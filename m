Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8517ED911
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344483AbjKPBzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344473AbjKPBzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:55:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5B5193
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700099710; x=1731635710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4e2WzVgnd3QufXnBgiy7uSbAqmY5jDHIAU+FTnse2sA=;
  b=lR1ToGmS4YGZXv5D8GakpbzBQ3pyG9M01LvZrkjyao7DZn1C5bwy2YC+
   mahltQZbMnrOffYf06GTym66M0DIYptpzNfClhYD73YRF34MI+Gd5ioGr
   8rcmXxiW6GyoP6bgVaLnLQKFzyyQuxOh9ba69RKVLGzZJxRlvQjnN8h6V
   tUsQOq5YzKrZi/eIW4mx3uBqSa4dUq7SVmVpcgoE+G9I/CBLEtg1inikp
   qPOyWFEUBmc/cMkhYk7WdD4F5qMSRWTuIjtw6rp391LNuXA22UOaqWwF+
   K4sQ+NmGGsAttESn/ZnE7BGQhaRafYmQaz8rKivBzYukabYzY+UQ5JnND
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381387700"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="381387700"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 17:55:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="13395423"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 15 Nov 2023 17:55:07 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/4] iommu/vt-d: Remove unused parameter of intel_pasid_setup_pass_through()
Date:   Thu, 16 Nov 2023 09:50:46 +0800
Message-Id: <20231116015048.29675-3-baolu.lu@linux.intel.com>
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

The domain parameter of this helper is unused and can be deleted to avoid
dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h | 1 -
 drivers/iommu/intel/iommu.c | 5 ++---
 drivers/iommu/intel/pasid.c | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index dd37611175cc..16265bc1f7ec 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -111,7 +111,6 @@ int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
 				     struct device *dev, u32 pasid,
 				     bool enabled);
 int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
-				   struct dmar_domain *domain,
 				   struct device *dev, u32 pasid);
 int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 			     u32 pasid, struct dmar_domain *domain);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b50ade814e94..3ccc2739236b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2460,7 +2460,7 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
 		/* Setup the PASID entry for requests without PASID: */
 		if (hw_pass_through && domain_type_is_si(domain))
-			ret = intel_pasid_setup_pass_through(iommu, domain,
+			ret = intel_pasid_setup_pass_through(iommu,
 					dev, IOMMU_NO_PASID);
 		else if (domain->use_first_level)
 			ret = domain_setup_first_level(iommu, domain, dev,
@@ -4795,8 +4795,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 		goto out_free;
 
 	if (domain_type_is_si(dmar_domain))
-		ret = intel_pasid_setup_pass_through(iommu, dmar_domain,
-						     dev, pasid);
+		ret = intel_pasid_setup_pass_through(iommu, dev, pasid);
 	else if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 74e8e4c17e81..8a1bcabf71a9 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -767,7 +767,6 @@ int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
  * Set up the scalable mode pasid entry for passthrough translation type.
  */
 int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
-				   struct dmar_domain *domain,
 				   struct device *dev, u32 pasid)
 {
 	u16 did = FLPT_DEFAULT_DID;
-- 
2.34.1

