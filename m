Return-Path: <linux-kernel+bounces-24110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EECC382B72C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4F51F25210
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E25FC16;
	Thu, 11 Jan 2024 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/LsICzv"
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD4DDDD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-35fe765d63eso30215635ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705012615; x=1705617415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lczn+93s43xycbOUg1tjz5/Z/zIwNlBLG84sXxBI1vc=;
        b=q/LsICzvQIUUesLs/W7TeQyAN7p2EPpUCT4Gom1piRQG+mz64iCbdZV1ZYUK/JfG4d
         T5J5r4SUTnq3HaQOtatg8OJaTLPwvKPzPTCMinVtfgcBAq6bPCVj8Po6XUH2+oyC0Hbm
         xNEALxp/E5PvHsVJUvAo5UunlK1xBr5jjciZ8nVamlPbNIcm0qmbdCm6OIhbe6Rv4IK5
         7ctL1T+voKiaIVBic9qS/k7GEcM1WY9hW0gliOfer2+HuBvRH5zOpKXjCmGRbjGnuyy7
         YeXhviGuftcNzsddlFEFla9jVyLOB6PWaZnVb/hM/iipg2uDIWynFLh/GpsO7et3BzYv
         V2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705012615; x=1705617415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lczn+93s43xycbOUg1tjz5/Z/zIwNlBLG84sXxBI1vc=;
        b=GEIpuWTtkRvoKHdYfoIuDSk69bG6KMe5z27s+aG/0z8YYiAN0C4FEM5CCDiokLcSKe
         ETxWR2kCHssa04ChcnLFbF3QmFNAU3gmbyrjRzp3xW01rOoESuX56ZPXZb9LAqwjXRlv
         om1QtkZ3B6vShWsL/DubS9ba0MZLluYHrFxRBSNH3fRX4avIs+FnI+YvKH0/ftgRJocZ
         hXK9CRFR/n+scuZaaCLRYeFRkkT62rcknlK1mNCJJHdcDcj8lfLtj0QIKdh0Sh4arN1A
         vwZjgPeU+xhS6TtvM9RPY/VZZJwTXAvLmwfeEHlXhUpLl35Vo5tAomf5KaAKwqU6221X
         dNAQ==
X-Gm-Message-State: AOJu0YwExYqRTUZotlfC6Qpq1rJkIcFATDxDB7Avj1l/OIX8jIolOgOw
	pOJRVZGX1N/O+OvhJjvplN8ZPjoqayoUOOZafWpAEmeuglo=
X-Google-Smtp-Source: AGHT+IE9G10UZqiKCF//ORs9+mSiFte53u+DD+bCNQWkWjXXdqCOytQJCId7DmHVBmf6hSyIeFawQFEr8UUo2Bq+cNUU
X-Received: from loughlin00.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b6f])
 (user=kevinloughlin job=sendgmr) by 2002:a05:6e02:18cd:b0:35f:cca8:cd54 with
 SMTP id s13-20020a056e0218cd00b0035fcca8cd54mr90119ilu.2.1705012615662; Thu,
 11 Jan 2024 14:36:55 -0800 (PST)
Date: Thu, 11 Jan 2024 22:36:50 +0000
In-Reply-To: <ZZ7YuEexYSaZYmLK@tassilo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZZ7YuEexYSaZYmLK@tassilo>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111223650.3502633-1-kevinloughlin@google.com>
Subject: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
From: Kevin Loughlin <kevinloughlin@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Kelley <mikelley@microsoft.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Pankaj Gupta <pankaj.gupta@amd.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Steve Rutherford <srutherford@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Wang Jinchao <wangjinchao@xfusion.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Brian Gerst <brgerst@gmail.com>, Hugh Dickins <hughd@google.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Joerg Roedel <jroedel@suse.de>, Randy Dunlap <rdunlap@infradead.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-coco@lists.linux.dev, 
	Ashish Kalra <ashish.kalra@amd.com>, Andi Kleen <ak@linux.intel.com>
Cc: Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, 
	Jacob Xu <jacobhxu@google.com>, Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"

SEV/SME code can execute prior to page table fixups for kernel
relocation. However, as with global variables accessed in
__startup_64(), the compiler is not required to generate RIP-relative
accesses for SEV/SME global variables, causing certain flavors of SEV
hosts and guests built with clang to crash during boot.

While an attempt was made to force RIP-relative addressing for certain
global SEV/SME variables via inline assembly (see snp_cpuid_get_table()
for example), RIP-relative addressing must be pervasively-enforced for
SEV/SME global variables when accessed prior to page table fixups.

__startup_64() already handles this issue for select non-SEV/SME global
variables using fixup_pointer(), which adjusts the pointer relative to
a `physaddr` argument. To avoid having to pass around this `physaddr`
argument across all functions needing to apply pointer fixups, this
patch introduces the macro GET_RIP_RELATIVE_PTR() (an abstraction of
the existing snp_cpuid_get_table()), which generates an RIP-relative
pointer to a passed variable. Similarly, PTR_TO_RIP_RELATIVE_PTR() is
introduced to fixup an existing pointer value with RIP-relative logic.

Applying these macros to early SEV/SME code (alongside Adam Dunlap's
necessary "[PATCH v2] x86/asm: Force native_apic_mem_read to use mov")
enables previously-failing boots of clang builds to succeed, while
preserving successful boot of gcc builds. Tested with and without SEV,
SEV-ES, SEV-SNP enabled in guests built via both gcc and clang.

Fixes: 95d33bfaa3e1 ("x86/sev: Register GHCB memory when SEV-SNP is active")
Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
Fixes: 1cd9c22fee3a ("x86/mm/encrypt: Move page table helpers into separate translation unit")
Fixes: c9f09539e16e ("x86/head/64: Check SEV encryption before switching to kernel page-table")
Fixes: b577f542f93c ("x86/coco: Add API to handle encryption mask")
Tested-by: Kevin Loughlin <kevinloughlin@google.com>
Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 arch/x86/coco/core.c               | 22 +++++++----
 arch/x86/include/asm/mem_encrypt.h | 37 +++++++++++++++++-
 arch/x86/kernel/head64.c           | 22 ++++++-----
 arch/x86/kernel/head_64.S          |  4 +-
 arch/x86/kernel/sev-shared.c       | 63 ++++++++++++++++--------------
 arch/x86/kernel/sev.c              | 15 +++++--
 arch/x86/mm/mem_encrypt_identity.c | 50 ++++++++++++------------
 7 files changed, 136 insertions(+), 77 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index eeec9986570e..8c45b5643f48 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -5,6 +5,11 @@
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ *
+ * WARNING!!
+ * Select functions in this file can execute prior to page table fixups and thus
+ * require pointer fixups for global variable accesses. See WARNING in
+ * arch/x86/kernel/head64.c.
  */
 
 #include <linux/export.h>
@@ -61,33 +66,34 @@ static __maybe_unused __always_inline bool amd_cc_platform_vtom(enum cc_attr att
 static bool noinstr amd_cc_platform_has(enum cc_attr attr)
 {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
+	const u64 sev_status_fixed_up = sev_get_status_fixup();
 
-	if (sev_status & MSR_AMD64_SNP_VTOM)
+	if (sev_status_fixed_up & MSR_AMD64_SNP_VTOM)
 		return amd_cc_platform_vtom(attr);
 
 	switch (attr) {
 	case CC_ATTR_MEM_ENCRYPT:
-		return sme_me_mask;
+		return sme_get_me_mask_fixup();
 
 	case CC_ATTR_HOST_MEM_ENCRYPT:
-		return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENABLED);
+		return sme_get_me_mask_fixup() && !(sev_status_fixed_up & MSR_AMD64_SEV_ENABLED);
 
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
-		return sev_status & MSR_AMD64_SEV_ENABLED;
+		return sev_status_fixed_up & MSR_AMD64_SEV_ENABLED;
 
 	case CC_ATTR_GUEST_STATE_ENCRYPT:
-		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
+		return sev_status_fixed_up & MSR_AMD64_SEV_ES_ENABLED;
 
 	/*
 	 * With SEV, the rep string I/O instructions need to be unrolled
 	 * but SEV-ES supports them through the #VC handler.
 	 */
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
-		return (sev_status & MSR_AMD64_SEV_ENABLED) &&
-			!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
+		return (sev_status_fixed_up & MSR_AMD64_SEV_ENABLED) &&
+			!(sev_status_fixed_up & MSR_AMD64_SEV_ES_ENABLED);
 
 	case CC_ATTR_GUEST_SEV_SNP:
-		return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
+		return sev_status_fixed_up & MSR_AMD64_SEV_SNP_ENABLED;
 
 	default:
 		return false;
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 359ada486fa9..d007050a0edc 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -17,6 +17,34 @@
 
 #include <asm/bootparam.h>
 
+/*
+ * Generates an RIP-relative pointer to a data variable "var".
+ * This macro can be used to safely access global data variables prior to kernel
+ * relocation, similar to fixup_pointer() in arch/x86/kernel/head64.c.
+ */
+#define GET_RIP_RELATIVE_PTR(var)	\
+({					\
+	void *rip_rel_ptr;		\
+	asm ("lea "#var"(%%rip), %0"	\
+		: "=r" (rip_rel_ptr)	\
+		: "p" (&var));		\
+	rip_rel_ptr;			\
+})
+
+/*
+ * Converts an existing pointer "ptr" to an RIP-relative pointer.
+ * This macro can be used to safely access global pointers prior to kernel
+ * relocation, similar to fixup_pointer() in arch/x86/kernel/head64.c.
+ */
+#define PTR_TO_RIP_RELATIVE_PTR(ptr)	\
+({					\
+	void *rip_rel_ptr;		\
+	asm ("lea "#ptr"(%%rip), %0"	\
+		: "=r" (rip_rel_ptr)	\
+		: "p" (ptr));		\
+	rip_rel_ptr;			\
+})
+
 #ifdef CONFIG_X86_MEM_ENCRYPT
 void __init mem_encrypt_init(void);
 void __init mem_encrypt_setup_arch(void);
@@ -106,9 +134,14 @@ void add_encrypt_protection_map(void);
 
 extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
 
-static inline u64 sme_get_me_mask(void)
+static inline u64 sme_get_me_mask_fixup(void)
+{
+	return *((u64 *) GET_RIP_RELATIVE_PTR(sme_me_mask));
+}
+
+static inline u64 sev_get_status_fixup(void)
 {
-	return sme_me_mask;
+	return *((u64 *) GET_RIP_RELATIVE_PTR(sev_status));
 }
 
 #endif	/* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index dc0956067944..8df7a198094d 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -130,6 +130,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 {
 	unsigned long vaddr, vaddr_end;
 	int i;
+	const u64 sme_me_mask_fixed_up = sme_get_me_mask_fixup();
 
 	/* Encrypt the kernel and related (if SME is active) */
 	sme_encrypt_kernel(bp);
@@ -140,7 +141,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	 * there is no need to zero it after changing the memory encryption
 	 * attribute.
 	 */
-	if (sme_get_me_mask()) {
+	if (sme_me_mask_fixed_up) {
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
 
@@ -158,7 +159,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
 
 			i = pmd_index(vaddr);
-			pmd[i] -= sme_get_me_mask();
+			pmd[i] -= sme_me_mask_fixed_up;
 		}
 	}
 
@@ -166,14 +167,16 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	 * Return the SME encryption mask (if SME is active) to be used as a
 	 * modifier for the initial pgdir entry programmed into CR3.
 	 */
-	return sme_get_me_mask();
+	return sme_me_mask_fixed_up;
 }
 
-/* Code in __startup_64() can be relocated during execution, but the compiler
+/*
+ * WARNING!!
+ * Code in __startup_64() can be relocated during execution, but the compiler
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
  * boot-time crashes. To work around this problem, every global pointer must
- * be adjusted using fixup_pointer().
+ * be adjusted using fixup_pointer() or GET_RIP_RELATIVE_PTR().
  */
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
@@ -188,6 +191,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	bool la57;
 	int i;
 	unsigned int *next_pgt_ptr;
+	const u64 sme_me_mask_fixed_up = sme_get_me_mask_fixup();
 
 	la57 = check_la57_support(physaddr);
 
@@ -206,7 +210,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 		for (;;);
 
 	/* Include the SME encryption mask in the fixup value */
-	load_delta += sme_get_me_mask();
+	load_delta += sme_me_mask_fixed_up;
 
 	/* Fixup the physical addresses in the page table */
 
@@ -242,7 +246,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pud = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
 	pmd = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
 
-	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
+	pgtable_flags = _KERNPG_TABLE_NOENC + sme_me_mask_fixed_up;
 
 	if (la57) {
 		p4d = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++],
@@ -269,7 +273,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
 	mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
 	pmd_entry &= *mask_ptr;
-	pmd_entry += sme_get_me_mask();
+	pmd_entry += sme_me_mask_fixed_up;
 	pmd_entry +=  physaddr;
 
 	for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
@@ -313,7 +317,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Fixup phys_base - remove the memory encryption mask to obtain
 	 * the true physical address.
 	 */
-	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
+	*fixup_long(&phys_base, physaddr) += load_delta - sme_me_mask_fixed_up;
 
 	return sme_postprocess_startup(bp, pmd);
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d4918d03efb4..b9e52cee6e00 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -176,9 +176,11 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	/*
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
 	 * added to the initial pgdir entry that will be programmed into CR3.
+	 * Since we may have not completed page table fixups, use RIP-relative
+	 * addressing for sme_me_mask.
 	 */
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	movq	sme_me_mask, %rax
+	movq	sme_me_mask(%rip), %rax
 #else
 	xorq	%rax, %rax
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 1d24ec679915..e71752c990ef 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -7,6 +7,11 @@
  * This file is not compiled stand-alone. It contains code shared
  * between the pre-decompression boot code and the running Linux kernel
  * and is included directly into both code-bases.
+ *
+ * WARNING!!
+ * Select functions in this file can execute prior to page table fixups and thus
+ * require pointer fixups for global variable accesses. See WARNING in
+ * arch/x86/kernel/head64.c.
  */
 
 #ifndef __BOOT_COMPRESSED
@@ -110,8 +115,9 @@ static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
 static u64 get_hv_features(void)
 {
 	u64 val;
+	const u16 *ghcb_version_ptr = (const u16 *) GET_RIP_RELATIVE_PTR(ghcb_version);
 
-	if (ghcb_version < 2)
+	if (*ghcb_version_ptr < 2)
 		return 0;
 
 	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
@@ -143,6 +149,7 @@ static void snp_register_ghcb_early(unsigned long paddr)
 static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
+	u16 *ghcb_version_ptr;
 
 	/* Do the GHCB protocol version negotiation */
 	sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
@@ -156,7 +163,8 @@ static bool sev_es_negotiate_protocol(void)
 	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
 		return false;
 
-	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
+	ghcb_version_ptr = (u16 *) GET_RIP_RELATIVE_PTR(ghcb_version);
+	*ghcb_version_ptr = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
 
 	return true;
 }
@@ -318,23 +326,6 @@ static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid
 		    : __sev_cpuid_hv_msr(leaf);
 }
 
-/*
- * This may be called early while still running on the initial identity
- * mapping. Use RIP-relative addressing to obtain the correct address
- * while running with the initial identity mapping as well as the
- * switch-over to kernel virtual addresses later.
- */
-static const struct snp_cpuid_table *snp_cpuid_get_table(void)
-{
-	void *ptr;
-
-	asm ("lea cpuid_table_copy(%%rip), %0"
-	     : "=r" (ptr)
-	     : "p" (&cpuid_table_copy));
-
-	return ptr;
-}
-
 /*
  * The SNP Firmware ABI, Revision 0.9, Section 7.1, details the use of
  * XCR0_IN and XSS_IN to encode multiple versions of 0xD subfunctions 0
@@ -357,7 +348,8 @@ static const struct snp_cpuid_table *snp_cpuid_get_table(void)
  */
 static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 {
-	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+	const struct snp_cpuid_table *cpuid_table = (const struct
+		snp_cpuid_table *) GET_RIP_RELATIVE_PTR(cpuid_table_copy);
 	u64 xfeatures_found = 0;
 	u32 xsave_size = 0x240;
 	int i;
@@ -394,7 +386,8 @@ static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 static bool
 snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 {
-	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+	const struct snp_cpuid_table *cpuid_table = (const struct
+		snp_cpuid_table *) GET_RIP_RELATIVE_PTR(cpuid_table_copy);
 	int i;
 
 	for (i = 0; i < cpuid_table->count; i++) {
@@ -530,7 +523,9 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
  */
 static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
-	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+	const struct snp_cpuid_table *cpuid_table = (const struct
+		snp_cpuid_table *) GET_RIP_RELATIVE_PTR(cpuid_table_copy);
+	const u32 *cpuid_std_range_max_ptr, *cpuid_hyp_range_max_ptr, *cpuid_ext_range_max_ptr;
 
 	if (!cpuid_table->count)
 		return -EOPNOTSUPP;
@@ -555,10 +550,14 @@ static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_le
 		 */
 		leaf->eax = leaf->ebx = leaf->ecx = leaf->edx = 0;
 
+		cpuid_std_range_max_ptr = (const u32 *) GET_RIP_RELATIVE_PTR(cpuid_std_range_max);
+		cpuid_hyp_range_max_ptr = (const u32 *) GET_RIP_RELATIVE_PTR(cpuid_hyp_range_max);
+		cpuid_ext_range_max_ptr = (const u32 *) GET_RIP_RELATIVE_PTR(cpuid_ext_range_max);
+
 		/* Skip post-processing for out-of-range zero leafs. */
-		if (!(leaf->fn <= cpuid_std_range_max ||
-		      (leaf->fn >= 0x40000000 && leaf->fn <= cpuid_hyp_range_max) ||
-		      (leaf->fn >= 0x80000000 && leaf->fn <= cpuid_ext_range_max)))
+		if (!(leaf->fn <= *cpuid_std_range_max_ptr ||
+		      (leaf->fn >= 0x40000000 && leaf->fn <= *cpuid_hyp_range_max_ptr) ||
+		      (leaf->fn >= 0x80000000 && leaf->fn <= *cpuid_ext_range_max_ptr)))
 			return 0;
 	}
 
@@ -1046,6 +1045,7 @@ static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
 static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 {
 	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
+	u32 *cpuid_std_range_max_ptr, *cpuid_hyp_range_max_ptr, *cpuid_ext_range_max_ptr;
 	int i;
 
 	if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < PAGE_SIZE)
@@ -1055,19 +1055,24 @@ static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 	if (!cpuid_table_fw->count || cpuid_table_fw->count > SNP_CPUID_COUNT_MAX)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
 
-	cpuid_table = snp_cpuid_get_table();
+	cpuid_table = (const struct snp_cpuid_table *) GET_RIP_RELATIVE_PTR(
+		cpuid_table_copy);
 	memcpy((void *)cpuid_table, cpuid_table_fw, sizeof(*cpuid_table));
 
+	cpuid_std_range_max_ptr = (u32 *) GET_RIP_RELATIVE_PTR(cpuid_std_range_max);
+	cpuid_hyp_range_max_ptr = (u32 *) GET_RIP_RELATIVE_PTR(cpuid_hyp_range_max);
+	cpuid_ext_range_max_ptr = (u32 *) GET_RIP_RELATIVE_PTR(cpuid_ext_range_max);
+
 	/* Initialize CPUID ranges for range-checking. */
 	for (i = 0; i < cpuid_table->count; i++) {
 		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
 
 		if (fn->eax_in == 0x0)
-			cpuid_std_range_max = fn->eax;
+			*cpuid_std_range_max_ptr = fn->eax;
 		else if (fn->eax_in == 0x40000000)
-			cpuid_hyp_range_max = fn->eax;
+			*cpuid_hyp_range_max_ptr = fn->eax;
 		else if (fn->eax_in == 0x80000000)
-			cpuid_ext_range_max = fn->eax;
+			*cpuid_ext_range_max_ptr = fn->eax;
 	}
 }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c67285824e82..c966bc511949 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -5,6 +5,11 @@
  * Copyright (C) 2019 SUSE
  *
  * Author: Joerg Roedel <jroedel@suse.de>
+ *
+ * WARNING!!
+ * Select functions in this file can execute prior to page table fixups and thus
+ * require pointer fixups for global variable accesses. See WARNING in
+ * arch/x86/kernel/head64.c.
  */
 
 #define pr_fmt(fmt)	"SEV: " fmt
@@ -748,7 +753,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	 * This eliminates worries about jump tables or checking boot_cpu_data
 	 * in the cc_platform_has() function.
 	 */
-	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+	if (!(sev_get_status_fixup() & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
 	 /*
@@ -767,7 +772,7 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	 * This eliminates worries about jump tables or checking boot_cpu_data
 	 * in the cc_platform_has() function.
 	 */
-	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+	if (!(sev_get_status_fixup() & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
@@ -2114,7 +2119,8 @@ void __init __noreturn snp_abort(void)
 
 static void dump_cpuid_table(void)
 {
-	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+	const struct snp_cpuid_table *cpuid_table = (const struct
+		snp_cpuid_table *) GET_RIP_RELATIVE_PTR(cpuid_table_copy);
 	int i = 0;
 
 	pr_info("count=%d reserved=0x%x reserved2=0x%llx\n",
@@ -2138,7 +2144,8 @@ static void dump_cpuid_table(void)
  */
 static int __init report_cpuid_table(void)
 {
-	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+	const struct snp_cpuid_table *cpuid_table = (const struct
+		snp_cpuid_table *) GET_RIP_RELATIVE_PTR(cpuid_table_copy);
 
 	if (!cpuid_table->count)
 		return 0;
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index d73aeb16417f..f4c864ea2468 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -5,6 +5,11 @@
  * Copyright (C) 2016 Advanced Micro Devices, Inc.
  *
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ *
+ * WARNING!!
+ * Select functions in this file can execute prior to page table fixups and thus
+ * require pointer fixups for global variable accesses. See WARNING in
+ * arch/x86/kernel/head64.c.
  */
 
 #define DISABLE_BRANCH_PROFILING
@@ -305,7 +310,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
 	 * function.
 	 */
-	if (!sme_get_me_mask() || sev_status & MSR_AMD64_SEV_ENABLED)
+	if (!sme_get_me_mask_fixup() || sev_get_status_fixup() & MSR_AMD64_SEV_ENABLED)
 		return;
 
 	/*
@@ -346,9 +351,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * We're running identity mapped, so we must obtain the address to the
 	 * SME encryption workarea using rip-relative addressing.
 	 */
-	asm ("lea sme_workarea(%%rip), %0"
-	     : "=r" (workarea_start)
-	     : "p" (sme_workarea));
+	workarea_start = (unsigned long) PTR_TO_RIP_RELATIVE_PTR(sme_workarea);
 
 	/*
 	 * Calculate required number of workarea bytes needed:
@@ -511,7 +514,7 @@ void __init sme_enable(struct boot_params *bp)
 	unsigned long me_mask;
 	char buffer[16];
 	bool snp;
-	u64 msr;
+	u64 msr, *sme_me_mask_ptr, *sev_status_ptr;
 
 	snp = snp_init(bp);
 
@@ -542,12 +545,14 @@ void __init sme_enable(struct boot_params *bp)
 
 	me_mask = 1UL << (ebx & 0x3f);
 
+	sev_status_ptr = (u64 *) GET_RIP_RELATIVE_PTR(sev_status);
+
 	/* Check the SEV MSR whether SEV or SME is enabled */
-	sev_status   = __rdmsr(MSR_AMD64_SEV);
-	feature_mask = (sev_status & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
+	*sev_status_ptr   = __rdmsr(MSR_AMD64_SEV);
+	feature_mask = (*sev_status_ptr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
 	/* The SEV-SNP CC blob should never be present unless SEV-SNP is enabled. */
-	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+	if (snp && !(*sev_status_ptr & MSR_AMD64_SEV_SNP_ENABLED))
 		snp_abort();
 
 	/* Check if memory encryption is enabled */
@@ -573,7 +578,8 @@ void __init sme_enable(struct boot_params *bp)
 			return;
 	} else {
 		/* SEV state cannot be controlled by a command line option */
-		sme_me_mask = me_mask;
+		sme_me_mask_ptr = (u64 *) GET_RIP_RELATIVE_PTR(sme_me_mask);
+		*sme_me_mask_ptr = me_mask;
 		goto out;
 	}
 
@@ -582,15 +588,9 @@ void __init sme_enable(struct boot_params *bp)
 	 * identity mapped, so we must obtain the address to the SME command
 	 * line argument data using rip-relative addressing.
 	 */
-	asm ("lea sme_cmdline_arg(%%rip), %0"
-	     : "=r" (cmdline_arg)
-	     : "p" (sme_cmdline_arg));
-	asm ("lea sme_cmdline_on(%%rip), %0"
-	     : "=r" (cmdline_on)
-	     : "p" (sme_cmdline_on));
-	asm ("lea sme_cmdline_off(%%rip), %0"
-	     : "=r" (cmdline_off)
-	     : "p" (sme_cmdline_off));
+	cmdline_arg = (const char *) PTR_TO_RIP_RELATIVE_PTR(sme_cmdline_arg);
+	cmdline_on = (const char *) PTR_TO_RIP_RELATIVE_PTR(sme_cmdline_on);
+	cmdline_off = (const char *) PTR_TO_RIP_RELATIVE_PTR(sme_cmdline_off);
 
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
 		active_by_default = true;
@@ -603,16 +603,18 @@ void __init sme_enable(struct boot_params *bp)
 	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
 		return;
 
+	sme_me_mask_ptr = (u64 *) GET_RIP_RELATIVE_PTR(sme_me_mask);
+
 	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
-		sme_me_mask = me_mask;
+		*sme_me_mask_ptr = me_mask;
 	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
-		sme_me_mask = 0;
+		*sme_me_mask_ptr = 0;
 	else
-		sme_me_mask = active_by_default ? me_mask : 0;
+		*sme_me_mask_ptr = active_by_default ? me_mask : 0;
 out:
-	if (sme_me_mask) {
-		physical_mask &= ~sme_me_mask;
+	if (*sme_me_mask_ptr) {
+		physical_mask &= ~(*sme_me_mask_ptr);
 		cc_vendor = CC_VENDOR_AMD;
-		cc_set_mask(sme_me_mask);
+		cc_set_mask(*sme_me_mask_ptr);
 	}
 }
-- 
2.43.0.275.g3460e3d667-goog


