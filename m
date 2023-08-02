Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0CA76D64D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjHBSAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbjHBR7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:59:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E00A30E3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so1248345e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999116; x=1691603916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zh/WX6wdJak4IhHc3jkL9iRoK+aXWh9O/IfQG1cm3A=;
        b=FTZxpdE5nx4Y6zQSk5bttaigS8VbRibjeKA3ZCREfPBwHaEibBv3iLD8k9qccZtT4e
         aZD09HP28KJsaWIUcrXrs3CEfvpd914hlqO0hNaxO+EcVsCXWA3vsRV4ehJWIiH1Wa0m
         4wn57sn5rhYJtHRamKiJfDg/rbcpFgEruL5xAQ7YaHmSl9EWcj3T/Pi3Ruxn6R3agW0U
         m+zQSRysHJ6Kd21dByfuCnyzcfIkxTRth8K/1GH0i/4tP1L1mi7NreUMNxUpIAAYSQbp
         hIF7YEYJeeGSJu2iNQs7+/vSCrUJNyZEcw3URHIRTTdBEPpYg3W/+WNWflv31jJ54L80
         39AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999116; x=1691603916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zh/WX6wdJak4IhHc3jkL9iRoK+aXWh9O/IfQG1cm3A=;
        b=VqG/Bq1HIolk4Emvm1IIJxllEIFlnkK6mwWEqEniEyaO8+Lor3nxg9cREEYHuzztD1
         /xDo6zS5GwJCaHtbx2h4UyBKS7u5MxWzM9lkrRys1joTGEKUdbatfTKE7ILTSRmKItUB
         KVGauggwurP7gwD5iSHGGbUff9S85J5ltZUzVCspbbFgMkopDO2xrjm9fyiyxtaNryE/
         KTnNpuX/uH8Dq0MAif/iioyqjdn6Fpk13hWjwBU00jLHCmxQJS8/TcBIqN2JqL1mtqAD
         pldkf8vELgfnhwbVQ//5QPi/JyDWVKUw6/7LYEY17bhXahz1lBdbKTd4b+iVsDVg4Pcs
         3rCA==
X-Gm-Message-State: ABy/qLbASzBWcZx+akVIcM40HodXz1g3ZAfFhJiBLP8uchVT3Ej+1N1F
        2WDgwvDQl1lXUFOSc7H9/jg=
X-Google-Smtp-Source: APBJJlFfB53UV8DUxJrlC5VR+KxGVU5uRRmKWxImfq+r4JmICNTmBkIhF7ae8zlkVAqNbIoOqNS/zQ==
X-Received: by 2002:a05:600c:20cb:b0:3f8:2777:15e with SMTP id y11-20020a05600c20cb00b003f82777015emr5232003wmm.31.1690999115687;
        Wed, 02 Aug 2023 10:58:35 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:35 -0700 (PDT)
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
Subject: [PATCH 21/27] ASoC: qcom: sc7280: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:31 +0300
Message-Id: <20230802175737.263412-22-alpernebiyasak@gmail.com>
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
Should the SND_JACK_LINEOUT be removed from the jack_new_pins calls?
Would SND_JACK_MECHANICAL be useful as a kcontrol as well?

 sound/soc/qcom/sc7280.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index 787dd49e03f6..43010e4e2242 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -43,6 +43,17 @@ static void sc7280_jack_free(struct snd_jack *jack)
 	snd_soc_component_set_jack(component, NULL, NULL);
 }
 
+static struct snd_soc_jack_pin sc7280_jack_pins[] = {
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
 static int sc7280_headset_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
@@ -54,13 +65,15 @@ static int sc7280_headset_init(struct snd_soc_pcm_runtime *rtd)
 	int rval, i;
 
 	if (!pdata->jack_setup) {
-		rval = snd_soc_card_jack_new(card, "Headset Jack",
-					     SND_JACK_HEADSET | SND_JACK_LINEOUT |
-					     SND_JACK_MECHANICAL |
-					     SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-					     SND_JACK_BTN_2 | SND_JACK_BTN_3 |
-					     SND_JACK_BTN_4 | SND_JACK_BTN_5,
-					     &pdata->hs_jack);
+		rval = snd_soc_card_jack_new_pins(card, "Headset Jack",
+						  SND_JACK_HEADSET | SND_JACK_LINEOUT |
+						  SND_JACK_MECHANICAL |
+						  SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+						  SND_JACK_BTN_2 | SND_JACK_BTN_3 |
+						  SND_JACK_BTN_4 | SND_JACK_BTN_5,
+						  &pdata->hs_jack,
+						  sc7280_jack_pins,
+						  ARRAY_SIZE(sc7280_jack_pins));
 
 		if (rval < 0) {
 			dev_err(card->dev, "Unable to add Headset Jack\n");
@@ -361,6 +374,11 @@ static const struct snd_soc_dapm_widget sc7280_snd_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 };
 
+static const struct snd_kcontrol_new sc7280_snd_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
 static int sc7280_snd_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 					 struct snd_pcm_hw_params *params)
 {
@@ -396,6 +414,8 @@ static int sc7280_snd_platform_probe(struct platform_device *pdev)
 
 	card->dapm_widgets = sc7280_snd_widgets;
 	card->num_dapm_widgets = ARRAY_SIZE(sc7280_snd_widgets);
+	card->controls = sc7280_snd_controls;
+	card->num_controls = ARRAY_SIZE(sc7280_snd_controls);
 
 	ret = qcom_snd_parse_of(card);
 	if (ret)
-- 
2.40.1

