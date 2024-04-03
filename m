Return-Path: <linux-kernel+bounces-129994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4128C8972FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85DF2B26082
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA4B13AA52;
	Wed,  3 Apr 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEuQL9EP"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D2743AB4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155622; cv=none; b=oqrxHlSXAtzq6fDjsDkAxOv8DQ8XvFYZJ4fm2ud9U26JgBJ+bgGObegL9UBZBq4meSSe6rcTtBIn+CK3yXiULSN/jVRzXz8WA72XXf1h4IpPhNKZ3eUhJ2Jw3sfE1ZvWBOc9YosboKtDEMLJJMNnRD/xGhQKr2aDcT0uFStm5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155622; c=relaxed/simple;
	bh=aWsX9PLCJQcRWQTUw746DTX9myLhmGpDl4TUW3NvmZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMYeSzqmp2SxUfT5MmAA+tgoJKpSQqLW42QKnwHLL8sHCW151xY7G6c4rAlkhgpW3HBF5dmUFdeKTRt7+VM16eXtG5xnIh2wlR4+FIallTiTsGKqqdxXWguMJ8/Kvp+/xsTaWbTwYKROb7aXEpeFckOxCl5r+pmGnKcU6dXageE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEuQL9EP; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d718efedb2so100315231fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712155618; x=1712760418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2shzLAbSo43FqL35QxvmdDciFXwdRjwcIm9g71py6PQ=;
        b=aEuQL9EP69CfZWYUVqS91MUY3JwNJv+M0hESknY5ln4cERdKOrobDVXek8K1GYjCd4
         mme2+oM/g5/ab/qLb4sHWuYIlI8Eq62odJrQO+bNg9M3Wa0VgAl/B6M5TkvfrFapivVV
         9aiW/vb1XyZvc8xyeJeEGEgwFC7K7Qw1wAda1utg13QFbquch5pJibLxOjsFhWs7H9kW
         J3Lpgl4t0FXBfO5pebY++VEOgddfP0xqnakRybJUCmMr4Lthk398tRLNbT1gYL7zR0xi
         RlPA753Pi+LqTZkkJHy1MVI+A/jYhtVQhTdh5bHFHBDgZtuBAdMYj321Jt0vM7JsSsVf
         9YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712155618; x=1712760418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2shzLAbSo43FqL35QxvmdDciFXwdRjwcIm9g71py6PQ=;
        b=QBECXulfLT97kmGF7wLFyrfn71j8H/Qjtddp9uiMdWyU1yFfGbBLN3dsnUZCZYm55Y
         j/kyNM1K3tlQQOpqyaEO/zLBoH7E2HIUXFrjKa9ozR9pJSdsBYfTwjyh11oyIuNMW2Be
         u+W22AkKmA6gQxDqI20Fti79QfZt+rYXWM4EBFxHQxzFC9EkdBQoKIRKhohn4iUA28Eq
         9gR6qwVjQiE24jZlC+RYHqabc1mMsNbMZukEx4lwL3OsRupIMqPsCMwU+Q87ujxqqE/I
         /jeNcr9vOekRLlKfo8YikwHOI672CNWScZVlwIGe2AhkSF6I4KQN4IpNqq3sOqh3SR8i
         FJPA==
X-Forwarded-Encrypted: i=1; AJvYcCW+/YEzWXeVQGV3GNk91OQaP0HD/VZswz/wxDUEygCPeCg7k61duWhakLciSJZ5mzUYJ7NNErUSMX19JMq8KIthpweIMXfI6QGRhqXe
X-Gm-Message-State: AOJu0YxvtW6iGcjfsKnePXN7XJ4gVgI5QLZDV5G5cOdBahP850ugTsz+
	+rP/K4yqXn06B1bm45PVSSDRotUnYzK1bV6T1ZdQjYTGziDDnDWo
X-Google-Smtp-Source: AGHT+IHmRQtbCAdANLjT+tO8PiEkkqUC732ouxnFmVXMVBEGOwA6248wUy70SON0Rj4FeAY+q4qlMQ==
X-Received: by 2002:a05:6512:3591:b0:515:d472:955d with SMTP id m17-20020a056512359100b00515d472955dmr4194231lfr.25.1712155617704;
        Wed, 03 Apr 2024 07:46:57 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090660c400b00a457a55b814sm7805407ejk.73.2024.04.03.07.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:46:56 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/percpu: Fix and improve x86_this_cpu_test_bit() and friends
Date: Wed,  3 Apr 2024 16:46:32 +0200
Message-ID: <20240403144648.3885-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix x86_this_cpu_variable_test_bit(), which is implemented with
wrong asm template, where argument 2 (count argument) is considered
as percpu variable. However, x86_this_cpu_test_bit() is currently
used exclusively with constant bit number argument, so the called
x86_this_cpu_variable_test_bit() function is never instantiated.
The fix introduces named assembler operands to prevent this kind
of errors.

Also rewrite the whole family of x86_this_cpu_test_bit() functions
as macros, so standard __my_cpu_var() and raw_cpu_read() macros
can be used on percpu variables. This approach considerably
simplifies implementation of functions and also introduces standard
checks on accessed percpu variables.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/um/include/asm/cpufeature.h  |  3 +-
 arch/x86/include/asm/cpufeature.h |  3 +-
 arch/x86/include/asm/percpu.h     | 51 +++++++++++++------------------
 3 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/arch/um/include/asm/cpufeature.h b/arch/um/include/asm/cpufeature.h
index 66fe06db872f..1eb8b834fbec 100644
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
index f95e1c8b7c01..7d527467ab9c 100644
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
index 20696df5d567..d6ff0db32209 100644
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
@@ -568,36 +568,29 @@ do {									\
 #define this_cpu_read_stable_8(pcp)    ({ BUILD_BUG(); (typeof(pcp))0; })
 #endif
 
-static __always_inline bool x86_this_cpu_constant_test_bit(unsigned int nr,
-                        const unsigned long __percpu *addr)
-{
-	unsigned long __percpu *a =
-		(unsigned long __percpu *)addr + nr / BITS_PER_LONG;
-
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
-	asm volatile("btl "__percpu_arg(2)",%1"
-			CC_SET(c)
-			: CC_OUT(c) (oldbit)
-			: "m" (*__my_cpu_ptr((unsigned long __percpu *)(addr))), "Ir" (nr));
+#define x86_this_cpu_constant_test_bit(_nr, _var)			\
+({									\
+	unsigned long __percpu *addr__ =				\
+		(unsigned long __percpu *)&(_var) + ((_nr) / BITS_PER_LONG); \
+	!!((1UL << ((_nr) % BITS_PER_LONG)) & raw_cpu_read(*addr__));	\
+})
 
-	return oldbit;
-}
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
 
-#define x86_this_cpu_test_bit(nr, addr)			\
-	(__builtin_constant_p((nr))			\
-	 ? x86_this_cpu_constant_test_bit((nr), (addr))	\
-	 : x86_this_cpu_variable_test_bit((nr), (addr)))
+#define x86_this_cpu_test_bit(_nr, _var)			\
+	(__builtin_constant_p(_nr)				\
+	 ? x86_this_cpu_constant_test_bit(_nr, _var)		\
+	 : x86_this_cpu_variable_test_bit(_nr, _var))
 
 
 #include <asm-generic/percpu.h>
-- 
2.42.0


