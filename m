Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2919A76D646
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjHBR7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjHBR65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016C51734
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso1210925e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999110; x=1691603910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyXZmbrejVy6oU7P85KygnAFUmokjdS7T3od5TZzPV0=;
        b=o61PY30OWJEqIsIJbqjC2wEfrFt++nmLh2bc7nDkGL4MxB0bYYDOddvwOSTvGgO9/1
         RHnKe82BAvOY83+5Xd7YOx6OdqDvUJ9VfsRQaxg410gY6M8Z1JzmF12gvrgEX+EXNG9i
         Bwn0OqH9bVANcCIpVEZci0Iki55/dZZrXWhvR3962AXTLoDu8IV6Cgx415uAlEIIhQxX
         P1ta1eLDdskcspu7cWdvn25AoQdd7Ot8Vb4AsPGUfqe40RI/3U7vpm2361KN1PXfCLP2
         lKV9u/gO3uLo2KNITq31zmI+fiqfmVrYKpoaPaqovx35yulDGwhwI9Psm2w6ScUR+/1x
         Kk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999110; x=1691603910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyXZmbrejVy6oU7P85KygnAFUmokjdS7T3od5TZzPV0=;
        b=KCNqpkArp509rrV5TknS3GF/J9tCMgpmoerL9UoViiLJ/aUB/x5y6fa+EK89weaqnf
         mscITwZVe21Kv+q5z82Txy7a48hQ/4hSPRhMBYuHdszG+mmW8umfggPMHLHhCNhZBFzb
         nhnBdwkAYa2pkbyRvJUhdfFBur01dVxhIxfWkWa9yKTK3lgVNrcuWKLOZNyoEYFzu7gk
         HaYJKowZCH0MDcCnIba1vA4QOGGlRX9g8PWg2Jxo0XKPIY885jpVG0LUulS/27JOh7a4
         vNPmhcD1ZPZkGJLfzfgGPO323VZW7XtuAe4ctQKNdRTm7tAY2o4ox2Fg1NCsGqVxH7vg
         Cqig==
X-Gm-Message-State: ABy/qLadoa5sxpJesGWGwixnLPQI/Sv1EPefJ4mnlqak8TpBLKaV87PR
        VohUuE2t2irOPi/V4rbDLpM=
X-Google-Smtp-Source: APBJJlG6lh7xO8s7gdwcdPpW393CzJ8GrsGTZ/O8tPJvPn73H1VkhPTU437+89OuIPBLICk0Dx6pWw==
X-Received: by 2002:a1c:7714:0:b0:3fb:be7c:d58a with SMTP id t20-20020a1c7714000000b003fbbe7cd58amr4909567wmi.26.1690999109889;
        Wed, 02 Aug 2023 10:58:29 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:29 -0700 (PDT)
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
Subject: [PATCH 18/27] ASoC: mediatek: mt8186-mt6366-da7219-max98357: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:28 +0300
Message-Id: <20230802175737.263412-19-alpernebiyasak@gmail.com>
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

Commit 8e9867486806 ("ASoC: mediatek: mt8186-da7219: Expose individual
headset jack pins") maps kcontrols for Headphone and Headset Mic jacks
for this driver so that PulseAudio and PipeWire can handle jack
detection events for these peripherals.

The DA7219 codec used here can also distinguish between Headphone and
Line Out connections that go into the same physical port. Expose the
latter to userspace as a kcontrol as well and add the necessary widgets.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
index 0432f9d89020..aa8e00bba19b 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
@@ -46,6 +46,10 @@ static struct snd_soc_jack_pin mt8186_jack_pins[] = {
 		.pin = "Headset Mic",
 		.mask = SND_JACK_MICROPHONE,
 	},
+	{
+		.pin = "Line Out",
+		.mask = SND_JACK_LINEOUT,
+	},
 };
 
 static struct snd_soc_codec_conf mt8186_mt6366_da7219_max98357_codec_conf[] = {
@@ -964,6 +968,7 @@ mt8186_mt6366_da7219_max98357_widgets[] = {
 	SND_SOC_DAPM_SPK("Speakers", NULL),
 	SND_SOC_DAPM_HP("Headphones", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
 	SND_SOC_DAPM_OUTPUT("HDMI1"),
 	SND_SOC_DAPM_MIXER(SOF_DMA_DL1, SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER(SOF_DMA_DL2, SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -996,6 +1001,7 @@ mt8186_mt6366_da7219_max98357_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Speakers"),
 	SOC_DAPM_PIN_SWITCH("Headphones"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Line Out"),
 	SOC_DAPM_PIN_SWITCH("HDMI1"),
 };
 
-- 
2.40.1

