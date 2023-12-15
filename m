Return-Path: <linux-kernel+bounces-984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C12C8148DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C7A1C238AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839B134558;
	Fri, 15 Dec 2023 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Sr2e804d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABE34557
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5B2CE3F2B4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702645777;
	bh=EhYwhx9WPqSQzkFYfTP87dU7WQuopKgMJSLCI/H3I+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=Sr2e804dZPw6S7dXfO10Co4uJp1g0vZX7DIFMqek/kQms1FY+lDujYIlHPv3acGkM
	 pWKBhgAFEaWs3X8sX4EZt/Np7niFVxfvXayuk+50oE4w14UwFeeTkaaqsH4yuLdcsk
	 zcDgvO9r2JTDxEQa1jvc4ig5xMLg3na6WaE6b3hUOhDjomcvGO9E0MsHHWDkK9w4sd
	 6tELh3nhbJEGabkrc9VZ/SbHhOFEqwOtX2Ss6Xb++ney5LQQstqFqimrRWs1kfkDyC
	 yMhMESfaGRpBxaHQGrVBfNnQLbZGmMjikYIpRb7mavC/TthsgNRSpkSOpkbXcocCoK
	 02Z5jwmZxHd+w==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1f99db3dd0so40080566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 05:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702645777; x=1703250577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhYwhx9WPqSQzkFYfTP87dU7WQuopKgMJSLCI/H3I+A=;
        b=jheGJckW9QtRwVAiP+0dsMcGtZOQVrKMatqVdUkPqgRTC294EOYC3eOKe5u4O4njYo
         f/WUJHvpP+v+PQFjfI2Nfgx1fqkg9QxQwmzy6gy2rBnAXHc2FmEs16vHRRB9NY4FN+a6
         6D548W5NSwjpGQbWuT0Tg2QwkvTufHYvxkKAfJDtOI9xMlt6IMsV2rroW6sLtVjYu5Fh
         nehkJszPucMTleFsmmK91dOyKl9IqIHpzAbfBEeFqbIFZi6oPYFnRiRTkzwk4rlaFxz2
         xoz5wh1q1TthmA3QYoyVdBiYeUchKVL4DIY4xFr1IAI50x3JlbfYSDpFBogGDjFU+tHz
         nDUQ==
X-Gm-Message-State: AOJu0YwLaCNI7n9noLw3i/TSMn7wr++Hwkn5hSwYAeK3w7istctPvaFh
	G24WOMd6gVk7evfffncp4/K1dEIeDqIEnVU7+TEtqXehscl8UQeHq+XZU2UR8id5sK3t6Woc4ON
	GvOGCU983tgMiS4a5WTnC+3ct0IYcYvVTF3Q76DDS3A==
X-Received: by 2002:a17:906:5448:b0:a19:287a:396a with SMTP id d8-20020a170906544800b00a19287a396amr5572109ejp.55.1702645777035;
        Fri, 15 Dec 2023 05:09:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPv7rt3lJwV7Mt6kQIKwyKBZKPkm1Iq7M0k8xQlTK2EHZn7S0RxToviR+OTIHcGsJtSiXCuA==
X-Received: by 2002:a17:906:5448:b0:a19:287a:396a with SMTP id d8-20020a170906544800b00a19287a396amr5572099ejp.55.1702645776636;
        Fri, 15 Dec 2023 05:09:36 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:8624:a300:ee04:15a2:3442:11ee])
        by smtp.gmail.com with ESMTPSA id tk7-20020a170907c28700b00a1d1ebc2206sm10738449ejc.72.2023.12.15.05.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:09:36 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: fix doc comment typo fs tree wide
Date: Fri, 15 Dec 2023 14:09:27 +0100
Message-Id: <20231215130927.136917-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do the replacement:
s/simply passs @nop_mnt_idmap/simply passs @nop_mnt_idmap/
in the fs/ tree.

Found by chance while working on support for idmapped mounts in fuse.

Cc: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/attr.c      |  2 +-
 fs/inode.c     |  2 +-
 fs/namei.c     | 22 +++++++++++-----------
 fs/posix_acl.c |  4 ++--
 fs/stat.c      |  2 +-
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index bdf5deb06ea9..5a13f0c8495f 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -157,7 +157,7 @@ static bool chgrp_ok(struct mnt_idmap *idmap,
  * the vfsmount must be passed through @idmap. This function will then
  * take care to map the inode according to @idmap before checking
  * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs @nop_mnt_idmap.
+ * performed on the raw inode simply pass @nop_mnt_idmap.
  *
  * Should be called as the first thing in ->setattr implementations,
  * possibly after taking additional locks.
diff --git a/fs/inode.c b/fs/inode.c
index edcd8a61975f..60d0667cbd27 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2402,7 +2402,7 @@ EXPORT_SYMBOL(inode_init_owner);
  * the vfsmount must be passed through @idmap. This function will then take
  * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs @nop_mnt_idmap.
+ * raw inode simply pass @nop_mnt_idmap.
  */
 bool inode_owner_or_capable(struct mnt_idmap *idmap,
 			    const struct inode *inode)
diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..200eb919cdc0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -289,7 +289,7 @@ EXPORT_SYMBOL(putname);
  * the vfsmount must be passed through @idmap. This function will then take
  * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs @nop_mnt_idmap.
+ * raw inode simply pass @nop_mnt_idmap.
  */
 static int check_acl(struct mnt_idmap *idmap,
 		     struct inode *inode, int mask)
@@ -334,7 +334,7 @@ static int check_acl(struct mnt_idmap *idmap,
  * the vfsmount must be passed through @idmap. This function will then take
  * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs @nop_mnt_idmap.
+ * raw inode simply pass @nop_mnt_idmap.
  */
 static int acl_permission_check(struct mnt_idmap *idmap,
 				struct inode *inode, int mask)
@@ -395,7 +395,7 @@ static int acl_permission_check(struct mnt_idmap *idmap,
  * the vfsmount must be passed through @idmap. This function will then take
  * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs @nop_mnt_idmap.
+ * raw inode simply pass @nop_mnt_idmap.
  */
 int generic_permission(struct mnt_idmap *idmap, struct inode *inode,
 		       int mask)
@@ -3158,7 +3158,7 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
  * the vfsmount must be passed through @idmap. This function will then take
  * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs @nop_mnt_idmap.
+ * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	       struct dentry *dentry, umode_t mode, bool want_excl)
@@ -3646,7 +3646,7 @@ static int do_open(struct nameidata *nd,
  * the vfsmount must be passed through @idmap. This function will then take
  * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs @nop_mnt_idmap.
+ * raw inode simply pass @nop_mnt_idmap.
  */
 static int vfs_tmpfile(struct mnt_idmap *idmap,
 		       const struct path *parentpath,
@@ -3954,7 +3954,7 @@ EXPORT_SYMBOL(user_path_create);
  * the vfsmount must be passed through @idmap. This function will then take
  * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs @nop_mnt_idmap.
+ * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	      struct dentry *dentry, umode_t mode, dev_t dev)
@@ -4080,7 +4080,7 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
  * the vfsmount must be passed through @idmap. This function will then take
  * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs @nop_mnt_idmap.
+ * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	      struct dentry *dentry, umode_t mode)
@@ -4161,7 +4161,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
  * the vfsmount must be passed through @idmap. This function will then take
  * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs @nop_mnt_idmap.
+ * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry)
@@ -4290,7 +4290,7 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
  * the vfsmount must be passed through @idmap. This function will then take
  * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs @nop_mnt_idmap.
+ * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 	       struct dentry *dentry, struct inode **delegated_inode)
@@ -4443,7 +4443,7 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
  * the vfsmount must be passed through @idmap. This function will then take
  * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs @nop_mnt_idmap.
+ * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		struct dentry *dentry, const char *oldname)
@@ -4535,7 +4535,7 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
  * the vfsmount must be passed through @idmap. This function will then take
  * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs @nop_mnt_idmap.
+ * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	     struct inode *dir, struct dentry *new_dentry,
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index a05fe94970ce..e1af20893ebe 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -600,7 +600,7 @@ EXPORT_SYMBOL(__posix_acl_chmod);
  * the vfsmount must be passed through @idmap. This function will then
  * take care to map the inode according to @idmap before checking
  * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs @nop_mnt_idmap.
+ * performed on the raw inode simply pass @nop_mnt_idmap.
  */
 int
  posix_acl_chmod(struct mnt_idmap *idmap, struct dentry *dentry,
@@ -700,7 +700,7 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
  * the vfsmount must be passed through @idmap. This function will then
  * take care to map the inode according to @idmap before checking
  * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs @nop_mnt_idmap.
+ * performed on the raw inode simply pass @nop_mnt_idmap.
  *
  * Called from set_acl inode operations.
  */
diff --git a/fs/stat.c b/fs/stat.c
index 24bb0209e459..0ab525f80a49 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -41,7 +41,7 @@
  * the vfsmount must be passed through @idmap. This function will then
  * take care to map the inode according to @idmap before filling in the
  * uid and gid filds. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs @nop_mnt_idmap.
+ * performed on the raw inode simply pass @nop_mnt_idmap.
  */
 void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 		      struct inode *inode, struct kstat *stat)
-- 
2.34.1


