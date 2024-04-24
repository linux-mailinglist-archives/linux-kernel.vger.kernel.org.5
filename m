Return-Path: <linux-kernel+bounces-157496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D17468B1224
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A53628C959
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF891A38F3;
	Wed, 24 Apr 2024 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/nX5rg9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DC2199EA9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982530; cv=none; b=dDEu2HXN7BYuab+f5H2vqeT8ZQ7ovpeYdBtOksP+uS7E/vy3pDN1YiWy7UYt+HN0aMeUHuu33ZPRyVbgCt6wNpbCMV9LNMwgA4THe6QiueQHkNjDA6KofV8FdSizkxG7eF/HLLiJwrtDm/zd/J2rxzeokaLyemHaV03eUjUk0qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982530; c=relaxed/simple;
	bh=dCC5e5zdUWP8nN10zczP7r4e33cRc3Nah82w39Vvy74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQciXMpMoIvmiuzfsNCzG76FwsDFnJMWX9MVQOaiLNtGvIhLuSzC26bA5QXu6vEcuXFBy8fBxlCOB5wSiAVi0JAgeR67sT6a6KzHE5uSn+CwLInf08+eooX7QQhjuOJ/UinkevY3rrP+10ISWfFER/xNu6WA74Q8+kIzgyUGvUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/nX5rg9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982529; x=1745518529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dCC5e5zdUWP8nN10zczP7r4e33cRc3Nah82w39Vvy74=;
  b=Z/nX5rg93JZVjrZu/ez6E9VE7I8Ly6AAk30qaxSdbXFR73mMYjZY69zH
   Bm15k/CX0NKz627oU2u0a24pJF0tctsSBMCgkcLju47JQ3NIYk37wU2lB
   Wbpj+Ys2lbAqCbLx7CMv0KQmWu0MWuqbBkuubuqyT7Zuul31maEwPvM1H
   pZVKmR1yTtXiPmHHZwxVQP/gbBU/e8mgwZM8XD/GO8pGy9sqYrq6Zq4yi
   pSLNfG/bHGgXL3QSBSu2fCGVopKtU2Hzlu9rTpKZfr/ypcOvHkRMKqNpa
   9jaKmIaC+ED9zFlpPcXtt9wMe9Bte4HhGZaz4mkw2+G1XuH66cMY/qY4a
   Q==;
X-CSE-ConnectionGUID: EU/b5jb6T8iGI40zBOWe6A==
X-CSE-MsgGUID: ynEM4odkSpKb+RD5gkAjRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9482072"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9482072"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:18 -0700
X-CSE-ConnectionGUID: mgTPo2hJR/2Epmgb3jkRYA==
X-CSE-MsgGUID: HLu4AdKOSLGC4CcDZD7aOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262788"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:18 -0700
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
Subject: [PATCH v4 40/71] x86/tsc_msr: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:18 -0700
Message-ID: <20240424181518.41927-1-tony.luck@intel.com>
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
 arch/x86/kernel/tsc_msr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 6555a857a1e6..deeb02825670 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -147,13 +147,13 @@ static const struct freq_desc freq_desc_lgm = {
 };
 
 static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID,	&freq_desc_pnw),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_TABLET,&freq_desc_clv),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&freq_desc_byt),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&freq_desc_tng),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&freq_desc_cht),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_MID,	&freq_desc_ann),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_NP,	&freq_desc_lgm),
+	X86_MATCH_VFM(INTEL_ATOM_SALTWELL_MID,	&freq_desc_pnw),
+	X86_MATCH_VFM(INTEL_ATOM_SALTWELL_TABLET, &freq_desc_clv),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&freq_desc_byt),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID,	&freq_desc_tng),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&freq_desc_cht),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_MID,	&freq_desc_ann),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_NP,	&freq_desc_lgm),
 	{}
 };
 
-- 
2.44.0


