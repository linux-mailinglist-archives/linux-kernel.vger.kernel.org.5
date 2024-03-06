Return-Path: <linux-kernel+bounces-94305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D08F873CCD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25B31F28C81
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D64513BAD5;
	Wed,  6 Mar 2024 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWcABid+"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E8413699E;
	Wed,  6 Mar 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744365; cv=none; b=ngKw/AOLEbXOx0ysLlwCAmp62qBC4P9RhhidFVusE2QlaNkfzggS3da42/PKlhuE9HU2yCKzYD7PnyXe642U+FradM14zyKyHus49SeoLc1MCJkkvtZhZEp5t/Sow8nwCTK7D7QXO8M5LUshqGMhqH133Zj9RGGTCHis+gcNzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744365; c=relaxed/simple;
	bh=5LwtSLzXIec/L5hngIZAnqe4yTLqewA2ZaP/KmBJdCE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=NyT587uxFJWV0qmNz7eRhcD5oCKB9Ju8bO5f3pirGolUXOSYfvKx9ozEO0Eve0qUJ7bbG066IwLKyiGJg/MDGMP0+j/9aGqRoJRcp0rX5ch9IPkIX4IpOtDoUybqir5w9+1YYq/givhD+L7PbHO62+RKpP014jFf6WBMCMpoPck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWcABid+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso1466f8f.0;
        Wed, 06 Mar 2024 08:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709744361; x=1710349161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GoDKhwgw+miW5ARkGVrNqzMnxuRe2Uy6wo1ivXGP/JA=;
        b=PWcABid+FL7xtfrWIPTR2G1SOH2MfFX7gvqhoBlJc3ubT+uN+g2oLz3XAoQ+fz0gKH
         E2TF/0RBw8VIZi5dCsZfJA0dX2g1uWViDCqtGRJAlf699rYnpOiy/FwbqeBv1Avd6k14
         2XGEnRNnQ9Ri8eXJjmX0zf8HefVsUYeQRv1VuGtxoXDV7kX3rGQj0X7tl/QNGl1X998D
         LtcZRFrmi/X+EZo2ktcrbyyBK2AYnRL2TqAD2EUfPxgq2oSL0bjeVfyOKVaanM7DeOpW
         x27TM46Eoe92ND5fFOc3o440LCtdepj7wbkRmYpeH2K1MtQd8oa9y25kFaWNkUvTxtVi
         X1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709744361; x=1710349161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoDKhwgw+miW5ARkGVrNqzMnxuRe2Uy6wo1ivXGP/JA=;
        b=weG+2vh+Ja6JYpkcKe8KgdPRygA3NSjunQVBJue2HsCx6/CdSTAFPh5jeNxS/JgOyf
         z1erb9YEnhWZrIabmnhra2dc7fYuCGqhPBQipcskvA5Z3xU0/G9laAh4I4Ic+1CY8dxJ
         7LiGbr9LGMm8X4LD2KBS6FSS3ogmTX6gA5wq+UWCD8p8quNMiDfQ02KJlBtjYiMMOGZ4
         26XZTNsN7sPzHTb+oZm7RvXXSbiTQSWK/ydMxcSM3inIjOL0b5nG4yGnY1rOwwfOLJEF
         H7tsQ4tg6NM4ASnZ+KPbo3f+uBZ8bBsvy17KppLJ8MjwuY4qwOSeKasufbA1m3Z9gJVv
         ZJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwz1iZ6Ez4W8ciOnOWidlzP1Z5K4X8v1cJGQWERcDPkKt4uUHb+QQ3Aly9KM7D0ZNDBclU9XCaDvq8Xt6CO9MPQaWHz8zjOosUCq76pWJNx+JomXFAkRHNAxmyub9LRKBdsE8GmRo3DADk7UcgK4ZJ
X-Gm-Message-State: AOJu0Yx6RtSrYm3Mpbw7yZHlGu6UwTABW2w9Z7vVnwzqKo4vDVqrDCsP
	DFaFhB440K8103RauAZS05o9dkJT2Kh5SH4xrFLZNOgmVQpXignh
X-Google-Smtp-Source: AGHT+IHKyDBT04YlSczEFz9XpHogy8dsgMG3n5l3SPmhEJfqIvqI+bjBU0cnm2x+43p7VFNEeJFmXA==
X-Received: by 2002:adf:ca04:0:b0:33d:c45:15ec with SMTP id o4-20020adfca04000000b0033d0c4515ecmr5955057wrh.32.1709744361226;
        Wed, 06 Mar 2024 08:59:21 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id ay30-20020a05600c1e1e00b00412fc25691bsm1294908wmb.38.2024.03.06.08.59.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2024 08:59:20 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Guo Ren <guoren@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Song Shuai <suagrfillet@gmail.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jisheng Zhang <jszhang@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
Date: Wed,  6 Mar 2024 16:59:04 +0000
Message-Id: <20240306165904.108141-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on RISC-V.
This allows each ftrace callsite to provide an ftrace_ops to the common
ftrace trampoline, allowing each callsite to invoke distinct tracer
functions without the need to fall back to list processing or to
allocate custom trampolines for each callsite. This significantly speeds
up cases where multiple distinct trace functions are used and callsites
are mostly traced by a single tracer.

The idea and most of the implementation is taken from the ARM64's
implementation of the same feature. The idea is to place a pointer to
the ftrace_ops as a literal at a fixed offset from the function entry
point, which can be recovered by the common ftrace trampoline.

We use -fpatchable-function-entry to reserve 8 bytes above the function
entry by emitting 2 4 byte or 4 2 byte  nops depending on the presence of
CONFIG_RISCV_ISA_C. These 8 bytes are patched at runtime with a pointer
to the associated ftrace_ops for that callsite. Functions are aligned to
8 bytes to make sure that the accesses to this literal are atomic.

This approach allows for directly invoking ftrace_ops::func even for
ftrace_ops which are dynamically-allocated (or part of a module),
without going via ftrace_ops_list_func.

I've benchamrked this with the ftrace_ops sample module on Qemu, with
the next version, I will provide benchmarks on real hardware:

Without this patch:

+-----------------------+-----------------+----------------------------+
|  Number of tracers    | Total time (ns) | Per-call average time      |
|-----------------------+-----------------+----------------------------|
| Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (ns) |
|----------+------------+-----------------+------------+---------------|
|        0 |          0 |        15615700 |        156 |             - |
|        0 |          1 |        15917600 |        159 |             - |
|        0 |          2 |        15668000 |        156 |             - |
|        0 |         10 |        14971500 |        149 |             - |
|        0 |        100 |        15417600 |        154 |             - |
|        0 |        200 |        15387000 |        153 |             - |
|----------+------------+-----------------+------------+---------------|
|        1 |          0 |       119906800 |       1199 |          1043 |
|        1 |          1 |       137428600 |       1374 |          1218 |
|        1 |          2 |       159562400 |       1374 |          1218 |
|        1 |         10 |       302099900 |       3020 |          2864 |
|        1 |        100 |      2008785500 |      20087 |         19931 |
|        1 |        200 |      3965221900 |      39652 |         39496 |
|----------+------------+-----------------+------------+---------------|
|        1 |          0 |       119166700 |       1191 |          1035 |
|        2 |          0 |       157999900 |       1579 |          1423 |
|       10 |          0 |       425370100 |       4253 |          4097 |
|      100 |          0 |      3595252100 |      35952 |         35796 |
|      200 |          0 |      7023485700 |      70234 |         70078 |
+----------+------------+-----------------+------------+---------------+

Note: per-call overhead is estimated relative to the baseline case with
0 relevant tracers and 0 irrelevant tracers.

With this patch:

+-----------------------+-----------------+----------------------------+
|   Number of tracers   | Total time (ns) | Per-call average time      |
|-----------------------+-----------------+----------------------------|
| Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (ns) |
|----------+------------+-----------------+------------+---------------|
|        0 |          0 |        15254600 |        152 |             - |
|        0 |          1 |        16136700 |        161 |             - |
|        0 |          2 |        15329500 |        153 |             - |
|        0 |         10 |        15148800 |        151 |             - |
|        0 |        100 |        15746900 |        157 |             - |
|        0 |        200 |        15737400 |        157 |             - |
|----------+------------+-----------------+------------+---------------|
|        1 |          0 |        47909000 |        479 |           327 |
|        1 |          1 |        48297400 |        482 |           330 |
|        1 |          2 |        47314100 |        473 |           321 |
|        1 |         10 |        47844900 |        478 |           326 |
|        1 |        100 |        46591900 |        465 |           313 |
|        1 |        200 |        47178900 |        471 |           319 |
|----------+------------+-----------------+------------+---------------|
|        1 |          0 |        46715800 |        467 |           315 |
|        2 |          0 |       155134500 |       1551 |          1399 |
|       10 |          0 |       442672800 |       4426 |          4274 |
|      100 |          0 |      4092353900 |      40923 |         40771 |
|      200 |          0 |      7135796400 |      71357 |         71205 |
+----------+------------+-----------------+------------+---------------+

Note: per-call overhead is estimated relative to the baseline case with
0 relevant tracers and 0 irrelevant tracers.

As can be seen from the above:

 a) Whenever there is a single relevant tracer function associated with a
    tracee, the overhead of invoking the tracer is constant, and does not
    scale with the number of tracers which are *not* associated with that
    tracee.

 b) The overhead for a single relevant tracer has dropped to ~1/3 of the
    overhead prior to this series (from 1035ns to 315ns). This is largely
    due to permitting calls to dynamically-allocated ftrace_ops without
    going through ftrace_ops_list_func.

Why is this patch a RFC patch:
 1. I saw some rcu stalls on Qemu and need to debug them and see if they
    were introduced by this patch.
 2. This needs to be tested thoroughly on real hardware.
 3. Seeking reviews to fix any fundamental problems with this patch that I
    might have missed due to my lack of RISC-V architecture knowledge.
 4. I would like to benchmark this on real hardware and put the results in
    the commit message.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/riscv/Kconfig              |  2 ++
 arch/riscv/Makefile             |  8 +++++
 arch/riscv/include/asm/ftrace.h |  3 ++
 arch/riscv/kernel/asm-offsets.c |  3 ++
 arch/riscv/kernel/ftrace.c      | 59 +++++++++++++++++++++++++++++++++
 arch/riscv/kernel/mcount-dyn.S  | 42 ++++++++++++++++++++---
 6 files changed, 112 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0bfcfec67ed5..e474742e23b2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -78,6 +78,7 @@ config RISCV
 	select EDAC_SUPPORT
 	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
+	select FUNCTION_ALIGNMENT_8B if DYNAMIC_FTRACE_WITH_CALL_OPS
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
@@ -127,6 +128,7 @@ config RISCV
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS if (DYNAMIC_FTRACE_WITH_REGS && !CFI_CLANG)
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 252d63942f34..875ad5dc3d32 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -14,12 +14,20 @@ endif
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
 	LDFLAGS_vmlinux += --no-relax
 	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS), y)
+ifeq ($(CONFIG_RISCV_ISA_C),y)
+	CC_FLAGS_FTRACE := -fpatchable-function-entry=8,4
+else
+	CC_FLAGS_FTRACE := -fpatchable-function-entry=4,2
+endif
+else
 ifeq ($(CONFIG_RISCV_ISA_C),y)
 	CC_FLAGS_FTRACE := -fpatchable-function-entry=4
 else
 	CC_FLAGS_FTRACE := -fpatchable-function-entry=2
 endif
 endif
+endif
 
 ifeq ($(CONFIG_CMODEL_MEDLOW),y)
 KBUILD_CFLAGS_MODULE += -mcmodel=medany
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 329172122952..c9a84222c9ea 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -28,6 +28,9 @@
 void MCOUNT_NAME(void);
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
+		return addr + 8;
+
 	return addr;
 }
 
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index a03129f40c46..7d7c4b486852 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -488,4 +488,7 @@ void asm_offsets(void)
 	DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe), STACK_ALIGN));
 	OFFSET(STACKFRAME_FP, stackframe, fp);
 	OFFSET(STACKFRAME_RA, stackframe, ra);
+#ifdef CONFIG_FUNCTION_TRACER
+	DEFINE(FTRACE_OPS_FUNC,		offsetof(struct ftrace_ops, func));
+#endif
 }
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index f5aa24d9e1c1..e2e75e15d32e 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -82,9 +82,52 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
 	return 0;
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+static const struct ftrace_ops *riscv64_rec_get_ops(struct dyn_ftrace *rec)
+{
+	const struct ftrace_ops *ops = NULL;
+
+	if (rec->flags & FTRACE_FL_CALL_OPS_EN) {
+		ops = ftrace_find_unique_ops(rec);
+		WARN_ON_ONCE(!ops);
+	}
+
+	if (!ops)
+		ops = &ftrace_list_ops;
+
+	return ops;
+}
+
+static int ftrace_rec_set_ops(const struct dyn_ftrace *rec,
+			      const struct ftrace_ops *ops)
+{
+	unsigned long literal = rec->ip - 8;
+
+	return patch_text_nosync((void *)literal, &ops, sizeof(ops));
+}
+
+static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec)
+{
+	return ftrace_rec_set_ops(rec, &ftrace_nop_ops);
+}
+
+static int ftrace_rec_update_ops(struct dyn_ftrace *rec)
+{
+	return ftrace_rec_set_ops(rec, riscv64_rec_get_ops(rec));
+}
+#else
+static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec) { return 0; }
+static int ftrace_rec_update_ops(struct dyn_ftrace *rec) { return 0; }
+#endif
+
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned int call[2];
+	int ret;
+
+	ret = ftrace_rec_update_ops(rec);
+	if (ret)
+		return ret;
 
 	make_call_t0(rec->ip, addr, call);
 
@@ -98,6 +141,11 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
 {
 	unsigned int nops[2] = {NOP4, NOP4};
+	int ret;
+
+	ret = ftrace_rec_set_nop_ops(rec);
+	if (ret)
+		return ret;
 
 	if (patch_text_nosync((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
 		return -EPERM;
@@ -125,6 +173,13 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
+	/*
+	 * When using CALL_OPS, the function to call is associated with the
+	 * call site, and we don't have a global function pointer to update.
+	 */
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
+		return 0;
+
 	int ret = __ftrace_modify_call((unsigned long)&ftrace_call,
 				       (unsigned long)func, true, true);
 	if (!ret) {
@@ -147,6 +202,10 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 	make_call_t0(caller, old_addr, call);
 	ret = ftrace_check_current_call(caller, call);
 
+	if (ret)
+		return ret;
+
+	ret = ftrace_rec_update_ops(rec);
 	if (ret)
 		return ret;
 
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index b7561288e8da..cb241e36e514 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -191,11 +191,35 @@
 	.endm
 
 	.macro PREPARE_ARGS
-	addi	a0, t0, -FENTRY_RA_OFFSET
+	addi	a0, t0, -FENTRY_RA_OFFSET	// ip (callsite's auipc insn)
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+	/*
+	 * When CALL_OPS is enabled (2 or 4) nops [8B] are placed before the
+	 * function entry, these are later overwritten with the pointer to the
+	 * associated struct ftrace_ops.
+	 *
+	 * -8: &ftrace_ops of the associated tracer function.
+	 *<ftrace enable>:
+	 *  0: auipc  t0/ra, 0x?
+	 *  4: jalr   t0/ra, ?(t0/ra)
+	 *
+	 * -8: &ftrace_nop_ops
+	 *<ftrace disable>:
+	 *  0: nop
+	 *  4: nop
+	 *
+	 * t0 is set to ip+8 after the jalr is executed at the callsite,
+	 * so we find the associated op at t0-16.
+	 */
+	mv 	a1, ra				// parent_ip
+	REG_L   a2, -16(t0)			// op
+	REG_L   ra, FTRACE_OPS_FUNC(a2)		// op->func
+#else
 	la	a1, function_trace_op
-	REG_L	a2, 0(a1)
-	mv	a1, ra
-	mv	a3, sp
+	REG_L	a2, 0(a1)			// op
+	mv	a1, ra				// parent_ip
+#endif
+	mv	a3, sp				// regs
 	.endm
 
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
@@ -233,8 +257,12 @@ SYM_FUNC_START(ftrace_regs_caller)
 	SAVE_ABI_REGS 1
 	PREPARE_ARGS
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+	jalr ra
+#else
 SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	call	ftrace_stub
+#endif
 
 	RESTORE_ABI_REGS 1
 	bnez	t1, .Ldirect
@@ -247,9 +275,13 @@ SYM_FUNC_START(ftrace_caller)
 	SAVE_ABI_REGS 0
 	PREPARE_ARGS
 
-SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+	jalr ra
+#else
+SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	call	ftrace_stub
 
+#endif
 	RESTORE_ABI_REGS 0
 	jr	t0
 SYM_FUNC_END(ftrace_caller)
-- 
2.40.1


