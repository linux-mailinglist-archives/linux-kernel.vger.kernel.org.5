Return-Path: <linux-kernel+bounces-148368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728CD8A8192
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3AA41F22E28
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6D213D279;
	Wed, 17 Apr 2024 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJELr/DN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D113C836;
	Wed, 17 Apr 2024 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351828; cv=none; b=udXQUW8jhzbmbQNXFaDFGdppssBKpN47G2LAmoNAz5B23E5CMDI59S1yV4UQYzL6ZZ1/GO2c6KOfOkO5wc+DDpsHHpHW7RRZPUZ1EI1MAx3/W75W5uoLzsYNUWqOcMbd8QXagZbkQF98l+4YqEZ8GV1+K4Jee6FWyvkszUT9RLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351828; c=relaxed/simple;
	bh=NPM74tt5sE/MfVe6VeyuUXpMJ6J+W7rv/GRbFNzrHKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljecXfQpGfER+1l6sOn+HyQnFTY6m9LdV8Sbl5pHEgylDR6SxIskvDDKIcixgQGoi2JTTy9tf+Z33db6RoEkdz7HiAh/elf9cBkFUc70yD7p2gBl8rrsdmD9CrkdaCPsSSiBNUL5bWIY158cu2z3ehiz+XF/ZznF9W4n+D7dIiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJELr/DN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713351827; x=1744887827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NPM74tt5sE/MfVe6VeyuUXpMJ6J+W7rv/GRbFNzrHKk=;
  b=QJELr/DN0tDDQ7tthSq/lmcYLGL8EUtjOTOgjEgTHcbmVZ5PAgC4hozr
   1ZipQwO/rn3TrgF1LkLHW8nzQwLh9bC5+mVpz/T0LcsZjpiWiaGSw9oip
   zX/U9cRQMKDJReZVh64U8VLAUUs04CPTUgyF1Cra/w20GaH/cCsVkaCdf
   OGDr6IQlhfi3LtrYchRBMK6DpLI/gTeNzQMRiTwRkterJZhiu/jFjZ4qx
   JgRIyza5ahIfIuuSh3hk1oX9a5M84q6vVE6zI8YGrTFWRwIDDMw8CyZUi
   7zhVp3FD7M9p2GMpRNbgBHkS13dDxAFkVLNvcR4rgd3vxM/0789hoYeL8
   Q==;
X-CSE-ConnectionGUID: cJgUvDf0QFCJnCmtIKfLRg==
X-CSE-MsgGUID: 80k3Dv0TT/yHr4R3lx5TAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8698143"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8698143"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 04:03:40 -0700
X-CSE-ConnectionGUID: YRij57pxQtugkdQU/3ruUQ==
X-CSE-MsgGUID: AMQHOuj6QxSkffgk80mOmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27380697"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 17 Apr 2024 04:03:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7060460B; Wed, 17 Apr 2024 14:03:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 3/9] spi: pxa2xx: Move contents of linux/spi/pxa2xx_spi.h to a local one
Date: Wed, 17 Apr 2024 13:54:30 +0300
Message-ID: <20240417110334.2671228-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com>
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no user of the linux/spi/pxa2xx_spi.h. Move its contents
to the drivers/spi/spi-pxa2xx.h.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c   |  1 -
 drivers/spi/spi-pxa2xx-pci.c   |  4 +--
 drivers/spi/spi-pxa2xx.c       |  1 -
 drivers/spi/spi-pxa2xx.h       | 36 ++++++++++++++++++++++++-
 include/linux/spi/pxa2xx_spi.h | 48 ----------------------------------
 5 files changed, 37 insertions(+), 53 deletions(-)
 delete mode 100644 include/linux/spi/pxa2xx_spi.h

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index be563f0dd03a..26416ced6505 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -12,7 +12,6 @@
 #include <linux/scatterlist.h>
 #include <linux/sizes.h>
 
-#include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
 
 #include "spi-pxa2xx.h"
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 861b21c63504..e11a613bc340 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -10,11 +10,11 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
-#include <linux/spi/pxa2xx_spi.h>
-
 #include <linux/dmaengine.h>
 #include <linux/platform_data/dma-dw.h>
 
+#include "spi-pxa2xx.h"
+
 #define PCI_DEVICE_ID_INTEL_QUARK_X1000		0x0935
 #define PCI_DEVICE_ID_INTEL_BYT			0x0f0e
 #define PCI_DEVICE_ID_INTEL_MRFLD		0x1194
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index ab6fd55237cd..82633682b581 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -24,7 +24,6 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 
-#include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
 
 #include "spi-pxa2xx.h"
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 45cdbbc71c4b..08296729ea80 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -7,6 +7,7 @@
 #ifndef SPI_PXA2XX_H
 #define SPI_PXA2XX_H
 
+#include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/types.h>
@@ -15,7 +16,40 @@
 #include <linux/pxa2xx_ssp.h>
 
 struct gpio_desc;
-struct pxa2xx_spi_controller;
+
+/*
+ * The platform data for SSP controller devices
+ * (resides in device.platform_data).
+ */
+struct pxa2xx_spi_controller {
+	u8 num_chipselect;
+	u8 enable_dma;
+	u8 dma_burst_size;
+	bool is_target;
+
+	/* DMA engine specific config */
+	dma_filter_fn dma_filter;
+	void *tx_param;
+	void *rx_param;
+
+	/* For non-PXA arches */
+	struct ssp_device ssp;
+};
+
+/*
+ * The controller specific data for SPI target devices
+ * (resides in spi_board_info.controller_data),
+ * copied to spi_device.platform_data ... mostly for
+ * DMA tuning.
+ */
+struct pxa2xx_spi_chip {
+	u8 tx_threshold;
+	u8 tx_hi_threshold;
+	u8 rx_threshold;
+	u8 dma_burst_size;
+	u32 timeout;
+};
+
 struct spi_controller;
 struct spi_device;
 struct spi_transfer;
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
deleted file mode 100644
index e5a4a045fb67..000000000000
--- a/include/linux/spi/pxa2xx_spi.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
- */
-#ifndef __LINUX_SPI_PXA2XX_SPI_H
-#define __LINUX_SPI_PXA2XX_SPI_H
-
-#include <linux/dmaengine.h>
-#include <linux/types.h>
-
-#include <linux/pxa2xx_ssp.h>
-
-struct dma_chan;
-
-/*
- * The platform data for SSP controller devices
- * (resides in device.platform_data).
- */
-struct pxa2xx_spi_controller {
-	u8 num_chipselect;
-	u8 enable_dma;
-	u8 dma_burst_size;
-	bool is_target;
-
-	/* DMA engine specific config */
-	dma_filter_fn dma_filter;
-	void *tx_param;
-	void *rx_param;
-
-	/* For non-PXA arches */
-	struct ssp_device ssp;
-};
-
-/*
- * The controller specific data for SPI target devices
- * (resides in spi_board_info.controller_data),
- * copied to spi_device.platform_data ... mostly for
- * DMA tuning.
- */
-struct pxa2xx_spi_chip {
-	u8 tx_threshold;
-	u8 tx_hi_threshold;
-	u8 rx_threshold;
-	u8 dma_burst_size;
-	u32 timeout;
-};
-
-#endif	/* __LINUX_SPI_PXA2XX_SPI_H */
-- 
2.43.0.rc1.1336.g36b5255a03ac


