Return-Path: <linux-kernel+bounces-167962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B088BB1AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40052B22923
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F210158A2B;
	Fri,  3 May 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYLqjtvl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075D1586C0;
	Fri,  3 May 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756786; cv=none; b=PcaSp7k3fyVk2QND3kSp6BEWlL9VFJ+MY0O5cSf8kGSOLveg9kb2tmYYzyQ0dGZG3TFll7M3iNZbqc+H72yNhkU6QAbb3qrw0wO6TqwR3CLvtozPKjVMiomhOvxXs6O6GG49CnWUli/L4sjrW/Yk2H2/TT0l/6yAkJzMXDsbpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756786; c=relaxed/simple;
	bh=Hcgz7372JSWmrvRQywcGylEztD7txJvhGznmILq6zB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pebHZ868J6iFkloq/RcKeGizvDP3Qj9V1KnwOlpiDdCSSZm6pAniXQTp92AvG08wNZ83OvZCdHrIgOF2IfiF5zoEMtPBtFRqQ4LvI8dZYuQ6NZHesJ345Mo+jTdCRKnu7t0//RVG9NVMgmDhoyuWQM7JFFVn2eHwrxjo8+LNI0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYLqjtvl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756785; x=1746292785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hcgz7372JSWmrvRQywcGylEztD7txJvhGznmILq6zB4=;
  b=GYLqjtvldvH6QwwH8Lns9yQsk6jGcCfDUSYKI3QmtNYt0J4cUgIU3vDk
   nXDNF6tO3rX/8BzQY8voa9u4COCzT9kLOLp1PpBArZ/x3mEp/IhQbb1mc
   0A1ahILEjSxErTMoVTMgwK4FWLNmk9twdOxGavxGIqSCIAjc1Ly5do64C
   FYuGNtgQq1St6XEGq7hDvJJ69/IaU3VZdac3O0nX+wfVLipBtrMDz6U/m
   edu/3nU3KwXAp8bKQUEimU/h7hf/trGaP1P4v82jkdtYidq2nDzakr3IZ
   NmcT9nYkUNs/4GpBcUqTsM/eiXsML3VMTI/rdyrSCK36e53kkbXkjBBuA
   A==;
X-CSE-ConnectionGUID: Jf2h6PuARM63v7pZZsM6IQ==
X-CSE-MsgGUID: PI7NB5/4RSalkxl5A3hn5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="11107808"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="11107808"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:19:44 -0700
X-CSE-ConnectionGUID: 0S5fgwx+RuGGjX3mv209/g==
X-CSE-MsgGUID: vq5wy9W0SKq6Swtvz3e3Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="58415424"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 03 May 2024 10:19:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 606F91C7; Fri,  3 May 2024 20:19:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 06/13] serial: 8250_exar: Extract cti_board_init_osc_freq() helper
Date: Fri,  3 May 2024 20:15:58 +0300
Message-ID: <20240503171917.2921250-7-andriy.shevchenko@linux.intel.com>
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


