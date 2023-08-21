Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49230782B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbjHUOSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjHUOSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:18:41 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9E126
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:18:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso22061251fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692627483; x=1693232283;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg6Q8WvRoMBiFRBNg44RRpw4GEQtXWgDN0RtMHV4cS8=;
        b=QiN0WrTHEUmFwdzSGfs487Z+Xw82nAtMR5HxOAYtKNSbc9hNkk7qvJHisUqj2ypJ6k
         VvrXeE/YjCIZDIM956zW5L++/N+NJt65jg2XPwohkzSBBqQATt2zk+TBxp7zo1By/7GQ
         +7zHBMh/RYgL8cjBwvgExnOnJTORsx2+EV2lrAAglTSmvEYn4GPux1q0J/ktR8uyvr1Z
         ntP3MrwV6ynDLJPSVPGoSUfsa0J/3n4i9twS/H3JgJF2h9AeXCRiEsQMx0EnH0l3nHZW
         MGW77XmRb4Tii8j26BBYobXpC0TjdRvtnTudEC+1HMf65AkDJw7OsT/Z9Q6TsO2P6OW2
         jV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692627483; x=1693232283;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lg6Q8WvRoMBiFRBNg44RRpw4GEQtXWgDN0RtMHV4cS8=;
        b=SLumbDkcf6I0T0pDkHmDcYqy5llgkI8WMDpTgmrCkgLpXvbE+kPOT84aC7n8coWVKZ
         8kGD/i+F8iM4owZoZD3UF3kkvNAcwT73hja7m82wXjZt6PLZoJ6m379Ljgt/pY7AWbVN
         w2CIVIc2v9pP9P4pU8IRXm7RRFFQkqIpNuo3GXTIoxDxwdhej2ytrzqq3geFe2AHT+L+
         0shKxAhNj4X7GhS7/742Inm0UOzl6JN5gHE4USuN6IH57C+gHTEQIZUKj0w0RxFiQihG
         CcpIHm6Q3js6bntd5lZpftIyfCLNonk2+QK08L5L6MbBoKaSSR/qZfOIQojHhGPHipv7
         pL4g==
X-Gm-Message-State: AOJu0YywcmfNmbSsLRiiyKwg/5JW4sNwJnu27ToDbdiyhmsaWOTqu7wK
        CBvuW05+/iFatiqpuVI0p+vWAKqqLGMBevWJHE8=
X-Google-Smtp-Source: AGHT+IFnBqkEgW64HMkTGeAuRKTB60QzZ+Eu9/oqxfKHg7OM+zDHZAcLJS2yjT3rZp/HQ+hC9rdjJw==
X-Received: by 2002:ac2:5b1e:0:b0:4fd:fc3e:722c with SMTP id v30-20020ac25b1e000000b004fdfc3e722cmr3790187lfn.58.1692627482926;
        Mon, 21 Aug 2023 07:18:02 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id r26-20020ac24d1a000000b004fb738796casm1761076lfi.40.2023.08.21.07.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 07:18:02 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Aug 2023 16:17:57 +0200
Subject: [PATCH] ASoC: Delete UDA134x/L3 audio codec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-delete-l3-v1-1-26d9cd32e7a2@linaro.org>
X-B4-Tracking: v=1; b=H4sIABRy42QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyND3ZTUnNSSVN0cY11Tc+M0EwtjIwPDVGMloPqCotS0zAqwWdGxtbU
 At3cMO1sAAAA=
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This codec was used by the deleted S3C board
sound/soc/samsung/s3c24xx_uda134x.c.

Fixes: 503278c12701 ("ASoC: samsung: remove unused drivers")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/sound/l3.h         |  28 ---
 include/sound/uda134x.h    |  24 --
 sound/soc/codecs/Kconfig   |   4 -
 sound/soc/codecs/Makefile  |   2 -
 sound/soc/codecs/l3.c      | 132 ----------
 sound/soc/codecs/uda134x.c | 587 ---------------------------------------------
 sound/soc/codecs/uda134x.h |  33 ---
 7 files changed, 810 deletions(-)

diff --git a/include/sound/l3.h b/include/sound/l3.h
deleted file mode 100644
index b6f58072237a..000000000000
--- a/include/sound/l3.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _L3_H_
-#define _L3_H_ 1
-
-struct l3_pins {
-	void (*setdat)(struct l3_pins *, int);
-	void (*setclk)(struct l3_pins *, int);
-	void (*setmode)(struct l3_pins *, int);
-
-	int gpio_data;
-	int gpio_clk;
-	int gpio_mode;
-	int use_gpios;
-
-	int data_hold;
-	int data_setup;
-	int clock_high;
-	int mode_hold;
-	int mode;
-	int mode_setup;
-};
-
-struct device;
-
-int l3_write(struct l3_pins *adap, u8 addr, u8 *data, int len);
-int l3_set_gpio_ops(struct device *dev, struct l3_pins *adap);
-
-#endif
diff --git a/include/sound/uda134x.h b/include/sound/uda134x.h
deleted file mode 100644
index db82516da162..000000000000
--- a/include/sound/uda134x.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * uda134x.h  --  UDA134x ALSA SoC Codec driver
- *
- * Copyright 2007 Dension Audio Systems Ltd.
- * Author: Zoltan Devai
- */
-
-#ifndef _UDA134X_H
-#define _UDA134X_H
-
-#include <sound/l3.h>
-
-struct uda134x_platform_data {
-	struct l3_pins l3;
-	void (*power) (int);
-	int model;
-#define UDA134X_UDA1340 1
-#define UDA134X_UDA1341 2
-#define UDA134X_UDA1344 3
-#define UDA134X_UDA1345 4
-};
-
-#endif /* _UDA134X_H */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ef279a27eb51..520b4e13e08b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -268,7 +268,6 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_TWL4030
 	imply SND_SOC_TWL6040
 	imply SND_SOC_UDA1334
-	imply SND_SOC_UDA134X
 	imply SND_SOC_UDA1380
 	imply SND_SOC_WCD9335
 	imply SND_SOC_WCD934X
@@ -1953,9 +1952,6 @@ config SND_SOC_UDA1334
 	  and has basic features such as de-emphasis (at 44.1 kHz sampling
 	  rate) and mute.
 
-config SND_SOC_UDA134X
-	tristate
-
 config SND_SOC_UDA1380
 	tristate
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 2bdc0ef29a9e..34ebbb27f96a 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -301,7 +301,6 @@ snd-soc-ts3a227e-objs := ts3a227e.o
 snd-soc-twl4030-objs := twl4030.o
 snd-soc-twl6040-objs := twl6040.o
 snd-soc-uda1334-objs := uda1334.o
-snd-soc-uda134x-objs := uda134x.o
 snd-soc-uda1380-objs := uda1380.o
 snd-soc-wcd-mbhc-objs := wcd-mbhc-v2.o
 snd-soc-wcd9335-objs := wcd-clsh-v2.o wcd9335.o
@@ -683,7 +682,6 @@ obj-$(CONFIG_SND_SOC_TS3A227E)	+= snd-soc-ts3a227e.o
 obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_TWL6040)	+= snd-soc-twl6040.o
 obj-$(CONFIG_SND_SOC_UDA1334)	+= snd-soc-uda1334.o
-obj-$(CONFIG_SND_SOC_UDA134X)	+= snd-soc-uda134x.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
 obj-$(CONFIG_SND_SOC_WCD_MBHC)	+= snd-soc-wcd-mbhc.o
 obj-$(CONFIG_SND_SOC_WCD9335)	+= snd-soc-wcd9335.o
diff --git a/sound/soc/codecs/l3.c b/sound/soc/codecs/l3.c
deleted file mode 100644
index b84f6f1f6800..000000000000
--- a/sound/soc/codecs/l3.c
+++ /dev/null
@@ -1,132 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * L3 code
- *
- *  Copyright (C) 2008, Christian Pellegrin <chripell@evolware.org>
- *
- * based on:
- *
- * L3 bus algorithm module.
- *
- *  Copyright (C) 2001 Russell King, All Rights Reserved.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/gpio.h>
-
-#include <sound/l3.h>
-
-/*
- * Send one byte of data to the chip.  Data is latched into the chip on
- * the rising edge of the clock.
- */
-static void sendbyte(struct l3_pins *adap, unsigned int byte)
-{
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		adap->setclk(adap, 0);
-		udelay(adap->data_hold);
-		adap->setdat(adap, byte & 1);
-		udelay(adap->data_setup);
-		adap->setclk(adap, 1);
-		udelay(adap->clock_high);
-		byte >>= 1;
-	}
-}
-
-/*
- * Send a set of bytes to the chip.  We need to pulse the MODE line
- * between each byte, but never at the start nor at the end of the
- * transfer.
- */
-static void sendbytes(struct l3_pins *adap, const u8 *buf,
-		      int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++) {
-		if (i) {
-			udelay(adap->mode_hold);
-			adap->setmode(adap, 0);
-			udelay(adap->mode);
-		}
-		adap->setmode(adap, 1);
-		udelay(adap->mode_setup);
-		sendbyte(adap, buf[i]);
-	}
-}
-
-int l3_write(struct l3_pins *adap, u8 addr, u8 *data, int len)
-{
-	adap->setclk(adap, 1);
-	adap->setdat(adap, 1);
-	adap->setmode(adap, 1);
-	udelay(adap->mode);
-
-	adap->setmode(adap, 0);
-	udelay(adap->mode_setup);
-	sendbyte(adap, addr);
-	udelay(adap->mode_hold);
-
-	sendbytes(adap, data, len);
-
-	adap->setclk(adap, 1);
-	adap->setdat(adap, 1);
-	adap->setmode(adap, 0);
-
-	return len;
-}
-EXPORT_SYMBOL_GPL(l3_write);
-
-
-static void l3_set_clk(struct l3_pins *adap, int val)
-{
-	gpio_set_value(adap->gpio_clk, val);
-}
-
-static void l3_set_data(struct l3_pins *adap, int val)
-{
-	gpio_set_value(adap->gpio_data, val);
-}
-
-static void l3_set_mode(struct l3_pins *adap, int val)
-{
-	gpio_set_value(adap->gpio_mode, val);
-}
-
-int l3_set_gpio_ops(struct device *dev, struct l3_pins *adap)
-{
-	int ret;
-
-	if (!adap->use_gpios)
-		return -EINVAL;
-
-	ret = devm_gpio_request_one(dev, adap->gpio_data,
-				GPIOF_OUT_INIT_LOW, "l3_data");
-	if (ret < 0)
-		return ret;
-	adap->setdat = l3_set_data;
-
-	ret = devm_gpio_request_one(dev, adap->gpio_clk,
-				GPIOF_OUT_INIT_LOW, "l3_clk");
-	if (ret < 0)
-		return ret;
-	adap->setclk = l3_set_clk;
-
-	ret = devm_gpio_request_one(dev, adap->gpio_mode,
-				GPIOF_OUT_INIT_LOW, "l3_mode");
-	if (ret < 0)
-		return ret;
-	adap->setmode = l3_set_mode;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(l3_set_gpio_ops);
-
-MODULE_DESCRIPTION("L3 bit-banging driver");
-MODULE_AUTHOR("Christian Pellegrin <chripell@evolware.org>");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
deleted file mode 100644
index 1a62bec94005..000000000000
--- a/sound/soc/codecs/uda134x.c
+++ /dev/null
@@ -1,587 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * uda134x.c  --  UDA134X ALSA SoC Codec driver
- *
- * Modifications by Christian Pellegrin <chripell@evolware.org>
- *
- * Copyright 2007 Dension Audio Systems Ltd.
- * Author: Zoltan Devai
- *
- * Based on the WM87xx drivers by Liam Girdwood and Richard Purdie
- */
-
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-#include <sound/initval.h>
-
-#include <sound/uda134x.h>
-#include <sound/l3.h>
-
-#include "uda134x.h"
-
-
-#define UDA134X_RATES SNDRV_PCM_RATE_8000_48000
-#define UDA134X_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
-		SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S20_3LE)
-
-struct uda134x_priv {
-	int sysclk;
-	int dai_fmt;
-
-	struct snd_pcm_substream *master_substream;
-	struct snd_pcm_substream *slave_substream;
-
-	struct regmap *regmap;
-	struct uda134x_platform_data *pd;
-};
-
-static const struct reg_default uda134x_reg_defaults[] = {
-	{ UDA134X_EA000, 0x04 },
-	{ UDA134X_EA001, 0x04 },
-	{ UDA134X_EA010, 0x04 },
-	{ UDA134X_EA011, 0x00 },
-	{ UDA134X_EA100, 0x00 },
-	{ UDA134X_EA101, 0x00 },
-	{ UDA134X_EA110, 0x00 },
-	{ UDA134X_EA111, 0x00 },
-	{ UDA134X_STATUS0, 0x00 },
-	{ UDA134X_STATUS1, 0x03 },
-	{ UDA134X_DATA000, 0x00 },
-	{ UDA134X_DATA001, 0x00 },
-	{ UDA134X_DATA010, 0x00 },
-	{ UDA134X_DATA011, 0x00 },
-	{ UDA134X_DATA1, 0x00 },
-};
-
-/*
- * Write to the uda134x registers
- *
- */
-static int uda134x_regmap_write(void *context, unsigned int reg,
-	unsigned int value)
-{
-	struct uda134x_platform_data *pd = context;
-	int ret;
-	u8 addr;
-	u8 data = value;
-
-	switch (reg) {
-	case UDA134X_STATUS0:
-	case UDA134X_STATUS1:
-		addr = UDA134X_STATUS_ADDR;
-		data |= (reg - UDA134X_STATUS0) << 7;
-		break;
-	case UDA134X_DATA000:
-	case UDA134X_DATA001:
-	case UDA134X_DATA010:
-	case UDA134X_DATA011:
-		addr = UDA134X_DATA0_ADDR;
-		data |= (reg - UDA134X_DATA000) << 6;
-		break;
-	case UDA134X_DATA1:
-		addr = UDA134X_DATA1_ADDR;
-		break;
-	default:
-		/* It's an extended address register */
-		addr =  (reg | UDA134X_EXTADDR_PREFIX);
-
-		ret = l3_write(&pd->l3,
-			       UDA134X_DATA0_ADDR, &addr, 1);
-		if (ret != 1)
-			return -EIO;
-
-		addr = UDA134X_DATA0_ADDR;
-		data = (value | UDA134X_EXTDATA_PREFIX);
-		break;
-	}
-
-	ret = l3_write(&pd->l3,
-		       addr, &data, 1);
-	if (ret != 1)
-		return -EIO;
-
-	return 0;
-}
-
-static inline void uda134x_reset(struct snd_soc_component *component)
-{
-	struct uda134x_priv *uda134x = snd_soc_component_get_drvdata(component);
-	unsigned int mask = 1<<6;
-
-	regmap_update_bits(uda134x->regmap, UDA134X_STATUS0, mask, mask);
-	msleep(1);
-	regmap_update_bits(uda134x->regmap, UDA134X_STATUS0, mask, 0);
-}
-
-static int uda134x_mute(struct snd_soc_dai *dai, int mute, int direction)
-{
-	struct uda134x_priv *uda134x = snd_soc_component_get_drvdata(dai->component);
-	unsigned int mask = 1<<2;
-	unsigned int val;
-
-	pr_debug("%s mute: %d\n", __func__, mute);
-
-	if (mute)
-		val = mask;
-	else
-		val = 0;
-
-	return regmap_update_bits(uda134x->regmap, UDA134X_DATA010, mask, val);
-}
-
-static int uda134x_startup(struct snd_pcm_substream *substream,
-	struct snd_soc_dai *dai)
-{
-	struct snd_soc_component *component = dai->component;
-	struct uda134x_priv *uda134x = snd_soc_component_get_drvdata(component);
-	struct snd_pcm_runtime *master_runtime;
-
-	if (uda134x->master_substream) {
-		master_runtime = uda134x->master_substream->runtime;
-
-		pr_debug("%s constraining to %d bits at %d\n", __func__,
-			 master_runtime->sample_bits,
-			 master_runtime->rate);
-
-		snd_pcm_hw_constraint_single(substream->runtime,
-					     SNDRV_PCM_HW_PARAM_RATE,
-					     master_runtime->rate);
-
-		snd_pcm_hw_constraint_single(substream->runtime,
-					     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
-					     master_runtime->sample_bits);
-
-		uda134x->slave_substream = substream;
-	} else
-		uda134x->master_substream = substream;
-
-	return 0;
-}
-
-static void uda134x_shutdown(struct snd_pcm_substream *substream,
-	struct snd_soc_dai *dai)
-{
-	struct snd_soc_component *component = dai->component;
-	struct uda134x_priv *uda134x = snd_soc_component_get_drvdata(component);
-
-	if (uda134x->master_substream == substream)
-		uda134x->master_substream = uda134x->slave_substream;
-
-	uda134x->slave_substream = NULL;
-}
-
-static int uda134x_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params,
-	struct snd_soc_dai *dai)
-{
-	struct snd_soc_component *component = dai->component;
-	struct uda134x_priv *uda134x = snd_soc_component_get_drvdata(component);
-	unsigned int hw_params = 0;
-
-	if (substream == uda134x->slave_substream) {
-		pr_debug("%s ignoring hw_params for slave substream\n",
-			 __func__);
-		return 0;
-	}
-
-	pr_debug("%s sysclk: %d, rate:%d\n", __func__,
-		 uda134x->sysclk, params_rate(params));
-
-	/* set SYSCLK / fs ratio */
-	switch (uda134x->sysclk / params_rate(params)) {
-	case 512:
-		break;
-	case 384:
-		hw_params |= (1<<4);
-		break;
-	case 256:
-		hw_params |= (1<<5);
-		break;
-	default:
-		printk(KERN_ERR "%s unsupported fs\n", __func__);
-		return -EINVAL;
-	}
-
-	pr_debug("%s dai_fmt: %d, params_format:%d\n", __func__,
-		 uda134x->dai_fmt, params_format(params));
-
-	/* set DAI format and word length */
-	switch (uda134x->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_I2S:
-		break;
-	case SND_SOC_DAIFMT_RIGHT_J:
-		switch (params_width(params)) {
-		case 16:
-			hw_params |= (1<<1);
-			break;
-		case 18:
-			hw_params |= (1<<2);
-			break;
-		case 20:
-			hw_params |= ((1<<2) | (1<<1));
-			break;
-		default:
-			printk(KERN_ERR "%s unsupported format (right)\n",
-			       __func__);
-			return -EINVAL;
-		}
-		break;
-	case SND_SOC_DAIFMT_LEFT_J:
-		hw_params |= (1<<3);
-		break;
-	default:
-		printk(KERN_ERR "%s unsupported format\n", __func__);
-		return -EINVAL;
-	}
-
-	return regmap_update_bits(uda134x->regmap, UDA134X_STATUS0,
-		STATUS0_SYSCLK_MASK | STATUS0_DAIFMT_MASK, hw_params);
-}
-
-static int uda134x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
-				  int clk_id, unsigned int freq, int dir)
-{
-	struct snd_soc_component *component = codec_dai->component;
-	struct uda134x_priv *uda134x = snd_soc_component_get_drvdata(component);
-
-	pr_debug("%s clk_id: %d, freq: %u, dir: %d\n", __func__,
-		 clk_id, freq, dir);
-
-	/* Anything between 256fs*8Khz and 512fs*48Khz should be acceptable
-	   because the codec is slave. Of course limitations of the clock
-	   master (the IIS controller) apply.
-	   We'll error out on set_hw_params if it's not OK */
-	if ((freq >= (256 * 8000)) && (freq <= (512 * 48000))) {
-		uda134x->sysclk = freq;
-		return 0;
-	}
-
-	printk(KERN_ERR "%s unsupported sysclk\n", __func__);
-	return -EINVAL;
-}
-
-static int uda134x_set_dai_fmt(struct snd_soc_dai *codec_dai,
-			       unsigned int fmt)
-{
-	struct snd_soc_component *component = codec_dai->component;
-	struct uda134x_priv *uda134x = snd_soc_component_get_drvdata(component);
-
-	pr_debug("%s fmt: %08X\n", __func__, fmt);
-
-	/* codec supports only full consumer mode */
-	if ((fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) != SND_SOC_DAIFMT_CBC_CFC) {
-		printk(KERN_ERR "%s unsupported clocking mode\n", __func__);
-		return -EINVAL;
-	}
-
-	/* no support for clock inversion */
-	if ((fmt & SND_SOC_DAIFMT_INV_MASK) != SND_SOC_DAIFMT_NB_NF) {
-		printk(KERN_ERR "%s unsupported clock inversion\n", __func__);
-		return -EINVAL;
-	}
-
-	/* We can't setup DAI format here as it depends on the word bit num */
-	/* so let's just store the value for later */
-	uda134x->dai_fmt = fmt;
-
-	return 0;
-}
-
-static int uda134x_set_bias_level(struct snd_soc_component *component,
-				  enum snd_soc_bias_level level)
-{
-	struct uda134x_priv *uda134x = snd_soc_component_get_drvdata(component);
-	struct uda134x_platform_data *pd = uda134x->pd;
-	pr_debug("%s bias level %d\n", __func__, level);
-
-	switch (level) {
-	case SND_SOC_BIAS_ON:
-		break;
-	case SND_SOC_BIAS_PREPARE:
-		/* power on */
-		if (pd->power) {
-			pd->power(1);
-			regcache_sync(uda134x->regmap);
-		}
-		break;
-	case SND_SOC_BIAS_STANDBY:
-		break;
-	case SND_SOC_BIAS_OFF:
-		/* power off */
-		if (pd->power) {
-			pd->power(0);
-			regcache_mark_dirty(uda134x->regmap);
-		}
-		break;
-	}
-	return 0;
-}
-
-static const char *uda134x_dsp_setting[] = {"Flat", "Minimum1",
-					    "Minimum2", "Maximum"};
-static const char *uda134x_deemph[] = {"None", "32Khz", "44.1Khz", "48Khz"};
-static const char *uda134x_mixmode[] = {"Differential", "Analog1",
-					"Analog2", "Both"};
-
-static const struct soc_enum uda134x_mixer_enum[] = {
-SOC_ENUM_SINGLE(UDA134X_DATA010, 0, 0x04, uda134x_dsp_setting),
-SOC_ENUM_SINGLE(UDA134X_DATA010, 3, 0x04, uda134x_deemph),
-SOC_ENUM_SINGLE(UDA134X_EA010, 0, 0x04, uda134x_mixmode),
-};
-
-static const struct snd_kcontrol_new uda1341_snd_controls[] = {
-SOC_SINGLE("Master Playback Volume", UDA134X_DATA000, 0, 0x3F, 1),
-SOC_SINGLE("Capture Volume", UDA134X_EA010, 2, 0x07, 0),
-SOC_SINGLE("Analog1 Volume", UDA134X_EA000, 0, 0x1F, 1),
-SOC_SINGLE("Analog2 Volume", UDA134X_EA001, 0, 0x1F, 1),
-
-SOC_SINGLE("Mic Sensitivity", UDA134X_EA010, 2, 7, 0),
-SOC_SINGLE("Mic Volume", UDA134X_EA101, 0, 0x1F, 0),
-
-SOC_SINGLE("Tone Control - Bass", UDA134X_DATA001, 2, 0xF, 0),
-SOC_SINGLE("Tone Control - Treble", UDA134X_DATA001, 0, 3, 0),
-
-SOC_ENUM("Sound Processing Filter", uda134x_mixer_enum[0]),
-SOC_ENUM("PCM Playback De-emphasis", uda134x_mixer_enum[1]),
-SOC_ENUM("Input Mux", uda134x_mixer_enum[2]),
-
-SOC_SINGLE("AGC Switch", UDA134X_EA100, 4, 1, 0),
-SOC_SINGLE("AGC Target Volume", UDA134X_EA110, 0, 0x03, 1),
-SOC_SINGLE("AGC Timing", UDA134X_EA110, 2, 0x07, 0),
-
-SOC_SINGLE("DAC +6dB Switch", UDA134X_STATUS1, 6, 1, 0),
-SOC_SINGLE("ADC +6dB Switch", UDA134X_STATUS1, 5, 1, 0),
-SOC_SINGLE("ADC Polarity Switch", UDA134X_STATUS1, 4, 1, 0),
-SOC_SINGLE("DAC Polarity Switch", UDA134X_STATUS1, 3, 1, 0),
-SOC_SINGLE("Double Speed Playback Switch", UDA134X_STATUS1, 2, 1, 0),
-SOC_SINGLE("DC Filter Enable Switch", UDA134X_STATUS0, 0, 1, 0),
-};
-
-static const struct snd_kcontrol_new uda1340_snd_controls[] = {
-SOC_SINGLE("Master Playback Volume", UDA134X_DATA000, 0, 0x3F, 1),
-
-SOC_SINGLE("Tone Control - Bass", UDA134X_DATA001, 2, 0xF, 0),
-SOC_SINGLE("Tone Control - Treble", UDA134X_DATA001, 0, 3, 0),
-
-SOC_ENUM("Sound Processing Filter", uda134x_mixer_enum[0]),
-SOC_ENUM("PCM Playback De-emphasis", uda134x_mixer_enum[1]),
-
-SOC_SINGLE("DC Filter Enable Switch", UDA134X_STATUS0, 0, 1, 0),
-};
-
-static const struct snd_kcontrol_new uda1345_snd_controls[] = {
-SOC_SINGLE("Master Playback Volume", UDA134X_DATA000, 0, 0x3F, 1),
-
-SOC_ENUM("PCM Playback De-emphasis", uda134x_mixer_enum[1]),
-
-SOC_SINGLE("DC Filter Enable Switch", UDA134X_STATUS0, 0, 1, 0),
-};
-
-/* UDA1341 has the DAC/ADC power down in STATUS1 */
-static const struct snd_soc_dapm_widget uda1341_dapm_widgets[] = {
-	SND_SOC_DAPM_DAC("DAC", "Playback", UDA134X_STATUS1, 0, 0),
-	SND_SOC_DAPM_ADC("ADC", "Capture", UDA134X_STATUS1, 1, 0),
-};
-
-/* UDA1340/4/5 has the DAC/ADC pwoer down in DATA0 11 */
-static const struct snd_soc_dapm_widget uda1340_dapm_widgets[] = {
-	SND_SOC_DAPM_DAC("DAC", "Playback", UDA134X_DATA011, 0, 0),
-	SND_SOC_DAPM_ADC("ADC", "Capture", UDA134X_DATA011, 1, 0),
-};
-
-/* Common DAPM widgets */
-static const struct snd_soc_dapm_widget uda134x_dapm_widgets[] = {
-	SND_SOC_DAPM_INPUT("VINL1"),
-	SND_SOC_DAPM_INPUT("VINR1"),
-	SND_SOC_DAPM_INPUT("VINL2"),
-	SND_SOC_DAPM_INPUT("VINR2"),
-	SND_SOC_DAPM_OUTPUT("VOUTL"),
-	SND_SOC_DAPM_OUTPUT("VOUTR"),
-};
-
-static const struct snd_soc_dapm_route uda134x_dapm_routes[] = {
-	{ "ADC", NULL, "VINL1" },
-	{ "ADC", NULL, "VINR1" },
-	{ "ADC", NULL, "VINL2" },
-	{ "ADC", NULL, "VINR2" },
-	{ "VOUTL", NULL, "DAC" },
-	{ "VOUTR", NULL, "DAC" },
-};
-
-static const struct snd_soc_dai_ops uda134x_dai_ops = {
-	.startup	= uda134x_startup,
-	.shutdown	= uda134x_shutdown,
-	.hw_params	= uda134x_hw_params,
-	.mute_stream	= uda134x_mute,
-	.set_sysclk	= uda134x_set_dai_sysclk,
-	.set_fmt	= uda134x_set_dai_fmt,
-	.no_capture_mute = 1,
-};
-
-static struct snd_soc_dai_driver uda134x_dai = {
-	.name = "uda134x-hifi",
-	/* playback capabilities */
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = UDA134X_RATES,
-		.formats = UDA134X_FORMATS,
-	},
-	/* capture capabilities */
-	.capture = {
-		.stream_name = "Capture",
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = UDA134X_RATES,
-		.formats = UDA134X_FORMATS,
-	},
-	/* pcm operations */
-	.ops = &uda134x_dai_ops,
-};
-
-static int uda134x_soc_probe(struct snd_soc_component *component)
-{
-	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
-	struct uda134x_priv *uda134x = snd_soc_component_get_drvdata(component);
-	struct uda134x_platform_data *pd = uda134x->pd;
-	const struct snd_soc_dapm_widget *widgets;
-	unsigned int num_widgets;
-	int ret;
-
-	printk(KERN_INFO "UDA134X SoC Audio Codec\n");
-
-	switch (pd->model) {
-	case UDA134X_UDA1340:
-	case UDA134X_UDA1341:
-	case UDA134X_UDA1344:
-	case UDA134X_UDA1345:
-		break;
-	default:
-		printk(KERN_ERR "UDA134X SoC codec: "
-		       "unsupported model %d\n",
-			pd->model);
-		return -EINVAL;
-	}
-
-	if (pd->power)
-		pd->power(1);
-
-	uda134x_reset(component);
-
-	if (pd->model == UDA134X_UDA1341) {
-		widgets = uda1341_dapm_widgets;
-		num_widgets = ARRAY_SIZE(uda1341_dapm_widgets);
-	} else {
-		widgets = uda1340_dapm_widgets;
-		num_widgets = ARRAY_SIZE(uda1340_dapm_widgets);
-	}
-
-	ret = snd_soc_dapm_new_controls(dapm, widgets, num_widgets);
-	if (ret) {
-		printk(KERN_ERR "%s failed to register dapm controls: %d",
-			__func__, ret);
-		return ret;
-	}
-
-	switch (pd->model) {
-	case UDA134X_UDA1340:
-	case UDA134X_UDA1344:
-		ret = snd_soc_add_component_controls(component, uda1340_snd_controls,
-					ARRAY_SIZE(uda1340_snd_controls));
-	break;
-	case UDA134X_UDA1341:
-		ret = snd_soc_add_component_controls(component, uda1341_snd_controls,
-					ARRAY_SIZE(uda1341_snd_controls));
-	break;
-	case UDA134X_UDA1345:
-		ret = snd_soc_add_component_controls(component, uda1345_snd_controls,
-					ARRAY_SIZE(uda1345_snd_controls));
-	break;
-	default:
-		printk(KERN_ERR "%s unknown codec type: %d",
-			__func__, pd->model);
-		return -EINVAL;
-	}
-
-	if (ret < 0) {
-		printk(KERN_ERR "UDA134X: failed to register controls\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct snd_soc_component_driver soc_component_dev_uda134x = {
-	.probe			= uda134x_soc_probe,
-	.set_bias_level		= uda134x_set_bias_level,
-	.dapm_widgets		= uda134x_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(uda134x_dapm_widgets),
-	.dapm_routes		= uda134x_dapm_routes,
-	.num_dapm_routes	= ARRAY_SIZE(uda134x_dapm_routes),
-	.suspend_bias_off	= 1,
-	.idle_bias_on		= 1,
-	.use_pmdown_time	= 1,
-	.endianness		= 1,
-};
-
-static const struct regmap_config uda134x_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = UDA134X_DATA1,
-	.reg_defaults = uda134x_reg_defaults,
-	.num_reg_defaults = ARRAY_SIZE(uda134x_reg_defaults),
-	.cache_type = REGCACHE_RBTREE,
-
-	.reg_write = uda134x_regmap_write,
-};
-
-static int uda134x_codec_probe(struct platform_device *pdev)
-{
-	struct uda134x_platform_data *pd = pdev->dev.platform_data;
-	struct uda134x_priv *uda134x;
-	int ret;
-
-	if (!pd) {
-		dev_err(&pdev->dev, "Missing L3 bitbang function\n");
-		return -ENODEV;
-	}
-
-	uda134x = devm_kzalloc(&pdev->dev, sizeof(*uda134x), GFP_KERNEL);
-	if (!uda134x)
-		return -ENOMEM;
-
-	uda134x->pd = pd;
-	platform_set_drvdata(pdev, uda134x);
-
-	if (pd->l3.use_gpios) {
-		ret = l3_set_gpio_ops(&pdev->dev, &uda134x->pd->l3);
-		if (ret < 0)
-			return ret;
-	}
-
-	uda134x->regmap = devm_regmap_init(&pdev->dev, NULL, pd,
-		&uda134x_regmap_config);
-	if (IS_ERR(uda134x->regmap))
-		return PTR_ERR(uda134x->regmap);
-
-	return devm_snd_soc_register_component(&pdev->dev,
-			&soc_component_dev_uda134x, &uda134x_dai, 1);
-}
-
-static struct platform_driver uda134x_codec_driver = {
-	.driver = {
-		.name = "uda134x-codec",
-	},
-	.probe = uda134x_codec_probe,
-};
-
-module_platform_driver(uda134x_codec_driver);
-
-MODULE_DESCRIPTION("UDA134X ALSA soc codec driver");
-MODULE_AUTHOR("Zoltan Devai, Christian Pellegrin <chripell@evolware.org>");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/uda134x.h b/sound/soc/codecs/uda134x.h
deleted file mode 100644
index 664618c2571c..000000000000
--- a/sound/soc/codecs/uda134x.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _UDA134X_CODEC_H
-#define _UDA134X_CODEC_H
-
-#define UDA134X_L3ADDR	5
-#define UDA134X_DATA0_ADDR	((UDA134X_L3ADDR << 2) | 0)
-#define UDA134X_DATA1_ADDR	((UDA134X_L3ADDR << 2) | 1)
-#define UDA134X_STATUS_ADDR	((UDA134X_L3ADDR << 2) | 2)
-
-#define UDA134X_EXTADDR_PREFIX	0xC0
-#define UDA134X_EXTDATA_PREFIX	0xE0
-
-/* UDA134X registers */
-#define UDA134X_EA000	0
-#define UDA134X_EA001	1
-#define UDA134X_EA010	2
-#define UDA134X_EA011	3
-#define UDA134X_EA100	4
-#define UDA134X_EA101	5
-#define UDA134X_EA110	6
-#define UDA134X_EA111	7
-#define UDA134X_STATUS0 8
-#define UDA134X_STATUS1 9
-#define UDA134X_DATA000 10
-#define UDA134X_DATA001 11
-#define UDA134X_DATA010 12
-#define UDA134X_DATA011 13
-#define UDA134X_DATA1   14
-
-#define STATUS0_DAIFMT_MASK (~(7<<1))
-#define STATUS0_SYSCLK_MASK (~(3<<4))
-
-#endif

---
base-commit: 17b9f4387ebabb19b871bbe2d06562e48e4e7130
change-id: 20230821-delete-l3-573f483201e3

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

