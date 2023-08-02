Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D4576D654
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjHBSAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjHBR77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:59:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D114236
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so1273255e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999128; x=1691603928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNMbLNyqZ+emJZ68zpth6DtJLmrhI+8LXvJVEDQYQ2I=;
        b=g1wME0SdXRtw9CPo/8HDfKuL4GNNtrvZAGMlwVbhYRcNlUlBDfWZX5k7hH6BkQGS35
         ZpHZJG1yusAGfd6t6AdsltXnnV/D6tMnxJCimEBMEdw8ZJ4zPkBqhrrxj6xn0APWDblT
         K2Miia2BQgJIu01mRQFaeB46Mphnc2dXcOUJn5jQeKteVa8vgMlH9aazo29kqhOq9KWz
         hWsF2Czn+GsI9Bgb6Xfbqba9D/2PlNHj4/bB2aFEspi6lQ3Ts1Fi25gX1+Jq1IwP3477
         00t2m8tO0TpVASZqUf8CpwJSpbiK2idu0SCkqn+Y1KXtOukmnEAZ6lFnzJQzqoXBrJhr
         dWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999128; x=1691603928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNMbLNyqZ+emJZ68zpth6DtJLmrhI+8LXvJVEDQYQ2I=;
        b=gXFnlEXeIzeFRt0tgG1bhOnPS8bDMWsUbTgEh8bnSWzGVHcOmK7QzDtBdhUlqrW5UH
         yl57IvcH5G4R+sfw4MlEvT+lXRlD87LJ9o91mdHSdQSlNDTaCIpZz/LndAhuv5P/V9F4
         zIwUCAffoJvn4r41Ng1LittGO0qCAnrI6Fw0SpHV/i5kdd66ckuiNGEEF1rP/Z+tTfVI
         9xsnyZS2XLMrarqJ7dkS7Qg/0p6Gkn+djf7q6+BZ/gb5cCvZLGib0IfpF30lAKCjGouf
         q/x7SuGwklJ63r4jIsg8BvrgF0ETbU4M+V42S8qTW0KEN3miU4X1T/uwcPHkg2EFammV
         FHGQ==
X-Gm-Message-State: ABy/qLYWHTy1/aSmUd92CyMEvsowFj8xgPavYA2nLdJaTMlC95clJ6mM
        mp3QmclrBkmC6DrrIBYJTLQ=
X-Google-Smtp-Source: APBJJlF+5skmhEb8aNeWM8Qh6e6Wepa+pivxHF2VJRgf2lqm5GL21Nod6FXyIloCW2/y+9tAYg2k3w==
X-Received: by 2002:a1c:7419:0:b0:3fb:e2af:49f6 with SMTP id p25-20020a1c7419000000b003fbe2af49f6mr5114900wmc.39.1690999127599;
        Wed, 02 Aug 2023 10:58:47 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:47 -0700 (PDT)
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
Subject: [PATCH 27/27] ASoC: samsung: midas_wm1811: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:37 +0300
Message-Id: <20230802175737.263412-28-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802175737.263412-1-alpernebiyasak@gmail.com>
References: <20230802175737.263412-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This driver does not map jack pins to kcontrols that PulseAudio/PipeWire
need to handle jack detection events. The WM1811 codec used here seems
to support detecting Headphone and Headset Mic connections. Expose each
to userspace as a kcontrol and add the necessary widgets.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
There's a "HP" widget as well, should the jack kcontrol use that?
Would SND_JACK_MECHANICAL be useful as a kcontrol as well?

 sound/soc/samsung/midas_wm1811.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/sound/soc/samsung/midas_wm1811.c b/sound/soc/samsung/midas_wm1811.c
index 6931b9a45b3e..44b32f5cddca 100644
--- a/sound/soc/samsung/midas_wm1811.c
+++ b/sound/soc/samsung/midas_wm1811.c
@@ -38,6 +38,17 @@ struct midas_priv {
 	struct snd_soc_jack headset_jack;
 };
 
+static struct snd_soc_jack_pin headset_jack_pins[] = {
+	{
+		.pin = "Headphone",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
+
 static int midas_start_fll1(struct snd_soc_pcm_runtime *rtd, unsigned int rate)
 {
 	struct snd_soc_card *card = rtd->card;
@@ -246,6 +257,7 @@ static const struct snd_kcontrol_new midas_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Main Mic"),
 	SOC_DAPM_PIN_SWITCH("Sub Mic"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Headphone"),
 
 	SOC_DAPM_PIN_SWITCH("FM In"),
 };
@@ -261,6 +273,7 @@ static const struct snd_soc_dapm_widget midas_dapm_widgets[] = {
 	SND_SOC_DAPM_LINE("HDMI", NULL),
 	SND_SOC_DAPM_LINE("FM In", midas_fm_set),
 
+	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Main Mic", midas_mic_bias),
 	SND_SOC_DAPM_MIC("Sub Mic", midas_submic_bias),
@@ -305,11 +318,13 @@ static int midas_late_probe(struct snd_soc_card *card)
 		return ret;
 	}
 
-	ret = snd_soc_card_jack_new(card, "Headset",
-			SND_JACK_HEADSET | SND_JACK_MECHANICAL |
-			SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2 |
-			SND_JACK_BTN_3 | SND_JACK_BTN_4 | SND_JACK_BTN_5,
-			&priv->headset_jack);
+	ret = snd_soc_card_jack_new_pins(card, "Headset",
+					 SND_JACK_HEADSET | SND_JACK_MECHANICAL |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2 |
+					 SND_JACK_BTN_3 | SND_JACK_BTN_4 | SND_JACK_BTN_5,
+					 &priv->headset_jack,
+					 headset_jack_pins,
+					 ARRAY_SIZE(headset_jack_pins));
 	if (ret)
 		return ret;
 
-- 
2.40.1

