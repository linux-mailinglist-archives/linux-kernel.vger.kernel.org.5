Return-Path: <linux-kernel+bounces-69865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBFF858F9B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D061F22CE3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8378A7A735;
	Sat, 17 Feb 2024 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hNuZ9CnT"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A47A727
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708175590; cv=none; b=YvQbK70QMhfER1f0cWQzTPbRTjL2FX1bdVrvUvXTkqwJrcaQ1VgM8DH+y9npZDT4Ue1YWq/cxs8xaJSud30ebtGckQCO6BhWlYWa7bWAuTwguGypVUvXbf/cMhZ2jDbnn9FP6E9pyXlC7pff90wOzq9c4Y3SfsdEmnNr9HZEHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708175590; c=relaxed/simple;
	bh=gXccFXA6GdmXxlKc4MwbQOawfe/mB+kTiwU1KyUkszo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m/WF5k1eZNZHYr6TOQAGEd3C3kurgEf3tDapMCmkMJ8/l4+Ut+2aIeC1VbAfPsZj6XGuKFUt450zlkYotj7LkfNCsnncubzz/j6USO0lWBAGhXwjz7Jsa/Kw8NKdoZrb5h+hJpzXb7BiahWZwV1580yKnmp+af2KO2PlFwcWs4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hNuZ9CnT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047a047f4cso71172547b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708175588; x=1708780388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R2+WpDCt8HOz+kxBkD8ukIa/A2HuTgCzwuZw4fcBj8Q=;
        b=hNuZ9CnT2VYjlxm8CxpmRu2Ji7llMTZtx6rR8UZOkSomdGW1Q40XxbVsQV2/b3tX2L
         A3zvh/S8Tp2o2xg41Io9J7aOPBZU3EgU4Wzsp4/9fzbmhHt4deySlGiCEIndETsZi3h1
         3pPl5p0o5Vuk/2JMqGYjD4XhzgBmf6YkYtthzYibduK0XofmOfZYJrlp8WLRgOZR6LnD
         U17ck5xjktOH3Zyga4CA2I56WOZ8Te0UaEaVAVg3rmTNDgfw1MmyEEC783tcnGJuXWB4
         DQuxekl8oq1z1zr+hjLUBBPpofPc2XBRoLCFKIFHcPKe4S656qYMnZIQF0U8ELfeJLXG
         WbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708175588; x=1708780388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2+WpDCt8HOz+kxBkD8ukIa/A2HuTgCzwuZw4fcBj8Q=;
        b=LMEdxf62doXHXcFfsYhFp1x6wAeeIsxMrVLrJtCW8BvFZ6Qy9xqy/9N1ugFaFTJqik
         7YjZCPSEKjnuq4OGmqbn1XE9ccZlCUxvC2btBfZkMh6P5fOIEQTKRNaYyrHR1OH1eq1z
         ZVtV70ShgFW4E5odzWbarHUl/dUb0oEZ0Kl4irC+NHQWfFk2wp4wdBYJ7sTEzBar5VVk
         7cL7ZvLkvKs+h8zUPNW/CqM9bCXKD3TCNJF/mt+AHQ6SDuXgLqBOadw6h2Qbg/T/Uwk7
         vyjLT7z6NF3CTW/WL1Q2dUIP/nlMknLusSsyXRxlmoL0VXYf1eVjwMV4ei2OVfhcTGBX
         pxnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSkTJS06HMbkcBKgqldTyYU5YMTTimk0cSsJyMgPpHd1ifBjCmAzdmdjn8JiVQNeKfXIbGPaCXXcOmEn8hWdlyES7ruVSdWw2nzXFU
X-Gm-Message-State: AOJu0YzgXzG0Qua56zs0SFKeGdU8r7wFJUyb11ztIuIiZIXOqz3av7Eo
	xvJ21OLYYlQoyYrOZeMJXfAgrYg1CFsWOJX2ve7dnuBZGNfNRKljWAei4sS9oSR55/y7hZNds4w
	R9lyI8i/f0yubHUkVyw==
X-Google-Smtp-Source: AGHT+IEAJ/4G6wD0KVnJGN5oQcDtNoKQ10qhlVZxpPvg7p+h7qHeL1Q6wHY/niRI5dbBnn7ePSTvHDt/7ZPsroqL
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:1029:b0:dc9:5ef8:2b2d with
 SMTP id x9-20020a056902102900b00dc95ef82b2dmr1930551ybt.4.1708175588280; Sat,
 17 Feb 2024 05:13:08 -0800 (PST)
Date: Sat, 17 Feb 2024 13:13:02 +0000
In-Reply-To: <20240217131206.3667544-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240217131206.3667544-1-ericchancf@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240217131302.3668481-1-ericchancf@google.com>
Subject: [PATCH v6 2/4] riscv/barrier: Define RISCV_FULL_BARRIER
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com, conor.dooley@microchip.com, parri.andrea@gmail.com, 
	emil.renner.berthing@canonical.com, samuel.holland@sifive.com
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
2.44.0.rc0.258.g7320e95886-goog


