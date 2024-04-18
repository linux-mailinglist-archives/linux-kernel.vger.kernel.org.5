Return-Path: <linux-kernel+bounces-150001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFFF8A98F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D988B220DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5347215FA67;
	Thu, 18 Apr 2024 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FibndAW+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0922A15F3EE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440908; cv=none; b=YyG+mBZCxo7t2k1LIQNKxaIn3/OMTF3iFluCBtj4VwEOxNBtyBQPJBwO0SE3xv3XorprGJW2TBIfc5glEmHS67XVKqzan98O/W1lxO9kd3P+tBvGk8uW3QSW0pZ9sr7mS+AetoM2dubRJed/cPIXo8iwzVzjFQA/vHivnJaF0cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440908; c=relaxed/simple;
	bh=D3XjbZW0yuTOp1ZDBE83DOAAEdGjTbx+zwXrb6aammA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCXKu8mSW7YX7Uy9Kj/wpdJ4H0qrt88FurTnQ/wDnckM+ekL5HWaFLYMHJv+FmRdDjWlLlQYM5ThRkgcOV41bGL2r3lTByQsLZHSLl3j3AKUYuDwW070uS+QU04KGxEaLidOrkEspRKT9frpbFZZPe+muhBn/4gTlds6wl7ivDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FibndAW+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713440907; x=1744976907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D3XjbZW0yuTOp1ZDBE83DOAAEdGjTbx+zwXrb6aammA=;
  b=FibndAW+bivUarsG1C31guf2ETisfjV7FMsf2Z9x234aV1D7dGKD+6uD
   oOaxY6VvY3n96WVEeLrTuiD/dXsjZ/OwuF/ssB3hT0CtWLpgga5xVVju9
   DEk2nsKSgKKQsNAPYlAerolsO8l4WMx3K7pw588rylYZuzH6UlCR0SjWG
   hqR9k6S7H4+cGPekDp7MKRXDzv2Nkwdudbr4DjI2CLAYZQw5vlXTfZGWQ
   jIAuhDcqsMmG7am/Y/9OdCDVfZ+aglt1exgLgEMLhD1+DxQQ6SZJ1g6bw
   SjQ2j6bofqXQoywoF4oJkTf4p4TWO4BImS0jug92rNkdrBG1YIHK9wME8
   g==;
X-CSE-ConnectionGUID: Oovi3EXTQASFWjhRpDBryw==
X-CSE-MsgGUID: aD/S+RUhSPi7a/Val80xIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12769373"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12769373"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:48:27 -0700
X-CSE-ConnectionGUID: aViuX9dzQoGqYb3zXGUE3g==
X-CSE-MsgGUID: zcNjLafuTmyGKK2V/6iDGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23019892"
Received: from vgannu-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.134.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:48:22 -0700
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
Subject: [PATCH v4 2/5] x86/kexec: do unconditional WBINVD for bare-metal in relocate_kernel()
Date: Thu, 18 Apr 2024 23:48:02 +1200
Message-ID: <6cbd40389458acbfdbd2d804da1d363dec06f750.1713439632.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713439632.git.kai.huang@intel.com>
References: <cover.1713439632.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both SME and TDX can leave caches in incoherent state due to memory
encryption.  During kexec, the caches must be flushed before jumping to
the second kernel to avoid silent memory corruption to the second kernel.

During kexec, the WBINVD in stop_this_cpu() flushes caches for all
remote cpus when they are being stopped.  For SME, the WBINVD in
relocate_kernel() flushes the cache for the last running cpu (which is
executing the kexec).

Similarly, to support kexec for TDX host, after stopping all remote cpus
with cache flushed, the kernel needs to flush cache for the last running
cpu.

Use the existing WBINVD in relocate_kernel() to cover TDX host as well.

However, instead of sprinkling around vendor-specific checks, just do
unconditional WBINVD to cover both SME and TDX.  Kexec is not a fast path
so having one additional WBINVD for platforms w/o SME/TDX is acceptable.

But only do WBINVD for bare-metal because TDX guests and SEV-ES/SEV-SNP
guests will get unexpected (and yet unnecessary) exception (#VE or #VC)
which the kernel is unable to handle at this stage.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Young <dyoung@redhat.com>
---

v3 -> v4:
 - Use "exception (#VE or #VC)" for TDX and SEV-ES/SEV-SNP in changelog
   and comments.  (Kirill, Tom)
 - "Save the bare_metal" -> "Save the bare_metal flag" (Tom)
 - Point out "WBINVD is not necessary for TDX and SEV-ES/SEV-SNP guests"
   in the comment.  (Tom)

v2 -> v3:
 - Change to only do WBINVD for bare metal

---
 arch/x86/include/asm/kexec.h         |  2 +-
 arch/x86/kernel/machine_kexec_64.c   |  2 +-
 arch/x86/kernel/relocate_kernel_64.S | 19 +++++++++++++++----
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 91ca9a9ee3a2..455f8a6c66a9 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -128,7 +128,7 @@ relocate_kernel(unsigned long indirection_page,
 		unsigned long page_list,
 		unsigned long start_address,
 		unsigned int preserve_context,
-		unsigned int host_mem_enc_active);
+		unsigned int bare_metal);
 #endif
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index b180d8e497c3..a454477b7b4c 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -358,7 +358,7 @@ void machine_kexec(struct kimage *image)
 				       (unsigned long)page_list,
 				       image->start,
 				       image->preserve_context,
-				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
+				       !boot_cpu_has(X86_FEATURE_HYPERVISOR));
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1bb25f5..6e1590b24e41 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -50,7 +50,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	 * %rsi page_list
 	 * %rdx start address
 	 * %rcx preserve_context
-	 * %r8  host_mem_enc_active
+	 * %r8  bare_metal
 	 */
 
 	/* Save the CPU context, used for jumping back */
@@ -78,7 +78,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	pushq $0
 	popfq
 
-	/* Save SME active flag */
+	/* Save the bare_metal flag */
 	movq	%r8, %r12
 
 	/*
@@ -160,9 +160,20 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%r9, %cr3
 
 	/*
-	 * If SME is active, there could be old encrypted cache line
+	 * The kernel could leave caches in incoherent state on SME/TDX
+	 * capable platforms.  Just do unconditional WBINVD to avoid
+	 * silent memory corruption to the new kernel for these platforms.
+	 *
+	 * For SME, need to flush cache here before copying the kernel.
+	 * When it is active, there could be old encrypted cache line
 	 * entries that will conflict with the now unencrypted memory
-	 * used by kexec. Flush the caches before copying the kernel.
+	 * used by kexec.
+	 *
+	 * Do WBINVD for bare-metal only to cover both SME and TDX.  It
+	 * isn't necessary to perform a WBINVD in a guest and performing
+	 * one could result in an exception (#VE or #VC) for a TDX or
+	 * SEV-ES/SEV-SNP guest that can crash the guest since, at this
+	 * stage, the kernel has torn down the IDT.
 	 */
 	testq	%r12, %r12
 	jz 1f
-- 
2.43.2


