Return-Path: <linux-kernel+bounces-134763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D589B696
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E7F1F2235A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9664C63;
	Mon,  8 Apr 2024 03:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NToUFCrn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D5E1877;
	Mon,  8 Apr 2024 03:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712548316; cv=none; b=K18ucbF3C+Q1KcPiBu5sSb+oPS2pkhEfjtM+KkBhxVQ3XVcOC2L8flnI8nYoPdizTYIHtSzeV2BLKFsxTWBbMz1l3f1zA+VAaVHAbOnwwqKS/5DzDmp7vpeyxWYWlSyznphhw0TwI5sf9MlXaQqdShCgnturOD1sM/wULxJ5sN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712548316; c=relaxed/simple;
	bh=a5WRdrpXzqncOkmtiK09xnULO4R75zZOYTQ2NFnKQb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DyEKJEBkPNMjmlq37wU7xjVdOmhehQo0F75E5V8LHNdAHjl3SSsuWcp/6LvzwuYZcRPL66l3qH99Q60qB7Ff8Xy+2MH9YBgja1ibLMd8V4zLn0QkgyRIciPAs5p80VuEC/a7JPrc2CUgtE6UA5OR0VgjJmraXnflm/epNw/sZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NToUFCrn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712548314; x=1744084314;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a5WRdrpXzqncOkmtiK09xnULO4R75zZOYTQ2NFnKQb4=;
  b=NToUFCrnY6jF7RuueXfO8yweAinJCwege1xwWGeh/v8JfYX4JMQFk5aD
   1qYnYIyWO8Z5xxJ1K+09nqETyu6CuQMVSdKMesFOsj7eYbw820RoTWHXr
   h+KGbiV6NFoaO28Xxgs8bA+WZPpW6/HUAX0Oz3fNP1U9jNsn2HoO/LP83
   Xud6cPRz9bUaSG8jqXHb+eLO1v/zjS853mAzH6f2tK3NleX+ZmdpOL0YC
   86Q5UjYR2+mDEYD9pjYjSsyPsa/u1DPJuNvxvMQDDl3tr0gmWJ65DzIDD
   GZFzFBuZ8/xeLSZeACugOhWKds+3m1+cMIhIhgPDIZ8mCTjQF9uvZelIo
   w==;
X-CSE-ConnectionGUID: FgxRb7/YTYSt9im0xW3c6A==
X-CSE-MsgGUID: HsK4t36lQmOTknPXycEgnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7909938"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7909938"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 20:51:53 -0700
X-CSE-ConnectionGUID: feYA/dpTSXi43Xbi61+pQg==
X-CSE-MsgGUID: abjSVbMVQsenflHuxnXlWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19870349"
Received: from lihon19x-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.249.173.91])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 20:51:51 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH V2 0/3] powercap: Introduce TPMI RAPL PMU support
Date: Mon,  8 Apr 2024 11:51:38 +0800
Message-Id: <20240408035141.248644-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RAPL energy counter MSRs are exposed via perf PMU. But this is done by
separate code which is not part of RAPL framework, and it cannot be
reused by other RAPL Interface drivers like TPMI RAPL.

Introduce two new APIs for PMU support in RAPL framework. This allows
TPMI RAPL PMU support and also makes it possible for future cleanups of
MSR RAPL PMU code.

Changes since V1:
- remove the MSR RAPL PMU conversion because it is a separate work that
  can be done later.
- instead of using a flag to indicate the need of PMU support, introduce
  two APIs for the RAPL Interface driver to invoke explicitly.
- minor code/comments/changelog improvements.

thanks,
rui

----------------------------------------------------------------
Zhang Rui (3):
      powercap: intel_rapl: Sort header files
      powercap: intel_rapl: Introduce APIs for PMU support
      powercap: intel_rapl_tpmi: Enable PMU support

 drivers/powercap/intel_rapl_common.c | 561 ++++++++++++++++++++++++++++++++++-
 drivers/powercap/intel_rapl_tpmi.c   |   3 +
 include/linux/intel_rapl.h           |  23 ++
 3 files changed, 575 insertions(+), 12 deletions(-)

