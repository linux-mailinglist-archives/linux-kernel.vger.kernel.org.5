Return-Path: <linux-kernel+bounces-103216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40E987BC7D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420081F22D59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226246F086;
	Thu, 14 Mar 2024 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1JVPuio"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95DF6EB4A;
	Thu, 14 Mar 2024 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417955; cv=none; b=qOA2ogdWPIk+YHzkK9DIpEzpYDINNFGiDi9iAq72/P9T5rG/H8jtNlHws0iBv7hIZSd3luGaVIA8CljAL3UpUwWWDDAI9Y2Sck9PhVnNaBHgu8guqgUpuQE/RYIvAOH0TA37wI7S4Nb0j/1SV8AE/sFplhnPin2vQpXbnA6s4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417955; c=relaxed/simple;
	bh=0xTpEM3Y/NrqBhreNw+cRUSto1TJ34AiQcMObEgaOG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MpIHA6aBQn1TWGD065coIsXZE5X17jlTK+8j12ldDEAU7ATEx6/XzUUpk/C2UQ+ZD6+8knsjxT1IGJMnnMEkFfmocWzzOYcL7/fQ3RJIxCivd2demFJ1vvHHBrRKCSJqLpoZy83NRhytQVk1gHYZHKBlSf2zT+hrOkeAjA54TEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1JVPuio; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc5d0162bcso6405885ad.0;
        Thu, 14 Mar 2024 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710417953; x=1711022753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sxUqglOb19+8Ui9qYkGG1A5RE2kMc/HzRCXEs7LSq5w=;
        b=e1JVPuio8S1mti2VC4HH3prBfhrxlse6tuJDMTkBgAWQ2XRxvaV6kCuBIpiu4POQpw
         cQsZVsocs/0f3Rk4jQ+QOXVPq/+ZRGx8sK+0hkjUF7qttHLT5/ZmEgJ09WBq9KWGQQu8
         k5qI/K2U+LnpO0mtld0saxivgLYKyMPYFlQ3LuSdBqk/AOWzxwTuA1BG50ik2GsAOcRM
         9LTXa2jMuJT0ZqF645M3sRnbdK3PADiyeP2U5s/Jlg9B5lEmsa4KvRUfeGJKjJgqL+o8
         0BZPXiIcTXRh7BEL9PVqSMSj/2sNNpILfYwNCYODVQaygybETLX8lEcCPkafF94eaOuM
         4rKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710417953; x=1711022753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxUqglOb19+8Ui9qYkGG1A5RE2kMc/HzRCXEs7LSq5w=;
        b=URBKc4ARNGfuoK7KBPjbERdqkEuGqYZ1EQl+YsNMsbXCrJtrq/si/1DFGb0VSGfj1O
         mSGM9BH9M+7vT26tFSn8JrDfu7Nqr0952nIIenUj4LqOggM1hmZvLYvsouLOsCaTSgJW
         zewhMRcd8JghvumOmKACb89ZQTQC+pPSFOkn+zKK1AsSGy5qXdErG9mtu58ujF+OK2HZ
         JfRXeVw2d+WVXUX08eUzlImLuKAco3VG7Gs1BqYNYkKlEeEqag/9fRQCgrrPLVLYObcC
         EY/p0U1P7bxC29DRyrji3ws0XyR6wWtbvn/daJtjE6UFRPazqQGdTOgCWMELYUIi6beU
         URRA==
X-Forwarded-Encrypted: i=1; AJvYcCV0YyHSFT9iRI+YWpBExTle+PfwKTlxg7aLwlI2OUDjqGj9SiYTTJgusuA21xHYQVw4ow7x1HnqS3sB2+dTFlSC8rSubDE/hrEfQljtzfpC1kyB7vMNIqG7g7DLAvSsqTaoptC8McNlhQ==
X-Gm-Message-State: AOJu0Ywr3c9Knt+a6ggPqegw3Jwc+l5Do4yNeod6MMe6hVI37x9uxXz+
	J4Gxw5UG7omuAh8uXDcDNkUCROT2fiGsEFbvCkBwJYwmckWAdW/Y
X-Google-Smtp-Source: AGHT+IH4/NiBc9M2jC4uVkmALXn2nyHXeOSFAZoTwdWRjfOM3P4K+8IzetlR7j+BVbgB4FfZcrwKNw==
X-Received: by 2002:a17:903:230e:b0:1de:e4bd:73fc with SMTP id d14-20020a170903230e00b001dee4bd73fcmr268291plh.24.1710417953006;
        Thu, 14 Mar 2024 05:05:53 -0700 (PDT)
Received: from met-Virtual-Machine.. ([131.107.8.95])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902e88d00b001db594c9d17sm1497389plg.254.2024.03.14.05.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 05:05:52 -0700 (PDT)
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
Subject: [PATCH] Fixes: ffceb7640cbf ("smb: client: do not defer close open handles to deleted files")
Date: Thu, 14 Mar 2024 08:05:49 -0400
Message-Id: <20240314120549.627950-1-meetakshisetiyaoss@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Meetakshi Setiya <msetiya@microsoft.com>

Fix potential memory leaks, add error checking, remove unnecessary
initialisation of status_file_deleted and do not use cifs_iget() to get
inode in reparse_info_to_fattr since fattrs may not be fully set.

Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
---
 fs/smb/client/file.c  |  1 -
 fs/smb/client/inode.c | 24 +++++++++++++-----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index c3ed7017cdf2..f83b088b5bc9 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -486,7 +486,6 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 	cfile->uid = current_fsuid();
 	cfile->dentry = dget(dentry);
 	cfile->f_flags = file->f_flags;
-	cfile->status_file_deleted = false;
 	cfile->invalidHandle = false;
 	cfile->deferred_close_scheduled = false;
 	cfile->tlink = cifs_get_tlink(tlink);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 8177ec59afee..6092729bf7f6 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -820,8 +820,10 @@ cifs_get_file_info(struct file *filp)
 	void *page = alloc_dentry_path();
 	const unsigned char *path;
 
-	if (!server->ops->query_file_info)
+	if (!server->ops->query_file_info) {
+		free_dentry_path(page);
 		return -ENOSYS;
+	}
 
 	xid = get_xid();
 	rc = server->ops->query_file_info(xid, tcon, cfile, &data);
@@ -835,8 +837,8 @@ cifs_get_file_info(struct file *filp)
 		}
 		path = build_path_from_dentry(dentry, page);
 		if (IS_ERR(path)) {
-			free_dentry_path(page);
-			return PTR_ERR(path);
+			rc = PTR_ERR(path);
+			goto cgfi_exit;
 		}
 		cifs_open_info_to_fattr(&fattr, &data, inode->i_sb);
 		if (fattr.cf_flags & CIFS_FATTR_DELETE_PENDING)
@@ -1009,7 +1011,6 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 	struct kvec rsp_iov, *iov = NULL;
 	int rsp_buftype = CIFS_NO_BUFFER;
 	u32 tag = data->reparse.tag;
-	struct inode *inode = NULL;
 	int rc = 0;
 
 	if (!tag && server->ops->query_reparse_point) {
@@ -1049,12 +1050,8 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 
 	if (tcon->posix_extensions)
 		smb311_posix_info_to_fattr(fattr, data, sb);
-	else {
+	else
 		cifs_open_info_to_fattr(fattr, data, sb);
-		inode = cifs_iget(sb, fattr);
-		if (inode && fattr->cf_flags & CIFS_FATTR_DELETE_PENDING)
-			cifs_mark_open_handles_for_deleted_file(inode, full_path);
-	}
 out:
 	fattr->cf_cifstag = data->reparse.tag;
 	free_rsp_buf(rsp_buftype, rsp_iov.iov_base);
@@ -1109,9 +1106,9 @@ static int cifs_get_fattr(struct cifs_open_info_data *data,
 						   full_path, fattr);
 		} else {
 			cifs_open_info_to_fattr(fattr, data, sb);
-			if (fattr->cf_flags & CIFS_FATTR_DELETE_PENDING)
-				cifs_mark_open_handles_for_deleted_file(*inode, full_path);
 		}
+		if (!rc && fattr->cf_flags & CIFS_FATTR_DELETE_PENDING)
+			cifs_mark_open_handles_for_deleted_file(*inode, full_path);
 		break;
 	case -EREMOTE:
 		/* DFS link, no metadata available on this server */
@@ -1340,6 +1337,8 @@ int smb311_posix_get_inode_info(struct inode **inode,
 		goto out;
 
 	rc = update_inode_info(sb, &fattr, inode);
+	if (!rc && fattr.cf_flags & CIFS_FATTR_DELETE_PENDING)
+		cifs_mark_open_handles_for_deleted_file(*inode, full_path);
 out:
 	kfree(fattr.cf_symlink_target);
 	return rc;
@@ -1501,6 +1500,9 @@ struct inode *cifs_root_iget(struct super_block *sb)
 		goto out;
 	}
 
+	if (!rc && fattr.cf_flags & CIFS_FATTR_DELETE_PENDING)
+		cifs_mark_open_handles_for_deleted_file(inode, path);
+
 	if (rc && tcon->pipe) {
 		cifs_dbg(FYI, "ipc connection - fake read inode\n");
 		spin_lock(&inode->i_lock);
-- 
2.39.2


