Return-Path: <linux-kernel+bounces-167963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0235C8BB1AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E751F23DD4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BE3158A36;
	Fri,  3 May 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYl7MXPs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EAF1586F2;
	Fri,  3 May 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756786; cv=none; b=G8Wye6y0dD8FGDqWpVT8iCcu5uSqMvgGAd2njPIV8r/yCylxA0vm3Z/HYuClGFwdr05Y30cjWRoU95eGcqj1WcqnK+oxhhHMSSCnJKOgfc/pEH5RK+JHWCKQFCZPS1j3yKPGBYyxg0zA0L++ZBDYhXOqW7g1k4tevYrG+6PuwZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756786; c=relaxed/simple;
	bh=MPc1IkmPTaUhh/egUaTmEy/dFmjevrLUOTFIWjFB7BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEfAnI2MPIC5/6uDoDRWJtHdHJWXf4qtUuKXp3iz2d0Nq/N2KU5AQzFHPSjq+vLLbXldrk+7jPDqdPms1yJLSbHqZDCaYO/boksi0YJ2Q2iYB6BXZQQwLxAenXf611KvLkQ1TFsLFHCwh2bg3YbyU8mGAS0FIsnIgOtIs2ZG1io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYl7MXPs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756785; x=1746292785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MPc1IkmPTaUhh/egUaTmEy/dFmjevrLUOTFIWjFB7BM=;
  b=TYl7MXPsBj6XrxGbFuJOpMydC3vbABQRhfGVeIfzV0/k/OoKYIKkCbFx
   Ir/61O2A3/13cUNkzF3w+aOEOXZU+lGaesJJk4dBUkcS11JxSFn9KK7UI
   J/zfOhJU547sKtbVVjb0cPxK7ikPA4V2kmRgm8JQUiq8gZe+9I0UQwutZ
   edKsJwxfp7UvQ+glTYgWER1xqqeF2Nazw5l4OfnRfzKd7FcWr7r7zzl4q
   doQQhdASEBQtHzYeTGM8BTEd8uzhykj5jb+J+VLv8Q/vw9JL/iGpJfe/w
   rXW0v3UnsVgMfI76wdYtuteZ5qd6lX2gCewSZNs0zc8asq4Fx1MzRcv3K
   Q==;
X-CSE-ConnectionGUID: Upm29KpxS1SmVcYFOh+jzQ==
X-CSE-MsgGUID: yxPUdOvSQLSHgZF6IGtYQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="35962101"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="35962101"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:19:44 -0700
X-CSE-ConnectionGUID: 9tB/PKX/TfqYjS5KRX+CRw==
X-CSE-MsgGUID: Yo6YW076Scmhcl3H3n7Jhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28098214"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 03 May 2024 10:19:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5AD96445; Fri,  3 May 2024 20:19:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 05/13] serial: 8250_exar: Trivia typo fixes
Date: Fri,  3 May 2024 20:15:57 +0300
Message-ID: <20240503171917.2921250-6-andriy.shevchenko@linux.intel.com>
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

Trivia typo fixes: interupts --> interrupts and others.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 5405a1f463f1..ac373cde7e39 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -641,7 +641,7 @@ pci_fastcom335_setup(struct exar8250 *priv, struct pci_dev *pcidev,
  * @port_num: Port number to set tristate off
  *
  * Most RS485 capable cards have a power on tristate jumper/switch that ensures
- * the RS422/RS485 transciever does not drive a multi-drop RS485 bus when it is
+ * the RS422/RS485 transceiver does not drive a multi-drop RS485 bus when it is
  * not the master. When this jumper is installed the user must set the RS485
  * mode to Full or Half duplex to disable tristate prior to using the port.
  *
@@ -666,7 +666,7 @@ static int cti_tristate_disable(struct exar8250 *priv, unsigned int port_num)
  * @priv: Device's private structure
  *
  * Some older CTI cards require MPIO_0 to be set low to enable the
- * interupts from the UART to the PLX PCI->PCIe bridge.
+ * interrupts from the UART to the PLX PCI->PCIe bridge.
  *
  * Return: 0 on success, negative error code on failure
  */
@@ -927,7 +927,7 @@ static int cti_port_setup_fpga(struct exar8250 *priv,
 
 	port_type = cti_get_port_type_fpga(priv, pcidev, idx);
 
-	// FPGA shares port offests with XR17C15X
+	// FPGA shares port offsets with XR17C15X
 	offset = idx * UART_EXAR_XR17C15X_PORT_OFFSET;
 	port->port.type = PORT_XR17D15X;
 
@@ -1109,7 +1109,7 @@ static int cti_board_init_xr17v25x(struct exar8250 *priv,
 
 	priv->osc_freq = osc_freq;
 
-	/* enable interupts on cards that need the "PLX fix" */
+	/* enable interrupts on cards that need the "PLX fix" */
 	switch (pcidev->subsystem_device) {
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
 	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
-- 
2.43.0.rc1.1336.g36b5255a03ac


