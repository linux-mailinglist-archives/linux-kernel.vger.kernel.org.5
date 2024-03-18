Return-Path: <linux-kernel+bounces-105952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A873C87E6CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036A4B21A95
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F133383BB;
	Mon, 18 Mar 2024 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="choKYCNW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fYWInPlE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E7A2DF9C;
	Mon, 18 Mar 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756464; cv=none; b=MC5DrnXY9yDABaWXs98hlIRwKppMPTksbj5wrx2cYs7M2DLIRd7T54deQ2s/MVc+pAKI20z1+vVFGPwv6ZplHaOLWXjEADzvLJ9TVXo+mMLs3qYt8V+iufD20YR96et19QnuXMRClBsPDI05qXUp3UnfA24dxtT08nHjVGio3O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756464; c=relaxed/simple;
	bh=O5iEM29wmRS4L36GpBPkV7+U/xtWU9rl/L2dDCgBtBk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LDse8ehH1//f/+ZQKDIwuVPAbHZhsugtQMegp172rnmrDfCYD4X1bfRZLo93jm1h7l1QUrEwk1mCkJgmbeQkFmdtYj4sP5NF7kIpIfvtePikHXI216xgZsu7AUvSQnDUArDQdtGjDZTfEdRTKUSPKgG/gOAOejpqG/h31+lRkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=choKYCNW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fYWInPlE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zS/eChdLaSnqH4X3789cKsE3DdERb8Z4lkNf2YMURxs=;
	b=choKYCNWEC8dGm8u9auHlqFT6XKPtOBtafguSkyWHGkubmtVE/0wXfU8B0a6auBC6Dyusd
	c/y5zX0a0u+74CapqSyk/mJRHER4bxvcF8cQn4S/bhuW34lhT/9WPI2egA8z2xWYBlGVtx
	zuINGQhvvrlukz3JrcfgoFxL2Iz8uP31Wie5nvaoLLoW7HFY15WFj3AtGfXLZgr3unvbsS
	8Mt2nbR+4BfPPXWaZQAl3/N0jFPzYTury9GJnpbJPhS6/ZD7JIv75LKa80BjyVMbWNXzar
	BS2hFcGyRQHlEam7qQSlqCHACzQDc9jiiSkfZSofeaIG7wLUG35FTsT5lDzadw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zS/eChdLaSnqH4X3789cKsE3DdERb8Z4lkNf2YMURxs=;
	b=fYWInPlE2Y5xoCmY8hqLbBHHBs/VqPWJkq8yowrN1PIJMNsIb3hwDlgdFCFIZtdJB9ocSI
	9SCY/3Sb9wyQJgAg==
From: "tip-bot2 for Peng Fan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] clocksource/drivers/imx-sysctr: Drop use global variables
Cc: Peng Fan <peng.fan@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240205-imx-sysctr-v4-2-ca5a6e1552e7@nxp.com>
References: <20240205-imx-sysctr-v4-2-ca5a6e1552e7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075646003.12214.18341108739264442850.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     418062b548b138a1e6a9fde3a8ddf7fa77c44c9e
Gitweb:        https://git.kernel.org/tip/418062b548b138a1e6a9fde3a8ddf7fa77c44c9e
Author:        Peng Fan <peng.fan@nxp.com>
AuthorDate:    Mon, 05 Feb 2024 11:17:58 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 18 Feb 2024 10:45:30 +01:00

clocksource/drivers/imx-sysctr: Drop use global variables

Clean up code to not use global variables and introduce sysctr_private
structure to prepare the support for i.MX95.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240205-imx-sysctr-v4-2-ca5a6e1552e7@nxp.com
---
 drivers/clocksource/timer-imx-sysctr.c | 76 ++++++++++++++-----------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index 5a7a951..c075ea8 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -4,6 +4,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
+#include <linux/slab.h>
 
 #include "timer-of.h"
 
@@ -20,32 +21,39 @@
 
 #define SYS_CTR_CLK_DIV		0x3
 
-static void __iomem *sys_ctr_base __ro_after_init;
-static u32 cmpcr __ro_after_init;
+struct sysctr_private {
+	u32 cmpcr;
+};
 
-static void sysctr_timer_enable(bool enable)
+static void sysctr_timer_enable(struct clock_event_device *evt, bool enable)
 {
-	writel(enable ? cmpcr | SYS_CTR_EN : cmpcr, sys_ctr_base + CMPCR);
+	struct timer_of *to = to_timer_of(evt);
+	struct sysctr_private *priv = to->private_data;
+	void __iomem *base = timer_of_base(to);
+
+	writel(enable ? priv->cmpcr | SYS_CTR_EN : priv->cmpcr, base + CMPCR);
 }
 
-static void sysctr_irq_acknowledge(void)
+static void sysctr_irq_acknowledge(struct clock_event_device *evt)
 {
 	/*
 	 * clear the enable bit(EN =0) will clear
 	 * the status bit(ISTAT = 0), then the interrupt
 	 * signal will be negated(acknowledged).
 	 */
-	sysctr_timer_enable(false);
+	sysctr_timer_enable(evt, false);
 }
 
-static inline u64 sysctr_read_counter(void)
+static inline u64 sysctr_read_counter(struct clock_event_device *evt)
 {
+	struct timer_of *to = to_timer_of(evt);
+	void __iomem *base = timer_of_base(to);
 	u32 cnt_hi, tmp_hi, cnt_lo;
 
 	do {
-		cnt_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
-		cnt_lo = readl_relaxed(sys_ctr_base + CNTCV_LO);
-		tmp_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
+		cnt_hi = readl_relaxed(base + CNTCV_HI);
+		cnt_lo = readl_relaxed(base + CNTCV_LO);
+		tmp_hi = readl_relaxed(base + CNTCV_HI);
 	} while (tmp_hi != cnt_hi);
 
 	return  ((u64) cnt_hi << 32) | cnt_lo;
@@ -54,22 +62,24 @@ static inline u64 sysctr_read_counter(void)
 static int sysctr_set_next_event(unsigned long delta,
 				 struct clock_event_device *evt)
 {
+	struct timer_of *to = to_timer_of(evt);
+	void __iomem *base = timer_of_base(to);
 	u32 cmp_hi, cmp_lo;
 	u64 next;
 
-	sysctr_timer_enable(false);
+	sysctr_timer_enable(evt, false);
 
-	next = sysctr_read_counter();
+	next = sysctr_read_counter(evt);
 
 	next += delta;
 
 	cmp_hi = (next >> 32) & 0x00fffff;
 	cmp_lo = next & 0xffffffff;
 
-	writel_relaxed(cmp_hi, sys_ctr_base + CMPCV_HI);
-	writel_relaxed(cmp_lo, sys_ctr_base + CMPCV_LO);
+	writel_relaxed(cmp_hi, base + CMPCV_HI);
+	writel_relaxed(cmp_lo, base + CMPCV_LO);
 
-	sysctr_timer_enable(true);
+	sysctr_timer_enable(evt, true);
 
 	return 0;
 }
@@ -81,7 +91,7 @@ static int sysctr_set_state_oneshot(struct clock_event_device *evt)
 
 static int sysctr_set_state_shutdown(struct clock_event_device *evt)
 {
-	sysctr_timer_enable(false);
+	sysctr_timer_enable(evt, false);
 
 	return 0;
 }
@@ -90,7 +100,7 @@ static irqreturn_t sysctr_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
 
-	sysctr_irq_acknowledge();
+	sysctr_irq_acknowledge(evt);
 
 	evt->event_handler(evt);
 
@@ -117,34 +127,36 @@ static struct timer_of to_sysctr = {
 	},
 };
 
-static void __init sysctr_clockevent_init(void)
-{
-	to_sysctr.clkevt.cpumask = cpu_possible_mask;
-
-	clockevents_config_and_register(&to_sysctr.clkevt,
-					timer_of_rate(&to_sysctr),
-					0xff, 0x7fffffff);
-}
-
 static int __init sysctr_timer_init(struct device_node *np)
 {
-	int ret = 0;
+	struct sysctr_private *priv;
+	void __iomem *base;
+	int ret;
+
+	priv = kzalloc(sizeof(struct sysctr_private), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
 	ret = timer_of_init(np, &to_sysctr);
-	if (ret)
+	if (ret) {
+		kfree(priv);
 		return ret;
+	}
 
 	if (!of_property_read_bool(np, "nxp,no-divider")) {
 		/* system counter clock is divided by 3 internally */
 		to_sysctr.of_clk.rate /= SYS_CTR_CLK_DIV;
 	}
 
-	sys_ctr_base = timer_of_base(&to_sysctr);
-	cmpcr = readl(sys_ctr_base + CMPCR);
-	cmpcr &= ~SYS_CTR_EN;
+	to_sysctr.clkevt.cpumask = cpu_possible_mask;
+	to_sysctr.private_data = priv;
 
-	sysctr_clockevent_init();
+	base = timer_of_base(&to_sysctr);
+	priv->cmpcr = readl(base + CMPCR) & ~SYS_CTR_EN;
 
+	clockevents_config_and_register(&to_sysctr.clkevt,
+					timer_of_rate(&to_sysctr),
+					0xff, 0x7fffffff);
 	return 0;
 }
 TIMER_OF_DECLARE(sysctr_timer, "nxp,sysctr-timer", sysctr_timer_init);

