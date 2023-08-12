Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324BF77A0CF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjHLPbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHLPbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:31:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E44E54;
        Sat, 12 Aug 2023 08:31:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso25398185e9.3;
        Sat, 12 Aug 2023 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691854273; x=1692459073;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DHdR91Cr4ayDwVTatLZNJpXNEH0l3fIlA2RBT4y8Nw=;
        b=sBI47C8sROOOoOauu/0AewfZ/TtFdD7cBXumaPW16qnFg+64JOPiZ5ivUdpezCqx9T
         5G3H2rbVJ+pCmj9CJ06C49+HzudKW48Fcts9+JpKeRccd0lV8uDX2q1pytG7M7QH6MZw
         2C5WMnkEXpFWXGWQq/wLqNotYotqZyGi/760m2LTVZS5+zIRVeHsU7afOcQ4KA1d6jbr
         YYYIilw1CRdCDon6ewhclVVZLF+JOeBz7Ya6jCvvDGMM4AeeG117qTn281+WIc+2IPnC
         jdT7XGxF6NRG55xdgPXvI+qtiAlksonCuZx9dpk6k5ZSCIv8jKPYwA0pO9i+Iua/A4qz
         iCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691854273; x=1692459073;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DHdR91Cr4ayDwVTatLZNJpXNEH0l3fIlA2RBT4y8Nw=;
        b=dn7TUmBEypId8Qrk4ekxlip9pJeRVdEuyHHvy+Zit3F31HndaT6g/DV+zBgEEfJ6JC
         EiDxA8/rDlfxitH4xurpw9+BCJzJZfWrsuUsuOjzcLtvY/twfV6a/738DH7r6I2WY5k3
         8QD14OiKKq+E1+4lub9/FpjWnf772P4ojne20UJwAThUXN0qVfIY1cOPHF4x+Us21OJQ
         +r9APaHjR4DCiryowt++deIuSrlBGsUeYroQmt7kMMgkFAYTK4dglcjfFP052md7wFI0
         qK2P2Rw+n0eYxpCstkmqGsEiOW/XljJ5G58WLBOfEyS4bbG9zjieGK6FogGzAzli2MzR
         RWLQ==
X-Gm-Message-State: AOJu0Yw1GQo6B+L6LJvXH+mgFeJIikjy8L29g0JCtdOmn0CjqvEbBTvG
        QcN69/HhZqyoE8C7e/Kmq7r8mz7LpI+MYaRY
X-Google-Smtp-Source: AGHT+IFAkCEVX5isT1RM/A+iymAypK8ZWczDIkWY0y9LfWpyJuMt0qY+rlEliQ3EaDRIXAZFuECTcQ==
X-Received: by 2002:a05:600c:22cc:b0:3fe:2186:e9ad with SMTP id 12-20020a05600c22cc00b003fe2186e9admr3906207wmg.6.1691854273289;
        Sat, 12 Aug 2023 08:31:13 -0700 (PDT)
Received: from khadija-virtual-machine ([154.80.49.20])
        by smtp.gmail.com with ESMTPSA id v1-20020a05600c214100b003fe215e4492sm8699606wml.4.2023.08.12.08.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 08:31:12 -0700 (PDT)
Date:   Sat, 12 Aug 2023 20:31:08 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH] lsm: constify the 'file' parameter in
 security_binder_transfer_file()
Message-ID: <ZNelvBCFG7wZt24g@gmail.com>
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

SELinux registers the implementation for the "binder_transfer_file"
hook. Looking at the function implementation we observe that the
parameter "file" is not changing.

Mark the "file" parameter of LSM hook security_binder_transfer_file() as
"const" since it will not be changing in the LSM hook.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/security.h      | 4 ++--
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6bb55e61e8e8..cda9e787cfc2 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -32,7 +32,7 @@ LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
 LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
 	 const struct cred *to)
 LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
-	 const struct cred *to, struct file *file)
+	 const struct cred *to, const struct file *file)
 LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
 	 unsigned int mode)
 LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
diff --git a/include/linux/security.h b/include/linux/security.h
index e2734e9e44d5..79ddeb2a2ff1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -268,7 +268,7 @@ int security_binder_transaction(const struct cred *from,
 int security_binder_transfer_binder(const struct cred *from,
 				    const struct cred *to);
 int security_binder_transfer_file(const struct cred *from,
-				  const struct cred *to, struct file *file);
+				  const struct cred *to, const struct file *file);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
 int security_capget(struct task_struct *target,
@@ -537,7 +537,7 @@ static inline int security_binder_transfer_binder(const struct cred *from,
 
 static inline int security_binder_transfer_file(const struct cred *from,
 						const struct cred *to,
-						struct file *file)
+						const struct file *file)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index d5ff7ff45b77..9e222e8156b1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -840,7 +840,7 @@ int security_binder_transfer_binder(const struct cred *from,
  * Return: Returns 0 if permission is granted.
  */
 int security_binder_transfer_file(const struct cred *from,
-				  const struct cred *to, struct file *file)
+				  const struct cred *to, const struct file *file)
 {
 	return call_int_hook(binder_transfer_file, 0, from, to, file);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79b4890e9936..f801b10d0822 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1665,7 +1665,7 @@ static inline int file_path_has_perm(const struct cred *cred,
 }
 
 #ifdef CONFIG_BPF_SYSCALL
-static int bpf_fd_pass(struct file *file, u32 sid);
+static int bpf_fd_pass(const struct file *file, u32 sid);
 #endif
 
 /* Check whether a task can use an open file descriptor to
@@ -1926,7 +1926,7 @@ static inline u32 file_mask_to_av(int mode, int mask)
 }
 
 /* Convert a Linux file to an access vector. */
-static inline u32 file_to_av(struct file *file)
+static inline u32 file_to_av(const struct file *file)
 {
 	u32 av = 0;
 
@@ -2001,7 +2001,7 @@ static int selinux_binder_transfer_binder(const struct cred *from,
 
 static int selinux_binder_transfer_file(const struct cred *from,
 					const struct cred *to,
-					struct file *file)
+					const struct file *file)
 {
 	u32 sid = cred_sid(to);
 	struct file_security_struct *fsec = selinux_file(file);
@@ -6679,7 +6679,7 @@ static u32 bpf_map_fmode_to_av(fmode_t fmode)
  * access the bpf object and that's why we have to add this additional check in
  * selinux_file_receive and selinux_binder_transfer_files.
  */
-static int bpf_fd_pass(struct file *file, u32 sid)
+static int bpf_fd_pass(const struct file *file, u32 sid)
 {
 	struct bpf_security_struct *bpfsec;
 	struct bpf_prog *prog;
-- 
2.34.1

