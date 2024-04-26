Return-Path: <linux-kernel+bounces-160210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC248B3A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810631F24D17
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2F148FF4;
	Fri, 26 Apr 2024 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2MlZHaF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABAC148846;
	Fri, 26 Apr 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144019; cv=none; b=ZixxIQn+VCcBOJnKq4IyUGKnNJ0J87mUZwbvAQPTmabG7GExAtsQo0hu2mKujrQwkrkNLQR+0jtqxE5LEpM2L/BvHJo99NwE4n1Gfehfnwtbe0+S+7J355AhZVfwmNKAzsHYs0PWhDQzVk9E1ZBVGSRmTpvpuh2lu7DgdcUc57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144019; c=relaxed/simple;
	bh=ncTVHNygt84sLGMiwmdLqfXu6MVvic3n8Py3fm7DG00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pWDQjKCLj2T96aD/YyJqqFQ+fk1PsmtlMduVmWgEg2URor5PdmUWZTMRALrwxoNisluHfiWD0uaMcHFem1F0uVABWj5KDAzp33QU7br15NeOhsyBtIM3XcyDBB6YUSnP9IjHXMTjsKjSpHQeVOuVpSQQAhB+ZmXbajpMbliiCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2MlZHaF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714144017; x=1745680017;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ncTVHNygt84sLGMiwmdLqfXu6MVvic3n8Py3fm7DG00=;
  b=L2MlZHaFPqibHt7ZfC+CX3ZR02me0rcNzhFwyvkQL6yiqU4FZ+PPkGRh
   iuSbpM074Gi526No+wxMfvHO4Z1D/zxAX15p829nlQdN5kg+K10VLPsuY
   92H7B6uTSSjnnIIAF5tlVJ31fLfh2wHGiJvvLFd1KWQHOLNESj+TUVrL2
   BZeRQP1oM+scNpO+bdU9CeyOsjH+KbQzgX5eWypgrgX1PXgSCpq38frE/
   Dx+0AfgHyt8GD1ivhjl9BKO/aFKkVUVdgKWYY7OAu+rMdKxi+hkuBVkC0
   OjgP3jVyDTqy7ppf83vBvdgU07WlE3KJYxnCrgmX6/I/O//+qmiAeRPQm
   g==;
X-CSE-ConnectionGUID: CxheVWS1Q4ektaLNCiTIWw==
X-CSE-MsgGUID: wKiO8BF9ToynOZN2DRxGbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="35269262"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="35269262"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:06:56 -0700
X-CSE-ConnectionGUID: 1RUVn8Y9T/mQyMy1zY+F5g==
X-CSE-MsgGUID: /O+8e8J3TPmWp53xRzjg/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25519467"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 26 Apr 2024 08:06:56 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-kernel@vger.kernel.org
Cc: eranian@google.com,
	ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Ahmad Yasin <ahmad.yasin@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel: Add a distinct name for Granite Rapids
Date: Fri, 26 Apr 2024 08:05:57 -0700
Message-Id: <20240426150557.2857936-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Currently, the Sapphire Rapids and Granite Rapids share the same PMU
name, sapphire_rapids. Because from the kernel’s perspective, GNR is
similar to SPR. The only key difference is that they support different
extra MSRs. The code path and the PMU name are shared.

However, from end users' perspective, they are quite different. Besides
the extra MSRs, GNR has a newer PEBS format, supports Retire Latency,
supports new CPUID enumeration architecture, doesn't required the
load-latency AUX event, has additional TMA Level 1 Architectural Events,
etc. The differences can be enumerated by CPUID or the PERF_CAPABILITIES
MSR. They weren't reflected in the model-specific kernel setup.
But it is worth to have a distinct PMU name for GNR.

Fixes: a6742cb90b56 ("perf/x86/intel: Fix the FRONTEND encoding on GNR and MTL")
Suggested-by: Ahmad Yasin <ahmad.yasin@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f3315f13f920..da38a16b2cbc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6768,12 +6768,17 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_EMERALDRAPIDS_X:
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 		x86_pmu.extra_regs = intel_glc_extra_regs;
+		pr_cont("Sapphire Rapids events, ");
+		name = "sapphire_rapids";
 		fallthrough;
 	case INTEL_FAM6_GRANITERAPIDS_X:
 	case INTEL_FAM6_GRANITERAPIDS_D:
 		intel_pmu_init_glc(NULL);
-		if (!x86_pmu.extra_regs)
+		if (!x86_pmu.extra_regs) {
 			x86_pmu.extra_regs = intel_rwc_extra_regs;
+			pr_cont("Granite Rapids events, ");
+			name = "granite_rapids";
+		}
 		x86_pmu.pebs_ept = 1;
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = glc_get_event_constraints;
@@ -6784,8 +6789,6 @@ __init int intel_pmu_init(void)
 		td_attr = glc_td_events_attrs;
 		tsx_attr = glc_tsx_events_attrs;
 		intel_pmu_pebs_data_source_skl(true);
-		pr_cont("Sapphire Rapids events, ");
-		name = "sapphire_rapids";
 		break;
 
 	case INTEL_FAM6_ALDERLAKE:
-- 
2.35.1


