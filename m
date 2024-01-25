Return-Path: <linux-kernel+bounces-38363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA9F83BE54
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39893293FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30E31C6BF;
	Thu, 25 Jan 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gu4ok8ca"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F91C6AB;
	Thu, 25 Jan 2024 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177303; cv=none; b=oiZkTw5k1I4E/7/oRJp5fUc6STAkqGb7Qp3lZAmtwNQpTSMNUPZU3Qu32AAiA8stlqoC8TGjxXcKn687CP6mzJetChCM3xrwIkZ4BI5xgOGk1wuPCLcJ3LlWp3TGENPdg56ra24wdkMyA9krJNsmnnYSMGthdh0xoZ1zr5R2GbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177303; c=relaxed/simple;
	bh=X0qq5ZaVDzahs2+lbQaAYhW2wnzFrplz3eF7XvHPfSY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J7XKhqgpwpMlZl9OgwwxEEf3MAJ/1BRQ8fCbSsA1PNAZCpl/yvqlgaReMTRUJ1/X2rIdKtX8j39ilPUIstsCmCSnxPVGMdJLA2YknH655NuQqYFYKXMLS12v6oQbMzwuP2ZN2QBhWkP6Dt8FPvkcAMNc0AE7kdI/uiMjMRwlvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gu4ok8ca; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706177300; x=1737713300;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X0qq5ZaVDzahs2+lbQaAYhW2wnzFrplz3eF7XvHPfSY=;
  b=gu4ok8cavgX9ltu43twFi+e+CPjnFtDFHQRJhrePzLK3g4uPWThpYR4Z
   oRYEGmhsLkaK4SF1V3naRyZ3AlmWjRp3VjYr7ITBsQyocQXVrtFUGwjjR
   A25hD9+nXNQuyLAoM4SuVAqk+0b7alkEtzNeNtbJm1awyuedu0r7aksWz
   yqJ45T8C1GAsVC0wYKNucfZqH6qw0UcHe6nAk0H2sds7wY4iLyv0ZrLy+
   5ga/aQpywqoxonP8AEyhbXSs2hksKqvw/9Tbe4DX0XVAZ8PMyKldc1QWs
   Mta/wEron2KwmOl+wm2brLZU80I9ynJ3fGc2N5AQaMOViSOZmolF3I3ej
   g==;
X-CSE-ConnectionGUID: XzFUEa+2R8WssLIbT7r3rw==
X-CSE-MsgGUID: /WxQOswXQBeea8jiQrnz6g==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="scan'208";a="182516535"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 03:08:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 03:08:14 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 03:08:09 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
	<andriy.shevchenko@linux.intel.com>, <f.fainelli@gmail.com>,
	<john.ogness@linutronix.de>, <tony@atomide.com>, <tglx@linutronix.de>,
	<jiaqing.zhao@linux.intel.com>, <linux-serial@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <UNGLinuxDriver@microchip.com>
Subject: [PATCH v1 tty] 8250: microchip: Add 4 Mbps support in PCI1XXXX UART
Date: Thu, 25 Jan 2024 15:36:19 +0530
Message-ID: <20240125100619.154873-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The current clock input is set to 62.5 MHz for supporting fractional
divider, which enables generation of an acceptable baud rate from any
frequency. With the current clock input the baud rate range is limited
to 3.9 Mbps. Hence, the current range is extended to support 4 Mbps
with Burst mode operation. Divisor calculation for a given baud rate is
updated as the sampling rate is reduced from 16 to 8 for 4 Mbps.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 34 +++++++++++++++++++++----
 drivers/tty/serial/8250/8250_port.c     |  7 +++++
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index d53605bf908d..6cfeba058dba 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -82,7 +82,8 @@
 #define ADCL_CFG_PIN_SEL			BIT(1)
 #define ADCL_CFG_EN				BIT(0)
 
-#define UART_BIT_SAMPLE_CNT			16
+#define UART_BIT_SAMPLE_CNT_8			8
+#define UART_BIT_SAMPLE_CNT_16			16
 #define BAUD_CLOCK_DIV_INT_MSK			GENMASK(31, 8)
 #define ADCL_CFG_RTS_DELAY_MASK			GENMASK(11, 8)
 #define UART_CLOCK_DEFAULT			(62500 * HZ_PER_KHZ)
@@ -96,6 +97,7 @@
 	(UART_WAKE_N_PIN | UART_WAKE_NCTS | UART_WAKE_INT)
 
 #define UART_BAUD_CLK_DIVISOR_REG		0x54
+#define FRAC_DIV_CFG_REG			0x58
 
 #define UART_RESET_REG				0x94
 #define UART_RESET_D3_RESET_DISABLE		BIT(16)
@@ -104,6 +106,10 @@
 #define UART_TX_BURST_FIFO			0xA0
 #define UART_RX_BURST_FIFO			0xA4
 
+#define UART_BIT_DIVISOR_8			0x26731000
+#define UART_BIT_DIVISOR_16			0x6ef71000
+#define UART_BAUD_4MBPS				4000000
+
 #define MAX_PORTS				4
 #define PORT_OFFSET				0x100
 #define RX_BUF_SIZE				512
@@ -210,15 +216,24 @@ static int pci1xxxx_get_num_ports(struct pci_dev *dev)
 static unsigned int pci1xxxx_get_divisor(struct uart_port *port,
 					 unsigned int baud, unsigned int *frac)
 {
+	unsigned int uart_sample_cnt;
 	unsigned int quot;
 
+	if (baud >= UART_BAUD_4MBPS) {
+		uart_sample_cnt = UART_BIT_SAMPLE_CNT_8;
+		writel(UART_BIT_DIVISOR_8, (port->membase + FRAC_DIV_CFG_REG));
+	} else {
+		uart_sample_cnt = UART_BIT_SAMPLE_CNT_16;
+		writel(UART_BIT_DIVISOR_16, (port->membase + FRAC_DIV_CFG_REG));
+	}
+
 	/*
 	 * Calculate baud rate sampling period in nanoseconds.
 	 * Fractional part x denotes x/255 parts of a nanosecond.
 	 */
-	quot = NSEC_PER_SEC / (baud * UART_BIT_SAMPLE_CNT);
-	*frac = (NSEC_PER_SEC - quot * baud * UART_BIT_SAMPLE_CNT) *
-		  255 / UART_BIT_SAMPLE_CNT / baud;
+	quot = NSEC_PER_SEC / (baud * uart_sample_cnt);
+	*frac = (NSEC_PER_SEC - quot * baud * uart_sample_cnt) *
+		  255 / uart_sample_cnt / baud;
 
 	return quot;
 }
@@ -237,7 +252,16 @@ static int pci1xxxx_rs485_config(struct uart_port *port,
 	u32 delay_in_baud_periods;
 	u32 baud_period_in_ns;
 	u32 mode_cfg = 0;
+	u32 sample_cnt;
 	u32 clock_div;
+	u32 frac_div;
+
+	frac_div = readl(port->membase + FRAC_DIV_CFG_REG);
+
+	if (frac_div == UART_BIT_DIVISOR_16)
+		sample_cnt = UART_BIT_SAMPLE_CNT_16;
+	else
+		sample_cnt = UART_BIT_SAMPLE_CNT_8;
 
 	/*
 	 * pci1xxxx's uart hardware supports only RTS delay after
@@ -253,7 +277,7 @@ static int pci1xxxx_rs485_config(struct uart_port *port,
 			clock_div = readl(port->membase + UART_BAUD_CLK_DIVISOR_REG);
 			baud_period_in_ns =
 				FIELD_GET(BAUD_CLOCK_DIV_INT_MSK, clock_div) *
-				UART_BIT_SAMPLE_CNT;
+				sample_cnt;
 			delay_in_baud_periods =
 				rs485->delay_rts_after_send * NSEC_PER_MSEC /
 				baud_period_in_ns;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 925ee1d61afb..2a85bc9475f9 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2688,6 +2688,7 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 					     struct ktermios *termios,
 					     const struct ktermios *old)
 {
+	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int tolerance = port->uartclk / 100;
 	unsigned int min;
 	unsigned int max;
@@ -2705,6 +2706,12 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 		max = (port->uartclk + tolerance) / 16;
 	}
 
+	/*
+	 * Microchip PCI1XXXX UART supports maximum baud rate up to 4 Mbps
+	 */
+	if (up->port.type == PORT_MCHP16550A)
+		max = 4000000;
+
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 * Allow 1% tolerance at the upper limit so uart clks marginally
-- 
2.25.1


