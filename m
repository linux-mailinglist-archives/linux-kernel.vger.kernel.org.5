Return-Path: <linux-kernel+bounces-39115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8D683CB00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBAE2991AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1219D14460A;
	Thu, 25 Jan 2024 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J4Ez8YzM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bEYvgHUM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04932140768;
	Thu, 25 Jan 2024 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206904; cv=none; b=W6fFwhjInGl0YvS9rDG9ShqmHYtYFjfc/+0cOGiAZKC6v0Z2XTzcgPj+ENjFrx5Hxu5b0Rb4fI4ryLK8YJ63IVUEjxIuOs22nSOZA/8OIujWUEq/7kJZaSnZJNKutc/xMmYDV5ncoD/isBbd7gRZJp2e0TrOncBUJAe1Uf0EnXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206904; c=relaxed/simple;
	bh=EhqCSlCs+nFqSs5SFZ96QFNLmlgWStSluZNfkpHERxI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B/PIqeezdHxADDtTqv7suUQLT4ifSDRIkTd51ryx5Ri2BqndDC27cyQOJGCGoxdZ2vpNJj89AaQwEkIEcy2JClZHsuG7LmtOEZwAHphT+51LhmxFrzMi2UpQmwiGhPxZWVqeN9bewesR20H0WP+dGfj7S+hV+vUHn9yhYvXw12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J4Ez8YzM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bEYvgHUM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206900;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5KHAWE3vDLVa1vlc6fc+ULPLLryNpy1gDxxoXtsKTU=;
	b=J4Ez8YzMo8fceYQMPRvesURforIyZJmm6ESPY4BRTdcif6ENbDJisGwF+DK9aIHZG4MaNI
	XL/tOjB5jCyGGpYc3DK5felYSmAjpiDJRFzJ5aGLMRK1xoqlqLgaa+w4DZcSl8G1E9QnmZ
	z4NEMHG0bFxmt1nyecid8wgSLCFhhuyq+TnOjzuaehY6xmG/C6Pt3rbGkWGktEaF+JicaS
	qPdNUYs6s4LNKwHkHJscNURBeM/X+jisMVZbZy/WKFTQoykZdQfbuCeAOmzZ8NW0scOJeO
	x6nGjsdNV8UHymQsVowb08Vo0Q0BYl3Oya/e4aCAbxN3xYOYlahxQp4dAHt77A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206900;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5KHAWE3vDLVa1vlc6fc+ULPLLryNpy1gDxxoXtsKTU=;
	b=bEYvgHUMvkd25IfW8YNzpShvGmtlOXVDJ4mQLUweCkyIyCvce6iN1LhCx+HP8Lzx76gqYW
	E8J2podxzjye35Ag==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/cpufeatures,opcode,msr: Add the WRMSRNS
 instruction support
Cc: Xin Li <xin3.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Shan Kang <shan.kang@intel.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-2-xin3.li@intel.com>
References: <20231205105030.8698-2-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620689975.398.11199510172533245378.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     a4cb5ece145828cae35503857debf3d49c9d1c5f
Gitweb:        https://git.kernel.org/tip/a4cb5ece145828cae35503857debf3d49c9d1c5f
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:49:50 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:29 +01:00

x86/cpufeatures,opcode,msr: Add the WRMSRNS instruction support

WRMSRNS is an instruction that behaves exactly like WRMSR, with
the only difference being that it is not a serializing instruction
by default. Under certain conditions, WRMSRNS may replace WRMSR to
improve performance.

Add its CPU feature bit, opcode to the x86 opcode map, and an
always inline API __wrmsrns() to embed WRMSRNS into the code.

Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231205105030.8698-2-xin3.li@intel.com

---
 arch/x86/include/asm/cpufeatures.h       |  1 +
 arch/x86/include/asm/msr.h               | 18 ++++++++++++++++++
 arch/x86/lib/x86-opcode-map.txt          |  2 +-
 tools/arch/x86/include/asm/cpufeatures.h |  1 +
 tools/arch/x86/lib/x86-opcode-map.txt    |  2 +-
 5 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 29cb275..bd05c75 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -327,6 +327,7 @@
 #define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
 #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
+#define X86_FEATURE_WRMSRNS		(12*32+19) /* "" Non-serializing WRMSR */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
 #define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 65ec196..c284ff9 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -97,6 +97,19 @@ static __always_inline void __wrmsr(unsigned int msr, u32 low, u32 high)
 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
 
+/*
+ * WRMSRNS behaves exactly like WRMSR with the only difference being
+ * that it is not a serializing instruction by default.
+ */
+static __always_inline void __wrmsrns(u32 msr, u32 low, u32 high)
+{
+	/* Instruction opcode for WRMSRNS; supported in binutils >= 2.40. */
+	asm volatile("1: .byte 0x0f,0x01,0xc6\n"
+		     "2:\n"
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
+		     : : "c" (msr), "a"(low), "d" (high));
+}
+
 #define native_rdmsr(msr, val1, val2)			\
 do {							\
 	u64 __val = __rdmsr((msr));			\
@@ -297,6 +310,11 @@ do {							\
 
 #endif	/* !CONFIG_PARAVIRT_XXL */
 
+static __always_inline void wrmsrns(u32 msr, u64 val)
+{
+	__wrmsrns(msr, val, val >> 32);
+}
+
 /*
  * 64-bit version of wrmsr_safe():
  */
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 5168ee0..1efe1d9 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -1051,7 +1051,7 @@ GrpTable: Grp6
 EndTable
 
 GrpTable: Grp7
-0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
+0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
 1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index f4542d2..8792841 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -322,6 +322,7 @@
 #define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
 #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
+#define X86_FEATURE_WRMSRNS		(12*32+19) /* "" Non-serializing WRMSR */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
 #define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 5168ee0..1efe1d9 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -1051,7 +1051,7 @@ GrpTable: Grp6
 EndTable
 
 GrpTable: Grp7
-0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
+0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
 1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms

