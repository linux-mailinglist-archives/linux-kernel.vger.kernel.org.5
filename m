Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E9D76D63B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjHBR6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjHBR6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE49170D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so1324375e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999084; x=1691603884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5e55/3niGxnTXERcmKYSB94dQwx71jJXMxMhyp26po=;
        b=RJ4Ld/ivmitOHIy6lTXMkEVG49CIs5bqeUEU0wDNDAPlLud4dF2xxgEXUSBvixy2mf
         UslIRyJGR5uGBgM3lFWPetavx6dTJZSYep4mSfril2gJvVWWCzK31xYK+sKaUnCxdgCj
         jwvspYMiCmFB96tmFahpDx9lBdpckAWCEBDmDpYTOea6N3KAiaa5CPg/iHqQOCQ3OpkQ
         WW5VI3oDYHeNjvv2XgkkY6FG7tqkphk7HvUQfMofDp+tiC5ZilzPifOY20Xp8oGrTXCv
         2InKyYQ0LsfPa0vOisXg+/5DA+xQUIzSRtjW1IYmHgsCPDangDcbHMVHhVVpAgzJDV9Z
         q3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999084; x=1691603884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5e55/3niGxnTXERcmKYSB94dQwx71jJXMxMhyp26po=;
        b=lR/NXcaySkS5f9UJTSDwQmPK5VMr7dUHRQT3IO9gS7s9nxHVUvIMMHAL8+SHT8zN2B
         delV/3QdcLabx+IAdi8+G1yHB5mBqwI3IswnyU5NpS+F9m+h8baDVStzbyEhxGjZFIRy
         6TPDX+gBZZRRQhjmvXWjt7UGpWah/oDZFkTmahasa6iDVtNwUL4UVHloiRgxtU1hI2ri
         p5cv/wfWwFmKiR+IsxV1s9bT4tKWsmF8YBhbuQf1PNv9qFHK9fbubARejH1JDR369ScI
         kiG9GFdEmZmCYSRw79tJJWL7vFxX07+uLkf87ZscdsGiJ0fnsUAc9yQJFNSaP4aPcPvD
         qZiA==
X-Gm-Message-State: ABy/qLZ4KEjNDu+fiaufr7zQEPlb2l6vaBIgv6UO34w4RPT4aAKmYEM4
        YGJpY2EB6fAGkjt914DZEzs=
X-Google-Smtp-Source: APBJJlHe5rsnsWTWy8R/4Vk0CgbZNnBGdJd50hzwNNAsvA3gYagQGA3Vz0KZ61Sahpqg0dwkZEaM9w==
X-Received: by 2002:a05:600c:2210:b0:3fe:ad4:27b1 with SMTP id z16-20020a05600c221000b003fe0ad427b1mr5437497wml.28.1690999084261;
        Wed, 02 Aug 2023 10:58:04 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:03 -0700 (PDT)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH 05/27] ASoC: Intel: avs: da7219: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:15 +0300
Message-Id: <20230802175737.263412-6-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802175737.263412-1-alpernebiyasak@gmail.com>
References: <20230802175737.263412-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver does not properly map jack pins to kcontrols that PulseAudio
and PipeWire need to handle jack detection events. The DA7219 codec used
here can detect Headphones, Headset Mic and Line Out connections. Expose
each to userspace as kcontrols and add the necessary widgets.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
I'm not sure the use of devm_kmemdup is necessary here, but it's what
avs/boards/nau8825.c does, I copied from that. Is it just to sidestep
the "const" modifier on snd_soc_jack_pin?

Also see a similar construct in nt8625.c (already in linux-next):
https://lore.kernel.org/all/20230629112449.1755928-8-cezary.rojewski@intel.com/

 sound/soc/intel/avs/boards/da7219.c | 34 +++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/avs/boards/da7219.c b/sound/soc/intel/avs/boards/da7219.c
index 964a763732ab..85014d98f7e8 100644
--- a/sound/soc/intel/avs/boards/da7219.c
+++ b/sound/soc/intel/avs/boards/da7219.c
@@ -22,6 +22,7 @@
 static const struct snd_kcontrol_new card_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Line Out"),
 };
 
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
@@ -55,6 +56,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 static const struct snd_soc_dapm_widget card_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0, platform_clock_control,
 			    SND_SOC_DAPM_POST_PMD | SND_SOC_DAPM_PRE_PMU),
 };
@@ -68,6 +70,22 @@ static const struct snd_soc_dapm_route card_base_routes[] = {
 
 	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headset Mic", NULL, "Platform Clock" },
+	{ "Line Out", NULL, "Platform Clock" },
+};
+
+static const struct snd_soc_jack_pin card_headset_pins[] = {
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+	{
+		.pin = "Line Out",
+		.mask = SND_JACK_LINEOUT,
+	},
 };
 
 static int avs_da7219_codec_init(struct snd_soc_pcm_runtime *runtime)
@@ -75,7 +93,9 @@ static int avs_da7219_codec_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(runtime, 0);
 	struct snd_soc_component *component = codec_dai->component;
 	struct snd_soc_card *card = runtime->card;
+	struct snd_soc_jack_pin *pins;
 	struct snd_soc_jack *jack;
+	int num_pins;
 	int clk_freq;
 	int ret;
 
@@ -91,14 +111,20 @@ static int avs_da7219_codec_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
+	num_pins = ARRAY_SIZE(card_headset_pins);
+	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	if (!pins)
+		return -ENOMEM;
+
 	/*
 	 * Headset buttons map to the google Reference headset.
 	 * These can be configured by userspace.
 	 */
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
-				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
-				    SND_JACK_BTN_3 | SND_JACK_LINEOUT, jack);
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0 |
+					 SND_JACK_BTN_1 | SND_JACK_BTN_2 |
+					 SND_JACK_BTN_3 | SND_JACK_LINEOUT,
+					 jack, pins, num_pins);
 	if (ret) {
 		dev_err(card->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
-- 
2.40.1

