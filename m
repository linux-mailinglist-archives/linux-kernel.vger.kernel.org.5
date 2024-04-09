Return-Path: <linux-kernel+bounces-137706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B5D89E639
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337971C22722
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B22158DD4;
	Tue,  9 Apr 2024 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mn85nTXh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FBF158DCB;
	Tue,  9 Apr 2024 23:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706112; cv=none; b=gkkbmnPe4m6GTP5UBaDKdChw6sU5rec7eMuB3dAAPziqjjTh78Eculkry1aYp3gTGkdlRrmWANTOd/Iwa6695UyT15iXc9pcPPgVeDlhculwSKKHdD7HVGaGqB3ORpIYJ8mg3gP8fPoPPO2XK8JLE9W3Nl3DfXEuNVYxqB3A+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706112; c=relaxed/simple;
	bh=XZPnuMGpxPe4CWkciEp2JpTmAZ+j8o4aGih5VYVyakI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjjhtOLVEm+7nGqF3yMV4Nv5i6cZzpUIVz1kPGCmcvY+AByaIX6ViciB6Co+2aXs2nQtzoaZHQHaJYM8q8UuFrxBES+ctgxcVdP7EFsfG90Q2C7wFnDDsTiNtHtcRLkfKbHrRk7YalFx9s/RPSN3zepe5cKLgBgUEwPPig+OXHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mn85nTXh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706111; x=1744242111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XZPnuMGpxPe4CWkciEp2JpTmAZ+j8o4aGih5VYVyakI=;
  b=mn85nTXhCzQ0ICNEt5FT6vW8Y95ArwiQkBVKwYlBL07qbzkEJZK0aQpf
   NsNk0FQxCgh7dq2WTbXhk+9ZIjmQF3Ipv45YWKDTTleZj+saguNOTIiK4
   6q+8A79yBP5pTtA6b5jaMwtEdjmKMLlxw1FlqcpZnu830Vq0EhdXkpa/h
   NrJk8KsrVpiipF7Za3bbbgmGgG/Ynks/pUL9pKq6p1KolZ+79Jq7lbyXX
   L6v92AEGHRaZQf0lRu8hX8j+7JPpYW2wfIQX7EuSAAHTVzQk4F8W5YyB2
   P0uyxmyee26K/kifi6/UMUNvZGbvHN3yblLA5fEPL0gWRXxhM61hxKCvq
   A==;
X-CSE-ConnectionGUID: 4su5iyT6S2OLbD6krFDGnw==
X-CSE-MsgGUID: L+EPuzZERVSot2bXLFf7UQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33455081"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="33455081"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:50 -0700
X-CSE-ConnectionGUID: a2dS8efpQj2fCUyxkDfvxg==
X-CSE-MsgGUID: R7bkZ9y7T/Cz2I8Ls/zsNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20261714"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:50 -0700
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
Subject: [RFC PATCH v2 1/9] fpga: dfl: alias dfl_feature_dev_data to dfl_feature_platform_data
Date: Tue,  9 Apr 2024 19:39:34 -0400
Message-ID: <20240409233942.828440-2-peter.colberg@intel.com>
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

Add temporary macros that alias dfl_feature_dev_data ("fdata") to
dfl_feature_platform_data ("pdata") and associated functions from the
"fdata" to the corresponding "pdata" variants. This is done to split a
single monolithic change into multiple, smaller patches at the request of
the maintainer. The macros will be removed in the last patch of the series.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
v2:
- Split monolithic patch into series at request of maintainer
---
 drivers/fpga/dfl.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 5063d73b0d82..d724614796cb 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -206,6 +206,8 @@
 #define PORT_UINT_CAP_INT_NUM	GENMASK_ULL(11, 0)	/* Interrupts num */
 #define PORT_UINT_CAP_FST_VECT	GENMASK_ULL(23, 12)	/* First Vector */
 
+#define dfl_feature_dev_data dfl_feature_platform_data
+
 /**
  * struct dfl_fpga_port_ops - port ops
  *
@@ -365,6 +367,8 @@ int dfl_feature_dev_use_count(struct dfl_feature_platform_data *pdata)
 	return pdata->open_count;
 }
 
+#define dfl_fpga_fdata_set_private dfl_fpga_pdata_set_private
+
 static inline
 void dfl_fpga_pdata_set_private(struct dfl_feature_platform_data *pdata,
 				void *private)
@@ -372,6 +376,8 @@ void dfl_fpga_pdata_set_private(struct dfl_feature_platform_data *pdata,
 	pdata->private = private;
 }
 
+#define dfl_fpga_fdata_get_private dfl_fpga_pdata_get_private
+
 static inline
 void *dfl_fpga_pdata_get_private(struct dfl_feature_platform_data *pdata)
 {
@@ -437,6 +443,10 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
 	return NULL;
 }
 
+#define to_dfl_feature_dev_data dev_get_platdata
+
+#define dfl_fpga_fdata_to_parent dfl_fpga_pdata_to_parent
+
 static inline
 struct device *dfl_fpga_pdata_to_parent(struct dfl_feature_platform_data *pdata)
 {
-- 
2.44.0


