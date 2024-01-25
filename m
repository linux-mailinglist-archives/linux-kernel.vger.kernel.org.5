Return-Path: <linux-kernel+bounces-38353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0371A83BE38
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DE41F255B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05641C6B5;
	Thu, 25 Jan 2024 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VvEyrU92"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C71C686;
	Thu, 25 Jan 2024 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176949; cv=none; b=GcHimR7tXEasaTWUOxaJ5NUVLYQXqGOdpXDZ1J9Xeg466YDM12q8PYsGLzgT7aqLYLknuUJ9nekO/STpUfK78N+MUWyxzucHGq9bv/ILUibfLxtfTQSgo3xHzqLPe4upb55qr1oiT4F4bnSUsg0lB7+dhXsEAYGdf8XytJOSAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176949; c=relaxed/simple;
	bh=Tv1+9k+cs9ODrgYL0DhM6PbCDNkcFvwIQHm8qIIPFOw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pHqX3409f/4AvmVqyV8jipOnFkTOw2dP3nRRha7iAfzGXYV9x1RCZOmKQbb0ISUZ+hHlSC+0ivFF2bIVpLnaEBb5awGlGQyi8pLQf1gvsAio7bc6yB+hhkBozuhrTq1vN5OtrFoQtW7CTXS/JGLgUnnpQnuoRlVcx1kwheMX8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VvEyrU92; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706176948; x=1737712948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tv1+9k+cs9ODrgYL0DhM6PbCDNkcFvwIQHm8qIIPFOw=;
  b=VvEyrU92g4QY0st1jN98VMuuShbvLKQy/YQAEsT6yP4XLhZ0pWBhQBJd
   zhge5HH6Vac+PCMmOK1bxgyAJQN5vS7xM+G+kZz3oUIfP0YwtlmhPsSn7
   lUVdckmnVfBX5VLPv2TQsoercLw6UxxmPAwtN8611ykrB/APVSM8GyFMs
   3zTUQuvVhLMmyHccxWtxugkv7KsDo5pPxFyrqCj+7KQvLxxmWrX4/JFQl
   7mTjuGbymJ31VJD9+lb31+xb90+WYmL9TAX3CXB3aKkdZjkHPDjnhtnMf
   583N22J5dQTWClrELdQCjxx52X+FsFrAGBOzvPZFWdyQQlGrkCFVvlS7h
   w==;
X-CSE-ConnectionGUID: EcHPnxniQdWGuWl+Gd9iBA==
X-CSE-MsgGUID: cPjp1T7gRbWSaY+EDV2BEQ==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="scan'208";a="245997251"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 03:02:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 03:01:56 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 03:01:53 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <UNGLinuxDriver@microchip.com>
Subject: [PATCH v1 tty] 8250: microchip: pci1xxxx: Add Burst mode transmission support in uart driver for reading from FIFO
Date: Thu, 25 Jan 2024 15:30:06 +0530
Message-ID: <20240125100006.153342-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

pci1xxxx_handle_irq reads the burst status and checks if the FIFO
is empty and is ready to accept the incoming data. The handling is
done in pci1xxxx_tx_burst where each transaction processes data in
block of DWORDs, while any remaining bytes are processed individually,
one byte at a time.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 106 ++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index 558c4c7f3104..d53605bf908d 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -67,6 +67,7 @@
 #define SYSLOCK_RETRY_CNT			1000
 
 #define UART_RX_BYTE_FIFO			0x00
+#define UART_TX_BYTE_FIFO			0x00
 #define UART_FIFO_CTL				0x02
 
 #define UART_ACTV_REG				0x11
@@ -100,6 +101,7 @@
 #define UART_RESET_D3_RESET_DISABLE		BIT(16)
 
 #define UART_BURST_STATUS_REG			0x9C
+#define UART_TX_BURST_FIFO			0xA0
 #define UART_RX_BURST_FIFO			0xA4
 
 #define MAX_PORTS				4
@@ -109,6 +111,7 @@
 #define UART_BURST_SIZE				4
 
 #define UART_BST_STAT_RX_COUNT_MASK		0x00FF
+#define UART_BST_STAT_TX_COUNT_MASK		0xFF00
 #define UART_BST_STAT_IIR_INT_PEND		0x100000
 #define UART_LSR_OVERRUN_ERR_CLR		0x43
 #define UART_BST_STAT_LSR_RX_MASK		0x9F000000
@@ -116,6 +119,7 @@
 #define UART_BST_STAT_LSR_OVERRUN_ERR		0x2000000
 #define UART_BST_STAT_LSR_PARITY_ERR		0x4000000
 #define UART_BST_STAT_LSR_FRAME_ERR		0x8000000
+#define UART_BST_STAT_LSR_THRE			0x20000000
 
 struct pci1xxxx_8250 {
 	unsigned int nr;
@@ -344,6 +348,105 @@ static void pci1xxxx_rx_burst(struct uart_port *port, u32 uart_status)
 	}
 }
 
+static void pci1xxxx_process_write_data(struct uart_port *port,
+					struct circ_buf *xmit,
+					int *data_empty_count,
+					u32 *valid_byte_count)
+{
+	u32 valid_burst_count = *valid_byte_count / UART_BURST_SIZE;
+
+	/*
+	 * Each transaction transfers data in DWORDs. If there are less than
+	 * four remaining valid_byte_count to transfer or if the circular
+	 * buffer has insufficient space for a DWORD, the data is transferred
+	 * one byte at a time.
+	 */
+	while (valid_burst_count) {
+		if (*data_empty_count - UART_BURST_SIZE < 0)
+			break;
+		if (xmit->tail > (UART_XMIT_SIZE - UART_BURST_SIZE))
+			break;
+		writel(*(unsigned int *)&xmit->buf[xmit->tail],
+		       port->membase + UART_TX_BURST_FIFO);
+		*valid_byte_count -= UART_BURST_SIZE;
+		*data_empty_count -= UART_BURST_SIZE;
+		valid_burst_count -= UART_BYTE_SIZE;
+
+		xmit->tail = (xmit->tail + UART_BURST_SIZE) &
+			     (UART_XMIT_SIZE - 1);
+	}
+
+	while (*valid_byte_count) {
+		if (*data_empty_count - UART_BYTE_SIZE < 0)
+			break;
+		writeb(xmit->buf[xmit->tail], port->membase +
+		       UART_TX_BYTE_FIFO);
+		*data_empty_count -= UART_BYTE_SIZE;
+		*valid_byte_count -= UART_BYTE_SIZE;
+
+		/*
+		 * When the tail of the circular buffer is reached, the next
+		 * byte is transferred to the beginning of the buffer.
+		 */
+		xmit->tail = (xmit->tail + UART_BYTE_SIZE) &
+			     (UART_XMIT_SIZE - 1);
+
+		/*
+		 * If there are any pending burst count, data is handled by
+		 * transmitting DWORDs at a time.
+		 */
+		if (valid_burst_count && (xmit->tail <
+		   (UART_XMIT_SIZE - UART_BURST_SIZE)))
+			break;
+	}
+}
+
+static void pci1xxxx_tx_burst(struct uart_port *port, u32 uart_status)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	u32 valid_byte_count;
+	int data_empty_count;
+	struct circ_buf *xmit;
+
+	xmit = &port->state->xmit;
+
+	if (port->x_char) {
+		writeb(port->x_char, port->membase + UART_TX);
+		port->icount.tx++;
+		port->x_char = 0;
+		return;
+	}
+
+	if ((uart_tx_stopped(port)) || (uart_circ_empty(xmit))) {
+		port->ops->stop_tx(port);
+	} else {
+		data_empty_count = (pci1xxxx_read_burst_status(port) &
+				    UART_BST_STAT_TX_COUNT_MASK) >> 8;
+		do {
+			valid_byte_count = uart_circ_chars_pending(xmit);
+
+			pci1xxxx_process_write_data(port, xmit,
+						    &data_empty_count,
+						    &valid_byte_count);
+
+			port->icount.tx++;
+			if (uart_circ_empty(xmit))
+				break;
+		} while (data_empty_count && valid_byte_count);
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	 /*
+	  * With RPM enabled, we have to wait until the FIFO is empty before
+	  * the HW can go idle. So we get here once again with empty FIFO and
+	  * disable the interrupt and RPM in __stop_tx()
+	  */
+	if (uart_circ_empty(xmit) && !(up->capabilities & UART_CAP_RPM))
+		port->ops->stop_tx(port);
+}
+
 static int pci1xxxx_handle_irq(struct uart_port *port)
 {
 	unsigned long flags;
@@ -359,6 +462,9 @@ static int pci1xxxx_handle_irq(struct uart_port *port)
 	if (status & UART_BST_STAT_LSR_RX_MASK)
 		pci1xxxx_rx_burst(port, status);
 
+	if (status & UART_BST_STAT_LSR_THRE)
+		pci1xxxx_tx_burst(port, status);
+
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	return 1;
-- 
2.25.1


