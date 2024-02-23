Return-Path: <linux-kernel+bounces-78054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 777D8860E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBDA286B37
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9234C5D74E;
	Fri, 23 Feb 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wMiD9Zs0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QQ5B/VHz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279AF5CDC2;
	Fri, 23 Feb 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681444; cv=none; b=m+O1YsHJXCBteOKOkZabGc/8XKdVFF9VV4A7yPEbXhWyBt3X/X1m8a4yaoGp0AhqUTcyV2d0NvXyVf55r1/KxMU4ZTTkKG/fJJVZU15Ym7kK9omarnjJzmFwKG/abAqQE0nNPbOUTivXRsEAlcPwT4vT+ue8TvpeowffX9dmNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681444; c=relaxed/simple;
	bh=hgNDypjtNG1qCAmnxmrFk1EU08TQF4LZ3NoiZx2wAzI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gW7+Ih2FjXK7leeOI5m9eOIbjiV+cwchC6vi4aHpXgWBaTjpHhsybMxNPRbhQ2k+sqAAeJbksGzn0crQyb6HaoPonzS6BGdxZOY760vvir7bkqkc6sjMbmRRJO82B3Pr4JaxE6G95XREmCZzlZm01Z85ZDGbVRJxS7asGIBxVZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wMiD9Zs0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QQ5B/VHz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 09:43:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708681437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNdqJz+34lM7QFTAwzmXbPLV0lJZlhQnT3BpPvbMV3U=;
	b=wMiD9Zs0E82qj9Qa8gu/TKdkXX/r1lqpeFv3sOrzL2vblIPBKEY8Sfk/Ce/Oqk0qKIjfhd
	/Ohqx7eM9BDo3kK8hlPEIX6Zgd1uBowz7GxTf790cDf97hPuNaPkxRRsTqkh4AAiiPY/jN
	KL7y1SCqr9kn7y+/8I1/NNkIgFH9ahKwI5HR6djS9jN7X90qEoZeisauDPdgHQk/qt1Ufd
	k/GzFdVDB9AkSSHSzclYM9+0U8y0PYVVy1CdVHkCQJikhUUTCFy/BE5IApjqW1GXY/jqfD
	v3yY2a3SKxH2HEfElar2ta7zf90uX5BrC1a3MZyFL2zDknRhhe/8vBU1xzg6/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708681437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNdqJz+34lM7QFTAwzmXbPLV0lJZlhQnT3BpPvbMV3U=;
	b=QQ5B/VHz/jmOB4mWnDiXmsuaPb0dJlPrFFj++2uyG9SO9GDLRWN0/jOhMwpqfolOMJWCdQ
	MvchSXc5sx2VVlCA==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] irqchip/sifive-plic: Use devm_xyz() for managed allocation
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240222094006.1030709-4-apatel@ventanamicro.com>
References: <20240222094006.1030709-4-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170868143672.398.909119484089787009.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     b68d0ff529a939a118ec52f271be8cad5d99e79a
Gitweb:        https://git.kernel.org/tip/b68d0ff529a939a118ec52f271be8cad5d99e79a
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 22 Feb 2024 15:09:51 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Feb 2024 10:18:43 +01:00

irqchip/sifive-plic: Use devm_xyz() for managed allocation

Use devm_xyz() for allocations and mappings managed by the
Linux device driver framework.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240222094006.1030709-4-apatel@ventanamicro.com

---
 drivers/irqchip/irq-sifive-plic.c | 49 +++++++++---------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 892666f..299feef 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -436,39 +436,30 @@ static int plic_probe(struct platform_device *pdev)
 			plic_quirks = (unsigned long)id->data;
 	}
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
 	priv->plic_quirks = plic_quirks;
 
-	priv->regs = of_iomap(to_of_node(dev->fwnode), 0);
-	if (WARN_ON(!priv->regs)) {
-		error = -EIO;
-		goto out_free_priv;
-	}
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (WARN_ON(!priv->regs))
+		return -EIO;
 
-	error = -EINVAL;
 	of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", &nr_irqs);
 	if (WARN_ON(!nr_irqs))
-		goto out_iounmap;
+		return -EINVAL;
 
 	priv->nr_irqs = nr_irqs;
 
-	priv->prio_save = bitmap_alloc(nr_irqs, GFP_KERNEL);
+	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
 	if (!priv->prio_save)
-		goto out_free_priority_reg;
+		return -ENOMEM;
 
 	nr_contexts = of_irq_count(to_of_node(dev->fwnode));
 	if (WARN_ON(!nr_contexts))
-		goto out_free_priority_reg;
-
-	error = -ENOMEM;
-	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
-						&plic_irqdomain_ops, priv);
-	if (WARN_ON(!priv->irqdomain))
-		goto out_free_priority_reg;
+		return -EINVAL;
 
 	for (i = 0; i < nr_contexts; i++) {
 		struct of_phandle_args parent;
@@ -539,10 +530,10 @@ static int plic_probe(struct platform_device *pdev)
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 
-		handler->enable_save =  kcalloc(DIV_ROUND_UP(nr_irqs, 32),
-						sizeof(*handler->enable_save), GFP_KERNEL);
+		handler->enable_save = devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
+						    sizeof(*handler->enable_save), GFP_KERNEL);
 		if (!handler->enable_save)
-			goto out_free_enable_reg;
+			return -ENOMEM;
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
@@ -552,6 +543,11 @@ done:
 		nr_handlers++;
 	}
 
+	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
+						&plic_irqdomain_ops, priv);
+	if (WARN_ON(!priv->irqdomain))
+		return -ENOMEM;
+
 	/*
 	 * We can have multiple PLIC instances so setup cpuhp state
 	 * and register syscore operations only once after context
@@ -578,19 +574,6 @@ done:
 	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
 		 nr_irqs, nr_handlers, nr_contexts);
 	return 0;
-
-out_free_enable_reg:
-	for_each_cpu(cpu, cpu_present_mask) {
-		handler = per_cpu_ptr(&plic_handlers, cpu);
-		kfree(handler->enable_save);
-	}
-out_free_priority_reg:
-	kfree(priv->prio_save);
-out_iounmap:
-	iounmap(priv->regs);
-out_free_priv:
-	kfree(priv);
-	return error;
 }
 
 static struct platform_driver plic_driver = {

