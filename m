Return-Path: <linux-kernel+bounces-50832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89523847EC3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD2F6B28476
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6F7182B5;
	Sat,  3 Feb 2024 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YY1kPk6C"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09CA23C9;
	Sat,  3 Feb 2024 02:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706927869; cv=none; b=gkN8sReYD1TSnrp6WkAHj4DtMx6cm5DE+VUxgQ7HUb8NDSSEZA970Y5D7xUivI6LnY+DIR+jBbyeMOTxK78xPoCyVqPZ8JVXJ3ORVG9MwCDOuPb9DnQ+qXkw6Jtn3lvJyyZWtCGUyG+V03ARHxPmFSbI2tz0e/1tyTali1px41g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706927869; c=relaxed/simple;
	bh=kCI2wpxHS2B0a8rnreQMrTdOsnwA7+jL3ssXaF27uaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRr+z2uwEYCueIFotncOWHxFrG8ScbFXJ1eRwGlz/9G9paBLAUBiI3xagDz2ifuof7eyv8NpjL/jYZowtZv60ModDoJruoXJAcYBZ7GI5YEy1/fWfYoaEN6WhwAEfme3Icg/PtVuLgWDqgO6B5jvFWZ0ej5fI5bGeKWuSQufCxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YY1kPk6C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4132HueN013938;
	Sat, 3 Feb 2024 02:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=EzS2gn4U4WnO6HUj0UC6
	9z/Zo5B+U25eLv0bGKq0HUI=; b=YY1kPk6CrYjaNXQrtDFmoN/hjkBASZcVguBd
	h7o6er/PxbRqKUUPatTcDfzAg3/jpy74B8IC/h4WMtW73VzLev4NWU2IwmFUbvfV
	H14OUZbu/4C4fA84aXSqJapqkSL3nSBZOgUIWvwdrsSPp4QXKsGM4SCLBrN025lp
	fA7DxQbA36f9BACpc8QiyX6OMmasdHKAPTidDkeRLdyzgh3L2xO/lmtOqvG8g70A
	CjG6AkBJf9mDnPuUZ3fNuZTykJ5NjSSnnml/mc9k38a4PN7Nk7zkgaCHVxb0KMKn
	ew5epZHz7OZr+qauAjQm4904emDIZpNRXk/82+IGQlIW9189/w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w154w8sh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Feb 2024 02:37:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4132bVvf004311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 02:37:31 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 18:37:30 -0800
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
Subject: [PATCH v13 45/53] ASoC: usb: Create SOC USB SND jack kcontrol
Date: Fri, 2 Feb 2024 18:36:37 -0800
Message-ID: <20240203023645.31105-46-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240203023645.31105-1-quic_wcheng@quicinc.com>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: vCsUTT7wCuLKKtKJOvI0rxexa6qGyK-L
X-Proofpoint-ORIG-GUID: vCsUTT7wCuLKKtKJOvI0rxexa6qGyK-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=723 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402030015

Expose API for creation of a jack control for notifying of available
devices that are plugged in/discovered, and that support offloading.  This
allows for control names to be standardized across implementations of USB
audio offloading.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 include/sound/soc-usb.h |  4 ++++
 sound/soc/soc-usb.c     | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
index c05d9b2f5c90..e07e83d86a11 100644
--- a/include/sound/soc-usb.h
+++ b/include/sound/soc-usb.h
@@ -6,6 +6,8 @@
 #ifndef __LINUX_SND_SOC_USB_H
 #define __LINUX_SND_SOC_USB_H
 
+#include <sound/soc.h>
+
 enum snd_soc_usb_dai_state {
 	SND_SOC_USB_IDLE,
 	SND_SOC_USB_PREPARED,
@@ -76,6 +78,8 @@ int snd_soc_usb_prepare_session(struct snd_soc_usb *usb, int card_idx, int pcm_i
 int snd_soc_usb_shutdown_session(struct snd_soc_usb *usb, int session_id);
 int snd_soc_usb_set_session_state(struct snd_soc_usb *usb, int session_id,
 				  enum snd_soc_usb_dai_state state);
+int snd_soc_usb_setup_offload_jack(struct snd_soc_component *component,
+					struct snd_soc_jack *jack);
 
 struct snd_soc_usb *snd_soc_usb_allocate_port(struct snd_soc_component *component,
 			int num_supported_streams, void *data);
diff --git a/sound/soc/soc-usb.c b/sound/soc/soc-usb.c
index 9c082129cb9f..f22fd1b6d294 100644
--- a/sound/soc/soc-usb.c
+++ b/sound/soc/soc-usb.c
@@ -4,8 +4,11 @@
  */
 #include <linux/of.h>
 #include <linux/usb.h>
+
+#include <sound/jack.h>
 #include <sound/soc.h>
 #include <sound/soc-usb.h>
+
 #include "../usb/card.h"
 
 static DEFINE_MUTEX(ctx_mutex);
@@ -42,6 +45,40 @@ static struct snd_soc_usb *snd_soc_find_usb_ctx(struct device_node *node)
 }
 
 /* SOC USB sound kcontrols */
+
+/**
+ * snd_soc_usb_setup_offload_jack() - Create USB offloading jack
+ * @component: USB DPCM backend DAI component
+ * @jack: jack structure to create
+ *
+ * Creates a jack device for notifying userspace of the availability
+ * of an offload capable device.
+ *
+ * Returns 0 on success, negative on error.
+ *
+ */
+int snd_soc_usb_setup_offload_jack(struct snd_soc_component *component,
+					struct snd_soc_jack *jack)
+{
+	int ret;
+
+	ret = snd_soc_card_jack_new(component->card, "SNDUSB OFFLD Jack",
+					SND_JACK_HEADPHONE, jack);
+	if (ret < 0) {
+		dev_err(component->card->dev, "Unable to add USB offload jack\n");
+		return ret;
+	}
+
+	ret = snd_soc_component_set_jack(component, jack, NULL);
+	if (ret) {
+		dev_warn(component->card->dev, "Failed to set jack: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_setup_offload_jack);
+
 static int snd_soc_usb_get_offload_status(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {

