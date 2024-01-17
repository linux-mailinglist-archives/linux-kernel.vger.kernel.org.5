Return-Path: <linux-kernel+bounces-29507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FB0830F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D231C1F2678F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B2B2E830;
	Wed, 17 Jan 2024 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="jE2FckAY"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798FA2E63C;
	Wed, 17 Jan 2024 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531171; cv=none; b=EC6oxkNHwndpS+rwdvdiptD+yTvtWz9s75KLACqnKED30lO7CJksG/OpRSES9geeiVQH9yu614euO9qxDRhFVNCKJHTNie8NKpb9SAAUsJGNTEOed7mcaNlHLWecm6ZOPspNNoJPMVtOpbYFm6aQXKlEHxT1Cnt3F8CTdoIz7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531171; c=relaxed/simple;
	bh=cf4L1mwDmy4rMhsIMUmBlJt0eC1KHoF9gevuK6hq8cw=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=CbCl+kfjY0buXmDZ2VJCS1HFkBA+qH9FpV4KImHH5YhiS6MhlY/1oR1hNgIxFCQ+/EF0gi/DE/jBEqVvE7Sg0uiAQNDOQjhEJ6VgISf66o4kV59nUi2NKZya8dSy763ACYNd+Nobr/OGJI3ltxeZ1jKkauJEVkf0nIsJ719zHos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=jE2FckAY; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=dyIY9bGPUC8AKFzYpGoK53HL4/tPhbH1GOk/4KhaMzQ=; b=jE2FckAYbaGR5YJLymgjUqSbcu
	acfHCmTZIZ1Z9SOlnCwjPb6nmIb7IFDfHHndwP2p+dXfk4iOml/szl3f/pYvadKJiPUrEjk5yLCW4
	04Q30AgsaStOUl/J0FRWF6ketzsDiL826AoKFPy5wfR+v39uxFxi3CGs5G5HBZGogBzc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEZA-000155-QY; Wed, 17 Jan 2024 17:39:26 -0500
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
Date: Wed, 17 Jan 2024 17:38:55 -0500
Message-Id: <20240117223856.2303475-18-hugo@hugovil.com>
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
Subject: [PATCH 17/18] serial: max310x: reformat and improve comments
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add comments about I2C slave address structure, and reformat to
improve readability.

Also reformat some comments according to kernel coding style.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 40 ++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 6ef0155074dd..c7849b92abb0 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -179,7 +179,8 @@
 #define MAX310X_FLOWCTRL_GPIADDR_BIT	(1 << 2) /* Enables that GPIO inputs
 						  * are used in conjunction with
 						  * XOFF2 for definition of
-						  * special character */
+						  * special character
+						  */
 #define MAX310X_FLOWCTRL_SWFLOWEN_BIT	(1 << 3) /* Auto SW flow ctrl enable */
 #define MAX310X_FLOWCTRL_SWFLOW0_BIT	(1 << 4) /* SWFLOW bit 0 */
 #define MAX310X_FLOWCTRL_SWFLOW1_BIT	(1 << 5) /* SWFLOW bit 1
@@ -258,7 +259,7 @@ struct max310x_devtype {
 	struct {
 		unsigned short min;
 		unsigned short max;
-	} slave_addr;
+	} slave_addr; /* Relevant only in I2C mode. */
 	int	nr;
 	char	name[9];
 	u8	mode1;
@@ -639,7 +640,8 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 	u8 ch, flag;
 
 	if (port->read_status_mask == MAX310X_LSR_RXOVR_BIT) {
-		/* We are just reading, happily ignoring any error conditions.
+		/*
+		 * We are just reading, happily ignoring any error conditions.
 		 * Break condition, parity checking, framing errors -- they
 		 * are all ignored. That means that we can do a batch-read.
 		 *
@@ -648,7 +650,7 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 		 * that the LSR register applies to the "current" character.
 		 * That's also the reason why we cannot do batched reads when
 		 * asked to check the individual statuses.
-		 * */
+		 */
 
 		sts = max310x_port_read(port, MAX310X_LSR_IRQSTS_REG);
 		max310x_batch_read(port, one->rx_buf, rxlen);
@@ -752,8 +754,10 @@ static void max310x_handle_tx(struct uart_port *port)
 		to_send = (to_send > txlen) ? txlen : to_send;
 
 		if (until_end < to_send) {
-			/* It's a circ buffer -- wrap around.
-			 * We could do that in one SPI transaction, but meh. */
+			/*
+			 * It's a circ buffer -- wrap around.
+			 * We could do that in one SPI transaction, but meh.
+			 */
 			max310x_batch_write(port, xmit->buf + xmit->tail, until_end);
 			max310x_batch_write(port, xmit->buf, to_send - until_end);
 		} else {
@@ -842,7 +846,8 @@ static unsigned int max310x_tx_empty(struct uart_port *port)
 
 static unsigned int max310x_get_mctrl(struct uart_port *port)
 {
-	/* DCD and DSR are not wired and CTS/RTS is handled automatically
+	/*
+	 * DCD and DSR are not wired and CTS/RTS is handled automatically
 	 * so just indicate DSR and CAR asserted
 	 */
 	return TIOCM_DSR | TIOCM_CAR;
@@ -934,7 +939,8 @@ static void max310x_set_termios(struct uart_port *port,
 	max310x_port_write(port, MAX310X_XON1_REG, termios->c_cc[VSTART]);
 	max310x_port_write(port, MAX310X_XOFF1_REG, termios->c_cc[VSTOP]);
 
-	/* Disable transmitter before enabling AutoCTS or auto transmitter
+	/*
+	 * Disable transmitter before enabling AutoCTS or auto transmitter
 	 * flow control
 	 */
 	if (termios->c_cflag & CRTSCTS || termios->c_iflag & IXOFF) {
@@ -961,7 +967,8 @@ static void max310x_set_termios(struct uart_port *port,
 	}
 	max310x_port_write(port, MAX310X_FLOWCTRL_REG, flow);
 
-	/* Enable transmitter after disabling AutoCTS and auto transmitter
+	/*
+	 * Enable transmitter after disabling AutoCTS and auto transmitter
 	 * flow control
 	 */
 	if (!(termios->c_cflag & CRTSCTS) && !(termios->c_iflag & IXOFF)) {
@@ -1052,8 +1059,11 @@ static int max310x_startup(struct uart_port *port)
 					    MAX310X_MODE2_ECHOSUPR_BIT);
 	}
 
-	/* Configure flow control levels */
-	/* Flow control halt level 96, resume level 48 */
+	/*
+	 * Configure flow control levels:
+	 *   resume: 48
+	 *   halt:   96
+	 */
 	max310x_port_write(port, MAX310X_FLOWLVL_REG,
 			   MAX310X_FLOWLVL_RES(48) | MAX310X_FLOWLVL_HALT(96));
 
@@ -1561,10 +1571,10 @@ static unsigned short max310x_i2c_slave_addr(unsigned short addr,
 	 * For MAX14830 and MAX3109, the slave address depends on what the
 	 * A0 and A1 pins are tied to.
 	 * See Table I2C Address Map of the datasheet.
-	 * Based on that table, the following formulas were determined.
-	 * UART1 - UART0 = 0x10
-	 * UART2 - UART1 = 0x20 + 0x10
-	 * UART3 - UART2 = 0x10
+	 * Based on that table, the following formulas were determined:
+	 *   UART1 - UART0 = 0x10
+	 *   UART2 - UART1 = 0x20 + 0x10
+	 *   UART3 - UART2 = 0x10
 	 */
 
 	addr -= nr * 0x10;
-- 
2.39.2


