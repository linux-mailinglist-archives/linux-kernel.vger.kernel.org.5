Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926907BB442
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjJFJbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJFJbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:31:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E171AB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:31:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-406650da82bso17043055e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 02:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696584694; x=1697189494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XW7A9oA+n1MGMkCXJe0m6VYvf+I2ZYEJ+oZKrMZZsA=;
        b=WyxvxenNlFhzA3GrJQyBefUT9frnkF5S3UE2uN/9yBDsoIAvnBJRNAtlY6K1LPHVoF
         x4+SRvsKl/rRAqniTrnkuOe+B3Rmygylk27sQ6l4K5wT8RopPFWrZFYozS8K73o+RXth
         vBdWI8l7JciXKap9yeYcSCQ/CPMpmK/qhhRkV1Pey0tDF4WDFLE0AK4zfsGOGlUVpMip
         Y0Y3/oaHfMPkF5+uol9ZEKN4y23AQZlpH2yjSP7Jmehyks8K6SNhcd8p0N5Gh89p7x8G
         j99N9PHJfamYg1xYmai8d2vBZdQ1Lz4yJDc7gpuhgqJ3SxjrKRImth1LdauPDbBsvgKH
         jHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696584694; x=1697189494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XW7A9oA+n1MGMkCXJe0m6VYvf+I2ZYEJ+oZKrMZZsA=;
        b=gTzsI3IuB06SqQGgYD6YhsS6DnzExk6eBdA0tE0abK31CL6yvXtl5izjXMiNDibPpM
         MnM2l1sUKyH1yUw8hh8PgbNIGX0cqQXaCH375x9b4gxYMyjS3GWx/gUdCAtC3z/CIEAB
         biHsnh6pHijI///+hKDvhEDFowG8tJ6ZAlxv7veY7fun72nDMnjZJfWVRzHnr+hhGxiH
         KWzfk3P78dIjCknSAVcv16KpZKXH5fOphXCBfCJD5bJ/CPkbLKpzc2XRlz6x1EXMJnJ6
         2avZcC6+Ofr6+ovigjIIrQxlby3/ZIlFL5iyz9NUCeDzmwuH2FTbGDIrJJFF9zFjvgAS
         j9MA==
X-Gm-Message-State: AOJu0YwhwkEXBbOf1Ih5+3kyNYNvoWHVtKRm8lIOdwT+e2poPS9sS7ZB
        d6rpfIxaYsiQtsNYWnY8mTsI4g==
X-Google-Smtp-Source: AGHT+IECOh4aKcdWw6Ubv05K2Tj1mMWcWsL9IQfL+dVU9Bq5vQnOIGUvAoDnGQUyvbm42cKDz2UJFg==
X-Received: by 2002:a05:600c:2a4e:b0:405:49aa:d578 with SMTP id x14-20020a05600c2a4e00b0040549aad578mr7123254wme.37.1696584694531;
        Fri, 06 Oct 2023 02:31:34 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id e14-20020adffd0e000000b00315af025098sm1227483wrr.46.2023.10.06.02.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:31:34 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 2/2] riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge linear mappings
Date:   Fri,  6 Oct 2023 11:29:30 +0200
Message-Id: <20231006092930.15850-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231006092930.15850-1-alexghiti@rivosinc.com>
References: <20231006092930.15850-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When STRICT_KERNEL_RWX is set, any change of permissions on any kernel
mapping (vmalloc/modules/kernel text...etc) should be applied on its
linear mapping alias. The problem is that the riscv kernel uses huge
mappings for the linear mapping and walk_page_range_novma() does not
split those huge mappings.

So this patchset implements such split in order to apply fine-grained
permissions on the linear mapping.

Below is the difference before and after (the first PUD mapping is split
into PTE/PMD mappings):

Before:

---[ Linear mapping ]---
0xffffaf8000080000-0xffffaf8000200000    0x0000000080080000      1536K PTE     D A G . . W R V
0xffffaf8000200000-0xffffaf8077c00000    0x0000000080200000      1914M PMD     D A G . . W R V
0xffffaf8077c00000-0xffffaf8078800000    0x00000000f7c00000        12M PMD     D A G . . . R V
0xffffaf8078800000-0xffffaf8078c00000    0x00000000f8800000         4M PMD     D A G . . W R V
0xffffaf8078c00000-0xffffaf8079200000    0x00000000f8c00000         6M PMD     D A G . . . R V
0xffffaf8079200000-0xffffaf807e600000    0x00000000f9200000        84M PMD     D A G . . W R V
0xffffaf807e600000-0xffffaf807e716000    0x00000000fe600000      1112K PTE     D A G . . W R V
0xffffaf807e717000-0xffffaf807e71a000    0x00000000fe717000        12K PTE     D A G . . W R V
0xffffaf807e71d000-0xffffaf807e71e000    0x00000000fe71d000         4K PTE     D A G . . W R V
0xffffaf807e722000-0xffffaf807e800000    0x00000000fe722000       888K PTE     D A G . . W R V
0xffffaf807e800000-0xffffaf807fe00000    0x00000000fe800000        22M PMD     D A G . . W R V
0xffffaf807fe00000-0xffffaf807ff54000    0x00000000ffe00000      1360K PTE     D A G . . W R V
0xffffaf807ff55000-0xffffaf8080000000    0x00000000fff55000       684K PTE     D A G . . W R V
0xffffaf8080000000-0xffffaf8400000000    0x0000000100000000        14G PUD     D A G . . W R V

After:

---[ Linear mapping ]---
0xffffaf8000080000-0xffffaf8000200000    0x0000000080080000      1536K PTE     D A G . . W R V
0xffffaf8000200000-0xffffaf8077c00000    0x0000000080200000      1914M PMD     D A G . . W R V
0xffffaf8077c00000-0xffffaf8078800000    0x00000000f7c00000        12M PMD     D A G . . . R V
0xffffaf8078800000-0xffffaf8078a00000    0x00000000f8800000         2M PMD     D A G . . W R V
0xffffaf8078a00000-0xffffaf8078c00000    0x00000000f8a00000         2M PTE     D A G . . W R V
0xffffaf8078c00000-0xffffaf8079200000    0x00000000f8c00000         6M PMD     D A G . . . R V
0xffffaf8079200000-0xffffaf807e600000    0x00000000f9200000        84M PMD     D A G . . W R V
0xffffaf807e600000-0xffffaf807e716000    0x00000000fe600000      1112K PTE     D A G . . W R V
0xffffaf807e717000-0xffffaf807e71a000    0x00000000fe717000        12K PTE     D A G . . W R V
0xffffaf807e71d000-0xffffaf807e71e000    0x00000000fe71d000         4K PTE     D A G . . W R V
0xffffaf807e722000-0xffffaf807e800000    0x00000000fe722000       888K PTE     D A G . . W R V
0xffffaf807e800000-0xffffaf807fe00000    0x00000000fe800000        22M PMD     D A G . . W R V
0xffffaf807fe00000-0xffffaf807ff54000    0x00000000ffe00000      1360K PTE     D A G . . W R V
0xffffaf807ff55000-0xffffaf8080000000    0x00000000fff55000       684K PTE     D A G . . W R V
0xffffaf8080000000-0xffffaf8080800000    0x0000000100000000         8M PMD     D A G . . W R V
0xffffaf8080800000-0xffffaf8080af6000    0x0000000100800000      3032K PTE     D A G . . W R V
0xffffaf8080af6000-0xffffaf8080af8000    0x0000000100af6000         8K PTE     D A G . X . R V
0xffffaf8080af8000-0xffffaf8080c00000    0x0000000100af8000      1056K PTE     D A G . . W R V
0xffffaf8080c00000-0xffffaf8081a00000    0x0000000100c00000        14M PMD     D A G . . W R V
0xffffaf8081a00000-0xffffaf8081a40000    0x0000000101a00000       256K PTE     D A G . . W R V
0xffffaf8081a40000-0xffffaf8081a44000    0x0000000101a40000        16K PTE     D A G . X . R V
0xffffaf8081a44000-0xffffaf8081a52000    0x0000000101a44000        56K PTE     D A G . . W R V
0xffffaf8081a52000-0xffffaf8081a54000    0x0000000101a52000         8K PTE     D A G . X . R V
...
0xffffaf809e800000-0xffffaf80c0000000    0x000000011e800000       536M PMD     D A G . . W R V
0xffffaf80c0000000-0xffffaf8400000000    0x0000000140000000        13G PUD     D A G . . W R V

Note that this also fixes memfd_secret() syscall which uses
set_direct_map_invalid_noflush() and set_direct_map_default_noflush() to
remove the pages from the linear mapping. Below is the kernel page table
while a memfd_secret() syscall is running, you can see all the !valid
page table entries in the linear mapping:

...
0xffffaf8082240000-0xffffaf8082241000    0x0000000102240000         4K PTE     D A G . . W R .
0xffffaf8082241000-0xffffaf8082250000    0x0000000102241000        60K PTE     D A G . . W R V
0xffffaf8082250000-0xffffaf8082252000    0x0000000102250000         8K PTE     D A G . . W R .
0xffffaf8082252000-0xffffaf8082256000    0x0000000102252000        16K PTE     D A G . . W R V
0xffffaf8082256000-0xffffaf8082257000    0x0000000102256000         4K PTE     D A G . . W R .
0xffffaf8082257000-0xffffaf8082258000    0x0000000102257000         4K PTE     D A G . . W R V
0xffffaf8082258000-0xffffaf8082259000    0x0000000102258000         4K PTE     D A G . . W R .
0xffffaf8082259000-0xffffaf808225a000    0x0000000102259000         4K PTE     D A G . . W R V
0xffffaf808225a000-0xffffaf808225c000    0x000000010225a000         8K PTE     D A G . . W R .
0xffffaf808225c000-0xffffaf8082266000    0x000000010225c000        40K PTE     D A G . . W R V
0xffffaf8082266000-0xffffaf8082268000    0x0000000102266000         8K PTE     D A G . . W R .
0xffffaf8082268000-0xffffaf8082284000    0x0000000102268000       112K PTE     D A G . . W R V
0xffffaf8082284000-0xffffaf8082288000    0x0000000102284000        16K PTE     D A G . . W R .
0xffffaf8082288000-0xffffaf808229c000    0x0000000102288000        80K PTE     D A G . . W R V
0xffffaf808229c000-0xffffaf80822a0000    0x000000010229c000        16K PTE     D A G . . W R .
0xffffaf80822a0000-0xffffaf80822a5000    0x00000001022a0000        20K PTE     D A G . . W R V
0xffffaf80822a5000-0xffffaf80822a6000    0x00000001022a5000         4K PTE     D A G . . . R V
0xffffaf80822a6000-0xffffaf80822ab000    0x00000001022a6000        20K PTE     D A G . . W R V
...

And when the memfd_secret() fd is released, the linear mapping is
correctly reset:

...
0xffffaf8082240000-0xffffaf80822a5000    0x0000000102240000       404K PTE     D A G . . W R V
0xffffaf80822a5000-0xffffaf80822a6000    0x00000001022a5000         4K PTE     D A G . . . R V
0xffffaf80822a6000-0xffffaf80822af000    0x00000001022a6000        36K PTE     D A G . . W R V
...

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/pageattr.c | 263 ++++++++++++++++++++++++++++++++-------
 1 file changed, 221 insertions(+), 42 deletions(-)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 161d0b34c2cb..743b30633d5c 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -5,6 +5,7 @@
 
 #include <linux/pagewalk.h>
 #include <linux/pgtable.h>
+#include <linux/vmalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/bitops.h>
 #include <asm/set_memory.h>
@@ -25,19 +26,6 @@ static unsigned long set_pageattr_masks(unsigned long val, struct mm_walk *walk)
 	return new_val;
 }
 
-static int pageattr_pgd_entry(pgd_t *pgd, unsigned long addr,
-			      unsigned long next, struct mm_walk *walk)
-{
-	pgd_t val = READ_ONCE(*pgd);
-
-	if (pgd_leaf(val)) {
-		val = __pgd(set_pageattr_masks(pgd_val(val), walk));
-		set_pgd(pgd, val);
-	}
-
-	return 0;
-}
-
 static int pageattr_p4d_entry(p4d_t *p4d, unsigned long addr,
 			      unsigned long next, struct mm_walk *walk)
 {
@@ -96,7 +84,6 @@ static int pageattr_pte_hole(unsigned long addr, unsigned long next,
 }
 
 static const struct mm_walk_ops pageattr_ops = {
-	.pgd_entry = pageattr_pgd_entry,
 	.p4d_entry = pageattr_p4d_entry,
 	.pud_entry = pageattr_pud_entry,
 	.pmd_entry = pageattr_pmd_entry,
@@ -105,12 +92,179 @@ static const struct mm_walk_ops pageattr_ops = {
 	.walk_lock = PGWALK_RDLOCK,
 };
 
+static int __split_linear_mapping_pmd(pud_t *pudp,
+				      unsigned long vaddr, unsigned long end)
+{
+	pmd_t *pmdp;
+	unsigned long next;
+
+	pmdp = pmd_offset(pudp, vaddr);
+
+	do {
+		next = pmd_addr_end(vaddr, end);
+
+		if (next - vaddr >= PMD_SIZE &&
+		    vaddr <= (vaddr & PMD_MASK) && end >= next)
+			continue;
+
+		if (pmd_leaf(*pmdp)) {
+			struct page *pte_page;
+			unsigned long pfn = _pmd_pfn(*pmdp);
+			pgprot_t prot = __pgprot(pmd_val(*pmdp) & ~_PAGE_PFN_MASK);
+			pte_t *ptep_new;
+			int i;
+
+			pte_page = alloc_page(GFP_KERNEL);
+			if (!pte_page)
+				return -ENOMEM;
+
+			ptep_new = (pte_t *)page_address(pte_page);
+			for (i = 0; i < PTRS_PER_PTE; ++i, ++ptep_new)
+				set_pte(ptep_new, pfn_pte(pfn + i, prot));
+
+			smp_wmb();
+
+			set_pmd(pmdp, pfn_pmd(page_to_pfn(pte_page), PAGE_TABLE));
+		}
+	} while (pmdp++, vaddr = next, vaddr != end);
+
+	return 0;
+}
+
+static int __split_linear_mapping_pud(p4d_t *p4dp,
+				      unsigned long vaddr, unsigned long end)
+{
+	pud_t *pudp;
+	unsigned long next;
+	int ret;
+
+	pudp = pud_offset(p4dp, vaddr);
+
+	do {
+		next = pud_addr_end(vaddr, end);
+
+		if (next - vaddr >= PUD_SIZE &&
+		    vaddr <= (vaddr & PUD_MASK) && end >= next)
+			continue;
+
+		if (pud_leaf(*pudp)) {
+			struct page *pmd_page;
+			unsigned long pfn = _pud_pfn(*pudp);
+			pgprot_t prot = __pgprot(pud_val(*pudp) & ~_PAGE_PFN_MASK);
+			pmd_t *pmdp_new;
+			int i;
+
+			pmd_page = alloc_page(GFP_KERNEL);
+			if (!pmd_page)
+				return -ENOMEM;
+
+			pmdp_new = (pmd_t *)page_address(pmd_page);
+			for (i = 0; i < PTRS_PER_PMD; ++i, ++pmdp_new)
+				set_pmd(pmdp_new,
+					pfn_pmd(pfn + ((i * PMD_SIZE) >> PAGE_SHIFT), prot));
+
+			smp_wmb();
+
+			set_pud(pudp, pfn_pud(page_to_pfn(pmd_page), PAGE_TABLE));
+		}
+
+		ret = __split_linear_mapping_pmd(pudp, vaddr, next);
+		if (ret)
+			return ret;
+	} while (pudp++, vaddr = next, vaddr != end);
+
+	return 0;
+}
+
+static int __split_linear_mapping_p4d(pgd_t *pgdp,
+				      unsigned long vaddr, unsigned long end)
+{
+	p4d_t *p4dp;
+	unsigned long next;
+	int ret;
+
+	p4dp = p4d_offset(pgdp, vaddr);
+
+	do {
+		next = p4d_addr_end(vaddr, end);
+
+		/*
+		 * If [vaddr; end] contains [vaddr & P4D_MASK; next], we don't
+		 * need to split, we'll change the protections on the whole P4D.
+		 */
+		if (next - vaddr >= P4D_SIZE &&
+		    vaddr <= (vaddr & P4D_MASK) && end >= next)
+			continue;
+
+		if (p4d_leaf(*p4dp)) {
+			struct page *pud_page;
+			unsigned long pfn = _p4d_pfn(*p4dp);
+			pgprot_t prot = __pgprot(p4d_val(*p4dp) & ~_PAGE_PFN_MASK);
+			pud_t *pudp_new;
+			int i;
+
+			pud_page = alloc_page(GFP_KERNEL);
+			if (!pud_page)
+				return -ENOMEM;
+
+			/*
+			 * Fill the pud level with leaf puds that have the same
+			 * protections as the leaf p4d.
+			 */
+			pudp_new = (pud_t *)page_address(pud_page);
+			for (i = 0; i < PTRS_PER_PUD; ++i, ++pudp_new)
+				set_pud(pudp_new,
+					pfn_pud(pfn + ((i * PUD_SIZE) >> PAGE_SHIFT), prot));
+
+			/*
+			 * Make sure the pud filling is not reordered with the
+			 * p4d store which could result in seeing a partially
+			 * filled pud level.
+			 */
+			smp_wmb();
+
+			set_p4d(p4dp, pfn_p4d(page_to_pfn(pud_page), PAGE_TABLE));
+		}
+
+		ret = __split_linear_mapping_pud(p4dp, vaddr, next);
+		if (ret)
+			return ret;
+	} while (p4dp++, vaddr = next, vaddr != end);
+
+	return 0;
+}
+
+static int __split_linear_mapping_pgd(pgd_t *pgdp,
+				      unsigned long vaddr,
+				      unsigned long end)
+{
+	unsigned long next;
+	int ret;
+
+	do {
+		next = pgd_addr_end(vaddr, end);
+		/* We never use PGD mappings for the linear mapping */
+		ret = __split_linear_mapping_p4d(pgdp, vaddr, next);
+		if (ret)
+			return ret;
+	} while (pgdp++, vaddr = next, vaddr != end);
+
+	return 0;
+}
+
+static int split_linear_mapping(unsigned long start, unsigned long end)
+{
+	return __split_linear_mapping_pgd(pgd_offset_k(start), start, end);
+}
+
 static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 			pgprot_t clear_mask)
 {
 	int ret;
 	unsigned long start = addr;
 	unsigned long end = start + PAGE_SIZE * numpages;
+	unsigned long lm_start;
+	unsigned long lm_end;
 	struct pageattr_masks masks = {
 		.set_mask = set_mask,
 		.clear_mask = clear_mask
@@ -120,11 +274,58 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 		return 0;
 
 	mmap_write_lock(&init_mm);
+
+	/*
+	 * We are about to change the permissions of a kernel mapping, we must
+	 * apply the same changes to its linear mapping alias, which may imply
+	 * splitting a huge mapping.
+	 */
+
+	if (is_vmalloc_or_module_addr((void *)start)) {
+		struct vm_struct *area = NULL;
+		int i, page_start;
+
+		area = find_vm_area((void *)start);
+		page_start = (start - (unsigned long)area->addr) >> PAGE_SHIFT;
+
+		for (i = page_start; i < page_start + numpages; ++i) {
+			lm_start = (unsigned long)page_address(area->pages[i]);
+			lm_end = lm_start + PAGE_SIZE;
+
+			ret = split_linear_mapping(lm_start, lm_end);
+			if (ret)
+				goto unlock;
+
+			ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
+						    &pageattr_ops, NULL, &masks);
+			if (ret)
+				goto unlock;
+		}
+	} else if (is_kernel_mapping(start) || is_linear_mapping(start)) {
+		lm_start = (unsigned long)lm_alias(start);
+		lm_end = (unsigned long)lm_alias(end);
+
+		ret = split_linear_mapping(lm_start, lm_end);
+		if (ret)
+			goto unlock;
+
+		ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
+					    &pageattr_ops, NULL, &masks);
+		if (ret)
+			goto unlock;
+	}
+
 	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
 				     &masks);
-	mmap_write_unlock(&init_mm);
 
-	flush_tlb_kernel_range(start, end);
+unlock:
+	/*
+	 * We can't use flush_tlb_kernel_range() here as we may have split a
+	 * hugepage that is larger than that, so let's flush everything.
+	 */
+	flush_tlb_all();
+
+	mmap_write_unlock(&init_mm);
 
 	return ret;
 }
@@ -159,36 +360,14 @@ int set_memory_nx(unsigned long addr, int numpages)
 
 int set_direct_map_invalid_noflush(struct page *page)
 {
-	int ret;
-	unsigned long start = (unsigned long)page_address(page);
-	unsigned long end = start + PAGE_SIZE;
-	struct pageattr_masks masks = {
-		.set_mask = __pgprot(0),
-		.clear_mask = __pgprot(_PAGE_PRESENT)
-	};
-
-	mmap_read_lock(&init_mm);
-	ret = walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
-	mmap_read_unlock(&init_mm);
-
-	return ret;
+	return __set_memory((unsigned long)page_address(page), 1,
+			    __pgprot(0), __pgprot(_PAGE_PRESENT));
 }
 
 int set_direct_map_default_noflush(struct page *page)
 {
-	int ret;
-	unsigned long start = (unsigned long)page_address(page);
-	unsigned long end = start + PAGE_SIZE;
-	struct pageattr_masks masks = {
-		.set_mask = PAGE_KERNEL,
-		.clear_mask = __pgprot(0)
-	};
-
-	mmap_read_lock(&init_mm);
-	ret = walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
-	mmap_read_unlock(&init_mm);
-
-	return ret;
+	return __set_memory((unsigned long)page_address(page), 1,
+			    PAGE_KERNEL, __pgprot(0));
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-- 
2.39.2

