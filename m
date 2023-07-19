Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8D675A231
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGSWre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSWr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462FB1FF1;
        Wed, 19 Jul 2023 15:47:28 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=giUarVDnv1Z4cvepgxL2Be4qlcKqGuVFS1qBPnFcdD0=;
        b=RPBUsSapf5QCVvtmPNOMeAy+2lILSV8GeD1+iNmDnvdiS/B7LRg2sGLH6Y3Ru9ukWpDJ6u
        x9ndeAEIa7DkfGiqlDFg5L+7YoqF1C0TlMw2giRiQaBsH+DOUZM5/dXCo/0Z7AKAdJZYB1
        Hb3IoPOE7S7Ldc7K8U1nyYJ23UOGOqABMeD1QeOVrao+ItbKj3cp2izO6NXNqToYQi4ymJ
        pelNUYFNVuHJ+gFsvxBoN+ENPJKQADi3GW4is1rQzy8bIVoWjL7PVhIBAlhqZrr2REibyN
        JHUe1JuZiEsNqR4ZhO87HLZa5QxMeBIhD9Ei5Btc1h7ZPOEUSa+ZQ62YqfPo0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=giUarVDnv1Z4cvepgxL2Be4qlcKqGuVFS1qBPnFcdD0=;
        b=3DCUWoIODa/svnS8S9lsYBsQQHcGDGUaEh/50BVwlc6FbZbqfOiCzOnns4MgrcDXy6e+Yj
        HXQs2LpzbovZ0VBw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Add ARCH_SHSTK_STATUS
Cc:     Mike Rapoport <rppt@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980684564.28540.1364207622351188041.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     0b3374b01dd47b29ca87f4523340ec142510335a
Gitweb:        https://git.kernel.org/tip/0b3374b01dd47b29ca87f4523340ec142510335a
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:11:08 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:14:15 -07:00

x86/shstk: Add ARCH_SHSTK_STATUS

CRIU and GDB need to get the current shadow stack and WRSS enablement
status. This information is already available via /proc/pid/status, but
this is inconvenient for CRIU because it involves parsing the text output
in an area of the code where this is difficult. Provide a status
arch_prctl(), ARCH_SHSTK_STATUS for retrieving the status. Have arg2 be a
userspace address, and make the new arch_prctl simply copy the features
out to userspace.

Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-43-rick.p.edgecombe%40intel.com
---
 Documentation/arch/x86/shstk.rst  | 6 ++++++
 arch/x86/include/asm/shstk.h      | 2 +-
 arch/x86/include/uapi/asm/prctl.h | 1 +
 arch/x86/kernel/process_64.c      | 1 +
 arch/x86/kernel/shstk.c           | 8 +++++++-
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/shstk.rst b/Documentation/arch/x86/shstk.rst
index f3553cc..60260e8 100644
--- a/Documentation/arch/x86/shstk.rst
+++ b/Documentation/arch/x86/shstk.rst
@@ -79,6 +79,11 @@ arch_prctl(ARCH_SHSTK_UNLOCK, unsigned long features)
     Unlock features. 'features' is a mask of all features to unlock. All
     bits set are processed, unset bits are ignored. Only works via ptrace.
 
+arch_prctl(ARCH_SHSTK_STATUS, unsigned long addr)
+    Copy the currently enabled features to the address passed in addr. The
+    features are described using the bits passed into the others in
+    'features'.
+
 The return values are as follows. On success, return 0. On error, errno can
 be::
 
@@ -86,6 +91,7 @@ be::
         -ENOTSUPP if the feature is not supported by the hardware or
          kernel.
         -EINVAL arguments (non existing feature, etc)
+        -EFAULT if could not copy information back to userspace
 
 The feature's bits supported are::
 
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index ecb23a8..42fee89 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -14,7 +14,7 @@ struct thread_shstk {
 	u64	size;
 };
 
-long shstk_prctl(struct task_struct *task, int option, unsigned long features);
+long shstk_prctl(struct task_struct *task, int option, unsigned long arg2);
 void reset_thread_features(void);
 unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
 				       unsigned long stack_size);
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 3189c4a..384e2cc 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -34,6 +34,7 @@
 #define ARCH_SHSTK_DISABLE		0x5002
 #define ARCH_SHSTK_LOCK			0x5003
 #define ARCH_SHSTK_UNLOCK		0x5004
+#define ARCH_SHSTK_STATUS		0x5005
 
 /* ARCH_SHSTK_ features bits */
 #define ARCH_SHSTK_SHSTK		(1ULL <<  0)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e6db21c..33b2687 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -900,6 +900,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_SHSTK_DISABLE:
 	case ARCH_SHSTK_LOCK:
 	case ARCH_SHSTK_UNLOCK:
+	case ARCH_SHSTK_STATUS:
 		return shstk_prctl(task, option, arg2);
 	default:
 		ret = -EINVAL;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index d43b7a9..b26810c 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -482,8 +482,14 @@ SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsi
 	return alloc_shstk(addr, aligned_size, size, set_tok);
 }
 
-long shstk_prctl(struct task_struct *task, int option, unsigned long features)
+long shstk_prctl(struct task_struct *task, int option, unsigned long arg2)
 {
+	unsigned long features = arg2;
+
+	if (option == ARCH_SHSTK_STATUS) {
+		return put_user(task->thread.features, (unsigned long __user *)arg2);
+	}
+
 	if (option == ARCH_SHSTK_LOCK) {
 		task->thread.features_locked |= features;
 		return 0;
