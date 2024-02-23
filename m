Return-Path: <linux-kernel+bounces-78056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50356860E75
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059F728727D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85B65DF26;
	Fri, 23 Feb 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+1L3A3K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u+z4cMLB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9E5D489;
	Fri, 23 Feb 2024 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681447; cv=none; b=g11P5VfUNe2+bmMwLWXacXVcwiSfm08N4Cj+O6ID1M6HNaQclYYRiejcQAkBL6QyuK60svC1nV4T+tTem/voQlgI563+FQQhDRWXuCrZNhNxyfuhRvy4GVshZCK+oy42+imuFsk4cxgKyf4vFfEAFLCM8kcMylUkA1o/evo9C8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681447; c=relaxed/simple;
	bh=f5hvvf5fHYTj7NQED/7gg0VO6sDmyiq3Zrw3I+C2i00=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=imylIfELlvRkCvbbbwl864ALh0SMJH2OVTDi2tHGgmBgf6ThaEUlPe3LtBAIL8U5Ll4IzH2kRcDGrzLlASX0eW4qHgzP2FkpqWbvIc08vgVZa5Md3LqaSVOIFdcvYdMO/4bGdMPa3bXQtWkhct/SJJg/e4JSKcO/w461RHdRu68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T+1L3A3K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u+z4cMLB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 09:44:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708681441;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZCKYvQvX/V27zysA35fscLc4hAb9T4pRSH1fsvjbGs=;
	b=T+1L3A3KEED99NSEQ1IdjA8HROiQYopb7kXmMzPyf2fJZxdKEyIIw6OloJDbRxIJ9GiN8Q
	CvrgPdlp5WcwgPwv0T2fPEN2ObF2ycQCnGgUqGoXxZKimlmG8G782nebYRt+wy/hb8M78e
	kBltWO4EHEgDv6HCQAmw8caRSq5Zo0HoM2umWcdbcGEHPtmJsA7eT5ndI74eG81eMmBwmD
	R02UoKZ5Z/dTcnWCAPZYuApslFUnEAOMHwqQKrSSeg1aOgBo1SESitvThnc+QxSHVQqSNl
	tAImKDWUVjnT4Hx6njjdkogNfxaaRbtHBndA4jmRYJlJdhfcWmXmx6jBSuXDNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708681441;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZCKYvQvX/V27zysA35fscLc4hAb9T4pRSH1fsvjbGs=;
	b=u+z4cMLBFKOsUPXq2O/dmRQvn9aCo9zwBLzR05ZvqvdghGRwl+Oe98bec/4Iet78w1aE9S
	UuKyNIXKc4GZxSDA==
From: "tip-bot2 for Yu Chien Peter Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] irqchip/riscv-intc: Allow large non-standard interrupt number
Cc: Yu Chien Peter Lin <peterlin@andestech.com>,
 Thomas Gleixner <tglx@linutronix.de>, Randolph <randolph@andestech.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240222083946.3977135-3-peterlin@andestech.com>
References: <20240222083946.3977135-3-peterlin@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170868144033.398.6153636773103697821.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     96303bcb401c21dc1426d8d9bb1fc74aae5c02a9
Gitweb:        https://git.kernel.org/tip/96303bcb401c21dc1426d8d9bb1fc74aae5c02a9
Author:        Yu Chien Peter Lin <peterlin@andestech.com>
AuthorDate:    Thu, 22 Feb 2024 16:39:38 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Feb 2024 09:57:42 +01:00

irqchip/riscv-intc: Allow large non-standard interrupt number

Currently, the implementation of the RISC-V INTC driver uses the
interrupt cause as the hardware interrupt number, with a maximum of
64 interrupts. However, the platform can expand the interrupt number
further for custom local interrupts.

To fully utilize the available local interrupt sources, switch
to using irq_domain_create_tree() that creates the radix tree
map, add global variables (riscv_intc_nr_irqs, riscv_intc_custom_base
and riscv_intc_custom_nr_irqs) to determine the valid range of local
interrupt number (hwirq).

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Randolph <randolph@andestech.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Link: https://lore.kernel.org/r/20240222083946.3977135-3-peterlin@andestech.com

---
 drivers/irqchip/irq-riscv-intc.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index e8d01b1..684875c 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -19,15 +19,16 @@
 #include <linux/smp.h>
 
 static struct irq_domain *intc_domain;
+static unsigned int riscv_intc_nr_irqs __ro_after_init = BITS_PER_LONG;
+static unsigned int riscv_intc_custom_base __ro_after_init = BITS_PER_LONG;
+static unsigned int riscv_intc_custom_nr_irqs __ro_after_init;
 
 static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 {
 	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
 
-	if (unlikely(cause >= BITS_PER_LONG))
-		panic("unexpected interrupt cause");
-
-	generic_handle_domain_irq(intc_domain, cause);
+	if (generic_handle_domain_irq(intc_domain, cause))
+		pr_warn_ratelimited("Failed to handle interrupt (cause: %ld)\n", cause);
 }
 
 /*
@@ -93,6 +94,14 @@ static int riscv_intc_domain_alloc(struct irq_domain *domain,
 	if (ret)
 		return ret;
 
+	/*
+	 * Only allow hwirq for which we have corresponding standard or
+	 * custom interrupt enable register.
+	 */
+	if ((hwirq >= riscv_intc_nr_irqs && hwirq < riscv_intc_custom_base) ||
+	    (hwirq >= riscv_intc_custom_base + riscv_intc_custom_nr_irqs))
+		return -EINVAL;
+
 	for (i = 0; i < nr_irqs; i++) {
 		ret = riscv_intc_domain_map(domain, virq + i, hwirq + i);
 		if (ret)
@@ -117,8 +126,7 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
 {
 	int rc;
 
-	intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
-					       &riscv_intc_domain_ops, NULL);
+	intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops, NULL);
 	if (!intc_domain) {
 		pr_err("unable to add IRQ domain\n");
 		return -ENXIO;
@@ -132,7 +140,11 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
 
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
 
-	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
+	pr_info("%d local interrupts mapped\n", riscv_intc_nr_irqs);
+	if (riscv_intc_custom_nr_irqs) {
+		pr_info("%d custom local interrupts mapped\n",
+			riscv_intc_custom_nr_irqs);
+	}
 
 	return 0;
 }

