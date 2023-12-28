Return-Path: <linux-kernel+bounces-12588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2D881F74E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FB41F20F42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF4D111B5;
	Thu, 28 Dec 2023 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PZxZz7Zu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CDA7479;
	Thu, 28 Dec 2023 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1c1cfae0a56f11eea2298b7352fd921d-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qrJfipjas6Uf7O2d0ZfTYL/+QMhsFtMcy+oq179h6+Q=;
	b=PZxZz7ZuuSt0/QGk1G/sRHWNNxSlZTaq11H9rT/rfr0AmcF6peF7n8bwWvKDHUWkiYa0VGGI1LEJ942l+ef51KbzHpBe8U4h1FUW6+9ax5yPWL7AT0t5u/nMZOAY89cSwlK4bO3XwzI4JQVMJJniMPFdFQs62NYagEm+Yj9XKZU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:b29063fb-fcfc-438a-acb9-84aaaad8d79f,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:5b52aa8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1c1cfae0a56f11eea2298b7352fd921d-20231228
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 606871255; Thu, 28 Dec 2023 18:51:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 18:51:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 18:51:51 +0800
From: Yi-De Wu <yi-de.wu@mediatek.com>
To: Yingshiuan Pan <yingshiuan.pan@mediatek.com>, Ze-Yu Wang
	<ze-yu.wang@mediatek.com>, Yi-De Wu <yi-de.wu@mediatek.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
	Wihl Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
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
	<peilun.suei@mediatek.com>, Liju Chen <liju-clr.chen@mediatek.com>, "Willix
 Yeh" <chi-shen.yeh@mediatek.com>, Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: [PATCH v8 05/20] virt: geniezone: Add set_user_memory_region for vm
Date: Thu, 28 Dec 2023 18:51:32 +0800
Message-ID: <20231228105147.13752-6-yi-de.wu@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.617900-8.000000
X-TMASE-MatchedRID: fwGmInB8JVWzOchXTgjX0fiP3cOw0hARa+E0oS8sctQ9wWQKVyZA290X
	7JEoSZZqFLIbNZhFHP/ybUel2aB0F8CiHTNtFGyJGfRQPgZTkipAGep3G4nlIJjk0EbtghtXEXF
	HklABLo5EctEVwopld9sIe/TXUbL1aTkWqXcVprsMH4SsGvRsA0+fvhSDkQoQCqIJhrrDy2/u9+
	Mep8zDYvACRkuyOuJdsmc8n79ad8wc3SvWQfKYQBlckvO1m+Jcoy/IbUblRdq6pZ/o2Hu2YfLTF
	m7Vc1pIOW2JwPS47C33KeW9X07fzeF/B1jEjV+6syw+ZJnFumTAmOfzKotTomHaXGR9wawUUhps
	+UWERnanCALQ8gkPWEe+SK7YHHNL0orU+fkIj1CimtMQe97AADGZtPrBBPZr0c4jGwXkyPk3Awi
	hR7/Pv+LzNWBegCW2wgn7iDBesS3CttcwYNipX1gO4hFamrGGKC9x+m5PUEdgjB+F66N83Kz0Im
	krcLeZpx7CoOMERVw8x56Ek0dvTx1S6tO1XCP8Pi2zDitBEZfYqPsY6OPx51ylY0EgWQiBdmtRs
	RmKkASJZPT2ZDPuzPD2QfzMDLjhIh26TkmSN3fAvpLE+mvX8g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.617900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	FC518BB9C1EDE568F5BC9E1DE6AE04126D534E5D2BD318EAFB14B420CB4B54C72000:8
X-MTK: N

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

Direct use of physical memory from VMs is forbidden and designed to be
dictated to the privilege models managed by GenieZone hypervisor for
security reason. With the help of gzvm-ko, the hypervisor would be able
to manipulate memory as objects. And the memory management is highly
integrated with ARM 2-stage translation tables to convert VA to IPA to
PA under proper security measures required by protected VMs.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |   2 +
 arch/arm64/geniezone/vm.c               |   9 ++
 drivers/virt/geniezone/Makefile         |   1 -
 drivers/virt/geniezone/gzvm_vm.c        | 110 ++++++++++++++++++++++++
 include/linux/gzvm_drv.h                |  44 ++++++++++
 include/uapi/linux/gzvm.h               |  26 ++++++
 6 files changed, 191 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index fdaa7849353d..2f66e496dfae 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -11,6 +11,7 @@
 enum {
 	GZVM_FUNC_CREATE_VM = 0,
 	GZVM_FUNC_DESTROY_VM = 1,
+	GZVM_FUNC_SET_MEMREGION = 4,
 	GZVM_FUNC_PROBE = 12,
 	NR_GZVM_FUNC,
 };
@@ -23,6 +24,7 @@ enum {
 
 #define MT_HVC_GZVM_CREATE_VM		GZVM_HCALL_ID(GZVM_FUNC_CREATE_VM)
 #define MT_HVC_GZVM_DESTROY_VM		GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VM)
+#define MT_HVC_GZVM_SET_MEMREGION	GZVM_HCALL_ID(GZVM_FUNC_SET_MEMREGION)
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
 
 /**
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index a15bad13c2ee..998d6498ac5e 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -49,6 +49,15 @@ int gzvm_arch_probe(void)
 	return 0;
 }
 
+int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
+			    phys_addr_t region)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_SET_MEMREGION, vm_id,
+				    buf_size, region, 0, 0, 0, 0, &res);
+}
+
 /**
  * gzvm_arch_create_vm() - create vm
  * @vm_type: VM type. Only supports Linux VM now.
diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index 066efddc0b9c..25614ea3dea2 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -7,4 +7,3 @@
 GZVM_DIR ?= ../../../drivers/virt/geniezone
 
 gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o
-
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index d5e850af924a..326cc9e93d92 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -15,6 +15,115 @@
 static DEFINE_MUTEX(gzvm_list_lock);
 static LIST_HEAD(gzvm_list);
 
+u64 gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn)
+{
+	u64 offset = gfn - memslot->base_gfn;
+
+	return memslot->userspace_addr + offset * PAGE_SIZE;
+}
+
+/**
+ * register_memslot_addr_range() - Register memory region to GenieZone
+ * @gzvm: Pointer to struct gzvm
+ * @memslot: Pointer to struct gzvm_memslot
+ *
+ * Return: 0 for success, negative number for error
+ */
+static int
+register_memslot_addr_range(struct gzvm *gzvm, struct gzvm_memslot *memslot)
+{
+	struct gzvm_memory_region_ranges *region;
+	u32 buf_size = PAGE_SIZE * 2;
+	u64 gfn;
+
+	region = alloc_pages_exact(buf_size, GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	region->slot = memslot->slot_id;
+	region->total_pages = memslot->npages;
+	gfn = memslot->base_gfn;
+	region->gpa = PFN_PHYS(gfn);
+
+	if (gzvm_arch_set_memregion(gzvm->vm_id, buf_size,
+				    virt_to_phys(region))) {
+		pr_err("Failed to register memregion to hypervisor\n");
+		free_pages_exact(region, buf_size);
+		return -EFAULT;
+	}
+
+	free_pages_exact(region, buf_size);
+	return 0;
+}
+
+/**
+ * gzvm_vm_ioctl_set_memory_region() - Set memory region of guest
+ * @gzvm: Pointer to struct gzvm.
+ * @mem: Input memory region from user.
+ *
+ * Return: 0 for success, negative number for error
+ *
+ * -EXIO		- The memslot is out-of-range
+ * -EFAULT		- Cannot find corresponding vma
+ * -EINVAL		- Region size and VMA size mismatch
+ */
+static int
+gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
+				struct gzvm_userspace_memory_region *mem)
+{
+	struct vm_area_struct *vma;
+	struct gzvm_memslot *memslot;
+	unsigned long size;
+	__u32 slot;
+
+	slot = mem->slot;
+	if (slot >= GZVM_MAX_MEM_REGION)
+		return -ENXIO;
+	memslot = &gzvm->memslot[slot];
+
+	vma = vma_lookup(gzvm->mm, mem->userspace_addr);
+	if (!vma)
+		return -EFAULT;
+
+	size = vma->vm_end - vma->vm_start;
+	if (size != mem->memory_size)
+		return -EINVAL;
+
+	memslot->base_gfn = __phys_to_pfn(mem->guest_phys_addr);
+	memslot->npages = size >> PAGE_SHIFT;
+	memslot->userspace_addr = mem->userspace_addr;
+	memslot->vma = vma;
+	memslot->flags = mem->flags;
+	memslot->slot_id = mem->slot;
+	return register_memslot_addr_range(gzvm, memslot);
+}
+
+/* gzvm_vm_ioctl() - Ioctl handler of VM FD */
+static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
+			  unsigned long arg)
+{
+	long ret;
+	void __user *argp = (void __user *)arg;
+	struct gzvm *gzvm = filp->private_data;
+
+	switch (ioctl) {
+	case GZVM_SET_USER_MEMORY_REGION: {
+		struct gzvm_userspace_memory_region userspace_mem;
+
+		if (copy_from_user(&userspace_mem, argp, sizeof(userspace_mem))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = gzvm_vm_ioctl_set_memory_region(gzvm, &userspace_mem);
+		break;
+	}
+	default:
+		ret = -ENOTTY;
+	}
+out:
+	return ret;
+}
+
 static void gzvm_destroy_vm(struct gzvm *gzvm)
 {
 	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);
@@ -42,6 +151,7 @@ static int gzvm_vm_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations gzvm_vm_fops = {
 	.release        = gzvm_vm_release,
+	.unlocked_ioctl = gzvm_vm_ioctl,
 	.llseek		= noop_llseek,
 };
 
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index f1dce23838e4..aa1eaf4d43b4 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -7,9 +7,16 @@
 #define __GZVM_DRV_H__
 
 #include <linux/list.h>
+#include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/gzvm.h>
 
+/*
+ * For the normal physical address, the highest 12 bits should be zero, so we
+ * can mask bit 62 ~ bit 52 to indicate the error physical address
+ */
+#define GZVM_PA_ERR_BAD (0x7ffULL << 52)
+
 #define INVALID_VM_ID   0xffff
 
 /*
@@ -27,10 +34,39 @@
  * The following data structures are for data transferring between driver and
  * hypervisor, and they're aligned with hypervisor definitions
  */
+#define GZVM_MAX_MEM_REGION	10
+
+/* struct mem_region_addr_range - Identical to ffa memory constituent */
+struct mem_region_addr_range {
+	/* the base IPA of the constituent memory region, aligned to 4 kiB */
+	__u64 address;
+	/* the number of 4 kiB pages in the constituent memory region. */
+	__u32 pg_cnt;
+	__u32 reserved;
+};
+
+struct gzvm_memory_region_ranges {
+	__u32 slot;
+	__u32 constituent_cnt;
+	__u64 total_pages;
+	__u64 gpa;
+	struct mem_region_addr_range constituents[];
+};
+
+/* struct gzvm_memslot - VM's memory slot descriptor */
+struct gzvm_memslot {
+	u64 base_gfn;			/* begin of guest page frame */
+	unsigned long npages;		/* number of pages this slot covers */
+	unsigned long userspace_addr;	/* corresponding userspace va */
+	struct vm_area_struct *vma;	/* vma related to this userspace addr */
+	u32 flags;
+	u32 slot_id;
+};
 
 struct gzvm {
 	/* userspace tied to this vm */
 	struct mm_struct *mm;
+	struct gzvm_memslot memslot[GZVM_MAX_MEM_REGION];
 	/* lock for list_add*/
 	struct mutex lock;
 	struct list_head vm_list;
@@ -45,7 +81,15 @@ void gzvm_destroy_all_vms(void);
 
 /* arch-dependant functions */
 int gzvm_arch_probe(void);
+int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
+			    phys_addr_t region);
 int gzvm_arch_create_vm(unsigned long vm_type);
 int gzvm_arch_destroy_vm(u16 vm_id);
 
+u64 gzvm_hva_to_pa_arch(u64 hva);
+u64 hva_to_pa_fast(u64 hva);
+u64 hva_to_pa_slow(u64 hva);
+int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn);
+u64 gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn);
+
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index c26c7720fab7..d2d5e6cfc2c9 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -22,4 +22,30 @@
 /* ioctls for /dev/gzvm fds */
 #define GZVM_CREATE_VM             _IO(GZVM_IOC_MAGIC,   0x01) /* Returns a Geniezone VM fd */
 
+/* ioctls for VM fds */
+/* for GZVM_SET_MEMORY_REGION */
+struct gzvm_memory_region {
+	__u32 slot;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	__u64 memory_size; /* bytes */
+};
+
+#define GZVM_SET_MEMORY_REGION     _IOW(GZVM_IOC_MAGIC,  0x40, \
+					struct gzvm_memory_region)
+
+/* for GZVM_SET_USER_MEMORY_REGION */
+struct gzvm_userspace_memory_region {
+	__u32 slot;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	/* bytes */
+	__u64 memory_size;
+	/* start of the userspace allocated memory */
+	__u64 userspace_addr;
+};
+
+#define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
+					 struct gzvm_userspace_memory_region)
+
 #endif /* __GZVM_H__ */
-- 
2.18.0


