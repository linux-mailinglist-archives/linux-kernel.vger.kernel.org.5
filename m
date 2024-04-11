Return-Path: <linux-kernel+bounces-139689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AEF8A0684
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78161F25CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F1413B792;
	Thu, 11 Apr 2024 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRyKRaQS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDDC13B5B7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804941; cv=none; b=qF3BXBNAo6aZm4ie7VUta4aSet03pKjKzGEonbBYt3vjdfqp2I3o0U0yHFCc2VwGcMyfdIqsfks0UBhc23ZoWLnnT5TMZOM8siCKMchutl8YFqo9dwFF3vBJZ9QGioM3gywJ2ZKFkgb6gyWKIFiHi6uY6wYP7PYJ7o0MOzVgnFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804941; c=relaxed/simple;
	bh=CrCQveiZdwYAH0mjaVPcjR6DITjQEl30tKTsxVaY4M0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oGNLlvwSM8T70OiIqRr/PgIPxsI45PgWhNpbNnfWuHuMkrEuSSGZkZ04CObt2JY77PcpwJIK2tlJgJw+mIgtvHuzJSrvkHjG3fzGaRuTN86V2U9Hhd6JRIPp3iwu4enilG/xRCsQXTMcjY3QFK1FCP8pIWDQZISLH+8m08FsN1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRyKRaQS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712804940; x=1744340940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CrCQveiZdwYAH0mjaVPcjR6DITjQEl30tKTsxVaY4M0=;
  b=GRyKRaQSyI0JIockxFlNIh7R7vxnsTGbdd0S8N+PJlNHhyYOWFAJEhJy
   3sSmXZJjb/Il489d5Rgz7kpgms/4SqksIGEsn6K+MMLfPA5+pcfSWANii
   1xXO/Zv4HjfLgWtruOznpAvTO7zHVNO6WqTEFW/ObL8IFv+bYWYNOw7WV
   uEm/BX8K8HZOLpbcVfX6390zfSh5WMm4XyBNRBHz+4GXtZ+6ShAykvz1Q
   yw0Mm9xfOaFzY2sECANVyvzXsmDq2b9F8mKXvOCl/Alz9L5/M62dhCKkn
   WzQlZtarKyHSf9srvL3Yur01AiTmXFLFbKqxElT4TguKNy7tfJ9QGImaT
   w==;
X-CSE-ConnectionGUID: faPHAm63TeSvCcMfzzkCZw==
X-CSE-MsgGUID: +CXydNXaR6CHR/2PTL3IhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="30681438"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="30681438"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 20:08:59 -0700
X-CSE-ConnectionGUID: 6U1REfodQoa03XAI2YHA1Q==
X-CSE-MsgGUID: Q0hxQO99SRKIYxHMhqIDTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="20822964"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 10 Apr 2024 20:08:57 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Xuchun Shang <xuchun.shang@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iommu/vt-d: Fix wrong use of pasid config
Date: Thu, 11 Apr 2024 11:07:42 +0800
Message-Id: <20240411030744.273460-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411030744.273460-1-baolu.lu@linux.intel.com>
References: <20240411030744.273460-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuchun Shang <xuchun.shang@linux.alibaba.com>

The commit "iommu/vt-d: Add IOMMU perfmon support" introduce IOMMU
PMU feature, but use the wrong config when set pasid filter.

Fixes: 7232ab8b89e9 ("iommu/vt-d: Add IOMMU perfmon support")
Signed-off-by: Xuchun Shang <xuchun.shang@linux.alibaba.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20240401060753.3321318-1-xuchun.shang@linux.alibaba.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index cf43e798eca4..44083d01852d 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -438,7 +438,7 @@ static int iommu_pmu_assign_event(struct iommu_pmu *iommu_pmu,
 	iommu_pmu_set_filter(domain, event->attr.config1,
 			     IOMMU_PMU_FILTER_DOMAIN, idx,
 			     event->attr.config1);
-	iommu_pmu_set_filter(pasid, event->attr.config1,
+	iommu_pmu_set_filter(pasid, event->attr.config2,
 			     IOMMU_PMU_FILTER_PASID, idx,
 			     event->attr.config1);
 	iommu_pmu_set_filter(ats, event->attr.config2,
-- 
2.34.1


