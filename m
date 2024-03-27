Return-Path: <linux-kernel+bounces-121123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2246988E3E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FDFBB2DE27
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089F6173D82;
	Wed, 27 Mar 2024 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQHG2mm/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4AB17335B;
	Wed, 27 Mar 2024 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542137; cv=none; b=RqUwFGIUl2bg/Wp66FqImWaJGp24KK6/ausB3FiJw+ys3XBK9JoDcNLTGtHUFxj/tf0zfnYoU5Y4tGIkk1keAu+jCE1qQ5xv2SOr5j7J+eyrsYz8B8pbxqlv7wxdS+OtqA1ilPDmMki9hKMXLjTKegC7e62hL5utjCk89HE5eMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542137; c=relaxed/simple;
	bh=dWn5KJSanH6XwMpKtm5F15CMhkVHoMD9VC8L31eWXBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgNLNhUQKlf+NHiw233f9dS+FBGgXZph+5XuAG0ZRhBlpEl4VXL5Q4/FZglFtLpaWsS4Y/rvofwoBzYoFVJda7vFLfrzKezy5ZLSB7AoITzlT7dY3MDIyRNC6+narrtImWG6b2c2HghoJktkVnPz2HT319IXT8uqdieRaM1iXNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQHG2mm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C50C433C7;
	Wed, 27 Mar 2024 12:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542137;
	bh=dWn5KJSanH6XwMpKtm5F15CMhkVHoMD9VC8L31eWXBk=;
	h=From:To:Cc:Subject:Date:From;
	b=VQHG2mm/lkMc8loxHFLsAYDmBxtMoLkTVuWdA/k91varT+B7I8DfyqgiFScJ5Y9gh
	 cKfE3PL0Me35fnZHhT+MkdigdeLyw+U+4Snmdm08PsgRPhd4TF2OhvCN5jewL9fh8G
	 c63M1wnSno8TO5VPyHDqtxcR0FI6pCD9T7H9C+F1iYjdsYRHUKUaAjulJ9s0tidKPa
	 ePoATN9WRIJnHmP/sIvUVj07Hq1a2iRrSaOiqKN22ia6DooBkxnhgzklfLeubCmUWZ
	 yZFRuHylx2zG0Z7can7t1pLbg6l8LiqM6VZq8CXcJWIRMSBB0BHllyvZVyOtODnIdT
	 FuzDAVm/4SZHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linkinjeon@kernel.org
Cc: Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ksmbd: fix potencial out-of-bounds when buffer offset is invalid" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:22:15 -0400
Message-ID: <20240327122216.2837562-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c6cd2e8d2d9aa7ee35b1fa6a668e32a22a9753da Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 19 Mar 2024 08:40:48 +0900
Subject: [PATCH] ksmbd: fix potencial out-of-bounds when buffer offset is
 invalid

I found potencial out-of-bounds when buffer offset fields of a few requests
is invalid. This patch set the minimum value of buffer offset field to
->Buffer offset to validate buffer length.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2misc.c | 23 +++++++++++++------
 fs/smb/server/smb2pdu.c  | 48 ++++++++++++++++++++++------------------
 2 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/fs/smb/server/smb2misc.c b/fs/smb/server/smb2misc.c
index 7c872ffb4b0a9..727cb49926ee5 100644
--- a/fs/smb/server/smb2misc.c
+++ b/fs/smb/server/smb2misc.c
@@ -101,7 +101,9 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		*len = le16_to_cpu(((struct smb2_sess_setup_req *)hdr)->SecurityBufferLength);
 		break;
 	case SMB2_TREE_CONNECT:
-		*off = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathOffset);
+		*off = max_t(unsigned short int,
+			     le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathOffset),
+			     offsetof(struct smb2_tree_connect_req, Buffer));
 		*len = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathLength);
 		break;
 	case SMB2_CREATE:
@@ -110,7 +112,6 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 			max_t(unsigned short int,
 			      le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset),
 			      offsetof(struct smb2_create_req, Buffer));
-
 		unsigned short int name_len =
 			le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
 
@@ -131,11 +132,15 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		break;
 	}
 	case SMB2_QUERY_INFO:
-		*off = le16_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferOffset);
+		*off = max_t(unsigned int,
+			     le16_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferOffset),
+			     offsetof(struct smb2_query_info_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferLength);
 		break;
 	case SMB2_SET_INFO:
-		*off = le16_to_cpu(((struct smb2_set_info_req *)hdr)->BufferOffset);
+		*off = max_t(unsigned int,
+			     le16_to_cpu(((struct smb2_set_info_req *)hdr)->BufferOffset),
+			     offsetof(struct smb2_set_info_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_set_info_req *)hdr)->BufferLength);
 		break;
 	case SMB2_READ:
@@ -145,7 +150,7 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 	case SMB2_WRITE:
 		if (((struct smb2_write_req *)hdr)->DataOffset ||
 		    ((struct smb2_write_req *)hdr)->Length) {
-			*off = max_t(unsigned int,
+			*off = max_t(unsigned short int,
 				     le16_to_cpu(((struct smb2_write_req *)hdr)->DataOffset),
 				     offsetof(struct smb2_write_req, Buffer));
 			*len = le32_to_cpu(((struct smb2_write_req *)hdr)->Length);
@@ -156,7 +161,9 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		*len = le16_to_cpu(((struct smb2_write_req *)hdr)->WriteChannelInfoLength);
 		break;
 	case SMB2_QUERY_DIRECTORY:
-		*off = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameOffset);
+		*off = max_t(unsigned short int,
+			     le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameOffset),
+			     offsetof(struct smb2_query_directory_req, Buffer));
 		*len = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameLength);
 		break;
 	case SMB2_LOCK:
@@ -171,7 +178,9 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		break;
 	}
 	case SMB2_IOCTL:
-		*off = le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputOffset);
+		*off = max_t(unsigned int,
+			     le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputOffset),
+			     offsetof(struct smb2_ioctl_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputCount);
 		break;
 	default:
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 1ef3859fed1b3..3f3408f086699 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1927,7 +1927,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 
 	WORK_BUFFERS(work, req, rsp);
 
-	treename = smb_strndup_from_utf16(req->Buffer,
+	treename = smb_strndup_from_utf16((char *)req + le16_to_cpu(req->PathOffset),
 					  le16_to_cpu(req->PathLength), true,
 					  conn->local_nls);
 	if (IS_ERR(treename)) {
@@ -2840,7 +2840,7 @@ int smb2_open(struct ksmbd_work *work)
 			goto err_out2;
 		}
 
-		name = smb2_get_name(req->Buffer,
+		name = smb2_get_name((char *)req + le16_to_cpu(req->NameOffset),
 				     le16_to_cpu(req->NameLength),
 				     work->conn->local_nls);
 		if (IS_ERR(name)) {
@@ -4305,7 +4305,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 	}
 
 	srch_flag = req->Flags;
-	srch_ptr = smb_strndup_from_utf16(req->Buffer,
+	srch_ptr = smb_strndup_from_utf16((char *)req + le16_to_cpu(req->FileNameOffset),
 					  le16_to_cpu(req->FileNameLength), 1,
 					  conn->local_nls);
 	if (IS_ERR(srch_ptr)) {
@@ -4565,7 +4565,8 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    sizeof(struct smb2_ea_info_req))
 			return -EINVAL;
 
-		ea_req = (struct smb2_ea_info_req *)req->Buffer;
+		ea_req = (struct smb2_ea_info_req *)((char *)req +
+						     le16_to_cpu(req->InputBufferOffset));
 	} else {
 		/* need to send all EAs, if no specific EA is requested*/
 		if (le32_to_cpu(req->Flags) & SL_RETURN_SINGLE_ENTRY)
@@ -6211,6 +6212,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			      struct ksmbd_share_config *share)
 {
 	unsigned int buf_len = le32_to_cpu(req->BufferLength);
+	char *buffer = (char *)req + le16_to_cpu(req->BufferOffset);
 
 	switch (req->FileInfoClass) {
 	case FILE_BASIC_INFORMATION:
@@ -6218,7 +6220,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_file_basic_info))
 			return -EINVAL;
 
-		return set_file_basic_info(fp, (struct smb2_file_basic_info *)req->Buffer, share);
+		return set_file_basic_info(fp, (struct smb2_file_basic_info *)buffer, share);
 	}
 	case FILE_ALLOCATION_INFORMATION:
 	{
@@ -6226,7 +6228,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_file_allocation_info(work, fp,
-						(struct smb2_file_alloc_info *)req->Buffer);
+						(struct smb2_file_alloc_info *)buffer);
 	}
 	case FILE_END_OF_FILE_INFORMATION:
 	{
@@ -6234,7 +6236,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_end_of_file_info(work, fp,
-					    (struct smb2_file_eof_info *)req->Buffer);
+					    (struct smb2_file_eof_info *)buffer);
 	}
 	case FILE_RENAME_INFORMATION:
 	{
@@ -6242,7 +6244,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_rename_info(work, fp,
-				       (struct smb2_file_rename_info *)req->Buffer,
+				       (struct smb2_file_rename_info *)buffer,
 				       buf_len);
 	}
 	case FILE_LINK_INFORMATION:
@@ -6251,7 +6253,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return smb2_create_link(work, work->tcon->share_conf,
-					(struct smb2_file_link_info *)req->Buffer,
+					(struct smb2_file_link_info *)buffer,
 					buf_len, fp->filp,
 					work->conn->local_nls);
 	}
@@ -6261,7 +6263,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_file_disposition_info(fp,
-						 (struct smb2_file_disposition_info *)req->Buffer);
+						 (struct smb2_file_disposition_info *)buffer);
 	}
 	case FILE_FULL_EA_INFORMATION:
 	{
@@ -6274,7 +6276,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_ea_info))
 			return -EINVAL;
 
-		return smb2_set_ea((struct smb2_ea_info *)req->Buffer,
+		return smb2_set_ea((struct smb2_ea_info *)buffer,
 				   buf_len, &fp->filp->f_path, true);
 	}
 	case FILE_POSITION_INFORMATION:
@@ -6282,14 +6284,14 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_file_pos_info))
 			return -EINVAL;
 
-		return set_file_position_info(fp, (struct smb2_file_pos_info *)req->Buffer);
+		return set_file_position_info(fp, (struct smb2_file_pos_info *)buffer);
 	}
 	case FILE_MODE_INFORMATION:
 	{
 		if (buf_len < sizeof(struct smb2_file_mode_info))
 			return -EINVAL;
 
-		return set_file_mode_info(fp, (struct smb2_file_mode_info *)req->Buffer);
+		return set_file_mode_info(fp, (struct smb2_file_mode_info *)buffer);
 	}
 	}
 
@@ -6370,7 +6372,7 @@ int smb2_set_info(struct ksmbd_work *work)
 		}
 		rc = smb2_set_info_sec(fp,
 				       le32_to_cpu(req->AdditionalInformation),
-				       req->Buffer,
+				       (char *)req + le16_to_cpu(req->BufferOffset),
 				       le32_to_cpu(req->BufferLength));
 		ksmbd_revert_fsids(work);
 		break;
@@ -7816,7 +7818,7 @@ static int fsctl_pipe_transceive(struct ksmbd_work *work, u64 id,
 				 struct smb2_ioctl_rsp *rsp)
 {
 	struct ksmbd_rpc_command *rpc_resp;
-	char *data_buf = (char *)&req->Buffer[0];
+	char *data_buf = (char *)req + le32_to_cpu(req->InputOffset);
 	int nbytes = 0;
 
 	rpc_resp = ksmbd_rpc_ioctl(work->sess, id, data_buf,
@@ -7929,6 +7931,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 	u64 id = KSMBD_NO_FID;
 	struct ksmbd_conn *conn = work->conn;
 	int ret = 0;
+	char *buffer;
 
 	if (work->next_smb2_rcv_hdr_off) {
 		req = ksmbd_req_buf_next(work);
@@ -7951,6 +7954,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 		goto out;
 	}
 
+	buffer = (char *)req + le32_to_cpu(req->InputOffset);
+
 	cnt_code = le32_to_cpu(req->CtlCode);
 	ret = smb2_calc_max_out_buf_len(work, 48,
 					le32_to_cpu(req->MaxOutputResponse));
@@ -8008,7 +8013,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		ret = fsctl_validate_negotiate_info(conn,
-			(struct validate_negotiate_info_req *)&req->Buffer[0],
+			(struct validate_negotiate_info_req *)buffer,
 			(struct validate_negotiate_info_rsp *)&rsp->Buffer[0],
 			in_buf_len);
 		if (ret < 0)
@@ -8061,7 +8066,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		rsp->VolatileFileId = req->VolatileFileId;
 		rsp->PersistentFileId = req->PersistentFileId;
 		fsctl_copychunk(work,
-				(struct copychunk_ioctl_req *)&req->Buffer[0],
+				(struct copychunk_ioctl_req *)buffer,
 				le32_to_cpu(req->CtlCode),
 				le32_to_cpu(req->InputCount),
 				req->VolatileFileId,
@@ -8074,8 +8079,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		ret = fsctl_set_sparse(work, id,
-				       (struct file_sparse *)&req->Buffer[0]);
+		ret = fsctl_set_sparse(work, id, (struct file_sparse *)buffer);
 		if (ret < 0)
 			goto out;
 		break;
@@ -8098,7 +8102,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		zero_data =
-			(struct file_zero_data_information *)&req->Buffer[0];
+			(struct file_zero_data_information *)buffer;
 
 		off = le64_to_cpu(zero_data->FileOffset);
 		bfz = le64_to_cpu(zero_data->BeyondFinalZero);
@@ -8129,7 +8133,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		ret = fsctl_query_allocated_ranges(work, id,
-			(struct file_allocated_range_buffer *)&req->Buffer[0],
+			(struct file_allocated_range_buffer *)buffer,
 			(struct file_allocated_range_buffer *)&rsp->Buffer[0],
 			out_buf_len /
 			sizeof(struct file_allocated_range_buffer), &nbytes);
@@ -8173,7 +8177,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		dup_ext = (struct duplicate_extents_to_file *)&req->Buffer[0];
+		dup_ext = (struct duplicate_extents_to_file *)buffer;
 
 		fp_in = ksmbd_lookup_fd_slow(work, dup_ext->VolatileFileHandle,
 					     dup_ext->PersistentFileHandle);
-- 
2.43.0





