Return-Path: <linux-kernel+bounces-164435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D99A8B7DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1C2288548
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12DB1836C8;
	Tue, 30 Apr 2024 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHc5C8Fb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E917F39F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495897; cv=none; b=Jwskp1rAuh6b107Te03NU4CGtUFzGtsTQ1+mjA9GlS1WC5RK5EhigvMygTqLZzSGJMkeXMYb6A2WrCMU9J038BNkOcvbgLz3/q9W9G7weGhS2HdJVCk+13EX16MVMaZk/oHi/wNSj0a86XjwqRAq9xz8X9p0Ts/tMEzSsB23pT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495897; c=relaxed/simple;
	bh=kkF0kOmubRaABW0Hf14QsZUk5Z9XWIfvaI1+06NWDic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPTozYspUw7w3y5yVFgg/+dMxKXaFlZ3PSR4vhY5pRprLYx4JJT6DMchDKWMFG46HNY+PfE0qo5OVdntAd7+wAJSNgi/RAeYCy4AqUvTblhocD+uFixsaZDnsAAoSV/oG+QyqbUIASQ/9A7xinctVloJOcxKihzaCeYd2FVF5vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHc5C8Fb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495896; x=1746031896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kkF0kOmubRaABW0Hf14QsZUk5Z9XWIfvaI1+06NWDic=;
  b=HHc5C8Fbr9SgbDi+NUCukWyxlgXSCsmIufYL9etxnwzBbg1totu3rfkN
   5NBPrdEmhDOMOLTTtTa9xtIU+pHlZBI8g6cT3iq0W+ZbOBzxlDPaL8kme
   JV621aelgrhCgeRAdJGbm4QZffBcK0ux1NPaU8qxbSr+SnYBlGXHvMwKN
   XBGHzCt0WFxN3Afh5mqkUFumqjVlYcqYMmXkAKdZOIna810vdGFuPl9mE
   f5oSN8leu5QrR+mEIiXO4QvKou76vanEOTBL4bRjry8PVgDs5NkV6doGw
   aD2PvYvOw7I8A/qq3R0+CrUUYqbWAH19ixrOMNwwhr6912Jz0SurauAjl
   g==;
X-CSE-ConnectionGUID: ufVnIe+wTweHRiMHm4B6jw==
X-CSE-MsgGUID: at7cF6HUS8G8gDRJAN0JbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075635"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075635"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:21 -0700
X-CSE-ConnectionGUID: N6+EOdB9SaSSOBvNYBrNlw==
X-CSE-MsgGUID: SQergmIjS4eho8Rfw9pcmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515416"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:11 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH v5 06/47] KVM: x86/pmu: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:19 -0700
Message-ID: <20240430165100.73491-6-tony.luck@intel.com>
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
Acked-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index c397b28e3d1b..2faa67a4bfb6 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -34,16 +34,16 @@ EXPORT_SYMBOL_GPL(kvm_pmu_eventsel);
 
 /* Precise Distribution of Instructions Retired (PDIR) */
 static const struct x86_cpu_id vmx_pebs_pdir_cpu[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_D, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_X, NULL),
 	/* Instruction-Accurate PDIR (PDIR++) */
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, NULL),
 	{}
 };
 
 /* Precise Distribution (PDist) */
 static const struct x86_cpu_id vmx_pebs_pdist_cpu[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, NULL),
 	{}
 };
 
-- 
2.44.0


