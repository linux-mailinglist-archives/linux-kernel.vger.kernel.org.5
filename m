Return-Path: <linux-kernel+bounces-103872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA7287C61D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34E71F22093
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A46219F3;
	Thu, 14 Mar 2024 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="QhXDvEmL"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773E2101DA;
	Thu, 14 Mar 2024 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458588; cv=none; b=RkXg3/M4/r3TNkv2pXWnpOFE6xNKSY8wc2MMpbQ4AaPcZDKLGXOrUhOY7FiU98NiDGME8JtSH1HLBkzS7KTmNgpG3Oi7F7nXVXMm2sIXXjKesBdeapVlQvlG4f3ROZf30RND4yL5C/w7cVJJjt8AIUORD+HDCWYtMMf0nxIO0ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458588; c=relaxed/simple;
	bh=FsNb0LecDwWhW+ShYdEvV5hEarU+koJuSLwJ7xHKTCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpZnfzrd3VeeeC+pMZvnA/dC2PFxwYU4TvVpTAN40Cb50iU5jH+XyhPyAQrzttz+dkKemKjFnpErb4qhHf204M/gPqemuCLZEQcAUGX7vyI/TkPYuF/XtIVymjTkLoErK+zmPZxDCyIN3jF4rhRxRReKgq4QjyHYNMYEVIou5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=QhXDvEmL; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4EF5312000B;
	Fri, 15 Mar 2024 02:23:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4EF5312000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710458582;
	bh=7Ktg/I6qGntShD8ifBiHrTIM9U/dVEP9EA69vHVTqk0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=QhXDvEmL1/rC3e27KMnsCuaES4ctes2HeDvgOWEANyT25X/Lgjp5bMG/lxgRi8XqR
	 gVbS+r1EFmkz7+CJxEoHx2VZ/T8Mg3PcAgh+N56B5lMqQ6BaQnWCKQoSks/oU7v6KU
	 oaNVXzmx8X7CcWzR06MPygdvK4pMg9bmvWC+0PKmJdc0Ye+fidClXX8k4KUfIg4TLl
	 07LvUNCfkXKCepohgLwKW/KXjf7g0qFpg7tZmaQKp1HQbaLSXBWkPGqp1FyLYhpD+0
	 V1755xumzTWyqP0wGJ118Vk2odsWZkg/cIU9rVwrJz+Wvh3O/DOTnP2YEPXdn1Eno7
	 87be5baTtKHAQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 15 Mar 2024 02:23:02 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Mar 2024 02:23:01 +0300
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
Subject: [PATCH 05/25] ASoC: meson: codec-glue: add support for capture stream
Date: Fri, 15 Mar 2024 02:21:41 +0300
Message-ID: <20240314232201.2102178-6-jan.dakinevich@salutedevices.com>
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

---- >8 ----
Hope, I haven't misinterpreted the terminology and codec-glue's behavior
too much.
---- >8 ----

The glue saves stream's private data in front-end dai and then backend
dai can reach them searching backward from sink to source. For capture
stream everything left the same, but searching should be performed from
source to sink.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 sound/soc/meson/meson-codec-glue.c | 174 ++++++++++++++++++++++-------
 sound/soc/meson/meson-codec-glue.h |  23 ++++
 2 files changed, 158 insertions(+), 39 deletions(-)

diff --git a/sound/soc/meson/meson-codec-glue.c b/sound/soc/meson/meson-codec-glue.c
index f8c5643f3cfe..da6d65e58d90 100644
--- a/sound/soc/meson/meson-codec-glue.c
+++ b/sound/soc/meson/meson-codec-glue.c
@@ -11,65 +11,94 @@
 #include "meson-codec-glue.h"
 
 static struct snd_soc_dapm_widget *
-meson_codec_glue_get_input(struct snd_soc_dapm_widget *w)
+meson_codec_glue_get_data_widget(struct snd_soc_dapm_widget *w, bool playback)
 {
 	struct snd_soc_dapm_path *p;
-	struct snd_soc_dapm_widget *in;
-
-	snd_soc_dapm_widget_for_each_source_path(w, p) {
+	struct snd_soc_dapm_widget *node;
+	enum snd_soc_dapm_type id = playback ? snd_soc_dapm_dai_in
+					     : snd_soc_dapm_dai_out;
+	enum snd_soc_dapm_direction dir = playback ? SND_SOC_DAPM_DIR_IN
+						   : SND_SOC_DAPM_DIR_OUT;
+	enum snd_soc_dapm_direction rdir = playback ? SND_SOC_DAPM_DIR_OUT
+						    : SND_SOC_DAPM_DIR_IN;
+
+	snd_soc_dapm_widget_for_each_path(w, rdir, p) {
 		if (!p->connect)
 			continue;
 
 		/* Check that we still are in the same component */
 		if (snd_soc_dapm_to_component(w->dapm) !=
-		    snd_soc_dapm_to_component(p->source->dapm))
+		    snd_soc_dapm_to_component(p->node[dir]->dapm))
 			continue;
 
-		if (p->source->id == snd_soc_dapm_dai_in)
-			return p->source;
+		if (p->node[dir]->id == id)
+			return p->node[dir];
 
-		in = meson_codec_glue_get_input(p->source);
-		if (in)
-			return in;
+		node = meson_codec_glue_get_data_widget(p->node[dir], playback);
+		if (node)
+			return node;
 	}
 
 	return NULL;
 }
 
-static void meson_codec_glue_input_set_data(struct snd_soc_dai *dai,
-					    struct meson_codec_glue_input *data)
+static void meson_codec_glue_set_data(struct snd_soc_dai *dai,
+				      struct meson_codec_glue_input *data,
+				      bool playback)
+{
+	int stream = playback ? SNDRV_PCM_STREAM_PLAYBACK
+			      : SNDRV_PCM_STREAM_CAPTURE;
+
+	snd_soc_dai_dma_data_set(dai, stream, data);
+}
+
+static struct meson_codec_glue_input *
+meson_codec_glue_get_data(struct snd_soc_dai *dai, bool playback)
 {
-	snd_soc_dai_dma_data_set_playback(dai, data);
+	int stream = playback ? SNDRV_PCM_STREAM_PLAYBACK
+			      : SNDRV_PCM_STREAM_CAPTURE;
+
+	return snd_soc_dai_dma_data_get(dai, stream);
 }
 
 struct meson_codec_glue_input *
 meson_codec_glue_input_get_data(struct snd_soc_dai *dai)
 {
-	return snd_soc_dai_dma_data_get_playback(dai);
+	return meson_codec_glue_get_data(dai, true);
 }
 EXPORT_SYMBOL_GPL(meson_codec_glue_input_get_data);
 
+struct meson_codec_glue_input *
+meson_codec_glue_capture_output_get_data(struct snd_soc_dai *dai)
+{
+	return meson_codec_glue_get_data(dai, false);
+}
+EXPORT_SYMBOL_GPL(meson_codec_glue_capture_output_get_data);
+
 static struct meson_codec_glue_input *
-meson_codec_glue_output_get_input_data(struct snd_soc_dapm_widget *w)
+meson_codec_glue_data(struct snd_soc_dapm_widget *w, bool playback)
 {
-	struct snd_soc_dapm_widget *in =
-		meson_codec_glue_get_input(w);
+	struct snd_soc_dapm_widget *node =
+		meson_codec_glue_get_data_widget(w, playback);
 	struct snd_soc_dai *dai;
 
-	if (WARN_ON(!in))
+	if (WARN_ON(!node))
 		return NULL;
 
-	dai = in->priv;
+	dai = node->priv;
 
-	return meson_codec_glue_input_get_data(dai);
+	return meson_codec_glue_get_data(dai, playback);
 }
 
-int meson_codec_glue_input_hw_params(struct snd_pcm_substream *substream,
-				     struct snd_pcm_hw_params *params,
-				     struct snd_soc_dai *dai)
+static int meson_codec_glue_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params,
+				      struct snd_soc_dai *dai,
+				      bool playback)
 {
 	struct meson_codec_glue_input *data =
-		meson_codec_glue_input_get_data(dai);
+		meson_codec_glue_get_data(dai, playback);
+	struct snd_soc_pcm_stream *stream = playback ? &dai->driver->playback
+						     : &dai->driver->capture;
 
 	data->params.rates = snd_pcm_rate_to_rate_bit(params_rate(params));
 	data->params.rate_min = params_rate(params);
@@ -77,32 +106,64 @@ int meson_codec_glue_input_hw_params(struct snd_pcm_substream *substream,
 	data->params.formats = 1ULL << (__force int) params_format(params);
 	data->params.channels_min = params_channels(params);
 	data->params.channels_max = params_channels(params);
-	data->params.sig_bits = dai->driver->playback.sig_bits;
+	data->params.sig_bits = stream->sig_bits;
 
 	return 0;
 }
+
+int meson_codec_glue_input_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params,
+				     struct snd_soc_dai *dai)
+{
+	return meson_codec_glue_hw_params(substream, params, dai, true);
+}
 EXPORT_SYMBOL_GPL(meson_codec_glue_input_hw_params);
 
-int meson_codec_glue_input_set_fmt(struct snd_soc_dai *dai,
-				   unsigned int fmt)
+int meson_codec_glue_capture_output_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params,
+				     struct snd_soc_dai *dai)
+{
+	return meson_codec_glue_hw_params(substream, params, dai, false);
+}
+EXPORT_SYMBOL_GPL(meson_codec_glue_capture_output_hw_params);
+
+static int meson_codec_glue_set_fmt(struct snd_soc_dai *dai,
+				    unsigned int fmt,
+				    bool playback)
 {
 	struct meson_codec_glue_input *data =
-		meson_codec_glue_input_get_data(dai);
+		meson_codec_glue_get_data(dai, playback);
 
 	/* Save the source stream format for the downstream link */
 	data->fmt = fmt;
 	return 0;
 }
+
+int meson_codec_glue_input_set_fmt(struct snd_soc_dai *dai,
+				   unsigned int fmt)
+{
+	return meson_codec_glue_set_fmt(dai, fmt, true);
+}
 EXPORT_SYMBOL_GPL(meson_codec_glue_input_set_fmt);
 
-int meson_codec_glue_output_startup(struct snd_pcm_substream *substream,
-				    struct snd_soc_dai *dai)
+int meson_codec_glue_capture_output_set_fmt(struct snd_soc_dai *dai,
+				    unsigned int fmt)
+{
+	return meson_codec_glue_set_fmt(dai, fmt, false);
+}
+EXPORT_SYMBOL_GPL(meson_codec_glue_capture_output_set_fmt);
+
+static int meson_codec_glue_startup(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai,
+				    bool playback)
 {
+	int stream = playback ? SNDRV_PCM_STREAM_CAPTURE
+			      : SNDRV_PCM_STREAM_PLAYBACK;
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-	struct snd_soc_dapm_widget *w = snd_soc_dai_get_widget_capture(dai);
-	struct meson_codec_glue_input *in_data = meson_codec_glue_output_get_input_data(w);
+	struct snd_soc_dapm_widget *w = snd_soc_dai_get_widget(dai, stream);
+	struct meson_codec_glue_input *data = meson_codec_glue_data(w, playback);
 
-	if (!in_data)
+	if (!data)
 		return -ENODEV;
 
 	if (WARN_ON(!rtd->dai_link->c2c_params)) {
@@ -111,14 +172,27 @@ int meson_codec_glue_output_startup(struct snd_pcm_substream *substream,
 	}
 
 	/* Replace link params with the input params */
-	rtd->dai_link->c2c_params = &in_data->params;
+	rtd->dai_link->c2c_params = &data->params;
 	rtd->dai_link->num_c2c_params = 1;
 
-	return snd_soc_runtime_set_dai_fmt(rtd, in_data->fmt);
+	return snd_soc_runtime_set_dai_fmt(rtd, data->fmt);
+}
+
+int meson_codec_glue_output_startup(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
+{
+	return meson_codec_glue_startup(substream, dai, true);
 }
 EXPORT_SYMBOL_GPL(meson_codec_glue_output_startup);
 
-int meson_codec_glue_input_dai_probe(struct snd_soc_dai *dai)
+int meson_codec_glue_capture_input_startup(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
+{
+	return meson_codec_glue_startup(substream, dai, false);
+}
+EXPORT_SYMBOL_GPL(meson_codec_glue_capture_input_startup);
+
+static int meson_codec_glue_dai_probe(struct snd_soc_dai *dai, bool playback)
 {
 	struct meson_codec_glue_input *data;
 
@@ -126,21 +200,43 @@ int meson_codec_glue_input_dai_probe(struct snd_soc_dai *dai)
 	if (!data)
 		return -ENOMEM;
 
-	meson_codec_glue_input_set_data(dai, data);
+	meson_codec_glue_set_data(dai, data, playback);
 	return 0;
 }
+
+int meson_codec_glue_input_dai_probe(struct snd_soc_dai *dai)
+{
+	return meson_codec_glue_dai_probe(dai, true);
+}
 EXPORT_SYMBOL_GPL(meson_codec_glue_input_dai_probe);
 
-int meson_codec_glue_input_dai_remove(struct snd_soc_dai *dai)
+int meson_codec_glue_capture_output_dai_probe(struct snd_soc_dai *dai)
+{
+	return meson_codec_glue_dai_probe(dai, false);
+}
+EXPORT_SYMBOL_GPL(meson_codec_glue_capture_output_dai_probe);
+
+static int meson_codec_glue_dai_remove(struct snd_soc_dai *dai, bool playback)
 {
 	struct meson_codec_glue_input *data =
-		meson_codec_glue_input_get_data(dai);
+		meson_codec_glue_get_data(dai, playback);
 
 	kfree(data);
 	return 0;
 }
+
+int meson_codec_glue_input_dai_remove(struct snd_soc_dai *dai)
+{
+	return meson_codec_glue_dai_remove(dai, true);
+}
 EXPORT_SYMBOL_GPL(meson_codec_glue_input_dai_remove);
 
+int meson_codec_glue_capture_output_dai_remove(struct snd_soc_dai *dai)
+{
+	return meson_codec_glue_dai_remove(dai, false);
+}
+EXPORT_SYMBOL_GPL(meson_codec_glue_capture_output_dai_remove);
+
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
 MODULE_DESCRIPTION("Amlogic Codec Glue Helpers");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/meson/meson-codec-glue.h b/sound/soc/meson/meson-codec-glue.h
index 07f99446c0c6..75d20aa75638 100644
--- a/sound/soc/meson/meson-codec-glue.h
+++ b/sound/soc/meson/meson-codec-glue.h
@@ -14,6 +14,10 @@ struct meson_codec_glue_input {
 	unsigned int fmt;
 };
 
+/*
+ * Playback stream
+ */
+
 /* Input helpers */
 struct meson_codec_glue_input *
 meson_codec_glue_input_get_data(struct snd_soc_dai *dai);
@@ -29,4 +33,23 @@ int meson_codec_glue_input_dai_remove(struct snd_soc_dai *dai);
 int meson_codec_glue_output_startup(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *dai);
 
+/*
+ * Capture stream
+ */
+
+/* Output helpers */
+struct meson_codec_glue_input *
+meson_codec_glue_capture_output_get_data(struct snd_soc_dai *dai);
+int meson_codec_glue_capture_output_hw_params(struct snd_pcm_substream *substream,
+					      struct snd_pcm_hw_params *params,
+					      struct snd_soc_dai *dai);
+int meson_codec_glue_capture_output_set_fmt(struct snd_soc_dai *dai,
+					    unsigned int fmt);
+int meson_codec_glue_capture_output_dai_probe(struct snd_soc_dai *dai);
+int meson_codec_glue_capture_output_dai_remove(struct snd_soc_dai *dai);
+
+/* Input helpers */
+int meson_codec_glue_capture_input_startup(struct snd_pcm_substream *substream,
+					   struct snd_soc_dai *dai);
+
 #endif /* _MESON_CODEC_GLUE_H */
-- 
2.34.1


