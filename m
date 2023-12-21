Return-Path: <linux-kernel+bounces-7800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E38981AD2B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D842839A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039F66103;
	Thu, 21 Dec 2023 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XlGhKX2P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A703F441E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7811db57cb4so17310185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 19:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703128759; x=1703733559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHVoW/MSujJv5NIsFUvfttxthtWbl9YXxYuPhvKhYN4=;
        b=XlGhKX2PWrEJ++A1pSj7qSrm/6i0Jn7zizpA0YrA9m5flSBQegMw5PnfY2BWZbPc2B
         SGfLt6zBDF5Cmq05Yw1M7Zjb6/aH0paSup88doMLh+02cRNn/03IiYPzwNkzKGC26HyS
         vFLpz4SPXD4R9pOrnN39Vz2CQLT8RogCUo+V6mx1P8sBipmSz+ecXk2Oi8j7ASRxo+FZ
         pe3bvw/IhA3iupiQnn3WNZaeLyRqY7NIceDVEriaQruuo8m5dURcZk8kucVM3WD2Ob0m
         MIH6WvxjEefRB7SMjrvNKllmwPtTWfNP2JYkcYDXi131n7WRU9bdy6Ea56Bnq9RH/PZZ
         UgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703128759; x=1703733559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHVoW/MSujJv5NIsFUvfttxthtWbl9YXxYuPhvKhYN4=;
        b=w/YudEIDUXGJOfQ6sKL4sL334L0eKu1+Q9GpdKC6uj3TFfSbShg+KjzIc2yD6nvdTt
         bL52WSW53JFW0CDLlHhpGJNj9ywOdZNfR03UFKIRj9VB88WM/d4SC7F9GR7Oqa3DkVrR
         4GB+aiBcueZVB2A2CV3/0TTziHfnoVPsIkXXB64igFDQnSLh4bFs/T/7/rzMGbLNxMGg
         vq7vYY9mRUV1dgV/yYtSuRGmPRlnKvsWbh6xKpfAbJ3Rys9A9nvwCaP0b30skc+/3IoN
         Ni1d1cQOjEqwscpnZue8mD9Ee3Lz9obRLdfwCSa7gqIsHm2GkfE8rcuFP/6GG7Q4plJz
         JroQ==
X-Gm-Message-State: AOJu0YynB/XNEUYReNKbXrF39NYpq+F9Nt/ZmFrtpBOQAMs+nknzC8xp
	hgPzdgkdABNCe2lPEVIzfEUr1Q==
X-Google-Smtp-Source: AGHT+IHY+sU7XqrPzSe1RhsjN9sLabzyaNEAd3hCwu8MQn6FSl4jaGvTX3sXjbffBRHiVyH9teDPwg==
X-Received: by 2002:a05:620a:461f:b0:781:97:fbc4 with SMTP id br31-20020a05620a461f00b007810097fbc4mr67467qkb.25.1703128759521;
        Wed, 20 Dec 2023 19:19:19 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a221200b0077d85695db4sm371893qkh.99.2023.12.20.19.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:19:18 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org,
	rientjes@google.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev
Subject: [RFC 1/3] iommu/intel: Use page->refcount to count number of entries in IOMMU
Date: Thu, 21 Dec 2023 03:19:13 +0000
Message-ID: <20231221031915.619337-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231221031915.619337-1-pasha.tatashin@soleen.com>
References: <20231221031915.619337-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to be able to efficiently free empty page table levels, count the
number of entries in each page table my incremeanting and decremeanting
refcount every time a PTE is inserted or removed form the page table.

For this to work correctly, add two helper function:
dma_clear_pte and dma_set_pte where counting is performed,

Also, modify the code so every page table entry is always updated using the
two new functions.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/intel/iommu.c | 40 +++++++++++++++++++++---------------
 drivers/iommu/intel/iommu.h | 41 +++++++++++++++++++++++++++++++------
 2 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 897159dba47d..4688ef797161 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -949,7 +949,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			if (domain->use_first_level)
 				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
 
-			if (cmpxchg64(&pte->val, 0ULL, pteval))
+			if (dma_set_pte(pte, pteval))
 				/* Someone else set it while we were thinking; use theirs. */
 				free_pgtable_page(tmp_page);
 			else
@@ -1021,7 +1021,8 @@ static void dma_pte_clear_range(struct dmar_domain *domain,
 			continue;
 		}
 		do {
-			dma_clear_pte(pte);
+			if (dma_pte_present(pte))
+				dma_clear_pte(pte);
 			start_pfn += lvl_to_nr_pages(large_page);
 			pte++;
 		} while (start_pfn <= last_pfn && !first_pte_in_page(pte));
@@ -1062,7 +1063,8 @@ static void dma_pte_free_level(struct dmar_domain *domain, int level,
 		 */
 		if (level < retain_level && !(start_pfn > level_pfn ||
 		      last_pfn < level_pfn + level_size(level) - 1)) {
-			dma_clear_pte(pte);
+			if (dma_pte_present(pte))
+				dma_clear_pte(pte);
 			domain_flush_cache(domain, pte, sizeof(*pte));
 			free_pgtable_page(level_pte);
 		}
@@ -1093,12 +1095,13 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
 	}
 }
 
-/* When a page at a given level is being unlinked from its parent, we don't
-   need to *modify* it at all. All we need to do is make a list of all the
-   pages which can be freed just as soon as we've flushed the IOTLB and we
-   know the hardware page-walk will no longer touch them.
-   The 'pte' argument is the *parent* PTE, pointing to the page that is to
-   be freed. */
+/*
+ * A given page at a given level is being unlinked from its parent.
+ * We need to make a list of all the pages which can be freed just as soon as
+ * we've flushed the IOTLB and we know the hardware page-walk will no longer
+ * touch them. The 'pte' argument is the *parent* PTE, pointing to the page
+ * that is to be freed.
+ */
 static void dma_pte_list_pagetables(struct dmar_domain *domain,
 				    int level, struct dma_pte *pte,
 				    struct list_head *freelist)
@@ -1106,17 +1109,20 @@ static void dma_pte_list_pagetables(struct dmar_domain *domain,
 	struct page *pg;
 
 	pg = pfn_to_page(dma_pte_addr(pte) >> PAGE_SHIFT);
-	list_add_tail(&pg->lru, freelist);
-
-	if (level == 1)
-		return;
-
 	pte = page_address(pg);
+
 	do {
-		if (dma_pte_present(pte) && !dma_pte_superpage(pte))
-			dma_pte_list_pagetables(domain, level - 1, pte, freelist);
+		if (dma_pte_present(pte)) {
+			if (level > 1 && !dma_pte_superpage(pte)) {
+				dma_pte_list_pagetables(domain, level - 1, pte,
+							freelist);
+			}
+			dma_clear_pte(pte);
+		}
 		pte++;
 	} while (!first_pte_in_page(pte));
+
+	list_add_tail(&pg->lru, freelist);
 }
 
 static void dma_pte_clear_level(struct dmar_domain *domain, int level,
@@ -2244,7 +2250,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		/* We don't need lock here, nobody else
 		 * touches the iova range
 		 */
-		tmp = cmpxchg64_local(&pte->val, 0ULL, pteval);
+		tmp = dma_set_pte(pte, pteval);
 		if (tmp) {
 			static int dumps = 5;
 			pr_crit("ERROR: DMA PTE for vPFN 0x%lx already set (to %llx not %llx)\n",
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ce030c5b5772..f1ea508f45bd 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -802,11 +802,6 @@ struct dma_pte {
 	u64 val;
 };
 
-static inline void dma_clear_pte(struct dma_pte *pte)
-{
-	pte->val = 0;
-}
-
 static inline u64 dma_pte_addr(struct dma_pte *pte)
 {
 #ifdef CONFIG_64BIT
@@ -818,9 +813,43 @@ static inline u64 dma_pte_addr(struct dma_pte *pte)
 #endif
 }
 
+#define DMA_PTEVAL_PRESENT(pteval) (((pteval) & 3) != 0)
 static inline bool dma_pte_present(struct dma_pte *pte)
 {
-	return (pte->val & 3) != 0;
+	return DMA_PTEVAL_PRESENT(pte->val);
+}
+
+static inline void dma_clear_pte(struct dma_pte *pte)
+{
+	u64 old_pteval;
+
+	old_pteval = xchg(&pte->val, 0ULL);
+	if (DMA_PTEVAL_PRESENT(old_pteval)) {
+		struct page *pg = virt_to_page(pte);
+		int rc = page_ref_dec_return(pg);
+
+		WARN_ON_ONCE(rc > 512 || rc < 1);
+	} else {
+		/* Ensure that we cleared a valid entry from the page table */
+		WARN_ON(1);
+	}
+}
+
+static inline u64 dma_set_pte(struct dma_pte *pte, u64 pteval)
+{
+	u64 old_pteval;
+
+	/* Ensure we about to set a valid entry to the page table */
+	WARN_ON(!DMA_PTEVAL_PRESENT(pteval));
+	old_pteval = cmpxchg64(&pte->val, 0ULL, pteval);
+	if (old_pteval == 0) {
+		struct page *pg = virt_to_page(pte);
+		int rc = page_ref_inc_return(pg);
+
+		WARN_ON_ONCE(rc > 513 || rc < 2);
+	}
+
+	return old_pteval;
 }
 
 static inline bool dma_sl_pte_test_and_clear_dirty(struct dma_pte *pte,
-- 
2.43.0.472.g3155946c3a-goog


