Return-Path: <linux-kernel+bounces-12582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587AF81F72F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9AC28148E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB02DDD6;
	Thu, 28 Dec 2023 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mG3fkrk9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED036FAC;
	Thu, 28 Dec 2023 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1d888dd6a56f11ee9e680517dc993faa-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=n25XNA+0vW7SZFQVNg6UCn+aZVR7kT3/JDQu6kF66no=;
	b=mG3fkrk99fSHSqgq9gebtsBnaCXZeqjGR5mG2Il469sr70M3PZCdO40w8R+2s/D7xpuz7A30jyqd/nxjuiGhPvcD+6PTBH5+YzzY1xkcCVlzivQJJjc0z/XtHj/36butIznPFqrTLdewa6JB8jQ8jUwzC2ASgmfgA2GTkoHLoMw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:1c408e22-8b95-4c65-b7ce-9a32db52d3a4,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:90bd942e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 1d888dd6a56f11ee9e680517dc993faa-20231228
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 416231128; Thu, 28 Dec 2023 18:51:55 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 18:51:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 18:51:53 +0800
From: Yi-De Wu <yi-de.wu@mediatek.com>
To: Yingshiuan Pan <yingshiuan.pan@mediatek.com>, Ze-Yu Wang
	<ze-yu.wang@mediatek.com>, Yi-De Wu <yi-de.wu@mediatek.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
	Wihl Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-trace-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, David Bradil <dbrazdil@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>, Jade Shih <jades.shih@mediatek.com>,
	Ivan Tseng <ivan.tseng@mediatek.com>, My Chuang <my.chuang@mediatek.com>,
	Shawn Hsiao <shawn.hsiao@mediatek.com>, PeiLun Suei
	<peilun.suei@mediatek.com>, Liju Chen <liju-clr.chen@mediatek.com>, Willix
 Yeh <chi-shen.yeh@mediatek.com>, Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: [PATCH v8 16/20] virt: geniezone: Add memory pin/unpin support
Date: Thu, 28 Dec 2023 18:51:43 +0800
Message-ID: <20231228105147.13752-17-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231228105147.13752-1-yi-de.wu@mediatek.com>
References: <20231228105147.13752-1-yi-de.wu@mediatek.com>
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
 drivers/virt/geniezone/gzvm_mmu.c | 74 ++++++++++++++++++++++++++++++-
 drivers/virt/geniezone/gzvm_vm.c  | 21 +++++++++
 include/linux/gzvm_drv.h          | 12 +++++
 3 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/geniezone/gzvm_mmu.c b/drivers/virt/geniezone/gzvm_mmu.c
index 1f8471509be2..857cc68f76dc 100644
--- a/drivers/virt/geniezone/gzvm_mmu.c
+++ b/drivers/virt/geniezone/gzvm_mmu.c
@@ -107,8 +107,73 @@ int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn,
 	return 0;
 }
 
+static int cmp_ppages(struct rb_node *node, const struct rb_node *parent)
+{
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
+static int rb_ppage_cmp(const void *key, const struct rb_node *node)
+{
+	struct gzvm_pinned_page *p = container_of(node,
+						  struct gzvm_pinned_page,
+						  node);
+	phys_addr_t ipa = (phys_addr_t)key;
+
+	return (ipa < p->ipa) ? -1 : (ipa > p->ipa);
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
+	gzvm_insert_ppage(vm, ppage);
+	mutex_unlock(&vm->mem_lock);
+
+	return 0;
+}
+
 static int handle_block_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
 {
+	unsigned long hva;
 	u64 pfn, __gfn;
 	int ret, i;
 
@@ -131,6 +196,11 @@ static int handle_block_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
 			goto err_unlock;
 		}
 		vm->demand_page_buffer[i] = pfn;
+
+		hva = gzvm_gfn_to_hva_memslot(&vm->memslot[memslot_id], __gfn);
+		ret = pin_one_page(vm, hva, PFN_PHYS(__gfn));
+		if (ret)
+			goto err_unlock;
 	}
 
 	ret = gzvm_arch_map_guest_block(vm->vm_id, memslot_id, start_gfn,
@@ -148,6 +218,7 @@ static int handle_block_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
 
 static int handle_single_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
 {
+	unsigned long hva;
 	int ret;
 	u64 pfn;
 
@@ -159,7 +230,8 @@ static int handle_single_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
 	if (unlikely(ret))
 		return -EFAULT;
 
-	return 0;
+	hva = gzvm_gfn_to_hva_memslot(&vm->memslot[memslot_id], gfn);
+	return pin_one_page(vm, hva, PFN_PHYS(gfn));
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
index 0a8b21e1ed1a..116d1d7c1562 100644
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
-- 
2.18.0


