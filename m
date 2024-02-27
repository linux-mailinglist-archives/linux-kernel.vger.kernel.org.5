Return-Path: <linux-kernel+bounces-83751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9A869E07
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F7628EA36
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8CE1482E2;
	Tue, 27 Feb 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bS+u84A6"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D121419B3;
	Tue, 27 Feb 2024 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055609; cv=none; b=a/r2ZNPXeTAm/seQms04Odfcm03V7xYcMnL1gRNj/fQ0Gl36f19VvgnJ7cvseP3z2vz0mlcLzQ3C+9nuAWs8uSnSFY/YcYUqcBGa9AUXXJzpOh4ph5k3HHm2laoifT1sVPBk/XAgrvBaNCpbrj6qiJeUonra4OvEKMhNVJYQDGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055609; c=relaxed/simple;
	bh=eCUUel4lLjjOP2DK1HWiX/4ToVHiW7+1ng7LHwDWrXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbQTz+BeHKLPFQCW49EYmX18tUWHDnaP09uc2VyVIEiLZffIG9mcHiMQ3qkkysU/pP3sFcafoifZ5D3fX4JUiRmhSUeYzurbdbGdpiZK1AR7IjjAfxAT8C3lqbnVRr/dGwMn/lHy7mCjpLNaL9rb+RfpE45Hfmh000+SRgFihDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bS+u84A6; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBiDrS010569;
	Tue, 27 Feb 2024 18:39:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=5kAJdzvKyNBF4DCTisnMcXkF/FxsQlkKDl8EbRW2k+4=; b=bS
	+u84A6yTVBC5frrrXDTKtPKuymOYjudO7gJVI7MixQhN0g3bQWy2XSKlA6w3cqpe
	4QpVebHBgQhDG2efHU3F3Vs9tknKexjfZse2U/b11Mc3IUkHFGYExfcbvYnrqsow
	rypD6lnKuT2ik/plvXG5s8W7HOcTWxg5hL8qvv4HB5IU+jdo1qB89Y5+xmx5EcG/
	48RuaSO5TlPA6XMCKuDhfbZSDdHqrK/zJ4hpkncPbzmiX3nx4dNUy+/z4oacKwzN
	H5gSKDfviAB6Uugwu9yDR0I+v3Tsu7KIA8/zv/e0hQuQ1V+IHyJ+801S9R7OrVsh
	3FTYaU5Vb36j2vKvpLfA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4cscdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:39:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CDD8D40044;
	Tue, 27 Feb 2024 18:39:53 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0F61C2AD131;
	Tue, 27 Feb 2024 18:39:30 +0100 (CET)
Received: from localhost (10.252.26.109) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 27 Feb
 2024 18:39:29 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 08/11] counter: stm32-timer-cnt: introduce channels
Date: Tue, 27 Feb 2024 18:38:00 +0100
Message-ID: <20240227173803.53906-9-fabrice.gasnier@foss.st.com>
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
index 144e040fa457..66039d1b3642 100644
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


