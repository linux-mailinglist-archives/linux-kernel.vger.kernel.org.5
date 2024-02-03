Return-Path: <linux-kernel+bounces-50867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3408C847F90
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575791C21EDB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF48C5675D;
	Sat,  3 Feb 2024 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="isQX4EdQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C847F60;
	Sat,  3 Feb 2024 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706927885; cv=none; b=SFZGK1YQXK1Gy+VlK2kEJKg7JqZUOSroQLe3V92yq7y3QfuByWvEfCD2/vBNQGqCYmTKmS8o0j99MJ7CZya9gW5eK3FNC4Au1rypjhWQujynho7NbHAUCw8DGo1t23yJ2Xiq+wHHlgg8h+1LMoQsZtI5OJQKoQCk5nC+iGPaD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706927885; c=relaxed/simple;
	bh=RtmQaj8NkOIBrQYRKvHrCqtxnDMndM5jafzZvCboeCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5gqGD/X7OQ4weOsjMkwzFzJV+SksKdeWJWcYsch7KwbeH3QxIdrOUxH5Loqn0JalsHE37IpPWYkwLS7pcqKDDisCMbNAjUBecmeIlvvX41pad5ylOaZrrRcOwDIqsuSAsmlCh8cVtThW/cfEJGVn4xLQxoifffo033mQhUCy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=isQX4EdQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4132a8Nr018011;
	Sat, 3 Feb 2024 02:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=TP9fyOwkywtfaOI9LqRo
	kjI/c6lBCTPIOkl0CcpX2Ew=; b=isQX4EdQelDPQ7alOct6weMX024jS+vYful3
	Q3dyldUf9jPyvw5IeWHYT8uXxeLjpRrhEfwnAW0PTcdJFQ5d7pksQmx7T5wE5J8X
	JhSpc+PxAKT3UUrhm0p4p5gpp9p54XQew+NEbEPZY1h2y8LJ2pxJkvVHmCJh1yWm
	k1IU3kXt0wq2GGeYnc5rYyYbcPM2o2fbtwklcAxfnzBTrC3hRd+y4QCQf7EnT+Yn
	JTB2gKxP4prHUPlLbSh+uEXl2Tb1P3Cj2AKOYK0K8ihXZRyNYfflEMb0oMFKxD2m
	MAIpY6wgku8YWqmR1hPWZzjt/6DYm5uBfXzRyZQL2ytpNpbnng==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1ctq003g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Feb 2024 02:37:47 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4132bUgG003595
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
Subject: [PATCH v13 44/53] ASoC: qcom: qdsp6: Add PCM ops to track current state
Date: Fri, 2 Feb 2024 18:36:36 -0800
Message-ID: <20240203023645.31105-45-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: jEG0LTjSOyb_Eo9SVCVaTNoOKDKRfM-c
X-Proofpoint-GUID: jEG0LTjSOyb_Eo9SVCVaTNoOKDKRfM-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402030015

Register PCM callbacks so that the Q6USB DPCM backend dai link can track
and update the status of the PCM device.  Utilize the SOC USB state APIs to
ensure that the SND kcontrol for the offload status is updated properly.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6usb.c | 52 +++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index 61d30303a7bb..84543b34f2b7 100644
--- a/sound/soc/qcom/qdsp6/q6usb.c
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -30,6 +30,9 @@
 struct q6usb_status {
 	struct snd_soc_usb_device *sdev;
 	unsigned int pcm_index;
+	bool prepared;
+	bool running;
+	int session_id;
 };
 
 struct q6usb_port_data {
@@ -81,14 +84,48 @@ static int q6usb_hw_params(struct snd_pcm_substream *substream,
 		goto out;
 
 	data->status[data->sel_card_idx].pcm_index = data->sel_pcm_idx;
+	data->status[data->sel_card_idx].prepared = true;
+	data->status[data->sel_card_idx].session_id =
+		snd_soc_usb_prepare_session(data->usb, data->sel_card_idx,
+						data->sel_pcm_idx);
 out:
 	mutex_unlock(&data->mutex);
 
 	return ret;
 }
 
+static int q6usb_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct q6usb_port_data *data = dev_get_drvdata(dai->dev);
+
+	mutex_lock(&data->mutex);
+	data->status[data->sel_card_idx].running = true;
+	snd_soc_usb_set_session_state(data->usb,
+			data->status[data->sel_card_idx].session_id,
+			SND_SOC_USB_RUNNING);
+	mutex_unlock(&data->mutex);
+
+	return 0;
+}
+
+static void q6usb_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct q6usb_port_data *data = dev_get_drvdata(dai->dev);
+
+	mutex_lock(&data->mutex);
+	data->status[data->sel_card_idx].running = false;
+	data->status[data->sel_card_idx].prepared = false;
+	snd_soc_usb_shutdown_session(data->usb,
+			data->status[data->sel_card_idx].session_id);
+	mutex_unlock(&data->mutex);
+}
+
 static const struct snd_soc_dai_ops q6usb_ops = {
 	.hw_params = q6usb_hw_params,
+	.prepare = q6usb_prepare,
+	.shutdown = q6usb_shutdown,
 };
 
 static struct snd_soc_dai_driver q6usb_be_dais[] = {
@@ -149,10 +186,15 @@ static int q6usb_put_offload_dev(struct snd_kcontrol *kcontrol,
 	int pcmidx;
 	int cardidx;
 
+	mutex_lock(&data->mutex);
+
+	/* Don't allow changes to the offloading devices if session is busy */
+	if (data->sel_card_idx >= 0 && data->status[data->sel_card_idx].prepared)
+		goto out;
+
 	cardidx = ucontrol->value.integer.value[0];
 	pcmidx = ucontrol->value.integer.value[1];
 
-	mutex_lock(&data->mutex);
 	if ((cardidx >= 0 && test_bit(cardidx, &data->available_card_slot))) {
 		data->sel_card_idx = cardidx;
 		changed = 1;
@@ -203,8 +245,12 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb,
 
 	mutex_lock(&data->mutex);
 	if (connected) {
-		/* We only track the latest USB headset plugged in */
-		if (!data->idx_valid) {
+		/*
+		 * Update the latest USB headset plugged in, if session is
+		 * idle.
+		 */
+		if (!data->idx_valid &&
+			!data->status[data->sel_card_idx].prepared) {
 			data->sel_card_idx = sdev->card_idx;
 			data->sel_pcm_idx = 0;
 		}

