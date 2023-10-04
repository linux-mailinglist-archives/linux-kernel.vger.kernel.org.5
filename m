Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB017B82B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbjJDOwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242996AbjJDOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:52:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9670DC6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:51:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso402147466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696431114; x=1697035914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rS7jRVcQ6NtK3qXxw1G/jurrddIxGHuAxg9jtCM/lIk=;
        b=hEvEaQ/TjwxTkVH8XajpzZMZcV5LJZ/bYasUSJHG+bT6LK6Pt8zKIBBjGfmTwKBSqq
         7idqEM3Y6rkH4s2AxzTLtMIiOUMaSaGd71askTHDUL0FNR2sioc8WP2f0jXoNF2Y0Uy2
         XDN+aoPKj6/3eGb2ukDnLUEGzc5LLl49uCbcH+b0GZyv10uaE5Guc7syajVQS3rXnRXh
         cLrNH5t2oPvE5eSfh7U2eptJAo5e2OmRrHLiajnVdM8Z3Rl/Sa8jeTtjzBnCJW75tbhY
         l+ZpILOrZKTw7s3yX6/Wt9K2ADjhcMtkGkR0Jp/Ny4F8t8yxVTNPRwtF4cLQZIGMuJgP
         taIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696431114; x=1697035914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rS7jRVcQ6NtK3qXxw1G/jurrddIxGHuAxg9jtCM/lIk=;
        b=sdKis0gCQTD9VVJU5sLOM0E5vmt2hDrQ7sCrPtYOvnk5yr6UjWOIs9i/yRWfbbW5ir
         qtLdjupBaA9R6a0ogAIu+Sil0uwMRUJ6Emamj93hF6ZbCtF1LHNMI0bHapXQtSMMYQBp
         Q0Qa4fVWDZ0+jxV8yt5dhSJHPGPzFx6tRBKiFn2QLWRjQSLh4aNSL650LbBZ+wsq6KpF
         pp792ZEsZ7OaFYje1/bjVVuifmb1STCADjqQZ1MBOmfJYjPa2bZxHl0urwHFfL+Jga2k
         VchS9Z61EaUi9/5i3UNCgLcbTx3cUElamhATu5pm/epZwEEwTvQ4tQKD66K6pjMjhW5X
         36YQ==
X-Gm-Message-State: AOJu0YzjELVRvaTOrXR27+LCZUpIDoL8PB6DsK0ed7nEDz2C/NLXeEIa
        mfAKMsLs5dfMMv6PaTmo2nY=
X-Google-Smtp-Source: AGHT+IE3parCnIxf0SHOxHOiyORZpdUFJSWEXx9I29gog/A9cdz/kPesZTNRnVQoQckOAAg+qQ4CjA==
X-Received: by 2002:a17:906:30cd:b0:9ad:e20f:142f with SMTP id b13-20020a17090630cd00b009ade20f142fmr2206389ejb.22.1696431113785;
        Wed, 04 Oct 2023 07:51:53 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id j26-20020a1709064b5a00b009a16975ee5asm2906307ejv.169.2023.10.04.07.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:51:53 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 3/4] x86/percpu: Use compiler segment prefix qualifier
Date:   Wed,  4 Oct 2023 16:49:43 +0200
Message-ID: <20231004145137.86537-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004145137.86537-1-ubizjak@gmail.com>
References: <20231004145137.86537-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Using a segment prefix qualifier is cleaner than using a segment prefix
in the inline assembly, and provides the compiler with more information,
telling it that __seg_gs:[addr] is different than [addr] when it
analyzes data dependencies. It also enables various optimizations that
will be implemented in the next patches.

Use segment prefix qualifiers when they are supported. Unfortunately,
gcc does not provide a way to remove segment qualifiers, which is needed
to use typeof() to create local instances of the per-cpu variable. For
this reason, do not use the segment qualifier for per-cpu variables, and
do casting using the segment qualifier instead.

Uros: Improve compiler support detection and update the patch
to the current mainline.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/percpu.h  | 68 +++++++++++++++++++++++-----------
 arch/x86/include/asm/preempt.h |  2 +-
 2 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 20624b80f890..da451202a1b9 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -28,26 +28,50 @@
 #include <linux/stringify.h>
 
 #ifdef CONFIG_SMP
+
+#ifdef CONFIG_CC_HAS_NAMED_AS
+
+#ifdef CONFIG_X86_64
+#define __percpu_seg_override	__seg_gs
+#else
+#define __percpu_seg_override	__seg_fs
+#endif
+
+#define __percpu_prefix		""
+
+#else /* CONFIG_CC_HAS_NAMED_AS */
+
+#define __percpu_seg_override
 #define __percpu_prefix		"%%"__stringify(__percpu_seg)":"
+
+#endif /* CONFIG_CC_HAS_NAMED_AS */
+
+#define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
 /*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
  */
-#define arch_raw_cpu_ptr(ptr)				\
-({							\
-	unsigned long tcp_ptr__;			\
-	asm ("add " __percpu_arg(1) ", %0"		\
-	     : "=r" (tcp_ptr__)				\
-	     : "m" (this_cpu_off), "0" (ptr));		\
-	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;	\
+#define arch_raw_cpu_ptr(ptr)					\
+({								\
+	unsigned long tcp_ptr__;				\
+	asm ("add " __percpu_arg(1) ", %0"			\
+	     : "=r" (tcp_ptr__)					\
+	     : "m" (__my_cpu_var(this_cpu_off)), "0" (ptr));	\
+	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
 })
-#else
+#else /* CONFIG_SMP */
+#define __percpu_seg_override
 #define __percpu_prefix		""
-#endif
+#define __force_percpu_prefix	""
+#endif /* CONFIG_SMP */
 
+#define __my_cpu_type(var)	typeof(var) __percpu_seg_override
+#define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr) *)(uintptr_t)(ptr)
+#define __my_cpu_var(var)	(*__my_cpu_ptr(&var))
 #define __percpu_arg(x)		__percpu_prefix "%" #x
+#define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 
 /*
  * Initialized pointers to per-cpu variables needed for the boot
@@ -107,14 +131,14 @@ do {									\
 		(void)pto_tmp__;					\
 	}								\
 	asm qual(__pcpu_op2_##size(op, "%[val]", __percpu_arg([var]))	\
-	    : [var] "+m" (_var)						\
+	    : [var] "+m" (__my_cpu_var(_var))				\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
 
 #define percpu_unary_op(size, qual, op, _var)				\
 ({									\
 	asm qual (__pcpu_op1_##size(op, __percpu_arg([var]))		\
-	    : [var] "+m" (_var));					\
+	    : [var] "+m" (__my_cpu_var(_var)));				\
 })
 
 /*
@@ -144,14 +168,14 @@ do {									\
 	__pcpu_type_##size pfo_val__;					\
 	asm qual (__pcpu_op2_##size(op, __percpu_arg([var]), "%[val]")	\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
-	    : [var] "m" (_var));					\
+	    : [var] "m" (__my_cpu_var(_var)));				\
 	(typeof(_var))(unsigned long) pfo_val__;			\
 })
 
 #define percpu_stable_op(size, op, _var)				\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
-	asm(__pcpu_op2_##size(op, __percpu_arg(P[var]), "%[val]")	\
+	asm(__pcpu_op2_##size(op, __force_percpu_arg(P[var]), "%[val]")	\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "p" (&(_var)));					\
 	(typeof(_var))(unsigned long) pfo_val__;			\
@@ -166,7 +190,7 @@ do {									\
 	asm qual (__pcpu_op2_##size("xadd", "%[tmp]",			\
 				     __percpu_arg([var]))		\
 		  : [tmp] __pcpu_reg_##size("+", paro_tmp__),		\
-		    [var] "+m" (_var)					\
+		    [var] "+m" (__my_cpu_var(_var))			\
 		  : : "memory");					\
 	(typeof(_var))(unsigned long) (paro_tmp__ + _val);		\
 })
@@ -187,7 +211,7 @@ do {									\
 				    __percpu_arg([var]))		\
 		  "\n\tjnz 1b"						\
 		  : [oval] "=&a" (pxo_old__),				\
-		    [var] "+m" (_var)					\
+		    [var] "+m" (__my_cpu_var(_var))			\
 		  : [nval] __pcpu_reg_##size(, pxo_new__)		\
 		  : "memory");						\
 	(typeof(_var))(unsigned long) pxo_old__;			\
@@ -204,7 +228,7 @@ do {									\
 	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
 				    __percpu_arg([var]))		\
 		  : [oval] "+a" (pco_old__),				\
-		    [var] "+m" (_var)					\
+		    [var] "+m" (__my_cpu_var(_var))			\
 		  : [nval] __pcpu_reg_##size(, pco_new__)		\
 		  : "memory");						\
 	(typeof(_var))(unsigned long) pco_old__;			\
@@ -221,7 +245,7 @@ do {									\
 		  CC_SET(z)						\
 		  : CC_OUT(z) (success),				\
 		    [oval] "+a" (pco_old__),				\
-		    [var] "+m" (_var)					\
+		    [var] "+m" (__my_cpu_var(_var))			\
 		  : [nval] __pcpu_reg_##size(, pco_new__)		\
 		  : "memory");						\
 	if (unlikely(!success))						\
@@ -244,7 +268,7 @@ do {									\
 									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		  : [var] "+m" (_var),					\
+		  : [var] "+m" (__my_cpu_var(_var)),			\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
@@ -276,7 +300,7 @@ do {									\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
 		  CC_SET(z)						\
 		  : CC_OUT(z) (success),				\
-		    [var] "+m" (_var),					\
+		    [var] "+m" (__my_cpu_var(_var)),			\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
@@ -313,7 +337,7 @@ do {									\
 									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		  : [var] "+m" (_var),					\
+		  : [var] "+m" (__my_cpu_var(_var)),			\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
@@ -345,7 +369,7 @@ do {									\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
 		  CC_SET(z)						\
 		  : CC_OUT(z) (success),				\
-		    [var] "+m" (_var),					\
+		    [var] "+m" (__my_cpu_var(_var)),			\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
@@ -494,7 +518,7 @@ static inline bool x86_this_cpu_variable_test_bit(int nr,
 	asm volatile("btl "__percpu_arg(2)",%1"
 			CC_SET(c)
 			: CC_OUT(c) (oldbit)
-			: "m" (*(unsigned long __percpu *)addr), "Ir" (nr));
+			: "m" (*__my_cpu_ptr((unsigned long __percpu *)(addr))), "Ir" (nr));
 
 	return oldbit;
 }
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 2d13f25b1bd8..e25b95e7cf82 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -92,7 +92,7 @@ static __always_inline void __preempt_count_sub(int val)
  */
 static __always_inline bool __preempt_count_dec_and_test(void)
 {
-	return GEN_UNARY_RMWcc("decl", pcpu_hot.preempt_count, e,
+	return GEN_UNARY_RMWcc("decl", __my_cpu_var(pcpu_hot.preempt_count), e,
 			       __percpu_arg([var]));
 }
 
-- 
2.41.0

