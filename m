Return-Path: <linux-kernel+bounces-95606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3346B87501D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA7EB23CBC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1923F12D75F;
	Thu,  7 Mar 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bnOUkcyT"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5DF12D1E7;
	Thu,  7 Mar 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818520; cv=none; b=PXZETNFMur4sc8TosFeQqzNl2A4gp/sFEuynE4ekqZG3y3g06FmlbOKYzR34Ha0jOnr9lzY48MOJ7WgPQwivJavYNi/LneyccKwftJVcNzEb61JnvL4t8ZP6DdSg3dp2cuBR8+KO6pXdvRaNeT+OrUzxxjstcp4NQ3RqnLwD+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818520; c=relaxed/simple;
	bh=K2t6XW0yayRUTM/VqG9sAxv10aUbmNatb6dKYz9MM9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wh65VWZZwQiMur1gcIBUCjWjCyHD0p38tuEI/3/4uN8Vfgna9HOI28uB4ZyFX3FD4BanuMLtaRhhkCg+NZ+BOE4xZY2ZemcHR66gc3yK88Xz+GuMq8KH7980lWGPnyQe5Ro3kkrzgzd5igfLHvVhdztnyOI0U5GEzVTLShBMkxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bnOUkcyT; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4279vKUL030012;
	Thu, 7 Mar 2024 14:35:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=b3XSIJTaaxtWqB8xdRUlG+Rl9a7/6rNgDWZPJrrBm8Y=; b=bn
	OUkcyTyA29idWHTORzyz5CrsvHiYTvtAksB8n/wkjlCZ1vfDpIN/DWfhUMWG/uGx
	/vXAZ2zc1swbM/qtDZyLYYY78r3RR6sFs8Sk78atK/Un0DpoZsCDat72SmIQsOoq
	vfke4NPESSvIDSQe8fLwRjHKsjQQhwduLKahN3jm3gIagwksYGW2yRLHPAB8PODE
	hAdKZvF4iRtphQFAuEgEujAnw578rBMzxz0ywcUnKZj9uArjowJulhym5/AdtSjt
	xptvYCOGGySVortJTypIOGg4XYySDbr3uIzesOzv3+8cfIirliCmc9pMAwYnyhYy
	bV5GQhV74XFE+PIpzXJA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wktdmgh43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 14:35:09 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 51AD140049;
	Thu,  7 Mar 2024 14:35:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B069027A504;
	Thu,  7 Mar 2024 14:34:40 +0100 (CET)
Received: from localhost (10.201.22.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Mar
 2024 14:34:40 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 07/10] counter: stm32-timer-cnt: introduce channels
Date: Thu, 7 Mar 2024 14:33:03 +0100
Message-ID: <20240307133306.383045-8-fabrice.gasnier@foss.st.com>
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

Simply add channels 3 and 4 that can be used for capture. Statically
add them, despite some timers doesn't have them. Rather rely on
stm32_action_read that will report "none" action for these currently.

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Add William's Reviewed-by tag
Changes in v3:
- New patch split from:
  "counter: stm32-timer-cnt: populate capture channels and check encoder"
---
 drivers/counter/stm32-timer-cnt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 17f87ace450d..f63d0c3e3f22 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -25,6 +25,8 @@
 #define STM32_CH1_SIG		0
 #define STM32_CH2_SIG		1
 #define STM32_CLOCK_SIG		2
+#define STM32_CH3_SIG		3
+#define STM32_CH4_SIG		4
 
 struct stm32_timer_regs {
 	u32 cr1;
@@ -365,6 +367,14 @@ static struct counter_signal stm32_signals[] = {
 		.ext = stm32_count_clock_ext,
 		.num_ext = ARRAY_SIZE(stm32_count_clock_ext),
 	},
+	{
+		.id = STM32_CH3_SIG,
+		.name = "Channel 3"
+	},
+	{
+		.id = STM32_CH4_SIG,
+		.name = "Channel 4"
+	},
 };
 
 static struct counter_synapse stm32_count_synapses[] = {
@@ -383,6 +393,16 @@ static struct counter_synapse stm32_count_synapses[] = {
 		.num_actions = ARRAY_SIZE(stm32_clock_synapse_actions),
 		.signal = &stm32_signals[STM32_CLOCK_SIG]
 	},
+	{
+		.actions_list = stm32_synapse_actions,
+		.num_actions = ARRAY_SIZE(stm32_synapse_actions),
+		.signal = &stm32_signals[STM32_CH3_SIG]
+	},
+	{
+		.actions_list = stm32_synapse_actions,
+		.num_actions = ARRAY_SIZE(stm32_synapse_actions),
+		.signal = &stm32_signals[STM32_CH4_SIG]
+	},
 };
 
 static struct counter_count stm32_counts = {
-- 
2.25.1


