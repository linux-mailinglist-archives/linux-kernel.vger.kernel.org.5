Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E96576D648
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjHBR7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjHBR70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:59:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8402D7B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so1310475e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999114; x=1691603914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+3O1DghoKTsvX8XNtwYPlplZlPGOuzWPkOeAp7AhV4=;
        b=PgoxqIWgtjL86OEBXvSnfsDkFquIuj6IG9GHhXDef7BAFe669yJ8pdHyvfdrYYwBlD
         GJC2YPeLVB7RRDLPXxqeK7DpCf64n+Y0JfuX5QUFoCDLTA1cTLmqwK6MWJXNnoQn9lZ9
         Fnm5eKJbAGoQRfBAAA6Vkn/yc7R5iHcMtX3E9pHKhDjSa85/yQQQfd0ZF1wY8dwEV2AL
         RoC+t9Qx2nm1lUj1c6k9px/zJAIAwTEAFH73/bvyf5o51OKy6gwrFhdABUXUOoaSHxP5
         6UfFHPVJT8zl7mMVEEeo5atAu8JrfZkm8Ve/hqIvlWLmt78EyLV8gdlSoDrl+9IaOsBt
         k2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999114; x=1691603914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+3O1DghoKTsvX8XNtwYPlplZlPGOuzWPkOeAp7AhV4=;
        b=TeGn/xX2cOeCQwOl5XOyrAXQDIWbi6SnYRaEKMOECGz+UPRaGFqEvivvu+9yfWB0/U
         UjCcVU4qIJDnKybY0TWfkHTQVI/lx+b4wmSv6k5Wf1N5rgXKgBSaC7507oCptNPlj9z3
         W/Xu6sTEh7IK1BvkFvog/k7tU1iAjKfCRTOVURpvaejEOGxC2WnglR9jB8pphbm7hok/
         S2rEmvPJw/NkHNFPT1RhF7QU/pk5yutBXq6Ce8vCnVrvu9YPp93FeRA3wd98PAcmMFVN
         l3qVNj+LFw7qdvVnVKwF/usjadhzoIS/sIAcltYwPIRxhb8cYiYTZO/M+rjJAOFdufoo
         CBTw==
X-Gm-Message-State: ABy/qLbwGfayC7Oyob2NQuPDY/Sp8dzhNTN7Wk2QQlbsf6cs9D11hpLT
        pHMaRWrPTp9gbNW5LoA5TgU=
X-Google-Smtp-Source: APBJJlFXfxujtj6YpCKjtWZNCMBWWVwJcXqOlCDQOj6i8alThDmQeh9bj8gaybKQUMc6C5J1umD6GQ==
X-Received: by 2002:a7b:c5d9:0:b0:3f7:678c:74b0 with SMTP id n25-20020a7bc5d9000000b003f7678c74b0mr5632761wmk.12.1690999113752;
        Wed, 02 Aug 2023 10:58:33 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:33 -0700 (PDT)
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
Subject: [PATCH 20/27] ASoC: qcom: sc7180: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:30 +0300
Message-Id: <20230802175737.263412-21-alpernebiyasak@gmail.com>
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
and PipeWire need to handle jack detection events. The RT5682 and
RT5682s codecs used here can detect Headphone and Headset Mic
connections. Expose each to userspace as a kcontrol.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 sound/soc/qcom/sc7180.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/sound/soc/qcom/sc7180.c b/sound/soc/qcom/sc7180.c
index f5f7c64b23a2..57c5f35dfcc5 100644
--- a/sound/soc/qcom/sc7180.c
+++ b/sound/soc/qcom/sc7180.c
@@ -42,6 +42,17 @@ static void sc7180_jack_free(struct snd_jack *jack)
 	snd_soc_component_set_jack(component, NULL, NULL);
 }
 
+static struct snd_soc_jack_pin sc7180_jack_pins[] = {
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
 static int sc7180_headset_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
@@ -51,13 +62,14 @@ static int sc7180_headset_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_jack *jack;
 	int rval;
 
-	rval = snd_soc_card_jack_new(
-			card, "Headset Jack",
-			SND_JACK_HEADSET |
-			SND_JACK_HEADPHONE |
-			SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-			SND_JACK_BTN_2 | SND_JACK_BTN_3,
-			&pdata->hs_jack);
+	rval = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					  SND_JACK_HEADSET |
+					  SND_JACK_HEADPHONE |
+					  SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					  SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					  &pdata->hs_jack,
+					  sc7180_jack_pins,
+					  ARRAY_SIZE(sc7180_jack_pins));
 
 	if (rval < 0) {
 		dev_err(card->dev, "Unable to add Headset Jack\n");
@@ -297,6 +309,11 @@ static const struct snd_soc_dapm_widget sc7180_snd_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 };
 
+static const struct snd_kcontrol_new sc7180_snd_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
 static const struct snd_soc_dapm_widget sc7180_adau7002_snd_widgets[] = {
 	SND_SOC_DAPM_MIC("DMIC", NULL),
 };
@@ -320,6 +337,11 @@ static const struct snd_soc_dapm_widget sc7180_snd_dual_mic_widgets[] = {
 	SND_SOC_DAPM_MUX("Dmic Mux", SND_SOC_NOPM, 0, 0, &sc7180_dmic_mux_control),
 };
 
+static const struct snd_kcontrol_new sc7180_snd_dual_mic_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
 static const struct snd_soc_dapm_route sc7180_snd_dual_mic_audio_route[] = {
 	{"Dmic Mux", "Front Mic", "DMIC"},
 	{"Dmic Mux", "Rear Mic", "DMIC"},
@@ -348,10 +370,14 @@ static int sc7180_snd_platform_probe(struct platform_device *pdev)
 	card->dev = dev;
 	card->dapm_widgets = sc7180_snd_widgets;
 	card->num_dapm_widgets = ARRAY_SIZE(sc7180_snd_widgets);
+	card->controls = sc7180_snd_controls;
+	card->num_controls = ARRAY_SIZE(sc7180_snd_controls);
 
 	if (of_property_read_bool(dev->of_node, "dmic-gpios")) {
 		card->dapm_widgets = sc7180_snd_dual_mic_widgets,
 		card->num_dapm_widgets = ARRAY_SIZE(sc7180_snd_dual_mic_widgets),
+		card->controls = sc7180_snd_dual_mic_controls,
+		card->num_controls = ARRAY_SIZE(sc7180_snd_dual_mic_controls),
 		card->dapm_routes = sc7180_snd_dual_mic_audio_route,
 		card->num_dapm_routes = ARRAY_SIZE(sc7180_snd_dual_mic_audio_route),
 		data->dmic_sel = devm_gpiod_get(&pdev->dev, "dmic", GPIOD_OUT_LOW);
-- 
2.40.1

