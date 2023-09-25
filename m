Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC4B7AD388
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjIYIjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjIYIjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:39:22 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0237FC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:39:15 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3634216a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1695631155; x=1696235955; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xI5M8VqjHxg4TM8TEPWCg+/Qvd/N7ZnqfdNTC0OI6Ds=;
        b=T3Q72OuzDPyJjwx6suDwhXAghRVq2SZOMSKWyCbj4L9VE8B+6Xn190DVC+F+XbGxyW
         OJLVfz8NREZ8zOdkyMhqPr1g8qSo/PnjU4LTJEak9FaeaNz7vdWE6FeTZ2XaOlxjXCFZ
         90WzZsI6wI6ymxLzdy++MJXNoumUp8XLNpDnyL1051a10HxI6jgUiy887GO9Fh5BJ0A3
         OE93h73tvFwTolBt+hQ42RyWnsVo90TxImHqx4YR38Xp/kAritfQdz4fT8SeyeR7Qu/K
         xzEMeSfgT6UwvNa7DurfmxnSrkXqCwEUnaii8Dkg2a780M5ZFuz055SrWJ3ziq9vfiLp
         dDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695631155; x=1696235955;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xI5M8VqjHxg4TM8TEPWCg+/Qvd/N7ZnqfdNTC0OI6Ds=;
        b=l2IDx9gJMG9Q2ha2mNNYlXh2wGF98WzdX0ppT+qw5+CkldjcwIOwJIdKMlzK9MLB2T
         VaGGrpmusFqccxhwAfIZzdKqmyTl3vCYvR0Fa7jufciz9E+zJbKFGUfaKcXwWf5LOU6/
         Aduz3B9RE48zoxvh8wla+pDiLh0a95FnVjumapG1uXZtdaqLC63/+n8cf7/uWA0QM7T6
         swKLxxXbh7btbE32/64jbbLzS0kGlEQZVxfBpadL9UZiZzP7N77PyWxyXId1zkKSA9+r
         7gPAiVbLIk9Wc4CXDdObqKzC+IHrCwqEcD3mgPbK4JkTNMZR5qBbazDJkaQsd7OiOyAv
         truQ==
X-Gm-Message-State: AOJu0Yypw7ulxUg8LOnaWcfLXphIJ9of2jqKEWa6Ylw2EFnxCz9t6rDj
        b4YnLCW7s+M5W3GT4j+70pFcGg==
X-Google-Smtp-Source: AGHT+IEidwo195lvaCNLYjcxjsIlUsTEIymmaFX1w9K4Gawo51vwYTFpYWEGe/sgYFMsSp9zfbUtiQ==
X-Received: by 2002:a17:90b:1012:b0:276:757d:8c89 with SMTP id gm18-20020a17090b101200b00276757d8c89mr3668309pjb.44.1695631155214;
        Mon, 25 Sep 2023 01:39:15 -0700 (PDT)
Received: from ubuntu.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a004e00b0025dc5749b4csm10141132pjb.21.2023.09.25.01.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:39:15 -0700 (PDT)
From:   xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To:     lgirdwood@gmail.com, perex@perex.cz, trevor.wu@mediatek.com,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [v1 2/2] ASoC: mediatek: mt8188-mt6359: add rt5682s support
Date:   Mon, 25 Sep 2023 16:38:47 +0800
Message-Id: <20230925083847.1496-3-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230925083847.1496-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20230925083847.1496-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use RT5682S as the codec and MAX98390 as the amp, add a new
sound card named mt8188_rt5682.

Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
---
 sound/soc/mediatek/Kconfig                |   1 +
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 154 +++++++++++++++++++++-
 2 files changed, 154 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 8d1bc8814486..43c8fea00439 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -250,6 +250,7 @@ config SND_SOC_MT8188_MT6359
 	select SND_SOC_MAX98390
 	select SND_SOC_NAU8315
 	select SND_SOC_NAU8825
+	select SND_SOC_RT5682S
 	help
 	  This adds support for ASoC machine driver for MediaTek MT8188
 	  boards with the MT6359 and other I2S audio codecs.
diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index e2416b981e1f..be632804c266 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -17,6 +17,7 @@
 #include "mt8188-afe-common.h"
 #include "../../codecs/nau8825.h"
 #include "../../codecs/mt6359.h"
+#include "../../codecs/rt5682.h"
 #include "../common/mtk-afe-platform-driver.h"
 #include "../common/mtk-soundcard-driver.h"
 #include "../common/mtk-dsp-sof-common.h"
@@ -32,7 +33,7 @@
  #define TEST_MISO_DONE_2	BIT(29)
 
 #define NAU8825_HS_PRESENT	BIT(0)
-
+#define RT5682_HS_PRESENT	BIT(1)
 /*
  * Maxim MAX98390
  */
@@ -52,6 +53,8 @@
 #define SOF_DMA_UL4 "SOF_DMA_UL4"
 #define SOF_DMA_UL5 "SOF_DMA_UL5"
 
+#define RT5682_CODEC_DAI     "rt5682s-aif1"
+
 /* FE */
 SND_SOC_DAILINK_DEFS(playback2,
 		     DAILINK_COMP_ARRAY(COMP_CPU("DL2")),
@@ -258,6 +261,17 @@ static struct snd_soc_jack_pin nau8825_jack_pins[] = {
 	},
 };
 
+static struct snd_soc_jack_pin rt5682_jack_pins[] = {
+	{
+		.pin    = "Headphone Jack",
+		.mask   = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin    = "Headset Mic",
+		.mask   = SND_JACK_MICROPHONE,
+	},
+};
+
 struct mt8188_card_data {
 	const char *name;
 	unsigned long quirk;
@@ -316,10 +330,18 @@ static const struct snd_soc_dapm_widget mt8188_nau8825_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 };
 
+static const struct snd_soc_dapm_widget mt8188_rt5682_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+};
+
 static const struct snd_kcontrol_new mt8188_nau8825_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 };
 
+static const struct snd_kcontrol_new mt8188_rt5682_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+};
+
 static const struct snd_soc_dapm_route mt8188_mt6359_routes[] = {
 	/* SOF Uplink */
 	{SOF_DMA_UL4, NULL, "O034"},
@@ -772,6 +794,55 @@ static int mt8188_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 };
 
+static int mt8188_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(card);
+	struct mt8188_mt6359_priv *priv = soc_card_data->mach_priv;
+	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
+	struct snd_soc_jack *jack = &priv->headset_jack;
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(&card->dapm, mt8188_rt5682_widgets,
+					ARRAY_SIZE(mt8188_rt5682_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add rt5682 card widget, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, mt8188_rt5682_controls,
+					ARRAY_SIZE(mt8188_rt5682_controls));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add rt5682 card controls, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0 |
+					 SND_JACK_BTN_1 | SND_JACK_BTN_2 |
+					 SND_JACK_BTN_3,
+					 jack,
+					 rt5682_jack_pins,
+					 ARRAY_SIZE(rt5682_jack_pins));
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
+		return ret;
+	}
+
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+	ret = snd_soc_component_set_jack(component, jack, NULL);
+
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack call-back failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+};
+
 static void mt8188_nau8825_codec_exit(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
@@ -779,6 +850,13 @@ static void mt8188_nau8825_codec_exit(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_component_set_jack(component, NULL, NULL);
 }
 
+static void mt8188_rt5682_codec_exit(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
+
+	snd_soc_component_set_jack(component, NULL, NULL);
+}
+
 static int mt8188_nau8825_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *params)
 {
@@ -813,6 +891,51 @@ static const struct snd_soc_ops mt8188_nau8825_ops = {
 	.hw_params = mt8188_nau8825_hw_params,
 };
 
+static int mt8186_rt5682s_i2s_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	unsigned int rate = params_rate(params);
+	int bitwidth;
+	int ret;
+
+	bitwidth = snd_pcm_format_width(params_format(params));
+	if (bitwidth < 0) {
+		dev_err(card->dev, "invalid bit width: %d\n", bitwidth);
+		return bitwidth;
+	}
+
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x00, 0x0, 0x2, bitwidth);
+	if (ret) {
+		dev_err(card->dev, "failed to set tdm slot\n");
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_pll(codec_dai, RT5682_PLL1, RT5682_PLL1_S_BCLK1,
+				  rate * 32, rate * 512);
+	if (ret) {
+		dev_err(card->dev, "failed to set pll\n");
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL1,
+				     rate * 512, SND_SOC_CLOCK_IN);
+	if (ret) {
+		dev_err(card->dev, "failed to set sysclk\n");
+		return ret;
+	}
+
+	return snd_soc_dai_set_sysclk(cpu_dai, 0, rate * 128,
+				      SND_SOC_CLOCK_OUT);
+}
+
+static const struct snd_soc_ops mt8188_rt5682s_i2s_ops = {
+	.hw_params = mt8186_rt5682s_i2s_hw_params,
+};
+
 static int mt8188_sof_be_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params)
 {
@@ -1163,6 +1286,21 @@ static void mt8188_fixup_controls(struct snd_soc_card *card)
 			snd_ctl_remove(card->snd_card, kctl);
 		else
 			dev_warn(card->dev, "Cannot find ctl : Headphone Switch\n");
+	} else if (card_data->quirk & RT5682_HS_PRESENT) {
+		struct snd_soc_dapm_widget *w, *next_w;
+
+		for_each_card_widgets_safe(card, w, next_w) {
+			if (strcmp(w->name, "Headphone"))
+				continue;
+
+			snd_soc_dapm_free_widget(w);
+		}
+
+		kctl = ctl_find(card->snd_card, "Headphone Switch");
+		if (kctl)
+			snd_ctl_remove(card->snd_card, kctl);
+		else
+			dev_warn(card->dev, "Cannot find ctl : Headphone Switch\n");
 	}
 }
 
@@ -1190,6 +1328,7 @@ static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
 	struct snd_soc_dai_link *dai_link;
 	bool init_mt6359 = false;
 	bool init_nau8825 = false;
+	bool init_rt5682 = false;
 	bool init_max98390 = false;
 	bool init_dumb = false;
 	int ret, i;
@@ -1306,6 +1445,13 @@ static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
 					dai_link->exit = mt8188_nau8825_codec_exit;
 					init_nau8825 = true;
 				}
+			} else if (!strcmp(dai_link->codecs->dai_name, RT5682_CODEC_DAI)) {
+				dai_link->ops = &mt8188_rt5682s_i2s_ops;
+				if (!init_rt5682) {
+					dai_link->init = mt8188_rt5682_codec_init;
+					dai_link->exit = mt8188_rt5682_codec_exit;
+					init_rt5682 = true;
+				}
 			} else {
 				if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai")) {
 					if (!init_dumb) {
@@ -1343,9 +1489,15 @@ static struct mt8188_card_data mt8188_nau8825_card = {
 	.quirk = NAU8825_HS_PRESENT,
 };
 
+static struct mt8188_card_data mt8188_rt5682_card = {
+	.name = "mt8188_rt5682",
+	.quirk = RT5682_HS_PRESENT,
+};
+
 static const struct of_device_id mt8188_mt6359_dt_match[] = {
 	{ .compatible = "mediatek,mt8188-mt6359-evb", .data = &mt8188_evb_card, },
 	{ .compatible = "mediatek,mt8188-nau8825", .data = &mt8188_nau8825_card, },
+	{ .compatible = "mediatek,mt8188-rt5682", .data = &mt8188_rt5682_card, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mt8188_mt6359_dt_match);
-- 
2.17.1

