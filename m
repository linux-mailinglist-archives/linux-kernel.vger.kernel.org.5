Return-Path: <linux-kernel+bounces-133898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB3A89AA80
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3627A1F21A52
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6792C6B7;
	Sat,  6 Apr 2024 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dJdH2x52";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r279CCgR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2124219;
	Sat,  6 Apr 2024 11:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712401681; cv=none; b=hxy1nX3uMJutNTnjUwxK8ho+pFTiWUomVdgiEYKPtT/8ysZskITeD5h5TnQUKlWkjUc8dGCVYfVunOjQSiztv/S37v9UWeqhdnS4GLh+GCgnGxP9zgQlGlQ84iK8SRlWXDwQ29ccJIZWT/JqjuF79Ox6z+Jx7A4qXuLVstq5aXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712401681; c=relaxed/simple;
	bh=EtAvrxwb3wNLzH5Et72bsbOizcpLgTpxxUcMAYME1C0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F+nnPn3soKCadKmAKZ5yfYxx5+LpKpcEDyWerR7sZMIDdWWrLoRCEmu43Dlgz+PYjvrg6lNm5IgyL0vRgD/KNyoIRhC81k/vuGMyLlL4AP2jLBQ46FAodfd6IBvE2ZbDQSB+yezSvZCCLXkCMDRkdLxVQ8m9maQQEm3vgEOM85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dJdH2x52; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r279CCgR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 06 Apr 2024 11:07:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712401678;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s83HeeqehO4rlHoAz788hUzh9Pm7jM/NKUzLWyUOxU4=;
	b=dJdH2x52mdo+jUO0jUITsY0LdowAIdVw/uUsCiQT4YBvJI36DrTo/dwBnv01GRzb3vVmd9
	+U8Vvq7FA7yqlH9lsLnw2oEh71rCXeonbOitO6/+VJlgrALzQ0xI/K1+chdbxhyFiXWDz3
	Ok+dX4yS2b0nfXoAq0N63PjaALX8FEEwIVm6NjbHr1/8iVTj14lbinMCgmf5SO6ZQxD32Z
	Pwyh+pdl6STNIMygEHud0n5a5URZy/uwSySVtjqxO+PNtbSCxkqnyOn3kaGW2wZ3ky3Jn1
	zq5zkhxQuLzv0/mFeE6AJQg4bSjoI+n77WQyLglriCsEz+MCvGupyFz4VN5JEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712401678;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s83HeeqehO4rlHoAz788hUzh9Pm7jM/NKUzLWyUOxU4=;
	b=r279CCgRzlsJp/y5bMeOdAiWfiPHi9wiplQ81H2iSzpAqaeckf8BSwf9g5ClRG2wFUb78U
	x1haHgRNFX2PGJBg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Rewrite x86_this_cpu_test_bit() and
 friends as macros
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240404094218.448963-2-ubizjak@gmail.com>
References: <20240404094218.448963-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171240167712.10875.8346272529060813426.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     a3f8a3a2cf0b7b3ccb51ee60d51c0b5435c7135a
Gitweb:        https://git.kernel.org/tip/a3f8a3a2cf0b7b3ccb51ee60d51c0b5435c7135a
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 04 Apr 2024 11:42:02 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Apr 2024 12:42:17 +02:00

x86/percpu: Rewrite x86_this_cpu_test_bit() and friends as macros

Rewrite the whole family of x86_this_cpu_test_bit() functions
as macros, so standard __my_cpu_var() and raw_cpu_read() macros
can be used on percpu variables. This approach considerably
simplifies implementation of functions and also introduces
standard checks on accessed percpu variables.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240404094218.448963-2-ubizjak@gmail.com
---
 arch/um/include/asm/cpufeature.h  |  3 +--
 arch/x86/include/asm/cpufeature.h |  3 +--
 arch/x86/include/asm/percpu.h     | 54 ++++++++++++------------------
 3 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/arch/um/include/asm/cpufeature.h b/arch/um/include/asm/cpufeature.h
index 66fe06d..1eb8b83 100644
--- a/arch/um/include/asm/cpufeature.h
+++ b/arch/um/include/asm/cpufeature.h
@@ -38,8 +38,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 #define this_cpu_has(bit)						\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
-	 x86_this_cpu_test_bit(bit,					\
-		(unsigned long __percpu *)&cpu_info.x86_capability))
+	 x86_this_cpu_test_bit(bit, cpu_info.x86_capability))
 
 /*
  * This macro is for detection of features which need kernel
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 42157dd..cd4c02d 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -127,8 +127,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 #define this_cpu_has(bit)						\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
-	 x86_this_cpu_test_bit(bit,					\
-		(unsigned long __percpu *)&cpu_info.x86_capability))
+	 x86_this_cpu_test_bit(bit, cpu_info.x86_capability))
 
 /*
  * This macro is for detection of features which need kernel
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index cbfbbe8..d6ff0db 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -96,7 +96,7 @@
 #endif /* CONFIG_SMP */
 
 #define __my_cpu_type(var)	typeof(var) __percpu_seg_override
-#define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr)*)(__force uintptr_t)(ptr)
+#define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
 #define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
 #define __percpu_arg(x)		__percpu_prefix "%" #x
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
@@ -568,37 +568,29 @@ do {									\
 #define this_cpu_read_stable_8(pcp)    ({ BUILD_BUG(); (typeof(pcp))0; })
 #endif
 
-static __always_inline bool x86_this_cpu_constant_test_bit(unsigned int nr,
-                        const unsigned long __percpu *addr)
-{
-	unsigned long __percpu *a =
-		(unsigned long __percpu *)addr + nr / BITS_PER_LONG;
+#define x86_this_cpu_constant_test_bit(_nr, _var)			\
+({									\
+	unsigned long __percpu *addr__ =				\
+		(unsigned long __percpu *)&(_var) + ((_nr) / BITS_PER_LONG); \
+	!!((1UL << ((_nr) % BITS_PER_LONG)) & raw_cpu_read(*addr__));	\
+})
 
-#ifdef CONFIG_X86_64
-	return ((1UL << (nr % BITS_PER_LONG)) & raw_cpu_read_8(*a)) != 0;
-#else
-	return ((1UL << (nr % BITS_PER_LONG)) & raw_cpu_read_4(*a)) != 0;
-#endif
-}
-
-static inline bool x86_this_cpu_variable_test_bit(int nr,
-                        const unsigned long __percpu *addr)
-{
-	bool oldbit;
-
-	asm volatile("btl %[nr], " __percpu_arg([var])
-			CC_SET(c)
-			: CC_OUT(c) (oldbit)
-			: [var] "m" (*__my_cpu_ptr((unsigned long __percpu *)(addr))),
-			  [nr] "Ir" (nr));
-
-	return oldbit;
-}
-
-#define x86_this_cpu_test_bit(nr, addr)			\
-	(__builtin_constant_p((nr))			\
-	 ? x86_this_cpu_constant_test_bit((nr), (addr))	\
-	 : x86_this_cpu_variable_test_bit((nr), (addr)))
+#define x86_this_cpu_variable_test_bit(_nr, _var)		\
+({								\
+	bool oldbit;						\
+								\
+	asm volatile("btl %[nr], " __percpu_arg([var])		\
+		     CC_SET(c)					\
+		     : CC_OUT(c) (oldbit)			\
+		     : [var] "m" (__my_cpu_var(_var)),		\
+		       [nr] "rI" (_nr));			\
+	oldbit;							\
+})
+
+#define x86_this_cpu_test_bit(_nr, _var)			\
+	(__builtin_constant_p(_nr)				\
+	 ? x86_this_cpu_constant_test_bit(_nr, _var)		\
+	 : x86_this_cpu_variable_test_bit(_nr, _var))
 
 
 #include <asm-generic/percpu.h>

