Return-Path: <linux-kernel+bounces-91348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57791870FDB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6FACB24E61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3542C7F7FA;
	Mon,  4 Mar 2024 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dV43nb2Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ybki8mFq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD77BB0F;
	Mon,  4 Mar 2024 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590145; cv=none; b=ZBgDAZzsDgGzU7vmq2F0zl/RAgII6Z1/oi4Cy8La9Ps0AvFIpnZG0uBELJtSr01yE2TIfLtb45LPHebXWQNBq+axIPGuNhTvCksDAgsQ+4FoirL4+YebvDzrZEpWK2JXD9itacbMbIMQhVcPpt85dwWqOdjGTitomXCI6ezAGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590145; c=relaxed/simple;
	bh=CF8hbqil9PZlwJqxTIu5JG6f3PaIXcHmCJN3T2GOCvg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oPF2l6aPipwP3X3t/ol18cwe2ZIWS3W/cGQ9MH3Hlmeb+TuV7cBGSa2ZeCUwbNo3GVCNNWu/A/guq1uIbol56rnUaz1WBZePgX5wm7jG9wUlClTjhlN9BjIdP3Z4n/tFv/dtig/lXH00Jhdweo7fCuCG6tJF9dXLUN39kxhEXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dV43nb2Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ybki8mFq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 22:09:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709590141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBhe1rfV2aLACSW7hqdYYXmj+4arNOOK06ehn1CN6SA=;
	b=dV43nb2QUX5MCrYAUvK0o91Y2/23yO2xDScKU+1H0j1MVDlQUxQK5gdxsk1Zzkjv+OTmEp
	hxjfnKpYbMnEARK6A/LNzwTQ6beQ8jUP5JiunPJ/rz/OZ32fFGyx1wDgd1kBHkRgKmHGbx
	E/JBGtU/u51+wxAyDuQ9L1LHiPxPbGKf39C/SSeVZsoOqWMddLjsHgE/d32igTgcqSg4dr
	lueqBr6smffKzU45ztAQD+URsgbClQvoztCy7x+TC1cbWDhUZ7YRMskexBzAn5DuAw5IKl
	TUcXmjb2hH7y05hMuQr2eyTDkAIplaIced6WVyeKVV9fhaXTtB7m118ByPLdeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709590141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBhe1rfV2aLACSW7hqdYYXmj+4arNOOK06ehn1CN6SA=;
	b=ybki8mFqCjGCYKOcbOVgRHi0bOR/40WYml3Y9r5nv8cv4H2uUxCvcV5dwlutGfnQ78diFh
	J67CoYWpXDG9q0Bg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot: Move mem_encrypt= parsing to the decompressor
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240227151907.387873-17-ardb+git@google.com>
References: <20240227151907.387873-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170959014065.398.8801905697203252339.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     cd0d9d92c8bb46e77de62efd7df13069ddd61e7d
Gitweb:        https://git.kernel.org/tip/cd0d9d92c8bb46e77de62efd7df13069ddd61e7d
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 27 Feb 2024 16:19:14 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 04 Mar 2024 18:12:28 +01:00

x86/boot: Move mem_encrypt= parsing to the decompressor

The early SME/SEV code parses the command line very early, in order to
decide whether or not memory encryption should be enabled, which needs
to occur even before the initial page tables are created.

This is problematic for a number of reasons:
- this early code runs from the 1:1 mapping provided by the decompressor
  or firmware, which uses a different translation than the one assumed by
  the linker, and so the code needs to be built in a special way;
- parsing external input while the entire kernel image is still mapped
  writable is a bad idea in general, and really does not belong in
  security minded code;
- the current code ignores the built-in command line entirely (although
  this appears to be the case for the entire decompressor)

Given that the decompressor/EFI stub is an intrinsic part of the x86
bootable kernel image, move the command line parsing there and out of
the core kernel. This removes the need to build lib/cmdline.o in a
special way, or to use RIP-relative LEA instructions in inline asm
blocks.

This involves a new xloadflag in the setup header to indicate
that mem_encrypt=on appeared on the kernel command line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240227151907.387873-17-ardb+git@google.com
---
 arch/x86/boot/compressed/misc.c         | 15 +++++++++++-
 arch/x86/include/uapi/asm/bootparam.h   |  1 +-
 arch/x86/lib/Makefile                   | 13 +----------
 arch/x86/mm/mem_encrypt_identity.c      | 32 ++----------------------
 drivers/firmware/efi/libstub/x86-stub.c |  3 ++-
 5 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index bd6857a..408507e 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -372,6 +372,19 @@ unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 }
 
 /*
+ * Set the memory encryption xloadflag based on the mem_encrypt= command line
+ * parameter, if provided.
+ */
+static void parse_mem_encrypt(struct setup_header *hdr)
+{
+	int on = cmdline_find_option_bool("mem_encrypt=on");
+	int off = cmdline_find_option_bool("mem_encrypt=off");
+
+	if (on > off)
+		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
+}
+
+/*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
  * image (VO) and the execution environment (.bss, .brk), which makes sure
@@ -401,6 +414,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	/* Clear flags intended for solely in-kernel use. */
 	boot_params_ptr->hdr.loadflags &= ~KASLR_FLAG;
 
+	parse_mem_encrypt(&boot_params_ptr->hdr);
+
 	sanitize_boot_params(boot_params_ptr);
 
 	if (boot_params_ptr->screen_info.orig_video_mode == 7) {
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 01d19fc..eeea058 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -38,6 +38,7 @@
 #define XLF_EFI_KEXEC			(1<<4)
 #define XLF_5LEVEL			(1<<5)
 #define XLF_5LEVEL_ENABLED		(1<<6)
+#define XLF_MEM_ENCRYPTION		(1<<7)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index ea3a28e..f0dae4f 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -14,19 +14,6 @@ ifdef CONFIG_KCSAN
 CFLAGS_REMOVE_delay.o = $(CC_FLAGS_FTRACE)
 endif
 
-# Early boot use of cmdline; don't instrument it
-ifdef CONFIG_AMD_MEM_ENCRYPT
-KCOV_INSTRUMENT_cmdline.o := n
-KASAN_SANITIZE_cmdline.o  := n
-KCSAN_SANITIZE_cmdline.o  := n
-
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_cmdline.o = -pg
-endif
-
-CFLAGS_cmdline.o := -fno-stack-protector -fno-jump-tables
-endif
-
 inat_tables_script = $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
 inat_tables_maps = $(srctree)/arch/x86/lib/x86-opcode-map.txt
 quiet_cmd_inat_tables = GEN     $@
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 0166ab1..d210c7f 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -43,7 +43,6 @@
 
 #include <asm/setup.h>
 #include <asm/sections.h>
-#include <asm/cmdline.h>
 #include <asm/coco.h>
 #include <asm/sev.h>
 
@@ -95,9 +94,6 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
-static char sme_cmdline_arg[] __initdata = "mem_encrypt";
-static char sme_cmdline_on[]  __initdata = "on";
-
 static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
@@ -504,11 +500,9 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 
 void __init sme_enable(struct boot_params *bp)
 {
-	const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
 	unsigned long me_mask;
-	char buffer[16];
 	bool snp;
 	u64 msr;
 
@@ -551,6 +545,9 @@ void __init sme_enable(struct boot_params *bp)
 
 	/* Check if memory encryption is enabled */
 	if (feature_mask == AMD_SME_BIT) {
+		if (!(bp->hdr.xloadflags & XLF_MEM_ENCRYPTION))
+			return;
+
 		/*
 		 * No SME if Hypervisor bit is set. This check is here to
 		 * prevent a guest from trying to enable SME. For running as a
@@ -570,31 +567,8 @@ void __init sme_enable(struct boot_params *bp)
 		msr = __rdmsr(MSR_AMD64_SYSCFG);
 		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
 			return;
-	} else {
-		/* SEV state cannot be controlled by a command line option */
-		goto out;
 	}
 
-	/*
-	 * Fixups have not been applied to phys_base yet and we're running
-	 * identity mapped, so we must obtain the address to the SME command
-	 * line argument data using rip-relative addressing.
-	 */
-	asm ("lea sme_cmdline_arg(%%rip), %0"
-	     : "=r" (cmdline_arg)
-	     : "p" (sme_cmdline_arg));
-	asm ("lea sme_cmdline_on(%%rip), %0"
-	     : "=r" (cmdline_on)
-	     : "p" (sme_cmdline_on));
-
-	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
-				     ((u64)bp->ext_cmd_line_ptr << 32));
-
-	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0 ||
-	    strncmp(buffer, cmdline_on, sizeof(buffer)))
-		return;
-
-out:
 	RIP_REL_REF(sme_me_mask) = me_mask;
 	physical_mask &= ~me_mask;
 	cc_vendor = CC_VENDOR_AMD;
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 99429bc..0336ed1 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -884,6 +884,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		}
 	}
 
+	if (efi_mem_encrypt > 0)
+		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
+
 	status = efi_decompress_kernel(&kernel_entry);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to decompress kernel\n");

