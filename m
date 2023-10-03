Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486827B6C61
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbjJCOxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240391AbjJCOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:52:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077EA10F1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405417465aaso10586815e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344709; x=1696949509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1G3Tmn2clG9elbTVRato2w4TSxjOdgdl/2ux8u+oR3U=;
        b=TGYNkwXW62jzoMJAoDxnBVTtmvb9uvC7RgiaoBzKn8oiK98EUVbTMoTV5WCdL2TBAN
         awOoog7VpJzD0DMw6TFB7vGKbAkSla+fdcHZS/9j7vXHGvgVCJjKaT6BtKwZQmGdAAZR
         WI5uuvDuCT4udkdeXp0x4QZZYZjwClZ+qWF+L2MnXF51Bl+k1k0nR0HkurWt8K4Es3Fh
         ca7gkECDrB3+oQHjOopGc2jHKsrmDF8jg3a82zguc3K7t5Bh3JZsqN0VrCLvTnqkWpLX
         n6v6gDPXDam5SB/3uoUvWDuwcjudTSM1OdJzW7kGX2/oJgD7PdeYW5z1dbbZ/qwDu3F5
         qISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344709; x=1696949509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1G3Tmn2clG9elbTVRato2w4TSxjOdgdl/2ux8u+oR3U=;
        b=v0oBidFw9ChygFbII4OX6mkIKXuhKgmR072pNIAdS76nTHxekKgyxk92pYiVS49La1
         VFXK/EApxSqNYy4k4yFt78wV/3QzAND/9WccPCmfXqZ1GjKlhFw/zyYeiWvqfaZnH0rx
         qImxjCIwvDwt08o+Ekro4la7uFTLBHHE6mwk4r3pg+urz7aC72cCHHIrF15bg0Kw47AM
         3/72I9p138aAylKzX4BxjIqKmrWdk5jbrOzKmIaXoWQy8myK+BxO2Gj+02RS/UF3BKSj
         a8+4H7E+L6NL9ytBGPOF5ifMKPSRwl0afL1haV/M9tJdtSerNqFaxKlLLL/Oz5vp+jOr
         AwHA==
X-Gm-Message-State: AOJu0YxBBQYjTci7EuGAidM1AnTFu/6xiJI05P/PhTT46tKX5SjKLQ7L
        8ryxKtnv1O3EtuQsSz9xxjwvpQ==
X-Google-Smtp-Source: AGHT+IFhCF7l1F0x8vkux4HbZ50WrLEyk+eX3M5ouS3yoWmbxfDBcvd8pnF2kT2N55sfOxi0nokpJA==
X-Received: by 2002:a05:600c:28c:b0:401:519:d2 with SMTP id 12-20020a05600c028c00b00401051900d2mr11822575wmk.23.1696344709254;
        Tue, 03 Oct 2023 07:51:49 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:48 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 32/36] treewide: rename pinctrl_gpio_request_new()
Date:   Tue,  3 Oct 2023 16:51:10 +0200
Message-Id: <20231003145114.21637-33-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003145114.21637-1-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Now that pinctrl_gpio_request() is no longer used, let's drop the '_new'
suffix from its improved variant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-aspeed.c                         | 2 +-
 drivers/gpio/gpio-em.c                             | 2 +-
 drivers/gpio/gpio-rcar.c                           | 2 +-
 drivers/gpio/gpio-tegra.c                          | 2 +-
 drivers/gpio/gpiolib.c                             | 2 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c           | 2 +-
 drivers/pinctrl/core.c                             | 6 +++---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          | 2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c          | 2 +-
 drivers/pinctrl/renesas/gpio.c                     | 2 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            | 2 +-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c            | 2 +-
 drivers/pinctrl/spear/pinctrl-plgpio.c             | 2 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 2 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              | 2 +-
 include/linux/pinctrl/consumer.h                   | 4 ++--
 17 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index d3aa1cfd4ace..af851c89cacc 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -750,7 +750,7 @@ static int aspeed_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	if (!have_gpio(gpiochip_get_data(chip), offset))
 		return -ENODEV;
 
-	return pinctrl_gpio_request_new(chip, offset);
+	return pinctrl_gpio_request(chip, offset);
 }
 
 static void aspeed_gpio_free(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index 35c65ff43f71..08c5427deb71 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -229,7 +229,7 @@ static int em_gio_to_irq(struct gpio_chip *chip, unsigned offset)
 
 static int em_gio_request(struct gpio_chip *chip, unsigned offset)
 {
-	return pinctrl_gpio_request_new(chip, offset);
+	return pinctrl_gpio_request(chip, offset);
 }
 
 static void em_gio_free(struct gpio_chip *chip, unsigned offset)
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 47121e1a6d4e..8c98730a7ad2 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -275,7 +275,7 @@ static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
 		return error;
 	}
 
-	error = pinctrl_gpio_request_new(chip, offset);
+	error = pinctrl_gpio_request(chip, offset);
 	if (error)
 		pm_runtime_put(p->dev);
 
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 08951ddcd294..c974ba368d18 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -139,7 +139,7 @@ static void tegra_gpio_disable(struct tegra_gpio_info *tgi, unsigned int gpio)
 
 static int tegra_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_request_new(chip, offset);
+	return pinctrl_gpio_request(chip, offset);
 }
 
 static void tegra_gpio_free(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 511f6220071d..7fc97f7ac3ee 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1854,7 +1854,7 @@ int gpiochip_generic_request(struct gpio_chip *gc, unsigned int offset)
 		return 0;
 #endif
 
-	return pinctrl_gpio_request_new(gc, offset);
+	return pinctrl_gpio_request(gc, offset);
 }
 EXPORT_SYMBOL_GPL(gpiochip_generic_request);
 
diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index fb98c3e14743..8162dd840933 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -335,7 +335,7 @@ static int iproc_gpio_request(struct gpio_chip *gc, unsigned offset)
 	if (!chip->pinmux_is_supported)
 		return 0;
 
-	return pinctrl_gpio_request_new(gc, offset);
+	return pinctrl_gpio_request(gc, offset);
 }
 
 static void iproc_gpio_free(struct gpio_chip *gc, unsigned offset)
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index eb12aec39ed1..4ce6c73d9813 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -778,7 +778,7 @@ bool pinctrl_gpio_can_use_line(struct gpio_chip *gc, unsigned int offset)
 EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line);
 
 /**
- * pinctrl_gpio_request_new() - request a single pin to be used as GPIO
+ * pinctrl_gpio_request() - request a single pin to be used as GPIO
  * @gc: GPIO chip structure from the GPIO subsystem
  * @offset: hardware offset of the GPIO relative to the controller
  *
@@ -786,7 +786,7 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line);
  * as part of their gpio_request() semantics, platforms and individual drivers
  * shall *NOT* request GPIO pins to be muxed in.
  */
-int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
+int pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset)
 {
 	struct pinctrl_gpio_range *range;
 	struct pinctrl_dev *pctldev;
@@ -809,7 +809,7 @@ int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(pinctrl_gpio_request_new);
+EXPORT_SYMBOL_GPL(pinctrl_gpio_request);
 
 /**
  * pinctrl_gpio_free_new() - free control on a single pin, currently used as GPIO
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 62134a7f0b4e..ad39b8c060b7 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -201,7 +201,7 @@ static int npcmgpio_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	int ret;
 
 	dev_dbg(chip->parent, "gpio_request: offset%d\n", offset);
-	ret = pinctrl_gpio_request_new(chip, offset);
+	ret = pinctrl_gpio_request(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index 0b6d6964087e..dd4532ae62bf 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -198,7 +198,7 @@ static int npcmgpio_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	struct npcm8xx_gpio *bank = gpiochip_get_data(chip);
 	int ret;
 
-	ret = pinctrl_gpio_request_new(chip, offset);
+	ret = pinctrl_gpio_request(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/renesas/gpio.c b/drivers/pinctrl/renesas/gpio.c
index e7771a57e6d1..0c4f4d8d0891 100644
--- a/drivers/pinctrl/renesas/gpio.c
+++ b/drivers/pinctrl/renesas/gpio.c
@@ -135,7 +135,7 @@ static int gpio_pin_request(struct gpio_chip *gc, unsigned offset)
 	if (idx < 0 || pfc->info->pins[idx].enum_id == 0)
 		return -EINVAL;
 
-	return pinctrl_gpio_request_new(gc, offset);
+	return pinctrl_gpio_request(gc, offset);
 }
 
 static void gpio_pin_free(struct gpio_chip *gc, unsigned offset)
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index b9195fff0abd..d7ce56243a78 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -801,7 +801,7 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	u8 reg8;
 	int ret;
 
-	ret = pinctrl_gpio_request_new(chip, offset);
+	ret = pinctrl_gpio_request(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 3d29c77a5aad..1ec0922f735c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -754,7 +754,7 @@ static int rzv2m_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	u8 bit = RZV2M_PIN_ID_TO_PIN(offset);
 	int ret;
 
-	ret = pinctrl_gpio_request_new(chip, offset);
+	ret = pinctrl_gpio_request(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/spear/pinctrl-plgpio.c b/drivers/pinctrl/spear/pinctrl-plgpio.c
index 7488f6394318..6d3b7ce1c35a 100644
--- a/drivers/pinctrl/spear/pinctrl-plgpio.c
+++ b/drivers/pinctrl/spear/pinctrl-plgpio.c
@@ -210,7 +210,7 @@ static int plgpio_request(struct gpio_chip *chip, unsigned offset)
 	if (offset >= chip->ngpio)
 		return -EINVAL;
 
-	ret = pinctrl_gpio_request_new(chip, offset);
+	ret = pinctrl_gpio_request(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
index 22a2db8fa315..88e39f68ef25 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
@@ -918,7 +918,7 @@ static struct pinctrl_desc starfive_desc = {
 
 static int starfive_gpio_request(struct gpio_chip *gc, unsigned int gpio)
 {
-	return pinctrl_gpio_request_new(gc, gpio);
+	return pinctrl_gpio_request(gc, gpio);
 }
 
 static void starfive_gpio_free(struct gpio_chip *gc, unsigned int gpio)
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 5557ef3fbeb2..c458c6fb992f 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -547,7 +547,7 @@ static const struct pinconf_ops jh7110_pinconf_ops = {
 
 static int jh7110_gpio_request(struct gpio_chip *gc, unsigned int gpio)
 {
-	return pinctrl_gpio_request_new(gc, gpio);
+	return pinctrl_gpio_request(gc, gpio);
 }
 
 static void jh7110_gpio_free(struct gpio_chip *gc, unsigned int gpio)
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 11d9f07934bd..dddbdc1a64c5 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -217,7 +217,7 @@ static int stm32_gpio_request(struct gpio_chip *chip, unsigned offset)
 		return -EINVAL;
 	}
 
-	return pinctrl_gpio_request_new(chip, offset);
+	return pinctrl_gpio_request(chip, offset);
 }
 
 static void stm32_gpio_free(struct gpio_chip *chip, unsigned offset)
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 4f9ead7f65d2..05b2dae05f24 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -27,7 +27,7 @@ struct pinctrl_state;
 
 /* External interface to pin control */
 bool pinctrl_gpio_can_use_line(struct gpio_chip *gc, unsigned int offset);
-int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset);
+int pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset);
 void pinctrl_gpio_free_new(struct gpio_chip *gc, unsigned int offset);
 int pinctrl_gpio_direction_input_new(struct gpio_chip *gc,
 				     unsigned int offset);
@@ -74,7 +74,7 @@ pinctrl_gpio_can_use_line(struct gpio_chip *gc, unsigned int offset)
 }
 
 static inline int
-pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
+pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset)
 {
 	return 0;
 }
-- 
2.39.2

