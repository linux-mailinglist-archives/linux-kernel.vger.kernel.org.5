Return-Path: <linux-kernel+bounces-29504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C020830F67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10941C2209B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8C71E891;
	Wed, 17 Jan 2024 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="zggwJupn"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22F28E2B;
	Wed, 17 Jan 2024 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531167; cv=none; b=aBQTUDNLB/Z8TEXXKBanfaxwipXz0c2bZNhmZYDxSYsqkuUpFasM+91sib/Anbu/QE/lcevq2okrL2KE9QqkiegBp4YHA+uHynw+3ribIkmasyfaQExMO4ktik9+LlSeXawoUUoTls+6cbms9BYZPYbktDDgrcgzDCtz0HeC4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531167; c=relaxed/simple;
	bh=o4qHYcx75Vffmt7jhpyWi7RixBhcgdK+VPLDK0No6cc=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=jh46ZEdjNF5G7TSaTJ7WPJD2+bjsirTgkZQX9oZj42KRAqunKGJEXEO+rZuqfbkgEXNTqVio+DGG3S5JO6AFeuLNlvrXHC3SQRY9zYtm6nmTjDd9aPuqNQgp1nnQw9vRmxOrY5BnWyYOlWudQzVNpwodw7JkiGMz5i4Tm+7nm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=zggwJupn; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=gTJ6JF7DaGbCoA2FCgeiQSkKmwNMR+GBKctwQFPlxF0=; b=zggwJupnfODyPNBUu/FCdEtjrU
	r0IU11qze2fPY6J8DZrExlaRBGQffSB01h0vhpo+04iuLBMUs53c/umwBsVE52yD5kYu+J/NcUId+
	V75XSmptyf0w0GfydlYILeHgJ+h9eHkt2pGmIpRJRFk1+Zy9jiFrkT5zlUtk8uFpBtn0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEZ6-000155-Ug; Wed, 17 Jan 2024 17:39:21 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cosmin.tanislav@analog.com,
	andy.shevchenko@gmail.com,
	shc_work@mail.ru
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 17 Jan 2024 17:38:52 -0500
Message-Id: <20240117223856.2303475-15-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117223856.2303475-1-hugo@hugovil.com>
References: <20240117223856.2303475-1-hugo@hugovil.com>
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
Subject: [PATCH 14/18] serial: max310x: use common power function for all variants
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Simplify driver by defining a common function to handle the power
control of all variants.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 44 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 83beaab3a0c5..e39d8ea51e4e 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -260,11 +260,12 @@ struct max310x_devtype {
 		unsigned short max;
 	} slave_addr;
 	int	nr;
-	void	(*power)(struct uart_port *, int);
 	char	name[9];
 	u8	mode1;
 	u8	rev_id_val;
 	u8	rev_id_reg; /* Relevant only if rev_id_val is defined. */
+	u8	power_reg; /* Register address for power/sleep control. */
+	u8	power_bit; /* Bit for sleep or power-off mode (active high). */
 };
 
 struct max310x_one {
@@ -378,18 +379,10 @@ static int max310x_detect(struct device *dev)
 
 static void max310x_power(struct uart_port *port, int on)
 {
-	max310x_port_update(port, MAX310X_MODE1_REG,
-			    MAX310X_MODE1_FORCESLEEP_BIT,
-			    on ? 0 : MAX310X_MODE1_FORCESLEEP_BIT);
-	if (on)
-		msleep(50);
-}
+	struct max310x_port *s = dev_get_drvdata(port->dev);
 
-static void max14830_power(struct uart_port *port, int on)
-{
-	max310x_port_update(port, MAX310X_BRGCFG_REG,
-			    MAX14830_BRGCFG_CLKDIS_BIT,
-			    on ? 0 : MAX14830_BRGCFG_CLKDIS_BIT);
+	max310x_port_update(port, s->devtype->power_reg, s->devtype->power_bit,
+			    on ? 0 : s->devtype->power_bit);
 	if (on)
 		msleep(50);
 }
@@ -400,7 +393,8 @@ static const struct max310x_devtype max3107_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT | MAX310X_MODE1_IRQSEL_BIT,
 	.rev_id_val = MAX3107_REV_ID,
 	.rev_id_reg = MAX310X_REVID_REG,
-	.power	= max310x_power,
+	.power_reg = MAX310X_MODE1_REG,
+	.power_bit = MAX310X_MODE1_FORCESLEEP_BIT,
 	.slave_addr	= {
 		.min = 0x2c,
 		.max = 0x2f,
@@ -413,7 +407,8 @@ static const struct max310x_devtype max3108_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT,
 	.rev_id_val = 0, /* Unsupported. */
 	.rev_id_reg = 0, /* Irrelevant when rev_id_val is not defined. */
-	.power	= max310x_power,
+	.power_reg = MAX310X_MODE1_REG,
+	.power_bit = MAX310X_MODE1_FORCESLEEP_BIT,
 	.slave_addr	= {
 		.min = 0x60,
 		.max = 0x6f,
@@ -426,7 +421,8 @@ static const struct max310x_devtype max3109_devtype = {
 	.mode1	= MAX310X_MODE1_AUTOSLEEP_BIT,
 	.rev_id_val = MAX3109_REV_ID,
 	.rev_id_reg = MAX310X_REVID_EXTREG,
-	.power	= max310x_power,
+	.power_reg = MAX310X_MODE1_REG,
+	.power_bit = MAX310X_MODE1_FORCESLEEP_BIT,
 	.slave_addr	= {
 		.min = 0x60,
 		.max = 0x6f,
@@ -439,7 +435,8 @@ static const struct max310x_devtype max14830_devtype = {
 	.mode1	= MAX310X_MODE1_IRQSEL_BIT,
 	.rev_id_val = MAX14830_REV_ID,
 	.rev_id_reg = MAX310X_REVID_EXTREG,
-	.power	= max14830_power,
+	.power_reg = MAX310X_BRGCFG_REG,
+	.power_bit = MAX14830_BRGCFG_CLKDIS_BIT,
 	.slave_addr	= {
 		.min = 0x60,
 		.max = 0x6f,
@@ -1025,10 +1022,9 @@ static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios
 
 static int max310x_startup(struct uart_port *port)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
 	unsigned int val;
 
-	s->devtype->power(port, 1);
+	max310x_power(port, 1);
 
 	/* Configure MODE1 register */
 	max310x_port_update(port, MAX310X_MODE1_REG,
@@ -1073,12 +1069,10 @@ static int max310x_startup(struct uart_port *port)
 
 static void max310x_shutdown(struct uart_port *port)
 {
-	struct max310x_port *s = dev_get_drvdata(port->dev);
-
 	/* Disable all interrupts */
 	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
 
-	s->devtype->power(port, 0);
+	max310x_power(port, 0);
 }
 
 static const char *max310x_type(struct uart_port *port)
@@ -1140,7 +1134,7 @@ static int __maybe_unused max310x_suspend(struct device *dev)
 
 	for (i = 0; i < s->devtype->nr; i++) {
 		uart_suspend_port(&max310x_uart, &s->p[i].port);
-		s->devtype->power(&s->p[i].port, 0);
+		max310x_power(&s->p[i].port, 0);
 	}
 
 	return 0;
@@ -1152,7 +1146,7 @@ static int __maybe_unused max310x_resume(struct device *dev)
 	int i;
 
 	for (i = 0; i < s->devtype->nr; i++) {
-		s->devtype->power(&s->p[i].port, 1);
+		max310x_power(&s->p[i].port, 1);
 		uart_resume_port(&max310x_uart, &s->p[i].port);
 	}
 
@@ -1367,7 +1361,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		set_bit(line, max310x_lines);
 
 		/* Go to suspend mode */
-		devtype->power(&s->p[i].port, 0);
+		max310x_power(&s->p[i].port, 0);
 	}
 
 #ifdef CONFIG_GPIOLIB
@@ -1421,7 +1415,7 @@ static void max310x_remove(struct device *dev)
 		if (test_and_clear_bit(s->p[i].port.line, max310x_lines))
 			uart_remove_one_port(&max310x_uart, &s->p[i].port);
 
-		s->devtype->power(&s->p[i].port, 0);
+		max310x_power(&s->p[i].port, 0);
 	}
 
 	clk_disable_unprepare(s->clk);
-- 
2.39.2


