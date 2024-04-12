Return-Path: <linux-kernel+bounces-142083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048738A274F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280831C21934
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3318952F99;
	Fri, 12 Apr 2024 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CtR3mCMW"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56B4CB2B;
	Fri, 12 Apr 2024 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905078; cv=none; b=rnQhgQchK3xUz26uRrObygyAPHFI7l7AnevECRRLnt2+JP5cFHzc0n4l6YpJ2FIatldCTWYhOgkpQSsRWyvD5g5gUMWTR5RNXdCQoW75dhGtj0hHJM65WFwVDD3rY7Pb0TNll3YzXap6+T3t+FWlSjH+RR4HXjwJGw422xDfFaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905078; c=relaxed/simple;
	bh=L2tJvFsMaoRM9gchlQLkVZ+hRAV02XNYS6v1rBZDyKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GH6sSOtViJ5o13EueI01cQnDqUJH5X4VAA72c4/g1d8upWqiSApfVDyJngI0DkXcKO/puNSbKLCg4qsShdgnlmeaz00t0+f1SBGH6lEukJk9THCPhQnv3hvI+dY1HEeEykXd2F/sqPCAIdIRyZqiHs4oQbEHeBwZ7QY1u1S85PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CtR3mCMW; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f94b5c72f89911ee935d6952f98a51a9-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KnmR3iuaQdzN5AUrWbhyo1vnuEmyAbGW2cOptRwC8Bk=;
	b=CtR3mCMWJFump1fAGpqDnILYhqPD4e9ELqyz7+Gmc5s61aevIWUTEjYDScbMm2Sftt9m3ZeZYtrZPXp4XG5O+9yIYOppL4diCa0zuDF8rjstqTaMsCfmYi4Ouvt6Qwxt5grzkmrx3UjLSOAhSHw9W7qt6yl9Y8dqeiR8nIXkHao=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e8c67fad-e753-4d45-8563-c2a411f5157a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:889a7e91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f94b5c72f89911ee935d6952f98a51a9-20240412
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1377817280; Fri, 12 Apr 2024 14:57:49 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 14:57:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 14:57:47 +0800
From: Yi-De Wu <yi-de.wu@mediatek.com>
To: Yingshiuan Pan <yingshiuan.pan@mediatek.com>, Ze-Yu Wang
	<ze-yu.wang@mediatek.com>, Yi-De Wu <yi-de.wu@mediatek.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-mediatek@lists.infradead.org>, David Bradil
	<dbrazdil@google.com>, Trilok Soni <quic_tsoni@quicinc.com>, My Chuang
	<my.chuang@mediatek.com>, Shawn Hsiao <shawn.hsiao@mediatek.com>, PeiLun Suei
	<peilun.suei@mediatek.com>, Liju Chen <liju-clr.chen@mediatek.com>, Willix
 Yeh <chi-shen.yeh@mediatek.com>, Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: [PATCH v10 17/21] virt: geniezone: Add memory pin/unpin support
Date: Fri, 12 Apr 2024 14:57:14 +0800
Message-ID: <20240412065718.29105-18-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240412065718.29105-1-yi-de.wu@mediatek.com>
References: <20240412065718.29105-1-yi-de.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK: N

From: "Jerry Wang" <ze-yu.wang@mediatek.com>

Protected VM's memory cannot be swapped out because the memory pages are
protected from host access.

Once host accesses to those protected pages, the hardware exception is
triggered and may crash the host. So, we have to make those protected
pages be ineligible for swapping or merging by the host kernel to avoid
host access. To do so, we pin the page when it is assigned (donated) to
VM and unpin when VM relinquish the pages or is destroyed. Besides, the
protected VM’s memory requires hypervisor to clear the content before
returning to host, but VMM may free those memory before clearing, it
will result in those memory pages are reclaimed and reused before
totally clearing. Using pin/unpin can also avoid the above problems.

The implementation is described as follows.
- Use rb_tree to store pinned memory pages.
- Pin the page when handling page fault.
- Unpin the pages when VM relinquish the pages or is destroyed.

Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/vm.c             |  8 ++-
 drivers/virt/geniezone/gzvm_mmu.c     | 88 +++++++++++++++++++++++++--
 drivers/virt/geniezone/gzvm_vm.c      | 21 +++++++
 include/linux/soc/mediatek/gzvm_drv.h | 15 ++++-
 4 files changed, 122 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 4691a3ada678..eb28c3850b5d 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -211,12 +211,14 @@ static int gzvm_vm_ioctl_get_pvmfw_size(struct gzvm *gzvm,
  * @gfn: Guest frame number.
  * @total_pages: Total page numbers.
  * @slot: Pointer to struct gzvm_memslot.
+ * @gzvm: Pointer to struct gzvm.
  *
  * Return: how many pages we've fill in, negative if error
  */
 static int fill_constituents(struct mem_region_addr_range *consti,
 			     int *consti_cnt, int max_nr_consti, u64 gfn,
-			     u32 total_pages, struct gzvm_memslot *slot)
+			     u32 total_pages, struct gzvm_memslot *slot,
+			     struct gzvm *gzvm)
 {
 	u64 pfn = 0, prev_pfn = 0, gfn_end = 0;
 	int nr_pages = 0;
@@ -227,7 +229,7 @@ static int fill_constituents(struct mem_region_addr_range *consti,
 	gfn_end = gfn + total_pages;
 
 	while (i < max_nr_consti && gfn < gfn_end) {
-		if (gzvm_vm_allocate_guest_page(slot, gfn, &pfn) != 0)
+		if (gzvm_vm_allocate_guest_page(gzvm, slot, gfn, &pfn) != 0)
 			return -EFAULT;
 		if (pfn == (prev_pfn + 1)) {
 			consti[i].pg_cnt++;
@@ -284,7 +286,7 @@ int gzvm_vm_populate_mem_region(struct gzvm *gzvm, int slot_id)
 		nr_pages = fill_constituents(region->constituents,
 					     &region->constituent_cnt,
 					     max_nr_consti, gfn,
-					     remain_pages, memslot);
+					     remain_pages, memslot, gzvm);
 
 		if (nr_pages < 0) {
 			pr_err("Failed to fill constituents\n");
diff --git a/drivers/virt/geniezone/gzvm_mmu.c b/drivers/virt/geniezone/gzvm_mmu.c
index eff02a5e1b17..7bc96cba1ecb 100644
--- a/drivers/virt/geniezone/gzvm_mmu.c
+++ b/drivers/virt/geniezone/gzvm_mmu.c
@@ -108,11 +108,88 @@ int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn,
 	return 0;
 }
 
-int gzvm_vm_allocate_guest_page(struct gzvm_memslot *slot, u64 gfn, u64 *pfn)
+static int cmp_ppages(struct rb_node *node, const struct rb_node *parent)
 {
+	struct gzvm_pinned_page *a = container_of(node,
+						  struct gzvm_pinned_page,
+						  node);
+	struct gzvm_pinned_page *b = container_of(parent,
+						  struct gzvm_pinned_page,
+						  node);
+
+	if (a->ipa < b->ipa)
+		return -1;
+	if (a->ipa > b->ipa)
+		return 1;
+	return 0;
+}
+
+/* Invoker of this function is responsible for locking */
+static int gzvm_insert_ppage(struct gzvm *vm, struct gzvm_pinned_page *ppage)
+{
+	if (rb_find_add(&ppage->node, &vm->pinned_pages, cmp_ppages))
+		return -EEXIST;
+	return 0;
+}
+
+static int pin_one_page(struct gzvm *vm, unsigned long hva, u64 gpa)
+{
+	unsigned int flags = FOLL_HWPOISON | FOLL_LONGTERM | FOLL_WRITE;
+	struct gzvm_pinned_page *ppage = NULL;
+	struct mm_struct *mm = current->mm;
+	struct page *page = NULL;
+	int ret;
+
+	ppage = kmalloc(sizeof(*ppage), GFP_KERNEL_ACCOUNT);
+	if (!ppage)
+		return -ENOMEM;
+
+	mmap_read_lock(mm);
+	pin_user_pages(hva, 1, flags, &page);
+	mmap_read_unlock(mm);
+
+	if (!page) {
+		kfree(ppage);
+		return -EFAULT;
+	}
+
+	ppage->page = page;
+	ppage->ipa = gpa;
+
+	mutex_lock(&vm->mem_lock);
+	ret = gzvm_insert_ppage(vm, ppage);
+
+	/**
+	 * The return of -EEXIST from gzvm_insert_ppage is considered an
+	 * expected behavior in this context.
+	 * This situation arises when two or more VCPUs are concurrently
+	 * engaged in demand paging handling. The initial VCPU has already
+	 * allocated and pinned a page, while the subsequent VCPU attempts
+	 * to pin the same page again. As a result, we prompt the unpinning
+	 * and release of the allocated structure, followed by a return 0.
+	 */
+	if (ret == -EEXIST) {
+		kfree(ppage);
+		unpin_user_pages(&page, 1);
+		ret = 0;
+	}
+	mutex_unlock(&vm->mem_lock);
+
+	return ret;
+}
+
+int gzvm_vm_allocate_guest_page(struct gzvm *vm, struct gzvm_memslot *slot,
+				u64 gfn, u64 *pfn)
+{
+	unsigned long hva;
+
 	if (gzvm_gfn_to_pfn_memslot(slot, gfn, pfn) != 0)
 		return -EFAULT;
-	return 0;
+
+	if (gzvm_gfn_to_hva_memslot(slot, gfn, (u64 *)&hva) != 0)
+		return -EINVAL;
+
+	return pin_one_page(vm, hva, PFN_PHYS(gfn));
 }
 
 static int handle_block_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
@@ -138,7 +215,7 @@ static int handle_block_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
 
 	mutex_lock(&vm->demand_paging_lock);
 	for (i = 0, __gfn = start_gfn; i < nr_entries; i++, __gfn++) {
-		ret = gzvm_vm_allocate_guest_page(memslot, __gfn, &pfn);
+		ret = gzvm_vm_allocate_guest_page(vm, memslot, __gfn, &pfn);
 		if (unlikely(ret)) {
 			ret = -ERR_FAULT;
 			goto err_unlock;
@@ -164,15 +241,14 @@ static int handle_single_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
 	int ret;
 	u64 pfn;
 
-	ret = gzvm_vm_allocate_guest_page(&vm->memslot[memslot_id], gfn, &pfn);
+	ret = gzvm_vm_allocate_guest_page(vm, &vm->memslot[memslot_id], gfn, &pfn);
 	if (unlikely(ret))
 		return -EFAULT;
 
 	ret = gzvm_arch_map_guest(vm->vm_id, memslot_id, pfn, gfn, 1);
 	if (unlikely(ret))
 		return -EFAULT;
-
-	return 0;
+	return ret;
 }
 
 /**
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index d698e4e86b0e..04af59b77189 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -299,6 +299,22 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 	return ret;
 }
 
+/* Invoker of this function is responsible for locking */
+static void gzvm_destroy_all_ppage(struct gzvm *gzvm)
+{
+	struct gzvm_pinned_page *ppage;
+	struct rb_node *node;
+
+	node = rb_first(&gzvm->pinned_pages);
+	while (node) {
+		ppage = rb_entry(node, struct gzvm_pinned_page, node);
+		unpin_user_pages_dirty_lock(&ppage->page, 1, true);
+		node = rb_next(node);
+		rb_erase(&ppage->node, &gzvm->pinned_pages);
+		kfree(ppage);
+	}
+}
+
 static void gzvm_destroy_vm(struct gzvm *gzvm)
 {
 	size_t allocated_size;
@@ -322,6 +338,9 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 
 	mutex_unlock(&gzvm->lock);
 
+	/* No need to lock here becauese it's single-threaded execution */
+	gzvm_destroy_all_ppage(gzvm);
+
 	kfree(gzvm);
 }
 
@@ -415,6 +434,8 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 	gzvm->vm_id = ret;
 	gzvm->mm = current->mm;
 	mutex_init(&gzvm->lock);
+	mutex_init(&gzvm->mem_lock);
+	gzvm->pinned_pages = RB_ROOT;
 
 	ret = gzvm_vm_irqfd_init(gzvm);
 	if (ret) {
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 1c16960a1728..bf5f1abf8dbe 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/gzvm.h>
 #include <linux/srcu.h>
+#include <linux/rbtree.h>
 
 /*
  * For the normal physical address, the highest 12 bits should be zero, so we
@@ -99,6 +100,12 @@ struct gzvm_vcpu {
 	struct gzvm_vcpu_hwstate *hwstate;
 };
 
+struct gzvm_pinned_page {
+	struct rb_node node;
+	struct page *page;
+	u64 ipa;
+};
+
 /**
  * struct gzvm: the following data structures are for data transferring between
  * driver and hypervisor, and they're aligned with hypervisor definitions.
@@ -119,6 +126,8 @@ struct gzvm_vcpu {
  * @demand_page_buffer: the mailbox for transferring large portion pages
  * @demand_paging_lock: lock for preventing multiple cpu using the same demand
  * page mailbox at the same time
+ * @pinned_pages: use rb-tree to record pin/unpin page
+ * @mem_lock: lock for memory operations
  */
 struct gzvm {
 	struct gzvm_vcpu *vcpus[GZVM_MAX_VCPUS];
@@ -146,6 +155,9 @@ struct gzvm {
 	u32 demand_page_gran;
 	u64 *demand_page_buffer;
 	struct mutex  demand_paging_lock;
+
+	struct rb_root pinned_pages;
+	struct mutex mem_lock;
 };
 
 long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
@@ -178,7 +190,8 @@ int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn);
 int gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn,
 			    u64 *hva_memslot);
 int gzvm_vm_populate_mem_region(struct gzvm *gzvm, int slot_id);
-int gzvm_vm_allocate_guest_page(struct gzvm_memslot *slot, u64 gfn, u64 *pfn);
+int gzvm_vm_allocate_guest_page(struct gzvm *gzvm, struct gzvm_memslot *slot,
+				u64 gfn, u64 *pfn);
 
 int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid);
 int gzvm_arch_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, __u64 reg_id,
-- 
2.18.0


