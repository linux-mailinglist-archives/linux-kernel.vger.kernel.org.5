Return-Path: <linux-kernel+bounces-119194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BBA88C559
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33651C62421
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A39813C3FB;
	Tue, 26 Mar 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="So8guPuM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YEZzilfm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D41A13C3DA;
	Tue, 26 Mar 2024 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463976; cv=none; b=EFhdf/YBHwhGA8/P7PjMvJW9O63DAMCJeBAX41W7BitEjt0oRv1KnpcO9Jv0ODHXuXxPeqNHlZT+kXdOHx5XRBiaTdX7pdFlKlNxhiholWEbG+LnQWyowAga0MVuW8LB71kk+btfzUx9myrpTXxcVrJSRpMrD+o71lkFe/KdHaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463976; c=relaxed/simple;
	bh=qGLAbtDkWWaS+W/oUfpte5Y4C8L0mKJ5i6vejJ8zyB0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T9AhU/kJoyDoo1U2pyiyc2aGq5OKG/umZD4nvZ0WnZKAVVzB29pDC+iGNOu0H1cbBC7bGKfUcZN4F2BLnIUFKkyx111Gp5JAadT5Ub8mpYKFswqqPuej4DJwCItD7LhUG4HhBen07yitlaJZ5xHDPdyBuWr+wCrma+sbPnFBtKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=So8guPuM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YEZzilfm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Mar 2024 14:39:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711463972;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q6GHXC7hiXy566G1BZJ9AS8AD6dvjqKl5e6pKBsTWM=;
	b=So8guPuM/rCX954MDPN3WqE2HZrAL0EuvWdsonnjc2iuJ89HMG9ZQQ/jX95i8tsBW24UKG
	xuTSiYa3JES9v2UFV5ptNqvE5V8QrlOmLjBj+HBuhl++g4BgBux6pPpKhUnodd83vn5QAl
	Ywd2mgkgNfWW10n2RhzL4DQeXXHtNKBSTxc5O+lU29fXkXGAZjbD2IATL3evkDsMcWGvAq
	B86EzJN51Wz6vyPQZGi15a7jW1DdcShln8/f15J0bJJ+zC39abZk40HXJAwTI9ZCi55SG5
	Ai0kSBUNpI4gFXc8zmwuOeLEiVf66icEn3fYlaU8HBZJ4Dxr8ecnOb9AAVEQLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711463972;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q6GHXC7hiXy566G1BZJ9AS8AD6dvjqKl5e6pKBsTWM=;
	b=YEZzilfm+iwjtQTjyk/6SqH2zMWAWmFxjfCF5WQirzG2rphkQtFUbgZjitkLKvWY1KOeqo
	mFkYfHgXjclSJuCQ==
From: "tip-bot2 for Kevin Loughlin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Skip ROM range scans and validation for
 SEV-SNP guests
Cc: Kevin Loughlin <kevinloughlin@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240313121546.2964854-1-kevinloughlin@google.com>
References: <20240313121546.2964854-1-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171146397122.10875.6843391527806015227.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0f4a1e80989aca185d955fcd791d7750082044a2
Gitweb:        https://git.kernel.org/tip/0f4a1e80989aca185d955fcd791d7750082044a2
Author:        Kevin Loughlin <kevinloughlin@google.com>
AuthorDate:    Wed, 13 Mar 2024 12:15:46 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 26 Mar 2024 15:22:35 +01:00

x86/sev: Skip ROM range scans and validation for SEV-SNP guests

SEV-SNP requires encrypted memory to be validated before access.
Because the ROM memory range is not part of the e820 table, it is not
pre-validated by the BIOS. Therefore, if a SEV-SNP guest kernel wishes
to access this range, the guest must first validate the range.

The current SEV-SNP code does indeed scan the ROM range during early
boot and thus attempts to validate the ROM range in probe_roms().
However, this behavior is neither sufficient nor necessary for the
following reasons:

* With regards to sufficiency, if EFI_CONFIG_TABLES are not enabled and
  CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
  attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
  falls in the ROM range) prior to validation.

  For example, Project Oak Stage 0 provides a minimal guest firmware
  that currently meets these configuration conditions, meaning guests
  booting atop Oak Stage 0 firmware encounter a problematic call chain
  during dmi_setup() -> dmi_scan_machine() that results in a crash
  during boot if SEV-SNP is enabled.

* With regards to necessity, SEV-SNP guests generally read garbage
  (which changes across boots) from the ROM range, meaning these scans
  are unnecessary. The guest reads garbage because the legacy ROM range
  is unencrypted data but is accessed via an encrypted PMD during early
  boot (where the PMD is marked as encrypted due to potentially mapping
  actually-encrypted data in other PMD-contained ranges).

In one exceptional case, EISA probing treats the ROM range as
unencrypted data, which is inconsistent with other probing.

Continuing to allow SEV-SNP guests to use garbage and to inconsistently
classify ROM range encryption status can trigger undesirable behavior.
For instance, if garbage bytes appear to be a valid signature, memory
may be unnecessarily reserved for the ROM range. Future code or other
use cases may result in more problematic (arbitrary) behavior that
should be avoided.

While one solution would be to overhaul the early PMD mapping to always
treat the ROM region of the PMD as unencrypted, SEV-SNP guests do not
currently rely on data from the ROM region during early boot (and even
if they did, they would be mostly relying on garbage data anyways).

As a simpler solution, skip the ROM range scans (and the otherwise-
necessary range validation) during SEV-SNP guest early boot. The
potential SEV-SNP guest crash due to lack of ROM range validation is
thus avoided by simply not accessing the ROM range.

In most cases, skip the scans by overriding problematic x86_init
functions during sme_early_init() to SNP-safe variants, which can be
likened to x86_init overrides done for other platforms (ex: Xen); such
overrides also avoid the spread of cc_platform_has() checks throughout
the tree.

In the exceptional EISA case, still use cc_platform_has() for the
simplest change, given (1) checks for guest type (ex: Xen domain status)
are already performed here, and (2) these checks occur in a subsys
initcall instead of an x86_init function.

  [ bp: Massage commit message, remove "we"s. ]

Fixes: 9704c07bf9f7 ("x86/kernel: Validate ROM memory before accessing when SEV-SNP is active")
Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20240313121546.2964854-1-kevinloughlin@google.com
---
 arch/x86/include/asm/sev.h      |  4 ++--
 arch/x86/include/asm/x86_init.h |  3 ++-
 arch/x86/kernel/eisa.c          |  3 ++-
 arch/x86/kernel/probe_roms.c    | 10 ----------
 arch/x86/kernel/setup.c         |  3 +--
 arch/x86/kernel/sev.c           | 27 ++++++++++++---------------
 arch/x86/kernel/x86_init.c      |  2 ++
 arch/x86/mm/mem_encrypt_amd.c   | 18 ++++++++++++++++++
 8 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9477b40..07e125f 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -218,12 +218,12 @@ void early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 				  unsigned long npages);
 void early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 				 unsigned long npages);
-void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __noreturn snp_abort(void);
+void snp_dmi_setup(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
@@ -244,12 +244,12 @@ static inline void __init
 early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
 static inline void __init
 early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
-static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
+static inline void snp_dmi_setup(void) { }
 static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
 {
 	return -ENOTTY;
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index b89b40f..6149eab 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -30,12 +30,13 @@ struct x86_init_mpparse {
  * @reserve_resources:		reserve the standard resources for the
  *				platform
  * @memory_setup:		platform specific memory setup
- *
+ * @dmi_setup:			platform specific DMI setup
  */
 struct x86_init_resources {
 	void (*probe_roms)(void);
 	void (*reserve_resources)(void);
 	char *(*memory_setup)(void);
+	void (*dmi_setup)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
index e963344..53935b4 100644
--- a/arch/x86/kernel/eisa.c
+++ b/arch/x86/kernel/eisa.c
@@ -2,6 +2,7 @@
 /*
  * EISA specific code
  */
+#include <linux/cc_platform.h>
 #include <linux/ioport.h>
 #include <linux/eisa.h>
 #include <linux/io.h>
@@ -12,7 +13,7 @@ static __init int eisa_bus_probe(void)
 {
 	void __iomem *p;
 
-	if (xen_pv_domain() && !xen_initial_domain())
+	if ((xen_pv_domain() && !xen_initial_domain()) || cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return 0;
 
 	p = ioremap(0x0FFFD9, 4);
diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
index 319fef3..cc2c34b 100644
--- a/arch/x86/kernel/probe_roms.c
+++ b/arch/x86/kernel/probe_roms.c
@@ -203,16 +203,6 @@ void __init probe_roms(void)
 	unsigned char c;
 	int i;
 
-	/*
-	 * The ROM memory range is not part of the e820 table and is therefore not
-	 * pre-validated by BIOS. The kernel page table maps the ROM region as encrypted
-	 * memory, and SNP requires encrypted memory to be validated before access.
-	 * Do that here.
-	 */
-	snp_prep_memory(video_rom_resource.start,
-			((system_rom_resource.end + 1) - video_rom_resource.start),
-			SNP_PAGE_STATE_PRIVATE);
-
 	/* video rom */
 	upper = adapter_rom_resources[0].start;
 	for (start = video_rom_resource.start; start < upper; start += 2048) {
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index ef20650..0109e6c 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -9,7 +9,6 @@
 #include <linux/console.h>
 #include <linux/crash_dump.h>
 #include <linux/dma-map-ops.h>
-#include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/ima.h>
 #include <linux/init_ohci1394_dma.h>
@@ -902,7 +901,7 @@ void __init setup_arch(char **cmdline_p)
 		efi_init();
 
 	reserve_ibft_region();
-	dmi_setup();
+	x86_init.resources.dmi_setup();
 
 	/*
 	 * VMware detection requires dmi to be available, so this
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b59b09c..7e1e63c 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/psp-sev.h>
+#include <linux/dmi.h>
 #include <uapi/linux/sev-guest.h>
 
 #include <asm/init.h>
@@ -795,21 +796,6 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
 }
 
-void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
-{
-	unsigned long vaddr, npages;
-
-	vaddr = (unsigned long)__va(paddr);
-	npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
-
-	if (op == SNP_PAGE_STATE_PRIVATE)
-		early_snp_set_memory_private(vaddr, paddr, npages);
-	else if (op == SNP_PAGE_STATE_SHARED)
-		early_snp_set_memory_shared(vaddr, paddr, npages);
-	else
-		WARN(1, "invalid memory op %d\n", op);
-}
-
 static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 				       unsigned long vaddr_end, int op)
 {
@@ -2136,6 +2122,17 @@ void __head __noreturn snp_abort(void)
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
 
+/*
+ * SEV-SNP guests should only execute dmi_setup() if EFI_CONFIG_TABLES are
+ * enabled, as the alternative (fallback) logic for DMI probing in the legacy
+ * ROM region can cause a crash since this region is not pre-validated.
+ */
+void __init snp_dmi_setup(void)
+{
+	if (efi_enabled(EFI_CONFIG_TABLES))
+		dmi_setup();
+}
+
 static void dump_cpuid_table(void)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a42830d..d5dc5a9 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -3,6 +3,7 @@
  *
  *  For licencing details see kernel-base/COPYING
  */
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/export.h>
@@ -66,6 +67,7 @@ struct x86_init_ops x86_init __initdata = {
 		.probe_roms		= probe_roms,
 		.reserve_resources	= reserve_standard_io_resources,
 		.memory_setup		= e820__memory_setup_default,
+		.dmi_setup		= dmi_setup,
 	},
 
 	.mpparse = {
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 70b91de..422602f 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -492,6 +492,24 @@ void __init sme_early_init(void)
 	 */
 	if (sev_status & MSR_AMD64_SEV_ENABLED)
 		ia32_disable();
+
+	/*
+	 * Override init functions that scan the ROM region in SEV-SNP guests,
+	 * as this memory is not pre-validated and would thus cause a crash.
+	 */
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
+		x86_init.mpparse.find_mptable = x86_init_noop;
+		x86_init.pci.init_irq = x86_init_noop;
+		x86_init.resources.probe_roms = x86_init_noop;
+
+		/*
+		 * DMI setup behavior for SEV-SNP guests depends on
+		 * efi_enabled(EFI_CONFIG_TABLES), which hasn't been
+		 * parsed yet. snp_dmi_setup() will run after that
+		 * parsing has happened.
+		 */
+		x86_init.resources.dmi_setup = snp_dmi_setup;
+	}
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)

