Return-Path: <linux-kernel+bounces-69358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 594308587D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6FC1C23313
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAFE146904;
	Fri, 16 Feb 2024 21:16:58 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F11420DE;
	Fri, 16 Feb 2024 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118218; cv=none; b=p62i/zXkcnYD+MmAlLG9DOfN3KmIP8BMGMPWqhDN9ukaXG8UDTySEldjBFKRRIG/MCRLggY/wq0QeE83nM1YgSBXyLOQFjQQC2Kagm8s0f4SK9RNefYmgiNYvs8WTOjHZ11+6bvd88t6owt3qFherhLaxWJZsuA5l/Or+szkz0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118218; c=relaxed/simple;
	bh=ilUd2XEnYNcfkPcVbpE92eytf80u0600eDPMHH5G6bY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nh9kKxaPcUSC8+N8eyO4e1LMnM7hXSH9TgylfhvukioPqF0D0MYH9B5JTF9dN1IZismoTZpdR5fZcp02DoaZSyZGvKAzWAIpSGnDMtsVTmEL0zZUhwf9e6v0EylOlISpPYPjHp2+jzIUdCVgDMJUsmn3h+bTV1vdwmAuUwucPx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 0A4F987249;
	Fri, 16 Feb 2024 22:16:47 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Fri, 16 Feb 2024 22:15:44 +0100
Subject: [PATCH v2 2/2] leds: expresswire: don't depend on NEW_LEDS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240216-expresswire-deps-v2-2-8be59c4a75f5@skole.hr>
References: <20240216-expresswire-deps-v2-0-8be59c4a75f5@skole.hr>
In-Reply-To: <20240216-expresswire-deps-v2-0-8be59c4a75f5@skole.hr>
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
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=ilUd2XEnYNcfkPcVbpE92eytf80u0600eDPMHH5G6bY=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlz9CFbQMadin7Zla/M2jnk+iQ4GhiLeNoguKar
 l1fhos+V66JAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZc/QhQAKCRCaEZ6wQi2W
 4e5nD/9KEaP/IJ5aCnN9dT5oMviYaX+wYXZI5R60COC8fWdFX0HrlrZL8u44u4GR1W5TgbNFsdL
 Z3NNqjzgV84k0a5fNIslVFCKi4GUCWrj4xaA+6vuN+iBw+e7fls5IN1wqHWqnmpjLqmC1tkT+Tb
 7SGnrwm3P0lUkZthiAX3Ox1fmKMBJfDSmT3NntRlLbO8pcjylfNOWnYOKvMMtIVxJvmFrMSl6Iy
 eqq/wa1RJpN+15orAfXTU1OB5/NuPseaIoN9FvWuyX26LV0oEHJJ1dYLwWCZ+aUSEtj8FFCtMyP
 H7VVrIW8jrD18Hv+KCog8JJcOZ1PCTDaA/U/M7GhMJY9lMHDu1U/ekxbgfZzDWUjTqi2ebUA9MU
 7U1NwcqfQ5hlDykSBzKZbLxbxrWQXB05miTWlE55+PAiz+t+k9oVMno8wlqpCmaUdHZvg30+kL8
 KhodxUneOoU7fmTz9uWxqqbYa064GnK0Pv13fGP9121TIrxtx7Zpghp7RcffeQU0YiYhNJfNMDO
 G9oa58a0t0W589NGvH64zFZDjVMABnmuAMKQ5aiS5e3O/6QS3EOa7sIFDbQfwP8wKZDtoEVF44d
 Eo7lxKkX8sAzs9Pdqd5BCsqPEdI6MVhOKuXW9Rt4zyF/CzrIJdqgAguBTX1jy3nyNl5dzzKCxPe
 690wlyjR4kIHKgA==
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

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/20240212111819.936815-1-arnd@kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402161410.IG9I4odj-lkp@intel.com/
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Fixes: 25ae5f5f4168 ("leds: Introduce ExpressWire library")
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v2:
- Change Link: to Closes: to silence checkpatch
- Add kernel test robot's error report
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



