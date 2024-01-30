Return-Path: <linux-kernel+bounces-45121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 842DE842BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFB90B2656D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C5278B73;
	Tue, 30 Jan 2024 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G1N66JSw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LK6bUH6S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379678B4A;
	Tue, 30 Jan 2024 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639796; cv=none; b=nxuNoyomC2iTXu/wIujXTdlueAMVYTl2D5miejvbgs9UzGIECEglaPTKvJCcAC66XXaykIUybsuaLjweEQZweQteSoTa3nv6YGQXd31IxVLtSH/1PgYZ085YQDFh6Hf7bNRk9QxDzmjLCU2lhTeeatCjebvMBZP5dkqltIJOlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639796; c=relaxed/simple;
	bh=FWUT0wLLSRnf09ExZBZUi5Lncjiws+s+KXYqvWzWcEk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s43fM8XjwQVmyjk8OwppSlRqBUKK8S5ihr2CY6tMtMxORYvi/sbCe0lB5sr+i06ZnlluCf4DQp+WGWosTeuiK4UEwaEXAi5EPnQ7zttvgk21nKfPN4qw2UFO7pyDe/1rDUU8SFKMot1yWpMO4wdb+RkJbuHV9eI0d809u+pPDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G1N66JSw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LK6bUH6S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 18:36:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706639792;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlrSuRSykG1ZRn4MdQ0PoBTjTY0Cbgyd2eCfy/d8R0M=;
	b=G1N66JSwFxl26nmkDZuNJk48W7z8lvqqGrrbYD31dF3cfkjbbq1tuKtPdp7HQrTVWoh/CQ
	lNb56Tk2028NYx0uf/9hVUSmilaAY2lckoXN0fmvEU7yzfYZD1bPAP92uZnR4wSd6Y75dc
	4U2OE76ma5hMm9hd6vaeKsOzcS02p+DK1bZDyLgQkDn8fJGOMmmbpJ1pEQfyZ5fC7P0c7P
	sj+Vnznno1/eE6Y1osxX+LEXKSwvcIxek9oobjz7XTnNMLBK3uwnk0gt9PGlE530shy9gj
	y6XDomSGg608cwHA2u88MF6U7Z4iUORgeeNDe97LrII50FO9idoOZQRBkWgOcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706639792;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlrSuRSykG1ZRn4MdQ0PoBTjTY0Cbgyd2eCfy/d8R0M=;
	b=LK6bUH6Sb7cNq7Qjb6G5CIZms/fEPrweXsJOOTbatI6XojQTvkcfvKI5zEDan4yxyn2ljZ
	Us11d0zT7dVAdXDg==
From: "tip-bot2 for Thomas Zimmermann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/build] x86: Do not include <asm/bootparam.h> in several files
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240112095000.8952-5-tzimmermann@suse.de>
References: <20240112095000.8952-5-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663979120.398.12452385440006197415.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     103bf75fc928d16185feb216bda525b5aaca0b18
Gitweb:        https://git.kernel.org/tip/103bf75fc928d16185feb216bda525b5aaca0b18
Author:        Thomas Zimmermann <tzimmermann@suse.de>
AuthorDate:    Fri, 12 Jan 2024 10:44:39 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 15:17:24 +01:00

x86: Do not include <asm/bootparam.h> in several files

Remove the include statement for <asm/bootparam.h> from several files
that don't require it and limit the exposure of those definitions within
the Linux kernel code.

  [ bp: Massage commit message. ]

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20240112095000.8952-5-tzimmermann@suse.de
---
 arch/x86/boot/compressed/acpi.c       | 2 ++
 arch/x86/boot/compressed/cmdline.c    | 2 ++
 arch/x86/boot/compressed/efi.c        | 2 ++
 arch/x86/boot/compressed/pgtable_64.c | 1 +
 arch/x86/boot/compressed/sev.c        | 1 +
 arch/x86/include/asm/kexec.h          | 1 -
 arch/x86/include/asm/mem_encrypt.h    | 2 +-
 arch/x86/include/asm/sev.h            | 3 ++-
 arch/x86/include/asm/x86_init.h       | 2 --
 arch/x86/kernel/crash.c               | 1 +
 arch/x86/kernel/sev-shared.c          | 2 ++
 arch/x86/platform/pvh/enlighten.c     | 1 +
 arch/x86/xen/enlighten_pvh.c          | 1 +
 arch/x86/xen/vga.c                    | 1 -
 14 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 18d15d1..f196b1d 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -5,6 +5,8 @@
 #include "../string.h"
 #include "efi.h"
 
+#include <asm/bootparam.h>
+
 #include <linux/numa.h>
 
 /*
diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index c1bb180..e162d7f 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
 
+#include <asm/bootparam.h>
+
 static unsigned long fs;
 static inline void set_fs(unsigned long seg)
 {
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index 6edd034..f2e50f9 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -7,6 +7,8 @@
 
 #include "misc.h"
 
+#include <asm/bootparam.h>
+
 /**
  * efi_get_type - Given a pointer to boot_params, determine the type of EFI environment.
  *
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 51f957b..c882e1f 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
+#include <asm/bootparam.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
 #include "pgtable.h"
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 454acd7..13beae7 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -12,6 +12,7 @@
  */
 #include "misc.h"
 
+#include <asm/bootparam.h>
 #include <asm/pgtable_types.h>
 #include <asm/sev.h>
 #include <asm/trapnr.h>
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index c9f6a6c..91ca9a9 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -25,7 +25,6 @@
 
 #include <asm/page.h>
 #include <asm/ptrace.h>
-#include <asm/bootparam.h>
 
 struct kimage;
 
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 359ada4..c1a8a34 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/cc_platform.h>
 
-#include <asm/bootparam.h>
+struct boot_params;
 
 #ifdef CONFIG_X86_MEM_ENCRYPT
 void __init mem_encrypt_init(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5b4a1ce..8dad8b1 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -13,7 +13,6 @@
 
 #include <asm/insn.h>
 #include <asm/sev-common.h>
-#include <asm/bootparam.h>
 #include <asm/coco.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
@@ -22,6 +21,8 @@
 
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
 
+struct boot_params;
+
 enum es_result {
 	ES_OK,			/* All good */
 	ES_UNSUPPORTED,		/* Requested operation not supported */
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index c878616..f062715 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_PLATFORM_H
 #define _ASM_X86_PLATFORM_H
 
-#include <asm/bootparam.h>
-
 struct ghcb;
 struct mpc_bus;
 struct mpc_cpu;
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index b6b0443..fe404c1 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -26,6 +26,7 @@
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
 
+#include <asm/bootparam.h>
 #include <asm/processor.h>
 #include <asm/hardirq.h>
 #include <asm/nmi.h>
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 1d24ec6..fcc6d83 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -9,6 +9,8 @@
  * and is included directly into both code-bases.
  */
 
+#include <asm/setup_data.h>
+
 #ifndef __BOOT_COMPRESSED
 #define error(v)	pr_err(v)
 #define has_cpuflag(f)	boot_cpu_has(f)
diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index 00a92cb..944e029 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -3,6 +3,7 @@
 
 #include <xen/hvc-console.h>
 
+#include <asm/bootparam.h>
 #include <asm/io_apic.h>
 #include <asm/hypervisor.h>
 #include <asm/e820/api.h>
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index ada3868..9e9db60 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -4,6 +4,7 @@
 
 #include <xen/hvc-console.h>
 
+#include <asm/bootparam.h>
 #include <asm/io_apic.h>
 #include <asm/hypervisor.h>
 #include <asm/e820/api.h>
diff --git a/arch/x86/xen/vga.c b/arch/x86/xen/vga.c
index d97adab..f754780 100644
--- a/arch/x86/xen/vga.c
+++ b/arch/x86/xen/vga.c
@@ -2,7 +2,6 @@
 #include <linux/screen_info.h>
 #include <linux/init.h>
 
-#include <asm/bootparam.h>
 #include <asm/setup.h>
 
 #include <xen/interface/xen.h>

