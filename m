Return-Path: <linux-kernel+bounces-107518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69D987FD93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17AC283FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB02056742;
	Tue, 19 Mar 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pu1kxTEE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bf7gD5hx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926ED18EAB;
	Tue, 19 Mar 2024 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710851504; cv=none; b=X7M6agdLs2TEfkf1dBAEkJj57o4a4mxlJD+CHIE0xIqGml0HXE7xZ+anw8Fc+sNi2rfzbZtTCX3Nf+Y29FKCcT2GgZ+wJ3C+cUezjZBc38ikyHp6cMJj3mfM83z8obq4NtD0sd/SO6tb67JRS441XKXG92BUZxOKGW+c8iQjbfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710851504; c=relaxed/simple;
	bh=Cp2zvHi3YdO5fJpG68cXOQoi6Dn2t3W7B+tLiiRUdfY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hz2j/kUNtdLh0UqjTB/3U5tli+dVR8ko1ducorKEX1r67huQyFzpiDKb8nm9Dlbj1xQMvlUovg5oXoAoOVnA04QEsT0oq52uwU3MKDkVGdpn+NRAZ70JbQGNWAorWcbtDiFvQ7i6gBkc5AgrOy27JCPr+chjFAXXQppy/VXDIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pu1kxTEE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bf7gD5hx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Mar 2024 12:31:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710851500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NShhxMWzFAcofb6ERv0kfsXdobwRDQWQ6WbLMWv2SW8=;
	b=Pu1kxTEEZt1LR6E+GK8fBqu2jvRBZqPBQR22gFtx5azre3YbkGnRifgoaf+I4661vRydtG
	IsB0T9JaNlF1cOyuEzs2aMiEl1Tp1CGuP7VxN3iMEjb+Vby2G8LnMBeu/WxgtN28cyupX1
	jBx09XWm881LuFRs7sKZloQN1bhlRtm8wCafSN0Dsrd/j3I3FzWpN7WyMsmEf3TsUff+D/
	Q7Ivz6qM+3zyY6zaZQLFDS1v8lZzzqavLRejXh6R4Z6vu/VLKbqR6cEJ1QKP1n3AFwMtw2
	rRLhaEr0Hc4MXnCJm039aogYYNNyI/MFVtvNPhwnm7QdQeYaLqmEYJZlx+I7xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710851500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NShhxMWzFAcofb6ERv0kfsXdobwRDQWQ6WbLMWv2SW8=;
	b=bf7gD5hxRau277XHVD0E0EGxHB2rF4eEmKL7lA1jxf7JRDBqyLD/NCYR3iTJy2toEtrQQQ
	QPH3ia3DW05Iz2CQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Use %a instead of %P operand modifier in asm
 templates
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240319104418.284519-4-ubizjak@gmail.com>
References: <20240319104418.284519-4-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171085149958.10875.16469771896365925756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     d689863c1a60b9936b47a34fa5c3330de374f4fc
Gitweb:        https://git.kernel.org/tip/d689863c1a60b9936b47a34fa5c3330de374f4fc
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 19 Mar 2024 11:40:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Mar 2024 13:15:35 +01:00

x86/asm: Use %a instead of %P operand modifier in asm templates

The "P" asm operand modifier is a x86 target-specific modifier.

For x86_64, when used with a symbol reference, the "%P" modifier
emits "sym" instead of "sym(%rip)". This property is currently
used to issue bare symbol reference.

The generic "a" operand modifier should be used instead. The "a"
asm operand modifier substitutes a memory reference, with the
actual operand treated as address.  For x86_64, when a symbol is
provided, the "a" modifier emits "sym(%rip)" instead of "sym",
enabling shorter %rip-relative addressing.

Also note that unlike GCC, clang emits %rip-relative symbol
reference with "P" asm operand modifier, so the patch also unifies
symbol handling with both compilers.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20240319104418.284519-4-ubizjak@gmail.com
---
 arch/x86/include/asm/cpufeature.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index fa938ed..daae5c6 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -172,7 +172,7 @@ static __always_inline bool _static_cpu_has(u16 bit)
 		ALTERNATIVE_TERNARY("jmp 6f", %c[feature], "", "jmp %l[t_no]")
 		".pushsection .altinstr_aux,\"ax\"\n"
 		"6:\n"
-		" testb %[bitnum]," _ASM_RIP(%P[cap_byte]) "\n"
+		" testb %[bitnum], %a[cap_byte]\n"
 		" jnz %l[t_yes]\n"
 		" jmp %l[t_no]\n"
 		".popsection\n"

