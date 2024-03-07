Return-Path: <linux-kernel+bounces-95607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312E7875021
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F98C1F23B71
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A8112DDB0;
	Thu,  7 Mar 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="8XHLkKbl"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044D012D755;
	Thu,  7 Mar 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818522; cv=none; b=hjQMDvWFDjrNWdsYFBFnU7AYFJaTABX9FvX5eymU3ib6W7ElEETpd/8Cd3VO1kVIk/wgukDuCL0cKmOSWMnmRnRr/YRkW4/fwkSvDrX07fJwSElMQcltcpMM1umothGvDnmi7Gol7+yiaHxLzwtHfu0iDPHRNAhpVznG220Wx8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818522; c=relaxed/simple;
	bh=xSphM6WnGvl8d1xN8bvZPdIouR73+Nnz5DSIQDy1jQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGcCAkJOMd3yHJWutQfzjrqz53LI0JCy0OIBJVzd5IaWYArgfAMgM40IdhsdFn11S8HaA+Guqu02MoTRGjiQQUH+HUGC/Zx7b5C0SzkwHU9b5o7UkrD3jjpQiu03o6kYepKDlu7MtT8T1B/Su97sZndDXJjkujuhYPMpSgqcfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=8XHLkKbl; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4278eS77014219;
	Thu, 7 Mar 2024 14:35:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=j5LYoNpWBrOk/Pfrt8DrnNoB0RQgOHa3KZB9xD3ISKQ=; b=8X
	HLkKbl6ZcY4LwurRPqcZE5Nt5d2tOjKEEVsjPUEfNmZ85FtdQ5sr05Aghrhek/Hn
	YJTAuwrl0y2IJnir0FZw5YW16JiYpOMrjz79Phyh31PcJM+7IN/NaWiYDmXoIvB0
	QBSXGtF+UpG/8/PQT3eVPYEEUkFa8L9Cil95ha45JLJEOXhVmcbiuMFl3RAazX6H
	wf1b/ZoVExM8VAZIZ/2VHYLJjWY+NwMU+aTLcZsObF1sKHWudm0CmOXASQYf2JXm
	GXHZL/++eM3d3EygVu8ZyB4gT3saHpODdxhinUGPHVcKN+v33qo7UkFppaEw2nAt
	W1gtlya9qFzUSkV9KRfg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wktdmgh44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 14:35:09 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 246D040047;
	Thu,  7 Mar 2024 14:35:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 995CD27A501;
	Thu,  7 Mar 2024 14:34:40 +0100 (CET)
Received: from localhost (10.201.22.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Mar
 2024 14:34:39 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 06/10] counter: stm32-timer-cnt: add checks on quadrature encoder capability
Date: Thu, 7 Mar 2024 14:33:02 +0100
Message-ID: <20240307133306.383045-7-fabrice.gasnier@foss.st.com>
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

This is a precursor patch to support capture channels on all possible
channels and stm32 timer types. Original driver was intended to be used
only as quadrature encoder and simple counter on internal clock.

So, add a check on encoder capability, so the driver may be probed for
timer instances without encoder feature. This way, all timers may be used
as simple counter on internal clock, starting from here.

Encoder capability is retrieved by using the timer index (originally in
stm32-timer-trigger driver and dt-bindings). The need to keep backward
compatibility with existing device tree lead to parse aside trigger node.

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v5:
- Add William's Reviewed-by tag.

Changes in v4:
- drop idx from struct stm32_timer_cnt as unused after probing
- directly use dev struct in stm32_timer_cnt_probe_encoder routine.

Changes in v3:
- New patch split from:
  "counter: stm32-timer-cnt: populate capture channels and check encoder"
- return -EOPNOTSUPP when encoder function isn't supported by the timer
  instance.
---
 drivers/counter/stm32-timer-cnt.c | 55 +++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index b969d550e90a..17f87ace450d 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -11,6 +11,7 @@
 #include <linux/mfd/stm32-timers.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
@@ -38,6 +39,7 @@ struct stm32_timer_cnt {
 	u32 max_arr;
 	bool enabled;
 	struct stm32_timer_regs bak;
+	bool has_encoder;
 };
 
 static const enum counter_function stm32_count_functions[] = {
@@ -111,12 +113,18 @@ static int stm32_count_function_write(struct counter_device *counter,
 		sms = TIM_SMCR_SMS_SLAVE_MODE_DISABLED;
 		break;
 	case COUNTER_FUNCTION_QUADRATURE_X2_A:
+		if (!priv->has_encoder)
+			return -EOPNOTSUPP;
 		sms = TIM_SMCR_SMS_ENCODER_MODE_1;
 		break;
 	case COUNTER_FUNCTION_QUADRATURE_X2_B:
+		if (!priv->has_encoder)
+			return -EOPNOTSUPP;
 		sms = TIM_SMCR_SMS_ENCODER_MODE_2;
 		break;
 	case COUNTER_FUNCTION_QUADRATURE_X4:
+		if (!priv->has_encoder)
+			return -EOPNOTSUPP;
 		sms = TIM_SMCR_SMS_ENCODER_MODE_3;
 		break;
 	default:
@@ -388,6 +396,49 @@ static struct counter_count stm32_counts = {
 	.num_ext = ARRAY_SIZE(stm32_count_ext)
 };
 
+/* encoder supported on TIM1 TIM2 TIM3 TIM4 TIM5 TIM8 */
+#define STM32_TIM_ENCODER_SUPPORTED	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(7))
+
+static const char * const stm32_timer_trigger_compat[] = {
+	"st,stm32-timer-trigger",
+	"st,stm32h7-timer-trigger",
+};
+
+static int stm32_timer_cnt_probe_encoder(struct device *dev,
+					 struct stm32_timer_cnt *priv)
+{
+	struct device *parent = dev->parent;
+	struct device_node *tnode = NULL, *pnode = parent->of_node;
+	int i, ret;
+	u32 idx;
+
+	/*
+	 * Need to retrieve the trigger node index from DT, to be able
+	 * to determine if the counter supports encoder mode. It also
+	 * enforce backward compatibility, and allow to support other
+	 * counter modes in this driver (when the timer doesn't support
+	 * encoder).
+	 */
+	for (i = 0; i < ARRAY_SIZE(stm32_timer_trigger_compat) && !tnode; i++)
+		tnode = of_get_compatible_child(pnode, stm32_timer_trigger_compat[i]);
+	if (!tnode) {
+		dev_err(dev, "Can't find trigger node\n");
+		return -ENODATA;
+	}
+
+	ret = of_property_read_u32(tnode, "reg", &idx);
+	if (ret) {
+		dev_err(dev, "Can't get index (%d)\n", ret);
+		return ret;
+	}
+
+	priv->has_encoder = !!(STM32_TIM_ENCODER_SUPPORTED & BIT(idx));
+
+	dev_dbg(dev, "encoder support: %s\n", priv->has_encoder ? "yes" : "no");
+
+	return 0;
+}
+
 static int stm32_timer_cnt_probe(struct platform_device *pdev)
 {
 	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
@@ -409,6 +460,10 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
 
+	ret = stm32_timer_cnt_probe_encoder(dev, priv);
+	if (ret)
+		return ret;
+
 	counter->name = dev_name(dev);
 	counter->parent = dev;
 	counter->ops = &stm32_timer_cnt_ops;
-- 
2.25.1


