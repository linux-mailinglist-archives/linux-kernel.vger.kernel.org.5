Return-Path: <linux-kernel+bounces-162065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC63E8B5575
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2871C21E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9FF3D54C;
	Mon, 29 Apr 2024 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t2mHGuw1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CBD3BBC7;
	Mon, 29 Apr 2024 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386955; cv=none; b=QlMFiUdwHbJD5LEN3csoY5QbPAiaz1XRZycOV7CPWDaMKbxPuNWA3pFcIEuQe8aMypMDV6w68qBg9xrq6XQ9aA8HQF3FRzwmKpM0nG+nLibJlT+bjvS8mcIniSZV5jPNIamWEJfKd0viwvqh1KO456sHjWciQz3GbdRMusY3h7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386955; c=relaxed/simple;
	bh=lorneWCfie5zAf/sR1Ivkns2EJjrI2HUJb9y/9+fSJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpX/B8jXDGSdaGdM63uMhTUVAp88UZCT2JszhvVPQksXM7hyZCHqQAcJCzad2IHR1NziMDNVx3TnvRAMU3eoNjHbaUsYMJGMOkTYIUUdvGlG1481Srp0h5CnJZgzp/Z+XSjETMV1obEbqPNklRLLbEQFVDRa5v3xOWxQSoV7E0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t2mHGuw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5372C4AF1B;
	Mon, 29 Apr 2024 10:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714386955;
	bh=lorneWCfie5zAf/sR1Ivkns2EJjrI2HUJb9y/9+fSJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2mHGuw149tJgw1/0AERhWuhw23DgnO1bkTOsXOvfh94zkGdCY1hp/7j+DoLfGS0f
	 4n/Jl/8ZLOzzCjyuFRBqiR8c2jiAqskbmzNNegD1zlankqNKM5zb/2p1v0BluJJCor
	 8XlPF3l3iUukGEga+W43zzfMmBFkZDtztcW7pM9U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.89
Date: Mon, 29 Apr 2024 12:35:50 +0200
Message-ID: <2024042915-lustfully-hardness-1f6c@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024042914-steadfast-skirmish-6b76@gregkh>
References: <2024042914-steadfast-skirmish-6b76@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index c73cb678fb9a..a0472e1cf715 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 88
+SUBLEVEL = 89
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 44da1e14a374..9deba798cc91 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -257,19 +257,9 @@ static struct platform_device pandora_backlight = {
 	.id	= -1,
 };
 
-static struct gpiod_lookup_table pandora_soc_audio_gpios = {
-	.dev_id = "soc-audio",
-	.table = {
-		GPIO_LOOKUP("gpio-112-127", 6, "dac", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("gpio-0-15", 14, "amp", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
 static void __init omap3_pandora_legacy_init(void)
 {
 	platform_device_register(&pandora_backlight);
-	gpiod_add_lookup_table(&pandora_soc_audio_gpios);
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
diff --git a/sound/soc/ti/omap3pandora.c b/sound/soc/ti/omap3pandora.c
index fa92ed97dfe3..a287e9747c2a 100644
--- a/sound/soc/ti/omap3pandora.c
+++ b/sound/soc/ti/omap3pandora.c
@@ -7,7 +7,7 @@
 
 #include <linux/clk.h>
 #include <linux/platform_device.h>
-#include <linux/gpio/consumer.h>
+#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
@@ -21,11 +21,12 @@
 
 #include "omap-mcbsp.h"
 
+#define OMAP3_PANDORA_DAC_POWER_GPIO	118
+#define OMAP3_PANDORA_AMP_POWER_GPIO	14
+
 #define PREFIX "ASoC omap3pandora: "
 
 static struct regulator *omap3pandora_dac_reg;
-static struct gpio_desc *dac_power_gpio;
-static struct gpio_desc *amp_power_gpio;
 
 static int omap3pandora_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
@@ -77,9 +78,9 @@ static int omap3pandora_dac_event(struct snd_soc_dapm_widget *w,
 			return ret;
 		}
 		mdelay(1);
-		gpiod_set_value(dac_power_gpio, 1);
+		gpio_set_value(OMAP3_PANDORA_DAC_POWER_GPIO, 1);
 	} else {
-		gpiod_set_value(dac_power_gpio, 0);
+		gpio_set_value(OMAP3_PANDORA_DAC_POWER_GPIO, 0);
 		mdelay(1);
 		regulator_disable(omap3pandora_dac_reg);
 	}
@@ -91,9 +92,9 @@ static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
-		gpiod_set_value(amp_power_gpio, 1);
+		gpio_set_value(OMAP3_PANDORA_AMP_POWER_GPIO, 1);
 	else
-		gpiod_set_value(amp_power_gpio, 0);
+		gpio_set_value(OMAP3_PANDORA_AMP_POWER_GPIO, 0);
 
 	return 0;
 }
@@ -228,10 +229,35 @@ static int __init omap3pandora_soc_init(void)
 
 	pr_info("OMAP3 Pandora SoC init\n");
 
+	ret = gpio_request(OMAP3_PANDORA_DAC_POWER_GPIO, "dac_power");
+	if (ret) {
+		pr_err(PREFIX "Failed to get DAC power GPIO\n");
+		return ret;
+	}
+
+	ret = gpio_direction_output(OMAP3_PANDORA_DAC_POWER_GPIO, 0);
+	if (ret) {
+		pr_err(PREFIX "Failed to set DAC power GPIO direction\n");
+		goto fail0;
+	}
+
+	ret = gpio_request(OMAP3_PANDORA_AMP_POWER_GPIO, "amp_power");
+	if (ret) {
+		pr_err(PREFIX "Failed to get amp power GPIO\n");
+		goto fail0;
+	}
+
+	ret = gpio_direction_output(OMAP3_PANDORA_AMP_POWER_GPIO, 0);
+	if (ret) {
+		pr_err(PREFIX "Failed to set amp power GPIO direction\n");
+		goto fail1;
+	}
+
 	omap3pandora_snd_device = platform_device_alloc("soc-audio", -1);
 	if (omap3pandora_snd_device == NULL) {
 		pr_err(PREFIX "Platform device allocation failed\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto fail1;
 	}
 
 	platform_set_drvdata(omap3pandora_snd_device, &snd_soc_card_omap3pandora);
@@ -242,20 +268,6 @@ static int __init omap3pandora_soc_init(void)
 		goto fail2;
 	}
 
-	dac_power_gpio = devm_gpiod_get(&omap3pandora_snd_device->dev,
-					"dac", GPIOD_OUT_LOW);
-	if (IS_ERR(dac_power_gpio)) {
-		ret = PTR_ERR(dac_power_gpio);
-		goto fail3;
-	}
-
-	amp_power_gpio = devm_gpiod_get(&omap3pandora_snd_device->dev,
-					"amp", GPIOD_OUT_LOW);
-	if (IS_ERR(amp_power_gpio)) {
-		ret = PTR_ERR(amp_power_gpio);
-		goto fail3;
-	}
-
 	omap3pandora_dac_reg = regulator_get(&omap3pandora_snd_device->dev, "vcc");
 	if (IS_ERR(omap3pandora_dac_reg)) {
 		pr_err(PREFIX "Failed to get DAC regulator from %s: %ld\n",
@@ -271,7 +283,10 @@ static int __init omap3pandora_soc_init(void)
 	platform_device_del(omap3pandora_snd_device);
 fail2:
 	platform_device_put(omap3pandora_snd_device);
-
+fail1:
+	gpio_free(OMAP3_PANDORA_AMP_POWER_GPIO);
+fail0:
+	gpio_free(OMAP3_PANDORA_DAC_POWER_GPIO);
 	return ret;
 }
 module_init(omap3pandora_soc_init);
@@ -280,6 +295,8 @@ static void __exit omap3pandora_soc_exit(void)
 {
 	regulator_put(omap3pandora_dac_reg);
 	platform_device_unregister(omap3pandora_snd_device);
+	gpio_free(OMAP3_PANDORA_AMP_POWER_GPIO);
+	gpio_free(OMAP3_PANDORA_DAC_POWER_GPIO);
 }
 module_exit(omap3pandora_soc_exit);
 

