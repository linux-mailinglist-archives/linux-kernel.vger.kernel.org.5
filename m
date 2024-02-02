Return-Path: <linux-kernel+bounces-50314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EFC84774D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76681C23DB6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5732814E2C0;
	Fri,  2 Feb 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="GbUoij+M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wlii2G/A"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF712151CCA;
	Fri,  2 Feb 2024 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898138; cv=none; b=T05XnOa02ZjHJjhFuqvAHys9n8hlOUDsK1SFvHjqreGkKvzp/EHnFn6/4GTXNAORNlwAK8bJNyQwRYraePj7ef6KGMVuWQbhsdAmRhVdHFLbKy04qm63TMmAbVdYyPVzy22P8qkIE+40An5NH5wl1U1v7pKm2jaz9l11YULSt2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898138; c=relaxed/simple;
	bh=YjTBZ8cpVs/d0tQGcFu2zYjjAAYAPyu7887lmJOQ2iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ped2MlJ0g5AZleBngik1s+9I+KzS72jmBFJb1XzyvHmiTjxx62lXWEN/QoocAtqsz0J250/sND5fBamnA9sOkNNsd6JmRpcJxRUo/Nd+Lz9PS1HZnFc+1uIdusQtc+ukQ3iS01QEq1PUpuN6efV9RMN4ymi52KBOkFhQE6LpyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=GbUoij+M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wlii2G/A; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 89DDA32009F9;
	Fri,  2 Feb 2024 13:22:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 02 Feb 2024 13:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706898134;
	 x=1706984534; bh=kN+Tzvk742jUfjiEPOWlEG5RSH0lecf7eek117CaFiA=; b=
	GbUoij+MjvOFQVRuR1fAxNyfmNTtxp+clhMLSING46NCslU+6U7444eBHNk3HRl0
	JIO+fNocEN2P4I2LI35qAdWqB+qajv5ONsYUwbvxpMtkza58o4UOZ3hCXdjh8ntx
	SzDdAdQDo0N2GH5WTMh1QZk/tSOc7vMzWocmUqb0lTjXSqi/PCOUlCBDf4wIX0c4
	SPmbrbKekCM9kLD2J0dyicUHCaMp8QwzkZ2r+4RkmkDBUgl/y/0LW4sGLO21RNpH
	/iAu7WCCi2o5nCq1JI7AXZbOeJWMIcZ+heIzUtcV4j9D9qGVLDfDCQsY6RsapAUC
	m2MNn9DWFzwBUoIEAc9IXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706898134; x=
	1706984534; bh=kN+Tzvk742jUfjiEPOWlEG5RSH0lecf7eek117CaFiA=; b=w
	lii2G/AkTHFNikbzma7hXrHneyHSpGF2RQwkl7QGMHMhaqP130LlhCoXTIsW2qOq
	X35WEDA6srrRHteoR8Qzj+Ej1vgSGgpxg2wRMLdwufCHpcGgXYT3yjPknCO1+u8O
	JvumKQ2cqwAwrtP5iVWkYYeu8BOHYwUViiYM7CA2X3NLi3XDQYa4poj1b/JhyBjO
	26oA0dagSgttwK0BFbEcGfqF1aiHZdBz5j3YJG/zDmJbU8itqyoNwbeU2BaU18Aw
	GLsdFGWWJpYVXVccm1UfqygphNP64doiIsG2gNhE+HYmkhOypP/IF2js5VeUeWp1
	SIhblYvOyAzE7AFFyoOAA==
X-ME-Sender: <xms:1jK9ZS4rW8CxYBL51i2AArfHusl-TI9O7BgOKRlQL46z1sRHa52xjg>
    <xme:1jK9Zb7S-smk9eGbZYpnAHX1WIsoYfwVKMIphvZ93fCJnqG4bdM0brlNi302e_crk
    bPblBxlHuI7QnvdBSY>
X-ME-Received: <xmr:1jK9ZRfHqlslo-qYFuPjuwXVZ80LfPYlb-UAR-0IGW-Z8cioSnUuD9yCHvtr1IZuNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeevveetheeggfegjeekjedttdetueeludehveejgfejtedv
    hfdugeetgfelhfevkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:1jK9ZfLarDb8ItDAuELOX8iMiMDctmorFKeTfuqM9zVz-M9um3YUxg>
    <xmx:1jK9ZWJpqoMl3nDU4H6K8pqItILIrBOMuLcyxAX6rTSc5ln_AG5_Jw>
    <xmx:1jK9ZQyHe81IVi4d04ZQNUwKUIAIoDURNtN2eENSriSHsEMzCJytlQ>
    <xmx:1jK9ZXqI1u435qdh_vn0a7fyYEmO-KIiaK4k3LHagBwg1Z9C1Exs3w>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 13:22:13 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 02 Feb 2024 18:21:46 +0000
Subject: [PATCH 7/8] MIPS: Implement microMIPS MT ASE helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240202-llvm-msym32-v1-7-52f0631057d6@flygoat.com>
References: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
In-Reply-To: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=14695;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=YjTBZ8cpVs/d0tQGcFu2zYjjAAYAPyu7887lmJOQ2iU=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtS9Rnv4OWzvTmaJkpXasfP1xvsTJq2O6o/PuOj34MCW8
 1eK71240FHKwiDGxSArpsgSIqDUt6Hx4oLrD7L+wMxhZQIZwsDFKQATudbAyPBVbbdhRtW+3evD
 GcuOPF72sexd69Zbgdeb+jaYsa2pqrrAyDD5gwzDQc0+XusCr+BVFatq42Z7vU3cqRml2DPtzSr
 uHC4A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Implement various microMIPS MT ASE helpers accroading to:

MIPS® Architecture for Programmers
Volume IV-f: The MIPS® MT Module for the microMIPS32™ Architecture

Fixes build error:
{standard input}:2616: Error: branch to a symbol in another ISA mode

This make MT ASE available on microMIPS as well.

Boot tested on M5150 with microMIPS enabled on M5150.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v1: MTTGPR takes register name as rt
---
 arch/mips/include/asm/asmmacro.h   |  22 ++--
 arch/mips/include/asm/mipsmtregs.h | 256 ++++++++++++++++++++++---------------
 arch/mips/include/asm/mipsregs.h   |   9 ++
 arch/mips/kernel/vpe-mt.c          |   4 +-
 4 files changed, 179 insertions(+), 112 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 067a635d3bc8..18c2ae58cdf3 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -216,27 +216,33 @@
  * Temporary until all gas have MT ASE support
  */
 	.macro	DMT	reg=0
-	.word	0x41600bc1 | (\reg << 16)
+	insn_if_mips	0x41600bc1 | (\reg << 16)
+	insn32_if_mm    0x0000057C | (\reg << 21)
 	.endm
 
 	.macro	EMT	reg=0
-	.word	0x41600be1 | (\reg << 16)
+	insn_if_mips	0x41600be1 | (\reg << 16)
+	insn32_if_mm    0x0000257C | (\reg << 21)
 	.endm
 
 	.macro	DVPE	reg=0
-	.word	0x41600001 | (\reg << 16)
+	insn_if_mips	0x41600001 | (\reg << 16)
+	insn32_if_mm    0x0000157C | (\reg << 21)
 	.endm
 
 	.macro	EVPE	reg=0
-	.word	0x41600021 | (\reg << 16)
+	insn_if_mips	0x41600021 | (\reg << 16)
+	insn32_if_mm    0x0000357C | (\reg << 21)
 	.endm
 
-	.macro	MFTR	rt=0, rd=0, u=0, sel=0
-	 .word	0x41000000 | (\rt << 16) | (\rd << 11) | (\u << 5) | (\sel)
+	.macro	MFTR	rs=0, rt=0, u=0, sel=0
+	insn_if_mips	0x41000000 | (\rt << 16) | (\rs << 11) | (\u << 5) | (\sel)
+	insn32_if_mm	0x0000000E | (\rt << 21) | (\rs << 16) | (\u << 10) | (\sel << 4)
 	.endm
 
-	.macro	MTTR	rt=0, rd=0, u=0, sel=0
-	 .word	0x41800000 | (\rt << 16) | (\rd << 11) | (\u << 5) | (\sel)
+	.macro	MTTR	rt=0, rs=0, u=0, sel=0
+	insn_if_mips	0x41800000 | (\rt << 16) | (\rs << 11) | (\u << 5) | (\sel)
+	insn32_if_mm	0x00000006 | (\rt << 21) | (\rs << 16) | (\u << 10) | (\sel << 4)
 	.endm
 
 #ifdef TOOLCHAIN_SUPPORTS_MSA
diff --git a/arch/mips/include/asm/mipsmtregs.h b/arch/mips/include/asm/mipsmtregs.h
index a8d67c2f4f7b..30e86861c206 100644
--- a/arch/mips/include/asm/mipsmtregs.h
+++ b/arch/mips/include/asm/mipsmtregs.h
@@ -189,19 +189,24 @@ static inline unsigned core_nvpes(void)
 	return ((conf0 & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT) + 1;
 }
 
+#define _ASM_SET_DVPE							\
+	_ASM_MACRO_1R(dvpe, rt,						\
+			_ASM_INSN_IF_MIPS(0x41600001 | __rt << 16)	\
+			_ASM_INSN32_IF_MM(0x0000157C | __rt << 21))
+#define _ASM_UNSET_DVPE ".purgem dvpe\n\t"
+
 static inline unsigned int dvpe(void)
 {
 	int res = 0;
 
 	__asm__ __volatile__(
-	"	.set	push						\n"
-	"	.set	noreorder					\n"
-	"	.set	noat						\n"
-	"	.set	mips32r2					\n"
-	"	.word	0x41610001		# dvpe $1		\n"
-	"	move	%0, $1						\n"
-	"	ehb							\n"
-	"	.set	pop						\n"
+	"	.set	push					\n"
+	"	.set	"MIPS_ISA_LEVEL"			\n"
+	_ASM_SET_DVPE
+	"	dvpe	%0					\n"
+	"	ehb						\n"
+	_ASM_UNSET_DVPE
+	"	.set	pop					\n"
 	: "=r" (res));
 
 	instruction_hazard();
@@ -209,16 +214,22 @@ static inline unsigned int dvpe(void)
 	return res;
 }
 
+#define _ASM_SET_EVPE							\
+	_ASM_MACRO_1R(evpe, rt,					\
+			_ASM_INSN_IF_MIPS(0x41600021 | __rt << 16)	\
+			_ASM_INSN32_IF_MM(0x0000357C | __rt << 21))
+#define _ASM_UNSET_EVPE ".purgem evpe\n\t"
+
 static inline void __raw_evpe(void)
 {
 	__asm__ __volatile__(
-	"	.set	push						\n"
-	"	.set	noreorder					\n"
-	"	.set	noat						\n"
-	"	.set	mips32r2					\n"
-	"	.word	0x41600021		# evpe			\n"
-	"	ehb							\n"
-	"	.set	pop						\n");
+	"	.set	push					\n"
+	"	.set	"MIPS_ISA_LEVEL"			\n"
+	_ASM_SET_EVPE
+	"	evpe    $0					\n"
+	"	ehb						\n"
+	_ASM_UNSET_EVPE
+	"	.set	pop					\n");
 }
 
 /* Enable virtual processor execution if previous suggested it should be.
@@ -232,18 +243,24 @@ static inline void evpe(int previous)
 		__raw_evpe();
 }
 
+#define _ASM_SET_DMT							\
+	_ASM_MACRO_1R(dmt, rt,						\
+			_ASM_INSN_IF_MIPS(0x41600bc1 | __rt << 16)	\
+			_ASM_INSN32_IF_MM(0x0000057C | __rt << 21))
+#define _ASM_UNSET_DMT ".purgem dmt\n\t"
+
 static inline unsigned int dmt(void)
 {
 	int res;
 
 	__asm__ __volatile__(
-	"	.set	push						\n"
-	"	.set	mips32r2					\n"
-	"	.set	noat						\n"
-	"	.word	0x41610BC1			# dmt $1	\n"
-	"	ehb							\n"
-	"	move	%0, $1						\n"
-	"	.set	pop						\n"
+	"	.set	push					\n"
+	"	.set	"MIPS_ISA_LEVEL"			\n"
+	_ASM_SET_DMT
+	"	dmt	%0					\n"
+	"	ehb						\n"
+	_ASM_UNSET_DMT
+	"	.set	pop					\n"
 	: "=r" (res));
 
 	instruction_hazard();
@@ -251,14 +268,21 @@ static inline unsigned int dmt(void)
 	return res;
 }
 
+#define _ASM_SET_EMT							\
+	_ASM_MACRO_1R(emt, rt,						\
+			_ASM_INSN_IF_MIPS(0x41600be1 | __rt << 16)	\
+			_ASM_INSN32_IF_MM(0x0000257C | __rt << 21))
+#define _ASM_UNSET_EMT ".purgem emt\n\t"
+
 static inline void __raw_emt(void)
 {
 	__asm__ __volatile__(
-	"	.set	push						\n"
-	"	.set	noreorder					\n"
-	"	.set	mips32r2					\n"
-	"	.word	0x41600be1			# emt		\n"
-	"	ehb							\n"
+	"	.set	push					\n"
+	"	.set	"MIPS_ISA_LEVEL"			\n"
+	_ASM_SET_EMT
+	"	emt	$0					\n"
+	_ASM_UNSET_EMT
+	"	ehb						\n"
 	"	.set	pop");
 }
 
@@ -276,41 +300,55 @@ static inline void emt(int previous)
 static inline void ehb(void)
 {
 	__asm__ __volatile__(
-	"	.set	push					\n"
-	"	.set	mips32r2				\n"
-	"	ehb						\n"
-	"	.set	pop					\n");
+	"	.set	push				\n"
+	"	.set	"MIPS_ISA_LEVEL"		\n"
+	"	ehb					\n"
+	"	.set	pop				\n");
 }
 
-#define mftc0(rt,sel)							\
+#define _ASM_SET_MFTC0							\
+	_ASM_MACRO_2R_1S(mftc0, rs, rt, sel,				\
+			_ASM_INSN_IF_MIPS(0x41000000 | __rt << 16 |	\
+				__rs << 11 | \\sel)			\
+			_ASM_INSN32_IF_MM(0x0000000E | __rt << 21 |	\
+				__rs << 16 | \\sel << 4))
+#define _ASM_UNSET_MFTC0 ".purgem mftc0\n\t"
+
+#define mftc0(rt, sel)							\
 ({									\
-	 unsigned long	__res;						\
+	unsigned long	__res;						\
 									\
 	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	mips32r2				\n"	\
-	"	.set	noat					\n"	\
-	"	# mftc0 $1, $" #rt ", " #sel "			\n"	\
-	"	.word	0x41000800 | (" #rt " << 16) | " #sel " \n"	\
-	"	move	%0, $1					\n"	\
-	"	.set	pop					\n"	\
+	"	.set	push				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"		\n"	\
+	_ASM_SET_MFTC0							\
+	"	mftc0	$1, " #rt ", " #sel "		\n"	\
+	_ASM_UNSET_MFTC0						\
+	"	.set	pop				\n"	\
 	: "=r" (__res));						\
 									\
 	__res;								\
 })
 
+#define _ASM_SET_MFTGPR							\
+	_ASM_MACRO_2R(mftgpr, rs, rt,					\
+			_ASM_INSN_IF_MIPS(0x41000020 | __rt << 16 |	\
+				__rs << 11)				\
+			_ASM_INSN32_IF_MM(0x0000040E | __rt << 21 |	\
+				__rs << 16))
+#define _ASM_UNSET_MFTGPR ".purgem mftgpr\n\t"
+
 #define mftgpr(rt)							\
 ({									\
 	unsigned long __res;						\
 									\
 	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	noat					\n"	\
-	"	.set	mips32r2				\n"	\
-	"	# mftgpr $1," #rt "				\n"	\
-	"	.word	0x41000820 | (" #rt " << 16)		\n"	\
-	"	move	%0, $1					\n"	\
-	"	.set	pop					\n"	\
+	"	.set	push				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"		\n"	\
+	_ASM_SET_MFTGPR							\
+	"	mftgpr	%0," #rt "			\n"	\
+	_ASM_UNSET_MFTGPR						\
+	"	.set	pop				\n"	\
 	: "=r" (__res));						\
 									\
 	__res;								\
@@ -321,35 +359,49 @@ static inline void ehb(void)
 	unsigned long __res;						\
 									\
 	__asm__ __volatile__(						\
-	"	mftr	%0, " #rt ", " #u ", " #sel "		\n"	\
+	"	mftr	%0, " #rt ", " #u ", " #sel "	\n"	\
 	: "=r" (__res));						\
 									\
 	__res;								\
 })
 
-#define mttgpr(rd,v)							\
+#define _ASM_SET_MTTGPR							\
+	_ASM_MACRO_2R(mttgpr, rt, rs,					\
+			_ASM_INSN_IF_MIPS(0x41800020 | __rt << 16 |	\
+				__rs << 11)				\
+			_ASM_INSN32_IF_MM(0x00000406 | __rt << 21 |	\
+				__rs << 16))
+#define _ASM_UNSET_MTTGPR ".purgem mttgpr\n\t"
+
+#define mttgpr(rs, v)							\
 do {									\
 	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	mips32r2				\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mttgpr $1, " #rd "				\n"	\
-	"	.word	0x41810020 | (" #rd " << 11)		\n"	\
-	"	.set	pop					\n"	\
+	"	.set	push				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"		\n"	\
+	_ASM_SET_MTTGPR							\
+	"	mttgpr	%0, " #rs "			\n"	\
+	_ASM_UNSET_MTTGPR						\
+	"	.set	pop				\n"	\
 	: : "r" (v));							\
 } while (0)
 
-#define mttc0(rd, sel, v)							\
+#define _ASM_SET_MTTC0							\
+	_ASM_MACRO_2R_1S(mttc0, rt, rs, sel,				\
+			_ASM_INSN_IF_MIPS(0x41800000 | __rt << 16 |	\
+				__rs << 11 | \\sel)			\
+			_ASM_INSN32_IF_MM(0x0000040E | __rt << 21 |	\
+				__rs << 16 | \\sel << 4))
+#define _ASM_UNSET_MTTC0 ".purgem mttc0\n\t"
+
+#define mttc0(rs, sel, v)							\
 ({									\
 	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	mips32r2				\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mttc0 %0," #rd ", " #sel "			\n"	\
-	"	.word	0x41810000 | (" #rd " << 11) | " #sel " \n"	\
-	"	.set	pop					\n"	\
+	"	.set	push				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"		\n"	\
+	_ASM_SET_MTTC0							\
+	"	mttc0	%0," #rs ", " #sel "		\n"	\
+	_ASM_UNSET_MTTC0						\
+	"	.set	pop				\n"	\
 	:								\
 	: "r" (v));							\
 })
@@ -371,49 +423,49 @@ do {									\
 
 
 /* you *must* set the target tc (settc) before trying to use these */
-#define read_vpe_c0_vpecontrol()	mftc0(1, 1)
-#define write_vpe_c0_vpecontrol(val)	mttc0(1, 1, val)
-#define read_vpe_c0_vpeconf0()		mftc0(1, 2)
-#define write_vpe_c0_vpeconf0(val)	mttc0(1, 2, val)
-#define read_vpe_c0_vpeconf1()		mftc0(1, 3)
-#define write_vpe_c0_vpeconf1(val)	mttc0(1, 3, val)
-#define read_vpe_c0_count()		mftc0(9, 0)
-#define write_vpe_c0_count(val)		mttc0(9, 0, val)
-#define read_vpe_c0_status()		mftc0(12, 0)
-#define write_vpe_c0_status(val)	mttc0(12, 0, val)
-#define read_vpe_c0_cause()		mftc0(13, 0)
-#define write_vpe_c0_cause(val)		mttc0(13, 0, val)
-#define read_vpe_c0_config()		mftc0(16, 0)
-#define write_vpe_c0_config(val)	mttc0(16, 0, val)
-#define read_vpe_c0_config1()		mftc0(16, 1)
-#define write_vpe_c0_config1(val)	mttc0(16, 1, val)
-#define read_vpe_c0_config7()		mftc0(16, 7)
-#define write_vpe_c0_config7(val)	mttc0(16, 7, val)
-#define read_vpe_c0_ebase()		mftc0(15, 1)
-#define write_vpe_c0_ebase(val)		mttc0(15, 1, val)
-#define write_vpe_c0_compare(val)	mttc0(11, 0, val)
-#define read_vpe_c0_badvaddr()		mftc0(8, 0)
-#define read_vpe_c0_epc()		mftc0(14, 0)
-#define write_vpe_c0_epc(val)		mttc0(14, 0, val)
+#define read_vpe_c0_vpecontrol()	mftc0($1, 1)
+#define write_vpe_c0_vpecontrol(val)	mttc0($1, 1, val)
+#define read_vpe_c0_vpeconf0()		mftc0($1, 2)
+#define write_vpe_c0_vpeconf0(val)	mttc0($1, 2, val)
+#define read_vpe_c0_vpeconf1()		mftc0($1, 3)
+#define write_vpe_c0_vpeconf1(val)	mttc0($1, 3, val)
+#define read_vpe_c0_count()		mftc0($9, 0)
+#define write_vpe_c0_count(val)		mttc0($9, 0, val)
+#define read_vpe_c0_status()		mftc0($12, 0)
+#define write_vpe_c0_status(val)	mttc0($12, 0, val)
+#define read_vpe_c0_cause()		mftc0($13, 0)
+#define write_vpe_c0_cause(val)		mttc0($13, 0, val)
+#define read_vpe_c0_config()		mftc0($16, 0)
+#define write_vpe_c0_config(val)	mttc0($16, 0, val)
+#define read_vpe_c0_config1()		mftc0($16, 1)
+#define write_vpe_c0_config1(val)	mttc0($16, 1, val)
+#define read_vpe_c0_config7()		mftc0($16, 7)
+#define write_vpe_c0_config7(val)	mttc0($16, 7, val)
+#define read_vpe_c0_ebase()		mftc0($15, 1)
+#define write_vpe_c0_ebase(val)		mttc0($15, 1, val)
+#define write_vpe_c0_compare(val)	mttc0($11, 0, val)
+#define read_vpe_c0_badvaddr()		mftc0($8, 0)
+#define read_vpe_c0_epc()		mftc0($14, 0)
+#define write_vpe_c0_epc(val)		mttc0($14, 0, val)
 
 
 /* TC */
-#define read_tc_c0_tcstatus()		mftc0(2, 1)
-#define write_tc_c0_tcstatus(val)	mttc0(2, 1, val)
-#define read_tc_c0_tcbind()		mftc0(2, 2)
-#define write_tc_c0_tcbind(val)		mttc0(2, 2, val)
-#define read_tc_c0_tcrestart()		mftc0(2, 3)
-#define write_tc_c0_tcrestart(val)	mttc0(2, 3, val)
-#define read_tc_c0_tchalt()		mftc0(2, 4)
-#define write_tc_c0_tchalt(val)		mttc0(2, 4, val)
-#define read_tc_c0_tccontext()		mftc0(2, 5)
-#define write_tc_c0_tccontext(val)	mttc0(2, 5, val)
+#define read_tc_c0_tcstatus()		mftc0($2, 1)
+#define write_tc_c0_tcstatus(val)	mttc0($2, 1, val)
+#define read_tc_c0_tcbind()		mftc0($2, 2)
+#define write_tc_c0_tcbind(val)		mttc0($2, 2, val)
+#define read_tc_c0_tcrestart()		mftc0($2, 3)
+#define write_tc_c0_tcrestart(val)	mttc0($2, 3, val)
+#define read_tc_c0_tchalt()		mftc0($2, 4)
+#define write_tc_c0_tchalt(val)		mttc0($2, 4, val)
+#define read_tc_c0_tccontext()		mftc0($2, 5)
+#define write_tc_c0_tccontext(val)	mttc0($2, 5, val)
 
 /* GPR */
-#define read_tc_gpr_sp()		mftgpr(29)
-#define write_tc_gpr_sp(val)		mttgpr(29, val)
-#define read_tc_gpr_gp()		mftgpr(28)
-#define write_tc_gpr_gp(val)		mttgpr(28, val)
+#define read_tc_gpr_sp()		mftgpr($29)
+#define write_tc_gpr_sp(val)		mttgpr($29, val)
+#define read_tc_gpr_gp()		mftgpr($28)
+#define write_tc_gpr_gp(val)		mttgpr($28, val)
 
 __BUILD_SET_C0(mvpcontrol)
 
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index ec58cb76d076..dfb268f8aef8 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1307,6 +1307,15 @@ static inline int mm_insn_16bit(u16 insn)
  * the ENC encodings.
  */
 
+/* Instructions with 1 register operand */
+#define _ASM_MACRO_1R(OP, R1, ENC)				\
+		".macro	" #OP " " #R1 "\n\t"			\
+		_ASM_SET_PARSE_R					\
+		"parse_r __" #R1 ", \\" #R1 "\n\t"			\
+		ENC							\
+		_ASM_UNSET_PARSE_R					\
+		".endm\n\t"
+
 /* Instructions with 1 register operand & 1 immediate operand */
 #define _ASM_MACRO_1R1I(OP, R1, I2, ENC)				\
 		".macro	" #OP " " #R1 ", " #I2 "\n\t"			\
diff --git a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
index 667bc75f6420..84124ac2d2a5 100644
--- a/arch/mips/kernel/vpe-mt.c
+++ b/arch/mips/kernel/vpe-mt.c
@@ -95,8 +95,8 @@ int vpe_run(struct vpe *v)
 	 * We don't pass the memsize here, so VPE programs need to be
 	 * compiled with DFLT_STACK_SIZE and DFLT_HEAP_SIZE defined.
 	 */
-	mttgpr(7, 0);
-	mttgpr(6, v->ntcs);
+	mttgpr($7, 0);
+	mttgpr($6, v->ntcs);
 
 	/* set up VPE1 */
 	/*

-- 
2.43.0


