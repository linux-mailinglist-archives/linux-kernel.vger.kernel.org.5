Return-Path: <linux-kernel+bounces-111766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777ED8870A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9871F247F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C7657878;
	Fri, 22 Mar 2024 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5dFFVpe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7867D57305;
	Fri, 22 Mar 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124040; cv=none; b=evEEnb+TIkO+Ofl4aiFtPuYOb9lwRT5lw22/y/eMt0TEf/wsbDffW5VboqRHUFEtV3b9GyswbKoe0m6NH/S22wWTlTrUvysnAJnritnnqwlrx5hKSGh9MTmPkjgI4wmwJ8GLHjBfG4j1zWI+xcA3P/N4Fl5eBIvdB1cjpz8AFcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124040; c=relaxed/simple;
	bh=I52zT7xEMHe9OcgmHjA8QzaoBxfiFbCv4OAJzUisQ6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lkORNPsaxvp7GoV8ojn43xh7SZ89sEu06cwTv/7hI5y/vIKx7yDJzWmxpOkTidKZySkGuZK1MV5kFRPWLsyLh3C5ty8VPPxRulYLUHsCMd+J92M+GOZioeLSfJZ28cGbGjZdOS46iE1xMa3FMcRW0g/lvvNJ4chG0MC1Xx2XqzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5dFFVpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C00C43390;
	Fri, 22 Mar 2024 16:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711124040;
	bh=I52zT7xEMHe9OcgmHjA8QzaoBxfiFbCv4OAJzUisQ6M=;
	h=From:Date:Subject:To:Cc:From;
	b=c5dFFVpeaZcLlUXL95JMfEnyb2BFC3Gzv3Qf4By8ziKTQyZCZfffIV+TVgq8vNa8t
	 esVNMYjIPinLU+1nUdP+a7T8t3s51lxYtJ5PrpRfOCdeqa63hSwhYROnrRUTPr4Pdp
	 uiXxxMoSFvuBPcmpe/ErHi2wEPeUQvzTpNyOcOWOTDtOHrHacje4PjEZQA9hoSjsrI
	 BnI/9dsXiZONhKyVwbBMSWUZnC6k3/jXVMjS5ecWKpPuBzFiH1GDOYRNpJNXD4f+aV
	 RDDtCRsHa0O2JARvYcRZO7fzuE/dG+h+xK755+YQiTfbw95mltlcnJ8P0pgSZDbEzF
	 a9s0NwG3DhCIw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Mar 2024 16:13:04 +0000
Subject: [PATCH] gpiolib: Add stubs for GPIO lookup functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-gpiolib-find-by-fwnode-stub-v1-1-05a0ceee2123@kernel.org>
X-B4-Tracking: v=1; b=H4sIAA+u/WUC/x3MSwrCMBAA0KuUWTsQRyviVYqLfCZ1QJKQ9GMJu
 XuDy7d5FQpn4QKvoULmTYrE0HG9DGA/OsyM4rqBFN3VjQjnJPErBr0Eh+ZAv4foGMuyGhwfoyf
 9JKPYQh9SZi+//z69WzsBhR72120AAAA=
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2663; i=broonie@kernel.org;
 h=from:subject:message-id; bh=I52zT7xEMHe9OcgmHjA8QzaoBxfiFbCv4OAJzUisQ6M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl/a5FkePyvMgHC4Qf0FbOXUhA5WyCvMvKTFMQMcGQ
 eewMIO2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZf2uRQAKCRAk1otyXVSH0EnJB/
 4mGKrGp5cEtYcEeE6yo2R686Y3LY69B8TFL8ZTmR+ysQT0ZODOCLZXtu0QA7Sy8KeDBqpiYkuVz7Np
 D20XXSO5iH+4v9kk9lVyMH1WxIIuwxWRoaFDeMQ9YS/pWX5TGRVEDmt5WlIClpycXiEuZ35PHxhsdw
 J7kPH5zTd9XlVE4XBllurfBXfCITB8bu5olFp/2JoLYS+VX4+ci0Z/SzGAJct6RsftH+gepunqlOX1
 9c9o+Tmt1d8iOmlrZObj531VGc4K7uao4Zx8w/C4mzWeszLEWKkpBcx0GtCfi5x/B+XY3RWWqjOC2t
 USXBjxmlGi6NhwXRChES9OK6di0P9f
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The gpio_device_find_by_() functions do not have stubs which means that if
they are referenced from code with an optiona dependency on gpiolib then
the code will fail to link. Add stubs for lookups via fwnode and label. I
have not added a stub for plain gpio_device_find() since it seems harder to
see a use case for that which does not depend on gpiolib.

With the addition of the GPIO reset controller (which lacks a gpiolib
dependency) to the arm64 defconfig this is causing build breaks for arm64
virtconfig in -next:

aarch64-linux-gnu-ld: drivers/reset/core.o: in function `__reset_add_reset_gpio_lookup':
 /build/stage/linux/drivers/reset/core.c:861:(.text+0xccc): undefined reference to `gpio_device_find_by_fwnode'

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/gpio/driver.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index dc75f802e284..f8617eaf08ba 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -646,8 +646,6 @@ int devm_gpiochip_add_data_with_key(struct device *dev, struct gpio_chip *gc,
 struct gpio_device *gpio_device_find(const void *data,
 				int (*match)(struct gpio_chip *gc,
 					     const void *data));
-struct gpio_device *gpio_device_find_by_label(const char *label);
-struct gpio_device *gpio_device_find_by_fwnode(const struct fwnode_handle *fwnode);
 
 struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
@@ -814,6 +812,9 @@ struct gpio_device *gpiod_to_gpio_device(struct gpio_desc *desc);
 int gpio_device_get_base(struct gpio_device *gdev);
 const char *gpio_device_get_label(struct gpio_device *gdev);
 
+struct gpio_device *gpio_device_find_by_label(const char *label);
+struct gpio_device *gpio_device_find_by_fwnode(const struct fwnode_handle *fwnode);
+
 #else /* CONFIG_GPIOLIB */
 
 #include <asm/bug.h>
@@ -843,6 +844,18 @@ static inline const char *gpio_device_get_label(struct gpio_device *gdev)
 	return NULL;
 }
 
+static inline struct gpio_device *gpio_device_find_by_label(const char *label)
+{
+	WARN_ON(1);
+	return NULL;
+}
+
+static inline struct gpio_device *gpio_device_find_by_fwnode(const struct fwnode_handle *fwnode)
+{
+	WARN_ON(1);
+	return NULL;
+}
+
 static inline int gpiochip_lock_as_irq(struct gpio_chip *gc,
 				       unsigned int offset)
 {

---
base-commit: 13ee4a7161b6fd938aef6688ff43b163f6d83e37
change-id: 20240322-gpiolib-find-by-fwnode-stub-565f2a82b0ec

Best regards,
-- 
Mark Brown <broonie@kernel.org>


