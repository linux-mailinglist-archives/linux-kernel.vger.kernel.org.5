Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CBF76D653
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjHBSAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjHBR7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:59:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA7C3C11
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so8096785e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999125; x=1691603925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QAIWP4M6rBKtTpn/rRinZikOOxcMUXJXPcYbOcWh7A=;
        b=jG029gDzx1VlaSJ6xc7aVKpj0Yef+5LN2PYEenXcXD3VNalatBnZxvLwaxFCBLAjwI
         pCU5V57NMxEkbzjVj7F28GLT9ocP47sWxQkPY+L7VYTFULVtn4pHf9a5Tihq1TE076Ho
         gRUFUZ7hQflSR1jA0q8oBDeJn96GDbIoCE8e5iKcEAb9D1qMkOu+S6PPk43/1HG8lGJV
         Y4hObvXevJX5xCJrPb7FVXhkZJCJmgvYmgSku5qWRfrNjtspBZcIe/HmUwqQVwOjUkOO
         tAeRA1MRPXTPmr8YW2KSiqix3l1nC7oPSZdEB1hmbcPePoeOax5Uysacrx6N2ELLkZkS
         G2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999125; x=1691603925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QAIWP4M6rBKtTpn/rRinZikOOxcMUXJXPcYbOcWh7A=;
        b=ZZmhaySxg+55uYRBFzGAlX5hONYiIV1xlcA6cFtQhVzdv+DrzmYAPVIGRkJ023DwtF
         EXa7Ac118kNRkpF1eI0mwPaXg7royNtmSCj+49a1FIGSU1yVGZi9FtfMwPulNAM+s4qa
         7eaIJ5wLkK7IImMBYvf4ce9TCyUSo9MXQHGwcbW0ssct2tXLOWOmLlofmrw9WEb8+vnU
         CT3uJdj+mURebY9TjcXI8CbXFOsj//a9yHsJkZ2FaBILEnHQDnx8LB6eXE3yz/zTaqRn
         PZtrHWrC1T2/Be96g3WgUQJaS0I4P1henV7Ek0JI/3UEaL7vr/LiCeg7r8M4vNnfiMcj
         JYbA==
X-Gm-Message-State: ABy/qLYEpszgPa7c2AF6QnpkEduO3DcoSmSUEYmJVl8P+eCdEYzdkBnX
        aCQR7ogzRjBMWwwx0L+Vr8Q=
X-Google-Smtp-Source: APBJJlEJ2EggviBFizXfzV+h7ot9Z1XD8RFiIvdOE3MYyO8E+jcUIKdnaY6u9B81DSwbVXGUTI3kOA==
X-Received: by 2002:a05:600c:4f06:b0:3fa:88b4:bff3 with SMTP id l6-20020a05600c4f0600b003fa88b4bff3mr5859273wmq.11.1690999125540;
        Wed, 02 Aug 2023 10:58:45 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:45 -0700 (PDT)
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
Subject: [PATCH 26/27] ASoC: samsung: lowland: Split Line Out jack kcontrol from Headphone
Date:   Wed,  2 Aug 2023 20:57:36 +0300
Message-Id: <20230802175737.263412-27-alpernebiyasak@gmail.com>
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

This driver has correctly mapped jack kcontrols for Headphone and
Headset Mic. However, it is also mapping Line Out jack detection events
to the Headphone kcontrol.

The WM5100 codec used here can distinguish Line Out connections from
Headphone connections. Decouple the two, expose Line Out to userspace as
an independent kcontrol and add the necessary widget.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
I'm not sure this is a good idea, but still...

 sound/soc/samsung/lowland.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/lowland.c b/sound/soc/samsung/lowland.c
index 106770be6fc5..a79df871ea13 100644
--- a/sound/soc/samsung/lowland.c
+++ b/sound/soc/samsung/lowland.c
@@ -22,12 +22,16 @@ static struct snd_soc_jack lowland_headset;
 static struct snd_soc_jack_pin lowland_headset_pins[] = {
 	{
 		.pin = "Headphone",
-		.mask = SND_JACK_HEADPHONE | SND_JACK_LINEOUT,
+		.mask = SND_JACK_HEADPHONE,
 	},
 	{
 		.pin = "Headset Mic",
 		.mask = SND_JACK_MICROPHONE,
 	},
+	{
+		.pin = "Line Out",
+		.mask = SND_JACK_LINEOUT,
+	},
 };
 
 static int lowland_wm5100_init(struct snd_soc_pcm_runtime *rtd)
@@ -140,11 +144,13 @@ static const struct snd_kcontrol_new controls[] = {
 	SOC_DAPM_PIN_SWITCH("WM1250 Input"),
 	SOC_DAPM_PIN_SWITCH("WM1250 Output"),
 	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Line Out"),
 };
 
 static const struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
 
 	SND_SOC_DAPM_SPK("Main Speaker", NULL),
 
-- 
2.40.1

