Return-Path: <linux-kernel+bounces-147606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B448A767A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D787281348
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB90B13AA39;
	Tue, 16 Apr 2024 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOAAvIYQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B2D136E28;
	Tue, 16 Apr 2024 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302527; cv=none; b=u8riZyccmsNykzLc6wJDELCCzoCu/tq2HjubuP3VEZ3OhsddySqFuloZ/5Vxhkm8Oi5jA6St52Dm4l7gJyyXcS7DSwmyhMFqmZcllOdNx0mU8Lt+HCk8Gu/35kKiHs2fNDQXUvCmi+8leGg953jZYnjdWu+MWLpKQT/HxWSUDQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302527; c=relaxed/simple;
	bh=A8rPja5SM3e/A73Nv/9L+KQ5Wu8KFRJ03CdluyjQGDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSYHyvuR2vLAubhudByCzm0PHJxSBP04uaTQVLEV3v4epX8Acy+w0YgW7id07hkjPJ075rg2TbUw7mNd+W14x/lZm9jzDSUHROvfhGazUgGCPHljuZEXqZRqUxetAqWB2Xcg/RKO+YzKqwXmNrCipMxSuU55xDm+W2CrX4pTsUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOAAvIYQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302527; x=1744838527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A8rPja5SM3e/A73Nv/9L+KQ5Wu8KFRJ03CdluyjQGDk=;
  b=hOAAvIYQ0LnDJzcjWvCOaIF2LbcSINJyPIATMJGMwYN8IednZjwztiZo
   pUhyWcX6K4nv9Jp8l8WfTpXqyJrT3DZMDIW8NE16qtiZx5x7wPWKAlHGZ
   +JuyqsfczFYQ7OISQ/jXi9hsRH0FfK2w+9wwspJu0Byn3C0oyd+JSiLk4
   7EgPF2nke65hE7tHayJWzcW1Xhd8pxRwKxjO3ZUGBjZoaZ7MMI2JyNxs3
   /P/qNoUIhtzG1W+0NCXdGbMBtLXQ2DpctNhivMrb0xI2LGBgVs0JVdQ3y
   aFXLDI3ONFGHPWsadvfgFWgNftNSCsi3YhJRx1pgRaS+Wyv9TwTEBLo3Z
   Q==;
X-CSE-ConnectionGUID: NDAmRQ4aS3yuxVqcs5moEg==
X-CSE-MsgGUID: kJd23riVTWm0bAFjtx7B5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19328741"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19328741"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:07 -0700
X-CSE-ConnectionGUID: SIzjrcofR0GJe4xuwP/ezg==
X-CSE-MsgGUID: iPdmg6hORW6PEe4BUSz4wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="27071900"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:06 -0700
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 43/74] x86/cpu/vfm: Update drivers/cpufreq/intel_pstate.c
Date: Tue, 16 Apr 2024 14:22:04 -0700
Message-ID: <20240416212204.9471-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
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
 drivers/cpufreq/intel_pstate.c | 90 +++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 46 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dbbf299f4219..685ec80e0af5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2402,52 +2402,51 @@ static const struct pstate_funcs knl_funcs = {
 	.get_val = core_get_val,
 };
 
-#define X86_MATCH(model, policy)					 \
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
-					   X86_FEATURE_APERFMPERF, &policy)
+#define X86_MATCH(vfm, policy)					 \
+	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_APERFMPERF, &policy)
 
 static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
-	X86_MATCH(SANDYBRIDGE,		core_funcs),
-	X86_MATCH(SANDYBRIDGE_X,	core_funcs),
-	X86_MATCH(ATOM_SILVERMONT,	silvermont_funcs),
-	X86_MATCH(IVYBRIDGE,		core_funcs),
-	X86_MATCH(HASWELL,		core_funcs),
-	X86_MATCH(BROADWELL,		core_funcs),
-	X86_MATCH(IVYBRIDGE_X,		core_funcs),
-	X86_MATCH(HASWELL_X,		core_funcs),
-	X86_MATCH(HASWELL_L,		core_funcs),
-	X86_MATCH(HASWELL_G,		core_funcs),
-	X86_MATCH(BROADWELL_G,		core_funcs),
-	X86_MATCH(ATOM_AIRMONT,		airmont_funcs),
-	X86_MATCH(SKYLAKE_L,		core_funcs),
-	X86_MATCH(BROADWELL_X,		core_funcs),
-	X86_MATCH(SKYLAKE,		core_funcs),
-	X86_MATCH(BROADWELL_D,		core_funcs),
-	X86_MATCH(XEON_PHI_KNL,		knl_funcs),
-	X86_MATCH(XEON_PHI_KNM,		knl_funcs),
-	X86_MATCH(ATOM_GOLDMONT,	core_funcs),
-	X86_MATCH(ATOM_GOLDMONT_PLUS,	core_funcs),
-	X86_MATCH(SKYLAKE_X,		core_funcs),
-	X86_MATCH(COMETLAKE,		core_funcs),
-	X86_MATCH(ICELAKE_X,		core_funcs),
-	X86_MATCH(TIGERLAKE,		core_funcs),
-	X86_MATCH(SAPPHIRERAPIDS_X,	core_funcs),
-	X86_MATCH(EMERALDRAPIDS_X,      core_funcs),
+	X86_MATCH(INTEL_SANDYBRIDGE,		core_funcs),
+	X86_MATCH(INTEL_SANDYBRIDGE_X,		core_funcs),
+	X86_MATCH(INTEL_ATOM_SILVERMONT,	silvermont_funcs),
+	X86_MATCH(INTEL_IVYBRIDGE,		core_funcs),
+	X86_MATCH(INTEL_HASWELL,		core_funcs),
+	X86_MATCH(INTEL_BROADWELL,		core_funcs),
+	X86_MATCH(INTEL_IVYBRIDGE_X,		core_funcs),
+	X86_MATCH(INTEL_HASWELL_X,		core_funcs),
+	X86_MATCH(INTEL_HASWELL_L,		core_funcs),
+	X86_MATCH(INTEL_HASWELL_G,		core_funcs),
+	X86_MATCH(INTEL_BROADWELL_G,		core_funcs),
+	X86_MATCH(INTEL_ATOM_AIRMONT,		airmont_funcs),
+	X86_MATCH(INTEL_SKYLAKE_L,		core_funcs),
+	X86_MATCH(INTEL_BROADWELL_X,		core_funcs),
+	X86_MATCH(INTEL_SKYLAKE,		core_funcs),
+	X86_MATCH(INTEL_BROADWELL_D,		core_funcs),
+	X86_MATCH(INTEL_XEON_PHI_KNL,		knl_funcs),
+	X86_MATCH(INTEL_XEON_PHI_KNM,		knl_funcs),
+	X86_MATCH(INTEL_ATOM_GOLDMONT,		core_funcs),
+	X86_MATCH(INTEL_ATOM_GOLDMONT_PLUS,	core_funcs),
+	X86_MATCH(INTEL_SKYLAKE_X,		core_funcs),
+	X86_MATCH(INTEL_COMETLAKE,		core_funcs),
+	X86_MATCH(INTEL_ICELAKE_X,		core_funcs),
+	X86_MATCH(INTEL_TIGERLAKE,		core_funcs),
+	X86_MATCH(INTEL_SAPPHIRERAPIDS_X,	core_funcs),
+	X86_MATCH(INTEL_EMERALDRAPIDS_X,	core_funcs),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
 
 static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
-	X86_MATCH(BROADWELL_D,		core_funcs),
-	X86_MATCH(BROADWELL_X,		core_funcs),
-	X86_MATCH(SKYLAKE_X,		core_funcs),
-	X86_MATCH(ICELAKE_X,		core_funcs),
-	X86_MATCH(SAPPHIRERAPIDS_X,	core_funcs),
+	X86_MATCH(INTEL_BROADWELL_D,		core_funcs),
+	X86_MATCH(INTEL_BROADWELL_X,		core_funcs),
+	X86_MATCH(INTEL_SKYLAKE_X,		core_funcs),
+	X86_MATCH(INTEL_ICELAKE_X,		core_funcs),
+	X86_MATCH(INTEL_SAPPHIRERAPIDS_X,	core_funcs),
 	{}
 };
 
 static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
-	X86_MATCH(KABYLAKE,		core_funcs),
+	X86_MATCH(INTEL_KABYLAKE,		core_funcs),
 	{}
 };
 
@@ -3386,14 +3385,13 @@ static inline void intel_pstate_request_control_from_smm(void) {}
 
 #define INTEL_PSTATE_HWP_BROADWELL	0x01
 
-#define X86_MATCH_HWP(model, hwp_mode)					\
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
-					   X86_FEATURE_HWP, hwp_mode)
+#define X86_MATCH_HWP(vfm, hwp_mode)				\
+	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_HWP, hwp_mode)
 
 static const struct x86_cpu_id hwp_support_ids[] __initconst = {
-	X86_MATCH_HWP(BROADWELL_X,	INTEL_PSTATE_HWP_BROADWELL),
-	X86_MATCH_HWP(BROADWELL_D,	INTEL_PSTATE_HWP_BROADWELL),
-	X86_MATCH_HWP(ANY,		0),
+	X86_MATCH_HWP(INTEL_BROADWELL_X,	INTEL_PSTATE_HWP_BROADWELL),
+	X86_MATCH_HWP(INTEL_BROADWELL_D,	INTEL_PSTATE_HWP_BROADWELL),
+	X86_MATCH_HWP(INTEL_ANY,		0),
 	{}
 };
 
@@ -3426,15 +3424,15 @@ static const struct x86_cpu_id intel_epp_default[] = {
 	 * which can result in one core turbo frequency for
 	 * AlderLake Mobile CPUs.
 	 */
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, HWP_SET_DEF_BALANCE_PERF_EPP(102)),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP(32)),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
-							HWP_EPP_BALANCE_POWERSAVE, 115, 16)),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L, HWP_SET_DEF_BALANCE_PERF_EPP(102)),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP(32)),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L, HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
+		      HWP_EPP_BALANCE_POWERSAVE, 115, 16)),
 	{}
 };
 
 static const struct x86_cpu_id intel_hybrid_scaling_factor[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
 	{}
 };
 
-- 
2.44.0


