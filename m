Return-Path: <linux-kernel+bounces-137376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B6B89E157
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EB4B2501E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5674156863;
	Tue,  9 Apr 2024 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YWFyEGW1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pd+soo3r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEB155759;
	Tue,  9 Apr 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682696; cv=none; b=JZxlEvg8XEaIz3NcziZxFdLNZKHiphAUTXvEDPfNz9XYpsltAlquXgVzqq7SGey+vrWVct6wYIb33+y3LlpbXLkRTKZglSlA8LxvI3fZHqZXf+vcwUg2VWrHHQw7WehLA1w4ha/STsj8Gujf9dfEw8bn4xuKArWlwmykdyhnyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682696; c=relaxed/simple;
	bh=TTU5LwP+BHTGxE5/boulhG9jN9eZ2E6iZrQn3KNeb0o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YAqM7d2cYfxsozSKQC6wHHGIdJc23hdhqtdSKNNOv9Z6gwwJalSaJBJyOwuEUx1ldNkDT0N6rC96gtRcFZGV3R/4n83JOIz6EVkjM9CM53TBvcqOKHDxy2Ax4slXDbK52oQOztvEzBZPzmIMxoNUvu/FqjqRepE8Kz1eJ2epZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YWFyEGW1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pd+soo3r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 17:11:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712682692;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMF+YonfauBpVyCCt7CBoFb+dxitG5lhjHywmo0GQAM=;
	b=YWFyEGW1ThkfX1Sn5C0o7v5AyOWLOt31rNl8bNEGQpJ3m/FXgqypk6DH5DUMuUMI45kCzK
	9ca88XojJzRkZHmar4eKBkNwB9cKjAj91yvkGzei/hBK27LuCYI14g6cnlUkxZRQGnuJLH
	v7qhi9PhIHZikKSM0rVBFowzmdR2Sg+Ehz7XRuIV/F7vuU7TMqGHCm4kPg9DLLdh6xBEVV
	HjfScohDDBQhAONk2edxBMXiI5K0KY1S1hd1+5vqrAYcRb7VhWYmmPpukZko4Os/onOVJi
	gtdZplpa+NhHpo7nLoV/Xjt7E7PWm11P5uyx2PZi4jB+JMprhc3cGuXa1d7Vdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712682692;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMF+YonfauBpVyCCt7CBoFb+dxitG5lhjHywmo0GQAM=;
	b=pd+soo3rTE+2j9ABhRwSxsAUEtpJLBMb1a3sej3pGh0TqWPrpo3le/LKmTZTnAsMC75XT2
	ycqhYR/GC3RU6iBg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Use a temporary buffer when
 optimizing NOPs
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240130105941.19707-2-bp@alien8.de>
References: <20240130105941.19707-2-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171268269191.10875.7152781174116674165.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     f796c75837623058db1ff93252b9f1681306b83d
Gitweb:        https://git.kernel.org/tip/f796c75837623058db1ff93252b9f1681306b83d
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 30 Jan 2024 11:59:38 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 09 Apr 2024 18:08:11 +02:00

x86/alternatives: Use a temporary buffer when optimizing NOPs

Instead of optimizing NOPs in-place, use a temporary buffer like the
usual alternatives patching flow does. This obviates the need to grab
locks when patching, see

  6778977590da ("x86/alternatives: Disable interrupts and sync when optimizing NOPs in place")

While at it, add nomenclature definitions clarifying and simplifying the
naming of function-local variables in the alternatives code.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240130105941.19707-2-bp@alien8.de
---
 arch/x86/include/asm/text-patching.h |  2 +-
 arch/x86/kernel/alternative.c        | 84 ++++++++++++++-------------
 arch/x86/kernel/callthunks.c         |  9 +--
 3 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 345aafb..6259f19 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -15,7 +15,7 @@
 
 extern void text_poke_early(void *addr, const void *opcode, size_t len);
 
-extern void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len);
+extern void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len);
 
 /*
  * Clear and restore the kernel write-protection flag on the local CPU.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 45a280f..ec94f13 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -125,6 +125,20 @@ const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
 };
 
 /*
+ * Nomenclature for variable names to simplify and clarify this code and ease
+ * any potential staring at it:
+ *
+ * @instr: source address of the original instructions in the kernel text as
+ * generated by the compiler.
+ *
+ * @buf: temporary buffer on which the patching operates. This buffer is
+ * eventually text-poked into the kernel image.
+ *
+ * @replacement/@repl: pointer to the opcodes which are replacing @instr, located
+ * in the .altinstr_replacement section.
+ */
+
+/*
  * Fill the buffer with a single effective instruction of size @len.
  *
  * In order not to issue an ORC stack depth tracking CFI entry (Call Frame Info)
@@ -133,28 +147,28 @@ const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
  * each single-byte NOPs). If @len to fill out is > ASM_NOP_MAX, pad with INT3 and
  * *jump* over instead of executing long and daft NOPs.
  */
-static void add_nop(u8 *instr, unsigned int len)
+static void add_nop(u8 *buf, unsigned int len)
 {
-	u8 *target = instr + len;
+	u8 *target = buf + len;
 
 	if (!len)
 		return;
 
 	if (len <= ASM_NOP_MAX) {
-		memcpy(instr, x86_nops[len], len);
+		memcpy(buf, x86_nops[len], len);
 		return;
 	}
 
 	if (len < 128) {
-		__text_gen_insn(instr, JMP8_INSN_OPCODE, instr, target, JMP8_INSN_SIZE);
-		instr += JMP8_INSN_SIZE;
+		__text_gen_insn(buf, JMP8_INSN_OPCODE, buf, target, JMP8_INSN_SIZE);
+		buf += JMP8_INSN_SIZE;
 	} else {
-		__text_gen_insn(instr, JMP32_INSN_OPCODE, instr, target, JMP32_INSN_SIZE);
-		instr += JMP32_INSN_SIZE;
+		__text_gen_insn(buf, JMP32_INSN_OPCODE, buf, target, JMP32_INSN_SIZE);
+		buf += JMP32_INSN_SIZE;
 	}
 
-	for (;instr < target; instr++)
-		*instr = INT3_INSN_OPCODE;
+	for (;buf < target; buf++)
+		*buf = INT3_INSN_OPCODE;
 }
 
 extern s32 __retpoline_sites[], __retpoline_sites_end[];
@@ -187,12 +201,12 @@ static bool insn_is_nop(struct insn *insn)
  * Find the offset of the first non-NOP instruction starting at @offset
  * but no further than @len.
  */
-static int skip_nops(u8 *instr, int offset, int len)
+static int skip_nops(u8 *buf, int offset, int len)
 {
 	struct insn insn;
 
 	for (; offset < len; offset += insn.length) {
-		if (insn_decode_kernel(&insn, &instr[offset]))
+		if (insn_decode_kernel(&insn, &buf[offset]))
 			break;
 
 		if (!insn_is_nop(&insn))
@@ -207,7 +221,7 @@ static int skip_nops(u8 *instr, int offset, int len)
  * to the end of the NOP sequence into a single NOP.
  */
 static bool
-__optimize_nops(u8 *instr, size_t len, struct insn *insn, int *next, int *prev, int *target)
+__optimize_nops(const u8 * const instr, u8 *buf, size_t len, struct insn *insn, int *next, int *prev, int *target)
 {
 	int i = *next - insn->length;
 
@@ -222,12 +236,12 @@ __optimize_nops(u8 *instr, size_t len, struct insn *insn, int *next, int *prev, 
 	if (insn_is_nop(insn)) {
 		int nop = i;
 
-		*next = skip_nops(instr, *next, len);
+		*next = skip_nops(buf, *next, len);
 		if (*target && *next == *target)
 			nop = *prev;
 
-		add_nop(instr + nop, *next - nop);
-		DUMP_BYTES(ALT, instr, len, "%px: [%d:%d) optimized NOPs: ", instr, nop, *next);
+		add_nop(buf + nop, *next - nop);
+		DUMP_BYTES(ALT, buf, len, "%px: [%d:%d) optimized NOPs: ", instr, nop, *next);
 		return true;
 	}
 
@@ -239,32 +253,22 @@ __optimize_nops(u8 *instr, size_t len, struct insn *insn, int *next, int *prev, 
  * "noinline" to cause control flow change and thus invalidate I$ and
  * cause refetch after modification.
  */
-static void __init_or_module noinline optimize_nops(u8 *instr, size_t len)
+static void __init_or_module noinline optimize_nops(const u8 * const instr, u8 *buf, size_t len)
 {
 	int prev, target = 0;
 
 	for (int next, i = 0; i < len; i = next) {
 		struct insn insn;
 
-		if (insn_decode_kernel(&insn, &instr[i]))
+		if (insn_decode_kernel(&insn, &buf[i]))
 			return;
 
 		next = i + insn.length;
 
-		__optimize_nops(instr, len, &insn, &next, &prev, &target);
+		__optimize_nops(instr, buf, len, &insn, &next, &prev, &target);
 	}
 }
 
-static void __init_or_module noinline optimize_nops_inplace(u8 *instr, size_t len)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	optimize_nops(instr, len);
-	sync_core();
-	local_irq_restore(flags);
-}
-
 /*
  * In this context, "source" is where the instructions are placed in the
  * section .altinstr_replacement, for example during kernel build by the
@@ -335,11 +339,11 @@ bool need_reloc(unsigned long offset, u8 *src, size_t src_len)
 	return (target < src || target > src + src_len);
 }
 
-void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
+void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len)
 {
 	int prev, target = 0;
 
-	for (int next, i = 0; i < len; i = next) {
+	for (int next, i = 0; i < instrlen; i = next) {
 		struct insn insn;
 
 		if (WARN_ON_ONCE(insn_decode_kernel(&insn, &buf[i])))
@@ -347,7 +351,7 @@ void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 
 		next = i + insn.length;
 
-		if (__optimize_nops(buf, len, &insn, &next, &prev, &target))
+		if (__optimize_nops(instr, buf, instrlen, &insn, &next, &prev, &target))
 			continue;
 
 		switch (insn.opcode.bytes[0]) {
@@ -361,10 +365,10 @@ void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 		case JMP8_INSN_OPCODE:
 		case JMP32_INSN_OPCODE:
 		case CALL_INSN_OPCODE:
-			if (need_reloc(next + insn.immediate.value, src, src_len)) {
+			if (need_reloc(next + insn.immediate.value, repl, repl_len)) {
 				apply_reloc(insn.immediate.nbytes,
 					    buf + i + insn_offset_immediate(&insn),
-					    src - dest);
+					    repl - instr);
 			}
 
 			/*
@@ -372,7 +376,7 @@ void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 			 */
 			if (insn.opcode.bytes[0] == JMP32_INSN_OPCODE) {
 				s32 imm = insn.immediate.value;
-				imm += src - dest;
+				imm += repl - instr;
 				imm += JMP32_INSN_SIZE - JMP8_INSN_SIZE;
 				if ((imm >> 31) == (imm >> 7)) {
 					buf[i+0] = JMP8_INSN_OPCODE;
@@ -385,10 +389,10 @@ void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 		}
 
 		if (insn_rip_relative(&insn)) {
-			if (need_reloc(next + insn.displacement.value, src, src_len)) {
+			if (need_reloc(next + insn.displacement.value, repl, repl_len)) {
 				apply_reloc(insn.displacement.nbytes,
 					    buf + i + insn_offset_displacement(&insn),
-					    src - dest);
+					    repl - instr);
 			}
 		}
 	}
@@ -504,7 +508,9 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		 *   patch if feature is *NOT* present.
 		 */
 		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
-			optimize_nops_inplace(instr, a->instrlen);
+			memcpy(insn_buff, instr, a->instrlen);
+			optimize_nops(instr, insn_buff, a->instrlen);
+			text_poke_early(instr, insn_buff, a->instrlen);
 			continue;
 		}
 
@@ -526,7 +532,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 
-		apply_relocation(insn_buff, a->instrlen, instr, replacement, a->replacementlen);
+		apply_relocation(insn_buff, instr, a->instrlen, replacement, a->replacementlen);
 
 		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
 		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
@@ -761,7 +767,7 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 
 		len = patch_retpoline(addr, &insn, bytes);
 		if (len == insn.length) {
-			optimize_nops(bytes, len);
+			optimize_nops(addr, bytes, len);
 			DUMP_BYTES(RETPOLINE, ((u8*)addr),  len, "%px: orig: ", addr);
 			DUMP_BYTES(RETPOLINE, ((u8*)bytes), len, "%px: repl: ", addr);
 			text_poke_early(addr, bytes, len);
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index e92ff0c..4656474 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -185,8 +185,7 @@ static void *patch_dest(void *dest, bool direct)
 	u8 *pad = dest - tsize;
 
 	memcpy(insn_buff, skl_call_thunk_template, tsize);
-	apply_relocation(insn_buff, tsize, pad,
-			 skl_call_thunk_template, tsize);
+	apply_relocation(insn_buff, pad, tsize, skl_call_thunk_template, tsize);
 
 	/* Already patched? */
 	if (!bcmp(pad, insn_buff, tsize))
@@ -308,8 +307,7 @@ static bool is_callthunk(void *addr)
 	pad = (void *)(dest - tmpl_size);
 
 	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
-	apply_relocation(insn_buff, tmpl_size, pad,
-			 skl_call_thunk_template, tmpl_size);
+	apply_relocation(insn_buff, pad, tmpl_size, skl_call_thunk_template, tmpl_size);
 
 	return !bcmp(pad, insn_buff, tmpl_size);
 }
@@ -327,8 +325,7 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
 		return 0;
 
 	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
-	apply_relocation(insn_buff, tmpl_size, ip,
-			 skl_call_thunk_template, tmpl_size);
+	apply_relocation(insn_buff, ip, tmpl_size, skl_call_thunk_template, tmpl_size);
 
 	memcpy(*pprog, insn_buff, tmpl_size);
 	*pprog += tmpl_size;

