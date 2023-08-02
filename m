Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328AA76D64C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbjHBSAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjHBR7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:59:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3990F35B5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso1390055e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999118; x=1691603918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivMSWY5W5vVdPZxQIPJMmrp6wGH4fY48CYl1yy0Ej0E=;
        b=MqN6xWERzMdTN+8tcVQSYKf9fLJTD2JZeiFLCObyl03B60/xzXmwB02zYmsL/6x5bh
         OypDvc0pipYf79vcMZBq/krvgrlOWmGzv8CDKGkHLLK7TgJU4MVfnrvrDh2thBvBT1dd
         QkoovvMpj5cgJVQfpsnAXhS6tMxnLU+wwEHTjMLCX3OtsGSbWfFbxjftEWlabVbs5EUY
         aXBMEU+9yTyyFnJ/4at2Acvmhpbn5B/B0LUutW3a7+HLu8sBqpNyPmx1mb4Zg4z+wi6+
         1LcEYnMoL85zbG7A/QuYxq6WKO5Hj0q4Bbg+zKZFayu/C06IqhWqdqwCKyAN/n6clMZC
         myAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999118; x=1691603918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivMSWY5W5vVdPZxQIPJMmrp6wGH4fY48CYl1yy0Ej0E=;
        b=R1/KtXHANJqU9zHoF9HdwPKYCOKMfrNQ6xVaFPDrcyzlB9pwPdSVNB6isBmxGUQAdI
         uiuWAz+osQmLilTuonAjEjCRVokn2Ur7wP4MNQpmee+TSXo82AX/gSEKIJP8Hxvu8BvU
         xOZOOM0uRp+GZvZ0qStwtGG2GPVlnREFBhPFyR9sfZDZd0tW2MSl2q/3lqi9KdEehXUn
         X2CwmSGzkTeS5t2ixvyMmu/FkfFgT/nKi4nY+9Q2MDHsn4ZrHSsRz7uaFKGvj5BwjYkd
         S6GgjuKk9XVu6BObFk15Ui2befEnCr/aDzqC3Yhux9zJXcm4bZRP5p+0f3jJNSZy79Dz
         ct6w==
X-Gm-Message-State: ABy/qLZMYKptqGT3ILTMdoyT45cshfy8zhHr1OltAHfInZodqOub6fHZ
        20DAeLEq26IHQFQUsSeEeeE=
X-Google-Smtp-Source: APBJJlGB+L4H3MvyOOJOR2XlHFtV3VEIC2qwY2/AoQPP1pkVYrM+PTm/KjqODvQdydcUzgWfP3aCAA==
X-Received: by 2002:a7b:cc12:0:b0:3fb:dd9c:72d2 with SMTP id f18-20020a7bcc12000000b003fbdd9c72d2mr5153102wmh.31.1690999117652;
        Wed, 02 Aug 2023 10:58:37 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:37 -0700 (PDT)
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
Subject: [PATCH 22/27] ASoC: qcom: sdm845: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:32 +0300
Message-Id: <20230802175737.263412-23-alpernebiyasak@gmail.com>
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
and PipeWire need to handle jack detection events. The RT5663 codec used
here can detect Headphone and Headset Mic connections. Expose each to
userspace as a kcontrol.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 sound/soc/qcom/sdm845.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 02612af714a8..29d23fe5dfa2 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -42,6 +42,17 @@ struct sdm845_snd_data {
 	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
 };
 
+static struct snd_soc_jack_pin sdm845_jack_pins[] = {
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
+
 static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
 
 static int sdm845_slim_snd_hw_params(struct snd_pcm_substream *substream,
@@ -242,12 +253,14 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 
 
 	if (!pdata->jack_setup) {
-		rval = snd_soc_card_jack_new(card, "Headset Jack",
-				SND_JACK_HEADSET |
-				SND_JACK_HEADPHONE |
-				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				&pdata->jack);
+		rval = snd_soc_card_jack_new_pins(card, "Headset Jack",
+						  SND_JACK_HEADSET |
+						  SND_JACK_HEADPHONE |
+						  SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+						  SND_JACK_BTN_2 | SND_JACK_BTN_3,
+						  &pdata->jack,
+						  sdm845_jack_pins,
+						  ARRAY_SIZE(sdm845_jack_pins));
 
 		if (rval < 0) {
 			dev_err(card->dev, "Unable to add Headphone Jack\n");
@@ -539,6 +552,11 @@ static const struct snd_soc_dapm_widget sdm845_snd_widgets[] = {
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
 };
 
+static const struct snd_kcontrol_new sdm845_snd_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
 static void sdm845_add_ops(struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link *link;
@@ -572,6 +590,8 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 	card->driver_name = DRIVER_NAME;
 	card->dapm_widgets = sdm845_snd_widgets;
 	card->num_dapm_widgets = ARRAY_SIZE(sdm845_snd_widgets);
+	card->controls = sdm845_snd_controls;
+	card->num_controls = ARRAY_SIZE(sdm845_snd_controls);
 	card->dev = dev;
 	card->owner = THIS_MODULE;
 	dev_set_drvdata(dev, card);
-- 
2.40.1

