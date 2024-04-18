Return-Path: <linux-kernel+bounces-150494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E424E8AA021
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48042B25094
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0B317997D;
	Thu, 18 Apr 2024 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dyqjqKhX"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867D417557E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457968; cv=none; b=sxq4crwhJpy5Ry649p+5fP2PL0zrR/JafG/A/tR7sJXrzS5+fqKtmb65A+ysRbxDxQATpkn6doikigwg9m3zjDYOveuJrzNZ/IdkMINV3pW4MQ+21bhuc1JtpvRt9MogOksnUEU99KMA3/3CwCDD/JcF6odz8LTHzSoFeWJTcWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457968; c=relaxed/simple;
	bh=oVkW6hz+OvOucQsnY5EiuNjtTCYdFhBdowR3JnUUTm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeazLEAeKtfTzlmkxCTrhMMveXzXMHOjDz9kLEJatUWESzp4AFR7O7fJegRRnjieA9DDMJ0iagMYHx2oRGKeX5nV5M+p++1NwcFkBeoFoMA1z3e1eeMSVbQj3dL7q5NLsixuWKwUcOznFJAKMY5+jwDwX/kBPW1GZtjLbv+H6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dyqjqKhX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed267f2936so953481b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713457965; x=1714062765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgxIrVS16h/SerYh1GsIEzKhv9b08IA4pie9TxH63fY=;
        b=dyqjqKhXwcp0bDWXcD/rQt7J6ixx1kC02ebkz0RB9bQ/zIbfhUqMsdYijCGRhsqeeB
         cR+nfWsQP5aJOdASNjMytSN5ghMgrGQUpClYG3UJEawA2CPe50dIRZsGp73qVb0nofMu
         WTxObfgVVaTPC5rbSct6DZzusawOBXveXU7MPJrz/BTU9DhQgWpCWsabSK3PqRIocAZR
         QLJCdHJQVp5ivSAkwGCgQxk9NbdeGaaErVDsJ0AwEKhZ8jf2ktdDLrKup1W9XzWLhQCA
         Kz+Fq1eK6xAwLqq3FGOugsqcHAqLmg4dVelHF12D3D93JuWciOMqbZ5eTHUcmZHdb+iv
         CRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713457965; x=1714062765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgxIrVS16h/SerYh1GsIEzKhv9b08IA4pie9TxH63fY=;
        b=HbaLtc6jRWm4fmVjnGFgv8MXZmC20kKAmDpkql3SuNCuTG3ENd1mI1VgkrjnN2ju3P
         oXiaQPGstZxbITLOw8UogzRGdVeJe7AdGQSiBjJ0BA9iTvcPq3fn4UerP3C+2rAgR+i5
         jdT+oFMhreU0RplLZvcN73Q4hOg3OXf3P2wAf1EUyxBSZ47DWLR4t341spmvB6fCRlTd
         /usMLJKFXVMQjb+HEMr6ovLOXhBH5bP37rUzqvcpcChvnBqiQWk48HEn2/c4t/VpXRw0
         72U+k6nF8/fVjFmJLdjTzJ+L8jHHw9DDNO+MEmZnu7cDpkn5+g2UVYBxzRzdrpAbxaby
         w+lw==
X-Forwarded-Encrypted: i=1; AJvYcCViDmdKsjZWd/uifw7ps2ntJwaNM4ZIRqPhCw0BxGdDCDhnCvsnW63o/g4z3NoEsYQxTu+kZiWhG16NT0sfDzRQiQWpKSrk7DG3NHY2
X-Gm-Message-State: AOJu0YzgdJ9hic/dmah6MDRPqSNCPjot2ep/hYHWolX1P7CL/L+weFqB
	WUYIaM4rHwYUSPXUUX754LC2jxxbc+QpV6Qxgwkv604nG1CN3KCDzrQfSWUNzC4=
X-Google-Smtp-Source: AGHT+IGg5fqr8mWjVW5dWxgXmXyrna9Ar6uIbK0PltfhIxYndnsbs7RkjmzhNqIngg9NPJv/yeaLkg==
X-Received: by 2002:a05:6a00:21c2:b0:6ed:d68d:948a with SMTP id t2-20020a056a0021c200b006edd68d948amr3580556pfj.23.1713457964808;
        Thu, 18 Apr 2024 09:32:44 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b19-20020a056a000a9300b006eae3aac040sm1674755pfl.31.2024.04.18.09.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:32:44 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH v2 7/7] iommu/riscv: Paging domain support
Date: Thu, 18 Apr 2024 09:32:25 -0700
Message-Id: <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713456597.git.tjeznach@rivosinc.com>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce first-stage address translation support.

Page table configured by the IOMMU driver will use the same format
as the CPU’s MMU, and will fallback to identity translation if the
page table format configured for the MMU is not supported by the
IOMMU hardware.

This change introduces IOTINVAL.VMA command, required to invalidate
any cached IOATC entries after mapping is updated and/or removed from
the paging domain. Invalidations for the non-leaf page entries will
be added to the driver code in separate patch series, following spec
update to clarify non-leaf cache invalidation command. With this patch,
allowing only 4K mappings and keeping non-leaf page entries in memory
this should be a reasonable simplification.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/Kconfig |   1 +
 drivers/iommu/riscv/iommu.c | 467 +++++++++++++++++++++++++++++++++++-
 2 files changed, 466 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index 711326992585..6f9fb396034a 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -7,6 +7,7 @@ config RISCV_IOMMU
 	select DMA_OPS
 	select IOMMU_API
 	select IOMMU_IOVA
+	select IOMMU_DMA
 	help
 	  Support for implementations of the RISC-V IOMMU architecture that
 	  complements the RISC-V MMU capabilities, providing similar address
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index a4f74588cdc2..32ddc372432d 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -46,6 +46,10 @@ MODULE_LICENSE("GPL");
 #define dev_to_iommu(dev) \
 	container_of((dev)->iommu->iommu_dev, struct riscv_iommu_device, iommu)
 
+/* IOMMU PSCID allocation namespace. */
+static DEFINE_IDA(riscv_iommu_pscids);
+#define RISCV_IOMMU_MAX_PSCID		BIT(20)
+
 /* Device resource-managed allocations */
 struct riscv_iommu_devres {
 	unsigned long addr;
@@ -752,12 +756,77 @@ static int riscv_iommu_ddt_alloc(struct riscv_iommu_device *iommu)
 	return 0;
 }
 
+struct riscv_iommu_bond {
+	struct list_head list;
+	struct rcu_head rcu;
+	struct device *dev;
+};
+
+/* This struct contains protection domain specific IOMMU driver data. */
+struct riscv_iommu_domain {
+	struct iommu_domain domain;
+	struct list_head bonds;
+	int pscid;
+	int numa_node;
+	int amo_enabled:1;
+	unsigned int pgd_mode;
+	/* paging domain */
+	unsigned long pgd_root;
+};
+
+#define iommu_domain_to_riscv(iommu_domain) \
+	container_of(iommu_domain, struct riscv_iommu_domain, domain)
+
+/*
+ * Send IOTLB.INVAL for whole address space for ranges larger than 2MB.
+ * This limit will be replaced with range invalidations, if supported by
+ * the hardware, when RISC-V IOMMU architecture specification update for
+ * range invalidations update will be available.
+ */
+#define RISCV_IOMMU_IOTLB_INVAL_LIMIT	(2 << 20)
+
+static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
+				    unsigned long start, unsigned long end)
+{
+	struct riscv_iommu_bond *bond;
+	struct riscv_iommu_device *iommu;
+	struct riscv_iommu_command cmd;
+	unsigned long len = end - start + 1;
+	unsigned long iova;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(bond, &domain->bonds, list) {
+		iommu = dev_to_iommu(bond->dev);
+		riscv_iommu_cmd_inval_vma(&cmd);
+		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
+		if (len > 0 && len < RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
+			for (iova = start; iova < end; iova += PAGE_SIZE) {
+				riscv_iommu_cmd_inval_set_addr(&cmd, iova);
+				riscv_iommu_cmd_send(iommu, &cmd, 0);
+			}
+		} else {
+			riscv_iommu_cmd_send(iommu, &cmd, 0);
+		}
+	}
+
+	list_for_each_entry_rcu(bond, &domain->bonds, list) {
+		iommu = dev_to_iommu(bond->dev);
+
+		riscv_iommu_cmd_iofence(&cmd);
+		riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEOUT);
+	}
+	rcu_read_unlock();
+}
+
 static int riscv_iommu_attach_domain(struct riscv_iommu_device *iommu,
 				     struct device *dev,
 				     struct iommu_domain *iommu_domain)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct riscv_iommu_domain *domain;
 	struct riscv_iommu_dc *dc;
+	struct riscv_iommu_bond *bond = NULL, *b;
+	struct riscv_iommu_command cmd;
 	u64 fsc, ta, tc;
 	int i;
 
@@ -769,6 +838,20 @@ static int riscv_iommu_attach_domain(struct riscv_iommu_device *iommu,
 		ta = 0;
 		tc = RISCV_IOMMU_DC_TC_V;
 		fsc = FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE, RISCV_IOMMU_DC_FSC_MODE_BARE);
+	} else if (iommu_domain->type & __IOMMU_DOMAIN_PAGING) {
+		domain = iommu_domain_to_riscv(iommu_domain);
+
+		ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid);
+		tc = RISCV_IOMMU_DC_TC_V;
+		if (domain->amo_enabled)
+			tc |= RISCV_IOMMU_DC_TC_SADE;
+		fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
+		      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+
+		bond = kzalloc(sizeof(*bond), GFP_KERNEL);
+		if (!bond)
+			return -ENOMEM;
+		bond->dev = dev;
 	} else {
 		/* This should never happen. */
 		return -ENODEV;
@@ -787,12 +870,390 @@ static int riscv_iommu_attach_domain(struct riscv_iommu_device *iommu,
 		xchg64(&dc->ta, ta);
 		xchg64(&dc->tc, tc);
 
-		/* Device context invalidation will be required. Ignoring for now. */
+		if (!(tc & RISCV_IOMMU_DC_TC_V))
+			continue;
+
+		/* Invalidate device context cache */
+		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
+		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
+		riscv_iommu_cmd_send(iommu, &cmd, 0);
+
+		if (FIELD_GET(RISCV_IOMMU_PC_FSC_MODE, fsc) == RISCV_IOMMU_DC_FSC_MODE_BARE)
+			continue;
+
+		/* Invalidate last valid PSCID */
+		riscv_iommu_cmd_inval_vma(&cmd);
+		riscv_iommu_cmd_inval_set_pscid(&cmd, FIELD_GET(RISCV_IOMMU_DC_TA_PSCID, ta));
+		riscv_iommu_cmd_send(iommu, &cmd, 0);
+	}
+
+	/* Synchronize directory update */
+	riscv_iommu_cmd_iofence(&cmd);
+	riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_IOTINVAL_TIMEOUT);
+
+	/* Track domain to devices mapping. */
+	if (bond)
+		list_add_rcu(&bond->list, &domain->bonds);
+
+	/* Remove tracking from previous domain, if needed. */
+	iommu_domain = iommu_get_domain_for_dev(dev);
+	if (iommu_domain && !!(iommu_domain->type & __IOMMU_DOMAIN_PAGING)) {
+		domain = iommu_domain_to_riscv(iommu_domain);
+		bond = NULL;
+		rcu_read_lock();
+		list_for_each_entry_rcu(b, &domain->bonds, list) {
+			if (b->dev == dev) {
+				bond = b;
+				break;
+			}
+		}
+		rcu_read_unlock();
+
+		if (bond) {
+			list_del_rcu(&bond->list);
+			kfree_rcu(bond, rcu);
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * IOVA page translation tree management.
+ */
+
+#define IOMMU_PAGE_SIZE_4K     BIT_ULL(12)
+#define IOMMU_PAGE_SIZE_2M     BIT_ULL(21)
+#define IOMMU_PAGE_SIZE_1G     BIT_ULL(30)
+#define IOMMU_PAGE_SIZE_512G   BIT_ULL(39)
+
+#define PT_SHIFT (PAGE_SHIFT - ilog2(sizeof(pte_t)))
+
+static void riscv_iommu_flush_iotlb_all(struct iommu_domain *iommu_domain)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+
+	riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
+}
+
+static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
+				   struct iommu_iotlb_gather *gather)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+
+	riscv_iommu_iotlb_inval(domain, gather->start, gather->end);
+}
+
+static inline size_t get_page_size(size_t size)
+{
+	if (size >= IOMMU_PAGE_SIZE_512G)
+		return IOMMU_PAGE_SIZE_512G;
+	if (size >= IOMMU_PAGE_SIZE_1G)
+		return IOMMU_PAGE_SIZE_1G;
+	if (size >= IOMMU_PAGE_SIZE_2M)
+		return IOMMU_PAGE_SIZE_2M;
+	return IOMMU_PAGE_SIZE_4K;
+}
+
+#define _io_pte_present(pte)	((pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE))
+#define _io_pte_leaf(pte)	((pte) & _PAGE_LEAF)
+#define _io_pte_none(pte)	((pte) == 0)
+#define _io_pte_entry(pn, prot)	((_PAGE_PFN_MASK & ((pn) << _PAGE_PFN_SHIFT)) | (prot))
+
+static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
+				 unsigned long pte, struct list_head *freelist)
+{
+	unsigned long *ptr;
+	int i;
+
+	if (!_io_pte_present(pte) || _io_pte_leaf(pte))
+		return;
+
+	ptr = (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
+
+	/* Recursively free all sub page table pages */
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		pte = READ_ONCE(ptr[i]);
+		if (!_io_pte_none(pte) && cmpxchg_relaxed(ptr + i, pte, 0) == pte)
+			riscv_iommu_pte_free(domain, pte, freelist);
+	}
+
+	if (freelist)
+		list_add_tail(&virt_to_page(ptr)->lru, freelist);
+	else
+		free_page((unsigned long)ptr);
+}
+
+static unsigned long *riscv_iommu_pte_alloc(struct riscv_iommu_domain *domain,
+					    unsigned long iova, size_t pgsize, gfp_t gfp)
+{
+	unsigned long *ptr = (unsigned long *)domain->pgd_root;
+	unsigned long pte, old;
+	int level = domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 + 2;
+	struct page *page;
+
+	do {
+		const int shift = PAGE_SHIFT + PT_SHIFT * level;
+
+		ptr += ((iova >> shift) & (PTRS_PER_PTE - 1));
+		/*
+		 * Note: returned entry might be a non-leaf if there was existing mapping
+		 * with smaller granularity. Up to the caller to replace and invalidate.
+		 */
+		if (((size_t)1 << shift) == pgsize)
+			return ptr;
+pte_retry:
+		pte = READ_ONCE(*ptr);
+		/*
+		 * This is very likely incorrect as we should not be adding new mapping
+		 * with smaller granularity on top of existing 2M/1G mapping. Fail.
+		 */
+		if (_io_pte_present(pte) && _io_pte_leaf(pte))
+			return NULL;
+		/*
+		 * Non-leaf entry is missing, allocate and try to add to the page table.
+		 * This might race with other mappings, retry on error.
+		 */
+		if (_io_pte_none(pte)) {
+			page = alloc_pages_node(domain->numa_node, __GFP_ZERO | gfp, 0);
+			if (!page)
+				return NULL;
+			old = pte;
+			pte = _io_pte_entry(page_to_pfn(page), _PAGE_TABLE);
+			if (cmpxchg_relaxed(ptr, old, pte) != old) {
+				__free_pages(page, 0);
+				goto pte_retry;
+			}
+		}
+		ptr = (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
+	} while (level-- > 0);
+
+	return NULL;
+}
+
+static unsigned long *riscv_iommu_pte_fetch(struct riscv_iommu_domain *domain,
+					    unsigned long iova, size_t *pte_pgsize)
+{
+	unsigned long *ptr = (unsigned long *)domain->pgd_root;
+	unsigned long pte;
+	int level = domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 + 2;
+
+	do {
+		const int shift = PAGE_SHIFT + PT_SHIFT * level;
+
+		ptr += ((iova >> shift) & (PTRS_PER_PTE - 1));
+		pte = READ_ONCE(*ptr);
+		if (_io_pte_present(pte) && _io_pte_leaf(pte)) {
+			*pte_pgsize = (size_t)1 << shift;
+			return ptr;
+		}
+		if (_io_pte_none(pte))
+			return NULL;
+		ptr = (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
+	} while (level-- > 0);
+
+	return NULL;
+}
+
+static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
+				 unsigned long iova, phys_addr_t phys,
+				 size_t pgsize, size_t pgcount, int prot,
+				 gfp_t gfp, size_t *mapped)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	size_t size = 0;
+	size_t page_size = get_page_size(pgsize);
+	unsigned long *ptr;
+	unsigned long pte, old, pte_prot;
+
+	if (!(prot & IOMMU_WRITE))
+		pte_prot = _PAGE_BASE | _PAGE_READ;
+	else if (domain->amo_enabled)
+		pte_prot = _PAGE_BASE | _PAGE_READ | _PAGE_WRITE;
+	else
+		pte_prot = _PAGE_BASE | _PAGE_READ | _PAGE_WRITE | _PAGE_DIRTY;
+
+	while (pgcount) {
+		ptr = riscv_iommu_pte_alloc(domain, iova, page_size, gfp);
+		if (!ptr) {
+			*mapped = size;
+			return -ENOMEM;
+		}
+
+		old = READ_ONCE(*ptr);
+		pte = _io_pte_entry(phys_to_pfn(phys), pte_prot);
+		if (cmpxchg_relaxed(ptr, old, pte) != old)
+			continue;
+
+		/* TODO: non-leaf page invalidation is pending spec update */
+		riscv_iommu_pte_free(domain, old, NULL);
+
+		size += page_size;
+		iova += page_size;
+		phys += page_size;
+		--pgcount;
 	}
 
+	*mapped = size;
+
 	return 0;
 }
 
+static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
+				      unsigned long iova, size_t pgsize, size_t pgcount,
+				      struct iommu_iotlb_gather *gather)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	size_t size = pgcount << __ffs(pgsize);
+	unsigned long *ptr, old;
+	size_t unmapped = 0;
+	size_t pte_size;
+
+	while (unmapped < size) {
+		ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
+		if (!ptr)
+			return unmapped;
+
+		/* partial unmap is not allowed, fail. */
+		if (iova & ~(pte_size - 1))
+			return unmapped;
+
+		old = READ_ONCE(*ptr);
+		if (cmpxchg_relaxed(ptr, old, 0) != old)
+			continue;
+
+		iommu_iotlb_gather_add_page(&domain->domain, gather, iova,
+					    pte_size);
+
+		iova += pte_size;
+		unmapped += pte_size;
+	}
+
+	return unmapped;
+}
+
+static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain, dma_addr_t iova)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	unsigned long pte_size;
+	unsigned long *ptr;
+
+	ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
+	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
+		return 0;
+
+	return pfn_to_phys(__page_val_to_pfn(*ptr)) | (iova & (pte_size - 1));
+}
+
+static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+
+	WARN_ON(!list_empty(&domain->bonds));
+
+	if (domain->pgd_root) {
+		const unsigned long pfn = virt_to_pfn(domain->pgd_root);
+
+		riscv_iommu_pte_free(domain, _io_pte_entry(pfn, _PAGE_TABLE), NULL);
+	}
+
+	if ((int)domain->pscid > 0)
+		ida_free(&riscv_iommu_pscids, domain->pscid);
+
+	kfree(domain);
+}
+
+static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_mode)
+{
+	switch (pgd_mode) {
+	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
+		return iommu->caps & RISCV_IOMMU_CAP_S_SV39;
+
+	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
+		return iommu->caps & RISCV_IOMMU_CAP_S_SV48;
+
+	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
+		return iommu->caps & RISCV_IOMMU_CAP_S_SV57;
+	}
+	return false;
+}
+
+static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
+					    struct device *dev)
+{
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	struct page *page;
+
+	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
+		return -ENODEV;
+
+	domain->numa_node = dev_to_node(iommu->dev);
+	domain->amo_enabled = !!(iommu->caps & RISCV_IOMMU_CAP_AMO_HWAD);
+
+	if (!domain->pgd_root) {
+		page = alloc_pages_node(domain->numa_node,
+					GFP_KERNEL_ACCOUNT | __GFP_ZERO, 0);
+		if (!page)
+			return -ENOMEM;
+		domain->pgd_root = (unsigned long)page_to_virt(page);
+	}
+
+	return riscv_iommu_attach_domain(iommu, dev, iommu_domain);
+}
+
+static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
+	.attach_dev = riscv_iommu_attach_paging_domain,
+	.free = riscv_iommu_free_paging_domain,
+	.map_pages = riscv_iommu_map_pages,
+	.unmap_pages = riscv_iommu_unmap_pages,
+	.iova_to_phys = riscv_iommu_iova_to_phys,
+	.iotlb_sync = riscv_iommu_iotlb_sync,
+	.flush_iotlb_all = riscv_iommu_flush_iotlb_all,
+};
+
+static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
+{
+	struct riscv_iommu_domain *domain;
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD_RCU(&domain->bonds);
+
+	domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1,
+					RISCV_IOMMU_MAX_PSCID - 1, GFP_KERNEL);
+	if (domain->pscid < 0) {
+		kfree(domain);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * Note: RISC-V Privilege spec mandates that virtual addresses
+	 * need to be sign-extended, so if (VA_BITS - 1) is set, all
+	 * bits >= VA_BITS need to also be set or else we'll get a
+	 * page fault. However the code that creates the mappings
+	 * above us (e.g. iommu_dma_alloc_iova()) won't do that for us
+	 * for now, so we'll end up with invalid virtual addresses
+	 * to map. As a workaround until we get this sorted out
+	 * limit the available virtual addresses to VA_BITS - 1.
+	 */
+	domain->domain.geometry.aperture_start = 0;
+	domain->domain.geometry.aperture_end = DMA_BIT_MASK(VA_BITS - 1);
+	domain->domain.geometry.force_aperture = true;
+
+	/*
+	 * Follow system address translation mode.
+	 * RISC-V IOMMU ATP mode values match RISC-V CPU SATP mode values.
+	 */
+	domain->pgd_mode = satp_mode >> SATP_MODE_SHIFT;
+	domain->numa_node = NUMA_NO_NODE;
+	domain->domain.ops = &riscv_iommu_paging_domain_ops;
+
+	return &domain->domain;
+}
+
 static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 					      struct device *dev)
 {
@@ -814,7 +1275,7 @@ static struct iommu_domain riscv_iommu_identity_domain = {
 
 static int riscv_iommu_device_domain_type(struct device *dev)
 {
-	return IOMMU_DOMAIN_IDENTITY;
+	return 0;
 }
 
 static struct iommu_group *riscv_iommu_device_group(struct device *dev)
@@ -858,8 +1319,10 @@ static void riscv_iommu_release_device(struct device *dev)
 
 static const struct iommu_ops riscv_iommu_ops = {
 	.owner = THIS_MODULE,
+	.pgsize_bitmap = SZ_4K,
 	.of_xlate = riscv_iommu_of_xlate,
 	.identity_domain = &riscv_iommu_identity_domain,
+	.domain_alloc_paging = riscv_iommu_alloc_paging_domain,
 	.def_domain_type = riscv_iommu_device_domain_type,
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
-- 
2.34.1


