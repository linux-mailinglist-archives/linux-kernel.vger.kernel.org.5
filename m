Return-Path: <linux-kernel+bounces-130718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 013D2897C14
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9171F28518
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591C3156C6F;
	Wed,  3 Apr 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDOplyGL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129B1156C41
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187687; cv=none; b=JcMOWRmSrJ4eASY0tGnRo4cDO2PtrrwB5FujXdxo4l+ICV12Z69DxHTtyDuaRCfCRWtbOTDk4t7QYJI0t6n66QJ/LxGwas5pH/uiFhqRQBsUJwwDh8fJfVhk+6Ql0r45qj9gg8SGV6DjfEUBheragMq8j7mCZ2h2gkpXFmFkSoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187687; c=relaxed/simple;
	bh=R0NMhwyttFNi30mNMusJuV2if3D+ISCNB1cUl8jQ7g8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M5n06p6zb9VZeidxh3mwCdP2F5THRJkfKEyHuimeKbGY3bFYOdjsblQjWNHIG2soL6nCfTkNsgVaFhshmsQLJRgpJOs++4zkS0pxMM8h1ZfM9vl+Y3KdBBuwB0SycQIpO9yeLRKer5xeexmSee42MGti5qGe6d+8+xja9aYtPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDOplyGL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712187686; x=1743723686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R0NMhwyttFNi30mNMusJuV2if3D+ISCNB1cUl8jQ7g8=;
  b=IDOplyGLB5a/YoDZvLg77vrfLe6gB1V0t/ksPmsS4y7M1gTzqSdzWn8y
   E7EZUDDLVo7G9ZVrNis0DHPbevx+MMfBBo3u86puyejOCNBLbUvKm7Hxu
   E5ABUuQgUJb6v3bb8edPgMj66fWvpxpp6ZH9OJbD9oANVrcHZw/2pxF0I
   5E/nntEfj7uO+AE2taJsMRS6OB5oWSpSBlwlo9exGheDHtF+1hMGEpLYs
   jO53PcqplQ5xMs+7R2BhjWKVuDKzkbkav51XrNyuLAvgByEqSzcOk3qGU
   ZhquRj4QZBz9l30cA0iwNbCcoEBJ757MYmDknEb7hYkzvLEgOz6l4u7gw
   Q==;
X-CSE-ConnectionGUID: AUMRkTYaScqyLywQ7yxVIw==
X-CSE-MsgGUID: TvBA1Va8SrmLJcLQ9hq05w==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="10419004"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="10419004"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 16:41:24 -0700
X-CSE-ConnectionGUID: Q10ReuZnTZe7oJMWgT0BxA==
X-CSE-MsgGUID: 5abMbITQTraYkx/CpSsmxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="19052516"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by orviesa006.jf.intel.com with ESMTP; 03 Apr 2024 16:41:24 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: sivanich@hpe.com,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	steve.wahl@hpe.com,
	russ.anderson@hpe.com,
	Peter Zijlstra <peterz@infradead.org>,
	"Will Deacon" <will@kernel.org>,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Share DMAR fault IRQ to prevent vector exhaustion
Date: Wed,  3 Apr 2024 16:45:48 -0700
Message-Id: <20240403234548.989061-2-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403234548.989061-1-jacob.jun.pan@linux.intel.com>
References: <20240403234548.989061-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DMAR fault interrupt is used for per-IOMMU unrecoverable fault reporting,
it occurs only if there is a kernel programming error or serious hardware
failure. In other words, they should never occur under normal circumstances.

However, we are permanently occupying IRQ vectors per DMAR unit. On a
dual-socket Saphire Rapids system, DMAR fault interrupts can consume 16
vectors on BSP, which can lead to vector exhaustion. The effort to spread
vectors to each socket only partially alleviates the problem.

This patch leverages the shared IRQ mechanism such that only a single IRQ
vector is consumed for all the DMAR units on a system. When any DMAR faults
occur, all DMAR handlers are called to check their own fault records.

After this patch /proc/interrupts will show the list of DMAR units that share
the fault interrupt, e.g.

24 DMAR-MSI   14-edge      dmar14, dmar13, dmar12, dmar11, dmar10, dmar9,
dmar8, dmar7, dmar6, dmar5, dmar4, dmar3, dmar2, dmar1, dmar0, dmar15

Link: https://lore.kernel.org/lkml/20240325115638.342716e5@jacob-builder/t/#mc08892e405456428773bcc3b0bbe8971886c5ab9

Reported-by: Dimitri Sivanich <sivanich@hpe.com>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 71 +++++++++++++++++++++++++++++--------
 drivers/iommu/intel/iommu.h |  1 +
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ab325af93f71..cf68464b3404 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1182,7 +1182,6 @@ static void free_iommu(struct intel_iommu *iommu)
 			iommu->pr_irq = 0;
 		}
 		free_irq(iommu->fault_irq, iommu);
-		dmar_free_hwirq(iommu->fault_irq);
 		iommu->fault_irq = 0;
 	}
 
@@ -1956,9 +1955,8 @@ void dmar_msi_mask(struct irq_data *data)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-void dmar_msi_write(int irq, struct msi_msg *msg)
+static void dmar_msi_write_msg(struct intel_iommu *iommu, int irq, struct msi_msg *msg)
 {
-	struct intel_iommu *iommu = irq_get_handler_data(irq);
 	int reg = dmar_msi_reg(iommu, irq);
 	unsigned long flag;
 
@@ -1969,6 +1967,13 @@ void dmar_msi_write(int irq, struct msi_msg *msg)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
+void dmar_msi_write(int irq, struct msi_msg *msg)
+{
+	struct intel_iommu *iommu = irq_get_handler_data(irq);
+
+	dmar_msi_write_msg(iommu, irq, msg);
+}
+
 void dmar_msi_read(int irq, struct msi_msg *msg)
 {
 	struct intel_iommu *iommu = irq_get_handler_data(irq);
@@ -2098,27 +2103,63 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static inline void dmar_fault_irq_unmask(struct intel_iommu *iommu)
+{
+	unsigned long flag;
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flag);
+	writel(0, iommu->reg + DMAR_FECTL_REG);
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
+}
+
 int dmar_set_interrupt(struct intel_iommu *iommu)
 {
-	int irq, ret;
+	static int dmar_irq;
+	int ret;
 
-	/*
-	 * Check if the fault interrupt is already initialized.
-	 */
+	/* Don't initialize it twice for a given iommu */
 	if (iommu->fault_irq)
 		return 0;
+	/*
+	 * There is one shared interrupt for all IOMMUs to prevent vector
+	 * exhaustion.
+	 */
+	if (!dmar_irq) {
+		int irq = dmar_alloc_hwirq(iommu->seq_id, iommu->node, iommu);
 
-	irq = dmar_alloc_hwirq(iommu->seq_id, iommu->node, iommu);
-	if (irq > 0) {
-		iommu->fault_irq = irq;
+		if (irq <= 0) {
+			pr_err("No free IRQ vectors\n");
+			return -EINVAL;
+		}
+		dmar_irq = irq;
+		iommu->fault_irq = dmar_irq;
+		iommu->flags |= VTD_FLAG_FAULT_IRQ_OWNER;
 	} else {
-		pr_err("No free IRQ vectors\n");
-		return -EINVAL;
-	}
+		struct msi_msg msg;
 
-	ret = request_irq(irq, dmar_fault, IRQF_NO_THREAD, iommu->name, iommu);
-	if (ret)
+		/*
+		 * Get the MSI message from the shared interrupt and write
+		 * it to the iommu MSI registers. Must assign fault_irq to get
+		 * the MSI register offset.
+		 */
+		iommu->fault_irq = dmar_irq;
+		dmar_msi_read(dmar_irq, &msg);
+		dmar_msi_write_msg(iommu, dmar_irq, &msg);
+	}
+	ret = request_irq(dmar_irq, dmar_fault, IRQF_NO_THREAD | IRQF_SHARED | IRQF_NOBALANCING, iommu->name, iommu);
+	if (ret) {
 		pr_err("Can't request irq\n");
+		return ret;
+	}
+
+	/*
+	 * Only the owner IOMMU of the shared IRQ has its fault event
+	 * interrupt unmasked after request_irq(), the rest are explicitly
+	 * unmasked.
+	 */
+	if (!(iommu->flags & VTD_FLAG_FAULT_IRQ_OWNER))
+		dmar_fault_irq_unmask(iommu);
+
 	return ret;
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index deebd4817d27..128f6cdaebac 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -536,6 +536,7 @@ enum {
 #define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
 #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
 #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
+#define VTD_FLAG_FAULT_IRQ_OWNER	(1 << 3)
 
 #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
-- 
2.25.1


