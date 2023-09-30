Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84817B3FD1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjI3KCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjI3KC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:02:29 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5847195
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 03:02:22 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1a1fa977667so7988487fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1696068141; x=1696672941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VCA5DG/tFHrdWN2W06aQcv04OFO9dwLwgOlkJ5gIxGM=;
        b=hsZ48WBu8rK7PTluJvIwUTqMPw18RMSzpHsLUq9p+JlFjyG4UhPuO3f6y4vXS6ExRe
         whRuAXqKlSmisZyE4Hxykx+3H/DAJNrYZgFk26maWUQlL7xWnSlWo5RzxUKeeAjcf3do
         gUuHnSwM3t1scEYJKqtyDr1+5HD7DYQWw6IEA05E/Tj9dKTzeyf+4rvQE1iZd32Y2IzQ
         iJSr9oVcdcpAsq2HyA78vksa5HzGr5VZX6BMg6Hde7hUDeuwf3CvEa73YAipQKJ/cbVw
         CoXG7H8sAVY3rt0KyMYcUE/ZKxw1oCHu4W6VbkkgGW5535JiVOFw4469KUrKUWbI1biC
         /gzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696068141; x=1696672941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCA5DG/tFHrdWN2W06aQcv04OFO9dwLwgOlkJ5gIxGM=;
        b=rxEtBFzKrqsXyEHlBBz2eFb2nK6d55HphbU+XcDmo8tnP2iCI8PDJ2A6c8Cg9NPjog
         sxLcZrAWEBAcelUYojo5BgGGhnbAQmPmlCmpup2WMK5lG0FYVe5HD8VpPd/ZJRmtJxKh
         tMDIjE10XBO+kNRFnas3jHl/orFy/Mamwb7Ab2CwCtisa+WLCWYM9/gRat0EG+DxtDDV
         eELHXrK4HoBwuu8T/EYP9FiJGFCPLJro33oeFSF+/EQWTbftaYosh46Lj65pY8gXi+PQ
         +8u7G64pSooPzQ7UFJLT9qJaS98k6mVJ5MSnx6V/N66Qwo66sXk4H8BEvNfzNAb8BGQ/
         barg==
X-Gm-Message-State: AOJu0YyE7rQkJJyskVOvVRyrKLWStfiH3BlVWzDtPdguwtTH5qtgbgHw
        A2392y/y8Dw91oZiyhV7mnqpag==
X-Google-Smtp-Source: AGHT+IGbLUHKAHKl52cRkbyNwZkRnzmz1O8f2tIdvBBs3gJ/lVxZYitBfOlAcIc7rgRfkUvhHET3qA==
X-Received: by 2002:a05:6870:b488:b0:1d5:a980:9caa with SMTP id y8-20020a056870b48800b001d5a9809caamr7460987oap.29.1696068140873;
        Sat, 30 Sep 2023 03:02:20 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id t21-20020a63b255000000b00578e9751b88sm15864937pgo.1.2023.09.30.03.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 03:02:20 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, mszeredi@redhat.com,
        bigeasy@linutronix.de, mcgrof@kernel.org, xiubli@redhat.com,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH RESEND 2/2] vfs: replace d_backing_inode() with d_inode() globally
Date:   Sat, 30 Sep 2023 10:01:56 +0000
Message-Id: <20230930100156.24014-2-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

d_backing_inode() does the same thing with d_inode(), so using
d_inode() to get the inode of dentry instead of d_backing_inode().

Following are the steps to complete search-and-replace:

1) replacing the definition and comment of d_backing_inode() with
   #define d_backing_inode d_inode

2) sed -i -e "s/\<d_backing_inode\>/d_inode/g" $(git grep -l -w "d_backing_inode")
   sed -i -e "/#define d_inode d_inode/d" include/linux/dcache.h

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/bdev.c                          |  2 +-
 drivers/block/ublk_drv.c              |  2 +-
 fs/cachefiles/cache.c                 |  8 ++--
 fs/cachefiles/namei.c                 | 38 +++++++++---------
 fs/cachefiles/security.c              |  6 +--
 fs/cachefiles/xattr.c                 |  2 +-
 fs/exfat/file.c                       |  2 +-
 fs/fs_parser.c                        |  2 +-
 fs/namei.c                            |  4 +-
 fs/open.c                             |  6 +--
 fs/posix_acl.c                        |  2 +-
 fs/reiserfs/xattr.c                   |  2 +-
 fs/stat.c                             |  6 +--
 fs/udf/symlink.c                      |  2 +-
 include/linux/dcache.h                | 18 +--------
 include/trace/events/cachefiles.h     | 10 ++---
 kernel/audit_tree.c                   |  4 +-
 kernel/audit_watch.c                  |  8 ++--
 kernel/auditsc.c                      |  6 +--
 kernel/bpf/inode.c                    |  4 +-
 net/unix/af_unix.c                    |  6 +--
 net/unix/diag.c                       |  2 +-
 security/apparmor/file.c              |  4 +-
 security/apparmor/lsm.c               | 14 +++----
 security/commoncap.c                  |  8 ++--
 security/integrity/evm/evm_crypto.c   |  4 +-
 security/integrity/evm/evm_main.c     | 24 +++++------
 security/integrity/ima/ima_appraise.c | 10 ++---
 security/landlock/fs.c                | 10 ++---
 security/landlock/syscalls.c          |  2 +-
 security/lsm_audit.c                  |  4 +-
 security/security.c                   | 54 ++++++++++++-------------
 security/selinux/hooks.c              | 20 ++++-----
 security/smack/smack_lsm.c            | 58 +++++++++++++--------------
 security/tomoyo/condition.c           |  2 +-
 security/tomoyo/realpath.c            |  8 ++--
 36 files changed, 174 insertions(+), 190 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f3b13aa1b7d4..72c7429db18e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -927,7 +927,7 @@ int lookup_bdev(const char *pathname, dev_t *dev)
 	if (error)
 		return error;
 
-	inode = d_backing_inode(path.dentry);
+	inode = d_inode(path.dentry);
 	error = -ENOTBLK;
 	if (!S_ISBLK(inode->i_mode))
 		goto out_path_put;
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 630ddfe6657b..3650aa869943 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2707,7 +2707,7 @@ static int ublk_char_dev_permission(struct ublk_device *ub,
 		goto exit;
 
 	err = inode_permission(&nop_mnt_idmap,
-			d_backing_inode(path.dentry), mask);
+			d_inode(path.dentry), mask);
 exit:
 	path_put(&path);
 	return err;
diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index 7077f72e6f47..86078ba0e637 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -59,10 +59,10 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
 	 */
 	ret = -EOPNOTSUPP;
 	if (d_is_negative(root) ||
-	    !d_backing_inode(root)->i_op->lookup ||
-	    !d_backing_inode(root)->i_op->mkdir ||
-	    !d_backing_inode(root)->i_op->tmpfile ||
-	    !(d_backing_inode(root)->i_opflags & IOP_XATTR) ||
+	    !d_inode(root)->i_op->lookup ||
+	    !d_inode(root)->i_op->mkdir ||
+	    !d_inode(root)->i_op->tmpfile ||
+	    !(d_inode(root)->i_opflags & IOP_XATTR) ||
 	    !root->d_sb->s_op->statfs ||
 	    !root->d_sb->s_op->sync_fs ||
 	    root->d_sb->s_blocksize > PAGE_SIZE)
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 7bf7a5fcc045..b39ab2159361 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -103,7 +103,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		subdir = ERR_PTR(ret);
 	trace_cachefiles_lookup(NULL, dir, subdir);
 	if (IS_ERR(subdir)) {
-		trace_cachefiles_vfs_error(NULL, d_backing_inode(dir),
+		trace_cachefiles_vfs_error(NULL, d_inode(dir),
 					   PTR_ERR(subdir),
 					   cachefiles_trace_lookup_error);
 		if (PTR_ERR(subdir) == -ENOMEM)
@@ -112,7 +112,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	}
 
 	_debug("subdir -> %pd %s",
-	       subdir, d_backing_inode(subdir) ? "positive" : "negative");
+	       subdir, d_inode(subdir) ? "positive" : "negative");
 
 	/* we need to create the subdir if it doesn't exist yet */
 	if (d_is_negative(subdir)) {
@@ -142,10 +142,10 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 			cachefiles_put_directory(subdir);
 			goto retry;
 		}
-		ASSERT(d_backing_inode(subdir));
+		ASSERT(d_inode(subdir));
 
 		_debug("mkdir -> %pd{ino=%lu}",
-		       subdir, d_backing_inode(subdir)->i_ino);
+		       subdir, d_inode(subdir)->i_ino);
 		if (_is_new)
 			*_is_new = true;
 	}
@@ -163,7 +163,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	inode_unlock(d_inode(subdir));
 
 	/* we need to make sure the subdir is a directory */
-	ASSERT(d_backing_inode(subdir));
+	ASSERT(d_inode(subdir));
 
 	if (!d_can_lookup(subdir)) {
 		pr_err("%s is not a directory\n", dirname);
@@ -172,15 +172,15 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	}
 
 	ret = -EPERM;
-	if (!(d_backing_inode(subdir)->i_opflags & IOP_XATTR) ||
-	    !d_backing_inode(subdir)->i_op->lookup ||
-	    !d_backing_inode(subdir)->i_op->mkdir ||
-	    !d_backing_inode(subdir)->i_op->rename ||
-	    !d_backing_inode(subdir)->i_op->rmdir ||
-	    !d_backing_inode(subdir)->i_op->unlink)
+	if (!(d_inode(subdir)->i_opflags & IOP_XATTR) ||
+	    !d_inode(subdir)->i_op->lookup ||
+	    !d_inode(subdir)->i_op->mkdir ||
+	    !d_inode(subdir)->i_op->rename ||
+	    !d_inode(subdir)->i_op->rmdir ||
+	    !d_inode(subdir)->i_op->unlink)
 		goto check_error;
 
-	_leave(" = [%lu]", d_backing_inode(subdir)->i_ino);
+	_leave(" = [%lu]", d_inode(subdir)->i_ino);
 	return subdir;
 
 check_error:
@@ -245,12 +245,12 @@ static int cachefiles_unlink(struct cachefiles_cache *cache,
 
 	ret = cachefiles_inject_remove_error();
 	if (ret == 0) {
-		ret = vfs_unlink(&nop_mnt_idmap, d_backing_inode(dir), dentry, NULL);
+		ret = vfs_unlink(&nop_mnt_idmap, d_inode(dir), dentry, NULL);
 		if (ret == -EIO)
 			cachefiles_io_error(cache, "Unlink failed");
 	}
 	if (ret != 0)
-		trace_cachefiles_vfs_error(object, d_backing_inode(dir), ret,
+		trace_cachefiles_vfs_error(object, d_inode(dir), ret,
 					   cachefiles_trace_unlink_error);
 	return ret;
 }
@@ -424,9 +424,9 @@ int cachefiles_delete_object(struct cachefiles_object *object,
 	/* Stop the dentry being negated if it's only pinned by a file struct. */
 	dget(dentry);
 
-	inode_lock_nested(d_backing_inode(fan), I_MUTEX_PARENT);
+	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
 	ret = cachefiles_unlink(volume->cache, object, fan, dentry, why);
-	inode_unlock(d_backing_inode(fan));
+	inode_unlock(d_inode(fan));
 	dput(dentry);
 	return ret;
 }
@@ -562,9 +562,9 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	path.mnt = cache->mnt;
 	path.dentry = dentry;
 	file = kernel_file_open(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
-				d_backing_inode(dentry), cache->cache_cred);
+				d_inode(dentry), cache->cache_cred);
 	if (IS_ERR(file)) {
-		trace_cachefiles_vfs_error(object, d_backing_inode(dentry),
+		trace_cachefiles_vfs_error(object, d_inode(dentry),
 					   PTR_ERR(file),
 					   cachefiles_trace_open_error);
 		goto error;
@@ -691,7 +691,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 	}
 
 	if (!d_is_negative(dentry)) {
-		if (d_backing_inode(dentry) == file_inode(object->file)) {
+		if (d_inode(dentry) == file_inode(object->file)) {
 			success = true;
 			goto out_dput;
 		}
diff --git a/fs/cachefiles/security.c b/fs/cachefiles/security.c
index fe777164f1d8..f3c1f4900d3e 100644
--- a/fs/cachefiles/security.c
+++ b/fs/cachefiles/security.c
@@ -51,14 +51,14 @@ static int cachefiles_check_cache_dir(struct cachefiles_cache *cache,
 {
 	int ret;
 
-	ret = security_inode_mkdir(d_backing_inode(root), root, 0);
+	ret = security_inode_mkdir(d_inode(root), root, 0);
 	if (ret < 0) {
 		pr_err("Security denies permission to make dirs: error %d",
 		       ret);
 		return ret;
 	}
 
-	ret = security_inode_create(d_backing_inode(root), root, 0);
+	ret = security_inode_create(d_inode(root), root, 0);
 	if (ret < 0)
 		pr_err("Security denies permission to create files: error %d",
 		       ret);
@@ -91,7 +91,7 @@ int cachefiles_determine_cache_security(struct cachefiles_cache *cache,
 
 	/* use the cache root dir's security context as the basis with
 	 * which create files */
-	ret = set_create_files_as(new, d_backing_inode(root));
+	ret = set_create_files_as(new, d_inode(root));
 	if (ret < 0) {
 		abort_creds(new);
 		cachefiles_begin_secure(cache, _saved_cred);
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index bcb6173943ee..05b9ccbc2e85 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -160,7 +160,7 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 			cachefiles_io_error(cache,
 					    "Can't remove xattr from %lu"
 					    " (error %d)",
-					    d_backing_inode(dentry)->i_ino, -ret);
+					    d_inode(dentry)->i_ino, -ret);
 	}
 
 	_leave(" = %d", ret);
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 32395ef686a2..9a3794ba783a 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -229,7 +229,7 @@ int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, unsigned int request_mask,
 		  unsigned int query_flags)
 {
-	struct inode *inode = d_backing_inode(path->dentry);
+	struct inode *inode = d_inode(path->dentry);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index edb3712dcfa5..62ab7d06de46 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -173,7 +173,7 @@ int fs_lookup_param(struct fs_context *fc,
 	}
 
 	if (want_bdev &&
-	    !S_ISBLK(d_backing_inode(_path->dentry)->i_mode)) {
+	    !S_ISBLK(d_inode(_path->dentry)->i_mode)) {
 		path_put(_path);
 		_path->dentry = NULL;
 		_path->mnt = NULL;
diff --git a/fs/namei.c b/fs/namei.c
index 567ee547492b..e7859d4f5274 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2950,7 +2950,7 @@ EXPORT_SYMBOL(__check_sticky);
 static int may_delete(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *victim, bool isdir)
 {
-	struct inode *inode = d_backing_inode(victim);
+	struct inode *inode = d_inode(victim);
 	int error;
 
 	if (d_is_negative(victim))
@@ -3615,7 +3615,7 @@ static int do_open(struct nameidata *nd,
 		if (d_is_dir(nd->path.dentry))
 			return -EISDIR;
 		error = may_create_in_sticky(idmap, nd,
-					     d_backing_inode(nd->path.dentry));
+					     d_inode(nd->path.dentry));
 		if (unlikely(error))
 			return error;
 	}
diff --git a/fs/open.c b/fs/open.c
index 98f6601fbac6..7bf3bdaec0bd 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -484,7 +484,7 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
 	if (res)
 		goto out;
 
-	inode = d_backing_inode(path.dentry);
+	inode = d_inode(path.dentry);
 
 	if ((mode & MAY_EXEC) && S_ISREG(inode->i_mode)) {
 		/*
@@ -1021,7 +1021,7 @@ int finish_open(struct file *file, struct dentry *dentry,
 	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
 
 	file->f_path.dentry = dentry;
-	return do_dentry_open(file, d_backing_inode(dentry), open);
+	return do_dentry_open(file, d_inode(dentry), open);
 }
 EXPORT_SYMBOL(finish_open);
 
@@ -1060,7 +1060,7 @@ EXPORT_SYMBOL(file_path);
 int vfs_open(const struct path *path, struct file *file)
 {
 	file->f_path = *path;
-	return do_dentry_open(file, d_backing_inode(path->dentry), NULL);
+	return do_dentry_open(file, d_inode(path->dentry), NULL);
 }
 
 struct file *dentry_open(const struct path *path, int flags,
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index a05fe94970ce..1e7a01c529f1 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -985,7 +985,7 @@ int posix_acl_listxattr(struct inode *inode, char **buffer,
 static bool
 posix_acl_xattr_list(struct dentry *dentry)
 {
-	return IS_POSIXACL(d_backing_inode(dentry));
+	return IS_POSIXACL(d_inode(dentry));
 }
 
 /*
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 6000964c2b80..1664a9334a50 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -776,7 +776,7 @@ static inline bool reiserfs_posix_acl_list(const char *name,
 					   struct dentry *dentry)
 {
 	return (posix_acl_type(name) >= 0) &&
-	       IS_POSIXACL(d_backing_inode(dentry));
+	       IS_POSIXACL(d_inode(dentry));
 }
 
 /* This is the implementation for the xattr plugin infrastructure */
diff --git a/fs/stat.c b/fs/stat.c
index d43a5cc1bfa4..83f6a51f496b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -106,7 +106,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 		      u32 request_mask, unsigned int query_flags)
 {
 	struct mnt_idmap *idmap;
-	struct inode *inode = d_backing_inode(path->dentry);
+	struct inode *inode = d_inode(path->dentry);
 
 	memset(stat, 0, sizeof(*stat));
 	stat->result_mask |= STATX_BASIC_STATS;
@@ -252,7 +252,7 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 
 	/* Handle STATX_DIOALIGN for block devices. */
 	if (request_mask & STATX_DIOALIGN) {
-		struct inode *inode = d_backing_inode(path.dentry);
+		struct inode *inode = d_inode(path.dentry);
 
 		if (S_ISBLK(inode->i_mode))
 			bdev_statx_dioalign(inode, stat);
@@ -489,7 +489,7 @@ static int do_readlinkat(int dfd, const char __user *pathname,
 retry:
 	error = user_path_at_empty(dfd, pathname, lookup_flags, &path, &empty);
 	if (!error) {
-		struct inode *inode = d_backing_inode(path.dentry);
+		struct inode *inode = d_inode(path.dentry);
 
 		error = empty ? -ENOENT : -EINVAL;
 		/*
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index f7eaf7b14594..a35d8db741c7 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -146,7 +146,7 @@ static int udf_symlink_getattr(struct mnt_idmap *idmap,
 			       u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct page *page;
 
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 13023c7211d6..f09c04a5bcef 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -528,22 +528,6 @@ static inline struct inode *d_inode_rcu(const struct dentry *dentry)
 	return READ_ONCE(dentry->d_inode);
 }
 
-/**
- * d_backing_inode - Get upper or lower inode we should be using
- * @upper: The upper layer
- *
- * This is the helper that should be used to get at the inode that will be used
- * if this dentry were to be opened as a file.  The inode may be on the upper
- * dentry or it may be on a lower dentry pinned by the upper.
- *
- * Normal filesystems should not use this to access their own inodes.
- */
-static inline struct inode *d_backing_inode(const struct dentry *upper)
-{
-	struct inode *inode = upper->d_inode;
-
-	return inode;
-}
 
 /**
  * d_real - Return the real dentry
@@ -574,7 +558,7 @@ static inline struct dentry *d_real(struct dentry *dentry,
 static inline struct inode *d_real_inode(const struct dentry *dentry)
 {
 	/* This usage of d_real() results in const dentry */
-	return d_backing_inode(d_real((struct dentry *) dentry, NULL));
+	return d_inode(d_real((struct dentry *) dentry, NULL));
 }
 
 struct name_snapshot {
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index cf4b98b9a9ed..e866d6ee1092 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -251,9 +251,9 @@ TRACE_EVENT(cachefiles_lookup,
 
 	    TP_fast_assign(
 		    __entry->obj	= obj ? obj->debug_id : 0;
-		    __entry->dino	= d_backing_inode(dir)->i_ino;
-		    __entry->ino	= (!IS_ERR(de) && d_backing_inode(de) ?
-					   d_backing_inode(de)->i_ino : 0);
+		    __entry->dino	= d_inode(dir)->i_ino;
+		    __entry->ino	= (!IS_ERR(de) && d_inode(de) ?
+					   d_inode(de)->i_ino : 0);
 		    __entry->error	= IS_ERR(de) ? PTR_ERR(de) : 0;
 			   ),
 
@@ -272,8 +272,8 @@ TRACE_EVENT(cachefiles_mkdir,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->dir	= d_backing_inode(dir)->i_ino;
-		    __entry->subdir	= d_backing_inode(subdir)->i_ino;
+		    __entry->dir	= d_inode(dir)->i_ino;
+		    __entry->subdir	= d_inode(subdir)->i_ino;
 			   ),
 
 	    TP_printk("dB=%x sB=%x",
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index e867c17d3f84..67451ab3f3da 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -670,7 +670,7 @@ int audit_remove_tree_rule(struct audit_krule *rule)
 
 static int compare_root(struct vfsmount *mnt, void *arg)
 {
-	return inode_to_key(d_backing_inode(mnt->mnt_root)) ==
+	return inode_to_key(d_inode(mnt->mnt_root)) ==
 	       (unsigned long)arg;
 }
 
@@ -744,7 +744,7 @@ void audit_put_tree(struct audit_tree *tree)
 
 static int tag_mount(struct vfsmount *mnt, void *arg)
 {
-	return tag_chunk(d_backing_inode(mnt->mnt_root), arg);
+	return tag_chunk(d_inode(mnt->mnt_root), arg);
 }
 
 /*
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 65075f1e4ac8..68c581662067 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -135,7 +135,7 @@ int audit_watch_compare(struct audit_watch *watch, unsigned long ino, dev_t dev)
 /* Initialize a parent watch entry. */
 static struct audit_parent *audit_init_parent(const struct path *path)
 {
-	struct inode *inode = d_backing_inode(path->dentry);
+	struct inode *inode = d_inode(path->dentry);
 	struct audit_parent *parent;
 	int ret;
 
@@ -353,9 +353,9 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 	if (d_is_positive(d)) {
 		/* update watch filter fields */
 		watch->dev = d->d_sb->s_dev;
-		watch->ino = d_backing_inode(d)->i_ino;
+		watch->ino = d_inode(d)->i_ino;
 	}
-	inode_unlock(d_backing_inode(parent->dentry));
+	inode_unlock(d_inode(parent->dentry));
 	dput(d);
 	return 0;
 }
@@ -425,7 +425,7 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
 	}
 
 	/* either find an old parent or attach a new one */
-	parent = audit_find_parent(d_backing_inode(parent_path.dentry));
+	parent = audit_find_parent(d_inode(parent_path.dentry));
 	if (!parent) {
 		parent = audit_init_parent(&parent_path);
 		if (IS_ERR(parent)) {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 21d2fa815e78..efaee820ea60 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2129,7 +2129,7 @@ static void handle_path(const struct dentry *dentry)
 	rcu_read_lock();
 	seq = read_seqbegin(&rename_lock);
 	for (;;) {
-		struct inode *inode = d_backing_inode(d);
+		struct inode *inode = d_inode(d);
 
 		if (inode && unlikely(inode->i_fsnotify_marks)) {
 			struct audit_chunk *chunk;
@@ -2296,7 +2296,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 		   unsigned int flags)
 {
 	struct audit_context *context = audit_context();
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct audit_names *n;
 	bool parent = flags & AUDIT_INODE_PARENT;
 	struct audit_entry *e;
@@ -2414,7 +2414,7 @@ void __audit_inode_child(struct inode *parent,
 			 const unsigned char type)
 {
 	struct audit_context *context = audit_context();
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	const struct qstr *dname = &dentry->d_name;
 	struct audit_names *n, *found_parent = NULL, *found_child = NULL;
 	struct audit_entry *e;
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 99d0625b6c82..88e35686127e 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -504,7 +504,7 @@ static void *bpf_obj_do_get(int path_fd, const char __user *pathname,
 	if (ret)
 		return ERR_PTR(ret);
 
-	inode = d_backing_inode(path.dentry);
+	inode = d_inode(path.dentry);
 	ret = path_permission(&path, ACC_MODE(flags));
 	if (ret)
 		goto out;
@@ -587,7 +587,7 @@ struct bpf_prog *bpf_prog_get_type_path(const char *name, enum bpf_prog_type typ
 	int ret = kern_path(name, LOOKUP_FOLLOW, &path);
 	if (ret)
 		return ERR_PTR(ret);
-	prog = __get_prog_inode(d_backing_inode(path.dentry), type);
+	prog = __get_prog_inode(d_inode(path.dentry), type);
 	if (!IS_ERR(prog))
 		touch_atime(&path);
 	path_put(&path);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3e8a04a13668..3a62bd99f561 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -406,7 +406,7 @@ static struct sock *unix_find_socket_byinode(struct inode *i)
 	sk_for_each_bound(s, &bsd_socket_buckets[hash]) {
 		struct dentry *dentry = unix_sk(s)->path.dentry;
 
-		if (dentry && d_backing_inode(dentry) == i) {
+		if (dentry && d_inode(dentry) == i) {
 			sock_hold(s);
 			spin_unlock(&bsd_socket_locks[hash]);
 			return s;
@@ -1086,7 +1086,7 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 		goto path_put;
 
 	err = -ECONNREFUSED;
-	inode = d_backing_inode(path.dentry);
+	inode = d_inode(path.dentry);
 	if (!S_ISSOCK(inode->i_mode))
 		goto path_put;
 
@@ -1250,7 +1250,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	if (u->addr)
 		goto out_unlock;
 
-	new_hash = unix_bsd_hash(d_backing_inode(dentry));
+	new_hash = unix_bsd_hash(d_inode(dentry));
 	unix_table_double_lock(net, old_hash, new_hash);
 	u->path.mnt = mntget(parent.mnt);
 	u->path.dentry = dget(dentry);
diff --git a/net/unix/diag.c b/net/unix/diag.c
index 616b55c5b890..88e2e64a6829 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -30,7 +30,7 @@ static int sk_diag_dump_vfs(struct sock *sk, struct sk_buff *nlskb)
 
 	if (dentry) {
 		struct unix_diag_vfs uv = {
-			.udiag_vfs_ino = d_backing_inode(dentry)->i_ino,
+			.udiag_vfs_ino = d_inode(dentry)->i_ino,
 			.udiag_vfs_dev = dentry->d_sb->s_dev,
 		};
 
diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 698b124e649f..c05f06fe9a64 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -409,8 +409,8 @@ int aa_path_link(struct aa_label *label, struct dentry *old_dentry,
 	struct path link = { .mnt = new_dir->mnt, .dentry = new_dentry };
 	struct path target = { .mnt = new_dir->mnt, .dentry = old_dentry };
 	struct path_cond cond = {
-		d_backing_inode(old_dentry)->i_uid,
-		d_backing_inode(old_dentry)->i_mode
+		d_inode(old_dentry)->i_uid,
+		d_inode(old_dentry)->i_mode
 	};
 	char *buffer = NULL, *buffer2 = NULL;
 	struct aa_profile *profile;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 108eccc5ada5..4f0a593c2c5b 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -228,10 +228,10 @@ static int common_perm(const char *op, const struct path *path, u32 mask,
 static int common_perm_cond(const char *op, const struct path *path, u32 mask)
 {
 	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_idmap(path->mnt),
-					    d_backing_inode(path->dentry));
+					    d_inode(path->dentry));
 	struct path_cond cond = {
 		vfsuid_into_kuid(vfsuid),
-		d_backing_inode(path->dentry)->i_mode
+		d_inode(path->dentry)->i_mode
 	};
 
 	if (!path_mediated_fs(path->dentry))
@@ -271,7 +271,7 @@ static int common_perm_dir_dentry(const char *op, const struct path *dir,
 static int common_perm_rm(const char *op, const struct path *dir,
 			  struct dentry *dentry, u32 mask)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct path_cond cond = { };
 	vfsuid_t vfsuid;
 
@@ -384,16 +384,16 @@ static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_d
 		struct path new_path = { .mnt = new_dir->mnt,
 					 .dentry = new_dentry };
 		struct path_cond cond = {
-			.mode = d_backing_inode(old_dentry)->i_mode
+			.mode = d_inode(old_dentry)->i_mode
 		};
-		vfsuid = i_uid_into_vfsuid(idmap, d_backing_inode(old_dentry));
+		vfsuid = i_uid_into_vfsuid(idmap, d_inode(old_dentry));
 		cond.uid = vfsuid_into_kuid(vfsuid);
 
 		if (flags & RENAME_EXCHANGE) {
 			struct path_cond cond_exchange = {
-				.mode = d_backing_inode(new_dentry)->i_mode,
+				.mode = d_inode(new_dentry)->i_mode,
 			};
-			vfsuid = i_uid_into_vfsuid(idmap, d_backing_inode(old_dentry));
+			vfsuid = i_uid_into_vfsuid(idmap, d_inode(old_dentry));
 			cond_exchange.uid = vfsuid_into_kuid(vfsuid);
 
 			error = aa_path_perm(OP_RENAME_SRC, label, &new_path, 0,
diff --git a/security/commoncap.c b/security/commoncap.c
index bc0521104197..8361226be59b 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -295,7 +295,7 @@ int cap_capset(struct cred *new,
  */
 int cap_inode_need_killpriv(struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	int error;
 
 	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
@@ -533,7 +533,7 @@ int cap_convert_nscap(struct mnt_idmap *idmap, struct dentry *dentry,
 	uid_t nsrootid;
 	const struct vfs_cap_data *cap = *ivalue;
 	__u32 magic, nsmagic;
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct user_namespace *task_ns = current_user_ns(),
 		*fs_ns = inode->i_sb->s_user_ns;
 	kuid_t rootid;
@@ -636,7 +636,7 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 			   const struct dentry *dentry,
 			   struct cpu_vfs_cap_data *cpu_caps)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	__u32 magic_etc;
 	int size;
 	struct vfs_ns_cap_data data, *nscaps = &data;
@@ -1039,7 +1039,7 @@ int cap_inode_removexattr(struct mnt_idmap *idmap,
 
 	if (strcmp(name, XATTR_NAME_CAPS) == 0) {
 		/* security.capability gets namespaced */
-		struct inode *inode = d_backing_inode(dentry);
+		struct inode *inode = d_inode(dentry);
 		if (!inode)
 			return -EINVAL;
 		if (!capable_wrt_inode_uidgid(idmap, inode, CAP_SETFCAP))
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index b1ffd4cc0b44..9bed5ff0a246 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 				 size_t req_xattr_value_len,
 				 uint8_t type, struct evm_digest *data)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct xattr_list *xattr;
 	struct shash_desc *desc;
 	size_t xattr_size = 0;
@@ -356,7 +356,7 @@ static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
 int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 			const char *xattr_value, size_t xattr_value_len)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct evm_digest data;
 	int rc = 0;
 
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index ff9a939dad8e..0413999d0aa6 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -131,7 +131,7 @@ static bool evm_hmac_disabled(void)
 
 static int evm_find_protected_xattrs(struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct xattr_list *xattr;
 	int error;
 	int count = 0;
@@ -241,7 +241,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 					(const char *)xattr_data, xattr_len,
 					digest.digest, digest.hdr.length);
 		if (!rc) {
-			inode = d_backing_inode(dentry);
+			inode = d_inode(dentry);
 
 			if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG) {
 				if (iint)
@@ -337,7 +337,7 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 	int rc, size, total_size = 0;
 
 	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
-		rc = __vfs_getxattr(dentry, d_backing_inode(dentry),
+		rc = __vfs_getxattr(dentry, d_inode(dentry),
 				    xattr->name, NULL, 0);
 		if (rc < 0 && rc == -ENODATA)
 			continue;
@@ -367,7 +367,7 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 			size = rc;
 			if (buffer) {
 				rc = __vfs_getxattr(dentry,
-					d_backing_inode(dentry), xattr->name,
+					d_inode(dentry), xattr->name,
 					buffer + total_size,
 					buffer_size - total_size);
 				if (rc < 0)
@@ -410,7 +410,7 @@ enum integrity_status evm_verifyxattr(struct dentry *dentry,
 		return INTEGRITY_UNKNOWN;
 
 	if (!iint) {
-		iint = integrity_iint_find(d_backing_inode(dentry));
+		iint = integrity_iint_find(d_inode(dentry));
 		if (!iint)
 			return INTEGRITY_UNKNOWN;
 	}
@@ -428,7 +428,7 @@ EXPORT_SYMBOL_GPL(evm_verifyxattr);
  */
 static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 
 	if (!evm_key_loaded() || !S_ISREG(inode->i_mode) || evm_fixmode)
 		return INTEGRITY_PASS;
@@ -510,7 +510,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 		if (evm_hmac_disabled())
 			return 0;
 
-		iint = integrity_iint_find(d_backing_inode(dentry));
+		iint = integrity_iint_find(d_inode(dentry));
 		if (iint && (iint->flags & IMA_NEW_FILE))
 			return 0;
 
@@ -545,7 +545,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 
 	if (evm_status != INTEGRITY_PASS &&
 	    evm_status != INTEGRITY_PASS_IMMUTABLE)
-		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
+		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
 				    integrity_status_msg[evm_status],
 				    -EPERM, 0);
@@ -618,7 +618,7 @@ static int evm_inode_set_acl_change(struct mnt_idmap *idmap,
 	int rc;
 
 	umode_t mode;
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 
 	if (!kacl)
 		return 1;
@@ -683,7 +683,7 @@ int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		return 0;
 
 	if (evm_status != INTEGRITY_PASS_IMMUTABLE)
-		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
+		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
 				    integrity_status_msg[evm_status],
 				    -EPERM, 0);
@@ -783,7 +783,7 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 static int evm_attr_change(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid = attr->ia_valid;
 
 	if (!i_uid_needs_update(idmap, attr, inode) &&
@@ -833,7 +833,7 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	    !evm_attr_change(idmap, dentry, attr))
 		return 0;
 
-	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
+	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_inode(dentry),
 			    dentry->d_name.name, "appraise_metadata",
 			    integrity_status_msg[evm_status], -EPERM, 0);
 	return -EPERM;
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 870dde67707b..491a7429df75 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -486,7 +486,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 	static const char op[] = "appraise_data";
 	const char *cause = "unknown";
 	struct dentry *dentry = file_dentry(file);
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	enum integrity_status status = INTEGRITY_UNKNOWN;
 	int rc = xattr_len;
 	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
@@ -638,7 +638,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
 void ima_inode_post_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct integrity_iint_cache *iint;
 	int action;
 
@@ -772,7 +772,7 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
 	}
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
-		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
+		ima_reset_appraise_flags(d_inode(dentry), digsig);
 		if (result == 1)
 			result = 0;
 	}
@@ -783,7 +783,7 @@ int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		      const char *acl_name, struct posix_acl *kacl)
 {
 	if (evm_revalidate_status(acl_name))
-		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
+		ima_reset_appraise_flags(d_inode(dentry), 0);
 
 	return 0;
 }
@@ -794,7 +794,7 @@ int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name)
 
 	result = ima_protect_xattr(dentry, xattr_name, NULL, 0);
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
-		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
+		ima_reset_appraise_flags(d_inode(dentry), 0);
 		if (result == 1)
 			result = 0;
 	}
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 1c0c198f6fdb..3bc7977c9ff5 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -181,7 +181,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	access_rights |=
 		LANDLOCK_MASK_ACCESS_FS &
 		~(ruleset->fs_access_masks[0] | ACCESS_INITIALLY_DENIED);
-	object = get_inode_object(d_backing_inode(path->dentry));
+	object = get_inode_object(d_inode(path->dentry));
 	if (IS_ERR(object))
 		return PTR_ERR(object);
 	mutex_lock(&ruleset->lock);
@@ -213,7 +213,7 @@ find_rule(const struct landlock_ruleset *const domain,
 	if (d_is_negative(dentry))
 		return NULL;
 
-	inode = d_backing_inode(dentry);
+	inode = d_inode(dentry);
 	rcu_read_lock();
 	rule = landlock_find_rule(
 		domain, rcu_dereference(landlock_inode(inode)->object));
@@ -284,7 +284,7 @@ static inline bool is_nouser_or_private(const struct dentry *dentry)
 {
 	return (dentry->d_sb->s_flags & SB_NOUSER) ||
 	       (d_is_positive(dentry) &&
-		unlikely(IS_PRIVATE(d_backing_inode(dentry))));
+		unlikely(IS_PRIVATE(d_inode(dentry))));
 }
 
 static inline access_mask_t
@@ -833,12 +833,12 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 		if (unlikely(d_is_negative(new_dentry)))
 			return -ENOENT;
 		access_request_parent1 =
-			get_mode_access(d_backing_inode(new_dentry)->i_mode);
+			get_mode_access(d_inode(new_dentry)->i_mode);
 	} else {
 		access_request_parent1 = 0;
 	}
 	access_request_parent2 =
-		get_mode_access(d_backing_inode(old_dentry)->i_mode);
+		get_mode_access(d_inode(old_dentry)->i_mode);
 	if (removable) {
 		access_request_parent1 |= maybe_remove(old_dentry);
 		access_request_parent2 |= maybe_remove(new_dentry);
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 245cc650a4dc..3fd22ee41e31 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -262,7 +262,7 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
 	    (f.file->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
 	    (f.file->f_path.dentry->d_sb->s_flags & SB_NOUSER) ||
 	    d_is_negative(f.file->f_path.dentry) ||
-	    IS_PRIVATE(d_backing_inode(f.file->f_path.dentry))) {
+	    IS_PRIVATE(d_inode(f.file->f_path.dentry))) {
 		err = -EBADFD;
 		goto out_fdput;
 	}
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 849e832719e2..422a7066c698 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -223,7 +223,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 
 		audit_log_d_path(ab, " path=", &a->u.path);
 
-		inode = d_backing_inode(a->u.path.dentry);
+		inode = d_inode(a->u.path.dentry);
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
@@ -267,7 +267,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		audit_log_untrustedstring(ab, a->u.dentry->d_name.name);
 		spin_unlock(&a->u.dentry->d_lock);
 
-		inode = d_backing_inode(a->u.dentry);
+		inode = d_inode(a->u.dentry);
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
diff --git a/security/security.c b/security/security.c
index 23b129d482a7..f25b2a7414d7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1710,7 +1710,7 @@ int security_inode_init_security_anon(struct inode *inode,
 int security_path_mknod(const struct path *dir, struct dentry *dentry,
 			umode_t mode, unsigned int dev)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dir->dentry))))
 		return 0;
 	return call_int_hook(path_mknod, 0, dir, dentry, mode, dev);
 }
@@ -1729,7 +1729,7 @@ EXPORT_SYMBOL(security_path_mknod);
 int security_path_mkdir(const struct path *dir, struct dentry *dentry,
 			umode_t mode)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dir->dentry))))
 		return 0;
 	return call_int_hook(path_mkdir, 0, dir, dentry, mode);
 }
@@ -1746,7 +1746,7 @@ EXPORT_SYMBOL(security_path_mkdir);
  */
 int security_path_rmdir(const struct path *dir, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dir->dentry))))
 		return 0;
 	return call_int_hook(path_rmdir, 0, dir, dentry);
 }
@@ -1762,7 +1762,7 @@ int security_path_rmdir(const struct path *dir, struct dentry *dentry)
  */
 int security_path_unlink(const struct path *dir, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dir->dentry))))
 		return 0;
 	return call_int_hook(path_unlink, 0, dir, dentry);
 }
@@ -1781,7 +1781,7 @@ EXPORT_SYMBOL(security_path_unlink);
 int security_path_symlink(const struct path *dir, struct dentry *dentry,
 			  const char *old_name)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dir->dentry))))
 		return 0;
 	return call_int_hook(path_symlink, 0, dir, dentry, old_name);
 }
@@ -1799,7 +1799,7 @@ int security_path_symlink(const struct path *dir, struct dentry *dentry,
 int security_path_link(struct dentry *old_dentry, const struct path *new_dir,
 		       struct dentry *new_dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(old_dentry))))
 		return 0;
 	return call_int_hook(path_link, 0, old_dentry, new_dir, new_dentry);
 }
@@ -1820,9 +1820,9 @@ int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
 			 const struct path *new_dir, struct dentry *new_dentry,
 			 unsigned int flags)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
+	if (unlikely(IS_PRIVATE(d_inode(old_dentry)) ||
 		     (d_is_positive(new_dentry) &&
-		      IS_PRIVATE(d_backing_inode(new_dentry)))))
+		      IS_PRIVATE(d_inode(new_dentry)))))
 		return 0;
 
 	return call_int_hook(path_rename, 0, old_dir, old_dentry, new_dir,
@@ -1842,7 +1842,7 @@ EXPORT_SYMBOL(security_path_rename);
  */
 int security_path_truncate(const struct path *path)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(path->dentry))))
 		return 0;
 	return call_int_hook(path_truncate, 0, path);
 }
@@ -1860,7 +1860,7 @@ int security_path_truncate(const struct path *path)
  */
 int security_path_chmod(const struct path *path, umode_t mode)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(path->dentry))))
 		return 0;
 	return call_int_hook(path_chmod, 0, path, mode);
 }
@@ -1877,7 +1877,7 @@ int security_path_chmod(const struct path *path, umode_t mode)
  */
 int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(path->dentry))))
 		return 0;
 	return call_int_hook(path_chown, 0, path, uid, gid);
 }
@@ -1928,7 +1928,7 @@ EXPORT_SYMBOL_GPL(security_inode_create);
 int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 			struct dentry *new_dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(old_dentry))))
 		return 0;
 	return call_int_hook(inode_link, 0, old_dentry, dir, new_dentry);
 }
@@ -1944,7 +1944,7 @@ int security_inode_link(struct dentry *old_dentry, struct inode *dir,
  */
 int security_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	return call_int_hook(inode_unlink, 0, dir, dentry);
 }
@@ -1997,7 +1997,7 @@ EXPORT_SYMBOL_GPL(security_inode_mkdir);
  */
 int security_inode_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	return call_int_hook(inode_rmdir, 0, dir, dentry);
 }
@@ -2040,9 +2040,9 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 			  struct inode *new_dir, struct dentry *new_dentry,
 			  unsigned int flags)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
+	if (unlikely(IS_PRIVATE(d_inode(old_dentry)) ||
 		     (d_is_positive(new_dentry) &&
-		      IS_PRIVATE(d_backing_inode(new_dentry)))))
+		      IS_PRIVATE(d_inode(new_dentry)))))
 		return 0;
 
 	if (flags & RENAME_EXCHANGE) {
@@ -2066,7 +2066,7 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
  */
 int security_inode_readlink(struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	return call_int_hook(inode_readlink, 0, dentry);
 }
@@ -2129,7 +2129,7 @@ int security_inode_setattr(struct mnt_idmap *idmap,
 {
 	int ret;
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	ret = call_int_hook(inode_setattr, 0, dentry, attr);
 	if (ret)
@@ -2148,7 +2148,7 @@ EXPORT_SYMBOL_GPL(security_inode_setattr);
  */
 int security_inode_getattr(const struct path *path)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(path->dentry))))
 		return 0;
 	return call_int_hook(inode_getattr, 0, path);
 }
@@ -2172,7 +2172,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 {
 	int ret;
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	/*
 	 * SELinux and Smack integrate the cap call,
@@ -2209,7 +2209,7 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 {
 	int ret;
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
 			    kacl);
@@ -2235,7 +2235,7 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 int security_inode_get_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	return call_int_hook(inode_get_acl, 0, idmap, dentry, acl_name);
 }
@@ -2256,7 +2256,7 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
 {
 	int ret;
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
 	if (ret)
@@ -2280,7 +2280,7 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return;
 	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
 	evm_inode_post_setxattr(dentry, name, value, size);
@@ -2298,7 +2298,7 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
  */
 int security_inode_getxattr(struct dentry *dentry, const char *name)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	return call_int_hook(inode_getxattr, 0, dentry, name);
 }
@@ -2314,7 +2314,7 @@ int security_inode_getxattr(struct dentry *dentry, const char *name)
  */
 int security_inode_listxattr(struct dentry *dentry)
 {
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	return call_int_hook(inode_listxattr, 0, dentry);
 }
@@ -2335,7 +2335,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
 {
 	int ret;
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 	/*
 	 * SELinux and Smack integrate the cap call,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2aa0e219d721..320d8d5ddcbe 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -321,7 +321,7 @@ static struct inode_security_struct *inode_security(struct inode *inode)
 
 static struct inode_security_struct *backing_inode_security_novalidate(struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 
 	return selinux_inode(inode);
 }
@@ -331,7 +331,7 @@ static struct inode_security_struct *backing_inode_security_novalidate(struct de
  */
 static struct inode_security_struct *backing_inode_security(struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 
 	__inode_security_revalidate(inode, dentry, true);
 	return selinux_inode(inode);
@@ -497,7 +497,7 @@ static int sb_check_xattr_support(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	struct dentry *root = sb->s_root;
-	struct inode *root_inode = d_backing_inode(root);
+	struct inode *root_inode = d_inode(root);
 	u32 sid;
 	int rc;
 
@@ -546,7 +546,7 @@ static int sb_finish_set_opts(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	struct dentry *root = sb->s_root;
-	struct inode *root_inode = d_backing_inode(root);
+	struct inode *root_inode = d_inode(root);
 	int rc = 0;
 
 	if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
@@ -1678,7 +1678,7 @@ static inline int dentry_has_perm(const struct cred *cred,
 				  struct dentry *dentry,
 				  u32 av)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct common_audit_data ad;
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
@@ -1694,7 +1694,7 @@ static inline int path_has_perm(const struct cred *cred,
 				const struct path *path,
 				u32 av)
 {
-	struct inode *inode = d_backing_inode(path->dentry);
+	struct inode *inode = d_inode(path->dentry);
 	struct common_audit_data ad;
 
 	ad.type = LSM_AUDIT_DATA_PATH;
@@ -2079,7 +2079,7 @@ static int selinux_binder_transfer_file(const struct cred *from,
 		return rc;
 #endif
 
-	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+	if (unlikely(IS_PRIVATE(d_inode(dentry))))
 		return 0;
 
 	isec = backing_inode_security(dentry);
@@ -3130,7 +3130,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 {
 	const struct cred *cred = current_cred();
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid = iattr->ia_valid;
 	__u32 av = FILE__WRITE;
 
@@ -3176,7 +3176,7 @@ static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 				  struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct inode_security_struct *isec;
 	struct superblock_security_struct *sbsec;
 	struct common_audit_data ad;
@@ -3287,7 +3287,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 					const void *value, size_t size,
 					int flags)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct inode *inode = d_inode(dentry);
 	struct inode_security_struct *isec;
 	u32 newsid;
 	int rc;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 65130a791f57..207a9f74162f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -798,7 +798,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 		unsigned long *set_kern_flags)
 {
 	struct dentry *root = sb->s_root;
-	struct inode *inode = d_backing_inode(root);
+	struct inode *inode = d_inode(root);
 	struct superblock_smack *sp = smack_superblock(sb);
 	struct inode_smack *isp;
 	struct smack_known *skp;
@@ -1072,15 +1072,15 @@ static int smack_inode_link(struct dentry *old_dentry, struct inode *dir,
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, old_dentry);
 
-	isp = smk_of_inode(d_backing_inode(old_dentry));
+	isp = smk_of_inode(d_inode(old_dentry));
 	rc = smk_curacc(isp, MAY_WRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(old_dentry), MAY_WRITE, rc);
+	rc = smk_bu_inode(d_inode(old_dentry), MAY_WRITE, rc);
 
 	if (rc == 0 && d_is_positive(new_dentry)) {
-		isp = smk_of_inode(d_backing_inode(new_dentry));
+		isp = smk_of_inode(d_inode(new_dentry));
 		smk_ad_setfield_u_fs_path_dentry(&ad, new_dentry);
 		rc = smk_curacc(isp, MAY_WRITE, &ad);
-		rc = smk_bu_inode(d_backing_inode(new_dentry), MAY_WRITE, rc);
+		rc = smk_bu_inode(d_inode(new_dentry), MAY_WRITE, rc);
 	}
 
 	return rc;
@@ -1096,7 +1096,7 @@ static int smack_inode_link(struct dentry *old_dentry, struct inode *dir,
  */
 static int smack_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct inode *ip = d_backing_inode(dentry);
+	struct inode *ip = d_inode(dentry);
 	struct smk_audit_info ad;
 	int rc;
 
@@ -1139,8 +1139,8 @@ static int smack_inode_rmdir(struct inode *dir, struct dentry *dentry)
 	/*
 	 * You need write access to the thing you're removing
 	 */
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+	rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_WRITE, &ad);
+	rc = smk_bu_inode(d_inode(dentry), MAY_WRITE, rc);
 	if (rc == 0) {
 		/*
 		 * You also need write access to the containing directory
@@ -1178,15 +1178,15 @@ static int smack_inode_rename(struct inode *old_inode,
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, old_dentry);
 
-	isp = smk_of_inode(d_backing_inode(old_dentry));
+	isp = smk_of_inode(d_inode(old_dentry));
 	rc = smk_curacc(isp, MAY_READWRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(old_dentry), MAY_READWRITE, rc);
+	rc = smk_bu_inode(d_inode(old_dentry), MAY_READWRITE, rc);
 
 	if (rc == 0 && d_is_positive(new_dentry)) {
-		isp = smk_of_inode(d_backing_inode(new_dentry));
+		isp = smk_of_inode(d_inode(new_dentry));
 		smk_ad_setfield_u_fs_path_dentry(&ad, new_dentry);
 		rc = smk_curacc(isp, MAY_READWRITE, &ad);
-		rc = smk_bu_inode(d_backing_inode(new_dentry), MAY_READWRITE, rc);
+		rc = smk_bu_inode(d_inode(new_dentry), MAY_READWRITE, rc);
 	}
 	return rc;
 }
@@ -1249,8 +1249,8 @@ static int smack_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+	rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_WRITE, &ad);
+	rc = smk_bu_inode(d_inode(dentry), MAY_WRITE, rc);
 	return rc;
 }
 
@@ -1263,7 +1263,7 @@ static int smack_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 static int smack_inode_getattr(const struct path *path)
 {
 	struct smk_audit_info ad;
-	struct inode *inode = d_backing_inode(path->dentry);
+	struct inode *inode = d_inode(path->dentry);
 	int rc;
 
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
@@ -1334,8 +1334,8 @@ static int smack_inode_setxattr(struct mnt_idmap *idmap,
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
 	if (rc == 0) {
-		rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
-		rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+		rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_WRITE, &ad);
+		rc = smk_bu_inode(d_inode(dentry), MAY_WRITE, rc);
 	}
 
 	return rc;
@@ -1356,7 +1356,7 @@ static void smack_inode_post_setxattr(struct dentry *dentry, const char *name,
 				      const void *value, size_t size, int flags)
 {
 	struct smack_known *skp;
-	struct inode_smack *isp = smack_inode(d_backing_inode(dentry));
+	struct inode_smack *isp = smack_inode(d_inode(dentry));
 
 	if (strcmp(name, XATTR_NAME_SMACKTRANSMUTE) == 0) {
 		isp->smk_flags |= SMK_INODE_TRANSMUTE;
@@ -1395,8 +1395,8 @@ static int smack_inode_getxattr(struct dentry *dentry, const char *name)
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_READ, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_READ, rc);
+	rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_READ, &ad);
+	rc = smk_bu_inode(d_inode(dentry), MAY_READ, rc);
 	return rc;
 }
 
@@ -1434,12 +1434,12 @@ static int smack_inode_removexattr(struct mnt_idmap *idmap,
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+	rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_WRITE, &ad);
+	rc = smk_bu_inode(d_inode(dentry), MAY_WRITE, rc);
 	if (rc != 0)
 		return rc;
 
-	isp = smack_inode(d_backing_inode(dentry));
+	isp = smack_inode(d_inode(dentry));
 	/*
 	 * Don't do anything special for these.
 	 *	XATTR_NAME_SMACKIPIN
@@ -1479,8 +1479,8 @@ static int smack_inode_set_acl(struct mnt_idmap *idmap,
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+	rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_WRITE, &ad);
+	rc = smk_bu_inode(d_inode(dentry), MAY_WRITE, rc);
 	return rc;
 }
 
@@ -1501,8 +1501,8 @@ static int smack_inode_get_acl(struct mnt_idmap *idmap,
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_READ, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_READ, rc);
+	rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_READ, &ad);
+	rc = smk_bu_inode(d_inode(dentry), MAY_READ, rc);
 	return rc;
 }
 
@@ -1523,8 +1523,8 @@ static int smack_inode_remove_acl(struct mnt_idmap *idmap,
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
 	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
 
-	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
-	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+	rc = smk_curacc(smk_of_inode(d_inode(dentry)), MAY_WRITE, &ad);
+	rc = smk_bu_inode(d_inode(dentry), MAY_WRITE, rc);
 	return rc;
 }
 
diff --git a/security/tomoyo/condition.c b/security/tomoyo/condition.c
index f8bcc083bb0d..c7e1bfd3ef72 100644
--- a/security/tomoyo/condition.c
+++ b/security/tomoyo/condition.c
@@ -735,7 +735,7 @@ void tomoyo_get_attributes(struct tomoyo_obj_info *obj)
 			dentry = dget_parent(dentry);
 			break;
 		}
-		inode = d_backing_inode(dentry);
+		inode = d_inode(dentry);
 		if (inode) {
 			struct tomoyo_mini_stat *stat = &obj->stat[i];
 
diff --git a/security/tomoyo/realpath.c b/security/tomoyo/realpath.c
index 1c483ee7f93d..e4eda5a4df4f 100644
--- a/security/tomoyo/realpath.c
+++ b/security/tomoyo/realpath.c
@@ -100,7 +100,7 @@ static char *tomoyo_get_absolute_path(const struct path *path, char * const buff
 		/* go to whatever namespace root we are under */
 		pos = d_absolute_path(path, buffer, buflen - 1);
 		if (!IS_ERR(pos) && *pos == '/' && pos[1]) {
-			struct inode *inode = d_backing_inode(path->dentry);
+			struct inode *inode = d_inode(path->dentry);
 
 			if (inode && S_ISDIR(inode->i_mode)) {
 				buffer[buflen - 2] = '/';
@@ -130,7 +130,7 @@ static char *tomoyo_get_dentry_path(struct dentry *dentry, char * const buffer,
 	if (buflen >= 256) {
 		pos = dentry_path_raw(dentry, buffer, buflen - 1);
 		if (!IS_ERR(pos) && *pos == '/' && pos[1]) {
-			struct inode *inode = d_backing_inode(dentry);
+			struct inode *inode = d_inode(dentry);
 
 			if (inode && S_ISDIR(inode->i_mode)) {
 				buffer[buflen - 2] = '/';
@@ -177,7 +177,7 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
 	if (!MAJOR(sb->s_dev))
 		goto prepend_filesystem_name;
 	{
-		struct inode *inode = d_backing_inode(sb->s_root);
+		struct inode *inode = d_inode(sb->s_root);
 
 		/*
 		 * Use filesystem name if filesystem does not support rename()
@@ -258,7 +258,7 @@ char *tomoyo_realpath_from_path(const struct path *path)
 			pos = dentry->d_op->d_dname(dentry, buf, buf_len - 1);
 			goto encode;
 		}
-		inode = d_backing_inode(sb->s_root);
+		inode = d_inode(sb->s_root);
 		/*
 		 * Get local name for filesystems without rename() operation
 		 */
-- 
2.25.1

