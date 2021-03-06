<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
  <head>
  
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<style>
	.wrapper {
		width: 800px;
		margin: 30px auto;
	}
	
	#title {
		width: 100%
	}
	</style>
 	</head>
  <body>
	<jsp:include page="/WEB-INF/views/community/header.jsp"/>
	    <div class="site-section">
	      <div class="container">
	        
		<div class="wrapper">


			<form action="/community/writeProc">
			<select name="cu_category" id="category">
					<option value="2">정보공유</option>
					<option value="3">실종</option>
					<option value="4">보호</option>
					<option value="5">산책커뮤니티</option>
					<option value="6">내새꾸자랑</option>
				</select>
				<input type="text" id="title" class="title" name="cu_title" placeholder="멤버글쓰기">
				<hr>
				<textarea id="summernote" name="cu_contents" class="contents" style="height:500px;"></textarea>
				<input type="text" name="cu_thumb" id="thumb_file" style="display:none">
				<button type="submit" class="btn btn-primary btn text-white" id="submit">게시</button>
				
			</form>

			<script>
				$(function(){
					
					$('#summernote').summernote({
										toolbar : [ [ 'style', [ 'style' ] ],
												[ 'font', [ 'bold', 'underline', 'clear' ] ],
												[ 'fontname', [ 'fontname' ] ],
												[ 'color', [ 'color' ] ],
												[ 'para', [ 'ul', 'ol', 'paragraph' ] ],
												[ 'table', [ 'table' ] ],
												[ 'insert', [ 'link', 'picture' ] ],
												[ 'view', [ 'fullscreen', 'codeview', 'help' ] ], ],
										callbacks : {
											 onImageUpload: function(files, editor, welEditable) {
									               for (var i = files.length - 1; i >= 0; i--) {
									                  sendFile(files[i],this);
									               }
									            }
										},
										placeholder : '내용을 입력하세요',
										tabsize : 2,
										height : 500,
										disableResizeEditor : true
									});
					function sendFile(file,editor) {
						data = new FormData();
						data.append("uploadFile",file);
						$.ajax({
							data:data,
							type:"POST",
							url:"/community/fileUpload",
							cache:false,
							contentType:false,
							enctype:'multipart/form-data',
							dataType: "json",
							processData: false,
							success:function(data){
								$(editor).summernote('editor.insertImage',data.url);
							}
						});
					}
				
				$("#submit").on("click",function(){
					var title = $("#title").val();
					var contents = $(".note-editable").html();
					var file =  $(".note-editable").find('img').attr('src');
					$("#thumb_file").val(file);
					
					if(title.trim() == "") {
						alert("제목을 입력하세요");
						$("#title").focus();
						return false;
						
					} else if(contents.trim() == "<p><br></p>" || contents.trim() == ""){
						alert("내용을 입력하세요");
						return false;
						
					} else {
						return true;
					}
					
				})
			}) 
			</script>
		</div>
	      </div>
	    </div>

	<jsp:include page="/WEB-INF/views/community/footer.jsp"/>
	</body>
</html>