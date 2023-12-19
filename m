Return-Path: <linux-kernel+bounces-5896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8762A819137
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35F6B24892
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29FD39AC4;
	Tue, 19 Dec 2023 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MkPrScov"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB13986C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33664b4e038so2845365f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703016668; x=1703621468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eKIwE+5cUM1YHQTlDvspjas01+2C8lRyX9Kr4YHxh9w=;
        b=MkPrScovR7/YPKAFyTvi7Ln40iS45rJG9r+CpP4WjLbNVo8DDWsZZF1hEUr3nLfDz2
         Ge7nFGMAeGzTpOIcghdpou1OiUcNq0Hru4HZKHZwEphD92zYPufQDO98txLFKbTUNFZc
         YaYBzoTBsTbDH/1SfrFrUIY1DSsCn8ad0THHftE3fGCWO0uWizxbxU4+53J+BvGMwXwA
         FOZXByrS7aM0HJQ+VXnJ4nTGBWNA4pBYKgIyIHL+gC2V4gyFNTvo7aEY3DEje7sh6Pkk
         PEwPf9HaLgassa8FypCR3Ze38GRAK0urF3XvF48IP6Bjj2w2edCs0vbHAtX5zQ9joSSk
         fV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703016668; x=1703621468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKIwE+5cUM1YHQTlDvspjas01+2C8lRyX9Kr4YHxh9w=;
        b=kWj1oTo9bSpQNonp9bdnf37Kl29AfVrlE35i0JXrZhZ+ezO+MfBkjidzvwyAUCT9nN
         oJjDVPxOM9d5n8w7/IJaXJDaJ07wSP25rEzzUJzaLboRM5B0iqVcVGW0Jd7CgDVN/L1d
         0SRHYZlykJybVSWGaYQ+QL1hV/HWa+9vmd59swvQDJHMa6xTOs0Uh2cQbQCXl/JwbkSh
         rSMWf0OPIBG6Yc0nj1Kdd226QylGOjKo5OpV3RCZRJsjBTTIu02nLItcy2VTET6A91XV
         9ZypQnk93ZWEw47JOiQNu6D9uUdGiMdOgV7YHG59/YDH1NC/4Aio904MBt6uroensEWU
         B8hg==
X-Gm-Message-State: AOJu0YxjpJGiD7nILcK9FWsy+EMu/w85iqcRjVRhosPFE+A3UMBC6sNm
	ZACDibwFHKaDvLU58EfeDSJ9n8ZdYtc1LztAyd8=
X-Google-Smtp-Source: AGHT+IGVjLp1ideSdQfZT5iaXGEDl4v6lNQQmUdDMZiKSmn61aihOOR64K7Bc+JkP9rFVQl7aAFdlQ==
X-Received: by 2002:adf:e547:0:b0:336:779e:7a2a with SMTP id z7-20020adfe547000000b00336779e7a2amr242632wrm.94.1703016667367;
        Tue, 19 Dec 2023 12:11:07 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bfd0:6ab0:50e2:7f18])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d5011000000b00336344c3c3fsm16402752wrt.90.2023.12.19.12.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 12:11:07 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC PATCH] gpiolib: remove extra_checks
Date: Tue, 19 Dec 2023 21:11:02 +0100
Message-Id: <20231219201102.41639-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

extra_checks is only used in a few places. It also depends on
a non-standard DEBUG define one needs to add to the source file. The
overhead of removing it should be minimal (we already use pure
might_sleep() in the code anyway) so drop it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c9ca809b55de..837e9919bf07 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -47,19 +47,6 @@
  * GPIOs can sometimes cost only an instruction or two per bit.
  */
 
-
-/* When debugging, extend minimal trust to callers and platform code.
- * Also emit diagnostic messages that may help initial bringup, when
- * board setup or driver bugs are most common.
- *
- * Otherwise, minimize overhead in what may be bitbanging codepaths.
- */
-#ifdef	DEBUG
-#define	extra_checks	1
-#else
-#define	extra_checks	0
-#endif
-
 /* Device and char device-related information */
 static DEFINE_IDA(gpio_ida);
 static dev_t gpio_devt;
@@ -2351,7 +2338,7 @@ void gpiod_free(struct gpio_desc *desc)
 		return;
 
 	if (!gpiod_free_commit(desc))
-		WARN_ON(extra_checks);
+		WARN_ON(1);
 
 	module_put(desc->gdev->owner);
 	gpio_device_put(desc->gdev);
@@ -3729,7 +3716,7 @@ EXPORT_SYMBOL_GPL(gpiochip_line_is_persistent);
  */
 int gpiod_get_raw_value_cansleep(const struct gpio_desc *desc)
 {
-	might_sleep_if(extra_checks);
+	might_sleep();
 	VALIDATE_DESC(desc);
 	return gpiod_get_raw_value_commit(desc);
 }
@@ -3748,7 +3735,7 @@ int gpiod_get_value_cansleep(const struct gpio_desc *desc)
 {
 	int value;
 
-	might_sleep_if(extra_checks);
+	might_sleep();
 	VALIDATE_DESC(desc);
 	value = gpiod_get_raw_value_commit(desc);
 	if (value < 0)
@@ -3779,7 +3766,7 @@ int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_array *array_info,
 				       unsigned long *value_bitmap)
 {
-	might_sleep_if(extra_checks);
+	might_sleep();
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(true, true, array_size,
@@ -3805,7 +3792,7 @@ int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap)
 {
-	might_sleep_if(extra_checks);
+	might_sleep();
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(false, true, array_size,
@@ -3826,7 +3813,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_array_value_cansleep);
  */
 void gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value)
 {
-	might_sleep_if(extra_checks);
+	might_sleep();
 	VALIDATE_DESC_VOID(desc);
 	gpiod_set_raw_value_commit(desc, value);
 }
@@ -3844,7 +3831,7 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_value_cansleep);
  */
 void gpiod_set_value_cansleep(struct gpio_desc *desc, int value)
 {
-	might_sleep_if(extra_checks);
+	might_sleep();
 	VALIDATE_DESC_VOID(desc);
 	gpiod_set_value_nocheck(desc, value);
 }
@@ -3867,7 +3854,7 @@ int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_array *array_info,
 				       unsigned long *value_bitmap)
 {
-	might_sleep_if(extra_checks);
+	might_sleep();
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_set_array_value_complex(true, true, array_size, desc_array,
@@ -3909,7 +3896,7 @@ int gpiod_set_array_value_cansleep(unsigned int array_size,
 				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap)
 {
-	might_sleep_if(extra_checks);
+	might_sleep();
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_set_array_value_complex(false, true, array_size,
-- 
2.40.1


