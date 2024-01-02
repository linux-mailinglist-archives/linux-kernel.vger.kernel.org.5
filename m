Return-Path: <linux-kernel+bounces-14474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD20D821D85
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53D91C22257
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AF810A0D;
	Tue,  2 Jan 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZL2oYNxE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880810955
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3367a304091so9229599f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704205135; x=1704809935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wMN809tankXeln0SghaIn8Kql+3yxJkVpIyb/WVy4mE=;
        b=ZL2oYNxEgoFgGfqkfcePcK1+vdZ6nB1GpLlyiLN5LeIZpL8C+cMtE0/KuKrYt9yTW+
         yy+BkmJIf7CwOcGmNw1xQjtMt/MfbJRfM1pQHJ5mLCVcc2fRweij8Fv4mboA2L8FS4/K
         drsRn7J3arxF3YwbVrApNrKEV5WPTXpBeX83K/6LFznqfd53Nto5AGDqjV0XQbiZLIPu
         DC8Sy2Bqpsf/ia4dmrsMJ6+Hz8i/+sgtzB2ooEIO9739ysW3eKbw+Vq/lVDJU5THPKXB
         Es8mNXmVQhTg1ujlI0J5lxdhl3K9p4RpTop5a5JAHIZdLBCKnynKSGHm5IKRQ2qAdMbT
         hdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704205135; x=1704809935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMN809tankXeln0SghaIn8Kql+3yxJkVpIyb/WVy4mE=;
        b=ZJh7AszkKm1zItJ7kMKoE6ikIkSaQBqSVZtloUQgvA5H7jk9ibgTwyp+LgWMRYwWij
         LWn9s7NcCOIrgLDeoQUSpblPWGvGy0X7xg+n9etvA6K4YcvjeChoCNFKZbmWtx+ghzQN
         4+8j619X5NaWZS3I3yhYKjJnqww4bfh3eFcHmZEwp1IJaaAE+PmmFhEuqyocTWVGyl2l
         2fd9FLK57hX/qA+icFHBC14c1AkTGNHP1iT7ArMstq0Uk/Q9SWCOTHjutt6zGSy+w/3b
         74Avy9njYd2HSJlNwa15/OMroxnBa90uwS2ziYU+9Or4PygvRjyXNjC/ohApC1bFdDGJ
         Z6/w==
X-Gm-Message-State: AOJu0Yw0Qy0SZ7Ffo+zm1j7EoG2Hpey2nUiWo623vh/whYbVM4TS/rFH
	QD0aeWS8l2SHju/mWOgTScTZrLqM6rlnwg==
X-Google-Smtp-Source: AGHT+IHuu8YHzUPNDkHHX9vez11aS4PONT163xT3HgL6zasNPiQtGDoJ4rm+KyN+vnhxYydK/VbwAw==
X-Received: by 2002:adf:eb0c:0:b0:336:d9cc:3050 with SMTP id s12-20020adfeb0c000000b00336d9cc3050mr4083761wrn.126.1704205134756;
        Tue, 02 Jan 2024 06:18:54 -0800 (PST)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id b14-20020adff90e000000b003373fe3d345sm5412159wrr.65.2024.01.02.06.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:18:54 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Add support for BATCHED_UNMAP_TLB_FLUSH
Date: Tue,  2 Jan 2024 15:18:51 +0100
Message-Id: <20240102141851.105144-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to defer the flushing of the TLB when unmapping pges, which allows
to reduce the numbers of IPI and the number of sfence.vma.

The ubenchmarch used in commit 43b3dfdd0455 ("arm64: support
batched/deferred tlb shootdown during page reclamation/migration") shows
good performance improvement and perf reports an important decrease in
time spent flushing the tlb (results come from qemu):

Before this patch:

real	2m1.135s
user	0m0.980s
sys	2m0.096s

4.83%  batch_tlb  [kernel.kallsyms]            [k] __flush_tlb_range

After this patch:

real	1m0.543s
user	0m1.059s
sys	0m59.489s

0.14%  batch_tlb  [kernel.kallsyms]            [k] __flush_tlb_range

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig                |  1 +
 arch/riscv/include/asm/tlbbatch.h | 15 +++++++
 arch/riscv/include/asm/tlbflush.h | 10 +++++
 arch/riscv/mm/tlbflush.c          | 71 ++++++++++++++++++++++---------
 4 files changed, 77 insertions(+), 20 deletions(-)
 create mode 100644 arch/riscv/include/asm/tlbbatch.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7603bd8ab333..aa07bd43b138 100644
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
index 8f3418c5f172..f0b731ccc0c2 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -46,6 +46,16 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end);
 #endif
+
+#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+bool arch_tlbbatch_should_defer(struct mm_struct *mm);
+void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+			       struct mm_struct *mm,
+			       unsigned long uaddr);
+void arch_flush_tlb_batched_pending(struct mm_struct *mm);
+void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+#endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
+
 #else /* CONFIG_SMP && CONFIG_MMU */
 
 #define flush_tlb_all() local_flush_tlb_all()
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index e6659d7368b3..bb623bca0a7d 100644
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
@@ -185,18 +188,46 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
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
+#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
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
+#endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
-- 
2.39.2


