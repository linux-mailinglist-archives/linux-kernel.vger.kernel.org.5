Return-Path: <linux-kernel+bounces-103873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4EF87C62F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E43B20EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF7B29427;
	Thu, 14 Mar 2024 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="HTDF2yKR"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA26A10798;
	Thu, 14 Mar 2024 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458589; cv=none; b=HemKLUbY76OLtZGL0vYibVRcE+aaWgEojF5IAvTXptyyWLq3hZqnvFB0Y0cLdAEOZpXWJIIhZ5pnki22/uoSD419nrI7wQMuDofy4wnf2DOTAZtCeZqld7fmDBMB6Zc8zPg/4YR4PpJRyMdkiyySiQCrmQjlg5dzOr/3Tuhd73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458589; c=relaxed/simple;
	bh=PK0t+T/l81LlFYozsaioZe1mA2+TBLCBftSXJcoXLeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIl+hzlPFWy6yZeTkpHL7K8Pnrwmz8ilngKz8224CVWNthoxJ1IgFdJAI2ckRmFv4wuXEadNL3E7XQBUuCMUXtqVF0b7n5rAhCTpwhAh+9G2UcwXrwj07IKKZVeQBFyHsKmoL9y/PdExp/u+c8eztuUmQM4Mtv2L9wWAR9xJRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=HTDF2yKR; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D902B12000D;
	Fri, 15 Mar 2024 02:23:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D902B12000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710458583;
	bh=/nEginKlyNB8n+NrSQ852rUKN1nYJC2wotBJJbFUhDc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=HTDF2yKRIJoY/MPUM8mEFhZO7KUp6f8pHP7mH2XYXGWwe9am0x56ayaWfuBvFTNrg
	 rFY/eYikMk2+QCBoxnBe49hvmXqkt+NGzhCLkD6Zi0aN3F0TuZJNdRc8HPdKTWoK0y
	 2QTdWA2aPXTrHseHtZYQ7BuD7WF3YbnHrbWt2S0VyC58Xq3OBS+r0W8wxnRmqxfp8g
	 6lglp46qmF11n97hQ+7MqMoMMBLhvn68uJ3qUwFVC5clcqZodAb3jAnuakJs3mp8my
	 QQZ5Dk+Dj7qR0jqKA1YIMebtBOEF6vSW1xa5XRyOnON0r0Jmjf4Nlvh4P/Cjz8pg91
	 9iTDnhnbVVdaQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 15 Mar 2024 02:23:03 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Mar 2024 02:23:03 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>
CC: <kernel@salutedevices.com>
Subject: [PATCH 09/25] ASoC: meson: g12a-toacodec: add support for A1 SoC family
Date: Fri, 15 Mar 2024 02:21:45 +0300
Message-ID: <20240314232201.2102178-10-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped

Internal codec on A1 SoC has ADC and this commit adds support for
capturing from it.

Also, regmap now uses caching for all platforms. Values that are written
to toacodec's register on A1 SoC can not be read back, that breaks
regmap_update_bits() functionality. Let's hope the caching will not
break anything on other platforms.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 sound/soc/meson/g12a-toacodec.c | 221 ++++++++++++++++++++++++++++++--
 1 file changed, 208 insertions(+), 13 deletions(-)

diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
index 325cf420fd69..21e569e72157 100644
--- a/sound/soc/meson/g12a-toacodec.c
+++ b/sound/soc/meson/g12a-toacodec.c
@@ -50,6 +50,23 @@
 #define CTRL0_BCLK_SEL_SM1_MSB		6
 #define CTRL0_BCLK_SEL_SM1_LSB		4
 
+/* A1 bits */
+#define CTRL0_DAT_CAPTURE_SEL_A1_MSB	23
+#define CTRL0_DAT_CAPTURE_SEL_A1_LSB	23
+#define CTRL0_LANE_CAPTURE_SEL_A1_MSB	22
+#define CTRL0_LANE_CAPTURE_SEL_A1_LSB	20
+#define CTRL0_DAT_SEL_A1_MSB		19
+#define CTRL0_DAT_SEL_A1_LSB		19
+#define CTRL0_LANE_SEL_A1_MSB		18
+#define CTRL0_LANE_SEL_A1_LSB		16
+#define CTRL0_LRCLK_SEL_A1_MSB		14
+#define CTRL0_LRCLK_SEL_A1_LSB		12
+#define CTRL0_LRCLK_INV_A1		BIT(10)
+#define CTRL0_BLK_CAP_INV_A1		BIT(9)
+#define CTRL0_BCLK_O_INV_A1		BIT(8)
+#define CTRL0_BCLK_SEL_A1_MSB		6
+#define CTRL0_BCLK_SEL_A1_LSB		4
+
 #define TOACODEC_OUT_CHMAX		2
 
 struct g12a_toacodec {
@@ -60,6 +77,8 @@ struct g12a_toacodec {
 
 struct g12a_toacodec_match_data {
 	const struct snd_soc_component_driver *component_drv;
+	struct snd_soc_dai_driver *dai_drv;
+	int num_dai_drv;
 	struct reg_field field_dat_sel;
 	struct reg_field field_lrclk_sel;
 	struct reg_field field_bclk_sel;
@@ -69,6 +88,10 @@ static const char * const g12a_toacodec_mux_texts[] = {
 	"I2S A", "I2S B", "I2S C",
 };
 
+static const char * const a1_toacodec_mux_texts[] = {
+	"I2S A", "I2S B",
+};
+
 static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
@@ -124,8 +147,12 @@ static SOC_ENUM_SINGLE_DECL(sm1_toacodec_mux_enum, TOACODEC_CTRL0,
 			    CTRL0_DAT_SEL_SM1_LSB,
 			    g12a_toacodec_mux_texts);
 
-static const struct snd_kcontrol_new g12a_toacodec_mux =
-	SOC_DAPM_ENUM_EXT("Source", g12a_toacodec_mux_enum,
+static SOC_ENUM_SINGLE_DECL(a1_toacodec_mux_enum, TOACODEC_CTRL0,
+			    CTRL0_DAT_SEL_A1_LSB,
+			    a1_toacodec_mux_texts);
+
+static const struct snd_kcontrol_new a1_toacodec_mux =
+	SOC_DAPM_ENUM_EXT("Source", a1_toacodec_mux_enum,
 			  snd_soc_dapm_get_enum_double,
 			  g12a_toacodec_mux_put_enum);
 
@@ -134,10 +161,21 @@ static const struct snd_kcontrol_new sm1_toacodec_mux =
 			  snd_soc_dapm_get_enum_double,
 			  g12a_toacodec_mux_put_enum);
 
+static const struct snd_kcontrol_new g12a_toacodec_mux =
+	SOC_DAPM_ENUM_EXT("Source", g12a_toacodec_mux_enum,
+			  snd_soc_dapm_get_enum_double,
+			  g12a_toacodec_mux_put_enum);
+
 static const struct snd_kcontrol_new g12a_toacodec_out_enable =
 	SOC_DAPM_SINGLE_AUTODISABLE("Switch", TOACODEC_CTRL0,
 				    CTRL0_ENABLE_SHIFT, 1, 0);
 
+/* Don't use AUTODISABLE unlike G12A. On A1 it causes noise after playback
+ * is stopped.
+ */
+static const struct snd_kcontrol_new a1_toacodec_enable =
+	SOC_DAPM_SINGLE("Switch", TOACODEC_CTRL0, CTRL0_ENABLE_SHIFT, 1, 0);
+
 static const struct snd_soc_dapm_widget g12a_toacodec_widgets[] = {
 	SND_SOC_DAPM_MUX("SRC", SND_SOC_NOPM, 0, 0,
 			 &g12a_toacodec_mux),
@@ -152,19 +190,34 @@ static const struct snd_soc_dapm_widget sm1_toacodec_widgets[] = {
 			    &g12a_toacodec_out_enable),
 };
 
-static int g12a_toacodec_input_hw_params(struct snd_pcm_substream *substream,
-					 struct snd_pcm_hw_params *params,
-					 struct snd_soc_dai *dai)
+static const struct snd_soc_dapm_widget a1_toacodec_widgets[] = {
+	SND_SOC_DAPM_SWITCH("EN", SND_SOC_NOPM, 0, 0,
+			    &a1_toacodec_enable),
+	SND_SOC_DAPM_MUX("Playback SRC", SND_SOC_NOPM, 0, 0,
+			 &a1_toacodec_mux),
+	SND_SOC_DAPM_MUX("Capture SRC A", SND_SOC_NOPM, 0, 0,
+			 &a1_toacodec_mux),
+	SND_SOC_DAPM_MUX("Capture SRC B", SND_SOC_NOPM, 0, 0,
+			 &a1_toacodec_mux),
+};
+
+static int g12a_toacodec_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params,
+				   struct snd_soc_dai *dai,
+				   bool playback)
 {
 	struct meson_codec_glue_input *data;
 	int ret;
 
-	ret = meson_codec_glue_input_hw_params(substream, params, dai);
+	ret = playback ? meson_codec_glue_input_hw_params(substream, params, dai)
+		       : meson_codec_glue_capture_output_hw_params(substream,
+								   params, dai);
 	if (ret)
 		return ret;
 
 	/* The glue will provide 1 lane out of the 4 to the output */
-	data = meson_codec_glue_input_get_data(dai);
+	data = playback ? meson_codec_glue_input_get_data(dai)
+			: meson_codec_glue_capture_output_get_data(dai);
 	data->params.channels_min = min_t(unsigned int, TOACODEC_OUT_CHMAX,
 					data->params.channels_min);
 	data->params.channels_max = min_t(unsigned int, TOACODEC_OUT_CHMAX,
@@ -173,6 +226,21 @@ static int g12a_toacodec_input_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int g12a_toacodec_input_hw_params(struct snd_pcm_substream *substream,
+					 struct snd_pcm_hw_params *params,
+					 struct snd_soc_dai *dai)
+{
+	return g12a_toacodec_hw_params(substream, params, dai, true);
+}
+
+static int
+g12a_toacodec_capture_output_hw_params(struct snd_pcm_substream *substream,
+				       struct snd_pcm_hw_params *params,
+				       struct snd_soc_dai *dai)
+{
+	return g12a_toacodec_hw_params(substream, params, dai, false);
+}
+
 static const struct snd_soc_dai_ops g12a_toacodec_input_ops = {
 	.probe		= meson_codec_glue_input_dai_probe,
 	.remove		= meson_codec_glue_input_dai_remove,
@@ -184,6 +252,17 @@ static const struct snd_soc_dai_ops g12a_toacodec_output_ops = {
 	.startup	= meson_codec_glue_output_startup,
 };
 
+static const struct snd_soc_dai_ops g12a_toacodec_capture_output_ops = {
+	.probe		= meson_codec_glue_capture_output_dai_probe,
+	.remove		= meson_codec_glue_capture_output_dai_remove,
+	.hw_params	= g12a_toacodec_capture_output_hw_params,
+	.set_fmt	= meson_codec_glue_capture_output_set_fmt,
+};
+
+static const struct snd_soc_dai_ops g12a_toacodec_capture_input_ops = {
+	.startup	= meson_codec_glue_capture_input_startup,
+};
+
 #define TOACODEC_STREAM(xname, xsuffix, xchmax)			\
 {								\
 	.stream_name	= xname " " xsuffix,			\
@@ -208,6 +287,20 @@ static const struct snd_soc_dai_ops g12a_toacodec_output_ops = {
 	.ops = &g12a_toacodec_output_ops,				\
 }
 
+#define TOACODEC_CAPTURE_INPUT(xname, xid) {				\
+	.name = xname,							\
+	.id = (xid),							\
+	.playback = TOACODEC_STREAM(xname, "Playback", 2),		\
+	.ops = &g12a_toacodec_capture_input_ops,			\
+}
+
+#define TOACODEC_CAPTURE_OUTPUT(xname, xid) {				\
+	.name = xname,							\
+	.id = (xid),							\
+	.capture = TOACODEC_STREAM(xname, "Capture", 2),		\
+	.ops = &g12a_toacodec_capture_output_ops,			\
+}
+
 static struct snd_soc_dai_driver g12a_toacodec_dai_drv[] = {
 	TOACODEC_INPUT("IN A", TOACODEC_IN_A),
 	TOACODEC_INPUT("IN B", TOACODEC_IN_B),
@@ -215,6 +308,16 @@ static struct snd_soc_dai_driver g12a_toacodec_dai_drv[] = {
 	TOACODEC_OUTPUT("OUT", TOACODEC_OUT),
 };
 
+static struct snd_soc_dai_driver a1_toacodec_dai_drv[] = {
+	TOACODEC_INPUT("IN A", TOACODEC_IN_A),
+	TOACODEC_INPUT("IN B", TOACODEC_IN_B),
+	TOACODEC_OUTPUT("OUT", TOACODEC_OUT),
+
+	TOACODEC_CAPTURE_OUTPUT("OUT A", TOACODEC_CAPTURE_OUT_A),
+	TOACODEC_CAPTURE_OUTPUT("OUT B", TOACODEC_CAPTURE_OUT_B),
+	TOACODEC_CAPTURE_INPUT("IN", TOACODEC_CAPTURE_IN),
+};
+
 static int g12a_toacodec_component_probe(struct snd_soc_component *c)
 {
 	/* Initialize the static clock parameters */
@@ -229,6 +332,32 @@ static int sm1_toacodec_component_probe(struct snd_soc_component *c)
 				       CTRL0_BLK_CAP_INV_SM1);
 }
 
+static int a1_toacodec_component_probe(struct snd_soc_component *c)
+{
+	/* Initialize the static clock parameters */
+	return snd_soc_component_write(c, TOACODEC_CTRL0,
+				       CTRL0_BLK_CAP_INV_A1);
+}
+
+static int a1_toacodec_of_xlate_dai_name(struct snd_soc_component *component,
+					 const struct of_phandle_args *args,
+					 const char **dai_name)
+{
+	struct snd_soc_dai *dai;
+
+	if (args->args_count != 1)
+		return -EINVAL;
+
+	for_each_component_dais(component, dai) {
+		if (dai->id == args->args[0]) {
+			*dai_name = dai->driver->name;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static const struct snd_soc_dapm_route g12a_toacodec_routes[] = {
 	{ "SRC", "I2S A", "IN A Playback" },
 	{ "SRC", "I2S B", "IN B Playback" },
@@ -237,6 +366,19 @@ static const struct snd_soc_dapm_route g12a_toacodec_routes[] = {
 	{ "OUT Capture", NULL, "OUT EN" },
 };
 
+static const struct snd_soc_dapm_route a1_toacodec_routes[] = {
+	{ "Playback SRC", "I2S A", "IN A Playback" },
+	{ "Playback SRC", "I2S B", "IN B Playback" },
+	{ "EN", "Switch", "Playback SRC" },
+	{ "OUT Capture", NULL, "Playback SRC" },
+
+	{ "EN", "Switch", "IN Playback" },
+	{ "Capture SRC A", "I2S A", "EN" },
+	{ "Capture SRC B", "I2S B", "EN" },
+	{ "OUT A Capture", NULL, "Capture SRC A" },
+	{ "OUT B Capture", NULL, "Capture SRC B" },
+};
+
 static const struct snd_kcontrol_new g12a_toacodec_controls[] = {
 	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_G12A_LSB,
 		   CTRL0_LANE_SEL_G12A_MSB - CTRL0_LANE_SEL_G12A_LSB + 1, 0),
@@ -247,6 +389,11 @@ static const struct snd_kcontrol_new sm1_toacodec_controls[] = {
 		   CTRL0_LANE_SEL_SM1_MSB - CTRL0_LANE_SEL_SM1_LSB + 1, 0),
 };
 
+static const struct snd_kcontrol_new a1_toacodec_controls[] = {
+	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_A1_LSB,
+		   CTRL0_LANE_SEL_A1_MSB - CTRL0_LANE_SEL_A1_LSB + 1, 0),
+};
+
 static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
 	.probe			= g12a_toacodec_component_probe,
 	.controls		= g12a_toacodec_controls,
@@ -269,14 +416,44 @@ static const struct snd_soc_component_driver sm1_toacodec_component_drv = {
 	.endianness		= 1,
 };
 
+static const struct snd_soc_component_driver a1_toacodec_component_drv = {
+	.probe			= a1_toacodec_component_probe,
+	.of_xlate_dai_name	= a1_toacodec_of_xlate_dai_name,
+	.controls		= a1_toacodec_controls,
+	.num_controls		= ARRAY_SIZE(a1_toacodec_controls),
+	.dapm_widgets		= a1_toacodec_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(a1_toacodec_widgets),
+	.dapm_routes		= a1_toacodec_routes,
+	.num_dapm_routes	= ARRAY_SIZE(a1_toacodec_routes),
+	.endianness		= 1,
+};
+
+static const struct reg_default g12a_toacodec_reg_default[] = {
+	{ TOACODEC_CTRL0, 0x0 },
+};
+
+static bool g12_toacodec_readable_reg(struct device *dev, unsigned int reg)
+{
+	/* There are no readable registers */
+	return false;
+}
+
 static const struct regmap_config g12a_toacodec_regmap_cfg = {
-	.reg_bits	= 32,
-	.val_bits	= 32,
-	.reg_stride	= 4,
+	.reg_bits		= 32,
+	.val_bits		= 32,
+	.reg_stride		= 4,
+	.max_register		= TOACODEC_CTRL0,
+	.max_register_is_0	= true,
+	.cache_type		= REGCACHE_FLAT,
+	.reg_defaults		= g12a_toacodec_reg_default,
+	.num_reg_defaults	= ARRAY_SIZE(g12a_toacodec_reg_default),
+	.readable_reg		= g12_toacodec_readable_reg,
 };
 
 static const struct g12a_toacodec_match_data g12a_toacodec_match_data = {
 	.component_drv	= &g12a_toacodec_component_drv,
+	.dai_drv	= g12a_toacodec_dai_drv,
+	.num_dai_drv	= ARRAY_SIZE(g12a_toacodec_dai_drv),
 	.field_dat_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_DAT_SEL_G12A_LSB,
 				    CTRL0_DAT_SEL_G12A_MSB),
 	.field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, CTRL0_LRCLK_SEL_G12A_LSB,
@@ -287,6 +464,8 @@ static const struct g12a_toacodec_match_data g12a_toacodec_match_data = {
 
 static const struct g12a_toacodec_match_data sm1_toacodec_match_data = {
 	.component_drv	= &sm1_toacodec_component_drv,
+	.dai_drv	= g12a_toacodec_dai_drv,
+	.num_dai_drv	= ARRAY_SIZE(g12a_toacodec_dai_drv),
 	.field_dat_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_DAT_SEL_SM1_LSB,
 				    CTRL0_DAT_SEL_SM1_MSB),
 	.field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, CTRL0_LRCLK_SEL_SM1_LSB,
@@ -295,6 +474,18 @@ static const struct g12a_toacodec_match_data sm1_toacodec_match_data = {
 				    CTRL0_BCLK_SEL_SM1_MSB),
 };
 
+static const struct g12a_toacodec_match_data a1_toacodec_match_data = {
+	.component_drv	= &a1_toacodec_component_drv,
+	.dai_drv	= a1_toacodec_dai_drv,
+	.num_dai_drv	= ARRAY_SIZE(a1_toacodec_dai_drv),
+	.field_dat_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_DAT_SEL_A1_LSB,
+				    CTRL0_DAT_SEL_A1_MSB),
+	.field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, CTRL0_LRCLK_SEL_A1_LSB,
+				     CTRL0_LRCLK_SEL_A1_MSB),
+	.field_bclk_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_BCLK_SEL_A1_LSB,
+				    CTRL0_BCLK_SEL_A1_MSB),
+};
+
 static const struct of_device_id g12a_toacodec_of_match[] = {
 	{
 		.compatible = "amlogic,g12a-toacodec",
@@ -304,6 +495,10 @@ static const struct of_device_id g12a_toacodec_of_match[] = {
 		.compatible = "amlogic,sm1-toacodec",
 		.data = &sm1_toacodec_match_data,
 	},
+	{
+		.compatible = "amlogic,a1-toacodec",
+		.data = &a1_toacodec_match_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, g12a_toacodec_of_match);
@@ -356,9 +551,9 @@ static int g12a_toacodec_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->field_bclk_sel))
 		return PTR_ERR(priv->field_bclk_sel);
 
-	return devm_snd_soc_register_component(dev,
-			data->component_drv, g12a_toacodec_dai_drv,
-			ARRAY_SIZE(g12a_toacodec_dai_drv));
+	return devm_snd_soc_register_component(dev, data->component_drv,
+					       data->dai_drv,
+					       data->num_dai_drv);
 }
 
 static struct platform_driver g12a_toacodec_pdrv = {
-- 
2.34.1


