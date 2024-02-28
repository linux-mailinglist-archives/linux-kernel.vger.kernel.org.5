Return-Path: <linux-kernel+bounces-84352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88C286A597
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1640C1C236E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C324364D8;
	Wed, 28 Feb 2024 01:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BpoPhPOx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99091DDF5;
	Wed, 28 Feb 2024 01:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709084216; cv=none; b=cFOtROnMUP1ypLz3OhE0K6VyPcVfkNYN6MKH8MmNrWkqTKfZndHWwzM0HblhKcTL+LoSEwnf7/TeWBzR4OPSG/vFS0e+4GIS1l+VM/FcMbW9zUovsTLqHzGBYSdQfVhqEx01uJQ0+xUq5W9XFSlRLVX4fFZTFSmYep0oTF+5l/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709084216; c=relaxed/simple;
	bh=7iOpsTMbqEwoi14/dcN8UwbNoAatyge1GCbT8mE6mNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVmQ8pSuKGUhZ03M4vNI6wotzEJzqHysNChXeejr6QfE7WHtgU9D6XVD47I5nsYB4nIkkqdoi3zlTAZlWiFwIUafRQYbcHZim8ieraFYPYpKz2myW5eGfhPSL1bjmv16OQuStX+XCmxBmdqDLXu3xa+5SqcuzQvVMTJysaqlaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BpoPhPOx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S0idw9010991;
	Wed, 28 Feb 2024 01:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=1ti0OFMlpvxuyvNxeli7
	4aYR9ZNdqw1HmgshCcMPrxo=; b=BpoPhPOxDfmthR6QCFE2MTSU1bm4ByvTld2t
	fjHyMDjqcU+LXhRciVwSNH7JMABg7QqhrpQxh75C5+U6erOLuPULU8KHrdA5JQNs
	FzipUkRzL9u5qEadbLPUKgdWGpaBkY1WpbFgg/IX/HKvjqJry3ZakGOk/YlcHwO9
	YXVoducEoyjTAU/RGhdJK4FBYsGJRuBYcfnmO+S80upcjAN+kBfdoU3LxrZCm8UN
	hQGLPrvIk5oXMQ/E3SbYhOBQC6cuEGJYgwvbY66dkbRZqjSGr6FAKt8esbRhlDue
	Efkey2yHJPIZ4N4RlqBqGY4ZveDf/E0Src4u66fnjziijkNpug==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whthv02kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 01:36:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S1aZO2005322
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 01:36:35 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 17:36:35 -0800
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
Subject: [PATCH v18 22/41] ASoC: usb: Add PCM format check API for USB backend
Date: Tue, 27 Feb 2024 17:36:00 -0800
Message-ID: <20240228013619.29758-23-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: e3icifQ4WGAKxVphwW8P9Mzq2KPURzX-
X-Proofpoint-GUID: e3icifQ4WGAKxVphwW8P9Mzq2KPURzX-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280011

Introduce a helper to check if a particular PCM format is supported by the
USB audio device connected.  If the USB audio device does not have an
audio profile which can support the requested format, then notify the USB
backend.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 include/sound/soc-usb.h |  9 +++++++++
 sound/soc/soc-usb.c     | 25 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
index 5b2fa0877523..8f2d3064b520 100644
--- a/include/sound/soc-usb.h
+++ b/include/sound/soc-usb.h
@@ -39,6 +39,8 @@ struct snd_soc_usb {
 
 #if IS_ENABLED(CONFIG_SND_SOC_USB)
 const char *snd_soc_usb_get_components_tag(bool playback);
+int snd_soc_usb_find_format(int card_idx, struct snd_pcm_hw_params *params,
+			int direction);
 
 int snd_soc_usb_connect(struct device *usbdev, struct snd_soc_usb_device *sdev);
 int snd_soc_usb_disconnect(struct device *usbdev, struct snd_soc_usb_device *sdev);
@@ -55,6 +57,13 @@ static inline const char *snd_soc_usb_get_components_tag(bool playback)
 	return "";
 }
 
+static inline int snd_soc_usb_find_format(int card_idx,
+					  struct snd_pcm_hw_params *params,
+					  int direction)
+{
+	return -EINVAL;
+}
+
 static inline int snd_soc_usb_connect(struct device *usbdev,
 					struct snd_soc_usb_device *sdev)
 {
diff --git a/sound/soc/soc-usb.c b/sound/soc/soc-usb.c
index d21db2345966..bc77204fd2db 100644
--- a/sound/soc/soc-usb.c
+++ b/sound/soc/soc-usb.c
@@ -80,6 +80,31 @@ void *snd_soc_usb_find_priv_data(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(snd_soc_usb_find_priv_data);
 
+/**
+ * snd_soc_usb_find_format() - Check if audio format is supported
+ * @card_idx: USB sound chip array index
+ * @params: PCM parameters
+ * @direction: capture or playback
+ *
+ * Ensure that a requested audio profile from the ASoC side is able to be
+ * supported by the USB device.
+ *
+ * Return 0 on success, negative on error.
+ *
+ */
+int snd_soc_usb_find_format(int card_idx, struct snd_pcm_hw_params *params,
+			int direction)
+{
+	struct snd_usb_stream *as;
+
+	as = snd_usb_find_suppported_substream(card_idx, params, direction);
+	if (!as)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_find_format);
+
 /**
  * snd_soc_usb_allocate_port() - allocate a SOC USB device
  * @component: USB DPCM backend DAI component

