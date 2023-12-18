Return-Path: <linux-kernel+bounces-3109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B19A81678B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E623D1F22E54
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E432101F8;
	Mon, 18 Dec 2023 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b83R+dtp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD73E578
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702885178; x=1734421178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uRpqB0ZP5Loi84yS0OCeqazEaU+b0Yz6T+oOuPCHrkc=;
  b=b83R+dtpWbicwQuOr64zNnyngEgSkszSLw1iT4rkhYIUHE34Il17ng6s
   vcKcd9N4fEzojbM164VzX7+kVKmmMB/6Kniot3ZG3TgRvbN1isj4/ti/z
   0lm5XfXDKAJ0q0EKpwU1GRK9lKn4f0wSCseGtrDIyEoOiyXfjgV4fLQVT
   wygAM2Mh1epqqriu9TFxNdwoXJbGRrvCtMh8THVCnSlmo0A0unH/dfEI3
   8ELcDuhTKJPC92VDpM+8eSrs0VYSfOJ0MCjGEkbNOAFOB2g5exHxfSu7H
   iAjurMaIFqn2bo4ACD/GfEdhD75iQVty0jzZi+JQ482ie215dmfWDzMT0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="459793934"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="459793934"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 23:39:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="893723259"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="893723259"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 17 Dec 2023 23:39:36 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iommu/vt-d: Remove unused vcmd interfaces
Date: Mon, 18 Dec 2023 15:34:44 +0800
Message-Id: <20231218073445.142401-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218073445.142401-1-baolu.lu@linux.intel.com>
References: <20231218073445.142401-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 99b5726b4423 ("iommu: Remove ioasid infrastructure") has removed
ioasid allocation interfaces from the iommu subsystem. As a result, these
vcmd interfaces have become obsolete. Remove them to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20231116015048.29675-4-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h   |  3 --
 drivers/iommu/intel/pasid.h   | 12 --------
 drivers/iommu/intel/debugfs.c |  3 --
 drivers/iommu/intel/pasid.c   | 57 -----------------------------------
 4 files changed, 75 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 42b8d3412115..1c6366f60805 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -140,9 +140,6 @@
 #define DMAR_ECEO_REG		0x408
 #define DMAR_ECRSP_REG		0x410
 #define DMAR_ECCAP_REG		0x430
-#define DMAR_VCCAP_REG		0xe30 /* Virtual command capability register */
-#define DMAR_VCMD_REG		0xe00 /* Virtual command register */
-#define DMAR_VCRSP_REG		0xe10 /* Virtual command response register */
 
 #define DMAR_IQER_REG_IQEI(reg)		FIELD_GET(GENMASK_ULL(3, 0), reg)
 #define DMAR_IQER_REG_ITESID(reg)	FIELD_GET(GENMASK_ULL(47, 32), reg)
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 16265bc1f7ec..00401cfc2a40 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -22,16 +22,6 @@
 #define is_pasid_enabled(entry)		(((entry)->lo >> 3) & 0x1)
 #define get_pasid_dir_size(entry)	(1 << ((((entry)->lo >> 9) & 0x7) + 7))
 
-/* Virtual command interface for enlightened pasid management. */
-#define VCMD_CMD_ALLOC			0x1
-#define VCMD_CMD_FREE			0x2
-#define VCMD_VRSP_IP			0x1
-#define VCMD_VRSP_SC(e)			(((e) & 0xff) >> 1)
-#define VCMD_VRSP_SC_SUCCESS		0
-#define VCMD_VRSP_SC_NO_PASID_AVAIL	16
-#define VCMD_VRSP_SC_INVALID_PASID	16
-#define VCMD_VRSP_RESULT_PASID(e)	(((e) >> 16) & 0xfffff)
-#define VCMD_CMD_OPERAND(e)		((e) << 16)
 /*
  * Domain ID reserved for pasid entries programmed for first-level
  * only and pass-through transfer modes.
@@ -117,8 +107,6 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 struct device *dev, u32 pasid,
 				 bool fault_ignore);
-int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid);
-void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid);
 void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 					  struct device *dev, u32 pasid);
 #endif /* __INTEL_PASID_H */
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index dee61e513be6..86b506af7daa 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -106,9 +106,6 @@ static const struct iommu_regset iommu_regs_64[] = {
 	IOMMU_REGSET_ENTRY(MTRR_PHYSMASK8),
 	IOMMU_REGSET_ENTRY(MTRR_PHYSBASE9),
 	IOMMU_REGSET_ENTRY(MTRR_PHYSMASK9),
-	IOMMU_REGSET_ENTRY(VCCAP),
-	IOMMU_REGSET_ENTRY(VCMD),
-	IOMMU_REGSET_ENTRY(VCRSP),
 };
 
 static struct dentry *intel_iommu_debug;
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


