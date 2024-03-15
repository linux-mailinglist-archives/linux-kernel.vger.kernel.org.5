Return-Path: <linux-kernel+bounces-104820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9290C87D42A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3335CB24042
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541E04CB2E;
	Fri, 15 Mar 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ReO8aO66";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D49YwmD0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB63D0A8;
	Fri, 15 Mar 2024 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528862; cv=none; b=Xc3kWuHsYIHqBteCEMrdiqLHmJEVkUzF6fOSctEjqI2bKY585ce4w2MS6JlBniv1eLigYO2Z8oLhFPK8wZydvOO0/NyEXi8KjpdazTHWAt2Vt8AOLYWFSoIawEWXnkgEBkSqSNkcXS5snAoEAqdh40jtbNTDhVe2tfZMEPLcHZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528862; c=relaxed/simple;
	bh=feimc6jM67HN7gI7It7/j2BTmKRhRVhKuUuM48nFIdo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jQyIEsapJOsbd9gIMTf3nYLuouJrf02wrQkNvtkFGhaRY3gbvxSafc3ZMhZMCGoKb/Cg6NqPK9fZbRtTrLkIWbIV5csOYVlpP1yciT1+27tGJAddLkN/zfLZpkOouZCctWHZwMFnjz1QNlyvDPKQFE8DCvuxsFewkbnCX5ljvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ReO8aO66; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D49YwmD0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Mar 2024 18:54:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710528856;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPKkcPuOFIpkaKIsMte17P8BpdtZi5h0O99T2RQBzRU=;
	b=ReO8aO665vFV4JurvoBM1tgqIONuB429Qjdd/ZgEGlG+Pd9RHDBCA+f95yXa/xSDBe+xBq
	kpHUzVfERaYculuHiVlc4evxf+iDR12TZpC0gh2Ae5IMtO1thFi0OEGnQm2p4kmzwpTG07
	UlRWHzXqVNPxIcXj33Nntc2dNV0fl0n8FkzOdbwkY7kd9KBRd5QQ/+F5l+eZA1csiDuiX9
	CDE2lZRNjgczGNVPebG2417B3KCiv08qxIVSNzCYyDo/HOYJ5l/4lF4QG1ygm4wzqHNOJ8
	BfujhAaGVtqDcMlZ6sh27sJDoHbqAt4VPw4pDRpouNk5qM4J0ZyhMMk4crzN0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710528856;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPKkcPuOFIpkaKIsMte17P8BpdtZi5h0O99T2RQBzRU=;
	b=D49YwmD0eDVWGBQBUBTw1cMzc4QpYRQiHI2JegE4Xbypb2sc9j9+soIK7JGkQBcW7bjY0J
	SuYNsmbWsC2VnTCg==
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
Message-ID: <171052885556.398.16577241789308728479.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     ca5b0b717b75d0f86f7f5dfe18369781bec742ad
Gitweb:        https://git.kernel.org/tip/ca5b0b717b75d0f86f7f5dfe18369781bec742ad
Author:        Samuel Holland <samuel.holland@sifive.com>
AuthorDate:    Tue, 12 Mar 2024 14:28:08 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 Mar 2024 15:27:02 +01:00

irqchip/riscv-intc: Fix use of AIA interrupts 32-63 on riscv32

riscv_intc_custom_base is initialized to BITS_PER_LONG, so the second
check passes even though AIA provides 64 interrupts. Adjust the condition to
only check the custom range for interrupts outside the standard range, and
adjust the standard range when AIA is available.

Fixes: 3c46fc5b5507 ("irqchip/riscv-intc: Add support for RISC-V AIA")
Fixes: 678c607ecf8a ("irqchip/riscv-intc: Fix low-level interrupt handler setup for AIA")
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

