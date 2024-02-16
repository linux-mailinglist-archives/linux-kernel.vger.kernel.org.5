Return-Path: <linux-kernel+bounces-68030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6B3857531
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7868281487
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6A953805;
	Fri, 16 Feb 2024 04:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OYho/kX7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F611D6A7;
	Fri, 16 Feb 2024 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708056007; cv=none; b=jxrnP1i4E3FPWKi+8yjiGsw/TJbr8S/nI2+5Lz3iCs7HnUjBtda4tCtT67QL4I2hFgsckhjsDyix5XtED3LL2lQhxWgGf5KrR2bOGpidrnq8/QF4u0+isRFzlPk3lw0goLOQ9qvKKxQ5/nnAjgeFiXuk3k0a0afagQEgn6aFK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708056007; c=relaxed/simple;
	bh=vwuofOOi4zkTHmmdGlxh9vfnw5KE/ViFZeGzZLFbN6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fk4tVRnz0QY840qYsvJVK1897J69DmPluH6EMnCt7COjdj0QiCUnpjm120JjSvaK3txFV2oznEy+0iMMJ4+8WbT9rFfIJisPcKAV1o0KsZhE4cW3Kg+R12FedvgQJuqeGBk98aHwa9HQnkECPInHk9FZe7TpcDjdsHeu1WX4QnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OYho/kX7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G3ePVH031287;
	Fri, 16 Feb 2024 03:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=FyzT1vr1jhu7S4Cu9qXB
	BRq39DvKyfKJ2DTmA9A+fPM=; b=OYho/kX7HYZMEgOgjPzukHoX9nhjupG9yyFL
	dskyRtizEQaAyfihP8googsyR2BJoqYHDuYx2Cwr/mKjL6Ha16PgYQnBSIV3Zsb9
	icJzYl6PYbZBRbGoTnmnwCeSRdIOZpbSn3DaPvAeJQRU2VlgPzkaQlrqIV4Gutdm
	93l031hJXqEyXxlWk3ID5ZglcSP/R0U2zlbIpHCtPVn7o8x0pgfB5EPUytc0B+aj
	C4v8XcwxH6S5j9H/BTX4VMYHLaMR+FgWLLPRXBAzCsJ3aX57kq7gWZT43zKNngiO
	9uR9LTlMwbYJzKQaKEHOkgCwBA+NXzrH0fDaGwpsaw7rnDTwzw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9435uvcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41G3xid9024978
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:44 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 19:59:44 -0800
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
Subject: [PATCH v16 41/50] ASoC: Introduce SND kcontrols to track USB offloading state
Date: Thu, 15 Feb 2024 19:59:14 -0800
Message-ID: <20240216035923.23392-42-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240216035923.23392-1-quic_wcheng@quicinc.com>
References: <20240216035923.23392-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nrt9uCnjsNLvkp7kta7-MLL2vQy-lwSJ
X-Proofpoint-ORIG-GUID: nrt9uCnjsNLvkp7kta7-MLL2vQy-lwSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_02,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160030

Expose helpers in the SoC USB layer so components can update and keep track
of the offloading sessions.  This exposes a kcontrol to userspace, so that
applications can be aware of what the current USB offloading status is.
An example output using tinymix is:

USB offloading idle:
tinymix -D 0 get 'USB Offload Playback Route Status'
-->-1, -1 (range -1->32)

USB offloading active(USB card#1 pcm#0):
tinymix -D 0 get 'USB Offload Playback Route Status'
-->1, 0 (range -1->32)

Change-Id: Idfa9ed7003e2a93ea091b7dbee71c5569d4bc7c0
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 include/sound/soc-usb.h |  46 +++++++++++
 sound/soc/soc-usb.c     | 176 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 222 insertions(+)

diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
index 18cdc59df9aa..5e6076f65a41 100644
--- a/include/sound/soc-usb.h
+++ b/include/sound/soc-usb.h
@@ -9,9 +9,29 @@
 enum snd_soc_usb_kctl {
 	SND_SOC_USB_KCTL_CARD_ROUTE,
 	SND_SOC_USB_KCTL_PCM_ROUTE,
+	SND_SOC_USB_KCTL_CARD_STATUS,
+	SND_SOC_USB_KCTL_PCM_STATUS,
 	SND_SOC_USB_KCTL_MAX,
 };
 
+enum snd_soc_usb_dai_state {
+	SND_SOC_USB_IDLE,
+	SND_SOC_USB_PREPARED,
+	SND_SOC_USB_RUNNING,
+};
+
+/**
+ * struct snd_soc_usb_session
+ * @active_card_idx - active offloaded sound card
+ * @active_pcm_idx - active offloaded PCM device
+ * @state - USB BE DAI link PCM state
+ */
+struct snd_soc_usb_session {
+	int active_card_idx;
+	int active_pcm_idx;
+	enum snd_soc_usb_dai_state state;
+};
+
 /**
  * struct snd_soc_usb_device
  * @card_idx - sound card index associated with USB device
@@ -31,6 +51,7 @@ struct snd_soc_usb_device {
  * @list - list head for SND SOC struct list
  * @component - reference to ASoC component
  * @kctl - list of kcontrols created
+ * @active_list - active sessions
  * @num_supported_streams - number of supported concurrent sessions
  * @connection_status_cb - callback to notify connection events
  * @put_offload_dev - callback to select USB sound card/PCM device
@@ -41,6 +62,7 @@ struct snd_soc_usb {
 	struct list_head list;
 	struct snd_soc_component *component;
 	struct snd_kcontrol *kctl[SND_SOC_USB_KCTL_MAX];
+	struct snd_soc_usb_session *active_list;
 	unsigned int num_supported_streams;
 	int (*connection_status_cb)(struct snd_soc_usb *usb,
 			struct snd_soc_usb_device *sdev, bool connected);
@@ -62,6 +84,11 @@ int snd_soc_usb_connect(struct device *usbdev, struct snd_soc_usb_device *sdev);
 int snd_soc_usb_disconnect(struct device *usbdev, struct snd_soc_usb_device *sdev);
 void *snd_soc_usb_find_priv_data(struct device *dev);
 
+int snd_soc_usb_prepare_session(struct snd_soc_usb *usb, int card_idx, int pcm_idx);
+int snd_soc_usb_shutdown_session(struct snd_soc_usb *usb, int session_id);
+int snd_soc_usb_set_session_state(struct snd_soc_usb *usb, int session_id,
+				  enum snd_soc_usb_dai_state state);
+
 struct snd_soc_usb *snd_soc_usb_allocate_port(struct snd_soc_component *component,
 					      int num_streams, void *data);
 void snd_soc_usb_free_port(struct snd_soc_usb *usb);
@@ -97,6 +124,25 @@ static inline void *snd_soc_usb_find_priv_data(struct device *dev)
 	return NULL;
 }
 
+static inline int snd_soc_usb_prepare_session(struct snd_soc_usb *usb, int card_idx,
+						int pcm_idx)
+{
+	return -EINVAL;
+}
+
+static inline int snd_soc_usb_shutdown_session(struct snd_soc_usb *usb,
+						int session_id)
+{
+	return -EINVAL;
+}
+
+static inline int snd_soc_usb_set_session_state(struct snd_soc_usb *usb,
+						int session_id,
+						enum snd_soc_usb_dai_state state)
+{
+	return -EINVAL;
+}
+
 static inline struct snd_soc_usb *snd_soc_usb_allocate_port(
 					      struct snd_soc_component *component,
 					      int num_streams, void *data)
diff --git a/sound/soc/soc-usb.c b/sound/soc/soc-usb.c
index ade09b416d45..e291f146a79d 100644
--- a/sound/soc/soc-usb.c
+++ b/sound/soc/soc-usb.c
@@ -42,6 +42,79 @@ static struct snd_soc_usb *snd_soc_find_usb_ctx(struct device_node *node)
 }
 
 /* SOC USB sound kcontrols */
+static int snd_soc_usb_get_offload_card_status(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_usb *ctx = snd_soc_find_usb_ctx(component->dev->of_node);
+	int control_idx = 0;
+	int card_idx;
+	int i;
+
+	for (i = 0; i < ctx->num_supported_streams; i++) {
+		card_idx = -1;
+
+		if (ctx->active_list[i].state == SND_SOC_USB_RUNNING)
+			card_idx = ctx->active_list[i].active_card_idx;
+
+		ucontrol->value.integer.value[control_idx] = card_idx;
+		control_idx++;
+	}
+
+	return 0;
+}
+
+static int snd_soc_usb_offload_card_status_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_usb *ctx = snd_soc_find_usb_ctx(component->dev->of_node);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = ctx->num_supported_streams;
+	uinfo->value.integer.min = -1;
+	uinfo->value.integer.max = SNDRV_CARDS;
+
+	return 0;
+}
+
+static int snd_soc_usb_get_offload_pcm_status(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_usb *ctx = snd_soc_find_usb_ctx(component->dev->of_node);
+	int control_idx = 0;
+	int pcm_idx;
+	int i;
+
+	for (i = 0; i < ctx->num_supported_streams; i++) {
+		pcm_idx = -1;
+
+		if (ctx->active_list[i].state == SND_SOC_USB_RUNNING)
+			pcm_idx = ctx->active_list[i].active_pcm_idx;
+
+		ucontrol->value.integer.value[control_idx] = pcm_idx;
+		control_idx++;
+	}
+
+	return 0;
+}
+
+static int snd_soc_usb_offload_pcm_status_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_usb *ctx = snd_soc_find_usb_ctx(component->dev->of_node);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = ctx->num_supported_streams;
+	uinfo->value.integer.min = -1;
+	/* Arbitrary max value, as there is no 'limit' on number of PCM devices */
+	uinfo->value.integer.max = 0xff;
+
+	return 0;
+}
+
 static int soc_usb_put_offload_pcm_dev(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
@@ -152,6 +225,22 @@ static const struct snd_kcontrol_new soc_usb_kcontrols[] = {
 		.get = soc_usb_get_offload_pcm_dev,
 		.put = soc_usb_put_offload_pcm_dev,
 	},
+	[SND_SOC_USB_KCTL_CARD_STATUS] = {
+		.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+		.access = SNDRV_CTL_ELEM_ACCESS_READ,
+		.name = "USB Offload Playback Route Card Status",
+		.info = snd_soc_usb_offload_card_status_info,
+		.get = snd_soc_usb_get_offload_card_status,
+		.put = NULL,
+	},
+	[SND_SOC_USB_KCTL_PCM_STATUS] = {
+		.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+		.access = SNDRV_CTL_ELEM_ACCESS_READ,
+		.name = "USB Offload Playback Route PCM Status",
+		.info = snd_soc_usb_offload_pcm_status_info,
+		.get = snd_soc_usb_get_offload_pcm_status,
+		.put = NULL,
+	},
 };
 
 static int snd_soc_usb_control_remove(struct snd_soc_usb *usb)
@@ -187,6 +276,85 @@ static int snd_soc_usb_control_init(struct snd_soc_usb *usb)
 	return ret;
 }
 
+/**
+ * snd_soc_usb_set_session_state() - Set the session state for a session
+ * @usb: SOC USB device
+ * @session_id: index to active_list
+ * @state: USB PCM device index
+ *
+ * Set the session state for an entry in active_list.  This should be only
+ * called after snd_soc_usb_prepare_session.
+ *
+ * Returns 0 on success, negative on error.
+ *
+ */
+int snd_soc_usb_set_session_state(struct snd_soc_usb *usb, int session_id,
+				  enum snd_soc_usb_dai_state state)
+{
+	if (session_id < 0 || session_id >= usb->num_supported_streams)
+		return -EINVAL;
+
+	mutex_lock(&ctx_mutex);
+	if (usb->active_list[session_id].state == state) {
+		mutex_unlock(&ctx_mutex);
+		return 0;
+	}
+
+	usb->active_list[session_id].state = state;
+	mutex_unlock(&ctx_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_set_session_state);
+
+/**
+ * snd_soc_usb_prepare_session() - Find and prepare a session
+ * @usb: SOC USB device
+ * @card_idx: USB card index
+ * @pcm_idx: USB PCM device index
+ *
+ * Find an open active session slot on the SOC USB device.  If all slots
+ * are busy, return an error.  If not, claim the slot and place it into
+ * the SND_SOC_USB_PREPARED state.  This should be called first before
+ * calling snd_soc_usb_set_session_state or snd_soc_usb_shutdown_session.
+ *
+ * Returns the session id (index) to active_list, negative on error.
+ *
+ */
+int snd_soc_usb_prepare_session(struct snd_soc_usb *usb, int card_idx, int pcm_idx)
+{
+	int i;
+
+	mutex_lock(&ctx_mutex);
+	for (i = 0; i < usb->num_supported_streams; i++) {
+		if (usb->active_list[i].state == SND_SOC_USB_IDLE) {
+			usb->active_list[i].active_card_idx = card_idx;
+			usb->active_list[i].active_pcm_idx = pcm_idx;
+			usb->active_list[i].state = SND_SOC_USB_PREPARED;
+			mutex_unlock(&ctx_mutex);
+			return i;
+		}
+	}
+	mutex_unlock(&ctx_mutex);
+
+	return -EBUSY;
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_prepare_session);
+
+/**
+ * snd_soc_usb_shutdown_session() - Set USB SOC to idle state
+ * @usb: SOC USB device
+ * @session_id: index to active_list
+ *
+ * Place the session specified by session_id into the idle/shutdown state.
+ *
+ */
+int snd_soc_usb_shutdown_session(struct snd_soc_usb *usb, int session_id)
+{
+	return snd_soc_usb_set_session_state(usb, session_id, SND_SOC_USB_IDLE);
+}
+EXPORT_SYMBOL_GPL(snd_soc_usb_shutdown_session);
+
 /**
  * snd_soc_usb_get_components_tag() - Retrieve SOC USB component tag
  * @playback: direction of audio stream
@@ -273,6 +441,13 @@ struct snd_soc_usb *snd_soc_usb_allocate_port(struct snd_soc_component *componen
 	if (!usb)
 		return ERR_PTR(-ENOMEM);
 
+	usb->active_list = kcalloc(num_streams, sizeof(struct snd_soc_usb_session),
+				   GFP_KERNEL);
+	if (!usb->active_list) {
+		kfree(usb);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	usb->component = component;
 	usb->priv_data = data;
 	usb->num_supported_streams = num_streams;
@@ -291,6 +466,7 @@ EXPORT_SYMBOL_GPL(snd_soc_usb_allocate_port);
 void snd_soc_usb_free_port(struct snd_soc_usb *usb)
 {
 	snd_soc_usb_remove_port(usb);
+	kfree(usb->active_list);
 	kfree(usb);
 }
 EXPORT_SYMBOL_GPL(snd_soc_usb_free_port);

