Return-Path: <linux-kernel+bounces-71154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8669385A16F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0F6283686
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EBE28DDF;
	Mon, 19 Feb 2024 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IgoWWx4r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="02R1N3KT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C13028DBF;
	Mon, 19 Feb 2024 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340048; cv=none; b=VW8B9KbQyX+uL+LisJKHGYq2Y2WRwJgsa+FunTq5XuB2XKuneYwYl9bBr+C/hSt5j07536SMlz9o8HYe9HjmjALzkY3oEP8rE1ZjaPKLy6AWVE7Kreirf3Cl/vm6cPImvW83MFuM4VhmHJgCffIrLLqvzSOyyoktk8LvboSL32A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340048; c=relaxed/simple;
	bh=gf3z+xntVMESYYOXqdfthNDgYasDPWbJWCxy0swxIeY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O0teFbKzq46sPnQ/wz3i44/VgnZv+3SdipAiveGyrJ+3EqATmVgVUEEQvyvPf994zvT/LVOB0ZljuGN4hRyO9EaCRcw90qOQ4pNf8Iq5KGMVSUDNzj0C/pL11IUwBHbObNsa8J+ir44Ugz3/hkrwpT3G0lRqrsdIUhv1Wk6AJyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IgoWWx4r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=02R1N3KT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 10:54:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708340044;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMr5wZHo+iJizSZtBfiMUkOCyOt32t5SxZbwNDvsiX0=;
	b=IgoWWx4rkxSHsVUQoVxtwT8ijHI3PVMJR/HZnTQC6PxRa0Yr8MDJxTSq9n6HvUgZLboOaW
	68lBea33yaGfBsNahwPtvJqHQXCQ1m3qBhlZ+1oM2GJyW9fYW7TUpijf6VftxYRup++bAS
	A4Pb+nc7LeiO/YmH3Ax2UuaYYRkXUZpvXbFIlsXd5xDBL52WxkRiVm+AdAMcKsbKKvB0V4
	HfOBc/UrHUCngfGd3m5l8L14jN+2ZDj4zbqu60ZSbQfEG3sa8IqY2MNMSpFVoHL+FHTc28
	D5z0btesOf+9wJs8Z8avPkkH3zYhLOh706FsZKwiwV22nkxiQLbrQoipb1mkNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708340044;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMr5wZHo+iJizSZtBfiMUkOCyOt32t5SxZbwNDvsiX0=;
	b=02R1N3KTQMFhQf8ZKCvrMHZtHSMGEbYYlTJBgIOGH6Y5CCoFyOo9iVCQTzbg0YW71XeNRP
	2CklfOWwV9XQjtAA==
From: "tip-bot2 for Crystal Wood" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Wake interrupt threads immediately when
 changing affinity
Cc: Crystal Wood <crwood@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240122235353.15235-1-crwood@redhat.com>
References: <20240122235353.15235-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170834004383.398.5346093175756384370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c99303a2d2a25ba467ebf75d3e446b58c7e7df3a
Gitweb:        https://git.kernel.org/tip/c99303a2d2a25ba467ebf75d3e446b58c7e7df3a
Author:        Crystal Wood <crwood@redhat.com>
AuthorDate:    Mon, 22 Jan 2024 17:53:53 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Feb 2024 11:43:46 +01:00

genirq: Wake interrupt threads immediately when changing affinity

The affinity setting of interrupt threads happens in the context of the
thread when the thread is woken up by an hard interrupt. As this can be an
arbitrary after changing the affinity, the thread can become runnable on an
isolated CPU and cause isolation disruption.

Avoid this by checking the set affinity request in wait_for_interrupt() and
waking the threads immediately when the affinity is modified.

Note that this is of the most benefit on systems where the interrupt
affinity itself does not need to be deferred to the interrupt handler, but
even where that's not the case, the total dirsuption will be less.

Signed-off-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240122235353.15235-1-crwood@redhat.com
---
 kernel/irq/manage.c | 109 +++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1782f90..ad3eaf2 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -192,10 +192,14 @@ void irq_set_thread_affinity(struct irq_desc *desc)
 	struct irqaction *action;
 
 	for_each_action_of_desc(desc, action) {
-		if (action->thread)
+		if (action->thread) {
 			set_bit(IRQTF_AFFINITY, &action->thread_flags);
-		if (action->secondary && action->secondary->thread)
+			wake_up_process(action->thread);
+		}
+		if (action->secondary && action->secondary->thread) {
 			set_bit(IRQTF_AFFINITY, &action->secondary->thread_flags);
+			wake_up_process(action->secondary->thread);
+		}
 	}
 }
 
@@ -1049,10 +1053,57 @@ static irqreturn_t irq_forced_secondary_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static int irq_wait_for_interrupt(struct irqaction *action)
+#ifdef CONFIG_SMP
+/*
+ * Check whether we need to change the affinity of the interrupt thread.
+ */
+static void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action)
+{
+	cpumask_var_t mask;
+	bool valid = false;
+
+	if (!test_and_clear_bit(IRQTF_AFFINITY, &action->thread_flags))
+		return;
+
+	__set_current_state(TASK_RUNNING);
+
+	/*
+	 * In case we are out of memory we set IRQTF_AFFINITY again and
+	 * try again next time
+	 */
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL)) {
+		set_bit(IRQTF_AFFINITY, &action->thread_flags);
+		return;
+	}
+
+	raw_spin_lock_irq(&desc->lock);
+	/*
+	 * This code is triggered unconditionally. Check the affinity
+	 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
+	 */
+	if (cpumask_available(desc->irq_common_data.affinity)) {
+		const struct cpumask *m;
+
+		m = irq_data_get_effective_affinity_mask(&desc->irq_data);
+		cpumask_copy(mask, m);
+		valid = true;
+	}
+	raw_spin_unlock_irq(&desc->lock);
+
+	if (valid)
+		set_cpus_allowed_ptr(current, mask);
+	free_cpumask_var(mask);
+}
+#else
+static inline void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) { }
+#endif
+
+static int irq_wait_for_interrupt(struct irq_desc *desc,
+				  struct irqaction *action)
 {
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
+		irq_thread_check_affinity(desc, action);
 
 		if (kthread_should_stop()) {
 			/* may need to run one last time */
@@ -1129,52 +1180,6 @@ out_unlock:
 	chip_bus_sync_unlock(desc);
 }
 
-#ifdef CONFIG_SMP
-/*
- * Check whether we need to change the affinity of the interrupt thread.
- */
-static void
-irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action)
-{
-	cpumask_var_t mask;
-	bool valid = true;
-
-	if (!test_and_clear_bit(IRQTF_AFFINITY, &action->thread_flags))
-		return;
-
-	/*
-	 * In case we are out of memory we set IRQTF_AFFINITY again and
-	 * try again next time
-	 */
-	if (!alloc_cpumask_var(&mask, GFP_KERNEL)) {
-		set_bit(IRQTF_AFFINITY, &action->thread_flags);
-		return;
-	}
-
-	raw_spin_lock_irq(&desc->lock);
-	/*
-	 * This code is triggered unconditionally. Check the affinity
-	 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
-	 */
-	if (cpumask_available(desc->irq_common_data.affinity)) {
-		const struct cpumask *m;
-
-		m = irq_data_get_effective_affinity_mask(&desc->irq_data);
-		cpumask_copy(mask, m);
-	} else {
-		valid = false;
-	}
-	raw_spin_unlock_irq(&desc->lock);
-
-	if (valid)
-		set_cpus_allowed_ptr(current, mask);
-	free_cpumask_var(mask);
-}
-#else
-static inline void
-irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) { }
-#endif
-
 /*
  * Interrupts which are not explicitly requested as threaded
  * interrupts rely on the implicit bh/preempt disable of the hard irq
@@ -1312,13 +1317,9 @@ static int irq_thread(void *data)
 	init_task_work(&on_exit_work, irq_thread_dtor);
 	task_work_add(current, &on_exit_work, TWA_NONE);
 
-	irq_thread_check_affinity(desc, action);
-
-	while (!irq_wait_for_interrupt(action)) {
+	while (!irq_wait_for_interrupt(desc, action)) {
 		irqreturn_t action_ret;
 
-		irq_thread_check_affinity(desc, action);
-
 		action_ret = handler_fn(desc, action);
 		if (action_ret == IRQ_WAKE_THREAD)
 			irq_wake_secondary(desc, action);

