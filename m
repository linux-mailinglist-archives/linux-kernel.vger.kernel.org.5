Return-Path: <linux-kernel+bounces-128807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072C9895FD2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DC02871E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054D3A1CB;
	Tue,  2 Apr 2024 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAS8fVlj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB42260B;
	Tue,  2 Apr 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712098224; cv=none; b=EhVmvI/TgJHwOvDMV9QxY3Rf/isjtsjlgXn438nL2Ohz/pvLkoDNa2MAzvWwpczRd+65glr+QaGaXZfyrMqeFIGbzrQ1XQe/DCkA2reB1K5ZjDzvcFxfetGnsKxvbuQEBCLXlWrsz9wOUPHR6cRzWgr4OAERYyh+q6vvh8snXYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712098224; c=relaxed/simple;
	bh=sa/omHLiyGMBc27nW4Us7Ky2vKsCVdFO3sXjahJBIb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWG+vLO8tDN1JPM5EbXjhx5mR7s1ovD483EJEXmfY1c2YnzoZ859B2V64z956xdnEh384o864tYxaZOD4C/3oVJUAqRZFLV0SsO8794qneW8nJ+nkAMuG91ygtA4IVyFVurJpgj8dai6ob2uws4Gai30K06hxxV2PBypxencTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAS8fVlj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712098222; x=1743634222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sa/omHLiyGMBc27nW4Us7Ky2vKsCVdFO3sXjahJBIb8=;
  b=OAS8fVljaCuhL6kK8+bMEJNOqo9suQVpKPQ3utfVvWTpw3VZKpAEHMhf
   RET8I5x6dHIj725tveGHl/j2MJ+WTqPH064tnViuLGRtTegdYiVQ76DZI
   lqZvZoDLATvAPtl4Jxq/hGwpl0w0QRF/lMq625tSJpup7bYbsgicnozf3
   MgoLahiSspOPjWIn5I4cX9eUwmzuwk09cigptL9D9moPIt833QBbvOdY5
   vIhNXHxnThdoZasr1OKRobwkla7nY9YlfpO/KVf9Q8oG2r2Lxc/jTdHSM
   qp2LCRForZcUbm1mslgoIQP5/URll0NkHheZzDc7V9bhI6jSb54bn/MLF
   A==;
X-CSE-ConnectionGUID: yEB0SK9bRcKIX2PuIJQ6uQ==
X-CSE-MsgGUID: zvahhLrMS76WF8aW+QmYLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17872830"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="17872830"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 15:50:21 -0700
X-CSE-ConnectionGUID: dANSClrmTUOwW4r2UKO4Qw==
X-CSE-MsgGUID: zLHSzZJOStmCYzZfUZMweQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18040585"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 15:50:21 -0700
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
Subject: [PATCH] fpga: dfl: remove unused function is_dfl_feature_present
Date: Tue,  2 Apr 2024 18:20:38 -0400
Message-ID: <20240402222038.1438718-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function is_dfl_feature_present was added in commit 5b57d02a2f94
("fpga: dfl: add feature device infrastructure") but never used.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/fpga/dfl.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 1d724a28f00a..5063d73b0d82 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -437,11 +437,6 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
 	return NULL;
 }
 
-static inline bool is_dfl_feature_present(struct device *dev, u16 id)
-{
-	return !!dfl_get_feature_ioaddr_by_id(dev, id);
-}
-
 static inline
 struct device *dfl_fpga_pdata_to_parent(struct dfl_feature_platform_data *pdata)
 {
-- 
2.44.0


