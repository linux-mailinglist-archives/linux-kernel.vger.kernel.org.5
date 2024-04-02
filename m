Return-Path: <linux-kernel+bounces-128451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD0A895B00
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFD9281B7E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D9815B0E7;
	Tue,  2 Apr 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ntto68Be"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F2315AD91;
	Tue,  2 Apr 2024 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079910; cv=none; b=E3QihQVZ//Nbi4xririDZPWLC3DzoYt3FHnISHgvHi+cXf0x0QW7JXPRRwF8uhRx26k09q8uf/LMWL7n5SQ+TpMyAlE/vjkcILIZEhEaShBaRo3ij5LAqZb8z4E42mZ91al4vVIy9lMjSjhPmwxuCwg/8Xv/4c7LIB7dIrL+Fhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079910; c=relaxed/simple;
	bh=Ks4AjQXWsPtJuZs48D9qoJnTOqm7WL1G1aMoJJsmIgg=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=PlNgFN7+nXPuRd/Ne+TNGWA4+qk61N8r7lDsDj+TGKFR/3Bjh/GYCakTg4XfdTBeKBMuuIEcKzund08JmJmUMmqPx6FvTE2pc1yayFHU3nHluBTRFw9Teix8VPDaq6zm0T/c8KFzpy9lmgpWop67YlMdRlsgqdwvChaBWdT+Tzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ntto68Be; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=HePpZGjVpPEdTqv+h84gUqQjiWZ5IkB2xGEJ8P/RY/w=; b=ntto68Be5hzIR38w1HhpGHdRn7
	WtntrqkGslsnkCbPKZB052IRLmio92KLkmVX0YTuzzvV7F97xpjW9iDpQ0SljzmpXFONBZsqc8GSC
	bwD0j7OL+cXMwYtfXY54UYWBBXV62tj/FVdwVMd/12ulfmEsnDeMlhHLH/oGFkfn1JJA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56268 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rriC3-0008FF-9T; Tue, 02 Apr 2024 13:45:07 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue,  2 Apr 2024 13:43:52 -0400
Message-Id: <20240402174353.256627-5-hugo@hugovil.com>
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
Subject: [PATCH v3 4/5] serial: sc16is7xx: split into core and I2C/SPI parts (sc16is7xx_lines)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Before, sc16is7xx_lines was checked for a free (zero) bit first, and then
later it was set only if UART port registration succeeded. Now that
sc16is7xx_lines is shared for the I2C and SPI drivers, there is a
possibility that the two drivers can simultaneously try to reserve the same
line bit at the same time.

To prevent this, make sure line allocation is reserved atomically, and use
a new variable to hold the status of UART port regisration.

Now that we no longer need to search if a bit is set, it is now possible
to simplify sc16is7xx_lines allocation by using the IDA framework.

Link: https://lore.kernel.org/all/20231212150302.a9ec5d085a4ba65e89ca41af@hugovil.com/
Link: https://lore.kernel.org/all/CAHp75VebCZckUrNraYQj9k=Mrn2kbYs1Lx26f5-8rKJ3RXeh-w@mail.gmail.com/
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 05e5cbc0f9e8b..58ab6b16860b8 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -341,7 +341,7 @@ struct sc16is7xx_port {
 	struct sc16is7xx_one		p[];
 };
 
-static DECLARE_BITMAP(sc16is7xx_lines, SC16IS7XX_MAX_DEVS);
+static DEFINE_IDA(sc16is7xx_lines);
 
 static struct uart_driver sc16is7xx_uart = {
 	.owner		= THIS_MODULE,
@@ -1468,6 +1468,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 	u32 uartclk = 0;
 	int i, ret;
 	struct sc16is7xx_port *s;
+	bool port_registered[SC16IS7XX_MAX_PORTS];
 
 	for (i = 0; i < devtype->nr_uart; i++)
 		if (IS_ERR(regmaps[i]))
@@ -1532,13 +1533,19 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
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
@@ -1584,7 +1591,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 		if (ret)
 			goto out_ports;
 
-		set_bit(s->p[i].port.line, sc16is7xx_lines);
+		port_registered[i] = true;
 
 		/* Enable EFR */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
@@ -1642,9 +1649,12 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
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
 
@@ -1667,7 +1677,7 @@ void sc16is7xx_remove(struct device *dev)
 
 	for (i = 0; i < s->devtype->nr_uart; i++) {
 		kthread_cancel_delayed_work_sync(&s->p[i].ms_work);
-		clear_bit(s->p[i].port.line, sc16is7xx_lines);
+		ida_free(&sc16is7xx_lines, s->p[i].port.line);
 		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 		sc16is7xx_power(&s->p[i].port, 0);
 	}
-- 
2.39.2


