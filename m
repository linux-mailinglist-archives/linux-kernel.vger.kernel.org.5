Return-Path: <linux-kernel+bounces-136780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B170C89D80F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B8D1C24896
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11FD131BB1;
	Tue,  9 Apr 2024 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="POa3k99V"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D77130A7E;
	Tue,  9 Apr 2024 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662435; cv=none; b=MLq6wNaEXkfi1+x29aPOwQCXP7GqLpC1MxPEK/bJ5w5CEWvZDhzZPWgodDm+33JO67RbSKACYf9YXlR2YNAl9hGdRIaLUY0T4Xe6ygKvsEH+ETtp7jHptZk9Yhj12LGDkgige4gSSFGxrAn0AIrI9EPQBWma5NXBQyzBKiYfWPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662435; c=relaxed/simple;
	bh=7dwcW721xQhnjT05thzylbyuJsM5PYC/qaTz/86b5ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8dLC/l5IgOHLpoDz8xd6JofEI3bu5npPWDzy+bUEzttH2oP2NZ+0AJ/1R7dUuAX933bKm4ogZaqDX48zhpnqu5N18KrqmG3Un8fqeYGCSHIfRFOxZKbjZZPJWCyAhQphqThuopiAUPakVuqI+nGVAfjuhbH1jtZsaObiCceWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=POa3k99V; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712662431;
	bh=7dwcW721xQhnjT05thzylbyuJsM5PYC/qaTz/86b5ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=POa3k99Vn7p8AZTqcrRL6QFEMTQVzOZu9r9uE5ahyTAU3R1IXGc+9csBeN5fgRm7K
	 FGc8jUNFJM8jMLoUHJpSX7ulgiZ1LTcIb6HS/oaqADJnO02OzkMmB3gt1kSWLyeJou
	 UcYxaXohxgZ42tvTwrK5vsymeuy5RupCCR879doMB5cPBFmKl5z42iZTlL9V/2Iufp
	 luXC+hWDGwwskckVLCGVJnTdO5SG039wM1M0NxZQM4PXUgASJ65DXWJsir8YQR2iga
	 o4QpDWZcjZqjmDE8sIW00S1QUuNK36WFART/PBZkojJx4mYG3SwwpGM0sSF7ENJ02/
	 qxpZxpi39teSA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9C2AE37820FD;
	Tue,  9 Apr 2024 11:33:49 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Cc: wenst@chromium.org,
	lgirdwood@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	trevor.wu@mediatek.com,
	maso.huang@mediatek.com,
	xiazhengqiao@huaqin.corp-partner.google.com,
	arnd@arndb.de,
	kuninori.morimoto.gx@renesas.com,
	shraash@google.com,
	amergnat@baylibre.com,
	nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de,
	dianders@chromium.org,
	frank.li@vivo.com,
	allen-kh.cheng@mediatek.com,
	eugen.hristev@collabora.com,
	claudiu.beznea@tuxon.dev,
	jarkko.nikula@bitmer.com,
	jiaxin.yu@mediatek.com,
	alpernebiyasak@gmail.com,
	ckeepax@opensource.cirrus.com,
	zhourui@huaqin.corp-partner.google.com,
	nfraprado@collabora.com,
	alsa-devel@alsa-project.org,
	shane.chien@mediatek.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v4 09/18] ASoC: mediatek: mt8192: Migrate to the common mtk_soundcard_startup
Date: Tue,  9 Apr 2024 13:33:01 +0200
Message-ID: <20240409113310.303261-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409113310.303261-1-angelogioacchino.delregno@collabora.com>
References: <20240409113310.303261-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a const mtk_pcm_constraints_data struct array with all of the
(again, constant) constraints for all of the supported usecases,
remove the duplicated functions and call mtk_soundcard_startup()
instead in all of the .startup() callbacks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 139 ++++++------------
 1 file changed, 41 insertions(+), 98 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index 645bc1aa67c7..5fb34a4834d2 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -389,100 +389,6 @@ static int mt8192_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static int
-mt8192_mt6359_cap1_startup(struct snd_pcm_substream *substream)
-{
-	static const unsigned int channels[] = {
-		1, 2, 4
-	};
-	static const struct snd_pcm_hw_constraint_list constraints_channels = {
-		.count = ARRAY_SIZE(channels),
-		.list = channels,
-		.mask = 0,
-	};
-	static const unsigned int rates[] = {
-		8000, 16000, 32000, 48000, 96000, 192000
-	};
-	static const struct snd_pcm_hw_constraint_list constraints_rates = {
-		.count = ARRAY_SIZE(rates),
-		.list  = rates,
-		.mask = 0,
-	};
-
-	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int ret;
-
-	ret = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_CHANNELS,
-					 &constraints_channels);
-	if (ret < 0) {
-		dev_err(rtd->dev, "hw_constraint_list channels failed\n");
-		return ret;
-	}
-
-	ret = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_RATE,
-					 &constraints_rates);
-	if (ret < 0) {
-		dev_err(rtd->dev, "hw_constraint_list rate failed\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct snd_soc_ops mt8192_mt6359_capture1_ops = {
-	.startup = mt8192_mt6359_cap1_startup,
-};
-
-static int
-mt8192_mt6359_rt5682_startup(struct snd_pcm_substream *substream)
-{
-	static const unsigned int channels[] = {
-		1, 2
-	};
-	static const struct snd_pcm_hw_constraint_list constraints_channels = {
-		.count = ARRAY_SIZE(channels),
-		.list = channels,
-		.mask = 0,
-	};
-	static const unsigned int rates[] = {
-		48000
-	};
-	static const struct snd_pcm_hw_constraint_list constraints_rates = {
-		.count = ARRAY_SIZE(rates),
-		.list  = rates,
-		.mask = 0,
-	};
-
-	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int ret;
-
-	ret = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_CHANNELS,
-					 &constraints_channels);
-	if (ret < 0) {
-		dev_err(rtd->dev, "hw_constraint_list channels failed\n");
-		return ret;
-	}
-
-	ret = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_RATE,
-					 &constraints_rates);
-	if (ret < 0) {
-		dev_err(rtd->dev, "hw_constraint_list rate failed\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct snd_soc_ops mt8192_mt6359_rt5682_ops = {
-	.startup = mt8192_mt6359_rt5682_startup,
-};
-
 /* FE */
 SND_SOC_DAILINK_DEFS(playback1,
 		     DAILINK_COMP_ARRAY(COMP_CPU("DL1")),
@@ -720,7 +626,7 @@ static struct snd_soc_dai_link mt8192_mt6359_dai_links[] = {
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_playback = 1,
-		.ops = &mt8192_mt6359_rt5682_ops,
+		.ops = &mtk_soundcard_common_playback_ops,
 		SND_SOC_DAILINK_REG(playback3),
 	},
 	{
@@ -784,7 +690,7 @@ static struct snd_soc_dai_link mt8192_mt6359_dai_links[] = {
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_capture = 1,
-		.ops = &mt8192_mt6359_capture1_ops,
+		.ops = &mtk_soundcard_common_capture_ops,
 		SND_SOC_DAILINK_REG(capture1),
 	},
 	{
@@ -794,7 +700,7 @@ static struct snd_soc_dai_link mt8192_mt6359_dai_links[] = {
 			    SND_SOC_DPCM_TRIGGER_PRE},
 		.dynamic = 1,
 		.dpcm_capture = 1,
-		.ops = &mt8192_mt6359_rt5682_ops,
+		.ops = &mtk_soundcard_common_playback_ops,
 		SND_SOC_DAILINK_REG(capture2),
 	},
 	{
@@ -1146,7 +1052,7 @@ static int mt8192_mt6359_legacy_probe(struct mtk_soc_card_data *soc_card_data)
 	struct device *dev = card->dev;
 	struct device_node *hdmi_codec, *headset_codec, *speaker_codec;
 	struct snd_soc_dai_link *dai_link;
-	int ret, i;
+	int i, ret = 0;
 
 	hdmi_codec = of_parse_phandle(dev->of_node, "mediatek,hdmi-codec", 0);
 	if (!hdmi_codec)
@@ -1235,11 +1141,44 @@ static int mt8192_mt6359_soc_card_probe(struct mtk_soc_card_data *soc_card_data,
 	return 0;
 }
 
+static const unsigned int mt8192_pcm_playback_channels[] = { 1, 2 };
+static const unsigned int mt8192_pcm_playback_rates[] = { 48000 };
+
+static const unsigned int mt8192_pcm_capture_channels[] = { 1, 2, 4 };
+static const unsigned int mt8192_pcm_capture_rates[] = {
+	8000, 16000, 32000, 48000, 96000, 192000
+};
+
+static const struct mtk_pcm_constraints_data mt8192_pcm_constraints[MTK_CONSTRAINT_CAPTURE + 1] = {
+	[MTK_CONSTRAINT_PLAYBACK] = {
+		.channels = {
+			.list = mt8192_pcm_playback_channels,
+			.count = ARRAY_SIZE(mt8192_pcm_playback_channels)
+		},
+		.rates = {
+			.list = mt8192_pcm_playback_rates,
+			.count = ARRAY_SIZE(mt8192_pcm_playback_rates)
+		}
+	},
+	[MTK_CONSTRAINT_CAPTURE] = {
+		.channels = {
+			.list = mt8192_pcm_capture_channels,
+			.count = ARRAY_SIZE(mt8192_pcm_capture_channels)
+		},
+		.rates = {
+			.list = mt8192_pcm_capture_rates,
+			.count = ARRAY_SIZE(mt8192_pcm_capture_rates)
+		}
+	}
+};
+
 static const struct mtk_soundcard_pdata mt8192_mt6359_rt1015_rt5682_pdata = {
 	.card_name = RT1015_RT5682_CARD_NAME,
 	.card_data = &(struct mtk_platform_card_data) {
 		.card = &mt8192_mt6359_rt1015_rt5682_card,
 		.num_jacks = MT8192_JACK_MAX,
+		.pcm_constraints = mt8192_pcm_constraints,
+		.num_pcm_constraints = ARRAY_SIZE(mt8192_pcm_constraints),
 	},
 	.soc_probe = mt8192_mt6359_soc_card_probe
 };
@@ -1249,6 +1188,8 @@ static const struct mtk_soundcard_pdata mt8192_mt6359_rt1015p_rt5682_pdata = {
 	.card_data = &(struct mtk_platform_card_data) {
 		.card = &mt8192_mt6359_rt1015p_rt5682x_card,
 		.num_jacks = MT8192_JACK_MAX,
+		.pcm_constraints = mt8192_pcm_constraints,
+		.num_pcm_constraints = ARRAY_SIZE(mt8192_pcm_constraints),
 	},
 	.soc_probe = mt8192_mt6359_soc_card_probe
 };
@@ -1258,6 +1199,8 @@ static const struct mtk_soundcard_pdata mt8192_mt6359_rt1015p_rt5682s_pdata = {
 	.card_data = &(struct mtk_platform_card_data) {
 		.card = &mt8192_mt6359_rt1015p_rt5682x_card,
 		.num_jacks = MT8192_JACK_MAX,
+		.pcm_constraints = mt8192_pcm_constraints,
+		.num_pcm_constraints = ARRAY_SIZE(mt8192_pcm_constraints),
 	},
 	.soc_probe = mt8192_mt6359_soc_card_probe
 };
-- 
2.44.0


