Return-Path: <linux-kernel+bounces-162204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCB88B578D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED125287C50
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873EF7BB11;
	Mon, 29 Apr 2024 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zat8eIaF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D984762DE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392580; cv=none; b=bvPPWKnAy5iLw1TsxSA9MIIIwkbm5R6HGRPmGb+Lkd82eDW8O38sekTtdSFkN3us6YCQO0ZS7rL99CLHT3C/CbrFR1ZkXlB4w7xNEV0ZTvktseHsELgBaO2WgtS7k1RONsVmDBR4wxtATSnMmNSBVX8df6AYIoiEmtDdYt7ndLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392580; c=relaxed/simple;
	bh=4mjB5jRD2LZdYg+WgATpyA8orwgL1dsnFryoaxKiQOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUOpW5ckTFgwNR4fcdN+5MRlQcuQb2oox/jIMSqpBn3Sx1dow2SdA6MPIc+Gp4pPQYcINVzUK+wQj6baI1wsbxcUVQq2hb5CKjH2TFBVxw5kPV8Vbz7Ykenks7+vYrX5Q2qXkELyqZQxRyUDuLY4BauoZGCgkK8AxluUt/7qpbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zat8eIaF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392580; x=1745928580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4mjB5jRD2LZdYg+WgATpyA8orwgL1dsnFryoaxKiQOw=;
  b=Zat8eIaFTGcBmM+fxqNZRvJ634Aza34jgb2/8q+fVhkRT49ozMLAlJ8y
   yphc0oX1MpuGOYqZwgPXN7XtdjR3WLGIwX1w6z2gj5gMdhB3HNs+8/Hqo
   gileqH8Ps/JYf2JeWoM4ahFTX6Y/9xOby7BdLylYdDW2bZNn/T1wvl0VD
   DzETL0ZoUSjAKz+jZ7iayKusPqA2/rFxNv5KX5u2BhKj67M4bQET/HAYd
   capZyfB0dr2h8LSkVxTMv60coE7Fvh1I8YMM3LukYy0RRapIOHwi42WZU
   /XlHxO5vJ6yvst0xKEBSU/5o22iHzY6JdQyMi+2SA0kCQimA9FpvcMErU
   A==;
X-CSE-ConnectionGUID: JiYb3dvhSgi87nObjrBBiA==
X-CSE-MsgGUID: RVqhXVepR7KjJtZ79IJMfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9908286"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9908286"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:09:40 -0700
X-CSE-ConnectionGUID: bOcKuZJhTXKaZsjDJZIgrA==
X-CSE-MsgGUID: 3gLlW+INTwmiGs0yEJgsjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26166663"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2024 05:09:38 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH 13/14] intel_th: pci: Add Meteor Lake-S CPU support
Date: Mon, 29 Apr 2024 15:09:07 +0300
Message-ID: <20240429120908.3723458-14-alexander.shishkin@linux.intel.com>
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

Add support for the Trace Hub in Meteor Lake-S CPU.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
---
 drivers/hwtracing/intel_th/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 7bb50d414027..0db8ff9b1c48 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -294,6 +294,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7f26),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Meteor Lake-S CPU */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xae24),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Raptor Lake-S */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7a26),
-- 
2.43.0


