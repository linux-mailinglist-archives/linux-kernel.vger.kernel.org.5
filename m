Return-Path: <linux-kernel+bounces-45122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A875E842BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB01C1C2391D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657A969974;
	Tue, 30 Jan 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O0mVN7QD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rbIG6vFM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB6778B4D;
	Tue, 30 Jan 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639796; cv=none; b=tLxt6D/JZNKg4OMy0w1lZArBk3fgfXIREKkcQBxIpLwPYbnLB2miFEUoL55JaALLty7MSrhIvSTHpQsNomnOenQ5WOOEjwGmh6D/ajuy7HB2StsP0KYwkNCq7BIApwTLfP0Bgg/9UWFg7o0NcJWlVSJXDJnn76LuRyD5tHOglck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639796; c=relaxed/simple;
	bh=TQMQJuhbVYR3IuI7EE3Z+bUkrVf7jfCpz2SRg+Rxx+s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=flmcannYvaWm64iS2WsutZbGfA3y/q2f3H7fwBRbkbgLq4320TI65/rrlpfMcYUKZo0vN6v4MnjIkN4Gatc42C4PPQ9NtIrTiT4DJW5xjwTpmjo5IBfsQyzuys8CMjvI64D2NFGKy9BYG9xwGfCfiTlZ49nj7Ny8oFbfXLuL1jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O0mVN7QD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rbIG6vFM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 18:36:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706639793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQ9pU46e8gbUGHOpRAEoQRDa5SWZAG2G05It6FKEm5o=;
	b=O0mVN7QD/Wp2KnpMfZTdKRBO/EvhikKnhGlpBUXMcuzTCGI/ipEbR5BTRv8G9VaUKateJQ
	l4kx/1zUWRxh0U47iXOcPhDxXskhhAnxZxpCL9hRzb5/sd73Fv3PP56EWkhIiAf3XEHfKn
	9rhyChwq/2Hosl4ZSlyC3j8kdPB8rpckWWIzvz0RsB9UMLJ5fXKoNel1c6dvHDKZ7nxXuN
	CBqTI8rm7aD5ezXZSMF6cFgUykHIh9oFeU/4nqhnjcjwvdijI9kZ9N7pVz1NhNTFokelGM
	4d+q5UAL4GwpxkPrBUM5HhS0mGshP8qVJEgc3YoQ4kfrJBsxHeDEy4MWr/MJ1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706639793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQ9pU46e8gbUGHOpRAEoQRDa5SWZAG2G05It6FKEm5o=;
	b=rbIG6vFMpECPQUveo7iLWAIBCRDQ3e72QrysZ45l7UBRO57idGh3+W/V5OzgLnw9+v1p7Q
	UmQR4Q/X8HaRF8BA==
From: "tip-bot2 for Thomas Zimmermann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/setup: Move internal setup_data structures into
 setup_data.h
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240112095000.8952-3-tzimmermann@suse.de>
References: <20240112095000.8952-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663979247.398.9385966329992245776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     2afa7994f794016d117b192e36b856df66d71172
Gitweb:        https://git.kernel.org/tip/2afa7994f794016d117b192e36b856df66d71172
Author:        Thomas Zimmermann <tzimmermann@suse.de>
AuthorDate:    Fri, 12 Jan 2024 10:44:37 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 15:17:12 +01:00

x86/setup: Move internal setup_data structures into setup_data.h

Move struct_efi_setup_data in order to unify duplicated definition of
the data structure in a single place. Also silence clang's warnings
about GNU extensions in real-mode code which might occur from the
changed includes.

  [ bp: Massage commit message. ]

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20240112095000.8952-3-tzimmermann@suse.de
---
 arch/x86/Makefile                 |  3 +++-
 arch/x86/boot/compressed/efi.h    |  9 +--------
 arch/x86/include/asm/efi.h        |  9 +--------
 arch/x86/include/asm/pci.h        | 13 +------------
 arch/x86/include/asm/setup_data.h | 32 ++++++++++++++++++++++++++++++-
 5 files changed, 35 insertions(+), 31 deletions(-)
 create mode 100644 arch/x86/include/asm/setup_data.h

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1a068de..24076db 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -53,6 +53,9 @@ REALMODE_CFLAGS += -fno-stack-protector
 REALMODE_CFLAGS += -Wno-address-of-packed-member
 REALMODE_CFLAGS += $(cc_stack_align4)
 REALMODE_CFLAGS += $(CLANG_FLAGS)
+ifdef CONFIG_CC_IS_CLANG
+REALMODE_CFLAGS += -Wno-gnu
+endif
 export REALMODE_CFLAGS
 
 # BITS is used as extension for files which are available in a 32 bit
diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
index 866c0af..b223009 100644
--- a/arch/x86/boot/compressed/efi.h
+++ b/arch/x86/boot/compressed/efi.h
@@ -97,15 +97,6 @@ typedef struct {
 	u32 tables;
 } efi_system_table_32_t;
 
-/* kexec external ABI */
-struct efi_setup_data {
-	u64 fw_vendor;
-	u64 __unused;
-	u64 tables;
-	u64 smbios;
-	u64 reserved[8];
-};
-
 struct efi_unaccepted_memory {
 	u32 version;
 	u32 unit_size;
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index c4555b2..a5d7a83 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -143,15 +143,6 @@ extern void efi_free_boot_services(void);
 void arch_efi_call_virt_setup(void);
 void arch_efi_call_virt_teardown(void);
 
-/* kexec external ABI */
-struct efi_setup_data {
-	u64 fw_vendor;
-	u64 __unused;
-	u64 tables;
-	u64 smbios;
-	u64 reserved[8];
-};
-
 extern u64 efi_setup;
 
 #ifdef CONFIG_EFI
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index f6100df..b3ab80a 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -10,7 +10,6 @@
 #include <linux/numa.h>
 #include <asm/io.h>
 #include <asm/memtype.h>
-#include <asm/setup_data.h>
 
 struct pci_sysdata {
 	int		domain;		/* PCI domain */
@@ -124,16 +123,4 @@ cpumask_of_pcibus(const struct pci_bus *bus)
 }
 #endif
 
-struct pci_setup_rom {
-	struct setup_data data;
-	uint16_t vendor;
-	uint16_t devid;
-	uint64_t pcilen;
-	unsigned long segment;
-	unsigned long bus;
-	unsigned long device;
-	unsigned long function;
-	uint8_t romdata[];
-};
-
 #endif /* _ASM_X86_PCI_H */
diff --git a/arch/x86/include/asm/setup_data.h b/arch/x86/include/asm/setup_data.h
new file mode 100644
index 0000000..77c5111
--- /dev/null
+++ b/arch/x86/include/asm/setup_data.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SETUP_DATA_H
+#define _ASM_X86_SETUP_DATA_H
+
+#include <uapi/asm/setup_data.h>
+
+#ifndef __ASSEMBLY__
+
+struct pci_setup_rom {
+	struct setup_data data;
+	uint16_t vendor;
+	uint16_t devid;
+	uint64_t pcilen;
+	unsigned long segment;
+	unsigned long bus;
+	unsigned long device;
+	unsigned long function;
+	uint8_t romdata[];
+};
+
+/* kexec external ABI */
+struct efi_setup_data {
+	u64 fw_vendor;
+	u64 __unused;
+	u64 tables;
+	u64 smbios;
+	u64 reserved[8];
+};
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_X86_SETUP_DATA_H */

