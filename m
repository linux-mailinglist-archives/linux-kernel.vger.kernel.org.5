Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6B37DACB5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjJ2N6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjJ2Np7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:45:59 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451AAC2;
        Sun, 29 Oct 2023 06:45:57 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7A10A3200914;
        Sun, 29 Oct 2023 09:45:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 29 Oct 2023 09:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698587155; x=1698673555; bh=jYhHcxouhYM9tIGaxyoEYXSEAO4S1yV0g4K
        J6UP/5LE=; b=nZfuiwP+PXXle2tGhlSmAI9dBZhPF+nWLnrOezM3i/m4rawbW3p
        1uH8KislQr5NZI2F3+Vp61X2+oA3By4HGscjETcOLPnuPiv3KLrBkMMD+YJAQLxe
        uvbSiNc8c/7SNxyLC7WmbSOTm8HGnAxGwDqqoeyMD1fR1Xfbeee4iwzgxoaU4Kki
        WpjNiLQ/4auZuyeYiudj8zYNQZrproDW1nm4s4kviLGXRGZVdx2XhMA6NbJcUX84
        C3I/jfw/RHy1RwWeZShXr2TM1lX9MOlY2/1eacaqjKVDr6TlsJPWQjBLBRnCFAyz
        4yAieZCNE16A9rUK8kOoxddVY5YeTuBgGXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698587155; x=1698673555; bh=jYhHcxouhYM9tIGaxyoEYXSEAO4S1yV0g4K
        J6UP/5LE=; b=ZabQEQ8l9OG5fXEOUlTQMG2r8x74zsw0B4ybW4XtmEzKio+T30k
        PJjcBWZojguCiS+hBfLJxNRUcDpSchdkAqxs9z9RlJWkYiV2IO6yVdBNATLy8uRV
        31YQSNDIdnkbSxMezXEUZ/A2NCpRx4km+n5bYOBTCFOGX7DtKyCrHwEDNhm9rCRx
        ZMKAfbkPwvdr4xgfDBfYKia60HZjr5vk6h5MFInQfpi+3d+ked9M5N8vjP+ymJo8
        44kvcLTzyjeVLYRkGgjQ9lnGVNKFHODjoLsDnjSIKkpT+1H7IfzkWWVHsY0jkNPM
        q5QFOhn+1eT+sBsQrbZVF1GQrPt6FgimrDQ==
X-ME-Sender: <xms:E2I-ZYeinM0-QXWgNo8Cvdqp_CwQ-BnAq1bbbdf2P4_WznqX_5WeIA>
    <xme:E2I-ZaOZIHTV9IfbX5f9mRfHj9ubwOORMlpFw-Jg6st5wELyzmUt4-9UqSzcovpYR
    E5sTYlHdPBD1mIKY3M>
X-ME-Received: <xmr:E2I-ZZg0jq-8VBxmaZ2tzfgqPG0i8WP3rMLuUklXxs8zsWRgnMif_kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeelieduudfftdegfeeukeduudevkeegtdeliefhfeeggfevleef
    ledvgeeftdelteenucffohhmrghinhepuggvsghughdqvhgvtgdrshgspdhnohhprdhorh
    hgpdhhvggrugdrshgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:E2I-Zd9g0BNP6JdUtXXHUw5IWDsWGXw-Sg61MTXhWwQA8pEkuhqgIg>
    <xmx:E2I-ZUtdmZK5k_ylaudndMe_DTDKB6x2KhmTyRHQbA5wNv8WkkPc_A>
    <xmx:E2I-ZUG3KMF9KZ-NzeHHQ98SEwzmLSIVHFWUmOrSCnMhvkKZYuE5vg>
    <xmx:E2I-Zd6oWPT-DKBXKBlm5cOktznJR1iUyyoEnIontJsJXoKpAVR9Iw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 09:45:55 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Sun, 29 Oct 2023 02:53:05 +0000
Subject: [PATCH 4/8] MIPS: debug: Provide an early exception vector for
 low-level debugging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-mips_debug_ll-v1-4-d7a491e8c278@flygoat.com>
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

This is helpful for debugging of early boot crash when exceptions
happens before trap_init(), or for debugging SMP bringup code.

It will install exception handler very early on kernel_entry by
setting ebase or copy itself to start of CKSEG0, and print off
exception vectors and other status registers like:

Low level exception: ffffffff8011e180

GlobalNumber: 0x00000000
EBase:    0xffffffff8011e000
Xcontext: 0x0000000000000000
Cause:    0x0000000c
Status:   0x14000082
EPC:      0xffffffff80d324e0
BadVAddr: 0x0000000000000000
BadInstr: 0xac000000

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig.debug      |   9 ++
 arch/mips/kernel/Makefile    |   1 +
 arch/mips/kernel/debug-vec.S | 194 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/head.S      |   4 +
 4 files changed, 208 insertions(+)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 6ef42edc7d67..323ad3ec643b 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -180,6 +180,15 @@ config DEBUG_LL
 	  this option should not be enabled for kernels that are intended to
 	  be portable.
 
+config DEBUG_LL_EXCEPT
+	bool "Kernel low-level debugging of exceptions"
+	depends on DEBUG_LL
+	help
+	  Say Y here to enable debugging prints for low-level exceptions.
+	  This is helpful if you are debugging a early boot crash when
+	  exceptions happens before trap_init(), or if you are debugging
+	  SMP bringup code.
+
 choice
 	prompt "Kernel low-level debugging port"
 	depends on DEBUG_LL
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 10c0a224efe4..400e35f9f82f 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_MIPS32_N32)	+= scall64-n32.o signal_n32.o
 obj-$(CONFIG_MIPS32_O32)	+= scall64-o32.o signal_o32.o
 
 obj-$(CONFIG_DEBUG_LL)		+= debug.o
+obj-$(CONFIG_DEBUG_LL_EXCEPT)	+= debug-vec.o
 
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_PROC_FS)		+= proc.o
diff --git a/arch/mips/kernel/debug-vec.S b/arch/mips/kernel/debug-vec.S
new file mode 100644
index 000000000000..4530bf3d5b75
--- /dev/null
+++ b/arch/mips/kernel/debug-vec.S
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2023, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *  MIPS Low level exception vectors and handler
+ */
+
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/asmmacro.h>
+
+
+.balign 0x1000
+LEAF(debug_ll_vecs)
+	.set	push
+	.set	noreorder
+	move	a0, zero
+	PTR_LA  t9, debug_ll_exception
+	jalr	t9
+	nop
+	b	.
+	nop
+
+.org	0x80
+	move	a0, zero
+	PTR_LA  t9, debug_ll_exception
+	jalr	t9
+	nop
+	b	.
+	nop
+
+.org	0x100
+	move	a0, zero
+	PTR_LA  t9, debug_ll_exception
+	jalr	t9
+	nop
+	b	.
+	nop
+
+.org	0x180
+	move	a0, zero
+	PTR_LA  t9, debug_ll_exception
+	jalr	t9
+	nop
+	b	.
+	nop
+
+.org	0x200
+	move	a0, zero
+	PTR_LA  t9, debug_ll_exception
+	jalr	t9
+	nop
+	b	.
+	nop
+
+.org	0x280
+	move	a0, zero
+	PTR_LA  t9, debug_ll_exception
+	jalr	t9
+	nop
+	b	.
+	nop
+
+.org	0x300
+	move	a0, zero
+	PTR_LA  t9, debug_ll_exception
+	jalr	t9
+	nop
+	b	.
+	nop
+
+.org	0x380
+	move	a0, zero
+	PTR_LA  t9, debug_ll_exception
+	jalr	t9
+	nop
+	b	.
+	nop
+
+.org	0x400
+	move	a0, zero
+	PTR_LA  t9, debug_ll_exception
+	jalr	t9
+	nop
+	b	.
+	nop
+
+.org	0x480
+	move	a0, zero
+	PTR_LA  t9, debug_ll_exception
+	jalr	t9
+	nop
+	b	.
+	nop
+
+	.set	pop
+END(debug_ll_vecs)
+
+
+/**
+ * debug_ll_exception() - dump relevant exception state to LL outputs
+ * @a0: pointer to NULL-terminated ASCII string naming the exception
+ *
+ * If a0 is NULL, it will print out exception vector number calculated
+ * from the ra insted. This is useful for debugging exceptions that
+ * happen before the exception handler is set up, or routed from BEV.
+ */
+LEAF(debug_ll_exception)
+	move		k0, ra
+	move		k1, a0
+	PTR_LA		t3, printascii
+
+	PTR_LA		a0, str_newline
+	jalr		t3  /* Call printascii */
+	PTR_LA		a0, str_exp
+	jalr		t3  /* Call printascii */
+	beqz		k1, 1f
+	move		a0, k1
+	jalr		t3  /* Call printascii */
+	b		2f
+1:
+	PTR_SRL		a0, k0, 7
+	PTR_SLL		a0, a0, 7
+	PTR_LA		t2, printhexl
+	jalr		t2
+2:
+	PTR_LA		a0, str_newline
+	jalr		t3  /* Call printascii */
+	PTR_LA		a0, str_newline
+	jalr		t3  /* Call printascii */
+
+#define DUMP_COP0_REG(reg, name, sz, _mfc0)		\
+	PTR_LA		a0, 8f;				\
+	jalr		t3;				\
+	_mfc0		a0, reg;			\
+	PTR_LA		t2, printhex##sz;		\
+	jalr		t2;				\
+	PTR_LA		a0, str_newline;		\
+	jalr		t3;				\
+	TEXT(name)
+
+#if defined(CONFIG_SMP) && defined(CONFIG_CPU_MIPSR6)
+	DUMP_COP0_REG(CP0_GLOBALNUMBER, "GlobalNumber: 0x", 4, mfc0)
+#endif
+#if MIPS_ISA_REV >= 2
+	DUMP_COP0_REG(CP0_EBASE,    "EBase:    0x", l, MFC0)
+#endif
+#ifdef CONFIG_64BIT
+	DUMP_COP0_REG(CP0_XCONTEXT, "Xcontext: 0x", 8, dmfc0)
+#else
+	DUMP_COP0_REG(CP0_CONTEXT,  "Context:  0x", 4, mfc0)
+#endif
+	DUMP_COP0_REG(CP0_CAUSE,    "Cause:    0x", 4, mfc0)
+	DUMP_COP0_REG(CP0_STATUS,   "Status:   0x", 4, mfc0)
+	DUMP_COP0_REG(CP0_EPC,      "EPC:      0x", l, MFC0)
+	DUMP_COP0_REG(CP0_BADVADDR, "BadVAddr: 0x", l, MFC0)
+#if MIPS_ISA_REV >= 6
+	DUMP_COP0_REG(CP0_BADINSTR, "BadInstr: 0x", 4, mfc0)
+#endif
+	PTR_LA		a0, str_newline
+	jalr		t3  /* Call printascii */
+	jr		k0
+	END(debug_ll_exception)
+
+.pushsection	.rodata.str
+str_exp: .asciiz "Low level exception: "
+str_newline: .asciiz "\r\n"
+.popsection
+
+NESTED(setup_debug_ll_exception, 0, ra)
+	PTR_LA		t0, debug_ll_vecs
+#if MIPS_ISA_REV >= 2
+	/* Set ebase to debug_ll_vecs */
+#if defined (CONFIG_64BIT) && !defined(KBUILD_64BIT_SYM32)
+	ori		t0, MIPS_EBASE_WG
+#endif
+	MTC0		t0, CP0_EBASE
+#else
+	/* Copy debug_ll_vecs to start of KSEG0 */
+	PTR_LI		t1, CKSEG0
+	PTR_ADDIU	t2, t0, 0x400 /* Only copy 0x400 as that is what reserved on old systems */
+copy_word:
+	PTR_LW		t3, 0(t0)
+	PTR_SW		t3, 0(t1)
+	PTR_ADDIU	t0, t0, PTRSIZE
+	PTR_ADDIU	t1, t1, PTRSIZE
+	PTR_BNE		t0, t2, copy_word
+#endif
+	/* Clear BEV bit in status register */
+	mfc0		t0, CP0_STATUS
+	and		t0, t0, ~ST0_BEV
+	mtc0		t0, CP0_STATUS
+	jr		ra
+	END(setup_debug_ll_exception)
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index b825ed4476c7..9be1c4ce6324 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -106,6 +106,10 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 	LONG_S		a2, fw_arg2
 	LONG_S		a3, fw_arg3
 
+#ifdef CONFIG_DEBUG_LL_EXCEPT
+	jal		setup_debug_ll_exception
+#endif
+
 	MTC0		zero, CP0_CONTEXT	# clear context register
 #ifdef CONFIG_64BIT
 	MTC0		zero, CP0_XCONTEXT

-- 
2.34.1

