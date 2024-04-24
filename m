Return-Path: <linux-kernel+bounces-157458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E458B11DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B1528CA45
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB1A171085;
	Wed, 24 Apr 2024 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3RE2vTn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B5316F26C;
	Wed, 24 Apr 2024 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982494; cv=none; b=kJ3ByCi04TkEQIA1Za75fmgZ7sp/PiqhT0uP+m8x6GQAHhb9XwGsK2nK2ivkfXRCL2JHQ7yIAGoE32j39gZMyLLXa0x1XV7uKxDpxn0hvz02ocogkmpxvT/4WQoifgiBs072+NepJoujkVbdJu+vjyYw49lQOBYmM3G98WNZkkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982494; c=relaxed/simple;
	bh=HtLk67VJXa/9h9uLwy5bh3ooxVgpgzTrHi5Ns3ks4fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHfNvI65hW/1HTdBlec1Roew9vzO8eo7UajvNo/rlWLUz9NzWGtd45pIODUdYYM/sMuvV0f+FdxvqVVLQZ3vGnyFXXAM97Mjy+aG0uJMHjQLscublKe+5YCIFQaoK10DY/ZNeyZszjjd5WwdoyKAxVUoyo5P9F/CFmscCO9Idbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k3RE2vTn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982493; x=1745518493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HtLk67VJXa/9h9uLwy5bh3ooxVgpgzTrHi5Ns3ks4fg=;
  b=k3RE2vTnrV/6VJ0fzzbLvbeqEHI4nAvOEEoZ1B3nMUfIUHaSxBosyoOo
   pmLPhPIWenppcCDQIOZDtQQw5nDJ6IE5/9tihQxF1Ck2Y8GmuSc2vgeL6
   qKpKcFyLaHGH3/LJhubeY897alF0gbGe0NjRLB8sP2/jPR3TresC235Il
   MGxj9n/yls7wfQyHw/575vEChhyGq8L1LlSxbEWGaMu7iE4R8SFhpvRCL
   7SS7f+qiE2WpiZ2+ISnP7MBsMdbgABjogleb96bpcYCezvMyLIrw/qYmL
   ErK7AWi+3YbPw54gPnV+xEeSBj8JwElgY6cX78UWSToP1O7+CaPQoMlON
   A==;
X-CSE-ConnectionGUID: uhpmMAIZRKS++p8DWz4bzw==
X-CSE-MsgGUID: gCcaJBh+TjKRvpUHfJxBrA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481776"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481776"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:52 -0700
X-CSE-ConnectionGUID: u0LB/dXXThevxvFn7MqEZw==
X-CSE-MsgGUID: EpYMA1HBT5mKNcZakfW05w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262574"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:52 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 09/71] intel_idle: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:14:51 -0700
Message-ID: <20240424181452.41327-1-tony.luck@intel.com>
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 116 +++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index e486027f8b07..9aab7abc2ae9 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1494,53 +1494,53 @@ static const struct idle_cpu idle_cpu_srf __initconst = {
 };
 
 static const struct x86_cpu_id intel_idle_ids[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		&idle_cpu_nhx),
-	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&idle_cpu_nehalem),
-	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_G,		&idle_cpu_nehalem),
-	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE,		&idle_cpu_nehalem),
-	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EP,		&idle_cpu_nhx),
-	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EX,		&idle_cpu_nhx),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_BONNELL,	&idle_cpu_atom),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_BONNELL_MID,	&idle_cpu_lincroft),
-	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EX,		&idle_cpu_nhx),
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&idle_cpu_snb),
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&idle_cpu_snx),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL,	&idle_cpu_atom),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&idle_cpu_byt),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&idle_cpu_tangier),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&idle_cpu_cht),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&idle_cpu_ivb),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&idle_cpu_ivt),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&idle_cpu_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&idle_cpu_hsx),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&idle_cpu_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&idle_cpu_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,	&idle_cpu_avn),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&idle_cpu_bdw),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&idle_cpu_bdw),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&idle_cpu_bdx),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&idle_cpu_bdx),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&idle_cpu_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&idle_cpu_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&idle_cpu_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&idle_cpu_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&idle_cpu_skx),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&idle_cpu_icx),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&idle_cpu_icx),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&idle_cpu_adl),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&idle_cpu_adl_l),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&idle_cpu_mtl_l),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&idle_cpu_gmt),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&idle_cpu_spr),
-	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&idle_cpu_spr),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&idle_cpu_knl),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&idle_cpu_bxt),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&idle_cpu_bxt),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&idle_cpu_dnv),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&idle_cpu_snr),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	&idle_cpu_grr),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	&idle_cpu_srf),
+	X86_MATCH_VFM(INTEL_NEHALEM_EP,		&idle_cpu_nhx),
+	X86_MATCH_VFM(INTEL_NEHALEM,		&idle_cpu_nehalem),
+	X86_MATCH_VFM(INTEL_NEHALEM_G,		&idle_cpu_nehalem),
+	X86_MATCH_VFM(INTEL_WESTMERE,		&idle_cpu_nehalem),
+	X86_MATCH_VFM(INTEL_WESTMERE_EP,	&idle_cpu_nhx),
+	X86_MATCH_VFM(INTEL_NEHALEM_EX,		&idle_cpu_nhx),
+	X86_MATCH_VFM(INTEL_ATOM_BONNELL,	&idle_cpu_atom),
+	X86_MATCH_VFM(INTEL_ATOM_BONNELL_MID,	&idle_cpu_lincroft),
+	X86_MATCH_VFM(INTEL_WESTMERE_EX,	&idle_cpu_nhx),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE,	&idle_cpu_snb),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,	&idle_cpu_snx),
+	X86_MATCH_VFM(INTEL_ATOM_SALTWELL,	&idle_cpu_atom),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&idle_cpu_byt),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, &idle_cpu_tangier),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&idle_cpu_cht),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE,		&idle_cpu_ivb),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,	&idle_cpu_ivt),
+	X86_MATCH_VFM(INTEL_HASWELL,		&idle_cpu_hsw),
+	X86_MATCH_VFM(INTEL_HASWELL_X,		&idle_cpu_hsx),
+	X86_MATCH_VFM(INTEL_HASWELL_L,		&idle_cpu_hsw),
+	X86_MATCH_VFM(INTEL_HASWELL_G,		&idle_cpu_hsw),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_D,	&idle_cpu_avn),
+	X86_MATCH_VFM(INTEL_BROADWELL,		&idle_cpu_bdw),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,	&idle_cpu_bdw),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	&idle_cpu_bdx),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,	&idle_cpu_bdx),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		&idle_cpu_skl),
+	X86_MATCH_VFM(INTEL_SKYLAKE,		&idle_cpu_skl),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		&idle_cpu_skl),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		&idle_cpu_skl),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,		&idle_cpu_skx),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,		&idle_cpu_icx),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,		&idle_cpu_icx),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,		&idle_cpu_adl),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	&idle_cpu_adl_l),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&idle_cpu_mtl_l),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&idle_cpu_gmt),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&idle_cpu_spr),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&idle_cpu_spr),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,	&idle_cpu_knl),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,	&idle_cpu_knl),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&idle_cpu_bxt),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&idle_cpu_bxt),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&idle_cpu_dnv),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,	&idle_cpu_snr),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&idle_cpu_grr),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&idle_cpu_srf),
 	{}
 };
 
@@ -1990,27 +1990,27 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 {
 	int cstate;
 
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_IVYBRIDGE_X:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_IVYBRIDGE_X:
 		ivt_idle_state_table_update();
 		break;
-	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+	case INTEL_ATOM_GOLDMONT:
+	case INTEL_ATOM_GOLDMONT_PLUS:
 		bxt_idle_state_table_update();
 		break;
-	case INTEL_FAM6_SKYLAKE:
+	case INTEL_SKYLAKE:
 		sklh_idle_state_table_update();
 		break;
-	case INTEL_FAM6_SKYLAKE_X:
+	case INTEL_SKYLAKE_X:
 		skx_idle_state_table_update();
 		break;
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:
-	case INTEL_FAM6_EMERALDRAPIDS_X:
+	case INTEL_SAPPHIRERAPIDS_X:
+	case INTEL_EMERALDRAPIDS_X:
 		spr_idle_state_table_update();
 		break;
-	case INTEL_FAM6_ALDERLAKE:
-	case INTEL_FAM6_ALDERLAKE_L:
-	case INTEL_FAM6_ATOM_GRACEMONT:
+	case INTEL_ALDERLAKE:
+	case INTEL_ALDERLAKE_L:
+	case INTEL_ATOM_GRACEMONT:
 		adl_idle_state_table_update();
 		break;
 	}
-- 
2.44.0


