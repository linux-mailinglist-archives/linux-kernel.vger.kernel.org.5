Return-Path: <linux-kernel+bounces-8102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F2481B232
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F6C1F214E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE6D4E1BD;
	Thu, 21 Dec 2023 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Cx9lHpSm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE404E1A6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d12b56a38so5840115e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 01:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703150151; x=1703754951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqPLJ6oGhesOpUeH8RDsWzpFrAHJgLqGLt68wHy7+K4=;
        b=Cx9lHpSmITKbNqDXQ041/9uh+RIhudMfS15fwK43jt56i0kykVEn2KOYPORLEWCmYx
         6OEJXOs5AqZHFJoMHofdD7Qcc01mpn6Py4s0dseqzTMY2/7D/zLT6YwxTPFUtjXAhCSm
         jcP8t59q6d/jKiwiMIrpDpUq7IibIVQBXR4Tuef+UEFNcCR5meykm/97ZHy69n6tHq5z
         S6SJlu1jKtZbeCUNjHo2/Dv1JviT7JifkvM9+1BqUSlAhQwQB7nI37D2nfVSMlcaxOwg
         UVav7V7kxAjyK3QbggbyJlR+V6Kt3KfwkWL+zDCUuXSNBYugdQSRgzLor6iJwyBKWuiX
         Xyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150151; x=1703754951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqPLJ6oGhesOpUeH8RDsWzpFrAHJgLqGLt68wHy7+K4=;
        b=SxKC7l3GjCHJlrmJoIFDO7MeY8YOUXqVpHVsRoOgyvJ2vybKBUs+nGPRVZIwDJw212
         WnocdnHMGPXViUPX4sW74RS9i6+MyWJevOOdlVMfIa3csOSYKXxuKlmfcEe9ByYUqK7o
         Cw3eBuwDTWwIqjv501PzcDZ+/T7ODu46a6iSKlQYmvEa0nl3OuW1x62W6L894oY45TCU
         nYqIUctKFzOJWvf700yqYyeHO3V9Y0wwXXxVOaSQOkbV0Cx0DUgtsV/0Ul0TPPwZZQkL
         DSxcJUgU2Xtmsw5T0EDTGALaveCmkBZ6BmstgxzyiIKYhli6dWaFmOqi6dDKRTtuGOZe
         HrUg==
X-Gm-Message-State: AOJu0YwNDY6DwHxnyunJcpnmlfp5Oa6hp5LMD+EA/j24VJYEmjE1A2tN
	qbCUZ2/Rp3/DRvAHvpdNwEVmag==
X-Google-Smtp-Source: AGHT+IEy67Vr293UO0kwikiiUBHyQBFn4s8jwO15j99Sei1gJ6ldVDJkxiinn4oI3TVBGaXyQzR0SA==
X-Received: by 2002:a7b:cd08:0:b0:40d:1930:d1de with SMTP id f8-20020a7bcd08000000b0040d1930d1demr253971wmj.373.1703150151717;
        Thu, 21 Dec 2023 01:15:51 -0800 (PST)
Received: from brgl-uxlite.. ([2a02:8440:c20c:e072:65b3:1998:74df:2809])
        by smtp.gmail.com with ESMTPSA id s13-20020a05600c45cd00b0040d414b57e8sm122157wmo.26.2023.12.21.01.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:15:51 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 2/2] gpio: sysfs: drop tabs from local variable declarations
Date: Thu, 21 Dec 2023 10:15:47 +0100
Message-Id: <20231221091547.57352-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231221091547.57352-1-brgl@bgdev.pl>
References: <20231221091547.57352-1-brgl@bgdev.pl>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v1 -> v2:
- drop more tabs where my regex didn't find them before

v2 ->v3:
- arrange variables we're touching in a reverse x-mass tree

 drivers/gpio/gpiolib-sysfs.c | 65 ++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index ae4fc013b675..4f7d4c00dac6 100644
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
@@ -292,10 +292,11 @@ static DEVICE_ATTR_RW(edge);
 /* Caller holds gpiod-data mutex. */
 static int gpio_sysfs_set_active_low(struct device *dev, int value)
 {
-	struct gpiod_data	*data = dev_get_drvdata(dev);
-	struct gpio_desc	*desc = data->desc;
-	int			status = 0;
-	unsigned int		flags = data->irq_flags;
+	struct gpiod_data *data = dev_get_drvdata(dev);
+	unsigned int flags = data->irq_flags;
+	struct gpio_desc *desc = data->desc;
+	int status = 0;
+
 
 	if (!!test_bit(FLAG_ACTIVE_LOW, &desc->flags) == !!value)
 		return 0;
@@ -331,9 +332,9 @@ static ssize_t active_low_show(struct device *dev,
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
@@ -399,7 +400,7 @@ static const struct attribute_group *gpio_groups[] = {
 static ssize_t base_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	const struct gpio_chip	*chip = dev_get_drvdata(dev);
+	const struct gpio_chip *chip = dev_get_drvdata(dev);
 
 	return sysfs_emit(buf, "%d\n", chip->base);
 }
@@ -408,7 +409,7 @@ static DEVICE_ATTR_RO(base);
 static ssize_t label_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	const struct gpio_chip	*chip = dev_get_drvdata(dev);
+	const struct gpio_chip *chip = dev_get_drvdata(dev);
 
 	return sysfs_emit(buf, "%s\n", chip->label ?: "");
 }
@@ -417,7 +418,7 @@ static DEVICE_ATTR_RO(label);
 static ssize_t ngpio_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	const struct gpio_chip	*chip = dev_get_drvdata(dev);
+	const struct gpio_chip *chip = dev_get_drvdata(dev);
 
 	return sysfs_emit(buf, "%u\n", chip->ngpio);
 }
@@ -441,11 +442,10 @@ static ssize_t export_store(const struct class *class,
 				const struct class_attribute *attr,
 				const char *buf, size_t len)
 {
-	long			gpio;
-	struct gpio_desc	*desc;
-	int			status;
-	struct gpio_chip	*gc;
-	int			offset;
+	struct gpio_desc *desc;
+	struct gpio_chip *gc;
+	int status, offset;
+	long gpio;
 
 	status = kstrtol(buf, 0, &gpio);
 	if (status < 0)
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
@@ -556,14 +556,13 @@ static struct class gpio_class = {
  */
 int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 {
-	struct gpio_chip	*chip;
-	struct gpio_device	*gdev;
-	struct gpiod_data	*data;
-	unsigned long		flags;
-	int			status;
-	const char		*ioname = NULL;
-	struct device		*dev;
-	int			offset;
+	const char *ioname = NULL;
+	struct gpio_device *gdev;
+	struct gpiod_data *data;
+	struct gpio_chip *chip;
+	unsigned long flags;
+	struct device *dev;
+	int status, offset;
 
 	/* can't export until sysfs is available ... */
 	if (!class_is_registered(&gpio_class)) {
@@ -730,9 +729,9 @@ EXPORT_SYMBOL_GPL(gpiod_unexport);
 
 int gpiochip_sysfs_register(struct gpio_device *gdev)
 {
-	struct device	*dev;
-	struct device	*parent;
 	struct gpio_chip *chip = gdev->chip;
+	struct device *parent;
+	struct device *dev;
 
 	/*
 	 * Many systems add gpio chips for SOC support very early,
-- 
2.40.1


