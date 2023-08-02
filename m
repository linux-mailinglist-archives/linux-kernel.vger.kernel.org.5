Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C83176D638
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjHBR6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbjHBR6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE59CA3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so1395665e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999086; x=1691603886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9P3TP3wzncRhOXgecZRN30Iatpmdu19th61qwxb3TI=;
        b=bnCWrvBW33Hc3lH7E3ojnUXu9Ro8w0Y5gsvpJtoeUNAkcrDtks3psfwf5mrnHNwCyT
         3deFDBbk+9b8/B2aEH7EyMbouK0typo/n9x3MJ998k97nDuFHx2dcxRPVaHPQyvb4nN9
         0TUe+jsmNGDMxGiNEoqWQ9YBTaFZe5aDkOwmBKuQuB5WJ/r1GGlG3mi/JZfbYNYJc4gz
         aTczta8+OM12jgy7iZ8C8/xvbhiMXRAeDuLwC44bv82QfsukQS8UcpvgkYK7GYZRSr7M
         gcB7pFpv2kCTwlPyicYgRdMsnu6pGZ0ZNouy0H0z0Jsfy68v5Q6uzHsE6ARmN85VSsO2
         blIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999086; x=1691603886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9P3TP3wzncRhOXgecZRN30Iatpmdu19th61qwxb3TI=;
        b=PI8rMnZ/0PYaLvfCo4ukuvJL2tM0YEeCWsBvHd7jFvAF1kSN3mdPtFuJYIK9sXDAg0
         HbDSoiUrS1ZEZb6DypfniznamNuf9tgAoPOj1pARFhwwYLQ6jqulvKNO/skXUtG5pXb5
         JDhTj5RIqAwi0PYNxNisQiDgfE5N7ZhEvbC4KqCvV6f9CHtUeYRTKYX/kfTM895VADa/
         0Peoow0VnSFlGO+kjruDH3kT/HEO6Y9EIj2VqsdJ8m20vnKWTqQLXFtebGubYn6lmOhq
         noKgXWlm+BopaHujL6YZRfuU/TtVzGmbJqIPD1GlGeiZcHk4QB+wnXv1GOmt8ju8OJpf
         /E/w==
X-Gm-Message-State: ABy/qLbuE5Z9czRwXuUS9koZ+wz99n95jevuiH+9apgJpKaB+MQZ03/G
        Mdp42tIZdekWb+wTB5Q5ifc=
X-Google-Smtp-Source: APBJJlEwjdDlcnSWCJ6DvL86bdak4jW/RJj56mLBJrICwRStZ4ojrxzFQe31Kb6pdeyPp60om6IkRQ==
X-Received: by 2002:a05:600c:2198:b0:3fe:e1e:5041 with SMTP id e24-20020a05600c219800b003fe0e1e5041mr5573612wme.32.1690999086221;
        Wed, 02 Aug 2023 10:58:06 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:05 -0700 (PDT)
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
Subject: [PATCH 06/27] ASoC: Intel: bxt_da7219_max98357a: Map missing Line Out jack kcontrol
Date:   Wed,  2 Aug 2023 20:57:16 +0300
Message-Id: <20230802175737.263412-7-alpernebiyasak@gmail.com>
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

Commit bbdd4ea2190b4 ("ASoC: Intel: bxt_da7219_max98357a: remap jack
pins") maps kcontrols for Headphone and Headset Mic jacks for this
driver so that PulseAudio and PipeWire can handle detection events for
these peripherals.

The DA7219 codec used here can also distinguish between Headphone and
Line Out connections that go into the same physical port. Expose the
latter to userspace as a kcontrol as well and add the necessary widgets.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Tested on a "Lick" Chromebook.

 sound/soc/intel/boards/bxt_da7219_max98357a.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index c593995facaa..cbfff466c5c8 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -90,6 +90,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 static const struct snd_kcontrol_new broxton_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Line Out"),
 };
 
 static const struct snd_kcontrol_new max98357a_controls[] = {
@@ -104,6 +105,7 @@ static const struct snd_kcontrol_new max98390_controls[] = {
 static const struct snd_soc_dapm_widget broxton_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
 	SND_SOC_DAPM_SPK("HDMI1", NULL),
 	SND_SOC_DAPM_SPK("HDMI2", NULL),
@@ -150,6 +152,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headset Mic", NULL, "Platform Clock" },
+	{ "Line Out", NULL, "Platform Clock" },
 };
 
 static const struct snd_soc_dapm_route max98357a_routes[] = {
@@ -194,6 +197,10 @@ static struct snd_soc_jack_pin jack_pins[] = {
 		.pin    = "Headset Mic",
 		.mask   = SND_JACK_MICROPHONE,
 	},
+	{
+		.pin    = "Line Out",
+		.mask   = SND_JACK_LINEOUT,
+	},
 };
 
 static int broxton_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
-- 
2.40.1

