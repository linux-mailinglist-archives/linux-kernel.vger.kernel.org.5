Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1293976D640
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjHBR7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjHBR6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6EF171B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so1285895e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999100; x=1691603900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDgex51QiOVczO4DJKkVoIxdj5w2CMw4f9nt7sgUgwU=;
        b=pQwSTdpiBct1ZkFKH+H1jKQOM71C568ZgrH2pqMuH26wTckRnDL3N40AhORENumltE
         zjwoFb1I1dDovAIy1cjl2Dr+ZFGic9XThduhC22I5MFk2XPlqivwWueGL+cCxM+AzFzy
         Vyx1Ymj/T07BBpAX/+KRco3eqLZDfqtRdt4+ZSm9x0ZK/TddmAFKO9q+X12HDOx/t+K6
         zAfhEJSzxqiynoCTVut8YPG/RVeB+upM18gUrWRunggDmtgcCHaw/vLyPclub5WyBd/e
         /T87a3L1YZ13oFytIh/urX2wIxLKRfTXzSuUpXb1yOILqJLYo9nBC++vfZxKCiQy9DC8
         Bm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999100; x=1691603900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDgex51QiOVczO4DJKkVoIxdj5w2CMw4f9nt7sgUgwU=;
        b=YDqhB/+e1ibblxW71sw5WZjBh5enH/6rOsGVHwEim9hs2PkT/xnHxjLhbU7EByOZ+7
         b5e0G6rYNojaOBLulIX/0aSv2RHfEBWquN+gy1kz1+d/B23shH7UO8SYq3BDXX1U7EW6
         0AtndQFxvbpmRQh3GHdkSjstnq0dNY4CPvf+fe8b6ampNj25pHS0NkgQe0pHbI86z/fQ
         jSVvOIJE3BjK6uXAzVeuyIIvIzJT5tjjG2PUT2YDbcwOKS/6VLVC0MBf/g0W26Sw0jaF
         4x20zFGQlEXBC/V8+2IBZ1f7oThS+BD98YFM1S7f+R5w/YXweCxVXqjUZ3uWvaWE0Zh0
         /niQ==
X-Gm-Message-State: ABy/qLapwz/Atvnzp13o0pHk9wAbEpi/VEs0tmRGNlX+Nx/LtRhyr0wd
        DUZC/EhwksCdaFzHIereuwQ=
X-Google-Smtp-Source: APBJJlH91r28l0IKr1hxqWGkEgaBxzgQ1myfYz6eME/NQQKzR9WlFFb9j5LckCL2VDUqkyoCxi0jpg==
X-Received: by 2002:a05:600c:cf:b0:3fe:1f2c:df2b with SMTP id u15-20020a05600c00cf00b003fe1f2cdf2bmr5488486wmm.11.1690999100142;
        Wed, 02 Aug 2023 10:58:20 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:19 -0700 (PDT)
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
Subject: [PATCH 13/27] ASoC: mediatek: mt8173-rt5650-rt5514: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:23 +0300
Message-Id: <20230802175737.263412-14-alpernebiyasak@gmail.com>
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
and PipeWire need to handle jack detection events. The RT5645 codec used
here can detect Headphone and Headset Mic connections. Expose each to
userspace as kcontrols.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 .../mediatek/mt8173/mt8173-rt5650-rt5514.c    | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index f803f121659d..e502cd1670ba 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -40,6 +40,17 @@ static const struct snd_kcontrol_new mt8173_rt5650_rt5514_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 };
 
+static struct snd_soc_jack_pin mt8173_rt5650_rt5514_jack_pins[] = {
+	{
+		.pin	= "Headphone",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
 static int mt8173_rt5650_rt5514_hw_params(struct snd_pcm_substream *substream,
 					  struct snd_pcm_hw_params *params)
 {
@@ -82,11 +93,13 @@ static int mt8173_rt5650_rt5514_init(struct snd_soc_pcm_runtime *runtime)
 				RT5645_CLK_SEL_I2S1_ASRC);
 
 	/* enable jack detection */
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &mt8173_rt5650_rt5514_jack);
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &mt8173_rt5650_rt5514_jack,
+					 mt8173_rt5650_rt5514_jack_pins,
+					 ARRAY_SIZE(mt8173_rt5650_rt5514_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "Can't new Headset Jack %d\n", ret);
 		return ret;
-- 
2.40.1

