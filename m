Return-Path: <linux-kernel+bounces-93292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D963872D99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3458E1F23012
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48581759E;
	Wed,  6 Mar 2024 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chqqPXER"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB814AB2;
	Wed,  6 Mar 2024 03:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696644; cv=none; b=K7CKBxFKrCBUhp+IFVgMdQZVv5DGD83XZL24EfRIa3nU85YPGYO7s3SBNZn9pBYoSBvEmBN7biIgKselCr3mdQ8a/P9hDl7WjOTTqx79h9PQc2uLDX67QMqaYu8cqHXcLf/C8QCLTLI2Rhrjibp6Je3Ofsw+3xcEomZV65lGIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696644; c=relaxed/simple;
	bh=r6rn3rDdf+TNYJsnbW86PV4rErqk5qquWoWPIqhEmbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWrVO1kVkCalZlpotYKZvJnAx6kLQiXZjOeq6QdNX/xMtDE/Jm4spFv8DL3TT9spJ/2TKcaET5ITL+sSmqqvcV3LmVsJMM4uqDtZ4pcH3+4vbSpVqjazWD+ZoLHUq4XhHUiiKKEb09hshdzyU4/fgrniIXI4EDXEBk9TJWjUZbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chqqPXER; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59fb0b5b47eso219951eaf.3;
        Tue, 05 Mar 2024 19:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709696642; x=1710301442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IrVmSfa1fxZtNJO3Co2iIfu8tPAcVFJOCNWkXReefY=;
        b=chqqPXERKH6C+55BUGx4N5UILLRxqkoEYKo69Kd3Gs5JXatdgwOkXfPuYtMd78Vkbs
         Url0JEDYHz893bTSgmW1fydc+XcLdsRgtmUM8QkSvLt3j6U81iVl/VpGyE8UgKrqTmLt
         2ypEcDr7rLoMr/bKdGL0Kpyn1lCgOoGmE3l85FZFJxXO3Z2IzZMqyr93G7BIKDOMqjbt
         s8xos3cyroZuy1zKsrXe+V1tXT0m8ZNdXQx3cc8B+ntMPeQPwbKpyawcEX5+QQIeAKt0
         Z/tPoNkDWRPOTre8CCI4/qldAfgEKWZbq/29qjlY7vHHs7SsMYp1m3rRED7itw+IgCld
         VxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709696642; x=1710301442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IrVmSfa1fxZtNJO3Co2iIfu8tPAcVFJOCNWkXReefY=;
        b=opmt7dXJCX5dib4EoMSf4bIN5WemgT4IA6yOdVz2dKeAH/Sy6mdRbMp7hdr1JU9hy7
         8P8rtAGfCgGSe+EV1JljJRZbXGp0vSrqqDFui3OQFvRwSuCZ//JORu6qYQfz5PIfUoc+
         g3vTyIfkhQgptaJWiJTeC50M5Tjc/6npYypkA/rVWOPNCtMPdOBjVITBlFeBhHm1638Z
         PyqTl9/UUgBPxylGtATqfBX8ENj4jZPbol/55jqdsf/9lgOQPUyguN3s3dJCsDM1THTQ
         mDdVwjR17ZebAo0Acjjyuw2rOQyc4C9jlnD/bG9jZKDeIlgFCLNU36UwcP1TrGVzpvm2
         hl5w==
X-Forwarded-Encrypted: i=1; AJvYcCUVZq7aVaIynoqFdc8EvmKKjxsfYQrZ3cro29Cmv3pzctFytUfoD5ZI1HM13nng6VnfOYpT0vyb+/RT93rTIw/O7C2pI/GJlEu31PDwQVkS1zuvszQKVZzcHVvCAjr8wdmUS1F/jwmY8A==
X-Gm-Message-State: AOJu0YzLc2afGjp7ikvSL3uDGRrLDkHB8DGKUncrvyElGEsBvm0CKxVf
	tg/zfYELKwwyVDG57cByKL29QBwgEFIrZLQTpYfZo0pv56kykT4+
X-Google-Smtp-Source: AGHT+IGWW2iuKnXDx0P2RTTWYXUhklOegA9YzBx297q4hdTh3tsOV2TC3PdhcHjqXm0JXCw3CeI4Mg==
X-Received: by 2002:a05:6358:6f8a:b0:17c:1db2:4ba4 with SMTP id s10-20020a0563586f8a00b0017c1db24ba4mr4533736rwn.4.1709696641953;
        Tue, 05 Mar 2024 19:44:01 -0800 (PST)
Received: from met-Virtual-Machine.. ([131.107.159.31])
        by smtp.gmail.com with ESMTPSA id j5-20020a654305000000b005db034d1514sm8639808pgq.82.2024.03.05.19.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 19:44:01 -0800 (PST)
From: meetakshisetiyaoss@gmail.com
To: sfrench@samba.org,
	pc@manguebit.com,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	nspmangalore@gmail.com,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	samba-technical@lists.samba.org,
	bharathsm.hsk@gmail.com
Cc: Meetakshi Setiya <msetiya@microsoft.com>
Subject: [PATCH 2/3] smb: client: do not defer close open handles to deleted files
Date: Tue,  5 Mar 2024 22:43:52 -0500
Message-Id: <20240306034353.190039-2-meetakshisetiyaoss@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306034353.190039-1-meetakshisetiyaoss@gmail.com>
References: <20240306034353.190039-1-meetakshisetiyaoss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Meetakshi Setiya <msetiya@microsoft.com>

When a file/dentry has been deleted before closing all its open
handles, currently, closing them can add them to the deferred
close list. This can lead to problems in creating file with the
same name when the file is re-created before the deferred close
completes. This issue was seen while reusing a client's already
existing lease on a file for compound operations and xfstest 591
failed because of the deferred close handle that remained valid
even after the file was deleted and was being reused to create a
file with the same name. The server in this case returns an error
on open with STATUS_DELETE_PENDING. Recreating the file would
fail till the deferred handles are closed (duration specified in
closetimeo).

This patch fixes the issue by flagging all open handles for the
deleted file (file path to be precise) by setting
status_file_deleted to true in the cifsFileInfo structure. As per
the information classes specified in MS-FSCC, SMB2 query info
response from the server has a DeletePending field, set to true
to indicate that deletion has been requested on that file. If
this is the case, flag the open handles for this file too.

When doing close in cifs_close for each of these handles, check the
value of this boolean field and do not defer close these handles
if the corresponding filepath has been deleted.

Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
---
 fs/smb/client/cifsglob.h  |  1 +
 fs/smb/client/cifsproto.h |  4 ++++
 fs/smb/client/file.c      |  3 ++-
 fs/smb/client/inode.c     | 28 +++++++++++++++++++++++++---
 fs/smb/client/misc.c      | 34 ++++++++++++++++++++++++++++++++++
 fs/smb/client/smb2inode.c |  9 ++++++++-
 6 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 50f7e47c2229..a88c8328b29c 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1417,6 +1417,7 @@ struct cifsFileInfo {
 	bool invalidHandle:1;	/* file closed via session abend */
 	bool swapfile:1;
 	bool oplock_break_cancelled:1;
+	bool status_file_deleted:1; /* file has been deleted */
 	unsigned int oplock_epoch; /* epoch from the lease break */
 	__u32 oplock_level; /* oplock/lease level from the lease break */
 	int count;
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index ef98c840791f..1f46e0db6e92 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -296,6 +296,10 @@ extern void cifs_close_all_deferred_files(struct cifs_tcon *cifs_tcon);
 
 extern void cifs_close_deferred_file_under_dentry(struct cifs_tcon *cifs_tcon,
 				const char *path);
+
+extern void cifs_mark_open_handles_for_deleted_file(struct inode *inode,
+				const char *path);
+
 extern struct TCP_Server_Info *
 cifs_get_tcp_session(struct smb3_fs_context *ctx,
 		     struct TCP_Server_Info *primary_server);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index b75282c204da..46951f403d31 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -483,6 +483,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 	cfile->uid = current_fsuid();
 	cfile->dentry = dget(dentry);
 	cfile->f_flags = file->f_flags;
+	cfile->status_file_deleted = false;
 	cfile->invalidHandle = false;
 	cfile->deferred_close_scheduled = false;
 	cfile->tlink = cifs_get_tlink(tlink);
@@ -1085,7 +1086,7 @@ int cifs_close(struct inode *inode, struct file *file)
 		if ((cifs_sb->ctx->closetimeo && cinode->oplock == CIFS_CACHE_RHW_FLG)
 		    && cinode->lease_granted &&
 		    !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
-		    dclose) {
+		    dclose && !(cfile->status_file_deleted)) {
 			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
 				inode_set_mtime_to_ts(inode,
 						      inode_set_ctime_current(inode));
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 3073eac989ea..3242e3b74386 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -893,6 +893,9 @@ cifs_get_file_info(struct file *filp)
 	struct cifsFileInfo *cfile = filp->private_data;
 	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
 	struct TCP_Server_Info *server = tcon->ses->server;
+	struct dentry *dentry = filp->f_path.dentry;
+	void *page = alloc_dentry_path();
+	const unsigned char *path;
 
 	if (!server->ops->query_file_info)
 		return -ENOSYS;
@@ -907,7 +910,14 @@ cifs_get_file_info(struct file *filp)
 			data.symlink = true;
 			data.reparse.tag = IO_REPARSE_TAG_SYMLINK;
 		}
+		path = build_path_from_dentry(dentry, page);
+		if (IS_ERR(path)) {
+			free_dentry_path(page);
+			return PTR_ERR(path);
+		}
 		cifs_open_info_to_fattr(&fattr, &data, inode->i_sb);
+		if (fattr.cf_flags & CIFS_FATTR_DELETE_PENDING)
+			cifs_mark_open_handles_for_deleted_file(inode, path);
 		break;
 	case -EREMOTE:
 		cifs_create_junction_fattr(&fattr, inode->i_sb);
@@ -937,6 +947,7 @@ cifs_get_file_info(struct file *filp)
 	rc = cifs_fattr_to_inode(inode, &fattr);
 cgfi_exit:
 	cifs_free_open_info(&data);
+	free_dentry_path(page);
 	free_xid(xid);
 	return rc;
 }
@@ -1075,6 +1086,7 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 	struct kvec rsp_iov, *iov = NULL;
 	int rsp_buftype = CIFS_NO_BUFFER;
 	u32 tag = data->reparse.tag;
+	struct inode *inode = NULL;
 	int rc = 0;
 
 	if (!tag && server->ops->query_reparse_point) {
@@ -1114,8 +1126,12 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 
 	if (tcon->posix_extensions)
 		smb311_posix_info_to_fattr(fattr, data, sb);
-	else
+	else {
 		cifs_open_info_to_fattr(fattr, data, sb);
+		inode = cifs_iget(sb, fattr);
+		if (inode && fattr->cf_flags & CIFS_FATTR_DELETE_PENDING)
+			cifs_mark_open_handles_for_deleted_file(inode, full_path);
+	}
 out:
 	fattr->cf_cifstag = data->reparse.tag;
 	free_rsp_buf(rsp_buftype, rsp_iov.iov_base);
@@ -1170,6 +1186,8 @@ static int cifs_get_fattr(struct cifs_open_info_data *data,
 						   full_path, fattr);
 		} else {
 			cifs_open_info_to_fattr(fattr, data, sb);
+			if (fattr->cf_flags & CIFS_FATTR_DELETE_PENDING)
+				cifs_mark_open_handles_for_deleted_file(*inode, full_path);
 		}
 		break;
 	case -EREMOTE:
@@ -1850,16 +1868,20 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 
 psx_del_no_retry:
 	if (!rc) {
-		if (inode)
+		if (inode) {
+			cifs_mark_open_handles_for_deleted_file(inode, full_path);
 			cifs_drop_nlink(inode);
+		}
 	} else if (rc == -ENOENT) {
 		d_drop(dentry);
 	} else if (rc == -EBUSY) {
 		if (server->ops->rename_pending_delete) {
 			rc = server->ops->rename_pending_delete(full_path,
 								dentry, xid);
-			if (rc == 0)
+			if (rc == 0) {
+				cifs_mark_open_handles_for_deleted_file(inode, full_path);
 				cifs_drop_nlink(inode);
+			}
 		}
 	} else if ((rc == -EACCES) && (dosattr == 0) && inode) {
 		attrs = kzalloc(sizeof(*attrs), GFP_KERNEL);
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 0748d7b757b9..9428a0db7718 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -853,6 +853,40 @@ cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon, const char *path)
 	free_dentry_path(page);
 }
 
+/*
+ * If a dentry has been deleted, all corresponding open handles should know that
+ * so that we do not defer close them.
+ */
+void cifs_mark_open_handles_for_deleted_file(struct inode *inode,
+					     const char *path)
+{
+	struct cifsFileInfo *cfile;
+	void *page;
+	const char *full_path;
+	struct cifsInodeInfo *cinode = CIFS_I(inode);
+
+	page = alloc_dentry_path();
+	spin_lock(&cinode->open_file_lock);
+
+	/*
+	 * note: we need to construct path from dentry and compare only if the
+	 * inode has any hardlinks. When number of hardlinks is 1, we can just
+	 * mark all open handles since they are going to be from the same file.
+	 */
+	if (inode->i_nlink > 1) {
+		list_for_each_entry(cfile, &cinode->openFileList, flist) {
+			full_path = build_path_from_dentry(cfile->dentry, page);
+			if (!IS_ERR(full_path) && strcmp(full_path, path) == 0)
+				cfile->status_file_deleted = true;
+		}
+	} else {
+		list_for_each_entry(cfile, &cinode->openFileList, flist)
+			cfile->status_file_deleted = true;
+	}
+	spin_unlock(&cinode->open_file_lock);
+	free_dentry_path(page);
+}
+
 /* parses DFS referral V3 structure
  * caller is responsible for freeing target_nodes
  * returns:
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 69f3442c5b96..429d83d31280 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -561,8 +561,15 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		case SMB2_OP_DELETE:
 			if (rc)
 				trace_smb3_delete_err(xid,  ses->Suid, tcon->tid, rc);
-			else
+			else {
+				/*
+				 * If dentry (hence, inode) is NULL, lease break is going to
+				 * take care of degrading leases on handles for deleted files.
+				 */
+				if (inode)
+					cifs_mark_open_handles_for_deleted_file(inode, full_path);
 				trace_smb3_delete_done(xid, ses->Suid, tcon->tid);
+			}
 			break;
 		case SMB2_OP_MKDIR:
 			if (rc)
-- 
2.39.2


