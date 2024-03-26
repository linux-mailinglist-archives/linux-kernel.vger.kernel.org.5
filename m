Return-Path: <linux-kernel+bounces-119935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4387088CF19
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCCB325688
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B6413D510;
	Tue, 26 Mar 2024 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="NASBzx5x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U0yE4MaK"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9213DDA4;
	Tue, 26 Mar 2024 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485342; cv=none; b=pse5ptxzuyNCVAJxsWCxmC7yG1O0+cKb6EoiH3Igus2Mv1ACRTz+SgRTE0GP6d7jgP1ENxj2ceyjHh4CyFQpvLXaCctGN6yoJAE5uK10rj3ku0Q+OrEfj9pPAkfvIEl9BZDjP5J0+0V+LN7vY+im1zPLbg3PJp06eKyPut4iq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485342; c=relaxed/simple;
	bh=jlhEoHOSgN8X4mEVHK3jfYatKD2DB6Py/q55teajpWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RVo8MUjBBSZ4DAD6YU18TFzhscvLjmMRe3a2WmOcAe6cHpigQ9TfaDSTh/uKepWiJL4qOwA98gdfq65FjLL6cqL06+JEgHKy/OVOp0nwycNbCKWuX6zITmV4XUIWT+PNlE97Pa4KhHBg/u0Flu3wRxE3SR7QgEqMQFXJppe+Aws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=NASBzx5x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U0yE4MaK; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E6D6E1140137;
	Tue, 26 Mar 2024 16:35:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 26 Mar 2024 16:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711485339;
	 x=1711571739; bh=IXEZ+++T7A/WGhf4gt5z4YISaz7Aa20LiIfPlp0S5ok=; b=
	NASBzx5x3AZHN/8xTavsXMtqqIeyvHzkGTI8q4LBdUvcjQVhqdH/uIzEwEUH2dm5
	RFhSR9QToYTLe8/iD4u8Tz5SBk/UgU46z87zYyJ3ECeFhx0/gBeXnoI/6PPHELt3
	pFMgVCQ/+5q5uJXPL+RmMlSuoya6KYsPf59T4EtgeJU3SN+DDBYbvJQ6kdc+h6Bn
	4Dj36W4eYr7/DY48ZWtJKjamL+5/XMNfyj0c5S8HQ2KYOnChYhe6+Q5+jlwucvMd
	mYl4wNr9raYCwz4FfYkknMdrY0G14bZz2cT4YbEMqMwxuxl274pCAav+m7wWTXw1
	mudLkBUBuZXT2EiGN3AiNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711485339; x=
	1711571739; bh=IXEZ+++T7A/WGhf4gt5z4YISaz7Aa20LiIfPlp0S5ok=; b=U
	0yE4MaKVfibwpLkIZUWU9mhARQibvY+Amagv6YSfNNuDGPdK/mhQ7SXpRiEfncyh
	5G6lu2OfWXq4IrRKMrYoMby+P5+y/gtSvvAeawgK3N5mzNO+3LsXjaN1FhTcNjx7
	XNhA2fBvJe+STH5Qw63yboOrKuu9r7kjEq8mDHbGmDsM0Xd4kf6Q1ffqsN8hNB8S
	Dpe49oWOK+2EwlXnaOoc3wxXUjQMKw9GpsasCvo4VKHboIhLffhAAntbx/hhJGhM
	oYJMIkBKuzBEWcnNRPPLlxpMDLtq1e5xQO41iP0dUg+BCSNL9oFXjKbFd5TnDH0V
	Xs1/wTnOtRZnBQuXWHwtw==
X-ME-Sender: <xms:mzEDZt9e2fvr8To56f09QR7yV_kUOdZETgfgNRrU8b_XB8Y4tCrTPw>
    <xme:mzEDZhvbU6Z8nOjY6JQBwM7gCTYIpzZ6AJCEmoJxlR5F9QgNbl24mMcRBlD9WwW2q
    M_aVcyd0aPYzO_mvBk>
X-ME-Received: <xmr:mzEDZrDk0oa00rJeZPj3HPesak-ER-uD4dslUqL9gAopuuWyqWQ8h1s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeelieduudfftdegfeeukeduudevkeegtdeliefhfeeggfev
    leefledvgeeftdelteenucffohhmrghinhepuggvsghughdqvhgvtgdrshgspdhnohhprd
    horhhgpdhhvggrugdrshgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:mzEDZhfrZJi-bO9I9oMABjB5-DToh4X9K7VvX7RZI2G-_ksxXButhg>
    <xmx:mzEDZiOHpnUMCJVC908cuhK6CG89YLgcmpwpBcU_hD55jH2oq0pEsw>
    <xmx:mzEDZjmYeyTgibhXeQTQPlwWF_W_NPi-f-BozRrx1XASzYjUK5Pv9A>
    <xmx:mzEDZsuXjMhZqhEWDfFTTPmIRvjENUxhrBt2jQP2KMPUXfhNqMYgxw>
    <xmx:mzEDZp0g85izrsZqaLAo6At10SNak1M0u5wyo361gRMsRnK4GdSYKg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 16:35:38 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 26 Mar 2024 20:35:36 +0000
Subject: [PATCH v2 4/9] MIPS: debug: Provide an early exception vector for
 low-level debugging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-mips_debug_ll-v2-4-b64abc76f2a1@flygoat.com>
References: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
In-Reply-To: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6831;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=jlhEoHOSgN8X4mEVHK3jfYatKD2DB6Py/q55teajpWU=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjRmw5mPrZz1WM8feG28XUHW2PBB1Iurfn/m5t64sME1i
 tNwmo5nRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExELZmR4a7jOeMZzLvd/+td
 kC/P2bRGa+65W9Fv12w/5XPI8OEHjSJGhh7tH7v+pmvWT2ArYJvnJ+axrZuHl+cGv6Jw+sKdG3K
 r2QA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

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
index bfac35a64ae5..6641c3370e68 100644
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


