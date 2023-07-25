Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D23976247D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGYVa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjGYVay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:30:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D751FF3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:30:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c6dd0e46a52so6962779276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690320631; x=1690925431;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GoW/C8aSJ3QQrkmqfHfVg+NzCxclYb36S5Qex51L2m8=;
        b=ESuAjcXvPKDAPkXfAPbCxYH4XXZyFMjfmIT2iJLnM+9cHFTi65kBsURkx+3Svvr9hX
         rm54DotQjycKTAobt3wv+ewCLhUdsVBKKyfxnSehIWTxV8Y/w6e7qHmajWsI/qECWmXX
         ogU4+Vh46lSjS3HpJNMGPP06zq7zIfQcz47WB9UHD1/WDhE2r//5wdZWZMOD+huSkv9t
         uX/Rpu7KiS9cd6+wUKXk85SJgG5y9GrKMRqUgK0w6gL5dNP2K9atKl/VZtuce1F1fW67
         cra2P5O8NFBHttbgeulR0sFDh73uaRkyt4biFp58+kGzaa8dueyHSw/CC4WF2+xa4xmt
         Yveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320631; x=1690925431;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GoW/C8aSJ3QQrkmqfHfVg+NzCxclYb36S5Qex51L2m8=;
        b=asmKQgvT5pqFm7g/DS2Wc87QPb5ME5Kwsjq/S3sec0C0OuIECNecaxEd8AWFqS4tVC
         GY9vHkFQ28bXF2y5sI9LYVAlzkG9sx2tLmvVGwHDTVrTL25a7EUaUbk3mCaWfv8mk3Ae
         X2NLUcDGQxI1WXXVtWgZBxMVh6UY1ORK7SGkIW/3/2xboAd2hFAfFZOBDK1Wr7lYEpBM
         bOHAXZvxaBdrhCzVBb+iAYeGWuDY1uta+GpMFasnTsSdMtSkrGXn+by1ibyrt8QQd5sF
         xMya1fiVj/qIyey4ukRdtU2Uqveq8Uw0oF0TPApsU59V2vAcvX6kMtEXiez6pPNOGiXR
         nPoQ==
X-Gm-Message-State: ABy/qLZUkfGi6fAW0sBoH9m0t8ijkvtzvwUTk8zvC+Yz10mEp1dH2VU9
        +54UKRH/euCTKASrAYDCzHbrx3IT57g3miRPvA==
X-Google-Smtp-Source: APBJJlGqomrned2wYkoaur5RFhS7CV4paRUsHNlL3694ThxKZGEI9aKqwnU+HHU/3ggpbcxbivHkGoejJg8Jy6Omaw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:41c6:0:b0:c41:4696:e879 with SMTP
 id o189-20020a2541c6000000b00c414696e879mr1597yba.7.1690320631474; Tue, 25
 Jul 2023 14:30:31 -0700 (PDT)
Date:   Tue, 25 Jul 2023 21:30:30 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPU+wGQC/x2NwQrCQAxEf6XkbCCNrYK/Ih6W3bTm4G5JSlFK/
 93obR7zmNnBxVQcbt0OJpu6thrQnzrIz1RnQS3BwMRnuvKIk2OzXxHB5NU2wSKLSU6rFPTVal4 +mITKQD0PFyaIrRAmff9/7o/j+AKfNP7pdwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690320630; l=7117;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=0SMB6DTx+0q+5lciS4yG3pu3QkL+z7NPvMNIsnfCNvc=; b=AsQBnHXkJkxz4+Ur4UY9naiZzkdRtsO+G8zrcD2kE92cyQvVsnIlzwhFhfPwPSUyz7bE6kL44
 J2QmpuQq/sCDJUUYEeC5DVPnrqRgSgtsHElF9wJcnKH+cDEa1tlqy5K
X-Mailer: b4 0.12.3
Message-ID: <20230725-fs-orangefs-remove-deprecated-strncpy-v1-1-f15f635cf820@google.com>
Subject: [PATCH] orangefs: replace strncpy with strscpy
From:   justinstitt@google.com
To:     Justin Stitt <justinstitt@google.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aims to eliminate `strncpy` usage across the orangefs
tree.

`strncpy` is deprecated for use on NUL-terminated destination strings
[1].

A suitable replacement is `strscpy` [2].

Using the `strscpy` api over `strncpy` has a slight wrinkle in the use
cases presented within orangefs. There is frequent usage of `...LEN - 1`
which is no longer required since `strscpy` will guarantee
NUL-termination on its `dest` argument. As per `strscpy`s implementation
in `linux/lib/string.c`

|       /* Hit buffer length without finding a NUL; force NUL-termination. */
|       if (res)
|               dest[res-1] = '\0';

There are some hopes that someday the `strncpy` api could be ripped out
due to the vast number of suitable replacements (strscpy, strscpy_pad,
strtomem, strtomem_pad, strlcpy) [1].

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

---


Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 fs/orangefs/dcache.c |  4 ++--
 fs/orangefs/namei.c  | 30 +++++++++++++++---------------
 fs/orangefs/super.c  | 14 +++++++-------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/orangefs/dcache.c b/fs/orangefs/dcache.c
index 8bbe9486e3a6..96ed9900f7a9 100644
--- a/fs/orangefs/dcache.c
+++ b/fs/orangefs/dcache.c
@@ -33,9 +33,9 @@ static int orangefs_revalidate_lookup(struct dentry *dentry)
 
 	new_op->upcall.req.lookup.sym_follow = ORANGEFS_LOOKUP_LINK_NO_FOLLOW;
 	new_op->upcall.req.lookup.parent_refn = parent->refn;
-	strncpy(new_op->upcall.req.lookup.d_name,
+	strscpy(new_op->upcall.req.lookup.d_name,
 		dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
+		ORANGEFS_NAME_MAX);
 
 	gossip_debug(GOSSIP_DCACHE_DEBUG,
 		     "%s:%s:%d interrupt flag [%d]\n",
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 77518e248cf7..503d07769bb4 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -41,8 +41,8 @@ static int orangefs_create(struct mnt_idmap *idmap,
 	fill_default_sys_attrs(new_op->upcall.req.create.attributes,
 			       ORANGEFS_TYPE_METAFILE, mode);
 
-	strncpy(new_op->upcall.req.create.d_name,
-		dentry->d_name.name, ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.create.d_name,
+		dentry->d_name.name, ORANGEFS_NAME_MAX);
 
 	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
 
@@ -137,8 +137,8 @@ static struct dentry *orangefs_lookup(struct inode *dir, struct dentry *dentry,
 		     &parent->refn.khandle);
 	new_op->upcall.req.lookup.parent_refn = parent->refn;
 
-	strncpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name,
+		ORANGEFS_NAME_MAX);
 
 	gossip_debug(GOSSIP_NAME_DEBUG,
 		     "%s: doing lookup on %s under %pU,%d\n",
@@ -192,8 +192,8 @@ static int orangefs_unlink(struct inode *dir, struct dentry *dentry)
 		return -ENOMEM;
 
 	new_op->upcall.req.remove.parent_refn = parent->refn;
-	strncpy(new_op->upcall.req.remove.d_name, dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.remove.d_name, dentry->d_name.name,
+		ORANGEFS_NAME_MAX);
 
 	ret = service_operation(new_op, "orangefs_unlink",
 				get_interruptible_flag(inode));
@@ -247,10 +247,10 @@ static int orangefs_symlink(struct mnt_idmap *idmap,
 			       ORANGEFS_TYPE_SYMLINK,
 			       mode);
 
-	strncpy(new_op->upcall.req.sym.entry_name,
+	strscpy(new_op->upcall.req.sym.entry_name,
 		dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
-	strncpy(new_op->upcall.req.sym.target, symname, ORANGEFS_NAME_MAX - 1);
+		ORANGEFS_NAME_MAX);
+	strscpy(new_op->upcall.req.sym.target, symname, ORANGEFS_NAME_MAX);
 
 	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
 
@@ -324,8 +324,8 @@ static int orangefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	fill_default_sys_attrs(new_op->upcall.req.mkdir.attributes,
 			      ORANGEFS_TYPE_DIRECTORY, mode);
 
-	strncpy(new_op->upcall.req.mkdir.d_name,
-		dentry->d_name.name, ORANGEFS_NAME_MAX - 1);
+	strscpy(new_op->upcall.req.mkdir.d_name,
+		dentry->d_name.name, ORANGEFS_NAME_MAX);
 
 	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
 
@@ -405,12 +405,12 @@ static int orangefs_rename(struct mnt_idmap *idmap,
 	new_op->upcall.req.rename.old_parent_refn = ORANGEFS_I(old_dir)->refn;
 	new_op->upcall.req.rename.new_parent_refn = ORANGEFS_I(new_dir)->refn;
 
-	strncpy(new_op->upcall.req.rename.d_old_name,
+	strscpy(new_op->upcall.req.rename.d_old_name,
 		old_dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
-	strncpy(new_op->upcall.req.rename.d_new_name,
+		ORANGEFS_NAME_MAX);
+	strscpy(new_op->upcall.req.rename.d_new_name,
 		new_dentry->d_name.name,
-		ORANGEFS_NAME_MAX - 1);
+		ORANGEFS_NAME_MAX);
 
 	ret = service_operation(new_op,
 				"orangefs_rename",
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 5254256a224d..b4af98b5a216 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -253,7 +253,7 @@ int orangefs_remount(struct orangefs_sb_info_s *orangefs_sb)
 	new_op = op_alloc(ORANGEFS_VFS_OP_FS_MOUNT);
 	if (!new_op)
 		return -ENOMEM;
-	strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
+	strscpy(new_op->upcall.req.fs_mount.orangefs_config_server,
 		orangefs_sb->devname,
 		ORANGEFS_MAX_SERVER_ADDR_LEN);
 
@@ -400,8 +400,8 @@ static int orangefs_unmount(int id, __s32 fs_id, const char *devname)
 		return -ENOMEM;
 	op->upcall.req.fs_umount.id = id;
 	op->upcall.req.fs_umount.fs_id = fs_id;
-	strncpy(op->upcall.req.fs_umount.orangefs_config_server,
-	    devname, ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
+	strscpy(op->upcall.req.fs_umount.orangefs_config_server,
+	    devname, ORANGEFS_MAX_SERVER_ADDR_LEN);
 	r = service_operation(op, "orangefs_fs_umount", 0);
 	/* Not much to do about an error here. */
 	if (r)
@@ -494,9 +494,9 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 	if (!new_op)
 		return ERR_PTR(-ENOMEM);
 
-	strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
+	strscpy(new_op->upcall.req.fs_mount.orangefs_config_server,
 		devname,
-		ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
+		ORANGEFS_MAX_SERVER_ADDR_LEN);
 
 	gossip_debug(GOSSIP_SUPER_DEBUG,
 		     "Attempting ORANGEFS Mount via host %s\n",
@@ -543,9 +543,9 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 	 * on successful mount, store the devname and data
 	 * used
 	 */
-	strncpy(ORANGEFS_SB(sb)->devname,
+	strscpy(ORANGEFS_SB(sb)->devname,
 		devname,
-		ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
+		ORANGEFS_MAX_SERVER_ADDR_LEN);
 
 	/* mount_pending must be cleared */
 	ORANGEFS_SB(sb)->mount_pending = 0;

---
base-commit: 0b5547c51827e053cc754db47d3ec3e6c2c451d2
change-id: 20230725-fs-orangefs-remove-deprecated-strncpy-ae0d40124620

Best regards,
-- 
Justin Stitt <justinstitt@google.com>

