Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80BD7CFC57
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345973AbjJSOV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345918AbjJSOVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:21:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B597134
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:21:52 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so79910225e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697725311; x=1698330111; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X7vXBtFp8YlW9tjprqOhSv3R1fGBRdJcwl00hTgXhRg=;
        b=GifIUbW9qKhu56g+5v7sbwTfS57tF3f0TB4GnGPDa9tCeOt8yY2ezlVn4eFxjN31I0
         o+hfFXeYPhTAbOgzHeQipBPz1odHbH6otPEdinlrZOCF0GnokLPwnaLXVFrDD4Bwfym/
         ki6/xQDH2QhnpG3gH7aMlROTnCZ4xuXKEEHRZ1zinBUtw7M3Gdxf2f5dF/pk8S0WYPTM
         nG+KJa8XPAHbO2zmUaSP4tqqNPIUW1QwsLOCD9QLK9zW9L0EpBLRhLALncEKBrTw6gm3
         2MDUVBibdH4SZXUZObkVxsKhW44hRsn5VjzRzplatq1LmsLuH5xSisc/TKaoGoUc1ER2
         qd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697725311; x=1698330111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7vXBtFp8YlW9tjprqOhSv3R1fGBRdJcwl00hTgXhRg=;
        b=XNA3EPmtXnf4TKagQNAKv2gfg4GWhu5zvgiYWKctOFRADmKY5OYaQU5uZ4Qh/1JhRx
         dKiiphfd8Ve4jgRWhp8Dg5Ke+Y85qdOr6kIfixGQmYaEo3P8tcm10URZHXG7LS3sdqf2
         TscL54os57ayJnNwmLz5XJjV/qT+eokXfPIPlsI8WNCH4DmGOdGkst/rJX4c0WCojNXp
         AeLLZR22otAhEH1wG1z5SdPsmJeMG098YStjyA1RTfi8/vTl4FMlExYIQUctylIYYg7I
         /nJA+fnHKzpvq3rVJOlSk1L76bn3DbALC28ZfZjiDSMF2Bm4vQN3Q8xGjOFZkI2ng7Hu
         4EpA==
X-Gm-Message-State: AOJu0Yy7fwcuondDbiv5r269zK48JPpIX6/1HE+IvKnqtQ0iRfRQ6GF9
        kkBxxO/xhgiWA0SUe0QDjF4Vg7Drsbk=
X-Google-Smtp-Source: AGHT+IHJqdSqmsH4yoOH0ZRIaqUFsO89CuN/CmqmV5aQR1+q4EsQXjUOLgsJ3mv0zA5gB9n4+UM+/A==
X-Received: by 2002:a05:600c:3788:b0:402:98cd:a3e9 with SMTP id o8-20020a05600c378800b0040298cda3e9mr1891267wmr.32.1697725310504;
        Thu, 19 Oct 2023 07:21:50 -0700 (PDT)
Received: from andrea ([151.76.7.139])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c1d1600b004042dbb8925sm4640509wms.38.2023.10.19.07.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:21:50 -0700 (PDT)
Date:   Thu, 19 Oct 2023 16:21:45 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        christoph.muellner@vrull.eu, David.Laight@aculab.com,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v3 0/2] Add Zawrs support and use it for spinlocks
Message-ID: <ZTE7eUyrb8+J+ORB@andrea>
References: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 01:47:13PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> Zawrs [0] was ratified in november 2022 [1], so I've resurrect the patch
> adding Zawrs support for spinlocks and adapted it to recent kernel
> changes.
> 
> Also incorporated are the nice comments David Laight provided on v2.
> 
> 
> Changes since v2:
> - Rebase on top of 6.4-rc1
> - Adapt to changed alternatives Kconfig handling
> - Adapt to changed cpufeature extension handling
> - Address review comments from David Laight
>   - better handling for 32/64bit cases (less ifdefery)
>   - less macros calling macros
>   - don't duplicate __smp_load_reserved_relaxed in
>     __smp_load_reserved_aquire
> 
> Changes since v1:
> - Fixing type checking code for 32/64-bit values
> - Adjustments according to the specification change
> - Adding "depends on !XIP_KERNEL" to RISCV_ISA_ZAWRS
> 
> 
> [0] https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
> [1] https://github.com/riscv/riscv-zawrs/commit/9ff54f7e7fcd95cf1b111d2e54276ff1183bcd37
> 
> Christoph Müllner (1):
>   riscv: Add Zawrs support for spinlocks
> 
> Heiko Stuebner (1):
>   riscv: don't include kernel.h into alternative.h
> 
>  arch/riscv/Kconfig                   | 10 +++++
>  arch/riscv/include/asm/alternative.h |  1 -
>  arch/riscv/include/asm/barrier.h     | 64 ++++++++++++++++++++++++++++
>  arch/riscv/include/asm/errata_list.h | 14 ++++++
>  arch/riscv/include/asm/hwcap.h       |  1 +
>  arch/riscv/kernel/cpu.c              |  1 +
>  arch/riscv/kernel/cpufeature.c       |  1 +
>  7 files changed, 91 insertions(+), 1 deletion(-)


Hi Heiko and Christoph,

I was wondering about the plan for this series: am I missing some update to
this discussion? do we have a new version to review?

I actually went ahead (as Palmer suggested in private  :-) ) and spent some
time trying to integrate feedback provided in this thread into your changes,
obtaining the diff below (on 6.6-rc6, the #include removal fixes some nommu
builds and should/can be splitted into a separate patch); thoughts?

  Andrea


From 79d25361ddd4a14db6ce94aec140efbdf2d89684 Mon Sep 17 00:00:00 2001
From: Andrea Parri <parri.andrea@gmail.com>
Date: Wed, 18 Oct 2023 02:22:28 +0200
Subject: [PATCH] riscv: Implement LR+WRS-based smp_cond_load_{relaxed,acquire}()

The Zawrs extension defines instructions allowing a core to enter
a low-power state and wait on a store to a memory location.

Introduce the Zawrs-instruction WRS.STO and use it in the polling
loops of the macros smp_cond_load_{relaxed,acquire}().

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
[based on the arm64 implementation and work from Heiko and Christoph]
---
 arch/riscv/Kconfig                | 14 +++++++++
 arch/riscv/include/asm/barrier.h  | 26 ++++++++++++++++
 arch/riscv/include/asm/cmpxchg.h  | 51 +++++++++++++++++++++++++++++++
 arch/riscv/include/asm/hwcap.h    |  3 +-
 arch/riscv/include/asm/insn-def.h |  2 ++
 arch/riscv/kernel/cpufeature.c    |  1 +
 6 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6da..ff49f90d175ba 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -489,6 +489,20 @@ config RISCV_ISA_SVPBMT
 
 	   If you don't know what to do here, say Y.
 
+config RISCV_ISA_ZAWRS
+	bool "Zawrs extension support for wait-on-reservation-set instructions"
+	depends on RISCV_ALTERNATIVE
+	default y
+	help
+	   Adds support to dynamically detect the presence of the Zawrs
+	   extension and enable its usage.
+
+	   The Zawrs extension defines a pair of instructions to be used
+	   in polling loops that allows a core to enter a low-power state
+	   and wait on a store to a memory location.
+
+	   If you don't know what to do here, say Y.
+
 config TOOLCHAIN_HAS_V
 	bool
 	default y
diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index 110752594228e..7ab7a28e72210 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -71,6 +71,32 @@ do {									\
  */
 #define smp_mb__after_spinlock()	RISCV_FENCE(iorw,iorw)
 
+#define smp_cond_load_relaxed(ptr, cond_expr)				\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		__cmpwait_relaxed(__PTR, VAL);				\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+
+#define smp_cond_load_acquire(ptr, cond_expr)				\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	for (;;) {							\
+		VAL = smp_load_acquire(__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		__cmpwait_relaxed(__PTR, VAL);				\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+
 #include <asm-generic/barrier.h>
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 2f4726d3cfcc2..65bc21379f40e 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -8,8 +8,11 @@
 
 #include <linux/bug.h>
 
+#include <asm/alternative-macros.h>
 #include <asm/barrier.h>
 #include <asm/fence.h>
+#include <asm/hwcap.h>
+#include <asm/insn-def.h>
 
 #define __xchg_relaxed(ptr, new, size)					\
 ({									\
@@ -360,4 +363,52 @@
 	arch_cmpxchg_relaxed((ptr), (o), (n));				\
 })
 
+#define __CMPWAIT_CASE(w, sz)						\
+static inline void __cmpwait_case_##sz(volatile void *ptr,		\
+				       unsigned long val)		\
+{									\
+	unsigned long tmp;						\
+									\
+	asm volatile(ALTERNATIVE(					\
+		__nops(4),						\
+		"lr." #w "\t" "%[tmp], %[v]\n\t"			\
+		"xor	%[tmp], %[tmp], %[val]\n\t"			\
+		"bnez	%[tmp], 1f\n\t"					\
+		WRS_sto "\n\t"						\
+		"1:\n",							\
+		0, RISCV_ISA_EXT_ZAWRS, CONFIG_RISCV_ISA_ZAWRS)		\
+	: [tmp] "=&r" (tmp), [v] "+A" (*(u##sz *)ptr)			\
+	: [val] "rJ" (val)						\
+	: "memory");							\
+}
+
+__CMPWAIT_CASE(w, 32);
+__CMPWAIT_CASE(d, 64);
+
+#undef __CMPWAIT_CASE
+
+#define __CMPWAIT_GEN()							\
+static __always_inline void __cmpwait(volatile void *ptr,		\
+				      unsigned long val,		\
+				      int size)				\
+{									\
+	switch (size) {							\
+	case 4:								\
+		return __cmpwait_case_32(ptr, val);			\
+	case 8:								\
+		return __cmpwait_case_64(ptr, val);			\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+									\
+	unreachable();							\
+}
+
+__CMPWAIT_GEN()
+
+#undef __CMPWAIT_GEN
+
+#define __cmpwait_relaxed(ptr, val)					\
+	__cmpwait((ptr), (unsigned long)(val), sizeof(*(ptr)))
+
 #endif /* _ASM_RISCV_CMPXCHG_H */
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b7b58258f6c7c..afabcbf849526 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -58,6 +58,7 @@
 #define RISCV_ISA_EXT_ZICSR		40
 #define RISCV_ISA_EXT_ZIFENCEI		41
 #define RISCV_ISA_EXT_ZIHPM		42
+#define RISCV_ISA_EXT_ZAWRS		43
 
 #define RISCV_ISA_EXT_MAX		64
 
@@ -69,8 +70,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/jump_label.h>
-
 unsigned long riscv_get_elf_hwcap(void);
 
 struct riscv_isa_ext_data {
diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
index 6960beb75f329..fecb744ed7b29 100644
--- a/arch/riscv/include/asm/insn-def.h
+++ b/arch/riscv/include/asm/insn-def.h
@@ -196,4 +196,6 @@
 	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
 	       RS1(base), SIMM12(4))
 
+#define WRS_sto	".long 0x01d00073"
+
 #endif /* __ASM_INSN_DEF_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1cfbba65d11ae..044682f54f78f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -181,6 +181,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
+	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
-- 
2.34.1

