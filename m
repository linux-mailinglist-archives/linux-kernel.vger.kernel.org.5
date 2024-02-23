Return-Path: <linux-kernel+bounces-78053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B93B0860E70
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BDC28184D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68CA5D755;
	Fri, 23 Feb 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3EO5C8bc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AlrKVC7G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334765CDC9;
	Fri, 23 Feb 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681444; cv=none; b=A5WI0aA0b6XWx5n6xi422DDwLizJSTrmBdXIb1tffPAebVJ5vJQMSaDxZz5a9mQ2suoZMWQ+urobayIATNtzM/6JgZbBL+jR2Q7Za4XpDfHnHbgVYGyNDhVmo2cZ5H+MNAUZUoNKPxaeXKCpcQyQ76eysTkEzr82zHJVEaKUCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681444; c=relaxed/simple;
	bh=Hm4THppcEjqjG4fMgBu50n40WUPovTQawlGO7Uojg0w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CG4erjCsC59U6azcUpIqIgkYUmr/IOHKMx5DZdpNfj3nq0oNCZg1WxfQCDkULtXzQXRPPqVF/HIoYpHKQLwDYmNneZAxosUrxOost8ywmAbQaAXgpzPxnnl2dc4V17NT4Uc6aoVT/EtNknopuX42CKFNQ+GIpbi0HuwcxlWCcuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3EO5C8bc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AlrKVC7G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 09:43:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708681435;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+YDZ2NKsPJa7w+knbqMUFc0NFtFQXq3fdC8XV9O4YE=;
	b=3EO5C8bcSnhBEPjif5VaXcnnx42ymHVlEUw2TfU9LYBHqHTK1OLYYjOnDZfnnV0sVQWELi
	TJM6X89yuZHJGPxCazM3Qps8OSA+j597rWgXosMpApLJJbXjo+6qkqxlls+aUmE+Ns1zFD
	fwpxPYbNebOO3GyrjmjnOevtrl52wPAzaR8bas8eIOIhSDAzf4jVYWUQ88pVHdQrPYdkci
	V0XNPojU0gdufWs0bhSGoDaJC6kgPNFnhcsP3ozFG+qXbkNJD8G80MLtqw3fIEPlfrx3sL
	O9spteWY9IPTKQv3ZJkN0yIuyzsSg+KDOPEsSzJI7bnOrdgiourc7XPlSAOD5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708681435;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+YDZ2NKsPJa7w+knbqMUFc0NFtFQXq3fdC8XV9O4YE=;
	b=AlrKVC7GUqSEpf/AoXnAi1kLytOWEThS4Wh+LvTuLXMNPJ+MJKumeoSMAWhLS4rajCo0zE
	/2dkSasILyZlstCA==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/sifive-plic: Cleanup PLIC contexts upon
 irqdomain creation failure
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240222094006.1030709-6-apatel@ventanamicro.com>
References: <20240222094006.1030709-6-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170868143492.398.585451758085811485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     a15587277a246c388c83b1cd9cf7c1a868cd752f
Gitweb:        https://git.kernel.org/tip/a15587277a246c388c83b1cd9cf7c1a868cd752f
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 22 Feb 2024 15:09:53 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Feb 2024 10:18:44 +01:00

irqchip/sifive-plic: Cleanup PLIC contexts upon irqdomain creation failure

The SiFive PLIC contexts should not be left dangling if irqdomain creation
fails because plic_starting_cpu() can crash accessing unmapped registers.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240222094006.1030709-6-apatel@ventanamicro.com

---
 drivers/irqchip/irq-sifive-plic.c | 73 +++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 208fad7..a399cb3 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -417,17 +417,45 @@ static const struct of_device_id plic_match[] = {
 	{}
 };
 
+static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
+				     u32 *parent_hwirq, int *parent_cpu)
+{
+	struct device *dev = &pdev->dev;
+	struct of_phandle_args parent;
+	unsigned long hartid;
+	int rc;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(dev->fwnode))
+		return -EINVAL;
+
+	rc = of_irq_parse_one(to_of_node(dev->fwnode), context, &parent);
+	if (rc)
+		return rc;
+
+	rc = riscv_of_parent_hartid(parent.np, &hartid);
+	if (rc)
+		return rc;
+
+	*parent_hwirq = parent.args[0];
+	*parent_cpu = riscv_hartid_to_cpuid(hartid);
+	return 0;
+}
+
 static int plic_probe(struct platform_device *pdev)
 {
-	int error = 0, nr_contexts, nr_handlers = 0, i;
+	int error = 0, nr_contexts, nr_handlers = 0, cpu, i;
 	struct device *dev = &pdev->dev;
 	unsigned long plic_quirks = 0;
 	struct plic_handler *handler;
+	u32 nr_irqs, parent_hwirq;
 	struct irq_domain *domain;
 	struct plic_priv *priv;
+	irq_hw_number_t hwirq;
 	bool cpuhp_setup;
-	unsigned int cpu;
-	u32 nr_irqs;
 
 	if (is_of_node(dev->fwnode)) {
 		const struct of_device_id *id;
@@ -463,13 +491,9 @@ static int plic_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	for (i = 0; i < nr_contexts; i++) {
-		struct of_phandle_args parent;
-		irq_hw_number_t hwirq;
-		int cpu;
-		unsigned long hartid;
-
-		if (of_irq_parse_one(to_of_node(dev->fwnode), i, &parent)) {
-			dev_err(dev, "failed to parse parent for context %d.\n", i);
+		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
+		if (error) {
+			dev_warn(dev, "hwirq for context%d not found\n", i);
 			continue;
 		}
 
@@ -477,7 +501,7 @@ static int plic_probe(struct platform_device *pdev)
 		 * Skip contexts other than external interrupts for our
 		 * privilege level.
 		 */
-		if (parent.args[0] != RV_IRQ_EXT) {
+		if (parent_hwirq != RV_IRQ_EXT) {
 			/* Disable S-mode enable bits if running in M-mode. */
 			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
 				void __iomem *enable_base = priv->regs +
@@ -490,13 +514,6 @@ static int plic_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		error = riscv_of_parent_hartid(parent.np, &hartid);
-		if (error < 0) {
-			dev_warn(dev, "failed to parse hart ID for context %d.\n", i);
-			continue;
-		}
-
-		cpu = riscv_hartid_to_cpuid(hartid);
 		if (cpu < 0) {
 			dev_warn(dev, "Invalid cpuid for context %d\n", i);
 			continue;
@@ -534,7 +551,7 @@ static int plic_probe(struct platform_device *pdev)
 		handler->enable_save = devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
 						    sizeof(*handler->enable_save), GFP_KERNEL);
 		if (!handler->enable_save)
-			return -ENOMEM;
+			goto fail_cleanup_contexts;
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
@@ -547,7 +564,7 @@ done:
 	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
 						&plic_irqdomain_ops, priv);
 	if (WARN_ON(!priv->irqdomain))
-		return -ENOMEM;
+		goto fail_cleanup_contexts;
 
 	/*
 	 * We can have multiple PLIC instances so setup cpuhp state
@@ -575,6 +592,22 @@ done:
 	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
 		 nr_irqs, nr_handlers, nr_contexts);
 	return 0;
+
+fail_cleanup_contexts:
+	for (i = 0; i < nr_contexts; i++) {
+		if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu))
+			continue;
+		if (parent_hwirq != RV_IRQ_EXT || cpu < 0)
+			continue;
+
+		handler = per_cpu_ptr(&plic_handlers, cpu);
+		handler->present = false;
+		handler->hart_base = NULL;
+		handler->enable_base = NULL;
+		handler->enable_save = NULL;
+		handler->priv = NULL;
+	}
+	return -ENOMEM;
 }
 
 static struct platform_driver plic_driver = {

