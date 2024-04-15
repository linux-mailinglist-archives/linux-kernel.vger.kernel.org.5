Return-Path: <linux-kernel+bounces-146027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3242E8A5F06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600881C21370
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59846159906;
	Mon, 15 Apr 2024 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJeDRkHk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC54F1591F4;
	Mon, 15 Apr 2024 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225496; cv=none; b=HSLbJP0gpf9P3MNodv/FhdpEjz6vYv+JtI8zHo9oIRC9wm/nc2k+C4fxYTDbGtRjrMeCdJcQ2oRNPk19wUdzG7W3YoclMQ7ZWcGU2GxMeEaGIeDyv3AEXYR/2MOL6RKCaxkzqGoVWy2h0R4sHGX7ea01Hjj5Wd3NhoBjCBFz+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225496; c=relaxed/simple;
	bh=S9uHbUvF9BAPlZALEKSXUhEc5OPZdpFJasa6wIfrH+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kskPvacPR/Sv9UBY+2wv2Hqlm717KVNe/n0YeqllBSpsTDOO5NJx8s19vdY6i5Ydl5E74CGkhaNA5tlRhWx49KbjDSrU1ZmmrRvZ7ZYSZouPlXJn2BReNTZiOSIS+bZnPxssjywir5PKIaAlDHAEGKBrsw3O+YpgVUDqFgiYFck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJeDRkHk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713225495; x=1744761495;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S9uHbUvF9BAPlZALEKSXUhEc5OPZdpFJasa6wIfrH+k=;
  b=LJeDRkHk9X3jVgvff9mbBOcz92AOwteL6C3kyBj/SpfNrYTPgpB4SX+Z
   jNVJ+W6PTPI7ZRNRqMXg+DPevhpCzqEBRUB/sSEaHpF6aFO6ofYy/N3tQ
   lPXuVzGRkRYg6kNOKwI4Sfp88PIY/1wtHhCm5dBBffK0N7DTYddgAp7FU
   txOifcJ5ujMMKi76UJXVPqAhoq92mpCNXqGQ/T3Zi+4I7mSUqXS3Zg/bi
   7fS6TWTqFGZpRTjY9v/0bbxH63vdei+qBVnA4xJNYn5tOhO1ZMIvdocDJ
   jjL8HwZvsRlS6k+KtTr1scVzf48Q1ewaWsnIzul5/GNqSyBuLqyeHHKA2
   g==;
X-CSE-ConnectionGUID: 3bmwH6AQTx+9ZZcBzIHQNQ==
X-CSE-MsgGUID: ku+fAmcLQDeqKANxhfG8gw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8559772"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8559772"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 16:58:14 -0700
X-CSE-ConnectionGUID: MqQeaqcQTACYunSUN7XgrQ==
X-CSE-MsgGUID: 2AlKMFcsRAG/Hni17fvJ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="21975192"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 16:58:14 -0700
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
Subject: [PATCH v2] fpga: dfl: remove unused function is_dfl_feature_present
Date: Mon, 15 Apr 2024 19:57:43 -0400
Message-ID: <20240415235743.3045-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function is_dfl_feature_present was added but never used.

Fixes: 5b57d02a2f94 ("fpga: dfl: add feature device infrastructure")
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v2:
- Do not wrap commit reference and move to Fixes: tag.
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


