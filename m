Return-Path: <linux-kernel+bounces-84372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7694C86A5F7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00DCF1F2C3D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29C754F88;
	Wed, 28 Feb 2024 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qk6Y5l5l"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DAE2C6B6;
	Wed, 28 Feb 2024 01:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709084223; cv=none; b=riXlH4jJkVvx7tvMUZznKbuzub3Wz9bIyItnmUW94q3W6VrS+DdmIgk36udQsXGkypztgy6do2LB8Fzmxc/asUJlNFOhER0QV1zocSGsCTsKFl/F8CMm/sc6RwVU6RW7JP4XTIsRZXU4y4N65s5vFD4QcNh0cgPEGISCd+Wd8j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709084223; c=relaxed/simple;
	bh=JR0ZF5EDYUXpz8R4hkblJP6u43VvKOsnM14+Rf6RV5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKJ60l7tLtidigOqh4ULbZenm2LrpSbpi1nlNj/WbnsNaWsWj2MqiHtwQjtNWu1tJzWo8UPHoUI6EVozs+iVRQIhgLmZp7n/9zZzqs/OgVLyhneVOLQxPAxC+clEisANBhZxLGemojeqjmzL3FmUdq82zyxhwK4GLQlGJoQINts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qk6Y5l5l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S0th3l026112;
	Wed, 28 Feb 2024 01:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=U6yTRai6MgB2GPETs+Ty
	FrMcQ5en+GNfoNXS76nrBjk=; b=Qk6Y5l5l6sMclVtMtQzqTkeV1/x+rMkAk4ra
	vXWJ8aOwzo0idW/SPbybNc7Zjtb1dd6XuOT+BvEVHE6zvw04WJ6l5Kck+tQf964B
	08U8smZ0g4nXDqBVrcp0lkoNaVgKc16ewWEbrnBRyqsU19gyRcuGSHptectv75ol
	jCMl74LVrtx1Qkh3gZT2ZYLPRG13lmXuaDj/PShRMdourum70HvOVDklemHI86PP
	0HkGhlBX5whJhXQTWejrHtYJDgQ1jituVYYsY54+x/LQNwL96b8vjTwBu7WRoPnm
	ho9tKAEPfCFzRkbydNWC27zUbRjbSXLFjYXN7vJ7SHK0cqRWfA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh64h31sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 01:36:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S1aWhc016672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 01:36:32 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 17:36:31 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v18 09/41] ASoC: Add SOC USB APIs for adding an USB backend
Date: Tue, 27 Feb 2024 17:35:47 -0800
Message-ID: <20240228013619.29758-10-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240228013619.29758-1-quic_wcheng@quicinc.com>
References: <20240228013619.29758-1-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: kXfQJopNIbi724HWzLJyRfMAQNpXEvKY
X-Proofpoint-GUID: kXfQJopNIbi724HWzLJyRfMAQNpXEvKY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402280011

Some platforms may have support for offloading USB audio devices to a
dedicated audio DSP.  Introduce a set of APIs that allow for management of
USB sound card and PCM devices enumerated by the USB SND class driver.
This allows for the ASoC components to be aware of what USB devices are
available for offloading.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 include/sound/soc-usb.h |  95 ++++++++++++++++
 sound/soc/Kconfig       |  10 ++
 sound/soc/Makefile      |   2 +
 sound/soc/soc-usb.c     | 239 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 346 insertions(+)
 create mode 100644 include/sound/soc-usb.h
 create mode 100644 sound/soc/soc-usb.c

diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
new file mode 100644
index 000000000000..5b2fa0877523
--- /dev/null
+++ b/include/sound/soc-usb.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __LINUX_SND_SOC_USB_H
+#define __LINUX_SND_SOC_USB_H
+
+/**
+ * struct snd_soc_usb_device
+ * @card_idx - sound card index associated with USB device
+ * @chip_idx - USB sound chip array index
+ * @num_playback - number of playback streams
+ * @num_capture - number of capture streams
+ **/
+struct snd_soc_usb_device {
+	int card_idx;
+	int chip_idx;
+	int num_playback;
+	int num_capture;
+};
+
+/**
+ * struct snd_soc_usb
+ * @list - list head for SND SOC struct list
+ * @component - reference to ASoC component
+ * @num_supported_streams - number of supported concurrent sessions
+ * @connection_status_cb - callback to notify connection events
+ * @priv_data - driver data
+ **/
+struct snd_soc_usb {
+	struct list_head list;
+	struct snd_soc_component *component;
+	unsigned int num_supported_streams;
+	int (*connection_status_cb)(struct snd_soc_usb *usb,
+			struct snd_soc_usb_device *sdev, bool connected);
+	void *priv_data;
+};
+
+#if IS_ENABLED(CONFIG_SND_SOC_USB)
+const char *snd_soc_usb_get_components_tag(bool playback);
+
+int snd_soc_usb_connect(struct device *usbdev, struct snd_soc_usb_device *sdev);
+int snd_soc_usb_disconnect(struct device *usbdev, struct snd_soc_usb_device *sdev);
+void *snd_soc_usb_find_priv_data(struct device *dev);
+
+struct snd_soc_usb *snd_soc_usb_allocate_port(struct snd_soc_component *component,
+					      int num_streams, void *data);
+void snd_soc_usb_free_port(struct snd_soc_usb *usb);
+int snd_soc_usb_add_port(struct snd_soc_usb *usb);
+int snd_soc_usb_remove_port(struct snd_soc_usb *usb);
+#else
+static inline const char *snd_soc_usb_get_components_tag(bool playback)
+{
+	return "";
+}
+
+static inline int snd_soc_usb_connect(struct device *usbdev,
+					struct snd_soc_usb_device *sdev)
+{
+	return -ENODEV;
+}
+
+static inline int snd_soc_usb_disconnect(struct device *usbdev,
+					 struct snd_soc_usb_device *sdev)
+{
+	return -EINVAL;
+}
+
+static inline void *snd_soc_usb_find_priv_data(struct device *dev)
+{
+	return NULL;
+}
+
+static inline struct snd_soc_usb *snd_soc_usb_allocate_port(
+					      struct snd_soc_component *component,
+					      int num_streams, void *data)
+{
+	return ERR_PTR(-ENOMEM);
+}
+
+static inline void snd_soc_usb_free_port(struct snd_soc_usb *usb)
+{ }
+
+static inline int snd_soc_usb_add_port(struct snd_soc_usb *usb)
+{
+	return -EINVAL;
+}
+
+static inline int snd_soc_usb_remove_port(struct snd_soc_usb *usb)
+{
+	return -ENODEV;
+}
+#endif /* IS_ENABLED(CONFIG_SND_SOC_USB) */
+#endif /*__LINUX_SND_SOC_USB_H */
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 439fa631c342..848493a46831 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -76,6 +76,16 @@ config SND_SOC_UTILS_KUNIT_TEST
 config SND_SOC_ACPI
 	tristate
 
+config SND_SOC_USB
+	tristate "SoC based USB audio offloading"
+	depends on SND_USB_AUDIO
+	help
+	  Enable this option if an ASoC platform card has support to handle
+	  USB audio offloading.  This enables the SoC USB layer, which will
+	  notifies the ASoC USB DPCM backend DAI link about available USB audio
+	  devices.  Based on the notifications, sequences to enable the audio
+	  stream can be taken based on the design.
+
 # All the supported SoCs
 source "sound/soc/adi/Kconfig"
 source "sound/soc/amd/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 8376fdb217ed..4c3d8b720d22 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -31,6 +31,8 @@ endif
 
 obj-$(CONFIG_SND_SOC_ACPI) += snd-soc-acpi.o
 
+obj-$(CONFIG_SND_SOC_USB) += soc-usb.o
+
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
 obj-$(CONFIG_SND_SOC)	+= codecs/
 obj-$(CONFIG_SND_SOC)	+= generic/
diff --git a/sound/soc/soc-usb.c b/sound/soc/soc-usb.c
new file mode 100644
index 000000000000..d21db2345966
--- /dev/null
+++ b/sound/soc/soc-usb.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <linux/of.h>
+#include <linux/usb.h>
+#include <sound/soc.h>
+#include <sound/soc-usb.h>
+#include "../usb/card.h"
+
+static DEFINE_MUTEX(ctx_mutex);
+static LIST_HEAD(usb_ctx_list);
+
+static struct device_node *snd_soc_find_phandle(struct device *dev)
+{
+	struct device_node *node;
+
+	node = of_parse_phandle(dev->of_node, "usb-soc-be", 0);
+	if (!node)
+		return ERR_PTR(-ENODEV);
+
+	return node;
+}
+
+static struct snd_soc_usb *snd_soc_find_usb_ctx(struct device_node *node)
+{
+	struct snd_soc_usb *ctx;
+
+	mutex_lock(&ctx_mutex);
+	list_for_each_entry(ctx, &usb_ctx_list, list) {
+		if (ctx->component->dev->of_node == node) {
+			mutex_unlock(&ctx_mutex);
+			return ctx;
+		}
+	}
+	mutex_unlock(&ctx_mutex);
+
+	return NULL;
+}
+
+/**
+ * snd_soc_usb_get_components_tag() - Retrieve SOC USB component tag
+ * @playback: direction of audio stream
+ *
+ * Returns the USB offload component tag used in the ASoC components
+ * string.
+ *
+ */
+const char *snd_soc_usb_get_components_tag(bool playback)
+{
+	if (playback)
+		return "usbplybkoffld: 1";
+	else
+		return "usbcapoffld: 1";
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_get_components_tag);
+
+/**
+ * snd_soc_usb_find_priv_data() - Retrieve private data stored
+ * @dev: device reference
+ *
+ * Fetch the private data stored in the USB SND SOC structure.
+ *
+ */
+void *snd_soc_usb_find_priv_data(struct device *dev)
+{
+	struct snd_soc_usb *ctx;
+	struct device_node *node;
+
+	node = snd_soc_find_phandle(dev);
+	if (!IS_ERR(node)) {
+		ctx = snd_soc_find_usb_ctx(node);
+		of_node_put(node);
+	} else {
+		/* Check if backend device */
+		ctx = snd_soc_find_usb_ctx(dev->of_node);
+	}
+
+	return ctx ? ctx->priv_data : NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_find_priv_data);
+
+/**
+ * snd_soc_usb_allocate_port() - allocate a SOC USB device
+ * @component: USB DPCM backend DAI component
+ * @num_streams: number of offloading sessions supported
+ * @data: private data
+ *
+ * Allocate and initialize a SOC USB device.  This will populate parameters that
+ * are used in subsequent sequences.
+ *
+ */
+struct snd_soc_usb *snd_soc_usb_allocate_port(struct snd_soc_component *component,
+					      int num_streams, void *data)
+{
+	struct snd_soc_usb *usb;
+
+	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
+	if (!usb)
+		return ERR_PTR(-ENOMEM);
+
+	usb->component = component;
+	usb->priv_data = data;
+	usb->num_supported_streams = num_streams;
+
+	return usb;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_allocate_port);
+
+/**
+ * snd_soc_usb_free_port() - free a SOC USB device
+ * @usb: allocated SOC USB device
+
+ * Free and remove the SOC USB device from the available list of devices.
+ *
+ */
+void snd_soc_usb_free_port(struct snd_soc_usb *usb)
+{
+	snd_soc_usb_remove_port(usb);
+	kfree(usb);
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_free_port);
+
+/**
+ * snd_soc_usb_add_port() - Add a USB backend port
+ * @dev: USB backend device
+ * @priv: private data
+ * @connection_cb: connection status callback
+ *
+ * Register a USB backend device to the SND USB SOC framework.  Memory is
+ * allocated as part of the USB backend device.
+ *
+ */
+int snd_soc_usb_add_port(struct snd_soc_usb *usb)
+{
+	mutex_lock(&ctx_mutex);
+	list_add_tail(&usb->list, &usb_ctx_list);
+	mutex_unlock(&ctx_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_add_port);
+
+/**
+ * snd_soc_usb_remove_port() - Remove a USB backend port
+ * @dev: USB backend device
+ *
+ * Remove a USB backend device from USB SND SOC.  Memory is freed when USB
+ * backend is removed.
+ *
+ */
+int snd_soc_usb_remove_port(struct snd_soc_usb *usb)
+{
+	struct snd_soc_usb *ctx, *tmp;
+
+	mutex_lock(&ctx_mutex);
+	list_for_each_entry_safe(ctx, tmp, &usb_ctx_list, list) {
+		if (ctx == usb) {
+			list_del(&ctx->list);
+			break;
+		}
+	}
+	mutex_unlock(&ctx_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_remove_port);
+
+/**
+ * snd_soc_usb_connect() - Notification of USB device connection
+ * @usbdev: USB bus device
+ * @card_idx: USB SND card instance
+ *
+ * Notify of a new USB SND device connection.  The card_idx can be used to
+ * handle how the DPCM backend selects, which device to enable USB offloading
+ * on.
+ *
+ */
+int snd_soc_usb_connect(struct device *usbdev, struct snd_soc_usb_device *sdev)
+{
+	struct snd_soc_usb *ctx;
+	struct device_node *node;
+
+	if (!usbdev)
+		return -ENODEV;
+
+	node = snd_soc_find_phandle(usbdev);
+	if (IS_ERR(node))
+		return -ENODEV;
+
+	ctx = snd_soc_find_usb_ctx(node);
+	of_node_put(node);
+	if (!ctx)
+		return -ENODEV;
+
+	mutex_lock(&ctx_mutex);
+	if (ctx->connection_status_cb)
+		ctx->connection_status_cb(ctx, sdev, true);
+	mutex_unlock(&ctx_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_connect);
+
+/**
+ * snd_soc_usb_disconnect() - Notification of USB device disconnection
+ * @usbdev: USB bus device
+ *
+ * Notify of a new USB SND device disconnection to the USB backend.
+ *
+ */
+int snd_soc_usb_disconnect(struct device *usbdev, struct snd_soc_usb_device *sdev)
+{
+	struct snd_soc_usb *ctx;
+	struct device_node *node;
+
+	if (!usbdev)
+		return -ENODEV;
+
+	node = snd_soc_find_phandle(usbdev);
+	if (IS_ERR(node))
+		return -ENODEV;
+
+	ctx = snd_soc_find_usb_ctx(node);
+	of_node_put(node);
+	if (!ctx)
+		return -ENODEV;
+
+	mutex_lock(&ctx_mutex);
+	if (ctx->connection_status_cb)
+		ctx->connection_status_cb(ctx, sdev, false);
+	mutex_unlock(&ctx_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_disconnect);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SoC USB driver for offloading");

