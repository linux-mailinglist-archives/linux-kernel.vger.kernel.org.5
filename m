Return-Path: <linux-kernel+bounces-164689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 640488B8116
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040241F2570B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF7019DF7A;
	Tue, 30 Apr 2024 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="YRghvhWW"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E217B514;
	Tue, 30 Apr 2024 20:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507488; cv=none; b=DnEZEpAkhbyT6fQUAy2xUm2Z+RwCTO2hilGaCP4T9XRNwNAJBKPUDip58Cf+vsWQHwqoTyMbSwDds53uuEBishqXqO3WcZti5z3Z1KiZFfHyHeGJ2TPQO782e+1+zlAu6yFkfpccfImhqIf7A2H6NIQo8T5vHmmlqAEhrvwwnUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507488; c=relaxed/simple;
	bh=CRudngwwFqEb5JkD9tyr3v9H3uVKI58dqmSAZwNlhLA=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=rVb/UVeps+LibZe49Obevjuw0D9Qpfz+9RgTtk1YyFDaycWvTW2pP6cIFrG9rkWsM2JiqJldaKPl6REe60dX4DGZygEn1elYgV7AXsNtSb5vAGs4MhHVEgRsKE2rLS4Vxu5sPt8Kj3gH9COGOXPjs8QKojy2cDyRbAfq1R+gwfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=YRghvhWW; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=EpMG0aEBxpsvqvhiJSjNm3u60yLj5lLNLQykLwZWCdM=; b=YRghvhWWNz/Z8+sY5K2sqgOodF
	OItBrAWOjBTOExlNIlmi/nDITvP8Eq8Q1DzAmbtvjXOo9PTBLEMaPlYWhKeU386vGXaCCFk9tFXvB
	JXwNWR2g+TpxEpV0uheYUXPRkvqvPQtAHKI7VUqGln+5V5ClMbchYykqrcSR8WwXE3RM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57260 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1s1tiN-0007JJ-AS; Tue, 30 Apr 2024 16:04:35 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jon Ringle <jringle@gridpoint.com>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Date: Tue, 30 Apr 2024 16:04:30 -0400
Message-Id: <20240430200431.4102923-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
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
Subject: [PATCH v2] serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when using prescaler
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

When using a high speed clock with a low baud rate, the 4x prescaler is
automatically selected if required. In that case, sc16is7xx_set_baud()
properly configures the chip registers, but returns an incorrect baud
rate by not taking into account the prescaler value. This incorrect baud
rate is then fed to uart_update_timeout().

For example, with an input clock of 80MHz, and a selected baud rate of 50,
sc16is7xx_set_baud() will return 200 instead of 50.

Fix this by first changing the prescaler variable to hold the selected
prescaler value instead of the MCR bitfield. Then properly take into
account the selected prescaler value in the return value computation.

Also add better documentation about the divisor value computation.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

---

Changes for V2:
- Change prescaler type to "unsigned int" (Jiri S.)

---
 drivers/tty/serial/sc16is7xx.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 03cf30e20b75..bf0065d1c8e9 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -555,16 +555,28 @@ static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
 	return reg == SC16IS7XX_RHR_REG;
 }
 
+/*
+ * Configure programmable baud rate generator (divisor) according to the
+ * desired baud rate.
+ *
+ * From the datasheet, the divisor is computed according to:
+ *
+ *              XTAL1 input frequency
+ *             -----------------------
+ *                    prescaler
+ * divisor = ---------------------------
+ *            baud-rate x sampling-rate
+ */
 static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	u8 lcr;
-	u8 prescaler = 0;
+	unsigned int prescaler = 1;
 	unsigned long clk = port->uartclk, div = clk / 16 / baud;
 
 	if (div >= BIT(16)) {
-		prescaler = SC16IS7XX_MCR_CLKSEL_BIT;
-		div /= 4;
+		prescaler = 4;
+		div /= prescaler;
 	}
 
 	/* Enable enhanced features */
@@ -574,9 +586,10 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 			      SC16IS7XX_EFR_ENABLE_BIT);
 	sc16is7xx_efr_unlock(port);
 
+	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_CLKSEL_BIT,
-			      prescaler);
+			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
 
 	/* Backup LCR and access special register set (DLL/DLH) */
 	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
@@ -592,7 +605,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	/* Restore LCR and access to general register set */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	return DIV_ROUND_CLOSEST(clk / 16, div);
+	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
 }
 
 static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,

base-commit: 660a708098569a66a47d0abdad998e29e1259de6
-- 
2.39.2


