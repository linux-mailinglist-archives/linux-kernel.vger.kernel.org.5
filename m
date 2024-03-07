Return-Path: <linux-kernel+bounces-95614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36142875031
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC02B1F22868
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A778912E1C4;
	Thu,  7 Mar 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BQ3YIwOI"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC9212C7EE;
	Thu,  7 Mar 2024 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818595; cv=none; b=CWvH989MOgRWDobQsnrJXvkG/covLU5zC/DZ3Z+xD3sGh8AbShZJngfo4I/h5s7CxWpuUFNpJduaZFskpuNnDoOUNj/BdL+iJKjFfGeyOz+aRg/EIwToH6LVzhalcRwAcNM7my8cinmMsEDoXM2TQsGZ+gfRfcz/QevRBt5+h3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818595; c=relaxed/simple;
	bh=kVVx4cvyGrHSQZfO/E+mcCMo6tHwieKNo+Wy8KlSN64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bn7a3NhYgnPwUuxlaEp72oWD6B+WsamnGbvuhckdWTXuV/vgvOVj2a55Htd9arGsZJHcsBPTCzUkk0LOGgI4Db8gRoXa+/bZ1Uw07YkW4yQYQ+JI+Usnjn3WG1ighy0+XxLgWe4V16hLGd9k3GB5lD2hO4gRJBDN/ZxNF5A9vfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BQ3YIwOI; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427C6nvK032390;
	Thu, 7 Mar 2024 14:36:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=IEvZxx/juDMRoMfxHFxpHiU9Ua2jQOe4iV1V9iT5ZOo=; b=BQ
	3YIwOIpz/LIOT6jV91D5+rBX5UDo8haHPAKvUD2l4U2gIMCUDK/z+4NdV826LqbP
	NbknGo/t8+m8eX1mz5O5tCLJcj8i5SViTIjOYxZ6MryPCwhbLtoVSN4BMMa9KNHx
	2TXzco73FB78SoO0kgzfB9qV1mZKVRYP35C2C6WIoQKE8izyVxSn8stJuJf1lXKX
	xmFNdkdz7HPtPWJakWSbKvLToBjIJE6Ty+2Lc31b65U593iG/PoCukxQWrZz5Htd
	85F6Sr6ULITzxhYr6lB3agalw7coIay2rnW4DiT5AyhqishJqx8t+4I1Iv4+WbrG
	fiKAbS+x3S7gpFBhNKpg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wktdmghe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 14:36:23 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 126294002D;
	Thu,  7 Mar 2024 14:36:20 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 72B6F27A51E;
	Thu,  7 Mar 2024 14:35:55 +0100 (CET)
Received: from localhost (10.201.22.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Mar
 2024 14:35:52 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 10/10] counter: stm32-timer-cnt: add support for capture events
Date: Thu, 7 Mar 2024 14:33:06 +0100
Message-ID: <20240307133306.383045-11-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240307133306.383045-1-fabrice.gasnier@foss.st.com>
References: <20240307133306.383045-1-fabrice.gasnier@foss.st.com>
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
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02

Add support for capture events. Captured counter value for each channel
can be retrieved through CCRx register.
STM32 timers can have up to 4 capture channels (on input channel 1 to
channel 4), hence need to check the number of channels before reading
the capture data.
The capture configuration is hard-coded to capture signals on both edges
(non-inverted). Interrupts are used to report events independently for
each channel.

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
Acked-by: Lee Jones <lee@kernel.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v5:
- Add William's Reviewed-by tag.

Changes in v4:
- move registers definition from previous patch to here. That's where
  the defines are actually used. So move the collected Acked-by: Lee
  for the mfd header here.
- drop *irq from stm32_timer_cnt, as only used at probe time.
- adopt some of the suggestions from William: introduce cc local variable,
  use regmap_test_bits().

Changes in v3:
- patch split from: "counter: stm32-timer-cnt: add support for events", to
  focus on the capture events only here.
- only get relevant interrupt line
---
 drivers/counter/stm32-timer-cnt.c | 134 +++++++++++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h  |  13 +++
 2 files changed, 144 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 9fcafec682b7..0664ef969f79 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -262,6 +262,40 @@ static int stm32_count_prescaler_write(struct counter_device *counter,
 	return regmap_write(priv->regmap, TIM_PSC, psc);
 }
 
+static int stm32_count_cap_read(struct counter_device *counter,
+				struct counter_count *count,
+				size_t ch, u64 *cap)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	u32 ccrx;
+
+	if (ch >= priv->nchannels)
+		return -EOPNOTSUPP;
+
+	switch (ch) {
+	case 0:
+		regmap_read(priv->regmap, TIM_CCR1, &ccrx);
+		break;
+	case 1:
+		regmap_read(priv->regmap, TIM_CCR2, &ccrx);
+		break;
+	case 2:
+		regmap_read(priv->regmap, TIM_CCR3, &ccrx);
+		break;
+	case 3:
+		regmap_read(priv->regmap, TIM_CCR4, &ccrx);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(counter->parent, "CCR%zu: 0x%08x\n", ch + 1, ccrx);
+
+	*cap = ccrx;
+
+	return 0;
+}
+
 static int stm32_count_nb_ovf_read(struct counter_device *counter,
 				   struct counter_count *count, u64 *val)
 {
@@ -288,6 +322,8 @@ static int stm32_count_nb_ovf_write(struct counter_device *counter,
 	return 0;
 }
 
+static DEFINE_COUNTER_ARRAY_CAPTURE(stm32_count_cap_array, 4);
+
 static struct counter_comp stm32_count_ext[] = {
 	COUNTER_COMP_DIRECTION(stm32_count_direction_read),
 	COUNTER_COMP_ENABLE(stm32_count_enable_read, stm32_count_enable_write),
@@ -295,6 +331,7 @@ static struct counter_comp stm32_count_ext[] = {
 			     stm32_count_ceiling_write),
 	COUNTER_COMP_COUNT_U64("prescaler", stm32_count_prescaler_read,
 			       stm32_count_prescaler_write),
+	COUNTER_COMP_ARRAY_CAPTURE(stm32_count_cap_read, NULL, stm32_count_cap_array),
 	COUNTER_COMP_COUNT_U64("num_overflows", stm32_count_nb_ovf_read, stm32_count_nb_ovf_write),
 };
 
@@ -353,11 +390,68 @@ static int stm32_action_read(struct counter_device *counter,
 	}
 }
 
+struct stm32_count_cc_regs {
+	u32 ccmr_reg;
+	u32 ccmr_mask;
+	u32 ccmr_bits;
+	u32 ccer_bits;
+};
+
+static const struct stm32_count_cc_regs stm32_cc[] = {
+	{ TIM_CCMR1, TIM_CCMR_CC1S, TIM_CCMR_CC1S_TI1,
+		TIM_CCER_CC1E | TIM_CCER_CC1P | TIM_CCER_CC1NP },
+	{ TIM_CCMR1, TIM_CCMR_CC2S, TIM_CCMR_CC2S_TI2,
+		TIM_CCER_CC2E | TIM_CCER_CC2P | TIM_CCER_CC2NP },
+	{ TIM_CCMR2, TIM_CCMR_CC3S, TIM_CCMR_CC3S_TI3,
+		TIM_CCER_CC3E | TIM_CCER_CC3P | TIM_CCER_CC3NP },
+	{ TIM_CCMR2, TIM_CCMR_CC4S, TIM_CCMR_CC4S_TI4,
+		TIM_CCER_CC4E | TIM_CCER_CC4P | TIM_CCER_CC4NP },
+};
+
+static int stm32_count_capture_configure(struct counter_device *counter, unsigned int ch,
+					 bool enable)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	const struct stm32_count_cc_regs *cc;
+	u32 ccmr, ccer;
+
+	if (ch >= ARRAY_SIZE(stm32_cc) || ch >= priv->nchannels) {
+		dev_err(counter->parent, "invalid ch: %d\n", ch);
+		return -EINVAL;
+	}
+
+	cc = &stm32_cc[ch];
+
+	/*
+	 * configure channel in input capture mode, map channel 1 on TI1, channel2 on TI2...
+	 * Select both edges / non-inverted to trigger a capture.
+	 */
+	if (enable) {
+		/* first clear possibly latched capture flag upon enabling */
+		if (!regmap_test_bits(priv->regmap, TIM_CCER, cc->ccer_bits))
+			regmap_write(priv->regmap, TIM_SR, ~TIM_SR_CC_IF(ch));
+		regmap_update_bits(priv->regmap, cc->ccmr_reg, cc->ccmr_mask,
+				   cc->ccmr_bits);
+		regmap_set_bits(priv->regmap, TIM_CCER, cc->ccer_bits);
+	} else {
+		regmap_clear_bits(priv->regmap, TIM_CCER, cc->ccer_bits);
+		regmap_clear_bits(priv->regmap, cc->ccmr_reg, cc->ccmr_mask);
+	}
+
+	regmap_read(priv->regmap, cc->ccmr_reg, &ccmr);
+	regmap_read(priv->regmap, TIM_CCER, &ccer);
+	dev_dbg(counter->parent, "%s(%s) ch%d 0x%08x 0x%08x\n", __func__, enable ? "ena" : "dis",
+		ch, ccmr, ccer);
+
+	return 0;
+}
+
 static int stm32_count_events_configure(struct counter_device *counter)
 {
 	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	struct counter_event_node *event_node;
 	u32 dier = 0;
+	int i, ret;
 
 	list_for_each_entry(event_node, &counter->events_list, l) {
 		switch (event_node->event) {
@@ -367,6 +461,12 @@ static int stm32_count_events_configure(struct counter_device *counter)
 				regmap_write(priv->regmap, TIM_SR, (u32)~TIM_SR_UIF);
 			dier |= TIM_DIER_UIE;
 			break;
+		case COUNTER_EVENT_CAPTURE:
+			ret = stm32_count_capture_configure(counter, event_node->channel, true);
+			if (ret)
+				return ret;
+			dier |= TIM_DIER_CC_IE(event_node->channel);
+			break;
 		default:
 			/* should never reach this path */
 			return -EINVAL;
@@ -376,6 +476,15 @@ static int stm32_count_events_configure(struct counter_device *counter)
 	/* Enable / disable all events at once, from events_list, so write all DIER bits */
 	regmap_write(priv->regmap, TIM_DIER, dier);
 
+	/* check for disabled capture events */
+	for (i = 0 ; i < priv->nchannels; i++) {
+		if (!(dier & TIM_DIER_CC_IE(i))) {
+			ret = stm32_count_capture_configure(counter, i, false);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -389,6 +498,12 @@ static int stm32_count_watch_validate(struct counter_device *counter,
 		return -EOPNOTSUPP;
 
 	switch (watch->event) {
+	case COUNTER_EVENT_CAPTURE:
+		if (watch->channel >= priv->nchannels) {
+			dev_err(counter->parent, "Invalid channel %d\n", watch->channel);
+			return -EINVAL;
+		}
+		return 0;
 	case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
 		return 0;
 	default:
@@ -499,6 +614,7 @@ static irqreturn_t stm32_timer_cnt_isr(int irq, void *ptr)
 	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 clr = GENMASK(31, 0); /* SR flags can be cleared by writing 0 (wr 1 has no effect) */
 	u32 sr, dier;
+	int i;
 
 	regmap_read(priv->regmap, TIM_SR, &sr);
 	regmap_read(priv->regmap, TIM_DIER, &dier);
@@ -506,7 +622,7 @@ static irqreturn_t stm32_timer_cnt_isr(int irq, void *ptr)
 	 * Some status bits in SR don't match with the enable bits in DIER. Only take care of
 	 * the possibly enabled bits in DIER (that matches in between SR and DIER).
 	 */
-	dier &= TIM_DIER_UIE;
+	dier &= (TIM_DIER_UIE | TIM_DIER_CC1IE | TIM_DIER_CC2IE | TIM_DIER_CC3IE | TIM_DIER_CC4IE);
 	sr &= dier;
 
 	if (sr & TIM_SR_UIF) {
@@ -519,6 +635,15 @@ static irqreturn_t stm32_timer_cnt_isr(int irq, void *ptr)
 		clr &= ~TIM_SR_UIF;
 	}
 
+	/* Check capture events */
+	for (i = 0 ; i < priv->nchannels; i++) {
+		if (sr & TIM_SR_CC_IF(i)) {
+			counter_push_event(counter, COUNTER_EVENT_CAPTURE, i);
+			clr &= ~TIM_SR_CC_IF(i);
+			dev_dbg(counter->parent, "COUNTER_EVENT_CAPTURE, %d\n", i);
+		}
+	}
+
 	regmap_write(priv->regmap, TIM_SR, clr);
 
 	return IRQ_HANDLED;
@@ -633,8 +758,11 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 		}
 	} else {
 		for (i = 0; i < priv->nr_irqs; i++) {
-			/* Only take care of update IRQ for overflow events */
-			if (i != STM32_TIMERS_IRQ_UP)
+			/*
+			 * Only take care of update IRQ for overflow events, and cc for
+			 * capture events.
+			 */
+			if (i != STM32_TIMERS_IRQ_UP && i != STM32_TIMERS_IRQ_CC)
 				continue;
 
 			ret = devm_request_irq(&pdev->dev, ddata->irq[i], stm32_timer_cnt_isr,
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index ca35af30745f..9eb17481b07f 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -41,6 +41,11 @@
 #define TIM_SMCR_SMS	(BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection */
 #define TIM_SMCR_TS	(BIT(4) | BIT(5) | BIT(6)) /* Trigger selection */
 #define TIM_DIER_UIE	BIT(0)	/* Update interrupt	   */
+#define TIM_DIER_CC1IE	BIT(1)  /* CC1 Interrupt Enable    */
+#define TIM_DIER_CC2IE	BIT(2)  /* CC2 Interrupt Enable    */
+#define TIM_DIER_CC3IE	BIT(3)  /* CC3 Interrupt Enable    */
+#define TIM_DIER_CC4IE	BIT(4)  /* CC4 Interrupt Enable    */
+#define TIM_DIER_CC_IE(x)	BIT((x) + 1) /* CC1, CC2, CC3, CC4 interrupt enable */
 #define TIM_DIER_UDE	BIT(8)  /* Update DMA request Enable */
 #define TIM_DIER_CC1DE	BIT(9)  /* CC1 DMA request Enable  */
 #define TIM_DIER_CC2DE	BIT(10) /* CC2 DMA request Enable  */
@@ -49,6 +54,7 @@
 #define TIM_DIER_COMDE	BIT(13) /* COM DMA request Enable  */
 #define TIM_DIER_TDE	BIT(14) /* Trigger DMA request Enable */
 #define TIM_SR_UIF	BIT(0)	/* Update interrupt flag   */
+#define TIM_SR_CC_IF(x)	BIT((x) + 1) /* CC1, CC2, CC3, CC4 interrupt flag */
 #define TIM_EGR_UG	BIT(0)	/* Update Generation       */
 #define TIM_CCMR_PE	BIT(3)	/* Channel Preload Enable  */
 #define TIM_CCMR_M1	(BIT(6) | BIT(5))  /* Channel PWM Mode 1 */
@@ -60,16 +66,23 @@
 #define TIM_CCMR_CC1S_TI2	BIT(1)	/* IC1/IC3 selects TI2/TI4 */
 #define TIM_CCMR_CC2S_TI2	BIT(8)	/* IC2/IC4 selects TI2/TI4 */
 #define TIM_CCMR_CC2S_TI1	BIT(9)	/* IC2/IC4 selects TI1/TI3 */
+#define TIM_CCMR_CC3S		(BIT(0) | BIT(1)) /* Capture/compare 3 sel */
+#define TIM_CCMR_CC4S		(BIT(8) | BIT(9)) /* Capture/compare 4 sel */
+#define TIM_CCMR_CC3S_TI3	BIT(0)	/* IC3 selects TI3 */
+#define TIM_CCMR_CC4S_TI4	BIT(8)	/* IC4 selects TI4 */
 #define TIM_CCER_CC1E	BIT(0)	/* Capt/Comp 1  out Ena    */
 #define TIM_CCER_CC1P	BIT(1)	/* Capt/Comp 1  Polarity   */
 #define TIM_CCER_CC1NE	BIT(2)	/* Capt/Comp 1N out Ena    */
 #define TIM_CCER_CC1NP	BIT(3)	/* Capt/Comp 1N Polarity   */
 #define TIM_CCER_CC2E	BIT(4)	/* Capt/Comp 2  out Ena    */
 #define TIM_CCER_CC2P	BIT(5)	/* Capt/Comp 2  Polarity   */
+#define TIM_CCER_CC2NP	BIT(7)	/* Capt/Comp 2N Polarity   */
 #define TIM_CCER_CC3E	BIT(8)	/* Capt/Comp 3  out Ena    */
 #define TIM_CCER_CC3P	BIT(9)	/* Capt/Comp 3  Polarity   */
+#define TIM_CCER_CC3NP	BIT(11)	/* Capt/Comp 3N Polarity   */
 #define TIM_CCER_CC4E	BIT(12)	/* Capt/Comp 4  out Ena    */
 #define TIM_CCER_CC4P	BIT(13)	/* Capt/Comp 4  Polarity   */
+#define TIM_CCER_CC4NP	BIT(15)	/* Capt/Comp 4N Polarity   */
 #define TIM_CCER_CCXE	(BIT(0) | BIT(4) | BIT(8) | BIT(12))
 #define TIM_BDTR_BKE(x)	BIT(12 + (x) * 12) /* Break input enable */
 #define TIM_BDTR_BKP(x)	BIT(13 + (x) * 12) /* Break input polarity */
-- 
2.25.1


