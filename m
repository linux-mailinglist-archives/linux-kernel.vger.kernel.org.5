Return-Path: <linux-kernel+bounces-83753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDC0869E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F1DB35353
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBBF14CAC3;
	Tue, 27 Feb 2024 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VApBCMRA"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C6914AD31;
	Tue, 27 Feb 2024 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055615; cv=none; b=dTHkXnl6pYlzkL/vDj145Q3O2IXLM6xVeS8p48JIRHW0t//wQ9BKyyaS14pxTlZQH1ICxdrvDg3latWXkUW3DVZ7YLQea3pXW/VCfMm6udbKdP/LJazd4eLSJKJHaBAExApZTet3A/QcfvDxbskOfkNHEAY5xz8iz0f3yiXXmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055615; c=relaxed/simple;
	bh=g+B/ZxmAt+hidesVqjrDVmazvLTbNKrI+x7QfWgm3ag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsprYYiihjTobvrFQdvb68z3EoDjB6uxtPsJPoj/xa5ucR1V32osTP3vmAFI0hPy9FF1Bzy7P6WYsI/0K/4MuWq4VyTfG+jVvyhuF9yLf+1HOT5Ng5cJAlc3qAjpue9/Trq3kNpxQTgaLwFDNHus+h6z5w2otd/rIQsjw7klzCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VApBCMRA; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBiVd8001069;
	Tue, 27 Feb 2024 18:40:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=23cef0f6RemlkBcr/fQtp0mL/3K1zOCA/BsyeJEat+c=; b=VA
	pBCMRAJwEQutMw8gFa+tACUDnxyErwwB5Rlp86EGqI4dFkbxxmmciiwTvHgaBuvQ
	+kfaNDUsqsf4HdPQnPQDGr5cWO3bDKc7yGHz9lbBoyNsTtfkDKJhmGCH0+koWqxo
	7w/+gm8oZXuZAJg81fw5SpChVTZe841C2WQn7AoJ/XZGY5s62NQclzPMB2CS7SBB
	X6fLcWaZA+cmnlYI9eo8+SeuvMwwuBcTwvBmhdWp+w+Ta+c7m9ZRQhARhInCc84h
	i1YkebCrS5rwgQ36+mhRQmqiFF/eqWzrYdUg3lo0/5oe1yX2eJ2oBHUB1Ukfdd8c
	S1JHMNYAMK0SIUb2NJRQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4dsces-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:40:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E723F40045;
	Tue, 27 Feb 2024 18:39:59 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 13A452AD128;
	Tue, 27 Feb 2024 18:39:31 +0100 (CET)
Received: from localhost (10.252.26.109) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 27 Feb
 2024 18:39:28 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 06/11] counter: stm32-timer-cnt: add counter prescaler extension
Date: Tue, 27 Feb 2024 18:37:58 +0100
Message-ID: <20240227173803.53906-7-fabrice.gasnier@foss.st.com>
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

There's a prescaler in between the selected input signal used for
counting (CK_PSC), and the counter input (CK_CNT).
So add the "prescaler" extension to the counter.

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Add William's Reviewed-by tag
Changes in v3:
- New patch split from "counter: stm32-timer-cnt: introduce clock signal"
---
 drivers/counter/stm32-timer-cnt.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index b914c87b6f10..e0709dd7dcfd 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -220,11 +220,40 @@ static int stm32_count_enable_write(struct counter_device *counter,
 	return 0;
 }
 
+static int stm32_count_prescaler_read(struct counter_device *counter,
+				      struct counter_count *count, u64 *prescaler)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	u32 psc;
+
+	regmap_read(priv->regmap, TIM_PSC, &psc);
+
+	*prescaler = psc + 1;
+
+	return 0;
+}
+
+static int stm32_count_prescaler_write(struct counter_device *counter,
+				       struct counter_count *count, u64 prescaler)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	u32 psc;
+
+	if (!prescaler || prescaler > MAX_TIM_PSC + 1)
+		return -ERANGE;
+
+	psc = prescaler - 1;
+
+	return regmap_write(priv->regmap, TIM_PSC, psc);
+}
+
 static struct counter_comp stm32_count_ext[] = {
 	COUNTER_COMP_DIRECTION(stm32_count_direction_read),
 	COUNTER_COMP_ENABLE(stm32_count_enable_read, stm32_count_enable_write),
 	COUNTER_COMP_CEILING(stm32_count_ceiling_read,
 			     stm32_count_ceiling_write),
+	COUNTER_COMP_COUNT_U64("prescaler", stm32_count_prescaler_read,
+			       stm32_count_prescaler_write),
 };
 
 static const enum counter_synapse_action stm32_clock_synapse_actions[] = {
-- 
2.25.1


