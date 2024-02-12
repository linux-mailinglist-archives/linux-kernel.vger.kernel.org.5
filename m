Return-Path: <linux-kernel+bounces-62310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAE2851E61
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 958E6B25173
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8333F47F57;
	Mon, 12 Feb 2024 20:04:49 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43604D9E9;
	Mon, 12 Feb 2024 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768289; cv=none; b=KYdF9Zw8QpHzr+0dHTtVKY2GmvC3euMkGxCcZIq/AGnWB3C5KOdJ14HdBKRbVEhr8Ruoj8dJZWCa78uKRcrqrqXOQ14h6tjxn1TuflGiFF6GgUmQDGrMA2kOSCHxiOP7uSVM+y9VKiRN0aWxkMYH3Qi/DwctGpF/PVm4f0tXskc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768289; c=relaxed/simple;
	bh=8oXLHu5mf6GCO+ZMr+tU6h6oKIscP7uIjmv7rxzg+zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkNO3HDTPNqfiW3IY/oyxMacCEOxXP3N7LhqVI9xhA34IUuSswr4xAUvyDq8TWpLr1gKDkPdbFAOD3dV4gFHqlvE7tCf6+63z/N3J+QH8Wzj/9fai4TrhyLCfPRa8EyXrW+FgOcrwm0AgOq+wuDBfeRa0uupoTSMY66wVmCQP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 982CF83C56;
	Mon, 12 Feb 2024 21:04:38 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Mon, 12 Feb 2024 21:03:26 +0100
Subject: [PATCH 2/2] leds: expresswire: don't depend on NEW_LEDS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240212-expresswire-deps-v1-2-685ad10cd693@skole.hr>
References: <20240212-expresswire-deps-v1-0-685ad10cd693@skole.hr>
In-Reply-To: <20240212-expresswire-deps-v1-0-685ad10cd693@skole.hr>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Hans de Goede <hdegoede@redhat.com>, 
 Jianhua Lu <lujianhua000@gmail.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Helge Deller <deller@gmx.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=8oXLHu5mf6GCO+ZMr+tU6h6oKIscP7uIjmv7rxzg+zo=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlynmgL8L0kP8ZVEOL1g3BmNLjNbTU+Q9Ykoclo
 JRlY2qTALGJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZcp5oAAKCRCaEZ6wQi2W
 4ZkvD/9Tm0AdqRYDjoU8A+UDGagpNQJX5o2MxYzKRI15Kjuili8GVVflTvViVBi8H34/ML2TaNa
 jEeaHxyeQssz/2zcEpflayLn02Sq1FOwKnbvzp7VjdvltWyeAkIPn6Nx3gLszasLNrh3FisGZ+8
 pg4FlXvlkDpxnflQ7tu8hTKLCnPWnbzIX8dZqP2JDTTljWc0fqL8CvLXfOqz3W4kdj3JYmGpAB+
 NPcKfhUn+aP+MUzP3j0hxCUiaywhKiR5e0hvgIgyiXYY7KHcD/tfh6P5nefeV3x6nD/NsStw5eO
 sOkyzOe3hc0KlLT2sgdzGw7t1Zm5ytPX6LYjwfBwiBG9vvCC0Cxa6xbqpdr5cUPjmJL0wRFO3/Z
 E0baLz6BFlGEs64xGzWz1dTG+VMlG2V3Or2CKO4p4AIsx7QEio/Rjm6tGChAcqupljAZCeetnSA
 4GcUqixr4W8gbqcFkylk86tIXZmqaI4YsTEyObgqQwmSFIHwUhnU8aV2pLH7JBtJQHABysUjUXz
 P97uJRkCfNs1CVOYbBgH3tYIKH3aSkzIuv4i+gf/8LPtge3BGEOEUHYXc8E4TvJJTnZ1tFP2Zh4
 qzDs5rdjQ6ZsABIz4sdsizTeQjIJytLO0ZIWgZGxjtXnH1U9iT5vCcdUe6qTMkpr20jL9/XqD28
 eOvZ3avwrFwS2jg==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

The ExpressWire library does not depend on NEW_LEDS and selecting it
from a subsystem other than LEDs may cause Kconfig warnings:

WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
  Depends on [n]: NEW_LEDS [=n] && GPIOLIB [=y]
  Selected by [y]:
  - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]

Move it out of the "if NEW_LEDS" block to allow selection from other
subsystems (in particular backlight) without raising this warning.

Link: https://lore.kernel.org/20240212111819.936815-1-arnd@kernel.org
Reported-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Fixes: 25ae5f5f4168 ("leds: Introduce ExpressWire library")
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/leds/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 52328d295b4e..66998b938ed3 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -6,6 +6,12 @@ config LEDS_GPIO_REGISTER
 	  As this function is used by arch code it must not be compiled as a
 	  module.
 
+# This library does not depend on NEW_LEDS and must be independent so it can be
+# selected from other subsystems (specifically backlight).
+config LEDS_EXPRESSWIRE
+	bool
+	depends on GPIOLIB
+
 menuconfig NEW_LEDS
 	bool "LED Support"
 	help
@@ -186,10 +192,6 @@ config LEDS_EL15203000
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-el15203000.
 
-config LEDS_EXPRESSWIRE
-	bool
-	depends on GPIOLIB
-
 config LEDS_TURRIS_OMNIA
 	tristate "LED support for CZ.NIC's Turris Omnia"
 	depends on LEDS_CLASS_MULTICOLOR

-- 
2.43.1



