Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434E878133D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379571AbjHRTKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379538AbjHRTJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:09:52 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB1A3A9C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:09:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3198d2745feso1061857f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692385789; x=1692990589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=amkvA6oVV+l1eNsM2AWwmHoLgXyiDp9eihxuhp7cWNc=;
        b=3mIHXGgU/eI83YuHIPw3zwbwQTJNCeegwalUbfzmwqPus1IF6TO+/9fouBkFV3uRg7
         HXKpZ9Dum1GCYwkE+BpbGhEEfME9xE6jT2HCakTssRn36cfog2hTN3p9kD/IvbSF3Q2g
         qx8+4mom7REdxk9eM0HDojVBpSD1Vt1cjORzQGbjUK8dcxuHxHx09E4VELHSSmuaN/LJ
         ohxzRbWImIyKG6BtDjJWwhjXTXceVxxbp0rhbCNa0jv38yMI5vnAZKIpYx37iTOeb/od
         OOwiqjAU6VhYvMVtAyvsdVOVZ2wpM796HT2jd0S9tbXLwrOu5YLF3ND0vjS1FPMBftd8
         H+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692385789; x=1692990589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amkvA6oVV+l1eNsM2AWwmHoLgXyiDp9eihxuhp7cWNc=;
        b=AgMbGsRIS8H5J7UU6FIwGa7Og40vc8rtZlWRYswX8XbqCuET9m1df9HsSofW8c6EvB
         gGPE730dVtJEiaEKuawUEZhTyBTTUBfzTBLiZ6wrr8RTwRv8JsqJoajOZODH8iM/c0mz
         MWI6Ru/YBwr4B2LQu5BrjqG5wo0QWwpVCgIUiwEBhB7z7jceYMkTonyRtHz1DrT4as33
         Ym3HkOkX5nbn6E/ByZrdNKz7I2l+E7MNhr11P5xhbbWtl4Wf2x9KxOClCRhrD6dEKawQ
         gvE7snZfN90GuuW7WZ45hRMsuhqshcOtlRxKgPwNf0uat6qKrOVLuAIVsKq4f9+xu/a9
         vzXw==
X-Gm-Message-State: AOJu0YzvIU4Z80AkuoOQLQiGUESkc5hC73cBZFhsXTRNIwdB20QjkPB5
        k4by8yJnwUekluxZwYUZE3yJP6cWbxvTIUZSbXdVvA==
X-Google-Smtp-Source: AGHT+IESWKOC22E20uRDQDPy12DpszS869olMVnEFhVi1k3xxTPABCit6DasW/5yeaTfK+91OxnqNQ==
X-Received: by 2002:a05:6000:87:b0:317:69d2:35c2 with SMTP id m7-20020a056000008700b0031769d235c2mr88663wrx.2.1692385788947;
        Fri, 18 Aug 2023 12:09:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d1c5:9f1f:6f05:38a3])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d630e000000b0031980783d78sm3669191wru.54.2023.08.18.12.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 12:09:48 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpiolib: notify user-space about line state changes triggered by kernel
Date:   Fri, 18 Aug 2023 21:09:44 +0200
Message-Id: <20230818190944.22177-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We currently only emit CHANGED_CONFIG events when the user-space changes
GPIO config. We won't be notified if changes come from in-kernel. Let's
call the notifier chain whenever kernel users change direction or any of
the active-low, debounce or consumer name settings. We don't notify the
user-space about the persistence as the uAPI has no notion of it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 76e0c38026c3..77e0d0afa2b5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2421,6 +2421,9 @@ int gpiod_direction_input(struct gpio_desc *desc)
 	}
 	if (ret == 0) {
 		clear_bit(FLAG_IS_OUT, &desc->flags);
+		blocking_notifier_call_chain(&desc->gdev->notifier,
+					     GPIO_V2_LINE_CHANGED_CONFIG,
+					     desc);
 		ret = gpio_set_bias(desc);
 	}
 
@@ -2466,8 +2469,12 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 		gc->set(gc, gpio_chip_hwgpio(desc), val);
 	}
 
-	if (!ret)
+	if (!ret) {
 		set_bit(FLAG_IS_OUT, &desc->flags);
+		blocking_notifier_call_chain(&desc->gdev->notifier,
+					     GPIO_V2_LINE_CHANGED_CONFIG,
+					     desc);
+	}
 	trace_gpio_value(desc_to_gpio(desc), 0, val);
 	trace_gpio_direction(desc_to_gpio(desc), 0, ret);
 	return ret;
@@ -2654,9 +2661,15 @@ EXPORT_SYMBOL_GPL(gpiod_set_config);
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned int debounce)
 {
 	unsigned long config;
+	int ret;
 
 	config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
-	return gpiod_set_config(desc, config);
+	ret = gpiod_set_config(desc, config);
+	if (!ret)
+		blocking_notifier_call_chain(&desc->gdev->notifier,
+					     GPIO_V2_LINE_CHANGED_CONFIG,
+					     desc);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(gpiod_set_debounce);
 
@@ -2705,6 +2718,8 @@ void gpiod_toggle_active_low(struct gpio_desc *desc)
 {
 	VALIDATE_DESC_VOID(desc);
 	change_bit(FLAG_ACTIVE_LOW, &desc->flags);
+	blocking_notifier_call_chain(&desc->gdev->notifier,
+				     GPIO_V2_LINE_CHANGED_CONFIG, desc);
 }
 EXPORT_SYMBOL_GPL(gpiod_toggle_active_low);
 
@@ -3312,6 +3327,8 @@ int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name)
 
 	kfree_const(desc->label);
 	desc_set_label(desc, name);
+	blocking_notifier_call_chain(&desc->gdev->notifier,
+				     GPIO_V2_LINE_CHANGED_CONFIG, desc);
 
 	return 0;
 }
-- 
2.39.2

