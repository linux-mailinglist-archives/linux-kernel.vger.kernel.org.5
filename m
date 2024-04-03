Return-Path: <linux-kernel+bounces-130104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E805289741E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254F01C25F0B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9906714A4D2;
	Wed,  3 Apr 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uca8iIjH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B87D14A633
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158516; cv=none; b=tLxkZsuJYdpR41EJae+udhtqT9lQC41GYS+AgGL68J/WFHZuTPJg/o1XK5WHaEQatoZXx4PnPuCDnYxxPFSIxjBk2E3lbUatg1ljwGaruo9dpAzWy+7ZjzGJvemQsk5crr+cIZT2BuRB8FnelK9xQc2wqG4V9IR6oVW8UVRJo1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158516; c=relaxed/simple;
	bh=jx3tpS06rszZZiW1VietOfoJ84bc3y027wrDYFXoLwY=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=lvtCU6G6UuyCotnJqVH7ltKJQGKWEQgZYpFQNLVCrrJlExR7kofbVwxdT3hWGSUZRHXBKSvyFLrlqTZui3yN5HeBTKFswP/mMymAQGQXf1O+y73NW2AJSym983n/ahZORXJsbV0DZI+899xhTQ5uYrFCMBXiGujF6cW2P2FxPVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uca8iIjH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712158516; x=1743694516;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=jx3tpS06rszZZiW1VietOfoJ84bc3y027wrDYFXoLwY=;
  b=Uca8iIjHB75Oig6x65DyQNj4NxwcxIbkD1aTkMGLl6xMxddRxNq+LVTc
   M3TXRCOA+OOPnKLMc12VZzK9fw9nWjbQBjf4+7tHVNLFCCuwqgcsarsvM
   kQCxjNxvXnwzuy1oH96703+1YiBzPfogn8AUvlgWkEK+wiCn7HxyHVv8V
   kcUfo5H92Qx3Uqyirnjfck9vexEArVTNzOKZq85fKdWxCsHZg6eennGja
   DLLSL1zgb5ugzOgImCzZCC5lxkoXYV6YjKwkrFT1gupVtgMw9m5/ymO3a
   EBLaS9osHwvgx49c3P+p8vM6j6ZbpQIGtlqyGs8X4xeKav2O/FX1NLva1
   Q==;
X-CSE-ConnectionGUID: iOJCh39SSqydd8Qjps+50g==
X-CSE-MsgGUID: jiWUzcnyRomnmpIUpvMlXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18556337"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18556337"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 08:35:16 -0700
X-CSE-ConnectionGUID: Thu+w43xRuqA0zm5vzEnJA==
X-CSE-MsgGUID: Vl0FAN+tQle4/EU9X6zu8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18395625"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 03 Apr 2024 08:35:15 -0700
Subject: [PATCH 4/4] x86/xen: Enumerate NX from CPUID directly
To: linux-kernel@vger.kernel.org
Cc: jgross@suse.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 03 Apr 2024 08:35:14 -0700
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
In-Reply-To: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
Message-Id: <20240403153514.CC2C9D13@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

xen_start_kernel() is some of the first C code run "Xen PV" systems.
It precedes things like setup_arch() or processor initialization code
that would be thought of as "very early".

That means that 'boot_cpu_data' is garbage.  It has not even
established the utter basics like if the CPU supports the CPUID
instruction.  Unfortunately get_cpu_cap() requires this exact
information.

Nevertheless, xen_start_kernel() calls get_cpu_cap().  But it
works out in practice because it's looking for the NX bit which
comes from an extended CPUID leaf that doesn't depend on
c->cpuid_level being set.

Stop calling get_cpu_cap().  Use CPUID directly.  Add a little
helper to avoid cluttering up the xen_start_kernel() flow.

This removes the risky, barely-working call to get_cpu_cap().

Note: The '& 31' strips the "capability" word off of an
      X86_FEATURE_* value.  It's a magic number, but there are
      a few of them sparsely scattered around and it's way
      shorter than any helper.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>
---

 b/arch/x86/xen/enlighten_pv.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff -puN arch/x86/xen/enlighten_pv.c~xen-explain1 arch/x86/xen/enlighten_pv.c
--- a/arch/x86/xen/enlighten_pv.c~xen-explain1	2024-04-02 15:23:00.046913557 -0700
+++ b/arch/x86/xen/enlighten_pv.c	2024-04-02 15:23:00.050913562 -0700
@@ -1306,6 +1306,21 @@ static void __init xen_domu_set_legacy_f
 
 extern void early_xen_iret_patch(void);
 
+/*
+ * It is too early for boot_cpu_has() and friends to work.
+ * Use CPUID to directly enumerate NX support.
+ */
+static inline void xen_configure_nx(void)
+{
+	bool nx_supported;
+	u32 eax = 0;
+
+	get_cpuid_region_leaf(0x80000001, CPUID_EDX, &eax);
+
+	nx_supported = eax & (X86_FEATURE_NX & 31);
+	x86_configure_nx(nx_supported);
+}
+
 /* First C function to be called on Xen boot */
 asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 {
@@ -1369,9 +1384,7 @@ asmlinkage __visible void __init xen_sta
 	/* Get mfn list */
 	xen_build_dynamic_phys_to_machine();
 
-	/* Work out if we support NX */
-	get_cpu_cap(&boot_cpu_data);
-	x86_configure_nx(boot_cpu_has(X86_FEATURE_NX));
+	xen_configure_nx();
 
 	/*
 	 * Set up kernel GDT and segment registers, mainly so that
_

