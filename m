Return-Path: <linux-kernel+bounces-141400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4202C8A1E22
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF43BB274E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E0D537F7;
	Thu, 11 Apr 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnnxGZNU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B650A77;
	Thu, 11 Apr 2024 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856404; cv=none; b=WtpiUiRD1ghXqCafy1Uq2rsuNytlDRiRhKftRzhYzXCoyNGnzzOwdomzSHamFaNq5LDjaH1LCSY61ZyIs/7TqM2YeTliz1RjMZP9iAR94iOd+s8CRX9OoqnC/kV/XqIZcjH5+8KzvLrmLsTFtCXNZ9TONhNnEGlsa6uejFDSMWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856404; c=relaxed/simple;
	bh=mkcaxfIAu8Shkk3u4f6ITrX0al+FrzCJ1eyBmzPJWoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dm+9auKEbcevnUrDUckQsvP1OdYzdeKrIgx1Xst5qAaLW8pAjMStVxrFW+/Ec7jvGGWGjHq/hIqk+QT2X7otHUNpImCk+RR2WPtpWYGl11XraAQXxorxHkwLXw8VGeu5ElAXogixXrRPJhKN/Y5Y/F4OvIfgf1IgHcAy+/KZBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnnxGZNU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712856404; x=1744392404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mkcaxfIAu8Shkk3u4f6ITrX0al+FrzCJ1eyBmzPJWoo=;
  b=cnnxGZNU3xxMElhZGYp6aDVOvkVvxJQuFJr5mCZyhFdxwnZpi4stAGfG
   8lQWbQFctO1NIyw8zioiChXAI+ZGKQ3Q+OGcfMaMpti+2WSaSt+Ju4vNo
   jotbmDysUT6u1GRrMBUhIgiacMuM+qiqBWOIM2vn8vhp0JSEbkvMU1PwM
   AmcwgTY7KzgncXO0jcoVcOqzkIs2ne4LBCCq7Dc8Po3Cetusa3LPJuWB6
   lf3/oOB8dD174lmAk5jnwHRvMzdTIIAZIa2kqyvd3BAuUmzgnXjl97iu+
   SmSkxlxunFKYs6ifrk/4wpZWu4R/ocJPOPI+NQNf8x0gHBfEiJMZ/YPye
   g==;
X-CSE-ConnectionGUID: NRO8WPnCS+Sl99JdXQnPGA==
X-CSE-MsgGUID: U/tu2Y4SSZmgBguKyKPF4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18845023"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="18845023"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="937097276"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="937097276"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2024 10:26:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1C123374; Thu, 11 Apr 2024 20:26:34 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Thompson <davthompson@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 2/4] gpiolib: acpi: Simplify error handling in __acpi_find_gpio()
Date: Thu, 11 Apr 2024 20:22:30 +0300
Message-ID: <20240411172540.4122581-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240411172540.4122581-2-andriy.shevchenko@linux.intel.com>
References: <20240411172540.4122581-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we don't perform anything on the GPIO descriptor,
we may simplify the error path in newly introduced helper.
Do it so.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index d47b22ac3ecb..fb2e14670b7a 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -974,20 +974,14 @@ __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int
 			return ERR_CAST(desc);
 
 		if (!IS_ERR(desc))
-			break;
-	}
-
-	/* Then from plain _CRS GPIOs */
-	if (IS_ERR(desc)) {
-		if (!adev || !acpi_can_fallback_to_crs(adev, con_id))
-			return ERR_PTR(-ENOENT);
-
-		desc = acpi_get_gpiod_by_index(adev, NULL, idx, info);
-		if (IS_ERR(desc))
 			return desc;
 	}
 
-	return desc;
+	/* Then from plain _CRS GPIOs */
+	if (!adev || !acpi_can_fallback_to_crs(adev, con_id))
+		return ERR_PTR(-ENOENT);
+
+	return acpi_get_gpiod_by_index(adev, NULL, idx, info);
 }
 
 struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
-- 
2.43.0.rc1.1336.g36b5255a03ac


