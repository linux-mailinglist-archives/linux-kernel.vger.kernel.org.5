Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AB4768D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjGaHKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjGaHJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:09:53 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABF23592;
        Mon, 31 Jul 2023 00:08:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9338e4695so60444961fa.2;
        Mon, 31 Jul 2023 00:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787276; x=1691392076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0/aKuaOVsJSJgtLyyiPYyb0+Zt09Maf57q0+SLzCsQ=;
        b=mbislLLFFEDe6n9R5cX+LLSIr4qJszm23PPRjA4xQME+yLrbRZ88DFAvPgJMe3o0br
         JiYlYs5ueW7QvLg3IH/x4gYvJ/zvI5E9WveIpY3/mxzdfGpXhJi2FmDtdeEJVfLsd/bY
         UzvIeM134Nhjx2sX5vDJpVrbXjY6A/eaa630t2iC6gZ1Axye0Ayxxpa5f9P0gw8zu+XG
         T3MAmooCRnrHJ1rtWxVbsnUaZ9WQqWZe8uvOHtMWreAMF9bSqaPlQxdfLkXuNktngq4L
         4EzHxJQ+Mj+IVfzLMGNvRg9lz+C4NEW+UjRMNnCQpXqh81uIeTzJD991MozKWfeYsB3y
         zJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787276; x=1691392076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0/aKuaOVsJSJgtLyyiPYyb0+Zt09Maf57q0+SLzCsQ=;
        b=Yvc5p941kca61bh3hmzvFCe8a5oa1Dyqj1AvFzvOrSSVZOR5dsGfXIarBh7QSjCA6w
         dZ2LJjy8p8MYtZ3RjJ4OxMK4Blc9t9A5YTlvWe55k2Ig/JueJNTCJOTumOzDd2pHbfhT
         nrdDOHjdOMwiEumZUGFCtZdyuRkGJcFqcG0u5a9psiEgzFSQ+UAtPAiLu3STAXn47VE2
         M3zpEAtTgRlhW/m7aepU5ixL428lHUjnWpZY5MRcy6mZgezyIfSYmC9byu23S0R5qgtm
         ALA1o4PjioVsYV85WaLQF5Nnt1uZG5KcRpYIwdwsytfqmmloanP12DgTHD3pKWENgX/Y
         /53g==
X-Gm-Message-State: ABy/qLbnzRK6FZL69aM6m3C1UCdMhKO4afjNv5KMpxEh7fcF2crWRAhQ
        ZSBdGfOVDShvuMHXd4bTbJc=
X-Google-Smtp-Source: APBJJlEmGXvkZ8xS1XENr3/LHg8pzM6HJzO8HdvOKSD895HNMlclj0O5T2u8J0glpxXn0CX0EbLK/Q==
X-Received: by 2002:a2e:9858:0:b0:2b9:d074:1871 with SMTP id e24-20020a2e9858000000b002b9d0741871mr5324822ljj.45.1690787275897;
        Mon, 31 Jul 2023 00:07:55 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.65.235])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c1d0a00b003fd2d3462fcsm15114098wms.1.2023.07.31.00.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:07:55 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        john.johansen@canonical.com, alison.schofield@intel.com,
        ztarkhani@microsoft.com
Cc:     Khadija Kamran <kamrankhadijadj@gmail.com>
Subject: [PATCH 1/2] lsm: change 'target' parameter to 'const' in security_capget LSM hook
Date:   Mon, 31 Jul 2023 12:07:31 +0500
Message-Id: <7fd5ea487559760818af96f7c1f2c25bec515049.1690786467.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690786466.git.kamrankhadijadj@gmail.com>
References: <cover.1690786466.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three LSMs register the implementations for the "capget" hook: AppArmor,
SELinux, and the normal capability code. Looking at the function
implementations we may observe that the first parameter "target" is not
changing.

Mark the first argument "target" of LSM hook security_capget(...) as
"const" since it will not be changing in the LSM hook.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/security.h      | 6 +++---
 kernel/capability.c           | 2 +-
 security/apparmor/lsm.c       | 2 +-
 security/commoncap.c          | 2 +-
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6bb55e61e8e8..fd3844e11077 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -36,7 +36,7 @@ LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
 LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
 	 unsigned int mode)
 LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
-LSM_HOOK(int, 0, capget, struct task_struct *target, kernel_cap_t *effective,
+LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_t *effective,
 	 kernel_cap_t *inheritable, kernel_cap_t *permitted)
 LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
 	 const kernel_cap_t *effective, const kernel_cap_t *inheritable,
diff --git a/include/linux/security.h b/include/linux/security.h
index e2734e9e44d5..8b7d0b2ec1a4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -145,7 +145,7 @@ extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 extern int cap_settime(const struct timespec64 *ts, const struct timezone *tz);
 extern int cap_ptrace_access_check(struct task_struct *child, unsigned int mode);
 extern int cap_ptrace_traceme(struct task_struct *parent);
-extern int cap_capget(struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
+extern int cap_capget(const struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
 extern int cap_capset(struct cred *new, const struct cred *old,
 		      const kernel_cap_t *effective,
 		      const kernel_cap_t *inheritable,
@@ -271,7 +271,7 @@ int security_binder_transfer_file(const struct cred *from,
 				  const struct cred *to, struct file *file);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
-int security_capget(struct task_struct *target,
+int security_capget(const struct task_struct *target,
 		    kernel_cap_t *effective,
 		    kernel_cap_t *inheritable,
 		    kernel_cap_t *permitted);
@@ -553,7 +553,7 @@ static inline int security_ptrace_traceme(struct task_struct *parent)
 	return cap_ptrace_traceme(parent);
 }
 
-static inline int security_capget(struct task_struct *target,
+static inline int security_capget(const struct task_struct *target,
 				   kernel_cap_t *effective,
 				   kernel_cap_t *inheritable,
 				   kernel_cap_t *permitted)
diff --git a/kernel/capability.c b/kernel/capability.c
index 3e058f41df32..67bdee3414dd 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -112,7 +112,7 @@ static inline int cap_get_target_pid(pid_t pid, kernel_cap_t *pEp,
 	int ret;
 
 	if (pid && (pid != task_pid_vnr(current))) {
-		struct task_struct *target;
+		const struct task_struct *target;
 
 		rcu_read_lock();
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f431251ffb91..12dd96c3b2f0 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -144,7 +144,7 @@ static int apparmor_ptrace_traceme(struct task_struct *parent)
 }
 
 /* Derived from security/commoncap.c:cap_capget */
-static int apparmor_capget(struct task_struct *target, kernel_cap_t *effective,
+static int apparmor_capget(const struct task_struct *target, kernel_cap_t *effective,
 			   kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	struct aa_label *label;
diff --git a/security/commoncap.c b/security/commoncap.c
index 0b3fc2f3afe7..5fd64d3e5bfd 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -197,7 +197,7 @@ int cap_ptrace_traceme(struct task_struct *parent)
  * This function retrieves the capabilities of the nominated task and returns
  * them to the caller.
  */
-int cap_capget(struct task_struct *target, kernel_cap_t *effective,
+int cap_capget(const struct task_struct *target, kernel_cap_t *effective,
 	       kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	const struct cred *cred;
diff --git a/security/security.c b/security/security.c
index d5ff7ff45b77..fb2d93b481f1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -893,7 +893,7 @@ int security_ptrace_traceme(struct task_struct *parent)
  *
  * Return: Returns 0 if the capability sets were successfully obtained.
  */
-int security_capget(struct task_struct *target,
+int security_capget(const struct task_struct *target,
 		    kernel_cap_t *effective,
 		    kernel_cap_t *inheritable,
 		    kernel_cap_t *permitted)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79b4890e9936..ff42d49f1b41 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2056,7 +2056,7 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
 			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
 
-static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
+static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
 			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	return avc_has_perm(current_sid(), task_sid_obj(target),
-- 
2.34.1

