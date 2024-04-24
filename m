Return-Path: <linux-kernel+bounces-157473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F83F8B1204
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8CF1F21FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C15180A99;
	Wed, 24 Apr 2024 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7/XmhJV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1317F393;
	Wed, 24 Apr 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982519; cv=none; b=T5huLxHU9ZpZwVlZ27HtK92iFW/1xSNVj9J7Vcu+gB1AFCK1RZ6NmnuOWhpFPPQdhs8rkp7zSn3qzoRrgztuX3OJ6Ybwp/6qpcSSaIcCU6oSRENAPadcBFtVjd4d/yBXA96CvH/FLmmYt55QMAfSgCI6me8wO4qAGAazjSxW5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982519; c=relaxed/simple;
	bh=8UQAqNekjg9PUGac6X2MaPesViGhIMmQkwSJ6hmLGVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/AbuSp9J1E7ociiE7G/AGC07LMV0g5e087uYhJuQzdVBfEoeIHuMA/snVr53Dz8z2w+9fbfeuUJuEfqZ4Sff5YItz3uciUiNC/j1jfOH1+4HfboftdPuiX1UrPYtMMIgy5cM+Atkrs2RRldvecOhwj6PZS2r8myX9XUDIIR5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7/XmhJV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982517; x=1745518517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8UQAqNekjg9PUGac6X2MaPesViGhIMmQkwSJ6hmLGVc=;
  b=i7/XmhJVyzzmBitM6qlXuuSsaW8AUGyQ3WyRn9iVVlIR+Yw9RxMwFXJs
   Dtg8tedLRUl4BROWWq60Bqqz1qs6y18Svn0J7kJNPH3FgbvvJ3zPJbZYh
   sgZBPzbJJMKMbX0YNXvzKMogNqPJQUibOnMcw7KmTRcg6VOsfujzzHwRh
   /mRl66EN77isOP2+2xSmx1KCO1A8+d9Fi6DBGBglKMRoCa5dWA5AXoasA
   Vyx0wK8VIX6vSxgmjWMTSEp506/fnX8HH23+R56EumFCzgGB4xGPMXSZ9
   FoCYpc21SBc47TYCnvC/FcesEc9KbJ02EDMSWdW/I4suL+KAjRVmoXDP7
   w==;
X-CSE-ConnectionGUID: DRDSns2DRWeni47EcUiqZA==
X-CSE-MsgGUID: cJbaAQrUQTeojap1HtcRuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481919"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481919"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:04 -0700
X-CSE-ConnectionGUID: JpkwHJ5qT7uNl2yr25dvbg==
X-CSE-MsgGUID: B7y1IQoSTaaDvWuFEobSCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262676"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:04 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 24/71] perf/x86/msr: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:03 -0700
Message-ID: <20240424181503.41614-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/events/msr.c | 132 +++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 9e237b30f017..45b1866ff051 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -2,7 +2,7 @@
 #include <linux/perf_event.h>
 #include <linux/sysfs.h>
 #include <linux/nospec.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include "probe.h"
 
 enum perf_msr_id {
@@ -43,75 +43,75 @@ static bool test_intel(int idx, void *data)
 	    boot_cpu_data.x86 != 6)
 		return false;
 
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_NEHALEM:
-	case INTEL_FAM6_NEHALEM_G:
-	case INTEL_FAM6_NEHALEM_EP:
-	case INTEL_FAM6_NEHALEM_EX:
-
-	case INTEL_FAM6_WESTMERE:
-	case INTEL_FAM6_WESTMERE_EP:
-	case INTEL_FAM6_WESTMERE_EX:
-
-	case INTEL_FAM6_SANDYBRIDGE:
-	case INTEL_FAM6_SANDYBRIDGE_X:
-
-	case INTEL_FAM6_IVYBRIDGE:
-	case INTEL_FAM6_IVYBRIDGE_X:
-
-	case INTEL_FAM6_HASWELL:
-	case INTEL_FAM6_HASWELL_X:
-	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_G:
-
-	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_D:
-	case INTEL_FAM6_BROADWELL_G:
-	case INTEL_FAM6_BROADWELL_X:
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:
-	case INTEL_FAM6_EMERALDRAPIDS_X:
-	case INTEL_FAM6_GRANITERAPIDS_X:
-	case INTEL_FAM6_GRANITERAPIDS_D:
-
-	case INTEL_FAM6_ATOM_SILVERMONT:
-	case INTEL_FAM6_ATOM_SILVERMONT_D:
-	case INTEL_FAM6_ATOM_AIRMONT:
-
-	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_GOLDMONT_D:
-	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
-	case INTEL_FAM6_ATOM_TREMONT_D:
-	case INTEL_FAM6_ATOM_TREMONT:
-	case INTEL_FAM6_ATOM_TREMONT_L:
-
-	case INTEL_FAM6_XEON_PHI_KNL:
-	case INTEL_FAM6_XEON_PHI_KNM:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_NEHALEM:
+	case INTEL_NEHALEM_G:
+	case INTEL_NEHALEM_EP:
+	case INTEL_NEHALEM_EX:
+
+	case INTEL_WESTMERE:
+	case INTEL_WESTMERE_EP:
+	case INTEL_WESTMERE_EX:
+
+	case INTEL_SANDYBRIDGE:
+	case INTEL_SANDYBRIDGE_X:
+
+	case INTEL_IVYBRIDGE:
+	case INTEL_IVYBRIDGE_X:
+
+	case INTEL_HASWELL:
+	case INTEL_HASWELL_X:
+	case INTEL_HASWELL_L:
+	case INTEL_HASWELL_G:
+
+	case INTEL_BROADWELL:
+	case INTEL_BROADWELL_D:
+	case INTEL_BROADWELL_G:
+	case INTEL_BROADWELL_X:
+	case INTEL_SAPPHIRERAPIDS_X:
+	case INTEL_EMERALDRAPIDS_X:
+	case INTEL_GRANITERAPIDS_X:
+	case INTEL_GRANITERAPIDS_D:
+
+	case INTEL_ATOM_SILVERMONT:
+	case INTEL_ATOM_SILVERMONT_D:
+	case INTEL_ATOM_AIRMONT:
+
+	case INTEL_ATOM_GOLDMONT:
+	case INTEL_ATOM_GOLDMONT_D:
+	case INTEL_ATOM_GOLDMONT_PLUS:
+	case INTEL_ATOM_TREMONT_D:
+	case INTEL_ATOM_TREMONT:
+	case INTEL_ATOM_TREMONT_L:
+
+	case INTEL_XEON_PHI_KNL:
+	case INTEL_XEON_PHI_KNM:
 		if (idx == PERF_MSR_SMI)
 			return true;
 		break;
 
-	case INTEL_FAM6_SKYLAKE_L:
-	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_SKYLAKE_X:
-	case INTEL_FAM6_KABYLAKE_L:
-	case INTEL_FAM6_KABYLAKE:
-	case INTEL_FAM6_COMETLAKE_L:
-	case INTEL_FAM6_COMETLAKE:
-	case INTEL_FAM6_ICELAKE_L:
-	case INTEL_FAM6_ICELAKE:
-	case INTEL_FAM6_ICELAKE_X:
-	case INTEL_FAM6_ICELAKE_D:
-	case INTEL_FAM6_TIGERLAKE_L:
-	case INTEL_FAM6_TIGERLAKE:
-	case INTEL_FAM6_ROCKETLAKE:
-	case INTEL_FAM6_ALDERLAKE:
-	case INTEL_FAM6_ALDERLAKE_L:
-	case INTEL_FAM6_ATOM_GRACEMONT:
-	case INTEL_FAM6_RAPTORLAKE:
-	case INTEL_FAM6_RAPTORLAKE_P:
-	case INTEL_FAM6_RAPTORLAKE_S:
-	case INTEL_FAM6_METEORLAKE:
-	case INTEL_FAM6_METEORLAKE_L:
+	case INTEL_SKYLAKE_L:
+	case INTEL_SKYLAKE:
+	case INTEL_SKYLAKE_X:
+	case INTEL_KABYLAKE_L:
+	case INTEL_KABYLAKE:
+	case INTEL_COMETLAKE_L:
+	case INTEL_COMETLAKE:
+	case INTEL_ICELAKE_L:
+	case INTEL_ICELAKE:
+	case INTEL_ICELAKE_X:
+	case INTEL_ICELAKE_D:
+	case INTEL_TIGERLAKE_L:
+	case INTEL_TIGERLAKE:
+	case INTEL_ROCKETLAKE:
+	case INTEL_ALDERLAKE:
+	case INTEL_ALDERLAKE_L:
+	case INTEL_ATOM_GRACEMONT:
+	case INTEL_RAPTORLAKE:
+	case INTEL_RAPTORLAKE_P:
+	case INTEL_RAPTORLAKE_S:
+	case INTEL_METEORLAKE:
+	case INTEL_METEORLAKE_L:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
-- 
2.44.0


