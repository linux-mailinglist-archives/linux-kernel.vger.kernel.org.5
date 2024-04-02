Return-Path: <linux-kernel+bounces-128449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9171895AFD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2162E1C22321
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3178015AAD7;
	Tue,  2 Apr 2024 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="xrkwXQUo"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E652615A4B3;
	Tue,  2 Apr 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079907; cv=none; b=Gf4s8HZXFzj8lBGBaE1JOlrOhqKjSUFsGBbB3BvKPaq+poWHS2BiFz8iKwOWw+HjI6RRk9xmkvHTioIKH64JlUefnzTmGQpvu0lrYZ7VNHjaMNA8N14vofAcI0Wa7Ttyr7sOCmAJCz6Auo1TycYJ5cDNSSSPt4ZSjlF4bZC76xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079907; c=relaxed/simple;
	bh=NO8sx7BEmdXAJCCtmgmWaDRmvaBNQzYUor23w6HgV+A=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=c339y3LE1IncSoQTxsiatPRxeFhHe1R7ZEXS3T6Uc1WvgZvRvmoOoC06oDDJlUGDJdgZRTc2rWQMngWSJzD/GDVDrhTw+C3RLg9Hciwbj2vBkJSFdU70WTn1j60RZXF2Pk31p7NPOOVZe8kJ2oFkohxdA1KNeXMeaSxI4KQ3Xn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=xrkwXQUo; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=Ks1JKRBp1nmEsXMUxSJGLv5REfK4wuCmiSDm2+yGNNI=; b=xrkwXQUo0CW0RX2YW/48jL2CxG
	xYb4cHBH8jEcSTwn3HIjvUXLLIBsnbEUJDcJ+Gg2HTQ18nrfn2SDH7yQLgN0TN96w7LCJeoTqkUjO
	bxjOaogWoPuBoCV0ll04VkBh+m674Ysj45i5ffhsNR0UOtHuOaY2FgLsKsmxa1mSwQmM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56268 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rriBz-0008FF-RO; Tue, 02 Apr 2024 13:45:04 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue,  2 Apr 2024 13:43:50 -0400
Message-Id: <20240402174353.256627-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402174353.256627-1-hugo@hugovil.com>
References: <20240402174353.256627-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH v3 2/5] serial: sc16is7xx: simplify and improve Kconfig help text
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Simplify and improve Kconfig help text for SC16IS7XX driver:

Especially get rid of the confusing:
    "If required say y, and say n to..."
in each of the I2C and SPI portions.

Capitalize SPI keyword for consistency.

Display list of supported ICs each on a separate line (and aligned) to
facilitate locating a specific IC model.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/Kconfig | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index ffcf4882b25f9..48087e34ff527 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1028,9 +1028,18 @@ config SERIAL_SC16IS7XX
 	select SERIAL_CORE
 	depends on (SPI_MASTER && !I2C) || I2C
 	help
-	  This selects support for SC16IS7xx serial ports.
-	  Supported ICs are SC16IS740, SC16IS741, SC16IS750, SC16IS752,
-	  SC16IS760 and SC16IS762. Select supported buses using options below.
+	  Core driver for NXP SC16IS7xx serial ports.
+	  Supported ICs are:
+
+	    SC16IS740
+	    SC16IS741
+	    SC16IS750
+	    SC16IS752
+	    SC16IS760
+	    SC16IS762
+
+	  You also must select at least one of I2C and SPI interface
+	  drivers below.
 
 config SERIAL_SC16IS7XX_I2C
 	bool "SC16IS7xx for I2C interface"
@@ -1041,9 +1050,7 @@ config SERIAL_SC16IS7XX_I2C
 	default y
 	help
 	  Enable SC16IS7xx driver on I2C bus,
-	  If required say y, and say n to i2c if not required,
-	  Enabled by default to support oldconfig.
-	  You must select at least one bus for the driver to be built.
+	  enabled by default to support oldconfig.
 
 config SERIAL_SC16IS7XX_SPI
 	bool "SC16IS7xx for spi interface"
@@ -1052,10 +1059,7 @@ config SERIAL_SC16IS7XX_SPI
 	select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
 	select REGMAP_SPI if SPI_MASTER
 	help
-	  Enable SC16IS7xx driver on SPI bus,
-	  If required say y, and say n to spi if not required,
-	  This is additional support to existing driver.
-	  You must select at least one bus for the driver to be built.
+	  Enable SC16IS7xx driver on SPI bus.
 
 config SERIAL_TIMBERDALE
 	tristate "Support for timberdale UART"
-- 
2.39.2


