Return-Path: <linux-kernel+bounces-134118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A56F89ADD3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EF11F21C90
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 01:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7625EC5;
	Sun,  7 Apr 2024 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgaZlXKM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA168A34
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712452544; cv=none; b=A3wQeyjKPfSgOPvjzaHBCtArblU+ksJQ8pwADsxApaK1P9p4wEhBecqQkhLVXfp1z2ML8Qqc/I/ORQXSgydy6alyP0r4bYDyWjPnJXnNx6Bk5KB+gCsAJN4WkK12Yn1mqtQ5WRkmw/Gw324hFNnTS5EBmQ10AIYOthLAYPkwEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712452544; c=relaxed/simple;
	bh=+kujYBSPT2TlGChGH3hiu9gHz9tx2MJoU2QSPezOmKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jAYDvM8X6k1GisktppPFe9VzT9i5u9l2R882yMFDufqH6f91rW5VEksIxIQVBjPU91LQ9bh2hQgKt7UJhks2yPdGLFlbOWElDm/4I4qOsGmqj3XNAwCcMPUEAkKxX6oqwvhFoonbE3l6qY3Xhkj9jHU1bLO65pqDqt9x/clt55k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgaZlXKM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712452543; x=1743988543;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+kujYBSPT2TlGChGH3hiu9gHz9tx2MJoU2QSPezOmKc=;
  b=KgaZlXKMGSieHLselYF+bQnuK2tIylrf1TxZJ2zrejDB8wqkozwtXARj
   ZKxijlpEeaMjdzFaAG2Hi3FDcjP5nTYDerMlnyGiG1YKzYrtOwQt7FMx8
   Lx0B8mav7mMHlpFByJBLs9FjE08S8b6PGtfQxmyb+SfZcRfwwqFpAiqo9
   sv2EQ3WTlEl0SWehJVdepYTxk8fnGkeR4/AF6kToIdFgxJg6zzlhBASrb
   8bj9Oj3c0+8rddf5Xas8+I1O9KmaXQhXR3K6ya2zadAMsouSvoC3PcTrO
   WzqNwMFf4uH4D0WB9CSCGdCsalkmmjLXRHWCrDJKfSCnoXrq8dK+fF8tC
   w==;
X-CSE-ConnectionGUID: iX/2JPjGSPGIEoERh485+w==
X-CSE-MsgGUID: RbyrjrhHS5eEQ4XMNFT8Yg==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="18890575"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="18890575"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 18:15:42 -0700
X-CSE-ConnectionGUID: vSAnGY7PR9CmZnEF+uDsqw==
X-CSE-MsgGUID: sQXCFUACT5WiOI1OrZSs/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="24015175"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 06 Apr 2024 18:15:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix WARN_ON in iommu probe path
Date: Sun,  7 Apr 2024 09:14:29 +0800
Message-Id: <20240407011429.136282-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed
devices") adds all devices probed by the iommu driver in a rbtree
indexed by the source ID of each device. It assumes that each device
has a unique source ID. This assumption is incorrect and the VT-d
spec doesn't state this requirement either.

The reason for using a rbtree to track devices is to look up the device
with PCI bus and devfunc in the paths of handling ATS invalidation time
out error and the PRI I/O page faults. Both are PCI ATS feature related.

Only track the devices that have PCI ATS capabilities in the rbtree to
avoid unnecessary WARN_ON in the iommu probe path. Otherwise, on some
platforms below kernel splat will be displayed and the iommu probe results
in failure.

 WARNING: CPU: 3 PID: 166 at drivers/iommu/intel/iommu.c:158 intel_iommu_probe_device+0x319/0xd90
 Call Trace:
  <TASK>
  ? __warn+0x7e/0x180
  ? intel_iommu_probe_device+0x319/0xd90
  ? report_bug+0x1f8/0x200
  ? handle_bug+0x3c/0x70
  ? exc_invalid_op+0x18/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? intel_iommu_probe_device+0x319/0xd90
  ? debug_mutex_init+0x37/0x50
  __iommu_probe_device+0xf2/0x4f0
  iommu_probe_device+0x22/0x70
  iommu_bus_notifier+0x1e/0x40
  notifier_call_chain+0x46/0x150
  blocking_notifier_call_chain+0x42/0x60
  bus_notify+0x2f/0x50
  device_add+0x5ed/0x7e0
  platform_device_add+0xf5/0x240
  mfd_add_devices+0x3f9/0x500
  ? preempt_count_add+0x4c/0xa0
  ? up_write+0xa2/0x1b0
  ? __debugfs_create_file+0xe3/0x150
  intel_lpss_probe+0x49f/0x5b0
  ? pci_conf1_write+0xa3/0xf0
  intel_lpss_pci_probe+0xcf/0x110 [intel_lpss_pci]
  pci_device_probe+0x95/0x120
  really_probe+0xd9/0x370
  ? __pfx___driver_attach+0x10/0x10
  __driver_probe_device+0x73/0x150
  driver_probe_device+0x19/0xa0
  __driver_attach+0xb6/0x180
  ? __pfx___driver_attach+0x10/0x10
  bus_for_each_dev+0x77/0xd0
  bus_add_driver+0x114/0x210
  driver_register+0x5b/0x110
  ? __pfx_intel_lpss_pci_driver_init+0x10/0x10 [intel_lpss_pci]
  do_one_initcall+0x57/0x2b0
  ? kmalloc_trace+0x21e/0x280
  ? do_init_module+0x1e/0x210
  do_init_module+0x5f/0x210
  load_module+0x1d37/0x1fc0
  ? init_module_from_file+0x86/0xd0
  init_module_from_file+0x86/0xd0
  idempotent_init_module+0x17c/0x230
  __x64_sys_finit_module+0x56/0xb0
  do_syscall_64+0x6e/0x140
  entry_SYSCALL_64_after_hwframe+0x71/0x79

Fixes: 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 50eb9aed47cc..a7ecd90303dc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4299,9 +4299,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	}
 
 	dev_iommu_priv_set(dev, info);
-	ret = device_rbtree_insert(iommu, info);
-	if (ret)
-		goto free;
+	if (pdev && pci_ats_supported(pdev)) {
+		ret = device_rbtree_insert(iommu, info);
+		if (ret)
+			goto free;
+	}
 
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
 		ret = intel_pasid_alloc_table(dev);
@@ -4336,7 +4338,8 @@ static void intel_iommu_release_device(struct device *dev)
 	struct intel_iommu *iommu = info->iommu;
 
 	mutex_lock(&iommu->iopf_lock);
-	device_rbtree_remove(info);
+	if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
+		device_rbtree_remove(info);
 	mutex_unlock(&iommu->iopf_lock);
 
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
-- 
2.34.1


