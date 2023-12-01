Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C47800A82
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378754AbjLAMLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378681AbjLAMLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:11:05 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC271721;
        Fri,  1 Dec 2023 04:11:09 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2AB695C00CC;
        Fri,  1 Dec 2023 07:11:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 07:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm2; t=1701432669; x=
        1701519069; bh=UKdkj82m0CJ0VSnfRdFjkeWDLvEVdeU1hht7PINciaY=; b=G
        FXK6jQMKXC0zdf3bGpePybAomtOWff6UZuCqwFFyJjwQrMxOmM80NEYls0ia3gNE
        0foOana4gQDS/Yo8iK6dRv3vpR+fh1Ojfi0kAFNfEb7txvJhh74EAk84rJXNqhJL
        CdImElOPbaU26a9y5ppBgJbdNnL90XRVdQc608S3ybV7hNdWMxU2bpyOjEaC2+RZ
        HRt7uMdusayhlA4o/8YhD/lbdHNQdsiv3j/Ui9dComVPqysn4NEVxHU1Qr7eWdMG
        tIyVuzzLyD4CX87viP3ELgGqRg+bJNJRSTMqmMAnmrflGZdpF294EaCRBE+COKkL
        AANe8g75TY770Q2lk8CAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1701432669; x=1701519069; bh=U
        Kdkj82m0CJ0VSnfRdFjkeWDLvEVdeU1hht7PINciaY=; b=0XJb/2Guk2CD/gnf2
        QCZ+zwarEZTPPYm4Mlbis+UHNJ8mwt5gfNPIbLyvR4DWczTO9VNGJeyfhHOpI5JA
        C3wR3H0e7SG2zXI/g61RDLryvMfsu4bIVX8kZJYPpyuoQNjGIbechTps1AI9bFGd
        fcH3WFTkryOu+0flhQfIPqZPKnbG+b199GrbLZ3tlv+fAnCpS/a+Dbv5MQb04LI9
        Gp5EFH1e4J47Q05eASF/QOgceiu1T/JvWjcKzR6PPl2zzqY/IpzV/SBbXkv4lMJG
        YQjkjVQyaaSOwfLKAnfaozTs51zF0lHy8mFLow+xe2drweBzXsrU7gpYc69Th+JQ
        mGQbw==
X-ME-Sender: <xms:XM1pZdZ0qkocoR-tandr-CcJienjVN4CaO9n2hha8N5l7hhW-x3QyQ>
    <xme:XM1pZUYfyoBE-6_sVyGRum6z_J-BzvbAIAw07ymrx86aXAWdsCGxrlF5ECnddEKvt
    L5qDSkoYNzVriOkEeQ>
X-ME-Received: <xmr:XM1pZf-MEO4oUPXuchfHYLHGGZJ98jKd8rVvjYVusMWxC5oQFIMdGzTlGw5RiLvPX46JOYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
    dtredtjeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfduvedvtdfgkeektd
    ffveeiueeludegheehtdegheduueeuueegtdehjeehheenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:Xc1pZbqOsJ2TlGUMAYBD98QvPnPuDQf_arLOp-xxKJRJ-1sMiJ2Rag>
    <xmx:Xc1pZYqlI-CrQp-rpIf7GsGous0F-HHZp_ZP9zO2yfbvrbHIMrsu3w>
    <xmx:Xc1pZRQUBj4Bs3OJXsaRXFD56lLbsHTcqhv_T6YHPCiAnXNQRK51dQ>
    <xmx:Xc1pZf0ZJmhO7xo9A4cgGMhegfA78ZthV9rZEhs7qELdtK3WNoApFw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 07:11:08 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] MIPS: Implement microMIPS MT ASE helpers
Date:   Fri,  1 Dec 2023 12:11:01 +0000
Message-Id: <20231201121101.90714-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement various microMIPS MT ASE helpers accroading to:

MIPS® Architecture for Programmers
Volume IV-f: The MIPS® MT Module for the microMIPS32™ Architecture

Fixes build error:
{standard input}:2616: Error: branch to a symbol in another ISA mode

This make MT ASE available on microMIPS as well.

Boot tested on M5150 with microMIPS enabled on M5150.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/asmmacro.h   |  22 ++-
 arch/mips/include/asm/mipsmtregs.h | 256 +++++++++++++++++------------
 arch/mips/include/asm/mipsregs.h   |   9 +
 3 files changed, 177 insertions(+), 110 deletions(-)

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
index 2d53704d9f24..4f334c8cc370 100644
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
-- 
2.34.1

