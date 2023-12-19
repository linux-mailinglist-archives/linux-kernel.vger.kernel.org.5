Return-Path: <linux-kernel+bounces-5348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED49C8189B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739E71F25AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B011B26F;
	Tue, 19 Dec 2023 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Jy98Jn5W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73D1B27B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c3fe6c08fso53083375e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 06:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702995808; x=1703600608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfcLeZaLTjQTB/4CmKh3Sp+MO7DUd7IqjLS//Br89XY=;
        b=Jy98Jn5W6y412GDrYTU2jFV0K49tWvISwdcLJilwDtnEkZvwuMWoAGQFBmf5CjCJOb
         lRHxBVq16bZ/QZzXAVuqvyr3LdWnWPKkL8OUNqiPM0kQcL0+xj8qW1EdlGYCMginAfLD
         M4wp2wch/JXDa8sUwIGORMBpVa+2Zg3ez9WrpsILWR8BOQy2MgaZuJ2Wh/PoKK4L6RJl
         6vwzB5XF5NFliLGLSOClnsVRCKDt7WXGPZ31R/v2t7wh7NkIwAFqE/aCQo3WA5W2r20M
         jaBzNPGW9qkGwZ8dzhjyNprrE4yhv2R7OWSe9ZFei80L//Duwi300i1LxjvXFC1MmorI
         HpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702995808; x=1703600608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfcLeZaLTjQTB/4CmKh3Sp+MO7DUd7IqjLS//Br89XY=;
        b=AufKlIZSjM0bPBxj6appHbtm9wfpXE4vPJLhNT8gy/7LeRbuwPZ199BEEC12aoDbvc
         bIr/bTZrk0Cbcgqs9uRUYyxUrDyeBPP6w4p78j6aL09GKaUsc0u0E+W12VJRHG/SIQDN
         iTFDopPPDvWidbyTzMpesj40LfOwoLcGwlhfblgmbzBIKSNJDnOowKMrtiAiZvBpQFf9
         yq1cF1163k61xJ1HqvcbOtKCNHbec9Pfrd9oYieKiRUX586CxXSk0mtNn4YmUC21XQ2L
         3/qTQxD6w0hThTj+x01IQwLqn3Mfudfx3SISo462dgwo5g0wRtIhiYv6iEYvoFr3LgeJ
         2tcw==
X-Gm-Message-State: AOJu0YyqxLeYxGgafb4v0tCT0+HsSu824/M9hGnT+OTUZOyXxyPf5E6a
	6ZtEKweLmfW2wxLWe0+STIPIdcXTa0M5DfXvBV0=
X-Google-Smtp-Source: AGHT+IFBff7Fs+VnxhoM6srZ0BjeqqeYnMlBY27mWOzUARTHniyikFpcXtTFKuRQGcIJbY6Ny98kiQ==
X-Received: by 2002:a05:600c:1f8e:b0:40c:53c2:d7ec with SMTP id je14-20020a05600c1f8e00b0040c53c2d7ecmr4293373wmb.97.1702995808437;
        Tue, 19 Dec 2023 06:23:28 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bfd0:6ab0:50e2:7f18])
        by smtp.gmail.com with ESMTPSA id e32-20020a5d5960000000b003366e3b434bsm3038375wri.65.2023.12.19.06.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:23:27 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] gpio: sysfs: drop tabs from local variable declarations
Date: Tue, 19 Dec 2023 15:23:23 +0100
Message-Id: <20231219142323.28929-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231219142323.28929-1-brgl@bgdev.pl>
References: <20231219142323.28929-1-brgl@bgdev.pl>
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

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 50 ++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index ae4fc013b675..f4be847a8e92 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -165,10 +165,10 @@ static irqreturn_t gpio_sysfs_irq(int irq, void *priv)
 /* Caller holds gpiod-data mutex. */
 static int gpio_sysfs_request_irq(struct device *dev, unsigned char flags)
 {
-	struct gpiod_data	*data = dev_get_drvdata(dev);
-	struct gpio_desc	*desc = data->desc;
-	unsigned long		irq_flags;
-	int			ret;
+	struct gpiod_data *data = dev_get_drvdata(dev);
+	struct gpio_desc *desc = data->desc;
+	unsigned long irq_flags;
+	int ret;
 
 	data->irq = gpiod_to_irq(desc);
 	if (data->irq < 0)
@@ -259,7 +259,7 @@ static ssize_t edge_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
 	struct gpiod_data *data = dev_get_drvdata(dev);
-	ssize_t	status = size;
+	ssize_t status = size;
 	int flags;
 
 	flags = sysfs_match_string(trigger_names, buf);
@@ -292,8 +292,8 @@ static DEVICE_ATTR_RW(edge);
 /* Caller holds gpiod-data mutex. */
 static int gpio_sysfs_set_active_low(struct device *dev, int value)
 {
-	struct gpiod_data	*data = dev_get_drvdata(dev);
-	struct gpio_desc	*desc = data->desc;
+	struct gpiod_data *data = dev_get_drvdata(dev);
+	struct gpio_desc *desc = data->desc;
 	int			status = 0;
 	unsigned int		flags = data->irq_flags;
 
@@ -331,9 +331,9 @@ static ssize_t active_low_show(struct device *dev,
 static ssize_t active_low_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
-	struct gpiod_data	*data = dev_get_drvdata(dev);
-	ssize_t			status;
-	long			value;
+	struct gpiod_data *data = dev_get_drvdata(dev);
+	ssize_t status;
+	long value;
 
 	status = kstrtol(buf, 0, &value);
 	if (status)
@@ -399,7 +399,7 @@ static const struct attribute_group *gpio_groups[] = {
 static ssize_t base_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	const struct gpio_chip	*chip = dev_get_drvdata(dev);
+	const struct gpio_chip *chip = dev_get_drvdata(dev);
 
 	return sysfs_emit(buf, "%d\n", chip->base);
 }
@@ -408,7 +408,7 @@ static DEVICE_ATTR_RO(base);
 static ssize_t label_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	const struct gpio_chip	*chip = dev_get_drvdata(dev);
+	const struct gpio_chip *chip = dev_get_drvdata(dev);
 
 	return sysfs_emit(buf, "%s\n", chip->label ?: "");
 }
@@ -417,7 +417,7 @@ static DEVICE_ATTR_RO(label);
 static ssize_t ngpio_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	const struct gpio_chip	*chip = dev_get_drvdata(dev);
+	const struct gpio_chip *chip = dev_get_drvdata(dev);
 
 	return sysfs_emit(buf, "%u\n", chip->ngpio);
 }
@@ -441,10 +441,10 @@ static ssize_t export_store(const struct class *class,
 				const struct class_attribute *attr,
 				const char *buf, size_t len)
 {
-	long			gpio;
-	struct gpio_desc	*desc;
-	int			status;
-	struct gpio_chip	*gc;
+	long gpio;
+	struct gpio_desc *desc;
+	int status;
+	struct gpio_chip *gc;
 	int			offset;
 
 	status = kstrtol(buf, 0, &gpio);
@@ -493,9 +493,9 @@ static ssize_t unexport_store(const struct class *class,
 				const struct class_attribute *attr,
 				const char *buf, size_t len)
 {
-	long			gpio;
-	struct gpio_desc	*desc;
-	int			status;
+	long gpio;
+	struct gpio_desc *desc;
+	int status;
 
 	status = kstrtol(buf, 0, &gpio);
 	if (status < 0)
@@ -556,9 +556,9 @@ static struct class gpio_class = {
  */
 int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 {
-	struct gpio_chip	*chip;
-	struct gpio_device	*gdev;
-	struct gpiod_data	*data;
+	struct gpio_chip *chip;
+	struct gpio_device *gdev;
+	struct gpiod_data *data;
 	unsigned long		flags;
 	int			status;
 	const char		*ioname = NULL;
@@ -730,8 +730,8 @@ EXPORT_SYMBOL_GPL(gpiod_unexport);
 
 int gpiochip_sysfs_register(struct gpio_device *gdev)
 {
-	struct device	*dev;
-	struct device	*parent;
+	struct device *dev;
+	struct device *parent;
 	struct gpio_chip *chip = gdev->chip;
 
 	/*
-- 
2.40.1


