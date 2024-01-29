Return-Path: <linux-kernel+bounces-42367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69988840076
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BED1F24050
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB49660DC8;
	Mon, 29 Jan 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hAdvMteA"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D955C33;
	Mon, 29 Jan 2024 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706517201; cv=none; b=A7PkJjsU2sMk9YJNZp5ivYMkplYl3hoU3/Ck2iWWOn1eclikYNWxsgv8konKCE+2S8udQ2q6ldwBYPzYvkOVzq/tMQhYqmWOyUcZcGuruI/OlbMGLhJtiC9ha5eT5F91YUbX+eBlhIsPtIDQU4DwdwbEQKDQRUz8leIHVkuU0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706517201; c=relaxed/simple;
	bh=MVFQZ1IItSk+X4EdOpiU+VKS++Pri+f6Ivz1lFkI6U0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6/j3y5vyoY1Fn0hyj/Np2drFugyGRRtCCPZKHZaEWSEcsQi5N7lYy+4NHqgzNzbF2PvwgvV5eFDQiOb/xCkSjYbWozgNoygUeCbU5+8IGMJHE7rhlTWFvqDQnuqRl3KjuXmFAORI6GyFCeWExS0vOzELJVLsJ7vzslWEOKnv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hAdvMteA; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0894cc48be8111eea2298b7352fd921d-20240129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DlxyWaomA72ymyQQ6VTyjM557/Qnzhm/UkHgR/8NsnI=;
	b=hAdvMteAVHVqAYDr6gahQ6dQiRs+88z24uMKBCqaXByChU2mXmDxoD39BfiyfS5YbD6qHCJGlJscXOgFd7kt9tUhsNnbi8NgMqVXcUmZ63q/Ol13hVC1zMaexj0Huv/rvkTPR5fGiP6uurZvXE7SDNXKwGqO32nnnB/Yby+yI0M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:393ab8d9-5c65-4f19-a888-ebc684f38491,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6e16cf4,CLOUDID:de25c58e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0894cc48be8111eea2298b7352fd921d-20240129
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 911914266; Mon, 29 Jan 2024 16:33:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 Jan 2024 16:33:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 29 Jan 2024 16:33:07 +0800
From: Yi-De Wu <yi-de.wu@mediatek.com>
To: Yingshiuan Pan <yingshiuan.pan@mediatek.com>, Ze-Yu Wang
	<ze-yu.wang@mediatek.com>, Yi-De Wu <yi-de.wu@mediatek.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-mediatek@lists.infradead.org>, David Bradil
	<dbrazdil@google.com>, Trilok Soni <quic_tsoni@quicinc.com>, My Chuang
	<my.chuang@mediatek.com>, Shawn Hsiao <shawn.hsiao@mediatek.com>, PeiLun Suei
	<peilun.suei@mediatek.com>, Liju Chen <liju-clr.chen@mediatek.com>, "Willix
 Yeh" <chi-shen.yeh@mediatek.com>, Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: [PATCH v9 08/21] virt: geniezone: Optimize performance of protected VM memory
Date: Mon, 29 Jan 2024 16:32:49 +0800
Message-ID: <20240129083302.26044-9-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240129083302.26044-1-yi-de.wu@mediatek.com>
References: <20240129083302.26044-1-yi-de.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-0.428200-8.000000
X-TMASE-MatchedRID: k5QkEXzOHcgZ6xRDKEbMaNiE0w2W/7Q3/Hd4CUWIS/FpG3YgOhBCuQjF
	DcaUmBsUpS2cZKjpLToO4n8yU3xhRxUBkTmMruyZhK8o4aoss8oraL2mh8ZVK1xTR00Ss4P6+Vi
	hXqn9xLE8VyRVdn8owNjMxwbxxAZyMHsCEB6xhyPJ1E39jKDimMSgMQYKGHsJQQ1XgvCe7sE1Hn
	rz3FMjWfKrCzh5Rjn97pe7sdIOgOuTM2fZSUCLQZrIHuCZpMzlfrTt+hmA5bITAT5mu/JB59eWF
	vQm49CBPSgOWjQHAA/K/S9FpaG5cuF/B1jEjV+6h2VzUlo4HVMwLjM7t3iRo2JkJOQVCIpwBpNq
	UzwLvvfC9TF0oEZxDBPXr2NefJkIFn6miqL6+G2jrlYm3WTU74EcpMn6x9cZVL6geaPy6nPqJOA
	9x2fPN+LzNWBegCW2xl8lw85EaVQLbigRnpKlKTpcQTtiHDgWwDWRHxk8pEPG6b2ZT16/gux1fA
	fM61omQIx8tzdLjRaYKgQQkPTQfm828hP3LuixJB58yKlbcZ9scjxg9dn6i4IHO9fYPO8kwZBgU
	yJVEbl6Fw8/PpTMRaVvmiAyeA2kc5MSfkiJFI4TpKrqhUsLs2cjFnImzvyS
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-0.428200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	05B2C5D3D07DFABB453FB4535DB8918546E96676D635B8CA9539AB2C23382E612000:8
X-MTK: N

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

The memory protection mechanism performs better with batch operations on
memory pages. To leverage this, we pre-allocate memory for VMs that are
set to protected mode. As a result, the memory protection mechanism can
proactively protect the pre-allocated memory in advance through batch
operations, leading to improved performance during VM booting.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/vm.c         | 152 ++++++++++++++++++++++++++++++
 drivers/virt/geniezone/Makefile   |   3 +-
 drivers/virt/geniezone/gzvm_mmu.c | 116 +++++++++++++++++++++++
 include/linux/gzvm_drv.h          |   6 ++
 4 files changed, 276 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/geniezone/gzvm_mmu.c

diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 02f94c86fbf1..b6a2bfa98b43 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -156,6 +156,128 @@ static int gzvm_vm_ioctl_get_pvmfw_size(struct gzvm *gzvm,
 	return 0;
 }
 
+/**
+ * fill_constituents() - Populate pa to buffer until full
+ * @consti: Pointer to struct mem_region_addr_range.
+ * @consti_cnt: Constituent count.
+ * @max_nr_consti: Maximum number of constituent count.
+ * @gfn: Guest frame number.
+ * @total_pages: Total page numbers.
+ * @slot: Pointer to struct gzvm_memslot.
+ *
+ * Return: how many pages we've fill in, negative if error
+ */
+static int fill_constituents(struct mem_region_addr_range *consti,
+			     int *consti_cnt, int max_nr_consti, u64 gfn,
+			     u32 total_pages, struct gzvm_memslot *slot)
+{
+	u64 pfn = 0, prev_pfn = 0, gfn_end = 0;
+	int nr_pages = 0;
+	int i = -1;
+
+	if (unlikely(total_pages == 0))
+		return -EINVAL;
+	gfn_end = gfn + total_pages;
+
+	while (i < max_nr_consti && gfn < gfn_end) {
+		if (gzvm_vm_allocate_guest_page(slot, gfn, &pfn) != 0)
+			return -EFAULT;
+		if (pfn == (prev_pfn + 1)) {
+			consti[i].pg_cnt++;
+		} else {
+			i++;
+			if (i >= max_nr_consti)
+				break;
+			consti[i].address = PFN_PHYS(pfn);
+			consti[i].pg_cnt = 1;
+		}
+		prev_pfn = pfn;
+		gfn++;
+		nr_pages++;
+	}
+	if (i != max_nr_consti)
+		i++;
+	*consti_cnt = i;
+
+	return nr_pages;
+}
+
+/**
+ * gzvm_vm_populate_mem_region() - Iterate all mem slot and populate pa to
+ * buffer until it's full
+ * @gzvm: Pointer to struct gzvm.
+ * @slot_id: Memory slot id to be populated.
+ *
+ * Return: 0 if it is successful, negative if error
+ */
+int gzvm_vm_populate_mem_region(struct gzvm *gzvm, int slot_id)
+{
+	struct gzvm_memslot *memslot = &gzvm->memslot[slot_id];
+	struct gzvm_memory_region_ranges *region;
+	int max_nr_consti, remain_pages;
+	u64 gfn, gfn_end;
+	u32 buf_size;
+
+	buf_size = PAGE_SIZE * 2;
+	region = alloc_pages_exact(buf_size, GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	max_nr_consti = (buf_size - sizeof(*region)) /
+			sizeof(struct mem_region_addr_range);
+
+	region->slot = memslot->slot_id;
+	remain_pages = memslot->npages;
+	gfn = memslot->base_gfn;
+	gfn_end = gfn + remain_pages;
+
+	while (gfn < gfn_end) {
+		int nr_pages;
+
+		nr_pages = fill_constituents(region->constituents,
+					     &region->constituent_cnt,
+					     max_nr_consti, gfn,
+					     remain_pages, memslot);
+
+		if (nr_pages < 0) {
+			pr_err("Failed to fill constituents\n");
+			free_pages_exact(region, buf_size);
+			return -EFAULT;
+		}
+
+		region->gpa = PFN_PHYS(gfn);
+		region->total_pages = nr_pages;
+		remain_pages -= nr_pages;
+		gfn += nr_pages;
+
+		if (gzvm_arch_set_memregion(gzvm->vm_id, buf_size,
+					    virt_to_phys(region))) {
+			pr_err("Failed to register memregion to hypervisor\n");
+			free_pages_exact(region, buf_size);
+			return -EFAULT;
+		}
+	}
+	free_pages_exact(region, buf_size);
+
+	return 0;
+}
+
+static int populate_all_mem_regions(struct gzvm *gzvm)
+{
+	int ret, i;
+
+	for (i = 0; i < GZVM_MAX_MEM_REGION; i++) {
+		if (gzvm->memslot[i].npages == 0)
+			continue;
+
+		ret = gzvm_vm_populate_mem_region(gzvm, i);
+		if (ret != 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * gzvm_vm_ioctl_cap_pvm() - Proceed GZVM_CAP_PROTECTED_VM's subcommands
  * @gzvm: Pointer to struct gzvm.
@@ -177,6 +299,11 @@ static int gzvm_vm_ioctl_cap_pvm(struct gzvm *gzvm,
 	case GZVM_CAP_PVM_SET_PVMFW_GPA:
 		fallthrough;
 	case GZVM_CAP_PVM_SET_PROTECTED_VM:
+		/*
+		 * To improve performance for protected VM, we have to populate VM's memory
+		 * before VM booting
+		 */
+		populate_all_mem_regions(gzvm);
 		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);
 		return ret;
 	case GZVM_CAP_PVM_GET_PVMFW_SIZE:
@@ -205,3 +332,28 @@ int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 
 	return -EINVAL;
 }
+
+/**
+ * gzvm_hva_to_pa_arch() - converts hva to pa with arch-specific way
+ * @hva: Host virtual address.
+ *
+ * Return: GZVM_PA_ERR_BAD for translation error
+ */
+u64 gzvm_hva_to_pa_arch(u64 hva)
+{
+	unsigned long flags;
+	u64 par;
+
+	local_irq_save(flags);
+	asm volatile("at s1e1r, %0" :: "r" (hva));
+	isb();
+	par = read_sysreg_par();
+	local_irq_restore(flags);
+
+	if (par & SYS_PAR_EL1_F)
+		return GZVM_PA_ERR_BAD;
+	par = par & PAR_PA47_MASK;
+	if (!par)
+		return GZVM_PA_ERR_BAD;
+	return par;
+}
diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index 25614ea3dea2..59fc4510a843 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -6,4 +6,5 @@
 
 GZVM_DIR ?= ../../../drivers/virt/geniezone
 
-gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o
+gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o \
+	  $(GZVM_DIR)/gzvm_mmu.o
diff --git a/drivers/virt/geniezone/gzvm_mmu.c b/drivers/virt/geniezone/gzvm_mmu.c
new file mode 100644
index 000000000000..3c87eee1321f
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_mmu.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/gzvm_drv.h>
+
+/**
+ * hva_to_pa_fast() - converts hva to pa in generic fast way
+ * @hva: Host virtual address.
+ *
+ * Return: GZVM_PA_ERR_BAD for translation error
+ */
+u64 hva_to_pa_fast(u64 hva)
+{
+	struct page *page[1];
+	u64 pfn;
+
+	if (get_user_page_fast_only(hva, 0, page)) {
+		pfn = page_to_phys(page[0]);
+		put_page(page[0]);
+		return pfn;
+	}
+	return GZVM_PA_ERR_BAD;
+}
+
+/**
+ * hva_to_pa_slow() - converts hva to pa in a slow way
+ * @hva: Host virtual address
+ *
+ * This function converts HVA to PA in a slow way because the target hva is not
+ * yet allocated and mapped in the host stage1 page table, we cannot find it
+ * directly from current page table.
+ * Thus, we have to allocate it and this operation is much slower than directly
+ * find via current page table.
+ *
+ * Context: This function may sleep
+ * Return: PA or GZVM_PA_ERR_BAD for translation error
+ */
+u64 hva_to_pa_slow(u64 hva)
+{
+	struct page *page = NULL;
+	u64 pfn = 0;
+	int npages;
+
+	npages = get_user_pages_unlocked(hva, 1, &page, 0);
+	if (npages != 1)
+		return GZVM_PA_ERR_BAD;
+
+	if (page) {
+		pfn = page_to_phys(page);
+		put_page(page);
+		return pfn;
+	}
+
+	return GZVM_PA_ERR_BAD;
+}
+
+static u64 __gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn)
+{
+	u64 hva, pa;
+
+	hva = gzvm_gfn_to_hva_memslot(memslot, gfn);
+
+	pa = gzvm_hva_to_pa_arch(hva);
+	if (pa != GZVM_PA_ERR_BAD)
+		return PHYS_PFN(pa);
+
+	pa = hva_to_pa_fast(hva);
+	if (pa != GZVM_PA_ERR_BAD)
+		return PHYS_PFN(pa);
+
+	pa = hva_to_pa_slow(hva);
+	if (pa != GZVM_PA_ERR_BAD)
+		return PHYS_PFN(pa);
+
+	return GZVM_PA_ERR_BAD;
+}
+
+/**
+ * gzvm_gfn_to_pfn_memslot() - Translate gfn (guest ipa) to pfn (host pa),
+ *			       result is in @pfn
+ * @memslot: Pointer to struct gzvm_memslot.
+ * @gfn: Guest frame number.
+ * @pfn: Host page frame number.
+ *
+ * Return:
+ * * 0			- Succeed
+ * * -EFAULT		- Failed to convert
+ */
+int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn,
+			    u64 *pfn)
+{
+	u64 __pfn;
+
+	if (!memslot)
+		return -EFAULT;
+
+	__pfn = __gzvm_gfn_to_pfn_memslot(memslot, gfn);
+	if (__pfn == GZVM_PA_ERR_BAD) {
+		*pfn = 0;
+		return -EFAULT;
+	}
+
+	*pfn = __pfn;
+
+	return 0;
+}
+
+int gzvm_vm_allocate_guest_page(struct gzvm_memslot *slot, u64 gfn, u64 *pfn)
+{
+	if (gzvm_gfn_to_pfn_memslot(slot, gfn, pfn) != 0)
+		return -EFAULT;
+	return 0;
+}
+
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index 01c92e7eb230..8ba0ec36bc8c 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -91,6 +91,12 @@ int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  void __user *argp);
 
+u64 gzvm_hva_to_pa_arch(u64 hva);
+u64 hva_to_pa_fast(u64 hva);
+u64 hva_to_pa_slow(u64 hva);
+int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn);
 u64 gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn);
+int gzvm_vm_populate_mem_region(struct gzvm *gzvm, int slot_id);
+int gzvm_vm_allocate_guest_page(struct gzvm_memslot *slot, u64 gfn, u64 *pfn);
 
 #endif /* __GZVM_DRV_H__ */
-- 
2.18.0


