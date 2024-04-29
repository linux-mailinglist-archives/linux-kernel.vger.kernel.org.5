Return-Path: <linux-kernel+bounces-161953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B078B53BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26EC1F21988
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3F23F9D8;
	Mon, 29 Apr 2024 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YsZaTAGC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HpxjScPv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9C62C68F;
	Mon, 29 Apr 2024 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381327; cv=none; b=Dq2Z5BHVdog+CwXpk7m8MJMdpOnVp3hYBaRQqKRbsJeUB9i3ZL4vvlX2Rj5miaYgxyLAEVo652Cpv9G0DGS5W6nIdpnaLYHolHcsTzA2jXLjCdMZWHHgXV0IzwkMH8D75Ef4Luxw9ph452x92PvRazeR1lPxYR/KmUk2R5hcAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381327; c=relaxed/simple;
	bh=tWKAxl8U5Dl7neGUk7Mgzg78J0YWD4yUGvzeAU3/CUs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jvex5OtxtzZmSseKUtb+T/59YzNvaNOZ4+DGWTeNqZPpex2N3b/EAgxVzwuNc+mP6UC6tS8dAKtU9aeEvo606rz1xI28kXLgtNIBsJI7Y71tQw00US9oQkITUQtFj0eZOnDUqMEWy0X/ku0KTN+WzXmaUXKvHEPlAh9LdrOs9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YsZaTAGC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HpxjScPv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 09:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714381316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=boU0HYZxRzu8SK04/t34bxYqHMRux5TH2WUZ5DIh2Zk=;
	b=YsZaTAGCkI7sVAf0rLQWD5VeY43M7GS6vzIeFKrCihJbit8p10/t3oIY8Bp3XZi93dkzd4
	FdqTv2GuKdfv4ExSxL8ijeYCUHL5vfNVEzQzPNTO71oqETezeYEPoUckQz1xv6lH7HG/1B
	Qw5PEYJv5sv6u7o+85Nc/WQ0jdk/eoLxrE9bDEyZjC+g9O7AqyEF4Lp11g3M4Rgrk4oqaq
	2Yh38fhxbfd+MsqaE5OOxFe97ytAQB69YG/6qb0yw/U3BfH20LzuBxdjUwGm3jVUTu5CKv
	QlDs+3vC7u0G6eAYzSD1CPc0+a7Da/NlO0g0NvxGFsmF7h++SBmcWCZMZnbShg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714381316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=boU0HYZxRzu8SK04/t34bxYqHMRux5TH2WUZ5DIh2Zk=;
	b=HpxjScPvGq7TnDbGuLMUwsLiom8N+Hbu734pwuqKV7AR0Bq+nslYbXPnzctzqRpKVfmV6E
	ArXXeheYBSdO5DBQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] perf/x86/intel/uncore: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171438131567.10875.4660387361451389041.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     9828a1cff456e0d6f55f9e148585313c2dd59c00
Gitweb:        https://git.kernel.org/tip/9828a1cff456e0d6f55f9e148585313c2dd59c00
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:01 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 10:30:39 +02:00

perf/x86/intel/uncore: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

  [ bp: Squash *three* uncore patches into one. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240424181501.41557-1-tony.luck%40intel.com
---
 arch/x86/events/intel/uncore.c       | 100 +++++++++++++-------------
 arch/x86/events/intel/uncore_nhmex.c |   3 +-
 arch/x86/events/intel/uncore_snbep.c |   5 +-
 3 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 258e2cd..419c517 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1829,56 +1829,56 @@ static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
 };
 
 static const struct x86_cpu_id intel_uncore_match[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		&nhm_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&nhm_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE,		&nhm_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EP,		&nhm_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&snb_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&ivb_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&hsw_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&hsw_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&hsw_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&bdw_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&bdw_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&snbep_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EX,		&nhmex_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EX,		&nhmex_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&ivbep_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&hswep_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&bdx_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&bdx_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&knl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&knl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&skl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&skl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&skx_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&skl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&skl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&skl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&skl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&icl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&icx_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&icx_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&tgl_l_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&tgl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&mtl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&mtl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&spr_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	&gnr_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	&gnr_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&adl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	&gnr_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	&gnr_uncore_init),
+	X86_MATCH_VFM(INTEL_NEHALEM_EP,		&nhm_uncore_init),
+	X86_MATCH_VFM(INTEL_NEHALEM,		&nhm_uncore_init),
+	X86_MATCH_VFM(INTEL_WESTMERE,		&nhm_uncore_init),
+	X86_MATCH_VFM(INTEL_WESTMERE_EP,	&nhm_uncore_init),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE,	&snb_uncore_init),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE,		&ivb_uncore_init),
+	X86_MATCH_VFM(INTEL_HASWELL,		&hsw_uncore_init),
+	X86_MATCH_VFM(INTEL_HASWELL_L,		&hsw_uncore_init),
+	X86_MATCH_VFM(INTEL_HASWELL_G,		&hsw_uncore_init),
+	X86_MATCH_VFM(INTEL_BROADWELL,		&bdw_uncore_init),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,	&bdw_uncore_init),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,	&snbep_uncore_init),
+	X86_MATCH_VFM(INTEL_NEHALEM_EX,		&nhmex_uncore_init),
+	X86_MATCH_VFM(INTEL_WESTMERE_EX,	&nhmex_uncore_init),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,	&ivbep_uncore_init),
+	X86_MATCH_VFM(INTEL_HASWELL_X,		&hswep_uncore_init),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	&bdx_uncore_init),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,	&bdx_uncore_init),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,	&knl_uncore_init),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,	&knl_uncore_init),
+	X86_MATCH_VFM(INTEL_SKYLAKE,		&skl_uncore_init),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		&skl_uncore_init),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,		&skx_uncore_init),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		&skl_uncore_init),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		&skl_uncore_init),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,	&skl_uncore_init),
+	X86_MATCH_VFM(INTEL_COMETLAKE,		&skl_uncore_init),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		&icl_uncore_init),
+	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,	&icl_uncore_init),
+	X86_MATCH_VFM(INTEL_ICELAKE,		&icl_uncore_init),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,		&icx_uncore_init),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,		&icx_uncore_init),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	&tgl_l_uncore_init),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,		&tgl_uncore_init),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE,		&rkl_uncore_init),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,		&adl_uncore_init),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	&adl_uncore_init),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&adl_uncore_init),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,	&adl_uncore_init),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&adl_uncore_init),
+	X86_MATCH_VFM(INTEL_METEORLAKE,		&mtl_uncore_init),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&mtl_uncore_init),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&spr_uncore_init),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&spr_uncore_init),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&gnr_uncore_init),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,	&gnr_uncore_init),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,	&snr_uncore_init),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&adl_uncore_init),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&gnr_uncore_init),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&gnr_uncore_init),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel/uncore_nhmex.c
index 92da8aa..4668334 100644
--- a/arch/x86/events/intel/uncore_nhmex.c
+++ b/arch/x86/events/intel/uncore_nhmex.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Nehalem-EX/Westmere-EX uncore support */
+#include <asm/cpu_device_id.h>
 #include "uncore.h"
 
 /* NHM-EX event control */
@@ -1217,7 +1218,7 @@ static struct intel_uncore_type *nhmex_msr_uncores[] = {
 
 void nhmex_uncore_cpu_init(void)
 {
-	if (boot_cpu_data.x86_model == 46)
+	if (boot_cpu_data.x86_vfm == INTEL_NEHALEM_EX)
 		uncore_nhmex = true;
 	else
 		nhmex_uncore_mbox.event_descs = wsmex_uncore_mbox_events;
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 2eaf0f3..74b8b21 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* SandyBridge-EP/IvyTown uncore support */
+#include <asm/cpu_device_id.h>
 #include "uncore.h"
 #include "uncore_discovery.h"
 
@@ -3285,7 +3286,7 @@ void bdx_uncore_cpu_init(void)
 	uncore_msr_uncores = bdx_msr_uncores;
 
 	/* Detect systems with no SBOXes */
-	if ((boot_cpu_data.x86_model == 86) || hswep_has_limit_sbox(BDX_PCU_DID))
+	if (boot_cpu_data.x86_vfm == INTEL_BROADWELL_D || hswep_has_limit_sbox(BDX_PCU_DID))
 		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
 
 	hswep_uncore_pcu.constraints = bdx_uncore_pcu_constraints;
@@ -5394,7 +5395,7 @@ static int icx_iio_get_topology(struct intel_uncore_type *type)
 static void icx_iio_set_mapping(struct intel_uncore_type *type)
 {
 	/* Detect ICX-D system. This case is not supported */
-	if (boot_cpu_data.x86_model == INTEL_FAM6_ICELAKE_D) {
+	if (boot_cpu_data.x86_vfm == INTEL_ICELAKE_D) {
 		pmu_clear_mapping_attr(type->attr_update, &icx_iio_mapping_group);
 		return;
 	}

