Return-Path: <linux-kernel+bounces-130273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEEF89762F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E081C28617
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58562155302;
	Wed,  3 Apr 2024 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPGzCHnp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D299153572;
	Wed,  3 Apr 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164562; cv=none; b=FBGqQ4O9XdJsDsHoObb9in9TlZz0D1oXJm6uChs3IVuv741yVu/xL0jgVzYac5aYVfb4d/D1ed6fet+Tcbu0W1s1LvhojhXdSXG3iEJPQqBCbVc9ayvHZrcx0uXP9hgXt98OhyyIrWVGr/N9TLe7uHkpofwPhpDLvlqnACKjr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164562; c=relaxed/simple;
	bh=me4cMeii27/KaK0gEtLaIGUNWbUm95Gjy18PkqtFUnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ad9Vp1wTCENqvqlb7SkDY9rRvfrPY/vHjDcZFI5ylF6Tn8a/J+Ki0cWcIZKI9sjq3uboJ5+RmmNhrgWAYd1wh9WtO1mAkl9rCqXxdvKT/LphC46TM0kkt+n4/nkQMFNbYhYJyCjPzah/VrYfZOgOmM2GTPwN8WYBENmW/Y+EWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPGzCHnp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712164561; x=1743700561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=me4cMeii27/KaK0gEtLaIGUNWbUm95Gjy18PkqtFUnE=;
  b=WPGzCHnpDiYTqX3vwPpWpNNAbSfzh5JCMwtlbISb2lXwb6WsVp3+AAyf
   8WGK9mFYpYV0DMp/sbM9ROT4FRXMchZkJj8YNCNIlreUckmOzUkf+GEtY
   ey/t1MTWZ2Bjiyxifc5bd5uSIDqUbBrrMWEanSiWPc44B4/f0WNRsib5w
   9GtNrCiAdS+5adIbPSNqFmzacbnYZ+3M1Tcnx9ROsMTfCooXCNmPwsC22
   oFL7XUMU31+xkAr4WUphEREHW/c1QR9XFAs3UquLbw0htmNJuO4fPPxGO
   ZDF1FJnvCDWS7RMn4hQpMBmSaQQJJgQiAA2IZ0oUkSGphuJGdRRMS857c
   w==;
X-CSE-ConnectionGUID: nw8DCGwFQEGOIVFRV7sXxQ==
X-CSE-MsgGUID: E3jdQWR8R1eFIXMHvcVxug==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18863578"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18863578"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:16:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085342"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085342"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 10:15:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CCAAE812; Wed,  3 Apr 2024 20:15:53 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 5/5] spi: pxa2xx: Don't provide struct chip_data for others
Date: Wed,  3 Apr 2024 20:06:39 +0300
Message-ID: <20240403171550.1074644-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240403171550.1074644-1-andriy.shevchenko@linux.intel.com>
References: <20240403171550.1074644-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the struct chip_data is local to spi-pxa2xx.c, move
its definition to the C file. This will slightly speed up
a build and also hide badly named data type (too generic).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 8 ++++++++
 drivers/spi/spi-pxa2xx.h | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 030afb17e606..efe76d0c21bb 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -66,6 +66,14 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 				| CE4100_SSCR1_RFT | CE4100_SSCR1_TFT | SSCR1_MWDS \
 				| SSCR1_SPH | SSCR1_SPO | SSCR1_LBM)
 
+struct chip_data {
+	u32 cr1;
+	u32 dds_rate;
+	u32 threshold;
+	u16 lpss_rx_threshold;
+	u16 lpss_tx_threshold;
+};
+
 #define LPSS_GENERAL_REG_RXTO_HOLDOFF_DISABLE	BIT(24)
 #define LPSS_CS_CONTROL_SW_MODE			BIT(0)
 #define LPSS_CS_CONTROL_CS_HIGH			BIT(1)
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 5f741bb30240..93e1e471e1c6 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -75,14 +75,6 @@ struct driver_data {
 	struct gpio_desc *gpiod_ready;
 };
 
-struct chip_data {
-	u32 cr1;
-	u32 dds_rate;
-	u32 threshold;
-	u16 lpss_rx_threshold;
-	u16 lpss_tx_threshold;
-};
-
 static inline u32 pxa2xx_spi_read(const struct driver_data *drv_data, u32 reg)
 {
 	return pxa_ssp_read_reg(drv_data->ssp, reg);
-- 
2.43.0.rc1.1.gbec44491f096


