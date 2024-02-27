Return-Path: <linux-kernel+bounces-83755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26199869E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01BE28F6B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3D514900E;
	Tue, 27 Feb 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="eD9ZphYg"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ACD14C582;
	Tue, 27 Feb 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055617; cv=none; b=GVAIcmJVmLgtRTPLGPn3LmhnMpw0aFUFcI0ptUgibRHQ58jcW8G5Fp1NjJJvC7O6dlZ/btS5XbqdfYfNxLqoQU6Lvn0hOonY1QxcQtDrrpklJ1vDMixI0wDgk8UbBZ7TexVpuZNUDQO2/CkDldjJI9z/PDIEVmPfFx3hQ+RkMns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055617; c=relaxed/simple;
	bh=+CcntBR+ctzeanI9LzOMfiPrNC9s3Xf4oSTtOMYaew0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZWhiOxPcNxMtFdj6XfzD4xLO2b0h0yluh/EcITjpvrBKxtJEAhR1jp8qdip6h92iAWF/1jIvolj9DPHgp/4AVWhMphzrOAdp+r8jD9W7tPvS336AZsFi2qnpIjmldk3SFt7f0vFCheBE+TvmBnAkDFuB0yGwbpRBYjdBeZPCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=eD9ZphYg; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBi70e025166;
	Tue, 27 Feb 2024 18:40:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=oK3u5VA04nVMBTkalarhGWM8df4YU9kjhwAaKc3RoBs=; b=eD
	9ZphYgfJ9gBTwl6j6MwI0mcx9Bwa8VTiBCbjxphWa9jJN3C7YTCKWYWJ0P8aChdP
	sXw3y8qS+0z8E8RemiFi/aBHQX2jbDRKAVsRGX11+7jsxco8I4lYultM/TK7HLjx
	2rLP995uKHmxbFJZ2E3BDvHfFej5aysaHaQtQbcN4F96g3Zmsvbw0sSuk5jJnC/U
	in0/Ew0ZP8ZHo9BYlFDKJIkMlfgzzDJjwY3EzZeJ9ewYZso09iXysMkYi+P6Ykmb
	EKcXmiBqiLND0IYcvYNIKDtFn90wQ1DadTnI/JRW2fznZy3DayIgk9bnlYWLGFV8
	QLyknZK5xwCDW8fTwCVA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4bscdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:40:04 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E35AB4002D;
	Tue, 27 Feb 2024 18:39:59 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 29A682AD133;
	Tue, 27 Feb 2024 18:39:33 +0100 (CET)
Received: from localhost (10.252.26.109) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 27 Feb
 2024 18:39:30 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 09/11] counter: stm32-timer-cnt: probe number of channels from registers
Date: Tue, 27 Feb 2024 18:38:01 +0100
Message-ID: <20240227173803.53906-10-fabrice.gasnier@foss.st.com>
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

Probe the number of capture compare channels, by writing CCER register bits
and read them back. Take care to restore the register original value.

This is a precursor patch to support capture channels.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- directly use dev struct in stm32_timer_cnt_detect_channels routine.
Changes in v3:
- New patch split from:
  "counter: stm32-timer-cnt: populate capture channels and check encoder"
---
 drivers/counter/stm32-timer-cnt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 66039d1b3642..710437d3b33f 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -42,6 +42,7 @@ struct stm32_timer_cnt {
 	bool enabled;
 	struct stm32_timer_regs bak;
 	bool has_encoder;
+	unsigned int nchannels;
 };
 
 static const enum counter_function stm32_count_functions[] = {
@@ -416,6 +417,20 @@ static struct counter_count stm32_counts = {
 	.num_ext = ARRAY_SIZE(stm32_count_ext)
 };
 
+static void stm32_timer_cnt_detect_channels(struct device *dev,
+					    struct stm32_timer_cnt *priv)
+{
+	u32 ccer, ccer_backup;
+
+	regmap_read(priv->regmap, TIM_CCER, &ccer_backup);
+	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
+	regmap_read(priv->regmap, TIM_CCER, &ccer);
+	regmap_write(priv->regmap, TIM_CCER, ccer_backup);
+	priv->nchannels = hweight32(ccer & TIM_CCER_CCXE);
+
+	dev_dbg(dev, "has %d cc channels\n", priv->nchannels);
+}
+
 /* encoder supported on TIM1 TIM2 TIM3 TIM4 TIM5 TIM8 */
 #define STM32_TIM_ENCODER_SUPPORTED	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(7))
 
@@ -484,6 +499,8 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	stm32_timer_cnt_detect_channels(dev, priv);
+
 	counter->name = dev_name(dev);
 	counter->parent = dev;
 	counter->ops = &stm32_timer_cnt_ops;
-- 
2.25.1


