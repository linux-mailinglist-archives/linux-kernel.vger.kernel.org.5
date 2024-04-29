Return-Path: <linux-kernel+bounces-161679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 015BF8B4F63
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 404E8B20BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE1A10F7;
	Mon, 29 Apr 2024 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3SNj0ut"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5AE7F;
	Mon, 29 Apr 2024 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714357261; cv=none; b=CVnMtqIJ/J09ri+7FqMevjAYf/vVmjqjsV6BfGH/SaNkEvtJ+P/UVqDYirm+xRLq1eI8GHfQHCRNa3QFcFBOt9A0xN6xLQ9/SiqrZ3gPAAp7NbElU7ssl+YseAYRYLZ519UdFZrwRRJtZ5vm9AY7eeBpsGl/p7tOdKkC+WGLh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714357261; c=relaxed/simple;
	bh=rH54+B7qepEzsTkmzdfjQzpVNgnT3mmYkF98YkNuoqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uN+UjKj0Zj1tGnXynvHpOwFWVQFD8Dl/wDQlP56xfLCjKtxW54FHNjWTDa0usxj8noEHhNYHSSdJDIbuefSATmFnpppD3NDc+G7opzuKRnmEIpgUbVjD1cL2qK3nEXJ7QvOvTZwSQ42eKuLYo83joIAEWf/i7Q3/lqXi8U0UE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3SNj0ut; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714357260; x=1745893260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rH54+B7qepEzsTkmzdfjQzpVNgnT3mmYkF98YkNuoqI=;
  b=H3SNj0utJDHY3VYfqv23VhwsG4a4lU8wOEYpUe4r+oj1DXX7RbmwHHCw
   fLJbHC2GJ+xgUngf+MYlfbbYGglkakxvSPaBVsJY7pcqZ3FADUwndZIsQ
   iBkM7BeQiGtOVVRI+VybCHM67ESGssqE3SQHixabvzQD8jG1uAMVYUo4g
   ohJYUajmOjRud5mVtkfYAOQF/ykACxV/a+DbvJbbBSoeSRnrgwaOxF3jT
   QxDniFTpTnBOm4rBb98AcoYrBr5GN8xZ4q4nlOQwQoBOMaamAKujxZArY
   aVYY6ldGS9UjUT6hIYVV7WNIFhTFO1lYrwf3VRpRQlAIVCl5H3U5XCosR
   g==;
X-CSE-ConnectionGUID: 570XayEmTuuqkNhQCtNnYQ==
X-CSE-MsgGUID: F2bKKeRRQqu+0OTnY5vEHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9882264"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="9882264"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 19:20:59 -0700
X-CSE-ConnectionGUID: nL0jTXbdRtiK/ZJL6nAgWw==
X-CSE-MsgGUID: 0QddVH5eSTWd1y+paFc/tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="25837300"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 19:20:58 -0700
From: Tony Luck <tony.luck@intel.com>
To: bp@alien8.de
Cc: dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	tony.luck@intel.com,
	x86@kernel.org
Subject: [PATCH] x86/cpu: Fix thinko comparing x86_vfm with x86_model
Date: Sun, 28 Apr 2024 19:20:51 -0700
Message-ID: <20240429022051.63360-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240428183142.GHZi6WDu5nbmJJ_BcH@fat_crate.local>
References: <20240428183142.GHZi6WDu5nbmJJ_BcH@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is obviously nonsense. Fix it.

Fixes: 68b4c6d168c5 ("x86/mce: Switch to new Intel CPU model defines")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Boris: Do you rebase x86/cpu branch in TIP? If so this could be merged
into the broken patch. If not then slap it on top. Risk of bisection
breakage is tiny as this only affects a quirk handling patrol scrub
errors on Skylake and Cascade lake systems.

 arch/x86/kernel/cpu/mce/severity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 7293a1c49050..e7892f11c70f 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -398,7 +398,7 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char
 			continue;
 		if (s->excp && excp != s->excp)
 			continue;
-		if (s->cpu_vfm && boot_cpu_data.x86_model != s->cpu_vfm)
+		if (s->cpu_vfm && boot_cpu_data.x86_vfm != s->cpu_vfm)
 			continue;
 		if (s->cpu_minstepping && boot_cpu_data.x86_stepping < s->cpu_minstepping)
 			continue;
-- 
2.44.0


