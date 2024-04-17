Return-Path: <linux-kernel+bounces-148453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DDD8A82CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80835287017
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9594413E89D;
	Wed, 17 Apr 2024 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e+6+3Qfg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SsQy7Muw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26F1327F2;
	Wed, 17 Apr 2024 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355648; cv=none; b=jPPDOrljo9st2eZ1jRNGtt7es2umwakXQqeH7+/E1w3hMFBWX6PUKZGzk3t4c8q/vS0gfKudWA1BNIpdczzb47jweusRctFDCL6FyBNGc3DdMNanTSlhTcyfzHXQ8ChRcy3no6Hk8CypVT/QvtzkElR24itOluvZTtTYBuT1siM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355648; c=relaxed/simple;
	bh=bzN5/kWYICx/pe5i2O3c1CjKELr/yU41TFTNGbiKu5I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nfzi+kM6B5PaonP8/q1jrmDsk6nKbNLQfKjXcafudDHeX2jEdurAyh15WFNyxAQ3rv6E2wFWmZvd9dolVyLQFiDyIUyn5mw2yf4W9kd0TZxGZq0Oezl5nAUsNx+qIRF1qwELf8grqjp3NHfOcQ0ozkLFWJxkyOpVx+ET8eWbwDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e+6+3Qfg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SsQy7Muw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Apr 2024 12:07:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713355642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vb5M0mW8qAR2QeNY/ySXxZj6z3yDPdzJIDQEx+QmFLo=;
	b=e+6+3QfgUZx/uI3fWYmeQvL5Ze/Q6QiTgqIVYrcZm86lCvVwMWH50KsQujQJX+bOu/YCnJ
	Jw6THvPl9iS4DGzMuxEqeWZ7LCoXQtWo+PvGWxkfCwWblETLtgXYe2uSM7JaBaLXzFyG7S
	bg3VxXLhkTp+Q93phprQtGnoVMgs76siWPQxZyiKkckLVc5PGQ8HEdtXuOiiNFTpKJbz+m
	+1A+veXJyza1donbtKZT0OXH+hk9qo4zDSQerc55/DNaKV+nA5IZnK7qXGzPxuNYkFA7Fm
	4DCzintdRcV/5x1YA+k4YAE0m8+h+9WNr55AsBBxvARqu1uucrnMuEzes/CDHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713355642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vb5M0mW8qAR2QeNY/ySXxZj6z3yDPdzJIDQEx+QmFLo=;
	b=SsQy7Muweyb5cqoybfmsNVD6UIew9dKlV0K1bcc6LQdfu/Gcrj6CuzSravNMmQPwu5G04b
	CBWfaNpRo7d+D0CQ==
From: "tip-bot2 for Alexander Gordeev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/vtime: Get rid of generic vtime_task_switch()
 implementation
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2cb6e3caada93623f6d4f78ad938ac6cd0e2fda8=2E17127?=
 =?utf-8?q?60275=2Egit=2Eagordeev=40linux=2Eibm=2Ecom=3E?=
References: =?utf-8?q?=3C2cb6e3caada93623f6d4f78ad938ac6cd0e2fda8=2E171276?=
 =?utf-8?q?0275=2Egit=2Eagordeev=40linux=2Eibm=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171335564205.10875.2012654679055415891.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     89d6910cc562ab34d1f1c08f3cf0a9700b8bf2c4
Gitweb:        https://git.kernel.org/tip/89d6910cc562ab34d1f1c08f3cf0a9700b8bf2c4
Author:        Alexander Gordeev <agordeev@linux.ibm.com>
AuthorDate:    Wed, 10 Apr 2024 17:09:45 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Apr 2024 13:37:20 +02:00

sched/vtime: Get rid of generic vtime_task_switch() implementation

The generic vtime_task_switch() implementation gets built only
if __ARCH_HAS_VTIME_TASK_SWITCH is not defined, but requires an
architecture to implement arch_vtime_task_switch() callback at
the same time, which is confusing.

Further, arch_vtime_task_switch() is implemented for 32-bit PowerPC
architecture only and vtime_task_switch() generic variant is rather
superfluous.

Simplify the whole vtime_task_switch() wiring by moving the existing
generic implementation to PowerPC.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/2cb6e3caada93623f6d4f78ad938ac6cd0e2fda8.1712760275.git.agordeev@linux.ibm.com
---
 arch/powerpc/include/asm/cputime.h | 13 -------------
 arch/powerpc/kernel/time.c         | 22 ++++++++++++++++++++++
 kernel/sched/cputime.c             | 13 -------------
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index 4961fb3..aff858c 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -32,23 +32,10 @@
 #ifdef CONFIG_PPC64
 #define get_accounting(tsk)	(&get_paca()->accounting)
 #define raw_get_accounting(tsk)	(&local_paca->accounting)
-static inline void arch_vtime_task_switch(struct task_struct *tsk) { }
 
 #else
 #define get_accounting(tsk)	(&task_thread_info(tsk)->accounting)
 #define raw_get_accounting(tsk)	get_accounting(tsk)
-/*
- * Called from the context switch with interrupts disabled, to charge all
- * accumulated times to the current process, and to prepare accounting on
- * the next process.
- */
-static inline void arch_vtime_task_switch(struct task_struct *prev)
-{
-	struct cpu_accounting_data *acct = get_accounting(current);
-	struct cpu_accounting_data *acct0 = get_accounting(prev);
-
-	acct->starttime = acct0->starttime;
-}
 #endif
 
 /*
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index df20cf2..c0fdc6d 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -354,6 +354,28 @@ void vtime_flush(struct task_struct *tsk)
 	acct->hardirq_time = 0;
 	acct->softirq_time = 0;
 }
+
+/*
+ * Called from the context switch with interrupts disabled, to charge all
+ * accumulated times to the current process, and to prepare accounting on
+ * the next process.
+ */
+void vtime_task_switch(struct task_struct *prev)
+{
+	if (is_idle_task(prev))
+		vtime_account_idle(prev);
+	else
+		vtime_account_kernel(prev);
+
+	vtime_flush(prev);
+
+	if (!IS_ENABLED(CONFIG_PPC64)) {
+		struct cpu_accounting_data *acct = get_accounting(current);
+		struct cpu_accounting_data *acct0 = get_accounting(prev);
+
+		acct->starttime = acct0->starttime;
+	}
+}
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
 void __no_kcsan __delay(unsigned long loops)
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f..aa48b2e 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -424,19 +424,6 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
  */
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 
-# ifndef __ARCH_HAS_VTIME_TASK_SWITCH
-void vtime_task_switch(struct task_struct *prev)
-{
-	if (is_idle_task(prev))
-		vtime_account_idle(prev);
-	else
-		vtime_account_kernel(prev);
-
-	vtime_flush(prev);
-	arch_vtime_task_switch(prev);
-}
-# endif
-
 void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
 {
 	unsigned int pc = irq_count() - offset;

