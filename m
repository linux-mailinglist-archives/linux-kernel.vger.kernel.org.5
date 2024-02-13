Return-Path: <linux-kernel+bounces-63815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B538534CD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C6A1C22144
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB825FBA9;
	Tue, 13 Feb 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OblL9XPv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NhPku5T1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D335F845;
	Tue, 13 Feb 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838564; cv=none; b=jAntLlrh4mXK+LF144O6AjgIvN75y4zF5CPlq+CRSibSFlwJkX9qjI4WpBFgJKt6zvZZYLkt8bgODNRRpXmdHvCoWQVlYjXcCCJLHRkx4hG/7Zb+RjHOe8KnPcjnjsSdfN1oKE0qWxvDyWF9p/OAv5BEEENmDHNjhlX/0izYbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838564; c=relaxed/simple;
	bh=2C083pQq7ejIrNta8rh79xzMjzLHYxYyMm1x6sR7OFM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Uv5RzOCw1Xtb4PXSGyggwNrSUKzOr8BWe9DefjBwh2clpdVS+oMtNKuyePpS8O4hzrUwCk7cVeBmDZ+02jJPCpGpPgnvqF3Ke0oK/U1+v7YDNHlQCSt4Pxi/88yV1UVaHSdci7HMBGFn/4mtPt9U3X5f0iUPtUKOcMX/TXFQUek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OblL9XPv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NhPku5T1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 15:35:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707838560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAKmX6rPfaSfxw6d+7kK2rtkhTI+gZJ1FunDM/XzF6k=;
	b=OblL9XPv4uv5vc7YMGp0fC3axOAL58Utj2Gw99L85USrtYbDmth5eWj+0QStqa5j14YK36
	8xg40QIIuwwxG9fkcPePcNgHwSOQawLEIqFh/Irj2qnlzlytuxw9HnpYRLW2IESCFm0hVX
	OZvktqEg2SdvqcUujVprlvGAhoviaW32ZzlhxwM6FlTWBiXDxXD+hg6LB3YParqzXNTdWV
	4mfClZDsa/Raqy2Q1U+yVzstkCmEQkxR1P1uidNXVPmntHyzQONGSFJWDyS3nc5fBYJMVB
	5zvbgUk7BkVeKHJYd+g6Ge/LQBiB57ABdyvNFQoEKWE3AyJZQXY7CAd/1QjcnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707838560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAKmX6rPfaSfxw6d+7kK2rtkhTI+gZJ1FunDM/XzF6k=;
	b=NhPku5T1HgkM7WBIW7SIMgHNiOpN7R7vpQi87xVQ91lnypVzYG6He9lMl5YzQxftfva77Q
	kQ4zQsRdCNd2QRDw==
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
Message-ID: <170783855963.398.15553842134757811644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     f9265b75648165f61467a7ea3c9bbae33be7ce27
Gitweb:        https://git.kernel.org/tip/f9265b75648165f61467a7ea3c9bbae33be7ce27
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 30 Jan 2024 11:59:39 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 Feb 2024 16:25:46 +01:00

x86/alternatives: Get rid of __optimize_nops()

There's no need to carve out bits of the NOP optimization functionality
and look at JMP opcodes - simply do one more NOPs optimization pass
at the end of patching.

A lot simpler code.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240130105941.19707-3-bp@alien8.de
---
 arch/x86/kernel/alternative.c | 52 ++++++----------------------------
 1 file changed, 10 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 835e343..cdbece3 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -217,46 +217,11 @@ static int skip_nops(u8 *buf, int offset, int len)
 }
 
 /*
- * Optimize a sequence of NOPs, possibly preceded by an unconditional jump
- * to the end of the NOP sequence into a single NOP.
- */
-static bool __init_or_module
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
 static void __init_or_module noinline optimize_nops(const u8 * const instr, u8 *buf, size_t len)
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
 
@@ -342,8 +314,6 @@ bool need_reloc(unsigned long offset, u8 *src, size_t src_len)
 static void __init_or_module noinline
 apply_relocation(const u8 * const instr, u8 *buf, size_t len, u8 *src, size_t src_len)
 {
-	int prev, target = 0;
-
 	for (int next, i = 0; i < len; i = next) {
 		struct insn insn;
 
@@ -352,9 +322,6 @@ apply_relocation(const u8 * const instr, u8 *buf, size_t len, u8 *src, size_t sr
 
 		next = i + insn.length;
 
-		if (__optimize_nops(instr, buf, len, &insn, &next, &prev, &target))
-			continue;
-
 		switch (insn.opcode.bytes[0]) {
 		case 0x0f:
 			if (insn.opcode.bytes[1] < 0x80 ||
@@ -533,7 +500,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 
-		apply_relocation(instr, insn_buff, a->instrlen, replacement, a->replacementlen);
+		apply_relocation(instr, insn_buff, a->instrlen, replacement, insn_buff_sz);
+		optimize_nops(instr, insn_buff, insn_buff_sz);
 
 		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
 		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);

