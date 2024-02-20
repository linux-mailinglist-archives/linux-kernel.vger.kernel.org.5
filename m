Return-Path: <linux-kernel+bounces-72884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE9785BA11
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C27B1F25270
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE84F66B5F;
	Tue, 20 Feb 2024 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B1J2PkBV"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C894A66B56;
	Tue, 20 Feb 2024 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427485; cv=none; b=Npdnk96uXHqMZj/DUuGyDdYvakEUd5sJ1a6qaGgHGzCTmINz5t+GRAr0p6LEZM/8GuAJujA8SVnEoh5kw+Qn2/cz0xbV63F3/VK5k5fvKH4WzQv9VMZ73vBjJh5M25+IXxZ/BDc8sf1uIsC5gK4Ef1IIy24nXmw6N+e0ovt5zFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427485; c=relaxed/simple;
	bh=ulweI1Ce0cUyHQQ4Wm/kRBRiyj0VTxmuz/Nzdi2q6FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ehb7m9GW4haHqyRnBSM38+AvUJ8b792YcNqYCUMNqELOdrLlC10vYSQ2JToBxttL2SHKMLTbpvpb3xdLt+KckZvPEG0VQM+TyOtueZBEheD4UuI/R+mS0Z3DkSYYRF7+i1lE8qMUF9MhwbajMRSx7NkhYOQ/LiEYgs75i7/u3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B1J2PkBV; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5F15D20005;
	Tue, 20 Feb 2024 11:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708427480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oc4ohg5LOK/NMkvzmh0zZUOGGe+/Ajs5RSnJ2qJvG0E=;
	b=B1J2PkBV3YrYPkbsJWns43NxpX1dzq5ylZexnzpA51Q81L5vFhOtU2CXLk5eYfOWqv6+8+
	E4TwED98yEMK2LQ4xdov4LL7R9Yx2RtK1tOrlv/JB5Et4Mb0PaO/WQ9P8+D1Tdii45sHSl
	aMEI3YU84yBVMZHUQ7c8Lwv5KlxJXIw/6nQXlE1/2PixTlq/kiiKB3TSwWNLlLOzvisf0R
	8/XCjNiWg79mI1ohYXULvbcivZKqKe0/OzTom/w/np31fGIs/y9ELWatfWj1pQJsFoG53c
	x5q6Jnld5yMIDkr4D2yy/m6Ii3mVVHMox+dAmS2wQ0adrxBxehzFSdMEsm+dhg==
From: Herve Codina <herve.codina@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 1/2] gpiolib: Introduce gpiod_device_add_link()
Date: Tue, 20 Feb 2024 12:11:06 +0100
Message-ID: <20240220111111.133826-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220111111.133826-1-herve.codina@bootlin.com>
References: <20240220111111.133826-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

With device-tree, some devlink related to gpios are automatically added
when a consumer device is added and the attached node has phandles
related to GPIOs.
In some cases, the real device used to get the gpio during a probe() can
be related to an of-node parent of the of-node used for the already done
automatically devlink creation.
For instance, a driver can be bound to a device and, during the
probe(), the driver can walk its of-node children to get the GPIO
described in these children nodes.
In that case, an additional devlink between the device attached to the
driver and the gpio consumer need to be created.
Indeed, if the GPIO is removed, the consumer/supplier dependency should
lead to remove first the consuming driver before removing the supplier.

In order to give the possibility to this kind of driver to add additional
devlinks, introduce gpiod_device_add_link().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/gpio/gpiolib.c        | 32 ++++++++++++++++++++++++++++++++
 include/linux/gpio/consumer.h |  5 +++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8b3a0f45b574..416ab334b02d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4195,6 +4195,38 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 	return desc;
 }
 
+/**
+ * gpiod_device_add_link - Add a link between a GPIO consumer and a GPIO.
+ * @consumer: GPIO consumer.
+ * @desc: GPIO consumed.
+ * @flags: Link flags, see device_link_add().
+ *
+ * This function can be used for drivers that need to add an additional
+ * consumer/supplier device link to a GPIO.
+ *
+ * Returns:
+ * On successful, the link created.
+ * NULL if the link was not created due to a missing GPIO parent.
+ *
+ * In case of error an ERR_PTR() is returned.
+ */
+struct device_link *gpiod_device_add_link(struct device *consumer,
+					  struct gpio_desc *desc,
+					  u32 flags)
+{
+	struct device_link *link;
+
+	if (!desc->gdev->dev.parent)
+		return NULL;
+
+	link = device_link_add(consumer, desc->gdev->dev.parent, flags);
+	if (!link)
+		return ERR_PTR(-EINVAL);
+
+	return link;
+}
+EXPORT_SYMBOL_GPL(gpiod_device_add_link);
+
 /**
  * fwnode_gpiod_get_index - obtain a GPIO from firmware node
  * @fwnode:	handle of the firmware node
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index db2dfbae8edb..4feed4e166b0 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -7,6 +7,7 @@
 
 struct acpi_device;
 struct device;
+struct device_link;
 struct fwnode_handle;
 
 struct gpio_array;
@@ -106,6 +107,10 @@ void devm_gpiod_put(struct device *dev, struct gpio_desc *desc);
 void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc);
 void devm_gpiod_put_array(struct device *dev, struct gpio_descs *descs);
 
+struct device_link *gpiod_device_add_link(struct device *consumer,
+					  struct gpio_desc *desc,
+					  u32 flags);
+
 int gpiod_get_direction(struct gpio_desc *desc);
 int gpiod_direction_input(struct gpio_desc *desc);
 int gpiod_direction_output(struct gpio_desc *desc, int value);
-- 
2.43.0


