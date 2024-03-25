Return-Path: <linux-kernel+bounces-117530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4DB88AC3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EBF1C382B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A436E2BE;
	Mon, 25 Mar 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVz2Sfb3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899EF6D1B0;
	Mon, 25 Mar 2024 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386065; cv=none; b=KbYWIIBRVu9oel/Ty1I/g+dpLb1ioDLYXmgpk+FG3Uonu9gH+F9lSOgwHyRpTdzuIwOsWPlEmsqBsCU6aWyV1z44RYYHirzMU8UlVRz0H0K4l7pQKWF4Mt2PalzA2V0VcJlS9Los6wi+gZvpjQtAH2hzmPgzlitGQlVAxtiZlFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386065; c=relaxed/simple;
	bh=Lci6nEV6lFRNgmbj/19OAFVfKuyN4Cyp2jW6qAIWwrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZBUKmdiiFk0B7tqIVRbZSx3P3VCXuKiRWqgkomn7gPQujAS0ZE7ldo//NGlL5PwGSz0uuU6n8/UfacixmWHt21Z2jFRRJiE8nyZJXVOjeH5ldTV9Ndw24YtL/XOsoSBCiOVfrvZyHh/idIAQPZoEN1EgtUJPovIPLR8iccFWnAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVz2Sfb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52F5C433F1;
	Mon, 25 Mar 2024 17:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711386065;
	bh=Lci6nEV6lFRNgmbj/19OAFVfKuyN4Cyp2jW6qAIWwrw=;
	h=From:Date:Subject:To:Cc:From;
	b=gVz2Sfb3dxNAPIRfEUU4KRbK+JBb+s401KhAbTDA+73+4XwqDdv3Do8557ra+Xl9h
	 XqbewdaTKW2o9M7vVNS4ZtB3EP7Cm2Ki+2kmQ18daSyzzsrF4e2lVWaRkO6ycSKQfx
	 9X8UJuQP84WIilg6liE4exqQQU++5+ZkgBV5BIaTBzvAiwfXVPERG1UcxUJksWflpR
	 csT+PHXCmn2CkOnIEAj53DtpcxTQLIbu8RkykAkhFm7u6MS9l3N83LLXwMThjHl5Av
	 pioNKHrNtAv2fkz3bOxVLI1JLh1WXp5miBpDo1qBurccsbHSvPvEE84uG4o8R9Gu+v
	 8AnVbpSZLdbfg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 25 Mar 2024 17:00:57 +0000
Subject: [PATCH v2] gpiolib: Add stubs for GPIO lookup functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-gpiolib-find-by-fwnode-stub-v2-1-c843288cb01f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMmtAWYC/43NQQ6CMBCF4auQWTumHcQYV96DsKAwhYmkJS2ih
 PTuVk7g8nuL/+0QOQhHuBc7BF4lincZdCqgG1s3MEqfDaTookoiHGbxkxi04no0G9q38z1jXF4
 Gq2tlqb2RUdxBLsyBrXyOet1kjxIXH7bjbNW/9b/uqlGjqlrVMTNpKh9PDo6nsw8DNCmlL3bZc
 zHHAAAA
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2883; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Lci6nEV6lFRNgmbj/19OAFVfKuyN4Cyp2jW6qAIWwrw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmAa3OAuQV7uRj36Qg09JExspAdtoyMZZkLpqLiguh
 CtqGMmGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZgGtzgAKCRAk1otyXVSH0J97B/
 9NmR2soPhHawJZpBXD0I7oRYHT7pNiK04Fo0Slr1PJsarihwQGN6LAzJaQyN10KjOOnsZGKtlyc0s8
 ao+jEn/EKLJkyyU2MarGVmBHqf99hFzsCfuHOKttezItn8zgD3dhWgDkQSeDXTj9MU5XDxTrtU1nOW
 pmQEKVExhoTboKZgBt1TDTE1NLbYZw/A/K/P8f8Ehi9vbHNHycoDs+72/Xy5qfI7sPfG5sy9WnolDp
 4+QVD5V02PrfdDzSFcJy3FWcvnEXL3eBOdooz/nIONJwiIU93+QhuhH/RqK+1/qhI4+ET26/nDY61i
 AU9q23NKtVl59n0F0deXobBDNAojBm
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.9-rc1.
- Link to v1: https://lore.kernel.org/r/20240322-gpiolib-find-by-fwnode-stub-v1-1-05a0ceee2123@kernel.org
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
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240322-gpiolib-find-by-fwnode-stub-565f2a82b0ec

Best regards,
-- 
Mark Brown <broonie@kernel.org>


