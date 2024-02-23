Return-Path: <linux-kernel+bounces-78049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741F3860E65
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C75287020
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEED5CDCE;
	Fri, 23 Feb 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tIH4JwsV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bDG8t8Fj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06111642A;
	Fri, 23 Feb 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681442; cv=none; b=Ezwgsa/ASl7LKE1zncLpCvWq3BQJ9PxEQ6U8TeyD1B5P+pKLwB4IaNHvFEhmuxGN4jjT+cHfIgwjGP4la9BKAfZrvcLZy+H4se66+EaHW+TeCaiBOuHCzvE8BhoZX4ji2VYH7Fidtp45B2EH0lOqF0Qw7OUYne1qKG1nBHUuKuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681442; c=relaxed/simple;
	bh=vYSSZVoi/wBbqaWlFLBAgIMVOuN0+7HYb6A3C7Km8m0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z36NOQrpm1cyUged6MxnQTlqdvBs8QYTyn2/BUf+s1QqxoOCs05owlE81TpY5E7zVjIs8wwWZP9Wn/QQwHaGng3lXyfzwNf2EerNT6lWvB5UMd1Ti3mOQXXLmkhHN27JCtaM9dSdjDRm+333A1ne8Es0NqQG+l+Dm4qsGFlgrt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tIH4JwsV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bDG8t8Fj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 09:43:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708681433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhY6wNGyVkEGV1ZTL629R+rhoNXWo3iUoaalM1Zf5wY=;
	b=tIH4JwsVq1pU4s9erNVKEj/c73GWhTmRyqYSU+H4wklcZIRWImqF9r2OU7U6ausDb27jS/
	WTX7expgav5xGGh2l9d699yJCgBsEdgKPLMqrZc1DMwrMKwPZR98UeGGq5Wn/TQ6hVYUKD
	RXtWl+AVnvfDZ59VM6y2YoF4/L1LY95ELMfyRY3mOxVQC8KIbydzMmec85YQq2uLdpu3wQ
	VIKdgbF8Ym792iSMAwnU3BHA5uydW7wsOhqNtReaKNqkDlFR8k1DgPMLlK4vBBSMYaVDqC
	hv5QH3ezQZU++2tL8qMjj8VLl/axYTpNLR2XzUunOm6J6dqlg0df/8EYf8SkLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708681433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhY6wNGyVkEGV1ZTL629R+rhoNXWo3iUoaalM1Zf5wY=;
	b=bDG8t8Fjq3dBOcp5tyhe8k/FdV+bQXYfUe/d10wWBr3w0mQfsat6Fas9yRVvp73XhWxZ2r
	XdVhdO47KMQp/sAw==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/riscv-intc: Add support for RISC-V AIA
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240222094006.1030709-9-apatel@ventanamicro.com>
References: <20240222094006.1030709-9-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170868143221.398.5826038525907165938.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     3c46fc5b5507be1f4aa144a1fbd83b0ccba04cc6
Gitweb:        https://git.kernel.org/tip/3c46fc5b5507be1f4aa144a1fbd83b0ccba04cc6
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 22 Feb 2024 15:09:56 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Feb 2024 10:18:44 +01:00

irqchip/riscv-intc: Add support for RISC-V AIA

The RISC-V advanced interrupt architecture (AIA) extends the per-HART
local interrupts in following ways:
1. Minimum 64 local interrupts for both RV32 and RV64
2. Ability to process multiple pending local interrupts in same
   interrupt handler
3. Priority configuration for each local interrupts
4. Special CSRs to configure/access the per-HART MSI controller

Add support for #1 and #2 described above in the RISC-V intc driver.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240222094006.1030709-9-apatel@ventanamicro.com

---
 drivers/irqchip/irq-riscv-intc.c | 32 ++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 0cd6b48..cccb653 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -19,6 +19,8 @@
 #include <linux/smp.h>
 #include <linux/soc/andes/irq.h>
 
+#include <asm/hwcap.h>
+
 static struct irq_domain *intc_domain;
 static unsigned int riscv_intc_nr_irqs __ro_after_init = BITS_PER_LONG;
 static unsigned int riscv_intc_custom_base __ro_after_init = BITS_PER_LONG;
@@ -32,6 +34,14 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 		pr_warn_ratelimited("Failed to handle interrupt (cause: %ld)\n", cause);
 }
 
+static asmlinkage void riscv_intc_aia_irq(struct pt_regs *regs)
+{
+	unsigned long topi;
+
+	while ((topi = csr_read(CSR_TOPI)))
+		generic_handle_domain_irq(intc_domain, topi >> TOPI_IID_SHIFT);
+}
+
 /*
  * On RISC-V systems local interrupts are masked or unmasked by writing
  * the SIE (Supervisor Interrupt Enable) CSR.  As CSRs can only be written
@@ -41,12 +51,18 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 
 static void riscv_intc_irq_mask(struct irq_data *d)
 {
-	csr_clear(CSR_IE, BIT(d->hwirq));
+	if (IS_ENABLED(CONFIG_32BIT) && d->hwirq >= BITS_PER_LONG)
+		csr_clear(CSR_IEH, BIT(d->hwirq - BITS_PER_LONG));
+	else
+		csr_clear(CSR_IE, BIT(d->hwirq));
 }
 
 static void riscv_intc_irq_unmask(struct irq_data *d)
 {
-	csr_set(CSR_IE, BIT(d->hwirq));
+	if (IS_ENABLED(CONFIG_32BIT) && d->hwirq >= BITS_PER_LONG)
+		csr_set(CSR_IEH, BIT(d->hwirq - BITS_PER_LONG));
+	else
+		csr_set(CSR_IE, BIT(d->hwirq));
 }
 
 static void andes_intc_irq_mask(struct irq_data *d)
@@ -157,8 +173,7 @@ static struct fwnode_handle *riscv_intc_hwnode(void)
 	return intc_domain->fwnode;
 }
 
-static int __init riscv_intc_init_common(struct fwnode_handle *fn,
-					 struct irq_chip *chip)
+static int __init riscv_intc_init_common(struct fwnode_handle *fn, struct irq_chip *chip)
 {
 	int rc;
 
@@ -176,11 +191,10 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn,
 
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
 
-	pr_info("%d local interrupts mapped\n", riscv_intc_nr_irqs);
-	if (riscv_intc_custom_nr_irqs) {
-		pr_info("%d custom local interrupts mapped\n",
-			riscv_intc_custom_nr_irqs);
-	}
+	pr_info("%d local interrupts mapped\n",
+		riscv_isa_extension_available(NULL, SxAIA) ? 64 : riscv_intc_nr_irqs);
+	if (riscv_intc_custom_nr_irqs)
+		pr_info("%d custom local interrupts mapped\n", riscv_intc_custom_nr_irqs);
 
 	return 0;
 }

