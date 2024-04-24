Return-Path: <linux-kernel+bounces-157472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 615188B11FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613ADB239F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2201802CE;
	Wed, 24 Apr 2024 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NoyK8df7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96B17B50F;
	Wed, 24 Apr 2024 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982517; cv=none; b=gSdHEIZsjfks9Aymb2iAzjcqXjdyDpCLa3+FPaciVDM+wvdY++zDobC4D/j0MBSmG3yzYslsMH1kS1AjG5o/mCtptUAGZ6aXnzmH+kDSYlXUH0gwlyhHlDoJmuo5yT7TMsYygkLEz1P5oQqUW7kuQy1+jPRhPEigo3xOE7wfg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982517; c=relaxed/simple;
	bh=Zrqcnxorevl79WD5a/tmkln4E0tHA8stgjX1kIXjdB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vn0LeJJOtnh679hKNHOp8l30Jqvy9Es9GL3eLlAo5OymWzRlj+FcBAf33qZ181Sz9wZmWQID7u8W0xgRj/aHabbmoW5ulaQ53ELne3kZuK0PA4aC00DWvcmd8a11Pxr0HxBeGzE+YHDJEBAYCbc2lX+mhos9Iji9BTBAJ8ByfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NoyK8df7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982514; x=1745518514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zrqcnxorevl79WD5a/tmkln4E0tHA8stgjX1kIXjdB8=;
  b=NoyK8df7E5C6JCHHjgNIHHjSOStYRy7j528bH9hYqID16CWBMSSjdV6a
   t8d5R+orxklM66nwqh7nbI4+97jwiwgXmPj/28IegbCqZNHBvK92eBc+I
   9atSWMcLaFySjN6PMUrXSPFv9ccdk5wyxW+Q7Oz9fgqcPDjGQ3sbX0f9n
   dxtSA+3shM0TolxqnJ8VoGcbtQ9LFyvaD2PxvVfTPFEk1T3YLR/6mDG12
   wLSOCyWOhAk90oJ8vwZK4Kj9AA1HwQfXll8kDe8RcssCzRuObE2CvtNP1
   nhKPKgA7t5zjwZysmjy3pQCXukKyknm1bEJbB4noriQdqrT3qgtGtUilo
   w==;
X-CSE-ConnectionGUID: YojkRM08TxmtuWDSCzBpDA==
X-CSE-MsgGUID: G5ZUDj5FT5mQF8g+ZRZO2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481886"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481886"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:02 -0700
X-CSE-ConnectionGUID: UhT24RloQQ2FKtN6GSrxcQ==
X-CSE-MsgGUID: Zm4sH1dvTR+Kxlzbs3dkDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262655"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:02 -0700
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
Subject: [PATCH v4 21/71] perf/x86/intel/uncore: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:01 -0700
Message-ID: <20240424181501.41557-1-tony.luck@intel.com>
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
 arch/x86/events/intel/uncore.c | 100 ++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 258e2cdf28fa..419c517b8594 100644
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
-- 
2.44.0


