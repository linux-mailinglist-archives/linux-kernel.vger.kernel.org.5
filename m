Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6F176D650
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjHBSAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjHBR7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:59:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B33C05
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso1075375e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999123; x=1691603923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXqXYAcukJg9NxGMzxMn5REWqtvtEi1jTOlYbMmEIwQ=;
        b=HRCj7K9dtm+flY3nG52NdwdzhU/m9cYvvltc4+JcXjr+3hBjxAxlfu3xEC9Q5wS26x
         GVg9y1suh7fhuXt/GPxc6N3xoTv7DjEMN8pea6sgapzjpU9bmXqLPLe4OcDsNp63ZK9D
         uN5GPpv2bxxNeMdFRvcWse/YNZT3VXtGukhFwDaDJ8STEXZQSCO8g7cx2l+egd/QdNA3
         eVLKc38vAtsMAOIUezHhXjX+UTl3DLLR/K6IxXYusihdWdlQoW/AYcvZlVlUrU0Si5+b
         pktAYGsgyBnrQyJJ/GZA7cz2/ZdoBeh3V7xo9afYhauPw/+KPkbnEmbRq9njiaAvRXEx
         py+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999123; x=1691603923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXqXYAcukJg9NxGMzxMn5REWqtvtEi1jTOlYbMmEIwQ=;
        b=S4+Bthwnz5lfEgYfAXQzIldv8rUe+7Bk5h83Lkx8ZpBu9FbdoeDOoCn+ZdqnMHdrAy
         33sDNTM5tO7DqIfuBI61Nx30Lc9HioelSR7VUNAyjN6PB4fI0P7JdNoFreeXOchnfGpW
         P+AsIEsr76az+jUgJrXxxdBd2tpU89IOzupKA6QeLhBmznQ9HHYyPc54b/u7i81Nfq9n
         RfeYpmRZjKqXTU5NjJ9/scZHbTUnwepY348dOIx09Mj1HJbeFYaEFJK9LGkQyusd+uTo
         s3dXcyEoeFe+/kzjjkvidXWVH5DgwFCJnVpug6ovIv4kH5aUh9zr6RH6vg8tkGH/H5Me
         43Xg==
X-Gm-Message-State: ABy/qLZOLcOZXUuYtP79T26qYFWaJJQIfd8g9J3FInY4ubSkmKa5rdRl
        4jv7U9ql66JKoUyv7Ub5mgY=
X-Google-Smtp-Source: APBJJlF4WH4ztE6sP96Ip/0+rlET/v5cd61TY/xgM05U+urjF/YhBfw4WfbX+mrQ1mjsRh1wiH6llQ==
X-Received: by 2002:a05:600c:3d85:b0:3f7:e78e:8a41 with SMTP id bi5-20020a05600c3d8500b003f7e78e8a41mr5585448wmb.18.1690999123631;
        Wed, 02 Aug 2023 10:58:43 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:43 -0700 (PDT)
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
Subject: [PATCH 25/27] ASoC: samsung: littlemill: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:35 +0300
Message-Id: <20230802175737.263412-26-alpernebiyasak@gmail.com>
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
and PipeWire need to handle jack detection events. The WM8958 codec used
here can detect Headphone and Headset Mic connections. Expose each to
userspace as a kcontrol and add the necessary widgets.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Would SND_JACK_MECHANICAL be useful as a kcontrol as well?

 sound/soc/samsung/littlemill.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index 5d8118e69359..fafadcef234e 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -225,12 +225,15 @@ static int bbclk_ev(struct snd_soc_dapm_widget *w,
 }
 
 static const struct snd_kcontrol_new controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("WM1250 Input"),
 	SOC_DAPM_PIN_SWITCH("WM1250 Output"),
 };
 
 static const struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_HP("Headset Mic", NULL),
 
 	SND_SOC_DAPM_MIC("AMIC", NULL),
 	SND_SOC_DAPM_MIC("DMIC", NULL),
@@ -255,6 +258,16 @@ static const struct snd_soc_dapm_route audio_paths[] = {
 };
 
 static struct snd_soc_jack littlemill_headset;
+static struct snd_soc_jack_pin littlemill_headset_pins[] = {
+	{
+		.pin = "Headphone",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
 
 static int littlemill_late_probe(struct snd_soc_card *card)
 {
@@ -281,12 +294,14 @@ static int littlemill_late_probe(struct snd_soc_card *card)
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_card_jack_new(card, "Headset",
-				    SND_JACK_HEADSET | SND_JACK_MECHANICAL |
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				    SND_JACK_BTN_2 | SND_JACK_BTN_3 |
-				    SND_JACK_BTN_4 | SND_JACK_BTN_5,
-				    &littlemill_headset);
+	ret = snd_soc_card_jack_new_pins(card, "Headset",
+					 SND_JACK_HEADSET | SND_JACK_MECHANICAL |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3 |
+					 SND_JACK_BTN_4 | SND_JACK_BTN_5,
+					 &littlemill_headset,
+					 littlemill_headset_pins,
+					 ARRAY_SIZE(littlemill_headset_pins));
 	if (ret)
 		return ret;
 
-- 
2.40.1

