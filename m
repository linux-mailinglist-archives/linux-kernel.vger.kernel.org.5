Return-Path: <linux-kernel+bounces-139691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A8B8A0686
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E931C237B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6983413BC1A;
	Thu, 11 Apr 2024 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXaPhY0K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAB513BACD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804943; cv=none; b=n4gUf9CBoKOHAOm+3pDLznFq8IvefYLjcd//sxtxn6UE4GqK9AL88qJyCH5lIRqACvyejsMT7eOnGWVnEWLhCcB+Wh5TY9qd7Y4bwhKNC/mP9oxDmj7Aax+uo3Pg+L8Y+rC53pWYGpt4iQQKEY6L1FZa4cwE8xyuH+P3CQsky7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804943; c=relaxed/simple;
	bh=UtbS/BnDM6+ab6c1umntrMRFPd2zV9Gtz174uvCGgpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cMKtKzAp2p2JJtQOQd9Mn0Nni+KeWS5uBX45yXhnzhPyV0LLMDFk3SS/8X67tSsmwvzqt+EyI+RwAFzZIoxQ8t68btBOq5dnvbJtf68okFyA2AkdfUcIHJUVpm7yYQoJ9rPyAFkyowQVhBgjNdFPTLVHMbRlktwG8mkq/jYaKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXaPhY0K; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712804942; x=1744340942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UtbS/BnDM6+ab6c1umntrMRFPd2zV9Gtz174uvCGgpM=;
  b=NXaPhY0KQyKr/vtJNaCVlfXYa/x9+88xFP8NyyQWo1p2BmBoN22mc82P
   QaRditLRoc7i0jyUkotA4H12A19oyxV5tBmV22x8nJXo4hGaLzIm60Lx/
   yZRzETibDadCvkC06tZesF5FAmaeFnE8Da6WaQPtTFV0mjcPWKdjXbAU+
   wrXGe2hEGvC4e4Dt/GMidKN5eZG3RKxRr/qj/p+bwDsu0VGEBNKNcLtA2
   ezmNHoNulNoQulQjNERqz7v7u2XU41ekE+lSaGq1IKHcF/Ub7gvrsr1pX
   yvVj+bPqzvfF/Cx0Du39p075qpLOmDZvZXKPxgEuI5yXpKOX/dn2iQFBi
   w==;
X-CSE-ConnectionGUID: 83LeiyXiTF2zvBl8TO9brQ==
X-CSE-MsgGUID: Vxiz7qGqQmy4P6/5dr6eOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="30681448"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="30681448"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 20:09:02 -0700
X-CSE-ConnectionGUID: 9FC1E0BbQCSatbM0W1KKnQ==
X-CSE-MsgGUID: hRrOEHiFSrCGBP9U0TSrug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="20822978"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 10 Apr 2024 20:09:00 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Xuchun Shang <xuchun.shang@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iommu/vt-d: Fix WARN_ON in iommu probe path
Date: Thu, 11 Apr 2024 11:07:44 +0800
Message-Id: <20240411030744.273460-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411030744.273460-1-baolu.lu@linux.intel.com>
References: <20240411030744.273460-1-baolu.lu@linux.intel.com>
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
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10689
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20240407011429.136282-1-baolu.lu@linux.intel.com
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


