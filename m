Return-Path: <linux-kernel+bounces-84019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4851786A16E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F8228A3B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A716D14DFF0;
	Tue, 27 Feb 2024 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oo8mK+td";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nHai63OF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2351C4C;
	Tue, 27 Feb 2024 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068686; cv=none; b=jeSoh73rT9zWeBNyYy8N49FEPJ4Zo9nqRPIIUlUZlPdr0bOGMA7Y5Fmo7X0eRTfvSIN0lmSP+QZCh/pIwtXTpnKatkHndmwgLL2cM0Pbo5hUPwT2fZQ5uIcjh2imF7SKYAD3g1KShRAeZQPywnqKFCxWxH72vUgQAnHXji52nQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068686; c=relaxed/simple;
	bh=qRWsrF2FhlekiFeN6dZF6GoevJxpbJKyFnNtXvb6z0k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jpIA4i/Ifka7BpWlnd+K6zAP5HrxWngNqISXoFqxDPc6Gm9JJkA6pQb0Ifjgkak4MAcXM57WlRmKqcXU30CYvbL+ncv1OZWUuaMC4+9UK128Df3WyxSQhBCIhzNyo+2TJkMEC2Iff8iDfRE8YkQv4u1n+Ca0ZoZfE170Mo4Erq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oo8mK+td; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nHai63OF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 21:18:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709068682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PwhnWrACoSS5MqsaaDh+q42DkYCfvHCT7sWkf3xoyFY=;
	b=oo8mK+tdgDYpkx6A1o7w1+XdEwqYjaBSU7PhafutweCG0Ds9Eh2yN20gbWAWwMj+UzYlWF
	hH10/FKj+9eSi+NSJJFsIgoGkenoOTe0Ab+Ckr/ZCa0/q976gGCG0J9zANZAJx5V3B53+U
	yPAUOI9gDVTNMDIfVxsM2WMWhoA7g8jiy1NTXB5OY+j6TAsOOv/G7ZvzddgCHlEmzoWApT
	uH/wx4LIf1KP0NZSqjGz5/xoPHPBXMvGDZx1WkSCZiv2ehWJn1WXrAfLVZw+RF024SIvyG
	MaNzKiXRLObLeUVmE/edhzERbeXUGxsy+Dg2tdiaiSaj88ZQ/0syGhlh7SJw2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709068682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PwhnWrACoSS5MqsaaDh+q42DkYCfvHCT7sWkf3xoyFY=;
	b=nHai63OFCs/jB/qqzaSHCFpcsRhhJv8p2jNXdQIeI/sKmzKEW2wZG5i4bGCYJwFLYT7Onx
	FPzwncMRyPmR+5Bg==
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
Message-ID: <170906868134.398.608439423720843674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     678c607ecf8a9b1b2ea09c367877164ba66cb11f
Gitweb:        https://git.kernel.org/tip/678c607ecf8a9b1b2ea09c367877164ba66cb11f
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Mon, 26 Feb 2024 09:37:37 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 22:06:32 +01:00

irqchip/riscv-intc: Fix low-level interrupt handler setup for AIA

Use riscv_intc_aia_irq() as the low-level interrupt handler instead of the
existing riscv_intc_irq() default handler to make demultiplexing work
correctly.

Also print "using AIA" in the INTC boot banner when AIA is available.

Fixes: 3c46fc5b5507 ("irqchip/riscv-intc: Add support for RISC-V AIA")
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
 

