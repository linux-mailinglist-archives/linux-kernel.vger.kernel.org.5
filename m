Return-Path: <linux-kernel+bounces-164461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9C58B7DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBAB1C238E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E551C1C8FDD;
	Tue, 30 Apr 2024 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6Hw7UeU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17211C6602
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495911; cv=none; b=T7+91g/khUScbL2J8ZIMpqSYnglpR/uE8FvVNIQFTula/1hPUb/i/dlhqpl7NbOk7BAPhkqLUomyqHwDD74J+vA6CUbsfLDpe2aop5qTmaVqpyQbG0c1ws9C386Eknci/435/TGSXKtgzjZQ2/S88cpCIN+JYAE8xXMxNz4g4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495911; c=relaxed/simple;
	bh=nsRNTDx4whD1GLA/xKi0WFK0CbOb/U+ApM/A8sRWWZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cf4JCm8ynEMay5CicUcQ1dny8US1Dxz+X+BEHEvjhHuHJ7UnA7cNDcxSOxsH6KzL5mkg6qtWZW4vaoimz+9NItj+L/5hbUG4lm8X0T6QAG3pWTc+c6VWb7UelVlBEF3pS6DS4ZC6GBohdSqW8DiYmjBboCJ8lYjXWo2AnNYkN7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6Hw7UeU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495910; x=1746031910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nsRNTDx4whD1GLA/xKi0WFK0CbOb/U+ApM/A8sRWWZE=;
  b=Q6Hw7UeU1u3C5EGRjC4GNMl7U7GkFCpKMlQmEtgqU8fUgKrf+DUg8gh2
   OGrH0PFf1BPP9L1Euck8Tb+xd0c+dm0dRQZnshb6OVETLEtvmt4WC0Ynx
   QBMbcbfzvDMPYq2+M6I6z4HDLlDLF2jY/4RhA469Ctla4T37OMI/kUD5V
   GJQMj20Z2OuZzdTENf07nYLCqg3cbUd7OvKHuAoo6hV1ITFa4FAr8wWjf
   xB2dXtwTv+y+mlzqqACw5vYJyFbJ5XdTjORkdszyWCKKiS3tO0KJ08fvu
   ngM+jkRr3WtzNi+lwDPyjtcqvlDG4kBjNSuC/glK6zkEF3kGRzaCqVGpy
   w==;
X-CSE-ConnectionGUID: 8FI4bPD3QAyyN6vWLEv2+w==
X-CSE-MsgGUID: 3ji5XxxlRYOIbe8yTp6jBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075798"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075798"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:24 -0700
X-CSE-ConnectionGUID: 0a/n0OrbSICH8BLXMPVv3g==
X-CSE-MsgGUID: t1HIG+daTtWIV/5ZVMP4bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515516"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:20 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 40/47] powercap: intel_rapl: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:53 -0700
Message-ID: <20240430165100.73491-40-tony.luck@intel.com>
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 118 +++++++++++++--------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index a28d54fd5222..59c36ea55712 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1220,65 +1220,65 @@ static const struct rapl_defaults rapl_defaults_amd = {
 };
 
 static const struct x86_cpu_id rapl_ids[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&rapl_defaults_hsw_server),
-
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&rapl_defaults_hsw_server),
-
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
-	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
-	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&rapl_defaults_byt),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&rapl_defaults_cht),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&rapl_defaults_tng),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_MID,	&rapl_defaults_ann),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,	&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_IVYBRIDGE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,	&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_HASWELL,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_G,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_X,		&rapl_defaults_hsw_server),
+
+	X86_MATCH_VFM(INTEL_BROADWELL,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	&rapl_defaults_hsw_server),
+
+	X86_MATCH_VFM(INTEL_SKYLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_COMETLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,        &rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_LAKEFIELD,		&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&rapl_defaults_byt),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&rapl_defaults_cht),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, &rapl_defaults_tng),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_MID,	&rapl_defaults_ann),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,	&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,	&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,	&rapl_defaults_hsw_server),
 
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
 	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
-- 
2.44.0


