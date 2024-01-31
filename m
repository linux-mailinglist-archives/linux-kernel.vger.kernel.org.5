Return-Path: <linux-kernel+bounces-45903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D5E8437B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3288B26691
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1032F604A7;
	Wed, 31 Jan 2024 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TPpk/I7y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nBE+pEZT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C9657DA;
	Wed, 31 Jan 2024 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685681; cv=none; b=YBaBIqV7zmXPo0Lqbjv8x9kB6LmTpp4nzJZCSYp1tI+x0Q73XYytQsqcq0RTvISoGweqQHzZtn4K+V60ia7ntYDGiL+lWHkN3RNIz0+4tRfvCbhnp+/2HO8QBIR4NHfObH9ZwST9103D/8RvYUTxMGDr1UCHUlSnKlVR31DOCVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685681; c=relaxed/simple;
	bh=mCBt5EsE0n2XqEeQjHG76xW2/BMMvN+SketzV+B0fMg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZcOZ9JreQe1nRwnuYevr5fAb2M4WOQVqjaQib4ekyatwtr4IsPOCy6Py7qJNw2wA2nSx1vBXSjkEB3tlsJE4O+9Von9KLYZrtMl6Qt/9PyQ6KA3b1lFk/qzEdGi4K9wg37gWugE+xwcTURjDiQw6v/ds/EUepxbdVUeEkYfCsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TPpk/I7y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nBE+pEZT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heEj9clWJf1DBgO5wqjsKMksR5nZ//K/C9coqz8ORVs=;
	b=TPpk/I7yC0MsZSOmzOPzNB8+Vo3yjMnGoqjU5X+FZRAUHEePubUV7Fs7v38XWCO6LEZHu6
	V71x/CwQOFSUN1dfNMQe02k79E+TWOOCcCfXSNyX5xSqLqjQIARIQ1P1ZZySFKkL8R2h31
	opmqQgd3vUdaySOR5Y6lvpgyrHaMpIrZCnhiBPXLfNsE1TiGm+DObOworYP+RvlzRq9d3F
	hhfaU33cdX6zOEiJPTKXuGY9EcloJl7rJrXFlBcrPviALE8jwp3hTf7e9HgmVQAa1jzdbv
	NqDEbse7STrNLs4UvcZtfQ6dqjKYhuB9d3Kt0F8YYJXSGzOR2mzbcjL/fpFJ5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heEj9clWJf1DBgO5wqjsKMksR5nZ//K/C9coqz8ORVs=;
	b=nBE+pEZTGha+sKjXbeo+dcaeS3QGduNuco8Ppw7xmicrM2tqr/UjH5Nje6oEolYCTa1n9+
	cc/0CzrjW0MUMUAA==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Add a debug fault entry stub for FRED
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-24-xin3.li@intel.com>
References: <20231205105030.8698-24-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170668567661.398.3910130782522674092.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     4af12f6a393ca2be76de6c5484f79acc1167e1c8
Gitweb:        https://git.kernel.org/tip/4af12f6a393ca2be76de6c5484f79acc1167e1c8
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:12 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:35 +01:00

x86/fred: Add a debug fault entry stub for FRED

When occurred on different ring level, i.e., from user or kernel context,
#DB needs to be handled on different stack: User #DB on current task
stack, while kernel #DB on a dedicated stack. This is exactly how FRED
event delivery invokes an exception handler: ring 3 event on level 0
stack, i.e., current task stack; ring 0 event on the #DB dedicated stack
specified in the IA32_FRED_STKLVLS MSR. So unlike IDT, the FRED debug
exception entry stub doesn't do stack switch.

On a FRED system, the debug trap status information (DR6) is passed on
the stack, to avoid the problem of transient state. Furthermore, FRED
transitions avoid a lot of ugly corner cases the handling of which can,
and should be, skipped.

The FRED debug trap status information saved on the stack differs from
DR6 in both stickiness and polarity; it is exactly in the format which
debug_read_clear_dr6() returns for the IDT entry points.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-24-xin3.li@intel.com

---
 arch/x86/kernel/traps.c | 43 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3c37489..1b19a17 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -51,6 +51,7 @@
 #include <asm/ftrace.h>
 #include <asm/traps.h>
 #include <asm/desc.h>
+#include <asm/fred.h>
 #include <asm/fpu/api.h>
 #include <asm/cpu.h>
 #include <asm/cpu_entry_area.h>
@@ -935,8 +936,7 @@ static bool notify_debug(struct pt_regs *regs, unsigned long *dr6)
 	return false;
 }
 
-static __always_inline void exc_debug_kernel(struct pt_regs *regs,
-					     unsigned long dr6)
+static noinstr void exc_debug_kernel(struct pt_regs *regs, unsigned long dr6)
 {
 	/*
 	 * Disable breakpoints during exception handling; recursive exceptions
@@ -948,6 +948,11 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	 *
 	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
 	 * includes the entry stack is excluded for everything.
+	 *
+	 * For FRED, nested #DB should just work fine. But when a watchpoint or
+	 * breakpoint is set in the code path which is executed by #DB handler,
+	 * it results in an endless recursion and stack overflow. Thus we stay
+	 * with the IDT approach, i.e., save DR7 and disable #DB.
 	 */
 	unsigned long dr7 = local_db_save();
 	irqentry_state_t irq_state = irqentry_nmi_enter(regs);
@@ -977,7 +982,8 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
 	 * watchpoint at the same time then that will still be handled.
 	 */
-	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
+	if (!cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    (dr6 & DR_STEP) && is_sysenter_singlestep(regs))
 		dr6 &= ~DR_STEP;
 
 	/*
@@ -1009,8 +1015,7 @@ out:
 	local_db_restore(dr7);
 }
 
-static __always_inline void exc_debug_user(struct pt_regs *regs,
-					   unsigned long dr6)
+static noinstr void exc_debug_user(struct pt_regs *regs, unsigned long dr6)
 {
 	bool icebp;
 
@@ -1094,6 +1099,34 @@ DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
 {
 	exc_debug_user(regs, debug_read_clear_dr6());
 }
+
+#ifdef CONFIG_X86_FRED
+/*
+ * When occurred on different ring level, i.e., from user or kernel
+ * context, #DB needs to be handled on different stack: User #DB on
+ * current task stack, while kernel #DB on a dedicated stack.
+ *
+ * This is exactly how FRED event delivery invokes an exception
+ * handler: ring 3 event on level 0 stack, i.e., current task stack;
+ * ring 0 event on the #DB dedicated stack specified in the
+ * IA32_FRED_STKLVLS MSR. So unlike IDT, the FRED debug exception
+ * entry stub doesn't do stack switch.
+ */
+DEFINE_FREDENTRY_DEBUG(exc_debug)
+{
+	/*
+	 * FRED #DB stores DR6 on the stack in the format which
+	 * debug_read_clear_dr6() returns for the IDT entry points.
+	 */
+	unsigned long dr6 = fred_event_data(regs);
+
+	if (user_mode(regs))
+		exc_debug_user(regs, dr6);
+	else
+		exc_debug_kernel(regs, dr6);
+}
+#endif /* CONFIG_X86_FRED */
+
 #else
 /* 32 bit does not have separate entry points. */
 DEFINE_IDTENTRY_RAW(exc_debug)

