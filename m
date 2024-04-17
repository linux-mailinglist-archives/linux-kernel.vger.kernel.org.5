Return-Path: <linux-kernel+bounces-148374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D83788A81A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 631D8B24646
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1872D13C8FB;
	Wed, 17 Apr 2024 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNeQx4E1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F4913DDC1;
	Wed, 17 Apr 2024 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351837; cv=none; b=SboA3X+g4yRRoSas0t1iQ1WDjoBrhM1zanfJ/Ie75W2Tof/mMFahJvguRUsrZcwc06wtXPf08ry50zP9Eq2tB2t1iu4iz8//C/7fKAhfWeWkwKgatDdx+rMqwNx9wWK0SX8qDsyLcfHQ8HETFiR6ZwnC0kvpt3GYIbOxgv1WhWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351837; c=relaxed/simple;
	bh=eKJwuwJhkJP8lPZ256GGIvTQ2O29fyGfookXc2AP3LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8Apu7mwPmdllTO3GfPY+sWq35YPBjaJpIKBPWt5hgrTYmEHfVLEUK6qKaUAIttz1WHSlZvOcr4gIqrNv5xkvs5G9GI8K6WHS09aA73QsGkvJKGDZty7Zc8/3FFeWS0Hpx3o+VSpK1dHC0hlMM26ihJQaQKsEBmt4hcFeAYnv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNeQx4E1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713351833; x=1744887833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eKJwuwJhkJP8lPZ256GGIvTQ2O29fyGfookXc2AP3LI=;
  b=gNeQx4E1ZPPMzjuLBjxljm4ldj0WwZMqwXG5awpm+cj+2jMAnNZqYLl3
   yL69o+TfFCfldwr/SGlBsFU9bHj1hbGv+Nt4CSG77tUcjLZ18BaDQ98hQ
   qvfmr98AhRAj/kIJedxjjG08kSV6wY3DEhAl8aIg+FSioUGTMcQVzviSM
   k81FBUBEPjTmN+87IyF4TAPp/yv5ceElUXXSgjyJmWKYKXGKJHK0VGjSp
   kZbL+BESUr24MMEgowie/pn/3122PIL3+Ci2jvrIMxsakaPQr1xe6A7km
   aYaxAt7HxxsszWwzB0RXsQvliy9yLFag1ENEofpbnQbDlAaO138bD+/Bs
   w==;
X-CSE-ConnectionGUID: qbvh1V9XSYqEAsnea8ec6A==
X-CSE-MsgGUID: GyfY9DBySraO8PFTrxZkKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8698188"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8698188"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 04:03:44 -0700
X-CSE-ConnectionGUID: 5ym2ePKORKagtOqI1/Mr8Q==
X-CSE-MsgGUID: +5ppQoSEQ/GP0uKHk1l4Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27380729"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 17 Apr 2024 04:03:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BFF241506; Wed, 17 Apr 2024 14:03:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 9/9] spi: pxa2xx: Don't provide struct chip_data for others
Date: Wed, 17 Apr 2024 13:54:36 +0300
Message-ID: <20240417110334.2671228-10-andriy.shevchenko@linux.intel.com>
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
2.43.0.rc1.1336.g36b5255a03ac


