Return-Path: <linux-kernel+bounces-101371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EC287A629
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8521A1C216AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28043EA77;
	Wed, 13 Mar 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIBstJiO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XAcpwtoU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F723EA66;
	Wed, 13 Mar 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327350; cv=none; b=utiBpcwr/R7Gie83ZrAYfHkjeAfgnTBxux/52tF9M0In4SNLgdAz/ECbLFiOKm9hlFg11R45mmyA+8BlQMHoPiwzvOBuJ7OyRDBZDOi63J2r5D5axmIsCXehpUiiRDeV7inlfwUNBSg5c0YA5fWzUd/pjfjzOTWMj+y9batEFSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327350; c=relaxed/simple;
	bh=UUNsX9/ItJg6db3U4H5dMXslJ9T0zc2L/ER7GrzlVEI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I08+OGScfha7ugMG5BbUFU0XC6m4UJwU4pYyAOCqSeaP4DcMrbNNXEXNek7QF1nSwk0jfe2pc6ufnJfRpfc7y86qdUKThAV50dcetcYanqCt/xiOl7my2NvnGx2tJdsNSOA3aSlBBimxFyWSvuHCRWx2oodmYpdyABtWrBVkGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIBstJiO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XAcpwtoU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Mar 2024 10:55:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710327347;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0SKrjf1B+cuGJlUUAjW+HNdsWy3Qcniw+d3IjuhWFg=;
	b=TIBstJiOs+Dcz2r3PgZwFsOnwlqqNrwv3+NuwMw01C4fX1KuARpcpniaea/MMeSXdMt6WW
	zVCJ96bw4mM/VauHuzU4M1CObrFas194jOVG0ZUPG32vRGGAkq1t2yjdtbrGkV3OkVSFuT
	Tl/r9iTgcV8cPCfT/QaAPCNJnboGCD0G6AdOUh6v2nMkro0n3tR6U1oZypiCbipIUmFBfL
	yGvNRkvqOS4sxHvGIMIKpmVaoLKv3hlu+BbIONEibET8Nu7wU2wBqP0319vWUPKwsdp7bH
	P7LVmlaj/Ujrh5UMD1S6oajFpP4jZvoav8lh0mD2thQT8/GBXxPOnRIQ9gDvCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710327347;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0SKrjf1B+cuGJlUUAjW+HNdsWy3Qcniw+d3IjuhWFg=;
	b=XAcpwtoUv2HG3gDeIqWSjZ+bKttkIIwhBkK5b7WtUl9kM0JyBleHMOiOMTT4b/B9wViJdP
	gJt8ze98LJ++8GDA==
From: "tip-bot2 for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/riscv-intc: Fix use of AIA interrupts 32-63
 on riscv32
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240312212813.2323841-1-samuel.holland@sifive.com>
References: <20240312212813.2323841-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171032734600.398.4666803374287322577.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     4ce937160ba053789f96d5130d5de4deaee2ad23
Gitweb:        https://git.kernel.org/tip/4ce937160ba053789f96d5130d5de4deaee2ad23
Author:        Samuel Holland <samuel.holland@sifive.com>
AuthorDate:    Tue, 12 Mar 2024 14:28:08 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 Mar 2024 11:50:11 +01:00

irqchip/riscv-intc: Fix use of AIA interrupts 32-63 on riscv32

riscv_intc_custom_base is initialized to BITS_PER_LONG, so the second
check passes even though AIA provides 64 interrupts. Adjust the condition to
only check the custom range for interrupts outside the standard range, and
adjust the standard range when AIA is available.

Fixes: bb7921cdea12 ("irqchip/riscv-intc: Add support for RISC-V AIA")
Fixes: e6bd9b966dc8 ("irqchip/riscv-intc: Fix low-level interrupt handler setup for AIA")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anup Patel <anup@brainfault.org> 
Link: https://lore.kernel.org/r/20240312212813.2323841-1-samuel.holland@sifive.com
---
 drivers/irqchip/irq-riscv-intc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index f87aeab..9e71c44 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -149,8 +149,9 @@ static int riscv_intc_domain_alloc(struct irq_domain *domain,
 	 * Only allow hwirq for which we have corresponding standard or
 	 * custom interrupt enable register.
 	 */
-	if ((hwirq >= riscv_intc_nr_irqs && hwirq < riscv_intc_custom_base) ||
-	    (hwirq >= riscv_intc_custom_base + riscv_intc_custom_nr_irqs))
+	if (hwirq >= riscv_intc_nr_irqs &&
+	    (hwirq < riscv_intc_custom_base ||
+	     hwirq >= riscv_intc_custom_base + riscv_intc_custom_nr_irqs))
 		return -EINVAL;
 
 	for (i = 0; i < nr_irqs; i++) {
@@ -183,10 +184,12 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn, struct irq_ch
 		return -ENXIO;
 	}
 
-	if (riscv_isa_extension_available(NULL, SxAIA))
+	if (riscv_isa_extension_available(NULL, SxAIA)) {
+		riscv_intc_nr_irqs = 64;
 		rc = set_handle_irq(&riscv_intc_aia_irq);
-	else
+	} else {
 		rc = set_handle_irq(&riscv_intc_irq);
+	}
 	if (rc) {
 		pr_err("failed to set irq handler\n");
 		return rc;
@@ -195,7 +198,7 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn, struct irq_ch
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
 
 	pr_info("%d local interrupts mapped%s\n",
-		riscv_isa_extension_available(NULL, SxAIA) ? 64 : riscv_intc_nr_irqs,
+		riscv_intc_nr_irqs,
 		riscv_isa_extension_available(NULL, SxAIA) ? " using AIA" : "");
 	if (riscv_intc_custom_nr_irqs)
 		pr_info("%d custom local interrupts mapped\n", riscv_intc_custom_nr_irqs);

