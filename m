Return-Path: <linux-kernel+bounces-157648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB098B1405
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E4A1F2423C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B0B13B59F;
	Wed, 24 Apr 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4oHNXR2f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hECedFK/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D69143878;
	Wed, 24 Apr 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989055; cv=none; b=dQwK1bnIGPxE7WBLJoJ4WMtv5Sn9Z8NpuGd5Dit8qR3f5c08bkvYJ0yrwt3t9cCfwLNRR0y2lGEF+4Zwt3AauK+sKgUOgA07lpjCDyaNlQMFMGmm1PT0Wqzbo67F3r2Ng5b5AUo5wHiyC2C91GTrx5aHD2ypcC8dgTJXEoVssT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989055; c=relaxed/simple;
	bh=evdbgZzDIIuQPOxc6b5ueItS9nng/hH/QWa/LXIXMlU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rZxKwN/WKEJ3Ni18qWjsXJ5vE0h0NK31ZP/TfjV2SLgXsaExupjeFacQM5UX4I8noaCLbGMkMOhgx4dojIQREpwZwdaxdkRe7okuIvSYex0Ca1flTvpgb/dyd+THlclULyNvopVj+zY2kc+9dpeBAFF26sF1CX0yCwu+QCGb28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4oHNXR2f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hECedFK/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 20:04:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713989047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g31eNiIar8EHGpPwJvz0j6LutnAx2RKP5X0CxYEOyuw=;
	b=4oHNXR2f8n9Rs3GxXiH4jcATSP+Js6vHbuNbS1nQFMk9Oo5F09p6FrVaPUEYcGoE+1lDpX
	0PPS2O7sn1QilFOqiPW5P3RgI1ayKZpPPxUC9yUprJLO/EgP5rQQSVRuGYj1gdYZIiEMvr
	sc7+YSK/Qjl5LU3fe8HigFY0HDJZOQ6egXkcMe4smduEihxslczydQb3ACAH4kLa/CCl/d
	G2Bz2Ec0I0CrOVQgr9k8tTkf1zpyrKQfR4MrkO2UvNwX6yeeTQQ2gP+yfcfozLBtlSgAKB
	KCaQuOoy9GE9LEdE6aS1gS7keOE6MBLtJW6ggYcdTI0YxVuk6ze2qmEQcXJ6Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713989047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g31eNiIar8EHGpPwJvz0j6LutnAx2RKP5X0CxYEOyuw=;
	b=hECedFK/PE5X5ZHTH843ySnGauT5oWPUBB/gEULuuu0PzonQBGIabtI3W9l79ytiakdSW6
	dW8uSTlJZ+ug0PBQ==
From: "tip-bot2 for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-brcmstb-l2: Avoid saving mask on shutdown
Cc: Tim Ross <tim.ross@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240424175732.1526531-1-florian.fainelli@broadcom.com>
References: <20240424175732.1526531-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171398904763.10875.14850183549093538755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c7cad38d37486668a448215fc92bace9c8cf747a
Gitweb:        https://git.kernel.org/tip/c7cad38d37486668a448215fc92bace9c8cf747a
Author:        Florian Fainelli <florian.fainelli@broadcom.com>
AuthorDate:    Wed, 24 Apr 2024 10:57:32 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Apr 2024 21:11:48 +02:00

irqchip/irq-brcmstb-l2: Avoid saving mask on shutdown

The interrupt controller shutdown path does not need to save the mask of
enabled interrupts because the next state the system is going to be in is
akin to a cold boot, or a kexec'd kernel. Saving the mask only makes sense
if the software state needs to preserve the hardware state across a system
suspend/resume cycle.

As an optimization, and given that there are systems with dozens of such
interrupt controller, save a "slow" memory mapped I/O read in the shutdown
path where no saving/restoring is required.

Reported-by: Tim Ross <tim.ross@broadcom.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240424175732.1526531-1-florian.fainelli@broadcom.com

---
 drivers/irqchip/irq-brcmstb-l2.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 2b0b317..c988886 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -118,7 +118,7 @@ out:
 	chained_irq_exit(chip, desc);
 }
 
-static void brcmstb_l2_intc_suspend(struct irq_data *d)
+static void __brcmstb_l2_intc_suspend(struct irq_data *d, bool save)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
@@ -127,7 +127,8 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 
 	irq_gc_lock_irqsave(gc, flags);
 	/* Save the current mask */
-	b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
+	if (save)
+		b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
 
 	if (b->can_wake) {
 		/* Program the wakeup mask */
@@ -137,6 +138,16 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 	irq_gc_unlock_irqrestore(gc, flags);
 }
 
+static void brcmstb_l2_intc_shutdown(struct irq_data *d)
+{
+	__brcmstb_l2_intc_suspend(d, false);
+}
+
+static void brcmstb_l2_intc_suspend(struct irq_data *d)
+{
+	__brcmstb_l2_intc_suspend(d, true);
+}
+
 static void brcmstb_l2_intc_resume(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
@@ -252,7 +263,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 
 	ct->chip.irq_suspend = brcmstb_l2_intc_suspend;
 	ct->chip.irq_resume = brcmstb_l2_intc_resume;
-	ct->chip.irq_pm_shutdown = brcmstb_l2_intc_suspend;
+	ct->chip.irq_pm_shutdown = brcmstb_l2_intc_shutdown;
 
 	if (data->can_wake) {
 		/* This IRQ chip can wake the system, set all child interrupts

