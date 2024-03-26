Return-Path: <linux-kernel+bounces-118675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D11D88BDEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740F7B272AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FEF12F36A;
	Tue, 26 Mar 2024 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+UMMct2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434E74416;
	Tue, 26 Mar 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444843; cv=none; b=GrPkSEqQgDVbaTKPHhk+eCMEi9sJMtvBHP11StH/ywXtv+eFwozJi2wprJEKb5p9++kE0OOtQ0gXvUIdbqFSZyR+Z41xjy9gnEjM9eeqOPAnZudOJObfVNmLCRZQwL2uzKrCfsKQH+YpPkh2oX3WPduQeWLGHPf+N42rJUbGGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444843; c=relaxed/simple;
	bh=q2wfBwiV2aXw54Tlm2xPl3C7+8RYVtIB25oGgkG96t4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMUBxg5Ke6SIg+nGIPFTNOUHfm3J7MediPo6faN5eSFGGfBOTZb7EB2zhKyZ30uJ5DKd7KN2A5CD0khhfFLwGO7YjSgUJI8+Il7WumG9D7alGvfkfi3O54m5eGCCNXrC7ebQnvhcx4W4YD2nyZGu2A7kJw10CPnaqk0sjc4TSzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+UMMct2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A76DC3279D;
	Tue, 26 Mar 2024 09:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711444843;
	bh=q2wfBwiV2aXw54Tlm2xPl3C7+8RYVtIB25oGgkG96t4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=n+UMMct21UPvD9H7AK65QTpeHGvjy4hF2CZcRN6KkaOUlY7e2OxQdzKdurlgifx5N
	 iROGMpsmP6fKKm35CJEpLlya00kxW0mVdAAsTYfEKbPLS18iWC5/E92YAQ3i7Mo3pJ
	 OS07EQNoeXqft+BP7ZToxLUVySI+MY+a4gbny5RD8tZ/fMSLPcsbCFvX24op6xwPqz
	 AVp+vSJV51t/8rTWos9I53GlihurIvcvRo//bV8EIkv34lgpIAmc77f+LOKHt+MRzU
	 5ld+gxglYJTb7708Hw3FC3rJSrEssP7xYZbnq2ozuHBgdZ1BMPCkVE7aj6UnX3X+3Q
	 lkv7SJXBH2WWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02566CD11DF;
	Tue, 26 Mar 2024 09:20:43 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 26 Mar 2024 12:19:04 +0300
Subject: [PATCH v9 37/38] ASoC: cirrus: edb93xx: Delete driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-ep93xx-v9-37-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711444837; l=4988;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=q85pa0yb/O7EaHVagkr9aEFvCWc3nilsGlPhGwvGUM8=;
 b=wfpQkt14c99qNtnBSRcgj0t3fLLIm8kyxvEtHiGnyhGShiN/xAyxMSoQimbmR7XVJvXLneZDVUMp
 C/nIMKg1AYFmy6l9FThf45/l2BW/p12SaT+835FbuIIOvwSb7GPq
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

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



