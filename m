Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997647851EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjHWHsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjHWHsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:48:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF2CD0;
        Wed, 23 Aug 2023 00:48:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3197b461bb5so4676204f8f.3;
        Wed, 23 Aug 2023 00:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692776880; x=1693381680;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQVQ0Pzioqm+apDWx/BTd1Aa/XSfhKkkMImFNI9FDqQ=;
        b=EM2RUV7wkp/EtyyJgQamyAD/tYmVInKboRM85l9Dw7YgiOCwJVUgPPcX1c4TF1Mhh/
         7Ymw9kw5yHKE3kfrtoNkVw+DG2eUabFNuPSyjvPCt+Z0yomnb66FZRqE0skqVmvwHT64
         H9cL4vUgb5S4B2Zv8F1Tq6qzwhuW+WaJlP/PtiOzIw3BSq+QlWQlM8AJbdPWwI1o92cK
         P/Bp0fNR3i5D8d0sQrf9PZrZw6nfFO+sz8Kn+E6jusrLywbwiGhaOC7Soqg6e3DHCZHT
         LqWwW73Fj6U+bS3SlFH0IGzrHwsCTBbORqEyMvLiDMpdc8Zi/JNUSYeS9ZEhH46L3hsp
         jeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692776880; x=1693381680;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQVQ0Pzioqm+apDWx/BTd1Aa/XSfhKkkMImFNI9FDqQ=;
        b=TRTjnd0G/f29L1AvyGGj87gfqHykV+ghE+V7lA49nytEfZ+dR56HUmubVrMvMVtck/
         Pp2B2u5rsPg80D6afWDbfsx1h1anOKLGIBIFJPnDoMw6m2dV6LtNBUI3fkBYMFAYsM6C
         qr23h/PXn6gXO9/InDPusJAb1beavSG0mOcuz8Hm6ThlimLp4PJp5PzTjDSG0jDKvLPa
         ZLpPSaGd+X5mW5rDroejfABnbv/XdkTClkroy6U7dnsG5x//a9RczyTqEnCADWyhJcV1
         WWZbBBLJD3E3mILLa5eiSolDUFLt0sNueAVEdmrgQhiiB5zw1QjfVYviJW+ErLzlVgbE
         OIAg==
X-Gm-Message-State: AOJu0Yz+LODuz5tNuKpb15sv7rEiiZg2HnCB5mtxzXzfm0Wb3GJrNEAm
        nzDD766OKb4bs7ocNMhgTks=
X-Google-Smtp-Source: AGHT+IEf4xWTSXShqxhkKEl5qYuFQQi7jDNX0+9IdYNSkviUh0bMlQx3RJrlZM9p8DKhBA6bue7nRA==
X-Received: by 2002:a5d:65c5:0:b0:317:70cb:4f58 with SMTP id e5-20020a5d65c5000000b0031770cb4f58mr9450919wrw.63.1692776879662;
        Wed, 23 Aug 2023 00:47:59 -0700 (PDT)
Received: from khadija-virtual-machine ([124.29.208.67])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4ccc000000b003143c6e09ccsm18051505wrt.16.2023.08.23.00.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 00:47:59 -0700 (PDT)
Date:   Wed, 23 Aug 2023 12:47:56 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Subject: [PATCH] lsm: constify 'bprm' parameter in
 security_bprm_committing_creds()
Message-ID: <ZOW5rC1MngXvPQLz@gmail.com>
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

The 'bprm_committing_creds' hook has implementations registered in
SELinux and Apparmor. Looking at the function implementations we observe
that the 'bprm' parameter is not changing.

Mark the 'bprm' parameter of LSM hook security_bprm_committing_creds()
as 'const' since it will not be changing in the LSM hook.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/security.h      | 4 ++--
 security/apparmor/lsm.c       | 2 +-
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 1a05d95148e9..df8f98a2c7bd 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -52,7 +52,7 @@ LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct file *file)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
-LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
+LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, const struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
 	 struct fs_context *src_sc)
diff --git a/include/linux/security.h b/include/linux/security.h
index fbd498046e39..8e5d412b2437 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -291,7 +291,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
 int security_bprm_creds_for_exec(struct linux_binprm *bprm);
 int security_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file);
 int security_bprm_check(struct linux_binprm *bprm);
-void security_bprm_committing_creds(struct linux_binprm *bprm);
+void security_bprm_committing_creds(const struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
 int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
@@ -621,7 +621,7 @@ static inline int security_bprm_check(struct linux_binprm *bprm)
 	return 0;
 }
 
-static inline void security_bprm_committing_creds(struct linux_binprm *bprm)
+static inline void security_bprm_committing_creds(const struct linux_binprm *bprm)
 {
 }
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f431251ffb91..251b62dd96da 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -734,7 +734,7 @@ static int apparmor_setprocattr(const char *name, void *value,
  * apparmor_bprm_committing_creds - do task cleanup on committing new creds
  * @bprm: binprm for the exec  (NOT NULL)
  */
-static void apparmor_bprm_committing_creds(struct linux_binprm *bprm)
+static void apparmor_bprm_committing_creds(const struct linux_binprm *bprm)
 {
 	struct aa_label *label = aa_current_raw_label();
 	struct aa_label *new_label = cred_label(bprm->cred);
diff --git a/security/security.c b/security/security.c
index bf7de5211542..6e181ed22cb4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1117,7 +1117,7 @@ int security_bprm_check(struct linux_binprm *bprm)
  * open file descriptors to which access will no longer be granted when the
  * attributes are changed.  This is called immediately before commit_creds().
  */
-void security_bprm_committing_creds(struct linux_binprm *bprm)
+void security_bprm_committing_creds(const struct linux_binprm *bprm)
 {
 	call_void_hook(bprm_committing_creds, bprm);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79b4890e9936..66f9ea14ed8f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2404,7 +2404,7 @@ static inline void flush_unauthorized_files(const struct cred *cred,
 /*
  * Prepare a process for imminent new credential changes due to exec
  */
-static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
+static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
 {
 	struct task_security_struct *new_tsec;
 	struct rlimit *rlim, *initrlim;
-- 
2.34.1

