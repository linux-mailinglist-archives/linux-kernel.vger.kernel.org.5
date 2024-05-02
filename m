Return-Path: <linux-kernel+bounces-166591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5B28B9CC2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074AB1F24211
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580DC15B13F;
	Thu,  2 May 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILNUOo1r"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DB5155340;
	Thu,  2 May 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661203; cv=none; b=hHpRcpCfe83KLaDNx1m/fDgflK69DWpA27leuZl58GkUL0kz/AnINfItfocsOXla4dZ7z1JFA8pGeaBVWigZ5avdqXkGg8Rpmhk3vGEPTV56d3r/NvTP/P+cmuPGI+jfabjzSum85+06JfmwbKz3ZZIwlKd6zcddfj41dA2DhWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661203; c=relaxed/simple;
	bh=t7c+p4jpADujsd+7SJ8cKecOyJnSYgDmtGkvtDrO4RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9hqyv1U9QsTUDr8nkgwa87FImhKyt3Zt9EuzA/o4eSmMfBxZqFdHuQl2uCw/h2RLPici5Ei5fC/etD8gqmnE24YEPnyRo9fhVcNvwokah04SJrmh3gCp6e2J6G9qPUGYf+9ZNc58VMxWketyPXNtkAmbfobxD85Y/SWFTA12Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILNUOo1r; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714661202; x=1746197202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7c+p4jpADujsd+7SJ8cKecOyJnSYgDmtGkvtDrO4RE=;
  b=ILNUOo1r4yp7MPCg0rOXPfrbsgcX+TGbP+PXdf6dSnb+UuE0WGS7QeQe
   COuLAUVvL2Ei7oVi6Sv5azasjKVSSXGfWBStMFfwZ/hftoQn7PjhSqgtL
   dZEJ2+EcWuZQB+G15CV1rnh0QOo6ZvEVy9E3o4Zk1+RtCV23HlpZjZoOo
   09JsnNxeQl8/Dd8/6KY5HSt2kUsjfBmiByoNB/jWrPRPKvvYTkB4d38Nu
   ZE9o5aFblSz/BAcvcDh4FvuxltQnvpDKQ/N070DW1wWdggU+LKyYttlsP
   ZguPL7ijEXPIdXJX9w3tufd4KVi1OIIgoJ33CYpLJqcGTLB9YCEVxU4U1
   A==;
X-CSE-ConnectionGUID: yCSM5PVPT6aZfyO7DEMKiA==
X-CSE-MsgGUID: Gp4Z4xP1QgyO0jPdZ6iCRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10306101"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10306101"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 07:46:36 -0700
X-CSE-ConnectionGUID: WWNSwq7zRQ+GYX9GIrSUHQ==
X-CSE-MsgGUID: ymqFtbLvRBmDHxrPJrkCug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31632844"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 02 May 2024 07:46:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 257A960A; Thu,  2 May 2024 17:46:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 07/13] serial: 8250_exar: Kill unneeded ->board_init()
Date: Thu,  2 May 2024 17:44:01 +0300
Message-ID: <20240502144626.2716994-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We may reuse ->setup() for the same purpose as it was done before.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 171 +++++++++++++---------------
 1 file changed, 81 insertions(+), 90 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 956323e2de4a..4e683ca76de0 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -237,14 +237,12 @@ struct exar8250_platform {
  * struct exar8250_board - board information
  * @num_ports: number of serial ports
  * @reg_shift: describes UART register mapping in PCI memory
- * @board_init: quirk run once at ->probe() stage before setting up ports
  * @setup: quirk run at ->probe() stage for each port
  * @exit: quirk run at ->remove() stage
  */
 struct exar8250_board {
 	unsigned int num_ports;
 	unsigned int reg_shift;
-	int     (*board_init)(struct exar8250 *priv, struct pci_dev *pcidev);
 	int	(*setup)(struct exar8250 *priv, struct pci_dev *pcidev,
 			 struct uart_8250_port *port, int idx);
 	void	(*exit)(struct pci_dev *pcidev);
@@ -907,9 +905,6 @@ static int cti_port_setup_common(struct exar8250 *priv,
 {
 	int ret;
 
-	if (priv->osc_freq == 0)
-		return -EINVAL;
-
 	port->port.port_id = idx;
 	port->port.uartclk = priv->osc_freq;
 
@@ -927,6 +922,30 @@ static int cti_port_setup_common(struct exar8250 *priv,
 	return 0;
 }
 
+static int cti_board_init_fpga(struct exar8250 *priv, struct pci_dev *pcidev)
+{
+	int ret;
+	u16 cfg_val;
+
+	// FPGA OSC is fixed to the 33MHz PCI clock
+	priv->osc_freq = CTI_DEFAULT_FPGA_OSC_FREQ;
+
+	// Enable external interrupts in special cfg space register
+	ret = pci_read_config_word(pcidev, CTI_FPGA_CFG_INT_EN_REG, &cfg_val);
+	if (ret)
+		return pcibios_err_to_errno(ret);
+
+	cfg_val |= CTI_FPGA_CFG_INT_EN_EXT_BIT;
+	ret = pci_write_config_word(pcidev, CTI_FPGA_CFG_INT_EN_REG, cfg_val);
+	if (ret)
+		return pcibios_err_to_errno(ret);
+
+	// RS485 gate needs to be enabled; otherwise RTS/CTS will not work
+	exar_write_reg(priv, CTI_FPGA_RS485_IO_REG, 0x01);
+
+	return 0;
+}
+
 static int cti_port_setup_fpga(struct exar8250 *priv,
 				struct pci_dev *pcidev,
 				struct uart_8250_port *port,
@@ -934,6 +953,13 @@ static int cti_port_setup_fpga(struct exar8250 *priv,
 {
 	enum cti_port_type port_type;
 	unsigned int offset;
+	int ret;
+
+	if (idx == 0) {
+		ret = cti_board_init_fpga(priv, pcidev);
+		if (ret)
+			return ret;
+	}
 
 	port_type = cti_get_port_type_fpga(priv, pcidev, idx);
 
@@ -953,6 +979,12 @@ static int cti_port_setup_fpga(struct exar8250 *priv,
 	return cti_port_setup_common(priv, pcidev, idx, offset, port);
 }
 
+static void cti_board_init_xr17v35x(struct exar8250 *priv, struct pci_dev *pcidev)
+{
+	// XR17V35X uses the PCIe clock rather than an oscillator
+	priv->osc_freq = CTI_DEFAULT_PCIE_OSC_FREQ;
+}
+
 static int cti_port_setup_xr17v35x(struct exar8250 *priv,
 				struct pci_dev *pcidev,
 				struct uart_8250_port *port,
@@ -962,6 +994,9 @@ static int cti_port_setup_xr17v35x(struct exar8250 *priv,
 	unsigned int offset;
 	int ret;
 
+	if (idx == 0)
+		cti_board_init_xr17v35x(priv, pcidev);
+
 	port_type = cti_get_port_type_xr17v35x(priv, pcidev, idx);
 
 	offset = idx * UART_EXAR_XR17V35X_PORT_OFFSET;
@@ -999,6 +1034,22 @@ static int cti_port_setup_xr17v35x(struct exar8250 *priv,
 	return 0;
 }
 
+static void cti_board_init_xr17v25x(struct exar8250 *priv, struct pci_dev *pcidev)
+{
+	cti_board_init_osc_freq(priv, pcidev, CTI_EE_OFF_XR17V25X_OSC_FREQ);
+
+	/* enable interrupts on cards that need the "PLX fix" */
+	switch (pcidev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
+		cti_plx_int_enable(priv);
+		break;
+	default:
+		break;
+	}
+}
+
 static int cti_port_setup_xr17v25x(struct exar8250 *priv,
 				struct pci_dev *pcidev,
 				struct uart_8250_port *port,
@@ -1008,6 +1059,9 @@ static int cti_port_setup_xr17v25x(struct exar8250 *priv,
 	unsigned int offset;
 	int ret;
 
+	if (idx == 0)
+		cti_board_init_xr17v25x(priv, pcidev);
+
 	port_type = cti_get_port_type_xr17c15x_xr17v25x(priv, pcidev, idx);
 
 	offset = idx * UART_EXAR_XR17V25X_PORT_OFFSET;
@@ -1055,6 +1109,25 @@ static int cti_port_setup_xr17v25x(struct exar8250 *priv,
 	return 0;
 }
 
+static void cti_board_init_xr17c15x(struct exar8250 *priv, struct pci_dev *pcidev)
+{
+	cti_board_init_osc_freq(priv, pcidev, CTI_EE_OFF_XR17C15X_OSC_FREQ);
+
+	/* enable interrupts on cards that need the "PLX fix" */
+	switch (pcidev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
+		cti_plx_int_enable(priv);
+		break;
+	default:
+		break;
+	}
+}
+
 static int cti_port_setup_xr17c15x(struct exar8250 *priv,
 				struct pci_dev *pcidev,
 				struct uart_8250_port *port,
@@ -1063,6 +1136,9 @@ static int cti_port_setup_xr17c15x(struct exar8250 *priv,
 	enum cti_port_type port_type;
 	unsigned int offset;
 
+	if (idx == 0)
+		cti_board_init_xr17c15x(priv, pcidev);
+
 	port_type = cti_get_port_type_xr17c15x_xr17v25x(priv, pcidev, idx);
 
 	offset = idx * UART_EXAR_XR17C15X_PORT_OFFSET;
@@ -1096,78 +1172,6 @@ static int cti_port_setup_xr17c15x(struct exar8250 *priv,
 	return cti_port_setup_common(priv, pcidev, idx, offset, port);
 }
 
-static int cti_board_init_xr17v35x(struct exar8250 *priv,
-				struct pci_dev *pcidev)
-{
-	// XR17V35X uses the PCIe clock rather than an oscillator
-	priv->osc_freq = CTI_DEFAULT_PCIE_OSC_FREQ;
-
-	return 0;
-}
-
-static int cti_board_init_xr17v25x(struct exar8250 *priv, struct pci_dev *pcidev)
-{
-	cti_board_init_osc_freq(priv, pcidev, CTI_EE_OFF_XR17V25X_OSC_FREQ);
-
-	/* enable interrupts on cards that need the "PLX fix" */
-	switch (pcidev->subsystem_device) {
-	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
-	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
-	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
-		cti_plx_int_enable(priv);
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-static int cti_board_init_xr17c15x(struct exar8250 *priv, struct pci_dev *pcidev)
-{
-	cti_board_init_osc_freq(priv, pcidev, CTI_EE_OFF_XR17C15X_OSC_FREQ);
-
-	/* enable interrupts on cards that need the "PLX fix" */
-	switch (pcidev->subsystem_device) {
-	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
-	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
-	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
-	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
-	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
-	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
-		cti_plx_int_enable(priv);
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-static int cti_board_init_fpga(struct exar8250 *priv, struct pci_dev *pcidev)
-{
-	int ret;
-	u16 cfg_val;
-
-	// FPGA OSC is fixed to the 33MHz PCI clock
-	priv->osc_freq = CTI_DEFAULT_FPGA_OSC_FREQ;
-
-	// Enable external interrupts in special cfg space register
-	ret = pci_read_config_word(pcidev, CTI_FPGA_CFG_INT_EN_REG, &cfg_val);
-	if (ret)
-		return pcibios_err_to_errno(ret);
-
-	cfg_val |= CTI_FPGA_CFG_INT_EN_EXT_BIT;
-	ret = pci_write_config_word(pcidev, CTI_FPGA_CFG_INT_EN_REG, cfg_val);
-	if (ret)
-		return pcibios_err_to_errno(ret);
-
-	// RS485 gate needs to be enabled; otherwise RTS/CTS will not work
-	exar_write_reg(priv, CTI_FPGA_RS485_IO_REG, 0x01);
-
-	return 0;
-}
-
 static int
 pci_xr17c154_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		   struct uart_8250_port *port, int idx)
@@ -1574,15 +1578,6 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	if (board->board_init) {
-		rc = board->board_init(priv, pcidev);
-		if (rc) {
-			dev_err_probe(&pcidev->dev, rc,
-					"failed to init serial board\n");
-			return rc;
-		}
-	}
-
 	for (i = 0; i < nr_ports && i < maxnr; i++) {
 		rc = board->setup(priv, pcidev, &uart, i);
 		if (rc) {
@@ -1664,22 +1659,18 @@ static const struct exar8250_board pbn_fastcom335_8 = {
 };
 
 static const struct exar8250_board pbn_cti_xr17c15x = {
-	.board_init	= cti_board_init_xr17c15x,
 	.setup		= cti_port_setup_xr17c15x,
 };
 
 static const struct exar8250_board pbn_cti_xr17v25x = {
-	.board_init	= cti_board_init_xr17v25x,
 	.setup		= cti_port_setup_xr17v25x,
 };
 
 static const struct exar8250_board pbn_cti_xr17v35x = {
-	.board_init	= cti_board_init_xr17v35x,
 	.setup		= cti_port_setup_xr17v35x,
 };
 
 static const struct exar8250_board pbn_cti_fpga = {
-	.board_init	= cti_board_init_fpga,
 	.setup		= cti_port_setup_fpga,
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


