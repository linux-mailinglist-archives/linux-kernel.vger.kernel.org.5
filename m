Return-Path: <linux-kernel+bounces-146358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D788A641B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764F02827F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2697713956A;
	Tue, 16 Apr 2024 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HdAkuOyW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604584FDE;
	Tue, 16 Apr 2024 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249443; cv=none; b=M29ZYN3i2DhgltYziyaH9tjGQwkfRoB+fcYEu6+W3PXZkJbKniqpP1CcEGKiO1/c56owr2RuPseXCVdR43meo4FZ45jOjul6zbvrxQQY675nzjnVUX6GhZXMAUFwbND8uO0JRGpxPcahJ86u/RA1tjr7FqsfNKIVGqiQDGKCeYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249443; c=relaxed/simple;
	bh=0xk+QIjxE2EB0lboGRRdBfc0QrIFZEEoCLzTMDLvFZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAHCOu2xxsC39o3Uf8LttbpCwLNwdFYL4rQS0lwQUVv7BtnVdlph88s2nI3p/PMInve7/tfuG9lLeXUOFPE4GgOqSvx3AjyRO27Jc7oZDSMMrOCOOojCeHfarr7WD6V5BBctdDVz9xZOcd7HTBh0wWMtcHHAda5NKLMZJs1J/YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HdAkuOyW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G1qVqI024703;
	Tue, 16 Apr 2024 06:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=6VMcktPesBFIPv0213oBYigslu7u+KqaXN4VVyX+RZs=; b=Hd
	AkuOyWvquZyIQlWGf+297Ns489ih4HVQW2JSGt6O8AU26+bfsLSNabtwuH5LM605
	J19C44BkYXWXq0HEL83FTGLyq/uqsIeYyN0x0XF9S1KjcQBWl2zaInlmPG/Ey35u
	TJNNtD60CXCN79juSutDrhuaHBbSuGEqds9rjg2Cz6LLWBxAm6FQ1PtBSPtnaxnr
	bAkXAuaYcsvBiuyUTsJ5gh49A0JOYyt5Bm85Knq4/jBpHl+YT8GW0lVSzSEcljh0
	OtVsx4fGTzoSmrfona5590phAdT74e33wVUC+LbL0pjlBcKO6/KK2mNLOI9ETVbM
	u0C7wOR93qcyNgBfChEg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xh7t1smxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 06:37:08 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G6b7UL029339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 06:37:07 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Apr 2024 23:37:02 -0700
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
Subject: [PATCH v2 7/8] ASoC: codecs: wcd937x: add capture dapm widgets
Date: Tue, 16 Apr 2024 12:05:59 +0530
Message-ID: <20240416063600.309747-8-quic_mohs@quicinc.com>
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
X-Proofpoint-ORIG-GUID: tM4-mBeG9UtmK9o7kS12RIBw0CpvMOAb
X-Proofpoint-GUID: tM4-mBeG9UtmK9o7kS12RIBw0CpvMOAb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_04,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160039

From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>

This patch adds required dapm widgets for capture path.

Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
---
 sound/soc/codecs/wcd937x.c | 404 +++++++++++++++++++++++++++++++++++++
 1 file changed, 404 insertions(+)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index a7f41749b5c5..87e571dc4a11 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -915,6 +915,145 @@ static int wcd937x_get_micb_vout_ctl_val(u32 micb_mv)
 	return (micb_mv - 1000) / 50;
 }
 
+static int wcd937x_tx_swr_ctrl(struct snd_soc_dapm_widget *w,
+			       struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
+	bool use_amic3 = snd_soc_component_read(component, WCD937X_TX_NEW_TX_CH2_SEL) & BIT(7);
+
+	/* Enable BCS for Headset mic */
+	if (event == SND_SOC_DAPM_PRE_PMU && strnstr(w->name, "ADC", sizeof("ADC")))
+		if (w->shift == 1 && !use_amic3)
+			set_bit(AMIC2_BCS_ENABLE, &wcd937x->status_mask);
+
+	return 0;
+}
+
+static int wcd937x_codec_enable_adc(struct snd_soc_dapm_widget *w,
+				    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		atomic_inc(&wcd937x->ana_clk_count);
+		snd_soc_component_update_bits(component,
+					      WCD937X_DIGITAL_CDC_DIG_CLK_CTL, BIT(7), BIT(7));
+		snd_soc_component_update_bits(component,
+					      WCD937X_DIGITAL_CDC_ANA_CLK_CTL, BIT(3), BIT(3));
+		snd_soc_component_update_bits(component,
+					      WCD937X_DIGITAL_CDC_ANA_CLK_CTL, BIT(4), BIT(4));
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (w->shift == 1 && test_bit(AMIC2_BCS_ENABLE, &wcd937x->status_mask))
+			clear_bit(AMIC2_BCS_ENABLE, &wcd937x->status_mask);
+
+		snd_soc_component_update_bits(component,
+					      WCD937X_DIGITAL_CDC_ANA_CLK_CTL, BIT(3), 0x00);
+		break;
+	}
+
+	return 0;
+}
+
+static int wcd937x_enable_req(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_component_update_bits(component,
+					      WCD937X_DIGITAL_CDC_REQ_CTL, BIT(1), BIT(1));
+		snd_soc_component_update_bits(component,
+					      WCD937X_DIGITAL_CDC_REQ_CTL, BIT(0), 0x00);
+		snd_soc_component_update_bits(component,
+					      WCD937X_ANA_TX_CH2, BIT(6), BIT(6));
+		snd_soc_component_update_bits(component,
+					      WCD937X_ANA_TX_CH3_HPF, BIT(6), BIT(6));
+		snd_soc_component_update_bits(component,
+					      WCD937X_DIGITAL_CDC_DIG_CLK_CTL, 0x70, 0x70);
+		snd_soc_component_update_bits(component,
+					      WCD937X_ANA_TX_CH1, BIT(7), BIT(7));
+		snd_soc_component_update_bits(component,
+					      WCD937X_ANA_TX_CH2, BIT(6), 0x00);
+		snd_soc_component_update_bits(component,
+					      WCD937X_ANA_TX_CH2, BIT(7), BIT(7));
+		snd_soc_component_update_bits(component,
+					      WCD937X_ANA_TX_CH3, BIT(7), BIT(7));
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_component_update_bits(component,
+					      WCD937X_ANA_TX_CH1, BIT(7), 0x00);
+		snd_soc_component_update_bits(component,
+					      WCD937X_ANA_TX_CH2, BIT(7), 0x00);
+		snd_soc_component_update_bits(component,
+					      WCD937X_ANA_TX_CH3, BIT(7), 0x00);
+		snd_soc_component_update_bits(component,
+					      WCD937X_DIGITAL_CDC_DIG_CLK_CTL, BIT(4), 0x00);
+
+		atomic_dec(&wcd937x->ana_clk_count);
+		if (atomic_read(&wcd937x->ana_clk_count) <= 0) {
+			snd_soc_component_update_bits(component,
+						      WCD937X_DIGITAL_CDC_ANA_CLK_CTL,
+						      BIT(4), 0x00);
+			atomic_set(&wcd937x->ana_clk_count, 0);
+		}
+
+		snd_soc_component_update_bits(component,
+					      WCD937X_DIGITAL_CDC_DIG_CLK_CTL,
+					      BIT(7), 0x00);
+		break;
+	}
+
+	return 0;
+}
+
+static int wcd937x_codec_enable_dmic(struct snd_soc_dapm_widget *w,
+				     struct snd_kcontrol *kcontrol,
+				     int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	u16 dmic_clk_reg;
+
+	switch (w->shift) {
+	case 0:
+	case 1:
+		dmic_clk_reg = WCD937X_DIGITAL_CDC_DMIC1_CTL;
+		break;
+	case 2:
+	case 3:
+		dmic_clk_reg = WCD937X_DIGITAL_CDC_DMIC2_CTL;
+		break;
+	case 4:
+	case 5:
+		dmic_clk_reg = WCD937X_DIGITAL_CDC_DMIC3_CTL;
+		break;
+	default:
+		dev_err(component->dev, "Invalid DMIC Selection\n");
+		return -EINVAL;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_component_update_bits(component,
+					      WCD937X_DIGITAL_CDC_DIG_CLK_CTL,
+					      BIT(7), BIT(7));
+		snd_soc_component_update_bits(component,
+					      dmic_clk_reg, 0x07, BIT(1));
+		snd_soc_component_update_bits(component,
+					      dmic_clk_reg, BIT(3), BIT(3));
+		snd_soc_component_update_bits(component,
+					      dmic_clk_reg, 0x70, BIT(5));
+		break;
+	}
+
+	return 0;
+}
+
 static int wcd937x_micbias_control(struct snd_soc_component *component,
 				   int micb_num, int req, bool is_dapm)
 {
@@ -1026,6 +1165,82 @@ static int wcd937x_micbias_control(struct snd_soc_component *component,
 	return 0;
 }
 
+static int __wcd937x_codec_enable_micbias(struct snd_soc_dapm_widget *w,
+					  int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	int micb_num;
+
+	if (strnstr(w->name, "MIC BIAS1", sizeof("MIC BIAS1")))
+		micb_num = MIC_BIAS_1;
+	else if (strnstr(w->name, "MIC BIAS2", sizeof("MIC BIAS2")))
+		micb_num = MIC_BIAS_2;
+	else if (strnstr(w->name, "MIC BIAS3", sizeof("MIC BIAS3")))
+		micb_num = MIC_BIAS_3;
+	else
+		return -EINVAL;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		wcd937x_micbias_control(component, micb_num,
+					MICB_ENABLE, true);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		usleep_range(1000, 1100);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		wcd937x_micbias_control(component, micb_num,
+					MICB_DISABLE, true);
+		break;
+	}
+
+	return 0;
+}
+
+static int wcd937x_codec_enable_micbias(struct snd_soc_dapm_widget *w,
+					struct snd_kcontrol *kcontrol,
+					int event)
+{
+	return __wcd937x_codec_enable_micbias(w, event);
+}
+
+static int __wcd937x_codec_enable_micbias_pullup(struct snd_soc_dapm_widget *w,
+						 int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	int micb_num;
+
+	if (strnstr(w->name, "VA MIC BIAS1", sizeof("VA MIC BIAS1")))
+		micb_num = MIC_BIAS_1;
+	else if (strnstr(w->name, "VA MIC BIAS2", sizeof("VA MIC BIAS2")))
+		micb_num = MIC_BIAS_2;
+	else if (strnstr(w->name, "VA MIC BIAS3", sizeof("VA MIC BIAS3")))
+		micb_num = MIC_BIAS_3;
+	else
+		return -EINVAL;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		wcd937x_micbias_control(component, micb_num, MICB_PULLUP_ENABLE, true);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		usleep_range(1000, 1100);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		wcd937x_micbias_control(component, micb_num, MICB_PULLUP_DISABLE, true);
+		break;
+	}
+
+	return 0;
+}
+
+static int wcd937x_codec_enable_micbias_pullup(struct snd_soc_dapm_widget *w,
+					       struct snd_kcontrol *kcontrol,
+					       int event)
+{
+	return __wcd937x_codec_enable_micbias_pullup(w, event);
+}
+
 static int wcd937x_connect_port(struct wcd937x_sdw_priv *wcd, u8 port_idx, u8 ch_id, bool enable)
 {
 	struct sdw_port_config *port_config = &wcd->port_config[port_idx - 1];
@@ -1924,6 +2139,42 @@ static const struct snd_kcontrol_new wcd937x_snd_controls[] = {
 		       wcd937x_get_swr_port, wcd937x_set_swr_port),
 };
 
+static const struct snd_kcontrol_new adc1_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
+};
+
+static const struct snd_kcontrol_new adc2_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
+};
+
+static const struct snd_kcontrol_new adc3_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
+};
+
+static const struct snd_kcontrol_new dmic1_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
+};
+
+static const struct snd_kcontrol_new dmic2_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
+};
+
+static const struct snd_kcontrol_new dmic3_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
+};
+
+static const struct snd_kcontrol_new dmic4_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
+};
+
+static const struct snd_kcontrol_new dmic5_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
+};
+
+static const struct snd_kcontrol_new dmic6_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
+};
+
 static const struct snd_kcontrol_new ear_rdac_switch[] = {
 	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
 };
@@ -1940,22 +2191,76 @@ static const struct snd_kcontrol_new hphr_rdac_switch[] = {
 	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
 };
 
+static const char * const adc2_mux_text[] = {
+	"INP2", "INP3"
+};
+
 static const char * const rdac3_mux_text[] = {
 	"RX1", "RX3"
 };
 
+static const struct soc_enum adc2_enum =
+	SOC_ENUM_SINGLE(WCD937X_TX_NEW_TX_CH2_SEL, 7,
+			ARRAY_SIZE(adc2_mux_text), adc2_mux_text);
+
 static const struct soc_enum rdac3_enum =
 	SOC_ENUM_SINGLE(WCD937X_DIGITAL_CDC_EAR_PATH_CTL, 0,
 			ARRAY_SIZE(rdac3_mux_text), rdac3_mux_text);
 
+static const struct snd_kcontrol_new tx_adc2_mux = SOC_DAPM_ENUM("ADC2 MUX Mux", adc2_enum);
+
 static const struct snd_kcontrol_new rx_rdac3_mux = SOC_DAPM_ENUM("RDAC3_MUX Mux", rdac3_enum);
 
 static const struct snd_soc_dapm_widget wcd937x_dapm_widgets[] = {
 	/* Input widgets */
+	SND_SOC_DAPM_INPUT("AMIC1"),
+	SND_SOC_DAPM_INPUT("AMIC2"),
+	SND_SOC_DAPM_INPUT("AMIC3"),
 	SND_SOC_DAPM_INPUT("IN1_HPHL"),
 	SND_SOC_DAPM_INPUT("IN2_HPHR"),
 	SND_SOC_DAPM_INPUT("IN3_AUX"),
 
+	/* TX widgets */
+	SND_SOC_DAPM_ADC_E("ADC1", NULL, SND_SOC_NOPM, 0, 0,
+			   wcd937x_codec_enable_adc,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("ADC2", NULL, SND_SOC_NOPM, 1, 0,
+			   wcd937x_codec_enable_adc,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MIXER_E("ADC1 REQ", SND_SOC_NOPM, 0, 0,
+			     NULL, 0, wcd937x_enable_req,
+			     SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("ADC2 REQ", SND_SOC_NOPM, 0, 0,
+			     NULL, 0, wcd937x_enable_req,
+			     SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MUX("ADC2 MUX", SND_SOC_NOPM, 0, 0, &tx_adc2_mux),
+
+	/* TX mixers */
+	SND_SOC_DAPM_MIXER_E("ADC1_MIXER", SND_SOC_NOPM, 0, 0,
+			     adc1_switch, ARRAY_SIZE(adc1_switch),
+			     wcd937x_tx_swr_ctrl, SND_SOC_DAPM_PRE_PMU |
+			     SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("ADC2_MIXER", SND_SOC_NOPM, 1, 0,
+			     adc2_switch, ARRAY_SIZE(adc2_switch),
+			     wcd937x_tx_swr_ctrl, SND_SOC_DAPM_PRE_PMU |
+			     SND_SOC_DAPM_POST_PMD),
+
+	/* MIC_BIAS widgets */
+	SND_SOC_DAPM_SUPPLY("MIC BIAS1", SND_SOC_NOPM, 0, 0,
+			    wcd937x_codec_enable_micbias,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			    SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("MIC BIAS2", SND_SOC_NOPM, 0, 0,
+			    wcd937x_codec_enable_micbias,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			    SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("MIC BIAS3", SND_SOC_NOPM, 0, 0,
+			    wcd937x_codec_enable_micbias,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			    SND_SOC_DAPM_POST_PMD),
+
 	SND_SOC_DAPM_SUPPLY("VDD_BUCK", SND_SOC_NOPM, 0, 0,
 			    wcd937x_codec_enable_vdd_buck,
 			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
@@ -2019,11 +2324,101 @@ static const struct snd_soc_dapm_widget wcd937x_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("HPHR_RDAC", SND_SOC_NOPM, 0, 0,
 			   hphr_rdac_switch, ARRAY_SIZE(hphr_rdac_switch)),
 
+	/* TX output widgets */
+	SND_SOC_DAPM_OUTPUT("ADC1_OUTPUT"),
+	SND_SOC_DAPM_OUTPUT("ADC2_OUTPUT"),
+	SND_SOC_DAPM_OUTPUT("ADC3_OUTPUT"),
+	SND_SOC_DAPM_OUTPUT("WCD_TX_OUTPUT"),
+
 	/* RX output widgets */
 	SND_SOC_DAPM_OUTPUT("EAR"),
 	SND_SOC_DAPM_OUTPUT("AUX"),
 	SND_SOC_DAPM_OUTPUT("HPHL"),
 	SND_SOC_DAPM_OUTPUT("HPHR"),
+
+	/* MIC_BIAS pull up widgets */
+	SND_SOC_DAPM_SUPPLY("VA MIC BIAS1", SND_SOC_NOPM, 0, 0,
+			    wcd937x_codec_enable_micbias_pullup,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			    SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("VA MIC BIAS2", SND_SOC_NOPM, 0, 0,
+			    wcd937x_codec_enable_micbias_pullup,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			    SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("VA MIC BIAS3", SND_SOC_NOPM, 0, 0,
+			    wcd937x_codec_enable_micbias_pullup,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			    SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_widget wcd9375_dapm_widgets[] = {
+	/* Input widgets */
+	SND_SOC_DAPM_INPUT("AMIC4"),
+
+	/* TX widgets */
+	SND_SOC_DAPM_ADC_E("ADC3", NULL, SND_SOC_NOPM, 2, 0,
+			   wcd937x_codec_enable_adc,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MIXER_E("ADC3 REQ", SND_SOC_NOPM, 0, 0,
+			     NULL, 0, wcd937x_enable_req,
+			     SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_ADC_E("DMIC1", NULL, SND_SOC_NOPM, 0, 0,
+			   wcd937x_codec_enable_dmic,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("DMIC2", NULL, SND_SOC_NOPM, 1, 0,
+			   wcd937x_codec_enable_dmic,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("DMIC3", NULL, SND_SOC_NOPM, 2, 0,
+			   wcd937x_codec_enable_dmic,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("DMIC4", NULL, SND_SOC_NOPM, 3, 0,
+			   wcd937x_codec_enable_dmic,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("DMIC5", NULL, SND_SOC_NOPM, 4, 0,
+			   wcd937x_codec_enable_dmic,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("DMIC6", NULL, SND_SOC_NOPM, 5, 0,
+			   wcd937x_codec_enable_dmic,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	/* TX mixer widgets */
+	SND_SOC_DAPM_MIXER_E("DMIC1_MIXER", SND_SOC_NOPM, 0,
+			     0, dmic1_switch, ARRAY_SIZE(dmic1_switch),
+			     wcd937x_tx_swr_ctrl, SND_SOC_DAPM_PRE_PMU |
+			     SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("DMIC2_MIXER", SND_SOC_NOPM, 1,
+			     0, dmic2_switch, ARRAY_SIZE(dmic2_switch),
+			     wcd937x_tx_swr_ctrl, SND_SOC_DAPM_PRE_PMU |
+			     SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("DMIC3_MIXER", SND_SOC_NOPM, 2,
+			     0, dmic3_switch, ARRAY_SIZE(dmic3_switch),
+			     wcd937x_tx_swr_ctrl, SND_SOC_DAPM_PRE_PMU |
+			     SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("DMIC4_MIXER", SND_SOC_NOPM, 3,
+			     0, dmic4_switch, ARRAY_SIZE(dmic4_switch),
+			     wcd937x_tx_swr_ctrl, SND_SOC_DAPM_PRE_PMU |
+			     SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("DMIC5_MIXER", SND_SOC_NOPM, 4,
+			     0, dmic5_switch, ARRAY_SIZE(dmic5_switch),
+			     wcd937x_tx_swr_ctrl, SND_SOC_DAPM_PRE_PMU |
+			     SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("DMIC6_MIXER", SND_SOC_NOPM, 5,
+			     0, dmic6_switch, ARRAY_SIZE(dmic6_switch),
+			     wcd937x_tx_swr_ctrl, SND_SOC_DAPM_PRE_PMU |
+			     SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("ADC3_MIXER", SND_SOC_NOPM, 2, 0, adc3_switch,
+			     ARRAY_SIZE(adc3_switch), wcd937x_tx_swr_ctrl,
+			     SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	/* Output widgets */
+	SND_SOC_DAPM_OUTPUT("DMIC1_OUTPUT"),
+	SND_SOC_DAPM_OUTPUT("DMIC2_OUTPUT"),
+	SND_SOC_DAPM_OUTPUT("DMIC3_OUTPUT"),
+	SND_SOC_DAPM_OUTPUT("DMIC4_OUTPUT"),
+	SND_SOC_DAPM_OUTPUT("DMIC5_OUTPUT"),
+	SND_SOC_DAPM_OUTPUT("DMIC6_OUTPUT"),
 };
 
 static int wcd937x_set_micbias_data(struct wcd937x_priv *wcd937x)
@@ -2155,6 +2550,15 @@ static int wcd937x_soc_codec_probe(struct snd_soc_component *component)
 	disable_irq_nosync(wcd937x->hphl_pdm_wd_int);
 	disable_irq_nosync(wcd937x->aux_pdm_wd_int);
 
+	if (wcd937x->chipid == CHIPID_WCD9375) {
+		ret = snd_soc_dapm_new_controls(dapm, wcd9375_dapm_widgets,
+						ARRAY_SIZE(wcd9375_dapm_widgets));
+		if (ret < 0) {
+			dev_err(component->dev, "Failed to add snd_ctls\n");
+			return ret;
+		}
+	}
+
 	ret = wcd937x_mbhc_init(component);
 	if (ret)
 		dev_err(component->dev,  "mbhc initialization failed\n");
-- 
2.25.1


