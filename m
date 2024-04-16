Return-Path: <linux-kernel+bounces-146356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4111D8A6417
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993811F218FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBE484FBE;
	Tue, 16 Apr 2024 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cZaO2ZQP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF06E619;
	Tue, 16 Apr 2024 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249436; cv=none; b=ru/49Xvisd7vDgzT/zyqBGJVF9XfapAPaZuljgjeL0RaJ0h2GC1d5nBWPvvspirVVf9AEi67EpkijuCkFl8FZqyc9bXIE7Ackvb+/gdykE+8KydPAgRJugON9CyQFl0XO9IJdsipCfFVKoYsVh25jrHqAZTCTuCgimMdfHJl5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249436; c=relaxed/simple;
	bh=m9SNDDrq3bcVCQeqqqKW11wm9Jed3aP62cdTM2yqO6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/tM4uVF3ciC3bDp5QmjcFPVacRKF+NXtWEV23P7sRFb9oP/Ew00iuFUFph6K3ixGCWAHmY83hLYfFaQyRiiI7F8oIBr5dvXvjmKvDXWJEbvUvPBdMaQkpNSgXIKk66RppAAgcvy78n3TGEK9xKF0gYHn4CjZSe3c3wpnqvD39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cZaO2ZQP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G2ukxB002930;
	Tue, 16 Apr 2024 06:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=7MpdL2yBkuZnHneYfE1i94L1X6lnZkbk5rkHYHKf4Zo=; b=cZ
	aO2ZQP9Uw4a8sNZRa2nHo5o0kXFoU6CnCYS7JYQaoJ1UpIs4ElwQ7ixIhaujjmT6
	oGxJVpqEt4HLZDpZb4DnlS0+fCk8qMfFnq7ELH9u/6ywZLzVPLMrOy1/tkOjzIJe
	PrE6rgTCKUss+yTNpgwBRB7/MlP7bTVudBapUYMLtW4cWail2OR7UXXtZMHpXbd9
	z8RVE4j9NQhvIAVoyj50iACvofPqVzXjzLnK4gdRiPkQ2JSM9HXH0ENfwagZexvP
	ROX66yy4O2FepO7y+UTkts4Of4FnFPp+oKWLOwqauob7BSqz00sYqnBrXKdeAmWo
	kpRwfSyVF+eVArNRxHNQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xh1m5jqna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 06:36:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G6aqT0002599
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 06:36:52 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Apr 2024 23:36:47 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami
	<bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <quic_pkumpatl@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v2 4/8] ASoC: codecs: wcd937x-sdw: add SoundWire driver
Date: Tue, 16 Apr 2024 12:05:56 +0530
Message-ID: <20240416063600.309747-5-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416063600.309747-1-quic_mohs@quicinc.com>
References: <20240416063600.309747-1-quic_mohs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ts5slUZoxJkwzwV6T3JBKbnMcUI3JPtn
X-Proofpoint-ORIG-GUID: Ts5slUZoxJkwzwV6T3JBKbnMcUI3JPtn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_03,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 mlxlogscore=949 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160038

From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>

This patch adds support to SoundWire devices on WCD9370/WCD9375 Codec.

Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
---
 sound/soc/codecs/wcd937x-sdw.c | 1148 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/wcd937x.c     |   90 +++
 sound/soc/codecs/wcd937x.h     |   38 ++
 3 files changed, 1276 insertions(+)
 create mode 100644 sound/soc/codecs/wcd937x-sdw.c

diff --git a/sound/soc/codecs/wcd937x-sdw.c b/sound/soc/codecs/wcd937x-sdw.c
new file mode 100644
index 000000000000..9a0d68aaad9a
--- /dev/null
+++ b/sound/soc/codecs/wcd937x-sdw.c
@@ -0,0 +1,1148 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+
+#include <linux/component.h>
+#include <linux/device.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/soundwire/sdw_type.h>
+#include <sound/soc-dapm.h>
+#include <sound/soc.h>
+#include "wcd937x.h"
+
+static struct wcd937x_sdw_ch_info wcd937x_sdw_rx_ch_info[] = {
+	WCD_SDW_CH(WCD937X_HPH_L, WCD937X_HPH_PORT, BIT(0)),
+	WCD_SDW_CH(WCD937X_HPH_R, WCD937X_HPH_PORT, BIT(1)),
+	WCD_SDW_CH(WCD937X_CLSH, WCD937X_CLSH_PORT, BIT(0)),
+	WCD_SDW_CH(WCD937X_COMP_L, WCD937X_COMP_PORT, BIT(0)),
+	WCD_SDW_CH(WCD937X_COMP_R, WCD937X_COMP_PORT, BIT(1)),
+	WCD_SDW_CH(WCD937X_LO, WCD937X_LO_PORT, BIT(0)),
+	WCD_SDW_CH(WCD937X_DSD_L, WCD937X_DSD_PORT, BIT(0)),
+	WCD_SDW_CH(WCD937X_DSD_R, WCD937X_DSD_PORT, BIT(1)),
+};
+
+static struct wcd937x_sdw_ch_info wcd937x_sdw_tx_ch_info[] = {
+	WCD_SDW_CH(WCD937X_ADC1, WCD937X_SDW_PORT0, BIT(0)),
+	WCD_SDW_CH(WCD937X_ADC2, WCD937X_SDW_PORT1, BIT(0)),
+	WCD_SDW_CH(WCD937X_ADC3, WCD937X_SDW_PORT1, BIT(0)),
+	WCD_SDW_CH(WCD937X_DMIC0, WCD937X_SDW_PORT2, BIT(0)),
+	WCD_SDW_CH(WCD937X_DMIC1, WCD937X_SDW_PORT2, BIT(1)),
+	/* MBHC and DMIC2 share the same channel */
+	WCD_SDW_CH(WCD937X_MBHC, WCD937X_SDW_PORT2, BIT(2)),
+	WCD_SDW_CH(WCD937X_DMIC2, WCD937X_SDW_PORT2, BIT(2)),
+	WCD_SDW_CH(WCD937X_DMIC3, WCD937X_SDW_PORT2, BIT(3)),
+	WCD_SDW_CH(WCD937X_DMIC4, WCD937X_SDW_PORT3, BIT(0)),
+	WCD_SDW_CH(WCD937X_DMIC5, WCD937X_SDW_PORT3, BIT(1)),
+	WCD_SDW_CH(WCD937X_DMIC6, WCD937X_SDW_PORT3, BIT(2)),
+	WCD_SDW_CH(WCD937X_DMIC7, WCD937X_SDW_PORT3, BIT(3)),
+};
+
+static struct sdw_dpn_prop wcd937x_dpn_prop[WCD937X_MAX_SWR_PORTS] = {
+	{
+		.num = 1,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 4, /* 4? 8? */
+		.simple_ch_prep_sm = true,
+	}, {
+		.num = 2,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 4,
+		.simple_ch_prep_sm = true,
+	}, {
+		.num = 3,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 4,
+		.simple_ch_prep_sm = true,
+	}, {
+		.num = 4,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 4,
+		.simple_ch_prep_sm = true,
+	}, {
+		.num = 5,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 4,
+		.simple_ch_prep_sm = true,
+	}
+};
+
+struct device *wcd937x_sdw_device_get(struct device_node *np)
+{
+	return bus_find_device_by_of_node(&sdw_bus_type, np);
+}
+EXPORT_SYMBOL_GPL(wcd937x_sdw_device_get);
+
+int wcd937x_sdw_hw_params(struct wcd937x_sdw_priv *wcd,
+			  struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params,
+			  struct snd_soc_dai *dai)
+{
+	struct sdw_port_config port_config[WCD937X_MAX_SWR_PORTS];
+	unsigned long ch_mask;
+	int i, j;
+
+	wcd->sconfig.ch_count = 1;
+	wcd->active_ports = 0;
+	for (i = 0; i < WCD937X_MAX_SWR_PORTS; i++) {
+		ch_mask = wcd->port_config[i].ch_mask;
+		if (!ch_mask)
+			continue;
+
+		for_each_set_bit(j, &ch_mask, 4)
+			wcd->sconfig.ch_count++;
+
+		port_config[wcd->active_ports] = wcd->port_config[i];
+		wcd->active_ports++;
+	}
+
+	wcd->sconfig.bps = 1;
+	wcd->sconfig.frame_rate = params_rate(params);
+	wcd->sconfig.direction = wcd->is_tx ? SDW_DATA_DIR_TX : SDW_DATA_DIR_RX;
+	wcd->sconfig.type = SDW_STREAM_PCM;
+
+	return sdw_stream_add_slave(wcd->sdev, &wcd->sconfig,
+				    &port_config[0], wcd->active_ports,
+				    wcd->sruntime);
+}
+EXPORT_SYMBOL_GPL(wcd937x_sdw_hw_params);
+
+static int wcd937x_update_status(struct sdw_slave *slave, enum sdw_slave_status status)
+{
+	struct wcd937x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
+
+	if (wcd->regmap && status == SDW_SLAVE_ATTACHED) {
+		/* Write out any cached changes that happened between probe and attach */
+		regcache_cache_only(wcd->regmap, false);
+		return regcache_sync(wcd->regmap);
+	}
+
+	return 0;
+}
+
+static int wcd937x_interrupt_callback(struct sdw_slave *slave,
+				      struct sdw_slave_intr_status *status)
+{
+	struct wcd937x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
+	struct irq_domain *slave_irq = wcd->slave_irq;
+	u32 sts1, sts2, sts3;
+
+	do {
+		handle_nested_irq(irq_find_mapping(slave_irq, 0));
+		regmap_read(wcd->regmap, WCD937X_DIGITAL_INTR_STATUS_0, &sts1);
+		regmap_read(wcd->regmap, WCD937X_DIGITAL_INTR_STATUS_1, &sts2);
+		regmap_read(wcd->regmap, WCD937X_DIGITAL_INTR_STATUS_2, &sts3);
+
+	} while (sts1 || sts2 || sts3);
+
+	return IRQ_HANDLED;
+}
+
+static const struct reg_default wcd937x_defaults[] = {
+	{ WCD937X_ANA_BIAS,					0x00 },
+	{ WCD937X_ANA_RX_SUPPLIES,				0x00 },
+	{ WCD937X_ANA_HPH,					0x0c },
+	{ WCD937X_ANA_EAR,					0x00 },
+	{ WCD937X_ANA_EAR_COMPANDER_CTL,			0x02 },
+	{ WCD937X_ANA_TX_CH1,					0x20 },
+	{ WCD937X_ANA_TX_CH2,					0x00 },
+	{ WCD937X_ANA_TX_CH3,					0x20 },
+	{ WCD937X_ANA_TX_CH3_HPF,				0x00 },
+	{ WCD937X_ANA_MICB1_MICB2_DSP_EN_LOGIC,			0x00 },
+	{ WCD937X_ANA_MICB3_DSP_EN_LOGIC,			0x00 },
+	{ WCD937X_ANA_MBHC_MECH,				0x39 },
+	{ WCD937X_ANA_MBHC_ELECT,				0x08 },
+	{ WCD937X_ANA_MBHC_ZDET,				0x00 },
+	{ WCD937X_ANA_MBHC_RESULT_1,				0x00 },
+	{ WCD937X_ANA_MBHC_RESULT_2,				0x00 },
+	{ WCD937X_ANA_MBHC_RESULT_3,				0x00 },
+	{ WCD937X_ANA_MBHC_BTN0,				0x00 },
+	{ WCD937X_ANA_MBHC_BTN1,				0x10 },
+	{ WCD937X_ANA_MBHC_BTN2,				0x20 },
+	{ WCD937X_ANA_MBHC_BTN3,				0x30 },
+	{ WCD937X_ANA_MBHC_BTN4,				0x40 },
+	{ WCD937X_ANA_MBHC_BTN5,				0x50 },
+	{ WCD937X_ANA_MBHC_BTN6,				0x60 },
+	{ WCD937X_ANA_MBHC_BTN7,				0x70 },
+	{ WCD937X_ANA_MICB1,					0x10 },
+	{ WCD937X_ANA_MICB2,					0x10 },
+	{ WCD937X_ANA_MICB2_RAMP,				0x00 },
+	{ WCD937X_ANA_MICB3,					0x10 },
+	{ WCD937X_BIAS_CTL,					0x2a },
+	{ WCD937X_BIAS_VBG_FINE_ADJ,				0x55 },
+	{ WCD937X_LDOL_VDDCX_ADJUST,				0x01 },
+	{ WCD937X_LDOL_DISABLE_LDOL,				0x00 },
+	{ WCD937X_MBHC_CTL_CLK,					0x00 },
+	{ WCD937X_MBHC_CTL_ANA,					0x00 },
+	{ WCD937X_MBHC_CTL_SPARE_1,				0x00 },
+	{ WCD937X_MBHC_CTL_SPARE_2,				0x00 },
+	{ WCD937X_MBHC_CTL_BCS,					0x00 },
+	{ WCD937X_MBHC_MOISTURE_DET_FSM_STATUS,			0x00 },
+	{ WCD937X_MBHC_TEST_CTL,				0x00 },
+	{ WCD937X_LDOH_MODE,					0x2b },
+	{ WCD937X_LDOH_BIAS,					0x68 },
+	{ WCD937X_LDOH_STB_LOADS,				0x00 },
+	{ WCD937X_LDOH_SLOWRAMP,				0x50 },
+	{ WCD937X_MICB1_TEST_CTL_1,				0x1a },
+	{ WCD937X_MICB1_TEST_CTL_2,				0x18 },
+	{ WCD937X_MICB1_TEST_CTL_3,				0xa4 },
+	{ WCD937X_MICB2_TEST_CTL_1,				0x1a },
+	{ WCD937X_MICB2_TEST_CTL_2,				0x18 },
+	{ WCD937X_MICB2_TEST_CTL_3,				0xa4 },
+	{ WCD937X_MICB3_TEST_CTL_1,				0x1a },
+	{ WCD937X_MICB3_TEST_CTL_2,				0x18 },
+	{ WCD937X_MICB3_TEST_CTL_3,				0xa4 },
+	{ WCD937X_TX_COM_ADC_VCM,				0x39 },
+	{ WCD937X_TX_COM_BIAS_ATEST,				0xc0 },
+	{ WCD937X_TX_COM_ADC_INT1_IB,				0x6f },
+	{ WCD937X_TX_COM_ADC_INT2_IB,				0x4f },
+	{ WCD937X_TX_COM_TXFE_DIV_CTL,				0x2e },
+	{ WCD937X_TX_COM_TXFE_DIV_START,			0x00 },
+	{ WCD937X_TX_COM_TXFE_DIV_STOP_9P6M,			0xc7 },
+	{ WCD937X_TX_COM_TXFE_DIV_STOP_12P288M,			0xff },
+	{ WCD937X_TX_1_2_TEST_EN,				0xcc },
+	{ WCD937X_TX_1_2_ADC_IB,				0x09 },
+	{ WCD937X_TX_1_2_ATEST_REFCTL,				0x0a },
+	{ WCD937X_TX_1_2_TEST_CTL,				0x38 },
+	{ WCD937X_TX_1_2_TEST_BLK_EN,				0xff },
+	{ WCD937X_TX_1_2_TXFE_CLKDIV,				0x00 },
+	{ WCD937X_TX_1_2_SAR2_ERR,				0x00 },
+	{ WCD937X_TX_1_2_SAR1_ERR,				0x00 },
+	{ WCD937X_TX_3_TEST_EN,					0xcc },
+	{ WCD937X_TX_3_ADC_IB,					0x09 },
+	{ WCD937X_TX_3_ATEST_REFCTL,				0x0a },
+	{ WCD937X_TX_3_TEST_CTL,				0x38 },
+	{ WCD937X_TX_3_TEST_BLK_EN,				0xff },
+	{ WCD937X_TX_3_TXFE_CLKDIV,				0x00 },
+	{ WCD937X_TX_3_SPARE_MONO,				0x00 },
+	{ WCD937X_TX_3_SAR1_ERR,				0x00 },
+	{ WCD937X_CLASSH_MODE_1,				0x40 },
+	{ WCD937X_CLASSH_MODE_2,				0x3a },
+	{ WCD937X_CLASSH_MODE_3,				0x00 },
+	{ WCD937X_CLASSH_CTRL_VCL_1,				0x70 },
+	{ WCD937X_CLASSH_CTRL_VCL_2,				0x82 },
+	{ WCD937X_CLASSH_CTRL_CCL_1,				0x31 },
+	{ WCD937X_CLASSH_CTRL_CCL_2,				0x80 },
+	{ WCD937X_CLASSH_CTRL_CCL_3,				0x80 },
+	{ WCD937X_CLASSH_CTRL_CCL_4,				0x51 },
+	{ WCD937X_CLASSH_CTRL_CCL_5,				0x00 },
+	{ WCD937X_CLASSH_BUCK_TMUX_A_D,				0x00 },
+	{ WCD937X_CLASSH_BUCK_SW_DRV_CNTL,			0x77 },
+	{ WCD937X_CLASSH_SPARE,					0x00 },
+	{ WCD937X_FLYBACK_EN,					0x4e },
+	{ WCD937X_FLYBACK_VNEG_CTRL_1,				0x0b },
+	{ WCD937X_FLYBACK_VNEG_CTRL_2,				0x45 },
+	{ WCD937X_FLYBACK_VNEG_CTRL_3,				0x74 },
+	{ WCD937X_FLYBACK_VNEG_CTRL_4,				0x7f },
+	{ WCD937X_FLYBACK_VNEG_CTRL_5,				0x83 },
+	{ WCD937X_FLYBACK_VNEG_CTRL_6,				0x98 },
+	{ WCD937X_FLYBACK_VNEG_CTRL_7,				0xa9 },
+	{ WCD937X_FLYBACK_VNEG_CTRL_8,				0x68 },
+	{ WCD937X_FLYBACK_VNEG_CTRL_9,				0x64 },
+	{ WCD937X_FLYBACK_VNEGDAC_CTRL_1,			0xed },
+	{ WCD937X_FLYBACK_VNEGDAC_CTRL_2,			0xf0 },
+	{ WCD937X_FLYBACK_VNEGDAC_CTRL_3,			0xa6 },
+	{ WCD937X_FLYBACK_CTRL_1,				0x65 },
+	{ WCD937X_FLYBACK_TEST_CTL,				0x00 },
+	{ WCD937X_RX_AUX_SW_CTL,				0x00 },
+	{ WCD937X_RX_PA_AUX_IN_CONN,				0x00 },
+	{ WCD937X_RX_TIMER_DIV,					0x32 },
+	{ WCD937X_RX_OCP_CTL,					0x1f },
+	{ WCD937X_RX_OCP_COUNT,					0x77 },
+	{ WCD937X_RX_BIAS_EAR_DAC,				0xa0 },
+	{ WCD937X_RX_BIAS_EAR_AMP,				0xaa },
+	{ WCD937X_RX_BIAS_HPH_LDO,				0xa9 },
+	{ WCD937X_RX_BIAS_HPH_PA,				0xaa },
+	{ WCD937X_RX_BIAS_HPH_RDACBUFF_CNP2,			0x8a },
+	{ WCD937X_RX_BIAS_HPH_RDAC_LDO,				0x88 },
+	{ WCD937X_RX_BIAS_HPH_CNP1,				0x82 },
+	{ WCD937X_RX_BIAS_HPH_LOWPOWER,				0x82 },
+	{ WCD937X_RX_BIAS_AUX_DAC,				0xa0 },
+	{ WCD937X_RX_BIAS_AUX_AMP,				0xaa },
+	{ WCD937X_RX_BIAS_VNEGDAC_BLEEDER,			0x50 },
+	{ WCD937X_RX_BIAS_MISC,					0x00 },
+	{ WCD937X_RX_BIAS_BUCK_RST,				0x08 },
+	{ WCD937X_RX_BIAS_BUCK_VREF_ERRAMP,			0x44 },
+	{ WCD937X_RX_BIAS_FLYB_ERRAMP,				0x40 },
+	{ WCD937X_RX_BIAS_FLYB_BUFF,				0xaa },
+	{ WCD937X_RX_BIAS_FLYB_MID_RST,				0x14 },
+	{ WCD937X_HPH_L_STATUS,					0x04 },
+	{ WCD937X_HPH_R_STATUS,					0x04 },
+	{ WCD937X_HPH_CNP_EN,					0x80 },
+	{ WCD937X_HPH_CNP_WG_CTL,				0x9a },
+	{ WCD937X_HPH_CNP_WG_TIME,				0x14 },
+	{ WCD937X_HPH_OCP_CTL,					0x28 },
+	{ WCD937X_HPH_AUTO_CHOP,				0x16 },
+	{ WCD937X_HPH_CHOP_CTL,					0x83 },
+	{ WCD937X_HPH_PA_CTL1,					0x46 },
+	{ WCD937X_HPH_PA_CTL2,					0x50 },
+	{ WCD937X_HPH_L_EN,					0x80 },
+	{ WCD937X_HPH_L_TEST,					0xe0 },
+	{ WCD937X_HPH_L_ATEST,					0x50 },
+	{ WCD937X_HPH_R_EN,					0x80 },
+	{ WCD937X_HPH_R_TEST,					0xe0 },
+	{ WCD937X_HPH_R_ATEST,					0x54 },
+	{ WCD937X_HPH_RDAC_CLK_CTL1,				0x99 },
+	{ WCD937X_HPH_RDAC_CLK_CTL2,				0x9b },
+	{ WCD937X_HPH_RDAC_LDO_CTL,				0x33 },
+	{ WCD937X_HPH_RDAC_CHOP_CLK_LP_CTL,			0x00 },
+	{ WCD937X_HPH_REFBUFF_UHQA_CTL,				0xa8 },
+	{ WCD937X_HPH_REFBUFF_LP_CTL,				0x0e },
+	{ WCD937X_HPH_L_DAC_CTL,				0x20 },
+	{ WCD937X_HPH_R_DAC_CTL,				0x20 },
+	{ WCD937X_HPH_SURGE_HPHLR_SURGE_COMP_SEL,		0x55 },
+	{ WCD937X_HPH_SURGE_HPHLR_SURGE_EN,			0x19 },
+	{ WCD937X_HPH_SURGE_HPHLR_SURGE_MISC1,			0xa0 },
+	{ WCD937X_HPH_SURGE_HPHLR_SURGE_STATUS,			0x00 },
+	{ WCD937X_EAR_EAR_EN_REG,				0x22 },
+	{ WCD937X_EAR_EAR_PA_CON,				0x44 },
+	{ WCD937X_EAR_EAR_SP_CON,				0xdb },
+	{ WCD937X_EAR_EAR_DAC_CON,				0x80 },
+	{ WCD937X_EAR_EAR_CNP_FSM_CON,				0xb2 },
+	{ WCD937X_EAR_TEST_CTL,					0x00 },
+	{ WCD937X_EAR_STATUS_REG_1,				0x00 },
+	{ WCD937X_EAR_STATUS_REG_2,				0x00 },
+	{ WCD937X_ANA_NEW_PAGE_REGISTER,			0x00 },
+	{ WCD937X_HPH_NEW_ANA_HPH2,				0x00 },
+	{ WCD937X_HPH_NEW_ANA_HPH3,				0x00 },
+	{ WCD937X_SLEEP_CTL,					0x16 },
+	{ WCD937X_SLEEP_WATCHDOG_CTL,				0x00 },
+	{ WCD937X_MBHC_NEW_ELECT_REM_CLAMP_CTL,			0x00 },
+	{ WCD937X_MBHC_NEW_CTL_1,				0x02 },
+	{ WCD937X_MBHC_NEW_CTL_2,				0x05 },
+	{ WCD937X_MBHC_NEW_PLUG_DETECT_CTL,			0xe9 },
+	{ WCD937X_MBHC_NEW_ZDET_ANA_CTL,			0x0f },
+	{ WCD937X_MBHC_NEW_ZDET_RAMP_CTL,			0x00 },
+	{ WCD937X_MBHC_NEW_FSM_STATUS,				0x00 },
+	{ WCD937X_MBHC_NEW_ADC_RESULT,				0x00 },
+	{ WCD937X_TX_NEW_TX_CH2_SEL,				0x00 },
+	{ WCD937X_AUX_AUXPA,					0x00 },
+	{ WCD937X_LDORXTX_MODE,					0x0c },
+	{ WCD937X_LDORXTX_CONFIG,				0x10 },
+	{ WCD937X_DIE_CRACK_DIE_CRK_DET_EN,			0x00 },
+	{ WCD937X_DIE_CRACK_DIE_CRK_DET_OUT,			0x00 },
+	{ WCD937X_HPH_NEW_INT_RDAC_GAIN_CTL,			0x40 },
+	{ WCD937X_HPH_NEW_INT_RDAC_HD2_CTL_L,			0x81 },
+	{ WCD937X_HPH_NEW_INT_RDAC_VREF_CTL,			0x10 },
+	{ WCD937X_HPH_NEW_INT_RDAC_OVERRIDE_CTL,		0x00 },
+	{ WCD937X_HPH_NEW_INT_RDAC_HD2_CTL_R,			0x81 },
+	{ WCD937X_HPH_NEW_INT_PA_MISC1,				0x22 },
+	{ WCD937X_HPH_NEW_INT_PA_MISC2,				0x00 },
+	{ WCD937X_HPH_NEW_INT_PA_RDAC_MISC,			0x00 },
+	{ WCD937X_HPH_NEW_INT_HPH_TIMER1,			0xfe },
+	{ WCD937X_HPH_NEW_INT_HPH_TIMER2,			0x02 },
+	{ WCD937X_HPH_NEW_INT_HPH_TIMER3,			0x4e },
+	{ WCD937X_HPH_NEW_INT_HPH_TIMER4,			0x54 },
+	{ WCD937X_HPH_NEW_INT_PA_RDAC_MISC2,			0x00 },
+	{ WCD937X_HPH_NEW_INT_PA_RDAC_MISC3,			0x00 },
+	{ WCD937X_RX_NEW_INT_HPH_RDAC_BIAS_LOHIFI,		0x62 },
+	{ WCD937X_RX_NEW_INT_HPH_RDAC_BIAS_ULP,			0x01 },
+	{ WCD937X_RX_NEW_INT_HPH_RDAC_LDO_LP,			0x11 },
+	{ WCD937X_MBHC_NEW_INT_MOISTURE_DET_DC_CTRL,		0x57 },
+	{ WCD937X_MBHC_NEW_INT_MOISTURE_DET_POLLING_CTRL,	0x01 },
+	{ WCD937X_MBHC_NEW_INT_MECH_DET_CURRENT,		0x00 },
+	{ WCD937X_MBHC_NEW_INT_SPARE_2,				0x00 },
+	{ WCD937X_EAR_INT_NEW_EAR_CHOPPER_CON,			0xa8 },
+	{ WCD937X_EAR_INT_NEW_CNP_VCM_CON1,			0x42 },
+	{ WCD937X_EAR_INT_NEW_CNP_VCM_CON2,			0x22 },
+	{ WCD937X_EAR_INT_NEW_EAR_DYNAMIC_BIAS,			0x00 },
+	{ WCD937X_AUX_INT_EN_REG,				0x00 },
+	{ WCD937X_AUX_INT_PA_CTRL,				0x06 },
+	{ WCD937X_AUX_INT_SP_CTRL,				0xd2 },
+	{ WCD937X_AUX_INT_DAC_CTRL,				0x80 },
+	{ WCD937X_AUX_INT_CLK_CTRL,				0x50 },
+	{ WCD937X_AUX_INT_TEST_CTRL,				0x00 },
+	{ WCD937X_AUX_INT_STATUS_REG,				0x00 },
+	{ WCD937X_AUX_INT_MISC,					0x00 },
+	{ WCD937X_LDORXTX_INT_BIAS,				0x6e },
+	{ WCD937X_LDORXTX_INT_STB_LOADS_DTEST,			0x50 },
+	{ WCD937X_LDORXTX_INT_TEST0,				0x1c },
+	{ WCD937X_LDORXTX_INT_STARTUP_TIMER,			0xff },
+	{ WCD937X_LDORXTX_INT_TEST1,				0x1f },
+	{ WCD937X_LDORXTX_INT_STATUS,				0x00 },
+	{ WCD937X_SLEEP_INT_WATCHDOG_CTL_1,			0x0a },
+	{ WCD937X_SLEEP_INT_WATCHDOG_CTL_2,			0x0a },
+	{ WCD937X_DIE_CRACK_INT_DIE_CRK_DET_INT1,		0x02 },
+	{ WCD937X_DIE_CRACK_INT_DIE_CRK_DET_INT2,		0x60 },
+	{ WCD937X_DIGITAL_PAGE_REGISTER,			0x00 },
+	{ WCD937X_DIGITAL_CHIP_ID0,				0x01 },
+	{ WCD937X_DIGITAL_CHIP_ID1,				0x00 },
+	{ WCD937X_DIGITAL_CHIP_ID2,				0x0a },
+	{ WCD937X_DIGITAL_CHIP_ID3,				0x01 },
+	{ WCD937X_DIGITAL_CDC_RST_CTL,				0x03 },
+	{ WCD937X_DIGITAL_TOP_CLK_CFG,				0x00 },
+	{ WCD937X_DIGITAL_CDC_ANA_CLK_CTL,			0x00 },
+	{ WCD937X_DIGITAL_CDC_DIG_CLK_CTL,			0x00 },
+	{ WCD937X_DIGITAL_SWR_RST_EN,				0x00 },
+	{ WCD937X_DIGITAL_CDC_PATH_MODE,			0x55 },
+	{ WCD937X_DIGITAL_CDC_RX_RST,				0x00 },
+	{ WCD937X_DIGITAL_CDC_RX0_CTL,				0xfc },
+	{ WCD937X_DIGITAL_CDC_RX1_CTL,				0xfc },
+	{ WCD937X_DIGITAL_CDC_RX2_CTL,				0xfc },
+	{ WCD937X_DIGITAL_DEM_BYPASS_DATA0,			0x55 },
+	{ WCD937X_DIGITAL_DEM_BYPASS_DATA1,			0x55 },
+	{ WCD937X_DIGITAL_DEM_BYPASS_DATA2,			0x55 },
+	{ WCD937X_DIGITAL_DEM_BYPASS_DATA3,			0x01 },
+	{ WCD937X_DIGITAL_CDC_COMP_CTL_0,			0x00 },
+	{ WCD937X_DIGITAL_CDC_RX_DELAY_CTL,			0x66 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_A1_0,			0x00 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_A1_1,			0x01 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_A2_0,			0x63 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_A2_1,			0x04 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_A3_0,			0xac },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_A3_1,			0x04 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_A4_0,			0x1a },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_A4_1,			0x03 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_A5_0,			0xbc },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_A5_1,			0x02 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_A6_0,			0xc7 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_A7_0,			0xf8 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_C_0,			0x47 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_C_1,			0x43 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_C_2,			0xb1 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_C_3,			0x17 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_R1,			0x4b },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_R2,			0x26 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_R3,			0x32 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_R4,			0x57 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_R5,			0x63 },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_R6,			0x7c },
+	{ WCD937X_DIGITAL_CDC_HPH_DSM_R7,			0x57 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_A1_0,			0x00 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_A1_1,			0x01 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_A2_0,			0x96 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_A2_1,			0x09 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_A3_0,			0xab },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_A3_1,			0x05 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_A4_0,			0x1c },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_A4_1,			0x02 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_A5_0,			0x17 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_A5_1,			0x02 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_A6_0,			0xaa },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_A7_0,			0xe3 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_C_0,			0x69 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_C_1,			0x54 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_C_2,			0x02 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_C_3,			0x15 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_R1,			0xa4 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_R2,			0xb5 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_R3,			0x86 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_R4,			0x85 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_R5,			0xaa },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_R6,			0xe2 },
+	{ WCD937X_DIGITAL_CDC_AUX_DSM_R7,			0x62 },
+	{ WCD937X_DIGITAL_CDC_HPH_GAIN_RX_0,			0x55 },
+	{ WCD937X_DIGITAL_CDC_HPH_GAIN_RX_1,			0xa9 },
+	{ WCD937X_DIGITAL_CDC_HPH_GAIN_DSD_0,			0x3d },
+	{ WCD937X_DIGITAL_CDC_HPH_GAIN_DSD_1,			0x2e },
+	{ WCD937X_DIGITAL_CDC_HPH_GAIN_DSD_2,			0x01 },
+	{ WCD937X_DIGITAL_CDC_AUX_GAIN_DSD_0,			0x00 },
+	{ WCD937X_DIGITAL_CDC_AUX_GAIN_DSD_1,			0xfc },
+	{ WCD937X_DIGITAL_CDC_AUX_GAIN_DSD_2,			0x01 },
+	{ WCD937X_DIGITAL_CDC_HPH_GAIN_CTL,			0x00 },
+	{ WCD937X_DIGITAL_CDC_AUX_GAIN_CTL,			0x00 },
+	{ WCD937X_DIGITAL_CDC_EAR_PATH_CTL,			0x00 },
+	{ WCD937X_DIGITAL_CDC_SWR_CLH,				0x00 },
+	{ WCD937X_DIGITAL_SWR_CLH_BYP,				0x00 },
+	{ WCD937X_DIGITAL_CDC_TX0_CTL,				0x68 },
+	{ WCD937X_DIGITAL_CDC_TX1_CTL,				0x68 },
+	{ WCD937X_DIGITAL_CDC_TX2_CTL,				0x68 },
+	{ WCD937X_DIGITAL_CDC_TX_RST,				0x00 },
+	{ WCD937X_DIGITAL_CDC_REQ_CTL,				0x01 },
+	{ WCD937X_DIGITAL_CDC_AMIC_CTL,				0x07 },
+	{ WCD937X_DIGITAL_CDC_DMIC_CTL,				0x00 },
+	{ WCD937X_DIGITAL_CDC_DMIC1_CTL,			0x01 },
+	{ WCD937X_DIGITAL_CDC_DMIC2_CTL,			0x01 },
+	{ WCD937X_DIGITAL_CDC_DMIC3_CTL,			0x01 },
+	{ WCD937X_DIGITAL_EFUSE_CTL,				0x2b },
+	{ WCD937X_DIGITAL_EFUSE_PRG_CTL,			0x00 },
+	{ WCD937X_DIGITAL_EFUSE_TEST_CTL_0,			0x00 },
+	{ WCD937X_DIGITAL_EFUSE_TEST_CTL_1,			0x00 },
+	{ WCD937X_DIGITAL_EFUSE_T_DATA_0,			0x00 },
+	{ WCD937X_DIGITAL_EFUSE_T_DATA_1,			0x00 },
+	{ WCD937X_DIGITAL_PDM_WD_CTL0,				0x00 },
+	{ WCD937X_DIGITAL_PDM_WD_CTL1,				0x00 },
+	{ WCD937X_DIGITAL_PDM_WD_CTL2,				0x00 },
+	{ WCD937X_DIGITAL_INTR_MODE,				0x00 },
+	{ WCD937X_DIGITAL_INTR_MASK_0,				0xff },
+	{ WCD937X_DIGITAL_INTR_MASK_1,				0xff },
+	{ WCD937X_DIGITAL_INTR_MASK_2,				0x0f },
+	{ WCD937X_DIGITAL_INTR_STATUS_0,			0x00 },
+	{ WCD937X_DIGITAL_INTR_STATUS_1,			0x00 },
+	{ WCD937X_DIGITAL_INTR_STATUS_2,			0x00 },
+	{ WCD937X_DIGITAL_INTR_CLEAR_0,				0x00 },
+	{ WCD937X_DIGITAL_INTR_CLEAR_1,				0x00 },
+	{ WCD937X_DIGITAL_INTR_CLEAR_2,				0x00 },
+	{ WCD937X_DIGITAL_INTR_LEVEL_0,				0x00 },
+	{ WCD937X_DIGITAL_INTR_LEVEL_1,				0x00 },
+	{ WCD937X_DIGITAL_INTR_LEVEL_2,				0x00 },
+	{ WCD937X_DIGITAL_INTR_SET_0,				0x00 },
+	{ WCD937X_DIGITAL_INTR_SET_1,				0x00 },
+	{ WCD937X_DIGITAL_INTR_SET_2,				0x00 },
+	{ WCD937X_DIGITAL_INTR_TEST_0,				0x00 },
+	{ WCD937X_DIGITAL_INTR_TEST_1,				0x00 },
+	{ WCD937X_DIGITAL_INTR_TEST_2,				0x00 },
+	{ WCD937X_DIGITAL_CDC_CONN_RX0_CTL,			0x00 },
+	{ WCD937X_DIGITAL_CDC_CONN_RX1_CTL,			0x00 },
+	{ WCD937X_DIGITAL_CDC_CONN_RX2_CTL,			0x00 },
+	{ WCD937X_DIGITAL_CDC_CONN_TX_CTL,			0x00 },
+	{ WCD937X_DIGITAL_LOOP_BACK_MODE,			0x00 },
+	{ WCD937X_DIGITAL_SWR_DAC_TEST,				0x00 },
+	{ WCD937X_DIGITAL_SWR_HM_TEST_RX_0,			0x40 },
+	{ WCD937X_DIGITAL_SWR_HM_TEST_TX_0,			0x40 },
+	{ WCD937X_DIGITAL_SWR_HM_TEST_RX_1,			0x00 },
+	{ WCD937X_DIGITAL_SWR_HM_TEST_TX_1,			0x00 },
+	{ WCD937X_DIGITAL_SWR_HM_TEST,				0x00 },
+	{ WCD937X_DIGITAL_PAD_CTL_PDM_RX0,			0xf1 },
+	{ WCD937X_DIGITAL_PAD_CTL_PDM_RX1,			0xf1 },
+	{ WCD937X_DIGITAL_PAD_CTL_PDM_TX0,			0xf1 },
+	{ WCD937X_DIGITAL_PAD_CTL_PDM_TX1,			0xf1 },
+	{ WCD937X_DIGITAL_PAD_INP_DIS_0,			0x00 },
+	{ WCD937X_DIGITAL_PAD_INP_DIS_1,			0x00 },
+	{ WCD937X_DIGITAL_DRIVE_STRENGTH_0,			0x00 },
+	{ WCD937X_DIGITAL_DRIVE_STRENGTH_1,			0x00 },
+	{ WCD937X_DIGITAL_DRIVE_STRENGTH_2,			0x00 },
+	{ WCD937X_DIGITAL_RX_DATA_EDGE_CTL,			0x1f },
+	{ WCD937X_DIGITAL_TX_DATA_EDGE_CTL,			0x10 },
+	{ WCD937X_DIGITAL_GPIO_MODE,				0x00 },
+	{ WCD937X_DIGITAL_PIN_CTL_OE,				0x00 },
+	{ WCD937X_DIGITAL_PIN_CTL_DATA_0,			0x00 },
+	{ WCD937X_DIGITAL_PIN_CTL_DATA_1,			0x00 },
+	{ WCD937X_DIGITAL_PIN_STATUS_0,				0x00 },
+	{ WCD937X_DIGITAL_PIN_STATUS_1,				0x00 },
+	{ WCD937X_DIGITAL_DIG_DEBUG_CTL,			0x00 },
+	{ WCD937X_DIGITAL_DIG_DEBUG_EN,				0x00 },
+	{ WCD937X_DIGITAL_ANA_CSR_DBG_ADD,			0x00 },
+	{ WCD937X_DIGITAL_ANA_CSR_DBG_CTL,			0x48 },
+	{ WCD937X_DIGITAL_SSP_DBG,				0x00 },
+	{ WCD937X_DIGITAL_MODE_STATUS_0,			0x00 },
+	{ WCD937X_DIGITAL_MODE_STATUS_1,			0x00 },
+	{ WCD937X_DIGITAL_SPARE_0,				0x00 },
+	{ WCD937X_DIGITAL_SPARE_1,				0x00 },
+	{ WCD937X_DIGITAL_SPARE_2,				0x00 },
+	{ WCD937X_DIGITAL_EFUSE_REG_0,				0x00 },
+	{ WCD937X_DIGITAL_EFUSE_REG_1,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_2,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_3,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_4,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_5,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_6,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_7,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_8,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_9,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_10,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_11,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_12,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_13,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_14,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_15,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_16,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_17,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_18,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_19,				0xff },
+	{ WCD937X_DIGITAL_EFUSE_REG_20,				0x0e },
+	{ WCD937X_DIGITAL_EFUSE_REG_21,				0x00 },
+	{ WCD937X_DIGITAL_EFUSE_REG_22,				0x00 },
+	{ WCD937X_DIGITAL_EFUSE_REG_23,				0xf8 },
+	{ WCD937X_DIGITAL_EFUSE_REG_24,				0x16 },
+	{ WCD937X_DIGITAL_EFUSE_REG_25,				0x00 },
+	{ WCD937X_DIGITAL_EFUSE_REG_26,				0x00 },
+	{ WCD937X_DIGITAL_EFUSE_REG_27,				0x00 },
+	{ WCD937X_DIGITAL_EFUSE_REG_28,				0x00 },
+	{ WCD937X_DIGITAL_EFUSE_REG_29,				0x00 },
+	{ WCD937X_DIGITAL_EFUSE_REG_30,				0x00 },
+	{ WCD937X_DIGITAL_EFUSE_REG_31,				0x00 },
+};
+
+static bool wcd937x_rdwr_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WCD937X_ANA_BIAS:
+	case WCD937X_ANA_RX_SUPPLIES:
+	case WCD937X_ANA_HPH:
+	case WCD937X_ANA_EAR:
+	case WCD937X_ANA_EAR_COMPANDER_CTL:
+	case WCD937X_ANA_TX_CH1:
+	case WCD937X_ANA_TX_CH2:
+	case WCD937X_ANA_TX_CH3:
+	case WCD937X_ANA_TX_CH3_HPF:
+	case WCD937X_ANA_MICB1_MICB2_DSP_EN_LOGIC:
+	case WCD937X_ANA_MICB3_DSP_EN_LOGIC:
+	case WCD937X_ANA_MBHC_MECH:
+	case WCD937X_ANA_MBHC_ELECT:
+	case WCD937X_ANA_MBHC_ZDET:
+	case WCD937X_ANA_MBHC_BTN0:
+	case WCD937X_ANA_MBHC_BTN1:
+	case WCD937X_ANA_MBHC_BTN2:
+	case WCD937X_ANA_MBHC_BTN3:
+	case WCD937X_ANA_MBHC_BTN4:
+	case WCD937X_ANA_MBHC_BTN5:
+	case WCD937X_ANA_MBHC_BTN6:
+	case WCD937X_ANA_MBHC_BTN7:
+	case WCD937X_ANA_MICB1:
+	case WCD937X_ANA_MICB2:
+	case WCD937X_ANA_MICB2_RAMP:
+	case WCD937X_ANA_MICB3:
+	case WCD937X_BIAS_CTL:
+	case WCD937X_BIAS_VBG_FINE_ADJ:
+	case WCD937X_LDOL_VDDCX_ADJUST:
+	case WCD937X_LDOL_DISABLE_LDOL:
+	case WCD937X_MBHC_CTL_CLK:
+	case WCD937X_MBHC_CTL_ANA:
+	case WCD937X_MBHC_CTL_SPARE_1:
+	case WCD937X_MBHC_CTL_SPARE_2:
+	case WCD937X_MBHC_CTL_BCS:
+	case WCD937X_MBHC_TEST_CTL:
+	case WCD937X_LDOH_MODE:
+	case WCD937X_LDOH_BIAS:
+	case WCD937X_LDOH_STB_LOADS:
+	case WCD937X_LDOH_SLOWRAMP:
+	case WCD937X_MICB1_TEST_CTL_1:
+	case WCD937X_MICB1_TEST_CTL_2:
+	case WCD937X_MICB1_TEST_CTL_3:
+	case WCD937X_MICB2_TEST_CTL_1:
+	case WCD937X_MICB2_TEST_CTL_2:
+	case WCD937X_MICB2_TEST_CTL_3:
+	case WCD937X_MICB3_TEST_CTL_1:
+	case WCD937X_MICB3_TEST_CTL_2:
+	case WCD937X_MICB3_TEST_CTL_3:
+	case WCD937X_TX_COM_ADC_VCM:
+	case WCD937X_TX_COM_BIAS_ATEST:
+	case WCD937X_TX_COM_ADC_INT1_IB:
+	case WCD937X_TX_COM_ADC_INT2_IB:
+	case WCD937X_TX_COM_TXFE_DIV_CTL:
+	case WCD937X_TX_COM_TXFE_DIV_START:
+	case WCD937X_TX_COM_TXFE_DIV_STOP_9P6M:
+	case WCD937X_TX_COM_TXFE_DIV_STOP_12P288M:
+	case WCD937X_TX_1_2_TEST_EN:
+	case WCD937X_TX_1_2_ADC_IB:
+	case WCD937X_TX_1_2_ATEST_REFCTL:
+	case WCD937X_TX_1_2_TEST_CTL:
+	case WCD937X_TX_1_2_TEST_BLK_EN:
+	case WCD937X_TX_1_2_TXFE_CLKDIV:
+	case WCD937X_TX_3_TEST_EN:
+	case WCD937X_TX_3_ADC_IB:
+	case WCD937X_TX_3_ATEST_REFCTL:
+	case WCD937X_TX_3_TEST_CTL:
+	case WCD937X_TX_3_TEST_BLK_EN:
+	case WCD937X_TX_3_TXFE_CLKDIV:
+	case WCD937X_CLASSH_MODE_1:
+	case WCD937X_CLASSH_MODE_2:
+	case WCD937X_CLASSH_MODE_3:
+	case WCD937X_CLASSH_CTRL_VCL_1:
+	case WCD937X_CLASSH_CTRL_VCL_2:
+	case WCD937X_CLASSH_CTRL_CCL_1:
+	case WCD937X_CLASSH_CTRL_CCL_2:
+	case WCD937X_CLASSH_CTRL_CCL_3:
+	case WCD937X_CLASSH_CTRL_CCL_4:
+	case WCD937X_CLASSH_CTRL_CCL_5:
+	case WCD937X_CLASSH_BUCK_TMUX_A_D:
+	case WCD937X_CLASSH_BUCK_SW_DRV_CNTL:
+	case WCD937X_CLASSH_SPARE:
+	case WCD937X_FLYBACK_EN:
+	case WCD937X_FLYBACK_VNEG_CTRL_1:
+	case WCD937X_FLYBACK_VNEG_CTRL_2:
+	case WCD937X_FLYBACK_VNEG_CTRL_3:
+	case WCD937X_FLYBACK_VNEG_CTRL_4:
+	case WCD937X_FLYBACK_VNEG_CTRL_5:
+	case WCD937X_FLYBACK_VNEG_CTRL_6:
+	case WCD937X_FLYBACK_VNEG_CTRL_7:
+	case WCD937X_FLYBACK_VNEG_CTRL_8:
+	case WCD937X_FLYBACK_VNEG_CTRL_9:
+	case WCD937X_FLYBACK_VNEGDAC_CTRL_1:
+	case WCD937X_FLYBACK_VNEGDAC_CTRL_2:
+	case WCD937X_FLYBACK_VNEGDAC_CTRL_3:
+	case WCD937X_FLYBACK_CTRL_1:
+	case WCD937X_FLYBACK_TEST_CTL:
+	case WCD937X_RX_AUX_SW_CTL:
+	case WCD937X_RX_PA_AUX_IN_CONN:
+	case WCD937X_RX_TIMER_DIV:
+	case WCD937X_RX_OCP_CTL:
+	case WCD937X_RX_OCP_COUNT:
+	case WCD937X_RX_BIAS_EAR_DAC:
+	case WCD937X_RX_BIAS_EAR_AMP:
+	case WCD937X_RX_BIAS_HPH_LDO:
+	case WCD937X_RX_BIAS_HPH_PA:
+	case WCD937X_RX_BIAS_HPH_RDACBUFF_CNP2:
+	case WCD937X_RX_BIAS_HPH_RDAC_LDO:
+	case WCD937X_RX_BIAS_HPH_CNP1:
+	case WCD937X_RX_BIAS_HPH_LOWPOWER:
+	case WCD937X_RX_BIAS_AUX_DAC:
+	case WCD937X_RX_BIAS_AUX_AMP:
+	case WCD937X_RX_BIAS_VNEGDAC_BLEEDER:
+	case WCD937X_RX_BIAS_MISC:
+	case WCD937X_RX_BIAS_BUCK_RST:
+	case WCD937X_RX_BIAS_BUCK_VREF_ERRAMP:
+	case WCD937X_RX_BIAS_FLYB_ERRAMP:
+	case WCD937X_RX_BIAS_FLYB_BUFF:
+	case WCD937X_RX_BIAS_FLYB_MID_RST:
+	case WCD937X_HPH_CNP_EN:
+	case WCD937X_HPH_CNP_WG_CTL:
+	case WCD937X_HPH_CNP_WG_TIME:
+	case WCD937X_HPH_OCP_CTL:
+	case WCD937X_HPH_AUTO_CHOP:
+	case WCD937X_HPH_CHOP_CTL:
+	case WCD937X_HPH_PA_CTL1:
+	case WCD937X_HPH_PA_CTL2:
+	case WCD937X_HPH_L_EN:
+	case WCD937X_HPH_L_TEST:
+	case WCD937X_HPH_L_ATEST:
+	case WCD937X_HPH_R_EN:
+	case WCD937X_HPH_R_TEST:
+	case WCD937X_HPH_R_ATEST:
+	case WCD937X_HPH_RDAC_CLK_CTL1:
+	case WCD937X_HPH_RDAC_CLK_CTL2:
+	case WCD937X_HPH_RDAC_LDO_CTL:
+	case WCD937X_HPH_RDAC_CHOP_CLK_LP_CTL:
+	case WCD937X_HPH_REFBUFF_UHQA_CTL:
+	case WCD937X_HPH_REFBUFF_LP_CTL:
+	case WCD937X_HPH_L_DAC_CTL:
+	case WCD937X_HPH_R_DAC_CTL:
+	case WCD937X_HPH_SURGE_HPHLR_SURGE_COMP_SEL:
+	case WCD937X_HPH_SURGE_HPHLR_SURGE_EN:
+	case WCD937X_HPH_SURGE_HPHLR_SURGE_MISC1:
+	case WCD937X_EAR_EAR_EN_REG:
+	case WCD937X_EAR_EAR_PA_CON:
+	case WCD937X_EAR_EAR_SP_CON:
+	case WCD937X_EAR_EAR_DAC_CON:
+	case WCD937X_EAR_EAR_CNP_FSM_CON:
+	case WCD937X_EAR_TEST_CTL:
+	case WCD937X_HPH_NEW_ANA_HPH2:
+	case WCD937X_HPH_NEW_ANA_HPH3:
+	case WCD937X_SLEEP_CTL:
+	case WCD937X_SLEEP_WATCHDOG_CTL:
+	case WCD937X_MBHC_NEW_ELECT_REM_CLAMP_CTL:
+	case WCD937X_MBHC_NEW_CTL_1:
+	case WCD937X_MBHC_NEW_CTL_2:
+	case WCD937X_MBHC_NEW_PLUG_DETECT_CTL:
+	case WCD937X_MBHC_NEW_ZDET_ANA_CTL:
+	case WCD937X_MBHC_NEW_ZDET_RAMP_CTL:
+	case WCD937X_TX_NEW_TX_CH2_SEL:
+	case WCD937X_AUX_AUXPA:
+	case WCD937X_LDORXTX_MODE:
+	case WCD937X_LDORXTX_CONFIG:
+	case WCD937X_DIE_CRACK_DIE_CRK_DET_EN:
+	case WCD937X_HPH_NEW_INT_RDAC_GAIN_CTL:
+	case WCD937X_HPH_NEW_INT_RDAC_HD2_CTL_L:
+	case WCD937X_HPH_NEW_INT_RDAC_VREF_CTL:
+	case WCD937X_HPH_NEW_INT_RDAC_OVERRIDE_CTL:
+	case WCD937X_HPH_NEW_INT_RDAC_HD2_CTL_R:
+	case WCD937X_HPH_NEW_INT_PA_MISC1:
+	case WCD937X_HPH_NEW_INT_PA_MISC2:
+	case WCD937X_HPH_NEW_INT_PA_RDAC_MISC:
+	case WCD937X_HPH_NEW_INT_HPH_TIMER1:
+	case WCD937X_HPH_NEW_INT_HPH_TIMER2:
+	case WCD937X_HPH_NEW_INT_HPH_TIMER3:
+	case WCD937X_HPH_NEW_INT_HPH_TIMER4:
+	case WCD937X_HPH_NEW_INT_PA_RDAC_MISC2:
+	case WCD937X_HPH_NEW_INT_PA_RDAC_MISC3:
+	case WCD937X_RX_NEW_INT_HPH_RDAC_BIAS_LOHIFI:
+	case WCD937X_RX_NEW_INT_HPH_RDAC_BIAS_ULP:
+	case WCD937X_RX_NEW_INT_HPH_RDAC_LDO_LP:
+	case WCD937X_MBHC_NEW_INT_MOISTURE_DET_DC_CTRL:
+	case WCD937X_MBHC_NEW_INT_MOISTURE_DET_POLLING_CTRL:
+	case WCD937X_MBHC_NEW_INT_MECH_DET_CURRENT:
+	case WCD937X_MBHC_NEW_INT_SPARE_2:
+	case WCD937X_EAR_INT_NEW_EAR_CHOPPER_CON:
+	case WCD937X_EAR_INT_NEW_CNP_VCM_CON1:
+	case WCD937X_EAR_INT_NEW_CNP_VCM_CON2:
+	case WCD937X_EAR_INT_NEW_EAR_DYNAMIC_BIAS:
+	case WCD937X_AUX_INT_EN_REG:
+	case WCD937X_AUX_INT_PA_CTRL:
+	case WCD937X_AUX_INT_SP_CTRL:
+	case WCD937X_AUX_INT_DAC_CTRL:
+	case WCD937X_AUX_INT_CLK_CTRL:
+	case WCD937X_AUX_INT_TEST_CTRL:
+	case WCD937X_AUX_INT_MISC:
+	case WCD937X_LDORXTX_INT_BIAS:
+	case WCD937X_LDORXTX_INT_STB_LOADS_DTEST:
+	case WCD937X_LDORXTX_INT_TEST0:
+	case WCD937X_LDORXTX_INT_STARTUP_TIMER:
+	case WCD937X_LDORXTX_INT_TEST1:
+	case WCD937X_SLEEP_INT_WATCHDOG_CTL_1:
+	case WCD937X_SLEEP_INT_WATCHDOG_CTL_2:
+	case WCD937X_DIE_CRACK_INT_DIE_CRK_DET_INT1:
+	case WCD937X_DIE_CRACK_INT_DIE_CRK_DET_INT2:
+	case WCD937X_DIGITAL_CDC_RST_CTL:
+	case WCD937X_DIGITAL_TOP_CLK_CFG:
+	case WCD937X_DIGITAL_CDC_ANA_CLK_CTL:
+	case WCD937X_DIGITAL_CDC_DIG_CLK_CTL:
+	case WCD937X_DIGITAL_SWR_RST_EN:
+	case WCD937X_DIGITAL_CDC_PATH_MODE:
+	case WCD937X_DIGITAL_CDC_RX_RST:
+	case WCD937X_DIGITAL_CDC_RX0_CTL:
+	case WCD937X_DIGITAL_CDC_RX1_CTL:
+	case WCD937X_DIGITAL_CDC_RX2_CTL:
+	case WCD937X_DIGITAL_DEM_BYPASS_DATA0:
+	case WCD937X_DIGITAL_DEM_BYPASS_DATA1:
+	case WCD937X_DIGITAL_DEM_BYPASS_DATA2:
+	case WCD937X_DIGITAL_DEM_BYPASS_DATA3:
+	case WCD937X_DIGITAL_CDC_COMP_CTL_0:
+	case WCD937X_DIGITAL_CDC_RX_DELAY_CTL:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_A1_0:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_A1_1:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_A2_0:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_A2_1:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_A3_0:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_A3_1:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_A4_0:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_A4_1:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_A5_0:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_A5_1:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_A6_0:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_A7_0:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_C_0:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_C_1:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_C_2:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_C_3:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_R1:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_R2:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_R3:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_R4:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_R5:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_R6:
+	case WCD937X_DIGITAL_CDC_HPH_DSM_R7:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_A1_0:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_A1_1:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_A2_0:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_A2_1:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_A3_0:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_A3_1:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_A4_0:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_A4_1:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_A5_0:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_A5_1:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_A6_0:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_A7_0:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_C_0:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_C_1:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_C_2:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_C_3:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_R1:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_R2:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_R3:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_R4:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_R5:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_R6:
+	case WCD937X_DIGITAL_CDC_AUX_DSM_R7:
+	case WCD937X_DIGITAL_CDC_HPH_GAIN_RX_0:
+	case WCD937X_DIGITAL_CDC_HPH_GAIN_RX_1:
+	case WCD937X_DIGITAL_CDC_HPH_GAIN_DSD_0:
+	case WCD937X_DIGITAL_CDC_HPH_GAIN_DSD_1:
+	case WCD937X_DIGITAL_CDC_HPH_GAIN_DSD_2:
+	case WCD937X_DIGITAL_CDC_AUX_GAIN_DSD_0:
+	case WCD937X_DIGITAL_CDC_AUX_GAIN_DSD_1:
+	case WCD937X_DIGITAL_CDC_AUX_GAIN_DSD_2:
+	case WCD937X_DIGITAL_CDC_HPH_GAIN_CTL:
+	case WCD937X_DIGITAL_CDC_AUX_GAIN_CTL:
+	case WCD937X_DIGITAL_CDC_EAR_PATH_CTL:
+	case WCD937X_DIGITAL_CDC_SWR_CLH:
+	case WCD937X_DIGITAL_SWR_CLH_BYP:
+	case WCD937X_DIGITAL_CDC_TX0_CTL:
+	case WCD937X_DIGITAL_CDC_TX1_CTL:
+	case WCD937X_DIGITAL_CDC_TX2_CTL:
+	case WCD937X_DIGITAL_CDC_TX_RST:
+	case WCD937X_DIGITAL_CDC_REQ_CTL:
+	case WCD937X_DIGITAL_CDC_AMIC_CTL:
+	case WCD937X_DIGITAL_CDC_DMIC_CTL:
+	case WCD937X_DIGITAL_CDC_DMIC1_CTL:
+	case WCD937X_DIGITAL_CDC_DMIC2_CTL:
+	case WCD937X_DIGITAL_CDC_DMIC3_CTL:
+	case WCD937X_DIGITAL_EFUSE_CTL:
+	case WCD937X_DIGITAL_EFUSE_PRG_CTL:
+	case WCD937X_DIGITAL_EFUSE_TEST_CTL_0:
+	case WCD937X_DIGITAL_EFUSE_TEST_CTL_1:
+	case WCD937X_DIGITAL_PDM_WD_CTL0:
+	case WCD937X_DIGITAL_PDM_WD_CTL1:
+	case WCD937X_DIGITAL_PDM_WD_CTL2:
+	case WCD937X_DIGITAL_INTR_MODE:
+	case WCD937X_DIGITAL_INTR_MASK_0:
+	case WCD937X_DIGITAL_INTR_MASK_1:
+	case WCD937X_DIGITAL_INTR_MASK_2:
+	case WCD937X_DIGITAL_INTR_CLEAR_0:
+	case WCD937X_DIGITAL_INTR_CLEAR_1:
+	case WCD937X_DIGITAL_INTR_CLEAR_2:
+	case WCD937X_DIGITAL_INTR_LEVEL_0:
+	case WCD937X_DIGITAL_INTR_LEVEL_1:
+	case WCD937X_DIGITAL_INTR_LEVEL_2:
+	case WCD937X_DIGITAL_INTR_SET_0:
+	case WCD937X_DIGITAL_INTR_SET_1:
+	case WCD937X_DIGITAL_INTR_SET_2:
+	case WCD937X_DIGITAL_INTR_TEST_0:
+	case WCD937X_DIGITAL_INTR_TEST_1:
+	case WCD937X_DIGITAL_INTR_TEST_2:
+	case WCD937X_DIGITAL_CDC_CONN_RX0_CTL:
+	case WCD937X_DIGITAL_CDC_CONN_RX1_CTL:
+	case WCD937X_DIGITAL_CDC_CONN_RX2_CTL:
+	case WCD937X_DIGITAL_CDC_CONN_TX_CTL:
+	case WCD937X_DIGITAL_LOOP_BACK_MODE:
+	case WCD937X_DIGITAL_SWR_DAC_TEST:
+	case WCD937X_DIGITAL_SWR_HM_TEST_RX_0:
+	case WCD937X_DIGITAL_SWR_HM_TEST_TX_0:
+	case WCD937X_DIGITAL_SWR_HM_TEST_RX_1:
+	case WCD937X_DIGITAL_SWR_HM_TEST_TX_1:
+	case WCD937X_DIGITAL_SWR_HM_TEST:
+	case WCD937X_DIGITAL_PAD_CTL_PDM_RX0:
+	case WCD937X_DIGITAL_PAD_CTL_PDM_RX1:
+	case WCD937X_DIGITAL_PAD_CTL_PDM_TX0:
+	case WCD937X_DIGITAL_PAD_CTL_PDM_TX1:
+	case WCD937X_DIGITAL_PAD_INP_DIS_0:
+	case WCD937X_DIGITAL_PAD_INP_DIS_1:
+	case WCD937X_DIGITAL_DRIVE_STRENGTH_0:
+	case WCD937X_DIGITAL_DRIVE_STRENGTH_1:
+	case WCD937X_DIGITAL_DRIVE_STRENGTH_2:
+	case WCD937X_DIGITAL_RX_DATA_EDGE_CTL:
+	case WCD937X_DIGITAL_TX_DATA_EDGE_CTL:
+	case WCD937X_DIGITAL_GPIO_MODE:
+	case WCD937X_DIGITAL_PIN_CTL_OE:
+	case WCD937X_DIGITAL_PIN_CTL_DATA_0:
+	case WCD937X_DIGITAL_PIN_CTL_DATA_1:
+	case WCD937X_DIGITAL_PIN_STATUS_0:
+	case WCD937X_DIGITAL_PIN_STATUS_1:
+	case WCD937X_DIGITAL_DIG_DEBUG_CTL:
+	case WCD937X_DIGITAL_DIG_DEBUG_EN:
+	case WCD937X_DIGITAL_ANA_CSR_DBG_ADD:
+	case WCD937X_DIGITAL_ANA_CSR_DBG_CTL:
+	case WCD937X_DIGITAL_SSP_DBG:
+	case WCD937X_DIGITAL_MODE_STATUS_0:
+	case WCD937X_DIGITAL_MODE_STATUS_1:
+	case WCD937X_DIGITAL_SPARE_0:
+	case WCD937X_DIGITAL_SPARE_1:
+	case WCD937X_DIGITAL_SPARE_2:
+		return true;
+	}
+
+	return false;
+}
+
+static bool wcd937x_readonly_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WCD937X_ANA_MBHC_RESULT_1:
+	case WCD937X_ANA_MBHC_RESULT_2:
+	case WCD937X_ANA_MBHC_RESULT_3:
+	case WCD937X_MBHC_MOISTURE_DET_FSM_STATUS:
+	case WCD937X_TX_1_2_SAR2_ERR:
+	case WCD937X_TX_1_2_SAR1_ERR:
+	case WCD937X_TX_3_SPARE_MONO:
+	case WCD937X_TX_3_SAR1_ERR:
+	case WCD937X_HPH_L_STATUS:
+	case WCD937X_HPH_R_STATUS:
+	case WCD937X_HPH_SURGE_HPHLR_SURGE_STATUS:
+	case WCD937X_EAR_STATUS_REG_1:
+	case WCD937X_EAR_STATUS_REG_2:
+	case WCD937X_MBHC_NEW_FSM_STATUS:
+	case WCD937X_MBHC_NEW_ADC_RESULT:
+	case WCD937X_DIE_CRACK_DIE_CRK_DET_OUT:
+	case WCD937X_AUX_INT_STATUS_REG:
+	case WCD937X_LDORXTX_INT_STATUS:
+	case WCD937X_DIGITAL_CHIP_ID0:
+	case WCD937X_DIGITAL_CHIP_ID1:
+	case WCD937X_DIGITAL_CHIP_ID2:
+	case WCD937X_DIGITAL_CHIP_ID3:
+	case WCD937X_DIGITAL_EFUSE_T_DATA_0:
+	case WCD937X_DIGITAL_EFUSE_T_DATA_1:
+	case WCD937X_DIGITAL_INTR_STATUS_0:
+	case WCD937X_DIGITAL_INTR_STATUS_1:
+	case WCD937X_DIGITAL_INTR_STATUS_2:
+	case WCD937X_DIGITAL_EFUSE_REG_0:
+	case WCD937X_DIGITAL_EFUSE_REG_1:
+	case WCD937X_DIGITAL_EFUSE_REG_2:
+	case WCD937X_DIGITAL_EFUSE_REG_3:
+	case WCD937X_DIGITAL_EFUSE_REG_4:
+	case WCD937X_DIGITAL_EFUSE_REG_5:
+	case WCD937X_DIGITAL_EFUSE_REG_6:
+	case WCD937X_DIGITAL_EFUSE_REG_7:
+	case WCD937X_DIGITAL_EFUSE_REG_8:
+	case WCD937X_DIGITAL_EFUSE_REG_9:
+	case WCD937X_DIGITAL_EFUSE_REG_10:
+	case WCD937X_DIGITAL_EFUSE_REG_11:
+	case WCD937X_DIGITAL_EFUSE_REG_12:
+	case WCD937X_DIGITAL_EFUSE_REG_13:
+	case WCD937X_DIGITAL_EFUSE_REG_14:
+	case WCD937X_DIGITAL_EFUSE_REG_15:
+	case WCD937X_DIGITAL_EFUSE_REG_16:
+	case WCD937X_DIGITAL_EFUSE_REG_17:
+	case WCD937X_DIGITAL_EFUSE_REG_18:
+	case WCD937X_DIGITAL_EFUSE_REG_19:
+	case WCD937X_DIGITAL_EFUSE_REG_20:
+	case WCD937X_DIGITAL_EFUSE_REG_21:
+	case WCD937X_DIGITAL_EFUSE_REG_22:
+	case WCD937X_DIGITAL_EFUSE_REG_23:
+	case WCD937X_DIGITAL_EFUSE_REG_24:
+	case WCD937X_DIGITAL_EFUSE_REG_25:
+	case WCD937X_DIGITAL_EFUSE_REG_26:
+	case WCD937X_DIGITAL_EFUSE_REG_27:
+	case WCD937X_DIGITAL_EFUSE_REG_28:
+	case WCD937X_DIGITAL_EFUSE_REG_29:
+	case WCD937X_DIGITAL_EFUSE_REG_30:
+	case WCD937X_DIGITAL_EFUSE_REG_31:
+		return true;
+	}
+
+	return false;
+}
+
+static bool wcd937x_readable_register(struct device *dev, unsigned int reg)
+{
+	return wcd937x_readonly_register(dev, reg) || wcd937x_rdwr_register(dev, reg);
+}
+
+static const struct regmap_config wcd937x_regmap_config = {
+	.name = "wcd937x_csr",
+	.reg_bits = 32,
+	.val_bits = 8,
+	.cache_type = REGCACHE_MAPLE,
+	.reg_defaults = wcd937x_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wcd937x_defaults),
+	.max_register = WCD937X_MAX_REGISTER,
+	.readable_reg = wcd937x_readable_register,
+	.writeable_reg = wcd937x_rdwr_register,
+	.volatile_reg = wcd937x_readonly_register,
+};
+
+static const struct sdw_slave_ops wcd937x_slave_ops = {
+	.update_status = wcd937x_update_status,
+	.interrupt_callback = wcd937x_interrupt_callback,
+};
+
+static int wcd937x_sdw_component_bind(struct device *dev,
+				      struct device *master, void *data)
+{
+	return 0;
+}
+
+static void wcd937x_sdw_component_unbind(struct device *dev,
+					 struct device *master, void *data)
+{
+}
+
+static const struct component_ops wcd937x_sdw_component_ops = {
+	.bind   = wcd937x_sdw_component_bind,
+	.unbind = wcd937x_sdw_component_unbind,
+};
+
+static int wcd937x_probe(struct sdw_slave *pdev,
+			 const struct sdw_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct wcd937x_sdw_priv *wcd;
+	int ret;
+
+	wcd = devm_kzalloc(dev, sizeof(*wcd), GFP_KERNEL);
+	if (!wcd)
+		return -ENOMEM;
+
+	/* Port map index starts at 0, however the data port for this codec start at index 1 */
+	if (of_property_read_bool(dev->of_node, "qcom,tx-port-mapping")) {
+		wcd->is_tx = true;
+		ret = of_property_read_u32_array(dev->of_node, "qcom,tx-port-mapping",
+						 &pdev->m_port_map[1],
+						 WCD937X_MAX_TX_SWR_PORTS);
+	} else {
+		ret = of_property_read_u32_array(dev->of_node, "qcom,rx-port-mapping",
+						 &pdev->m_port_map[1],
+						 WCD937X_MAX_SWR_PORTS);
+	}
+	if (ret < 0)
+		dev_info(dev, "Error getting static port mapping for %s (%d)\n",
+			 wcd->is_tx ? "TX" : "RX", ret);
+
+	wcd->sdev = pdev;
+	dev_set_drvdata(dev, wcd);
+
+	pdev->prop.scp_int1_mask = SDW_SCP_INT1_IMPL_DEF |
+				   SDW_SCP_INT1_BUS_CLASH |
+				   SDW_SCP_INT1_PARITY;
+	pdev->prop.lane_control_support = true;
+	pdev->prop.simple_clk_stop_capable = true;
+	if (wcd->is_tx) {
+		pdev->prop.source_ports = GENMASK(WCD937X_MAX_TX_SWR_PORTS, 0);
+		pdev->prop.src_dpn_prop = wcd937x_dpn_prop;
+		wcd->ch_info = &wcd937x_sdw_tx_ch_info[0];
+		pdev->prop.wake_capable = true;
+
+		wcd->regmap = devm_regmap_init_sdw(pdev, &wcd937x_regmap_config);
+		if (IS_ERR(wcd->regmap))
+			return dev_err_probe(dev, PTR_ERR(wcd->regmap),
+					     "Regmap init failed\n");
+
+		/* Start in cache-only until device is enumerated */
+		regcache_cache_only(wcd->regmap, true);
+	} else {
+		pdev->prop.sink_ports = GENMASK(WCD937X_MAX_SWR_PORTS, 0);
+		pdev->prop.sink_dpn_prop = wcd937x_dpn_prop;
+		wcd->ch_info = &wcd937x_sdw_rx_ch_info[0];
+	}
+
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return component_add(dev, &wcd937x_sdw_component_ops);
+}
+
+static const struct sdw_device_id wcd937x_slave_id[] = {
+	SDW_SLAVE_ENTRY(0x0217, 0x10a, 0), /* WCD9370 */
+	{ },
+};
+MODULE_DEVICE_TABLE(sdw, wcd937x_slave_id);
+
+static int __maybe_unused wcd937x_sdw_runtime_suspend(struct device *dev)
+{
+	struct wcd937x_sdw_priv *wcd = dev_get_drvdata(dev);
+
+	if (wcd->regmap) {
+		regcache_cache_only(wcd->regmap, true);
+		regcache_mark_dirty(wcd->regmap);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused wcd937x_sdw_runtime_resume(struct device *dev)
+{
+	struct wcd937x_sdw_priv *wcd = dev_get_drvdata(dev);
+
+	if (wcd->regmap) {
+		regcache_cache_only(wcd->regmap, false);
+		regcache_sync(wcd->regmap);
+	}
+
+	pm_runtime_mark_last_busy(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops wcd937x_sdw_pm_ops = {
+	SET_RUNTIME_PM_OPS(wcd937x_sdw_runtime_suspend, wcd937x_sdw_runtime_resume, NULL)
+};
+
+static struct sdw_driver wcd937x_codec_driver = {
+	.probe = wcd937x_probe,
+	.ops = &wcd937x_slave_ops,
+	.id_table = wcd937x_slave_id,
+	.driver = {
+		.name = "wcd937x-codec",
+		.pm = &wcd937x_sdw_pm_ops,
+	}
+};
+module_sdw_driver(wcd937x_codec_driver);
+
+MODULE_DESCRIPTION("WCD937X SDW codec driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index d29cb56630c7..b2d5d29303b6 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -1359,7 +1359,40 @@ static bool wcd937x_swap_gnd_mic(struct snd_soc_component *component, bool activ
 	return true;
 }
 
+static int wcd937x_codec_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params,
+				   struct snd_soc_dai *dai)
+{
+	struct wcd937x_priv *wcd937x = dev_get_drvdata(dai->dev);
+	struct wcd937x_sdw_priv *wcd = wcd937x->sdw_priv[dai->id];
+
+	return wcd937x_sdw_hw_params(wcd, substream, params, dai);
+}
+
+static int wcd937x_codec_free(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct wcd937x_priv *wcd937x = dev_get_drvdata(dai->dev);
+	struct wcd937x_sdw_priv *wcd = wcd937x->sdw_priv[dai->id];
+
+	return sdw_stream_remove_slave(wcd->sdev, wcd->sruntime);
+}
+
+static int wcd937x_codec_set_sdw_stream(struct snd_soc_dai *dai,
+					void *stream, int direction)
+{
+	struct wcd937x_priv *wcd937x = dev_get_drvdata(dai->dev);
+	struct wcd937x_sdw_priv *wcd = wcd937x->sdw_priv[dai->id];
+
+	wcd->sruntime = stream;
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops wcd937x_sdw_dai_ops = {
+	.hw_params = wcd937x_codec_hw_params,
+	.hw_free = wcd937x_codec_free,
+	.set_stream = wcd937x_codec_set_sdw_stream,
 };
 
 static struct snd_soc_dai_driver wcd937x_dais[] = {
@@ -1405,12 +1438,66 @@ static int wcd937x_bind(struct device *dev)
 		return ret;
 	}
 
+	wcd937x->rxdev = wcd937x_sdw_device_get(wcd937x->rxnode);
+	if (!wcd937x->rxdev) {
+		dev_err(dev, "could not find slave with matching of node\n");
+		return -EINVAL;
+	}
+
+	wcd937x->sdw_priv[AIF1_PB] = dev_get_drvdata(wcd937x->rxdev);
+	wcd937x->sdw_priv[AIF1_PB]->wcd937x = wcd937x;
+
+	wcd937x->txdev = wcd937x_sdw_device_get(wcd937x->txnode);
+	if (!wcd937x->txdev) {
+		dev_err(dev, "could not find txslave with matching of node\n");
+		return -EINVAL;
+	}
+
+	wcd937x->sdw_priv[AIF1_CAP] = dev_get_drvdata(wcd937x->txdev);
+	wcd937x->sdw_priv[AIF1_CAP]->wcd937x = wcd937x;
+	wcd937x->tx_sdw_dev = dev_to_sdw_dev(wcd937x->txdev);
+	if (!wcd937x->tx_sdw_dev) {
+		dev_err(dev, "could not get txslave with matching of dev\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * As TX is the main CSR reg interface, which should not be suspended first.
+	 * expicilty add the dependency link
+	 */
+	if (!device_link_add(wcd937x->rxdev, wcd937x->txdev,
+			     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME)) {
+		dev_err(dev, "Could not devlink TX and RX\n");
+		return -EINVAL;
+	}
+
+	if (!device_link_add(dev, wcd937x->txdev,
+			     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME)) {
+		dev_err(dev, "Could not devlink WCD and TX\n");
+		return -EINVAL;
+	}
+
+	if (!device_link_add(dev, wcd937x->rxdev,
+			     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME)) {
+		dev_err(dev, "Could not devlink WCD and RX\n");
+		return -EINVAL;
+	}
+
+	wcd937x->regmap = dev_get_regmap(&wcd937x->tx_sdw_dev->dev, NULL);
+	if (!wcd937x->regmap) {
+		dev_err(dev, "could not get TX device regmap\n");
+		return -EINVAL;
+	}
+
 	ret = wcd937x_irq_init(wcd937x, dev);
 	if (ret) {
 		dev_err(dev, "IRQ init failed: %d\n", ret);
 		return ret;
 	}
 
+	wcd937x->sdw_priv[AIF1_PB]->slave_irq = wcd937x->virq;
+	wcd937x->sdw_priv[AIF1_CAP]->slave_irq = wcd937x->virq;
+
 	ret = wcd937x_set_micbias_data(wcd937x);
 	if (ret < 0) {
 		dev_err(dev, "Bad micbias pdata\n");
@@ -1429,6 +1516,9 @@ static void wcd937x_unbind(struct device *dev)
 {
 	struct wcd937x_priv *wcd937x = dev_get_drvdata(dev);
 
+	device_link_remove(dev, wcd937x->txdev);
+	device_link_remove(dev, wcd937x->rxdev);
+	device_link_remove(wcd937x->rxdev, wcd937x->txdev);
 	snd_soc_unregister_component(dev);
 	component_unbind_all(dev, wcd937x);
 	mutex_destroy(&wcd937x->micb_lock);
diff --git a/sound/soc/codecs/wcd937x.h b/sound/soc/codecs/wcd937x.h
index 9cd6441c82fd..22da254c3dcc 100644
--- a/sound/soc/codecs/wcd937x.h
+++ b/sound/soc/codecs/wcd937x.h
@@ -532,6 +532,44 @@ struct wcd937x_sdw_priv {
 	struct regmap *regmap;
 };
 
+#if IS_ENABLED(CONFIG_SND_SOC_WCD937X_SDW)
+int wcd937x_sdw_free(struct wcd937x_sdw_priv *wcd,
+		     struct snd_pcm_substream *substream,
+		     struct snd_soc_dai *dai);
+int wcd937x_sdw_set_sdw_stream(struct wcd937x_sdw_priv *wcd,
+			       struct snd_soc_dai *dai,
+			       void *stream, int direction);
+int wcd937x_sdw_hw_params(struct wcd937x_sdw_priv *wcd,
+			  struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params,
+			  struct snd_soc_dai *dai);
+
+struct device *wcd937x_sdw_device_get(struct device_node *np);
+
+#else
+int wcd937x_sdw_free(struct wcd937x_sdw_priv *wcd,
+		     struct snd_pcm_substream *substream,
+		     struct snd_soc_dai *dai)
+{
+	return -EOPNOTSUPP;
+}
+
+int wcd937x_sdw_set_sdw_stream(struct wcd937x_sdw_priv *wcd,
+			       struct snd_soc_dai *dai,
+			       void *stream, int direction)
+{
+	return -EOPNOTSUPP;
+}
+
+int wcd937x_sdw_hw_params(struct wcd937x_sdw_priv *wcd,
+			  struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params,
+			  struct snd_soc_dai *dai)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 enum {
 	WCD_RX1,
 	WCD_RX2,
-- 
2.25.1


