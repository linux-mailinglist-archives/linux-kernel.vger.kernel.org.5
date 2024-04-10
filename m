Return-Path: <linux-kernel+bounces-139307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22108A0137
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8881F22EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6FB181D06;
	Wed, 10 Apr 2024 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCfujnxG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83593181B9F;
	Wed, 10 Apr 2024 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780573; cv=none; b=H4OjbGD3SONcZlxEZlbx2MgjtWTj+i3O0guVW8qyS0bwvEsNYnrq4r2xyfPPhY7EoB4XYrN0uLll1wTaO6w5MjWrlTE2LEhwPq6+nSKrlqpmiZoDmMyrneOoruMGZ1aQnSvMFE4CLeg+mGsL4OtEAnbk4sn4UqTeWpYt7d6DwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780573; c=relaxed/simple;
	bh=+2HZiSpbT1DVyz7ooUfdwbZ8UU3WoCwyFIEyBe958GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XA3WMHycOdxeex85SyeH843xWulnCjve6DX+vG/P9Lx+xhjcjMJwYOcJOwM8d0XosQBI0u7RBKxnhVtD+nqNxn+dtu0TyXXMEUQoXlosJhKW9gfQlmN2j+mdBMXmNzGGEmvjRdB1hAJGeHTGzc2Fn/3fdF2oBjcYHQkmuTUP+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCfujnxG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712780572; x=1744316572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+2HZiSpbT1DVyz7ooUfdwbZ8UU3WoCwyFIEyBe958GA=;
  b=ZCfujnxGzGWChA0Y5gn1wQyt5f2DFfsJSugi21PgmnPf+CGG9TR8hvAf
   mpBt2Lf/I5D616uSqmb+DCMRyBhVN7c8b8d/ivHaQrFo4mAiUp10UYJPx
   IbXC3ERvpJM0/FJ7s3sBGAoErakiPWe4zyOFu8kFcsqaZx0MO6zFLEkX6
   40v6sZ+YVQ9mXIJhgO9OFiAegJeUcSUJQJG3GX4GF+MVE32H8dfPxggwr
   YMgkltadyjfd0MvFAg2Qcj1m+XhovhRu2hJaJeuQ5BLTxynNei981ZOxF
   srEXpmpYJDV3VhjxFvmFhGUxD6Kl2+fRXzHms7tn7D1/NYnBrRCCZlwAX
   w==;
X-CSE-ConnectionGUID: WLf2weKlRP6MDlkwmbPmJg==
X-CSE-MsgGUID: CkU6Te4tQdCYvDA/0+nn7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11960669"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="11960669"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937095429"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="937095429"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2024 13:22:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 14B151A6; Wed, 10 Apr 2024 23:22:45 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH v1 1/2] gpiolib: acpi: Remove never true check in acpi_get_gpiod_by_index()
Date: Wed, 10 Apr 2024 23:21:46 +0300
Message-ID: <20240410202243.1658129-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240410202243.1658129-1-andriy.shevchenko@linux.intel.com>
References: <20240410202243.1658129-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The acpi_get_gpiod_by_index() never is called with adev being NULL.
Remove the redundant check.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 7f140df40f35..f596edf89451 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -873,9 +873,6 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 	struct acpi_gpio_lookup lookup;
 	int ret;
 
-	if (!adev)
-		return ERR_PTR(-ENODEV);
-
 	memset(&lookup, 0, sizeof(lookup));
 	lookup.index = index;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


