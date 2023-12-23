Return-Path: <linux-kernel+bounces-10260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEBF81D1DB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B0FB23547
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D4F4C6B;
	Sat, 23 Dec 2023 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCMzG6dp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDE0EC2;
	Sat, 23 Dec 2023 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703301953; x=1734837953;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=4ou10im8zAAuh8Osc8zLhJTnU2+5FYfBMeulq5VgZUo=;
  b=GCMzG6dpvHW426LwhY71d6mRoDR4BQA7FSL6VR5tBOHkD5TQh9r7mEOy
   Gf0HqZtY8QNcznMYYCccVhxigGZ1hvEoVRvVCZCdowAkXUoDfjWRNpK41
   L6heJc2tU2BMxxUw0vSH7mic0Mh4Q3sGz2MNcjogRzbBilkR+lR0r8Uyd
   GYCGKJgEEvhenNVuO6ADvm3Xr72qZB/+gmeyOrZcRiAFEdzMV/O+CaUNj
   BpaKbLtcFNVDosMUFNxtZANSaNXYukW42FvHHFbWsWpYHKCOObvy0qjvD
   Ctab8wGHWgnMhNbq5mNqTyPydzH6ozRZhh6VIwwQ/EZPQ6pzl22f1eBcA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="462619290"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="462619290"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="811534574"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="811534574"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:51 -0800
Received: from debox1-desk4.intel.com (unknown [10.209.86.110])
	by linux.intel.com (Postfix) with ESMTP id 48125580DB9;
	Fri, 22 Dec 2023 19:25:51 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] platform/x86/intel/pmc/arl.c: Remove probe time LTR ignore
Date: Fri, 22 Dec 2023 19:25:41 -0800
Message-Id: <20231223032548.1680738-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231223032548.1680738-1-david.e.box@linux.intel.com>
References: <20231223032548.1680738-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the probe time LTR ignore for Arrow Lake.

Fixes: f34dcf397286 ("platform/x86/intel/pmc: Add Arrow Lake S support to intel_pmc_core driver")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index c20506a9f4a6..31e1fa538e32 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -716,12 +716,6 @@ int arl_core_init(struct pmc_dev *pmcdev)
 	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_punit_pmt_init(pmcdev, ARL_PMT_DMU_GUID);
 
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
-
 	if (ssram_init)	{
 		ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
 		if (ret)
-- 
2.34.1


