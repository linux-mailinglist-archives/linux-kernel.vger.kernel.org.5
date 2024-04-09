Return-Path: <linux-kernel+bounces-137375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5764E89E12A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127DA1C22A33
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D998156249;
	Tue,  9 Apr 2024 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GdpmjY0a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DBrYyxbC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968AC1553A4;
	Tue,  9 Apr 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682695; cv=none; b=STTVqZM/osTfEiT1urLCkxduvYrZZvDBZWmfit/LhVPxKgVHmoHrp4I4+1FtdExtduGuyakeYOsIqL8V+sH5JJIgf8m5d5K2u/SbknhRiqixet91QU8uKB5LbQMK93OhkD11hUhNbUQ55YKaIJKibdOZVi85ipBFSefroM/1Fx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682695; c=relaxed/simple;
	bh=ljDoht4gIlHXgQ6DZZC+hSQ58lkGXg1Z5Yy/e4jU4yE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=idSliUMxbQ9YfUwCZjPAT17pwzK8Axbq0nu/xUiUZu2M+HjvuzkW7QVpgeZPKLFyrACI3ZpbTr7D4Ggw5rubmb1boRaFVular5FXzPItgF6994iy3rWDZ56WwWUqkR4MVxCjzJLIk/T35AXEbqSUcfTkYtTgTOWiJBiWVqBzGuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GdpmjY0a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DBrYyxbC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 17:11:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712682692;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPHgoV226yo0QsYY4d4QVrUTyTxT8ywuyVMZLoQ9rKE=;
	b=GdpmjY0asF2ZAfhtH1pff4nyam1LrMxAxvw94P+jhceQroVUMPOOoNcDCCHOwySmR+mt5v
	TnSfUk4AIhm7YeGZnWkiWWve/EomoHEUMMXSqnhf4HVv+UytOYAqywhfmOOtMGwaP5zDPn
	JvMNNeL+8t9yEuQs9SIZDY7JBaazmBlZRbxOe2+nkvPo/5Mj4MKFZ/+g2YIEQLhTabxRVh
	sj/T0AcnJc2+/mwfYb1SFO/d4Bp1U8UPUrgyJnVUdLllLK6LfS1FSHt7bzxTPYAT2RsiHY
	GuRlWC1Sk6gVJXIG2oPwI3M+i3xHshndGkzL2qiZVRf1HO5FcyIOqZuBKe23eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712682692;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPHgoV226yo0QsYY4d4QVrUTyTxT8ywuyVMZLoQ9rKE=;
	b=DBrYyxbCls7zP7qkJrkx34kjM0Q06zzA6fG/ImbblyC++6XrNr1B92otGHiLbDqmaejaQW
	LzuEfNKhI9lf4GCg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternatives: Get rid of __optimize_nops()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240130105941.19707-3-bp@alien8.de>
References: <20240130105941.19707-3-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171268269023.10875.4449485630574875156.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     da8f9cf7e721c690ca169fa88641a6c4cee5cae4
Gitweb:        https://git.kernel.org/tip/da8f9cf7e721c690ca169fa88641a6c4cee5cae4
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 30 Jan 2024 11:59:39 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 09 Apr 2024 18:12:53 +02:00

x86/alternatives: Get rid of __optimize_nops()

There's no need to carve out bits of the NOP optimization functionality
and look at JMP opcodes - simply do one more NOPs optimization pass
at the end of patching.

A lot simpler code.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240130105941.19707-3-bp@alien8.de
---
 arch/x86/kernel/alternative.c | 59 +++++++++-------------------------
 1 file changed, 16 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ec94f13..4b3378c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -217,46 +217,11 @@ static int skip_nops(u8 *buf, int offset, int len)
 }
 
 /*
- * Optimize a sequence of NOPs, possibly preceded by an unconditional jump
- * to the end of the NOP sequence into a single NOP.
- */
-static bool
-__optimize_nops(const u8 * const instr, u8 *buf, size_t len, struct insn *insn, int *next, int *prev, int *target)
-{
-	int i = *next - insn->length;
-
-	switch (insn->opcode.bytes[0]) {
-	case JMP8_INSN_OPCODE:
-	case JMP32_INSN_OPCODE:
-		*prev = i;
-		*target = *next + insn->immediate.value;
-		return false;
-	}
-
-	if (insn_is_nop(insn)) {
-		int nop = i;
-
-		*next = skip_nops(buf, *next, len);
-		if (*target && *next == *target)
-			nop = *prev;
-
-		add_nop(buf + nop, *next - nop);
-		DUMP_BYTES(ALT, buf, len, "%px: [%d:%d) optimized NOPs: ", instr, nop, *next);
-		return true;
-	}
-
-	*target = 0;
-	return false;
-}
-
-/*
  * "noinline" to cause control flow change and thus invalidate I$ and
  * cause refetch after modification.
  */
-static void __init_or_module noinline optimize_nops(const u8 * const instr, u8 *buf, size_t len)
+static void noinline optimize_nops(const u8 * const instr, u8 *buf, size_t len)
 {
-	int prev, target = 0;
-
 	for (int next, i = 0; i < len; i = next) {
 		struct insn insn;
 
@@ -265,7 +230,14 @@ static void __init_or_module noinline optimize_nops(const u8 * const instr, u8 *
 
 		next = i + insn.length;
 
-		__optimize_nops(instr, buf, len, &insn, &next, &prev, &target);
+		if (insn_is_nop(&insn)) {
+			int nop = i;
+
+			next = skip_nops(buf, next, len);
+
+			add_nop(buf + nop, next - nop);
+			DUMP_BYTES(ALT, buf, len, "%px: [%d:%d) optimized NOPs: ", instr, nop, next);
+		}
 	}
 }
 
@@ -339,10 +311,8 @@ bool need_reloc(unsigned long offset, u8 *src, size_t src_len)
 	return (target < src || target > src + src_len);
 }
 
-void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len)
+static void __apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len)
 {
-	int prev, target = 0;
-
 	for (int next, i = 0; i < instrlen; i = next) {
 		struct insn insn;
 
@@ -351,9 +321,6 @@ void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl
 
 		next = i + insn.length;
 
-		if (__optimize_nops(instr, buf, instrlen, &insn, &next, &prev, &target))
-			continue;
-
 		switch (insn.opcode.bytes[0]) {
 		case 0x0f:
 			if (insn.opcode.bytes[1] < 0x80 ||
@@ -398,6 +365,12 @@ void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl
 	}
 }
 
+void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len)
+{
+	__apply_relocation(buf, instr, instrlen, repl, repl_len);
+	optimize_nops(instr, buf, repl_len);
+}
+
 /* Low-level backend functions usable from alternative code replacements. */
 DEFINE_ASM_FUNC(nop_func, "", .entry.text);
 EXPORT_SYMBOL_GPL(nop_func);

