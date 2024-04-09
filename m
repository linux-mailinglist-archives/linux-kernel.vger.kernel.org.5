Return-Path: <linux-kernel+bounces-137712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CE389E644
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949C82832D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A687815A491;
	Tue,  9 Apr 2024 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lfrx7O2q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E9159584;
	Tue,  9 Apr 2024 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706120; cv=none; b=TDRlkGpxtp9JGrk8j9x38Kbffz0FMjKBKLS74tLNyg5P/Md2jxtAg9jeI6oXlykg93p0rccqChJrCBZv/5oKCrcCFIiv/cOO+Pe7pshwNebY18O3hh3PkzgN0/e4KyS9B3TWvQtavaqxZ3s3znP2H1pg+ue3zRh1NMsMX3WgJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706120; c=relaxed/simple;
	bh=mQhWXKPhUS8SNMgiD/05CRPzutPNt0WnvhIEFUacyp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTcH4ngpSeIA24GcWK/0EzsYYwAJWlkC5MSaiaOjdepBIRNwB18pW4Ih4kbwHdV4bGzbpEzb656V9eI1xjRN6+wZPYNbZmsn/Y1zCh0/E+FS1znAmQmJJ6JzpEoUlMFUX5rLpiz8dt7pudMv/LoXLp0s57J+bCDk6uDutQcCxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lfrx7O2q; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706119; x=1744242119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mQhWXKPhUS8SNMgiD/05CRPzutPNt0WnvhIEFUacyp0=;
  b=Lfrx7O2qwH6RnT1ydsV0G6egAKdI1EMGkgUC7joi5Pk1LqohfGUWNeOH
   l26eSIO8Ap+T/TDDtRbFPr2LUXhPyAD5xuTrvuujnk/lJ1Qrydnrl2/ZK
   fr/1swjyz+zGpmgFwghIZ196kdutgyBbbSFfZOHHlgVC98i4NUUqFVxZ6
   H8Oo0GYG9R+56nfeV0CsrLvmaSjXKVOi0uICLN4Y7Pj5USDT9sWlxTf6r
   Lep2vvB7p/OIoWacLkc3AKFWrxuYQvs80wbATbexSvgjrHD1vD0GVCN1A
   FzUhoU7JJlP+AJl+MPaDJFRxe1YDzm5ESq8rdMUdkN594QbjlnJ1kco9r
   Q==;
X-CSE-ConnectionGUID: h/G2L276QTqZWcxl5nr++w==
X-CSE-MsgGUID: 5JET+GnTQBeBhAuor9PaRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33455118"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="33455118"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:59 -0700
X-CSE-ConnectionGUID: MQTPzM6oS+mtCptV+q+HFQ==
X-CSE-MsgGUID: RVmBPh18SC6H/M6ApUF+gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20261817"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:59 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [RFC PATCH v2 7/9] fpga: dfl: migrate DFL support header to dfl_feature_dev_data
Date: Tue,  9 Apr 2024 19:39:40 -0400
Message-ID: <20240409233942.828440-8-peter.colberg@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409233942.828440-1-peter.colberg@intel.com>
References: <20240409233942.828440-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change separates out most of the symbol name changes required by this
patch series for the file: drivers/fpga/dfl.h. This is done to split a
single monolithic change into multiple, smaller patches at the request of
the maintainer.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
v2:
- Split monolithic patch into series at request of maintainer
---
 drivers/fpga/dfl.h | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index d724614796cb..b700f5bb7be7 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -333,55 +333,51 @@ struct dfl_feature_platform_data {
 };
 
 static inline
-int dfl_feature_dev_use_begin(struct dfl_feature_platform_data *pdata,
+int dfl_feature_dev_use_begin(struct dfl_feature_dev_data *fdata,
 			      bool excl)
 {
-	if (pdata->excl_open)
+	if (fdata->excl_open)
 		return -EBUSY;
 
 	if (excl) {
-		if (pdata->open_count)
+		if (fdata->open_count)
 			return -EBUSY;
 
-		pdata->excl_open = true;
+		fdata->excl_open = true;
 	}
-	pdata->open_count++;
+	fdata->open_count++;
 
 	return 0;
 }
 
 static inline
-void dfl_feature_dev_use_end(struct dfl_feature_platform_data *pdata)
+void dfl_feature_dev_use_end(struct dfl_feature_dev_data *fdata)
 {
-	pdata->excl_open = false;
+	fdata->excl_open = false;
 
-	if (WARN_ON(pdata->open_count <= 0))
+	if (WARN_ON(fdata->open_count <= 0))
 		return;
 
-	pdata->open_count--;
+	fdata->open_count--;
 }
 
 static inline
-int dfl_feature_dev_use_count(struct dfl_feature_platform_data *pdata)
+int dfl_feature_dev_use_count(struct dfl_feature_dev_data *fdata)
 {
-	return pdata->open_count;
+	return fdata->open_count;
 }
 
-#define dfl_fpga_fdata_set_private dfl_fpga_pdata_set_private
-
 static inline
-void dfl_fpga_pdata_set_private(struct dfl_feature_platform_data *pdata,
+void dfl_fpga_fdata_set_private(struct dfl_feature_dev_data *fdata,
 				void *private)
 {
-	pdata->private = private;
+	fdata->private = private;
 }
 
-#define dfl_fpga_fdata_get_private dfl_fpga_pdata_get_private
-
 static inline
-void *dfl_fpga_pdata_get_private(struct dfl_feature_platform_data *pdata)
+void *dfl_fpga_fdata_get_private(struct dfl_feature_dev_data *fdata)
 {
-	return pdata->private;
+	return fdata->private;
 }
 
 struct dfl_feature_ops {
@@ -414,9 +410,9 @@ struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
 	return pdata->dev;
 }
 
-#define dfl_fpga_dev_for_each_feature(pdata, feature)			    \
-	for ((feature) = (pdata)->features;				    \
-	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
+#define dfl_fpga_dev_for_each_feature(fdata, feature)			    \
+	for ((feature) = (fdata)->features;				    \
+	   (feature) < (fdata)->features + (fdata)->num; (feature)++)
 
 static inline
 struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u16 id)
@@ -445,12 +441,10 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
 
 #define to_dfl_feature_dev_data dev_get_platdata
 
-#define dfl_fpga_fdata_to_parent dfl_fpga_pdata_to_parent
-
 static inline
-struct device *dfl_fpga_pdata_to_parent(struct dfl_feature_platform_data *pdata)
+struct device *dfl_fpga_fdata_to_parent(struct dfl_feature_dev_data *fdata)
 {
-	return pdata->dev->dev.parent->parent;
+	return fdata->dev->dev.parent->parent;
 }
 
 static inline bool dfl_feature_is_fme(void __iomem *base)
-- 
2.44.0


