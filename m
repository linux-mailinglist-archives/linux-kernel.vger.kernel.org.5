Return-Path: <linux-kernel+bounces-5347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB65A8189AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E1A289FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127591B28C;
	Tue, 19 Dec 2023 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HrdbuES1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D751B288
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-336695c4317so2213110f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 06:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702995807; x=1703600607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m0ixPtoAPGKvK37J2//i5TEfAHvCqoh+89EGr3jhVvs=;
        b=HrdbuES1NGfwpowO7HGB7Jqz39EI2lOXKUviEuq/dwNfLnQhkKMcaxe5Rt2KHH0xYA
         mb9JwllXypjYLiZGREbFoPVQ/rZ3+c2X29f2k7lt9gbSd3PS7J08UFZa6ImoMxf/r2HT
         fNnj+PaFsy3yiM2wdYG7e3ooU+ly9RsfTKB3jZsDBOvXzNXHHph3JeJWrHJTi4tVZWZ8
         sYdwz55wfwnL/sHUHIU5OxW1MkFiswC5H+s44xYzUbWJLmuu9d1w0N4knLPR/U5Imt5C
         HPs9yGDZ5kQQYu4bzhxQ4vqngKByIDMfsG7O7vCYzp1sIaz3RD0Xz2RZFQd3a0y5lbms
         UHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702995807; x=1703600607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0ixPtoAPGKvK37J2//i5TEfAHvCqoh+89EGr3jhVvs=;
        b=OUfsX/CJkjs5Iq9RiP/KIqjqIKK8tfpxu6Ic54zBp1dOdgbosXS2FzmIN6DF6CmBN/
         mevjQHNw4GLs4vsnQ2JTauz4iEaxM6FeqVyDEnzf5JQVeKFYE7tYFzxuABa9OcUX51UZ
         ewiIw3ynaB9nKVKlcPt4Z+BzxrspOvkXyyOTZ4C/lRQSKNUP1L94PtC3ko+C8pg1HSZr
         UbsJKF35CED7vpUZsKD4oqTFmNXEW/T1mGpuriBJNvYyP+dK9uTfkOb0QUKBm0IiODbR
         9/aCT4E613V9p+xeflv4cifnK5V3Evm2IlcBT0bSHji04LcXzD1KKrSjtLyjy79cB7av
         eRgg==
X-Gm-Message-State: AOJu0Yyw2+D8mWxhu2f1xYl2JpiuwKPoU0paAxZB5bofJunIi27uKCx8
	uVMnR+wHcSchJgDBn06dOZHOFw==
X-Google-Smtp-Source: AGHT+IFvNmhtyifEJ4GHGe70PPcjYzfZWnXn3ygiMX9XgGBp4xqmE8p6Hw+W7P5FfDSWVXMQicaqTQ==
X-Received: by 2002:a05:6000:1d84:b0:336:1fcf:5aec with SMTP id bk4-20020a0560001d8400b003361fcf5aecmr9838671wrb.55.1702995807441;
        Tue, 19 Dec 2023 06:23:27 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bfd0:6ab0:50e2:7f18])
        by smtp.gmail.com with ESMTPSA id e32-20020a5d5960000000b003366e3b434bsm3038375wri.65.2023.12.19.06.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:23:27 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] gpiolib: drop tabs from local variable declarations
Date: Tue, 19 Dec 2023 15:23:22 +0100
Message-Id: <20231219142323.28929-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Older code has an annoying habit of putting tabs between the type and the
name of the variable. This doesn't really add to readability and newer
code doesn't do it so make the entire file consistent.

While at it: convert 'unsigned' to 'unsigned int'.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c9ca809b55de..c3704d32afdd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1049,8 +1049,8 @@ EXPORT_SYMBOL_GPL(gpiochip_add_data_with_key);
 void gpiochip_remove(struct gpio_chip *gc)
 {
 	struct gpio_device *gdev = gc->gpiodev;
-	unsigned long	flags;
-	unsigned int	i;
+	unsigned long flags;
+	unsigned int i;
 
 	down_write(&gdev->sem);
 
@@ -2186,10 +2186,10 @@ EXPORT_SYMBOL_GPL(gpiochip_remove_pin_ranges);
  */
 static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 {
-	struct gpio_chip	*gc = desc->gdev->chip;
-	int			ret;
-	unsigned long		flags;
-	unsigned		offset;
+	struct gpio_chip *gc = desc->gdev->chip;
+	int ret;
+	unsigned long flags;
+	unsigned int offset;
 
 	if (label) {
 		label = kstrdup_const(label, GFP_KERNEL);
@@ -2301,9 +2301,9 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
 
 static bool gpiod_free_commit(struct gpio_desc *desc)
 {
-	bool			ret = false;
-	unsigned long		flags;
-	struct gpio_chip	*gc;
+	bool ret = false;
+	unsigned long flags;
+	struct gpio_chip *gc;
 
 	might_sleep();
 
@@ -2577,8 +2577,8 @@ int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
  */
 int gpiod_direction_input(struct gpio_desc *desc)
 {
-	struct gpio_chip	*gc;
-	int			ret = 0;
+	struct gpio_chip *gc;
+	int ret = 0;
 
 	VALIDATE_DESC(desc);
 	gc = desc->gdev->chip;
@@ -2927,7 +2927,7 @@ static int gpio_chip_get_value(struct gpio_chip *gc, const struct gpio_desc *des
 
 static int gpiod_get_raw_value_commit(const struct gpio_desc *desc)
 {
-	struct gpio_chip	*gc;
+	struct gpio_chip *gc;
 	int value;
 
 	gc = desc->gdev->chip;
@@ -3222,7 +3222,7 @@ static void gpio_set_open_source_value_commit(struct gpio_desc *desc, bool value
 
 static void gpiod_set_raw_value_commit(struct gpio_desc *desc, bool value)
 {
-	struct gpio_chip	*gc;
+	struct gpio_chip *gc;
 
 	gc = desc->gdev->chip;
 	trace_gpio_value(desc_to_gpio(desc), 0, value);
@@ -4709,13 +4709,13 @@ core_initcall(gpiolib_dev_init);
 
 static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 {
-	struct gpio_chip	*gc = gdev->chip;
-	struct gpio_desc	*desc;
-	unsigned		gpio = gdev->base;
-	int			value;
-	bool			is_out;
-	bool			is_irq;
-	bool			active_low;
+	struct gpio_chip *gc = gdev->chip;
+	struct gpio_desc *desc;
+	unsigned int gpio = gdev->base;
+	int value;
+	bool is_out;
+	bool is_irq;
+	bool active_low;
 
 	for_each_gpio_desc(gc, desc) {
 		if (test_bit(FLAG_REQUESTED, &desc->flags)) {
-- 
2.40.1


