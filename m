Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44657DACAC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjJ2NqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjJ2NqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:46:08 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33080C1;
        Sun, 29 Oct 2023 06:46:05 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 624D8320027A;
        Sun, 29 Oct 2023 09:46:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 29 Oct 2023 09:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698587163; x=1698673563; bh=VVYQuKINHnFBqLPFiy0T5mZFPavh5Li6d87
        JmtCWe1g=; b=r4/sB/RNAf+8H/ZblgdqntptF1qsxVLiggVCcaODYwPTMuTPxsW
        BtJnenaecIW2fUx7LXBJQTC7PQ5cIoRoNxozUnMoNKN2UemL4XvbgFRCv4ApFC8A
        zX5HNfHQ8r9eCDvAkKF/D4XHub1O6EhvIEUJlf96IqwUm4nPEr8PnxNtZtQ6SBPz
        yzHF/GtzgwH0Gs0kG6Ojvuxkyx8FWHgS3EIcz8M6ZJBOMEx/gNWXEzPaNkAXU+dE
        PcKhgx53i1sJD5Kg2pUnvNKctllG4SZsUG3SZh69G9++hH+26XTa/aIy5D7t/0wu
        eCIxUb1AY/F0PUOCQWf84G9u2UayL3m1Scg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698587163; x=1698673563; bh=VVYQuKINHnFBqLPFiy0T5mZFPavh5Li6d87
        JmtCWe1g=; b=qLprJQ/cZj/lB6XRG7ZcXsGloRyM+Du2tFgSSEpTgbuKyXKzGqt
        UaxhbLDwENuxNzFAydMVJwAPyhg6A4z1qrmbB68At2LY6ltoDXjq+6yJhGLarAX0
        E+vlBnie7/1WbW8sgKOqcjEjIvBf9arMGTeU5RlrQ8OY16VmR4yt1198N0aQ+vf1
        Msu6dttZWuHaFC04k7InfRHH2AjVdr79vXc+59nxJwHEzoks3qGNVMXcPr97CzfN
        lJLGMmD4yh6c86fj1eqcRTzZBP09wDCHNST48+KJq+6pR547QmJm/CRkoJC+QOJy
        zQ3pnZKcIg7bYFJsSFnvv4likhNW/d6+Hig==
X-ME-Sender: <xms:G2I-ZSUfKvj2k-SRO0hQ7iCmIS-d_G4_EchENqKtkKG1437jOgvbzQ>
    <xme:G2I-Zemc_JUwhTh0dHZ3W0gUyOlwtb8rgVtoTtbRxWmeZ_xh7sTb2_DexFE4pT6Lu
    8-UF3rLeijWT-9mKuY>
X-ME-Received: <xmr:G2I-ZWZ9tH2DymZ7abOT_o2FQBhbVgeLZojQg8fWS6HgddIXHPHAmvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeduudekveevvddtffegkeevieehheehieejueekkedvuddvheeg
    heevueeujeehheenucffohhmrghinhepuggvsghughdqvhgvtgdrshgspdguvggsuhhgrd
    hssgdphhgvrggurdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:G2I-ZZV0bgGtZu50nsqCs69CiU8G_fIUqPqOYXyCtxUzEj81cC9dHQ>
    <xmx:G2I-ZclFZcRdKybkKt_9MdalhlTdthw_4HNpA8o8oMVS3AdLcDGBrw>
    <xmx:G2I-ZefoA8Bd1voDJdH-atSbVqsYpeXP0MSiah5vgkD84d-kYBl08A>
    <xmx:G2I-ZRzjPeEZdLrwxcqsp0QVRIgXazxjcbw1Gsi_pqB3TCHyrVtQvQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 09:46:03 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Sun, 29 Oct 2023 02:53:09 +0000
Subject: [PATCH 8/8] MIPS: zboot: Convert to use debug_ll facilities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-mips_debug_ll-v1-8-d7a491e8c278@flygoat.com>
References: <20231029-mips_debug_ll-v1-0-d7a491e8c278@flygoat.com>
In-Reply-To: <20231029-mips_debug_ll-v1-0-d7a491e8c278@flygoat.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since now debug_ll facilities can cover all platforms supported
by zboot debug print, and it provides extra capability on debugging
exceptions, switch zboot to use those facilities.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig                        | 12 ++------
 arch/mips/Kconfig.debug                  | 46 +++++++++++++------------------
 arch/mips/boot/compressed/Makefile       |  9 ++----
 arch/mips/boot/compressed/dbg.c          | 37 -------------------------
 arch/mips/boot/compressed/debug-vec.S    |  3 ++
 arch/mips/boot/compressed/debug.S        |  3 ++
 arch/mips/boot/compressed/decompress.c   |  6 ++--
 arch/mips/boot/compressed/head.S         |  6 ++++
 arch/mips/boot/compressed/uart-16550.c   | 47 --------------------------------
 arch/mips/boot/compressed/uart-alchemy.c |  7 -----
 arch/mips/boot/compressed/uart-ath79.c   |  2 --
 arch/mips/boot/compressed/uart-prom.c    |  7 -----
 12 files changed, 39 insertions(+), 146 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 76db82542519..0442b44da32f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -232,7 +232,7 @@ config ATH79
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_MIPS16
-	select SYS_SUPPORTS_ZBOOT_UART_PROM
+	select SYS_SUPPORTS_ZBOOT
 	select USE_OF
 	select USB_EHCI_ROOT_HUB_TT if USB_EHCI_HCD_PLATFORM
 	help
@@ -413,7 +413,7 @@ config MACH_INGENIC_SOC
 	bool "Ingenic SoC based machines"
 	select MIPS_GENERIC
 	select MACH_INGENIC
-	select SYS_SUPPORTS_ZBOOT_UART16550
+	select SYS_SUPPORTS_ZBOOT
 	select CPU_SUPPORTS_CPUFREQ
 	select MIPS_EXTERNAL_TIMER
 
@@ -1727,14 +1727,6 @@ config SYS_SUPPORTS_ZBOOT
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
index f6728a8fd1c3..000000000000
--- a/arch/mips/boot/compressed/dbg.c
+++ /dev/null
@@ -1,37 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * MIPS-specific debug support for pre-boot environment
- *
- * NOTE: putc() is board specific, if your board have a 16550 compatible uart,
- * please select SYS_SUPPORTS_ZBOOT_UART16550 for your machine. othewise, you
- * need to implement your own putc().
- */
-#include <linux/compiler.h>
-#include <linux/types.h>
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
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index c5dd415254d3..2317f44307e1 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -31,8 +31,10 @@ extern unsigned char __image_begin[], __image_end[];
 
 /* debug interfaces  */
 #ifdef CONFIG_DEBUG_ZBOOT
-extern void puts(const char *s);
-extern void puthex(unsigned long long val);
+extern void printascii(const char *s);
+extern void printhexl(unsigned long val);
+#define puts(s) printascii(s)
+#define puthex(val) printhexl(val)
 #else
 #define puts(s) do {} while (0)
 #define puthex(val) do {} while (0)
diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index 5795d0af1e1b..c347d2273ae8 100644
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
index 09dcd2c561d9..000000000000
--- a/arch/mips/boot/compressed/uart-16550.c
+++ /dev/null
@@ -1,47 +0,0 @@
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
index 8ec63011e7dc..000000000000
--- a/arch/mips/boot/compressed/uart-alchemy.c
+++ /dev/null
@@ -1,7 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <asm/mach-au1x00/au1000.h>
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
index a8a0a32e05d1..000000000000
--- a/arch/mips/boot/compressed/uart-prom.c
+++ /dev/null
@@ -1,7 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <asm/setup.h>
-
-void putc(char c)
-{
-	prom_putchar(c);
-}

-- 
2.34.1

