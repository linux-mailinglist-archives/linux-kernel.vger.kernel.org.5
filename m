Return-Path: <linux-kernel+bounces-78057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D652860E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C86BB25CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8E75CDC0;
	Fri, 23 Feb 2024 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CLkG47L4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kyd5PNDA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAA65CDF4;
	Fri, 23 Feb 2024 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681448; cv=none; b=lo3RCuifs9ZnG9MCrWCdnWAqj5aOuP/o8Tj8Zfa++gIxLARCl1nIQTICgSA/MxhT/A0Ks4LDA+7lwhGqufO4bs3twAqXKIv/3dvGkWKNUlO9ClFIgVGRiOfYb6Foh8i8mLSJXn5O7ruJktG9Tljygha2LVmFEqtSdg9ovwqC6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681448; c=relaxed/simple;
	bh=AlEbOermp1F8Q0iqHlsvfS2M6+5oyBEWffzt7PjJrJ8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IfQ9TsReDQ4j+JosJ1vGQ5dTw4vb6xH87LobBm9oDv5Ou8F2qZ6t90WwVe/OSqHnp6pfg7P6ZTr3DpAx81kSHNFxt4HjZFCs4/gLQeRA2bwetRpQDAOoC9NiRhm5M8VRqSxAB7c+AIaX5vrd0Hw/I2QLjjsuhThCz31FEWWsmX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CLkG47L4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kyd5PNDA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 09:43:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708681439;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2PMHFcB61+S0C8W7aEcqQTPMtADdl+pSwMYbvkIl9Y=;
	b=CLkG47L4XHhZD4PJEV5f/d11RzCLduhLuu9Mm4zBlsbMI4CZiDSxT5ug8p9ORvxM/ixKZ2
	7KtEMAvwQHhTBhltmW5XCdzhsF32Nl1GEdbOG2aoQ7bMa+HcbiDHg5DBgyFgeBKFhoucPH
	tezDax9FCmEv1YSSQrlraRtjaVRQedZ/4RrgDXRm+eXQz7A49LI7bvpNKj48cCBFZmcEN9
	hHRawsn/jwo3fQ1T0uy1A2L/98OjqOGoNBJFXFGdDKy8vX3I4kb6hVXAPjsBGVUu/dACN6
	drnLQCD4SNmlp/38gXV9nCkTQAB0S8RVU0k+HKfjIvK5v2vdAhRXWpwZHeUsKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708681439;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2PMHFcB61+S0C8W7aEcqQTPMtADdl+pSwMYbvkIl9Y=;
	b=kyd5PNDAkiiirulIbEms9VKPyeLmdmzbOU2iXISycjnr6kW+LC/aB4zivP3rfAKW9Qy+e+
	GGqlg/LoSz0r6cAw==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240222094006.1030709-2-apatel@ventanamicro.com>
References: <20240222094006.1030709-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170868143850.398.12304285170769867752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     8ec99b033147ef3bb8f0a560c24eb1baec3bc0be
Gitweb:        https://git.kernel.org/tip/8ec99b033147ef3bb8f0a560c24eb1baec3bc0be
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 22 Feb 2024 15:09:49 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Feb 2024 10:18:43 +01:00

irqchip/sifive-plic: Convert PLIC driver into a platform driver

The PLIC driver does not require very early initialization so convert
it into a platform driver.

After conversion, the PLIC driver is probed after CPUs are brought-up
so setup cpuhp state after context handler of all online CPUs are
initialized otherwise PLIC driver crashes for platforms with multiple
PLIC instances.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240222094006.1030709-2-apatel@ventanamicro.com

---
 drivers/irqchip/irq-sifive-plic.c | 101 +++++++++++++++++------------
 1 file changed, 61 insertions(+), 40 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 5b7bc4f..7400a07 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -64,6 +64,7 @@
 #define PLIC_QUIRK_EDGE_INTERRUPT	0
 
 struct plic_priv {
+	struct device *dev;
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
@@ -406,30 +407,50 @@ static int plic_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
-static int __init __plic_init(struct device_node *node,
-			      struct device_node *parent,
-			      unsigned long plic_quirks)
+static const struct of_device_id plic_match[] = {
+	{ .compatible = "sifive,plic-1.0.0" },
+	{ .compatible = "riscv,plic0" },
+	{ .compatible = "andestech,nceplic100",
+	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
+	{ .compatible = "thead,c900-plic",
+	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
+	{}
+};
+
+static int plic_probe(struct platform_device *pdev)
 {
 	int error = 0, nr_contexts, nr_handlers = 0, i;
-	u32 nr_irqs;
-	struct plic_priv *priv;
+	struct device *dev = &pdev->dev;
+	unsigned long plic_quirks = 0;
 	struct plic_handler *handler;
+	struct plic_priv *priv;
+	bool cpuhp_setup;
 	unsigned int cpu;
+	u32 nr_irqs;
+
+	if (is_of_node(dev->fwnode)) {
+		const struct of_device_id *id;
+
+		id = of_match_node(plic_match, to_of_node(dev->fwnode));
+		if (id)
+			plic_quirks = (unsigned long)id->data;
+	}
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->dev = dev;
 	priv->plic_quirks = plic_quirks;
 
-	priv->regs = of_iomap(node, 0);
+	priv->regs = of_iomap(to_of_node(dev->fwnode), 0);
 	if (WARN_ON(!priv->regs)) {
 		error = -EIO;
 		goto out_free_priv;
 	}
 
 	error = -EINVAL;
-	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
+	of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", &nr_irqs);
 	if (WARN_ON(!nr_irqs))
 		goto out_iounmap;
 
@@ -439,13 +460,13 @@ static int __init __plic_init(struct device_node *node,
 	if (!priv->prio_save)
 		goto out_free_priority_reg;
 
-	nr_contexts = of_irq_count(node);
+	nr_contexts = of_irq_count(to_of_node(dev->fwnode));
 	if (WARN_ON(!nr_contexts))
 		goto out_free_priority_reg;
 
 	error = -ENOMEM;
-	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
-			&plic_irqdomain_ops, priv);
+	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
+						&plic_irqdomain_ops, priv);
 	if (WARN_ON(!priv->irqdomain))
 		goto out_free_priority_reg;
 
@@ -455,7 +476,7 @@ static int __init __plic_init(struct device_node *node,
 		int cpu;
 		unsigned long hartid;
 
-		if (of_irq_parse_one(node, i, &parent)) {
+		if (of_irq_parse_one(to_of_node(dev->fwnode), i, &parent)) {
 			pr_err("failed to parse parent for context %d.\n", i);
 			continue;
 		}
@@ -491,7 +512,7 @@ static int __init __plic_init(struct device_node *node,
 
 		/* Find parent domain and register chained handler */
 		if (!plic_parent_irq && irq_find_host(parent.np)) {
-			plic_parent_irq = irq_of_parse_and_map(node, i);
+			plic_parent_irq = irq_of_parse_and_map(to_of_node(dev->fwnode), i);
 			if (plic_parent_irq)
 				irq_set_chained_handler(plic_parent_irq,
 							plic_handle_irq);
@@ -533,20 +554,29 @@ done:
 
 	/*
 	 * We can have multiple PLIC instances so setup cpuhp state
-	 * and register syscore operations only when context handler
-	 * for current/boot CPU is present.
+	 * and register syscore operations only once after context
+	 * handlers of all online CPUs are initialized.
 	 */
-	handler = this_cpu_ptr(&plic_handlers);
-	if (handler->present && !plic_cpuhp_setup_done) {
-		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
-				  "irqchip/sifive/plic:starting",
-				  plic_starting_cpu, plic_dying_cpu);
-		register_syscore_ops(&plic_irq_syscore_ops);
-		plic_cpuhp_setup_done = true;
+	if (!plic_cpuhp_setup_done) {
+		cpuhp_setup = true;
+		for_each_online_cpu(cpu) {
+			handler = per_cpu_ptr(&plic_handlers, cpu);
+			if (!handler->present) {
+				cpuhp_setup = false;
+				break;
+			}
+		}
+		if (cpuhp_setup) {
+			cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+					  "irqchip/sifive/plic:starting",
+					  plic_starting_cpu, plic_dying_cpu);
+			register_syscore_ops(&plic_irq_syscore_ops);
+			plic_cpuhp_setup_done = true;
+		}
 	}
 
-	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
-		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
+	pr_info("%pOFP: mapped %d interrupts with %d handlers for %d contexts.\n",
+		to_of_node(dev->fwnode), nr_irqs, nr_handlers, nr_contexts);
 	return 0;
 
 out_free_enable_reg:
@@ -563,20 +593,11 @@ out_free_priv:
 	return error;
 }
 
-static int __init plic_init(struct device_node *node,
-			    struct device_node *parent)
-{
-	return __plic_init(node, parent, 0);
-}
-
-IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
-IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
-
-static int __init plic_edge_init(struct device_node *node,
-				 struct device_node *parent)
-{
-	return __plic_init(node, parent, BIT(PLIC_QUIRK_EDGE_INTERRUPT));
-}
-
-IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init);
-IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
+static struct platform_driver plic_driver = {
+	.driver = {
+		.name		= "riscv-plic",
+		.of_match_table	= plic_match,
+	},
+	.probe = plic_probe,
+};
+builtin_platform_driver(plic_driver);

