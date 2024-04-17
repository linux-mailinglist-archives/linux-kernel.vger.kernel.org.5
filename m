Return-Path: <linux-kernel+bounces-148365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB5B8A818B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF8B1F22114
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF813C8E5;
	Wed, 17 Apr 2024 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F520NppO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D7613C80B;
	Wed, 17 Apr 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351826; cv=none; b=Qrb+8cgSnuny1PdC6vOWQuhGGl4GFh97OXJXf5eXX1RoQWRDSM9oY3zHejtnXxczHtySGyu1lf9ed3E5ucCmo4S1z1l9ruATPQARcXizpaPqEFejT8T8N2tsXKvxauQ04T8/OyBdg4Mv3Dj8VEBRMaL3KZIZ/bd5eO0AHIMblj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351826; c=relaxed/simple;
	bh=Vq5PKqs9ah/OwO8gQhBqXkVQsO/11Ccf4mxzPDr98VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bprhYRgO4bxoZlISeSfIFB9e1oSp9bR2ZvOzdGlXrGtQMdbH1Jmpvv7VGH1lsrUtTtUHJsrfIp+ZMv0HTStYjyGZJJHbJdf5uLOqMeovKXFvHauvL5kywtzt8qCcEJPjVl2bi4NyusQb7nIC67QhsAuB6arr6dj5zfjvJYMLdUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F520NppO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713351824; x=1744887824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vq5PKqs9ah/OwO8gQhBqXkVQsO/11Ccf4mxzPDr98VU=;
  b=F520NppOW02iE8jTGCSSM7FshVaCZKTIBQDpFXgV3ES+xclShaS7JrvV
   mYMirhbpI0lDAd+bCSAsSy2FmZHsBgBnvQYDNNl+6Uk/N5TQtjlQb2g5K
   +uRwqegcBmiWqMTUcD0X7e3et7UR9bm+c5VpCtMc9KkzWUucvW6DdUqKZ
   42zhh3zVxKRkrsKI8AqBCpUxQ7TFYU9Fokc7FMK6L3TzV6lms6/1PHkep
   Qr7XDtpL4gSGEH6dZc1QX5vA7ga9UYUP47heGAfMQ/nIY9R1Zj67fUOL6
   VcfEmJ/3X+UvqWALwv0tj90uqfnMAEy8HlJsL7STYsXw1UV3jn0nzkREr
   g==;
X-CSE-ConnectionGUID: 2Ud1LrFXRr+iu+uUPXPR2w==
X-CSE-MsgGUID: VIyvxnj9ReKG/HfWYQXFXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8698114"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8698114"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 04:03:40 -0700
X-CSE-ConnectionGUID: 3Ibp+FXhRzya5MRcf5MVig==
X-CSE-MsgGUID: zvXo1qisReSOzfHnmLrEpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27380694"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 17 Apr 2024 04:03:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5678021A; Wed, 17 Apr 2024 14:03:36 +0300 (EEST)
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
Subject: [PATCH v3 1/9] spi: pxa2xx: Allow number of chip select pins to be read from property
Date: Wed, 17 Apr 2024 13:54:28 +0300
Message-ID: <20240417110334.2671228-2-andriy.shevchenko@linux.intel.com>
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

In some cases the number of the chip select pins might come from
the device property. Allow driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 2f60b2fde8d5..ab6fd55237cd 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1357,6 +1357,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct ssp_device *ssp = NULL;
 	const void *match;
 	bool is_lpss_priv;
+	u32 num_cs = 1;
 	int status;
 
 	is_lpss_priv = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv");
@@ -1395,8 +1396,11 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		pdata->dma_filter = pxa2xx_spi_idma_filter;
 	}
 
+	/* Read number of chip select pins, if provided */
+	device_property_read_u32(dev, "num-cs", &num_cs);
+
+	pdata->num_chipselect = num_cs;
 	pdata->is_target = device_property_read_bool(dev, "spi-slave");
-	pdata->num_chipselect = 1;
 	pdata->enable_dma = true;
 	pdata->dma_burst_size = 1;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


