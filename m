Return-Path: <linux-kernel+bounces-9126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9BE81C0EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7C2B24450
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BA278E6B;
	Thu, 21 Dec 2023 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1j7JdFHH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J4jZqYRp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6677F14;
	Thu, 21 Dec 2023 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Dec 2023 22:19:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703197194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6MZf3JnNH6fYMqsmBdfadcswG1f57d08m995ZyqhgA=;
	b=1j7JdFHHj+z7lS2WG51kLEJ+aMIdF1q1f/lXsHKLS9Dl8aCUYmwIU4k1vNP+bz4xRf5e/3
	hUiAY6H0v0OhG3cVT+aPcs4bL4mKBIf5EWrkPjqnYXokc8LXujRLajzNeaREULjMXhlo8Q
	RDmmbXDs0tgRH/L7qImwgIUAvHryXoFrM6Ir8KVZEp2aReP4sJtp0DZZFR0l8vb61yx7Eb
	nnd7ZWaQuZg/JQaq/v6P71bnvh0oBru8edo1ZrKHNb0fhaZ98Sm+wNx2+n/M1W9zW9sm9f
	yCbjeIz/CrdXjPrV8f4oGnRbdfa/rI5B7XRkVwA76zFzgj0I3HBjBrPLe5sA+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703197194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6MZf3JnNH6fYMqsmBdfadcswG1f57d08m995ZyqhgA=;
	b=J4jZqYRpjkv5ZPHufOoB7D1V9RAoq4XON59qjzjozktpFvRmBdIgsgiEx+qnwt6wmG/RW8
	9uZcQFTOcX4exrCg==
From: "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/entry] entry: Move exit to usermode functions to header file
Cc: Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231218074520.1998026-2-svens@linux.ibm.com>
References: <20231218074520.1998026-2-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170319719381.398.2807341208511949110.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     d68019471995ba47e56a9da355df13a1cdb5bf7e
Gitweb:        https://git.kernel.org/tip/d68019471995ba47e56a9da355df13a1cdb5bf7e
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Mon, 18 Dec 2023 08:45:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 21 Dec 2023 23:12:18 +01:00

entry: Move exit to usermode functions to header file

To allow inlining, move exit_to_user_mode() to
entry-common.h.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231218074520.1998026-2-svens@linux.ibm.com

---
 include/linux/entry-common.h | 53 ++++++++++++++++++++++++++++++++++-
 kernel/entry/common.c        | 52 +++++-----------------------------
 2 files changed, 61 insertions(+), 44 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index d95ab85..6a6e98f 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -7,6 +7,10 @@
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
+#include <linux/context_tracking.h>
+#include <linux/livepatch.h>
+#include <linux/resume_user_mode.h>
+#include <linux/tick.h>
 
 #include <asm/entry-common.h>
 
@@ -259,6 +263,43 @@ static __always_inline void arch_exit_to_user_mode(void) { }
 void arch_do_signal_or_restart(struct pt_regs *regs);
 
 /**
+ * exit_to_user_mode_loop - do any pending work before leaving to user space
+ */
+unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
+				     unsigned long ti_work);
+
+/**
+ * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
+ * @regs:	Pointer to pt_regs on entry stack
+ *
+ * 1) check that interrupts are disabled
+ * 2) call tick_nohz_user_enter_prepare()
+ * 3) call exit_to_user_mode_loop() if any flags from
+ *    EXIT_TO_USER_MODE_WORK are set
+ * 4) check that interrupts are still disabled
+ */
+static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	unsigned long ti_work;
+
+	lockdep_assert_irqs_disabled();
+
+	/* Flush pending rcuog wakeup before the last need_resched() check */
+	tick_nohz_user_enter_prepare();
+
+	ti_work = read_thread_flags();
+	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
+		ti_work = exit_to_user_mode_loop(regs, ti_work);
+
+	arch_exit_to_user_mode_prepare(regs, ti_work);
+
+	/* Ensure that kernel state is sane for a return to userspace */
+	kmap_assert_nomap();
+	lockdep_assert_irqs_disabled();
+	lockdep_sys_exit();
+}
+
+/**
  * exit_to_user_mode - Fixup state when exiting to user mode
  *
  * Syscall/interrupt exit enables interrupts, but the kernel state is
@@ -276,7 +317,17 @@ void arch_do_signal_or_restart(struct pt_regs *regs);
  * non-instrumentable.
  * The caller has to invoke syscall_exit_to_user_mode_work() before this.
  */
-void exit_to_user_mode(void);
+static __always_inline void exit_to_user_mode(void)
+{
+	instrumentation_begin();
+	trace_hardirqs_on_prepare();
+	lockdep_hardirqs_on_prepare();
+	instrumentation_end();
+
+	user_enter_irqoff();
+	arch_exit_to_user_mode();
+	lockdep_hardirqs_on(CALLER_ADDR0);
+}
 
 /**
  * syscall_exit_to_user_mode_work - Handle work before returning to user mode
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d7ee4bc..7f8f8c1 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -123,29 +123,16 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 	instrumentation_end();
 }
 
-/* See comment for exit_to_user_mode() in entry-common.h */
-static __always_inline void __exit_to_user_mode(void)
-{
-	instrumentation_begin();
-	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare();
-	instrumentation_end();
-
-	user_enter_irqoff();
-	arch_exit_to_user_mode();
-	lockdep_hardirqs_on(CALLER_ADDR0);
-}
-
-void noinstr exit_to_user_mode(void)
-{
-	__exit_to_user_mode();
-}
-
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
-static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-					    unsigned long ti_work)
+/**
+ * exit_to_user_mode_loop - do any pending work before leaving to user space
+ * @regs:	Pointer to pt_regs on entry stack
+ * @ti_work:	TIF work flags as read by the caller
+ */
+__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
+						     unsigned long ti_work)
 {
 	/*
 	 * Before returning to user space ensure that all pending work
@@ -190,27 +177,6 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 	return ti_work;
 }
 
-static void exit_to_user_mode_prepare(struct pt_regs *regs)
-{
-	unsigned long ti_work;
-
-	lockdep_assert_irqs_disabled();
-
-	/* Flush pending rcuog wakeup before the last need_resched() check */
-	tick_nohz_user_enter_prepare();
-
-	ti_work = read_thread_flags();
-	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work = exit_to_user_mode_loop(regs, ti_work);
-
-	arch_exit_to_user_mode_prepare(regs, ti_work);
-
-	/* Ensure that kernel state is sane for a return to userspace */
-	kmap_assert_nomap();
-	lockdep_assert_irqs_disabled();
-	lockdep_sys_exit();
-}
-
 /*
  * If SYSCALL_EMU is set, then the only reason to report is when
  * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
@@ -295,7 +261,7 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 	instrumentation_begin();
 	__syscall_exit_to_user_mode_work(regs);
 	instrumentation_end();
-	__exit_to_user_mode();
+	exit_to_user_mode();
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
@@ -308,7 +274,7 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	instrumentation_begin();
 	exit_to_user_mode_prepare(regs);
 	instrumentation_end();
-	__exit_to_user_mode();
+	exit_to_user_mode();
 }
 
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)

