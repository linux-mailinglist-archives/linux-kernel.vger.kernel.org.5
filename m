Return-Path: <linux-kernel+bounces-20048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FA88278A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D130CB21003
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E185576D;
	Mon,  8 Jan 2024 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EbM/lctm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C546755771
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33748c4f33dso2089282f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704742615; x=1705347415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0A3ryeyMJZpg1Hmx8jjfMszJRDq8kxjkrAWUket3WHU=;
        b=EbM/lctmBFyLkjokp//hMQLj0luM5OFbnyC6UVj2hoX4RBuE/BulxrS/7grgcTLUcB
         oLXtzV5g98froTpZ3Wprlgnda2kIsGMMbN4UlYUXlcvhAmmSV0xlq+E3yYoGNbJoK7f2
         i6dFr+HOk96UbueMoLM9u+Pyt8QbwcQut9KsTwNZV5j/ygoOI/lo2uZwZN2RBBc7A/B3
         YxAWm8yiSDnO/v8jjNGxrmuTz5IMgIN7aex5gTh7xmaOomb0KnCIsYLG1+nl95xnSFML
         m8c/b20oHNGnlc/13OiEoVPPkcp4UlZRl91ymVUhcrFu0c/s+pEoEPHRbyn9mSlluE/M
         C4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704742615; x=1705347415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0A3ryeyMJZpg1Hmx8jjfMszJRDq8kxjkrAWUket3WHU=;
        b=BuTx1BLbwfcVwKH1unainQoULHh3/IyPalVYJFArZ5wrs2Bij15S1nevCKtjlyuUBr
         KsHKSlIJzgwwPbR8R7FbmiA/zqipDdtU7+/WTbHHvHc5BUXvuQ+u1Z6O4Xtu9Oq495s4
         z6wN/916kNTzUnZZz56hOzehuxUeAcKw98MEWtLxUDiOgl/yva0JK0hH3je389fNNC3B
         QbxUnYnIp3ABZia3A7KkkEE4Z8Mw2OdzKNxEJchc0pnmT297RfMbrL+47ibNqXXJITrW
         gS+e7kj6xyGWtXtLCB1LUptutf5Yv0baXXuJAoNuvEAOksLltMk03gzRyNseopuSLRPO
         uvKg==
X-Gm-Message-State: AOJu0YxDPw4WjHnpNz4KHR/vWSlypfftEKpafSoZ7LsaFk/DjgqFRD8t
	olblD6X9FWi8Dw/XtsPvIhtwdME75MF2Cg==
X-Google-Smtp-Source: AGHT+IFeaTPgStGBhJQLs2Nw3aNSwPRuL9Q2GuNFmE0jdNUvpPkz+XlothoadPGhyALtQp3/Om+r1w==
X-Received: by 2002:adf:cc85:0:b0:336:7bd3:9520 with SMTP id p5-20020adfcc85000000b003367bd39520mr2487583wrj.43.1704742614984;
        Mon, 08 Jan 2024 11:36:54 -0800 (PST)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id g18-20020adff3d2000000b00336aac53e75sm412040wrp.97.2024.01.08.11.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 11:36:54 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v2] riscv: Add support for BATCHED_UNMAP_TLB_FLUSH
Date: Mon,  8 Jan 2024 20:36:40 +0100
Message-Id: <20240108193640.344929-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to defer the flushing of the TLB when unmapping pages, which allows
to reduce the numbers of IPI and the number of sfence.vma.

The ubenchmarch used in commit 43b3dfdd0455 ("arm64: support
batched/deferred tlb shootdown during page reclamation/migration") that
was multithreaded to force the usage of IPI shows good performance
improvement on all platforms:

* Unmatched: ~34%
* TH1520   : ~78%
* Qemu     : ~81%

In addition, perf on qemu reports an important decrease in time spent
dealing with IPIs:

Before:  68.17%  main     [kernel.kallsyms]            [k] __sbi_rfence_v02_call
After :   8.64%  main     [kernel.kallsyms]            [k] __sbi_rfence_v02_call

* Benchmark:

int stick_this_thread_to_core(int core_id) {
        int num_cores = sysconf(_SC_NPROCESSORS_ONLN);
        if (core_id < 0 || core_id >= num_cores)
           return EINVAL;

        cpu_set_t cpuset;
        CPU_ZERO(&cpuset);
        CPU_SET(core_id, &cpuset);

        pthread_t current_thread = pthread_self();
        return pthread_setaffinity_np(current_thread,
sizeof(cpu_set_t), &cpuset);
}

static void *fn_thread (void *p_data)
{
        int ret;
        pthread_t thread;

        stick_this_thread_to_core((int)p_data);

        while (1) {
                sleep(1);
        }

        return NULL;
}

int main()
{
        volatile unsigned char *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
                                         MAP_SHARED | MAP_ANONYMOUS, -1, 0);
        pthread_t threads[4];
        int ret;

        for (int i = 0; i < 4; ++i) {
                ret = pthread_create(&threads[i], NULL, fn_thread, (void *)i);
                if (ret)
                {
                        printf("%s", strerror (ret));
                }
        }

        memset(p, 0x88, SIZE);

        for (int k = 0; k < 10000; k++) {
                /* swap in */
                for (int i = 0; i < SIZE; i += 4096) {
                        (void)p[i];
                }

                /* swap out */
                madvise(p, SIZE, MADV_PAGEOUT);
        }

        for (int i = 0; i < 4; i++)
        {
                pthread_cancel(threads[i]);
        }

        for (int i = 0; i < 4; i++)
        {
                pthread_join(threads[i], NULL);
        }

        return 0;
}

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
Tested-by: Jisheng Zhang <jszhang@kernel.org> # Tested on TH1520
---

Changes in v2:
- Remove #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH as suggested by
  Samuel
- Update Documentation as pointed by Jisheng
- Update commit log with Unmatched and TH1520 results (Jisheng) with new
  ubenchmarks

 .../features/vm/TLB/arch-support.txt          |  2 +-
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/include/asm/tlbbatch.h             | 15 ++++
 arch/riscv/include/asm/tlbflush.h             |  8 +++
 arch/riscv/mm/tlbflush.c                      | 69 +++++++++++++------
 5 files changed, 74 insertions(+), 21 deletions(-)
 create mode 100644 arch/riscv/include/asm/tlbbatch.h

diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index 8fd22073a847..d222bd3ee749 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -20,7 +20,7 @@
     |    openrisc: |  ..  |
     |      parisc: | TODO |
     |     powerpc: | TODO |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 060c2a4fa639..49a94a4f2f58 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -53,6 +53,7 @@ config RISCV
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USES_CFI_TRAPS if CFI_CLANG
+	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
diff --git a/arch/riscv/include/asm/tlbbatch.h b/arch/riscv/include/asm/tlbbatch.h
new file mode 100644
index 000000000000..46014f70b9da
--- /dev/null
+++ b/arch/riscv/include/asm/tlbbatch.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+#ifndef _ASM_RISCV_TLBBATCH_H
+#define _ASM_RISCV_TLBBATCH_H
+
+#include <linux/cpumask.h>
+
+struct arch_tlbflush_unmap_batch {
+	struct cpumask cpumask;
+};
+
+#endif /* _ASM_RISCV_TLBBATCH_H */
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 8f3418c5f172..9c8a67b1285e 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -46,6 +46,14 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end);
 #endif
+
+bool arch_tlbbatch_should_defer(struct mm_struct *mm);
+void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+			       struct mm_struct *mm,
+			       unsigned long uaddr);
+void arch_flush_tlb_batched_pending(struct mm_struct *mm);
+void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+
 #else /* CONFIG_SMP && CONFIG_MMU */
 
 #define flush_tlb_all() local_flush_tlb_all()
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index e6659d7368b3..f0190f5fdd05 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -93,29 +93,23 @@ static void __ipi_flush_tlb_range_asid(void *info)
 	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
 }
 
-static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
-			      unsigned long size, unsigned long stride)
+static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
+			      unsigned long start, unsigned long size,
+			      unsigned long stride)
 {
 	struct flush_tlb_range_data ftd;
-	const struct cpumask *cmask;
-	unsigned long asid = FLUSH_TLB_NO_ASID;
 	bool broadcast;
 
-	if (mm) {
-		unsigned int cpuid;
+	if (cpumask_empty(cmask))
+		return;
 
-		cmask = mm_cpumask(mm);
-		if (cpumask_empty(cmask))
-			return;
+	if (cmask != cpu_online_mask) {
+		unsigned int cpuid;
 
 		cpuid = get_cpu();
 		/* check if the tlbflush needs to be sent to other CPUs */
 		broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
-
-		if (static_branch_unlikely(&use_asid_allocator))
-			asid = atomic_long_read(&mm->context.id) & asid_mask;
 	} else {
-		cmask = cpu_online_mask;
 		broadcast = true;
 	}
 
@@ -135,25 +129,34 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 		local_flush_tlb_range_asid(start, size, stride, asid);
 	}
 
-	if (mm)
+	if (cmask != cpu_online_mask)
 		put_cpu();
 }
 
+static inline unsigned long get_mm_asid(struct mm_struct *mm)
+{
+	return static_branch_unlikely(&use_asid_allocator) ?
+			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
+}
+
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	__flush_tlb_range(mm, 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
+	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
+			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
 }
 
 void flush_tlb_mm_range(struct mm_struct *mm,
 			unsigned long start, unsigned long end,
 			unsigned int page_size)
 {
-	__flush_tlb_range(mm, start, end - start, page_size);
+	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
+			  start, end - start, page_size);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	__flush_tlb_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
+	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+			  addr, PAGE_SIZE, PAGE_SIZE);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
@@ -185,18 +188,44 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		}
 	}
 
-	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
+	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+			  start, end - start, stride_size);
 }
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	__flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
+	__flush_tlb_range((struct cpumask *)cpu_online_mask, FLUSH_TLB_NO_ASID,
+			  start, end - start, PAGE_SIZE);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end)
 {
-	__flush_tlb_range(vma->vm_mm, start, end - start, PMD_SIZE);
+	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+			  start, end - start, PMD_SIZE);
 }
 #endif
+
+bool arch_tlbbatch_should_defer(struct mm_struct *mm)
+{
+	return true;
+}
+
+void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+			       struct mm_struct *mm,
+			       unsigned long uaddr)
+{
+	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
+}
+
+void arch_flush_tlb_batched_pending(struct mm_struct *mm)
+{
+	flush_tlb_mm(mm);
+}
+
+void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
+{
+	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
+			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
+}
-- 
2.39.2


