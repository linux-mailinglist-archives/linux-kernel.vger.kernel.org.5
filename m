Return-Path: <linux-kernel+bounces-157467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511018B11F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A332128F30D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6A417BB19;
	Wed, 24 Apr 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JK/Rq0F9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B01D179956;
	Wed, 24 Apr 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982514; cv=none; b=X8cXwPQ718/T9YQMWlzhrL7o4Cs7JBD81ZulkrGUGyKzUchFO2iDz8rD8QQjop4aS3/t9QjcnjlbF4UG5XrHhimvc+A3rTXM3UQqrgdW2Bf5rc78SuC529ypGuUbSVGiCrXghHS/EWV2IXAzqbvKVAOQAn9aDWx8is+3hIsWovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982514; c=relaxed/simple;
	bh=t7s0Jb1VMCyYA/ZHcEyg4TQxW5ylNCaGqSLvy2930us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bitogcSmCdBVDZgLOgNkGoyzdcDaKFNnwYabCZDXyax88vDEjSTbiit994Z9MjzwP1nrFo2x9wMk/XE+hm0qsT449bxr+e/lVli0RwepXUkiTqR4MQl1cY5wApWiGiPPUAwg524WA4Fo4moDqGOLN36Dt+Kb42wAp3sa4MCHmE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JK/Rq0F9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982512; x=1745518512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7s0Jb1VMCyYA/ZHcEyg4TQxW5ylNCaGqSLvy2930us=;
  b=JK/Rq0F9kKq8v30AAzU4Am/tYmTPtM4x4KxfzmUS9mu4m1k7Sq4zFiba
   jZZSTzDTT3OvMpf1EeytNnNK4cIWrb532VrPIekzVJOE6MceNKpr+Pv8J
   wzPTrkp13vrrQGt+2Y7/nRm/8OO0P4xR1HxttpRg22+fwTzFWTmB2cg1+
   bbgCiuG00zK4BDA94T6nNL4Br64b8V3e0nlDI0AOhPsOSkwZ5OAmhnZ0S
   z9kRJhc29P44MhJ8tHt9kNqSqkK3MVmhhQEHm/1usZVoZ2ex7veHlCcJX
   BUoy0Lc5rplTCQEaUWyc20glIq+paQwr/23VG/piVd8Mn6EkCcr6zmdVt
   g==;
X-CSE-ConnectionGUID: InGsnx7gTWyYE27DfF3I6g==
X-CSE-MsgGUID: s1sOUNKARoewEzYcdMKOAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481853"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481853"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:59 -0700
X-CSE-ConnectionGUID: 1eZXXoFyRTCzx5kHR1rL8g==
X-CSE-MsgGUID: 0OuRsVzYS6Sr3lnf1mAjqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262635"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:59 -0700
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
Subject: [PATCH v4 18/71] perf/x86/intel/cstate: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:14:59 -0700
Message-ID: <20240424181459.41500-1-tony.luck@intel.com>
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
 arch/x86/events/intel/cstate.c | 144 ++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 326c8cd5aa2d..54eb142810fb 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -696,78 +696,78 @@ static const struct cstate_model srf_cstates __initconst = {
 
 
 static const struct x86_cpu_id intel_cstates_match[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&nhm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		&nhm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EX,		&nhm_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE,		&nhm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EP,		&nhm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EX,		&nhm_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&snb_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&snb_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&snb_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&hswult_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&slm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,	&slm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&slm_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&snb_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&snb_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&snb_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&hswult_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&hswult_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&hswult_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&hswult_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&cnl_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&knl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&knl_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&glm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&glm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&glm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&glm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&glm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&glm_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	&srf_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	&grr_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&icx_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&icx_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&icx_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&icx_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	&icx_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	&icx_cstates),
-
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&icl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&icl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&icl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_NEHALEM,		&nhm_cstates),
+	X86_MATCH_VFM(INTEL_NEHALEM_EP,		&nhm_cstates),
+	X86_MATCH_VFM(INTEL_NEHALEM_EX,		&nhm_cstates),
+
+	X86_MATCH_VFM(INTEL_WESTMERE,		&nhm_cstates),
+	X86_MATCH_VFM(INTEL_WESTMERE_EP,	&nhm_cstates),
+	X86_MATCH_VFM(INTEL_WESTMERE_EX,	&nhm_cstates),
+
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE,	&snb_cstates),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,	&snb_cstates),
+
+	X86_MATCH_VFM(INTEL_IVYBRIDGE,		&snb_cstates),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,	&snb_cstates),
+
+	X86_MATCH_VFM(INTEL_HASWELL,		&snb_cstates),
+	X86_MATCH_VFM(INTEL_HASWELL_X,		&snb_cstates),
+	X86_MATCH_VFM(INTEL_HASWELL_G,		&snb_cstates),
+
+	X86_MATCH_VFM(INTEL_HASWELL_L,		&hswult_cstates),
+
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&slm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_D,	&slm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&slm_cstates),
+
+	X86_MATCH_VFM(INTEL_BROADWELL,		&snb_cstates),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,	&snb_cstates),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,	&snb_cstates),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	&snb_cstates),
+
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		&snb_cstates),
+	X86_MATCH_VFM(INTEL_SKYLAKE,		&snb_cstates),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,		&snb_cstates),
+
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		&hswult_cstates),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		&hswult_cstates),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,	&hswult_cstates),
+	X86_MATCH_VFM(INTEL_COMETLAKE,		&hswult_cstates),
+
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	&cnl_cstates),
+
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,	&knl_cstates),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,	&knl_cstates),
+
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&glm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&glm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&glm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,	&glm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,	&glm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,	&glm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&srf_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&grr_cstates),
+
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		&icl_cstates),
+	X86_MATCH_VFM(INTEL_ICELAKE,		&icl_cstates),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,		&icx_cstates),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,		&icx_cstates),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&icx_cstates),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&icx_cstates),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&icx_cstates),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,	&icx_cstates),
+
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	&icl_cstates),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,		&icl_cstates),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE,		&icl_cstates),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,		&adl_cstates),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&adl_cstates),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&adl_cstates),
+	X86_MATCH_VFM(INTEL_METEORLAKE,		&adl_cstates),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&adl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.44.0


