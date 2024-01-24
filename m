Return-Path: <linux-kernel+bounces-36603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A983A3AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAE81C21B43
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771F9171DC;
	Wed, 24 Jan 2024 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="t1wMBdEa"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE4C171AB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083418; cv=none; b=NNGkV57ijzqoHzhqcffoXtIhr3tRY5KZufX6/+DkIDppGuoFCwcNcT9hb8r5MezQ85/1HilCHbiAC/Wjh8y7L4KKsMwvWYSfwKMyMcc74fKip2RYihb1/FWp8FzKGnaAePumANpU/7TNEk0v3EF/QQxoMc6v3qf0+dBtUUJpMRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083418; c=relaxed/simple;
	bh=DZbGuahRgEekEeLuIH8Px8pflnALX/1XiiUfpzn1trA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FIr3fEVMxNDKaxL0cA5wz+0Hs1eg0FUktWBX6wyBZ4xy2SRDSMMQsW3x69/Ktjq0h8kBOBaKwnbQ94c8SKtnWc10DPgr+7D1IpRLxtkGgjogCioC0UjsbtA+IJ8BRT+8av8uahEojyxujkO3rg3aw1GriB/6utzg8ukamk8jAb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=t1wMBdEa; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3394ca0c874so404101f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706083414; x=1706688214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GZy9WpZnhJvrQeE8AmDUs4sp0+DbG8sczVOvkF4cAt8=;
        b=t1wMBdEaT6goDxILLUabY8Eb0c/CUccrzvlc4hAd8TfsiXY/d0FEntIeVX+gNr33AZ
         EdLx6ZDiaN+7dhN14Fy0MoeFjXK4Gllb67Rh87Jj/wcsQIrG/N8Nt85FiWL5IaSF17zz
         4wrx9ay/Bs5yQADj7Sun7bJ8cJxWgb7MtuHEnQYmmcmZwTJy0GQWLz2rlRR9/avgjTJ+
         yCEv1EqbLyhoQ014hYoHz6IbZcplXd351CcYsfuQxP7nb4rx0MdS0YXdL3v0+tZ/FWOW
         +BeqTkg40wPd5GiBnDGyvL2zbDwrcvbJ26FszzYSzlCzmOiaYic7ONXnmTEy3ev1z0+8
         u9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706083414; x=1706688214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZy9WpZnhJvrQeE8AmDUs4sp0+DbG8sczVOvkF4cAt8=;
        b=OlzBFOEiXRWFBv3bIYmY62Ysb6SlearK0/nkOOZjiqVhj4qOxI1Vvsr5dD4HKw5VOp
         S1cGCzV58l2wfxFMdgW3U6SEOTde7Fuo8hOudpik3qjkyF65CRWLc+R3HkklUgZmL6Iu
         Em4I3W9D26Kj/c7djWo3ug0vhFqti4hHLTiHkxgAB4cLA9hQY6SMiQRKb4c4RbebLinK
         59A3JfrRxvgYoEkr8wmo3pWc2kp1+382qJNONAE98FT0eCx4r/JzS7LWULU/69XGhF0b
         KSeEe48bk8Zu2zDjEyB7jV1XQBFqZb5VLxISkR0ZXnfHPdtMdoGBQ+UmEGrCUYrgbQZN
         M7/g==
X-Gm-Message-State: AOJu0YyzlDiDTa+FVkcDStfTSK+nCiCgEDs3mdV7FP/I94ghu3XOoDn4
	7T3PE0nX9mTJwTF3S5eQPTXHDiORoFwqApgdRYm7FyWA/u3QP8DJ46LZYuVcnoI=
X-Google-Smtp-Source: AGHT+IEwCglOT9kCUsrL9QV6qoywOPNiQgp6EwlC96xpmz3dFXkjkP38QsKvnDEjagMQzVxRLinzRQ==
X-Received: by 2002:a7b:cb8a:0:b0:40e:8c73:b205 with SMTP id m10-20020a7bcb8a000000b0040e8c73b205mr883048wmi.74.1706083414076;
        Wed, 24 Jan 2024 00:03:34 -0800 (PST)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id g7-20020a7bc4c7000000b0040d5c58c41dsm43655605wmk.24.2024.01.24.00.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:03:33 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Call secondary mmu notifier when flushing the tlb
Date: Wed, 24 Jan 2024 09:03:25 +0100
Message-Id: <20240124080325.2324462-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is required to allow the IOMMU driver to correctly flush its own
TLB.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/tlbflush.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 8d12b26f5ac3..ad7c4205524d 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -4,6 +4,7 @@
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
+#include <linux/mmu_notifier.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
@@ -98,11 +99,19 @@ static void __ipi_flush_tlb_range_asid(void *info)
 	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
 }
 
-static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
+static inline unsigned long get_mm_asid(struct mm_struct *mm)
+{
+	return (mm && static_branch_unlikely(&use_asid_allocator)) ?
+			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
+}
+
+static void __flush_tlb_range(struct mm_struct *mm,
+			      struct cpumask *cmask,
 			      unsigned long start, unsigned long size,
 			      unsigned long stride)
 {
 	struct flush_tlb_range_data ftd;
+	unsigned long asid = get_mm_asid(mm);
 	bool broadcast;
 
 	if (cpumask_empty(cmask))
@@ -136,31 +145,26 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
 
 	if (cmask != cpu_online_mask)
 		put_cpu();
-}
 
-static inline unsigned long get_mm_asid(struct mm_struct *mm)
-{
-	return static_branch_unlikely(&use_asid_allocator) ?
-			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
+	if (mm)
+		mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, start + size);
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
-			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
+	__flush_tlb_range(mm, mm_cpumask(mm), 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
 }
 
 void flush_tlb_mm_range(struct mm_struct *mm,
 			unsigned long start, unsigned long end,
 			unsigned int page_size)
 {
-	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
-			  start, end - start, page_size);
+	__flush_tlb_range(mm, mm_cpumask(mm), start, end - start, page_size);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
 			  addr, PAGE_SIZE, PAGE_SIZE);
 }
 
@@ -193,13 +197,13 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		}
 	}
 
-	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
 			  start, end - start, stride_size);
 }
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	__flush_tlb_range((struct cpumask *)cpu_online_mask, FLUSH_TLB_NO_ASID,
+	__flush_tlb_range(NULL, (struct cpumask *)cpu_online_mask,
 			  start, end - start, PAGE_SIZE);
 }
 
@@ -207,7 +211,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end)
 {
-	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
 			  start, end - start, PMD_SIZE);
 }
 #endif
@@ -221,7 +225,10 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
 			       struct mm_struct *mm,
 			       unsigned long uaddr)
 {
+	unsigned long start = uaddr & PAGE_MASK;
+
 	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
+	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, start + PAGE_SIZE);
 }
 
 void arch_flush_tlb_batched_pending(struct mm_struct *mm)
@@ -231,6 +238,6 @@ void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
-	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
-			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
+	__flush_tlb_range(NULL, &batch->cpumask,
+			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
 }
-- 
2.39.2


