Return-Path: <linux-kernel+bounces-1998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21DD8156D4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44C91C2489D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4A263B0;
	Sat, 16 Dec 2023 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yS+78uw3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E571FCB;
	Sat, 16 Dec 2023 03:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=H9AWDBao+ixPxKIxPD9Emyx97BYYwRxtEc/lm+btQTw=; b=yS+78uw3z9HwPDeTKkPUt+o2Ns
	splw76Qff1Ylvc1UGBTHUOGy9zJmvizQtp2COTnrk3reiWT18DU5opAPHxfv7phKUEE7gs0jaF5Km
	+bXxkI7/4YXvOL7sLXls8Nt+6KYr9cH33+o9Jfc+mlsMf24k/SZ/4fqXEeO97/dud3XmD2iZyg4hF
	lHQFk4zNXK0ub8ZEYBsxWOh0rfdPs50EVpGzCXle8cTu3rRY4r1qOPKBDkF3JtsSmR6wKqgQZAHbW
	QppjyC4joCadj8RbxQgC4EsLXn84pkJQJMI+JS8U++Z0cyAPxP6xGjDV6/qwGzT92WdiYcw0atoKI
	Zs+PfeVA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rELLb-005FSr-17;
	Sat, 16 Dec 2023 03:28:15 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org
Subject: [PATCH] ksmbd: vfs: fix all kernel-doc warnings
Date: Fri, 15 Dec 2023 19:28:14 -0800
Message-ID: <20231216032814.10560-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix all kernel-doc warnings in vfs.c:

vfs.c:54: warning: Function parameter or member 'parent' not described in 'ksmbd_vfs_lock_parent'
vfs.c:54: warning: Function parameter or member 'child' not described in 'ksmbd_vfs_lock_parent'
vfs.c:54: warning: No description found for return value of 'ksmbd_vfs_lock_parent'
vfs.c:372: warning: Function parameter or member 'fp' not described in 'ksmbd_vfs_read'
vfs.c:372: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_read'
vfs.c:489: warning: Function parameter or member 'fp' not described in 'ksmbd_vfs_write'
vfs.c:489: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_write'
vfs.c:555: warning: Function parameter or member 'path' not described in 'ksmbd_vfs_getattr'
vfs.c:555: warning: Function parameter or member 'stat' not described in 'ksmbd_vfs_getattr'
vfs.c:555: warning: Excess function parameter 'work' description in 'ksmbd_vfs_getattr'
vfs.c:555: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_getattr'
vfs.c:555: warning: Excess function parameter 'attrs' description in 'ksmbd_vfs_getattr'
vfs.c:572: warning: Function parameter or member 'p_id' not described in 'ksmbd_vfs_fsync'
vfs.c:595: warning: Function parameter or member 'work' not described in 'ksmbd_vfs_remove_file'
vfs.c:595: warning: Function parameter or member 'path' not described in 'ksmbd_vfs_remove_file'
vfs.c:595: warning: Excess function parameter 'name' description in 'ksmbd_vfs_remove_file'
vfs.c:633: warning: Function parameter or member 'work' not described in 'ksmbd_vfs_link'
vfs.c:805: warning: Function parameter or member 'fp' not described in 'ksmbd_vfs_truncate'
vfs.c:805: warning: Excess function parameter 'fid' description in 'ksmbd_vfs_truncate'
vfs.c:846: warning: Excess function parameter 'size' description in 'ksmbd_vfs_listxattr'
vfs.c:953: warning: Function parameter or member 'option' not described in 'ksmbd_vfs_set_fadvise'
vfs.c:953: warning: Excess function parameter 'options' description in 'ksmbd_vfs_set_fadvise'
vfs.c:1167: warning: Function parameter or member 'um' not described in 'ksmbd_vfs_lookup_in_dir'
vfs.c:1203: warning: Function parameter or member 'work' not described in 'ksmbd_vfs_kern_path_locked'
vfs.c:1641: warning: No description found for return value of 'ksmbd_vfs_init_kstat'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <sfrench@samba.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
---
 fs/smb/server/vfs.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff -- a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -49,6 +49,10 @@ static void ksmbd_vfs_inherit_owner(stru
 
 /**
  * ksmbd_vfs_lock_parent() - lock parent dentry if it is stable
+ * @parent: parent dentry
+ * @child: child dentry
+ *
+ * Returns: %0 on success, %-ENOENT if the parent dentry is not stable
  */
 int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child)
 {
@@ -360,7 +364,7 @@ out:
 /**
  * ksmbd_vfs_read() - vfs helper for smb file read
  * @work:	smb work
- * @fid:	file id of open file
+ * @fp:		ksmbd file pointer
  * @count:	read byte count
  * @pos:	file pos
  * @rbuf:	read data buffer
@@ -474,7 +478,7 @@ out:
 /**
  * ksmbd_vfs_write() - vfs helper for smb file write
  * @work:	work
- * @fid:	file id of open file
+ * @fp:		ksmbd file pointer
  * @buf:	buf containing data for writing
  * @count:	read byte count
  * @pos:	file pos
@@ -545,10 +549,8 @@ out:
 
 /**
  * ksmbd_vfs_getattr() - vfs helper for smb getattr
- * @work:	work
- * @fid:	file id of open file
- * @attrs:	inode attributes
- *
+ * @path:	path of dentry
+ * @stat:	pointer to returned kernel stat structure
  * Return:	0 on success, otherwise error
  */
 int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat)
@@ -565,6 +567,7 @@ int ksmbd_vfs_getattr(const struct path
  * ksmbd_vfs_fsync() - vfs helper for smb fsync
  * @work:	work
  * @fid:	file id of open file
+ * @p_id:	persistent file id
  *
  * Return:	0 on success, otherwise error
  */
@@ -587,7 +590,8 @@ int ksmbd_vfs_fsync(struct ksmbd_work *w
 
 /**
  * ksmbd_vfs_remove_file() - vfs helper for smb rmdir or unlink
- * @name:	directory or file name that is relative to share
+ * @work:	work
+ * @path:	path of dentry
  *
  * Return:	0 on success, otherwise error
  */
@@ -623,6 +627,7 @@ out_err:
 
 /**
  * ksmbd_vfs_link() - vfs helper for creating smb hardlink
+ * @work:	work
  * @oldname:	source file name
  * @newname:	hardlink name that is relative to share
  *
@@ -795,7 +800,7 @@ revert_fsids:
 /**
  * ksmbd_vfs_truncate() - vfs helper for smb file truncate
  * @work:	work
- * @fid:	file id of old file
+ * @fp:		ksmbd file pointer
  * @size:	truncate to given size
  *
  * Return:	0 on success, otherwise error
@@ -838,7 +843,6 @@ int ksmbd_vfs_truncate(struct ksmbd_work
  * ksmbd_vfs_listxattr() - vfs helper for smb list extended attributes
  * @dentry:	dentry of file for listing xattrs
  * @list:	destination buffer
- * @size:	destination buffer length
  *
  * Return:	xattr list length on success, otherwise error
  */
@@ -947,7 +951,7 @@ int ksmbd_vfs_setxattr(struct mnt_idmap
 /**
  * ksmbd_vfs_set_fadvise() - convert smb IO caching options to linux options
  * @filp:	file pointer for IO
- * @options:	smb IO options
+ * @option:	smb IO options
  */
 void ksmbd_vfs_set_fadvise(struct file *filp, __le32 option)
 {
@@ -1159,6 +1163,7 @@ static bool __caseless_lookup(struct dir
  * @dir:	path info
  * @name:	filename to lookup
  * @namelen:	filename length
+ * @um:		&struct unicode_map to use
  *
  * Return:	0 on success, otherwise error
  */
@@ -1189,6 +1194,7 @@ static int ksmbd_vfs_lookup_in_dir(const
 
 /**
  * ksmbd_vfs_kern_path_locked() - lookup a file and get path info
+ * @work:	work
  * @name:		file path that is relative to share
  * @flags:		lookup flags
  * @parent_path:	if lookup succeed, return parent_path info
@@ -1636,6 +1642,8 @@ int ksmbd_vfs_get_dos_attrib_xattr(struc
  * ksmbd_vfs_init_kstat() - convert unix stat information to smb stat format
  * @p:          destination buffer
  * @ksmbd_kstat:      ksmbd kstat wrapper
+ *
+ * Returns: pointer to the converted &struct file_directory_info
  */
 void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat)
 {

