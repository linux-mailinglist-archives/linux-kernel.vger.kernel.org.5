Return-Path: <linux-kernel+bounces-162205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C108B578F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C701F242E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7F77C6CC;
	Mon, 29 Apr 2024 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LX6crxyU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F157BAF0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392582; cv=none; b=Uiu/HaYxqThi/YpI6OD8e3WDupM8Lam4cuuUooUmT9Dq8Llule0/p3m5XIWvHiB19dVHe5y/c74ZWrejBf3Gp1MNG5It15X41AZssfEXfQTM2m8crNEpqcGQsuqD6y+P99xZjuLPxNBU3wDcSyTN9SGofcu+h3H/kzUSfjyz5lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392582; c=relaxed/simple;
	bh=XHEQAft4tZaQ2JdNqTSsJ60xy1/uNy4H7i3u5WPmZVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+kfgVEWnqCRkf6UgfIlzz0QTlKwZXlNEMpf6gkFYQaZG/GUN6jpiicUHGDtb2XieAQti7kQ6c+5mQtUkVYKY/73eBv5Z7lYI3OZlJfqMv+0o/+FzMu681fScj+BCbBHJzqPR53qu1aGzF3DwpHTNRPIeqr0y5JjsdubqGPysU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LX6crxyU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392582; x=1745928582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XHEQAft4tZaQ2JdNqTSsJ60xy1/uNy4H7i3u5WPmZVk=;
  b=LX6crxyUDHH60d1smChuQaPDWHvYwGqNVVEuYIdrHZX0U9j+dNmPD8d9
   XFdVNy6NPN8QGm4VE7pXhFd/0g7KxGY1vJZTW5EVjlmHDHaInXqBWQD1m
   MTreowtuRM87/Ot4UiusJMtYn7Sals5ZFvLeQX/ebNASc5PvlqzJN5ZWu
   GlmzPzJ9SytyFd+94c/LQ3mVCyPbuhn09OJu51FsFqTvTVN/6BFst584o
   6Og9XHMVdSgRazAJ1E9p6m/T1rtlZN+RPlHLteStAOKiqLPJ4njS6CgFN
   2QSqGK6ryMS4JFz5qD/c+Y5o/5lFb18+0g1fdHfBJQNdZuAmStg0rWH61
   g==;
X-CSE-ConnectionGUID: QJdr9GNZSkeytM+7yWo9OA==
X-CSE-MsgGUID: FmOOn1M+ThaIIoOPedxtnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9908290"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9908290"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:09:41 -0700
X-CSE-ConnectionGUID: PJE1vwbLRg6Jcp8QmDf5LA==
X-CSE-MsgGUID: Dw/naGPRSFCY9zv9oRLF0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26166667"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2024 05:09:39 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH 14/14] intel_th: pci: Add Lunar Lake support
Date: Mon, 29 Apr 2024 15:09:08 +0300
Message-ID: <20240429120908.3723458-15-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
References: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Trace Hub in Lunar Lake.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
---
 drivers/hwtracing/intel_th/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 0db8ff9b1c48..0d7b9839e5b6 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -324,6 +324,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3456),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Lunar Lake */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa824),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
-- 
2.43.0


