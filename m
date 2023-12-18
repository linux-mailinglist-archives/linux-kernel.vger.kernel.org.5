Return-Path: <linux-kernel+bounces-3108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AB181678A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76131C20943
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49483101C0;
	Mon, 18 Dec 2023 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTYub1fu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D200DF47
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702885177; x=1734421177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QEjM+mCRBO6H6hco8TQ65Esf+zuBywOLjMv+hLe6C38=;
  b=RTYub1fudmm8r5gOPkW3pE7127fItuknOLgeDulojstwMksqPQjdYZLl
   hiXIDuH8En4+qmCmZ88JqjS6eCHNWnRX1yLlyvE+gtc/c+V94ipttb4mi
   6zjNHIeGpwqRj9VywFGVwp6j5/vnG+xfhKsmtN2axCo9S+c22+4w687mW
   R/V/bOwQYH8gB+yb/d+Js16WYfqZix4Qp8yuYtqDZshQk5LUj6hZZWfQw
   rlZMdMf1YY/9mq5MjivDjC+127vwCuhfPgR1qeObahczpbXi88uft82Mr
   MpRfluZ25coqdKj/2A/xEiN6H0pHQL4uN1qD3A5qadSs/n8hSnXanGZiw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="459793931"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="459793931"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 23:39:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="893723256"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="893723256"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 17 Dec 2023 23:39:35 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iommu/vt-d: Remove unused parameter of intel_pasid_setup_pass_through()
Date: Mon, 18 Dec 2023 15:34:43 +0800
Message-Id: <20231218073445.142401-3-baolu.lu@linux.intel.com>
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

The domain parameter of this helper is unused and can be deleted to avoid
dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20231116015048.29675-3-baolu.lu@linux.intel.com
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
index 874d35f760fb..a91959c42781 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2462,7 +2462,7 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
 		/* Setup the PASID entry for requests without PASID: */
 		if (hw_pass_through && domain_type_is_si(domain))
-			ret = intel_pasid_setup_pass_through(iommu, domain,
+			ret = intel_pasid_setup_pass_through(iommu,
 					dev, IOMMU_NO_PASID);
 		else if (domain->use_first_level)
 			ret = domain_setup_first_level(iommu, domain, dev,
@@ -4801,8 +4801,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
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


