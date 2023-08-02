Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4236276D64F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjHBSAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjHBR7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:59:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D33170D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso1620375e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999119; x=1691603919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r84U5vKKrOG5iP+/wELvgXipD3A/eO08Kh4+Yu4iiLQ=;
        b=nHvmRKQk5b0vvll7cRuFQ7yoULx2W60YBSzafVOipAk+XPMA8mPPGqUgJV5xCmYOU0
         gUtYmyflcfvJXSSR2WUKfg85Tp5fSaAtVixDhdKxpaHWJc3KEc6mMuIy1Tv2J8XGm3iB
         bPNo6aUDpnWdTtNkPHDxcTcSCxej+8+wlyPHrbiK8DMpgI8n8ocrxuzsVmXYZAqY/1fN
         pH4stOJyWoP8mIDGSUwiznE8EV8K4oRD4+GbYUkPs03oGIZwVVJ+Luv3Es7Kq3TwFLwV
         7s4p5wlBgIL/FOB4fj8pQnSegH0AwAS5XW9+b4b1qLDAs8Z25gjf63SBb813WGwEgGhu
         TxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999119; x=1691603919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r84U5vKKrOG5iP+/wELvgXipD3A/eO08Kh4+Yu4iiLQ=;
        b=GBdofa7aWUHtDYtUpX6wrelWBs2Tie6S70DryBysFfuTmu680e/cRMTpuzq3lLIHBN
         cA37GhhX+efc/X/z+QLRUKLmxog0/xXZt/HERbt7NF9BZPKhZdwObFy24xq57p5R0CJq
         MqthqPBsUPPjrMP5DZ4hatH+8SRoZ+xvMHtmi5TV4HleGTpJU3trPCqCkuCqvGsJO5WE
         LenIL2Oi4v+pst0vLaXMQRU8GuvuoUTIs9T/VqlBLlxI8dh7/qLozaVeMAm3AUUwu31Q
         aaFDr/OzwOL2KDk/DGW8j9ltodTq16Nkvnqvgkmd3pAKgX8AyxyrtquamtO1nKTwPI9m
         Hqug==
X-Gm-Message-State: ABy/qLaCOI7HFq0RUVIg+D68zyluogLoNlxxOEziZfL0Sd8xoLvvbeOk
        yynNfM119u06Mz2c5zzS0wk=
X-Google-Smtp-Source: APBJJlHTdTr6GABuL8o6Z9U1QvO2dPaRIzK5YY/L5EMLjePFSuhtQUmUrLD+p8BRkDSBML7H+lgVcQ==
X-Received: by 2002:a05:600c:215:b0:3fe:173e:4a54 with SMTP id 21-20020a05600c021500b003fe173e4a54mr5247511wmi.17.1690999119701;
        Wed, 02 Aug 2023 10:58:39 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:39 -0700 (PDT)
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
Subject: [PATCH 23/27] ASoC: rk3399-gru-sound: Map missing Line Out jack kcontrol
Date:   Wed,  2 Aug 2023 20:57:33 +0300
Message-Id: <20230802175737.263412-24-alpernebiyasak@gmail.com>
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

Commit d0508b4f1604 ("ASoC: rk3399_gru_sound: Add DAPM pins, kcontrols
for jack detection") maps kcontrols for Headphones and Headset Mic jacks
for this driver so that PulseAudio and PipeWire can handle insertion
events for these peripherals.

The DA7219 codec used here can also distinguish between Headphone and
Line Out connections that go into the same physical port. Expose the
latter to userspace as a kcontrol as well and add the necessary widget.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Tested on a "Kevin" Chromebook.

 sound/soc/rockchip/rk3399_gru_sound.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 5e52e9d60d44..0f704d22d21b 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -41,13 +41,17 @@ static struct snd_soc_jack_pin rockchip_sound_jack_pins[] = {
 		.pin = "Headset Mic",
 		.mask = SND_JACK_MICROPHONE,
 	},
-
+	{
+		.pin = "Line Out",
+		.mask = SND_JACK_LINEOUT,
+	},
 };
 
 static const struct snd_soc_dapm_widget rockchip_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphones", NULL),
 	SND_SOC_DAPM_SPK("Speakers", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
 	SND_SOC_DAPM_LINE("HDMI", NULL),
 };
@@ -56,6 +60,7 @@ static const struct snd_kcontrol_new rockchip_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphones"),
 	SOC_DAPM_PIN_SWITCH("Speakers"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Line Out"),
 	SOC_DAPM_PIN_SWITCH("Int Mic"),
 	SOC_DAPM_PIN_SWITCH("HDMI"),
 };
-- 
2.40.1

