Return-Path: <linux-kernel+bounces-143230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578A98A35FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6804B25090
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B371509AC;
	Fri, 12 Apr 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElOCP1UC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914DC14F9E5;
	Fri, 12 Apr 2024 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947681; cv=none; b=F7ZcgkJfk7IboM+5B4e/kxg/3YDjY/HJVuVA6oQIHhjCf/lVTr66AA4T2VR2HnOFBolg32oTyJYogRi29NAUoawewPaIIRdVv2AwgbyAwr36N6TFiEuEpwE+dHooFLkyrZ1/MRFzkXv7mdP6BR0LXpBuFvZJQskqR9CMYA2JN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947681; c=relaxed/simple;
	bh=keDoBh4N1bcwvDCmZ/4Sw+askjtG52PpwtQLSYVexTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ia7GGHywZWvt7i+zx/qpeGCONErMZHVaJKjoyO40HDOGF+YyB1OG24zlr9V7Oei1L8F4d/mzgEtYKJuexCPLOu0bvwNQ00EdPY6t1N1Lpit9UGwYBcRdhTIzv7dJcebGmgrO9TLerQi+PCVokVw/VlbSvLFHbQlxxOH3hWoWy/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElOCP1UC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712947680; x=1744483680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=keDoBh4N1bcwvDCmZ/4Sw+askjtG52PpwtQLSYVexTQ=;
  b=ElOCP1UC4ZsgzfZ3HdgyBeo4lfhKL/rnGiNV4PvV+1CIyGTXptYzytpj
   hA35PsB3aIq68Pyg5HXGammFNbNB+JwQGvRSi6sWaV4mmV95joJ3VSEE5
   xdaX190NIEC0NJdzu1OMNJ5Da6KXV5opjeILP86Chg513m8VqBvKamnKV
   doI4e5iUO+VgcUjkQIN38J1TpKZd14eRSbGfv/ofNIw21G/0ci8/h+lXG
   /viweyr29WlCl2M//cKsTmEgfSfP+JTSJZ/Y3eq+2hnX4gM6pbjF1P46y
   LL0J3116gv5DTvgT00ZwpEo9bo2y65i5FmasezMHJSTeuJR6L0dxdmz5F
   g==;
X-CSE-ConnectionGUID: 3yq5Mk9pT0iWRWEPfkfb+Q==
X-CSE-MsgGUID: BNIcyvTvSDigDinWNKNvHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="12204630"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="12204630"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 11:47:58 -0700
X-CSE-ConnectionGUID: naEweZgzSYu3OoKG3qx0FQ==
X-CSE-MsgGUID: 5Xuofn8YRf6H/gbqBXlGKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="58725386"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 12 Apr 2024 11:47:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 13977FF; Fri, 12 Apr 2024 21:47:55 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 1/2] mmc: sdhci-acpi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
Date: Fri, 12 Apr 2024 21:46:20 +0300
Message-ID: <20240412184706.366879-3-andriy.shevchenko@linux.intel.com>
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

SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
and require an ifdeffery protection against unused function warnings.
The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
the compiler to see the functions, thus suppressing the warning. Thus
drop the ifdeffery protection.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index acf5fc3ad7e4..32ae6f763c1d 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -957,8 +957,6 @@ static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
 	}
 }
 
-#ifdef CONFIG_PM_SLEEP
-
 static int sdhci_acpi_suspend(struct device *dev)
 {
 	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
@@ -985,10 +983,6 @@ static int sdhci_acpi_resume(struct device *dev)
 	return sdhci_resume_host(c->host);
 }
 
-#endif
-
-#ifdef CONFIG_PM
-
 static int sdhci_acpi_runtime_suspend(struct device *dev)
 {
 	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
@@ -1015,12 +1009,9 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
 	return sdhci_runtime_resume_host(c->host, 0);
 }
 
-#endif
-
 static const struct dev_pm_ops sdhci_acpi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sdhci_acpi_suspend, sdhci_acpi_resume)
-	SET_RUNTIME_PM_OPS(sdhci_acpi_runtime_suspend,
-			sdhci_acpi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(sdhci_acpi_suspend, sdhci_acpi_resume)
+	RUNTIME_PM_OPS(sdhci_acpi_runtime_suspend, sdhci_acpi_runtime_resume, NULL)
 };
 
 static struct platform_driver sdhci_acpi_driver = {
@@ -1028,7 +1019,7 @@ static struct platform_driver sdhci_acpi_driver = {
 		.name			= "sdhci-acpi",
 		.probe_type		= PROBE_PREFER_ASYNCHRONOUS,
 		.acpi_match_table	= sdhci_acpi_ids,
-		.pm			= &sdhci_acpi_pm_ops,
+		.pm			= pm_ptr(&sdhci_acpi_pm_ops),
 	},
 	.probe	= sdhci_acpi_probe,
 	.remove_new = sdhci_acpi_remove,
-- 
2.43.0.rc1.1336.g36b5255a03ac


