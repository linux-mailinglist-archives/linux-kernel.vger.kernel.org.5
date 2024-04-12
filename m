Return-Path: <linux-kernel+bounces-143229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48188A35F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BD61C21795
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2797414F9F5;
	Fri, 12 Apr 2024 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvsD2jfB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC014F9D7;
	Fri, 12 Apr 2024 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947679; cv=none; b=YPKogkPU0//Nhw43SiV+sUB/9xS9QEg85paA/HsFRTxo9vVrxH85jDi7eFk5z2nl9vvYIYxUUCYiQlSAgweBhAj/ulbJ8PrYY4569gmk/SFEi1S87xuBY1L0pkz5Mprz75dWkFIbuMJCDpTqyJZxjWCfPtvvcWcwZlJA4fTO18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947679; c=relaxed/simple;
	bh=qNwaH9FoWBTAdA5ghiLL6X1/WsUFM5GWDUFnPLH5qSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPlEI5AZSH+RB3n01HlXImGluT2ePqSR9u3uknA+xQTkxLNMB0NFr75IUfBvLb8DS2HIiekNjBmVJ1ZO3si71quav1tliwm/SZZaHK4zLRQDtCofbXZWyAmGa4N+OkwmrUxGeEpAfXnHjp/w48s4tfk0o7btkM7DT9MDLtwbQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvsD2jfB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712947678; x=1744483678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qNwaH9FoWBTAdA5ghiLL6X1/WsUFM5GWDUFnPLH5qSM=;
  b=PvsD2jfBBcSBZchkQThnlaBrdmCkIpO0X4Yg4BSZKB/wFUjN2SB9h0Ow
   8TqQMpoWWnYeXJ2yRIEEaUgJYhGFS12HOe0AgZNH3sHlrlPHPkNp+D0IF
   18keApwAKWEO/uBUTFU3uNNaEXwLcsrmcKMOKsNVw9meZ4D31RgnYE6D4
   IFgj8SIHEKqzj11ZXvZiW5+crkJWYxsvGERPn39EK77BIXPbt+tNQ94hB
   iSM3Uq40oLYgtNFFpvk3rKh7D496c/wVgXvU0GswSphEIlTz6HZhPFR1U
   m0AJGk8uKwUzkIPJOSJXScv6Zg/5n1+QO1gytFmbsomTCdGfRMw4lQNFa
   g==;
X-CSE-ConnectionGUID: ptA1TsM4SsSXPZqRh27TbQ==
X-CSE-MsgGUID: H2yytqZWRWm7AWjf2wr83A==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8333189"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8333189"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 11:47:58 -0700
X-CSE-ConnectionGUID: pj9FaUm4SIWVi/UmnAvSsw==
X-CSE-MsgGUID: 8U1PKzKvTKmf/o+lukE73A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25856201"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 12 Apr 2024 11:47:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 249612BE; Fri, 12 Apr 2024 21:47:55 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 2/2] mmc: sdhci-acpi: Use devm_platform_ioremap_resource()
Date: Fri, 12 Apr 2024 21:46:21 +0300
Message-ID: <20240412184706.366879-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240412184706.366879-2-andriy.shevchenko@linux.intel.com>
References: <20240412184706.366879-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct resource is not used for anything else, so we can simplify
the code a bit by using the helper function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 32ae6f763c1d..b9c8eb87a01a 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -779,8 +779,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	struct acpi_device *device;
 	struct sdhci_acpi_host *c;
 	struct sdhci_host *host;
-	struct resource *iomem;
-	resource_size_t len;
 	size_t priv_size;
 	int quirks = 0;
 	int err;
@@ -801,17 +799,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (sdhci_acpi_byt_defer(dev))
 		return -EPROBE_DEFER;
 
-	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iomem)
-		return -ENOMEM;
-
-	len = resource_size(iomem);
-	if (len < 0x100)
-		dev_err(dev, "Invalid iomem size!\n");
-
-	if (!devm_request_mem_region(dev, iomem->start, len, dev_name(dev)))
-		return -ENOMEM;
-
 	priv_size = slot ? slot->priv_size : 0;
 	host = sdhci_alloc_host(dev, sizeof(struct sdhci_acpi_host) + priv_size);
 	if (IS_ERR(host))
@@ -833,10 +820,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
-	host->ioaddr = devm_ioremap(dev, iomem->start,
-					    resource_size(iomem));
-	if (host->ioaddr == NULL) {
-		err = -ENOMEM;
+	host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(host->ioaddr)) {
+		err = PTR_ERR(host->ioaddr);
 		goto err_free;
 	}
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


