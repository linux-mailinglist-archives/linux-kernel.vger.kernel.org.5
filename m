Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D5F78535E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjHWJBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbjHWIzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:55:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5F2268B;
        Wed, 23 Aug 2023 01:44:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fef2f05356so25303765e9.0;
        Wed, 23 Aug 2023 01:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692780290; x=1693385090;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qDc8l3Yzp5tDJpEn7LMGbnQ8OZ73E/PvsDzFi6JBRGg=;
        b=k3GQIgBx9xjTNWfWp3bav2qDM5n05bOba37PlEh2emOGBOH6FGbk4Qn43bxkihGE7E
         0kzcUU1LwesF6z+9vFDwJzDMWvvxHIOgOpexPqA0O1YTZ0L7KaHeTlLyCDUbebiAHE65
         61uiKpQiDqecRF5lMs32YK2/Tha0SmXpRiXbYwdaJDOz6G2/0al7Xq//czGJj8IsZkSQ
         KEFZcvHTrzqC5qx6OkRkhnS/lQ67kywVMQK38vnYGPbyhQPsI8pLYpdxzYLmWgHm5FLC
         UbqeSGWqNku0Cv6E/9T1zTD14SpoCFH76u3pLhUw87UUhdcFYlgKmFO9T7tMrht7SvKb
         mneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780290; x=1693385090;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDc8l3Yzp5tDJpEn7LMGbnQ8OZ73E/PvsDzFi6JBRGg=;
        b=I+UtRvcN1W0h3Dzw/OFSFgIhHBxlnwmcSHVkFOAM021bGseMD+UwOqp2f10j3HBr64
         LJASknLWc+/mbfK/GrH+I3bBqmxovVvdLWbW8P3TdqOTALX9KEnPBPYELQ8bU1Tuk1l4
         78CwLknlob+8k5lG792q5dJj88pXOJb/xO8BsWeWwYy/jtKbrLK1U9PLr8JyAfRBRKXH
         FET1IJeS+rHTu9ktHPSTu+z7VSmHDuhBORr/wqJZ10tJ1X3/Vy8YaTmv1W/nakReUiVC
         v7q7klD+FqDg3C6E9AraYssKcuaABvOantz2CVHoZAHX7Kpkafyo0R9zeor0+ooc6uSm
         pgNQ==
X-Gm-Message-State: AOJu0YyrK3Rc0CEHmm2j/hFdtOTSGXN/VXEovCfB/dEQsefcPX6+GTQD
        GQgZ3SAuIHFvZThgcMl0qJ8=
X-Google-Smtp-Source: AGHT+IEJ8b1KzeciqboA2CRFXXlm+Zx9pnOG7fxIuXsgE5Mg25Z2OiKoNgwyB/ea3FEOJ6hLGq1IDw==
X-Received: by 2002:adf:e844:0:b0:317:568d:d69a with SMTP id d4-20020adfe844000000b00317568dd69amr9147173wrn.11.1692780289823;
        Wed, 23 Aug 2023 01:44:49 -0700 (PDT)
Received: from khadija-virtual-machine ([124.29.208.67])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d4211000000b0030ae499da59sm18067674wrq.111.2023.08.23.01.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:44:49 -0700 (PDT)
Date:   Wed, 23 Aug 2023 13:44:45 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, ztarkhani@microsoft.com,
        alison.schofield@intel.com
Subject: [PATCH] lsm: constify 'mnt_opts' parameter in
 security_free_mnt_opts()
Message-ID: <ZOXG/VVC1XRc7TtI@gmail.com>
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

The "sb_free_mnt_opts" hook has implementations registered in SELinux
and Smack. Looking at the function implementations we observe that the
"mnt_opts" parameter is not changing.

Mark the "mnt_opts" parameter of LSM hook security_free_mnt_opts() as
"const" since it will not be changing in the LSM hook.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/security.h      | 2 +-
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 2 +-
 security/smack/smack_lsm.c    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6bb55e61e8e8..7b193349db89 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -61,7 +61,7 @@ LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
 LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_delete, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
-LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
+LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, const void *mnt_opts)
 LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
 LSM_HOOK(int, 0, sb_mnt_opts_compat, struct super_block *sb, void *mnt_opts)
 LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
diff --git a/include/linux/security.h b/include/linux/security.h
index e2734e9e44d5..acdd1eccf2d3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -298,7 +298,7 @@ int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *
 int security_sb_alloc(struct super_block *sb);
 void security_sb_delete(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
-void security_free_mnt_opts(void **mnt_opts);
+void security_free_mnt_opts(const void **mnt_opts);
 int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
 int security_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts);
 int security_sb_remount(struct super_block *sb, void *mnt_opts);
diff --git a/security/security.c b/security/security.c
index d5ff7ff45b77..8386d764d9fc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1238,7 +1238,7 @@ void security_sb_free(struct super_block *sb)
  *
  * Free memory associated with @mnt_ops.
  */
-void security_free_mnt_opts(void **mnt_opts)
+void security_free_mnt_opts(const void **mnt_opts)
 {
 	if (!*mnt_opts)
 		return;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79b4890e9936..225b76839c95 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -342,7 +342,7 @@ struct selinux_mnt_opts {
 	u32 defcontext_sid;
 };
 
-static void selinux_free_mnt_opts(void *mnt_opts)
+static void selinux_free_mnt_opts(const void *mnt_opts)
 {
 	kfree(mnt_opts);
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7a3e9ab137d8..290593dcd852 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -557,7 +557,7 @@ struct smack_mnt_opts {
 	const char *fstransmute;
 };
 
-static void smack_free_mnt_opts(void *mnt_opts)
+static void smack_free_mnt_opts(const void *mnt_opts)
 {
 	kfree(mnt_opts);
 }
-- 
2.34.1

