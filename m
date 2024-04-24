Return-Path: <linux-kernel+bounces-157477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B18B1209
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BF72911A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CE3181B88;
	Wed, 24 Apr 2024 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3/mlI/3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813C8180A77
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982521; cv=none; b=SJAaXohjZEwIwvH4TurHeqysaojJX7Ja7FM3HdHaBbK+j6SaCsaCfcaGtQeZnH6G8gjB8aRo7vnlVDUFtOAUaQfnhMh1vs632kjn2irL/scF7xC5Bci4U9K2RVGjnNwq+Xc3G8XFgdgWooWRGK1u4gsHp3dqzVJjAzh40jUnYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982521; c=relaxed/simple;
	bh=CIcz5Nw2dfWca2jMW3VzowmJZ/HfcnGQaEE9Ffmx768=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2FtM6uAQ/Vvir01LygazAEyNja1RBkuT06IgcwEmCIbSayxih8Hu7DGRhrgEz3AHgKpm+9vXM5aP/wyurv+Ho7tsBTswRwgsy8NynzLnCXU24/iHuuBhyAm5lCjR9tExG9iMvw/7R1owJAB7fkWu3307olF8wGVTBUU1lsKedc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R3/mlI/3; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982519; x=1745518519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CIcz5Nw2dfWca2jMW3VzowmJZ/HfcnGQaEE9Ffmx768=;
  b=R3/mlI/3OhZ+CmsPVqJWQGSIk+3EIOX/rfs33id3Mcy0vPdgAzAGYeX+
   Bfw7AQybtbWnWWen3RL8YiaQPWoxjTtA9DEVQMo9jG5cFK+ngPZSIA2nE
   SOnBc38qhKx8FzAxHznl77DCQKRPg+woLDKH8BZeoQRNxx6T1bUdaGjHz
   em43/UW6dipx3i0t+nFKeEoI9yfK46+rgKfaWYpiwtNyd1ml/f7+ll8B0
   t+oXyd3CUbxKXu3wajRG++uUR6RqbrDb/RUbMRFLBw7ztdikjLJbeKDdd
   hIR8tdhZUaq+k54f200+wGW5KMXEz8ew2hpKOaiL2bBmxRZ2xzOL6ejU1
   Q==;
X-CSE-ConnectionGUID: i83pgSYqT4KkOaA6fF3jwQ==
X-CSE-MsgGUID: pLbpcLB2Sxei8v4pqhgVUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481977"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481977"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:10 -0700
X-CSE-ConnectionGUID: Fwjj2ohoQ9S7sZY4S6yGCQ==
X-CSE-MsgGUID: o5GBkDJNTI+i+PamPgq6ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262726"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:10 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Gavin Shan <gshan@redhat.com>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 30/71] x86/cpu/intel_epb: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:09 -0700
Message-ID: <20240424181510.41733-1-tony.luck@intel.com>
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


