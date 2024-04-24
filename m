Return-Path: <linux-kernel+bounces-157476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574FC8B1208
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A3D1C23281
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39DF181B81;
	Wed, 24 Apr 2024 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlQ0WAGc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F9A180A6C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982521; cv=none; b=EIOm1yXagl4J6tliDbXZUmQlVcsBMX8KlBZhIkEGW0b010Y/7SDqcakYmCgi+4+wBN+xAIOa/A0C55+itwn6jen/nTR+4F+kBXlZtfjG4aghgKKCmwk89f1cGRYdC35YlslB5lzGisiHde1WgYU/gkNk3JhpAVto4eWts6CZyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982521; c=relaxed/simple;
	bh=MQ97iLFFbgxQYCiSBsEDrW3R5WSpsqJ/JU/KTZPQ0ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KquNf80mU471iKxNR474JVX/EhTvYl2rBXooCrqsrgaOYF1P6SLPjvyKsdQWnSh3Kt7lb6krgoMRgC/ro9siieQ+tyANSPxg1x2mZnfcLb6Q3035uowLsZKzWYHllUx/ZX0iU2+tLJkXCExeXxTb/6QtqRN2n0tD2YRNUW2iB1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlQ0WAGc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982519; x=1745518519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MQ97iLFFbgxQYCiSBsEDrW3R5WSpsqJ/JU/KTZPQ0ow=;
  b=LlQ0WAGceM6Q025F8+v87+IN1IAVZyWavmTfXwS0ssUp/2vfvaj+VEAB
   Oz+v+wUoXUl56ww5TamItHXf4mLEcFFNp28LtTb9GkOvU5PTed0gyu3GI
   CaxZu2AoJsDc6aaCV9Vj01frAGbHQcv2mZifejg8yhKeMiw8Q73eQEP7O
   vp81rsiZE+8i/LeHVr3OayqDTny1xpH01+lQ3+Y23Xt5Zac1nt8GQkUPR
   J8Clvs+ZaOiXfioyGBxLnxEK9PSlw/PsfdrmGBSilBYBNLX/rSLmxPJeF
   QpjTx3fTfar3fU5b01n6UR/7oTR60cy7tVZ/j+YBY84V2e7VoARQn9ke3
   w==;
X-CSE-ConnectionGUID: imiSScCiQM6UnnXLZGeBVQ==
X-CSE-MsgGUID: YfT6z1fWT1KkF5oYLOyg8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481950"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481950"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:06 -0700
X-CSE-ConnectionGUID: NQGb3yeuSbW5JeWJ/NDD0A==
X-CSE-MsgGUID: SMvjHHtTQJySvBszTAF66A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262700"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:07 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 27/71] x86/bugs: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:06 -0700
Message-ID: <20240424181506.41673-1-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/bugs.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ca295b0c1eee..32d86dd976c0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -26,7 +26,7 @@
 #include <asm/msr.h>
 #include <asm/vmx.h>
 #include <asm/paravirt.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/e820/api.h>
 #include <asm/hypervisor.h>
 #include <asm/tlbflush.h>
@@ -2390,20 +2390,20 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 	if (c->x86 != 6)
 		return;
 
-	switch (c->x86_model) {
-	case INTEL_FAM6_NEHALEM:
-	case INTEL_FAM6_WESTMERE:
-	case INTEL_FAM6_SANDYBRIDGE:
-	case INTEL_FAM6_IVYBRIDGE:
-	case INTEL_FAM6_HASWELL:
-	case INTEL_FAM6_HASWELL_L:
-	case INTEL_FAM6_HASWELL_G:
-	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_G:
-	case INTEL_FAM6_SKYLAKE_L:
-	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_KABYLAKE_L:
-	case INTEL_FAM6_KABYLAKE:
+	switch (c->x86_vfm) {
+	case INTEL_NEHALEM:
+	case INTEL_WESTMERE:
+	case INTEL_SANDYBRIDGE:
+	case INTEL_IVYBRIDGE:
+	case INTEL_HASWELL:
+	case INTEL_HASWELL_L:
+	case INTEL_HASWELL_G:
+	case INTEL_BROADWELL:
+	case INTEL_BROADWELL_G:
+	case INTEL_SKYLAKE_L:
+	case INTEL_SKYLAKE:
+	case INTEL_KABYLAKE_L:
+	case INTEL_KABYLAKE:
 		if (c->x86_cache_bits < 44)
 			c->x86_cache_bits = 44;
 		break;
-- 
2.44.0


