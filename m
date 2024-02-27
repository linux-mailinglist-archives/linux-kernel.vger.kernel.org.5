Return-Path: <linux-kernel+bounces-83756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F5F869E11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888DC28FBE9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF36A4EB34;
	Tue, 27 Feb 2024 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ls+hIJEs"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92BC2557F;
	Tue, 27 Feb 2024 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055687; cv=none; b=ORr1v9dTwt3gK9/82tVwjmnhh06h5UJxwr8BHwIFeTdH82bd0MVsg2DYmGH0Q/Q8P6kdCegpU1OsOI1CCFp+mFgNK4Zx9iz8ku4d5A/PjmCQiLwsyz6J4nir2s5RGl2Dxk6ebOoiOJXe+gYMVPehZfRh6DNJ7uYIJmdk3z3+s+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055687; c=relaxed/simple;
	bh=s7NWQinBJnjgy3mumGJfc7qp23d23q4kW7l8kV/DGio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVgQJQWc6digmZKSQzqchMTigJ2T0+lAwGaYTLx8kLpnfJAQAgjZVKLkQNELXP08xJIy1EpxJKRCH6Wo2rkEMyQMPmkc8s4USFpTNhgGh5R47Z0+8GpxSeb2Bu64ia6dIrN1HUzZ7GFQUfuXa/ZHH+/jsG+7BSgwbftNWnXN9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ls+hIJEs; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBi2rk029650;
	Tue, 27 Feb 2024 18:41:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=/Q/TfEHS7ktUk+Ck1mLVERqp7dICZ7Ag0Jf4kVHfD1E=; b=Ls
	+hIJEsg8l8Ouu2+ypJWhLR2reqx8wop+iB1ZZwP1o2qGyvOaSL6eVvR0EEerd9if
	AOgu6uSaZ0kImJIE0nKxUa05GKpgvOHwpqGqA5ZXyKgLrz/JYIe9yP9RHmmZGQBh
	+iF4VtClziWGSreAKN2RRgjwsOjr8MV54eL0+DMxayDiVAq4QTR6KIftVesD5Kk9
	FNcTpBhPkgjsTxnQlulmMCkGj/QFi2L4xVt/+VhT3g77Rg4uuYnhyIC/lyfuVjHM
	sVUXBLqzu/5Xhqza9A3CtMfYuSuQt0sW97ujneS1A5+mrwdHoHTGTSdQiGdaiFmI
	4LQm2GiZVU/ZG2VvUMAQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4b9ddq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:41:10 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A7D0B4002D;
	Tue, 27 Feb 2024 18:41:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1270E2AD154;
	Tue, 27 Feb 2024 18:40:41 +0100 (CET)
Received: from localhost (10.252.26.109) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 27 Feb
 2024 18:40:40 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 10/11] counter: stm32-timer-cnt: add support for overflow events
Date: Tue, 27 Feb 2024 18:38:02 +0100
Message-ID: <20240227173803.53906-11-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227173803.53906-1-fabrice.gasnier@foss.st.com>
References: <20240227173803.53906-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02

Add support overflow events. Also add the related validation and
configuration routine. Register and enable interrupts to push events.
STM32 Timers can have either 1 global interrupt, or 4 dedicated interrupt
lines. Request only the necessary interrupt, e.g. either global interrupt
that can report all event types, or update interrupt only for overflow
event.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- drop *irq from stm32_timer_cnt, as only used at probe time.
- Declare nb_ovf as u64 instead of atomic_t, to fit the API, and avoid
  unsuitable range check. This also avoid checking for negative value.
  Use a spin_lock to protect it, as it is updated in interrupt context.
- use regmap_test_bits() to avoid intermediate variable.
- fix error message in probe (ddata->irq[0] instead of ddata->irq[i])
- move mfd header to subsequent patch, where the defines are actually
  used.

Changes in v3:
- patch split from: "counter: stm32-timer-cnt: add support for events", to
  focus on the overflow events only here. Move the capture event support
  to a separate patch.
- simplify the patch, by removing diversity introduced by the number of
  possible channels. All channels are now exposed instead.
  Report an error when trying to access a channel that doesn't exist.

Changes in v2:
- fix warnings (kernel test robot)
- fix a typo
- add collected ack from Lee
---
 drivers/counter/stm32-timer-cnt.c | 138 +++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 710437d3b33f..9ec6e18f4d43 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -8,6 +8,7 @@
  *
  */
 #include <linux/counter.h>
+#include <linux/interrupt.h>
 #include <linux/mfd/stm32-timers.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -43,6 +44,9 @@ struct stm32_timer_cnt {
 	struct stm32_timer_regs bak;
 	bool has_encoder;
 	unsigned int nchannels;
+	unsigned int nr_irqs;
+	spinlock_t lock; /* protects nb_ovf */
+	u64 nb_ovf;
 };
 
 static const enum counter_function stm32_count_functions[] = {
@@ -258,6 +262,32 @@ static int stm32_count_prescaler_write(struct counter_device *counter,
 	return regmap_write(priv->regmap, TIM_PSC, psc);
 }
 
+static int stm32_count_nb_ovf_read(struct counter_device *counter,
+				   struct counter_count *count, u64 *val)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&priv->lock, irqflags);
+	*val = priv->nb_ovf;
+	spin_unlock_irqrestore(&priv->lock, irqflags);
+
+	return 0;
+}
+
+static int stm32_count_nb_ovf_write(struct counter_device *counter,
+				    struct counter_count *count, u64 val)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&priv->lock, irqflags);
+	priv->nb_ovf = val;
+	spin_unlock_irqrestore(&priv->lock, irqflags);
+
+	return 0;
+}
+
 static struct counter_comp stm32_count_ext[] = {
 	COUNTER_COMP_DIRECTION(stm32_count_direction_read),
 	COUNTER_COMP_ENABLE(stm32_count_enable_read, stm32_count_enable_write),
@@ -265,6 +295,7 @@ static struct counter_comp stm32_count_ext[] = {
 			     stm32_count_ceiling_write),
 	COUNTER_COMP_COUNT_U64("prescaler", stm32_count_prescaler_read,
 			       stm32_count_prescaler_write),
+	COUNTER_COMP_COUNT_U64("num_overflows", stm32_count_nb_ovf_read, stm32_count_nb_ovf_write),
 };
 
 static const enum counter_synapse_action stm32_clock_synapse_actions[] = {
@@ -322,12 +353,57 @@ static int stm32_action_read(struct counter_device *counter,
 	}
 }
 
+static int stm32_count_events_configure(struct counter_device *counter)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	struct counter_event_node *event_node;
+	u32 dier = 0;
+
+	list_for_each_entry(event_node, &counter->events_list, l) {
+		switch (event_node->event) {
+		case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
+			/* first clear possibly latched UIF before enabling */
+			if (!regmap_test_bits(priv->regmap, TIM_DIER, TIM_DIER_UIE))
+				regmap_write(priv->regmap, TIM_SR, (u32)~TIM_SR_UIF);
+			dier |= TIM_DIER_UIE;
+			break;
+		default:
+			/* should never reach this path */
+			return -EINVAL;
+		}
+	}
+
+	/* Enable / disable all events at once, from events_list, so write all DIER bits */
+	regmap_write(priv->regmap, TIM_DIER, dier);
+
+	return 0;
+}
+
+static int stm32_count_watch_validate(struct counter_device *counter,
+				      const struct counter_watch *watch)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+
+	/* Interrupts are optional */
+	if (!priv->nr_irqs)
+		return -EOPNOTSUPP;
+
+	switch (watch->event) {
+	case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct counter_ops stm32_timer_cnt_ops = {
 	.count_read = stm32_count_read,
 	.count_write = stm32_count_write,
 	.function_read = stm32_count_function_read,
 	.function_write = stm32_count_function_write,
 	.action_read = stm32_action_read,
+	.events_configure = stm32_count_events_configure,
+	.watch_validate = stm32_count_watch_validate,
 };
 
 static int stm32_count_clk_get_freq(struct counter_device *counter,
@@ -417,6 +493,37 @@ static struct counter_count stm32_counts = {
 	.num_ext = ARRAY_SIZE(stm32_count_ext)
 };
 
+static irqreturn_t stm32_timer_cnt_isr(int irq, void *ptr)
+{
+	struct counter_device *counter = ptr;
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	u32 clr = GENMASK(31, 0); /* SR flags can be cleared by writing 0 (wr 1 has no effect) */
+	u32 sr, dier;
+
+	regmap_read(priv->regmap, TIM_SR, &sr);
+	regmap_read(priv->regmap, TIM_DIER, &dier);
+	/*
+	 * Some status bits in SR don't match with the enable bits in DIER. Only take care of
+	 * the possibly enabled bits in DIER (that matches in between SR and DIER).
+	 */
+	dier &= TIM_DIER_UIE;
+	sr &= dier;
+
+	if (sr & TIM_SR_UIF) {
+		spin_lock(&priv->lock);
+		priv->nb_ovf++;
+		spin_unlock(&priv->lock);
+		counter_push_event(counter, COUNTER_EVENT_OVERFLOW_UNDERFLOW, 0);
+		dev_dbg(counter->parent, "COUNTER_EVENT_OVERFLOW_UNDERFLOW\n");
+		/* SR flags can be cleared by writing 0, only clear relevant flag */
+		clr &= ~TIM_SR_UIF;
+	}
+
+	regmap_write(priv->regmap, TIM_SR, clr);
+
+	return IRQ_HANDLED;
+};
+
 static void stm32_timer_cnt_detect_channels(struct device *dev,
 					    struct stm32_timer_cnt *priv)
 {
@@ -480,7 +587,7 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct stm32_timer_cnt *priv;
 	struct counter_device *counter;
-	int ret;
+	int i, ret;
 
 	if (IS_ERR_OR_NULL(ddata))
 		return -EINVAL;
@@ -494,6 +601,7 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
+	priv->nr_irqs = ddata->nr_irqs;
 
 	ret = stm32_timer_cnt_probe_encoder(dev, priv);
 	if (ret)
@@ -509,8 +617,36 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	counter->signals = stm32_signals;
 	counter->num_signals = ARRAY_SIZE(stm32_signals);
 
+	spin_lock_init(&priv->lock);
+
 	platform_set_drvdata(pdev, priv);
 
+	/* STM32 Timers can have either 1 global, or 4 dedicated interrupts (optional) */
+	if (priv->nr_irqs == 1) {
+		/* All events reported through the global interrupt */
+		ret = devm_request_irq(&pdev->dev, ddata->irq[0], stm32_timer_cnt_isr,
+				       0, dev_name(dev), counter);
+		if (ret) {
+			dev_err(dev, "Failed to request irq %d (err %d)\n",
+				ddata->irq[0], ret);
+			return ret;
+		}
+	} else {
+		for (i = 0; i < priv->nr_irqs; i++) {
+			/* Only take care of update IRQ for overflow events */
+			if (i != STM32_TIMERS_IRQ_UP)
+				continue;
+
+			ret = devm_request_irq(&pdev->dev, ddata->irq[i], stm32_timer_cnt_isr,
+					       0, dev_name(dev), counter);
+			if (ret) {
+				dev_err(dev, "Failed to request irq %d (err %d)\n",
+					ddata->irq[i], ret);
+				return ret;
+			}
+		}
+	}
+
 	/* Reset input selector to its default input */
 	regmap_write(priv->regmap, TIM_TISEL, 0x0);
 
-- 
2.25.1


