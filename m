Return-Path: <linux-kernel+bounces-158945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B378B2737
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7C61F25375
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229DE14E2D9;
	Thu, 25 Apr 2024 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkWbr/6p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A309B14D719;
	Thu, 25 Apr 2024 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064947; cv=none; b=kG252/c4TlpSkeF3cjsVSDCtAMnMCyXFkqUeNbkM+XZRGaHjPdBtuYgFanWnXOqXTgSVSChjhhzvr8EBwoofZz92XzJYsMPaoy6OQ6c4sVT4xn8n1n3T9ha6Lzbg/Qz2GnivmzsJ9we36wJRAoibDaLDhvaAnctBJdn1o31Qgi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064947; c=relaxed/simple;
	bh=Poecu4f5dpmnBhjDNs+GIeQe2EIjAchr4YDeOe285sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTNAsaWlHisZFKz/qK/kuqXEX2tqNH+FHZtT2D4GKBGZdHvfXxcnHrWQELxAMsA1CksBOnTk7wJw61WxymbM21lH2V+Dd5uCwkRDgM8QBJZFi8gYENebngJ0G8JFrrGFRlOEo/bH2D+rvok6AeLVVsZlaveMeHgY8uQhNdkkq7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkWbr/6p; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714064945; x=1745600945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Poecu4f5dpmnBhjDNs+GIeQe2EIjAchr4YDeOe285sY=;
  b=jkWbr/6pVf+q7nDAdAkQ5Sbbg7NIYIansS9XocwBXSe6K+BBUmJwfB+U
   0AIDbs6iXFHtJC8zY8dtEdBlCBT9LM6OB5T8Yp3EPRvPRD4LKrwDbEC8T
   9HV/vZ6rgGIkkRYQua1T0hzG498ygeQa6CIGAbNOIWXs3+0TsvacqcyNv
   wctkMNaJacGCQBKkUt6nm/D/Q/1vRQR7erPRGS4+cpMHHa59nIZr4qwss
   ouxI2oSm8YubxN89h0q7opeuqweooH+I36oMoA17pTtAjq/zrK7A/pKrR
   Rv+T40HpDAFmdzuiMMVW8zJI2k2tA3N+4KnNTvtm5WqTk4pDImBlIEfZz
   w==;
X-CSE-ConnectionGUID: dXvqx40WQyCbbmFekygugw==
X-CSE-MsgGUID: 0Sqye04VRG+EEohv0dpnyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9618905"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9618905"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 10:09:04 -0700
X-CSE-ConnectionGUID: LqkwhMLARgq9KjVdNaAqPw==
X-CSE-MsgGUID: X+Lavs6MTwqvEI8THCiJtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="29945986"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 25 Apr 2024 10:09:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8B5E75B2; Thu, 25 Apr 2024 20:09:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v2 2/2] mmc: atmel-mci: Switch to use dev_err_probe()
Date: Thu, 25 Apr 2024 20:08:45 +0300
Message-ID: <20240425170900.3767990-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240425170900.3767990-1-andriy.shevchenko@linux.intel.com>
References: <20240425170900.3767990-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to use dev_err_probe() to simplify the error path and
unify a message template.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/atmel-mci.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 9ae3ce14db50..8199d9620075 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -632,10 +632,8 @@ static int atmci_of_init(struct atmel_mci *host)
 	u32 slot_id;
 	int err;
 
-	if (!np) {
-		dev_err(dev, "device node not found\n");
-		return ERR_PTR(-EINVAL);
-	}
+	if (!np)
+		return dev_err_probe(dev, -EINVAL, "device node not found\n");
 
 	for_each_child_of_node(np, cnp) {
 		if (of_property_read_u32(cnp, "reg", &slot_id)) {
@@ -2551,7 +2549,7 @@ static int atmci_probe(struct platform_device *pdev)
 	}
 
 	if (!nr_slots) {
-		dev_err(dev, "init failed: no slot defined\n");
+		dev_err_probe(dev, ret, "init failed: no slot defined\n");
 		goto err_init_slot;
 	}
 
@@ -2560,8 +2558,7 @@ static int atmci_probe(struct platform_device *pdev)
 		                                  &host->buf_phys_addr,
 						  GFP_KERNEL);
 		if (!host->buffer) {
-			ret = -ENOMEM;
-			dev_err(dev, "buffer allocation failed\n");
+			ret = dev_err_probe(dev, -ENOMEM, "buffer allocation failed\n");
 			goto err_dma_alloc;
 		}
 	}
-- 
2.43.0.rc1.1336.g36b5255a03ac


