Return-Path: <linux-kernel+bounces-160470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624D78B3DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865431C20E30
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B9E171660;
	Fri, 26 Apr 2024 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nEuT0nT6"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A857D17165E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152173; cv=none; b=Na0Wt/jxkXamczCNeMeBAOFfMbdVbO5wRmFxBVtGnRA8fOVEk5HNo6S1DINk/YZjt/qN9o7WfIGqpMYf0kZBMGtx06C01nWXX3clUzbCVmr9WQNVF3WLs1Ow/3PSA0LL0LgKk2nMwneuVYusadq7u4jLHoWGx3yTT5KxKWvPy5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152173; c=relaxed/simple;
	bh=rupMHCo4ov9trVUAGySMN2xWWd+DYicdRaX3eev6dnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=naWqrYNwwMOXYJPZM2iMjiNrHv+n0GZJTfPLUDz/UK2wnFB5QAZjK2tBY3P7jZtF24h/4P6tNjoOQ/MzWl9zJ/pywQLGme2mqf7XmQkA2ykzocx4/89yGfZTVkRl6NT22WVqZe7HkiAEcn4kR4WJDXg0aPfwLpn38BUj/OSzQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nEuT0nT6; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so37409281fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714152169; x=1714756969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTSY1ko++/wb2lPvySWoKOwaimob916R/fGD0IssuIQ=;
        b=nEuT0nT6MvRd2SpdHji4zhLEtToZFeqhmViLcOvF0JpEdL0WNxOAVD5aanssS6p/3S
         KwrwKpqeNJJA4N6Tn9uWKunrgXDhSP7KWkqQ9svTb+IqUZ3+tyFZzz8wQev40n4IFSnV
         j2CIGV3kEzz6vFtEk8wegONoYb5ZeIV7104Xqe7CfPvdsXJFavyZQkWYKTMjCCZNSfEK
         AOP8tD3J2J8Baecknq/uXp0f5/zG7fot79pnJxjWtvIjiAVPRYydq3FMYxnxJXZ0ev9h
         nTKJxw0BNy46guZxcKz9tDjAfdDuy1ujhFxQiSXryNysaYzQxUh4hF4Zgde3WlOoxd8C
         jZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152169; x=1714756969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTSY1ko++/wb2lPvySWoKOwaimob916R/fGD0IssuIQ=;
        b=Y0ggsgnGvMgvNuPpYxYhnIWua6Vy389wFLSXVaJVfpY+ww0//sDwJhr3MT+XNgOP1d
         olo8PG+s9dRa3JJ90+280SLVKF1VEmva10ZzKXGbqpT8kz1uGgfWV2UVFJR2iWVRHvdN
         bP1KPDDzw9p3IxvUAMriVbs0BWK9GPkkOcazULGfmJkwMhFZ6p9GsNCaQVfPxszcOQYU
         kqIkB3+WTARzD7leBEWB9BroKK9Sy8xHa0TviHssldpbf66+nckB5po76UW9t7ZxyUyJ
         OImSl39hH00rmVdDtHaBBfeb1r1JZwLNj0LAO/t2obZzMYd9zkbyR7/qjt/EnNRtCC+T
         G02Q==
X-Forwarded-Encrypted: i=1; AJvYcCU56t/r7fQi3Ay3iNvMrBJjYp1VbVL5JA0TAac8dA7pSHiM9w7Y8hIHnfwuJTh/OApT4S/4kuMkK57/qywwPnR+18WGR6MzcgzavGXY
X-Gm-Message-State: AOJu0YwErQxCjz3HBBFvVH+tCMmvDd18bZpOJP5h4EBjdFBtW6Yh52Hh
	ChwFo9xQsgtuh7A4878+XG7ZReJ925dy+OVxoqkZHzNvmbEZzLoVUAWNJtmlGik=
X-Google-Smtp-Source: AGHT+IGyMCQcv8a5p539hpb7XhCWiEvacxq9uLmPO1I7UnIGZY4NrK6ZNB1ydrCeSWxn7frNx8OGXA==
X-Received: by 2002:a2e:9008:0:b0:2db:a9c9:4c5e with SMTP id h8-20020a2e9008000000b002dba9c94c5emr2761461ljg.21.1714152168954;
        Fri, 26 Apr 2024 10:22:48 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ot15-20020a170906cccf00b00a5239720044sm10763363ejb.8.2024.04.26.10.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:22:48 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Fri, 26 Apr 2024 19:22:36 +0200
Subject: [PATCH v4 07/16] ASoC: mediatek: mt8365: Add ADDA DAI support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v4-7-082b22186d4c@baylibre.com>
References: <20240226-audio-i350-v4-0-082b22186d4c@baylibre.com>
In-Reply-To: <20240226-audio-i350-v4-0-082b22186d4c@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10092;
 i=amergnat@baylibre.com; h=from:subject:message-id;
 bh=rupMHCo4ov9trVUAGySMN2xWWd+DYicdRaX3eev6dnk=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmK+LahayLRRrw5KpN0IzsLZFXqXJXCy2x3zCZRu7J
 OBlVJVeJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZivi2gAKCRArRkmdfjHURTlLEA
 CkdHIBfbblpCMNJxcA7OiP3KWN1HNUv9oe9aS32DJqQdGAE5AbHWe1u4fQGUoCM/w7XWvsWAApygh/
 haiNmvg76c0NYuEjfhj/PSU5p5KBjiE7EpMFZ3xZqus8lxbyzPTKHdjnANlhr7jOLgN1C52+2cg1M6
 IOSYZ+i3o+gO00bI7+HNGLXMFXuZ6xLM+zWEAj0/bK7FORrSoE2MTG/m1zmysCA4fcXh9/wpPZQHbC
 8malyJJ/PUakYcQ7WsK0FBi9n/HwNiWxdXUG067ZOPUDc6NRhyhFb0egedNlbBWe+UIWJBI/VoPTN/
 LSKXk120eDpmbaiUqRxEJKVPX4ZngJjW5aFj0z7qdfymFdS2+9L8eSLtlBpn4ZiO3FCvl09hjuZe5L
 jmDkhVYKw8SGROtEpbMwltN/wk7+W7DadzTGdZcOZj+mlJRO1Y12sxuItOirpaASWwTp6iwzz07eGu
 YOXwRKCUqV0HsuTca1pK2dSH04CfyqH8Ld6nTZDkrbExXGwoLH4BvFkwOxsegE5/kuWsqTpBSDLrat
 F8Vn7T/a13BHmovVj+RTlVSoGSpjdoxROjdnxRw+IEEm5BtwWGwsABD5WtRx1pcBcxogNOr2nLTkt4
 43fu9p1m2wmzyhbHC18u5j0KRjBuIVFQFt4WfO7VuJj6AZL9q6rf8PAXJ4tA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add ADDA Device Audio Interface support for MT8365 SoC.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 sound/soc/mediatek/mt8365/mt8365-dai-adda.c | 315 ++++++++++++++++++++++++++++
 1 file changed, 315 insertions(+)

diff --git a/sound/soc/mediatek/mt8365/mt8365-dai-adda.c b/sound/soc/mediatek/mt8365/mt8365-dai-adda.c
new file mode 100644
index 000000000000..65d45010ac90
--- /dev/null
+++ b/sound/soc/mediatek/mt8365/mt8365-dai-adda.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek 8365 ALSA SoC Audio DAI ADDA Control
+ *
+ * Copyright (c) 2024 MediaTek Inc.
+ * Authors: Jia Zeng <jia.zeng@mediatek.com>
+ *          Alexandre Mergnat <amergnat@baylibre.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include "mt8365-afe-clk.h"
+#include "mt8365-afe-common.h"
+#include "../common/mtk-dai-adda-common.h"
+
+static int adda_afe_on_ref_cnt;
+
+/* DAI Drivers */
+
+static int mt8365_dai_set_adda_out(struct mtk_base_afe *afe, unsigned int rate)
+{
+	unsigned int val;
+
+	switch (rate) {
+	case 8000:
+		val = AFE_ADDA_DL_VOICE_DATA;
+		break;
+	case 16000:
+		val = AFE_ADDA_DL_VOICE_DATA;
+		break;
+	default:
+		val = 0;
+	}
+
+	val |= FIELD_PREP(AFE_ADDA_DL_SAMPLING_RATE,
+		mtk_adda_dl_rate_transform(afe, rate));
+	val |= AFE_ADDA_DL_8X_UPSAMPLE |
+	       AFE_ADDA_DL_MUTE_OFF_CH1 |
+	       AFE_ADDA_DL_MUTE_OFF_CH2 |
+	       AFE_ADDA_DL_DEGRADE_GAIN;
+
+	regmap_update_bits(afe->regmap, AFE_ADDA_PREDIS_CON0, 0xffffffff, 0);
+	regmap_update_bits(afe->regmap, AFE_ADDA_PREDIS_CON1, 0xffffffff, 0);
+	regmap_update_bits(afe->regmap, AFE_ADDA_DL_SRC2_CON0, 0xffffffff, val);
+	/* SA suggest apply -0.3db to audio/speech path */
+	regmap_update_bits(afe->regmap, AFE_ADDA_DL_SRC2_CON1,
+			   0xffffffff, 0xf74f0000);
+	/* SA suggest use default value for sdm */
+	regmap_update_bits(afe->regmap, AFE_ADDA_DL_SDM_DCCOMP_CON,
+			   0xffffffff, 0x0700701e);
+
+	return 0;
+}
+
+static int mt8365_dai_set_adda_in(struct mtk_base_afe *afe, unsigned int rate)
+{
+	unsigned int val;
+
+	val = FIELD_PREP(AFE_ADDA_UL_SAMPLING_RATE,
+			 mtk_adda_ul_rate_transform(afe, rate));
+	regmap_update_bits(afe->regmap, AFE_ADDA_UL_SRC_CON0,
+			   AFE_ADDA_UL_SAMPLING_RATE, val);
+	/* Using Internal ADC */
+	regmap_update_bits(afe->regmap, AFE_ADDA_TOP_CON0, 0x1, 0x0);
+
+	return 0;
+}
+
+int mt8365_dai_enable_adda_on(struct mtk_base_afe *afe)
+{
+	unsigned long flags;
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+
+	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);
+
+	adda_afe_on_ref_cnt++;
+	if (adda_afe_on_ref_cnt == 1)
+		regmap_update_bits(afe->regmap, AFE_ADDA_UL_DL_CON0,
+				   AFE_ADDA_UL_DL_ADDA_AFE_ON,
+				   AFE_ADDA_UL_DL_ADDA_AFE_ON);
+
+	spin_unlock_irqrestore(&afe_priv->afe_ctrl_lock, flags);
+
+	return 0;
+}
+
+int mt8365_dai_disable_adda_on(struct mtk_base_afe *afe)
+{
+	unsigned long flags;
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+
+	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);
+
+	adda_afe_on_ref_cnt--;
+	if (adda_afe_on_ref_cnt == 0)
+		regmap_update_bits(afe->regmap, AFE_ADDA_UL_DL_CON0,
+				   AFE_ADDA_UL_DL_ADDA_AFE_ON,
+				   ~AFE_ADDA_UL_DL_ADDA_AFE_ON);
+	else if (adda_afe_on_ref_cnt < 0)
+		adda_afe_on_ref_cnt = 0;
+
+	spin_unlock_irqrestore(&afe_priv->afe_ctrl_lock, flags);
+
+	return 0;
+}
+
+static void mt8365_dai_set_adda_out_enable(struct mtk_base_afe *afe,
+					   bool enable)
+{
+	regmap_update_bits(afe->regmap, AFE_ADDA_DL_SRC2_CON0, 0x1, enable);
+
+	if (enable)
+		mt8365_dai_enable_adda_on(afe);
+	else
+		mt8365_dai_disable_adda_on(afe);
+}
+
+static void mt8365_dai_set_adda_in_enable(struct mtk_base_afe *afe, bool enable)
+{
+	if (enable) {
+		regmap_update_bits(afe->regmap, AFE_ADDA_UL_SRC_CON0, 0x1, 0x1);
+		mt8365_dai_enable_adda_on(afe);
+		/* enable aud_pad_top fifo */
+		regmap_update_bits(afe->regmap, AFE_AUD_PAD_TOP,
+				   0xffffffff, 0x31);
+	} else {
+		/* disable aud_pad_top fifo */
+		regmap_update_bits(afe->regmap, AFE_AUD_PAD_TOP,
+				   0xffffffff, 0x30);
+		regmap_update_bits(afe->regmap, AFE_ADDA_UL_SRC_CON0, 0x1, 0x0);
+		/* de suggest disable ADDA_UL_SRC at least wait 125us */
+		usleep_range(150, 300);
+		mt8365_dai_disable_adda_on(afe);
+	}
+}
+
+static int mt8365_dai_int_adda_startup(struct snd_pcm_substream *substream,
+				       struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	unsigned int stream = substream->stream;
+
+	mt8365_afe_enable_main_clk(afe);
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		mt8365_afe_enable_top_cg(afe, MT8365_TOP_CG_DAC);
+		mt8365_afe_enable_top_cg(afe, MT8365_TOP_CG_DAC_PREDIS);
+	} else if (stream == SNDRV_PCM_STREAM_CAPTURE) {
+		mt8365_afe_enable_top_cg(afe, MT8365_TOP_CG_ADC);
+	}
+
+	return 0;
+}
+
+static void mt8365_dai_int_adda_shutdown(struct snd_pcm_substream *substream,
+					 struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+	struct mt8365_be_dai_data *be =
+		&afe_priv->be_data[dai->id - MT8365_AFE_BACKEND_BASE];
+	unsigned int stream = substream->stream;
+
+	if (be->prepared[stream]) {
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			mt8365_dai_set_adda_out_enable(afe, false);
+			mt8365_afe_set_i2s_out_enable(afe, false);
+		} else {
+			mt8365_dai_set_adda_in_enable(afe, false);
+		}
+		be->prepared[stream] = false;
+	}
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		mt8365_afe_disable_top_cg(afe, MT8365_TOP_CG_DAC_PREDIS);
+		mt8365_afe_disable_top_cg(afe, MT8365_TOP_CG_DAC);
+	} else if (stream == SNDRV_PCM_STREAM_CAPTURE) {
+		mt8365_afe_disable_top_cg(afe, MT8365_TOP_CG_ADC);
+	}
+
+	mt8365_afe_disable_main_clk(afe);
+}
+
+static int mt8365_dai_int_adda_prepare(struct snd_pcm_substream *substream,
+				       struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+	struct mt8365_be_dai_data *be =
+		&afe_priv->be_data[dai->id - MT8365_AFE_BACKEND_BASE];
+	unsigned int rate = substream->runtime->rate;
+	int bit_width = snd_pcm_format_width(substream->runtime->format);
+	int ret;
+
+	dev_info(afe->dev, "%s '%s' rate = %u\n", __func__,
+		 snd_pcm_stream_str(substream), rate);
+
+	if (be->prepared[substream->stream]) {
+		dev_info(afe->dev, "%s '%s' prepared already\n",
+			 __func__, snd_pcm_stream_str(substream));
+		return 0;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ret = mt8365_dai_set_adda_out(afe, rate);
+		if (ret)
+			return ret;
+
+		ret = mt8365_afe_set_i2s_out(afe, rate, bit_width);
+		if (ret)
+			return ret;
+
+		mt8365_dai_set_adda_out_enable(afe, true);
+		mt8365_afe_set_i2s_out_enable(afe, true);
+	} else {
+		ret = mt8365_dai_set_adda_in(afe, rate);
+		if (ret)
+			return ret;
+
+		mt8365_dai_set_adda_in_enable(afe, true);
+	}
+	be->prepared[substream->stream] = true;
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mt8365_afe_int_adda_ops = {
+	.startup	= mt8365_dai_int_adda_startup,
+	.shutdown	= mt8365_dai_int_adda_shutdown,
+	.prepare	= mt8365_dai_int_adda_prepare,
+};
+
+static struct snd_soc_dai_driver mtk_dai_adda_driver[] = {
+	{
+		.name = "INT ADDA",
+		.id = MT8365_AFE_IO_INT_ADDA,
+		.playback = {
+			.stream_name = "INT ADDA Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.capture = {
+			.stream_name = "INT ADDA Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_16000 |
+				 SNDRV_PCM_RATE_32000 |
+				 SNDRV_PCM_RATE_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S32_LE,
+		},
+		.ops = &mt8365_afe_int_adda_ops,
+	}
+};
+
+/* DAI Controls */
+
+static const struct snd_kcontrol_new mtk_adda_dl_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("GAIN1_OUT_CH1 Switch", AFE_CONN3,
+				    10, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_adda_dl_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("GAIN1_OUT_CH2 Switch", AFE_CONN4,
+				    11, 1, 0),
+};
+
+static const struct snd_kcontrol_new int_adda_o03_o04_enable_ctl =
+	SOC_DAPM_SINGLE_VIRT("Switch", 1);
+
+/* DAI widget */
+
+static const struct snd_soc_dapm_widget mtk_dai_adda_widgets[] = {
+	SND_SOC_DAPM_SWITCH("INT ADDA O03_O04", SND_SOC_NOPM, 0, 0,
+			    &int_adda_o03_o04_enable_ctl),
+	/* inter-connections */
+	SND_SOC_DAPM_MIXER("ADDA_DL_CH1", SND_SOC_NOPM, 0, 0,
+			   mtk_adda_dl_ch1_mix,
+			   ARRAY_SIZE(mtk_adda_dl_ch1_mix)),
+	SND_SOC_DAPM_MIXER("ADDA_DL_CH2", SND_SOC_NOPM, 0, 0,
+			   mtk_adda_dl_ch2_mix,
+			   ARRAY_SIZE(mtk_adda_dl_ch2_mix)),
+};
+
+/* DAI route */
+
+static const struct snd_soc_dapm_route mtk_dai_adda_routes[] = {
+	{"INT ADDA O03_O04", "Switch", "O03"},
+	{"INT ADDA O03_O04", "Switch", "O04"},
+	{"INT ADDA Playback", NULL, "INT ADDA O03_O04"},
+	{"INT ADDA Playback", NULL, "ADDA_DL_CH1"},
+	{"INT ADDA Playback", NULL, "ADDA_DL_CH2"},
+	{"AIN Mux", "INT ADC", "INT ADDA Capture"},
+	{"ADDA_DL_CH1", "GAIN1_OUT_CH1", "Hostless FM DL"},
+	{"ADDA_DL_CH2", "GAIN1_OUT_CH2", "Hostless FM DL"},
+};
+
+int mt8365_dai_adda_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+	list_add(&dai->list, &afe->sub_dais);
+	dai->dai_drivers = mtk_dai_adda_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_adda_driver);
+	dai->dapm_widgets = mtk_dai_adda_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_adda_widgets);
+	dai->dapm_routes = mtk_dai_adda_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_adda_routes);
+	return 0;
+}

-- 
2.25.1


