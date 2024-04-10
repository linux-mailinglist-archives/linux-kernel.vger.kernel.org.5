Return-Path: <linux-kernel+bounces-139308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E10BA8A0138
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF9C1C23BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64B3181D0F;
	Wed, 10 Apr 2024 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1AVp7hr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF6181BAD;
	Wed, 10 Apr 2024 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780573; cv=none; b=VZ0fw6eNdIESWpBwyuQQw41KQNykeV7obpXKuPj01p5xtFu3FARFI4ihY7Rk8Kir7G5SiI9wsfInDddnxR5yu3SARaUaGWP5troH3Qv+a8sYd668HI6fUtAES0xCvee5Jx7riglnkX0UKYgyGfgiY/CKT9FWnSUt5pUSQbBhQjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780573; c=relaxed/simple;
	bh=5H0HF8xD//yLE+aRbR8R8jTk44h5XWBp8jiK/ynSaT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbNORUwzfcRgdgCbniCAaWPKcOqKY/otkFnG0kyQ/pDZmUeEFla9qeLif+L7sLzyxif6eE4AOVDqNmYaq8ee/6WZ/GMkG4E6EMRjH1dfeo6QB6LGihH9ABQc1y2hB1NRdoS1ghwmsh1UVgzNJeb2FxRrEYCqArOgBMcthMJeZvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1AVp7hr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712780572; x=1744316572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5H0HF8xD//yLE+aRbR8R8jTk44h5XWBp8jiK/ynSaT8=;
  b=h1AVp7hrWpCO9ZrFfCoBRHj95rn3JuUYdHs3E5hYLtxMIyN9ikE8LxdU
   FjQpDz0ANoBHVfdnauaeDm7GyeayzA1ma6VnfOjPTDkm3csN/XTYxQcnV
   aWrsPySG56+oJncijRAEhOEKNhH3VbMyMXAUPwsxFKysBkkSUqtuZCca1
   mDwvMVBmpCEw7mlRSp3Iw1nJyg06Pr1BxUo2wyog8sdgofoS2GK71mq4i
   Q8ken+pLSHEPU0Ck4k7mbm07VXzCKXElYjqvBwMHXyjlPVAKYixbyiusZ
   QfmZ2Pw6lzhbZ1VgTI6lqMrHZ5GISK40+PN/2EiCX6SQBp+s5O5pv9k1J
   w==;
X-CSE-ConnectionGUID: Qb6f3wWpSrOQC+Zbw7Z0+Q==
X-CSE-MsgGUID: 1AqBlvBIQdudGxJiXbDpAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11960678"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="11960678"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937095430"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="937095430"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2024 13:22:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1DEA32E9; Wed, 10 Apr 2024 23:22:45 +0300 (EEST)
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
Subject: [PATCH v1 2/2] gpiolib: acpi: Check for errors first in acpi_find_gpio()
Date: Wed, 10 Apr 2024 23:21:47 +0300
Message-ID: <20240410202243.1658129-3-andriy.shevchenko@linux.intel.com>
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

It's better to parse the code when the usual pattern is being used,
i.e. checking for error condition first.

There is no functional or code generation change (tested in LLVM).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index f596edf89451..c2a33beeec50 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -973,10 +973,11 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 		else
 			desc = acpi_get_gpiod_from_data(fwnode,
 						        propname, idx, &info);
-		if (!IS_ERR(desc))
-			break;
 		if (PTR_ERR(desc) == -EPROBE_DEFER)
 			return ERR_CAST(desc);
+
+		if (!IS_ERR(desc))
+			break;
 	}
 
 	/* Then from plain _CRS GPIOs */
-- 
2.43.0.rc1.1336.g36b5255a03ac


