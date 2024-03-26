Return-Path: <linux-kernel+bounces-119939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A088CF20
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865A21C66FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03E13E886;
	Tue, 26 Mar 2024 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="rXXGPd1r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r7EbepvN"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E813E3EB;
	Tue, 26 Mar 2024 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485347; cv=none; b=LOFaMTiQT9wQe5cndF+9DQCZlEsxbxaVD7Y99TYCwXQWSH7yX1zE555UjabyB0pXgvGbS97hel3YSnTcLFTqGp6Bid+cg8wL3eEVW4f5TwHNAsh2L0k/S96CZdZXCZMe3h7TEyVqI6EzOaSz2xghN3+RXw5G5V9D3zoEkqV2YnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485347; c=relaxed/simple;
	bh=6PYshBYsyHU9y1oU7WKcX8ygqHspnG1/l1J3FcfKTic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnwVJLyyYz74mr8Dmq7GtSsp9HgK3JbEqrI828TWgJNWAX1t5BLqv3763wFG4CPMjjynElaLb+ZtPy2qgnYKpddIwmsBePQMiodNAqp26mUGtqoaGwp/fLPSTJYlgXGnEn4wQX/tUNh5wa4ZLZf1evTH2brREnQKwAM4h7mPzSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=rXXGPd1r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r7EbepvN; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 208F05C004D;
	Tue, 26 Mar 2024 16:35:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Mar 2024 16:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711485344;
	 x=1711571744; bh=EfmnxpMYJaTv6kmfmBSf/+W4jwiX0Wab1+FY0FgJ9uw=; b=
	rXXGPd1r2Yf9QR+I9EPm4QQ7yHcYJAed1wbTI73nIrYMZrZrcIgebWlVTbowRNPH
	Hgncgngls4h45QJKFZXdhw/CR0hmS2XXMWV6nDjWqrvr52nS74lejW45AhsaZ2Gz
	1AIKrFHNyxgy0sn7L2ottYB6tx8w168JqKW3VIpARc28vGb46aOf3cxiaLIAXDrV
	KhiwWT+e1TsQr9RbUTRXoK/K4AKaVmCTn0W36Ohq3OcqPB9WVT55K24t873FBlSp
	aWfoD/U88GNp3li7rboGwUL/Eh4z+AERJRlTKbcWFChUyp45mQbitbIYlIOxb3UF
	60d+3q9zppMOEK6YdZRWmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711485344; x=
	1711571744; bh=EfmnxpMYJaTv6kmfmBSf/+W4jwiX0Wab1+FY0FgJ9uw=; b=r
	7EbepvNlVc4PB3d5+B/vgmIHxuA2x0d7Lp4Jb8aIWB9+cPZ+ELc2VvgmZAVddMjV
	600MAiAMy6nitk3i8HXZ7JRxpcWioOqslPRPDRraeeweudGiL6sFYns8Rta1Nyu0
	A7ClikBvozZaNxXTxBxEfIxFR1pVF77d884Gy/iWCLjenLgy2hPpfy4R7VGuQbUW
	WHdbzeJmtt0q9UY6Ee/aMAFsGS8/326Hfs1k4J94IYKlkGPBQE7ePsG1d/m26SkT
	+kaMvP1ckstRwamHnNunKfz3sNFvhJhMBeE8ecIKYBexP8FypGM7lAPEvQbo0lGF
	wlN+etTTdGPQL4fgWcE3w==
X-ME-Sender: <xms:nzEDZrNJZbuxe5YYTvbjOiPs6j3_wb7Uk8yhONhvyKkgJdXpeXIiNg>
    <xme:nzEDZl9PUT1_GByKDB8D23dE2vTOGBZm0qrkulIOA2ZqQWu96clvhQ0VdOmoSvtdf
    KqCCmgWiQQJ_C3UXxI>
X-ME-Received: <xmr:nzEDZqR94q2IIUaXP7PhQj8ZVYfehFUb7L3U7b8AO0O6_c-YuTBPSD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeduudekveevvddtffegkeevieehheehieejueekkedvuddv
    heegheevueeujeehheenucffohhmrghinhepuggvsghughdqvhgvtgdrshgspdguvggsuh
    hgrdhssgdphhgvrggurdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:nzEDZvtCZNaPWKP12EhRmgzEaluDm_nzSSUI0jcMFli6OiYhq00W3Q>
    <xmx:nzEDZjfLhQLaGiz8NYN_50iFFzpubIhymHUo5p3hh3JYaRIs2rCSXw>
    <xmx:nzEDZr2MJdFAaISWAD5_FW1xxc6S0YzLurHFkoh9IVj2VnSq3tq3bA>
    <xmx:nzEDZv9LSOC8YH4XWjHFQ4kooSc17y_76mf-NQ9_j225meKezKebiA>
    <xmx:oDEDZq67UYLGGUxf13AfUMqravNcfUVNKxeZEZkL_jCmiv5kmyaWYg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 16:35:43 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 26 Mar 2024 20:35:40 +0000
Subject: [PATCH v2 8/9] MIPS: zboot: Convert to use debug_ll facilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-mips_debug_ll-v2-8-b64abc76f2a1@flygoat.com>
References: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
In-Reply-To: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10528;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=6PYshBYsyHU9y1oU7WKcX8ygqHspnG1/l1J3FcfKTic=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjRmw5mnbP2FuneqG1yzO2QvKftoBaNEtNLs1+qLLj7cG
 VJl8C24o5SFQYyDQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACaS2cHwP8R3t8LlaFcTo0Tj
 mJ7TWvNtZjTPSPHxUT7ltGTtzAm5YowMDSdDf0rM+CBw6tAjG92zmy2vtZgeSJO6sW169MEfVSc
 7eAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Since now debug_ll facilities can cover all platforms supported
by zboot debug print, and it provides extra capability on debugging
exceptions, switch zboot to use those facilities.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig                        | 12 ++------
 arch/mips/Kconfig.debug                  | 46 +++++++++++++-----------------
 arch/mips/boot/compressed/Makefile       |  9 ++----
 arch/mips/boot/compressed/dbg.c          | 39 -------------------------
 arch/mips/boot/compressed/debug-vec.S    |  3 ++
 arch/mips/boot/compressed/debug.S        |  3 ++
 arch/mips/boot/compressed/decompress.h   |  8 +++---
 arch/mips/boot/compressed/head.S         |  6 ++++
 arch/mips/boot/compressed/uart-16550.c   | 49 --------------------------------
 arch/mips/boot/compressed/uart-alchemy.c |  9 ------
 arch/mips/boot/compressed/uart-ath79.c   |  2 --
 arch/mips/boot/compressed/uart-prom.c    |  9 ------
 12 files changed, 39 insertions(+), 156 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 06ef440d16ce..6729bf1d158d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -240,7 +240,7 @@ config ATH79
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_MIPS16
-	select SYS_SUPPORTS_ZBOOT_UART_PROM
+	select SYS_SUPPORTS_ZBOOT
 	select USE_OF
 	select USB_EHCI_ROOT_HUB_TT if USB_EHCI_HCD_PLATFORM
 	help
@@ -422,7 +422,7 @@ config MACH_INGENIC_SOC
 	select MIPS_GENERIC
 	select MACH_INGENIC
 	select MACH_GENERIC_CORE
-	select SYS_SUPPORTS_ZBOOT_UART16550
+	select SYS_SUPPORTS_ZBOOT
 	select CPU_SUPPORTS_CPUFREQ
 	select MIPS_EXTERNAL_TIMER
 
@@ -1792,14 +1792,6 @@ config SYS_SUPPORTS_ZBOOT
 	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_ZSTD
 
-config SYS_SUPPORTS_ZBOOT_UART16550
-	bool
-	select SYS_SUPPORTS_ZBOOT
-
-config SYS_SUPPORTS_ZBOOT_UART_PROM
-	bool
-	select SYS_SUPPORTS_ZBOOT
-
 config CPU_LOONGSON2EF
 	bool
 	select CPU_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index a6687c503c34..0ce6d24d05b3 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -79,33 +79,6 @@ config SB1XXX_CORELIS
 	  Select compile flags that produce code that can be processed by the
 	  Corelis mksym utility and UDB Emulator.
 
-config DEBUG_ZBOOT
-	bool "Enable compressed kernel support debugging"
-	depends on DEBUG_KERNEL && SYS_SUPPORTS_ZBOOT
-	default n
-	help
-	  If you want to add compressed kernel support to a new board, and the
-	  board supports uart16550 compatible serial port, please select
-	  SYS_SUPPORTS_ZBOOT_UART16550 for your board and enable this option to
-	  debug it.
-
-	  If your board doesn't support uart16550 compatible serial port, you
-	  can try to select SYS_SUPPORTS_ZBOOT and use the other methods to
-	  debug it. for example, add a new serial port support just as
-	  arch/mips/boot/compressed/uart-16550.c does.
-
-	  After the compressed kernel support works, please disable this option
-	  to reduce the kernel image size and speed up the booting procedure a
-	  little.
-
-config ZBOOT_INGENIC_UART
-	int "UART to use for compressed kernel debugging"
-	depends on DEBUG_ZBOOT && MACH_INGENIC_SOC
-	default 0
-	range 0 4
-	help
-	  Specify the UART that should be used for compressed kernel debugging.
-
 config SPINLOCK_TEST
 	bool "Enable spinlock timing tests in debugfs"
 	depends on DEBUG_FS
@@ -328,3 +301,22 @@ config DEBUG_UART_8250_WIDTH
 	int "Register width for the 8250 debug UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	default 1
+
+config DEBUG_ZBOOT
+	bool "Enable compressed kernel debugging via DEBUG_LL output"
+	depends on DEBUG_LL && SYS_SUPPORTS_ZBOOT
+	help
+	  Say Y here if you want to enable debugging of a compressed kernel
+	  via the DEBUG_LL output.  This is useful if you are debugging
+	  decompressor issues.
+
+	  If unsure, say N.
+
+config DEBUG_ZBOOT_EXCEPT
+	bool "Enable compressed kernel debugging of exceptions"
+	depends on DEBUG_ZBOOT
+	help
+	  Say Y here if you want to enable debugging of exceptions happen
+	  during decompression of a compressed kernel via the DEBUG_LL output.
+
+	  If unsure, say N.
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 6cc28173bee8..78c65db8dd04 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -43,13 +43,8 @@ KCSAN_SANITIZE			:= n
 # decompressor objects (linked with vmlinuz)
 vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/bswapsi.o
 
-ifdef CONFIG_DEBUG_ZBOOT
-vmlinuzobjs-$(CONFIG_DEBUG_ZBOOT)		   += $(obj)/dbg.o
-vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
-vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART_PROM) += $(obj)/uart-prom.o
-vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
-vmlinuzobjs-$(CONFIG_ATH79)			   += $(obj)/uart-ath79.o
-endif
+vmlinuzobjs-$(CONFIG_DEBUG_ZBOOT)		+= $(obj)/debug.o
+vmlinuzobjs-$(CONFIG_DEBUG_ZBOOT_EXCEPT)	+= $(obj)/debug-vec.o
 
 vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o
 
diff --git a/arch/mips/boot/compressed/dbg.c b/arch/mips/boot/compressed/dbg.c
deleted file mode 100644
index 95405292accd..000000000000
--- a/arch/mips/boot/compressed/dbg.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * MIPS-specific debug support for pre-boot environment
- *
- * NOTE: putc() is board specific, if your board have a 16550 compatible uart,
- * please select SYS_SUPPORTS_ZBOOT_UART16550 for your machine. otherwise, you
- * need to implement your own putc().
- */
-#include <linux/compiler.h>
-#include <linux/types.h>
-
-#include "decompress.h"
-
-void __weak putc(char c)
-{
-}
-
-void puts(const char *s)
-{
-	char c;
-	while ((c = *s++) != '\0') {
-		putc(c);
-		if (c == '\n')
-			putc('\r');
-	}
-}
-
-void puthex(unsigned long long val)
-{
-
-	unsigned char buf[10];
-	int i;
-	for (i = 7; i >= 0; i--) {
-		buf[i] = "0123456789ABCDEF"[val & 0x0F];
-		val >>= 4;
-	}
-	buf[8] = '\0';
-	puts(buf);
-}
diff --git a/arch/mips/boot/compressed/debug-vec.S b/arch/mips/boot/compressed/debug-vec.S
new file mode 100644
index 000000000000..e7bedb183da8
--- /dev/null
+++ b/arch/mips/boot/compressed/debug-vec.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "../../kernel/debug-vec.S"
diff --git a/arch/mips/boot/compressed/debug.S b/arch/mips/boot/compressed/debug.S
new file mode 100644
index 000000000000..0cf3da958f7e
--- /dev/null
+++ b/arch/mips/boot/compressed/debug.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "../../kernel/debug.S"
diff --git a/arch/mips/boot/compressed/decompress.h b/arch/mips/boot/compressed/decompress.h
index 073b64593b3d..e375d50c71a0 100644
--- a/arch/mips/boot/compressed/decompress.h
+++ b/arch/mips/boot/compressed/decompress.h
@@ -7,11 +7,11 @@ extern unsigned char __image_begin[], __image_end[];
 
 /* debug interfaces  */
 #ifdef CONFIG_DEBUG_ZBOOT
-extern void putc(char c);
-extern void puts(const char *s);
-extern void puthex(unsigned long long val);
+extern void printascii(const char *s);
+extern void printhexl(unsigned long val);
+#define puts(s) printascii(s)
+#define puthex(val) printhexl(val)
 #else
-#define putc(s) do {} while (0)
 #define puts(s) do {} while (0)
 #define puthex(val) do {} while (0)
 #endif
diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index d237a834b85e..b05e9591d3af 100644
--- a/arch/mips/boot/compressed/head.S
+++ b/arch/mips/boot/compressed/head.S
@@ -22,6 +22,12 @@
 	move	s2, a2
 	move	s3, a3
 
+#ifdef CONFIG_DEBUG_ZBOOT_EXCEP
+	/* Set up the exception vector */
+	PTR_LA	t9, setup_debug_ll_exception
+	jalr	t9
+#endif
+
 	/* Clear BSS */
 	PTR_LA	a0, _edata
 	PTR_LA	a2, _end
diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
deleted file mode 100644
index db618e72a0c4..000000000000
--- a/arch/mips/boot/compressed/uart-16550.c
+++ /dev/null
@@ -1,49 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * 16550 compatible uart based serial debug support for zboot
- */
-
-#include <linux/types.h>
-#include <linux/serial_reg.h>
-
-#include <asm/addrspace.h>
-
-#include "decompress.h"
-
-#if defined(CONFIG_MACH_LOONGSON64) || defined(CONFIG_MIPS_MALTA)
-#define UART_BASE 0x1fd003f8
-#define PORT(offset) (CKSEG1ADDR(UART_BASE) + (offset))
-#endif
-
-#ifdef CONFIG_MACH_INGENIC
-#define INGENIC_UART_BASE_ADDR	(0x10030000 + 0x1000 * CONFIG_ZBOOT_INGENIC_UART)
-#define PORT(offset) (CKSEG1ADDR(INGENIC_UART_BASE_ADDR) + (4 * offset))
-#endif
-
-#ifndef IOTYPE
-#define IOTYPE char
-#endif
-
-#ifndef PORT
-#error please define the serial port address for your own machine
-#endif
-
-static inline unsigned int serial_in(int offset)
-{
-	return *((volatile IOTYPE *)PORT(offset)) & 0xFF;
-}
-
-static inline void serial_out(int offset, int value)
-{
-	*((volatile IOTYPE *)PORT(offset)) = value & 0xFF;
-}
-
-void putc(char c)
-{
-	int timeout = 1000000;
-
-	while (((serial_in(UART_LSR) & UART_LSR_THRE) == 0) && (timeout-- > 0))
-		;
-
-	serial_out(UART_TX, c);
-}
diff --git a/arch/mips/boot/compressed/uart-alchemy.c b/arch/mips/boot/compressed/uart-alchemy.c
deleted file mode 100644
index 003967c084b3..000000000000
--- a/arch/mips/boot/compressed/uart-alchemy.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <asm/mach-au1x00/au1000.h>
-
-#include "decompress.h"
-
-void putc(char c)
-{
-	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
-}
diff --git a/arch/mips/boot/compressed/uart-ath79.c b/arch/mips/boot/compressed/uart-ath79.c
deleted file mode 100644
index d686820921be..000000000000
--- a/arch/mips/boot/compressed/uart-ath79.c
+++ /dev/null
@@ -1,2 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include "../../ath79/early_printk.c"
diff --git a/arch/mips/boot/compressed/uart-prom.c b/arch/mips/boot/compressed/uart-prom.c
deleted file mode 100644
index 5fa3b9945333..000000000000
--- a/arch/mips/boot/compressed/uart-prom.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <asm/setup.h>
-
-#include "decompress.h"
-
-void putc(char c)
-{
-	prom_putchar(c);
-}

-- 
2.34.1


