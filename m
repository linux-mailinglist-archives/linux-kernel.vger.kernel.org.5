Return-Path: <linux-kernel+bounces-120917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB98188E080
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30BC2B2813C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD57149DF0;
	Wed, 27 Mar 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw1ETrQ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C90E149DE0;
	Wed, 27 Mar 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541579; cv=none; b=fXWCgdn2SsQFe5pvRWyrg3I3Tlse6JhlqBbSt9zej7B9x8sUVwYtVkLxsIhlRSfZE+6u5vBLH2qRNqghdB+AwXApXuG1s0mljK1uuJkFRc8V+P+kVe6RQObH0s+tOdusQz59K9zAai06xw7Ip7u2i3il2wCZmBuUa+1ld8Fyw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541579; c=relaxed/simple;
	bh=Urm6oLiMCLzWTymTPmbHWg9DspiVpo08bJZvITciOYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ts+xojpIlqaI2EJrRbp173T7tmPcGmRk3qNMPHkEnaed3ablQ72cpeEJzMUE/p4JVUe8riwdbBN8YFviYrrbikng6I4QxFN9EnMIwGQBBhE4Q9gitZ6ozUjhbblEztpF5MCdedTtgnvFytf+ZqYbb1LWd3Y4DL2oYKOBYxCTX5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw1ETrQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7617DC433F1;
	Wed, 27 Mar 2024 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541579;
	bh=Urm6oLiMCLzWTymTPmbHWg9DspiVpo08bJZvITciOYk=;
	h=From:To:Cc:Subject:Date:From;
	b=Pw1ETrQ2ws/360+ahyvpzzik7C+QWrLQ+jUugcy3u7LDOYHo9Z1wQmALTz6xS0m8G
	 5TLISXpKUV5jNZfBtmGsdSuWN9N+b3giyBOplTlLEcsqSzx0nW8yupiTnkHRTLsgq3
	 uu8YqyFWZbbxTHLHiup1JiFkmBVBx8g322otKAitj1HRg6svEY36CGsGSneBYZN+K0
	 bFUcDfm19d38uDj9PijupNhNfNVd4+2jRUQublIOH8XE7YXN34tUU3NBGKTB70GTIB
	 nmgaxmKrDstWj963z/Y1ceMYYxxiyeSN1W49IZn7ttTXHPxiBfLCy10GFLLuNNtpEn
	 W/pvtHJSYly0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mmakassikis@freebox.fr
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "ksmbd: replace generic_fillattr with vfs_getattr" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:12:57 -0400
Message-ID: <20240327121257.2829938-1-sashal@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5614c8c487f6af627614dd2efca038e4afe0c6d7 Mon Sep 17 00:00:00 2001
From: Marios Makassikis <mmakassikis@freebox.fr>
Date: Thu, 22 Feb 2024 10:58:19 +0100
Subject: [PATCH] ksmbd: replace generic_fillattr with vfs_getattr

generic_fillattr should not be used outside of ->getattr
implementations.

Use vfs_getattr instead, and adapt functions to return an
error code to the caller.

Cc: stable@vger.kernel.org
Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c    | 170 ++++++++++++++++++++++++-------------
 fs/smb/server/smb_common.c |  11 ++-
 fs/smb/server/vfs.c        |  12 ++-
 3 files changed, 127 insertions(+), 66 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 0c97d3c860726..f6cc5d2730ffb 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3828,11 +3828,16 @@ static int process_query_dir_entries(struct smb2_query_dir_private *priv)
 		}
 
 		ksmbd_kstat.kstat = &kstat;
-		if (priv->info_level != FILE_NAMES_INFORMATION)
-			ksmbd_vfs_fill_dentry_attrs(priv->work,
-						    idmap,
-						    dent,
-						    &ksmbd_kstat);
+		if (priv->info_level != FILE_NAMES_INFORMATION) {
+			rc = ksmbd_vfs_fill_dentry_attrs(priv->work,
+							 idmap,
+							 dent,
+							 &ksmbd_kstat);
+			if (rc) {
+				dput(dent);
+				continue;
+			}
+		}
 
 		rc = smb2_populate_readdir_entry(priv->work->conn,
 						 priv->info_level,
@@ -4480,6 +4485,7 @@ static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
 	struct smb2_file_basic_info *basic_info;
 	struct kstat stat;
 	u64 time;
+	int ret;
 
 	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
 		pr_err("no right to read the attributes : 0x%x\n",
@@ -4487,9 +4493,12 @@ static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
 		return -EACCES;
 	}
 
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
+
 	basic_info = (struct smb2_file_basic_info *)rsp->Buffer;
-	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS,
-			 file_inode(fp->filp), &stat);
 	basic_info->CreationTime = cpu_to_le64(fp->create_time);
 	time = ksmbd_UnixTimeToNT(stat.atime);
 	basic_info->LastAccessTime = cpu_to_le64(time);
@@ -4504,27 +4513,31 @@ static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
 	return 0;
 }
 
-static void get_file_standard_info(struct smb2_query_info_rsp *rsp,
-				   struct ksmbd_file *fp, void *rsp_org)
+static int get_file_standard_info(struct smb2_query_info_rsp *rsp,
+				  struct ksmbd_file *fp, void *rsp_org)
 {
 	struct smb2_file_standard_info *sinfo;
 	unsigned int delete_pending;
-	struct inode *inode;
 	struct kstat stat;
+	int ret;
 
-	inode = file_inode(fp->filp);
-	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS, inode, &stat);
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
 
 	sinfo = (struct smb2_file_standard_info *)rsp->Buffer;
 	delete_pending = ksmbd_inode_pending_delete(fp);
 
-	sinfo->AllocationSize = cpu_to_le64(inode->i_blocks << 9);
+	sinfo->AllocationSize = cpu_to_le64(stat.blocks << 9);
 	sinfo->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
 	sinfo->NumberOfLinks = cpu_to_le32(get_nlink(&stat) - delete_pending);
 	sinfo->DeletePending = delete_pending;
 	sinfo->Directory = S_ISDIR(stat.mode) ? 1 : 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_standard_info));
+
+	return 0;
 }
 
 static void get_file_alignment_info(struct smb2_query_info_rsp *rsp,
@@ -4546,11 +4559,11 @@ static int get_file_all_info(struct ksmbd_work *work,
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_file_all_info *file_info;
 	unsigned int delete_pending;
-	struct inode *inode;
 	struct kstat stat;
 	int conv_len;
 	char *filename;
 	u64 time;
+	int ret;
 
 	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
 		ksmbd_debug(SMB, "no right to read the attributes : 0x%x\n",
@@ -4562,8 +4575,10 @@ static int get_file_all_info(struct ksmbd_work *work,
 	if (IS_ERR(filename))
 		return PTR_ERR(filename);
 
-	inode = file_inode(fp->filp);
-	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS, inode, &stat);
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
 
 	ksmbd_debug(SMB, "filename = %s\n", filename);
 	delete_pending = ksmbd_inode_pending_delete(fp);
@@ -4579,7 +4594,7 @@ static int get_file_all_info(struct ksmbd_work *work,
 	file_info->Attributes = fp->f_ci->m_fattr;
 	file_info->Pad1 = 0;
 	file_info->AllocationSize =
-		cpu_to_le64(inode->i_blocks << 9);
+		cpu_to_le64(stat.blocks << 9);
 	file_info->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
 	file_info->NumberOfLinks =
 			cpu_to_le32(get_nlink(&stat) - delete_pending);
@@ -4623,10 +4638,10 @@ static void get_file_alternate_info(struct ksmbd_work *work,
 		cpu_to_le32(sizeof(struct smb2_file_alt_name_info) + conv_len);
 }
 
-static void get_file_stream_info(struct ksmbd_work *work,
-				 struct smb2_query_info_rsp *rsp,
-				 struct ksmbd_file *fp,
-				 void *rsp_org)
+static int get_file_stream_info(struct ksmbd_work *work,
+				struct smb2_query_info_rsp *rsp,
+				struct ksmbd_file *fp,
+				void *rsp_org)
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_file_stream_info *file_info;
@@ -4637,9 +4652,13 @@ static void get_file_stream_info(struct ksmbd_work *work,
 	int nbytes = 0, streamlen, stream_name_len, next, idx = 0;
 	int buf_free_len;
 	struct smb2_query_info_req *req = ksmbd_req_buf_next(work);
+	int ret;
+
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
 
-	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS,
-			 file_inode(fp->filp), &stat);
 	file_info = (struct smb2_file_stream_info *)rsp->Buffer;
 
 	buf_free_len =
@@ -4720,29 +4739,37 @@ static void get_file_stream_info(struct ksmbd_work *work,
 	kvfree(xattr_list);
 
 	rsp->OutputBufferLength = cpu_to_le32(nbytes);
+
+	return 0;
 }
 
-static void get_file_internal_info(struct smb2_query_info_rsp *rsp,
-				   struct ksmbd_file *fp, void *rsp_org)
+static int get_file_internal_info(struct smb2_query_info_rsp *rsp,
+				  struct ksmbd_file *fp, void *rsp_org)
 {
 	struct smb2_file_internal_info *file_info;
 	struct kstat stat;
+	int ret;
+
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
 
-	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS,
-			 file_inode(fp->filp), &stat);
 	file_info = (struct smb2_file_internal_info *)rsp->Buffer;
 	file_info->IndexNumber = cpu_to_le64(stat.ino);
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_internal_info));
+
+	return 0;
 }
 
 static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
 				      struct ksmbd_file *fp, void *rsp_org)
 {
 	struct smb2_file_ntwrk_info *file_info;
-	struct inode *inode;
 	struct kstat stat;
 	u64 time;
+	int ret;
 
 	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
 		pr_err("no right to read the attributes : 0x%x\n",
@@ -4750,10 +4777,12 @@ static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
 		return -EACCES;
 	}
 
-	file_info = (struct smb2_file_ntwrk_info *)rsp->Buffer;
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
 
-	inode = file_inode(fp->filp);
-	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS, inode, &stat);
+	file_info = (struct smb2_file_ntwrk_info *)rsp->Buffer;
 
 	file_info->CreationTime = cpu_to_le64(fp->create_time);
 	time = ksmbd_UnixTimeToNT(stat.atime);
@@ -4763,8 +4792,7 @@ static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
 	time = ksmbd_UnixTimeToNT(stat.ctime);
 	file_info->ChangeTime = cpu_to_le64(time);
 	file_info->Attributes = fp->f_ci->m_fattr;
-	file_info->AllocationSize =
-		cpu_to_le64(inode->i_blocks << 9);
+	file_info->AllocationSize = cpu_to_le64(stat.blocks << 9);
 	file_info->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
 	file_info->Reserved = cpu_to_le32(0);
 	rsp->OutputBufferLength =
@@ -4804,14 +4832,17 @@ static void get_file_mode_info(struct smb2_query_info_rsp *rsp,
 		cpu_to_le32(sizeof(struct smb2_file_mode_info));
 }
 
-static void get_file_compression_info(struct smb2_query_info_rsp *rsp,
-				      struct ksmbd_file *fp, void *rsp_org)
+static int get_file_compression_info(struct smb2_query_info_rsp *rsp,
+				     struct ksmbd_file *fp, void *rsp_org)
 {
 	struct smb2_file_comp_info *file_info;
 	struct kstat stat;
+	int ret;
 
-	generic_fillattr(file_mnt_idmap(fp->filp), STATX_BASIC_STATS,
-			 file_inode(fp->filp), &stat);
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
 
 	file_info = (struct smb2_file_comp_info *)rsp->Buffer;
 	file_info->CompressedFileSize = cpu_to_le64(stat.blocks << 9);
@@ -4823,6 +4854,8 @@ static void get_file_compression_info(struct smb2_query_info_rsp *rsp,
 
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_comp_info));
+
+	return 0;
 }
 
 static int get_file_attribute_tag_info(struct smb2_query_info_rsp *rsp,
@@ -4844,7 +4877,7 @@ static int get_file_attribute_tag_info(struct smb2_query_info_rsp *rsp,
 	return 0;
 }
 
-static void find_file_posix_info(struct smb2_query_info_rsp *rsp,
+static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
 				struct ksmbd_file *fp, void *rsp_org)
 {
 	struct smb311_posix_qinfo *file_info;
@@ -4852,24 +4885,31 @@ static void find_file_posix_info(struct smb2_query_info_rsp *rsp,
 	struct mnt_idmap *idmap = file_mnt_idmap(fp->filp);
 	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
 	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
+	struct kstat stat;
 	u64 time;
 	int out_buf_len = sizeof(struct smb311_posix_qinfo) + 32;
+	int ret;
+
+	ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+			  AT_STATX_SYNC_AS_STAT);
+	if (ret)
+		return ret;
 
 	file_info = (struct smb311_posix_qinfo *)rsp->Buffer;
 	file_info->CreationTime = cpu_to_le64(fp->create_time);
-	time = ksmbd_UnixTimeToNT(inode_get_atime(inode));
+	time = ksmbd_UnixTimeToNT(stat.atime);
 	file_info->LastAccessTime = cpu_to_le64(time);
-	time = ksmbd_UnixTimeToNT(inode_get_mtime(inode));
+	time = ksmbd_UnixTimeToNT(stat.mtime);
 	file_info->LastWriteTime = cpu_to_le64(time);
-	time = ksmbd_UnixTimeToNT(inode_get_ctime(inode));
+	time = ksmbd_UnixTimeToNT(stat.ctime);
 	file_info->ChangeTime = cpu_to_le64(time);
 	file_info->DosAttributes = fp->f_ci->m_fattr;
-	file_info->Inode = cpu_to_le64(inode->i_ino);
-	file_info->EndOfFile = cpu_to_le64(inode->i_size);
-	file_info->AllocationSize = cpu_to_le64(inode->i_blocks << 9);
-	file_info->HardLinks = cpu_to_le32(inode->i_nlink);
-	file_info->Mode = cpu_to_le32(inode->i_mode & 0777);
-	file_info->DeviceId = cpu_to_le32(inode->i_rdev);
+	file_info->Inode = cpu_to_le64(stat.ino);
+	file_info->EndOfFile = cpu_to_le64(stat.size);
+	file_info->AllocationSize = cpu_to_le64(stat.blocks << 9);
+	file_info->HardLinks = cpu_to_le32(stat.nlink);
+	file_info->Mode = cpu_to_le32(stat.mode & 0777);
+	file_info->DeviceId = cpu_to_le32(stat.rdev);
 
 	/*
 	 * Sids(32) contain two sids(Domain sid(16), UNIX group sid(16)).
@@ -4882,6 +4922,8 @@ static void find_file_posix_info(struct smb2_query_info_rsp *rsp,
 		  SIDUNIX_GROUP, (struct smb_sid *)&file_info->Sids[16]);
 
 	rsp->OutputBufferLength = cpu_to_le32(out_buf_len);
+
+	return 0;
 }
 
 static int smb2_get_info_file(struct ksmbd_work *work,
@@ -4930,7 +4972,7 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 		break;
 
 	case FILE_STANDARD_INFORMATION:
-		get_file_standard_info(rsp, fp, work->response_buf);
+		rc = get_file_standard_info(rsp, fp, work->response_buf);
 		break;
 
 	case FILE_ALIGNMENT_INFORMATION:
@@ -4946,11 +4988,11 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 		break;
 
 	case FILE_STREAM_INFORMATION:
-		get_file_stream_info(work, rsp, fp, work->response_buf);
+		rc = get_file_stream_info(work, rsp, fp, work->response_buf);
 		break;
 
 	case FILE_INTERNAL_INFORMATION:
-		get_file_internal_info(rsp, fp, work->response_buf);
+		rc = get_file_internal_info(rsp, fp, work->response_buf);
 		break;
 
 	case FILE_NETWORK_OPEN_INFORMATION:
@@ -4974,7 +5016,7 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 		break;
 
 	case FILE_COMPRESSION_INFORMATION:
-		get_file_compression_info(rsp, fp, work->response_buf);
+		rc = get_file_compression_info(rsp, fp, work->response_buf);
 		break;
 
 	case FILE_ATTRIBUTE_TAG_INFORMATION:
@@ -4985,7 +5027,7 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
 			rc = -EOPNOTSUPP;
 		} else {
-			find_file_posix_info(rsp, fp, work->response_buf);
+			rc = find_file_posix_info(rsp, fp, work->response_buf);
 		}
 		break;
 	default:
@@ -5398,7 +5440,6 @@ int smb2_close(struct ksmbd_work *work)
 	struct smb2_close_rsp *rsp;
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_file *fp;
-	struct inode *inode;
 	u64 time;
 	int err = 0;
 
@@ -5453,24 +5494,33 @@ int smb2_close(struct ksmbd_work *work)
 	rsp->Reserved = 0;
 
 	if (req->Flags == SMB2_CLOSE_FLAG_POSTQUERY_ATTRIB) {
+		struct kstat stat;
+		int ret;
+
 		fp = ksmbd_lookup_fd_fast(work, volatile_id);
 		if (!fp) {
 			err = -ENOENT;
 			goto out;
 		}
 
-		inode = file_inode(fp->filp);
+		ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
+				  AT_STATX_SYNC_AS_STAT);
+		if (ret) {
+			ksmbd_fd_put(work, fp);
+			goto out;
+		}
+
 		rsp->Flags = SMB2_CLOSE_FLAG_POSTQUERY_ATTRIB;
-		rsp->AllocationSize = S_ISDIR(inode->i_mode) ? 0 :
-			cpu_to_le64(inode->i_blocks << 9);
-		rsp->EndOfFile = cpu_to_le64(inode->i_size);
+		rsp->AllocationSize = S_ISDIR(stat.mode) ? 0 :
+			cpu_to_le64(stat.blocks << 9);
+		rsp->EndOfFile = cpu_to_le64(stat.size);
 		rsp->Attributes = fp->f_ci->m_fattr;
 		rsp->CreationTime = cpu_to_le64(fp->create_time);
-		time = ksmbd_UnixTimeToNT(inode_get_atime(inode));
+		time = ksmbd_UnixTimeToNT(stat.atime);
 		rsp->LastAccessTime = cpu_to_le64(time);
-		time = ksmbd_UnixTimeToNT(inode_get_mtime(inode));
+		time = ksmbd_UnixTimeToNT(stat.mtime);
 		rsp->LastWriteTime = cpu_to_le64(time);
-		time = ksmbd_UnixTimeToNT(inode_get_ctime(inode));
+		time = ksmbd_UnixTimeToNT(stat.ctime);
 		rsp->ChangeTime = cpu_to_le64(time);
 		ksmbd_fd_put(work, fp);
 	} else {
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 7c98bf699772f..fcaf373cc0080 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -457,10 +457,13 @@ int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work, int info_level,
 			}
 
 			ksmbd_kstat.kstat = &kstat;
-			ksmbd_vfs_fill_dentry_attrs(work,
-						    idmap,
-						    dentry,
-						    &ksmbd_kstat);
+			rc = ksmbd_vfs_fill_dentry_attrs(work,
+							 idmap,
+							 dentry,
+							 &ksmbd_kstat);
+			if (rc)
+				break;
+
 			rc = fn(conn, info_level, d_info, &ksmbd_kstat);
 			if (rc)
 				break;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index a6961bfe3e139..2e992fadeaa7d 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1682,11 +1682,19 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 				struct dentry *dentry,
 				struct ksmbd_kstat *ksmbd_kstat)
 {
+	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
 	u64 time;
 	int rc;
+	struct path path = {
+		.mnt = share_conf->vfs_path.mnt,
+		.dentry = dentry,
+	};
 
-	generic_fillattr(idmap, STATX_BASIC_STATS, d_inode(dentry),
-			 ksmbd_kstat->kstat);
+	rc = vfs_getattr(&path, ksmbd_kstat->kstat,
+			 STATX_BASIC_STATS | STATX_BTIME,
+			 AT_STATX_SYNC_AS_STAT);
+	if (rc)
+		return rc;
 
 	time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->ctime);
 	ksmbd_kstat->create_time = time;
-- 
2.43.0





