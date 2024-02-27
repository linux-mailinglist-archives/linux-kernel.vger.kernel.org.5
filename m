Return-Path: <linux-kernel+bounces-83752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53F5869E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC11B3512A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB2C14A4F0;
	Tue, 27 Feb 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="A2Q+wTCW"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87948145354;
	Tue, 27 Feb 2024 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055610; cv=none; b=AKN6/R3NqVg45lWfO+7HswjoVavJJYj82pe/LCmnds4pGvGXJp1XG0vGR8P6gF6oB0NNg1oUE/y1HLygNI8MauqLZcvPYWKAMdLiuYXPkF52z1mXxdCYfpU9yEL4t8wC9762HwJ/k0Bu+E4Jpiok7BMhqR4TjyFnDBRWHWHw6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055610; c=relaxed/simple;
	bh=z1P+wWPYf4rLAUgC8ajYKV1jKinfx+jSfcRmHbuBEZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkAfGpzrpo/+641IujpiTSg6S7ERJa74x7PKwkguJ3oZDvIH/Jb08TFuJJWz6apjab+9y+uu0S80wWj4msOmRHwjEDvJJBWw/E2PjYDX0M92ZC3wvMTB6B2/NG2S0G3onp5jv1VTZpwe7ujfJY7LjVvRM3GoyTM1uD8lill1eOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=A2Q+wTCW; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBiQOt000980;
	Tue, 27 Feb 2024 18:39:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=gV6cLaC3QIdWwPldH7ryzYKtFzveQ4F+ZEi3MqaDLGQ=; b=A2
	Q+wTCWICkGwGXI40VVYyhrFKShGCiRvAzPHzbms2xSRWwgt+ZFi4vGypEDXDQ81f
	wL6HRRhgnp2qVu9ueaxUa7/Xw4sOx+0X5Gj3bYRe22hQAMY6ztGZNtE3o66wBze6
	lyxklbgAeaV53scGdVO/Z/YWeHxd+QZf0Q1+K1LlnJ+FercptdILmHjCIf0M2QTF
	X7JlTZ6/LimD8KpoiWRCfMEAIqOAUI4X9KFBPujKYvZ+Yd8OlMsH8GMN0VK1uWBg
	9VCX7/4esXGb67f+FN0ygcSzGPNaQY6/XSSV4CEC5Dg5+EKs849w+vTf1VKvXMr5
	w1ZaE0xDxmCe6qzGvfbw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4dscee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:39:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D112D40045;
	Tue, 27 Feb 2024 18:39:53 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 28F832AD127;
	Tue, 27 Feb 2024 18:39:29 +0100 (CET)
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
Subject: [PATCH v4 05/11] counter: stm32-timer-cnt: introduce clock signal
Date: Tue, 27 Feb 2024 18:37:57 +0100
Message-ID: <20240227173803.53906-6-fabrice.gasnier@foss.st.com>
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

Introduce the internal clock signal, used to count when in simple rising
function. Also add the "frequency" extension to the clock signal.

With this patch, signal action reports a consistent state when "increase"
function is used, and the counting frequency:
    $ echo increase > function
    $ grep -H "" signal*_action
    signal0_action:none
    signal1_action:none
    signal2_action:rising edge
    $ echo 1 > enable
    $ cat count
    25425
    $ cat count
    44439
    $ cat ../signal2/frequency
    208877930

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Introduce COUNTER_COMP_FREQUENCY() macro as suggested by William in [1]
[1] https://lore.kernel.org/lkml/ZZwm7ZyrL7vFn0Xd@ubuntu-server-vm-macos/
- Remove "Signal" from "Clock Signal" name which is redundant with sysfs
  path that already has signal as a name.
Changes in v3:
- split the patch in 3 parts: signal definition becomes a pre-cursor patch,
  add the "prescaler" extension in its own patch.
- Move the clock signal at the end of the signals array, so existing
  userspace programs that may rely on signal0 being "Channel 1" for
  example will remain compatible.
---
 drivers/counter/stm32-timer-cnt.c | 53 ++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index c34747d7857e..b914c87b6f10 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -23,6 +23,7 @@
 
 #define STM32_CH1_SIG		0
 #define STM32_CH2_SIG		1
+#define STM32_CLOCK_SIG		2
 
 struct stm32_timer_regs {
 	u32 cr1;
@@ -226,6 +227,10 @@ static struct counter_comp stm32_count_ext[] = {
 			     stm32_count_ceiling_write),
 };
 
+static const enum counter_synapse_action stm32_clock_synapse_actions[] = {
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+};
+
 static const enum counter_synapse_action stm32_synapse_actions[] = {
 	COUNTER_SYNAPSE_ACTION_NONE,
 	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
@@ -246,7 +251,10 @@ static int stm32_action_read(struct counter_device *counter,
 	switch (function) {
 	case COUNTER_FUNCTION_INCREASE:
 		/* counts on internal clock when CEN=1 */
-		*action = COUNTER_SYNAPSE_ACTION_NONE;
+		if (synapse->signal->id == STM32_CLOCK_SIG)
+			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
+		else
+			*action = COUNTER_SYNAPSE_ACTION_NONE;
 		return 0;
 	case COUNTER_FUNCTION_QUADRATURE_X2_A:
 		/* counts up/down on TI1FP1 edge depending on TI2FP2 level */
@@ -264,7 +272,10 @@ static int stm32_action_read(struct counter_device *counter,
 		return 0;
 	case COUNTER_FUNCTION_QUADRATURE_X4:
 		/* counts up/down on both TI1FP1 and TI2FP2 edges */
-		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
+		if (synapse->signal->id == STM32_CH1_SIG || synapse->signal->id == STM32_CH2_SIG)
+			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
+		else
+			*action = COUNTER_SYNAPSE_ACTION_NONE;
 		return 0;
 	default:
 		return -EINVAL;
@@ -279,7 +290,30 @@ static const struct counter_ops stm32_timer_cnt_ops = {
 	.action_read = stm32_action_read,
 };
 
+static int stm32_count_clk_get_freq(struct counter_device *counter,
+				    struct counter_signal *signal, u64 *freq)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+
+	*freq = clk_get_rate(priv->clk);
+
+	return 0;
+}
+
+static struct counter_comp stm32_count_clock_ext[] = {
+	COUNTER_COMP_FREQUENCY(stm32_count_clk_get_freq, NULL),
+};
+
 static struct counter_signal stm32_signals[] = {
+	/*
+	 * Need to declare all the signals as a static array, and keep the signals order here,
+	 * even if they're unused or unexisting on some timer instances. It's an abstraction,
+	 * e.g. high level view of the counter features.
+	 *
+	 * Userspace programs may rely on signal0 to be "Channel 1", signal1 to be "Channel 2",
+	 * and so on. When a signal is unexisting, the COUNTER_SYNAPSE_ACTION_NONE can be used,
+	 * to indicate that a signal doesn't affect the counter.
+	 */
 	{
 		.id = STM32_CH1_SIG,
 		.name = "Channel 1"
@@ -287,7 +321,13 @@ static struct counter_signal stm32_signals[] = {
 	{
 		.id = STM32_CH2_SIG,
 		.name = "Channel 2"
-	}
+	},
+	{
+		.id = STM32_CLOCK_SIG,
+		.name = "Clock",
+		.ext = stm32_count_clock_ext,
+		.num_ext = ARRAY_SIZE(stm32_count_clock_ext),
+	},
 };
 
 static struct counter_synapse stm32_count_synapses[] = {
@@ -300,7 +340,12 @@ static struct counter_synapse stm32_count_synapses[] = {
 		.actions_list = stm32_synapse_actions,
 		.num_actions = ARRAY_SIZE(stm32_synapse_actions),
 		.signal = &stm32_signals[STM32_CH2_SIG]
-	}
+	},
+	{
+		.actions_list = stm32_clock_synapse_actions,
+		.num_actions = ARRAY_SIZE(stm32_clock_synapse_actions),
+		.signal = &stm32_signals[STM32_CLOCK_SIG]
+	},
 };
 
 static struct counter_count stm32_counts = {
-- 
2.25.1


