Return-Path: <linux-kernel+bounces-6541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F036819A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2C31F21C20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27F91D536;
	Wed, 20 Dec 2023 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dXRz7QoF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED551D52B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so59096245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703059785; x=1703664585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIsSMD7i5NE719u+31dGpBwzTze1hY2hnasRjy34amk=;
        b=dXRz7QoFbgGyGT5nfE3NRCJZ4yIjlbK1lrNvMW+bCfDLSn6AjR5hhEwjN6VSFWOmly
         nVWGS50/3dCXMEu8MsDT/O7vbmqArOSjSeLlm/aXQm5KuI6LBYQJ9ssmV1ung/gUXycb
         79f5EVOrTmG6U6t94rFIRotya4XLMofPk/ZYcma0jLWpzWzGm+WYHA9vfzXw73zh0DgZ
         IFq8gmg2GZK/tgbuWIeZfxRBYJYBeFeZwyoKblcZcutPACzHgh08bvzz6RiRHo4fXRJI
         qehmECYnHZB8XMSXnjw7YzsKeYGCecOHipyXDpgALl10wtNy89Nzz/Mj+NEVBw7j9B9x
         jf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703059785; x=1703664585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIsSMD7i5NE719u+31dGpBwzTze1hY2hnasRjy34amk=;
        b=nU74fTo9RGj0kpK6hH1kNRd5h8DCjB7qc4Cp51B7TlRdZIOlcgM0EoG9NUhxKUfbB+
         ZSHY2lLZLgyPb2JTVJnC1Onv+xkPFrZVJtgsKDRuAr5u//kOCkq1WUEWKQdKvbTkLwg7
         sBYdGBaieM1VZrsvdE2leV5LDgrYF9be3jgJcN2MHHoqYcHFNRw1P0PzaiR20oBrtouD
         EcymOz1TVT4+e+HUBWieuqp3Dweb8XomXhXbEwJXzQe9paeAB7SYA+2hk0ZYDCTP0cY6
         x5Y8YYktthBhvT6EpV8QFztdz8M3Wuh+k6mg25QUtnSFZHR1RaYCgd4PKxHGIJVCdbQe
         AwNA==
X-Gm-Message-State: AOJu0Yxc1byjhRCtcCo3z16M+DBuDZAhJbkHFiK1/g/EKv423f6i5FLe
	tphIur3WB1k69H/8KkR0GwcPGg==
X-Google-Smtp-Source: AGHT+IEjNzvn0De543+sEAGcJw6eIRBYEeq9uwlb09OSuVoO3JhemUfa5gg0rIaIN0ZM7/5Jt8t/ww==
X-Received: by 2002:a05:600c:4c1a:b0:40c:d4d:68ec with SMTP id d26-20020a05600c4c1a00b0040c0d4d68ecmr9804231wmp.183.1703059785403;
        Wed, 20 Dec 2023 00:09:45 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ecf7:fc79:9704:9cf7])
        by smtp.gmail.com with ESMTPSA id k36-20020a05600c1ca400b0040b38292253sm6344729wms.30.2023.12.20.00.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:09:45 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] gpio: sysfs: drop tabs from local variable declarations
Date: Wed, 20 Dec 2023 09:09:42 +0100
Message-Id: <20231220080942.8381-1-brgl@bgdev.pl>
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

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- drop more tabs where my regex didn't find them before

 drivers/gpio/gpiolib-sysfs.c | 66 ++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index ae4fc013b675..6c9fde19d46e 100644
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
@@ -292,10 +292,10 @@ static DEVICE_ATTR_RW(edge);
 /* Caller holds gpiod-data mutex. */
 static int gpio_sysfs_set_active_low(struct device *dev, int value)
 {
-	struct gpiod_data	*data = dev_get_drvdata(dev);
-	struct gpio_desc	*desc = data->desc;
-	int			status = 0;
-	unsigned int		flags = data->irq_flags;
+	struct gpiod_data *data = dev_get_drvdata(dev);
+	struct gpio_desc *desc = data->desc;
+	int status = 0;
+	unsigned int flags = data->irq_flags;
 
 	if (!!test_bit(FLAG_ACTIVE_LOW, &desc->flags) == !!value)
 		return 0;
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
@@ -441,11 +441,11 @@ static ssize_t export_store(const struct class *class,
 				const struct class_attribute *attr,
 				const char *buf, size_t len)
 {
-	long			gpio;
-	struct gpio_desc	*desc;
-	int			status;
-	struct gpio_chip	*gc;
-	int			offset;
+	long gpio;
+	struct gpio_desc *desc;
+	int status;
+	struct gpio_chip *gc;
+	int offset;
 
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
@@ -556,14 +556,14 @@ static struct class gpio_class = {
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
+	struct gpio_chip *chip;
+	struct gpio_device *gdev;
+	struct gpiod_data *data;
+	unsigned long flags;
+	int status;
+	const char *ioname = NULL;
+	struct device *dev;
+	int offset;
 
 	/* can't export until sysfs is available ... */
 	if (!class_is_registered(&gpio_class)) {
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


