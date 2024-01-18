Return-Path: <linux-kernel+bounces-29887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6295E8314B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D576281CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F6D341BF;
	Thu, 18 Jan 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIx5FZBy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D49219ED;
	Thu, 18 Jan 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566180; cv=none; b=auLAlJPbATSl59uh0/LMNFuq4auBz62L3k/cEf2N17BrCo2J1uLdQyYmOnH7lW2lrgTFXQBxmPTb+2MfoYWlaGfox5mSsBdOud21D1vokMcwO7Q1ToxhyLMcUi99pwAk+FboUvJql1Ggt61Mo9EN6bg6XQM7sWITuq6rPP2t7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566180; c=relaxed/simple;
	bh=q2wfBwiV2aXw54Tlm2xPl3C7+8RYVtIB25oGgkG96t4=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=Lw1vutolvBFto5ggRlQKKQJ+u2qbmTbc3WKmMvCCeaUiBCYfAOwMwdiBQzMZYA6EkMr9T7tU8u147rDZw3qUbNkPwEdYRNDDWsM016WAhEQgX9AKnHiH3MNY4LnoxuOSiXmY0VwWycYz8Rnr0J0SXKaYmRuyi8UaDVn901Ud2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIx5FZBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92A04C4E759;
	Thu, 18 Jan 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705566180;
	bh=q2wfBwiV2aXw54Tlm2xPl3C7+8RYVtIB25oGgkG96t4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eIx5FZBy8IhF+r6ryvEXAa+zgtwc+Cfj4PnWFl9SW0l0jDKhPdVyyCEUJ8Mcr5Vzg
	 O1lxpYuIGHeNc3vknnt8AVaCCn8QhDbVL7bvcy5iTF4pS8Pcq2D4tDO30zzIfUvOiL
	 SawkfvGIdBYfxF12TuHcN9BxPizGw3EG9RDFy1jWje0LIS7AK9N5LlyR5U6HCGVyLd
	 d4NOOKwnyzHKvIr6L5AHX5V/bZ08yQwGhcCkyhXEBKun0yo9pBlAms4LaMY7CgMQZQ
	 fpQgDy6TImZiMLn9EWRZdOkXLkfnDMO3gkXdOB73xm+ftX9dlmRdd5/bEriivrpPqN
	 /Wf9GH4Aq3GRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748BCC47DD8;
	Thu, 18 Jan 2024 08:23:00 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 18 Jan 2024 11:21:21 +0300
Subject: [PATCH v7 38/39] ASoC: cirrus: edb93xx: Delete driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-ep93xx-v7-38-d953846ae771@maquefel.me>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705566176; l=4988;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=q85pa0yb/O7EaHVagkr9aEFvCWc3nilsGlPhGwvGUM8=; =?utf-8?q?b=3D2niQo7x7+ysc?=
 =?utf-8?q?HqpMn0J229NU1lQ5IuXsLQJe6HKzGrN01/8LhtQNnNF1ngWPgG1sMC0HTusjl7/9?=
 iN81kyt4C1oSDsuZ+SMJyJDaB3EeuLlu4WsUIgXvoG+GaGtFOdtg
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Can be replaced with "simple-audio-card" for the rates up to 50kHz, refer
to commit "ARM: dts: ep93xx: Add EDB9302 DT".

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 sound/soc/cirrus/Kconfig   |   9 ----
 sound/soc/cirrus/Makefile  |   4 --
 sound/soc/cirrus/edb93xx.c | 116 ---------------------------------------------
 3 files changed, 129 deletions(-)

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
index 8bb67d7d2b4b..000000000000
--- a/sound/soc/cirrus/edb93xx.c
+++ /dev/null
@@ -1,116 +0,0 @@
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


