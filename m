Return-Path: <linux-kernel+bounces-76640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDF285FA5E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1181DB29E74
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7114A097;
	Thu, 22 Feb 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g9IdMt7h"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1F1487FA;
	Thu, 22 Feb 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609953; cv=none; b=QiLAML+8OjIEHFIoPA7WV8hYXrYdq24NUQrp1wxZJnU52eZnYoepJWJqkfcRGo+aKRGKeAur/UyCIqfburJVBnUQpr9azOOX2ZUZunmi+XOkPtd2lVb4fy3rjdmMS4a4aLNLUt/aeNJ02x/0yQ61IAloSKDHtmVqnloMR+jx4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609953; c=relaxed/simple;
	bh=IzJkKWwTvYMWgJmqreb1lep+2WnW6qA832pfbNZn5ws=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IbDfzfRWdy9Jix16EOlQbgBdzZt3h5gAuq+L3RDGxmqbzE6Oa5CuI7TTKQoXPhGwA8tTTz0/w7a55n4qwOvJaR+Y69XFQ6csMm+KVXc4oWDo/fHI8zrTn0IgiGpAGmAFJGOwDCEKEQZQQ/yt0KGT90iji5GhIBPZsUbfxD8ZvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=g9IdMt7h; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708609951; x=1740145951;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IzJkKWwTvYMWgJmqreb1lep+2WnW6qA832pfbNZn5ws=;
  b=g9IdMt7hShkUpGBHjDT0xqX8Ebo7pewxMCAKE/VF9S1acEi3eSjMsD3z
   JcnARzM22mXtToZ3BXl5B7Mkh2u2dyE6dUDOfFMk324qm1IeGvd7R9Gjt
   bK0gtgDzZj33JvQxiDPIlQOtJQSbTnLXjmxvDFsNYDl7PeaWO+9QOxw91
   nZC6gnBw1tUKjIuhqgGvPHVbjvegjd6qdtn9hRB/wWyH3ff1UQWK2ME4U
   LNXiVxSTZ4etku9E+ntUQOtHHsinjInDIIRFSakQ+szikVNXYaxfSorcg
   RxD5gnFI0UNhAd9lyvZ2sAk8O3sePolgRe0cPMvxanlRZBs87zcYKNLUD
   Q==;
X-CSE-ConnectionGUID: 1g9PJo2cQYm6idtRWmCp+g==
X-CSE-MsgGUID: 1gv/w4ieQJC6rO5afeWlOQ==
X-IronPort-AV: E=Sophos;i="6.06,177,1705388400"; 
   d="scan'208";a="16659544"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2024 06:52:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 06:51:49 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 06:51:46 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <unglinuxdriver@microchip.com>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code to use pre-existing APIs
Date: Thu, 22 Feb 2024 19:19:44 +0530
Message-ID: <20240222134944.1131952-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Updated the TX Burst implementation by changing the circular buffer
processing with the pre-existing APIs in kernel. Also updated conditional
statements and alignment issues for better readability.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 39 ++++++++++++-------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index 6cfeba058dba..84e0a0725f41 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -374,7 +374,7 @@ static void pci1xxxx_rx_burst(struct uart_port *port, u32 uart_status)
 
 static void pci1xxxx_process_write_data(struct uart_port *port,
 					struct circ_buf *xmit,
-					int *data_empty_count,
+					u32 *data_empty_count,
 					u32 *valid_byte_count)
 {
 	u32 valid_burst_count = *valid_byte_count / UART_BURST_SIZE;
@@ -386,22 +386,24 @@ static void pci1xxxx_process_write_data(struct uart_port *port,
 	 * one byte at a time.
 	 */
 	while (valid_burst_count) {
-		if (*data_empty_count - UART_BURST_SIZE < 0)
+		if (*data_empty_count < UART_BURST_SIZE)
 			break;
-		if (xmit->tail > (UART_XMIT_SIZE - UART_BURST_SIZE))
+
+		if (CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE) <
+		    UART_BURST_SIZE)
 			break;
-		writel(*(unsigned int *)&xmit->buf[xmit->tail],
+
+		writel(*(u32 *)&xmit->buf[xmit->tail],
 		       port->membase + UART_TX_BURST_FIFO);
 		*valid_byte_count -= UART_BURST_SIZE;
 		*data_empty_count -= UART_BURST_SIZE;
 		valid_burst_count -= UART_BYTE_SIZE;
 
-		xmit->tail = (xmit->tail + UART_BURST_SIZE) &
-			     (UART_XMIT_SIZE - 1);
+		uart_xmit_advance(port, UART_BURST_SIZE);
 	}
 
 	while (*valid_byte_count) {
-		if (*data_empty_count - UART_BYTE_SIZE < 0)
+		if (*data_empty_count < UART_BYTE_SIZE)
 			break;
 		writeb(xmit->buf[xmit->tail], port->membase +
 		       UART_TX_BYTE_FIFO);
@@ -412,8 +414,7 @@ static void pci1xxxx_process_write_data(struct uart_port *port,
 		 * When the tail of the circular buffer is reached, the next
 		 * byte is transferred to the beginning of the buffer.
 		 */
-		xmit->tail = (xmit->tail + UART_BYTE_SIZE) &
-			     (UART_XMIT_SIZE - 1);
+		uart_xmit_advance(port, UART_BYTE_SIZE);
 
 		/*
 		 * If there are any pending burst count, data is handled by
@@ -434,16 +435,7 @@ static void pci1xxxx_tx_burst(struct uart_port *port, u32 uart_status)
 
 	xmit = &port->state->xmit;
 
-	if (port->x_char) {
-		writeb(port->x_char, port->membase + UART_TX);
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-
-	if ((uart_tx_stopped(port)) || (uart_circ_empty(xmit))) {
-		port->ops->stop_tx(port);
-	} else {
+	if (!(port->x_char)) {
 		data_empty_count = (pci1xxxx_read_burst_status(port) &
 				    UART_BST_STAT_TX_COUNT_MASK) >> 8;
 		do {
@@ -453,15 +445,22 @@ static void pci1xxxx_tx_burst(struct uart_port *port, u32 uart_status)
 						    &data_empty_count,
 						    &valid_byte_count);
 
-			port->icount.tx++;
 			if (uart_circ_empty(xmit))
 				break;
 		} while (data_empty_count && valid_byte_count);
+	} else {
+		writeb(port->x_char, port->membase + UART_TX);
+		port->icount.tx++;
+		port->x_char = 0;
+		return;
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
+	if ((uart_tx_stopped(port)) || (uart_circ_empty(xmit)))
+		port->ops->stop_tx(port);
+
 	 /*
 	  * With RPM enabled, we have to wait until the FIFO is empty before
 	  * the HW can go idle. So we get here once again with empty FIFO and
-- 
2.25.1


