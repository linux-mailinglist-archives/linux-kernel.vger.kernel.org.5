Return-Path: <linux-kernel+bounces-137256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA09B89E050
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1F9B2A880
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D908E136E0C;
	Tue,  9 Apr 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="xBtBqJTG"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1503137937;
	Tue,  9 Apr 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677588; cv=none; b=m6jSqoc24qcX6kGazDVRwhVUVoi1ttYiTZYr0mxVs/MAql0V7rAMQRC4M2LUhuOIxfaoRxln5OMMRMMWwCyL0GICkRTYEqeLPCam5eWUkaebCFqCV+FQjE0sAd8KqTb8xAeZTuiu3gsXyFaweccon8AIl2Ffng1T1mCivbz673E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677588; c=relaxed/simple;
	bh=vzjGeu+AJdAKb5gZa1RInSJYJalU2mNRS87EdkJDi78=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=jbox9cqkIej6m+YfLpuzznladr5CUUfSyz4RpDL3cjosukA+0UbELazNACBkRNRqPCO5SYTOp+fuuu/ZA92Z3r4BmxiM//jIw4gJJJG6CS45T+eumms8dDQVhC/JPXBLriiXKm/IgAO8kt2+zUyCI7YyVw36q/1HfkKscJJZo50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=xBtBqJTG; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=/ay+oTr5UAX2JmfeWVeDyagBvvrT/SX3Jb1qflhjCxQ=; b=xBtBqJTGBCz2D38LYwLYdqa9/E
	etKREnrqxqHOQp4XjWye5wMYClQMMi9eJtNAESoUZ/k4KL8WkDT7tnY/Rc+dc5WIavA3AE2FLkEJD
	ddq+uzzCdtRIhzGFLPD4GlBgxaQvuNPSRckXu7e88Af6PxfziZpOGh8iG3VuhKH9E+ls=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:44750 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1ruDfu-0002NM-NL; Tue, 09 Apr 2024 11:46:19 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue,  9 Apr 2024 11:42:52 -0400
Message-Id: <20240409154253.3043822-5-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409154253.3043822-1-hugo@hugovil.com>
References: <20240409154253.3043822-1-hugo@hugovil.com>
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
Subject: [PATCH v4 4/5] serial: sc16is7xx: split into core and I2C/SPI parts (sc16is7xx_lines)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Before, sc16is7xx_lines was checked for a free (zero) bit first, and then
later it was set only if UART port registration succeeded. Now that
sc16is7xx_lines is shared for the I2C and SPI drivers, there is a
possibility that the two drivers can simultaneously try to reserve the same
line bit at the same time.

To prevent this, make sure line allocation is reserved atomically, and use
a new variable to hold the status of UART port registration.

Now that we no longer need to search if a bit is set, it is now possible
to simplify sc16is7xx_lines allocation by using the IDA framework.

Link: https://lore.kernel.org/all/20231212150302.a9ec5d085a4ba65e89ca41af@hugovil.com/
Link: https://lore.kernel.org/all/CAHp75VebCZckUrNraYQj9k=Mrn2kbYs1Lx26f5-8rKJ3RXeh-w@mail.gmail.com/
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 51fb1c95d3826..1eb440f0c9cd0 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -10,12 +10,12 @@
 #undef DEFAULT_SYMBOL_NAMESPACE
 #define DEFAULT_SYMBOL_NAMESPACE SERIAL_NXP_SC16IS7XX
 
-#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/gpio/driver.h>
+#include <linux/idr.h>
 #include <linux/kthread.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -345,7 +345,7 @@ struct sc16is7xx_port {
 	struct sc16is7xx_one		p[];
 };
 
-static DECLARE_BITMAP(sc16is7xx_lines, SC16IS7XX_MAX_DEVS);
+static DEFINE_IDA(sc16is7xx_lines);
 
 static struct uart_driver sc16is7xx_uart = {
 	.owner		= THIS_MODULE,
@@ -1472,6 +1472,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 	u32 uartclk = 0;
 	int i, ret;
 	struct sc16is7xx_port *s;
+	bool port_registered[SC16IS7XX_MAX_PORTS];
 
 	for (i = 0; i < devtype->nr_uart; i++)
 		if (IS_ERR(regmaps[i]))
@@ -1536,13 +1537,19 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 	regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
 		     SC16IS7XX_IOCONTROL_SRESET_BIT);
 
+	/* Mark each port line and status as uninitialised. */
 	for (i = 0; i < devtype->nr_uart; ++i) {
-		s->p[i].port.line = find_first_zero_bit(sc16is7xx_lines,
-							SC16IS7XX_MAX_DEVS);
-		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
-			ret = -ERANGE;
+		s->p[i].port.line = SC16IS7XX_MAX_DEVS;
+		port_registered[i] = false;
+	}
+
+	for (i = 0; i < devtype->nr_uart; ++i) {
+		ret = ida_alloc_max(&sc16is7xx_lines,
+				    SC16IS7XX_MAX_DEVS - 1, GFP_KERNEL);
+		if (ret < 0)
 			goto out_ports;
-		}
+
+		s->p[i].port.line = ret;
 
 		/* Initialize port data */
 		s->p[i].port.dev	= dev;
@@ -1588,7 +1595,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		if (ret)
 			goto out_ports;
 
-		set_bit(s->p[i].port.line, sc16is7xx_lines);
+		port_registered[i] = true;
 
 		/* Enable EFR */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
@@ -1646,9 +1653,12 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 #endif
 
 out_ports:
-	for (i = 0; i < devtype->nr_uart; i++)
-		if (test_and_clear_bit(s->p[i].port.line, sc16is7xx_lines))
+	for (i = 0; i < devtype->nr_uart; i++) {
+		if (s->p[i].port.line < SC16IS7XX_MAX_DEVS)
+			ida_free(&sc16is7xx_lines, s->p[i].port.line);
+		if (port_registered[i])
 			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
+	}
 
 	kthread_stop(s->kworker_task);
 
@@ -1671,7 +1681,7 @@ void sc16is7xx_remove(struct device *dev)
 
 	for (i = 0; i < s->devtype->nr_uart; i++) {
 		kthread_cancel_delayed_work_sync(&s->p[i].ms_work);
-		clear_bit(s->p[i].port.line, sc16is7xx_lines);
+		ida_free(&sc16is7xx_lines, s->p[i].port.line);
 		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 		sc16is7xx_power(&s->p[i].port, 0);
 	}
-- 
2.39.2


