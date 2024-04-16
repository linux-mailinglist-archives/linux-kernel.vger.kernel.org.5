Return-Path: <linux-kernel+bounces-147577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD328A7650
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663C21C212C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A4B13C3DD;
	Tue, 16 Apr 2024 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rhgq7j/Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C1135A51
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302406; cv=none; b=bkwM+5tpV0baGsNv+vCUWIUZNh4P3SH5840YjvbOE/3iI6LcNQ7F98FJ6V9KLgAQnb7t8qiCHAiZ6VqKvaXXukKNxsCGcW8ZSdDS1KjJa9Ijqe5hPeVelmdI7zQK7dqRKd1RO0nOQAOWC1Kp9AQRhixt+DhRlYQqWrsvZE3umdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302406; c=relaxed/simple;
	bh=fGDKZi8+sOeq7/JWizxqSluf8fa6qGhKnj1+MpVsn/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+KyJK8FDM3bKtgUNCCY/ilr184UchfPRvIYgOBxPZum1O0NtAWuJAF9shbjvjDbKAQ28w4fgZYtIeQ5yJa+aJJekw+P3Ghnj8xnpGgDuF7RJjBRgG9V7SK1CCXGH3rRqi1AfUJjn3GrhE/s/g487EDKpuaFbZx5ZgLv52gAO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rhgq7j/Y; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302404; x=1744838404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fGDKZi8+sOeq7/JWizxqSluf8fa6qGhKnj1+MpVsn/A=;
  b=Rhgq7j/YwUO6YBF2YzSjFErCs3AdbSt7IARNenwQu03tkROKm801adnE
   a0Q4fTd7NNZrSpqFm3jakAZA41Qjz9VYqUgUvbQzOIIy7/R3qW1Omdcek
   8HroJE7x0iR2zObzhCSg3m7GHoLZtrBhW4UF1B4utW4Zq4mwHjoqFnW8u
   ilXsQ9f87zNMTxZj8IWseSWtBU8qohpxEPAD7Kd5G4mXmqZnK79a6ab6v
   Cyl5HkjOkMv1XlBNFc9sPLll3KZcRH1O83agBhkwgS6hwfnDwqIwyGwPk
   oe5ifz0dAVYAtcJbSLxXbJzidmd7uWmh0jIGcSwevrwCt5OiwuDDBzRk+
   A==;
X-CSE-ConnectionGUID: rQ1qjq+8QaiUt1i3q0i4yQ==
X-CSE-MsgGUID: BwhamzmIRI+CVDwSJJmMmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914723"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914723"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:59 -0700
X-CSE-ConnectionGUID: 8eGB8UyhQMSpusru5AcgdA==
X-CSE-MsgGUID: KsaQhkPHS3KPBHoV4EDLww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871918"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:58 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 13/74] x86/cpu/vfm: Update arch/x86/events/rapl.c
Date: Tue, 16 Apr 2024 14:19:15 -0700
Message-ID: <20240416211941.9369-14-tony.luck@intel.com>
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
 arch/x86/events/rapl.c | 90 +++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index ca5f687fa420..4ea6a0083795 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -764,51 +764,51 @@ static struct rapl_model model_amd_hygon = {
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
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,		&model_skl),
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
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&model_skl),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,		&model_skl),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&model_skl),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
-- 
2.44.0


