Return-Path: <linux-kernel+bounces-164214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9008B7AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AA51F23BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988D174EF0;
	Tue, 30 Apr 2024 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/7Fhh0h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3713D29C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489145; cv=none; b=TBR3lheXnVoXMP5/mPUkeBiFb8jp90xGvy6eNQROyMnE2KD73vJZsNk0ht2CY52aF5/xR+wbOF+J334mOSPE65/abHkVl/EGG3s5ylytmXhC6a1WtfdTYL+Z5Ml48AEowTyrluhLDNKkBH3rxY3rOAIZ3lBAm7JZwlGIApRsHAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489145; c=relaxed/simple;
	bh=tvoic8JEg5iwsCj9YBFoEAx3/4HZliI5/5DJbrdIfjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLUKHv9gJZ0j1yj8vqNDeTaehyg7EFqJ5vOhhYY7N56yOZD0fi2jF1PnyvYUj8NK6vjevGA3McJWGVRYkT35ZNXjgl++f/wab+HqNCrYAbMiT2vXo/jKdNbD1/Qnl+x+mpprFJuAVh0tTT6yd+7XF5OHVEBKNUi/cp9jjXt07fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/7Fhh0h; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714489144; x=1746025144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tvoic8JEg5iwsCj9YBFoEAx3/4HZliI5/5DJbrdIfjQ=;
  b=W/7Fhh0hXjRgiTBXMz8u+ASSvqJiIfEU086C71E3ovDubaDgOEa8k+jh
   CEH+rQgr7vLhg+c2csGGa6Dgc+6isAPUR+68b9GMsWH332/G9yR96/OFr
   D013wDB78B0f6t7ePOPaR9IOz9HWLwC419lvwjFGU65tFa8bsWNxELxPn
   fhYSMPGzZiWmBD3+b+JVMkGDUC8OwDt/pAFzZsyCsloXiB0fd9JqmM+Vq
   5iLBXykBb7gzF8GZnhgi4DVLthHbjCoGb9PnJT0LoTVF15s+25Ht4fKlO
   w8TxxjBov3X1g0VdG2a65jE7r4BvsRU67Rh6+b9NQMYA1zEg6ltfWc173
   w==;
X-CSE-ConnectionGUID: 39zVwj0pRsCHmfEMa7Z1mQ==
X-CSE-MsgGUID: +gAPV4yJQkSeQuLflpFp6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10059882"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10059882"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:59:04 -0700
X-CSE-ConnectionGUID: zOA9IU/KTNumW79bdtW+wg==
X-CSE-MsgGUID: sQV7gGqkQOOMppzb/u/Seg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31282202"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 30 Apr 2024 07:59:00 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 4/9] iommufd: Add fault and response message definitions
Date: Tue, 30 Apr 2024 22:57:05 +0800
Message-Id: <20240430145710.68112-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430145710.68112-1-baolu.lu@linux.intel.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_hwpt_pgfaults represent fault messages that the userspace can
retrieve. Multiple iommu_hwpt_pgfaults might be put in an iopf group,
with the IOMMU_PGFAULT_FLAGS_LAST_PAGE flag set only for the last
iommu_hwpt_pgfault.

An iommu_hwpt_page_response is a response message that the userspace
should send to the kernel after finishing handling a group of fault
messages. The @dev_id, @pasid, and @grpid fields in the message
identify an outstanding iopf group for a device. The @cookie field,
which matches the cookie field of the last fault in the group, will
be used by the kernel to look up the pending message.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/uapi/linux/iommufd.h | 96 ++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dfeaa2e649e..83b45dce94a4 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -692,4 +692,100 @@ struct iommu_hwpt_invalidate {
 	__u32 __reserved;
 };
 #define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
+
+/**
+ * enum iommu_hwpt_pgfault_flags - flags for struct iommu_hwpt_pgfault
+ * @IOMMU_PGFAULT_FLAGS_PASID_VALID: The pasid field of the fault data is
+ *                                   valid.
+ * @IOMMU_PGFAULT_FLAGS_LAST_PAGE: It's the last fault of a fault group.
+ */
+enum iommu_hwpt_pgfault_flags {
+	IOMMU_PGFAULT_FLAGS_PASID_VALID		= (1 << 0),
+	IOMMU_PGFAULT_FLAGS_LAST_PAGE		= (1 << 1),
+};
+
+/**
+ * enum iommu_hwpt_pgfault_perm - perm bits for struct iommu_hwpt_pgfault
+ * @IOMMU_PGFAULT_PERM_READ: request for read permission
+ * @IOMMU_PGFAULT_PERM_WRITE: request for write permission
+ * @IOMMU_PGFAULT_PERM_EXEC: (PCIE 10.4.1) request with a PASID that has the
+ *                           Execute Requested bit set in PASID TLP Prefix.
+ * @IOMMU_PGFAULT_PERM_PRIV: (PCIE 10.4.1) request with a PASID that has the
+ *                           Privileged Mode Requested bit set in PASID TLP
+ *                           Prefix.
+ */
+enum iommu_hwpt_pgfault_perm {
+	IOMMU_PGFAULT_PERM_READ			= (1 << 0),
+	IOMMU_PGFAULT_PERM_WRITE		= (1 << 1),
+	IOMMU_PGFAULT_PERM_EXEC			= (1 << 2),
+	IOMMU_PGFAULT_PERM_PRIV			= (1 << 3),
+};
+
+/**
+ * struct iommu_hwpt_pgfault - iommu page fault data
+ * @size: sizeof(struct iommu_hwpt_pgfault)
+ * @flags: Combination of enum iommu_hwpt_pgfault_flags
+ * @dev_id: id of the originated device
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @perm: Combination of enum iommu_hwpt_pgfault_perm
+ * @addr: Page address
+ * @length: a hint of how much data the requestor is expecting to fetch. For
+ *          example, if the PRI initiator knows it is going to do a 10MB
+ *          transfer, it could fill in 10MB and the OS could pre-fault in
+ *          10MB of IOVA. It's default to 0 if there's no such hint.
+ * @cookie: kernel-managed cookie identifying a group of fault messages. The
+ *          cookie number encoded in the last page fault of the group should
+ *          be echoed back in the response message.
+ */
+struct iommu_hwpt_pgfault {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 pasid;
+	__u32 grpid;
+	__u32 perm;
+	__u64 addr;
+	__u32 length;
+	__u32 cookie;
+};
+
+/**
+ * enum iommufd_page_response_code - Return status of fault handlers
+ * @IOMMUFD_PAGE_RESP_SUCCESS: Fault has been handled and the page tables
+ *                             populated, retry the access. This is the
+ *                             "Success" defined in PCI 10.4.2.1.
+ * @IOMMUFD_PAGE_RESP_INVALID: General error. Drop all subsequent faults
+ *                             from this device if possible. This is the
+ *                             "Response Failure" in PCI 10.4.2.1.
+ * @IOMMUFD_PAGE_RESP_FAILURE: Could not handle this fault, don't retry the
+ *                             access. This is the "Invalid Request" in PCI
+ *                             10.4.2.1.
+ */
+enum iommufd_page_response_code {
+	IOMMUFD_PAGE_RESP_SUCCESS = 0,
+	IOMMUFD_PAGE_RESP_INVALID,
+	IOMMUFD_PAGE_RESP_FAILURE,
+};
+
+/**
+ * struct iommu_hwpt_page_response - IOMMU page fault response
+ * @size: sizeof(struct iommu_hwpt_page_response)
+ * @flags: Must be set to 0
+ * @dev_id: device ID of target device for the response
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @code: One of response code in enum iommufd_page_response_code.
+ * @cookie: The kernel-managed cookie reported in the fault message.
+ */
+struct iommu_hwpt_page_response {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 pasid;
+	__u32 grpid;
+	__u32 code;
+	__u32 cookie;
+	__u32 reserved;
+};
 #endif
-- 
2.34.1


