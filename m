Return-Path: <linux-kernel+bounces-130717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148F7897C13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F6428939E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E0D156C52;
	Wed,  3 Apr 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQqZzWhB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F112692FC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187685; cv=none; b=cJiJ45xknZlFcejZ5ofdXP2iUjBxVMR/Z7q6d4XOYuFsCCrGpSZ1FeL7GFdIUHR3KSIHJ5IFPhtS/j2uSq4CLMnXmN4UlHN7i5c6YfTfkByET8HuFI1nIqE5PNLTXLsXvrT0ksYIkZ+3LxKYceLEPv8DnKUnb98ESUpfL6MF1dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187685; c=relaxed/simple;
	bh=i3JFYctDTzbA0EHATWBXApDbgtgZ0KAnnqv0/18o6Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XMwm6Ej4azSmWycMI8hsushy3w69hrmLOQAiOqpTJDdO9BK4JLQk/yf5PsRMIKl7i5ngSiwkPcKmFQcv7cG/09UGvpWHWwJeRPkGsPJvPo8SGErKMS6uPE4Jwa7kTV7n6DHjSK0B+JC71xPgLzgf4dsktG1COO3vU/dYktthZuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQqZzWhB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712187684; x=1743723684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i3JFYctDTzbA0EHATWBXApDbgtgZ0KAnnqv0/18o6Zw=;
  b=OQqZzWhBeyi2cVHCKB6P90lY+FO8AL6dbzJsU2ORorMbsBChSenkSZL6
   wQiwvt93bwIRPhzO2AFec6xCxGi2CcO40dHzoNW3jLVQFBAR7y6uP/fhT
   KVDwzBdULzFfAJZ0lTxqvflGxxcDmUweTObxkJS+db3SBUgi4JF+6CrBG
   wzMfAnmZKUduL8/TO+ThTEMPh5X0x66e5erf8zswwNLZrQayMgkdUELD5
   uwqEL6yXeHcZ2AUXahP8e+Hv6fTDdKzLEWIbCedHKVe5YRDAFxj0O7MRB
   Mt3RtvVdtGS9wzegHb1OZoti5ViO4LdQUqMZOK++6v2WO/suipAL35Ttu
   A==;
X-CSE-ConnectionGUID: 8gP33jg9ScmQFBlCm6H6tA==
X-CSE-MsgGUID: FQDXakxyQuKsjElbmefKsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="10418999"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="10418999"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 16:41:23 -0700
X-CSE-ConnectionGUID: VvdqvG2qSxSU4JHoRHVbpQ==
X-CSE-MsgGUID: iYwV/h5tRk2bZOoz0Hst/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="19052508"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by orviesa006.jf.intel.com with ESMTP; 03 Apr 2024 16:41:23 -0700
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
Subject: [PATCH 1/2] iommu/vt-d: Rename fault IRQ variable
Date: Wed,  3 Apr 2024 16:45:47 -0700
Message-Id: <20240403234548.989061-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally, DMAR fault IRQ was the only source of interrupts for VT-d
itself, thus simply named 'irq'. Newer interrupt sources were added later
for page requests and perfmon with proper names, i.e. pr_irq and perf_irq.

Rename the fault IRQ to reflect its usage. This avoids confusion when
programming MSI messages for the three possible sources.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 16 ++++++++--------
 drivers/iommu/intel/iommu.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 36d7427b1202..ab325af93f71 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1175,15 +1175,15 @@ static void free_iommu(struct intel_iommu *iommu)
 
 	free_iommu_pmu(iommu);
 
-	if (iommu->irq) {
+	if (iommu->fault_irq) {
 		if (iommu->pr_irq) {
 			free_irq(iommu->pr_irq, iommu);
 			dmar_free_hwirq(iommu->pr_irq);
 			iommu->pr_irq = 0;
 		}
-		free_irq(iommu->irq, iommu);
-		dmar_free_hwirq(iommu->irq);
-		iommu->irq = 0;
+		free_irq(iommu->fault_irq, iommu);
+		dmar_free_hwirq(iommu->fault_irq);
+		iommu->fault_irq = 0;
 	}
 
 	if (iommu->qi) {
@@ -1918,7 +1918,7 @@ static const char *dmar_get_fault_reason(u8 fault_reason, int *fault_type)
 
 static inline int dmar_msi_reg(struct intel_iommu *iommu, int irq)
 {
-	if (iommu->irq == irq)
+	if (iommu->fault_irq == irq)
 		return DMAR_FECTL_REG;
 	else if (iommu->pr_irq == irq)
 		return DMAR_PECTL_REG;
@@ -2105,12 +2105,12 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 	/*
 	 * Check if the fault interrupt is already initialized.
 	 */
-	if (iommu->irq)
+	if (iommu->fault_irq)
 		return 0;
 
 	irq = dmar_alloc_hwirq(iommu->seq_id, iommu->node, iommu);
 	if (irq > 0) {
-		iommu->irq = irq;
+		iommu->fault_irq = irq;
 	} else {
 		pr_err("No free IRQ vectors\n");
 		return -EINVAL;
@@ -2143,7 +2143,7 @@ int __init enable_drhd_fault_handling(void)
 		/*
 		 * Clear any previous faults.
 		 */
-		dmar_fault(iommu->irq, iommu);
+		dmar_fault(iommu->fault_irq, iommu);
 		fault_status = readl(iommu->reg + DMAR_FSTS_REG);
 		writel(fault_status, iommu->reg + DMAR_FSTS_REG);
 	}
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 404d2476a877..deebd4817d27 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -699,7 +699,7 @@ struct intel_iommu {
 	int		seq_id;	/* sequence id of the iommu */
 	int		agaw; /* agaw of this iommu */
 	int		msagaw; /* max sagaw of this iommu */
-	unsigned int	irq, pr_irq, perf_irq;
+	unsigned int	fault_irq, pr_irq, perf_irq;
 	u16		segment;     /* PCI segment# */
 	unsigned char 	name[13];    /* Device Name */
 
-- 
2.25.1


