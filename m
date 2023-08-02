Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6124476D636
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjHBR63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbjHBR6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184C8A3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbea147034so1550095e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999090; x=1691603890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5Agk2IhTlueKpAaOVZPmPiVBKk+AEjM8QiFyo+WrKQ=;
        b=cH9DcH1DxY4Yz9Q9s2/zqrXiaeWRqIgZsmXk5aOM5TA9zaAmZZtz4Ue5dckgnO/7PR
         LcDuoemcupnv+vTeCNJJqkCm8yylKBrOc40IT40+P6L8HWbHIzKll9CqbUlXScxvxEqK
         YBUi0vnpPisZkI8DvtYQsrZXm7eArwxev7rnIKr+BU6Aa1F8RDAyEdz5rqDYN7GmB1pY
         /zFPekPj6pIE04Pz5oCvTUYWillfyfKmFqAEA92JtC5znNz73IljhlYowHalEOkDIcQj
         bzr4b4xQLJDSuuEIYhHEJhe8I2WL9FetkV1cmP37LVhXf23zYFf3Jc/USF8Nqu5muPyn
         rUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999090; x=1691603890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5Agk2IhTlueKpAaOVZPmPiVBKk+AEjM8QiFyo+WrKQ=;
        b=Vi+1liv7gDPRw8NFzP4BaCzlErKjZQMDBHfGSNbpX9FCk2e95+IxRwMRs2i0jX7ZGi
         NtHutpLrpzlqi1oJ2W5PvPKoeMk4XTsjiy6jalelq7m7OAk0QTRI7Tkh0ZZHgmGzm+5b
         e0ozE3+cJgAzmU55Qt8g/SrVemFE8Jk86tlXEO74tyKyoH6irr12Th7R7U5Qh34z7I74
         fAwtQcb8G85XrSn+c2cNB/1QQMYDNW3wRU+NDDNpkT9f6Vf+tG9Q2OEnkuIdPLHx0bU0
         0w8DBPTHz0VPNODKI/eiUj2dzuUcL9nPEFie3RN77tagC+xSscSz777bSORqlOPxl3p/
         YAMg==
X-Gm-Message-State: ABy/qLZrMzT6sRVNVfDJM0ittOWhRmMxkwJ05pN/ZaSYDr/Bu/zthiOJ
        fZJ7URUJP/Mh3bQ/P98UO8I=
X-Google-Smtp-Source: APBJJlHfdaDchRiKCzzj9hZwgTbQzwyxtzeuizDH16V+TqsJiCmpv7CuVvnxrhr/G1gG/9TOMuyrvA==
X-Received: by 2002:a05:600c:2253:b0:3fd:3049:9496 with SMTP id a19-20020a05600c225300b003fd30499496mr5605696wmm.33.1690999090199;
        Wed, 02 Aug 2023 10:58:10 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:09 -0700 (PDT)
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
Subject: [PATCH 08/27] ASoC: Intel: kbl_da7219_max98357a: Map missing Line Out jack kcontrol
Date:   Wed,  2 Aug 2023 20:57:18 +0300
Message-Id: <20230802175737.263412-9-alpernebiyasak@gmail.com>
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

Commit c2065d43ae85 ("ASoC: Intel: kbl_da7219_max98357a: remap jack
pins") maps kcontrols for Headphone and Headset Mic jacks for this
driver so that PulseAudio and PipeWire can handle jack detection events
for these peripherals.

The DA7219 codec used here can also distinguish between Headphone and
Line Out connections that go into the same physical port. Expose the
latter to userspace as a kcontrol as well and add the necessary widgets.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 sound/soc/intel/boards/kbl_da7219_max98357a.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 18365ce6bcba..97149513076f 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -83,12 +83,14 @@ static const struct snd_kcontrol_new kabylake_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Spk"),
+	SOC_DAPM_PIN_SWITCH("Line Out"),
 };
 
 static const struct snd_soc_dapm_widget kabylake_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_SPK("Spk", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
 	SND_SOC_DAPM_SPK("HDMI1", NULL),
 	SND_SOC_DAPM_SPK("HDMI2", NULL),
@@ -107,6 +109,10 @@ static struct snd_soc_jack_pin jack_pins[] = {
 		.pin    = "Headset Mic",
 		.mask   = SND_JACK_MICROPHONE,
 	},
+	{
+		.pin    = "Line Out",
+		.mask   = SND_JACK_LINEOUT,
+	},
 };
 
 static const struct snd_soc_dapm_route kabylake_map[] = {
@@ -147,6 +153,7 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
 
 	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headset Mic", NULL, "Platform Clock" },
+	{ "Line Out", NULL, "Platform Clock" },
 };
 
 static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
-- 
2.40.1

