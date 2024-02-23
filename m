Return-Path: <linux-kernel+bounces-78051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B20860E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F130B21ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8E05D495;
	Fri, 23 Feb 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="InYV/0Rg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1+zvP+/1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19C25C91A;
	Fri, 23 Feb 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681444; cv=none; b=Gd2tAskB1Yb9XSL8zrkxF+387xfY5uJkF9P+wKJfdx4cwVmN5VGCjq4PLCSBdtDrtVndrteICpWxONFC3dolFqv1RpSE4up+K6dHt1VIVCWczFmOSBjNYgmRRsnj61R6HKi7mFixRTJpZwGGvna61CTZ3xMxgDj/oXUJUnRltPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681444; c=relaxed/simple;
	bh=xP1QMBHBnX7txEiz3JN13nwfnUgIJKwzU6gITrTpne4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tB6NvIDiuEwg/urYqpvyuA3xyVSN0LxHMrkO3iJQbQFyf095h2ATHRbW2P6+HyOYeOaescyd4gcFcDYRxla17fmh6OY+0kR5qqDRzHJ1+a3HGv0qzss7NtLMoLUE7etQPAOM6c4F2ANAG0SA2/Bf4OmiW9O7BYm8Smni4qglUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=InYV/0Rg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1+zvP+/1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 09:43:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708681434;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAHbqt8rQSPOA2HvT+YVJ6OL/lZfbAgvAFtu3HB+cNg=;
	b=InYV/0Rgmw8PeLD6QTiQu9lhUvZXso96HBCS95LjwmXBrU71Is9xkjwt9878JxlQsVDyZ4
	QfDkO22e5sbu735n6k9bvGCZCgEHs1S7xaQWVIvJnmnX1HrSi3EJnfYrS2eV1bzDfHQmCb
	Qog8D/aUGCEQBvnGR6riMNmKG+DrpAbh85UAiIS7Pu4IyFoCHasoN3oH0BTH4PBYItJ63+
	D4/J/EbCG0j0t5PmUcSR9FeqyDZiOFaQb3oBCyTTrkaTfWdzXG53q9A/tdXwIbUbkg68iT
	W6cDD5VP3O79ZQ8A3SHnx74tCgbQaozO//eMexE5sEIkPWdWAttxCIxH9McT9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708681434;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAHbqt8rQSPOA2HvT+YVJ6OL/lZfbAgvAFtu3HB+cNg=;
	b=1+zvP+/1bSRaYdZD7v5IbSd2vyoW5eL1eMMYx6NaWv6kE2XnN0N5iBElGmn+2nl3A8nTGu
	SIAmE8h9FcTvNoCQ==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/sifive-plic: Parse number of interrupts and
 contexts early in plic_probe()
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240222094006.1030709-7-apatel@ventanamicro.com>
References: <20240222094006.1030709-7-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170868143403.398.1806515246389747048.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     95652106478030f54620b1f0d28f78ab110b3212
Gitweb:        https://git.kernel.org/tip/95652106478030f54620b1f0d28f78ab110b3212
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 22 Feb 2024 15:09:54 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Feb 2024 10:18:44 +01:00

irqchip/sifive-plic: Parse number of interrupts and contexts early in plic_probe()

The SiFive PLIC driver needs to know the number of interrupts and contexts
to complete initialization. Parse these details early in plic_probe() to
avoid unnecessary memory allocations and register mappings if these details
are not available.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240222094006.1030709-7-apatel@ventanamicro.com

---
 drivers/irqchip/irq-sifive-plic.c | 43 +++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index a399cb3..474ddc3 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -417,6 +417,34 @@ static const struct of_device_id plic_match[] = {
 	{}
 };
 
+static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
+					   u32 *nr_irqs, u32 *nr_contexts)
+{
+	struct device *dev = &pdev->dev;
+	int rc;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(dev->fwnode))
+		return -EINVAL;
+
+	rc = of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", nr_irqs);
+	if (rc) {
+		dev_err(dev, "riscv,ndev property not available\n");
+		return rc;
+	}
+
+	*nr_contexts = of_irq_count(to_of_node(dev->fwnode));
+	if (WARN_ON(!(*nr_contexts))) {
+		dev_err(dev, "no PLIC context available\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
 				     u32 *parent_hwirq, int *parent_cpu)
 {
@@ -465,31 +493,26 @@ static int plic_probe(struct platform_device *pdev)
 			plic_quirks = (unsigned long)id->data;
 	}
 
+	error = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
+	if (error)
+		return error;
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
 	priv->plic_quirks = plic_quirks;
+	priv->nr_irqs = nr_irqs;
 
 	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (WARN_ON(!priv->regs))
 		return -EIO;
 
-	of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", &nr_irqs);
-	if (WARN_ON(!nr_irqs))
-		return -EINVAL;
-
-	priv->nr_irqs = nr_irqs;
-
 	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
 	if (!priv->prio_save)
 		return -ENOMEM;
 
-	nr_contexts = of_irq_count(to_of_node(dev->fwnode));
-	if (WARN_ON(!nr_contexts))
-		return -EINVAL;
-
 	for (i = 0; i < nr_contexts; i++) {
 		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
 		if (error) {

