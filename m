Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF8A7D81F8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbjJZLpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344840AbjJZLpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:45:11 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 475BF1B3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:45:06 -0700 (PDT)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8CxLOs_UTpl9M40AA--.32094S3;
        Thu, 26 Oct 2023 19:45:03 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx3t47UTpl7bMzAA--.4952S2;
        Thu, 26 Oct 2023 19:45:00 +0800 (CST)
From:   Huang Pei <huangpei@loongson.cn>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] selftests/rseq: Add 64bit LoongArch support
Date:   Thu, 26 Oct 2023 19:44:45 +0800
Message-Id: <20231026114446.5932-1-huangpei@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx3t47UTpl7bMzAA--.4952S2
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfWFy7Jr1DuFy8Kw47Kr43twc_yoW8tw4kuo
        W7CF4xK3WIgw1jvr1kCFy7tFWfJFW7GFW7AFWagr18CFyxKr1DGw1UAr42q39xZrWkGa45
        XFy5C3yfWF9Iywn3l-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
        9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
        UjIYCTnIWjp_UUUY17kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
        8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 tools/testing/selftests/rseq/param_test.c     |  20 +
 .../selftests/rseq/rseq-loongarch-bits.h      | 463 ++++++++++++++++++
 .../rseq/rseq-loongarch-thread-pointer.h      |  22 +
 tools/testing/selftests/rseq/rseq-loongarch.h | 140 ++++++
 .../selftests/rseq/rseq-thread-pointer.h      |   2 +
 tools/testing/selftests/rseq/rseq.h           |   2 +
 6 files changed, 649 insertions(+)
 create mode 100644 tools/testing/selftests/rseq/rseq-loongarch-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-loongarch-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-loongarch.h

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index bf951a490bb4..e930aa73c219 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -227,7 +227,27 @@ unsigned int yield_mod_cnt, nr_abort;
 	"bnez " INJECT_ASM_REG ", 222b\n\t"			\
 	"333:\n\t"
 
+#elif defined(__loongarch__)
+#define RSEQ_INJECT_INPUT \
+	, [loop_cnt_1]"m"(loop_cnt[1]) \
+	, [loop_cnt_2]"m"(loop_cnt[2]) \
+	, [loop_cnt_3]"m"(loop_cnt[3]) \
+	, [loop_cnt_4]"m"(loop_cnt[4]) \
+	, [loop_cnt_5]"m"(loop_cnt[5]) \
+	, [loop_cnt_6]"m"(loop_cnt[6])
+
+#define INJECT_ASM_REG  "$r12"
+
+#define RSEQ_INJECT_CLOBBER \
+	, INJECT_ASM_REG
 
+#define RSEQ_INJECT_ASM(n)                                      \
+	"ld.w " INJECT_ASM_REG ", %[loop_cnt_" #n "]\n\t"         \
+	"beqz " INJECT_ASM_REG ", 333f\n\t"                     \
+	"222:\n\t"                                              \
+	"addi.w  " INJECT_ASM_REG "," INJECT_ASM_REG ", -1\n\t"   \
+	"bnez " INJECT_ASM_REG ", 222b\n\t"                     \
+	"333:\n\t"
 #else
 #error unsupported target
 #endif
diff --git a/tools/testing/selftests/rseq/rseq-loongarch-bits.h b/tools/testing/selftests/rseq/rseq-loongarch-bits.h
new file mode 100644
index 000000000000..cf933c1a2100
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-loongarch-bits.h
@@ -0,0 +1,463 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Author: Huang Pei <huangpei@loongson.cn>
+ * (C) Copyright 2023 Loongson Technology Corporation Limited
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2018 MIPS Tech LLC
+ * (C) Copyright 2018 - Paul Burton <paul.burton@mips.com>
+ */
+#include "rseq-bits-template.h"
+
+#if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $r4, %[v]\n\t"
+		"bne $r4, %[expect], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $r4, %[v]\n\t"
+		"bne $r4, %[expect], %l[error2]\n\t"
+#endif
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "$r4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpnev_storeoffp_load)(intptr_t *v, intptr_t expectnot,
+			       long voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $r4, %[v]\n\t"
+		"beq $r4, %[expectnot], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $r4, %[v]\n\t"
+		"beq $r4, %[expectnot], %l[error2]\n\t"
+#endif
+		LONG_S " $r4, %[load]\n\t"
+		LONG_ADDI " $r4, $r4, %[voffp]\n\t"
+		LONG_L " $r4, $r4, 0\n\t"
+		/* final store */
+		LONG_S " $r4, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"Ir" (voffp),
+		  [load]		"m" (*load)
+		  RSEQ_INJECT_INPUT
+		: "$r4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_addv)(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		LONG_L " $r4, %[v]\n\t"
+		LONG_ADDI " $r4, $r4, %[count]\n\t"
+		/* final store */
+		LONG_S " $r4, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  [v]			"m" (*v),
+		  [count]		"Ir" (count)
+		  RSEQ_INJECT_INPUT
+		: "$r4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $r4, %[v]\n\t"
+		"bne $r4, %[expect], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		LONG_L " $r4, %[v2]\n\t"
+		"bne $r4, %[expect2], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $r4, %[v]\n\t"
+		"bne $r4, %[expect], %l[error2]\n\t"
+		LONG_L " $r4, %[v2]\n\t"
+		"bne $r4, %[expect2], %l[error3]\n\t"
+#endif
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "$r4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("1st expected value comparison failed");
+error3:
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+#endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+
+#if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $r4, %[v]\n\t"
+		"bne $r4, %[expect], %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		LONG_L " $r4, %[v]\n\t"
+		"bne $r4, %[expect], %l[error2]\n\t"
+#endif
+		/* try store */
+		LONG_S " %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		"dbar 0x12\n\t"	/* store-release */
+#endif
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "$r4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	uintptr_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
+		LONG_S " %[src], %[rseq_scratch0]\n\t"
+		LONG_S "  %[dst], %[rseq_scratch1]\n\t"
+		LONG_S " %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		LONG_L " $r4, %[v]\n\t"
+		"bne $r4, %[expect], 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		LONG_L " $r4, %[v]\n\t"
+		"bne $r4, %[expect], 7f\n\t"
+#endif
+		/* try memcpy */
+		"beqz %[len], 333f\n\t" \
+		"222:\n\t" \
+		"ld.b  $r4, %[src], 0\n\t" \
+		"st.b  $r4, %[dst], 0\n\t" \
+		LONG_ADDI " %[src], %[src], 1\n\t" \
+		LONG_ADDI " %[dst], %[dst], 1\n\t" \
+		LONG_ADDI " %[len], %[len], -1\n\t" \
+		"bnez %[len], 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_TEMPLATE_MO_RELEASE
+		"dbar 0x12\n\t"	/* store-release */
+#endif
+		/* final store */
+		LONG_S " %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		LONG_L " %[len], %[rseq_scratch2]\n\t"
+		LONG_L " %[dst], %[rseq_scratch1]\n\t"
+		LONG_L " %[src], %[rseq_scratch0]\n\t"
+		"b 8f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4,
+				      /* teardown */
+				      LONG_L " %[len], %[rseq_scratch2]\n\t"
+				      LONG_L " %[dst], %[rseq_scratch1]\n\t"
+				      LONG_L " %[src], %[rseq_scratch0]\n\t",
+				      abort, 1b, 2b, 4f)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+					/* teardown */
+					LONG_L " %[len], %[rseq_scratch2]\n\t"
+					LONG_L " %[dst], %[rseq_scratch1]\n\t"
+					LONG_L " %[src], %[rseq_scratch0]\n\t",
+					error2)
+#endif
+		"8:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		  RSEQ_INJECT_INPUT
+		: "$r4", "memory"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
+	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
+
+#include "rseq-bits-reset.h"
diff --git a/tools/testing/selftests/rseq/rseq-loongarch-thread-pointer.h b/tools/testing/selftests/rseq/rseq-loongarch-thread-pointer.h
new file mode 100644
index 000000000000..7dc990687982
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-loongarch-thread-pointer.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: MIT */
+/* SPDX-FileCopyrightText: 2023 Huang Pei <huangpei@loongson.cn> */
+
+#ifndef _RSEQ_LOONGARCH_THREAD_POINTER
+#define _RSEQ_LOONGARCH_THREAD_POINTER
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+static inline void *rseq_thread_pointer(void)
+{
+	register void *__result asm ("$2");
+	asm ("" : "=r" (__result));
+	return __result;
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/tools/testing/selftests/rseq/rseq-loongarch.h b/tools/testing/selftests/rseq/rseq-loongarch.h
new file mode 100644
index 000000000000..37aae463edde
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-loongarch.h
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Author: Huang Pei <huangpei@loongson.cn>
+ * (C) Copyright 2023 Loongson Technology Corporation Limited
+ * (C) Copyright 2016-2022 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2018 MIPS Tech LLC
+ * (C) Copyright 2018 - Paul Burton <paul.burton@mips.com>
+ */
+
+/*
+ * RSEQ_SIG use "break 0x10" instruction.
+ */
+
+# define RSEQ_SIG	0x002a0010
+
+
+
+#define rseq_smp_mb()	__asm__ __volatile__ ("dbar 0x10" ::: "memory")
+#define rseq_smp_rmb()	__asm__ __volatile__ ("dbar 0x15" ::: "memory")
+#define rseq_smp_wmb()	__asm__ __volatile__ ("dbar 0x1a" ::: "memory")
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	rseq_unqual_scalar_typeof(*(p)) ____p1 = RSEQ_READ_ONCE(*(p));	\
+	__asm__ __volatile__("dbar 0x14" :::  "memory");		\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	__asm__ __volatile__("dbar 0x12" :::  "memory");		\
+	RSEQ_WRITE_ONCE(*(p), v);					\
+} while (0)
+
+# define LONG			".dword"
+# define LONG_LA		"la.local"
+# define LONG_L			"ld.d"
+# define LONG_S			"st.d"
+# define LONG_ADDI		"addi.d"
+# define U32_U64_PAD(x)		x
+
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip, \
+				post_commit_offset, abort_ip) \
+		".pushsection __rseq_cs, \"aw\"\n\t" \
+		".balign 32\n\t" \
+		__rseq_str(label) ":\n\t"					\
+		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(start_ip)) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(post_commit_offset)) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(abort_ip)) "\n\t" \
+		".popsection\n\t" \
+		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(label) "b") "\n\t" \
+		".popsection\n\t"
+
+#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
+	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip, \
+				(post_commit_ip - start_ip), abort_ip)
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_cs section and should not be
+ * explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip) \
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(start_ip)) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(exit_ip)) "\n\t" \
+		".popsection\n\t"
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs) \
+		RSEQ_INJECT_ASM(1) \
+		LONG_LA " $r4, " __rseq_str(cs_label) "\n\t" \
+		LONG_S  " $r4, %[" __rseq_str(rseq_cs) "]\n\t" \
+		__rseq_str(label) ":\n\t"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label) \
+		RSEQ_INJECT_ASM(2) \
+		"ld.w  $r4, %[" __rseq_str(current_cpu_id) "]\n\t" \
+		"bne $r4, %[" __rseq_str(cpu_id) "], " __rseq_str(label) "\n\t"
+
+#define __RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown, \
+				abort_label, version, flags, \
+				start_ip, post_commit_offset, abort_ip) \
+		".balign 32\n\t" \
+		__rseq_str(table_label) ":\n\t" \
+		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(start_ip)) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(post_commit_offset)) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(abort_ip)) "\n\t" \
+		".word " __rseq_str(RSEQ_SIG) "\n\t" \
+		__rseq_str(label) ":\n\t" \
+		teardown \
+		"b %l[" __rseq_str(abort_label) "]\n\t"
+
+#define RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown, abort_label, \
+			      start_ip, post_commit_ip, abort_ip) \
+	__RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown, \
+				abort_label, 0x0, 0x0, start_ip, \
+				(post_commit_ip - start_ip), abort_ip)
+
+#define RSEQ_ASM_DEFINE_CMPFAIL(label, teardown, cmpfail_label) \
+		__rseq_str(label) ":\n\t" \
+		teardown \
+		"b %l[" __rseq_str(cmpfail_label) "]\n\t"
+
+/* Per-cpu-id indexing. */
+#define RSEQ_TEMPLATE_CPU_ID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-loongarch-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-loongarch-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_CPU_ID
+
+/* Per-mm-cid indexing. */
+
+#define RSEQ_TEMPLATE_MM_CID
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-loongarch-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+
+#define RSEQ_TEMPLATE_MO_RELEASE
+#include "rseq-loongarch-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELEASE
+#undef RSEQ_TEMPLATE_MM_CID
+
+/* APIs which are not based on cpu ids. */
+
+#define RSEQ_TEMPLATE_CPU_ID_NONE
+#define RSEQ_TEMPLATE_MO_RELAXED
+#include "rseq-loongarch-bits.h"
+#undef RSEQ_TEMPLATE_MO_RELAXED
+#undef RSEQ_TEMPLATE_CPU_ID_NONE
diff --git a/tools/testing/selftests/rseq/rseq-thread-pointer.h b/tools/testing/selftests/rseq/rseq-thread-pointer.h
index 977c25d758b2..b9c8fe7c4683 100644
--- a/tools/testing/selftests/rseq/rseq-thread-pointer.h
+++ b/tools/testing/selftests/rseq/rseq-thread-pointer.h
@@ -12,6 +12,8 @@
 #include "rseq-x86-thread-pointer.h"
 #elif defined(__PPC__)
 #include "rseq-ppc-thread-pointer.h"
+#elif defined(__loongarch__)
+#include "rseq-loongarch-thread-pointer.h"
 #else
 #include "rseq-generic-thread-pointer.h"
 #endif
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index d7364ea4d201..75c4bbe013d3 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -128,6 +128,8 @@ static inline struct rseq_abi *rseq_get_abi(void)
 #include <rseq-s390.h>
 #elif defined(__riscv)
 #include <rseq-riscv.h>
+#elif defined(__loongarch__)
+#include <rseq-loongarch.h>
 #else
 #error unsupported target
 #endif
-- 
2.20.1

