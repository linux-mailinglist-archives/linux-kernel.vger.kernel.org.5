Return-Path: <linux-kernel+bounces-55273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F2684BA1E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B57B30AF4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07161339AB;
	Tue,  6 Feb 2024 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TkasSpuj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MRtDDbZe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32DA13341A;
	Tue,  6 Feb 2024 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234397; cv=none; b=FwDRNAsh15m4lJ6b+N1qiwsLv15KW+w2dRK477jhBGxhSWUSiiTzWCtkG4jH9X2qz0wfg3YmBzEa0bjnbGzm9A7MqChEjSjJEbb6Y6VH+RO4LLQSg9RZhgORl6wxaebJJ/zogWnYra+FwSZuFcW1lXSxR/2wzhkcwhzajy8fjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234397; c=relaxed/simple;
	bh=SEdns8smKMGR5dhngyDhyIEnCtDt7MMyHzlgKHDW3+0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RZSzxu9rdCzIdQBcjdeGGLJzfXGYNSp5ep1Hf7j9pUD6jlBiPpjHmoBPJAvx7vfI4mIsGrdh9sH/QcUSfRy2GN5a0UVi6ZVGzrK8p6IcM95ZizOdZpaoWHv1XZUXTA0CGnKhoD+U9wj9zlIZhfktyAcLeiJl/+g6CGVQ/AuEybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TkasSpuj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MRtDDbZe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 Feb 2024 15:46:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707234393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zM41oB1Pf2A6ttloJasxcrcys5oQ/ucDuSO7nHCkIJM=;
	b=TkasSpujSwxYfsBjrfro6u75kefs6NY/PI+0feZzGIrWlx6p2bbcie6vjAIP1AkB59vjHR
	v7275Ak/647+xm5yLkB+cNN70TnhEt7yM7mGp19/ufc67BIKIKXh4qKHWAyHxb4K7HzTin
	DOrLNMVb1msnrtHb6/x4AgNFpZxAMoCssH6o0Q4iEk8IgWiwsS0P6qbFhgX78WdP+1sqfb
	BxE1VB7YnCbHsaMnCEgtCtgLc88kQeBgTelk5p60IAHBnqxbEQPo/SNc7BYGWTUdkONXkn
	Xqm6rrPTalxRNGo2Jtu7GV8cvaHhYdIKaNJkTqC7VO6EekhoavqgvET6jUhU7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707234393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zM41oB1Pf2A6ttloJasxcrcys5oQ/ucDuSO7nHCkIJM=;
	b=MRtDDbZeJWWVqkHxBWzrd39GejLtCJsNg7n83JH1ZIPjwwG95Iw1X9lpw4/tVqE4xlVU6D
	WWk2580MLo7eUxCA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Fix position dependent variable references in
 startup code
Cc: Kevin Loughlin <kevinloughlin@google.com>,
 Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
  <stable@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240130220845.1978329-1-kevinloughlin@google.com>
References: <20240130220845.1978329-1-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170723439231.398.15349370352197964831.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     1c811d403afd73f04bde82b83b24c754011bd0e8
Gitweb:        https://git.kernel.org/tip/1c811d403afd73f04bde82b83b24c754011bd0e8
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sat, 03 Feb 2024 13:53:06 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 06 Feb 2024 16:38:42 +01:00

x86/sev: Fix position dependent variable references in startup code

The early startup code executes from a 1:1 mapping of memory, which
differs from the mapping that the code was linked and/or relocated to
run at. The latter mapping is not active yet at this point, and so
symbol references that rely on it will fault.

Given that the core kernel is built without -fPIC, symbol references are
typically emitted as absolute, and so any such references occuring in
the early startup code will therefore crash the kernel.

While an attempt was made to work around this for the early SEV/SME
startup code, by forcing RIP-relative addressing for certain global
SEV/SME variables via inline assembly (see snp_cpuid_get_table() for
example), RIP-relative addressing must be pervasively enforced for
SEV/SME global variables when accessed prior to page table fixups.

__startup_64() already handles this issue for select non-SEV/SME global
variables using fixup_pointer(), which adjusts the pointer relative to a
`physaddr` argument. To avoid having to pass around this `physaddr`
argument across all functions needing to apply pointer fixups, introduce
a macro RIP_RELATIVE_REF() which generates a RIP-relative reference to
a given global variable. It is used where necessary to force
RIP-relative accesses to global variables.

For backporting purposes, this patch makes no attempt at cleaning up
other occurrences of this pattern, involving either inline asm or
fixup_pointer(). Those will be addressed later.

  [ bp: Call it "rip_rel_ref" everywhere like other code shortens
    "rIP-relative reference" and make the asm wrapper __always_inline. ]

Co-developed-by: Kevin Loughlin <kevinloughlin@google.com>
Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/all/20240130220845.1978329-1-kevinloughlin@google.com
---
 arch/x86/coco/core.c               |  7 +------
 arch/x86/include/asm/asm.h         | 14 ++++++++++++++
 arch/x86/include/asm/coco.h        |  8 +++++++-
 arch/x86/include/asm/mem_encrypt.h | 15 +++++++++------
 arch/x86/kernel/sev-shared.c       | 12 ++++++------
 arch/x86/kernel/sev.c              |  4 ++--
 arch/x86/mm/mem_encrypt_identity.c | 27 ++++++++++++---------------
 7 files changed, 51 insertions(+), 36 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index eeec998..d07be9d 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -14,7 +14,7 @@
 #include <asm/processor.h>
 
 enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
-static u64 cc_mask __ro_after_init;
+u64 cc_mask __ro_after_init;
 
 static bool noinstr intel_cc_platform_has(enum cc_attr attr)
 {
@@ -148,8 +148,3 @@ u64 cc_mkdec(u64 val)
 	}
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
-
-__init void cc_set_mask(u64 mask)
-{
-	cc_mask = mask;
-}
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index fbcfec4..ca8eed1 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -113,6 +113,20 @@
 
 #endif
 
+#ifndef __ASSEMBLY__
+#ifndef __pic__
+static __always_inline __pure void *rip_rel_ptr(void *p)
+{
+	asm("leaq %c1(%%rip), %0" : "=r"(p) : "i"(p));
+
+	return p;
+}
+#define RIP_REL_REF(var)	(*(typeof(&(var)))rip_rel_ptr(&(var)))
+#else
+#define RIP_REL_REF(var)	(var)
+#endif
+#endif
+
 /*
  * Macros to generate condition code outputs from inline assembly,
  * The output operand must be type "bool".
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 6ae2d16..21940ef 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_COCO_H
 #define _ASM_X86_COCO_H
 
+#include <asm/asm.h>
 #include <asm/types.h>
 
 enum cc_vendor {
@@ -11,9 +12,14 @@ enum cc_vendor {
 };
 
 extern enum cc_vendor cc_vendor;
+extern u64 cc_mask;
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-void cc_set_mask(u64 mask);
+static inline void cc_set_mask(u64 mask)
+{
+	RIP_REL_REF(cc_mask) = mask;
+}
+
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
 #else
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 359ada4..b31eb9f 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -15,7 +15,8 @@
 #include <linux/init.h>
 #include <linux/cc_platform.h>
 
-#include <asm/bootparam.h>
+#include <asm/asm.h>
+struct boot_params;
 
 #ifdef CONFIG_X86_MEM_ENCRYPT
 void __init mem_encrypt_init(void);
@@ -58,6 +59,11 @@ void __init mem_encrypt_free_decrypted_mem(void);
 
 void __init sev_es_init_vc_handling(void);
 
+static inline u64 sme_get_me_mask(void)
+{
+	return RIP_REL_REF(sme_me_mask);
+}
+
 #define __bss_decrypted __section(".bss..decrypted")
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
@@ -89,6 +95,8 @@ early_set_mem_enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool en
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
 
+static inline u64 sme_get_me_mask(void) { return 0; }
+
 #define __bss_decrypted
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
@@ -106,11 +114,6 @@ void add_encrypt_protection_map(void);
 
 extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
 
-static inline u64 sme_get_me_mask(void)
-{
-	return sme_me_mask;
-}
-
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 5db24d0..ae79f95 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -560,9 +560,9 @@ static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_le
 		leaf->eax = leaf->ebx = leaf->ecx = leaf->edx = 0;
 
 		/* Skip post-processing for out-of-range zero leafs. */
-		if (!(leaf->fn <= cpuid_std_range_max ||
-		      (leaf->fn >= 0x40000000 && leaf->fn <= cpuid_hyp_range_max) ||
-		      (leaf->fn >= 0x80000000 && leaf->fn <= cpuid_ext_range_max)))
+		if (!(leaf->fn <= RIP_REL_REF(cpuid_std_range_max) ||
+		      (leaf->fn >= 0x40000000 && leaf->fn <= RIP_REL_REF(cpuid_hyp_range_max)) ||
+		      (leaf->fn >= 0x80000000 && leaf->fn <= RIP_REL_REF(cpuid_ext_range_max))))
 			return 0;
 	}
 
@@ -1072,11 +1072,11 @@ static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
 
 		if (fn->eax_in == 0x0)
-			cpuid_std_range_max = fn->eax;
+			RIP_REL_REF(cpuid_std_range_max) = fn->eax;
 		else if (fn->eax_in == 0x40000000)
-			cpuid_hyp_range_max = fn->eax;
+			RIP_REL_REF(cpuid_hyp_range_max) = fn->eax;
 		else if (fn->eax_in == 0x80000000)
-			cpuid_ext_range_max = fn->eax;
+			RIP_REL_REF(cpuid_ext_range_max) = fn->eax;
 	}
 }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 002af6c..1ef7ae8 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -748,7 +748,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	 * This eliminates worries about jump tables or checking boot_cpu_data
 	 * in the cc_platform_has() function.
 	 */
-	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
 	 /*
@@ -767,7 +767,7 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	 * This eliminates worries about jump tables or checking boot_cpu_data
 	 * in the cc_platform_has() function.
 	 */
-	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index efe9f21..0166ab1 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -304,7 +304,8 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
 	 * function.
 	 */
-	if (!sme_get_me_mask() || sev_status & MSR_AMD64_SEV_ENABLED)
+	if (!sme_get_me_mask() ||
+	    RIP_REL_REF(sev_status) & MSR_AMD64_SEV_ENABLED)
 		return;
 
 	/*
@@ -541,11 +542,11 @@ void __init sme_enable(struct boot_params *bp)
 	me_mask = 1UL << (ebx & 0x3f);
 
 	/* Check the SEV MSR whether SEV or SME is enabled */
-	sev_status   = __rdmsr(MSR_AMD64_SEV);
-	feature_mask = (sev_status & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
+	RIP_REL_REF(sev_status) = msr = __rdmsr(MSR_AMD64_SEV);
+	feature_mask = (msr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
 	/* The SEV-SNP CC blob should never be present unless SEV-SNP is enabled. */
-	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+	if (snp && !(msr & MSR_AMD64_SEV_SNP_ENABLED))
 		snp_abort();
 
 	/* Check if memory encryption is enabled */
@@ -571,7 +572,6 @@ void __init sme_enable(struct boot_params *bp)
 			return;
 	} else {
 		/* SEV state cannot be controlled by a command line option */
-		sme_me_mask = me_mask;
 		goto out;
 	}
 
@@ -590,16 +590,13 @@ void __init sme_enable(struct boot_params *bp)
 	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
 				     ((u64)bp->ext_cmd_line_ptr << 32));
 
-	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
-		goto out;
-
-	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
-		sme_me_mask = me_mask;
+	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0 ||
+	    strncmp(buffer, cmdline_on, sizeof(buffer)))
+		return;
 
 out:
-	if (sme_me_mask) {
-		physical_mask &= ~sme_me_mask;
-		cc_vendor = CC_VENDOR_AMD;
-		cc_set_mask(sme_me_mask);
-	}
+	RIP_REL_REF(sme_me_mask) = me_mask;
+	physical_mask &= ~me_mask;
+	cc_vendor = CC_VENDOR_AMD;
+	cc_set_mask(me_mask);
 }

