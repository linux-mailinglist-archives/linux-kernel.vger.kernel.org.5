Return-Path: <linux-kernel+bounces-37518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4736B83B137
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD572869DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4531013174F;
	Wed, 24 Jan 2024 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aIu/V8TM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fvVO/WWK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82038131732;
	Wed, 24 Jan 2024 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121323; cv=none; b=suL2bmAFJLOyywArXoZD8tKmKjTN8SU+TZ/Jow/qRd+7gGUSoubFwt//UndZgq5xtRHsLk4qf5eK5m3SLPTJidz1Ccxh9a+UhxbX3Ba5UP3I7qkNVE4vrl3I6XCQJY63HExq9G6xxluU3fz21NPyiHAsvy55F0LJ/gXEKqh3gI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121323; c=relaxed/simple;
	bh=Np2VXXMYurtq5ntQ06E6I5v2cBffeVZzwXfVzOK6rbA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LTBh7tzgnJsuGzI8Hdw1C5UDjiTX4qMYWjQr3LU6LymU4vj1XHWL+yMZF6ohgvjOghMRjwjItAFaABXdMZJmVFz3XK1NQ+8sXbQgXmuwJMlk47SGnxPSpqSBVGl2GENfUZsEKC/FoFpBnfISAkJndFv7j+NfrwbMfMrTKgf99yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aIu/V8TM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fvVO/WWK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Jan 2024 18:35:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706121319;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GtrpXp7xwnV1UvsaxL3kfgcJ7wx4/zEhZg0ZY1Ln2H8=;
	b=aIu/V8TMRfd/fw9vm+VNpTX2s88zo8c3eirh3ZTBFmdprRZbSf0p7u5TQe3r/Thxq7yMG2
	n4RqWJk4VEIP63MGJAmeVr1GIYksHj6A0ssRmxZylHMAen8uTPQVZCSHqF1ElJPe0jV7nJ
	mDsSKU+QOh7aeQ5KOdQmr1Iwyv8+b9BYXy+5Xa4tXbeonCmVGoipEtIa35awmv2wPHUzTz
	MWaB90OTMETxCnQ702FbEr1K7pAJUadq8Ih4+2OpgPqCxiAniTx25imuLvd5Qx7jX21DEH
	kbGcQg8eSHqnypX8XuY8U0CPDBrbQFmLLOwGqw5MxXB5HqdvXzGAQ1bGKFco0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706121319;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GtrpXp7xwnV1UvsaxL3kfgcJ7wx4/zEhZg0ZY1Ln2H8=;
	b=fvVO/WWKRwttljesfF5Mh6mzNx5UZ8iYlWfIGUJuwszJcIUCauTngNOgiGKp4Me0aGLOzF
	fvpcIz8SosLnQcAw==
From: "tip-bot2 for Dawei Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq: Deduplicate interrupt descriptor initialization
Cc: Marc Zyngier <maz@kernel.org>, Dawei Li <dawei.li@shingroup.cn>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240122085716.2999875-6-dawei.li@shingroup.cn>
References: <20240122085716.2999875-6-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170612131798.398.11050796782414301853.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     22653244a9fed06f2f864b44808a85bf5c4e3ef2
Gitweb:        https://git.kernel.org/tip/22653244a9fed06f2f864b44808a85bf5c4e3ef2
Author:        Dawei Li <dawei.li@shingroup.cn>
AuthorDate:    Mon, 22 Jan 2024 16:57:16 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Jan 2024 16:02:48 +01:00

genirq: Deduplicate interrupt descriptor initialization

alloc_desc() and early_irq_init() contain duplicated code to initialize
interrupt descriptors.

Replace that with a helper function.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240122085716.2999875-6-dawei.li@shingroup.cn

---
 kernel/irq/irqdesc.c | 112 ++++++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 48 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 371eb17..4c6b323 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -92,11 +92,23 @@ static void desc_smp_init(struct irq_desc *desc, int node,
 #endif
 }
 
+static void free_masks(struct irq_desc *desc)
+{
+#ifdef CONFIG_GENERIC_PENDING_IRQ
+	free_cpumask_var(desc->pending_mask);
+#endif
+	free_cpumask_var(desc->irq_common_data.affinity);
+#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	free_cpumask_var(desc->irq_common_data.effective_affinity);
+#endif
+}
+
 #else
 static inline int
 alloc_masks(struct irq_desc *desc, int node) { return 0; }
 static inline void
 desc_smp_init(struct irq_desc *desc, int node, const struct cpumask *affinity) { }
+static inline void free_masks(struct irq_desc *desc) { }
 #endif
 
 static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
@@ -166,6 +178,39 @@ static void delete_irq_desc(unsigned int irq)
 }
 
 #ifdef CONFIG_SPARSE_IRQ
+static const struct kobj_type irq_kobj_type;
+#endif
+
+static int init_desc(struct irq_desc *desc, int irq, int node,
+		     unsigned int flags,
+		     const struct cpumask *affinity,
+		     struct module *owner)
+{
+	desc->kstat_irqs = alloc_percpu(unsigned int);
+	if (!desc->kstat_irqs)
+		return -ENOMEM;
+
+	if (alloc_masks(desc, node)) {
+		free_percpu(desc->kstat_irqs);
+		return -ENOMEM;
+	}
+
+	raw_spin_lock_init(&desc->lock);
+	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
+	mutex_init(&desc->request_mutex);
+	init_waitqueue_head(&desc->wait_for_threads);
+	desc_set_defaults(irq, desc, node, affinity, owner);
+	irqd_set(&desc->irq_data, flags);
+	irq_resend_init(desc);
+#ifdef CONFIG_SPARSE_IRQ
+	kobject_init(&desc->kobj, &irq_kobj_type);
+	init_rcu_head(&desc->rcu);
+#endif
+
+	return 0;
+}
+
+#ifdef CONFIG_SPARSE_IRQ
 
 static void irq_kobj_release(struct kobject *kobj);
 
@@ -384,21 +429,6 @@ struct irq_desc *irq_to_desc(unsigned int irq)
 EXPORT_SYMBOL_GPL(irq_to_desc);
 #endif
 
-#ifdef CONFIG_SMP
-static void free_masks(struct irq_desc *desc)
-{
-#ifdef CONFIG_GENERIC_PENDING_IRQ
-	free_cpumask_var(desc->pending_mask);
-#endif
-	free_cpumask_var(desc->irq_common_data.affinity);
-#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
-	free_cpumask_var(desc->irq_common_data.effective_affinity);
-#endif
-}
-#else
-static inline void free_masks(struct irq_desc *desc) { }
-#endif
-
 void irq_lock_sparse(void)
 {
 	mutex_lock(&sparse_irq_lock);
@@ -414,36 +444,19 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 				   struct module *owner)
 {
 	struct irq_desc *desc;
+	int ret;
 
 	desc = kzalloc_node(sizeof(*desc), GFP_KERNEL, node);
 	if (!desc)
 		return NULL;
-	/* allocate based on nr_cpu_ids */
-	desc->kstat_irqs = alloc_percpu(unsigned int);
-	if (!desc->kstat_irqs)
-		goto err_desc;
-
-	if (alloc_masks(desc, node))
-		goto err_kstat;
 
-	raw_spin_lock_init(&desc->lock);
-	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
-	mutex_init(&desc->request_mutex);
-	init_rcu_head(&desc->rcu);
-	init_waitqueue_head(&desc->wait_for_threads);
-
-	desc_set_defaults(irq, desc, node, affinity, owner);
-	irqd_set(&desc->irq_data, flags);
-	kobject_init(&desc->kobj, &irq_kobj_type);
-	irq_resend_init(desc);
+	ret = init_desc(desc, irq, node, flags, affinity, owner);
+	if (unlikely(ret)) {
+		kfree(desc);
+		return NULL;
+	}
 
 	return desc;
-
-err_kstat:
-	free_percpu(desc->kstat_irqs);
-err_desc:
-	kfree(desc);
-	return NULL;
 }
 
 static void irq_kobj_release(struct kobject *kobj)
@@ -583,26 +596,29 @@ struct irq_desc irq_desc[NR_IRQS] __cacheline_aligned_in_smp = {
 int __init early_irq_init(void)
 {
 	int count, i, node = first_online_node;
-	struct irq_desc *desc;
+	int ret;
 
 	init_irq_default_affinity();
 
 	printk(KERN_INFO "NR_IRQS: %d\n", NR_IRQS);
 
-	desc = irq_desc;
 	count = ARRAY_SIZE(irq_desc);
 
 	for (i = 0; i < count; i++) {
-		desc[i].kstat_irqs = alloc_percpu(unsigned int);
-		alloc_masks(&desc[i], node);
-		raw_spin_lock_init(&desc[i].lock);
-		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
-		mutex_init(&desc[i].request_mutex);
-		init_waitqueue_head(&desc[i].wait_for_threads);
-		desc_set_defaults(i, &desc[i], node, NULL, NULL);
-		irq_resend_init(&desc[i]);
+		ret = init_desc(irq_desc + i, i, node, 0, NULL, NULL);
+		if (unlikely(ret))
+			goto __free_desc_res;
 	}
+
 	return arch_early_irq_init();
+
+__free_desc_res:
+	while (--i >= 0) {
+		free_masks(irq_desc + i);
+		free_percpu(irq_desc[i].kstat_irqs);
+	}
+
+	return ret;
 }
 
 struct irq_desc *irq_to_desc(unsigned int irq)

