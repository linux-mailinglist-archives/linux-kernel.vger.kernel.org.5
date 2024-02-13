Return-Path: <linux-kernel+bounces-63678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EF685331F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD5828349A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25CB58235;
	Tue, 13 Feb 2024 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfS+y//Q"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40958234
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834568; cv=none; b=QkJ/RNZGhcTMv3d5lJaAZWzrjHilOFjyebFXFR4qcH8Doi+QCbokyO6/5bXCLrzAqvI9aCin0IHrw3GWD8uSZQCRypkFUg0qmR8nfO0VuNiNeqcybwjtau5RZ7ncvHCTgmdT2LDEuJqRomGk5R+L3CeByPMbt4EGwZg+v1rMKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834568; c=relaxed/simple;
	bh=+mPsQFxDyv4xoZGkFnZUtpvg7QmtVFk4n4nJyEwpkmo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UUnwHxom3Md9aolg2WD80eiDY7VV/vv9u8c7K+sKwZ8SQK8gzW9yuElJp9U2MOYTt+E6wWhaTEJN99Ur/cI0nlraR7tousYuEZRTkExvkhqOkXmB1/0oLwuOrBBN6XKVEc+jya6X9zg8P4IPaMMALHC5v9HsK6iK4Kd8/rBkhKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cfS+y//Q; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so5160098276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707834565; x=1708439365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2A5s0YU98xz4fK0cK8V3de3MUudesnEU1GM23Fa1guU=;
        b=cfS+y//Qmsa7flvrPo4j5c50dlYdoWB/Hrpav9kv0Joyw+GaCriJkiyKqfdAgK3Ydb
         AOC4LU/gzCRZsYqdS2PAskoHzNaK2+Hc5mW8ok5oD9zfVACljRuR3VLPgwgKEupm3X74
         wSUwW8XU7t3NaKJWC4dobib7BFaHdqGYGTQ1yK+cCzVaszn4qKSGmEWYeM98NS5OmZKR
         rtkUrERPFpQJ92W9MLoR2kj8qIl1XlQvAyj6Yu1UwTpVb4XT+3KlGyL+4SiU7+Zf5oJl
         OJRnEmz0CL96clh/0xOGvbSvwlmZj4GdYqFdp7aQbC+NhL57ZJWYdyTkGgcVkNFTaXGA
         XLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834565; x=1708439365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2A5s0YU98xz4fK0cK8V3de3MUudesnEU1GM23Fa1guU=;
        b=heV6fnV7+6OU+rqTMiizU93El8me3L140HrKc5DgJjrKyB73rKM8KBX6pr4y3F7Fid
         v3oFIPW4Pfaai2VqEnCYV153FzvdD4/uGyEf1pp8ot5VRyas2qT5KjyXKbleu6/zAoo+
         pCLPdCBKZtNkliH9r0ZNV3Vjo2wfaYm2Cvve4sVpOrud0oqkmLP3OPe7K4XVuWtN1QhA
         OkU+0AgAyGCvB8oTy6nGyDns6/xlTQRQEXU3ys/ePl66ZFPJKWiY52L/TBNagy5bijYR
         PCwTMbsdCyJHcke4vWTxjhaNPvR945b9HkGUodcYhc67h1Qm3sB/US2ocmnLZU2UFad4
         1CVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlIsNKCTbjGFZVJRi3pGNuAYdYbHu/n0A3/qD6Fhp1IGlUrFliQIxp10a2qRIZWQIAsR0t136tKYJco6qW8FQJXecw1F04/WpzIKEx
X-Gm-Message-State: AOJu0YwR7gEEf9MIGcMiTdFurPS4TYYMeOzQsgWb/6+Xw+Y5iwVmnc3N
	4o1JXOMg25LeirWAmSQCKDAkX5n9uyPjsuY9yBnIB+tcmcrKw045168BLdydcRUrK9UoWaokuNQ
	eKRRkVonf25mYNb6uFw==
X-Google-Smtp-Source: AGHT+IEFfDoRwQ206s3vRpeCnYcR/ybaOaF2/O1U/21MDlmy9oENsuSN3eESDaGFpf658j2sMYStzQ152cIojUz6
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a25:69c4:0:b0:dcc:53c6:1133 with SMTP
 id e187-20020a2569c4000000b00dcc53c61133mr76167ybc.13.1707834565189; Tue, 13
 Feb 2024 06:29:25 -0800 (PST)
Date: Tue, 13 Feb 2024 14:29:19 +0000
In-Reply-To: <20240213142632.2415127-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213142632.2415127-1-ericchancf@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213142919.2416728-1-ericchancf@google.com>
Subject: [PATCH v3 2/4] riscv/barrier: Define RISCV_FULL_BARRIER
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

Introduce RISCV_FULL_BARRIER and use in arch_atomic* function.
like RISCV_ACQUIRE_BARRIER and RISCV_RELEASE_BARRIER, the fence
instruction can be eliminated When SMP is not enabled.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 arch/riscv/include/asm/atomic.h  | 16 ++++++++--------
 arch/riscv/include/asm/cmpxchg.h |  4 ++--
 arch/riscv/include/asm/fence.h   |  2 ++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index f5dfef6c2153..31e6e2e7cc18 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -207,7 +207,7 @@ static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int
 		"	add      %[rc], %[p], %[a]\n"
 		"	sc.w.rl  %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		: [a]"r" (a), [u]"r" (u)
@@ -228,7 +228,7 @@ static __always_inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a,
 		"	add      %[rc], %[p], %[a]\n"
 		"	sc.d.rl  %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		: [a]"r" (a), [u]"r" (u)
@@ -248,7 +248,7 @@ static __always_inline bool arch_atomic_inc_unless_negative(atomic_t *v)
 		"	addi      %[rc], %[p], 1\n"
 		"	sc.w.rl   %[rc], %[rc], %[c]\n"
 		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -268,7 +268,7 @@ static __always_inline bool arch_atomic_dec_unless_positive(atomic_t *v)
 		"	addi      %[rc], %[p], -1\n"
 		"	sc.w.rl   %[rc], %[rc], %[c]\n"
 		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -288,7 +288,7 @@ static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
 		"	bltz     %[rc], 1f\n"
 		"	sc.w.rl  %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -310,7 +310,7 @@ static __always_inline bool arch_atomic64_inc_unless_negative(atomic64_t *v)
 		"	addi      %[rc], %[p], 1\n"
 		"	sc.d.rl   %[rc], %[rc], %[c]\n"
 		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -331,7 +331,7 @@ static __always_inline bool arch_atomic64_dec_unless_positive(atomic64_t *v)
 		"	addi      %[rc], %[p], -1\n"
 		"	sc.d.rl   %[rc], %[rc], %[c]\n"
 		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -352,7 +352,7 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 		"	bltz     %[rc], 1f\n"
 		"	sc.d.rl  %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 2f4726d3cfcc..a608e4d1a0a4 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -313,7 +313,7 @@
 			"	bne  %0, %z3, 1f\n"			\
 			"	sc.w.rl %1, %z4, %2\n"			\
 			"	bnez %1, 0b\n"				\
-			"	fence rw, rw\n"				\
+			RISCV_FULL_BARRIER				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
 			: "rJ" ((long)__old), "rJ" (__new)		\
@@ -325,7 +325,7 @@
 			"	bne %0, %z3, 1f\n"			\
 			"	sc.d.rl %1, %z4, %2\n"			\
 			"	bnez %1, 0b\n"				\
-			"	fence rw, rw\n"				\
+			RISCV_FULL_BARRIER				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
 			: "rJ" (__old), "rJ" (__new)			\
diff --git a/arch/riscv/include/asm/fence.h b/arch/riscv/include/asm/fence.h
index 2b443a3a487f..6c26c44dfcd6 100644
--- a/arch/riscv/include/asm/fence.h
+++ b/arch/riscv/include/asm/fence.h
@@ -4,9 +4,11 @@
 #ifdef CONFIG_SMP
 #define RISCV_ACQUIRE_BARRIER		"\tfence r , rw\n"
 #define RISCV_RELEASE_BARRIER		"\tfence rw,  w\n"
+#define RISCV_FULL_BARRIER		"\tfence rw, rw\n"
 #else
 #define RISCV_ACQUIRE_BARRIER
 #define RISCV_RELEASE_BARRIER
+#define RISCV_FULL_BARRIER
 #endif
 
 #endif	/* _ASM_RISCV_FENCE_H */
-- 
2.43.0.687.g38aa6559b0-goog


