Return-Path: <linux-kernel+bounces-128922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5A88961E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533B91C245C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F87A17995;
	Wed,  3 Apr 2024 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkrNeACb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02773EA97
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107012; cv=none; b=qRnMSC0BCeL14/eILE5SnJRKqQhHr/7NVmgVhFYfUzM+3zCUa051J1ZL6UebQaqhLMHVgDQIS6buvMdSLdp3ubuHXWCSJitM0A0go6nhdQKcSIJGgsf4bHxI0Bm9M521qT/8kKk+7cMhwpjuoT+K7SZbCz9YXSgKIlTJ5kIq5zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107012; c=relaxed/simple;
	bh=Wx8nv2RbfUU5/rQlE3i/mjUA8iZwQsBV38GWN5zfJWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oRJ+EvZd+GjNR1a5bhuC7zClUe9//H5M50BtaW2/JyxRwjuxDiJbbf1jE8BQoxEJVy28fgdqlTC/Jsl2POKJdQJaOh2RWwxqhRz6WSS71g2hpvSz8OtBIX1t9i79gcD1HEP2CPPK9BB+ZsL7zkuBCmJ08N/xLPT/4wdC7G8oQN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkrNeACb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712107011; x=1743643011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wx8nv2RbfUU5/rQlE3i/mjUA8iZwQsBV38GWN5zfJWQ=;
  b=dkrNeACbuP53UxBevl+OOUH461scrw/knG8rR5mcaZopVx2rpRiDavdP
   Th+73jBJ5eRdsAojkMB/QKqQL8srrZQryJLHCD6MXhuJCu7xeqkgQ6dov
   FvHxA+eCB78OH/FjdZ1hFteMa60yiu0XWDuKjedixYXoXOeatphCuPQb/
   BOOpDE9NfKYNIUlRZV0T4ILFSg+TRJJH7MYJUeHqNuvrWxfmT+kZyxkvY
   wQ4L7w8v7CT6YW6J8eCylIbSLoLQWHCmtuPL29AAAyq8YL8dHy+E3vr/3
   aVWh6L6WYEY7emq9Qiqmf34AeIMxquWuWRa41560BWB+gq3hTXczrDpxK
   Q==;
X-CSE-ConnectionGUID: E7IHN7jfSaqxdBvWiLGSLg==
X-CSE-MsgGUID: zSNXIorHTie9MkGke/xEeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7439820"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7439820"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 18:16:51 -0700
X-CSE-ConnectionGUID: pSiwoUD0SXK6SiFjMtW1JQ==
X-CSE-MsgGUID: WlFwJaLyRwKyd+SQHm1mkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22953328"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 02 Apr 2024 18:16:48 -0700
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
Subject: [PATCH v4 8/9] iommufd/selftest: Add IOPF support for mock device
Date: Wed,  3 Apr 2024 09:15:18 +0800
Message-Id: <20240403011519.78512-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403011519.78512-1-baolu.lu@linux.intel.com>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the selftest mock device to support generating and responding to
an IOPF. Also add an ioctl interface to userspace applications to trigger
the IOPF on the mock device. This would allow userspace applications to
test the IOMMUFD's handling of IOPFs without having to rely on any real
hardware.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  8 ++++
 drivers/iommu/iommufd/selftest.c     | 63 ++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index e854d3f67205..acbbba1c6671 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -22,6 +22,7 @@ enum {
 	IOMMU_TEST_OP_MOCK_DOMAIN_FLAGS,
 	IOMMU_TEST_OP_DIRTY,
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
+	IOMMU_TEST_OP_TRIGGER_IOPF,
 };
 
 enum {
@@ -127,6 +128,13 @@ struct iommu_test_cmd {
 			__u32 id;
 			__u32 iotlb;
 		} check_iotlb;
+		struct {
+			__u32 dev_id;
+			__u32 pasid;
+			__u32 grpid;
+			__u32 perm;
+			__u64 addr;
+		} trigger_iopf;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 97ce62602e66..f925f5e5c00a 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -504,6 +504,8 @@ static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
 	return false;
 }
 
+static struct iopf_queue *mock_iommu_iopf_queue;
+
 static struct iommu_device mock_iommu_device = {
 };
 
@@ -514,6 +516,29 @@ static struct iommu_device *mock_probe_device(struct device *dev)
 	return &mock_iommu_device;
 }
 
+static void mock_domain_page_response(struct device *dev, struct iopf_fault *evt,
+				      struct iommu_page_response *msg)
+{
+}
+
+static int mock_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
+{
+	if (feat != IOMMU_DEV_FEAT_IOPF || !mock_iommu_iopf_queue)
+		return -ENODEV;
+
+	return iopf_queue_add_device(mock_iommu_iopf_queue, dev);
+}
+
+static int mock_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
+{
+	if (feat != IOMMU_DEV_FEAT_IOPF || !mock_iommu_iopf_queue)
+		return -ENODEV;
+
+	iopf_queue_remove_device(mock_iommu_iopf_queue, dev);
+
+	return 0;
+}
+
 static const struct iommu_ops mock_ops = {
 	/*
 	 * IOMMU_DOMAIN_BLOCKED cannot be returned from def_domain_type()
@@ -529,6 +554,9 @@ static const struct iommu_ops mock_ops = {
 	.capable = mock_domain_capable,
 	.device_group = generic_device_group,
 	.probe_device = mock_probe_device,
+	.page_response = mock_domain_page_response,
+	.dev_enable_feat = mock_dev_enable_feat,
+	.dev_disable_feat = mock_dev_disable_feat,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
@@ -1397,6 +1425,31 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 	return rc;
 }
 
+static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct iopf_fault event = { };
+	struct iommufd_device *idev;
+
+	idev = iommufd_get_device(ucmd, cmd->trigger_iopf.dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	event.fault.prm.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+	if (cmd->trigger_iopf.pasid != IOMMU_NO_PASID)
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	event.fault.type = IOMMU_FAULT_PAGE_REQ;
+	event.fault.prm.addr = cmd->trigger_iopf.addr;
+	event.fault.prm.pasid = cmd->trigger_iopf.pasid;
+	event.fault.prm.grpid = cmd->trigger_iopf.grpid;
+	event.fault.prm.perm = cmd->trigger_iopf.perm;
+
+	iommu_report_device_fault(idev->dev, &event);
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+
+	return 0;
+}
+
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
 	struct selftest_obj *sobj = container_of(obj, struct selftest_obj, obj);
@@ -1472,6 +1525,8 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 					  cmd->dirty.page_size,
 					  u64_to_user_ptr(cmd->dirty.uptr),
 					  cmd->dirty.flags);
+	case IOMMU_TEST_OP_TRIGGER_IOPF:
+		return iommufd_test_trigger_iopf(ucmd, cmd);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1513,6 +1568,9 @@ int __init iommufd_test_init(void)
 				  &iommufd_mock_bus_type.nb);
 	if (rc)
 		goto err_sysfs;
+
+	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
+
 	return 0;
 
 err_sysfs:
@@ -1528,6 +1586,11 @@ int __init iommufd_test_init(void)
 
 void iommufd_test_exit(void)
 {
+	if (mock_iommu_iopf_queue) {
+		iopf_queue_free(mock_iommu_iopf_queue);
+		mock_iommu_iopf_queue = NULL;
+	}
+
 	iommu_device_sysfs_remove(&mock_iommu_device);
 	iommu_device_unregister_bus(&mock_iommu_device,
 				    &iommufd_mock_bus_type.bus,
-- 
2.34.1


