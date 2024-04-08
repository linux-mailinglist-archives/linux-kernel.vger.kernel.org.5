Return-Path: <linux-kernel+bounces-134772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF78589B6AE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F05D1C20C8A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0795244;
	Mon,  8 Apr 2024 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdezWKlR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BAB5228;
	Mon,  8 Apr 2024 04:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712549161; cv=none; b=u6KNiokp8IuDgwy6YGgtEOPh4gT3TEV781lQrLoF19ZI0NlavwaWS3kry6OQ2ysVgYszumnYaG6ioFpYECmAjCBsHq2eMddFx08tv+6BpwvX8OPs1sUGkek70sGnKHllddaYNdna5lVe/O38KFjLkFrn5lxGa9lo3aBWQJiQFl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712549161; c=relaxed/simple;
	bh=0n0ybe62mdtqwWktMxjD8Zzy1Cw8ZQWIbTkqqEhdaKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hZ/zsw/n8zVrDKJBjw3TFguI3b3/EhhJjxwqmlSFSuNZBmJayFIdMX9hBUIGrYz2/PeYKotYLwiPrxqkoD3tEnq6oJTuNiS3y/Oq/eXG2WUMB0etPnL4UGn6lOSLb5FVKBzaajGVM8yZsbqHGpYZFs2kAfMit7FxMtn7yMviqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdezWKlR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712549159; x=1744085159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0n0ybe62mdtqwWktMxjD8Zzy1Cw8ZQWIbTkqqEhdaKg=;
  b=FdezWKlRunj7fLVWA2D+QcrRe1XM7nB8wymR1CHldrJkvmkirVB7GofC
   bZ9scJwAur9Iuk8NcMk20o4W4kGwZUxDB/yO1KR2/qug4qdDWnr3Z0jDr
   v4R5WdudCDfZ0Nk1mypNlPBZRp4mOWgI4qKkAon3P9nKX7lNYplrFmE14
   1MID8ZHn/FZLRvDzdk2r0UXBGC9VIUC9WEkNmCEO+0/uWgP+6gWZwslH1
   ljEHEl25D6EU6UoRVNZ0u+UW3jjhsRs3nVBVsMAKVz/NRELulYS9wQXx8
   YRXd6aVoSVTEcfa3Sylkglv6asyz3KAp3rx++zFYrWPU2wiJmhfZNhki0
   w==;
X-CSE-ConnectionGUID: 6r/41zU4R7WJanRoPWmHVw==
X-CSE-MsgGUID: MnIznXZkQFO05UcLH841rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="8386161"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="8386161"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 21:05:59 -0700
X-CSE-ConnectionGUID: 0yb+CHuNRjSipHmbiq/6SQ==
X-CSE-MsgGUID: kdLSx+BfQ1yV+eEow+JXQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="24492104"
Received: from lihon19x-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.249.173.91])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 21:05:57 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] powercap: intel_rapl: Add support for ArrowLake-H platform
Date: Mon,  8 Apr 2024 12:05:48 +0800
Message-Id: <20240408040548.249664-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ArrowLake-H platform.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index a28d54fd5222..c02851c73751 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1263,6 +1263,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
 
-- 
2.34.1


