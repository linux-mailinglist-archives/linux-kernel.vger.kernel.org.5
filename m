Return-Path: <linux-kernel+bounces-134386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FFD89B0E0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B88B20E10
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2080376E4;
	Sun,  7 Apr 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUgiEU3R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302753309E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493934; cv=none; b=gU1BlXOfUSHEo/uNdoSV4qhI3VD5CWrGAWMtj7QHCwx3reTzauAArizDld8TdKm2OwNNXVevA7cVd2Q+jOABzTT69URhz/mtEqYYpqUwT5GI3VFVkTjrPSZYIqDTq0vVrsNSIW1SxNI40YdBn/2md0g/TcqOT3ULoJwfNDbHAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493934; c=relaxed/simple;
	bh=w5AQltEjcfuaA8t+xAbaDYXarkRZWOmtHIHnBJWtT88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHr0qwR1OgtZalAwWZVPezPrnS5KWBbEl5595C5oRkRc2Bl8wPOwm/LYilsyj2ndAKJLwiNDs/bsaUQYQh6bKB3MBPRicq406b9DHUjSWrfrPaAv728+XqxsxM38o6zzqCAkRb3fkuhRY+gl/73t2Uj6X+pcoiYH/sH/+aHT67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUgiEU3R; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712493934; x=1744029934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w5AQltEjcfuaA8t+xAbaDYXarkRZWOmtHIHnBJWtT88=;
  b=JUgiEU3RkQXSxPx/c7OXEdn/MiEYFLjNdeAz7Qjxp+Q7cP2cu/vPuTFT
   CuQf4sRJe5CtIhxkGImQJ/0zmQMTyDX1aKTajTQOV9PuiSMJUt3JHwmXy
   RbKjfPcMeLw6y06Lq70SWIdOXcFPZeT2KtRBMkt/tZmK4qviAXFgyjHks
   heJWqnhrSXMMrSjFxTBk/Nfft6YsS1wdsJkbTdiJeuGgejY/x6d+Rxysl
   G4sF0KuRXOSID1rZJdufLhrbzv+UGsx428jUbSj9L/d//dPlBAmvfm9GA
   OsjO4BKr5yX9vVoOgA6jdWrqHKw5Utg6KbNJhn1OPbXr4MeGOcJ9bhPPE
   w==;
X-CSE-ConnectionGUID: RJI2J3nrRy6dcDLlHZi7RQ==
X-CSE-MsgGUID: 9Mxs4Do4Q5mFfczj6KzG1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="11564103"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="11564103"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 05:45:33 -0700
X-CSE-ConnectionGUID: 7757OkZGT3ijl1UFYtuNcg==
X-CSE-MsgGUID: z0HSBt8LTxOfUIzCWypoBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="20185744"
Received: from mirtanji-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.251.14.88])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 05:45:29 -0700
From: Kai Huang <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	bp@alien8.de,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com,
	ashish.kalra@amd.com,
	chao.gao@intel.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: [PATCH v3 5/5] x86/virt/tdx: Add TDX memory reset notifier to reset other private pages
Date: Mon,  8 Apr 2024 00:44:58 +1200
Message-ID: <94a9d89487356547b67e2e5c08edae3bd2e68490.1712493366.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1712493366.git.kai.huang@intel.com>
References: <cover.1712493366.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR:

To cover both normal kexec and crash kexec, add a TDX specific memory
reset notifier to let "in-kernel TDX users" use their own way to convert
TDX private pages (that they manage respectively) in tdx_reset_memory().

Long version:

On the platforms with TDX "partial write machine check" erratum, during
kexec, the kernel needs to convert TDX private memory back to normal
before jumping to the second kernel to avoid the second kernel seeing
potential machine check.

For now tdx_reset_memory() only resets PAMT pages.  KVM will be the
first in-kernel TDX user to support running TDX guests, and by then
other TDX private pages will start to exist.  They need to be covered
too.

Currently the kernel doesn't have a unified way to tell whether a given
page is TDX private page or not.  One choice is to add such unified way,
and there are couple of options to do it:

 1) Use a bitmap, or Xarray, etc to track TDX private page for all PFNs;
 2) Use a "software-only" bit in the direct-mapping PTE to mark a given
    page is TDX private page;
 3) Use a new flag in 'struct page' to mark TDX private page;
 4) ... potential other ways.

Option 1) consumes additional memory.  E.g., if using bitmap, the
overhead is "number of total RAM pages / 8" bytes.

Option 2) would cause splitting large-page mapping to 4K mapping in the
direct mapping when one page is allocated as TDX private page, and cause
additional TLB flush etc.  It's not ideal for such use case.

Option 3) apparently contradicts to the effort to reduce the use of the
flags of 'struct page'.

None of above is ideal.

Therefore, instead of providing a unified way to tell whether a given
page is TDX private page or not, leave "resetting TDX private pages" to
the "in-kernel user" of TDX.

This is motivated by the fact that KVM is already maintaining an Xarray
to track "memory attributes (e.g., private or shared)" for each GFN for
each guest.  Thus KVM can use its own way to find all TDX private pages
that it manages and convert them back to normal.

For the normal kexec the reboot notifier could be used, but it doesn't
cover the cash kexec.

Add a TDX specific memory reset notifier to achieve this.  The in-kernel
TDX users will need to register their own notifiers to reset TDX private
pages.  Call these notifiers in tdx_reset_memory() right before
resetting PAMT pages.

KVM will be the first user of this notifier.  Export the "register" and
"unregister" APIs for KVM to use.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/include/asm/tdx.h  | 14 ++++++++++++
 arch/x86/virt/vmx/tdx/tdx.c | 45 +++++++++++++++++++++++++++----------
 2 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index ed3ac9a8a079..7c2c0a0b9754 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -117,12 +117,26 @@ int tdx_cpu_enable(void);
 int tdx_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
 void tdx_reset_memory(void);
+
+struct notifier_block;
+
+int tdx_register_memory_reset_notifier(struct notifier_block *nb);
+void tdx_unregister_memory_reset_notifier(struct notifier_block *nb);
 #else
 static inline void tdx_init(void) { }
 static inline int tdx_cpu_enable(void) { return -ENODEV; }
 static inline int tdx_enable(void)  { return -ENODEV; }
 static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
 static inline void tdx_reset_memory(void) { }
+
+struct notifier_block;
+
+static inline int tdx_register_memory_reset_notifier(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+static inline void tdx_unregister_memory_reset_notifier(
+		struct notifier_block *nb) { }
 #endif	/* CONFIG_INTEL_TDX_HOST */
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 7f5d388c5461..af62fbffcd96 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -27,6 +27,7 @@
 #include <linux/log2.h>
 #include <linux/acpi.h>
 #include <linux/suspend.h>
+#include <linux/notifier.h>
 #include <asm/page.h>
 #include <asm/special_insns.h>
 #include <asm/msr-index.h>
@@ -54,6 +55,8 @@ static LIST_HEAD(tdx_memlist);
 
 static bool tdx_may_have_private_memory __read_mostly;
 
+static BLOCKING_NOTIFIER_HEAD(tdx_memory_reset_chain);
+
 typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
 
 static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
@@ -1511,6 +1514,27 @@ void __init tdx_init(void)
 	check_tdx_erratum();
 }
 
+int tdx_register_memory_reset_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&tdx_memory_reset_chain, nb);
+}
+EXPORT_SYMBOL_GPL(tdx_register_memory_reset_notifier);
+
+void tdx_unregister_memory_reset_notifier(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&tdx_memory_reset_chain, nb);
+}
+EXPORT_SYMBOL_GPL(tdx_unregister_memory_reset_notifier);
+
+static int notify_reset_memory(void)
+{
+	int ret;
+
+	ret = blocking_notifier_call_chain(&tdx_memory_reset_chain, 0, NULL);
+
+	return notifier_to_errno(ret);
+}
+
 void tdx_reset_memory(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
@@ -1553,18 +1577,15 @@ void tdx_reset_memory(void)
 	native_wbinvd();
 
 	/*
-	 * It's ideal to cover all types of TDX private pages here, but
-	 * currently there's no unified way to tell whether a given page
-	 * is TDX private page or not.
-	 *
-	 * Just convert PAMT pages now, as currently TDX private pages
-	 * can only be PAMT pages.
-	 *
-	 * TODO:
-	 *
-	 * This leaves all other types of TDX private pages undealt
-	 * with.  They must be handled in _some_ way when they become
-	 * possible to exist.
+	 * Tell all in-kernel TDX users to reset TDX private pages
+	 * that they manage.
+	 */
+	if (notify_reset_memory())
+		pr_err("Failed to reset all TDX private pages.\n");
+
+	/*
+	 * The only remaining TDX private pages are PAMT pages.
+	 * Reset them.
 	 */
 	tdmrs_reset_pamt_all(&tdx_tdmr_list);
 }
-- 
2.43.2


