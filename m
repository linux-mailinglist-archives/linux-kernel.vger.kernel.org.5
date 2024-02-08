Return-Path: <linux-kernel+bounces-58840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88CB84ED7B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA0E1C20E5A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C26960878;
	Thu,  8 Feb 2024 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YJJYtLfv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EAA5026E;
	Thu,  8 Feb 2024 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434090; cv=none; b=FX0ag5bCiZ+Mkn3iq8R04/Lr4NwpydrrhOdUg9SPQizCIzqC9Q7jsJana3SShCGRrYOVMmtSG83ASe4MBwnx5ht4BI+7bjCiv08sAeSAIDtlVzNf5O9DpcNYQBimM7uF4vKYLcxsYJgIk/M32QAkh7JaJDkbSjXzX0EKLqVTKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434090; c=relaxed/simple;
	bh=WD2aYO20Jj6ylAcciZCsjRR8imXLNE0xsGdkB6cKWI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFWugNUtrIS0XfztG7Iri9myeXdFlMcdOdcLSW3EUwyCfVhK8pl9aN5uWkpq8aYBMgqgWvujD0mD8iPDOhdU6kK1l4054B9/6jg1lgZof3v5jl2KFnS9n4wBdBZlux1ky76mOJoDHjQeUDOQOtrpFUkFhH7gHDol68Wp9ygEKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YJJYtLfv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418MslHe009997;
	Thu, 8 Feb 2024 23:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=1wOpcy9jDvAAEHI/K11v
	sFGqT15VfQz1a4+qL0/PTVM=; b=YJJYtLfv6rYecfY1vsi7jy/WfiWHH08mvHeR
	iIuF9dPF80y2AvhQ7ue+WZ/8ORBpgvGWHoCJeeGnXyS7SnRW5XCY517qRU5Nu9SC
	1eVDpCKH9+aYHty5mK35K/XkoXmpkYBAUz/04NipuDhrBNT/t6dCE6ujGIq89D47
	aZzvybMYp6CWSpAekVz2rOAX7TkoF5SbEkVS6H065rjBO6cnTA1ckbWB8qSLvtba
	NJLolKdaKsE5CoLmqbGICGHS9bY8YuZQ2Cr+55S+9G4r3qFXAG3ZBu4bYxBWVY6V
	NAcovEUggrVXFEGxuksIvgZ1AMr9OW6ZfglyCjZiCUMfDIi+QQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4rk82k53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:14:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418NERsv005633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 23:14:27 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 8 Feb 2024 15:14:27 -0800
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
Subject: [PATCH v14 42/53] ASoC: qcom: qdsp6: Add SOC USB offload select get/put callbacks
Date: Thu, 8 Feb 2024 15:13:55 -0800
Message-ID: <20240208231406.27397-43-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: dZtBKbQ_ZcKW5hLsH2PT2b45Okq8DfBj
X-Proofpoint-ORIG-GUID: dZtBKbQ_ZcKW5hLsH2PT2b45Okq8DfBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080131

In order for device selection to be supported, the Q6USB backend DAI link
will need to be notified about the device to start the offloading session
on. Device selection is made possible by setting the Q6AFE device token.
The audio DSP utilizes this parameter, and will pass this field back to
the USB offload driver within the QMI stream requests.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6usb.c | 108 +++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index e539b411c35e..61d30303a7bb 100644
--- a/sound/soc/qcom/qdsp6/q6usb.c
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -36,9 +36,12 @@ struct q6usb_port_data {
 	struct q6afe_usb_cfg usb_cfg;
 	struct snd_soc_usb *usb;
 	struct q6usb_offload priv;
-	int active_usb_chip_idx;
+	struct mutex mutex;
 	unsigned long available_card_slot;
 	struct q6usb_status status[SNDRV_CARDS];
+	bool idx_valid;
+	int sel_card_idx;
+	int sel_pcm_idx;
 };
 
 static const struct snd_soc_dapm_widget q6usb_dai_widgets[] = {
@@ -54,10 +57,34 @@ static int q6usb_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct q6usb_port_data *data = dev_get_drvdata(dai->dev);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct q6afe_port *q6usb_afe;
 	int direction = substream->stream;
+	int chip_idx;
+	int ret;
+
+	mutex_lock(&data->mutex);
+	chip_idx = data->status[data->sel_card_idx].sdev->chip_idx;
+
+	ret = snd_soc_usb_find_format(chip_idx, params, direction);
+	if (ret < 0)
+		goto out;
+
+	q6usb_afe = q6afe_port_get_from_id(cpu_dai->dev, USB_RX);
+	if (IS_ERR(q6usb_afe))
+		goto out;
 
-	return snd_soc_usb_find_format(data->active_usb_chip_idx, params,
-					direction);
+	ret = afe_port_send_usb_dev_param(q6usb_afe, data->sel_card_idx,
+						data->sel_pcm_idx);
+	if (ret < 0)
+		goto out;
+
+	data->status[data->sel_card_idx].pcm_index = data->sel_pcm_idx;
+out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
 }
 
 static const struct snd_soc_dai_ops q6usb_ops = {
@@ -88,6 +115,63 @@ static struct snd_soc_dai_driver q6usb_be_dais[] = {
 	},
 };
 
+static int q6usb_get_offload_dev(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
+	int pcm_idx;
+	int card_idx;
+
+	mutex_lock(&data->mutex);
+
+	if (!data->available_card_slot) {
+		card_idx = -1;
+		pcm_idx = -1;
+	} else {
+		card_idx = data->sel_card_idx;
+		pcm_idx = data->sel_pcm_idx;
+	}
+
+	ucontrol->value.integer.value[0] = card_idx;
+	ucontrol->value.integer.value[1] = pcm_idx;
+	mutex_unlock(&data->mutex);
+
+	return 0;
+}
+
+static int q6usb_put_offload_dev(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
+	int changed = 0;
+	int pcmidx;
+	int cardidx;
+
+	cardidx = ucontrol->value.integer.value[0];
+	pcmidx = ucontrol->value.integer.value[1];
+
+	mutex_lock(&data->mutex);
+	if ((cardidx >= 0 && test_bit(cardidx, &data->available_card_slot))) {
+		data->sel_card_idx = cardidx;
+		changed = 1;
+	}
+
+	if ((pcmidx >= 0 && pcmidx < data->status[cardidx].sdev->num_playback)) {
+		data->sel_pcm_idx = pcmidx;
+		changed = 1;
+	}
+
+	if (changed)
+		data->idx_valid = true;
+
+out:
+	mutex_unlock(&data->mutex);
+
+	return changed;
+}
+
 static int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *component,
 					const struct of_phandle_args *args,
 					const char **dai_name)
@@ -117,16 +201,28 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb,
 
 	data = dev_get_drvdata(usb->component->dev);
 
+	mutex_lock(&data->mutex);
 	if (connected) {
 		/* We only track the latest USB headset plugged in */
-		data->active_usb_chip_idx = sdev->card_idx;
+		if (!data->idx_valid) {
+			data->sel_card_idx = sdev->card_idx;
+			data->sel_pcm_idx = 0;
+		}
 
 		set_bit(sdev->card_idx, &data->available_card_slot);
 		data->status[sdev->card_idx].sdev = sdev;
 	} else {
 		clear_bit(sdev->card_idx, &data->available_card_slot);
 		data->status[sdev->card_idx].sdev = NULL;
+
+		if (data->sel_card_idx == sdev->card_idx) {
+			data->idx_valid = false;
+			data->sel_card_idx = data->available_card_slot ?
+					ffs(data->available_card_slot) - 1 : 0;
+			data->sel_pcm_idx = 0;
+		}
 	}
+	mutex_unlock(&data->mutex);
 
 	return 0;
 }
@@ -142,6 +238,8 @@ static int q6usb_component_probe(struct snd_soc_component *component)
 		return -ENOMEM;
 
 	usb->connection_status_cb = q6usb_alsa_connection_cb;
+	usb->put_offload_dev = q6usb_put_offload_dev;
+	usb->get_offload_dev = q6usb_get_offload_dev;
 
 	ret = snd_soc_usb_add_port(usb);
 	if (ret < 0) {
@@ -205,6 +303,8 @@ static int q6usb_dai_dev_probe(struct platform_device *pdev)
 
 	data->priv.domain = iommu_get_domain_for_dev(&pdev->dev);
 
+	mutex_init(&data->mutex);
+
 	data->priv.dev = dev;
 	dev_set_drvdata(dev, data);
 

