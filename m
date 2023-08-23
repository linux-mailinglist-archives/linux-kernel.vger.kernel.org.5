Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D366785382
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjHWJJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjHWJHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:07:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6723C38;
        Wed, 23 Aug 2023 02:01:33 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so50769865e9.2;
        Wed, 23 Aug 2023 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692781291; x=1693386091;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLx9XDCNsbFYXBmD+uBtB7HRdyTRS+WlWpDKsyMdL1E=;
        b=DpwWqSFb0bQw+2R5W+Uew/uVxwByp+AqpC3gGsgIVhQg5c2+qq/KK8OUgCtDg7NWCq
         1yJduA40xzLq3JW3WkE2gJebJjrKhrP6r/W+veFQNFCJwOSwUPjcRCMHAtS+DERRE/BR
         eEIst91qxpgIu/0cpd7C5PqYmSSsw1Fbpsbmo3tWNDCRzdCgSMoBxYMgF7B1Lki9ehYC
         BOaFLQMjq0jTuemRiXSbkJF7fGws0ucTvbwp+fL5m3qGZTlVFck8eUIJGIBYXrE9GsHE
         8mH3hOOppj0CzpLbYZCNW7jV1tMbuNdMr079YscZ4/RaonQA+KiQ2CBVGnxMd/Ak/emv
         QVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692781291; x=1693386091;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLx9XDCNsbFYXBmD+uBtB7HRdyTRS+WlWpDKsyMdL1E=;
        b=Ib7Wcfnrr/qDkBFmv53m1CZisIyoXBcxJrAjnV+Btkw6+PCq5e7mBa3hiVAEcU0OEl
         yhl6w1D3Uvthfgy/BARy5sf8c27pQu+Y9BOl9LIW1pd4m72vWcTyOJY4VjQRQCIKhCrO
         qxL+L5HZSUQvj3SnxJMQsjr75CAAqJWuzbFu6FMZ/ATyPk1xcSWuhXNhEoW0DIJ5l2BD
         RqOKmS182kuV+c2TfLexQlCRXITrJm26X1R1Eso5QdFUP/Oj3Hb7ybbG61jcHjCiWHDO
         1Af9GVrLiB2My79EYFfzUpuaUoleFsNejlOPGmCs3uluVGCyDB3PtvW9A99vAskc6c7s
         RgtA==
X-Gm-Message-State: AOJu0Yxza/++iQPdWfdXx4qtvSxshp0dDyXEwuuHqushrE4Kt2TNnbuT
        e+IwZRuSShngTOiBc1mGHCA=
X-Google-Smtp-Source: AGHT+IGhBKF2fmiTeu/Au6Wa/EzH9tRes18Uz+k3DqagOIXozC1iGux44PZGoaHIvoa0H4+6MkuePA==
X-Received: by 2002:a7b:c7d4:0:b0:3fa:93b0:a69c with SMTP id z20-20020a7bc7d4000000b003fa93b0a69cmr9070579wmk.24.1692781291197;
        Wed, 23 Aug 2023 02:01:31 -0700 (PDT)
Received: from khadija-virtual-machine ([124.29.208.67])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d68c6000000b00317f70240afsm18541644wrw.27.2023.08.23.02.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 02:01:30 -0700 (PDT)
Date:   Wed, 23 Aug 2023 14:01:28 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Subject: [PATCH] lsm: constify 'sb' parameter in security_sb_kern_mount()
Message-ID: <ZOXK6MywWFIdUTsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "sb_kern_mount" hook has implementation registered in SELinux.
Looking at the function implementation we observe that the "sb"
parameter is not changing.

Mark the "sb" parameter of LSM hook security_sb_kern_mount() as "const"
since it will not be changing in the LSM hook.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/security.h      | 2 +-
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6bb55e61e8e8..f38491b77616 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -65,7 +65,7 @@ LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
 LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
 LSM_HOOK(int, 0, sb_mnt_opts_compat, struct super_block *sb, void *mnt_opts)
 LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
-LSM_HOOK(int, 0, sb_kern_mount, struct super_block *sb)
+LSM_HOOK(int, 0, sb_kern_mount, const struct super_block *sb)
 LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
 LSM_HOOK(int, 0, sb_statfs, struct dentry *dentry)
 LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *path,
diff --git a/include/linux/security.h b/include/linux/security.h
index e2734e9e44d5..38f3ae6f25c2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -302,7 +302,7 @@ void security_free_mnt_opts(void **mnt_opts);
 int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
 int security_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts);
 int security_sb_remount(struct super_block *sb, void *mnt_opts);
-int security_sb_kern_mount(struct super_block *sb);
+int security_sb_kern_mount(const struct super_block *sb);
 int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
 int security_sb_mount(const char *dev_name, const struct path *path,
diff --git a/security/security.c b/security/security.c
index d5ff7ff45b77..5b21b4c61acb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1304,7 +1304,7 @@ EXPORT_SYMBOL(security_sb_remount);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_sb_kern_mount(struct super_block *sb)
+int security_sb_kern_mount(const struct super_block *sb)
 {
 	return call_int_hook(sb_kern_mount, 0, sb);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79b4890e9936..2708c5b5ecd7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1886,7 +1886,7 @@ static inline int may_rename(struct inode *old_dir,
 
 /* Check whether a task can perform a filesystem operation. */
 static int superblock_has_perm(const struct cred *cred,
-			       struct super_block *sb,
+			       const struct super_block *sb,
 			       u32 perms,
 			       struct common_audit_data *ad)
 {
@@ -2670,7 +2670,7 @@ static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 	return -EINVAL;
 }
 
-static int selinux_sb_kern_mount(struct super_block *sb)
+static int selinux_sb_kern_mount(const struct super_block *sb)
 {
 	const struct cred *cred = current_cred();
 	struct common_audit_data ad;
-- 
2.34.1

