Return-Path: <linux-kernel+bounces-158709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB3D8B240F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9B2283690
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4514A4DA;
	Thu, 25 Apr 2024 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFCHFRuo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066A149E12
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055235; cv=none; b=icFASeGvgGWJHZTqe92BNuXQh/IjIsewRTpmGmenlp2qw9C/Omj/+IT3fPpdyIM2KeoC5VA/nEvPmK7p4jsjghOm5iUsU4IUaPH3WQpaHZ9urvaOwZY/3GV2DQQrLT42og9fidmltNnVLVzZR5uPBR6g/9leIrlSS88i7T9Awis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055235; c=relaxed/simple;
	bh=yCTUM4VsZP0XLCbKY2nqBkSXSRXgEYSN4aDZAwo5Ukk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPKMMjXoUHt84L63UiZ2HPIY3YL7rwu/dp9jptXu8tJ/kMJIbC24aRkdDhMUrGfIoxsHPouR7jpZdoLy2uDPVdS3D9Gi8r9ZJBS9gD1XZD0LRSQAKOtxby4dhi5asELWvUEu9X4TE4XDGMZgl5C7DtT21JGFU7wg4h67ckB8Jl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFCHFRuo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714055234; x=1745591234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yCTUM4VsZP0XLCbKY2nqBkSXSRXgEYSN4aDZAwo5Ukk=;
  b=fFCHFRuoXN5hpvjNy9aRVjZP19yNF7/ZY9Ab8qIDPp1+BiJMYkeqXjSi
   VJ1EaAdfAEAImOTAnKOTxGsIK1nt8JUaGf0004Q17bOEez86pjYDGNAPv
   r6WRYl91TQI7Fc49zk94UlU1vUxZbhmV5Ls7VA3N9rPVSK16/1a0bnLX0
   0ckdGlpnPBrV3jMixgi1ZakWOuIDtSyN2LdVq2qWCMJcU8JvKYJvQI7Bv
   rJx4wkL+F0NiXYju8UDrTeJj9F3+JVkWWQeXe9ayHNmjrSZcTgGSy6Gth
   KIxvq6gUoPsQjksqoXkW7bjrFMN7jo0rNmUB1EYa2+KCWEItscRF3nosu
   g==;
X-CSE-ConnectionGUID: xXlaOA3xSW64g3NUvwe2Tg==
X-CSE-MsgGUID: bdkyfbmaQGi7uxUE0NAfKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="10281349"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="10281349"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 07:27:11 -0700
X-CSE-ConnectionGUID: TtSjRNFfSuaq2PIeMrhhNA==
X-CSE-MsgGUID: QIpqLtBDQr+fLUQUN0w7mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="29555176"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 25 Apr 2024 07:27:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0BCD3F4; Thu, 25 Apr 2024 17:27:06 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 1/3] drm/panel: ili9341: Correct use of device property APIs
Date: Thu, 25 Apr 2024 17:26:17 +0300
Message-ID: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
References: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems driver missed the point of proper use of device property APIs.
Correct this by updating headers and calls respectively.

Fixes: 5a04227326b0 ("drm/panel: Add ilitek ili9341 panel driver")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/panel/Kconfig                | 2 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index e54f6f5604ed..2d4515555820 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -177,7 +177,7 @@ config DRM_PANEL_ILITEK_IL9322
 
 config DRM_PANEL_ILITEK_ILI9341
 	tristate "Ilitek ILI9341 240x320 QVGA panels"
-	depends on OF && SPI
+	depends on SPI
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	depends on BACKLIGHT_CLASS_DEVICE
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
index 3574681891e8..7584ddb0e441 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
@@ -22,8 +22,9 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
@@ -691,7 +692,7 @@ static int ili9341_dpi_probe(struct spi_device *spi, struct gpio_desc *dc,
 	 * Every new incarnation of this display must have a unique
 	 * data entry for the system in this driver.
 	 */
-	ili->conf = of_device_get_match_data(dev);
+	ili->conf = device_get_match_data(dev);
 	if (!ili->conf) {
 		dev_err(dev, "missing device configuration\n");
 		return -ENODEV;
-- 
2.43.0.rc1.1336.g36b5255a03ac


