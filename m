Return-Path: <linux-kernel+bounces-157651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A9D8B1408
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255481C230BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A3145345;
	Wed, 24 Apr 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K9Idxg0o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jL7Wx0mc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB0143882;
	Wed, 24 Apr 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989056; cv=none; b=HqoQPTKdwp3dD3baMPKe2TG5UWh691vw6voPFGe8roZ/3eAeda4dFClIJ8YNPt+2y4uY3SJ9NX8sxIfNut7ByMcfXjZ/CAxY7MDtGzV2zG/34vx1mXIouLy8zz/KshlvmRDJRdGEAOIDCvjWBBN3vTRyRpXu9CSUWzBhKOnvu4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989056; c=relaxed/simple;
	bh=b5hQS6pgkisKzFAKmI4zIFzxjq9xoJV4PsjRaeY+/2E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FFSBu8A7diH94nL/xZYD5hJJezia9uqqHo8F7ZflUljdoz0ddGuybhHgefwzt6SMZAnronkBSaA2hVRnpWCzouE9KePuG/zirrrhepEX8sn+I516D8YP5Pq70SjKOGE6CRVfnNOxy9s/feGC6cYdh33OwNDIVo3WvyERxOHZGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K9Idxg0o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jL7Wx0mc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 20:04:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713989048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A96YpfMg1VlatpIGX5ujAH4vkuZ68JAcPv1s8lIj+y4=;
	b=K9Idxg0oZsG65YBHNPw0UpSKOjx0qm32R+GHd6pwPGgxFQuyWH5bzjdCuqD4cjJUX7302M
	+xLBxDpiLjXM0QxADJkG8EJMyVBhmAYYpHda+z4BVBeusOZNMQsGY1fN8LUjdeCjg2jFQl
	fvDJJ0KDv8wpSyXmmSck5F5sK5L5yb+/E9Kb06vRc+Zb/mX9A/kYHzGXgpvWyNFudyDmFS
	77pBdCWd3fN4o/e45aBbzT3nk/So63mpd1HYBMJVa+Q9TgmYqCbSZGE62NSGxdg11NmgJp
	3g+zMC2Wx+gzQxyd77wUcXRtagWPjy3WRrv8N6C+jA6EJfdtCsimBob7ELPUrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713989048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A96YpfMg1VlatpIGX5ujAH4vkuZ68JAcPv1s8lIj+y4=;
	b=jL7Wx0mcbnoFV75vPZwOMK5JFRP/iIPUWAR2jgbluLKEczXNMtdFqiOU80z5I/ZyUBpvLb
	bQ8aoUSryYp+uCCg==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Reuse irq_is_nmi()
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240423024037.3331215-1-ruanjinjie@huawei.com>
References: <20240423024037.3331215-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171398904780.10875.7983047492181737837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6678ae1918ff554f7438ff3f1a3be22d6d01f2fb
Gitweb:        https://git.kernel.org/tip/6678ae1918ff554f7438ff3f1a3be22d6d01f2fb
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Tue, 23 Apr 2024 02:40:37 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Apr 2024 20:42:57 +02:00

genirq: Reuse irq_is_nmi()

Move irq_is_nmi() to the internal header file and reuse it all over the
place.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423024037.3331215-1-ruanjinjie@huawei.com
---
 kernel/irq/internals.h |  5 +++++
 kernel/irq/irqdesc.c   |  5 -----
 kernel/irq/manage.c    | 16 ++++++++--------
 kernel/irq/resend.c    |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 6c43ef3..ed28059 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -280,6 +280,11 @@ static inline int irq_desc_is_chained(struct irq_desc *desc)
 	return (desc->action && desc->action == &chained_action);
 }
 
+static inline bool irq_is_nmi(struct irq_desc *desc)
+{
+	return desc->istate & IRQS_NMI;
+}
+
 #ifdef CONFIG_PM_SLEEP
 bool irq_pm_check_wakeup(struct irq_desc *desc);
 void irq_pm_install_action(struct irq_desc *desc, struct irqaction *action);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index f0d4b98..88ac365 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -965,11 +965,6 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
 	return desc && desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
 }
 
-static bool irq_is_nmi(struct irq_desc *desc)
-{
-	return desc->istate & IRQS_NMI;
-}
-
 unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpumask *cpumask)
 {
 	unsigned int sum = 0;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 29c378d..61bdb45 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -564,7 +564,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	/* The release function is promised process context */
 	might_sleep();
 
-	if (!desc || desc->istate & IRQS_NMI)
+	if (!desc || irq_is_nmi(desc))
 		return -EINVAL;
 
 	/* Complete initialisation of *notify */
@@ -902,7 +902,7 @@ int irq_set_irq_wake(unsigned int irq, unsigned int on)
 		return -EINVAL;
 
 	/* Don't use NMIs as wake up interrupts please */
-	if (desc->istate & IRQS_NMI) {
+	if (irq_is_nmi(desc)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -1628,7 +1628,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		 */
 		unsigned int oldtype;
 
-		if (desc->istate & IRQS_NMI) {
+		if (irq_is_nmi(desc)) {
 			pr_err("Invalid attempt to share NMI for %s (irq %d) on irqchip %s.\n",
 				new->name, irq, desc->irq_data.chip->name);
 			ret = -EINVAL;
@@ -2081,7 +2081,7 @@ const void *free_nmi(unsigned int irq, void *dev_id)
 	unsigned long flags;
 	const void *devname;
 
-	if (!desc || WARN_ON(!(desc->istate & IRQS_NMI)))
+	if (!desc || WARN_ON(!irq_is_nmi(desc)))
 		return NULL;
 
 	if (WARN_ON(irq_settings_is_per_cpu_devid(desc)))
@@ -2547,7 +2547,7 @@ void free_percpu_nmi(unsigned int irq, void __percpu *dev_id)
 	if (!desc || !irq_settings_is_per_cpu_devid(desc))
 		return;
 
-	if (WARN_ON(!(desc->istate & IRQS_NMI)))
+	if (WARN_ON(!irq_is_nmi(desc)))
 		return;
 
 	kfree(__free_percpu_irq(irq, dev_id));
@@ -2683,7 +2683,7 @@ int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
 		return -EINVAL;
 
 	/* The line cannot already be NMI */
-	if (desc->istate & IRQS_NMI)
+	if (irq_is_nmi(desc))
 		return -EINVAL;
 
 	action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
@@ -2744,7 +2744,7 @@ int prepare_percpu_nmi(unsigned int irq)
 	if (!desc)
 		return -EINVAL;
 
-	if (WARN(!(desc->istate & IRQS_NMI),
+	if (WARN(!irq_is_nmi(desc),
 		 KERN_ERR "prepare_percpu_nmi called for a non-NMI interrupt: irq %u\n",
 		 irq)) {
 		ret = -EINVAL;
@@ -2786,7 +2786,7 @@ void teardown_percpu_nmi(unsigned int irq)
 	if (!desc)
 		return;
 
-	if (WARN_ON(!(desc->istate & IRQS_NMI)))
+	if (WARN_ON(!irq_is_nmi(desc)))
 		goto out;
 
 	irq_nmi_teardown(desc);
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 5f2c668..b07a2d7 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -190,7 +190,7 @@ int irq_inject_interrupt(unsigned int irq)
 	 *  - not NMI type
 	 *  - activated
 	 */
-	if ((desc->istate & IRQS_NMI) || !irqd_is_activated(&desc->irq_data))
+	if (irq_is_nmi(desc) || !irqd_is_activated(&desc->irq_data))
 		err = -EINVAL;
 	else
 		err = check_irq_resend(desc, true);

