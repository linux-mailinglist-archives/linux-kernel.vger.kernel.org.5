Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED2878535C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjHWJA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjHWIxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:53:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BA91FC7;
        Wed, 23 Aug 2023 01:51:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fee769fd53so35409245e9.1;
        Wed, 23 Aug 2023 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692780691; x=1693385491;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ins+aoeevfrM2N2uoE9dDFUb3W9Apm1jV2A2ukI9V7k=;
        b=VnnN3tXNhHVy13DfPC8w0dVEHWthUl+TZ5KVVHf0FH+DYTW3ojh9VFxziBUwwRdYoc
         v/cepRcg7sltX7lBpWX24ElHh82pko9ohWyeI2InAQPIBYaXUNET//I5f6owF9aaK8xB
         /hjMvCodvInK7XX5VyvyfSDjXNGysKY0fxx28u1FC4uFACCyLA5Jn38yw/NZgtGWFNnx
         X1gEDdBDoASiGDllmm2BlSiFKImnupUTDUgO+pGKkgMI45SBwbk6W0Lnytd92X178ORb
         pt2FjzCBnCW/7qlbORDVlwCg5ASy0tsJbmJHtRhulvYQYvrp/WZBRJ94PsxiUHzL9i6Y
         RXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780691; x=1693385491;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ins+aoeevfrM2N2uoE9dDFUb3W9Apm1jV2A2ukI9V7k=;
        b=PdcuMqNg19GMwNxZYzDlUUYWJdM26Xj+2I9ZiwheLAl3OQ+IPRd5rNPW/AgzUVY0lZ
         wAp8yo8NEFJlwi7QRSMaBpL3b2QhTyFahNABM5fazwHQsK2VEoWBclblWybyDWMPq18H
         WGo2zXlQl8klZM0et+uaTWvdenhAqeECMkgoRbhmM7pukcy1eVwlPStWYa+bZuHAGXC0
         UlUthGHMlewK3GFJJqut0uhDiPnbVLwlCt8LDDkLbuLZI68czIPpE5X5vkPi45EfV7Hl
         s4/lgn+1JTAY6GdRswxXRSrOVeCgggt88OpUphwHvvlbMVwjRY/XhTrX+N5R4Kz9+ZHc
         RvyQ==
X-Gm-Message-State: AOJu0YwUFyqntzSvAYMfLzBQIsXvmWd7JeF5xPbOUa4mhtAyavA4ac1T
        mh20LhAcQmctfsn9tT5NHJM=
X-Google-Smtp-Source: AGHT+IG/PyFTUsbBdpcSGxfFT+5psF/daoSgA9PzozLbcDrQimZJPzkouWAil7uNGbS/GVJfy1MduA==
X-Received: by 2002:a05:600c:3799:b0:3fe:5053:1a0b with SMTP id o25-20020a05600c379900b003fe50531a0bmr10090752wmr.11.1692780690674;
        Wed, 23 Aug 2023 01:51:30 -0700 (PDT)
Received: from khadija-virtual-machine ([124.29.208.67])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c22d500b003fee777fd84sm13169744wmg.41.2023.08.23.01.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:51:30 -0700 (PDT)
Date:   Wed, 23 Aug 2023 13:51:27 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Subject: [PATCH] lsm: constify 'sb' parameter in security_sb_remount()
Message-ID: <ZOXIjzLnnbuoLOrF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "sb_remount" hook has implementations registered in SELinux and
Landlock. Looking at the function implementations we observe that the
"sb" parameter is not changing.

Mark the "sb" parameter of LSM hook security_sb_remount() as "const"
since it will not be changing in the LSM hook.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/security.h      | 2 +-
 security/landlock/fs.c        | 2 +-
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6bb55e61e8e8..dca689c9ac04 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -64,7 +64,7 @@ LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
 LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
 LSM_HOOK(int, 0, sb_mnt_opts_compat, struct super_block *sb, void *mnt_opts)
-LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
+LSM_HOOK(int, 0, sb_remount, const struct super_block *sb, void *mnt_opts)
 LSM_HOOK(int, 0, sb_kern_mount, struct super_block *sb)
 LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
 LSM_HOOK(int, 0, sb_statfs, struct dentry *dentry)
diff --git a/include/linux/security.h b/include/linux/security.h
index e2734e9e44d5..ce08ed7d5437 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -301,7 +301,7 @@ void security_sb_free(struct super_block *sb);
 void security_free_mnt_opts(void **mnt_opts);
 int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
 int security_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts);
-int security_sb_remount(struct super_block *sb, void *mnt_opts);
+int security_sb_remount(const struct super_block *sb, void *mnt_opts);
 int security_sb_kern_mount(struct super_block *sb);
 int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 1c0c198f6fdb..fabe324922ec 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1074,7 +1074,7 @@ static int hook_sb_umount(struct vfsmount *const mnt, const int flags)
 	return -EPERM;
 }
 
-static int hook_sb_remount(struct super_block *const sb, void *const mnt_opts)
+static int hook_sb_remount(const struct super_block *const sb, void *const mnt_opts)
 {
 	if (!landlock_get_current_domain())
 		return 0;
diff --git a/security/security.c b/security/security.c
index d5ff7ff45b77..acc8a92ba857 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1289,7 +1289,7 @@ EXPORT_SYMBOL(security_sb_mnt_opts_compat);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_sb_remount(struct super_block *sb,
+int security_sb_remount(const struct super_block *sb,
 			void *mnt_opts)
 {
 	return call_int_hook(sb_remount, 0, sb, mnt_opts);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79b4890e9936..e4de42150b87 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2628,7 +2628,7 @@ static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 	return 0;
 }
 
-static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
+static int selinux_sb_remount(const struct super_block *sb, void *mnt_opts)
 {
 	struct selinux_mnt_opts *opts = mnt_opts;
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
-- 
2.34.1

