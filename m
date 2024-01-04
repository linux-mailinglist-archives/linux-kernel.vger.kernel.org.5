Return-Path: <linux-kernel+bounces-17083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0713B824811
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41502849E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF6828E09;
	Thu,  4 Jan 2024 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="P2BtR2Pr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821A28DD4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d5aefcc2fso7151565e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 10:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704392438; x=1704997238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lIgPJQ/Ek2jBs1mR0NLzWA62Ta2aiqv24v6hMQR2KKs=;
        b=P2BtR2PrdnFuRZixhaP79MbbcUkevoY0rZmuLsxoe5gB944S6sg7p3mJrSlHas3Zf1
         W6LA7ms+TLP7PnJTDaJw8Vi4JEgi1HNsUTrZGdZuAc6uzQKjev5pBwf7GMoynme2bPHW
         x9haOApbbdv+EbjcmutAOwEMmSLFZag0WZKei69Wcv73tplpq2mzxguyhSQuldvP7jj7
         QOh4YaUaL/tlZ91L0jED2nSB9r50JZSa0c3QKmN272Gywj5TUSmue3exNkYL5w7Y3tgK
         UF3/MmUHKXhHLUE989rgGYDVzbm23IN/fy6Al8cVn7pVIXfXIBFT3zIjvUyIPFOQnIJy
         6cBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704392438; x=1704997238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIgPJQ/Ek2jBs1mR0NLzWA62Ta2aiqv24v6hMQR2KKs=;
        b=PKh22dDpJKESYHB32pwjGu4Li2Ni2Mm+1OwJKSysFtnRdhjtqQsWOTTPnl4/9beZvY
         GEfLpsaqhZDGXODTpnJvYOH6W6ouOWhavbTn/JwrOgBuluEDV8sBz44iimXnhwcCTLKz
         ITuAUp4jeXjpohBRw/eB+HpA6WG7gYLV3xVEiGd0yluS82Q83gGwkE7WcjWdAgSZf9vI
         6Z2sqjcqYNyKn95VLhvw0kW5xRL32Xd3UeaZmS3R26qSuoe3SysuRT6qpBNQBTosUhoY
         fWDqWifNvb+32Jqb6DIBUT+Ws24X8q1khou/sMOOxhkTrvgGmdvLvli5NQOTPHUBrILy
         mTEg==
X-Gm-Message-State: AOJu0Yx02ndJ/jltIgBNn2sbXqPsNJfIH5P0/j9cN6dub556Q8njHUSe
	pZn9YevOczB2VFpQpViIVUVB+7CjDnP8Kw==
X-Google-Smtp-Source: AGHT+IGdmppx7CeWzPZboLM8WEd9OOzUyt4JF2aPqCh4UPacrJ4JLW3b1l6dZ6JVis4mdj2e5nodgA==
X-Received: by 2002:a05:600c:4710:b0:40d:8784:8bfd with SMTP id v16-20020a05600c471000b0040d87848bfdmr573321wmo.165.1704392437778;
        Thu, 04 Jan 2024 10:20:37 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5b69:3768:8459:8fee])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c4fc400b0040d8d11bd4esm6573129wmq.36.2024.01.04.10.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 10:20:37 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: legacy: mark old interfaces as deprecated in kernel docs
Date: Thu,  4 Jan 2024 19:20:34 +0100
Message-Id: <20240104182034.61892-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We've recently had someone try to use of_get_named_gpio() in new code.
Mark legacy interfaces as deprecated in kernel docs to avoid any
confusion.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-legacy.c | 12 ++++++++++++
 drivers/gpio/gpiolib-of.c     |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpio/gpiolib-legacy.c b/drivers/gpio/gpiolib-legacy.c
index 97f4b498e343..b138682fec3d 100644
--- a/drivers/gpio/gpiolib-legacy.c
+++ b/drivers/gpio/gpiolib-legacy.c
@@ -6,6 +6,9 @@
 
 #include "gpiolib.h"
 
+/*
+ * **DEPRECATED** This function is deprecated and must not be used in new code.
+ */
 void gpio_free(unsigned gpio)
 {
 	gpiod_free(gpio_to_desc(gpio));
@@ -17,6 +20,8 @@ EXPORT_SYMBOL_GPL(gpio_free);
  * @gpio:	the GPIO number
  * @flags:	GPIO configuration as specified by GPIOF_*
  * @label:	a literal description string of this GPIO
+ *
+ * **DEPRECATED** This function is deprecated and must not be used in new code.
  */
 int gpio_request_one(unsigned gpio, unsigned long flags, const char *label)
 {
@@ -53,6 +58,9 @@ int gpio_request_one(unsigned gpio, unsigned long flags, const char *label)
 }
 EXPORT_SYMBOL_GPL(gpio_request_one);
 
+/*
+ * **DEPRECATED** This function is deprecated and must not be used in new code.
+ */
 int gpio_request(unsigned gpio, const char *label)
 {
 	struct gpio_desc *desc = gpio_to_desc(gpio);
@@ -69,6 +77,8 @@ EXPORT_SYMBOL_GPL(gpio_request);
  * gpio_request_array - request multiple GPIOs in a single call
  * @array:	array of the 'struct gpio'
  * @num:	how many GPIOs in the array
+ *
+ * **DEPRECATED** This function is deprecated and must not be used in new code.
  */
 int gpio_request_array(const struct gpio *array, size_t num)
 {
@@ -92,6 +102,8 @@ EXPORT_SYMBOL_GPL(gpio_request_array);
  * gpio_free_array - release multiple GPIOs in a single call
  * @array:	array of the 'struct gpio'
  * @num:	how many GPIOs in the array
+ *
+ * **DEPRECATED** This function is deprecated and must not be used in new code.
  */
 void gpio_free_array(const struct gpio *array, size_t num)
 {
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 402f7d99b0c1..ad8e75db68b0 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -414,6 +414,8 @@ static struct gpio_desc *of_get_named_gpiod_flags(const struct device_node *np,
  * @propname:	Name of property containing gpio specifier(s)
  * @index:	index of the GPIO
  *
+ * **DEPRECATED** This function is deprecated and must not be used in new code.
+ *
  * Returns GPIO number to use with Linux generic GPIO API, or one of the errno
  * value on the error condition.
  */
-- 
2.40.1


