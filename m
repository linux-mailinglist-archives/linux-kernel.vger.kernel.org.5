Return-Path: <linux-kernel+bounces-81602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CEF86781A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2519A1F2368E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C82129A88;
	Mon, 26 Feb 2024 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Di2Qs7Tr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NiEdbtvB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829C129A60;
	Mon, 26 Feb 2024 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957318; cv=none; b=JChThJajkzq9nAbWH08z+WvI40IVtaFW6qJY9vni9DqfDRUdjrhSNUCHG24PNIWhu/nPHGLR1y7qOmaEsz7rEtt8OW2oSJ+vDIDJcqTIDV6s8m1Paor1j5fuPx+OQwjoYfpzx+aELS2WVrP7fW2qv3R4g6nWoyaqaVmrBQZgJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957318; c=relaxed/simple;
	bh=8WvnMs1Oiazuwc6Dj/9PvxJnw9utvTorR83BBqq8Wqs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XMcngifRfCFocLsYNdjnVOTYoNYSFpP1p9igCZGIr2lGzQH1jV37v5abqFV45R4olnYW72B8Co8IAm3hd2hlRHttGYiDeT73ljVsDqqxNKVJ5d43rX30RU0Vmcw59uon7NE9u4hWNOjdhU949So8VuJ3dfm0IzvxocgdzF3iiro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Di2Qs7Tr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NiEdbtvB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 14:21:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708957315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGUxh/MpWYF6modd4VritjfskWdY8aSRe1GkrlnbTQA=;
	b=Di2Qs7TrAa2MgtDtmguDRlrZmdoIB89lLyOmDpnBfH9OltqDbh5wq16MUEVBKtDLTI3doi
	oBYdJoKHM/YInW5JarZKTA+7dWUt7qOW1dbzrv2ETXG7V5I0+IPKG+BCQ0eSnru5uTU9GV
	7cxId1os4xPbbMiEJhA4JSDIPU/4W87NfK8DJtWosZ85sC1vKLulfEDwfIq/xdIqXMYAET
	XPkOlctdB+pqHF543t1M2EPkQxLYof8w9cYIwSVlFe4swEH/LlukekaxTvpIgVxhmWUKvo
	J/mqsbb+PlfeAWJs5XbTaUzOir2j+lAALIbAZqKObzAxAll0L+rSEZH0BUsnPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708957315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGUxh/MpWYF6modd4VritjfskWdY8aSRe1GkrlnbTQA=;
	b=NiEdbtvBxmtCUquJSccOpFvW9AT/gTzjEHemVi8YHgmMusxlpeH3Y5pM9pmkX2+QC/T20T
	pZZKajuszzxaOFBA==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/riscv-intc: Fix low-level interrupt handler
 setup for AIA
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240226040746.1396416-2-apatel@ventanamicro.com>
References: <20240226040746.1396416-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170895731463.398.6136319036686107784.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     1abea7339b404bd79bb26976471e3bf8e6080f47
Gitweb:        https://git.kernel.org/tip/1abea7339b404bd79bb26976471e3bf8e6080f47
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Mon, 26 Feb 2024 09:37:37 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 15:17:11 +01:00

irqchip/riscv-intc: Fix low-level interrupt handler setup for AIA

Use riscv_intc_aia_irq() as the low-level interrupt handler instead of the
existing riscv_intc_irq() default handler to make demultiplexing work
correctly.

Also print "using AIA" in the INTC boot banner when AIA is available.

Fixes: c1be2ae5987a ("irqchip/riscv-intc: Add support for RISC-V AIA")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240226040746.1396416-2-apatel@ventanamicro.com
---
 drivers/irqchip/irq-riscv-intc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index cccb653..f87aeab 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -183,7 +183,10 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn, struct irq_ch
 		return -ENXIO;
 	}
 
-	rc = set_handle_irq(&riscv_intc_irq);
+	if (riscv_isa_extension_available(NULL, SxAIA))
+		rc = set_handle_irq(&riscv_intc_aia_irq);
+	else
+		rc = set_handle_irq(&riscv_intc_irq);
 	if (rc) {
 		pr_err("failed to set irq handler\n");
 		return rc;
@@ -191,8 +194,9 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn, struct irq_ch
 
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
 
-	pr_info("%d local interrupts mapped\n",
-		riscv_isa_extension_available(NULL, SxAIA) ? 64 : riscv_intc_nr_irqs);
+	pr_info("%d local interrupts mapped%s\n",
+		riscv_isa_extension_available(NULL, SxAIA) ? 64 : riscv_intc_nr_irqs,
+		riscv_isa_extension_available(NULL, SxAIA) ? " using AIA" : "");
 	if (riscv_intc_custom_nr_irqs)
 		pr_info("%d custom local interrupts mapped\n", riscv_intc_custom_nr_irqs);
 

