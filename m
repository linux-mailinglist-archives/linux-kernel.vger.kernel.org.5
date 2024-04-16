Return-Path: <linux-kernel+bounces-147579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D3C8A7651
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A694B1C21C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF74513C825;
	Tue, 16 Apr 2024 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aebk4ZTm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26813AD33
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302408; cv=none; b=WNaK0MVbJGHpgMZFnhKTs77UEOqKHl+auMb6KkarOPp2iJx9SM8vA0G0fvsWlglK4G2IFl9LnWVp0lTlcFBZIfYy1phpZvjXzLquW9A7jbPwy8+Xq+wgtFBLnhZ6GTuCcPzxK2ibeIjfwEyy2dIiH1eMIlZxPvkHWrCquIs5YEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302408; c=relaxed/simple;
	bh=CIcz5Nw2dfWca2jMW3VzowmJZ/HfcnGQaEE9Ffmx768=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzHFn0f9BP0rL+QAgBwNY21LJ3qSaikFHYzVm9cWAsF7qvoXtrYmzI7UioRuHDHHcV/lIybvyMs6u4ZVtORdj5UoX/P7vmOIJ1MyR6ixYJJzAnun2TIs2FQs6p1rXPZI4DomS5+wV0H26lEx5ueLwTuo2yzqI87l+a77YcVwxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aebk4ZTm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302406; x=1744838406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CIcz5Nw2dfWca2jMW3VzowmJZ/HfcnGQaEE9Ffmx768=;
  b=Aebk4ZTm4r74O1WTmB9sLtRa4ityIkcw70rNafScIYBEgSIvvFACZ++M
   Y9MWqhXSj9PVHpwNgaj3wo68EDMecjZno6KVOSKpoFPu+wgkUFylilztp
   hfcFBdT5TzVaLREB8WxP86xdP9rKig69sxlDFrlb4QrlX3R7axnds6RDQ
   D+T1xCIZxxNF1cgBwSgHfNds2MJtD9y+gbsNe2UqN4EpEXebwXvamC9my
   2z5uodBG5Qvawy/0S6V2dZhTL4fnKAMRxFxLJU6v2tt4jbxBK4ETmslu8
   KQql8acIhU+lbN8n05bLETZoynER0o22iiXr9V6Y3Bo3Dy16Id1fwnZ3T
   w==;
X-CSE-ConnectionGUID: 2AW+ADHTQz6TXedhDCSXmA==
X-CSE-MsgGUID: Z60SwhiPTwibJds+RGeakg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914750"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914750"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:00 -0700
X-CSE-ConnectionGUID: D3+EexuIT+WYPVZaPH/YaQ==
X-CSE-MsgGUID: C1rjBy67SHeoHMmKEwVnPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871941"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:59 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 19/74] x86/cpu/vfm: Update arch/x86/kernel/cpu/intel_epb.c
Date: Tue, 16 Apr 2024 14:19:21 -0700
Message-ID: <20240416211941.9369-20-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/intel_epb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index f18d35fe27a9..30b1d63b97f3 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -204,12 +204,12 @@ static int intel_epb_offline(unsigned int cpu)
 }
 
 static const struct x86_cpu_id intel_epb_normal[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,
-				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,
-				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,
-				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,
+		      ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,
+		      ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,
+		      ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
 	{}
 };
 
-- 
2.44.0


