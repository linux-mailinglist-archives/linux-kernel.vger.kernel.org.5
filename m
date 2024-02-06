Return-Path: <linux-kernel+bounces-55679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0B884BFE1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B5A1F25E20
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABB51BF37;
	Tue,  6 Feb 2024 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="tZKBoaC3"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD71C282;
	Tue,  6 Feb 2024 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257675; cv=none; b=YnXCm4uUdCx0UevGlT3zyJkTZFdVuj9L/KJwVxfu7E2wRYAzsL94/B/lFCyOguASv2x7HutGvmthlpcpb5zAgK2XXgL+EjFrDZJkOPmxmp16+jeVAWngCBHmhctVe1WLzCWy2VcWNxP6M61beCoQj+VaXCeX76Vy6VNVt2PknsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257675; c=relaxed/simple;
	bh=iX/jZ6x7JPoYKfE3wKn+A8vOt4Aa7voggEBapOK97Ys=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=oXHiidwUXdOQ7Fzu/YoVToHlQlebzff0YJw/Lmb690T46svKtAFimPZIWvTXpZfIJn1BdUqfeZ1eL2mbKoSg3BeAtm3rK6Tt/jDtYLK/FaqI7XI/WjA6AxxlhbRA17KWhqmE+a8lO/4xAqwz7LOENq5KFNCWjbnt1AAM08h6QN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=tZKBoaC3; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=/gIgOLz3wVbfgBdtwAQlAKb78cdDXKUGPHpE/f9zKGA=; b=tZKBoaC3ZXbwdefK2ul98OxQOu
	+NLmQ458ajNMpM/OUl+yI5we2ugABI4KlRluVAZXMcdob+jH65KXAlGOPqsyzDT2Y7uJu24uQyK38
	HrTD1yTEoLl+a3++D+L20vtGNU3qAXwkoAQ8qWGyDGqMxFVRUUVGqu1aUky3toR9lrfY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41434 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rXTCm-0006XX-Dx; Tue, 06 Feb 2024 16:42:13 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue,  6 Feb 2024 16:42:05 -0500
Message-Id: <20240206214208.2141067-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206214208.2141067-1-hugo@hugovil.com>
References: <20240206214208.2141067-1-hugo@hugovil.com>
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
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 1/4] serial: sc16is7xx: simplify and improve Kconfig help text
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
index ffcf4882b25f..48087e34ff52 100644
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


