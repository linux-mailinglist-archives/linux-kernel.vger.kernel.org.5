Return-Path: <linux-kernel+bounces-95608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4990E875023
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0236A1F22531
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E78012D77D;
	Thu,  7 Mar 2024 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zWxN8/Wa"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7F12DDA7;
	Thu,  7 Mar 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818525; cv=none; b=HKdoVjQHenmF5dfrUrUIOL/eSmfE+Yzz3ff01OcXte6gAA7Vtw2j4WibOxsHJFtccvvUsni6dPn7DdyVxAi1bkqZnr93l2+MY1lWyQ3ODimJ6+OhpFDtcnOGM+GnhsqzLvQ22OvQkvOkE9c9h9LhiD+aogiOpAdO4OpCciN1b6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818525; c=relaxed/simple;
	bh=sE9MDLiOgq9FU99NRLp+cLa9Sq+I4ShSz+hPVE9Zxq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8DEAgGXGBrHWLaTvA48DHgLQB9y4EtbAy8boJ/rl/rd2H8h70TWHSaNLZQw+B+F46O1EPo5Dyl5TwO1fSBfdpSPoJtly483D1+Ni7vWFgQUJR+kfHl1OLwmAn3ZeCF9RR7tH1fVBvhpEAfadSxtKbqA91JhLOq+0yMQCUknrV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=zWxN8/Wa; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4279qDHA004218;
	Thu, 7 Mar 2024 14:35:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=gOumbbgPaqvn44tqW0xgZQ1SLJ0gP3GHl099084722c=; b=zW
	xN8/WaxT9yNL0c7qlAlz0IOzfrRX1iQkPX7pTr769bxiRgcZvrpc28TE+hvMU0v8
	gvGz/cIvwVrpef7rWlRhA+1k8qyS/jCcAwjiwBIlCoGlggL6QmoDarYTDDPufJMf
	RYirA5yrbFDVXcrz1Dmi0HDXUnzInQMRTjElRurK6zoT9rCLIOjT8198AZBkoiUo
	Kv+GFG5FRErK3TOB1b91tSgRpb2atRQDc7oYc5i1yKqAno+pMlo8Jp4PRXLUA6Uv
	QMRro8PE18nvh1eE4DjjPn7/g97MUnWLefrw5+gOq54RLwWys2Q5cKdLYW+RVcTf
	TgNVZYIAK8Ie8aV6g6Dw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wmej5dtvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 14:35:12 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D03C440044;
	Thu,  7 Mar 2024 14:35:08 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A30D27A506;
	Thu,  7 Mar 2024 14:34:42 +0100 (CET)
Received: from localhost (10.201.22.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Mar
 2024 14:34:41 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 08/10] counter: stm32-timer-cnt: probe number of channels from registers
Date: Thu, 7 Mar 2024 14:33:04 +0100
Message-ID: <20240307133306.383045-9-fabrice.gasnier@foss.st.com>
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

Probe the number of capture compare channels, by writing CCER register bits
and read them back. Take care to restore the register original value.

This is a precursor patch to support capture channels.

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v5:
- Add William's Reviewed-by tag.

Changes in v4:
- directly use dev struct in stm32_timer_cnt_detect_channels routine.

Changes in v3:
- New patch split from:
  "counter: stm32-timer-cnt: populate capture channels and check encoder"
---
 drivers/counter/stm32-timer-cnt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index f63d0c3e3f22..e1c0a502b74c 100644
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


