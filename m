Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F09276D63D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjHBR65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjHBR6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BEA171B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so8093125e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999082; x=1691603882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giLlDxuohbavL/Eh+3qVG6gVGzv5UIQjKSZ5ky1GgcY=;
        b=dcwAI3ZOa09tYBw11uCkrcP1OCcx4OyU/Z2uu9sLT5AszyF0lL7xMJbuSicjUawgVQ
         vlq+yryK2kPnMHPGqA5rcrihs4+1jXfiYJqkcQJhcdhlmTdFA9QrA8uIJ9qEcdDjvvwi
         gSen/5PdQG2pvGa0ablMsZbEGUlO9cl3Q4hvS/WeCKdeTkOi81yTmdc2Gd/mH+EdZOnw
         YFeNflvIxZHVme6PqVUEaION84HAS6+Q7qydRmDPcdFWKNA95ES/zGOlztxFs2x+n/Ub
         4pTXJtsw3z+RinV7DbimCQmbIKC2n6RdBY6FICujmbL94WxJ/9++gOhbx9bY9svVsoH3
         t4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999082; x=1691603882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giLlDxuohbavL/Eh+3qVG6gVGzv5UIQjKSZ5ky1GgcY=;
        b=WTxFvILYbOmuQylQEoJs7UrNAtDu0Qv81uMqe09a1yhD85k+dSSlBcvqCkdeY4a9Qw
         j8bkIiZPSBR0tTo5mAcJsB37/KLgEcjmT/n60t3Iu6nCo8J3SvxOZ02orfTYBTfofmKU
         O0NSbku2L/a57DqNgLfoHpLfLTEDb5nA6sqq3BdhLA4fG126cQZR+4uf9VSz+SdKn1hV
         /DpOQJWLrvBHVL531abb3LwcflbC5v/srs3+BVj9bBYTTYs/8/K8POqn3UPHllkUqGMv
         lEWtEGNjYa19I7yuq8fF0/in0/JiYEtZQLsXdIuyEDw+po0bPqFT5l3RyArX8JxNYK9o
         c0bQ==
X-Gm-Message-State: ABy/qLYkfOGmp07kFoeeNy0WVqxxWa/M12uP/yH9hH6yA3/lcFIEXPuq
        qsetAtAw1Dq0lXwtVgLulXQ=
X-Google-Smtp-Source: APBJJlHsDaCjAi4zBTU9xrF27hqoMFD5e0yhCUCynaZ/vT7KHt4B0IwuLDdQmQ7FEXmHdswWOSfPSw==
X-Received: by 2002:a05:6000:1152:b0:317:58a4:916f with SMTP id d18-20020a056000115200b0031758a4916fmr6105223wrx.33.1690999082349;
        Wed, 02 Aug 2023 10:58:02 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:01 -0700 (PDT)
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
Subject: [PATCH 04/27] ASoC: amd: acp3x-rt5682-max9836: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:14 +0300
Message-Id: <20230802175737.263412-5-alpernebiyasak@gmail.com>
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
and PipeWire need to handle jack detection events. The RT5682, RT1015
and RT1015p codecs used here can detect Headphone and Headset Mic
connections. Expose the former two to userspace as kcontrols.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Should the SND_JACK_LINEOUT be removed from the jack_new_pins calls?

 sound/soc/amd/acp3x-rt5682-max9836.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 0543dda75b99..3bf7e1e83c36 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -28,6 +28,17 @@
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack pco_jack;
+static struct snd_soc_jack_pin pco_jack_pins[] = {
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
 static struct clk *rt5682_dai_wclk;
 static struct clk *rt5682_dai_bclk;
 static struct gpio_desc *dmic_sel;
@@ -86,11 +97,13 @@ static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
 	rt5682_dai_wclk = clk_get(component->dev, "rt5682-dai-wclk");
 	rt5682_dai_bclk = clk_get(component->dev, "rt5682-dai-bclk");
 
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				SND_JACK_HEADSET | SND_JACK_LINEOUT |
-				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				&pco_jack);
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &pco_jack,
+					 pco_jack_pins,
+					 ARRAY_SIZE(pco_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
-- 
2.40.1

