Return-Path: <linux-kernel+bounces-162315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991658B597B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED4EB2C15E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF1280604;
	Mon, 29 Apr 2024 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMMtTJfn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BB67F48C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395727; cv=none; b=qkIrBTLfNC11LjFHu2PiU0pTA0qjOQ1w6AvZeS1SbUOwoND6s6EdD6fZZpSvKSMfoKpkmU2Pq/nNejzekEvKPN/XmjkSwmljn/KGdGMoNQKBd1062nx/GbCTpR6VdS/OiNpWTjYAd5/5k8yA5DDRQXplZ0Gfluv+HgYXccw23Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395727; c=relaxed/simple;
	bh=wLYBlxedLAthkJZqqlPpyzb7ig9rN7jLeqrZ6Jbe1HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHNMEpDybM3Nw+/rof5rtlHW6hyyruRppOHfx7fFJAi/zp0NZKxkU1B7orl8wj1MxnnDIUFz4HZ8oc772Oji1lN43WJDOIdO95mQoAueDV1YeyfXWuktgom9+WNxUbBudbRoddGvdjr2aqzq1STApeomiSj7883X4M/7LRZjD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMMtTJfn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395726; x=1745931726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wLYBlxedLAthkJZqqlPpyzb7ig9rN7jLeqrZ6Jbe1HE=;
  b=OMMtTJfnE//xJnemWa+V6o4DPfrVssxx3CM5I6ctbFQIQgSk3wKR3dmn
   1xqh0cu2IFHT0p46n5Mh6+LzMCxLiqmF8IICYISgpmPSA5lsxFXgyQiE0
   sGzB0mg8a2gmWuGQ9HqBZNg5W6IOCB0AYCtuMsXLcgq+loSA9U86Jmvjc
   qRbYksqnysxjvCi9OSKN5fES/V2ApeI4Uq+sxzYxj852Sz0hFfDkn9B9u
   2hYJ3TCLnxL5E0k8SB4N675/5CfyF2Q4puXyXoF2hRmPGBEn2YgXHyWEU
   XMvs/h/5PNzTcHe7tY2nzSks8h0jKWgxESPDSjNPMoRUuhj8X6Qp1QW8Y
   w==;
X-CSE-ConnectionGUID: WvtpcqVsQWqFLNM+gWUh5Q==
X-CSE-MsgGUID: jhzogL1KS7+LSskHfAze4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986956"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986956"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:02:06 -0700
X-CSE-ConnectionGUID: MkqZ6cdRTymCour0pe9o+w==
X-CSE-MsgGUID: uKbvR911SqyRL4W/Vh+tbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507201"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:02:03 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH v1 12/15] intel_th: pci: Add Sapphire Rapids SOC support
Date: Mon, 29 Apr 2024 16:01:16 +0300
Message-ID: <20240429130119.1518073-13-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
References: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Trace Hub in Sapphire Rapids SOC.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
---
 drivers/hwtracing/intel_th/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 44c08db253d8..08c956fb4995 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -309,6 +309,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3256),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Sapphire Rapids SOC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3456),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
-- 
2.43.0


