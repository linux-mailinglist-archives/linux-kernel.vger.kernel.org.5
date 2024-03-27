Return-Path: <linux-kernel+bounces-120758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEF088DC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35131F2B579
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA3882D8C;
	Wed, 27 Mar 2024 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YA8pe27b"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193D81AC5;
	Wed, 27 Mar 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711539234; cv=none; b=ApjDXO0qn8jecZE+oYxKHAkwVmBld5QBoEDE3Hb6eNxVd2HK4zeVrQo7ISDA0dEzidcqjagMrisNaaetuhsTM7iOpaYf+/TFQTVt2Relr/r3m/z/x64cbiUP5LYNmjxM0N0OxlJ/gUNi8qVWwyw6oipXrKuTfa8bPfmSOWJaImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711539234; c=relaxed/simple;
	bh=ZmZY4klLx60T3u+pxYJnT+s1JREgAnxFC27meQibGHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JX3hGBPNm6hSWLyfgJhMwiyPK8oEG8OVhYK0lMqMTAwQsliEmDVzYI3dR6FeDL0vmxovINvDWxkbF/EVIvQ707CfpUuted4c/yQoxrLlM53oqrHDASPkscQekUEOHvBGCVUMMLEB/0gYX9ovhSjZOKxVTlHMZtbGEgq7HVzYSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YA8pe27b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RAZM3E023786;
	Wed, 27 Mar 2024 11:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=snMIH5GFrI8kPEs9bEqq+/1eqkN3sd/QEbs6jLOH8UM=; b=YA
	8pe27bBy/A0E3nofalczo9lW+2+2S6ZxOeNx6C+3PxJ4zQK8sglAZJwxsfIauj/6
	Nvny/QjrImQN2BcemXkpSZUZv5bI9lnNheKIrgj2Ln2IEBbDJLv/FvIEM65+O+ev
	TzcDX8NzGwlp2yaPcdXDta9fHKG3Ch3GgjiMeHhLYLmPscelqoE1dAHv+FDAp6qB
	qpPPj6pF6fqAs3Y8hKSmmhcvA9tq6aOUvZVmWiE1JzQ4IsWH47J8wJLQl5EYwodr
	eCGfQvL9qlydHxNzlhEj0kN7hJeBjRe6F/QuXaDa6QCirrVcGmVj7TWcsmEitWuu
	YQNbq9yvr55yuvOEJ90g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4hu2r4e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 11:33:34 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42RBXXLw000457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 11:33:33 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 27 Mar 2024 04:33:29 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <broonie@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <lgirdwood@gmail.com>, <tiwai@suse.com>, <quic_rohkumar@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-sound@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v1 2/2] ASoC: qcom: qcm6490: Add machine driver for qcm6490
Date: Wed, 27 Mar 2024 17:02:28 +0530
Message-ID: <20240327113228.1706975-3-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327113228.1706975-1-quic_mohs@quicinc.com>
References: <20240327113228.1706975-1-quic_mohs@quicinc.com>
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
X-Proofpoint-ORIG-GUID: iKC408_5rAsw8AZoUPNKKH92s9V9FzS3
X-Proofpoint-GUID: iKC408_5rAsw8AZoUPNKKH92s9V9FzS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270078

Add machine driver for qcm6490 SoC.

This initial supports which includes WSA883x Speakers with onboard DMIC
connected to internal LPASS codec via VA macros respectively and also
WCD937x based headset.

Add compatible for sound card on Qualcomm qcs6490 boards.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 sound/soc/qcom/Kconfig   |  13 +++
 sound/soc/qcom/Makefile  |   2 +
 sound/soc/qcom/qcm6490.c | 173 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 sound/soc/qcom/qcm6490.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 762491d6f2f2..0bc536766872 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -151,6 +151,19 @@ config SND_SOC_MSM8996
 	  APQ8096 SoC-based systems.
 	  Say Y if you want to use audio device on this SoCs
 
+config SND_SOC_QCM6490
+	tristate "SoC Machine driver for QCM6490 boards"
+	depends on QCOM_APR && SOUNDWIRE
+	depends on COMMON_CLK
+	select SND_SOC_QDSP6
+	select SND_SOC_QCOM_COMMON
+	select SND_SOC_QCOM_SDW
+	help
+	  Add support for audio on Qualcomm Technologies Inc.
+	  QCM6490 SoC-based systems.
+	  To compile this driver say Y or M if you want to
+	  use audio device on this SoCs.
+
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
 	depends on QCOM_APR && I2C && SOUNDWIRE
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index 34f3fcb8ee9a..feb2c164be69 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_SND_SOC_LPASS_SC7280) += snd-soc-lpass-sc7280.o
 snd-soc-storm-objs := storm.o
 snd-soc-apq8016-sbc-objs := apq8016_sbc.o
 snd-soc-apq8096-objs := apq8096.o
+snd-soc-qcm6490-objs := qcm6490.o
 snd-soc-sc7180-objs := sc7180.o
 snd-soc-sc7280-objs := sc7280.o
 snd-soc-sdm845-objs := sdm845.o
@@ -34,6 +35,7 @@ snd-soc-x1e80100-objs := x1e80100.o
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
 obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
+obj-$(CONFIG_SND_SOC_QCM6490) += snd-soc-qcm6490.o
 obj-$(CONFIG_SND_SOC_SC7180) += snd-soc-sc7180.o
 obj-$(CONFIG_SND_SOC_SC7280) += snd-soc-sc7280.o
 obj-$(CONFIG_SND_SOC_SC8280XP) += snd-soc-sc8280xp.o
diff --git a/sound/soc/qcom/qcm6490.c b/sound/soc/qcom/qcm6490.c
new file mode 100644
index 000000000000..5b0dc95963f5
--- /dev/null
+++ b/sound/soc/qcom/qcm6490.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <linux/soundwire/sdw.h>
+#include <sound/jack.h>
+#include <sound/pcm_params.h>
+#include "lpass.h"
+#include "qdsp6/q6afe.h"
+#include "common.h"
+#include "sdw.h"
+
+struct qcm6490_snd_data {
+	bool stream_prepared[AFE_PORT_MAX];
+	struct snd_soc_card *card;
+	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
+	struct snd_soc_jack jack;
+	bool jack_setup;
+};
+
+static int qcm6490_snd_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct qcm6490_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+
+	switch (cpu_dai->id) {
+	case TX_CODEC_DMA_TX_3:
+	case LPASS_CDC_DMA_TX3:
+	case RX_CODEC_DMA_RX_0:
+		return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
+	case VA_CODEC_DMA_TX_0:
+	case WSA_CODEC_DMA_RX_0:
+		return 0;
+	default:
+		dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
+	}
+
+	return -EINVAL;
+}
+
+static int qcm6490_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct snd_interval *rate = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	rate->min = 48000;
+	rate->max = 48000;
+	channels->min = 2;
+	channels->max = 2;
+	switch (cpu_dai->id) {
+	case TX_CODEC_DMA_TX_0:
+	case TX_CODEC_DMA_TX_1:
+	case TX_CODEC_DMA_TX_2:
+	case TX_CODEC_DMA_TX_3:
+		channels->min = 1;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int qcm6490_snd_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct qcm6490_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
+
+	return qcom_snd_sdw_hw_params(substream, params, &pdata->sruntime[cpu_dai->id]);
+}
+
+static int qcm6490_snd_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct qcm6490_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+
+	return qcom_snd_sdw_prepare(substream, sruntime,
+				    &data->stream_prepared[cpu_dai->id]);
+}
+
+static int qcm6490_snd_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct qcm6490_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+
+	return qcom_snd_sdw_hw_free(substream, sruntime,
+				    &data->stream_prepared[cpu_dai->id]);
+}
+
+static const struct snd_soc_ops qcm6490_be_ops = {
+	.hw_params = qcm6490_snd_hw_params,
+	.hw_free = qcm6490_snd_hw_free,
+	.prepare = qcm6490_snd_prepare,
+};
+
+static void qcm6490_add_be_ops(struct snd_soc_card *card)
+{
+	struct snd_soc_dai_link *link;
+	int i;
+
+	for_each_card_prelinks(card, i, link) {
+		if (link->no_pcm == 1) {
+			link->init = qcm6490_snd_init;
+			link->be_hw_params_fixup = qcm6490_be_hw_params_fixup;
+			link->ops = &qcm6490_be_ops;
+		}
+	}
+}
+
+static int qcm6490_platform_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card;
+	struct qcm6490_snd_data *data;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+	card->owner = THIS_MODULE;
+	/* Allocate the private data */
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	card->dev = dev;
+	dev_set_drvdata(dev, card);
+	snd_soc_card_set_drvdata(card, data);
+	ret = qcom_snd_parse_of(card);
+	if (ret)
+		return ret;
+
+	card->driver_name = of_device_get_match_data(dev);
+	qcm6490_add_be_ops(card);
+	return devm_snd_soc_register_card(dev, card);
+}
+
+static const struct of_device_id snd_qcm6490_dt_match[] = {
+	{.compatible = "qcom,qcm6490-sndcard", "qcm6490"},
+	{.compatible = "qcom,qcs6490-sndcard", "qcs6490"},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, snd_qcm6490_dt_match);
+
+static struct platform_driver snd_qcm6490_driver = {
+	.probe  = qcm6490_platform_probe,
+	.driver = {
+		.name = "snd-qcm6490",
+		.of_match_table = snd_qcm6490_dt_match,
+	},
+};
+module_platform_driver(snd_qcm6490_driver);
+MODULE_DESCRIPTION("qcm6490 ASoC Machine Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


