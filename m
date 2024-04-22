Return-Path: <linux-kernel+bounces-154135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE558AD819
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7B01C21A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B4215B135;
	Mon, 22 Apr 2024 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R0+Hchfv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84775103D;
	Mon, 22 Apr 2024 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826207; cv=none; b=sPcYhqFg6SYUso4LzoiRCM5HyPllo6OstuKCPs/WnuJ9PfK3d3tPz6AreQemORu3lW57XwoaDTJrfYYPBgkwLcbiUO8NlPmUZe/eqdghoQmyetQT8QkMxsdgsakj9dwGd3ZlwaWtRbwIavCaQuQXQBoXYB7OZH6MNNVHqCfcprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826207; c=relaxed/simple;
	bh=x8FMw79+MJO3INaA7cIDxv7FVstaQ6sDc7VmQmpQgf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3Xtb+1RQt9WFi5cNF4qrNzu1sFm1/jXJKfXSn5apzHBs5vZod9T6o4ae8pk0deOcsUwX2XLBtasXR5Y8enescgIuJW9wlpX2N049FvB4RjyNigsB2Nm49SrV36HM2MmAMJZ93eW89s/XTyZwb/8mtDNYNbc3uEfkQMJ1lDthUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R0+Hchfv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MKQ7XF022182;
	Mon, 22 Apr 2024 22:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=9GymGWHJhd3bLbSuLAwx
	WHGoQttVN5CT5k2iVDcg96M=; b=R0+HchfvrjtEasxjFdYy3PqmqUY4I+j0dLJ5
	T8vbQfFsGQk20/ne9Y31cFQskel8vUA2TQ3UTRkyDiUDeiV2JNeBObcrxhGyicjR
	9R623DhGAz7yAZAdPDYArSFhcKpDAZtWqohSeQ0qPoCWKW/LG1V9UZqBLm9clz9w
	pdgHo57SrCsuZH3DMz/I7sngbbaGUEhqttotO8PbqyWSqWMT3pEEs5QtLet2HLwl
	Jfl/6yK9wXoqL9FECg0Z8xg7KxCPrr/LedTUGIlUvH3815awah2a2A+Z29ZmndGb
	O3+zHi5i+BSkcUpQa8C/9sEeHknx2Dsu/R1KF2Yi1i/4aKxohA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnn82hskf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 22:49:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MMnKaK012062
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 22:49:20 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 15:49:19 -0700
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v19 13/41] ASoC: qcom: qdsp6: Add USB backend ASoC driver for Q6
Date: Mon, 22 Apr 2024 15:48:38 -0700
Message-ID: <20240422224906.15868-14-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240422224906.15868-1-quic_wcheng@quicinc.com>
References: <20240422224906.15868-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m6zsfwIdvQ-gbvaSMGEtHfGvRDONiv0o
X-Proofpoint-ORIG-GUID: m6zsfwIdvQ-gbvaSMGEtHfGvRDONiv0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_16,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220096

Create a USB BE component that will register a new USB port to the ASoC USB
framework.  This will handle determination on if the requested audio
profile is supported by the USB device currently selected.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 include/sound/q6usboffload.h  |  20 ++++
 sound/soc/qcom/Kconfig        |  10 ++
 sound/soc/qcom/qdsp6/Makefile |   1 +
 sound/soc/qcom/qdsp6/q6usb.c  | 218 ++++++++++++++++++++++++++++++++++
 4 files changed, 249 insertions(+)
 create mode 100644 include/sound/q6usboffload.h
 create mode 100644 sound/soc/qcom/qdsp6/q6usb.c

diff --git a/include/sound/q6usboffload.h b/include/sound/q6usboffload.h
new file mode 100644
index 000000000000..fdc1f5c53a3b
--- /dev/null
+++ b/include/sound/q6usboffload.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * linux/sound/q6usboffload.h -- QDSP6 USB offload
+ *
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/**
+ * struct q6usb_offload
+ * @dev - dev handle to usb be
+ * @sid - streamID for iommu
+ * @intr_num - usb interrupter number
+ * @domain - allocated iommu domain
+ **/
+struct q6usb_offload {
+	struct device *dev;
+	long long sid;
+	u16 intr_num;
+	struct iommu_domain *domain;
+};
diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 762491d6f2f2..a1beafe2b1dd 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -118,6 +118,16 @@ config SND_SOC_QDSP6_PRM
 	tristate
 	select SND_SOC_QDSP6_PRM_LPASS_CLOCKS
 
+config SND_SOC_QDSP6_USB
+    tristate "SoC ALSA USB offloading backing for QDSP6"
+    depends on SND_SOC_USB
+    help
+      Adds support for USB offloading for QDSP6 ASoC
+      based platform sound cards.  This will enable the
+      Q6USB DPCM backend DAI link, which will interact
+      with the SoC USB framework to initialize a session
+      with active USB SND devices.
+
 config SND_SOC_QDSP6
 	tristate "SoC ALSA audio driver for QDSP6"
 	depends on QCOM_APR
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index 3963bf234664..c9457ee898d0 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_SND_SOC_QDSP6_APM_DAI) += q6apm-dai.o
 obj-$(CONFIG_SND_SOC_QDSP6_APM_LPASS_DAI) += q6apm-lpass-dais.o
 obj-$(CONFIG_SND_SOC_QDSP6_PRM) += q6prm.o
 obj-$(CONFIG_SND_SOC_QDSP6_PRM_LPASS_CLOCKS) += q6prm-clocks.o
+obj-$(CONFIG_SND_SOC_QDSP6_USB) += q6usb.o
diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
new file mode 100644
index 000000000000..00cba1021dc6
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/iommu.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <sound/asound.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/q6usboffload.h>
+#include <sound/soc.h>
+#include <sound/soc-usb.h>
+
+#include <dt-bindings/sound/qcom,q6afe.h>
+
+#include "q6afe.h"
+#include "q6dsp-lpass-ports.h"
+
+#define Q6_USB_SID_MASK	0xF
+
+struct q6usb_port_data {
+	struct q6afe_usb_cfg usb_cfg;
+	struct snd_soc_usb *usb;
+	struct q6usb_offload priv;
+	int active_usb_chip_idx;
+};
+
+static const struct snd_soc_dapm_widget q6usb_dai_widgets[] = {
+	SND_SOC_DAPM_HP("USB_RX_BE", NULL),
+};
+
+static const struct snd_soc_dapm_route q6usb_dapm_routes[] = {
+	{"USB Playback", NULL, "USB_RX_BE"},
+};
+
+static int q6usb_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	return 0;
+}
+
+static const struct snd_soc_dai_ops q6usb_ops = {
+	.hw_params = q6usb_hw_params,
+};
+
+static struct snd_soc_dai_driver q6usb_be_dais[] = {
+	{
+		.playback = {
+			.stream_name = "USB BE RX",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
+				SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |
+				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
+				SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+				SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
+				SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |
+				SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |
+				SNDRV_PCM_FMTBIT_U24_LE | SNDRV_PCM_FMTBIT_U24_BE,
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_max =     192000,
+			.rate_min =	8000,
+		},
+		.id = USB_RX,
+		.name = "USB_RX_BE",
+		.ops = &q6usb_ops,
+	},
+};
+
+static int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *component,
+					const struct of_phandle_args *args,
+					const char **dai_name)
+{
+	int id = args->args[0];
+	int ret = -EINVAL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(q6usb_be_dais); i++) {
+		if (q6usb_be_dais[i].id == id) {
+			*dai_name = q6usb_be_dais[i].name;
+			ret = 0;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb,
+			struct snd_soc_usb_device *sdev, bool connected)
+{
+	struct q6usb_port_data *data;
+
+	if (!usb->component)
+		return -ENODEV;
+
+	data = dev_get_drvdata(usb->component->dev);
+
+	if (connected) {
+		/* We only track the latest USB headset plugged in */
+		data->active_usb_chip_idx = sdev->card_idx;
+	}
+
+	return 0;
+}
+
+static int q6usb_component_probe(struct snd_soc_component *component)
+{
+	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
+	struct snd_soc_usb *usb;
+	int ret;
+
+	usb = snd_soc_usb_allocate_port(component, 1, &data->priv);
+	if (IS_ERR(usb))
+		return -ENOMEM;
+
+	usb->connection_status_cb = q6usb_alsa_connection_cb;
+
+	ret = snd_soc_usb_add_port(usb);
+	if (ret < 0) {
+		dev_err(component->dev, "failed to add usb port\n");
+		goto free_usb;
+	}
+
+	data->usb = usb;
+
+	return 0;
+
+free_usb:
+	snd_soc_usb_free_port(usb);
+
+	return ret;
+}
+
+static void q6usb_component_remove(struct snd_soc_component *component)
+{
+	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
+
+	snd_soc_usb_remove_port(data->usb);
+	snd_soc_usb_free_port(data->usb);
+}
+
+static const struct snd_soc_component_driver q6usb_dai_component = {
+	.probe = q6usb_component_probe,
+	.remove = q6usb_component_remove,
+	.name = "q6usb-dai-component",
+	.dapm_widgets = q6usb_dai_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(q6usb_dai_widgets),
+	.dapm_routes = q6usb_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(q6usb_dapm_routes),
+	.of_xlate_dai_name = q6usb_audio_ports_of_xlate_dai_name,
+};
+
+static int q6usb_dai_dev_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct q6usb_port_data *data;
+	struct device *dev = &pdev->dev;
+	struct of_phandle_args args;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = of_property_read_u16(node, "qcom,usb-audio-intr-idx",
+				&data->priv.intr_num);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to read intr idx.\n");
+		return ret;
+	}
+
+	ret = of_parse_phandle_with_fixed_args(node, "iommus", 1, 0, &args);
+	if (ret < 0)
+		data->priv.sid = -1;
+	else
+		data->priv.sid = args.args[0] & Q6_USB_SID_MASK;
+
+	data->priv.domain = iommu_get_domain_for_dev(&pdev->dev);
+
+	data->priv.dev = dev;
+	dev_set_drvdata(dev, data);
+
+	return devm_snd_soc_register_component(dev, &q6usb_dai_component,
+					q6usb_be_dais, ARRAY_SIZE(q6usb_be_dais));
+}
+
+static const struct of_device_id q6usb_dai_device_id[] = {
+	{ .compatible = "qcom,q6usb" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6usb_dai_device_id);
+
+static struct platform_driver q6usb_dai_platform_driver = {
+	.driver = {
+		.name = "q6usb-dai",
+		.of_match_table = of_match_ptr(q6usb_dai_device_id),
+	},
+	.probe = q6usb_dai_dev_probe,
+	/*
+	 * Remove not required as resources are cleaned up as part of
+	 * component removal.  Others are device managed resources.
+	 */
+};
+module_platform_driver(q6usb_dai_platform_driver);
+
+MODULE_DESCRIPTION("Q6 USB backend dai driver");
+MODULE_LICENSE("GPL");

