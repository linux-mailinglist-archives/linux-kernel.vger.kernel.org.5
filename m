Return-Path: <linux-kernel+bounces-30266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8352C831C60
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2F71F2957D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2941E2D7BA;
	Thu, 18 Jan 2024 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="lRFsiw/f"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184792D7A6;
	Thu, 18 Jan 2024 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591363; cv=none; b=a568r7xllkXxqokijrZVz1o3TZesMp1Jkqi53chIrT1BbH4JvTppOOhPg07utbg3sqoMpW1Z1S3I9uAe4gFD21nZ1yT50NDR8VnfrumrwgAwoEYT6HZWPG0l8AaQ3bu+Qp03pfZxHQWLtnDLu3OaAnfDaD4D9Guxe3jFjdpxlg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591363; c=relaxed/simple;
	bh=DWyV82oro07Sb4RFuj7QNWOcz/TjyK42/icJHH79/ro=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=i50xb+El7mhI7F7eNNIgajtx58pG1ELlRHXUFX329yJ0K0V+HLeuOsCjRr3ewpmef6GrBI4/yG+CRyvoUckL82EOVwq7IPZAQMwdNYdvWU8x7aM2OYUTGfMvCJ18o/L1x9SvwIGOa9yhd0HuQRjYwT6qsExzvHHeek8mx7n2uog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=lRFsiw/f; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=E8xBpE6/izJpUPpiElZwJ8/NHQwprbnTz3pLvy5YXIg=; b=lRFsiw/fpTzx80SGspb8ovMJ3l
	8TkzMXIuIGWNyi5vGGizFod9X2lrdYgumrZvQiPKdeANUJfnMVkULEcRjW7Vh3gBQVZqgeqS1U4+f
	WxTwwLAUzWU0EcpfDcgOBRwJljgwzKWtrg1SJNzg/pmuGsOgkBejDSHgMgMrlZOEL3d8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57058 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQUE1-0002lf-D2; Thu, 18 Jan 2024 10:22:38 -0500
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
Date: Thu, 18 Jan 2024 10:22:10 -0500
Message-Id: <20240118152213.2644269-15-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240118152213.2644269-1-hugo@hugovil.com>
References: <20240118152213.2644269-1-hugo@hugovil.com>
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
Subject: [PATCH v2 14/17] serial: max310x: use common power function for all variants
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Simplify driver by defining a common function to handle the power
control of all variants.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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


