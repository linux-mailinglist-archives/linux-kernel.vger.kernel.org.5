Return-Path: <linux-kernel+bounces-42369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A55840077
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D02A5B2378F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFA960EC4;
	Mon, 29 Jan 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ipMcdyo4"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265155E67;
	Mon, 29 Jan 2024 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706517201; cv=none; b=DYm27e3CUbOzleEtpn044G/L6BAjNWtmaS+2lmwttUBQ/65SnJnS+KYcstjRd5p+iPRff2rzFTB5tR+KL0hyuvFVGs/YhQqgqXHEJrjGt+8urdMwPNXTdkZUzAU1OOm++2t+abwBLIOjPkY1df47sNCCn7YR8J/ZQqlACsbUus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706517201; c=relaxed/simple;
	bh=6ViCmhSRorGXUu5ubQd7FkqVR3OghehyclBCnKW/bkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEaZCOd2bU/0h4lqb0i5TgmFVg5rOcYQZHucvhV0D1hOtKaZ3tcHtnzjCvWGRM7+7sOyhpskmrBxy0niE6R8CzESYTtEdTFhb0dd2jIAGKlkNHL5nENHSXXYwqVd9Pq5KYn4bHu+LcmIkICwU1ufIQkK7ZXBzhgxBVOchh2oiDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ipMcdyo4; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 08a570d4be8111ee9e680517dc993faa-20240129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=c+26dMTTSdxbm38+P9yYsT5O7WjTnzxRDdRCBRWTttw=;
	b=ipMcdyo4UMYqnpdD3nOW35iHlQp55OT9RbjCS1oxijBvimzGQZYHkvUOHINBRX6vz0umIz5KR7jxDEd4stQu3Jxj34wRpiOAHekyld79X/ze/Il0+usIvak/1qDImLko7x3q2DtwBvgVWQNTeckGSDo1WCIqxv/gBhSpeR8DGO0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:5a408e21-3900-4919-a125-7b397f783596,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6e16cf4,CLOUDID:c3185e83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 08a570d4be8111ee9e680517dc993faa-20240129
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 843612132; Mon, 29 Jan 2024 16:33:10 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 Jan 2024 16:33:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 29 Jan 2024 16:33:08 +0800
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
	<peilun.suei@mediatek.com>, Liju Chen <liju-clr.chen@mediatek.com>, Willix
 Yeh <chi-shen.yeh@mediatek.com>, Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: [PATCH v9 17/21] virt: geniezone: Add memory pin/unpin support
Date: Mon, 29 Jan 2024 16:32:58 +0800
Message-ID: <20240129083302.26044-18-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240129083302.26044-1-yi-de.wu@mediatek.com>
References: <20240129083302.26044-1-yi-de.wu@mediatek.com>
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
 arch/arm64/geniezone/vm.c         |  8 ++--
 drivers/virt/geniezone/gzvm_mmu.c | 76 ++++++++++++++++++++++++++++---
 drivers/virt/geniezone/gzvm_vm.c  | 21 +++++++++
 include/linux/gzvm_drv.h          | 15 +++++-
 4 files changed, 110 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 1841e3aed363..691e6521cc48 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -195,12 +195,14 @@ static int gzvm_vm_ioctl_get_pvmfw_size(struct gzvm *gzvm,
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
@@ -211,7 +213,7 @@ static int fill_constituents(struct mem_region_addr_range *consti,
 	gfn_end = gfn + total_pages;
 
 	while (i < max_nr_consti && gfn < gfn_end) {
-		if (gzvm_vm_allocate_guest_page(slot, gfn, &pfn) != 0)
+		if (gzvm_vm_allocate_guest_page(gzvm, slot, gfn, &pfn) != 0)
 			return -EFAULT;
 		if (pfn == (prev_pfn + 1)) {
 			consti[i].pg_cnt++;
@@ -268,7 +270,7 @@ int gzvm_vm_populate_mem_region(struct gzvm *gzvm, int slot_id)
 		nr_pages = fill_constituents(region->constituents,
 					     &region->constituent_cnt,
 					     max_nr_consti, gfn,
-					     remain_pages, memslot);
+					     remain_pages, memslot, gzvm);
 
 		if (nr_pages < 0) {
 			pr_err("Failed to fill constituents\n");
diff --git a/drivers/virt/geniezone/gzvm_mmu.c b/drivers/virt/geniezone/gzvm_mmu.c
index 98d296ff9c90..cf619b3833aa 100644
--- a/drivers/virt/geniezone/gzvm_mmu.c
+++ b/drivers/virt/geniezone/gzvm_mmu.c
@@ -107,11 +107,76 @@ int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn,
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
+	hva = gzvm_gfn_to_hva_memslot(slot, gfn);
+	return pin_one_page(vm, hva, PFN_PHYS(gfn));
 }
 
 static int handle_block_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
@@ -131,7 +196,7 @@ static int handle_block_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
 
 	mutex_lock(&vm->demand_paging_lock);
 	for (i = 0, __gfn = start_gfn; i < nr_entries; i++, __gfn++) {
-		ret = gzvm_vm_allocate_guest_page(memslot, __gfn, &pfn);
+		ret = gzvm_vm_allocate_guest_page(vm, memslot, __gfn, &pfn);
 		if (unlikely(ret)) {
 			ret = -ERR_FAULT;
 			goto err_unlock;
@@ -157,15 +222,14 @@ static int handle_single_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
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
index 485d1e2097aa..1af78f161eb3 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -292,6 +292,22 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
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
@@ -315,6 +331,9 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 
 	mutex_unlock(&gzvm->lock);
 
+	/* No need to lock here becauese it's single-threaded execution */
+	gzvm_destroy_all_ppage(gzvm);
+
 	kfree(gzvm);
 }
 
@@ -390,6 +409,8 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 	gzvm->vm_id = ret;
 	gzvm->mm = current->mm;
 	mutex_init(&gzvm->lock);
+	mutex_init(&gzvm->mem_lock);
+	gzvm->pinned_pages = RB_ROOT;
 
 	ret = gzvm_vm_irqfd_init(gzvm);
 	if (ret) {
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index b537f71465e7..bb47de2cf5a2 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/gzvm.h>
 #include <linux/srcu.h>
+#include <linux/rbtree.h>
 
 /*
  * For the normal physical address, the highest 12 bits should be zero, so we
@@ -82,6 +83,12 @@ struct gzvm_vcpu {
 	struct gzvm_vcpu_hwstate *hwstate;
 };
 
+struct gzvm_pinned_page {
+	struct rb_node node;
+	struct page *page;
+	u64 ipa;
+};
+
 struct gzvm {
 	struct gzvm_vcpu *vcpus[GZVM_MAX_VCPUS];
 	/* userspace tied to this vm */
@@ -121,6 +128,11 @@ struct gzvm {
 	 * at the same time
 	 */
 	struct mutex  demand_paging_lock;
+
+	/* Use rb-tree to record pin/unpin page */
+	struct rb_root pinned_pages;
+	/* lock for memory operations */
+	struct mutex mem_lock;
 };
 
 long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
@@ -152,7 +164,8 @@ u64 hva_to_pa_slow(u64 hva);
 int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn);
 u64 gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn);
 int gzvm_vm_populate_mem_region(struct gzvm *gzvm, int slot_id);
-int gzvm_vm_allocate_guest_page(struct gzvm_memslot *slot, u64 gfn, u64 *pfn);
+int gzvm_vm_allocate_guest_page(struct gzvm *gzvm, struct gzvm_memslot *slot,
+				u64 gfn, u64 *pfn);
 
 int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid);
 int gzvm_arch_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, __u64 reg_id,
-- 
2.18.0


