Return-Path: <linux-kernel+bounces-158284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989798B1DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92DF1F23A69
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B312BE86;
	Thu, 25 Apr 2024 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M/UFinRz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061512A153;
	Thu, 25 Apr 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036857; cv=none; b=q5qNLm629BMOLdrJ4WTOH8HG0kebxtc8jsHoTOE6wj4xLv+4W1nQoySE4nyYcsCfp8bnwOqeBScyPqtN+9fgbKL4DeI6XcRwFGe+BS/m/MPILFPS2CJttLH+hWy6cuVkOexgVC0l5L5VKXBiAnO1+g6u3gq66g931mUbWrSd8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036857; c=relaxed/simple;
	bh=7Ab9Uf8rWsSgwirdPGiJH7KCvUWhp4dinFO9fAfD+BQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7V/3ry9OM0vQjY1kVlSZR2tu2V35iJt9s4dhewdI0DymTS7eCOVjf0YSSe+8SBMPign4JGOAvOi54b/Z45vTuu4bOIHXhT681HhGxDGk8r/28xmD5VKRxk+I27Pc7udjCRk9NEhgDpDzeP7/AfmF753l4VXqMSIW+lrtbS0FqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M/UFinRz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P365x2023172;
	Thu, 25 Apr 2024 09:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=SpoAd/Rf2LLZj93edJ+wVrXlxe5EZ1m4zMtuy7cxlxc=; b=M/
	UFinRzHqIljSSY1RyogOjRG6cNHPQwcTSnT2NhkPbgjShA1S4fX4Thvr4PsC3RGm
	1xjshto9QEHFyBeCc0Pt2+snidcZ2o6f3iq6dRBKtmenhZ8jdNjAJjrsXqaNl/d8
	dHP488jLmY+RESclHperMg6OJ7xhfFdKiITOL5XSwIEZqD5ZIblbnEP1rCANRIcT
	NJNTvMglD51FOy/K7b8nhnVDVuVE38zDpup7Tk6YccjOAT+MsDAd/n9p8pajGD9r
	Q47QyrxZHfcBjwJdjzZBqUu4rcd1LEOyAPeaJlAidmTj1mAO2oJ8wTxvvJ+Uxsv1
	gAfqqCVTKqbyst/2pSJA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenghnaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 09:20:42 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43P9KfhC032610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 09:20:41 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 02:20:36 -0700
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
CC: <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <quic_pkumpatl@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v3 7/7] ASoC: codecs: wcd937x: add audio routing and Kconfig
Date: Thu, 25 Apr 2024 14:48:57 +0530
Message-ID: <20240425091857.2161088-8-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425091857.2161088-1-quic_mohs@quicinc.com>
References: <20240425091857.2161088-1-quic_mohs@quicinc.com>
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
X-Proofpoint-GUID: mhBrhs-NEeKb6U0Xq9DNLD4MdHFm830Q
X-Proofpoint-ORIG-GUID: mhBrhs-NEeKb6U0Xq9DNLD4MdHFm830Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_09,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250066

From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>

This patch adds audio routing for both playback and capture and
Makefile and Kconfigs changes for wcd937x.

Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
---
 sound/soc/codecs/Kconfig   | 20 ++++++++++
 sound/soc/codecs/Makefile  |  7 ++++
 sound/soc/codecs/wcd937x.c | 80 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4afc43d3f71f..a6bb5716632d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -278,6 +278,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_UDA1380
 	imply SND_SOC_WCD9335
 	imply SND_SOC_WCD934X
+	imply SND_SOC_WCD937X_SDW
 	imply SND_SOC_WCD938X_SDW
 	imply SND_SOC_WCD939X_SDW
 	imply SND_SOC_LPASS_MACRO_COMMON
@@ -2100,6 +2101,25 @@ config SND_SOC_WCD934X
 	  The WCD9340/9341 is a audio codec IC Integrated in
 	  Qualcomm SoCs like SDM845.
 
+config SND_SOC_WCD937X
+	depends on SND_SOC_WCD937X_SDW
+	tristate
+	depends on SOUNDWIRE || !SOUNDWIRE
+	select SND_SOC_WCD_CLASSH
+
+config SND_SOC_WCD937X_SDW
+	tristate "WCD9370/WCD9375 Codec - SDW"
+	select SND_SOC_WCD937X
+	select SND_SOC_WCD_MBHC
+	select REGMAP_IRQ
+	depends on SOUNDWIRE
+	select REGMAP_SOUNDWIRE
+	help
+	  The WCD9370/9375 is an audio codec IC used with SoCs
+	  like SC7280 or QCM6490 chipsets, and it connected
+	  via soundwire.
+	  To compile this codec driver say Y or m.
+
 config SND_SOC_WCD938X
 	depends on SND_SOC_WCD938X_SDW
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index cddb16cd6a4c..e5ffd2f02e11 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -316,6 +316,8 @@ snd-soc-wcd-classh-objs := wcd-clsh-v2.o
 snd-soc-wcd-mbhc-objs := wcd-mbhc-v2.o
 snd-soc-wcd9335-objs := wcd9335.o
 snd-soc-wcd934x-objs := wcd934x.o
+snd-soc-wcd937x-objs := wcd937x.o
+snd-soc-wcd937x-sdw-objs := wcd937x-sdw.o
 snd-soc-wcd938x-objs := wcd938x.o
 snd-soc-wcd938x-sdw-objs := wcd938x-sdw.o
 snd-soc-wcd939x-objs := wcd939x.o
@@ -710,6 +712,11 @@ obj-$(CONFIG_SND_SOC_WCD_CLASSH)	+= snd-soc-wcd-classh.o
 obj-$(CONFIG_SND_SOC_WCD_MBHC)	+= snd-soc-wcd-mbhc.o
 obj-$(CONFIG_SND_SOC_WCD9335)	+= snd-soc-wcd9335.o
 obj-$(CONFIG_SND_SOC_WCD934X)	+= snd-soc-wcd934x.o
+obj-$(CONFIG_SND_SOC_WCD937X)	+= snd-soc-wcd937x.o
+ifdef CONFIG_SND_SOC_WCD937X_SDW
+# avoid link failure by forcing sdw code built-in when needed
+obj-$(CONFIG_SND_SOC_WCD937X) += snd-soc-wcd937x-sdw.o
+endif
 obj-$(CONFIG_SND_SOC_WCD938X)	+= snd-soc-wcd938x.o
 ifdef CONFIG_SND_SOC_WCD938X_SDW
 # avoid link failure by forcing sdw code built-in when needed
diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 87e571dc4a11..d0795e39e99b 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -2421,6 +2421,77 @@ static const struct snd_soc_dapm_widget wcd9375_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("DMIC6_OUTPUT"),
 };
 
+static const struct snd_soc_dapm_route wcd937x_audio_map[] = {
+	{ "ADC1_OUTPUT", NULL, "ADC1_MIXER" },
+	{ "ADC1_MIXER", "Switch", "ADC1 REQ" },
+	{ "ADC1 REQ", NULL, "ADC1" },
+	{ "ADC1", NULL, "AMIC1" },
+
+	{ "ADC2_OUTPUT", NULL, "ADC2_MIXER" },
+	{ "ADC2_MIXER", "Switch", "ADC2 REQ" },
+	{ "ADC2 REQ", NULL, "ADC2" },
+	{ "ADC2", NULL, "ADC2 MUX" },
+	{ "ADC2 MUX", "INP3", "AMIC3" },
+	{ "ADC2 MUX", "INP2", "AMIC2" },
+
+	{ "IN1_HPHL", NULL, "VDD_BUCK" },
+	{ "IN1_HPHL", NULL, "CLS_H_PORT" },
+	{ "RX1", NULL, "IN1_HPHL" },
+	{ "RDAC1", NULL, "RX1" },
+	{ "HPHL_RDAC", "Switch", "RDAC1" },
+	{ "HPHL PGA", NULL, "HPHL_RDAC" },
+	{ "HPHL", NULL, "HPHL PGA" },
+
+	{ "IN2_HPHR", NULL, "VDD_BUCK" },
+	{ "IN2_HPHR", NULL, "CLS_H_PORT" },
+	{ "RX2", NULL, "IN2_HPHR" },
+	{ "RDAC2", NULL, "RX2" },
+	{ "HPHR_RDAC", "Switch", "RDAC2" },
+	{ "HPHR PGA", NULL, "HPHR_RDAC" },
+	{ "HPHR", NULL, "HPHR PGA" },
+
+	{ "IN3_AUX", NULL, "VDD_BUCK" },
+	{ "IN3_AUX", NULL, "CLS_H_PORT" },
+	{ "RX3", NULL, "IN3_AUX" },
+	{ "RDAC4", NULL, "RX3" },
+	{ "AUX_RDAC", "Switch", "RDAC4" },
+	{ "AUX PGA", NULL, "AUX_RDAC" },
+	{ "AUX", NULL, "AUX PGA" },
+
+	{ "RDAC3_MUX", "RX3", "RX3" },
+	{ "RDAC3_MUX", "RX1", "RX1" },
+	{ "RDAC3", NULL, "RDAC3_MUX" },
+	{ "EAR_RDAC", "Switch", "RDAC3" },
+	{ "EAR PGA", NULL, "EAR_RDAC" },
+	{ "EAR", NULL, "EAR PGA" },
+};
+
+static const struct snd_soc_dapm_route wcd9375_audio_map[] = {
+	{ "ADC3_OUTPUT", NULL, "ADC3_MIXER" },
+	{ "ADC3_OUTPUT", NULL, "ADC3_MIXER" },
+	{ "ADC3_MIXER", "Switch", "ADC3 REQ" },
+	{ "ADC3 REQ", NULL, "ADC3" },
+	{ "ADC3", NULL, "AMIC4" },
+
+	{ "DMIC1_OUTPUT", NULL, "DMIC1_MIXER" },
+	{ "DMIC1_MIXER", "Switch", "DMIC1" },
+
+	{ "DMIC2_OUTPUT", NULL, "DMIC2_MIXER" },
+	{ "DMIC2_MIXER", "Switch", "DMIC2" },
+
+	{ "DMIC3_OUTPUT", NULL, "DMIC3_MIXER" },
+	{ "DMIC3_MIXER", "Switch", "DMIC3" },
+
+	{ "DMIC4_OUTPUT", NULL, "DMIC4_MIXER" },
+	{ "DMIC4_MIXER", "Switch", "DMIC4" },
+
+	{ "DMIC5_OUTPUT", NULL, "DMIC5_MIXER" },
+	{ "DMIC5_MIXER", "Switch", "DMIC5" },
+
+	{ "DMIC6_OUTPUT", NULL, "DMIC6_MIXER" },
+	{ "DMIC6_MIXER", "Switch", "DMIC6" },
+};
+
 static int wcd937x_set_micbias_data(struct wcd937x_priv *wcd937x)
 {
 	int vout_ctl[3];
@@ -2557,6 +2628,13 @@ static int wcd937x_soc_codec_probe(struct snd_soc_component *component)
 			dev_err(component->dev, "Failed to add snd_ctls\n");
 			return ret;
 		}
+
+		ret = snd_soc_dapm_add_routes(dapm, wcd9375_audio_map,
+					      ARRAY_SIZE(wcd9375_audio_map));
+		if (ret < 0) {
+			dev_err(component->dev, "Failed to add routes\n");
+			return ret;
+		}
 	}
 
 	ret = wcd937x_mbhc_init(component);
@@ -2600,6 +2678,8 @@ static const struct snd_soc_component_driver soc_codec_dev_wcd937x = {
 	.num_controls = ARRAY_SIZE(wcd937x_snd_controls),
 	.dapm_widgets = wcd937x_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wcd937x_dapm_widgets),
+	.dapm_routes = wcd937x_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(wcd937x_audio_map),
 	.set_jack = wcd937x_codec_set_jack,
 	.endianness = 1,
 };
-- 
2.25.1


