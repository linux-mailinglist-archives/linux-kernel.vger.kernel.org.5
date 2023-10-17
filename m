Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165C27CC29E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343722AbjJQMJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343630AbjJQMI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:08:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510142D50
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so52642295e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697544356; x=1698149156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFr6QY4eYLHOc0l8IDUIWTqpQdT11W1FKFRdkIoRPQg=;
        b=ghgZqeTtDAKbSvx4tlkoqTWvfg8HtDmDOE7aIMpAFs/VqnbaIEWd+uTED8FKsJx4k7
         7n7GTzedxzwz2UjuWDYUNbbXPZUuPDBV6jbHyjTwon0N13TdugHEujo6TMwaU7qRfzfO
         dIzMGxGGVIRE0lGaHvsTbnjvRgkeK1yoWlsHEw9Q/Waf/KntEfQ4tALF97xYyDUAeVqG
         YRp+VwMvmyZvlSVxVqgzKMjJQauY5Xvt0/yEGDlMgdZUz8gXpFBIwgyznPVnluZZYbbR
         oWSkYkpP37/IuGIFog1XK5JiyRfNKMaybLjeJMznwx7ihjleCXGJ1MhP3l3XwwSuIB4S
         jP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544356; x=1698149156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFr6QY4eYLHOc0l8IDUIWTqpQdT11W1FKFRdkIoRPQg=;
        b=uO7aSVw/FjYqjvOq84NGe3LF+Z2gW2g/OUkklRvtTnx6uiTX+xbRPMwio7/7cW0WyW
         FOs03NdeokytDJZMXmVg8jEEgwMhnLguaX+mw2LGeUVBQUghWeyEIbHq+nDapYxAGdM6
         348qgVfWpzNNhNQfTsTfLlAY2WR8ciBDmnOvnw0d7Qd2fNyrODHRarZ5kEm+PM3vmD7d
         FDCWlxsRMnjbevxdKPVVFCmjvQmamBHQNX3CpULoxgEo6OVWula+gUOcZ4sW5sTXUeRy
         dMAIerQjYVx+DfY4gPrpR0t+3s726zBNm9YX8S/d6zYlXRLD3Ia36PgrWsGl9NCKX0wb
         jKCg==
X-Gm-Message-State: AOJu0YzD+OBgnWBQ2+3z5nP4vonomZ0fK2v+mgcGRLYtY5WWKZMkmA+a
        cKb1vnFN6L2lGsPx9sM4TVyDug==
X-Google-Smtp-Source: AGHT+IGECM7QoHgQLkn+z0jqNBZrYL350nPR+9uCcxQUMyXZBzyjmzw27zG6PUgXLvkccP0VYZsurg==
X-Received: by 2002:a05:600c:4f15:b0:401:bdd7:49ae with SMTP id l21-20020a05600c4f1500b00401bdd749aemr1687396wmq.18.1697544355901;
        Tue, 17 Oct 2023 05:05:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b00405442edc69sm1353859wmm.14.2023.10.17.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:05:55 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 71/73] pinctrl: nuvoton: npcm8xx: drop wrappers around pinctrl_gpio_request/free()
Date:   Tue, 17 Oct 2023 14:04:29 +0200
Message-Id: <20231017120431.68847-72-brgl@bgdev.pl>
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

pinctrl_gpio_*() helpers now have signatures corresponding with those of
the GPIOLIB callbacks. We can drop the wrappers.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index 140fdbbe8458..a377d36b0eb0 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -205,11 +205,6 @@ static int npcmgpio_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	return bank->request(chip, offset);
 }
 
-static void npcmgpio_gpio_free(struct gpio_chip *chip, unsigned int offset)
-{
-	pinctrl_gpio_free(chip, offset);
-}
-
 static void npcmgpio_irq_handler(struct irq_desc *desc)
 {
 	unsigned long sts, en, bit;
@@ -2388,7 +2383,7 @@ static int npcm8xx_gpio_fw(struct npcm8xx_pinctrl *pctrl)
 		pctrl->gpio_bank[id].gc.direction_output = npcmgpio_direction_output;
 		pctrl->gpio_bank[id].request = pctrl->gpio_bank[id].gc.request;
 		pctrl->gpio_bank[id].gc.request = npcmgpio_gpio_request;
-		pctrl->gpio_bank[id].gc.free = npcmgpio_gpio_free;
+		pctrl->gpio_bank[id].gc.free = pinctrl_gpio_free;
 		for (i = 0 ; i < NPCM8XX_DEBOUNCE_MAX ; i++)
 			pctrl->gpio_bank[id].debounce.set_val[i] = false;
 		pctrl->gpio_bank[id].gc.add_pin_ranges = npcmgpio_add_pin_ranges;
-- 
2.39.2

