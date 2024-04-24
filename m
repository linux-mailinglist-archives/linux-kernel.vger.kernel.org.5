Return-Path: <linux-kernel+bounces-157471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D9F8B11FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57148B24216
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCBD16D9BD;
	Wed, 24 Apr 2024 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrUrxxn3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6781216E867;
	Wed, 24 Apr 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982517; cv=none; b=E1e+wQ12rbHrvccRP0tL/Z6SWPtGVIVvkirsvtQ+mOgq1kcev0HRmgd97T7pAOPwSip0BPADZcDATHLoZDDJYqI6pbOXChvrT260AqLGZRV8Tdhf/7tg6gZ1amiUj9aRWB9UbxPNo8Gq9LPGyXbf/jeh7Bp8gQkQ6/17qo4sYBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982517; c=relaxed/simple;
	bh=SHMkDQNhLJVSbQAhNMfggf+iNz/SzZPr73nQsNDr5PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vprs2tUBQzgGKXM/kTNCgYFk9FQYI0CjXpzMd0g8NeEk2xPpl7+86d5Xt6Igu6lOWAnwNPZjpDXRiH7Efa/fOz5XjoxohLKlIqCuUaiLy0kqptQMJntApWNc0ubWX5iS5r97IiKG8DQZ2nWVWqFmzbBSZ3GDsJsgFuqSbsdfxm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrUrxxn3; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982515; x=1745518515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SHMkDQNhLJVSbQAhNMfggf+iNz/SzZPr73nQsNDr5PA=;
  b=YrUrxxn3bcYLL8CbEvIKW3HCgUaQLWiXCFdmiWqtu4dHNtNHKz/7LDKF
   ZgbZDq546g6CpCOYWkn7XageiRym5bIGa0pww/eOiIwtHHtuz8Aneu+CQ
   7OqL/Sgf4BNABHlro/GLu0llsxsAamdLeQHSXRqyVlMRgJ9U6wu7HX3oN
   bVps4DVRI0GCpu6aNBuDBvE9xrkHnAmofvza4vs4txrEI1PZ+4iGUL8xc
   woY00Ve6ZTEwVHMZXESftFeRtW8upwARtB5FJdX1cLH5Xy6/MRYgQJoQH
   MCs3eDZVEfRTSzg3CLpgvxV0kkJVmS2Cs7GtWDNqFevuYZHc9sVAmxwdc
   g==;
X-CSE-ConnectionGUID: pFoDfiQpRxaMEX5YGFju7g==
X-CSE-MsgGUID: 7ChaOaaASLGPttqQQKMhkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481907"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481907"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:03 -0700
X-CSE-ConnectionGUID: Pz7yq/wzTuOGL2Mza7wa0g==
X-CSE-MsgGUID: jApYVrXOTnujTNkAikv0Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262668"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:03 -0700
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
Subject: [PATCH v4 23/71] perf/x86/intel/uncore: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:03 -0700
Message-ID: <20240424181503.41595-1-tony.luck@intel.com>
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
 arch/x86/events/intel/uncore_snbep.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 2eaf0f339849..74b8b21e8990 100644
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
-- 
2.44.0


