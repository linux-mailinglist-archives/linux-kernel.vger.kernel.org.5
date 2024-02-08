Return-Path: <linux-kernel+bounces-58843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A3784ED87
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8CA1F213BC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F9761691;
	Thu,  8 Feb 2024 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OlRn4jWR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC8855789;
	Thu,  8 Feb 2024 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434091; cv=none; b=NhvlCQzN+RE6d0Ri+eF05ZG68hVu5YosFvmYpyDlpnawhjHQ8QIgMKAyjYIvtzfa60ohYbyY7y1PF4icu+hMyZ0fd3EybLGwEGASAH6bceTtvvP6L/aKs4YwK0BsoNa93DVHkBQQcYle8Olk/9YvRYy4PR7kRHQzRxDy0306wr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434091; c=relaxed/simple;
	bh=B2Uh+utLRUwvSvG6gKYDBbEMdPWEQKJy4Vy8UpaYpEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBMm+ouvqPfJh2J07E+AVOWSB6uVNWqEF/VKJ0CiCoNt8UUWJTO4IOeiLoDR1KBUXTqiwv1yg0GMUTy2rSlmdjNRrU1MWI+e1oM5Fe3AACy81B2uvHlRqZmG9jM0d9E+L2eV26cRSLV8WKgl+NKSBw6f1o7drwPRD5YbbV8fKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OlRn4jWR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418N5MTS001374;
	Thu, 8 Feb 2024 23:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=4B1k97XPpHND08MwaSfK
	ILwcn62znRNXke+S79WKkGE=; b=OlRn4jWRXEaofllDuqqK6MvKzh1WSh/ZZPif
	OHSKr3WtI5WI5Qdi88o9rCVLWOMYN2ONI4UynXevHUnEuACtCvRkLyBBuMjV80iX
	GOAIIFlALEb4ETMdfOMvd3TLkqRxpaINOvOqQeQDNpB5+uieVjTju1sQfkb7HN/u
	RhokmWYKCbj7hjX6nakoZV7giOQ+H4KWyrZSSgZbiCbVBiR3kTuNYiQ4tHgoKkXn
	+vfnRJHvwNEoJ8n1KNQo7sLSnSPm3COw6UfT0ta06RqXnqi9En1dz+NGjN1B06pC
	HwFXYeZKTdClWD8WL6C8gXMezKeGTQrMXcy0dmvrCX3ZN+sz9A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4m3ak1pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:14:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418NEStl009259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 23:14:28 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 8 Feb 2024 15:14:28 -0800
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
Subject: [PATCH v14 47/53] ASoC: usb: Fetch ASoC sound card information
Date: Thu, 8 Feb 2024 15:14:00 -0800
Message-ID: <20240208231406.27397-48-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208231406.27397-1-quic_wcheng@quicinc.com>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ai1V8jvH3MvZ9vwJj9XYdhdtTauEDGz4
X-Proofpoint-GUID: Ai1V8jvH3MvZ9vwJj9XYdhdtTauEDGz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080131

For USB sound to expose mixer controls to fetch information about the ASoC
sound card, add an API that returns the platform sound card number that is
registered with SOC USB.  Knowing this allows for applications to further
query about the offload status.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 include/sound/soc-usb.h |  1 +
 sound/soc/soc-usb.c     | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
index e07e83d86a11..443c53419295 100644
--- a/include/sound/soc-usb.h
+++ b/include/sound/soc-usb.h
@@ -73,6 +73,7 @@ int snd_soc_usb_find_format(int card_idx, struct snd_pcm_hw_params *params,
 int snd_soc_usb_connect(struct device *usbdev, struct snd_soc_usb_device *sdev);
 int snd_soc_usb_disconnect(struct device *usbdev, struct snd_soc_usb_device *sdev);
 void *snd_soc_usb_find_priv_data(struct device *dev);
+int snd_soc_usb_device_offload_available(struct device *dev);
 
 int snd_soc_usb_prepare_session(struct snd_soc_usb *usb, int card_idx, int pcm_idx);
 int snd_soc_usb_shutdown_session(struct snd_soc_usb *usb, int session_id);
diff --git a/sound/soc/soc-usb.c b/sound/soc/soc-usb.c
index f22fd1b6d294..dfd6f53898c5 100644
--- a/sound/soc/soc-usb.c
+++ b/sound/soc/soc-usb.c
@@ -340,6 +340,32 @@ int snd_soc_usb_find_format(int card_idx, struct snd_pcm_hw_params *params,
 }
 EXPORT_SYMBOL_GPL(snd_soc_usb_find_format);
 
+/**
+ * snd_soc_usb_device_offload_available() - Fetch BE DAI link sound card
+ * @dev: the device to find in SOC USB
+ *
+ * Finds the component linked to a specific SOC USB instance, and returns
+ * the sound card number for the platform card supporting offloading.
+ *
+ */
+int snd_soc_usb_device_offload_available(struct device *dev)
+{
+	struct snd_soc_usb *ctx;
+	struct device_node *node;
+
+	node = snd_soc_find_phandle(dev);
+	if (IS_ERR(node))
+		return -ENODEV;
+
+	ctx = snd_soc_find_usb_ctx(node);
+	of_node_put(node);
+	if (!ctx)
+		return -ENODEV;
+
+	return ctx->component->card->snd_card->number;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_device_offload_available);
+
 /**
  * snd_soc_usb_allocate_port() - allocate a SOC USB device
  * @component: USB DPCM backend DAI component

