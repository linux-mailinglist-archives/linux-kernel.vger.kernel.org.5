Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A207DACB3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjJ2Np7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjJ2Npz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:45:55 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439DDC0;
        Sun, 29 Oct 2023 06:45:53 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7375B3200065;
        Sun, 29 Oct 2023 09:45:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 29 Oct 2023 09:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698587151; x=1698673551; bh=BjhNm0ubpl/jcKdEMNbRDsPIaqKFl+mCdys
        y2aVA1f8=; b=HJXlNYZirEcNXUdBk2IsHsKm8OTzqoBBv0Zd06Febmzd1QeGgCF
        cSirTVv4PnU05dTKgp1iSB12BgrbZv33bmrqeLaYQLoQ5ir7c0+nDK8Dxq1gpcBk
        eRGnTMiU19fzf1NXY61wJzj0wpgvgoIDOCDPH3Vfhx5wFji6bdbn8G6HmAieNFux
        QmHk948l+7iMCdIZz0ZdziZKBSjZuIFGRyuOlLJLS3WuepwLlMtXxMDb5zShIYXP
        k2vzETY4gEpeQQb2hW3AQIPze8mfs0tRKSKCNOS/EafivM31G3utVME+K+eDAvSq
        WPit6NfoCzwhA6kcWZcQ71nne7sOgnsPd9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698587151; x=1698673551; bh=BjhNm0ubpl/jcKdEMNbRDsPIaqKFl+mCdys
        y2aVA1f8=; b=WPlJTfM9RcEzLZ2ApsIwCaCx+UMGiZDFnnpoOKVSOTBipiSI/Qt
        A+Z2NEkuWl60HeXuOCsucnId/egziZQCKgr0LGfMHSVML4g4tl3cBCNouUPrSEFh
        O42ycn7f5CuCg1mjxgy6mWEL37crfbZQJlv2t28UEIy7mZWAwNTMwKgRSld+zVJ4
        FSZnSu1lVBzcS0fLqNsaJOInS9g1HdI0c+tS9cs//1wEsVCqL2zizeEkby7DJwzO
        9ed74J+oYDNjBfgRsDrXHpfV7jw3R4y1XsgJh3KCP3n5LWpRjTEGkjLlDfXRS3gw
        1Eqcwf4sjT0vN90fuGIPV+FqsqUPXxvKddQ==
X-ME-Sender: <xms:D2I-ZSXqtuyf2WcsfHBoJjRXoxKwOMblr-e3SrLUFjqBWOql7_cCtg>
    <xme:D2I-ZekLUViYPb7icykFugDMrrm0PLsTPgkCCu7KOJvfDBmT8P-bs7meRtbqArJLL
    5xahzwokogNpNGfnO0>
X-ME-Received: <xmr:D2I-ZWbAYWtGLXD5QeCLKXVd6nkXzkaJ8k4WzfS2JkalroMF0FQwDW8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvgfegffefueeihedvgfdvvdeukeeiteehvefguedvheekffdv
    keefhfeiudeiveenucffohhmrghinhepkedvhedtrdhssgdpuhhhihdrshgspdguvggsuh
    hgrdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:D2I-ZZX7ZaIf9ac_wrcGeXrqrFT958nm37-Kd6N-pgEYCNRVCIWPyA>
    <xmx:D2I-ZcnAEyU1uK2BGDP947dGdT5-PncVtzDotA1clqsOBe_ZPJ8oEw>
    <xmx:D2I-ZedH0BBQqrxc8la_lkHfuD-e24YTtMc8ID8wtFsRAxYU_Aa_7g>
    <xmx:D2I-ZRy-IH1Vaj-YDFYhcE8IOLjiDjKpqkt780CE8C3DzKDSe0_xIA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 09:45:51 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Sun, 29 Oct 2023 02:53:03 +0000
Subject: [PATCH 2/8] MIPS: debug: Implement low-level debugging functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-mips_debug_ll-v1-2-d7a491e8c278@flygoat.com>
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

Currently we have three sets of early debugging functions
for MIPS: zboot putc/puts, cps-vec-ns16550, and prom_putc.

This is a attempt to bring them all to one by providing
a interface similar to arm's debug_ll, which is very portable
and allows you to support new platforms easily.

Two examples of output interfaces are provided, including
8250 uart and MIPS UHI semihosting, which already covered
most of the platforms.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig.debug        |  80 +++++++++++++++++++++++++
 arch/mips/include/debug/8250.S |  60 +++++++++++++++++++
 arch/mips/include/debug/uhi.S  |  48 +++++++++++++++
 arch/mips/kernel/Makefile      |   2 +
 arch/mips/kernel/debug.S       | 130 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 320 insertions(+)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index f4ae7900fcd3..892e31804982 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -164,3 +164,83 @@ config MIPS_CPS_NS16550_WIDTH
 	  lb/sb instructions.
 
 endif # MIPS_CPS_NS16550_BOOL
+
+# These options are only for real kernel hackers who want to get their hands dirty.
+config DEBUG_LL
+	bool "Kernel low-level debugging functions (read help!)"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to include definitions of printascii, printch, printhex
+	  in the kernel.  This is helpful if you are debugging code that
+	  executes before the console is initialized.
+
+	  Note that selecting this option will limit the kernel to a single
+	  UART or semihosting definition, as specified below. Attempting to
+	  boot the kernel image on a different platform *will not work*, so
+	  this option should not be enabled for kernels that are intended to
+	  be portable.
+
+choice
+	prompt "Kernel low-level debugging port"
+	depends on DEBUG_LL
+
+	config DEBUG_MIPS_UHI
+		bool "Kernel low-level debugging via UHI semihosting"
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  via MIPS UHI semihosting.
+
+	config DEBUG_LL_UART_8250
+		bool "Kernel low-level debugging via 8250 UART"
+		select DEBUG_LL_UART
+		help
+		  Say Y here if you wish the debug print routes to direct
+		  their output to an 8250 UART.  You can use this option
+		  to provide the parameters for the 8250 UART rather than
+		  selecting one of the platform specific options below if
+		  you know the parameters for the port.
+
+endchoice
+
+config DEBUG_LL_INCLUDE
+	string
+	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
+	default "debug/uhi.S" if DEBUG_MIPS_UHI
+	default "debug-macro.S"
+
+# Compatibility options for 8250
+config DEBUG_UART_8250
+	bool
+	select DEBUG_LL_UART
+
+config DEBUG_LL_UART
+	bool
+
+config DEBUG_UART_FLOW_CONTROL
+	bool "Enable flow control (CTS) for the debug UART"
+	depends on DEBUG_LL_UART
+	default n
+	help
+	  Some UART ports are connected to terminals that will use modem
+	  control signals to indicate whether they are ready to receive text.
+	  In practice this means that the terminal is asserting the special
+	  control signal CTS (Clear To Send). If your debug UART supports
+	  this and your debug terminal will require it, enable this option.
+
+config DEBUG_UART_PHYS
+	hex "Physical base address of debug UART"
+	depends on DEBUG_LL_UART
+	help
+	  This is the physical base address of the debug UART. It must be
+	  accessible from unmapped kernel space (i.e. KSEG1 for 32bit kernels
+	  or XKPHYS for 64bit kernels).
+
+config DEBUG_UART_8250_SHIFT
+	int "Register offset shift for the 8250 debug UART"
+	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
+	default 2
+
+config DEBUG_UART_8250_WIDTH
+	int "Register width for the 8250 debug UART"
+	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
+	default 1
diff --git a/arch/mips/include/debug/8250.S b/arch/mips/include/debug/8250.S
new file mode 100644
index 000000000000..f8608d3e271a
--- /dev/null
+++ b/arch/mips/include/debug/8250.S
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ * MIPS Low level debug include file for 8250 UART
+ */
+
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <linux/serial_reg.h>
+
+#define DEBUG_LL_UART
+
+#define UART_BASE	CKSEG1ADDR(CONFIG_DEBUG_UART_PHYS)
+
+#define UART_TX_OFS	(UART_TX  << CONFIG_DEBUG_UART_8250_SHIFT)
+#define UART_LSR_OFS	(UART_LSR << CONFIG_DEBUG_UART_8250_SHIFT)
+#define UART_MSR_OFS	(UART_MSR << CONFIG_DEBUG_UART_8250_SHIFT)
+
+#if CONFIG_DEBUG_UART_8250_WIDTH == 1
+# define UART_L		lb
+# define UART_S		sb
+#elif CONFIG_DEBUG_UART_8250_WIDTH == 2
+# define UART_L		lh
+# define UART_S		sh
+#elif CONFIG_DEBUG_UART_8250_WIDTH == 4
+# define UART_L		lw
+# define UART_S		sw
+#elif defined(CONFIG_64BIT) && CONFIG_DEBUG_UART_8250_WIDTH == 8
+# define UART_L		ld
+# define UART_S		sd
+#else
+# define UART_L		lb
+# define UART_S		sb
+#endif
+
+		.macro	addruart,rd,rx
+		PTR_LA	\rd, UART_BASE
+		.endm
+
+		.macro	senduart,rd,rx
+		UART_S   \rd, UART_TX_OFS(\rx)
+		.endm
+
+		.macro	busyuart,rd,rx
+1002:
+		UART_L	\rd, UART_LSR_OFS(\rx)
+		andi	\rd, \rd, (UART_LSR_TEMT | UART_LSR_THRE)
+		xori	\rd, (UART_LSR_TEMT | UART_LSR_THRE)
+		bnez	\rd, 1002b
+		.endm
+
+		.macro	waituarttxrdy,rd,rx
+		.endm
+
+		.macro	waituartcts,rd,rx
+1001:
+		UART_L	\rd, UART_MSR_OFS(\rx)
+		andi	\rd, UART_MSR_CTS
+		beqz	\rd, 1001b
+		.endm
diff --git a/arch/mips/include/debug/uhi.S b/arch/mips/include/debug/uhi.S
new file mode 100644
index 000000000000..20554523e151
--- /dev/null
+++ b/arch/mips/include/debug/uhi.S
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ * MIPS Low level debug include file for UHI semihosting
+ */
+
+#include <asm/asm.h>
+
+/**
+ * printch() - write a character to UHI Plog
+ * @a0: ASCII character to write
+ *
+ * clobbers v0, t9
+ * UHI may clobber k0, k1
+ */
+		.pushsection .bss
+charbuf_addr:	.space 8
+		.popsection
+NESTED(printch, 0, ra)
+	PTR_LI	t9, charbuf_addr
+	sb	a0, 0(t9)
+	sb	zero, 1(t9)
+	move	a0, t9
+	li	v0, 0x1
+	li	t9, 13 /* plog */
+	.set push
+	.set MIPS_ISA_LEVEL_RAW
+	sdbbp	1
+	.set pop
+	jr	ra
+	END(printch)
+
+/**
+ * printascii() - write a string to UHI Plog
+ * @a0: pointer to NULL-terminated ASCII string
+ *
+ * clobbers v0
+ * UHI may clobber k0, k1
+ */
+NESTED(printascii, 0, ra)
+	li	v0, 0x1
+	li	t9, 13 /* plog */
+	.set push
+	.set MIPS_ISA_LEVEL_RAW
+	sdbbp	1
+	.set pop
+	jr		ra
+	END(printascii)
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 853a43ee4b44..10c0a224efe4 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -78,6 +78,8 @@ obj-$(CONFIG_MIPS32_COMPAT)	+= linux32.o ptrace32.o signal32.o
 obj-$(CONFIG_MIPS32_N32)	+= scall64-n32.o signal_n32.o
 obj-$(CONFIG_MIPS32_O32)	+= scall64-o32.o signal_o32.o
 
+obj-$(CONFIG_DEBUG_LL)		+= debug.o
+
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_PROC_FS)		+= proc.o
 obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
diff --git a/arch/mips/kernel/debug.S b/arch/mips/kernel/debug.S
new file mode 100644
index 000000000000..f71c6c969ef6
--- /dev/null
+++ b/arch/mips/kernel/debug.S
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ * MIPS Low level debug routines
+ *
+ * Note: Those functions are designed carefully to only clobber
+ * t0, t1, t9, so they can be used without stack. Also they are
+ * position independent to be called from any place.
+ */
+
+#include <linux/compiler.h>
+
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/mipsregs.h>
+#include <asm/regdef.h>
+
+#include CONFIG_DEBUG_LL_INCLUDE
+
+#ifdef DEBUG_LL_UART
+/**
+ * printch() - write a character to the UART
+ * @a0: ASCII character to write
+ *
+ * clobbers t0, t9
+ */
+NESTED(printch, 0, ra)
+	addruart	t9, t0
+#ifdef CONFIG_DEBUG_UART_FLOW_CONTROL
+	waituartcts	t0, t9
+#endif
+	waituarttxrdy	t0, t9
+	senduart	a0, t9
+	busyuart	t0, t9
+	jr		ra
+	END(printch)
+
+/**
+ * printascii() - write a string to the UART
+ * @a0: pointer to NULL-terminated ASCII string
+ *
+ * clobbers t0, t1, t9
+ *
+ * Write a null-terminated ASCII string to the UART.
+ */
+NESTED(printascii, 0, ra)
+	addruart	t9, t0
+	move		t1, a0
+
+1:	lb		a0, 0(t1)
+	beqz		a0, 2f
+#ifdef CONFIG_DEBUG_UART_FLOW_CONTROL
+	waituartcts	t0, t9
+#endif
+	waituarttxrdy	t0, t9
+	senduart	a0, t9
+	busyuart	t0, t9
+	PTR_ADDIU	t1, t1, 1
+	b		1b
+
+2:	jr		ra
+	END(printascii)
+#endif /* DEBUG_LL_UART */
+
+/**
+ * printhex() - write n byte hex value to the UART
+ * @a0: Hex value to write to the UART
+ * @a1: number of bytes to write to the UART
+ *
+ * clobbers: t0, t1, t9
+ */
+
+		.pushsection .bss
+hexbuf_addr:	.space 32
+		.popsection
+
+NESTED(printhex, 0, ra)
+	PTR_LA		t9, hexbuf_addr
+	sll		a1, a1, 1
+1:
+    	subu		t0, a1, 1
+	sll		t0, t0, 2
+	LONG_SRLV	t0, a0, t0
+	andi		t0, t0, 0xf
+	li		t1, '0'
+	blt		t0, 10, 2f
+	li		t1, 'a'
+	addiu		t0, t0, -10
+2:
+	addu		t1, t1, t0
+	sb		t1, 0(t9)
+	PTR_ADDIU	t9, t9, 1
+	addiu		a1, a1, -1
+	bnez		a1, 1b
+	sb		zero, 0(t9)
+
+	move		a1, ra
+	PTR_LA		a0, hexbuf_addr
+	bal		printascii
+
+	jr		a1
+	END(printhex)
+
+NESTED(printhex1, 0, ra)
+	li		a1, 1
+	b		printhex
+	END(printhex1)
+
+NESTED(printhex2, 0, ra)
+	li		a1, 2
+	b		printhex
+	END(printhex2)
+
+NESTED(printhex4, 0, ra)
+	li		a1, 4
+	b		printhex
+	END(printhex4)
+
+#ifdef CONFIG_64BIT
+NESTED(printhex8, 0, ra)
+	li		a1, 8
+	b		printhex
+	END(printhex8)
+#endif
+
+NESTED(printhexl, 0, ra)
+	li		a1, PTRSIZE
+	b		printhex
+	END(printhexl)

-- 
2.34.1

