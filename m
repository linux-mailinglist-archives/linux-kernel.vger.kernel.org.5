Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E3E80E612
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346364AbjLLIZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346109AbjLLIWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:22:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1B1EE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:22:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85038C433AB;
        Tue, 12 Dec 2023 08:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702369326;
        bh=Q3h1r7ii+HamifRwqVLAqzF9LWiWleZqbtI1y/YUAmo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=VAvTX4+KHb6EkghD/CNW8mh41qEa0jqpExcHF774r8jHRSb6Roildy4S/1bQkNds0
         7Mk8Abpr4y7/fwpamAgkXLceqfmfk1K5PWWvgTVosK3XU4HcGemN/M7zhNWTTUGRXo
         2Ad9Oeb0KWbl8kyeRXcGSxspvdvkH5urM7D4dyj/LVn0vEO/DHFi4+D+YsQlJbk5cZ
         wxXHNr3Q7QulKTXWXcRfv/9aFnT7VO0IXYY5UF65dGxb+T6tvDKL+jRZI5siXPoBB0
         O/j+eImU2oilMYsPHdh7PpwG84wfdVa3HFBYogIUAWUUwgew4aDutxExbjYOdOwWtO
         4JKmOSPRB+iPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 75A9FC4167D;
        Tue, 12 Dec 2023 08:22:06 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Tue, 12 Dec 2023 11:20:56 +0300
Subject: [PATCH v6 39/40] ASoC: cirrus: edb93xx: Delete driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-ep93xx-v6-39-c307b8ac9aa8@maquefel.me>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
In-Reply-To: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702369322; l=5014;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=h2rduEcwWz7/6MY2gxmHuwdvmGLXXkP6apssDcKmh10=; =?utf-8?q?b=3DpZCxkKxhED6N?=
 =?utf-8?q?GOz9kH82UHaouqIO35KEu+X0kU/w2/ASkMXf0LRZkl0SWEfVD4txPfrYcfhKXiLl?=
 H6n6owmPDMPfhpcNUBAyjtUmdSzwMTeTySpO1iWlURNQYu1NBVDm
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Can be replaced with "simple-audio-card" for the rates up to 50kHz, refer
to commit "ARM: dts: ep93xx: Add EDB9302 DT".

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 sound/soc/cirrus/Kconfig   |   9 ----
 sound/soc/cirrus/Makefile  |   4 --
 sound/soc/cirrus/edb93xx.c | 117 ---------------------------------------------
 3 files changed, 130 deletions(-)

diff --git a/sound/soc/cirrus/Kconfig b/sound/soc/cirrus/Kconfig
index 38a83c4dcc2d..97def4e53fbc 100644
--- a/sound/soc/cirrus/Kconfig
+++ b/sound/soc/cirrus/Kconfig
@@ -31,12 +31,3 @@ config SND_EP93XX_SOC_I2S_WATCHDOG
 
 endif # if SND_EP93XX_SOC_I2S
 
-config SND_EP93XX_SOC_EDB93XX
-	tristate "SoC Audio support for Cirrus Logic EDB93xx boards"
-	depends on SND_EP93XX_SOC && (MACH_EDB9301 || MACH_EDB9302 || MACH_EDB9302A || MACH_EDB9307A || MACH_EDB9315A)
-	select SND_EP93XX_SOC_I2S
-	select SND_SOC_CS4271_I2C if I2C
-	select SND_SOC_CS4271_SPI if SPI_MASTER
-	help
-	  Say Y or M here if you want to add support for I2S audio on the
-	  Cirrus Logic EDB93xx boards.
diff --git a/sound/soc/cirrus/Makefile b/sound/soc/cirrus/Makefile
index 19a86daad660..5916c03888cb 100644
--- a/sound/soc/cirrus/Makefile
+++ b/sound/soc/cirrus/Makefile
@@ -6,7 +6,3 @@ snd-soc-ep93xx-i2s-objs	 			:= ep93xx-i2s.o
 obj-$(CONFIG_SND_EP93XX_SOC)			+= snd-soc-ep93xx.o
 obj-$(CONFIG_SND_EP93XX_SOC_I2S)		+= snd-soc-ep93xx-i2s.o
 
-# EP93XX Machine Support
-snd-soc-edb93xx-objs				:= edb93xx.o
-
-obj-$(CONFIG_SND_EP93XX_SOC_EDB93XX)		+= snd-soc-edb93xx.o
diff --git a/sound/soc/cirrus/edb93xx.c b/sound/soc/cirrus/edb93xx.c
deleted file mode 100644
index 6b6817256331..000000000000
--- a/sound/soc/cirrus/edb93xx.c
+++ /dev/null
@@ -1,117 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * SoC audio for EDB93xx
- *
- * Copyright (c) 2010 Alexander Sverdlin <subaparts@yandex.ru>
- *
- * This driver support CS4271 codec being master or slave, working
- * in control port mode, connected either via SPI or I2C.
- * The data format accepted is I2S or left-justified.
- * DAPM support not implemented.
- */
-
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <linux/module.h>
-#include <linux/soc/cirrus/ep93xx.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <asm/mach-types.h>
-
-static int edb93xx_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
-	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
-	int err;
-	unsigned int mclk_rate;
-	unsigned int rate = params_rate(params);
-
-	/*
-	 * According to CS4271 datasheet we use MCLK/LRCK=256 for
-	 * rates below 50kHz and 128 for higher sample rates
-	 */
-	if (rate < 50000)
-		mclk_rate = rate * 64 * 4;
-	else
-		mclk_rate = rate * 64 * 2;
-
-	err = snd_soc_dai_set_sysclk(codec_dai, 0, mclk_rate,
-				     SND_SOC_CLOCK_IN);
-	if (err)
-		return err;
-
-	return snd_soc_dai_set_sysclk(cpu_dai, 0, mclk_rate,
-				      SND_SOC_CLOCK_OUT);
-}
-
-static const struct snd_soc_ops edb93xx_ops = {
-	.hw_params	= edb93xx_hw_params,
-};
-
-SND_SOC_DAILINK_DEFS(hifi,
-	DAILINK_COMP_ARRAY(COMP_CPU("ep93xx-i2s")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("spi0.0", "cs4271-hifi")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("ep93xx-i2s")));
-
-static struct snd_soc_dai_link edb93xx_dai = {
-	.name		= "CS4271",
-	.stream_name	= "CS4271 HiFi",
-	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			  SND_SOC_DAIFMT_CBC_CFC,
-	.ops		= &edb93xx_ops,
-	SND_SOC_DAILINK_REG(hifi),
-};
-
-static struct snd_soc_card snd_soc_edb93xx = {
-	.name		= "EDB93XX",
-	.owner		= THIS_MODULE,
-	.dai_link	= &edb93xx_dai,
-	.num_links	= 1,
-};
-
-static int edb93xx_probe(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = &snd_soc_edb93xx;
-	int ret;
-
-	ret = ep93xx_i2s_acquire();
-	if (ret)
-		return ret;
-
-	card->dev = &pdev->dev;
-
-	ret = snd_soc_register_card(card);
-	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
-			ret);
-		ep93xx_i2s_release();
-	}
-
-	return ret;
-}
-
-static void edb93xx_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-	ep93xx_i2s_release();
-}
-
-static struct platform_driver edb93xx_driver = {
-	.driver		= {
-		.name	= "edb93xx-audio",
-	},
-	.probe		= edb93xx_probe,
-	.remove_new	= edb93xx_remove,
-};
-
-module_platform_driver(edb93xx_driver);
-
-MODULE_AUTHOR("Alexander Sverdlin <subaparts@yandex.ru>");
-MODULE_DESCRIPTION("ALSA SoC EDB93xx");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:edb93xx-audio");

-- 
2.41.0

