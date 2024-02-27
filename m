Return-Path: <linux-kernel+bounces-83492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F0C869A30
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0761C2296D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9804E146E60;
	Tue, 27 Feb 2024 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9JoFN/e"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C71482EF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047179; cv=none; b=WVkUBwFZ3TW+wNabqqnf0efVbKB1UEOen7LDNU0keU/0MXJqPj9OkK13GS044/nE/DIF+O8RQL+OTW3sTu3QWHnOSRQESEUwSg5XDe6LfdAl/6sMT7LWTYLbsLr/DK0IPX2Y3FCj9W/vp6H7h8F9ZREV4l0IlzNwiJLL7cIVuFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047179; c=relaxed/simple;
	bh=A2R9NwPOj178rTXF4jj1Oe0QhM2YkwIT8ZkVkD7sOlw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r4go51ZMkZl3HqkTA3sx+nQGuNBawGec2xTCzHH79x4GOxR38Xo8Xo1Bh4hmDQY4gKoUM5g6vKvitzIUcaAWuN4qhguZfExwUvfipxxXdIRKiWKbbYuQUK+BbqQR2Sgewx+BpF+DIIa/Ptjsh5TsPTQDfpwc3GveOz9tpyfc/iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W9JoFN/e; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ab197437so69590887b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709047177; x=1709651977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qc1vZT6QqkQkEMHN6UDx4N3IKREdTVsL1hpJl21eLz4=;
        b=W9JoFN/eVGSVF8fxpkDJ2vCAflR+BZLg155+Nnk28l0b4i8z4PZAu96kZ1lFLtOi+i
         6J6kXGbJ9fBeNP0Ed8gJoYVgGrUnF+w2ilQnODci6G7VLSNbOiNuzQLERjZwgNoMSCpy
         4BWAEysHLDet29kaMd+nO0JmFFn50xonK73gyGbbL0dmuK4du27k46X2lO0j0MCpf6/W
         ndj4HiihGHqaoma7vfFX952ltNdrokKuW6FDSvYCZhIwi03lkgGafoVYZjNY8R/RS01P
         pFnnuJj/xwJKyEPkKbPSyux+Sdb3EID5d56wEZ8ZUhQQ2ogQxZVf4MWOqNxNmlzXQM8P
         Axdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047177; x=1709651977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qc1vZT6QqkQkEMHN6UDx4N3IKREdTVsL1hpJl21eLz4=;
        b=MEQmpCn1iBkPPz5bw2qCyzekQ4f0YXVQQ+3GIDOW+Qt54dfQqOYb5QEIBS9obf5cKT
         GNz+ugJY+jP0mtI5vg7sLTp2U0QQ2bunIWn5graShNiyiu0fIPXtR0giN8sPZK77MOdG
         MBfvdkQW2HgttIWT3xdIRAcmWjytIp6dQsdqvFBfa3iY18HiStz8rlor4JYSlHSMeJjj
         swSPxeLrIPxAFCB3QreAnJAHjZAERFaoOlwHSCy/7+uctNzEVW/MM8rZnTMFTz0SAcc1
         FN+hUKw16uJvq52F7AO2FAS4TouxVPHb0kQpIdqtkFatj404QNsSxHHPFny9Wt9bYyvC
         Q+ZA==
X-Gm-Message-State: AOJu0YyvWuo0Vbgy0gokv9VWQQNruG8+0LjZeSsFhHIS4QaZ3yFFchN8
	q+zjfKhKFCzpTg2QdAW1XaXM54UN4suPY5r6Qck6vUoo9qbfXUREvFINwLTGHSR1niZgaqJtAdQ
	Jw4x0ynLFvA9VPRx5k6/AJYpMCKwY6Gn2nXaPoxMRiYfxAETMzZkw0zHQ9+RftiK0uY0RuFO+tt
	TU/7XD9u56Mpgu3FnAmkbDzyV2LBXeBA==
X-Google-Smtp-Source: AGHT+IGia+6EyrdacdXDt5a5Bq/GczHCRxClR1f9K15mG0PQBCqJPyC6SnsL0A8aD0YSvU6v33wefrNA
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:48c8:0:b0:608:de34:9583 with SMTP id
 v191-20020a8148c8000000b00608de349583mr527840ywa.7.1709047177011; Tue, 27 Feb
 2024 07:19:37 -0800 (PST)
Date: Tue, 27 Feb 2024 16:19:14 +0100
In-Reply-To: <20240227151907.387873-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227151907.387873-17-ardb+git@google.com>
Subject: [PATCH v7 6/9] x86/boot: Move mem_encrypt= parsing to the decompressor
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

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
---
 arch/x86/boot/compressed/misc.c         | 15 +++++++++
 arch/x86/include/uapi/asm/bootparam.h   |  1 +
 arch/x86/lib/Makefile                   | 13 --------
 arch/x86/mm/mem_encrypt_identity.c      | 32 ++------------------
 drivers/firmware/efi/libstub/x86-stub.c |  3 ++
 5 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index bd6857a9f15a..408507e305be 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -371,6 +371,19 @@ unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 	return entry;
 }
 
+/*
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
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -401,6 +414,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	/* Clear flags intended for solely in-kernel use. */
 	boot_params_ptr->hdr.loadflags &= ~KASLR_FLAG;
 
+	parse_mem_encrypt(&boot_params_ptr->hdr);
+
 	sanitize_boot_params(boot_params_ptr);
 
 	if (boot_params_ptr->screen_info.orig_video_mode == 7) {
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 01d19fc22346..eeea058cf602 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -38,6 +38,7 @@
 #define XLF_EFI_KEXEC			(1<<4)
 #define XLF_5LEVEL			(1<<5)
 #define XLF_5LEVEL_ENABLED		(1<<6)
+#define XLF_MEM_ENCRYPTION		(1<<7)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index ea3a28e7b613..f0dae4fb6d07 100644
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
index 0166ab1780cc..d210c7fc8fa2 100644
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
index 99429bc4b0c7..0336ed175e67 100644
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
-- 
2.44.0.rc1.240.g4c46232300-goog


