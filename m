Return-Path: <linux-kernel+bounces-166587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49858B9CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119CD1C22354
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A604C156C45;
	Thu,  2 May 2024 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gs/hIpM0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE04154C0B;
	Thu,  2 May 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661201; cv=none; b=HF5Elm8LSfFYrzuOI9rAwbKSArx6hFNfQQaZK4nW7fC+P+CC9iOCKsuqnhZuLQJ2v1JurWHwM1YrItFHh4PlGOi4ABrMYAolh9YSzPRT2nTtiO/KZhQJZ28qtHgCLs6zLxiZlMWeDuWBdAL1l8I7rLSvDboxV5z4LLoWmxArcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661201; c=relaxed/simple;
	bh=MPc1IkmPTaUhh/egUaTmEy/dFmjevrLUOTFIWjFB7BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gur0/ointqfAiP+msdyaWSEY6kYLrURWYv4JZORdJ/AyDQ9/0bF83fFGHs6nDHnO/ruwyrSiyPwyDp7un1YTgpC1oQz6Ki4awdw4zIM+1i4I4VuBiXbsN6qWztYEIvTnKqwP8ntOclX/sQFLksU2hyRtZqAcuC3jfsjgtEfQdI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gs/hIpM0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714661200; x=1746197200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MPc1IkmPTaUhh/egUaTmEy/dFmjevrLUOTFIWjFB7BM=;
  b=gs/hIpM0hhZtGuIADMwkxkOoJ6U0AsRjOQpfD4ygDtbADaQHdpPNgqmO
   1wwXsRcoI5TgALagPhZFWcm9ezb4IuwH6otyRY7q2fzh8kQfUW/enHnFc
   rdWd1FrS1tZ7KHj6BHkMDbBEv1uBkNoHcBT2+XlQVgiF/HqVYtnQ+ujJg
   p2Ec9d1XZdfOPf9letjj6Yc+uNKKf+2OtQliWihJ7qth6rlw4KspZI4dL
   vW+DhfWwxaY3WNRbxhtSQIeebDQSbPQ49alcDGCE8VrhHbgZco4JQWPNm
   A6GgSXXGfn6WeXGcYdtBYzzryaoCGC/UjD2/wa63GIgOIMJjrRxckSfpo
   w==;
X-CSE-ConnectionGUID: aw2hvlB1TeKPl75n0xWKfA==
X-CSE-MsgGUID: vvp73YNlTSiEmvaYzB/yhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10306093"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10306093"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 07:46:36 -0700
X-CSE-ConnectionGUID: +4o5sW/LS8S3PHuUrIkjgQ==
X-CSE-MsgGUID: Y6sdbkf9Rsy1dYR6SFPFLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31632840"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 02 May 2024 07:46:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 054FE4B9; Thu,  2 May 2024 17:46:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 05/13] serial: 8250_exar: Trivia typo fixes
Date: Thu,  2 May 2024 17:43:59 +0300
Message-ID: <20240502144626.2716994-6-andriy.shevchenko@linux.intel.com>
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


