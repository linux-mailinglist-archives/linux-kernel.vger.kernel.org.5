Return-Path: <linux-kernel+bounces-154111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3578AD779
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03821F21B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784A845970;
	Mon, 22 Apr 2024 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DKg5imOs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c/ArD7Iw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5102B43AB4;
	Mon, 22 Apr 2024 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825917; cv=none; b=aZ9cb/wn45+DWHeMAd8aPZCYIo9jDNRgq2+GqjcxLgJse9K70+S1Yd3xpykwFsBNN3EArecahl16lkq3UPuykwA9h91NGVkU+gjVe4cs4s82q/iLNNnp22UpJyYkzs4i/RRYPLmf4Z5xHJt3pA5EKo20yB779bYiVzpe9TMfMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825917; c=relaxed/simple;
	bh=0zHpxMDoP93I9hPy6H94DV+PFCpHKhikr7bi/VR1DAw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dp8z5179qrNOfmQfK9S9kDjNIMDwJ6AnHPRajwNTjU1tt5o2cDwTR1VDUFuhEBls+GYE/cGDfYsu0gjoP4zig197UHo54Z8ne9X8CX0hFeqNq9xo6Tdvk3ZJUILXdoBQdpwslm8EvSOa3d2LbQ10vKhvaXURayFZXR4YE3hozdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DKg5imOs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c/ArD7Iw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 22:45:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713825914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1l+fFrcb1tm2/Q1rBkMseDDo+cTSQcy2epINamvW+E=;
	b=DKg5imOs0AB94TlY2Bdicnu5VChznn9aC/CAuNDUKNcYIAqUETIU/5ovBFr4WLO97AeY8Y
	d7hTHwlJlTgKxsx3pKlKBDyqM7Guwy6VU3f1712wxCr1y8COmumWR/agbVnoarkT4mqXxy
	yI9IzS5SQhnqXubS4G5k1xPj1dRxONKQVj6uY9YJC0VIWSn+aEvGgoIWA4mSjrNRE4p9g7
	4WDcYqqiLrDr9izvGCtrKlSC/rD42XaQG11qdCUJhTz5pgcLQ/0KMg9tuv72YrltTpCpl1
	njcLf3IrtqCpsrQzUG1ib1MVCoV3C6Sr+azexThSCRp/uE35cZbd8/T+2deKyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713825914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1l+fFrcb1tm2/Q1rBkMseDDo+cTSQcy2epINamvW+E=;
	b=c/ArD7Iw3c1SYu1N5dPRCEpTTh5+Xj/Locw54NOzMOLtZ4p+FcXLHFq6aMQXAUkQkMb/zX
	kP2CWf1FcxSX0cDQ==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/stm32-exti: Map interrupts through
 interrupts-extended
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240415134926.1254428-4-antonio.borneo@foss.st.com>
References: <20240415134926.1254428-4-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171382591368.10875.18389105424880851527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     77ec258ffa5c5f8c700fab7a0a78426904d1e6d4
Gitweb:        https://git.kernel.org/tip/77ec258ffa5c5f8c700fab7a0a78426904d1e6d4
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Mon, 15 Apr 2024 15:49:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 23 Apr 2024 00:28:15 +02:00

irqchip/stm32-exti: Map interrupts through interrupts-extended

The mapping of EXTI events to its parent interrupt controller is both SoC
and instance dependent.

The current implementation requires adding a new mapping table to the
driver's code and a new compatible for each new EXTI instance.

Check for the presence of the optional interrupts-extended property and use
it to map EXTI events to the parent's interrupts.

For old device trees without the optional interrupts-extended property, the
driver's behavior is unchanged, thus keeps backward compatibility.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240415134926.1254428-4-antonio.borneo@foss.st.com

---
 drivers/irqchip/irq-stm32-exti.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 3b35f13..e5714a0 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -61,6 +61,7 @@ struct stm32_exti_host_data {
 	struct stm32_exti_chip_data *chips_data;
 	const struct stm32_exti_drv_data *drv_data;
 	struct hwspinlock *hwlock;
+	bool dt_has_irqs_desc; /* skip internal desc_irqs array and get it from DT */
 };
 
 static struct stm32_exti_host_data *stm32_host_data;
@@ -731,6 +732,23 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 
 	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
 
+	if (host_data->dt_has_irqs_desc) {
+		struct of_phandle_args out_irq;
+		int ret;
+
+		ret = of_irq_parse_one(host_data->dev->of_node, hwirq, &out_irq);
+		if (ret)
+			return ret;
+		/* we only support one parent, so far */
+		if (of_node_to_fwnode(out_irq.np) != dm->parent->fwnode)
+			return -EINVAL;
+
+		of_phandle_args_to_fwspec(out_irq.np, out_irq.args,
+					  out_irq.args_count, &p_fwspec);
+
+		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
+	}
+
 	if (!host_data->drv_data->desc_irqs)
 		return -EINVAL;
 
@@ -975,6 +993,9 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (of_property_read_bool(np, "interrupts-extended"))
+		host_data->dt_has_irqs_desc = true;
+
 	stm32_exti_h_syscore_init(host_data);
 
 	return 0;

