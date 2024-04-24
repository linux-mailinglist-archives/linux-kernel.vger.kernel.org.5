Return-Path: <linux-kernel+bounces-157474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EBB8B1203
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7281F21BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF32180A96;
	Wed, 24 Apr 2024 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPybUfDH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18FD1802AD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982519; cv=none; b=Csm93u6f0B+4n+NZf3T65tC/CXdhSAGx8noLvXO3HjpykzGJORpb74OiRsjzIFDy8kyjCFFZ2lqildgkPnKae7DARWZ2p6yFln3EoG8ev5X0V/8Op+G9A6YdUnHP7Nbmlbjj5gA7cieBm7a6jxii4UTOA887wn6IVB6a3EWcKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982519; c=relaxed/simple;
	bh=9rMjpqoCOgRty8mRKqjOBHEBAP+bItOsOB0U8/8T0P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EioY9f5F+Ou6MN6tH/G5GiHafkBi/EqwXSN9b/QUP8HSCZeeB3dQb9VAJ4EWlZnJ7GJ3M++QOlZhiz1oZo1G9Z92lQqD3COcy1KB2ezZ5BG+6cLebJaMb+SBsztb+OTjLOZbkSQbZLH1AsoO/tMO+Vck2Tzp+K0PMT6QP1ARS98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPybUfDH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982517; x=1745518517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9rMjpqoCOgRty8mRKqjOBHEBAP+bItOsOB0U8/8T0P4=;
  b=RPybUfDHxluMbqGjOeyHytOaQV1f82jT1ZO5uyMpThihzMZ5lHK2ykac
   ziDixW+cQHIfnSRJ6hu88qjM0Gq3eQkYsd86TP2hPfzYJg0swc16TFyo0
   pslo1WmH2/ugmhmeAGjZREKAl5G+GMZY5A9Ygh+U/tm+ZG6bDz7k9rgMb
   PIz3dtsclQdxxZcWGArv4RwvyZTgPXIVklnDONNrZtANIcpFjatEq6tT9
   +ZioJm/0OpImilq1nFFppjYk9NWVSxv2+cKyzVMcMWesjzHoVXLPYmHMx
   sEefqe16osOBSbL6i50W+SKrtA9nl8xsvhIJkNeX+OHuGS6kZMU65mdZF
   w==;
X-CSE-ConnectionGUID: rBmmDbMGTG6+Cv74tJK0Mw==
X-CSE-MsgGUID: +q6BalzHTQmXA446NkaQVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481943"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481943"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:06 -0700
X-CSE-ConnectionGUID: Mn4Cqx1hS26PH8lQg704lQ==
X-CSE-MsgGUID: d+cdyBE0SjOYHlJxgAxWNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262695"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:06 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 26/71] x86/aperfmperf: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:05 -0700
Message-ID: <20240424181505.41654-1-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/aperfmperf.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index fdbb5f07448f..f9a8c7b7943f 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -124,25 +124,24 @@ static bool __init slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 	return true;
 }
 
-#define X86_MATCH(model)					\
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
-		INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
+#define X86_MATCH(vfm)						\
+	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_APERFMPERF, NULL)
 
 static const struct x86_cpu_id has_knl_turbo_ratio_limits[] __initconst = {
-	X86_MATCH(XEON_PHI_KNL),
-	X86_MATCH(XEON_PHI_KNM),
+	X86_MATCH(INTEL_XEON_PHI_KNL),
+	X86_MATCH(INTEL_XEON_PHI_KNM),
 	{}
 };
 
 static const struct x86_cpu_id has_skx_turbo_ratio_limits[] __initconst = {
-	X86_MATCH(SKYLAKE_X),
+	X86_MATCH(INTEL_SKYLAKE_X),
 	{}
 };
 
 static const struct x86_cpu_id has_glm_turbo_ratio_limits[] __initconst = {
-	X86_MATCH(ATOM_GOLDMONT),
-	X86_MATCH(ATOM_GOLDMONT_D),
-	X86_MATCH(ATOM_GOLDMONT_PLUS),
+	X86_MATCH(INTEL_ATOM_GOLDMONT),
+	X86_MATCH(INTEL_ATOM_GOLDMONT_D),
+	X86_MATCH(INTEL_ATOM_GOLDMONT_PLUS),
 	{}
 };
 
-- 
2.44.0


