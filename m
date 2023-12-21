Return-Path: <linux-kernel+bounces-7801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB65481AD2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C6F283A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68298F48;
	Thu, 21 Dec 2023 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Fe8eTqkr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB314427
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7811db57cb4so17311085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 19:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703128761; x=1703733561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGmYN/slxAgBeZjp+ZQs88mMzGzd5XnAVtjIWHCDIHA=;
        b=Fe8eTqkrvUEvuHdlfK0989Y56i0ewKkeikgkKm4o3BceLgczzf3dW7OMFgZAbEGMyI
         FIcorCOHFnsGdfMhe/vN1MM9IQbfy+a+AoqOZEiB+8f0G73vnXGGAnIytZE+cA09omcL
         G31AlRomLMgp9EA2gkjSouLunftC4MwflOB0h3SZluP8AybjGKhzWvrDmj9tYyHpKAVi
         kGF/ZrPncicNraJF4HaS8nVLMQu9RFH9pAjs1abtK3Q003P10YFTe5AbLfx289E/Nr1F
         nIbUt9cE6EhfEl0g7ORkBzDokxo3cU7FEnYjx/CHKvyMVvDWy9xEPDMlr2DvaL7HjHTF
         /o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703128761; x=1703733561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGmYN/slxAgBeZjp+ZQs88mMzGzd5XnAVtjIWHCDIHA=;
        b=o7TdSTjMoBPfvMJ7AZzjc8wB9jLSw7CGg9VDbBZ2i8y/9jnMXz+6uBYedmQ1B7or1q
         l9lgFtzLRbmea1NvN4O5i33aci8Ip0bMMVnfNqc59XZKoqP680zkZQuwvnuODW8WLhZX
         jPjO+yj6bTrs1kmbZbNdIFjENLUU30PyKR2nROlg5Yz6ucSXelYYlMcK129bBRmPEHJo
         qwZuYFBWzl7c7pwM/byp8Q+iaL7R8QfzxaMvwmGlTBaoBnTiW1BL3e8dlCikMQfWMwrq
         p13Fw9Esyo5zUyK0i/p2hYGTQczMN4blh81RjIlWLdDZU4ztrLVET4LG5FzK1Y5cL2NZ
         X2Qw==
X-Gm-Message-State: AOJu0YwhFGPNl6BJgTYPc6tzJ3+BZJjZMip45XysM3tgPCIkAr9DF+57
	auXApNOWc0vBi7VMLjHn43sZmwjKExZjjuNGL0A=
X-Google-Smtp-Source: AGHT+IGNYrBgDx+nvC9AuuwI67vV1vM61BysWepXxnQdaZCSvAikEGaalUvebM9KlNFAOPYa+XowDw==
X-Received: by 2002:ae9:e64d:0:b0:781:1ae:5aa1 with SMTP id x13-20020ae9e64d000000b0078101ae5aa1mr52489qkl.29.1703128760786;
        Wed, 20 Dec 2023 19:19:20 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a221200b0077d85695db4sm371893qkh.99.2023.12.20.19.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:19:19 -0800 (PST)
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
Subject: [RFC 2/3] iommu/intel: synchronize page table map and unmap operations
Date: Thu, 21 Dec 2023 03:19:14 +0000
Message-ID: <20231221031915.619337-3-pasha.tatashin@soleen.com>
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

Since, we are going to update  parent page table entries when lower
level page tables become emtpy and we add them to the free list.
We need a way to synchronize the operation.

Use domain->pgd_lock to protect all map and unmap operations.
This is reader/writer lock. At the beginning everything is going to be
read only mode, however, later, when free page table on unmap is added
we will add a writer section as well.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++--
 drivers/iommu/intel/iommu.h |  3 +++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4688ef797161..733f25b277a3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1082,11 +1082,13 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
 				   unsigned long last_pfn,
 				   int retain_level)
 {
+	read_lock(&domain->pgd_lock);
 	dma_pte_clear_range(domain, start_pfn, last_pfn);
 
 	/* We don't need lock here; nobody else touches the iova range */
 	dma_pte_free_level(domain, agaw_to_level(domain->agaw), retain_level,
 			   domain->pgd, 0, start_pfn, last_pfn);
+	read_unlock(&domain->pgd_lock);
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
@@ -1179,9 +1181,11 @@ static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
 	    WARN_ON(start_pfn > last_pfn))
 		return;
 
+	read_lock(&domain->pgd_lock);
 	/* we don't need lock here; nobody else touches the iova range */
 	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
 			    domain->pgd, 0, start_pfn, last_pfn, freelist);
+	read_unlock(&domain->pgd_lock);
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
@@ -2217,6 +2221,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 	pteval = ((phys_addr_t)phys_pfn << VTD_PAGE_SHIFT) | attr;
 
+	read_lock(&domain->pgd_lock);
 	while (nr_pages > 0) {
 		uint64_t tmp;
 
@@ -2226,8 +2231,10 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 			pte = pfn_to_dma_pte(domain, iov_pfn, &largepage_lvl,
 					     gfp);
-			if (!pte)
+			if (!pte) {
+				read_unlock(&domain->pgd_lock);
 				return -ENOMEM;
+			}
 			first_pte = pte;
 
 			lvl_pages = lvl_to_nr_pages(largepage_lvl);
@@ -2287,6 +2294,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			pte = NULL;
 		}
 	}
+	read_unlock(&domain->pgd_lock);
 
 	return 0;
 }
@@ -4013,6 +4021,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	domain->pgd = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
 	if (!domain->pgd)
 		return -ENOMEM;
+	rwlock_init(&domain->pgd_lock);
 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
 	return 0;
 }
@@ -4247,11 +4256,15 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	unsigned long start_pfn, last_pfn;
 	int level = 0;
 
+	read_lock(&dmar_domain->pgd_lock);
 	/* Cope with horrid API which requires us to unmap more than the
 	   size argument if it happens to be a large-page mapping. */
 	if (unlikely(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
-				     &level, GFP_ATOMIC)))
+				     &level, GFP_ATOMIC))) {
+		read_unlock(&dmar_domain->pgd_lock);
 		return 0;
+	}
+	read_unlock(&dmar_domain->pgd_lock);
 
 	if (size < VTD_PAGE_SIZE << level_to_offset_bits(level))
 		size = VTD_PAGE_SIZE << level_to_offset_bits(level);
@@ -4315,8 +4328,10 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	int level = 0;
 	u64 phys = 0;
 
+	read_lock(&dmar_domain->pgd_lock);
 	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level,
 			     GFP_ATOMIC);
+	read_unlock(&dmar_domain->pgd_lock);
 	if (pte && dma_pte_present(pte))
 		phys = dma_pte_addr(pte) +
 			(iova & (BIT_MASK(level_to_offset_bits(level) +
@@ -4919,8 +4934,10 @@ static int intel_iommu_read_and_clear_dirty(struct iommu_domain *domain,
 		struct dma_pte *pte;
 		int lvl = 0;
 
+		read_lock(&dmar_domain->pgd_lock);
 		pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &lvl,
 				     GFP_ATOMIC);
+		read_unlock(&dmar_domain->pgd_lock);
 		pgsize = level_size(lvl) << VTD_PAGE_SHIFT;
 		if (!pte || !dma_pte_present(pte)) {
 			iova += pgsize;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index f1ea508f45bd..cb0577ec5166 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -618,6 +618,9 @@ struct dmar_domain {
 		struct {
 			/* virtual address */
 			struct dma_pte	*pgd;
+
+			/* Synchronizes pgd map/unmap operations */
+			rwlock_t	pgd_lock;
 			/* max guest address width */
 			int		gaw;
 			/*
-- 
2.43.0.472.g3155946c3a-goog


