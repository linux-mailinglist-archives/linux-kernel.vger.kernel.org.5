Return-Path: <linux-kernel+bounces-130103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266D589741D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB221F2470C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C61F14AD0F;
	Wed,  3 Apr 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVJOKVzF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595514A603
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158515; cv=none; b=uRmd37nmxi8TS+SiWFPoroYR0X8K3oDLj/ixt5he6B4pOcr5mirzFSZxjucYi534awnjrJCxxT9X9cFLE6rrfQhn6d5Tx+BX3HcM9LijYZtSFbxuCaYwfFInV78JbHaekG+bL2VbXJBhcZjruX2Gboe+A1V9jR/c2ONCQMvmLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158515; c=relaxed/simple;
	bh=a6HVtRXaQfY5q5OgOACYnReHMtv81k9BxmJgM8UFrro=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=ob4m/SJE4b4mr3W7APPTj/7FXADzHiC9FbFrlitMV+x9M9F+KFphZeeZjuL1OJkonT/vzd9p8B+yEjlseyq5eUORpBv2aQTrtrAe+wwN05CdYPfv0ZRcMqlKbloVna7QRFp3O7jo1OYU4QlW+AuZem3epLu5ult0mYXTtIRlsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVJOKVzF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712158514; x=1743694514;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=a6HVtRXaQfY5q5OgOACYnReHMtv81k9BxmJgM8UFrro=;
  b=BVJOKVzFtfmOftSSK81mV7xXymMs18XWi7Ioc8XWWi9V5uQvvAys2b2l
   3btOopFlUAMU6A+val7OHnUk8dFR2xmPj+MZhjleiMyomEZ+bhLAybZpA
   U6Tp2wzRWP4yw35T9Lh2P9J7pgRiJRFrIoH+USOajo9QL5QDpjc893V2I
   1CxG8lbHtfCDcNq0FB04O8tGowWuBtx8ccv3cjVpt/Z13H5XzHPMW06Q7
   RnpI57z1ZmKZIEoxfU+YYgBzjxv5Ea11BMCMY9UYjBZfPxPYnZppuLTtf
   mGqnxxG69MikkQog3iJTCCPmgwzmdlMsekdVyEoWnMJmYswYb5wGXtAeB
   A==;
X-CSE-ConnectionGUID: Or0ew0lWQbqKsOASe4mhVA==
X-CSE-MsgGUID: TTVEedUIRLWcUK+Y+XC3RQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18556328"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18556328"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 08:35:14 -0700
X-CSE-ConnectionGUID: tDe7EAcpQ46er0WJjWuvmw==
X-CSE-MsgGUID: VOZi+z/ZRni8Qe08hOCDYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18395618"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 03 Apr 2024 08:35:13 -0700
Subject: [PATCH 3/4] x86/boot: Explicitly pass NX enabling status
To: linux-kernel@vger.kernel.org
Cc: jgross@suse.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>,kai.huang@intel.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 03 Apr 2024 08:35:13 -0700
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
In-Reply-To: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
Message-Id: <20240403153513.76C52354@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The kernel sometimes needs to mask unsupported bits out of page
table entries.  It does that with a mask: '__supported_pte_mask'.

That mask can obviously only contain the No-eXecute bit (_PAGE_NX)
on hardware where NX is supported.  x86_configure_nx() checks the
boot CPU's NX support and adjusts the mask appropriately.

But it doesn't check support directly.  It uses the venerable
'boot_cpu_data' which is a software approximation of the actual CPU
support.  Unfortunately, Xen wants to set up '__supported_pte_mask'
before 'boot_cpu_data' has been initialized.  It hacks around this
problem by repeating some of the 'boot_cpu_data' setup *just* for
NX.

Have x86_configure_nx() stop consulting 'boot_cpu_data' and move
the NX detection to the caller.

No functional change.  That will come later.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---

 b/arch/x86/include/asm/proto.h |    2 +-
 b/arch/x86/kernel/setup.c      |    6 +++---
 b/arch/x86/xen/enlighten_pv.c  |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff -puN arch/x86/include/asm/proto.h~x86_configure_nx-arg arch/x86/include/asm/proto.h
--- a/arch/x86/include/asm/proto.h~x86_configure_nx-arg	2024-04-02 15:22:59.638913056 -0700
+++ b/arch/x86/include/asm/proto.h	2024-04-02 15:22:59.642913062 -0700
@@ -37,7 +37,7 @@ void entry_SYSRETL_compat_end(void);
 #define entry_SYSENTER_compat NULL
 #endif
 
-void x86_configure_nx(void);
+void x86_configure_nx(bool nx_supported);
 
 extern int reboot_force;
 
diff -puN arch/x86/kernel/setup.c~x86_configure_nx-arg arch/x86/kernel/setup.c
--- a/arch/x86/kernel/setup.c~x86_configure_nx-arg	2024-04-02 15:22:59.638913056 -0700
+++ b/arch/x86/kernel/setup.c	2024-04-02 15:22:59.642913062 -0700
@@ -687,9 +687,9 @@ dump_kernel_offset(struct notifier_block
 	return 0;
 }
 
-void x86_configure_nx(void)
+void x86_configure_nx(bool nx_supported)
 {
-	if (boot_cpu_has(X86_FEATURE_NX))
+	if (nx_supported)
 		__supported_pte_mask |= _PAGE_NX;
 	else
 		__supported_pte_mask &= ~_PAGE_NX;
@@ -853,7 +853,7 @@ void __init setup_arch(char **cmdline_p)
 	 * whether hardware doesn't support NX (so that the early EHCI debug
 	 * console setup can safely call set_fixmap()).
 	 */
-	x86_configure_nx();
+	x86_configure_nx(boot_cpu_has(X86_FEATURE_NX));
 
 	parse_early_param();
 
diff -puN arch/x86/xen/enlighten_pv.c~x86_configure_nx-arg arch/x86/xen/enlighten_pv.c
--- a/arch/x86/xen/enlighten_pv.c~x86_configure_nx-arg	2024-04-02 15:22:59.638913056 -0700
+++ b/arch/x86/xen/enlighten_pv.c	2024-04-02 15:22:59.642913062 -0700
@@ -1371,7 +1371,7 @@ asmlinkage __visible void __init xen_sta
 
 	/* Work out if we support NX */
 	get_cpu_cap(&boot_cpu_data);
-	x86_configure_nx();
+	x86_configure_nx(boot_cpu_has(X86_FEATURE_NX));
 
 	/*
 	 * Set up kernel GDT and segment registers, mainly so that
_

