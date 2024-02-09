Return-Path: <linux-kernel+bounces-59345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D623384F5A7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EDB1F22E41
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04A7381A2;
	Fri,  9 Feb 2024 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDE+rA/C"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8656529CF8;
	Fri,  9 Feb 2024 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484574; cv=none; b=jI60KItYk3zM/rGLsqc25SrhbUkcXiPfUX443gRmlhvnGnMnbtb+V4lzNz/CX0eaIFT6biwoTzkmXhFBRHr/y/uLDilqIU0Z0RM0RxraU7FUZP3lkvDpysdWm9fSaOkwdr+9jicHD3JSjBFOeKE2bu4cnQDw0um/GlQywemLVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484574; c=relaxed/simple;
	bh=kEOW6Ro1dUaEB7NjwI9r+6JbRCQpGLp6wJfykrsNJak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cRmJhCDTx8GSQeaLzlk4F3awfluh+YfX6lLOquYRlz2L66apI8lq5xu89IepmyPkypTxsmhQzD/X4EWOXZSXN3qB85QpZ34PFduvRA1HcauTbzVFvjOsGLXP+FSAqY70/HrN8sJiOIPs4uR9fCiK2w0njHN3eb+te7OlE5mtd18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDE+rA/C; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d51ba18e1bso8963905ad.0;
        Fri, 09 Feb 2024 05:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707484572; x=1708089372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XKfVxq5s1e2ISbkZ5F17DY5TtUz/n+URrbxrOrInYCY=;
        b=TDE+rA/CIUHMRe6IPN9BHAtZy08IWcxObQTNEOObo5pwAsHLXMHQW3/oEwzyh37N/P
         SpkAJp83BTARY8F2QTru+z8B8v8YUNkGxD14FOXEvYUjF1SOc/bgEqAB5Hh/bOCRd8zd
         ZhpYwDpprFWw6WFCFxGrIZ/sLXfFIYxSPE+H3vdE9jmAe/EjwTix/KjBLOpaEgKXGCIM
         YkP05Q8xgC8Ej141E0KXND60zFgT0o5ft/On+KDpU0VMvvsAe48Z0lqhZsvDI4TvOeA1
         BSIKQDlakL0ajfcUDiNBfYDBIdxAAn4GAg6eCJ+9sYdqIYhKoXEhi5RClR/SPZgoNgEN
         yINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484572; x=1708089372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKfVxq5s1e2ISbkZ5F17DY5TtUz/n+URrbxrOrInYCY=;
        b=YSLXRrRNTPhqrdukwi3a7L6K1+utSXSLBVjUdLT4m/IjaMaPud4X4w8M6QAH48buPy
         iENWGEF3+QvijheMNLgwCcmAL1qLqPv3zAKEO6cFaRvOwcZq4CxofA6YJu8gzwkNqIbZ
         FpyKGZxJDukQ4kCq+iuS/trydgxGZyO0AbWJ+xFSF84gf0oIQUyZfvXVNhe9oOVLQEPG
         x4Z26pAd8CUF89MMaYNCA+X27lJ9AqyUSQukYXLIcv5BbfxL1XMFAI9d30hRv4+VRu5A
         A4gJ8v7g+X8soHBTQUPaYtdTRQgC5u0YkKg7yeONIr6hrkw/SQEXe8J0sLcXs//DXg4y
         I1Vg==
X-Gm-Message-State: AOJu0Yz1ryDk7xee8KUde2CnHDK0DL93XrHlKjoqnCLbbiHnYSokf+oy
	qSPDS3RdPujM7haQR/G+eTmXHeBzcbAWz3xT+x1I+1lmM4FkskZEcnGvioJg9y0=
X-Google-Smtp-Source: AGHT+IHaaqh7V9zPP+RRLUmIG7cWfmh8KmAyvuseL/ii0IlCWo68UeHBZ5gpBCMtyoA7EmlNz9m+FQ==
X-Received: by 2002:a17:902:d512:b0:1d4:cd4d:923b with SMTP id b18-20020a170902d51200b001d4cd4d923bmr1531154plg.54.1707484571675;
        Fri, 09 Feb 2024 05:16:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOarCWTYeKNHl4lSbPfL9Z3nEMu3SkPbMqzpP/P8doPEQX8T37Rn0JxmVA3hmpDacprRhnD6SI3mffUgOagQ+U48P5z6dX3i2kXD+T9/rXX5Dr75b0uV9GY7fvFrL6VI+uNyWI6qoYyGhuHfu2t5KjClLrI42gscVZhGsRlScXB7t63rsOoNcxaQTwHKraMSbbSBGVa+wcGIPzE1ANlPb/INdIfkJ+lfnRO4bzP8VvRxclteZzaNySxUsRSgMsaX1Udz6kfsV+b+/S7JpvWc+3eXDIjNRd3A3hQfVcrt49EG4R/Uq0R4f7q81qgOKZaXithFMCFqHLZg3C8pbi3m/rEMgApjuKaqxGXl/mTw==
Received: from met-Virtual-Machine.. ([131.107.1.159])
        by smtp.gmail.com with ESMTPSA id sk12-20020a17090b2dcc00b00296540086a5sm1713246pjb.23.2024.02.09.05.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 05:16:11 -0800 (PST)
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
Subject: [PATCH 1/3] smb: client: do not defer close open handles to deleted files
Date: Fri,  9 Feb 2024 08:15:50 -0500
Message-Id: <20240209131552.471765-1-meetakshisetiyaoss@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Meetakshi Setiya <msetiya@microsoft.com>

When a file/dentry has been deleted before closing all its open handles,
currently, closing them can add them to the deferred close list. This can
lead to problems in creating file with the same name when the file is
re-created before the deferred close completes. This issue was seen while
reusing a client's already existing lease on a file for compound operations
and xfstest 591 failed because of the deferred close handle that remained
valid even after the file was deleted and was being reused to create a file
with the same name. The server in this case returns an error on open with
STATUS_DELETE_PENDING. Recreating the file would fail till the deferred
handles are closed (duration specified in closetimeo).

This patch fixes the issue by flagging all open handles for the deleted
file (file path to be precise) with FILE_DELETED at the end of the unlink
operation. A new field cflags has been introduced in the cifsFileInfo
structure to set the FILE_DELETED flag without interfering with the f_flags
field. This cflags field could be useful in the future for setting more
flags specific to cfile.
When doing close in cifs_close for each of these handles, check the
FILE_DELETED flag and do not defer close these handles if the corresponding
filepath has been deleted.

Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
---
 fs/smb/client/cifsglob.h  |  3 +++
 fs/smb/client/cifsproto.h |  4 ++++
 fs/smb/client/file.c      |  3 ++-
 fs/smb/client/inode.c     |  2 ++
 fs/smb/client/misc.c      | 22 ++++++++++++++++++++++
 5 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 16befff4cbb4..f6b4acdcdeb3 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1398,6 +1398,8 @@ struct cifs_fid_locks {
 	struct list_head locks;		/* locks held by fid above */
 };
 
+#define FILE_DELETED 00000001
+
 struct cifsFileInfo {
 	/* following two lists are protected by tcon->open_file_lock */
 	struct list_head tlist;	/* pointer to next fid owned by tcon */
@@ -1413,6 +1415,7 @@ struct cifsFileInfo {
 	struct dentry *dentry;
 	struct tcon_link *tlink;
 	unsigned int f_flags;
+	unsigned int cflags;	/* flags for this file */
 	bool invalidHandle:1;	/* file closed via session abend */
 	bool swapfile:1;
 	bool oplock_break_cancelled:1;
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index a841bf4967fa..f995b766b177 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -296,6 +296,10 @@ extern void cifs_close_all_deferred_files(struct cifs_tcon *cifs_tcon);
 
 extern void cifs_close_deferred_file_under_dentry(struct cifs_tcon *cifs_tcon,
 				const char *path);
+
+extern void cifs_mark_open_handles_for_deleted_file(struct cifs_tcon
+				*cifs_tcon, const char *path);
+
 extern struct TCP_Server_Info *
 cifs_get_tcp_session(struct smb3_fs_context *ctx,
 		     struct TCP_Server_Info *primary_server);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index b75282c204da..91cf4d2df4de 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -483,6 +483,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 	cfile->uid = current_fsuid();
 	cfile->dentry = dget(dentry);
 	cfile->f_flags = file->f_flags;
+	cfile->cflags = 0;
 	cfile->invalidHandle = false;
 	cfile->deferred_close_scheduled = false;
 	cfile->tlink = cifs_get_tlink(tlink);
@@ -1085,7 +1086,7 @@ int cifs_close(struct inode *inode, struct file *file)
 		if ((cifs_sb->ctx->closetimeo && cinode->oplock == CIFS_CACHE_RHW_FLG)
 		    && cinode->lease_granted &&
 		    !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
-		    dclose) {
+		    dclose && !(cfile->cflags & FILE_DELETED)) {
 			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
 				inode_set_mtime_to_ts(inode,
 						      inode_set_ctime_current(inode));
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index d02f8ba29cb5..8121b5b1aa22 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1900,6 +1900,8 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 	cifs_inode = CIFS_I(dir);
 	CIFS_I(dir)->time = 0;	/* force revalidate of dir as well */
 unlink_out:
+	if (rc == 0)
+		cifs_mark_open_handles_for_deleted_file(tcon, full_path);
 	free_dentry_path(page);
 	kfree(attrs);
 	free_xid(xid);
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 0748d7b757b9..8e46dee1a36c 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -853,6 +853,28 @@ cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon, const char *path)
 	free_dentry_path(page);
 }
 
+/*
+ * If a dentry has been deleted, all corresponding open handles should know that
+ * so that we do not defer close them.
+ */
+void cifs_mark_open_handles_for_deleted_file(struct cifs_tcon *tcon,
+					     const char *path)
+{
+	struct cifsFileInfo *cfile;
+	void *page;
+	const char *full_path;
+
+	page = alloc_dentry_path();
+	spin_lock(&tcon->open_file_lock);
+	list_for_each_entry(cfile, &tcon->openFileList, tlist) {
+		full_path = build_path_from_dentry(cfile->dentry, page);
+		if (strcmp(full_path, path) == 0)
+			cfile->cflags |= FILE_DELETED;
+	}
+	spin_unlock(&tcon->open_file_lock);
+	free_dentry_path(page);
+}
+
 /* parses DFS referral V3 structure
  * caller is responsible for freeing target_nodes
  * returns:
-- 
2.39.2


