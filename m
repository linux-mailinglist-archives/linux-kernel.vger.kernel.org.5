Return-Path: <linux-kernel+bounces-119933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A87988CF15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008EC3039B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304D813DDDE;
	Tue, 26 Mar 2024 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Zb72DL4v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YMWuQj1x"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899D13DDA7;
	Tue, 26 Mar 2024 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485340; cv=none; b=lgKQ54cSd8ER6n6PuUud3jByE96HSG40tRc9Zzr3Hy7fD+KHJGpWOYkf9QE+AW3W4pgzACFxR83QP3Ly7EYppg6C8/0nDx9knhzJE0wRG+EWgycK50J2QG5x0R8QSJdBDDLnfHjlupUolq6OuzDT+UuJOa9ezvWavamjc/lr6Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485340; c=relaxed/simple;
	bh=5gxIKAjz/XPyXUXeQpHzgCJcCn6meX861yL46fhGilU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d868DIO69Xc3ilCOzWnNRoTV2X0YpqCy+5ff+JOiIevofZnF81oWPNW3zZuyko5zNefTgWAQfPbBdNOo6M3COxYxd8h4QBiN1ihX4JmkutdG8uU6Iww6yiAmhopX5ULWfmeHzFNbohgNZJCyOoJXCHEcX+Mo1tPGpW6qBVIT7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Zb72DL4v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YMWuQj1x; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CD1271140141;
	Tue, 26 Mar 2024 16:35:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 26 Mar 2024 16:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711485337;
	 x=1711571737; bh=e/C1q67PI/7EQxxbtKE/qNjwswKrsxlCTALbNK3+ODM=; b=
	Zb72DL4v0f4gfd/PpWhCf6TV9mtW+qzHac5H3ECBOnMgs7y3q0vFTzf0HFdAT/Nh
	PnEJQrs1UP3QJqrj6cYxF1vFjotYH+hLLfpxvTLeT7zv+H53iQLsRn//il6c3N2t
	8Twahy2y7R9Z2v/2E7ZCntXjCPuJL8N/JQ23Z4oRA+NzXSlHK+qBfrKl1f77+fVk
	PQymT/w8+oEc9Qin6SSpimHvJwKY99DhlSHqit6MagSYk4Oe/HB62FHINWIVoSCm
	55cvGMbxIa6MFisNXG0Z6XLihB7h5NtJ19tp2dXtt8gHjbL1oY3TC1hobrMUinc2
	DEkuQ9+vPYCBLtaOnUGGrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711485337; x=
	1711571737; bh=e/C1q67PI/7EQxxbtKE/qNjwswKrsxlCTALbNK3+ODM=; b=Y
	MWuQj1xvx2khUsMLTtpnTduy2NZts4UPYVXvFWweQbhL8OkAoEfD/r25sahfRyMO
	xeUCMBIUFxiZ2AP3tQzthvvLbx9lERhzoMdU2Kc7MzEQJsqqR6pc2sbYZDqGFA+W
	BlJEXtJzodB/ywPwwgAIgTrLkVgYL5nsny/8qmMV61CRJ8IbBCtwGZmG+4zKJJWN
	tK9xqTT6C2BUrJuf/NHZFHZyukoUnaYm5F1/+HxVFi3w+Bh9vvlYbDPQY5dp3KiF
	6jSPsZE0Ae1/bwHH7a+SrzB5njMM9vk9i9sL0mlLI1vOE8WoctjRyBw49wYuLFOR
	L46yAF8iKsY2CBrWxojLA==
X-ME-Sender: <xms:mTEDZmU3VuPX0XqFLUrZxkmAUIMbkn1CQ9yNJ8foIz0jP2fguO4GmA>
    <xme:mTEDZilwjDB06yiWHSKQiQzZf6mq10wdpthTvnoQCqC0apX2jhjwM4dSztBn0szEz
    ucUQkQGr9xe5sJluNI>
X-ME-Received: <xmr:mTEDZqbvvMMehY-nqqaMvPFF_NH-y2ytXCpZXrdslH5YZ8T4aMx05k0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedvgfegffefueeihedvgfdvvdeukeeiteehvefguedvheek
    ffdvkeefhfeiudeiveenucffohhmrghinhepkedvhedtrdhssgdpuhhhihdrshgspdguvg
    gsuhhgrdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:mTEDZtWZrDwg7FJ2QC_tNHQIHMutZngte9TVx4HRjyThOKri0oiJkw>
    <xmx:mTEDZgmiUqqtl-iOyiFuki5bTmrAo83OCzn_GavQByt3pgD85Dj-sw>
    <xmx:mTEDZiew9XGws5Kn-OCpiEF6LOsrWSMBwDjhmToaoFypKCavcWFblQ>
    <xmx:mTEDZiGccOoTAaB888rni0rh72dPGyMMq2lKC-O4O9KgQDz6bYIsNg>
    <xmx:mTEDZvvyNRKa8_ECzF8O894MRCBA2NsM-Ns73Iw7Dvl70xnrlL4-kA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 16:35:36 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 26 Mar 2024 20:35:34 +0000
Subject: [PATCH v2 2/9] MIPS: debug: Implement low-level debugging
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-mips_debug_ll-v2-2-b64abc76f2a1@flygoat.com>
References: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
In-Reply-To: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10014;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=5gxIKAjz/XPyXUXeQpHzgCJcCn6meX861yL46fhGilU=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjRmw5k966NWnrbaffWBhhpv1YKkdyYc3k9Eq+ad5Zpac
 OfvpAs/OkpZGMQ4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAiQRUMf3i6LI0Xv/no1bGi
 /f0cn9hTu7oCF5S7L1knvyR+oeHpr3sYGa4axAl+7I2WX/L/rPB8XofoMEcV1V4NRav2CEN/Q6s
 XjAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

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
index ecf3278a32f7..bfac35a64ae5 100644
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
index 000000000000..a78d9a55bb35
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
+	subu		t0, a1, 1
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


