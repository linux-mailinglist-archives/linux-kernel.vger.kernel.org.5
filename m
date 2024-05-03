Return-Path: <linux-kernel+bounces-167964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA108BB1AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516AE1C22C83
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36915158D7B;
	Fri,  3 May 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTPJD5uS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078501586C3;
	Fri,  3 May 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756787; cv=none; b=hxmg7G5oO+AvPhpqESqiBIT0fBsDor93RrCqHLZfKRWI7x9aiD/5EQI8SOfYdgbx3PgAPwYwn+t0+OeXrutXc3/uvbp9UHca8DV3GgeuYd+kkj9ROn8va82iY/CXnVINyg3ZgZQxCrFSMy8ExDr1l/nCp/GAGF/fBZg2Bp1Y2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756787; c=relaxed/simple;
	bh=lcpyqo/kIZ8bG16xlC0SZOBkBwextMe9kvhdGFvCZgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLo6jfoP2b+gjMKaoClX1yYkHs5j30fsZBc4U7loTszY/cDdSzY7G54DEUg47B+KAnk7ZH8NxdvJyVnKWaAWVIYfUpiCmGQ5QtDCOuaE/hJZtI/uGaP9CZTlfTvZVWZx/YEFDYL3v/Bnu1XgIAHZfgvVNBBE8xA+m2fmQ/vbJtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTPJD5uS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756785; x=1746292785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lcpyqo/kIZ8bG16xlC0SZOBkBwextMe9kvhdGFvCZgI=;
  b=kTPJD5uSjJDaxkTOG+ZpcGVMZ789pdj3w0lH+PtFPp7y9IrQ8C6OfCOP
   +/kAejbQW1W0RhTw9axMqoD0ZPVkd9tSsTqfb3Z+31NK5kOlPUpwJwvTq
   8tLAxhu+6a8WH9EL1YWYQbbC74qgJpE1UMKtsLUcIqpPwmvmCtBz+pkgi
   4nc7t2oeLrP8bnvtKn9GqiLoL8okfeZFx997r/xlNidJjuolP7w+zdCXe
   KtuSf2+kA/wsYPQIugZDuUBQI2vNXMS/Mi+4uXfqott34A8FtHd6JRFm2
   DPQoDloXEePJSLTCaSU08bfvGUtEjh+5W3OCQG7w2ZRRL9i2xqz5Uocf2
   Q==;
X-CSE-ConnectionGUID: +8eOfZ4BTYiR/x0QK7LDOA==
X-CSE-MsgGUID: XRweAGkuRrWif1pMnZl1bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="11107813"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="11107813"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:19:44 -0700
X-CSE-ConnectionGUID: JFEUDPVcRUOnQUsleNNKeA==
X-CSE-MsgGUID: 8++WEltPRQy99xJDxy4cxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="58415425"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 03 May 2024 10:19:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 831D4713; Fri,  3 May 2024 20:19:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 09/13] serial: 8250_exar: Return directly from switch-cases
Date: Fri,  3 May 2024 20:16:01 +0300
Message-ID: <20240503171917.2921250-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two similar switch-cases which use different style.
Unify them and one more to return from the cases directly.

While at it, add missing default in another switch-case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 80 +++++++++++------------------
 1 file changed, 29 insertions(+), 51 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 1f04d4562878..51f6af16c557 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -627,6 +627,8 @@ pci_fastcom335_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		writeb(0xc0, p + UART_EXAR_MPIOINV_7_0);
 		writeb(0xc0, p + UART_EXAR_MPIOSEL_7_0);
 		break;
+	default:
+		break;
 	}
 	writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
 	writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
@@ -723,8 +725,6 @@ static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar8250 *p
 							struct pci_dev *pcidev,
 							unsigned int port_num)
 {
-	enum cti_port_type port_type;
-
 	switch (pcidev->subsystem_device) {
 	// RS232 only cards
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232:
@@ -734,24 +734,17 @@ static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar8250 *p
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS:
-		port_type = CTI_PORT_TYPE_RS232;
-		break;
+		return CTI_PORT_TYPE_RS232;
 	// 1x RS232, 1x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
-		port_type = (port_num == 0) ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
-		break;
+		return (port_num == 0) ? CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
 	// 2x RS232, 2x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2:
-		port_type = (port_num < 2) ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
-		break;
+		return (port_num < 2) ? CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
 	// 4x RS232, 4x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
-		port_type = (port_num < 4) ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
-		break;
+		return (port_num < 4) ? CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
 	// RS232/RS422/RS485 HW (jumper) selectable
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4:
@@ -774,32 +767,24 @@ static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar8250 *p
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
-		port_type = CTI_PORT_TYPE_RS232_422_485_HW;
-		break;
+		return CTI_PORT_TYPE_RS232_422_485_HW;
 	// RS422/RS485 HW (jumper) selectable
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_485:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_485:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_485:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
-		port_type = CTI_PORT_TYPE_RS422_485;
-		break;
+		return CTI_PORT_TYPE_RS422_485;
 	// 6x RS232, 2x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
-		port_type = (port_num < 6) ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
-		break;
+		return (port_num < 6) ? CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
 	// 2x RS232, 6x RS422/RS485
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
-		port_type = (port_num < 2) ?
-			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
-		break;
+		return (port_num < 2) ? CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
 	default:
 		dev_err(&pcidev->dev, "unknown/unsupported device\n");
-		port_type = CTI_PORT_TYPE_NONE;
+		return CTI_PORT_TYPE_NONE;
 	}
-
-	return port_type;
 }
 
 /**
@@ -816,20 +801,15 @@ static enum cti_port_type cti_get_port_type_fpga(struct exar8250 *priv,
 						struct pci_dev *pcidev,
 						unsigned int port_num)
 {
-	enum cti_port_type port_type;
-
 	switch (pcidev->device) {
 	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
 	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
 	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
-		port_type = CTI_PORT_TYPE_RS232_422_485_HW;
-		break;
+		return CTI_PORT_TYPE_RS232_422_485_HW;
 	default:
 		dev_err(&pcidev->dev, "unknown/unsupported device\n");
 		return CTI_PORT_TYPE_NONE;
 	}
-
-	return port_type;
 }
 
 /**
@@ -1493,35 +1473,33 @@ static irqreturn_t exar_misc_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static unsigned int exar_get_nr_ports(struct exar8250_board *board,
-					struct pci_dev *pcidev)
+static unsigned int exar_get_nr_ports(struct exar8250_board *board, struct pci_dev *pcidev)
 {
-	unsigned int nr_ports = 0;
+	if (pcidev->vendor == PCI_VENDOR_ID_ACCESSIO)
+		return BIT(((pcidev->device & 0x38) >> 3) - 1);
 
-	if (pcidev->vendor == PCI_VENDOR_ID_ACCESSIO) {
-		nr_ports = BIT(((pcidev->device & 0x38) >> 3) - 1);
-	} else if (board->num_ports > 0) {
-		// Check if board struct overrides number of ports
-		nr_ports = board->num_ports;
-	} else if (pcidev->vendor == PCI_VENDOR_ID_EXAR) {
-		// Exar encodes # ports in last nibble of PCI Device ID ex. 0358
-		nr_ports = pcidev->device & 0x0f;
-	} else  if (pcidev->vendor == PCI_VENDOR_ID_CONNECT_TECH) {
-		// Handle CTI FPGA cards
+	// Check if board struct overrides number of ports
+	if (board->num_ports > 0)
+		return board->num_ports;
+
+	// Exar encodes # ports in last nibble of PCI Device ID ex. 0358
+	if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
+		return pcidev->device & 0x0f;
+
+	// Handle CTI FPGA cards
+	if (pcidev->vendor == PCI_VENDOR_ID_CONNECT_TECH) {
 		switch (pcidev->device) {
 		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
 		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
-			nr_ports = 12;
-			break;
+			return 12;
 		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
-			nr_ports = 16;
-			break;
+			return 16;
 		default:
-			break;
+			return 0;
 		}
 	}
 
-	return nr_ports;
+	return 0;
 }
 
 static int
-- 
2.43.0.rc1.1336.g36b5255a03ac


