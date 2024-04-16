Return-Path: <linux-kernel+bounces-147566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1208A7646
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED68B21880
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1697137C33;
	Tue, 16 Apr 2024 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxFNjZZQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69CB6CDCF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302402; cv=none; b=VC+Lbf0nSBQcSDsJ9WoJSqaYc1r+CgF1nckpK0jz24mstt49L5BWWaud52RILeb9n8Jm4NiqQWxw893qOBGbzNLBiHYxyDQNDXi85fftTzPlfGw1w1gOm96auhSM/vDtkoAmwYLrBriC2lWot6V6AK4tgoxdClWK0T9dk00ijRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302402; c=relaxed/simple;
	bh=t7s0Jb1VMCyYA/ZHcEyg4TQxW5ylNCaGqSLvy2930us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IluWJL9uRIgafFEXCxSUp20Pj3kfXMlajuT2iPGqKilIOmQrJo3+Qp+Ds2gn14B7pKi0tDb75tEU4Ph85mopreBrVWNYo0FU+3ytrNZTaW9kOc7JiVtuNySClaQRO0eWhgL/fUMQ0b3UJ8lm90mz0SQ9o7NXeDsBuy0oN2wUP2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxFNjZZQ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302401; x=1744838401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7s0Jb1VMCyYA/ZHcEyg4TQxW5ylNCaGqSLvy2930us=;
  b=LxFNjZZQIhXNN3tFaEe3Q0zphVHu3FQxWJ05DziUc/+boaxUG1I+hr2G
   LR1sG+wMfcbhJNXB/4WiWFEiHXQk9qif5+D/Idd7rTAM79QyE8cVF89Gf
   yE9Fzuord3CVu3NMEEjiaP9un1XEhrzCnc1nN+rBhx5uUYI04F2Tz3gS2
   vArllBTZs2buuHZSxN7hAvu+eiN+7kz/2RU0YYtvPRAWxa0wszzK5ADVt
   VjdFRx+SaNKTSLdMY/2dFvd2VJGVUzFrseNJX8Ot3rSDsi7cevFUWFTXo
   0W4UIfgyGeeQwpx4PC1LqiWDrrikynXjt66aZ4F3HIVxU2RszNP/LbzXI
   A==;
X-CSE-ConnectionGUID: yUX+YcisT0GufoVboxotOQ==
X-CSE-MsgGUID: JWQ25e2ITwa1Po+0hcpltw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914691"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914691"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:57 -0700
X-CSE-ConnectionGUID: OxrjVNguSh6BxHAuLUQdXA==
X-CSE-MsgGUID: IvZw98quRYq1g9k7ydWM4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871889"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:57 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 06/74] x86/cpu/vfm: Update arch/x86/events/intel/cstate.c
Date: Tue, 16 Apr 2024 14:19:08 -0700
Message-ID: <20240416211941.9369-7-tony.luck@intel.com>
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


