Return-Path: <linux-kernel+bounces-45123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74503842BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FA8B2463B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211EA69E1C;
	Tue, 30 Jan 2024 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w8BJrVhp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="52+WYad/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435778B42;
	Tue, 30 Jan 2024 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639797; cv=none; b=oztshq6t1IacSs7/h5uasPRFAjLhDdmstLSia1+esKiE5HiE2ePOY5QWUEls+6TmIFhfimDVtjQc3zRiDTDmfo1ryy/QhRfCcRxixvweocAu9oc/DNM6KW0QmvHjCvpoe3O0X9WsgYxMA3qW2tgbcDyCTcelkJdYlaxT73FoHxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639797; c=relaxed/simple;
	bh=NiNBvrR40otFTHJ097OMe57DnR7feDP4DZbaBZfGXaI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U3GndbQC2JdA+OvmEn18Ywp+GIoT6cwVV25UT8K5avFbkDOQ/lWmaQRuVolAmmJQKRCLix3B5VjDS8Tde8rwaGrSi7YMrFk24thInk8yuaeDk1eGqsTFOsR7vk3w8xNScDQoqdCU8uknpfV8Fv7H/Tm8FTveppakoaSYg5NeeYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w8BJrVhp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=52+WYad/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 18:36:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706639793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toA+ptjEM+2DWWvx60arfsDl7c0WFLQQBhrY2zAl8TE=;
	b=w8BJrVhp0sa2DflwlV5BorJcSBrONChZhwM6CjhxryeenBq6cvHyQZWwuZnRIW+tMo50zO
	duktHWhgyuRTzS9kPS0gmhq1oqSXufefuKDYvyv+sm1yZKI3PtJBbCFzMdcg3eBh2PQ6EC
	TO/xF2Fffi98bBU435wqIwaoAL+iDHiO0HrZDsuKCF6f5As86/0DIbJvOZh6wPL/l3DXeG
	uueoI2qH/6kDrKqm3hkpYfcrGD4rCtm0UWGVifG0+1/v6hDzG4KCq5tOxQMry40r4Wz8O8
	tSa075VEJ520xdtDVT/OAnkf2rUDVGoAOKDdFPKTX+df1I/s3uyAZqzOGn6JWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706639793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toA+ptjEM+2DWWvx60arfsDl7c0WFLQQBhrY2zAl8TE=;
	b=52+WYad/8TR4cya2buyJY0onwyGV25IpH344TXtIf3wPldyWf5MVTHdZOYASVUuUMJZetz
	Djr7EDUks9DBiMCw==
From: "tip-bot2 for Thomas Zimmermann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/build] x86/setup: Move UAPI setup structures into setup_data.h
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240112095000.8952-2-tzimmermann@suse.de>
References: <20240112095000.8952-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663979304.398.5831265739764610531.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     efd7def00406ac57400501cdc76d0d95d4691927
Gitweb:        https://git.kernel.org/tip/efd7def00406ac57400501cdc76d0d95d4691927
Author:        Thomas Zimmermann <tzimmermann@suse.de>
AuthorDate:    Fri, 12 Jan 2024 10:44:36 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 15:17:06 +01:00

x86/setup: Move UAPI setup structures into setup_data.h

The type definition of struct pci_setup_rom in <asm/pci.h> requires
struct setup_data from <asm/bootparam.h>. Many drivers include
<linux/pci.h>, but do not use boot parameters. Changes to bootparam.h or
its included header files could easily trigger a large, unnecessary
rebuild of the kernel.

Moving struct setup_data and related code into its own header file
avoids including <asm/bootparam.h> in <asm/pci.h>. Instead include the
new header <asm/screen_data.h> and remove the include statement for
x86_init.h, which is unnecessary but pulls in bootparams.h.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20240112095000.8952-2-tzimmermann@suse.de
---
 arch/x86/include/asm/pci.h             |  2 +-
 arch/x86/include/uapi/asm/bootparam.h  | 72 +----------------------
 arch/x86/include/uapi/asm/setup_data.h | 83 +++++++++++++++++++++++++-
 3 files changed, 85 insertions(+), 72 deletions(-)
 create mode 100644 arch/x86/include/uapi/asm/setup_data.h

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index b40c462..f6100df 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -10,7 +10,7 @@
 #include <linux/numa.h>
 #include <asm/io.h>
 #include <asm/memtype.h>
-#include <asm/x86_init.h>
+#include <asm/setup_data.h>
 
 struct pci_sysdata {
 	int		domain;		/* PCI domain */
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 01d19fc..4a38e79 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -2,21 +2,7 @@
 #ifndef _ASM_X86_BOOTPARAM_H
 #define _ASM_X86_BOOTPARAM_H
 
-/* setup_data/setup_indirect types */
-#define SETUP_NONE			0
-#define SETUP_E820_EXT			1
-#define SETUP_DTB			2
-#define SETUP_PCI			3
-#define SETUP_EFI			4
-#define SETUP_APPLE_PROPERTIES		5
-#define SETUP_JAILHOUSE			6
-#define SETUP_CC_BLOB			7
-#define SETUP_IMA			8
-#define SETUP_RNG_SEED			9
-#define SETUP_ENUM_MAX			SETUP_RNG_SEED
-
-#define SETUP_INDIRECT			(1<<31)
-#define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
+#include <asm/setup_data.h>
 
 /* ram_size flags */
 #define RAMDISK_IMAGE_START_MASK	0x07FF
@@ -48,22 +34,6 @@
 #include <asm/ist.h>
 #include <video/edid.h>
 
-/* extensible setup data list node */
-struct setup_data {
-	__u64 next;
-	__u32 type;
-	__u32 len;
-	__u8 data[];
-};
-
-/* extensible setup indirect data node */
-struct setup_indirect {
-	__u32 type;
-	__u32 reserved;  /* Reserved, must be set to zero. */
-	__u64 len;
-	__u64 addr;
-};
-
 struct setup_header {
 	__u8	setup_sects;
 	__u16	root_flags;
@@ -137,50 +107,10 @@ struct efi_info {
 #define E820_MAX_ENTRIES_ZEROPAGE 128
 
 /*
- * The E820 memory region entry of the boot protocol ABI:
- */
-struct boot_e820_entry {
-	__u64 addr;
-	__u64 size;
-	__u32 type;
-} __attribute__((packed));
-
-/*
  * Smallest compatible version of jailhouse_setup_data required by this kernel.
  */
 #define JAILHOUSE_SETUP_REQUIRED_VERSION	1
 
-/*
- * The boot loader is passing platform information via this Jailhouse-specific
- * setup data structure.
- */
-struct jailhouse_setup_data {
-	struct {
-		__u16	version;
-		__u16	compatible_version;
-	} __attribute__((packed)) hdr;
-	struct {
-		__u16	pm_timer_address;
-		__u16	num_cpus;
-		__u64	pci_mmconfig_base;
-		__u32	tsc_khz;
-		__u32	apic_khz;
-		__u8	standard_ioapic;
-		__u8	cpu_ids[255];
-	} __attribute__((packed)) v1;
-	struct {
-		__u32	flags;
-	} __attribute__((packed)) v2;
-} __attribute__((packed));
-
-/*
- * IMA buffer setup data information from the previous kernel during kexec
- */
-struct ima_setup_data {
-	__u64 addr;
-	__u64 size;
-} __attribute__((packed));
-
 /* The so-called "zeropage" */
 struct boot_params {
 	struct screen_info screen_info;			/* 0x000 */
diff --git a/arch/x86/include/uapi/asm/setup_data.h b/arch/x86/include/uapi/asm/setup_data.h
new file mode 100644
index 0000000..b111b0c
--- /dev/null
+++ b/arch/x86/include/uapi/asm/setup_data.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_X86_SETUP_DATA_H
+#define _UAPI_ASM_X86_SETUP_DATA_H
+
+/* setup_data/setup_indirect types */
+#define SETUP_NONE			0
+#define SETUP_E820_EXT			1
+#define SETUP_DTB			2
+#define SETUP_PCI			3
+#define SETUP_EFI			4
+#define SETUP_APPLE_PROPERTIES		5
+#define SETUP_JAILHOUSE			6
+#define SETUP_CC_BLOB			7
+#define SETUP_IMA			8
+#define SETUP_RNG_SEED			9
+#define SETUP_ENUM_MAX			SETUP_RNG_SEED
+
+#define SETUP_INDIRECT			(1<<31)
+#define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+/* extensible setup data list node */
+struct setup_data {
+	__u64 next;
+	__u32 type;
+	__u32 len;
+	__u8 data[];
+};
+
+/* extensible setup indirect data node */
+struct setup_indirect {
+	__u32 type;
+	__u32 reserved;  /* Reserved, must be set to zero. */
+	__u64 len;
+	__u64 addr;
+};
+
+/*
+ * The E820 memory region entry of the boot protocol ABI:
+ */
+struct boot_e820_entry {
+	__u64 addr;
+	__u64 size;
+	__u32 type;
+} __attribute__((packed));
+
+/*
+ * The boot loader is passing platform information via this Jailhouse-specific
+ * setup data structure.
+ */
+struct jailhouse_setup_data {
+	struct {
+		__u16	version;
+		__u16	compatible_version;
+	} __attribute__((packed)) hdr;
+	struct {
+		__u16	pm_timer_address;
+		__u16	num_cpus;
+		__u64	pci_mmconfig_base;
+		__u32	tsc_khz;
+		__u32	apic_khz;
+		__u8	standard_ioapic;
+		__u8	cpu_ids[255];
+	} __attribute__((packed)) v1;
+	struct {
+		__u32	flags;
+	} __attribute__((packed)) v2;
+} __attribute__((packed));
+
+/*
+ * IMA buffer setup data information from the previous kernel during kexec
+ */
+struct ima_setup_data {
+	__u64 addr;
+	__u64 size;
+} __attribute__((packed));
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _UAPI_ASM_X86_SETUP_DATA_H */

