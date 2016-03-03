class EpubController < ApplicationController
  def index
# 		filepath = Rails.root.join('tmp', '20100524_ebook.mobi')
#     stat = File::stat(filepath)
# 		send_file(filepath, :filename => 'test.mobi', :length => stat.size)
  end

  def form
  end

  def upload
		# TODO apply strong parameter
		upload_file = params[:epub][:file]
		file_name = "#{upload_file.original_filename}"
		logger.debug("upload_file: #{upload_file}")
		file_path = Rails.root.join('tmp', file_name)
		File.open(file_path, "wb") do |f|
			f.write(upload_file.read)
		end
		system("../KindleGen/kindlegen #{file_path}")
		mobi_file_name = file_name.gsub(/epub$/, "mobi")
# 		KindleMailer.send_email(mobi_file_name).deliver_now()
		stat = File::stat(file_path)
		send_file(Rails.root.join('tmp', mobi_file_name), :filename => mobi_file_name, :length => stat.size)
#     if upload_file != nil

# 			uploader = EpubUploader.new
# 			uploader.store!(upload_file)
# 			filepath = Rails.root.join('tmp', '20100524_ebook.mobi')
# 			stat = File::stat(filepath)
# 			send_file(filepath, :filename => 'test.mobi', :length => stat.size)
#     end
# 		redirect_to action: "index"
  end
end
