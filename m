Return-Path: <linux-kernel+bounces-146463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212238A65B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439851C225FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A7215884A;
	Tue, 16 Apr 2024 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B54dUiez"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0BD139CFF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254900; cv=none; b=hvh6opZcI/nnkZ79c8qHVX3oihT874ISAEY2vQum7u7UMz/khQ8TaRpvBhqzM5m2P3Y8Vf9eCv8vK3nI0Y1WYZv2w1Fnfv2aemzBxQQSloQOK++aHn0cOsjqHQLuPhISXg2l1WKRTCdr47Q1dshpq2vxqsGUt+jAZQnTQQKS11c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254900; c=relaxed/simple;
	bh=FAIM3jbAb09dS/tKiqNMIbUiFcgn6CpZo/oJWzmnxbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=luQZ22v5N6m9y7jz8GZZRIFy4tyHqmRP7SedW1oKrJ2bfri7JqHzXYOXlFLb81dHzOcWta8+FuVNWmck336HuQYOYbAG2KL0l/OJ4Qa94mYxI98Q2JllLHKzdBcMSB2q5E/sjc7UCyWO8Wm/fE1QRRUeFXyu8deHO3v1B8MCPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B54dUiez; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713254898; x=1744790898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FAIM3jbAb09dS/tKiqNMIbUiFcgn6CpZo/oJWzmnxbc=;
  b=B54dUiez546iD8sFUadAKFHWdmdExmhu3e3onETXLh4pNKv/hW935k1/
   Bq04YAFaCkgMOTMvFQElrqhZVoQvTaHqRSGMd4/lQiQlXhplhu7zL0BrT
   EE7zH2+AnSpj0r8qJHZUPUirrEh/ofq3xDZLT+/C9GK5M7C1Ytu3ynZ0u
   H/s8BlFW57VONV1LoDabl+3SVXYUu3RNbXx0KQkgPN2/c1rjDNGB7aYrP
   AXvF6Nh10SUurUT34NKQF36lDwest+nGOKSZnJkXsSa9c1fJoTFiZzvh4
   yEJ7W+YAB4sjLCOwaV7/K5YcXPZs+3PXxS2G4JX9JMywdhocKwkOLZ4Vt
   g==;
X-CSE-ConnectionGUID: L1nnfonHQsa7bBJsJmrFpA==
X-CSE-MsgGUID: H0+BKUd+R921hswe0qXqRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12466430"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="12466430"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 01:08:18 -0700
X-CSE-ConnectionGUID: oQ0ia1GCSPe5xmWIsNmKsg==
X-CSE-MsgGUID: pnhcOjhzQ2ihhMV/58KWlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22077674"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 16 Apr 2024 01:08:16 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 01/12] iommu/vt-d: Add cache tag assignment interface
Date: Tue, 16 Apr 2024 16:06:45 +0800
Message-Id: <20240416080656.60968-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416080656.60968-1-baolu.lu@linux.intel.com>
References: <20240416080656.60968-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caching tag is a combination of tags used by the hardware to cache various
translations. Whenever a mapping in a domain is changed, the IOMMU driver
should invalidate the caches with the caching tags. The VT-d specification
describes caching tags in section 6.2.1, Tagging of Cached Translations.

Add interface to assign caching tags to an IOMMU domain when attached to a
RID or PASID, and unassign caching tags when a domain is detached from a
RID or PASID. All caching tags are listed in the per-domain tag list and
are protected by a dedicated lock.

In addition to the basic IOTLB and devTLB caching tag types, PARENT_IOTLB
and PARENT_DEVTLB tag types are also introduced. These tags are used for
caches that store translations for DMA accesses through a nested user
domain. They are affected by changes to mappings in the parent domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h  |  31 +++++
 drivers/iommu/intel/cache.c  | 214 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c  |  28 ++++-
 drivers/iommu/intel/nested.c |  19 +++-
 drivers/iommu/intel/svm.c    |  10 +-
 drivers/iommu/intel/Makefile |   2 +-
 6 files changed, 295 insertions(+), 9 deletions(-)
 create mode 100644 drivers/iommu/intel/cache.c

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 404d2476a877..52471f5337d5 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -607,6 +607,9 @@ struct dmar_domain {
 	struct list_head devices;	/* all devices' list */
 	struct list_head dev_pasids;	/* all attached pasids */
 
+	spinlock_t cache_lock;		/* Protect the cache tag list */
+	struct list_head cache_tags;	/* Cache tag list */
+
 	int		iommu_superpage;/* Level of superpages supported:
 					   0 == 4KiB (no superpages), 1 == 2MiB,
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
@@ -1092,6 +1095,34 @@ struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 					       const struct iommu_user_data *user_data);
 struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid);
 
+enum cache_tag_type {
+	CACHE_TAG_IOTLB,
+	CACHE_TAG_DEVTLB,
+	CACHE_TAG_NESTING_IOTLB,
+	CACHE_TAG_NESTING_DEVTLB,
+};
+
+struct cache_tag {
+	struct list_head node;
+	enum cache_tag_type type;
+	struct intel_iommu *iommu;
+	/*
+	 * The @dev field represents the location of the cache. For IOTLB, it
+	 * resides on the IOMMU hardware. @dev stores the device pointer to
+	 * the IOMMU hardware. For DevTLB, it locates in the PCIe endpoint.
+	 * @dev stores the device pointer to that endpoint.
+	 */
+	struct device *dev;
+	u16 domain_id;
+	ioasid_t pasid;
+	unsigned int users;
+};
+
+int cache_tag_assign_domain(struct dmar_domain *domain,
+			    struct device *dev, ioasid_t pasid);
+void cache_tag_unassign_domain(struct dmar_domain *domain,
+			       struct device *dev, ioasid_t pasid);
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
 int intel_svm_enable_prq(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
new file mode 100644
index 000000000000..296f1645a739
--- /dev/null
+++ b/drivers/iommu/intel/cache.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * cache.c - Intel VT-d cache invalidation
+ *
+ * Copyright (C) 2024 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu@linux.intel.com>
+ */
+
+#define pr_fmt(fmt)	"DMAR: " fmt
+
+#include <linux/dmar.h>
+#include <linux/iommu.h>
+#include <linux/memory.h>
+#include <linux/spinlock.h>
+
+#include "iommu.h"
+#include "pasid.h"
+
+/* Check if an existing cache tag can be reused for a new association. */
+static bool cache_tage_match(struct cache_tag *tag, u16 domain_id,
+			     struct intel_iommu *iommu, struct device *dev,
+			     ioasid_t pasid, enum cache_tag_type type)
+{
+	if (tag->type != type)
+		return false;
+
+	if (tag->domain_id != domain_id || tag->pasid != pasid)
+		return false;
+
+	if (type == CACHE_TAG_IOTLB || type == CACHE_TAG_NESTING_IOTLB)
+		return tag->iommu == iommu;
+
+	if (type == CACHE_TAG_DEVTLB || type == CACHE_TAG_NESTING_DEVTLB)
+		return tag->dev == dev;
+
+	return false;
+}
+
+/* Assign a cache tag with specified type to domain. */
+static int cache_tag_assign(struct dmar_domain *domain, u16 did,
+			    struct device *dev, ioasid_t pasid,
+			    enum cache_tag_type type)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct cache_tag *tag, *temp;
+	unsigned long flags;
+
+	tag = kzalloc(sizeof(*tag), GFP_KERNEL);
+	if (!tag)
+		return -ENOMEM;
+
+	tag->type = type;
+	tag->iommu = iommu;
+	tag->domain_id = did;
+	tag->pasid = pasid;
+	tag->users = 1;
+
+	if (type == CACHE_TAG_DEVTLB || type == CACHE_TAG_NESTING_DEVTLB)
+		tag->dev = dev;
+	else
+		tag->dev = iommu->iommu.dev;
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	list_for_each_entry(temp, &domain->cache_tags, node) {
+		if (cache_tage_match(temp, did, iommu, dev, pasid, type)) {
+			temp->users++;
+			spin_unlock_irqrestore(&domain->cache_lock, flags);
+			kfree(tag);
+			return 0;
+		}
+	}
+	list_add_tail(&tag->node, &domain->cache_tags);
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+
+	return 0;
+}
+
+/* Unassign a cache tag with specified type from domain. */
+static void cache_tag_unassign(struct dmar_domain *domain, u16 did,
+			       struct device *dev, ioasid_t pasid,
+			       enum cache_tag_type type)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct cache_tag *tag;
+	unsigned long flags;
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	list_for_each_entry(tag, &domain->cache_tags, node) {
+		if (cache_tage_match(tag, did, iommu, dev, pasid, type)) {
+			if (--tag->users == 0) {
+				list_del(&tag->node);
+				kfree(tag);
+			}
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+}
+
+static int __cache_tag_assign_domain(struct dmar_domain *domain, u16 did,
+				     struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	int ret;
+
+	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_IOTLB);
+	if (ret || !info->ats_enabled)
+		return ret;
+
+	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_DEVTLB);
+	if (ret)
+		cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_IOTLB);
+
+	return ret;
+}
+
+static void __cache_tag_unassign_domain(struct dmar_domain *domain, u16 did,
+					struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_IOTLB);
+
+	if (info->ats_enabled)
+		cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_DEVTLB);
+}
+
+static int __cache_tag_assign_parent_domain(struct dmar_domain *domain, u16 did,
+					    struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	int ret;
+
+	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_NESTING_IOTLB);
+	if (ret || !info->ats_enabled)
+		return ret;
+
+	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_NESTING_DEVTLB);
+	if (ret)
+		cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_NESTING_IOTLB);
+
+	return ret;
+}
+
+static void __cache_tag_unassign_parent_domain(struct dmar_domain *domain, u16 did,
+					       struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_NESTING_IOTLB);
+
+	if (info->ats_enabled)
+		cache_tag_unassign(domain, did, dev, pasid, CACHE_TAG_NESTING_DEVTLB);
+}
+
+static u16 domain_get_id_for_dev(struct dmar_domain *domain, struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	/*
+	 * The driver assigns different domain IDs for all domains except
+	 * the SVA type.
+	 */
+	if (domain->domain.type == IOMMU_DOMAIN_SVA)
+		return FLPT_DEFAULT_DID;
+
+	return domain_id_iommu(domain, iommu);
+}
+
+/*
+ * Assign cache tags to a domain when it's associated with a device's
+ * PASID using a specific domain ID.
+ *
+ * On success (return value of 0), cache tags are created and added to the
+ * domain's cache tag list. On failure (negative return value), an error
+ * code is returned indicating the reason for the failure.
+ */
+int cache_tag_assign_domain(struct dmar_domain *domain,
+			    struct device *dev, ioasid_t pasid)
+{
+	u16 did = domain_get_id_for_dev(domain, dev);
+	int ret;
+
+	ret = __cache_tag_assign_domain(domain, did, dev, pasid);
+	if (ret || domain->domain.type != IOMMU_DOMAIN_NESTED)
+		return ret;
+
+	ret = __cache_tag_assign_parent_domain(domain->s2_domain, did, dev, pasid);
+	if (ret)
+		__cache_tag_unassign_domain(domain, did, dev, pasid);
+
+	return ret;
+}
+
+/*
+ * Remove the cache tags associated with a device's PASID when the domain is
+ * detached from the device.
+ *
+ * The cache tags must be previously assigned to the domain by calling the
+ * assign interface.
+ */
+void cache_tag_unassign_domain(struct dmar_domain *domain,
+			       struct device *dev, ioasid_t pasid)
+{
+	u16 did = domain_get_id_for_dev(domain, dev);
+
+	__cache_tag_unassign_domain(domain, did, dev, pasid);
+	if (domain->domain.type == IOMMU_DOMAIN_NESTED)
+		__cache_tag_unassign_parent_domain(domain->s2_domain, did, dev, pasid);
+}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f0a67e9d9faf..0c0b8e493fda 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1745,7 +1745,9 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
 	INIT_LIST_HEAD(&domain->dev_pasids);
+	INIT_LIST_HEAD(&domain->cache_tags);
 	spin_lock_init(&domain->lock);
+	spin_lock_init(&domain->cache_lock);
 	xa_init(&domain->iommu_array);
 
 	return domain;
@@ -1757,6 +1759,9 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	unsigned long ndomains;
 	int num, ret = -ENOSPC;
 
+	if (domain->domain.type == IOMMU_DOMAIN_SVA)
+		return 0;
+
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
@@ -1804,6 +1809,9 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info;
 
+	if (domain->domain.type == IOMMU_DOMAIN_SVA)
+		return;
+
 	spin_lock(&iommu->lock);
 	info = xa_load(&domain->iommu_array, iommu->seq_id);
 	if (--info->refcnt == 0) {
@@ -2322,6 +2330,13 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	ret = domain_attach_iommu(domain, iommu);
 	if (ret)
 		return ret;
+
+	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
+	if (ret) {
+		domain_detach_iommu(domain, iommu);
+		return ret;
+	}
+
 	info->domain = domain;
 	spin_lock_irqsave(&domain->lock, flags);
 	list_add(&info->link, &domain->devices);
@@ -3810,6 +3825,7 @@ void device_block_translation(struct device *dev)
 	list_del(&info->link);
 	spin_unlock_irqrestore(&info->domain->lock, flags);
 
+	cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
 	domain_detach_iommu(info->domain, iommu);
 	info->domain = NULL;
 }
@@ -4597,6 +4613,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
 	if (WARN_ON_ONCE(!domain))
 		goto out_tear_down;
+	dmar_domain = to_dmar_domain(domain);
 
 	/*
 	 * The SVA implementation needs to handle its own stuffs like the mm
@@ -4605,10 +4622,10 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	 */
 	if (domain->type == IOMMU_DOMAIN_SVA) {
 		intel_svm_remove_dev_pasid(dev, pasid);
+		cache_tag_unassign_domain(dmar_domain, dev, pasid);
 		goto out_tear_down;
 	}
 
-	dmar_domain = to_dmar_domain(domain);
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
 		if (curr->dev == dev && curr->pasid == pasid) {
@@ -4620,6 +4637,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	WARN_ON_ONCE(!dev_pasid);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
+	cache_tag_unassign_domain(dmar_domain, dev, pasid);
 	domain_detach_iommu(dmar_domain, iommu);
 	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
 	kfree(dev_pasid);
@@ -4659,6 +4677,10 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_free;
 
+	ret = cache_tag_assign_domain(dmar_domain, dev, pasid);
+	if (ret)
+		goto out_detach_iommu;
+
 	if (domain_type_is_si(dmar_domain))
 		ret = intel_pasid_setup_pass_through(iommu, dev, pasid);
 	else if (dmar_domain->use_first_level)
@@ -4668,7 +4690,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
 						     dev, pasid);
 	if (ret)
-		goto out_detach_iommu;
+		goto out_unassign_tag;
 
 	dev_pasid->dev = dev;
 	dev_pasid->pasid = pasid;
@@ -4680,6 +4702,8 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 		intel_iommu_debugfs_create_dev_pasid(dev_pasid);
 
 	return 0;
+out_unassign_tag:
+	cache_tag_unassign_domain(dmar_domain, dev, pasid);
 out_detach_iommu:
 	domain_detach_iommu(dmar_domain, iommu);
 out_free:
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index a7d68f3d518a..13406ee742bf 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -52,13 +52,14 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 		return ret;
 	}
 
+	ret = cache_tag_assign_domain(dmar_domain, dev, IOMMU_NO_PASID);
+	if (ret)
+		goto detach_iommu;
+
 	ret = intel_pasid_setup_nested(iommu, dev,
 				       IOMMU_NO_PASID, dmar_domain);
-	if (ret) {
-		domain_detach_iommu(dmar_domain, iommu);
-		dev_err_ratelimited(dev, "Failed to setup pasid entry\n");
-		return ret;
-	}
+	if (ret)
+		goto unassign_tag;
 
 	info->domain = dmar_domain;
 	spin_lock_irqsave(&dmar_domain->lock, flags);
@@ -68,6 +69,12 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	domain_update_iotlb(dmar_domain);
 
 	return 0;
+unassign_tag:
+	cache_tag_unassign_domain(dmar_domain, dev, IOMMU_NO_PASID);
+detach_iommu:
+	domain_detach_iommu(dmar_domain, iommu);
+
+	return ret;
 }
 
 static void intel_nested_domain_free(struct iommu_domain *domain)
@@ -206,7 +213,9 @@ struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 	domain->domain.type = IOMMU_DOMAIN_NESTED;
 	INIT_LIST_HEAD(&domain->devices);
 	INIT_LIST_HEAD(&domain->dev_pasids);
+	INIT_LIST_HEAD(&domain->cache_tags);
 	spin_lock_init(&domain->lock);
+	spin_lock_init(&domain->cache_lock);
 	xa_init(&domain->iommu_array);
 
 	spin_lock(&s2_domain->s1_lock);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index ee3b469e2da1..641d0cef3737 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -366,17 +366,23 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 			sdev->qdep = 0;
 	}
 
+	ret = cache_tag_assign_domain(to_dmar_domain(domain), dev, pasid);
+	if (ret)
+		goto free_sdev;
+
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, pasid,
 					    FLPT_DEFAULT_DID, sflags);
 	if (ret)
-		goto free_sdev;
+		goto unassign_tag;
 
 	list_add_rcu(&sdev->list, &svm->devs);
 
 	return 0;
 
+unassign_tag:
+	cache_tag_unassign_domain(to_dmar_domain(domain), dev, pasid);
 free_sdev:
 	kfree(sdev);
 free_svm:
@@ -795,6 +801,8 @@ struct iommu_domain *intel_svm_domain_alloc(void)
 	if (!domain)
 		return NULL;
 	domain->domain.ops = &intel_svm_domain_ops;
+	INIT_LIST_HEAD(&domain->cache_tags);
+	spin_lock_init(&domain->cache_lock);
 
 	return &domain->domain;
 }
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index 5402b699a122..c8beb0281559 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
-obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o
+obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o cache.o
 obj-$(CONFIG_DMAR_TABLE) += trace.o cap_audit.o
 obj-$(CONFIG_DMAR_PERF) += perf.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
-- 
2.34.1


