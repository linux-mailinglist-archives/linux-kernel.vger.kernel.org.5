Return-Path: <linux-kernel+bounces-164469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BF58B7DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25332857DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD27B20126E;
	Tue, 30 Apr 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dy0/QM3x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512FF1C6898
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495915; cv=none; b=EHMVUpxySq+FhHs+nGN+VcdIgywtI2Ti+hyunLeaPSg5K1NsEyvCAUDHkdT/NiKde2KB5ZTp2s7+3cKz+oG3s9ftTEJG4TPDsz5HmuQUjx0iU3z3m0sd22zQ2ypoMcwxBD9Q8K09oW/l+cJ4q+CfcerIPtJ+IuZv6YopAIJGBF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495915; c=relaxed/simple;
	bh=cqyzuAeGvuhZYodMb9AblLQW+gSz+JxsTr7KnJrT2no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZV+MopIw9DuDNtxmv1i0JbwzLtEs9lgx2Psz+VNlkG6WEhDomrSkZvSYXqCGBTzMdDkcnlzEUgTk7olP8UKSipLVCPrnuhXdqcjQlRJ4D6TQZY0xYzdo1UnIGuizZkuqfQFw4kJBs5aHXeD0Wxykls737OBt9jl9ZJ+sKRqrdUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dy0/QM3x; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495913; x=1746031913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cqyzuAeGvuhZYodMb9AblLQW+gSz+JxsTr7KnJrT2no=;
  b=Dy0/QM3x7dx7f+ifv5iDdk1KpUoVV5an57Cno5TTOi9YItsUEaT0tYJr
   gz86IijQq7vQpkZS3NgFnMfi5dqqmAgPapSlCW+BTcRhLlG8F1MRa5PV1
   uyMtpa9YJ8E5Pe1yDwPwYlK9rG2t+x3D2b3TfPyhyMRsKGnPew9MOwmb8
   c0nFwkw9DAAajuvIMxXIc064M0Pj5QjWCTcRirbOWm6lW62Cd+z9iW9Fv
   amGRtvQPBF08ocV7gISKaiCV/D+iaKAUbLTfWmGg9XA5LgkwywIBdAHug
   u4cEaLunmPvEC+0C4UUnzkzNPwRbH/C3PI25Fe+dm0hY1u5phS1gJZ1Y6
   w==;
X-CSE-ConnectionGUID: kBpt56sJSrGRwzSimXCcvQ==
X-CSE-MsgGUID: djr287HPS3CpEK+NLseYtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075811"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075811"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:24 -0700
X-CSE-ConnectionGUID: rvx2dlCOSnSOiMuJRBrM6Q==
X-CSE-MsgGUID: 0w/IjsimTl6thhz8FzSazQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515524"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:21 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 43/47] perf/x86/rapl: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:56 -0700
Message-ID: <20240430165100.73491-43-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430165100.73491-1-tony.luck@intel.com>
References: <20240430164913.73473-1-tony.luck@intel.com>
 <20240430165100.73491-1-tony.luck@intel.com>
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
 arch/x86/events/rapl.c | 84 +++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index fb2b1961e5a3..45b62ef451aa 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -766,48 +766,48 @@ static struct rapl_model model_amd_hygon = {
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
-	X86_MATCH_FEATURE(X86_FEATURE_RAPL,		&model_amd_hygon),
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&model_snb),
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&model_snbep),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&model_snb),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&model_snbep),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&model_hsx),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&model_hsx),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&model_hsx),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&model_knl),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&model_knl),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&model_hsx),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&model_hsx),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&model_hsx),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
-	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&model_spr),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&model_skl),
+	X86_MATCH_FEATURE(X86_FEATURE_RAPL,	&model_amd_hygon),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE,	&model_snb),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,	&model_snbep),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE,		&model_snb),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,	&model_snbep),
+	X86_MATCH_VFM(INTEL_HASWELL,		&model_hsw),
+	X86_MATCH_VFM(INTEL_HASWELL_X,		&model_hsx),
+	X86_MATCH_VFM(INTEL_HASWELL_L,		&model_hsw),
+	X86_MATCH_VFM(INTEL_HASWELL_G,		&model_hsw),
+	X86_MATCH_VFM(INTEL_BROADWELL,		&model_hsw),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,	&model_hsw),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	&model_hsx),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,	&model_hsx),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,	&model_knl),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,	&model_knl),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		&model_skl),
+	X86_MATCH_VFM(INTEL_SKYLAKE,		&model_skl),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,		&model_hsx),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		&model_skl),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		&model_skl),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	&model_skl),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&model_hsw),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&model_hsw),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&model_hsw),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		&model_skl),
+	X86_MATCH_VFM(INTEL_ICELAKE,		&model_skl),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,		&model_hsx),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,		&model_hsx),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,	&model_skl),
+	X86_MATCH_VFM(INTEL_COMETLAKE,		&model_skl),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	&model_skl),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,		&model_skl),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,		&model_skl),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	&model_skl),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&model_skl),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&model_spr),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&model_spr),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&model_skl),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,	&model_skl),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&model_skl),
+	X86_MATCH_VFM(INTEL_METEORLAKE,		&model_skl),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&model_skl),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
-- 
2.44.0


