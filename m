Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521BF76D63E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjHBR7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjHBR6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA32EA3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so1193025e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999096; x=1691603896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6nMyjPDcYHJiCu1T+2rryAVPMQB1lBdVoigClnfhE0=;
        b=Pq/1FGIBfPTM8xlFaIMjn1o5wOEU2kj7KT9xR0Ocy74eFT33CbYnmhRBhR6j9R5E17
         JY+Ym9jIvVshplH76FYvLhFYDjAequ6p4yKAyd3p6zPGrYwKGxSUorDNyq0sEIxqk7V6
         TDesnd7jp/JgGl2o6TMcfn8Z5DQzwD5vJ92w2OXss9yUzTbZvDRkzz98k0NPHU4lyIoK
         5+o21smSqiKlegxyL6wmHLoh6Q/ga98Vws/YXX54PxTQOZaYt8JLCa8h2ZKC4B6Qiaew
         snYgYsWQok08PMvzc99N5232Ue9F0+AETxpai+w0wlrgq+1Va0fLhnWWgx3x3Jw95BIl
         qxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999096; x=1691603896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6nMyjPDcYHJiCu1T+2rryAVPMQB1lBdVoigClnfhE0=;
        b=PvZXd5BG3zdvuNw+DyOPztR09H5GC+a/K6l9YpgxsTq18bKDISc00c56JQKV1cmXtt
         uihFucrNIuoeax8JqwCDhwSgUHs8w4FUBJaHbnyE1BnarQEHajZmOjaZOz5DatMNEYss
         5Nqhy7jsxjjtF1j5WbmVZJcvZV74Oal5yMESr3skJol4umbnHbGulTckztA0EzP1AwY0
         BHn+2Te3qm2Yf42GAuFXao47epcskPIUGxjDHW1U16tJ7qZj0t58vGds376woK7NjrjP
         hWbgWwCTGKLXsK5KUtZItFoXSG+g86d3EEHL2cjfjb8HHvQuqewe7h0QS8jLQSyg1aVr
         jVRg==
X-Gm-Message-State: ABy/qLZ2Jltg+ZNmr/japd9j+vp19G5j01QXfWeMKda1qRWJY3u5MQje
        tuy44O2IxST9XPJDpEOYM6Y=
X-Google-Smtp-Source: APBJJlGPaCnmxQZeBSmFQkM3APRCZ94arRA5batOsSBNcMoomdpSEqWIssz4EhlEA3s+ieoFUM4XnQ==
X-Received: by 2002:a1c:f202:0:b0:3fb:f926:4937 with SMTP id s2-20020a1cf202000000b003fbf9264937mr5004542wmc.31.1690999096274;
        Wed, 02 Aug 2023 10:58:16 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:15 -0700 (PDT)
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
Subject: [PATCH 11/27] ASoC: imx-es8328: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:21 +0300
Message-Id: <20230802175737.263412-12-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802175737.263412-1-alpernebiyasak@gmail.com>
References: <20230802175737.263412-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver does not properly map jack pins to kcontrols that PulseAudio
and PipeWire need to handle jack detection events. It seems to have a
single detection GPIO pin used to report everything as a Headset. But it
has widgets for Headphone and Mic Jack, so expose both to userspace as
kcontrols.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Also see https://github.com/xobs/pulseaudio-novena though I don't
really understand PulseAudio configuration.

 sound/soc/fsl/imx-es8328.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 85bd36fb68a2..6f0d031c1d5f 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -37,6 +37,16 @@ static struct snd_soc_jack_gpio headset_jack_gpios[] = {
 };
 
 static struct snd_soc_jack headset_jack;
+static struct snd_soc_jack_pin headset_jack_pins[] = {
+	{
+		.pin = "Headphone",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Mic Jack",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
 
 static int imx_es8328_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -46,9 +56,11 @@ static int imx_es8328_dai_init(struct snd_soc_pcm_runtime *rtd)
 
 	/* Headphone jack detection */
 	if (gpio_is_valid(data->jack_gpio)) {
-		ret = snd_soc_card_jack_new(rtd->card, "Headphone",
-					    SND_JACK_HEADPHONE | SND_JACK_BTN_0,
-					    &headset_jack);
+		ret = snd_soc_card_jack_new_pins(rtd->card, "Headphone",
+						 SND_JACK_HEADSET | SND_JACK_BTN_0,
+						 &headset_jack,
+						 headset_jack_pins,
+						 ARRAY_SIZE(headset_jack_pins));
 		if (ret)
 			return ret;
 
@@ -68,6 +80,11 @@ static const struct snd_soc_dapm_widget imx_es8328_dapm_widgets[] = {
 	SND_SOC_DAPM_REGULATOR_SUPPLY("audio-amp", 1, 0),
 };
 
+static const struct snd_kcontrol_new imx_es8328_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Mic Jack"),
+};
+
 static int imx_es8328_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -183,6 +200,8 @@ static int imx_es8328_probe(struct platform_device *pdev)
 	data->card.dev = dev;
 	data->card.dapm_widgets = imx_es8328_dapm_widgets;
 	data->card.num_dapm_widgets = ARRAY_SIZE(imx_es8328_dapm_widgets);
+	data->card.controls = imx_es8328_controls;
+	data->card.num_controls = ARRAY_SIZE(imx_es8328_controls);
 	ret = snd_soc_of_parse_card_name(&data->card, "model");
 	if (ret) {
 		dev_err(dev, "Unable to parse card name\n");
-- 
2.40.1

