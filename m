Return-Path: <linux-kernel+bounces-167966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DD78BB1B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193DC286BCB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32932158DBE;
	Fri,  3 May 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XT6mUd65"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F456158853;
	Fri,  3 May 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756788; cv=none; b=h+NuEtxjLaZ0mQKeDtil2pOkwChPDpQK5XL4YAPufaN8oA7Q++qZmXBMgg6vJy8hn0ZYbGgw5PQjmPPsCwCWTei1hABy/iIJ2aEqFGZWvFXMAl9HVQY9jtfZv+dhjqxYKjlHGBJ2wtEzfdxPyjqnvu4P7kBXbLy/nTiFVTGU0Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756788; c=relaxed/simple;
	bh=0P8W5/r5S5k6SwXf7VCCJC2Qrhne6InBiWz5NUC6oPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuVYL9XlV7LeEBI7hCjOMSfu5GQJJfawb/Foa60GcRaftgQxEAyZptx1VeZP8E3wMTwsyv0164BOIDj+mLSQu5RmxlocdVUIfsIHLLOJ3q4fWgfqFJlFezDXffufz5qM5dnwEguXelxS2oJe97QM8Hew3yke4vb++7EsHrK1lrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XT6mUd65; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756785; x=1746292785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0P8W5/r5S5k6SwXf7VCCJC2Qrhne6InBiWz5NUC6oPI=;
  b=XT6mUd654wiUQ4Bq6uOrr9wsmOdImXThpaztTL/RlDlZEu0CZfGTg8gl
   eTYGZuePM6CYUJXC8sWAJ8QFRhtyo5puZ7xrDd/mpvCcA22JtWRzhTutH
   ocMgFoaAxZDgybcGJVANu50+r96yp4uyhZj3gnnQzGRzYcIbHZr2M0VOP
   lUYiYg6TbpfAPquZgqbhjVSZtjGug4JLKdlaRoS95u/RJ739klGza6Uxr
   i6VVXOIIzX3WQA16VwGAvt9rDI6zpRfA3joms4hYXZfKFDnJlWf5XUXOY
   tcmM/IBowg4ORfsE0imXfAozDvBudrEEoxwpvPB9WrX2gbhrs5ryQAI/C
   Q==;
X-CSE-ConnectionGUID: e6aR1tFZSK6ES7ORgJJS/w==
X-CSE-MsgGUID: 9hq/X+e4SISmHqtSFz/JeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="35962105"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="35962105"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:19:44 -0700
X-CSE-ConnectionGUID: VRw+1/qcSJafBnw+I0soJw==
X-CSE-MsgGUID: cbpKREC1TyGqC+jHb26UvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28098215"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 03 May 2024 10:19:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7521F48B; Fri,  3 May 2024 20:19:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 08/13] serial: 8250_exar: Decrease indentation level
Date: Fri,  3 May 2024 20:16:00 +0300
Message-ID: <20240503171917.2921250-9-andriy.shevchenko@linux.intel.com>
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

Decrease indentation level in some places.
No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 100 ++++++++++++++--------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 4e683ca76de0..1f04d4562878 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -607,28 +607,30 @@ pci_fastcom335_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 	writeb(32, p + UART_EXAR_TXTRG);
 	writeb(32, p + UART_EXAR_RXTRG);
 
+	/* Skip the initial (per device) setup */
+	if (idx)
+		return 0;
+
 	/*
 	 * Setup Multipurpose Input/Output pins.
 	 */
-	if (idx == 0) {
-		switch (pcidev->device) {
-		case PCI_DEVICE_ID_COMMTECH_4222PCI335:
-		case PCI_DEVICE_ID_COMMTECH_4224PCI335:
-			writeb(0x78, p + UART_EXAR_MPIOLVL_7_0);
-			writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
-			writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
-			break;
-		case PCI_DEVICE_ID_COMMTECH_2324PCI335:
-		case PCI_DEVICE_ID_COMMTECH_2328PCI335:
-			writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
-			writeb(0xc0, p + UART_EXAR_MPIOINV_7_0);
-			writeb(0xc0, p + UART_EXAR_MPIOSEL_7_0);
-			break;
-		}
-		writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
-		writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
-		writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
+	switch (pcidev->device) {
+	case PCI_DEVICE_ID_COMMTECH_4222PCI335:
+	case PCI_DEVICE_ID_COMMTECH_4224PCI335:
+		writeb(0x78, p + UART_EXAR_MPIOLVL_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
+		break;
+	case PCI_DEVICE_ID_COMMTECH_2324PCI335:
+	case PCI_DEVICE_ID_COMMTECH_2328PCI335:
+		writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
+		writeb(0xc0, p + UART_EXAR_MPIOINV_7_0);
+		writeb(0xc0, p + UART_EXAR_MPIOSEL_7_0);
+		break;
 	}
+	writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
+	writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
+	writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
 
 	return 0;
 }
@@ -853,21 +855,19 @@ static enum cti_port_type cti_get_port_type_xr17v35x(struct exar8250 *priv,
 	port_flags = exar_ee_read(priv, offset);
 
 	port_type = FIELD_GET(CTI_EE_MASK_PORT_FLAGS_TYPE, port_flags);
-	if (!CTI_PORT_TYPE_VALID(port_type)) {
-		/*
-		 * If the port type is missing the card assume it is a
-		 * RS232/RS422/RS485 card to be safe.
-		 *
-		 * There is one known board (BEG013) that only has
-		 * 3 of 4 port types written to the EEPROM so this
-		 * acts as a work around.
-		 */
-		dev_warn(&pcidev->dev,
-			"failed to get port %d type from EEPROM\n", port_num);
-		port_type = CTI_PORT_TYPE_RS232_422_485_HW;
-	}
+	if (CTI_PORT_TYPE_VALID(port_type))
+		return port_type;
 
-	return port_type;
+	/*
+	 * If the port type is missing the card assume it is a
+	 * RS232/RS422/RS485 card to be safe.
+	 *
+	 * There is one known board (BEG013) that only has 3 of 4 port types
+	 * written to the EEPROM so this acts as a work around.
+	 */
+	dev_warn(&pcidev->dev, "failed to get port %d type from EEPROM\n", port_num);
+
+	return CTI_PORT_TYPE_RS232_422_485_HW;
 }
 
 static int cti_rs485_config_mpio_tristate(struct uart_port *port,
@@ -1190,11 +1190,10 @@ static void setup_gpio(struct pci_dev *pcidev, u8 __iomem *p)
 	 * devices will export them as GPIOs, so we pre-configure them safely
 	 * as inputs.
 	 */
-
 	u8 dir = 0x00;
 
 	if  ((pcidev->vendor == PCI_VENDOR_ID_EXAR) &&
-		(pcidev->subsystem_vendor != PCI_VENDOR_ID_SEALEVEL)) {
+	     (pcidev->subsystem_vendor != PCI_VENDOR_ID_SEALEVEL)) {
 		// Configure GPIO as inputs for Commtech adapters
 		dir = 0xff;
 	} else {
@@ -1284,27 +1283,28 @@ static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termio
 	if (ret)
 		return ret;
 
-	if (rs485->flags & SER_RS485_ENABLED) {
-		old_lcr = readb(p + UART_LCR);
+	if (!(rs485->flags & SER_RS485_ENABLED))
+		return 0;
 
-		/* Set EFR[4]=1 to enable enhanced feature registers */
-		efr = readb(p + UART_XR_EFR);
-		efr |= UART_EFR_ECB;
-		writeb(efr, p + UART_XR_EFR);
+	old_lcr = readb(p + UART_LCR);
 
-		/* Set MCR to use DTR as Auto-RS485 Enable signal */
-		writeb(UART_MCR_OUT1, p + UART_MCR);
+	/* Set EFR[4]=1 to enable enhanced feature registers */
+	efr = readb(p + UART_XR_EFR);
+	efr |= UART_EFR_ECB;
+	writeb(efr, p + UART_XR_EFR);
 
-		/* Set LCR[7]=1 to enable access to DLD register */
-		writeb(old_lcr | UART_LCR_DLAB, p + UART_LCR);
+	/* Set MCR to use DTR as Auto-RS485 Enable signal */
+	writeb(UART_MCR_OUT1, p + UART_MCR);
 
-		/* Set DLD[7]=1 for inverted RS485 Enable logic */
-		dld = readb(p + UART_EXAR_DLD);
-		dld |= UART_EXAR_DLD_485_POLARITY;
-		writeb(dld, p + UART_EXAR_DLD);
+	/* Set LCR[7]=1 to enable access to DLD register */
+	writeb(old_lcr | UART_LCR_DLAB, p + UART_LCR);
 
-		writeb(old_lcr, p + UART_LCR);
-	}
+	/* Set DLD[7]=1 for inverted RS485 Enable logic */
+	dld = readb(p + UART_EXAR_DLD);
+	dld |= UART_EXAR_DLD_485_POLARITY;
+	writeb(dld, p + UART_EXAR_DLD);
+
+	writeb(old_lcr, p + UART_LCR);
 
 	return 0;
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac


