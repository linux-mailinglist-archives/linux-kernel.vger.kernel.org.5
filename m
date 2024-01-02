Return-Path: <linux-kernel+bounces-14915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8FA822471
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E3EAB217A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D5018EC8;
	Tue,  2 Jan 2024 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DAIC4PEH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AEE18E1C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28c0d8dd88bso4065989a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704232902; x=1704837702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtzHkWRF5gALofCSRDnlYgSzHUyaPaF++esfIcBOkBw=;
        b=DAIC4PEHXK6zN41yGxbL8WtnEyXB7nYGu49/aORPHuv2xTX+4si3aH4of6n+waXs+n
         QRpUA/BGpBPkwGoGWxZ5S9NRdjoXPFJNTiGuzXbsM+k4srZHnZZ4pj0iLwfUdSsFcDb6
         PGPtfbLTo8KNJ0NVUQiJBf6s7tYRjqyobBZ8SCazTKU4VkIMM1wSSov7ZMAnJVXxqG1q
         OleZkGQ+YCQ0EkF1344I0kMlE1SjqEsrWAToUpADyIXqPMxJf4vXa6E0By2FNGttP7Zn
         yUcBaJgG8E4Pe8Hec4TCWqq+sPfy8ngGJ2wXfbAS6M+NeLPZbSJRuw1H728uJlnpPdHI
         +eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232902; x=1704837702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtzHkWRF5gALofCSRDnlYgSzHUyaPaF++esfIcBOkBw=;
        b=I3nbBbO8vE2U/gaedSgg4TVm15v3A5EOz7z75h8f/gxHjBJno+gl5qp7YVXmYl8tU7
         HktOFiCu1c80wp6VekZC1cKEdLlyaxq/AkVnDqljQfg0gKAFMKL8x5MEatWOxIPaGgHu
         w3alK/e75gRQgPe3tw9+Eggc4mrgaWTx2tVxKz18hV1ZkibDRCMW8FQY7Cn74a7z8MxS
         yp5OXLw0k6IaN/OE+Cnrju1T3zufnuivT5q5yRZrk50/2BKSh10+MLlvqzcj8ONT2aYN
         pjjE7bp0PaivvNV/VtpcxKLuzRxikUT9jkm0FeGuGglIKN2ezaZWFuX8yrIjk/kXRILP
         CpcQ==
X-Gm-Message-State: AOJu0YxWQW8edkcra5Kaikg6tJZZrybPCprPgyD/msjNaMpJdjOO6ydm
	XytC8chEGN/AcRb1Dfy0Ueqgv04u/Ch4TA==
X-Google-Smtp-Source: AGHT+IExkJSZEsbRdHGUNd8kiI0pICSa1vMynIFUPWzzc2fqMiijvWM2jfH6XllBTjKhdLtvimrjxg==
X-Received: by 2002:a17:90a:740a:b0:286:7f0d:6254 with SMTP id a10-20020a17090a740a00b002867f0d6254mr6006468pjg.63.1704232902374;
        Tue, 02 Jan 2024 14:01:42 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id r59-20020a17090a43c100b0028ce507cd7dsm101724pjg.55.2024.01.02.14.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:01:42 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 05/12] riscv: mm: Combine the SMP and UP TLB flush code
Date: Tue,  2 Jan 2024 14:00:42 -0800
Message-ID: <20240102220134.3229156-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240102220134.3229156-1-samuel.holland@sifive.com>
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In SMP configurations, all TLB flushing narrower than flush_tlb_all()
goes through __flush_tlb_range(). Do the same in UP configurations.

This allows UP configurations to take advantage of recent improvements
to the code in tlbflush.c, such as support for huge pages and flushing
multiple-page ranges.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - Merge the two copies of __flush_tlb_range() and rely on the compiler
   to optimize out the broadcast path (both clang and gcc do this)
 - Merge the two copies of flush_tlb_all() and rely on constant folding

Changes in v2:
 - Move the SMP/UP merge earlier in the series to avoid build issues
 - Make a copy of __flush_tlb_range() instead of adding ifdefs inside
 - local_flush_tlb_all() is the only function used on !MMU (smpboot.c)

 arch/riscv/include/asm/tlbflush.h | 29 +++--------------------------
 arch/riscv/mm/Makefile            |  5 +----
 2 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 8f3418c5f172..7712ffe2f6c4 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -27,12 +27,7 @@ static inline void local_flush_tlb_page(unsigned long addr)
 {
 	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
 }
-#else /* CONFIG_MMU */
-#define local_flush_tlb_all()			do { } while (0)
-#define local_flush_tlb_page(addr)		do { } while (0)
-#endif /* CONFIG_MMU */
 
-#if defined(CONFIG_SMP) && defined(CONFIG_MMU)
 void flush_tlb_all(void);
 void flush_tlb_mm(struct mm_struct *mm);
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
@@ -46,26 +41,8 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end);
 #endif
-#else /* CONFIG_SMP && CONFIG_MMU */
-
-#define flush_tlb_all() local_flush_tlb_all()
-#define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
-
-static inline void flush_tlb_range(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end)
-{
-	local_flush_tlb_all();
-}
-
-/* Flush a range of kernel pages */
-static inline void flush_tlb_kernel_range(unsigned long start,
-	unsigned long end)
-{
-	local_flush_tlb_all();
-}
-
-#define flush_tlb_mm(mm) flush_tlb_all()
-#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
-#endif /* !CONFIG_SMP || !CONFIG_MMU */
+#else /* CONFIG_MMU */
+#define local_flush_tlb_all()			do { } while (0)
+#endif /* CONFIG_MMU */
 
 #endif /* _ASM_RISCV_TLBFLUSH_H */
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 3a4dfc8babcf..96e65c571ce8 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -13,15 +13,12 @@ endif
 KCOV_INSTRUMENT_init.o := n
 
 obj-y += init.o
-obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o
+obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o tlbflush.o
 obj-y += cacheflush.o
 obj-y += context.o
 obj-y += pgtable.o
 obj-y += pmem.o
 
-ifeq ($(CONFIG_MMU),y)
-obj-$(CONFIG_SMP) += tlbflush.o
-endif
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_KASAN)   += kasan_init.o
-- 
2.42.0


