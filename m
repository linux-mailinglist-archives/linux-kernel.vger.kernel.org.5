Return-Path: <linux-kernel+bounces-166389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797318B99FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C5D1F24189
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F4D65BB7;
	Thu,  2 May 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dt47fNZQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xv1STtIJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3540BF5;
	Thu,  2 May 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649176; cv=none; b=U3H+tMrMg5zYF4C+VZ1NAm6/Xlb4z+aZPClVYoatlN7zos1aE1WY6MgbO4vNnC10Uvz5O7xW1a7tXFxAj68iuCK+UeFYecLBduyT+ZL3otQXLB++zz8fjknFvGTt80aW0to9kuE2LtxywSVQtYpTQtRzGSKPBJ62oHwQHPvgf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649176; c=relaxed/simple;
	bh=uuaDMIncbEXFb0TyUWeHLgDLz4X+PCaA8ybSMnntds4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hwmgUzeZackKrYeUDg+7enk6/wxxkLUZ38BoEp9rthM8sEY2CNxZKByO62fpVVTeJb26Oq9+gPV+djYbP53HXhW26sebvsZwmyCbMVZ6LS7f2+HF85boPY4ONu6mttaz0XY1auPuAH5g7AUOPOBm69j/TrWUIQ0L3GezVY7Mwg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dt47fNZQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xv1STtIJ; arc=none smtp.client-ip=193.142.43.55
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
	bh=YcBsdoU9Df2kGqSNMUlvV9krlat6X0V/nt6l5GJRhso=;
	b=dt47fNZQ/ie2QEoT+3/cOKUbDMwcYFo2zKXxVaTVZe/R4yaUfoxXglur6gp3RpRpN2izas
	ft1CFNNJ/qsGgzn0ohaUsFyR2KuDsC7JbJO2huVr7GHBq8S3UhswGcg4QiyOdnlRuF/x9N
	2fQRb+SBkhn9WG3Ax+K9aflBUP3rPST/nz0mXhPmrYC2Y7hY7zyUgDg0D8DDT1APIYV5W4
	avKh/7+OxtzIRB6/Z3jVSbbisb9XlDjM9L055LLgsAc/UzNUZ7cvY1yLp6XoT/LFhEPLmb
	ckFsL7N90VqB6IPG7c3kgxsJacNClEbm/CwvEXCz/8jX3VadIIFLxDACbIGkEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714649172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcBsdoU9Df2kGqSNMUlvV9krlat6X0V/nt6l5GJRhso=;
	b=xv1STtIJcib/Sewlj+KZfn8wL7tikRyyxH8/HnvRpPyMZaMfahtz/XjROftBF34kcFX8bQ
	vxt31vnr6glgwEAQ==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/insn: Add support for APX EVEX to the
 instruction decoder logic
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240502105853.5338-8-adrian.hunter@intel.com>
References: <20240502105853.5338-8-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171464917215.10875.13157458888728224213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     87bbaf1a4be4904fcf04a024e7c1d9f9d1fa945b
Gitweb:        https://git.kernel.org/tip/87bbaf1a4be4904fcf04a024e7c1d9f9d1fa945b
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 02 May 2024 13:58:50 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 02 May 2024 13:13:45 +02:00

x86/insn: Add support for APX EVEX to the instruction decoder logic

Intel Advanced Performance Extensions (APX) extends the EVEX prefix to
support:

 - extended general purpose registers (EGPRs) i.e. r16 to r31
 - Push-Pop Acceleration (PPX) hints
 - new data destination (NDD) register
 - suppress status flags writes (NF) of common instructions
 - new instructions

Refer to the Intel Advanced Performance Extensions (Intel APX) Architecture
Specification for details.

The extended EVEX prefix does not need amended instruction decoder logic,
except in one area. Some instructions are defined as SCALABLE which means
the EVEX.W bit and EVEX.pp bits are used to determine operand size.
Specifically, if an instruction is SCALABLE and EVEX.W is zero, then
EVEX.pp value 0 (representing no prefix NP) means default operand size,
whereas EVEX.pp value 1 (representing 66 prefix) means operand size
override i.e. 16 bits

Add an attribute (INAT_EVEX_SCALABLE) to identify such instructions, and
amend the logic appropriately.

Amend the awk script that generates the attribute tables from the opcode
map, to recognise "(es)" as attribute INAT_EVEX_SCALABLE.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240502105853.5338-8-adrian.hunter@intel.com
---
 arch/x86/include/asm/inat.h                | 6 ++++++
 arch/x86/include/asm/insn.h                | 7 +++++++
 arch/x86/lib/insn.c                        | 4 ++++
 arch/x86/tools/gen-insn-attr-x86.awk       | 4 ++++
 tools/arch/x86/include/asm/inat.h          | 6 ++++++
 tools/arch/x86/include/asm/insn.h          | 7 +++++++
 tools/arch/x86/lib/insn.c                  | 4 ++++
 tools/arch/x86/tools/gen-insn-attr-x86.awk | 4 ++++
 8 files changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
index 1331bdd..53e4015 100644
--- a/arch/x86/include/asm/inat.h
+++ b/arch/x86/include/asm/inat.h
@@ -81,6 +81,7 @@
 #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
 #define INAT_NO_REX2	(1 << (INAT_FLAG_OFFS + 8))
 #define INAT_REX2_VARIANT	(1 << (INAT_FLAG_OFFS + 9))
+#define INAT_EVEX_SCALABLE	(1 << (INAT_FLAG_OFFS + 10))
 /* Attribute making macros for attribute tables */
 #define INAT_MAKE_PREFIX(pfx)	(pfx << INAT_PFX_OFFS)
 #define INAT_MAKE_ESCAPE(esc)	(esc << INAT_ESC_OFFS)
@@ -236,4 +237,9 @@ static inline int inat_must_evex(insn_attr_t attr)
 {
 	return attr & INAT_EVEXONLY;
 }
+
+static inline int inat_evex_scalable(insn_attr_t attr)
+{
+	return attr & INAT_EVEX_SCALABLE;
+}
 #endif
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 95249ec..7152ea8 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -215,6 +215,13 @@ static inline insn_byte_t insn_vex_p_bits(struct insn *insn)
 		return X86_VEX_P(insn->vex_prefix.bytes[2]);
 }
 
+static inline insn_byte_t insn_vex_w_bit(struct insn *insn)
+{
+	if (insn->vex_prefix.nbytes < 3)
+		return 0;
+	return X86_VEX_W(insn->vex_prefix.bytes[2]);
+}
+
 /* Get the last prefix id from last prefix or VEX prefix */
 static inline int insn_last_prefix_id(struct insn *insn)
 {
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 6126ddc..5952ab4 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -294,6 +294,10 @@ int insn_get_opcode(struct insn *insn)
 		m = insn_vex_m_bits(insn);
 		p = insn_vex_p_bits(insn);
 		insn->attr = inat_get_avx_attribute(op, m, p);
+		/* SCALABLE EVEX uses p bits to encode operand size */
+		if (inat_evex_scalable(insn->attr) && !insn_vex_w_bit(insn) &&
+		    p == INAT_PFX_OPNDSZ)
+			insn->opnd_bytes = 2;
 		if ((inat_must_evex(insn->attr) && !insn_is_evex(insn)) ||
 		    (!inat_accept_vex(insn->attr) &&
 		     !inat_is_group(insn->attr))) {
diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
index 3f43aa7..5770c80 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -83,6 +83,8 @@ BEGIN {
 	vexonly_expr = "\\(v\\)"
 	# All opcodes with (ev) superscript supports *only* EVEX prefix
 	evexonly_expr = "\\(ev\\)"
+	# (es) is the same as (ev) but also "SCALABLE" i.e. W and pp determine operand size
+	evex_scalable_expr = "\\(es\\)"
 
 	prefix_expr = "\\(Prefix\\)"
 	prefix_num["Operand-Size"] = "INAT_PFX_OPNDSZ"
@@ -332,6 +334,8 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		# check VEX codes
 		if (match(ext, evexonly_expr))
 			flags = add_flags(flags, "INAT_VEXOK | INAT_EVEXONLY")
+		else if (match(ext, evex_scalable_expr))
+			flags = add_flags(flags, "INAT_VEXOK | INAT_EVEXONLY | INAT_EVEX_SCALABLE")
 		else if (match(ext, vexonly_expr))
 			flags = add_flags(flags, "INAT_VEXOK | INAT_VEXONLY")
 		else if (match(ext, vexok_expr) || match(opcode, vexok_opcode_expr))
diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
index 2e65312..253690e 100644
--- a/tools/arch/x86/include/asm/inat.h
+++ b/tools/arch/x86/include/asm/inat.h
@@ -81,6 +81,7 @@
 #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
 #define INAT_NO_REX2	(1 << (INAT_FLAG_OFFS + 8))
 #define INAT_REX2_VARIANT	(1 << (INAT_FLAG_OFFS + 9))
+#define INAT_EVEX_SCALABLE	(1 << (INAT_FLAG_OFFS + 10))
 /* Attribute making macros for attribute tables */
 #define INAT_MAKE_PREFIX(pfx)	(pfx << INAT_PFX_OFFS)
 #define INAT_MAKE_ESCAPE(esc)	(esc << INAT_ESC_OFFS)
@@ -236,4 +237,9 @@ static inline int inat_must_evex(insn_attr_t attr)
 {
 	return attr & INAT_EVEXONLY;
 }
+
+static inline int inat_evex_scalable(insn_attr_t attr)
+{
+	return attr & INAT_EVEX_SCALABLE;
+}
 #endif
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 1a7e8fc..0e5abd8 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -215,6 +215,13 @@ static inline insn_byte_t insn_vex_p_bits(struct insn *insn)
 		return X86_VEX_P(insn->vex_prefix.bytes[2]);
 }
 
+static inline insn_byte_t insn_vex_w_bit(struct insn *insn)
+{
+	if (insn->vex_prefix.nbytes < 3)
+		return 0;
+	return X86_VEX_W(insn->vex_prefix.bytes[2]);
+}
+
 /* Get the last prefix id from last prefix or VEX prefix */
 static inline int insn_last_prefix_id(struct insn *insn)
 {
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index f761ade..a43b373 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -294,6 +294,10 @@ int insn_get_opcode(struct insn *insn)
 		m = insn_vex_m_bits(insn);
 		p = insn_vex_p_bits(insn);
 		insn->attr = inat_get_avx_attribute(op, m, p);
+		/* SCALABLE EVEX uses p bits to encode operand size */
+		if (inat_evex_scalable(insn->attr) && !insn_vex_w_bit(insn) &&
+		    p == INAT_PFX_OPNDSZ)
+			insn->opnd_bytes = 2;
 		if ((inat_must_evex(insn->attr) && !insn_is_evex(insn)) ||
 		    (!inat_accept_vex(insn->attr) &&
 		     !inat_is_group(insn->attr))) {
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
index 3f43aa7..5770c80 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -83,6 +83,8 @@ BEGIN {
 	vexonly_expr = "\\(v\\)"
 	# All opcodes with (ev) superscript supports *only* EVEX prefix
 	evexonly_expr = "\\(ev\\)"
+	# (es) is the same as (ev) but also "SCALABLE" i.e. W and pp determine operand size
+	evex_scalable_expr = "\\(es\\)"
 
 	prefix_expr = "\\(Prefix\\)"
 	prefix_num["Operand-Size"] = "INAT_PFX_OPNDSZ"
@@ -332,6 +334,8 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		# check VEX codes
 		if (match(ext, evexonly_expr))
 			flags = add_flags(flags, "INAT_VEXOK | INAT_EVEXONLY")
+		else if (match(ext, evex_scalable_expr))
+			flags = add_flags(flags, "INAT_VEXOK | INAT_EVEXONLY | INAT_EVEX_SCALABLE")
 		else if (match(ext, vexonly_expr))
 			flags = add_flags(flags, "INAT_VEXOK | INAT_VEXONLY")
 		else if (match(ext, vexok_expr) || match(opcode, vexok_opcode_expr))

