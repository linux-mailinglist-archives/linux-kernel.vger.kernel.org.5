Return-Path: <linux-kernel+bounces-10259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DDF81D1DA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B23B1C22C73
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A7046A2;
	Sat, 23 Dec 2023 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkEgz0I4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22A8A5D;
	Sat, 23 Dec 2023 03:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703301952; x=1734837952;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=jkEFHjFRPU7A7ZnDq0tXdEmYBD2JEFf7YtIg/EJSCYE=;
  b=QkEgz0I4w8g5WJ/ZySSOFMJTZwYApiamzUt1Sb0659ARCJCZniiM6J34
   dhrtVSmTkEurVry1qo2XzFO12pZ5ZTpgxrIv4gLQix+L0DhPPonKCLWh4
   vsxYfldO4RoRTGFUezabiIpB+GZ9PbdyMkwYLmD4xPmj4d89F/cG4D/v4
   QXouEjAp0jS0abDuvMKZvzBH34qWOkg3MdYCVC3sNUr8QX3/mpWc4+thT
   cMrK6702ytDinjGbSx4In+tk65LXnMJV3Xfacwpn4i2E8I3KJsnFB171s
   LKbYB5QZwRRPGblSzQrudjXAectmPUMpxnwvU/HMjjObYd5yw/IhZD1OD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="395922869"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="395922869"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="1024436817"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="1024436817"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:51 -0800
Received: from debox1-desk4.intel.com (unknown [10.209.86.110])
	by linux.intel.com (Postfix) with ESMTP id 81455580C4B;
	Fri, 22 Dec 2023 19:25:51 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] platform/x86/intel/pmc/lnl.c: Remove probe time LTR ignore
Date: Fri, 22 Dec 2023 19:25:42 -0800
Message-Id: <20231223032548.1680738-3-david.e.box@linux.intel.com>
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

Remove the probe time LTR ignore for Lunar Lake.

Fixes: 119652b855e6 ("platform/x86/intel/pmc: Add Lunar Lake M support to intel_pmc_core driver")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/lnl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index 88b35931f5df..fe97ad09a1a6 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -536,12 +536,6 @@ int lnl_core_init(struct pmc_dev *pmcdev)
 
 	pmc_core_get_low_power_modes(pmcdev);
 
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
-
 	if (ssram_init) {
 		ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
 		if (ret)
-- 
2.34.1


