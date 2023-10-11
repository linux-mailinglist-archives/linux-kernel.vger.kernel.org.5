Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC467C531C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346824AbjJKMKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346717AbjJKMJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77AD10A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4054496bde3so62404325e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026163; x=1697630963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPRzIFIU2I284yl/ON43iSE6foshfftHmva92Etqe/c=;
        b=GgK3oqbdlBZcC1z8a40Zu2Cc6YgH9UC1Kf/M3npSmRJWgj2mnxWR7iFeRvtzcaZwJI
         OWwDWghfANbcISt20RhPDZoQOxyjHK1lSF3zjRTW03/XUJG8BDQSaGrQ9O9dRun/c66b
         yv0YAnEvvpYZCqaPD80Q9aFruK2+GcC4tNwuiN1iXqry2oV3vMkMTPNhrRjEh5fObNk7
         V2bLTjDkh/H/6iNB1rp3iZpW7ySCssJ+q3SZtiPIG8rFKbrQS1GjYa25ZC271G5sUyoE
         7lK22ZI9cVmXd37xXeQSph7M9dbuLZ6QFvRlY/5uKqFEfZTZehczRc7yGtudla3R57zd
         /8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026163; x=1697630963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPRzIFIU2I284yl/ON43iSE6foshfftHmva92Etqe/c=;
        b=Ia7moSWwqkbmvbX+QjYhtHWjp0fDgvJIQ4Ksa5ZX7nNdBBJvQabtlNJu+3USYRCIkE
         JrwczrJ46C9DCRUQj0FTkmGp1iLKxYkr4SWG2DukhLYjaeNMBmrGbftj+jY78XffZthe
         rOMvZuE+U4X/nuAaR4yV8F9O+wpTVqMElg9UegYDkeXIwNh5/lo+Dp4GymML9pwkuZwB
         hJ6jyo2u2cWTmmf3otNaVLbZNlyP/DJ/D9fs83gMnG/Slnd77amX+3MJ0xrKLMFgDaP7
         t8xHYvWCryv0HZh3FkT++TXQMCyRRuPd7ubYwFcXIB4IAKcanlyMRXeHTNhysfaUKi9p
         aabA==
X-Gm-Message-State: AOJu0Yzv+UE+CT6VPFm5tQDjH5Tcicg9RFw6jALUMl7RynWnKhAckKQ1
        3sK8BVU+A5rouynWsUULzKmRUQ==
X-Google-Smtp-Source: AGHT+IEaSIIbvKhgV5gHxYWEYnfgCLYCY1HHJ9DSqRepIYLW0M9ek/Lk6IyRaz0mHxUuATwPd1ChZg==
X-Received: by 2002:a05:600c:2197:b0:405:514d:eb0e with SMTP id e23-20020a05600c219700b00405514deb0emr18330423wme.19.1697026162724;
        Wed, 11 Oct 2023 05:09:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v2 17/62] pinctrl: spear: use new pinctrl GPIO helpers
Date:   Wed, 11 Oct 2023 14:07:45 +0200
Message-Id: <20231011120830.49324-18-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Replace the pinctrl helpers taking the global GPIO number as argument
with the improved variants that instead take a pointer to the GPIO chip
and the controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/pinctrl/spear/pinctrl-plgpio.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/spear/pinctrl-plgpio.c b/drivers/pinctrl/spear/pinctrl-plgpio.c
index 722681e0b89b..7488f6394318 100644
--- a/drivers/pinctrl/spear/pinctrl-plgpio.c
+++ b/drivers/pinctrl/spear/pinctrl-plgpio.c
@@ -204,14 +204,13 @@ static void plgpio_set_value(struct gpio_chip *chip, unsigned offset, int value)
 static int plgpio_request(struct gpio_chip *chip, unsigned offset)
 {
 	struct plgpio *plgpio = gpiochip_get_data(chip);
-	int gpio = chip->base + offset;
 	unsigned long flags;
 	int ret = 0;
 
 	if (offset >= chip->ngpio)
 		return -EINVAL;
 
-	ret = pinctrl_gpio_request(gpio);
+	ret = pinctrl_gpio_request_new(chip, offset);
 	if (ret)
 		return ret;
 
@@ -249,14 +248,13 @@ static int plgpio_request(struct gpio_chip *chip, unsigned offset)
 	if (!IS_ERR(plgpio->clk))
 		clk_disable(plgpio->clk);
 err0:
-	pinctrl_gpio_free(gpio);
+	pinctrl_gpio_free_new(chip, offset);
 	return ret;
 }
 
 static void plgpio_free(struct gpio_chip *chip, unsigned offset)
 {
 	struct plgpio *plgpio = gpiochip_get_data(chip);
-	int gpio = chip->base + offset;
 	unsigned long flags;
 
 	if (offset >= chip->ngpio)
@@ -280,7 +278,7 @@ static void plgpio_free(struct gpio_chip *chip, unsigned offset)
 	if (!IS_ERR(plgpio->clk))
 		clk_disable(plgpio->clk);
 
-	pinctrl_gpio_free(gpio);
+	pinctrl_gpio_free_new(chip, offset);
 }
 
 /* PLGPIO IRQ */
-- 
2.39.2

