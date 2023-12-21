Return-Path: <linux-kernel+bounces-9124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1ED81C0EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ADC6B23407
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0CD77F36;
	Thu, 21 Dec 2023 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xtbMQ6JL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wGZV6Vhn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973558224;
	Thu, 21 Dec 2023 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Dec 2023 22:19:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703197193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVIfz86zLwDDAzvuPStrRVhoyaKHOi+EzjyorsIZCvQ=;
	b=xtbMQ6JLFZD/a2qE3T6a5X0bo4rYX6Ks3svUmkpNIwzN08WaUHmOGLoJlxX/vyCuyFgku9
	W0Ek2Tc90jOzh2VsS7wpzO3VkdZa17hvbWUCVRF2k2Unz88Xumojc+nByw4YkitxcyaSn+
	MFyT2xMNFhct56DIj9smUrkTLbYZ8eM/1X2jbcvSkxPGntIaCwCBjPlEqXxjwtkyfp0ky1
	zB4Bu8KO7ma6sJVFQDcMW/JVSNxtK4TQvpGPPIYJaGLCI8JNPXs//OJFrBOpX1T9i+t08b
	cl8iAZuXxt5/4Uxn1p4ETb9zOqUESPajw3O4yK58VH0D3j5OelnheGnZciPBHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703197193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVIfz86zLwDDAzvuPStrRVhoyaKHOi+EzjyorsIZCvQ=;
	b=wGZV6VhnaCh9whg69nG1wneAfIrErtGfosChpxm08s5xfUsnEk2USmqMkXgvsXQg3+dtX2
	X9yJTDI5SDPMLsBg==
From: "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/entry] entry: Move syscall_enter_from_user_mode() to header file
Cc: Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231218074520.1998026-4-svens@linux.ibm.com>
References: <20231218074520.1998026-4-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170319719260.398.4829837604529644212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     221a164035fd8b554a44bd7c4bf8e7715a497561
Gitweb:        https://git.kernel.org/tip/221a164035fd8b554a44bd7c4bf8e7715a497561
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Mon, 18 Dec 2023 08:45:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 21 Dec 2023 23:12:18 +01:00

entry: Move syscall_enter_from_user_mode() to header file

To allow inlining of syscall_enter_from_user_mode(), move it
to entry-common.h.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231218074520.1998026-4-svens@linux.ibm.com

---
 include/linux/entry-common.h | 27 +++++++++++++++++++++++++--
 kernel/entry/common.c        | 32 +-------------------------------
 2 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index c420539..b0fb775 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -134,6 +134,9 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
  */
 void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
 
+long syscall_trace_enter(struct pt_regs *regs, long syscall,
+			 unsigned long work);
+
 /**
  * syscall_enter_from_user_mode_work - Check and handle work before invoking
  *				       a syscall
@@ -157,7 +160,15 @@ void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
  *     ptrace_report_syscall_entry(), __secure_computing(), trace_sys_enter()
  *  2) Invocation of audit_syscall_entry()
  */
-long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
+static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
+{
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
+
+	if (work & SYSCALL_WORK_ENTER)
+		syscall = syscall_trace_enter(regs, syscall, work);
+
+	return syscall;
+}
 
 /**
  * syscall_enter_from_user_mode - Establish state and check and handle work
@@ -176,7 +187,19 @@ long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
  * Returns: The original or a modified syscall number. See
  * syscall_enter_from_user_mode_work() for further explanation.
  */
-long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall);
+static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
+{
+	long ret;
+
+	enter_from_user_mode(regs);
+
+	instrumentation_begin();
+	local_irq_enable();
+	ret = syscall_enter_from_user_mode_work(regs, syscall);
+	instrumentation_end();
+
+	return ret;
+}
 
 /**
  * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 0616f23..88cb3c8 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -25,7 +25,7 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 	}
 }
 
-static long syscall_trace_enter(struct pt_regs *regs, long syscall,
+long syscall_trace_enter(struct pt_regs *regs, long syscall,
 				unsigned long work)
 {
 	long ret = 0;
@@ -65,36 +65,6 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	return ret ? : syscall;
 }
 
-static __always_inline long
-__syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
-{
-	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-
-	if (work & SYSCALL_WORK_ENTER)
-		syscall = syscall_trace_enter(regs, syscall, work);
-
-	return syscall;
-}
-
-long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
-{
-	return __syscall_enter_from_user_work(regs, syscall);
-}
-
-noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
-{
-	long ret;
-
-	enter_from_user_mode(regs);
-
-	instrumentation_begin();
-	local_irq_enable();
-	ret = __syscall_enter_from_user_work(regs, syscall);
-	instrumentation_end();
-
-	return ret;
-}
-
 noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);

