Return-Path: <linux-kernel+bounces-148337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9E38A811E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896DC283A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B5C13C3EA;
	Wed, 17 Apr 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsNuyFSS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A27213C69C;
	Wed, 17 Apr 2024 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350318; cv=none; b=g/p07EebTMfk2aDdoJxCgmrwo9WP7+emLvEHQqicG+MXEwMkqdEBx+jXvDalF8H6VNBRvxzWjKIbzbARW7wlvylzJPcYj8uVUNt5fSI8NYRYbXKD+NXPmGvwBT/KdBkkvVbCnMtgz0uwFR5PJO5Fi1CGOPr06X1zUpZwbUDJLCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350318; c=relaxed/simple;
	bh=qFxQfFj8nM+zXZv3n7qPVjdJftX+8qyHu76VmZRCiJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGHDcLcPAHMjLCyTies+P8WcAdzhVRXzcm7+wlEiaLzE5fHU+Rk8pqlwCoZb2IOS4ydCABQ0GlG4mweyYqqdqtkKNb8xrK6XVffCAKVr4XltjgTsoblvt4ykjTCBBVdot5n7GOBe6qlmXxE9M4jtIp7z/LLPKfkzNyvImFQHCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsNuyFSS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713350317; x=1744886317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qFxQfFj8nM+zXZv3n7qPVjdJftX+8qyHu76VmZRCiJ0=;
  b=TsNuyFSSShd0bWf7hCKuOK1G/bpgHAS8w7c+Mgo8yfF5mAJovgkEn6IY
   TKC+BidIUws4z9SulG5t4IPjc+hCoRVEVC0Oyl3m0/QdixfyRMEQhuJBd
   E0NCymlpQQwujXh24zjI4YdqoGYvn9TPJO1hMSekH441Dak/nhWX1aPxl
   AfXkvCwaG0mL/vLc7iC3Pu/uEhb1jNpMuNBQZDvBbfcbDGCCfhCgrhPJi
   fI+o3Hm27RonOtGBYZ0lbYOPM6LI5EHgqH/f2VeVvRbyE2ZeAbXh+Udga
   vUPQzqfAx5spM3RzBCaQqC6BI8pXljjBEUgmtJvFcF7KHR4WAMfVisoNo
   A==;
X-CSE-ConnectionGUID: pWgTZoTmTLu4/sAigr4mug==
X-CSE-MsgGUID: J9fzzUshTISZgz69zo2oxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9384042"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9384042"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 03:38:34 -0700
X-CSE-ConnectionGUID: dL8S9in4Tg21QPHBiGf9nw==
X-CSE-MsgGUID: w+jYd2ImTzKIA9UZzKJwMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27257838"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 17 Apr 2024 03:38:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 591B760B; Wed, 17 Apr 2024 13:38:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/2] gpiolib: acpi: Add fwnode name to the GPIO interrupt label
Date: Wed, 17 Apr 2024 13:37:27 +0300
Message-ID: <20240417103829.2324960-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240417103829.2324960-1-andriy.shevchenko@linux.intel.com>
References: <20240417103829.2324960-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's ambiguous to have a device-related index in the GPIO interrupt
label as most of the devices will have it the same or very similar.
Extend label with fwnode name for better granularity. It significantly
reduces the scope of searching among devices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 909113312a1b..0b0c8729fc6e 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1035,6 +1035,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id, int index,
 				  bool *wake_capable)
 {
+	struct fwnode_handle *fwnode = acpi_fwnode_handle(adev);
 	int idx, i;
 	unsigned int irq_flags;
 	int ret;
@@ -1044,7 +1045,7 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id,
 		struct gpio_desc *desc;
 
 		/* Ignore -EPROBE_DEFER, it only matters if idx matches */
-		desc = __acpi_find_gpio(acpi_fwnode_handle(adev), con_id, i, true, &info);
+		desc = __acpi_find_gpio(fwnode, con_id, i, true, &info);
 		if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER)
 			return PTR_ERR(desc);
 
@@ -1064,7 +1065,7 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id,
 			acpi_gpio_update_gpiod_flags(&dflags, &info);
 			acpi_gpio_update_gpiod_lookup_flags(&lflags, &info);
 
-			snprintf(label, sizeof(label), "GpioInt() %d", index);
+			snprintf(label, sizeof(label), "%pfwP GpioInt(%d)", fwnode, index);
 			ret = gpiod_configure_flags(desc, label, lflags, dflags);
 			if (ret < 0)
 				return ret;
-- 
2.43.0.rc1.1336.g36b5255a03ac


