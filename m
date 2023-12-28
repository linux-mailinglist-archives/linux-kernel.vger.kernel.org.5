Return-Path: <linux-kernel+bounces-12586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13D381F73E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5510B280F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEE1101F3;
	Thu, 28 Dec 2023 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="isLr03WP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2D7464;
	Thu, 28 Dec 2023 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1ceb9b5ca56f11eea2298b7352fd921d-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Uz3Lmqt9nM07fllAbBHWkxH3IhdfWBztqPzFt5JQXNk=;
	b=isLr03WPvznStB6y5cQ8qJYJ+RJA3uWzRmpIdh1bYU+soTdhDK1Ecxvpn323ekkOOCyXSQMj04T+YOgX1MEvYw711iYsOAUH0ReHKxsJj05AndED+znQ+I4dR+S26akUnSJJEzwsmZgV1FNulPR8ZbxDDUeQEoH3yJKhZcJsGH8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:809e5bb1-05d6-4831-a447-63e167791cd5,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:4869c37e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1ceb9b5ca56f11eea2298b7352fd921d-20231228
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 416938954; Thu, 28 Dec 2023 18:51:54 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
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
Subject: [PATCH v8 15/20] virt: geniezone: Add block-based demand paging support
Date: Thu, 28 Dec 2023 18:51:42 +0800
Message-ID: <20231228105147.13752-16-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231228105147.13752-1-yi-de.wu@mediatek.com>
References: <20231228105147.13752-1-yi-de.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

To balance memory usage and performance, GenieZone supports larger
granularity demand paging, called block-based demand paging.
Gzvm driver uses enable_cap to query the hypervisor if it supports
block-based demand paging and the given granularity or not. Meanwhile,
the gzvm driver allocates a shared buffer for storing the physical
pages later.

If the hypervisor supports, every time the gzvm driver handles guest
page faults, it allocates more memory in advance (default: 2MB) for
demand paging. And fills those physical pages into the allocated shared
memory, then calls the hypervisor to map to guest's memory.

The physical pages allocated for block-based demand paging is not
necessary to be contiguous because in many cases, 2MB block is not
followed. 1st, the memory is allocated because of VMM's page fault
(VMM loads kernel image to guest memory before running). In this case,
the page is allocated by the host kernel and using PAGE_SIZE. 2nd is
that guest may return memory to host via ballooning and that is still
4KB (or PAGE_SIZE) granularity. Therefore, we do not have to allocate
physically contiguous 2MB pages.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |  2 +
 arch/arm64/geniezone/vm.c               | 19 ++++++++--
 drivers/virt/geniezone/gzvm_mmu.c       | 44 +++++++++++++++++++++-
 drivers/virt/geniezone/gzvm_vm.c        | 49 +++++++++++++++++++++++++
 include/linux/gzvm_drv.h                | 16 ++++++++
 include/uapi/linux/gzvm.h               |  2 +
 6 files changed, 128 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 1f0c7a3fede8..07c5e2df7a74 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -25,6 +25,7 @@ enum {
 	GZVM_FUNC_MEMREGION_PURPOSE = 15,
 	GZVM_FUNC_SET_DTB_CONFIG = 16,
 	GZVM_FUNC_MAP_GUEST = 17,
+	GZVM_FUNC_MAP_GUEST_BLOCK = 18,
 	NR_GZVM_FUNC,
 };
 
@@ -50,6 +51,7 @@ enum {
 #define MT_HVC_GZVM_MEMREGION_PURPOSE	GZVM_HCALL_ID(GZVM_FUNC_MEMREGION_PURPOSE)
 #define MT_HVC_GZVM_SET_DTB_CONFIG	GZVM_HCALL_ID(GZVM_FUNC_SET_DTB_CONFIG)
 #define MT_HVC_GZVM_MAP_GUEST		GZVM_HCALL_ID(GZVM_FUNC_MAP_GUEST)
+#define MT_HVC_GZVM_MAP_GUEST_BLOCK	GZVM_HCALL_ID(GZVM_FUNC_MAP_GUEST_BLOCK)
 
 #define GIC_V3_NR_LRS			16
 
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index ecc43bcc2705..e709872e3dfe 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -325,10 +325,11 @@ static int gzvm_vm_ioctl_cap_pvm(struct gzvm *gzvm,
 		fallthrough;
 	case GZVM_CAP_PVM_SET_PROTECTED_VM:
 		/*
-		 * To improve performance for protected VM, we have to populate VM's memory
-		 * before VM booting
+		 * If the hypervisor doesn't support block-based demand paging, we
+		 * populate memory in advance to improve performance for protected VM.
 		 */
-		populate_mem_region(gzvm);
+		if (gzvm->demand_page_gran == PAGE_SIZE)
+			populate_mem_region(gzvm);
 		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);
 		return ret;
 	case GZVM_CAP_PVM_GET_PVMFW_SIZE:
@@ -345,12 +346,16 @@ int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  void __user *argp)
 {
+	struct arm_smccc_res res = {0};
 	int ret;
 
 	switch (cap->cap) {
 	case GZVM_CAP_PROTECTED_VM:
 		ret = gzvm_vm_ioctl_cap_pvm(gzvm, cap, argp);
 		return ret;
+	case GZVM_CAP_BLOCK_BASED_DEMAND_PAGING:
+		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);
+		return ret;
 	default:
 		break;
 	}
@@ -391,3 +396,11 @@ int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
 	return gzvm_hypcall_wrapper(MT_HVC_GZVM_MAP_GUEST, vm_id, memslot_id,
 				    pfn, gfn, nr_pages, 0, 0, &res);
 }
+
+int gzvm_arch_map_guest_block(u16 vm_id, int memslot_id, u64 gfn, u64 nr_pages)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_MAP_GUEST_BLOCK, vm_id,
+				    memslot_id, gfn, nr_pages, 0, 0, 0, &res);
+}
diff --git a/drivers/virt/geniezone/gzvm_mmu.c b/drivers/virt/geniezone/gzvm_mmu.c
index e6415baa064d..1f8471509be2 100644
--- a/drivers/virt/geniezone/gzvm_mmu.c
+++ b/drivers/virt/geniezone/gzvm_mmu.c
@@ -107,6 +107,45 @@ int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn,
 	return 0;
 }
 
+static int handle_block_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
+{
+	u64 pfn, __gfn;
+	int ret, i;
+
+	u32 nr_entries = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE;
+	struct gzvm_memslot *memslot = &vm->memslot[memslot_id];
+	u64 start_gfn = ALIGN_DOWN(gfn, nr_entries);
+	u32 total_pages = memslot->npages;
+	u64 base_gfn = memslot->base_gfn;
+
+	/* if the demand region is less than a block, adjust the nr_entries */
+	if (start_gfn + nr_entries > base_gfn + total_pages)
+		nr_entries = base_gfn + total_pages - start_gfn;
+
+	mutex_lock(&vm->demand_paging_lock);
+	for (i = 0, __gfn = start_gfn; i < nr_entries; i++, __gfn++) {
+		ret = gzvm_gfn_to_pfn_memslot(&vm->memslot[memslot_id], __gfn,
+					      &pfn);
+		if (unlikely(ret)) {
+			ret = -ERR_FAULT;
+			goto err_unlock;
+		}
+		vm->demand_page_buffer[i] = pfn;
+	}
+
+	ret = gzvm_arch_map_guest_block(vm->vm_id, memslot_id, start_gfn,
+					nr_entries);
+	if (unlikely(ret)) {
+		ret = -EFAULT;
+		goto err_unlock;
+	}
+
+err_unlock:
+	mutex_unlock(&vm->demand_paging_lock);
+
+	return ret;
+}
+
 static int handle_single_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
 {
 	int ret;
@@ -143,5 +182,8 @@ int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu)
 	if (unlikely(memslot_id < 0))
 		return -EFAULT;
 
-	return handle_single_demand_page(vm, memslot_id, gfn);
+	if (vm->demand_page_gran == PAGE_SIZE)
+		return handle_single_demand_page(vm, memslot_id, gfn);
+	else
+		return handle_block_demand_page(vm, memslot_id, gfn);
 }
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 9f7e44521de5..485d1e2097aa 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -294,6 +294,8 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 
 static void gzvm_destroy_vm(struct gzvm *gzvm)
 {
+	size_t allocated_size;
+
 	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);
 
 	mutex_lock(&gzvm->lock);
@@ -306,6 +308,11 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 	list_del(&gzvm->vm_list);
 	mutex_unlock(&gzvm_list_lock);
 
+	if (gzvm->demand_page_buffer) {
+		allocated_size = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE * sizeof(u64);
+		free_pages_exact(gzvm->demand_page_buffer, allocated_size);
+	}
+
 	mutex_unlock(&gzvm->lock);
 
 	kfree(gzvm);
@@ -325,6 +332,46 @@ static const struct file_operations gzvm_vm_fops = {
 	.llseek		= noop_llseek,
 };
 
+/**
+ * setup_vm_demand_paging - Query hypervisor suitable demand page size and set
+ * @vm: gzvm instance for setting up demand page size
+ *
+ * Return: void
+ */
+static void setup_vm_demand_paging(struct gzvm *vm)
+{
+	u32 buf_size = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE / PAGE_SIZE * sizeof(u64);
+	struct gzvm_enable_cap cap = {0};
+	void *buffer;
+	int ret;
+
+	mutex_init(&vm->demand_paging_lock);
+	buffer = alloc_pages_exact(buf_size, GFP_KERNEL);
+	if (!buffer) {
+		/* Fall back to use default page size for demand paging */
+		vm->demand_page_gran = PAGE_SIZE;
+		vm->demand_page_buffer = NULL;
+		return;
+	}
+
+	cap.cap = GZVM_CAP_BLOCK_BASED_DEMAND_PAGING;
+	cap.args[0] = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE;
+	cap.args[1] = (__u64)virt_to_phys(buffer);
+	/* demand_page_buffer is freed when destroy VM */
+	vm->demand_page_buffer = buffer;
+
+	ret = gzvm_vm_ioctl_enable_cap(vm, &cap, NULL);
+	if (ret == 0) {
+		vm->demand_page_gran = GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE;
+		/* freed when destroy vm */
+		vm->demand_page_buffer = buffer;
+	} else {
+		vm->demand_page_gran = PAGE_SIZE;
+		vm->demand_page_buffer = NULL;
+		free_pages_exact(buffer, buf_size);
+	}
+}
+
 static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 {
 	int ret;
@@ -358,6 +405,8 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 		return ERR_PTR(ret);
 	}
 
+	setup_vm_demand_paging(gzvm);
+
 	mutex_lock(&gzvm_list_lock);
 	list_add(&gzvm->vm_list, &gzvm_list);
 	mutex_unlock(&gzvm_list_lock);
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index b9e60fe5dcde..0a8b21e1ed1a 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -44,6 +44,8 @@
 
 #define GZVM_VCPU_RUN_MAP_SIZE		(PAGE_SIZE * 2)
 
+#define GZVM_BLOCK_BASED_DEMAND_PAGE_SIZE	(2 * 1024 * 1024) /* 2MB */
+
 /* struct mem_region_addr_range - Identical to ffa memory constituent */
 struct mem_region_addr_range {
 	/* the base IPA of the constituent memory region, aligned to 4 kiB */
@@ -106,6 +108,19 @@ struct gzvm {
 	struct srcu_struct irq_srcu;
 	/* lock for irq injection */
 	struct mutex irq_lock;
+
+	/*
+	 * demand page granularity: how much memory we allocate for VM in a
+	 * single page fault
+	 */
+	u32 demand_page_gran;
+	/* the mailbox for transferring large portion pages */
+	u64 *demand_page_buffer;
+	/*
+	 * lock for preventing multiple cpu using the same demand page mailbox
+	 * at the same time
+	 */
+	struct mutex  demand_paging_lock;
 };
 
 long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
@@ -126,6 +141,7 @@ int gzvm_arch_create_vm(unsigned long vm_type);
 int gzvm_arch_destroy_vm(u16 vm_id);
 int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
 			u64 nr_pages);
+int gzvm_arch_map_guest_block(u16 vm_id, int memslot_id, u64 gfn, u64 nr_pages);
 int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  void __user *argp);
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 1f134c55ac2a..f858b04bf7b9 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -18,6 +18,8 @@
 
 #define GZVM_CAP_VM_GPA_SIZE	0xa5
 #define GZVM_CAP_PROTECTED_VM	0xffbadab1
+/* query hypervisor supported block-based demand page */
+#define GZVM_CAP_BLOCK_BASED_DEMAND_PAGING	0x9201
 
 /* sub-commands put in args[0] for GZVM_CAP_PROTECTED_VM */
 #define GZVM_CAP_PVM_SET_PVMFW_GPA		0
-- 
2.18.0


