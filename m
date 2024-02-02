Return-Path: <linux-kernel+bounces-50734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4395847D67
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141871C2383B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D597A12F378;
	Fri,  2 Feb 2024 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="U0R5hav+"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE485946
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918100; cv=none; b=MyC4BFNUxgS2smYoDXqgYhH4rvOr0Cml2gUQQmDarXvSn+6CIZ1pztH+f68yCN5ffhsjJC1zy2ED1shUam2KKc9OLVpFbL/e/6jhgX28yMUKI9MpLPGcbmpIEBE1ejHIbdNNqk9+sAfijdb7SIgMKoUJOLCMqW2xoqh+45ZpTNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918100; c=relaxed/simple;
	bh=vwhBmHfF/EKObUwb3qKoX49eRqG1MgvOSHuJsJTDdRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rg9cae+qzU5RFn6LnLunjj98GWXm42//tRiWe7YLUmehkUj8NGGjtJzksTdPPpjU3ehoz+RwX5Hvq6FOzCmQRw6foOA6jqj8Uj9S1Mu5P3ARlyKXegkDj2oJGW62fYxCffHWlijPBC77oxreebkPT7KqSLmefr9Kk2eDhfKDgtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=U0R5hav+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d746856d85so20821265ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 15:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706918097; x=1707522897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xunksNOigL1rXi22PNXZoQDfg/C2wRrV7gzfa+vwFao=;
        b=U0R5hav+AWzFHUU849BcG44sBQcsL1/gyOVUnLZ1SOr8a5UpKU4B32nDF+6krnxvcL
         rV2dOUDnuv9VqeG3Wx2olOBM0DHaWh65z4jNejRKDTVWkBJpty5QuLVC194a5jzLHLwY
         JfnoBEE5g3YXdMYHO1nT+A0Kybfk84wNT+TjYslAO2xP1fbcTSU6p6dDcbgFqtYCyfM+
         tMuFu1Wyy2/9PvvOGWbgZkp9vjXA4Bywv0g/ySG733d6nM0ILi9z+wu2WxYgeVrjnD/j
         Qgkcl2WEm2Bu5FwAyMtrWc8WICGJXvYRTSecZXwv//Cy2zO/FRsYGicgJPTqv0qgMIbn
         GQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706918097; x=1707522897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xunksNOigL1rXi22PNXZoQDfg/C2wRrV7gzfa+vwFao=;
        b=otdrwFeAeRpEwLZUiRDBbFCyw6dzCc9nf8D8rTu2Cc2noywBSCVO8TGF/awr0NzbQv
         P1bbe6qbkU1/JuQrFu11ybSlM/xjEEp/RLJkraiHA9BOfqnIQj4uwwplDdH15Wm3v5nR
         drPjyVg2XOtiFCWkMkhRltdzIEl2EEIaSzNWx+4r/yueLAShnqzqtA/iietlVEj0qSlX
         gCR+FyQ9UpEDTPcIk2s0Sqwo55QB8jwt/y8mynt3Dyug9WM4feedU/dhVZJB+po7st8X
         DQhVBcZfVbhvcdRPX+lALXyVrf/PjkQH2M4LaaBwbcYxnOS9U+wD7tupoFtftPKM7B39
         k2XQ==
X-Gm-Message-State: AOJu0Yz2p7G+xlW9FWSAWAoJ5qsWtRwmmsCOlJUPxfXzJvtlTTyxDVpP
	RPpEfhgJAaV6CID1CtqZcmKYsUBPDs4bdSkMRxFO2nDytQVBRhocGdXpzDh7VNM=
X-Google-Smtp-Source: AGHT+IFYHxXEjIxPpgXA6J1gs/EirBeKRbhlsf+UfzOqed7FQaaJMsX52TR4lNfokk2aQ9ZAARrxWA==
X-Received: by 2002:a17:903:1210:b0:1d8:debb:4125 with SMTP id l16-20020a170903121000b001d8debb4125mr3316154plh.38.1706918097358;
        Fri, 02 Feb 2024 15:54:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUngsmC9mmyAjdvI5TTu9ggcNSXbmqX/s809OxaHO7G3/6T1jktG55f6M5eOHDC9iFwztIn/oqWXyXAPkpjpdMucEQN3HPjSkiZyZTbKwlqG6Rq3NirkiCKXKpa9sD0jeozME1MBNcshWKkmYZ9tZIUySIXk246uhabAM5cus1y9r2BjT9Kdljzu24iH8BmHlFMssm0Ge1tR+MDjULLEsHt7jgsQ3l7M2KrGPVvwd7Om44NSqvGi729GqqWFuaXvDa6Qouki+NyZO0Urt3xyFUTKA5uJzha2DDyQODaQTi/XD3+nGXqkTTxZayTF3GMNOt9CQr7Xqq3SA==
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090282c100b001d8f81ece98sm2133607plz.104.2024.02.02.15.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 15:54:56 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 02 Feb 2024 15:54:53 -0800
Subject: [PATCH v3 2/2] riscv: Disable misaligned access probe when
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-disable_misaligned_probe_config-v3-2-c44f91f03bb6@rivosinc.com>
References: <20240202-disable_misaligned_probe_config-v3-0-c44f91f03bb6@rivosinc.com>
In-Reply-To: <20240202-disable_misaligned_probe_config-v3-0-c44f91f03bb6@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706918093; l=19916;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=vwhBmHfF/EKObUwb3qKoX49eRqG1MgvOSHuJsJTDdRo=;
 b=QBayGrWdc/19uAkWgBJuvk/KwxtyVs+VZzXjoNqgXRlxbhfDMcIcM//li0qGe6y6xyRNUJszt
 IDoFebO2PCBCiQ9tPXk2cBHc8ktUcbEg4p1nf96VFtUzqma0JiKZlSi
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

When CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is selected, the cpus can be
set to have fast misaligned access without needing to probe.

To avoid some ifdefs, move unalignment probing code into its own file
and make CONFIG_RISCV_MISALIGNED depend on
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig                          |   1 +
 arch/riscv/include/asm/cpufeature.h         |   7 +
 arch/riscv/kernel/Makefile                  |   3 +
 arch/riscv/kernel/cpufeature.c              | 255 --------------------------
 arch/riscv/kernel/misaligned_access_speed.c | 265 ++++++++++++++++++++++++++++
 arch/riscv/kernel/sys_hwprobe.c             |   4 +
 6 files changed, 280 insertions(+), 255 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bffbd869a068..3223d2d08f74 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -690,6 +690,7 @@ config THREAD_SIZE_ORDER
 config RISCV_MISALIGNED
 	bool "Support misaligned load/store traps for kernel and userspace"
 	select SYSCTL_ARCH_UNALIGN_ALLOW
+	depends on !HAVE_EFFICIENT_UNALIGNED_ACCESS
 	default y
 	help
 	  Say Y here if you want the kernel to embed support for misaligned
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index eb3ac304fc42..44734e5169b1 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -51,6 +51,12 @@ static inline bool check_unaligned_access_emulated(int cpu)
 static inline void unaligned_emulation_finish(void) {}
 #endif
 
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+static __always_inline bool has_fast_misaligned_accesses(void)
+{
+	return true;
+}
+#else
 DECLARE_PER_CPU(long, misaligned_access_speed);
 
 DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
@@ -59,6 +65,7 @@ static __always_inline bool has_fast_misaligned_accesses(void)
 {
 	return static_branch_likely(&fast_misaligned_access_speed_key);
 }
+#endif
 
 unsigned long riscv_get_elf_hwcap(void);
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f71910718053..ffba5ecf12c2 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -62,6 +62,9 @@ obj-y	+= tests/
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
+ifneq ($(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS), y)
+obj-y	+= misaligned_access_speed.o
+endif
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
 obj-$(CONFIG_RISCV_ISA_V)	+= kernel_mode_vector.o
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 89920f84d0a3..319670af5704 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -11,7 +11,6 @@
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
 #include <linux/ctype.h>
-#include <linux/jump_label.h>
 #include <linux/log2.h>
 #include <linux/memory.h>
 #include <linux/module.h>
@@ -21,20 +20,12 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/hwcap.h>
-#include <asm/hwprobe.h>
 #include <asm/patch.h>
 #include <asm/processor.h>
 #include <asm/vector.h>
 
-#include "copy-unaligned.h"
-
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
-#define MISALIGNED_ACCESS_JIFFIES_LG2 1
-#define MISALIGNED_BUFFER_SIZE 0x4000
-#define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
-#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
-
 unsigned long elf_hwcap __read_mostly;
 
 /* Host ISA bitmap */
@@ -43,11 +34,6 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 /* Per-cpu ISA extensions. */
 struct riscv_isainfo hart_isa[NR_CPUS];
 
-/* Performance information */
-DEFINE_PER_CPU(long, misaligned_access_speed);
-
-static cpumask_t fast_misaligned_access;
-
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -706,247 +692,6 @@ unsigned long riscv_get_elf_hwcap(void)
 	return hwcap;
 }
 
-static int check_unaligned_access(void *param)
-{
-	int cpu = smp_processor_id();
-	u64 start_cycles, end_cycles;
-	u64 word_cycles;
-	u64 byte_cycles;
-	int ratio;
-	unsigned long start_jiffies, now;
-	struct page *page = param;
-	void *dst;
-	void *src;
-	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
-
-	if (check_unaligned_access_emulated(cpu))
-		return 0;
-
-	/* Make an unaligned destination buffer. */
-	dst = (void *)((unsigned long)page_address(page) | 0x1);
-	/* Unalign src as well, but differently (off by 1 + 2 = 3). */
-	src = dst + (MISALIGNED_BUFFER_SIZE / 2);
-	src += 2;
-	word_cycles = -1ULL;
-	/* Do a warmup. */
-	__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
-	preempt_disable();
-	start_jiffies = jiffies;
-	while ((now = jiffies) == start_jiffies)
-		cpu_relax();
-
-	/*
-	 * For a fixed amount of time, repeatedly try the function, and take
-	 * the best time in cycles as the measurement.
-	 */
-	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
-		start_cycles = get_cycles64();
-		/* Ensure the CSR read can't reorder WRT to the copy. */
-		mb();
-		__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
-		/* Ensure the copy ends before the end time is snapped. */
-		mb();
-		end_cycles = get_cycles64();
-		if ((end_cycles - start_cycles) < word_cycles)
-			word_cycles = end_cycles - start_cycles;
-	}
-
-	byte_cycles = -1ULL;
-	__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
-	start_jiffies = jiffies;
-	while ((now = jiffies) == start_jiffies)
-		cpu_relax();
-
-	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
-		start_cycles = get_cycles64();
-		mb();
-		__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
-		mb();
-		end_cycles = get_cycles64();
-		if ((end_cycles - start_cycles) < byte_cycles)
-			byte_cycles = end_cycles - start_cycles;
-	}
-
-	preempt_enable();
-
-	/* Don't divide by zero. */
-	if (!word_cycles || !byte_cycles) {
-		pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned access speed\n",
-			cpu);
-
-		return 0;
-	}
-
-	if (word_cycles < byte_cycles)
-		speed = RISCV_HWPROBE_MISALIGNED_FAST;
-
-	ratio = div_u64((byte_cycles * 100), word_cycles);
-	pr_info("cpu%d: Ratio of byte access time to unaligned word access is %d.%02d, unaligned accesses are %s\n",
-		cpu,
-		ratio / 100,
-		ratio % 100,
-		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
-
-	per_cpu(misaligned_access_speed, cpu) = speed;
-
-	/*
-	 * Set the value of fast_misaligned_access of a CPU. These operations
-	 * are atomic to avoid race conditions.
-	 */
-	if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
-		cpumask_set_cpu(cpu, &fast_misaligned_access);
-	else
-		cpumask_clear_cpu(cpu, &fast_misaligned_access);
-
-	return 0;
-}
-
-static void check_unaligned_access_nonboot_cpu(void *param)
-{
-	unsigned int cpu = smp_processor_id();
-	struct page **pages = param;
-
-	if (smp_processor_id() != 0)
-		check_unaligned_access(pages[cpu]);
-}
-
-DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
-
-static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
-{
-	if (cpumask_weight(mask) == weight)
-		static_branch_enable_cpuslocked(&fast_misaligned_access_speed_key);
-	else
-		static_branch_disable_cpuslocked(&fast_misaligned_access_speed_key);
-}
-
-static void set_unaligned_access_static_branches_except_cpu(int cpu)
-{
-	/*
-	 * Same as set_unaligned_access_static_branches, except excludes the
-	 * given CPU from the result. When a CPU is hotplugged into an offline
-	 * state, this function is called before the CPU is set to offline in
-	 * the cpumask, and thus the CPU needs to be explicitly excluded.
-	 */
-
-	cpumask_t fast_except_me;
-
-	cpumask_and(&fast_except_me, &fast_misaligned_access, cpu_online_mask);
-	cpumask_clear_cpu(cpu, &fast_except_me);
-
-	modify_unaligned_access_branches(&fast_except_me, num_online_cpus() - 1);
-}
-
-static void set_unaligned_access_static_branches(void)
-{
-	/*
-	 * This will be called after check_unaligned_access_all_cpus so the
-	 * result of unaligned access speed for all CPUs will be available.
-	 *
-	 * To avoid the number of online cpus changing between reading
-	 * cpu_online_mask and calling num_online_cpus, cpus_read_lock must be
-	 * held before calling this function.
-	 */
-
-	cpumask_t fast_and_online;
-
-	cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online_mask);
-
-	modify_unaligned_access_branches(&fast_and_online, num_online_cpus());
-}
-
-static int lock_and_set_unaligned_access_static_branch(void)
-{
-	cpus_read_lock();
-	set_unaligned_access_static_branches();
-	cpus_read_unlock();
-
-	return 0;
-}
-
-arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
-
-static int riscv_online_cpu(unsigned int cpu)
-{
-	static struct page *buf;
-
-	/* We are already set since the last check */
-	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
-		goto exit;
-
-	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
-	if (!buf) {
-		pr_warn("Allocation failure, not measuring misaligned performance\n");
-		return -ENOMEM;
-	}
-
-	check_unaligned_access(buf);
-	__free_pages(buf, MISALIGNED_BUFFER_ORDER);
-
-exit:
-	set_unaligned_access_static_branches();
-
-	return 0;
-}
-
-static int riscv_offline_cpu(unsigned int cpu)
-{
-	set_unaligned_access_static_branches_except_cpu(cpu);
-
-	return 0;
-}
-
-/* Measure unaligned access on all CPUs present at boot in parallel. */
-static int check_unaligned_access_all_cpus(void)
-{
-	unsigned int cpu;
-	unsigned int cpu_count = num_possible_cpus();
-	struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
-				     GFP_KERNEL);
-
-	if (!bufs) {
-		pr_warn("Allocation failure, not measuring misaligned performance\n");
-		return 0;
-	}
-
-	/*
-	 * Allocate separate buffers for each CPU so there's no fighting over
-	 * cache lines.
-	 */
-	for_each_cpu(cpu, cpu_online_mask) {
-		bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
-		if (!bufs[cpu]) {
-			pr_warn("Allocation failure, not measuring misaligned performance\n");
-			goto out;
-		}
-	}
-
-	/* Check everybody except 0, who stays behind to tend jiffies. */
-	on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
-
-	/* Check core 0. */
-	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
-
-	/*
-	 * Setup hotplug callbacks for any new CPUs that come online or go
-	 * offline.
-	 */
-	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
-				  riscv_online_cpu, riscv_offline_cpu);
-
-out:
-	unaligned_emulation_finish();
-	for_each_cpu(cpu, cpu_online_mask) {
-		if (bufs[cpu])
-			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
-	}
-
-	kfree(bufs);
-	return 0;
-}
-
-arch_initcall(check_unaligned_access_all_cpus);
-
 void riscv_user_isa_enable(void)
 {
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
diff --git a/arch/riscv/kernel/misaligned_access_speed.c b/arch/riscv/kernel/misaligned_access_speed.c
new file mode 100644
index 000000000000..b725c07dd1af
--- /dev/null
+++ b/arch/riscv/kernel/misaligned_access_speed.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Rivos Inc.
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/jump_label.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/types.h>
+#include <asm/cpufeature.h>
+#include <asm/hwprobe.h>
+
+#include "copy-unaligned.h"
+
+#define MISALIGNED_ACCESS_JIFFIES_LG2 1
+#define MISALIGNED_BUFFER_SIZE 0x4000
+#define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
+#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
+
+DEFINE_PER_CPU(long, misaligned_access_speed);
+
+static cpumask_t fast_misaligned_access;
+
+static int check_unaligned_access(void *param)
+{
+	int cpu = smp_processor_id();
+	u64 start_cycles, end_cycles;
+	u64 word_cycles;
+	u64 byte_cycles;
+	int ratio;
+	unsigned long start_jiffies, now;
+	struct page *page = param;
+	void *dst;
+	void *src;
+	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
+
+	if (check_unaligned_access_emulated(cpu))
+		return 0;
+
+	/* Make an unaligned destination buffer. */
+	dst = (void *)((unsigned long)page_address(page) | 0x1);
+	/* Unalign src as well, but differently (off by 1 + 2 = 3). */
+	src = dst + (MISALIGNED_BUFFER_SIZE / 2);
+	src += 2;
+	word_cycles = -1ULL;
+	/* Do a warmup. */
+	__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+	preempt_disable();
+	start_jiffies = jiffies;
+	while ((now = jiffies) == start_jiffies)
+		cpu_relax();
+
+	/*
+	 * For a fixed amount of time, repeatedly try the function, and take
+	 * the best time in cycles as the measurement.
+	 */
+	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
+		start_cycles = get_cycles64();
+		/* Ensure the CSR read can't reorder WRT to the copy. */
+		mb();
+		__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+		/* Ensure the copy ends before the end time is snapped. */
+		mb();
+		end_cycles = get_cycles64();
+		if ((end_cycles - start_cycles) < word_cycles)
+			word_cycles = end_cycles - start_cycles;
+	}
+
+	byte_cycles = -1ULL;
+	__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+	start_jiffies = jiffies;
+	while ((now = jiffies) == start_jiffies)
+		cpu_relax();
+
+	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
+		start_cycles = get_cycles64();
+		mb();
+		__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+		mb();
+		end_cycles = get_cycles64();
+		if ((end_cycles - start_cycles) < byte_cycles)
+			byte_cycles = end_cycles - start_cycles;
+	}
+
+	preempt_enable();
+
+	/* Don't divide by zero. */
+	if (!word_cycles || !byte_cycles) {
+		pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned access speed\n",
+			cpu);
+
+		return 0;
+	}
+
+	if (word_cycles < byte_cycles)
+		speed = RISCV_HWPROBE_MISALIGNED_FAST;
+
+	ratio = div_u64((byte_cycles * 100), word_cycles);
+	pr_info("cpu%d: Ratio of byte access time to unaligned word access is %d.%02d, unaligned accesses are %s\n",
+		cpu,
+		ratio / 100,
+		ratio % 100,
+		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
+
+	per_cpu(misaligned_access_speed, cpu) = speed;
+
+	/*
+	 * Set the value of fast_misaligned_access of a CPU. These operations
+	 * are atomic to avoid race conditions.
+	 */
+	if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
+		cpumask_set_cpu(cpu, &fast_misaligned_access);
+	else
+		cpumask_clear_cpu(cpu, &fast_misaligned_access);
+
+	return 0;
+}
+
+static void check_unaligned_access_nonboot_cpu(void *param)
+{
+	unsigned int cpu = smp_processor_id();
+	struct page **pages = param;
+
+	if (smp_processor_id() != 0)
+		check_unaligned_access(pages[cpu]);
+}
+
+DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
+static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
+{
+	if (cpumask_weight(mask) == weight)
+		static_branch_enable_cpuslocked(&fast_misaligned_access_speed_key);
+	else
+		static_branch_disable_cpuslocked(&fast_misaligned_access_speed_key);
+}
+
+static void set_unaligned_access_static_branches_except_cpu(int cpu)
+{
+	/*
+	 * Same as set_unaligned_access_static_branches, except excludes the
+	 * given CPU from the result. When a CPU is hotplugged into an offline
+	 * state, this function is called before the CPU is set to offline in
+	 * the cpumask, and thus the CPU needs to be explicitly excluded.
+	 */
+
+	cpumask_t fast_except_me;
+
+	cpumask_and(&fast_except_me, &fast_misaligned_access, cpu_online_mask);
+	cpumask_clear_cpu(cpu, &fast_except_me);
+
+	modify_unaligned_access_branches(&fast_except_me, num_online_cpus() - 1);
+}
+
+static void set_unaligned_access_static_branches(void)
+{
+	/*
+	 * This will be called after check_unaligned_access_all_cpus so the
+	 * result of unaligned access speed for all CPUs will be available.
+	 *
+	 * To avoid the number of online cpus changing between reading
+	 * cpu_online_mask and calling num_online_cpus, cpus_read_lock must be
+	 * held before calling this function.
+	 */
+
+	cpumask_t fast_and_online;
+
+	cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online_mask);
+
+	modify_unaligned_access_branches(&fast_and_online, num_online_cpus());
+}
+
+static int lock_and_set_unaligned_access_static_branch(void)
+{
+	cpus_read_lock();
+	set_unaligned_access_static_branches();
+	cpus_read_unlock();
+
+	return 0;
+}
+
+arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
+
+static int riscv_online_cpu(unsigned int cpu)
+{
+	static struct page *buf;
+
+	/* We are already set since the last check */
+	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
+		goto exit;
+
+	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
+	if (!buf) {
+		pr_warn("Allocation failure, not measuring misaligned performance\n");
+		return -ENOMEM;
+	}
+
+	check_unaligned_access(buf);
+	__free_pages(buf, MISALIGNED_BUFFER_ORDER);
+
+exit:
+	set_unaligned_access_static_branches();
+
+	return 0;
+}
+
+static int riscv_offline_cpu(unsigned int cpu)
+{
+	set_unaligned_access_static_branches_except_cpu(cpu);
+
+	return 0;
+}
+
+/* Measure unaligned access on all CPUs present at boot in parallel. */
+static int check_unaligned_access_all_cpus(void)
+{
+	unsigned int cpu;
+	unsigned int cpu_count = num_possible_cpus();
+	struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
+				     GFP_KERNEL);
+
+	if (!bufs) {
+		pr_warn("Allocation failure, not measuring misaligned performance\n");
+		return 0;
+	}
+
+	/*
+	 * Allocate separate buffers for each CPU so there's no fighting over
+	 * cache lines.
+	 */
+	for_each_cpu(cpu, cpu_online_mask) {
+		bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
+		if (!bufs[cpu]) {
+			pr_warn("Allocation failure, not measuring misaligned performance\n");
+			goto out;
+		}
+	}
+
+	/* Check everybody except 0, who stays behind to tend jiffies. */
+	on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
+
+	/* Check core 0. */
+	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
+
+	/*
+	 * Setup hotplug callbacks for any new CPUs that come online or go
+	 * offline.
+	 */
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
+				  riscv_online_cpu, riscv_offline_cpu);
+
+out:
+	unaligned_emulation_finish();
+	for_each_cpu(cpu, cpu_online_mask) {
+		if (bufs[cpu])
+			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
+	}
+
+	kfree(bufs);
+	return 0;
+}
+
+arch_initcall(check_unaligned_access_all_cpus);
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index a7c56b41efd2..d9bd24776a3e 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -149,6 +149,9 @@ static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
 
 static u64 hwprobe_misaligned(const struct cpumask *cpus)
 {
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	return RISCV_HWPROBE_MISALIGNED_FAST;
+#else
 	int cpu;
 	u64 perf = -1ULL;
 
@@ -168,6 +171,7 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
 		return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
 
 	return perf;
+#endif
 }
 
 static void hwprobe_one_pair(struct riscv_hwprobe *pair,

-- 
2.43.0


