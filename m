Return-Path: <linux-kernel+bounces-83746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587A6869DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FCB1C21357
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D417714900D;
	Tue, 27 Feb 2024 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wVWdnsZ3"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6531487D5;
	Tue, 27 Feb 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055564; cv=none; b=SNGHAqSS8Oy8nxhsP7YzgMAxNbdkcA4OZktj+MJBiGQQrl+LqfhGoJgajee0XHZsXEgD6ZUQFzampmftaUNC1zLkdp2ohD/VYufmQSGAsrAxHRELg9lzr3eUSMAGNuxfrx68EBSTbiS0sPZuPCHg2YaYB76XP3Budk6Iu5RznoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055564; c=relaxed/simple;
	bh=LWsw026/asPNOxKB3DfQPCtN+8c7p5NHBaCKCQqDSWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTYWbq8FaxQRIaYUZ6piu3prXtfsiHFcULUHqexyHmrh1VVWlVMRD5fStq41mrdb2u9fcNKWqG8JPKxW9tpwQUpa6v+AiXHaqWzB9WolwoxvPP+BZsOf7Qp3AHfzZDmC4qWTev88fLJ5C5uOt0kj6nItQ7N26DzVP3gapD5MPd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wVWdnsZ3; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBiEn9010585;
	Tue, 27 Feb 2024 18:39:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=+7nWDb9ZWuayfFkASgiJUL4avZyU6WuY7zpZjhvk6Uc=; b=wV
	WdnsZ3KwTRrBtGf4nGJoOh5h+XiliszfOEy4KMP9nf2kh8oyO4ec6UQUV03C1q7n
	OJ/XxL1Ulul2aIIVpZhbtlcaQqIlpop54bFBtOvlU1Pworl9xObmpW6bI1juBESI
	BuqEE1Hx2EfFzPlC3QHxcrEswaaNdu3JChPGXVpyJigE4JDFSltoy2p+wfftizg/
	VVO6qe09IR80WC4EyhTN9aAOItp7bEaZSKuyWgIxfJrgrho9S5CTh2PN35+JZPHo
	aULVBwiezHqtN9Gx0sKal+O6nhmSCU+StN3D6fCVw3RHMm3o907N6tybH9r969LQ
	o6l3Yi5cY2XzglAsQ1eg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4cscb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:38:49 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A9BBB40047;
	Tue, 27 Feb 2024 18:38:44 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 123D52AD127;
	Tue, 27 Feb 2024 18:38:20 +0100 (CET)
Received: from localhost (10.252.26.109) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 27 Feb
 2024 18:38:17 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 04/11] counter: stm32-timer-cnt: adopt signal definitions
Date: Tue, 27 Feb 2024 18:37:56 +0100
Message-ID: <20240227173803.53906-5-fabrice.gasnier@foss.st.com>
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
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02

Adopt signals definitions to ease later signals additions.
There are no intended functional changes here.

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Add William's Reviewed-by tag
Changes in v3:
 New patch split from "counter: stm32-timer-cnt: introduce clock signal"
---
 drivers/counter/stm32-timer-cnt.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 668e9d1061d3..c34747d7857e 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -21,6 +21,9 @@
 #define TIM_CCER_MASK	(TIM_CCER_CC1P | TIM_CCER_CC1NP | \
 			 TIM_CCER_CC2P | TIM_CCER_CC2NP)
 
+#define STM32_CH1_SIG		0
+#define STM32_CH2_SIG		1
+
 struct stm32_timer_regs {
 	u32 cr1;
 	u32 cnt;
@@ -247,14 +250,14 @@ static int stm32_action_read(struct counter_device *counter,
 		return 0;
 	case COUNTER_FUNCTION_QUADRATURE_X2_A:
 		/* counts up/down on TI1FP1 edge depending on TI2FP2 level */
-		if (synapse->signal->id == count->synapses[0].signal->id)
+		if (synapse->signal->id == STM32_CH1_SIG)
 			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
 		else
 			*action = COUNTER_SYNAPSE_ACTION_NONE;
 		return 0;
 	case COUNTER_FUNCTION_QUADRATURE_X2_B:
 		/* counts up/down on TI2FP2 edge depending on TI1FP1 level */
-		if (synapse->signal->id == count->synapses[1].signal->id)
+		if (synapse->signal->id == STM32_CH2_SIG)
 			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
 		else
 			*action = COUNTER_SYNAPSE_ACTION_NONE;
@@ -278,11 +281,11 @@ static const struct counter_ops stm32_timer_cnt_ops = {
 
 static struct counter_signal stm32_signals[] = {
 	{
-		.id = 0,
+		.id = STM32_CH1_SIG,
 		.name = "Channel 1"
 	},
 	{
-		.id = 1,
+		.id = STM32_CH2_SIG,
 		.name = "Channel 2"
 	}
 };
@@ -291,12 +294,12 @@ static struct counter_synapse stm32_count_synapses[] = {
 	{
 		.actions_list = stm32_synapse_actions,
 		.num_actions = ARRAY_SIZE(stm32_synapse_actions),
-		.signal = &stm32_signals[0]
+		.signal = &stm32_signals[STM32_CH1_SIG]
 	},
 	{
 		.actions_list = stm32_synapse_actions,
 		.num_actions = ARRAY_SIZE(stm32_synapse_actions),
-		.signal = &stm32_signals[1]
+		.signal = &stm32_signals[STM32_CH2_SIG]
 	}
 };
 
-- 
2.25.1


