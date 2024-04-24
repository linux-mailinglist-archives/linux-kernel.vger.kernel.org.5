Return-Path: <linux-kernel+bounces-156459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9A58B02FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FA11C22D62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E41158A0B;
	Wed, 24 Apr 2024 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPM7KSE6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F215884E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943100; cv=none; b=Lexn3btHyT6ZV726ci7Wi6Y+mLwAb9k6OJ4AtoCKpDrwefje8jif4j3/hqi9kPCL/9xBKB3+VhyhijKZVx2IA0/Uf0LY6QvjDpVqpOm3tXsoVdg5/UPKgWNbdFTX1+hcm58knFaXzXbQyYPaR+zFwQ1oJ2U0QNnMNmMsNpto/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943100; c=relaxed/simple;
	bh=LrQrNI1CYTBZXaKD8wgDnxx/r4bNSfr30OOwqEIoFSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hI2qyVZq+4G5KpN03ASPJqqnJQGSY0QmXmCbUJJEw4ioPi/A56pzk3L9lceP2z8S7Z0M9dQF2hlIhiv+oYbn0W3pohzVCYpP0MYRtGWWHD2EWkPoBVSFM4Ks3n8U4NpaIxNJ9EHLhDeCkS9H5AruZ+VY1lez+i0yF+ZJPfu8G14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPM7KSE6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943099; x=1745479099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LrQrNI1CYTBZXaKD8wgDnxx/r4bNSfr30OOwqEIoFSk=;
  b=NPM7KSE6HPDCCdr2jvfwc3TD0nv0xYwFrMoAiAusGNIQo+uj6RBGiLSZ
   tHTGHXBmdhPBJfi8WydCZOmI/L5QFaNaTlyk0iSi6h88v2sVYiNEn+MCW
   9M+nRvp8baYU0bll++mm/9QIQ4aMiUJZs5Er5NlviEqpigkO7kJPYoZkA
   uwupZONeq019tg2uBzl2ie8i+6mk1G5PvrApMB1VoMjcVTwNI1+RJxD3V
   KLLeiwlTin5+TEOk85mbj8j4bVGn7L+1ZN4/LPTNTBesiZHuY/g5OQ1nT
   NxZ0KXDM/tlJWWF7M9mXqOb7EbUZlc16nDCEJ05hXBwuHtYOKi3qjDcdz
   g==;
X-CSE-ConnectionGUID: WTcW2Z1TTfSO6chgTapwYg==
X-CSE-MsgGUID: pNmF9kNdQdeaBD7RoSMQWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073113"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073113"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:16 -0700
X-CSE-ConnectionGUID: gNTNfRlfRy6P9ldN4UlbSg==
X-CSE-MsgGUID: dd71We17QMO/A5NycX6EiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24664795"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/18] iommu/vt-d: Allocate DMAR fault interrupts locally
Date: Wed, 24 Apr 2024 15:16:29 +0800
Message-Id: <20240424071644.178250-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dimitri Sivanich <sivanich@hpe.com>

The Intel IOMMU code currently tries to allocate all DMAR fault interrupt
vectors on the boot cpu.  On large systems with high DMAR counts this
results in vector exhaustion, and most of the vectors are not initially
allocated socket local.

Instead, have a cpu on each node do the vector allocation for the DMARs on
that node.  The boot cpu still does the allocation for its node during its
boot sequence.

Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/Zfydpp2Hm+as16TY@hpe.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/dmar.h          | 2 +-
 drivers/iommu/amd/amd_iommu.h | 2 +-
 drivers/iommu/irq_remapping.h | 2 +-
 drivers/iommu/amd/init.c      | 2 +-
 drivers/iommu/intel/dmar.c    | 9 +++++++--
 drivers/iommu/irq_remapping.c | 5 ++++-
 6 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e34b601b71fd..499bb2c63483 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -117,7 +117,7 @@ extern int dmar_remove_dev_scope(struct dmar_pci_notify_info *info,
 				 int count);
 /* Intel IOMMU detection */
 void detect_intel_iommu(void);
-extern int enable_drhd_fault_handling(void);
+extern int enable_drhd_fault_handling(unsigned int cpu);
 extern int dmar_device_add(acpi_handle handle);
 extern int dmar_device_remove(acpi_handle handle);
 
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f482aab420f7..410c360e7e24 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -33,7 +33,7 @@ int amd_iommu_prepare(void);
 int amd_iommu_enable(void);
 void amd_iommu_disable(void);
 int amd_iommu_reenable(int mode);
-int amd_iommu_enable_faulting(void);
+int amd_iommu_enable_faulting(unsigned int cpu);
 extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 8c89cb947cdb..0d6f140b5e01 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -41,7 +41,7 @@ struct irq_remap_ops {
 	int  (*reenable)(int);
 
 	/* Enable fault handling */
-	int  (*enable_faulting)(void);
+	int  (*enable_faulting)(unsigned int);
 };
 
 extern struct irq_remap_ops intel_irq_remap_ops;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ac6754a85f35..8085e13e0100 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3392,7 +3392,7 @@ int amd_iommu_reenable(int mode)
 	return 0;
 }
 
-int __init amd_iommu_enable_faulting(void)
+int __init amd_iommu_enable_faulting(unsigned int cpu)
 {
 	/* We enable MSI later when PCI is initialized */
 	return 0;
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 351be9455214..932e0c10c0fe 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2121,7 +2121,7 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 	return ret;
 }
 
-int __init enable_drhd_fault_handling(void)
+int enable_drhd_fault_handling(unsigned int cpu)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
@@ -2131,7 +2131,12 @@ int __init enable_drhd_fault_handling(void)
 	 */
 	for_each_iommu(iommu, drhd) {
 		u32 fault_status;
-		int ret = dmar_set_interrupt(iommu);
+		int ret;
+
+		if (iommu->irq || iommu->node != cpu_to_node(cpu))
+			continue;
+
+		ret = dmar_set_interrupt(iommu);
 
 		if (ret) {
 			pr_err("DRHD %Lx: failed to enable fault, interrupt, ret %d\n",
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index ee59647c2050..2f7281ccc05f 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -151,7 +151,10 @@ int __init irq_remap_enable_fault_handling(void)
 	if (!remap_ops->enable_faulting)
 		return -ENODEV;
 
-	return remap_ops->enable_faulting();
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "dmar:enable_fault_handling",
+			  remap_ops->enable_faulting, NULL);
+
+	return remap_ops->enable_faulting(smp_processor_id());
 }
 
 void panic_if_irq_remap(const char *msg)
-- 
2.34.1


