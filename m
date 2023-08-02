Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D85476D63C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjHBR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjHBR56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:57:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0A51713
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:57:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313e742a787so84728f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999076; x=1691603876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brF3soBTEQ7lATGtnS3zYxb7mTThtaUthI8D9XqkA8U=;
        b=kZWYUQ2zZqRsD5oZlb5Tp99pT8j2KFnXx/x0wYpcz3Ah+nAL+XycehI0yWOotAftmg
         Zq1+7eTn8w4mVc3czxO7dqDi9+Idxh/kp+08TSOmFudi+6m/GU/xgGcR8ZNoo6f4zYqJ
         TBXShkSvrwbDN9hr3vP9r3P/Hc7RBRyeHCz5nrPiLF76GrjqwW8YQeM5ynJr5fSA/KSJ
         pXBKvI9BVt7GpJl6NxZBndooXEhrO9TsuC3YRKAhl0S37bi/w2tGttNvBeQsJ6Vhu+3y
         mOfG4sTPucFQdCX+SQQddJE6b5ewcSmuJFQaZxsP8/EJB1IqAyKhOeRgxA4IqODXHj+f
         VMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999076; x=1691603876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brF3soBTEQ7lATGtnS3zYxb7mTThtaUthI8D9XqkA8U=;
        b=HpzvEfn1RGkqGDB9mz/P57gLJBZ8fnb3Ilntj8Oueo14omFbNlIXRs5KTaZ2Pg+p0G
         jLEMf9wAElxwEtVZxgdYw1xfD0b6m7RLC7jt+pdzp01Da4xin05/Imuh0tpfguj/m7z8
         b4FyVV0zsii0luHBcyJkWRBOEeFrPzEjXVLvlr8dFz7X3c3IC4GQM2wP70ljXH4FNV38
         LXeFkYs8yHuTzytXgiive94H8rM+dGSxwtiN/uTNEAlH5rxcefZm4g5x9c3nRyCMhgJd
         wiyq1EfxOmalLIBdCSMlcsZ5me7xDV9nuia4aj378lhQijPTKaVbBQvybvYUlW4aC5L0
         wndA==
X-Gm-Message-State: ABy/qLbjYjh0PJyxRyCpNHq0Bw/rj8c1cbuMozDnSC21VQIwJwtvNjNv
        VkbrAvsRJ7giQmlfegS0ugOkBeJGT2E=
X-Google-Smtp-Source: APBJJlGS3n72jelR+5CW5X/s/y1sftl/stCBASnlJP6scTtObuQyQ2mFLQUolQRV7m0Ede6z6aQhzw==
X-Received: by 2002:adf:e546:0:b0:317:6570:afec with SMTP id z6-20020adfe546000000b003176570afecmr5701405wrm.3.1690999076398;
        Wed, 02 Aug 2023 10:57:56 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:57:56 -0700 (PDT)
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
Subject: [PATCH 01/27] ASoC: amd: acp-da7219-max98357a: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:11 +0300
Message-Id: <20230802175737.263412-2-alpernebiyasak@gmail.com>
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

 sound/soc/amd/acp-da7219-max98357a.c | 41 +++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 7464ca2b596c..9e3133bec2b1 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -28,6 +28,21 @@
 #define RT5682_PLL_FREQ (48000 * 512)
 
 static struct snd_soc_jack cz_jack;
+static struct snd_soc_jack_pin cz_jack_pins[] = {
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
+};
+
 static struct clk *da7219_dai_wclk;
 static struct clk *da7219_dai_bclk;
 static struct clk *rt5682_dai_wclk;
@@ -66,11 +81,13 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	if (IS_ERR(da7219_dai_bclk))
 		return PTR_ERR(da7219_dai_bclk);
 
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				SND_JACK_HEADSET | SND_JACK_LINEOUT |
-				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				&cz_jack);
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &cz_jack,
+					 cz_jack_pins,
+					 ARRAY_SIZE(cz_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
@@ -146,11 +163,13 @@ static int cz_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 	if (IS_ERR(rt5682_dai_bclk))
 		return PTR_ERR(rt5682_dai_bclk);
 
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &cz_jack);
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &cz_jack,
+					 cz_jack_pins,
+					 ARRAY_SIZE(cz_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
@@ -631,6 +650,7 @@ static struct snd_soc_dai_link cz_dai_5682_98357[] = {
 static const struct snd_soc_dapm_widget cz_widgets[] = {
 	SND_SOC_DAPM_HP("Headphones", NULL),
 	SND_SOC_DAPM_SPK("Speakers", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
 };
@@ -654,6 +674,7 @@ static const struct snd_soc_dapm_route cz_rt5682_audio_route[] = {
 static const struct snd_kcontrol_new cz_mc_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphones"),
 	SOC_DAPM_PIN_SWITCH("Speakers"),
+	SOC_DAPM_PIN_SWITCH("Line Out"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Int Mic"),
 };
-- 
2.40.1

