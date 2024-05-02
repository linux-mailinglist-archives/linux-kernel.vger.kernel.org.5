Return-Path: <linux-kernel+bounces-166586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4851B8B9CBA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0440F285878
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CBF153567;
	Thu,  2 May 2024 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="baMpMNDh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FBB154457;
	Thu,  2 May 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661201; cv=none; b=u6gcqORzfHODL3geDi6DEF2c9MtbnScNrdZrau45HnIVJjOYucB/p8AIm8HbZ1hUcRnQU2CwS8qxY+s1xDM1ReVCP+TcHq08AWGDZ+AZ0poViez0/7nteDoLTB+pqENFueAn7LETaBvdb6TEGYewXjXEugPG5mraw1Bv4HfFEhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661201; c=relaxed/simple;
	bh=Hcgz7372JSWmrvRQywcGylEztD7txJvhGznmILq6zB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3fTEEY6rIFE+LiFBeSw/SRWycJk87Md3gD9aCGMzEKBtJJqiQISwXbtp4EGuk6qCx3PMvBSN/koBlfvFzb262fqJeDzD27L9oVlR0af3PoBy7RMDJNoYfySVJbMW/GDzUcFVHeqzVFJdcce48sOxvr0niCRNnv1uR/K/6YSvpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=baMpMNDh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714661200; x=1746197200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hcgz7372JSWmrvRQywcGylEztD7txJvhGznmILq6zB4=;
  b=baMpMNDha+lS/OM2L2RU9zVWLDaSM/jo9FTlQ+d4VDdKJx5pCPKPkizA
   qqwoytYPoCFIQ+ncPCHE/4P54ZlXujc2CqypOhml+nFuTpd7MeqsLn9X+
   GHJQiHBRG5wVBsms2F1oOvCB6LADz6kOk0mHnmoJAhuS0Wr8/5qmYZKf7
   0O42wLHgfSvi9Axn4veozXAf0tdujplZJ0CK2XpmFiguNAFG+I7SnCW8p
   U1n21WSXt1CvKXHG2DlZJXdNCYVavbpgZcAHlhl3GuzafcxvPwhaVQ06V
   rKV/KJxHi4o1hnWa/xlNSqJjGNxb4J7Gci7pHbyq0IdB4Td9zhSFM7nMn
   g==;
X-CSE-ConnectionGUID: EZFUb5FxQ6qM12Y6MizAaw==
X-CSE-MsgGUID: /x5PAul6Tvq+EX9GX4jQYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10306088"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10306088"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 07:46:36 -0700
X-CSE-ConnectionGUID: JE3IlubBTXmx4RwteMZowg==
X-CSE-MsgGUID: 0tBQAtizQmqMuQz6s6D+hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31632839"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 02 May 2024 07:46:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 12FC322C; Thu,  2 May 2024 17:46:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 06/13] serial: 8250_exar: Extract cti_board_init_osc_freq() helper
Date: Thu,  2 May 2024 17:44:00 +0300
Message-ID: <20240502144626.2716994-7-andriy.shevchenko@linux.intel.com>
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

Extract cti_board_init_osc_freq() helper to avoid code duplication.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 48 ++++++++++++-----------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index ac373cde7e39..956323e2de4a 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -695,7 +695,6 @@ static int cti_read_osc_freq(struct exar8250 *priv, u8 eeprom_offset)
 {
 	u16 lower_word;
 	u16 upper_word;
-	int osc_freq;
 
 	lower_word = exar_ee_read(priv, eeprom_offset);
 	// Check if EEPROM word was blank
@@ -706,10 +705,8 @@ static int cti_read_osc_freq(struct exar8250 *priv, u8 eeprom_offset)
 	if (upper_word == 0xFFFF)
 		return -EIO;
 
-	osc_freq = FIELD_PREP(CTI_EE_MASK_OSC_FREQ_LOWER, lower_word) |
-		FIELD_PREP(CTI_EE_MASK_OSC_FREQ_UPPER, upper_word);
-
-	return osc_freq;
+	return FIELD_PREP(CTI_EE_MASK_OSC_FREQ_LOWER, lower_word) |
+	       FIELD_PREP(CTI_EE_MASK_OSC_FREQ_UPPER, upper_word);
 }
 
 /**
@@ -890,6 +887,19 @@ static int cti_rs485_config_mpio_tristate(struct uart_port *port,
 	return cti_tristate_disable(priv, port->port_id);
 }
 
+static void cti_board_init_osc_freq(struct exar8250 *priv, struct pci_dev *pcidev, u8 eeprom_offset)
+{
+	int osc_freq;
+
+	osc_freq = cti_read_osc_freq(priv, eeprom_offset);
+	if (osc_freq <= 0) {
+		dev_warn(&pcidev->dev, "failed to read OSC freq from EEPROM, using default\n");
+		osc_freq = CTI_DEFAULT_PCI_OSC_FREQ;
+	}
+
+	priv->osc_freq = osc_freq;
+}
+
 static int cti_port_setup_common(struct exar8250 *priv,
 				struct pci_dev *pcidev,
 				int idx, unsigned int offset,
@@ -1095,19 +1105,9 @@ static int cti_board_init_xr17v35x(struct exar8250 *priv,
 	return 0;
 }
 
-static int cti_board_init_xr17v25x(struct exar8250 *priv,
-				struct pci_dev *pcidev)
+static int cti_board_init_xr17v25x(struct exar8250 *priv, struct pci_dev *pcidev)
 {
-	int osc_freq;
-
-	osc_freq = cti_read_osc_freq(priv, CTI_EE_OFF_XR17V25X_OSC_FREQ);
-	if (osc_freq < 0) {
-		dev_warn(&pcidev->dev,
-			"failed to read osc freq from EEPROM, using default\n");
-		osc_freq = CTI_DEFAULT_PCI_OSC_FREQ;
-	}
-
-	priv->osc_freq = osc_freq;
+	cti_board_init_osc_freq(priv, pcidev, CTI_EE_OFF_XR17V25X_OSC_FREQ);
 
 	/* enable interrupts on cards that need the "PLX fix" */
 	switch (pcidev->subsystem_device) {
@@ -1123,19 +1123,9 @@ static int cti_board_init_xr17v25x(struct exar8250 *priv,
 	return 0;
 }
 
-static int cti_board_init_xr17c15x(struct exar8250 *priv,
-				struct pci_dev *pcidev)
+static int cti_board_init_xr17c15x(struct exar8250 *priv, struct pci_dev *pcidev)
 {
-	int osc_freq;
-
-	osc_freq = cti_read_osc_freq(priv, CTI_EE_OFF_XR17C15X_OSC_FREQ);
-	if (osc_freq <= 0) {
-		dev_warn(&pcidev->dev,
-			"failed to read osc freq from EEPROM, using default\n");
-		osc_freq = CTI_DEFAULT_PCI_OSC_FREQ;
-	}
-
-	priv->osc_freq = osc_freq;
+	cti_board_init_osc_freq(priv, pcidev, CTI_EE_OFF_XR17C15X_OSC_FREQ);
 
 	/* enable interrupts on cards that need the "PLX fix" */
 	switch (pcidev->subsystem_device) {
-- 
2.43.0.rc1.1336.g36b5255a03ac


