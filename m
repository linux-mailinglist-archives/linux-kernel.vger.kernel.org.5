Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD877850C2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjHWGov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjHWGot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:44:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E5AE46;
        Tue, 22 Aug 2023 23:44:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fee51329feso23372295e9.0;
        Tue, 22 Aug 2023 23:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692773086; x=1693377886;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2h2lr/08wRAzvYuPaGRiGBkl2WzgYmq6pFayFTNRKXs=;
        b=YCldIJYGiowEN1ktPV0XNIzDcd4QvmSOQP43EDDuQz5EJcI27ScKX0sJk8mkMZv7l8
         KfvN+qRVpTS36FwOf1fcDDj/H6iCC7tOuzPf9fh6OPzGwZk3ND3HvcHGkORrlBrfgGaT
         lFuJvs4QChAVXHsyFTegfnBxBie1JIpXHRnxLuuvLo4xUEFEqaQ2QYwpJuuxJshK2VtG
         Zg9GhkRxwsCDJAK3KmsT4nZST3UlHMdDHAaJJrIkxO7uKADgBdUgCEocTuQcTfl+rs8H
         7fciZXWrYJEm90Q0kPMyFJtx4OjmA6Xv75Q+4ZqAY5mkspFCMXcM5K0DjA67myDUu2km
         SSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692773086; x=1693377886;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2h2lr/08wRAzvYuPaGRiGBkl2WzgYmq6pFayFTNRKXs=;
        b=gNRh2/d35ela9b4eAVzJBEQJiSwL+SbkuzX1tm1uNnroWwgv7x5mQuALchtulBBGnr
         rGirMnuYC1PnlJxl4xWqqkbexnVZzCkEql4jW28yqt16MrmrVNFt8eVIdlGW+XCuL54h
         TROuPbBO47WC9imyr+3IWw8WU/5ZfBZ4VNuxKSFOdFEieVbEvxODdmZc++fQb354SJx8
         4HifWwVaUbmyHfomsJeF1bm/TCpY4IpT6FzgFS84l2HOgB8uJl7Y6Ai7QepkU1jwFv0U
         WlfJiyfbvLClfY84SOjxgiHSraHh4eYzoZvXF+NTFPtreqT/yK6ZCPpi3plsSCI+94V6
         rsfw==
X-Gm-Message-State: AOJu0Yx98OqzTM5f74YUhygIYL1AHw4kCkDctb8kfOBhm7wYik0HKxiA
        CaKu+DU3CvjXZ801NgOZIJOPkQEhdyV7tYcLWAY=
X-Google-Smtp-Source: AGHT+IENrgjkvPL+4cUPqfqOAcYackdWmRWn5U+gHOvzc0QIp12DaxuLFMaNdpqyelGUnj7lCnMVHg==
X-Received: by 2002:a05:600c:448a:b0:3fa:955a:9291 with SMTP id e10-20020a05600c448a00b003fa955a9291mr8953524wmo.9.1692773085945;
        Tue, 22 Aug 2023 23:44:45 -0700 (PDT)
Received: from khadija-virtual-machine ([124.29.208.67])
        by smtp.gmail.com with ESMTPSA id p21-20020a1c7415000000b003feef5b0baesm9801527wmc.26.2023.08.22.23.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 23:44:45 -0700 (PDT)
Date:   Wed, 23 Aug 2023 11:44:41 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Subject: [PATCH] lsm: constify 'sb' parameter in security_quotactl()
Message-ID: <ZOWq2d5c7MpLl5A4@gmail.com>
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

SELinux registers the implementation for the "quotactl" hook. Looking at
the function implementation we observe that the parameter "sb" is not
changing.

Mark the "sb" parameter of LSM hook security_quotactl() as "const" since
it will not be changing in the LSM hook.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/security.h      | 4 ++--
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6bb55e61e8e8..b63672ef6f11 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -43,7 +43,7 @@ LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
 	 const kernel_cap_t *permitted)
 LSM_HOOK(int, 0, capable, const struct cred *cred, struct user_namespace *ns,
 	 int cap, unsigned int opts)
-LSM_HOOK(int, 0, quotactl, int cmds, int type, int id, struct super_block *sb)
+LSM_HOOK(int, 0, quotactl, int cmds, int type, int id, const struct super_block *sb)
 LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
 LSM_HOOK(int, 0, syslog, int type)
 LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
diff --git a/include/linux/security.h b/include/linux/security.h
index e2734e9e44d5..b4d1e160bd76 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -283,7 +283,7 @@ int security_capable(const struct cred *cred,
 		       struct user_namespace *ns,
 		       int cap,
 		       unsigned int opts);
-int security_quotactl(int cmds, int type, int id, struct super_block *sb);
+int security_quotactl(int cmds, int type, int id, const struct super_block *sb);
 int security_quota_on(struct dentry *dentry);
 int security_syslog(int type);
 int security_settime64(const struct timespec64 *ts, const struct timezone *tz);
@@ -579,7 +579,7 @@ static inline int security_capable(const struct cred *cred,
 }
 
 static inline int security_quotactl(int cmds, int type, int id,
-				     struct super_block *sb)
+				     const struct super_block *sb)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index d5ff7ff45b77..1844b8ab3317 100644
--- a/security/security.c
+++ b/security/security.c
@@ -956,7 +956,7 @@ int security_capable(const struct cred *cred,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_quotactl(int cmds, int type, int id, struct super_block *sb)
+int security_quotactl(int cmds, int type, int id, const struct super_block *sb)
 {
 	return call_int_hook(quotactl, 0, cmds, type, id, sb);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79b4890e9936..8d4611ac5ec3 100644
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
@@ -2088,7 +2088,7 @@ static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
 	return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
 }
 
-static int selinux_quotactl(int cmds, int type, int id, struct super_block *sb)
+static int selinux_quotactl(int cmds, int type, int id, const struct super_block *sb)
 {
 	const struct cred *cred = current_cred();
 	int rc = 0;
-- 
2.34.1

