Return-Path: <linux-kernel+bounces-78055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2151860E76
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A2828748D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE4F5CDCA;
	Fri, 23 Feb 2024 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G2uWfWUh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H/3jTG8f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA595CDF2;
	Fri, 23 Feb 2024 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681446; cv=none; b=Be9R0VkXj712htVtW6smO39nWSGsGKat7FXwMha/M079soe/nI3y93iIvhhLemgWLtXBWFo01faaPStZR52XaMYTlthEZTNW5xc1aBqvYYzhZxXhm3AF143EA2HCE1hU6Z3RamCznlU4VBeSuCw8kXjNH8hLE/V3KiL2tadrXwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681446; c=relaxed/simple;
	bh=9dCh/XBicUP7Daf6/HNwo0G0QzLlzPM89+f0jnhuZ5k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Pth814FpGco3yltqTLMbGA/ZFMVDLgf3pyi7S35U1JnyN0DR+bhJBiaRPuxl8HSosgistCeAa8r6ZrOwdXgc8hPSIyoNNEzKwmhsh6Y2ILgLCY4Zg+AukWrT7c4EpXZ9lPIoBcas+LPOpLqBEWDjQ8ecY2OKAtVsVgDQeZe4tg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G2uWfWUh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H/3jTG8f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 09:43:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708681438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWLbxZOz2VVepFJ76j+S+oXb77wUC0lhraw/tOL0sA8=;
	b=G2uWfWUhRPLbi6bBs6INm6VnTdYe4SDNWlDl/tL8upfW4eRBe4iAi4cLSHz+MyFMa2PgGZ
	P2yj4O93ApS9TYclEL3w2t7EmJIIUpxfs7qm6M2QDdOjfdRVi12VljhSGIUTRr4wbwV6AP
	nglX8Lnayn0NUbTjZHeEitrRK3lpv+xZwsjSN1aICtWjjqKVjm0lFlFhZSfcSazCc8Ov3s
	c50uJtk5GzJQeXlFQN+DpLI4zhb1UMifew2DDuwDzQ9QxR8oxRJk5vgkYLJ27U7Kct+eOT
	gWlInxq+JYU4fN5qb7uot5ZS4lgiJHn/elvGlGEYb+O4xuqydBn+FVJ7ag6u/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708681438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWLbxZOz2VVepFJ76j+S+oXb77wUC0lhraw/tOL0sA8=;
	b=H/3jTG8f0G4GioXa8SkyHqbfVz4gXjS7J8rLC92x9ARvcGoxEZEfDSwGYDRtIyV7TMrPPJ
	uRs8QEVYZ5fTjfBw==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] irqchip/sifive-plic: Use dev_xyz() in-place of pr_xyz()
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240222094006.1030709-3-apatel@ventanamicro.com>
References: <20240222094006.1030709-3-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170868143763.398.16716590973406571859.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     25d862e183d4efeb5e8b9843d783c90aaae4b14a
Gitweb:        https://git.kernel.org/tip/25d862e183d4efeb5e8b9843d783c90aaae4b14a
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 22 Feb 2024 15:09:50 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Feb 2024 10:18:43 +01:00

irqchip/sifive-plic: Use dev_xyz() in-place of pr_xyz()

Use dev_info(), dev_warn(), and dev_err() in-place of pr_info(),
pr_warn(), and pr_err().

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240222094006.1030709-3-apatel@ventanamicro.com

---
 drivers/irqchip/irq-sifive-plic.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 7400a07..892666f 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 SiFive
  * Copyright (C) 2018 Christoph Hellwig
  */
-#define pr_fmt(fmt) "plic: " fmt
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -371,9 +370,10 @@ static void plic_handle_irq(struct irq_desc *desc)
 	while ((hwirq = readl(claim))) {
 		int err = generic_handle_domain_irq(handler->priv->irqdomain,
 						    hwirq);
-		if (unlikely(err))
-			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
-					hwirq);
+		if (unlikely(err)) {
+			dev_warn_ratelimited(handler->priv->dev,
+					     "can't find mapping for hwirq %lu\n", hwirq);
+		}
 	}
 
 	chained_irq_exit(chip, desc);
@@ -401,7 +401,7 @@ static int plic_starting_cpu(unsigned int cpu)
 		enable_percpu_irq(plic_parent_irq,
 				  irq_get_trigger_type(plic_parent_irq));
 	else
-		pr_warn("cpu%d: parent irq not available\n", cpu);
+		dev_warn(handler->priv->dev, "cpu%d: parent irq not available\n", cpu);
 	plic_set_threshold(handler, PLIC_ENABLE_THRESHOLD);
 
 	return 0;
@@ -477,7 +477,7 @@ static int plic_probe(struct platform_device *pdev)
 		unsigned long hartid;
 
 		if (of_irq_parse_one(to_of_node(dev->fwnode), i, &parent)) {
-			pr_err("failed to parse parent for context %d.\n", i);
+			dev_err(dev, "failed to parse parent for context %d.\n", i);
 			continue;
 		}
 
@@ -500,13 +500,13 @@ static int plic_probe(struct platform_device *pdev)
 
 		error = riscv_of_parent_hartid(parent.np, &hartid);
 		if (error < 0) {
-			pr_warn("failed to parse hart ID for context %d.\n", i);
+			dev_warn(dev, "failed to parse hart ID for context %d.\n", i);
 			continue;
 		}
 
 		cpu = riscv_hartid_to_cpuid(hartid);
 		if (cpu < 0) {
-			pr_warn("Invalid cpuid for context %d\n", i);
+			dev_warn(dev, "Invalid cpuid for context %d\n", i);
 			continue;
 		}
 
@@ -525,7 +525,7 @@ static int plic_probe(struct platform_device *pdev)
 		 */
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		if (handler->present) {
-			pr_warn("handler already present for context %d.\n", i);
+			dev_warn(dev, "handler already present for context %d.\n", i);
 			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
 			goto done;
 		}
@@ -575,8 +575,8 @@ done:
 		}
 	}
 
-	pr_info("%pOFP: mapped %d interrupts with %d handlers for %d contexts.\n",
-		to_of_node(dev->fwnode), nr_irqs, nr_handlers, nr_contexts);
+	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
+		 nr_irqs, nr_handlers, nr_contexts);
 	return 0;
 
 out_free_enable_reg:

