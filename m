Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD67CC280
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343753AbjJQMIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343644AbjJQMHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:07:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799321FCC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so55479345e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544329; x=1698149129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p42f61CpUtMnJj/47/fYVjanoYa1QidKwMzIa52vOno=;
        b=uilx1vwS6vDfUa72y9oJf0tw4KFMENZ7iDorK6yc1XsGSdj4vwnGwgwmSGRKsV8se7
         HUrs+ix/1UGQ8sNEHpvfWWMt5EXA7nMGwBADRQeRIEeUZUnhDdxX7zbiSpvQKIES3Q2Q
         NWz8Iaue6jYURMoPQWNCw+tkV2v4ZvjwWTL6YdAMVmgIhDffJ3Bppt8/g5xBeWFkdM8n
         G16rlnjVeu+nbPj3DoVaWd2QBOLfWDD9aP8TSXNQW3pFw2JBDwch9swBalqTs85EBJF7
         oYE6GXHjCJriGMcBGJGEXgOwVWLGcADs7d7Vk2MI4WH8c6L1YShh79WkuVpuJcGinTD2
         5g3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544329; x=1698149129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p42f61CpUtMnJj/47/fYVjanoYa1QidKwMzIa52vOno=;
        b=nMT2svzLZ9c7AQ+d7BOe02Gj3p8hmIgcooUMMabiAoPVFSE1N1zJjWft6PcEyCAvS2
         VfEW5ok8WAu+vDVhuETdzFffjste+DHOI1zl3s6jpB0f+7rysjRbw93wZB7l3Xv17HVk
         dyxZ4T9pqtUkn75LGG0x7xPM4rKDs2S6SyyfOzREKKzmYdhM4jHyLrL48cfVd0iEUUd2
         JJbI0MS0KhCqtUh/Fl8GiJRJcz7TFGLxeFuFpUIYBPbkFCwISija6adKq7eBpf014pE3
         vqbxnOn96h0gCoc3SeYsG2UGj4RWevjjVUg5YiCu1e5E8J/6BTkplpY6nIXcBCYP0BEM
         8wuA==
X-Gm-Message-State: AOJu0Yx17ls4P+93dulNRqkxoCNcc2xZxbPnZVtqRxzufVrcBeZxw0Kr
        7WOaHxN6t3D+7XCEQ0UnzKpInQ==
X-Google-Smtp-Source: AGHT+IGv2Xe4CwTYDNz2u/cfF/4691A8eOUhjlPtHXifLJJRaCGAGtZ1ZAtF4IGeFWLnhYHGPpN+7A==
X-Received: by 2002:a05:600c:46c6:b0:406:7d74:a2a6 with SMTP id q6-20020a05600c46c600b004067d74a2a6mr1664614wmo.24.1697544329693;
        Tue, 17 Oct 2023 05:05:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:29 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 43/73] treewide: rename pinctrl_gpio_request_new()
Date:   Tue, 17 Oct 2023 14:04:01 +0200
Message-Id: <20231017120431.68847-44-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017120431.68847-1-brgl@bgdev.pl>
References: <20231017120431.68847-1-brgl@bgdev.pl>
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
index 37c1df78437f..794408be7109 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2036,7 +2036,7 @@ int gpiochip_generic_request(struct gpio_chip *gc, unsigned int offset)
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
index 20f4b655aa08..d200a887dc5d 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -784,7 +784,7 @@ bool pinctrl_gpio_can_use_line(struct gpio_chip *gc, unsigned int offset)
 EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line);
 
 /**
- * pinctrl_gpio_request_new() - request a single pin to be used as GPIO
+ * pinctrl_gpio_request() - request a single pin to be used as GPIO
  * @gc: GPIO chip structure from the GPIO subsystem
  * @offset: hardware offset of the GPIO relative to the controller
  *
@@ -792,7 +792,7 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line);
  * as part of their gpio_request() semantics, platforms and individual drivers
  * shall *NOT* request GPIO pins to be muxed in.
  */
-int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
+int pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset)
 {
 	struct pinctrl_gpio_range *range;
 	struct pinctrl_dev *pctldev;
@@ -817,7 +817,7 @@ int pinctrl_gpio_request_new(struct gpio_chip *gc, unsigned int offset)
 
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
index 22d4ab7d228c..c5d247d24374 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1056,7 +1056,7 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	if (ret)
 		return ret;
 
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

