Return-Path: <linux-kernel+bounces-166393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 142EC8B9A01
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 245F6B2123D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5150C768EC;
	Thu,  2 May 2024 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WiOTjBlx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QVyvRSOv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FAD60DCF;
	Thu,  2 May 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649176; cv=none; b=R5zQbSTNS9TRC2G8CmjQ9fXBVSAgGNR5rwnl3kGYoUcgaY+yLhqEx9RP9DV3L0tiGMt3aLLSKQBmpGOD89HxxEJUX1bPns5melrJGVpXEgvR9KvLAGZsqS/19nX+GUyuOO2ItDXQQ38anEnaAbJRHYkPGaaQxMfVy6CL8S1Rgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649176; c=relaxed/simple;
	bh=nIYsIMK+PpLOJH5h7+IIeJCOGGESjTPkYnXC/FuzlCc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bDur/bRDY+94vGQD7fXtKyjaIFKQ7h4Dq6ECSWgndh3VtZJVfR6AAV0B3Gmdcf99ahnZrRe6RuSDN+poeemNCE+jdUEps/gmILLlw72BFM9XCpeEpzapPMeITuK3BtGBotq+RNe5UwMO667JMVvoEnRIf1UGyznCFLMbhbLc288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WiOTjBlx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QVyvRSOv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 02 May 2024 11:26:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714649172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFW5ZqZMNW5FzYsAlBlKh/6jJ6rGsVQBgGd+QAu7ZYM=;
	b=WiOTjBlxzCcCsjrXMeJd9bqcp9oLqxeT2saQr5IFo0kS1qa7hvFC26WKk5MKb0YUeC4nzM
	jDzyKQNE0Q/EOUV9xVde8AXl3arHcHMOQAZhSQqKPAwcJIb1B4oWgSyBdcAdvc1ZSEeBQA
	qjOaepThYGye0QgKaaXiy56BmXvuVWV0+v/gHYeinJq1WTdBB45gJntn9NHFoDbfNo5Aqu
	Z3kA/OC1TWF9UPwWaT0r1J4dnqXO/K6b2zOZ2Qn/gSnRS/B1qNnyU+RyhW9zFLkhcS3RVG
	txJGSQDEJN7frOJ4Li8axmG2EhrcFnXrNNuLlxvtTRKWgIof6YiogBimGp01OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714649172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFW5ZqZMNW5FzYsAlBlKh/6jJ6rGsVQBgGd+QAu7ZYM=;
	b=QVyvRSOvAYW+hVFw/zguSomjycoPjOAFiLr3KM+Kge+4d5EP0++5oZqThy7jW7vfJ1sd/W
	c/g/24ZYBiut7OAA==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/insn: Add support for REX2 prefix to the
 instruction decoder logic
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240502105853.5338-6-adrian.hunter@intel.com>
References: <20240502105853.5338-6-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171464917258.10875.9137187278792857009.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     eada38d575a2b947b3ffefd570fea90a5a17feb3
Gitweb:        https://git.kernel.org/tip/eada38d575a2b947b3ffefd570fea90a5a17feb3
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 02 May 2024 13:58:48 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 02 May 2024 13:13:44 +02:00

x86/insn: Add support for REX2 prefix to the instruction decoder logic

Intel Advanced Performance Extensions (APX) uses a new 2-byte prefix named
REX2 to select extended general purpose registers (EGPRs) i.e. r16 to r31.

The REX2 prefix is effectively an extended version of the REX prefix.

REX2 and EVEX are also used with PUSH/POP instructions to provide a
Push-Pop Acceleration (PPX) hint. With PPX hints, a CPU will attempt to
fast-forward register data between matching PUSH and POP instructions.

REX2 is valid only with opcodes in maps 0 and 1. Similar extension for
other maps is provided by the EVEX prefix, covered in a separate patch.

Some opcodes in maps 0 and 1 are reserved under REX2. One of these is used
for a new 64-bit absolute direct jump instruction JMPABS.

Refer to the Intel Advanced Performance Extensions (Intel APX) Architecture
Specification for details.

Define a code value for the REX2 prefix (INAT_PFX_REX2), and add attribute
flags for opcodes reserved under REX2 (INAT_NO_REX2) and to identify
opcodes (only JMPABS) that require a mandatory REX2 prefix
(INAT_REX2_VARIANT).

Amend logic to read the REX2 prefix and get the opcode attribute for the
map number (0 or 1) encoded in the REX2 prefix.

Amend the awk script that generates the attribute tables from the opcode
map, to recognise "REX2" as attribute INAT_PFX_REX2, and "(!REX2)"
as attribute INAT_NO_REX2, and "(REX2)" as attribute INAT_REX2_VARIANT.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240502105853.5338-6-adrian.hunter@intel.com
---
 arch/x86/include/asm/inat.h                | 11 ++++++++-
 arch/x86/include/asm/insn.h                | 25 +++++++++++++++++----
 arch/x86/lib/insn.c                        | 25 +++++++++++++++++++++-
 arch/x86/tools/gen-insn-attr-x86.awk       | 11 ++++++++-
 tools/arch/x86/include/asm/inat.h          | 11 ++++++++-
 tools/arch/x86/include/asm/insn.h          | 25 +++++++++++++++++----
 tools/arch/x86/lib/insn.c                  | 25 +++++++++++++++++++++-
 tools/arch/x86/tools/gen-insn-attr-x86.awk | 11 ++++++++-
 8 files changed, 132 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
index b56c574..1331bdd 100644
--- a/arch/x86/include/asm/inat.h
+++ b/arch/x86/include/asm/inat.h
@@ -35,6 +35,8 @@
 #define INAT_PFX_VEX2	13	/* 2-bytes VEX prefix */
 #define INAT_PFX_VEX3	14	/* 3-bytes VEX prefix */
 #define INAT_PFX_EVEX	15	/* EVEX prefix */
+/* x86-64 REX2 prefix */
+#define INAT_PFX_REX2	16	/* 0xD5 */
 
 #define INAT_LSTPFX_MAX	3
 #define INAT_LGCPFX_MAX	11
@@ -50,7 +52,7 @@
 
 /* Legacy prefix */
 #define INAT_PFX_OFFS	0
-#define INAT_PFX_BITS	4
+#define INAT_PFX_BITS	5
 #define INAT_PFX_MAX    ((1 << INAT_PFX_BITS) - 1)
 #define INAT_PFX_MASK	(INAT_PFX_MAX << INAT_PFX_OFFS)
 /* Escape opcodes */
@@ -77,6 +79,8 @@
 #define INAT_VEXOK	(1 << (INAT_FLAG_OFFS + 5))
 #define INAT_VEXONLY	(1 << (INAT_FLAG_OFFS + 6))
 #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
+#define INAT_NO_REX2	(1 << (INAT_FLAG_OFFS + 8))
+#define INAT_REX2_VARIANT	(1 << (INAT_FLAG_OFFS + 9))
 /* Attribute making macros for attribute tables */
 #define INAT_MAKE_PREFIX(pfx)	(pfx << INAT_PFX_OFFS)
 #define INAT_MAKE_ESCAPE(esc)	(esc << INAT_ESC_OFFS)
@@ -128,6 +132,11 @@ static inline int inat_is_rex_prefix(insn_attr_t attr)
 	return (attr & INAT_PFX_MASK) == INAT_PFX_REX;
 }
 
+static inline int inat_is_rex2_prefix(insn_attr_t attr)
+{
+	return (attr & INAT_PFX_MASK) == INAT_PFX_REX2;
+}
+
 static inline int inat_last_prefix_id(insn_attr_t attr)
 {
 	if ((attr & INAT_PFX_MASK) > INAT_LSTPFX_MAX)
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 1b29f58..95249ec 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -112,10 +112,15 @@ struct insn {
 #define X86_SIB_INDEX(sib) (((sib) & 0x38) >> 3)
 #define X86_SIB_BASE(sib) ((sib) & 0x07)
 
-#define X86_REX_W(rex) ((rex) & 8)
-#define X86_REX_R(rex) ((rex) & 4)
-#define X86_REX_X(rex) ((rex) & 2)
-#define X86_REX_B(rex) ((rex) & 1)
+#define X86_REX2_M(rex) ((rex) & 0x80)	/* REX2 M0 */
+#define X86_REX2_R(rex) ((rex) & 0x40)	/* REX2 R4 */
+#define X86_REX2_X(rex) ((rex) & 0x20)	/* REX2 X4 */
+#define X86_REX2_B(rex) ((rex) & 0x10)	/* REX2 B4 */
+
+#define X86_REX_W(rex) ((rex) & 8)	/* REX or REX2 W */
+#define X86_REX_R(rex) ((rex) & 4)	/* REX or REX2 R3 */
+#define X86_REX_X(rex) ((rex) & 2)	/* REX or REX2 X3 */
+#define X86_REX_B(rex) ((rex) & 1)	/* REX or REX2 B3 */
 
 /* VEX bit flags  */
 #define X86_VEX_W(vex)	((vex) & 0x80)	/* VEX3 Byte2 */
@@ -161,6 +166,18 @@ static inline void insn_get_attribute(struct insn *insn)
 /* Instruction uses RIP-relative addressing */
 extern int insn_rip_relative(struct insn *insn);
 
+static inline int insn_is_rex2(struct insn *insn)
+{
+	if (!insn->prefixes.got)
+		insn_get_prefixes(insn);
+	return insn->rex_prefix.nbytes == 2;
+}
+
+static inline insn_byte_t insn_rex2_m_bit(struct insn *insn)
+{
+	return X86_REX2_M(insn->rex_prefix.bytes[1]);
+}
+
 static inline int insn_is_avx(struct insn *insn)
 {
 	if (!insn->prefixes.got)
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 1bb155a..6126ddc 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -185,6 +185,17 @@ found:
 			if (X86_REX_W(b))
 				/* REX.W overrides opnd_size */
 				insn->opnd_bytes = 8;
+		} else if (inat_is_rex2_prefix(attr)) {
+			insn_set_byte(&insn->rex_prefix, 0, b);
+			b = peek_nbyte_next(insn_byte_t, insn, 1);
+			insn_set_byte(&insn->rex_prefix, 1, b);
+			insn->rex_prefix.nbytes = 2;
+			insn->next_byte += 2;
+			if (X86_REX_W(b))
+				/* REX.W overrides opnd_size */
+				insn->opnd_bytes = 8;
+			insn->rex_prefix.got = 1;
+			goto vex_end;
 		}
 	}
 	insn->rex_prefix.got = 1;
@@ -294,6 +305,20 @@ int insn_get_opcode(struct insn *insn)
 		goto end;
 	}
 
+	/* Check if there is REX2 prefix or not */
+	if (insn_is_rex2(insn)) {
+		if (insn_rex2_m_bit(insn)) {
+			/* map 1 is escape 0x0f */
+			insn_attr_t esc_attr = inat_get_opcode_attribute(0x0f);
+
+			pfx_id = insn_last_prefix_id(insn);
+			insn->attr = inat_get_escape_attribute(op, pfx_id, esc_attr);
+		} else {
+			insn->attr = inat_get_opcode_attribute(op);
+		}
+		goto end;
+	}
+
 	insn->attr = inat_get_opcode_attribute(op);
 	while (inat_is_escape(insn->attr)) {
 		/* Get escaped opcode */
diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
index af38469..3f43aa7 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -64,7 +64,9 @@ BEGIN {
 
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
-	rex_expr = "^REX(\\.[XRWB]+)*"
+	rex_expr = "^((REX(\\.[XRWB]+)+)|(REX$))"
+	rex2_expr = "\\(REX2\\)"
+	no_rex2_expr = "\\(!REX2\\)"
 	fpu_expr = "^ESC" # TODO
 
 	lprefix1_expr = "\\((66|!F3)\\)"
@@ -99,6 +101,7 @@ BEGIN {
 	prefix_num["VEX+1byte"] = "INAT_PFX_VEX2"
 	prefix_num["VEX+2byte"] = "INAT_PFX_VEX3"
 	prefix_num["EVEX"] = "INAT_PFX_EVEX"
+	prefix_num["REX2"] = "INAT_PFX_REX2"
 
 	clear_vars()
 }
@@ -314,6 +317,10 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		if (match(ext, force64_expr))
 			flags = add_flags(flags, "INAT_FORCE64")
 
+		# check REX2 not allowed
+		if (match(ext, no_rex2_expr))
+			flags = add_flags(flags, "INAT_NO_REX2")
+
 		# check REX prefix
 		if (match(opcode, rex_expr))
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
@@ -351,6 +358,8 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 			lptable3[idx] = add_flags(lptable3[idx],flags)
 			variant = "INAT_VARIANT"
 		}
+		if (match(ext, rex2_expr))
+			table[idx] = add_flags(table[idx], "INAT_REX2_VARIANT")
 		if (!match(ext, lprefix_expr)){
 			table[idx] = add_flags(table[idx],flags)
 		}
diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
index a610514..2e65312 100644
--- a/tools/arch/x86/include/asm/inat.h
+++ b/tools/arch/x86/include/asm/inat.h
@@ -35,6 +35,8 @@
 #define INAT_PFX_VEX2	13	/* 2-bytes VEX prefix */
 #define INAT_PFX_VEX3	14	/* 3-bytes VEX prefix */
 #define INAT_PFX_EVEX	15	/* EVEX prefix */
+/* x86-64 REX2 prefix */
+#define INAT_PFX_REX2	16	/* 0xD5 */
 
 #define INAT_LSTPFX_MAX	3
 #define INAT_LGCPFX_MAX	11
@@ -50,7 +52,7 @@
 
 /* Legacy prefix */
 #define INAT_PFX_OFFS	0
-#define INAT_PFX_BITS	4
+#define INAT_PFX_BITS	5
 #define INAT_PFX_MAX    ((1 << INAT_PFX_BITS) - 1)
 #define INAT_PFX_MASK	(INAT_PFX_MAX << INAT_PFX_OFFS)
 /* Escape opcodes */
@@ -77,6 +79,8 @@
 #define INAT_VEXOK	(1 << (INAT_FLAG_OFFS + 5))
 #define INAT_VEXONLY	(1 << (INAT_FLAG_OFFS + 6))
 #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
+#define INAT_NO_REX2	(1 << (INAT_FLAG_OFFS + 8))
+#define INAT_REX2_VARIANT	(1 << (INAT_FLAG_OFFS + 9))
 /* Attribute making macros for attribute tables */
 #define INAT_MAKE_PREFIX(pfx)	(pfx << INAT_PFX_OFFS)
 #define INAT_MAKE_ESCAPE(esc)	(esc << INAT_ESC_OFFS)
@@ -128,6 +132,11 @@ static inline int inat_is_rex_prefix(insn_attr_t attr)
 	return (attr & INAT_PFX_MASK) == INAT_PFX_REX;
 }
 
+static inline int inat_is_rex2_prefix(insn_attr_t attr)
+{
+	return (attr & INAT_PFX_MASK) == INAT_PFX_REX2;
+}
+
 static inline int inat_last_prefix_id(insn_attr_t attr)
 {
 	if ((attr & INAT_PFX_MASK) > INAT_LSTPFX_MAX)
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 65c0d9c..1a7e8fc 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -112,10 +112,15 @@ struct insn {
 #define X86_SIB_INDEX(sib) (((sib) & 0x38) >> 3)
 #define X86_SIB_BASE(sib) ((sib) & 0x07)
 
-#define X86_REX_W(rex) ((rex) & 8)
-#define X86_REX_R(rex) ((rex) & 4)
-#define X86_REX_X(rex) ((rex) & 2)
-#define X86_REX_B(rex) ((rex) & 1)
+#define X86_REX2_M(rex) ((rex) & 0x80)	/* REX2 M0 */
+#define X86_REX2_R(rex) ((rex) & 0x40)	/* REX2 R4 */
+#define X86_REX2_X(rex) ((rex) & 0x20)	/* REX2 X4 */
+#define X86_REX2_B(rex) ((rex) & 0x10)	/* REX2 B4 */
+
+#define X86_REX_W(rex) ((rex) & 8)	/* REX or REX2 W */
+#define X86_REX_R(rex) ((rex) & 4)	/* REX or REX2 R3 */
+#define X86_REX_X(rex) ((rex) & 2)	/* REX or REX2 X3 */
+#define X86_REX_B(rex) ((rex) & 1)	/* REX or REX2 B3 */
 
 /* VEX bit flags  */
 #define X86_VEX_W(vex)	((vex) & 0x80)	/* VEX3 Byte2 */
@@ -161,6 +166,18 @@ static inline void insn_get_attribute(struct insn *insn)
 /* Instruction uses RIP-relative addressing */
 extern int insn_rip_relative(struct insn *insn);
 
+static inline int insn_is_rex2(struct insn *insn)
+{
+	if (!insn->prefixes.got)
+		insn_get_prefixes(insn);
+	return insn->rex_prefix.nbytes == 2;
+}
+
+static inline insn_byte_t insn_rex2_m_bit(struct insn *insn)
+{
+	return X86_REX2_M(insn->rex_prefix.bytes[1]);
+}
+
 static inline int insn_is_avx(struct insn *insn)
 {
 	if (!insn->prefixes.got)
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index ada4b4a..f761ade 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -185,6 +185,17 @@ found:
 			if (X86_REX_W(b))
 				/* REX.W overrides opnd_size */
 				insn->opnd_bytes = 8;
+		} else if (inat_is_rex2_prefix(attr)) {
+			insn_set_byte(&insn->rex_prefix, 0, b);
+			b = peek_nbyte_next(insn_byte_t, insn, 1);
+			insn_set_byte(&insn->rex_prefix, 1, b);
+			insn->rex_prefix.nbytes = 2;
+			insn->next_byte += 2;
+			if (X86_REX_W(b))
+				/* REX.W overrides opnd_size */
+				insn->opnd_bytes = 8;
+			insn->rex_prefix.got = 1;
+			goto vex_end;
 		}
 	}
 	insn->rex_prefix.got = 1;
@@ -294,6 +305,20 @@ int insn_get_opcode(struct insn *insn)
 		goto end;
 	}
 
+	/* Check if there is REX2 prefix or not */
+	if (insn_is_rex2(insn)) {
+		if (insn_rex2_m_bit(insn)) {
+			/* map 1 is escape 0x0f */
+			insn_attr_t esc_attr = inat_get_opcode_attribute(0x0f);
+
+			pfx_id = insn_last_prefix_id(insn);
+			insn->attr = inat_get_escape_attribute(op, pfx_id, esc_attr);
+		} else {
+			insn->attr = inat_get_opcode_attribute(op);
+		}
+		goto end;
+	}
+
 	insn->attr = inat_get_opcode_attribute(op);
 	while (inat_is_escape(insn->attr)) {
 		/* Get escaped opcode */
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
index af38469..3f43aa7 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -64,7 +64,9 @@ BEGIN {
 
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
-	rex_expr = "^REX(\\.[XRWB]+)*"
+	rex_expr = "^((REX(\\.[XRWB]+)+)|(REX$))"
+	rex2_expr = "\\(REX2\\)"
+	no_rex2_expr = "\\(!REX2\\)"
 	fpu_expr = "^ESC" # TODO
 
 	lprefix1_expr = "\\((66|!F3)\\)"
@@ -99,6 +101,7 @@ BEGIN {
 	prefix_num["VEX+1byte"] = "INAT_PFX_VEX2"
 	prefix_num["VEX+2byte"] = "INAT_PFX_VEX3"
 	prefix_num["EVEX"] = "INAT_PFX_EVEX"
+	prefix_num["REX2"] = "INAT_PFX_REX2"
 
 	clear_vars()
 }
@@ -314,6 +317,10 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		if (match(ext, force64_expr))
 			flags = add_flags(flags, "INAT_FORCE64")
 
+		# check REX2 not allowed
+		if (match(ext, no_rex2_expr))
+			flags = add_flags(flags, "INAT_NO_REX2")
+
 		# check REX prefix
 		if (match(opcode, rex_expr))
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
@@ -351,6 +358,8 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 			lptable3[idx] = add_flags(lptable3[idx],flags)
 			variant = "INAT_VARIANT"
 		}
+		if (match(ext, rex2_expr))
+			table[idx] = add_flags(table[idx], "INAT_REX2_VARIANT")
 		if (!match(ext, lprefix_expr)){
 			table[idx] = add_flags(table[idx],flags)
 		}

