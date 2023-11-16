Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB787ED912
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbjKPBzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344493AbjKPBzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:55:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EBF198
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700099712; x=1731635712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I8+jCn+VllpmwtFb6bxxIgTCdCKQIsTCc63leYdRI1g=;
  b=lLmkl0Fh85PMztmea7fvkNEhq2b8pmqRhbs5ZPmEgevcSPOyoL/NGDcE
   +B58YVhj0CrXK+2m2tU+In1AMl9sne+8NbUj83sf/lxf6TBXTMOZnmIGU
   V7MODQTQcg/wFJtxlD3jcPmamylAny4+QCHyjAQDLDuOqiV8NAvV84K/k
   /mJmGdn0ExVMk9wQWWbDjNItwy8Xt4mh46AFadZBKsbvzNvhM5r4kIbis
   cvyD/JTK7W/Qjf9/pWvEMV29C3OnUZ36CFA/+tgYmKGb00cf3iTBm15AF
   CkZqPdJlgaafuDCyTwo5VNozrmkumFOs37MUiLCNBmjAtY1pAaktB/iKm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381387718"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="381387718"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 17:55:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="13395428"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 15 Nov 2023 17:55:10 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/4] iommu/vt-d: Remove unused vcmd interfaces
Date:   Thu, 16 Nov 2023 09:50:47 +0800
Message-Id: <20231116015048.29675-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116015048.29675-1-baolu.lu@linux.intel.com>
References: <20231116015048.29675-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 99b5726b4423 ("iommu: Remove ioasid infrastructure") has removed
ioasid allocation interfaces from the iommu subsystem. As a result, these
vcmd interfaces have become obsolete. Remove them to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h |  2 --
 drivers/iommu/intel/pasid.c | 57 -------------------------------------
 2 files changed, 59 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 16265bc1f7ec..647723c650bf 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -117,8 +117,6 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 struct device *dev, u32 pasid,
 				 bool fault_ignore);
-int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid);
-void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid);
 void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 					  struct device *dev, u32 pasid);
 #endif /* __INTEL_PASID_H */
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 8a1bcabf71a9..57ae716a2c70 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -26,63 +26,6 @@
  */
 u32 intel_pasid_max_id = PASID_MAX;
 
-int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid)
-{
-	unsigned long flags;
-	u8 status_code;
-	int ret = 0;
-	u64 res;
-
-	raw_spin_lock_irqsave(&iommu->register_lock, flags);
-	dmar_writeq(iommu->reg + DMAR_VCMD_REG, VCMD_CMD_ALLOC);
-	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
-		      !(res & VCMD_VRSP_IP), res);
-	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
-
-	status_code = VCMD_VRSP_SC(res);
-	switch (status_code) {
-	case VCMD_VRSP_SC_SUCCESS:
-		*pasid = VCMD_VRSP_RESULT_PASID(res);
-		break;
-	case VCMD_VRSP_SC_NO_PASID_AVAIL:
-		pr_info("IOMMU: %s: No PASID available\n", iommu->name);
-		ret = -ENOSPC;
-		break;
-	default:
-		ret = -ENODEV;
-		pr_warn("IOMMU: %s: Unexpected error code %d\n",
-			iommu->name, status_code);
-	}
-
-	return ret;
-}
-
-void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid)
-{
-	unsigned long flags;
-	u8 status_code;
-	u64 res;
-
-	raw_spin_lock_irqsave(&iommu->register_lock, flags);
-	dmar_writeq(iommu->reg + DMAR_VCMD_REG,
-		    VCMD_CMD_OPERAND(pasid) | VCMD_CMD_FREE);
-	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
-		      !(res & VCMD_VRSP_IP), res);
-	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
-
-	status_code = VCMD_VRSP_SC(res);
-	switch (status_code) {
-	case VCMD_VRSP_SC_SUCCESS:
-		break;
-	case VCMD_VRSP_SC_INVALID_PASID:
-		pr_info("IOMMU: %s: Invalid PASID\n", iommu->name);
-		break;
-	default:
-		pr_warn("IOMMU: %s: Unexpected error code %d\n",
-			iommu->name, status_code);
-	}
-}
-
 /*
  * Per device pasid table management:
  */
-- 
2.34.1

