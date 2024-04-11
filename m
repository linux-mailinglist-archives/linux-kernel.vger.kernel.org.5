Return-Path: <linux-kernel+bounces-141397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F868A1DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D401C245DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756A14AEE4;
	Thu, 11 Apr 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WC28LqO8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9DD18050;
	Thu, 11 Apr 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856401; cv=none; b=lj0KHv+9Eo+e64KwQPfdrdYj67CJamqT0+eOjL8WVpCcsD08CjKna5rlH9QA6cr0XqsU2kAa9VuJBq4yqXEbL1aDGUVIzGQTufLjXA2QfqQTrpTXtRkdKQaWJIIaN6r4B3H0K0ZXxtlldxvYhKQrP/nXYfyWgAB2CwS56j750uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856401; c=relaxed/simple;
	bh=A2+jXtS5g8HA0A8/2hmcMBqno1MQ7oBHc6IPFkKw3e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=om549zUD831/F28DxPqXQ/WGvj6F6pYOHsUcqpNffHCddUbtt9qJwI65Q8yx9qq/C2tqB0VFt4CYW/JE+af4OnfE+5qG6VNRETcCrCvL0qNqI5MLcmRRnBY0tvsgyO052uWLOjOWYGHR0G02yu3NTngbpEl8Nkj+zatMkIvn6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WC28LqO8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712856400; x=1744392400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A2+jXtS5g8HA0A8/2hmcMBqno1MQ7oBHc6IPFkKw3e8=;
  b=WC28LqO886XPiO9g611lcP4THsUDjjmeQEAtQ19xypW59zlhD2FtatuK
   lwZGg7RpTQVLx5H5rfcyElOZqmjAiGpGT+g2GwmYb4L5pSIePuKa7jUQ3
   g1KM+YD1MtRZlOjAmzXU1PgnHe+Fp+v+d19M8elF53Y1BnSzv6WMDKfID
   MW8Tv7j7gPnnWVn5Uacw8IobRJKfcbqDuUqgEtzZ16hAIDy1eQjV/8M0w
   AvEtAlR1kHaRB3AI2n+c3ey954VVGH1km7DpXzxco2DqQBcKBuyn4EFfC
   que0V9KNsVIG1m3q0UR+4CqPhArSv3k593JcTbqPMPURnQNQ5ENmiaXQQ
   Q==;
X-CSE-ConnectionGUID: VQclX42vR0aiFqbXrUtmuA==
X-CSE-MsgGUID: RNyzALCHRhyv78PLv4d8tQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18844983"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="18844983"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:26:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="937097272"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="937097272"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2024 10:26:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2B32C4C5; Thu, 11 Apr 2024 20:26:34 +0300 (EEST)
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
Subject: [PATCH v1 3/4] gpiolib: acpi: Move acpi_can_fallback_to_crs() out of __acpi_find_gpio()
Date: Thu, 11 Apr 2024 20:22:31 +0300
Message-ID: <20240411172540.4122581-5-andriy.shevchenko@linux.intel.com>
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

New coming user may need to check for _CRS fallback slightly differently.
Move the current check out of the helper function to allow that user to
use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index fb2e14670b7a..2b3fd43b13fc 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -947,7 +947,7 @@ static bool acpi_can_fallback_to_crs(struct acpi_device *adev,
 
 static struct gpio_desc *
 __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int idx,
-		 struct acpi_gpio_info *info)
+		 bool can_fallback, struct acpi_gpio_info *info)
 {
 	struct acpi_device *adev = to_acpi_device_node(fwnode);
 	struct gpio_desc *desc;
@@ -978,7 +978,7 @@ __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int
 	}
 
 	/* Then from plain _CRS GPIOs */
-	if (!adev || !acpi_can_fallback_to_crs(adev, con_id))
+	if (!adev || !can_fallback)
 		return ERR_PTR(-ENOENT);
 
 	return acpi_get_gpiod_by_index(adev, NULL, idx, info);
@@ -991,10 +991,11 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 				 unsigned long *lookupflags)
 {
 	struct acpi_device *adev = to_acpi_device_node(fwnode);
+	bool can_fallback = acpi_can_fallback_to_crs(adev, con_id);
 	struct acpi_gpio_info info;
 	struct gpio_desc *desc;
 
-	desc = __acpi_find_gpio(fwnode, con_id, idx, &info);
+	desc = __acpi_find_gpio(fwnode, con_id, idx, can_fallback, &info);
 	if (IS_ERR(desc))
 		return desc;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


