Return-Path: <linux-kernel+bounces-7802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D624481AD2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B560B24E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55016AD59;
	Thu, 21 Dec 2023 03:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="U/kdJhYI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C345248
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-77f9c7d35deso16039885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 19:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703128761; x=1703733561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AmuHXuEhInFkqtbi2Boe13e6hcYidcEU++H5mZtuKg=;
        b=U/kdJhYITr3gShRYsJi6KSCuHG02j1yWuwc0YFoNUeHiUY8/j958BDLfMlFVo1Mht6
         FUGKfMLp2kBe+Cop/xfaulyo3hD12/cGfgp50Hv0qb0afKZReaCozXAPWrehQnsNzlcr
         Neol11iCbllbYAOWpF/j6diMnG7VWYABff+K1AHpoLet+J9ZRx35aRs1lmtGcvgFOnuL
         WNmloJHygmzi0fjaAf1tvWY78YLrNIvwGwb6dL89ucCyqoM1HogNQjUuEc+pMduoszne
         24aa+BtF/vgQnQMws0JWt5eLtRbo+YyVaoOSziSVO3skyBfmafCn2qWaic1kLKH8zJeL
         TxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703128761; x=1703733561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AmuHXuEhInFkqtbi2Boe13e6hcYidcEU++H5mZtuKg=;
        b=ejM5t9jipeE4IN8ZHzNE6wfcK5h7W4xjYKH2/N1EcDj7Hp52LXMY2McEKhz1CdViJp
         ncefpnhNtIf3IEADlIGuLsflgZDquEM9ddAvsE30q/8hN2oRXvuB6szXeJE+wdLQZnCL
         CSsoxeAYmpYjKVwznLvS+XNvTqmu/+1aXxfpn/SX2gUJjzdf+6UukrI4p43GLoy9POmS
         8gun2pp/R36jwlHbOFoGIOHZhBKOf4I1hgd3rvl+Foss2QtFRvkQXpMMfhr//FwCTCXX
         6BInJZ0+QcgsxCwnWR9a8t/80gBEwEIND8zu0ca4JOi0qLDRH2uGkuCZqW0L0qD7Vagk
         IcbA==
X-Gm-Message-State: AOJu0Yw7+2yZGjwP2vlunag6u93GBZv/S1LAYdeo4nRgSSI4Iep3PNZO
	+2bZ0jZBFb91s90rmhulZ/+L8w==
X-Google-Smtp-Source: AGHT+IHF5zSXhAGcOI9AIkZshfFia5huQM56CGqHZFlyV5V3eI/TVjPw6Y6m+SE7x4iKtWD/m0z+kg==
X-Received: by 2002:a05:620a:4891:b0:774:cf9:b206 with SMTP id ea17-20020a05620a489100b007740cf9b206mr19223447qkb.42.1703128761561;
        Wed, 20 Dec 2023 19:19:21 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a221200b0077d85695db4sm371893qkh.99.2023.12.20.19.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:19:21 -0800 (PST)
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
Subject: [RFC 3/3] iommu/intel: free empty page tables on unmaps
Date: Thu, 21 Dec 2023 03:19:15 +0000
Message-ID: <20231221031915.619337-4-pasha.tatashin@soleen.com>
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

When page tables become empty, add them to the freelist so that they
can also be freed.

This is means that a page tables that are outside of the imediat iova
range might be freed as well, therefore, only in the case where such
page tables are going to be freed, we take the writer lock.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/intel/iommu.c | 92 +++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 733f25b277a3..141dc106fb01 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1130,7 +1130,7 @@ static void dma_pte_list_pagetables(struct dmar_domain *domain,
 static void dma_pte_clear_level(struct dmar_domain *domain, int level,
 				struct dma_pte *pte, unsigned long pfn,
 				unsigned long start_pfn, unsigned long last_pfn,
-				struct list_head *freelist)
+				struct list_head *freelist, int *freed_level)
 {
 	struct dma_pte *first_pte = NULL, *last_pte = NULL;
 
@@ -1156,11 +1156,48 @@ static void dma_pte_clear_level(struct dmar_domain *domain, int level,
 				first_pte = pte;
 			last_pte = pte;
 		} else if (level > 1) {
+			struct dma_pte *npte = phys_to_virt(dma_pte_addr(pte));
+			struct page *npage = virt_to_page(npte);
+
 			/* Recurse down into a level that isn't *entirely* obsolete */
-			dma_pte_clear_level(domain, level - 1,
-					    phys_to_virt(dma_pte_addr(pte)),
+			dma_pte_clear_level(domain, level - 1, npte,
 					    level_pfn, start_pfn, last_pfn,
-					    freelist);
+					    freelist, freed_level);
+
+			/*
+			 * Free next level page table if it became empty.
+			 *
+			 * We only holding the reader lock, and it is possible
+			 * that other threads are accessing page table as
+			 * readers as well. We can only free page table that
+			 * is outside of the request IOVA space only if
+			 * we grab the writer lock. Since we need to drop reader
+			 * lock, we are incrementing the refcount in the npage
+			 * so it (and the current page table) does not
+			 * dissappear due to concurrent unmapping threads.
+			 *
+			 * Store the size maximum size of the freed page table
+			 * into freed_level, so the size of the IOTLB flush
+			 * can be determined.
+			 */
+			if (freed_level && page_count(npage) == 1) {
+				page_ref_inc(npage);
+				read_unlock(&domain->pgd_lock);
+				write_lock(&domain->pgd_lock);
+				if (page_count(npage) == 2) {
+					dma_clear_pte(pte);
+
+					if (!first_pte)
+						first_pte = pte;
+
+					last_pte = pte;
+					list_add_tail(&npage->lru, freelist);
+					*freed_level = level;
+				}
+				write_unlock(&domain->pgd_lock);
+				read_lock(&domain->pgd_lock);
+				page_ref_dec(npage);
+			}
 		}
 next:
 		pfn = level_pfn + level_size(level);
@@ -1175,7 +1212,8 @@ static void dma_pte_clear_level(struct dmar_domain *domain, int level,
    the page tables, and may have cached the intermediate levels. The
    pages can only be freed after the IOTLB flush has been done. */
 static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
-			 unsigned long last_pfn, struct list_head *freelist)
+			 unsigned long last_pfn, struct list_head *freelist,
+			 int *level)
 {
 	if (WARN_ON(!domain_pfn_supported(domain, last_pfn)) ||
 	    WARN_ON(start_pfn > last_pfn))
@@ -1184,7 +1222,8 @@ static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
 	read_lock(&domain->pgd_lock);
 	/* we don't need lock here; nobody else touches the iova range */
 	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
-			    domain->pgd, 0, start_pfn, last_pfn, freelist);
+			    domain->pgd, 0, start_pfn, last_pfn, freelist,
+			    level);
 	read_unlock(&domain->pgd_lock);
 
 	/* free pgd */
@@ -1524,11 +1563,11 @@ static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
 
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 				  struct dmar_domain *domain,
-				  unsigned long pfn, unsigned int pages,
+				  unsigned long pfn, unsigned long pages,
 				  int ih, int map)
 {
-	unsigned int aligned_pages = __roundup_pow_of_two(pages);
-	unsigned int mask = ilog2(aligned_pages);
+	unsigned long aligned_pages = __roundup_pow_of_two(pages);
+	unsigned long mask = ilog2(aligned_pages);
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
 	u16 did = domain_id_iommu(domain, iommu);
 
@@ -1872,7 +1911,8 @@ static void domain_exit(struct dmar_domain *domain)
 	if (domain->pgd) {
 		LIST_HEAD(freelist);
 
-		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist);
+		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist,
+			     NULL);
 		put_pages_list(&freelist);
 	}
 
@@ -3579,7 +3619,8 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 			struct intel_iommu *iommu;
 			LIST_HEAD(freelist);
 
-			domain_unmap(si_domain, start_vpfn, last_vpfn, &freelist);
+			domain_unmap(si_domain, start_vpfn, last_vpfn,
+				     &freelist, NULL);
 
 			rcu_read_lock();
 			for_each_active_iommu(iommu, drhd)
@@ -4253,6 +4294,7 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 				struct iommu_iotlb_gather *gather)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	bool queued = iommu_iotlb_gather_queued(gather);
 	unsigned long start_pfn, last_pfn;
 	int level = 0;
 
@@ -4272,7 +4314,16 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	start_pfn = iova >> VTD_PAGE_SHIFT;
 	last_pfn = (iova + size - 1) >> VTD_PAGE_SHIFT;
 
-	domain_unmap(dmar_domain, start_pfn, last_pfn, &gather->freelist);
+	/*
+	 * pass level only if !queued, which means we will do iotlb
+	 * flush callback before freeing pages from freelist.
+	 *
+	 * When level is passed domain_unamp will attempt to add empty
+	 * page tables to freelist, and pass the level number of the highest
+	 * page table that was added to the freelist.
+	 */
+	domain_unmap(dmar_domain, start_pfn, last_pfn, &gather->freelist,
+		     queued ? NULL : &level);
 
 	if (dmar_domain->max_addr == iova + size)
 		dmar_domain->max_addr = iova;
@@ -4281,8 +4332,21 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	 * We do not use page-selective IOTLB invalidation in flush queue,
 	 * so there is no need to track page and sync iotlb.
 	 */
-	if (!iommu_iotlb_gather_queued(gather))
-		iommu_iotlb_gather_add_page(domain, gather, iova, size);
+	if (!queued) {
+		size_t sz = size;
+
+		/*
+		 * Increase iova and sz for flushing if level was returned,
+		 * as it means we also are freeing some page tables.
+		 */
+		if (level) {
+			unsigned long pgsize = level_size(level) << VTD_PAGE_SHIFT;
+
+			iova = ALIGN_DOWN(iova, pgsize);
+			sz = ALIGN(size, pgsize);
+		}
+		iommu_iotlb_gather_add_page(domain, gather, iova, sz);
+	}
 
 	return size;
 }
-- 
2.43.0.472.g3155946c3a-goog


