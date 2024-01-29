Return-Path: <linux-kernel+bounces-42357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A4284003A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56B5B2231E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870975645F;
	Mon, 29 Jan 2024 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jGAbBuYb"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D24254750;
	Mon, 29 Jan 2024 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706517197; cv=none; b=aofGXdDPVkQUJUzYe/ioqt/vjargF0b8zrFzm+YolUi+EkDnb6ZzFj4hADni7xjmXqsWfs9gp5IkmBHNd4PYPGdFku0rFIUrS2A6hw8mnqUwvmJmwNLKgjWAZ+/Bb2BkcA9z9vDWUKb+M/tQG8wbnmeQ5i8KN093QiNsJ0xkV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706517197; c=relaxed/simple;
	bh=D+lw3FjMCC7OE2kEihD42FosGF53M8KXThGuHvCLy/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTZu7bdE1Mxq5TGb8AgoC66lgq2+eld/GZ5v3Y2H7MM5/EHXdrAdNCwdWycq9xqzP9ch3pnQk0KBl4LqrRAMwnJ+9qR8aagpX64ZgOStXlrCkOP5tsDloF9K20Ux46/ned5YhWxaO23IDyAMKr2yrpviitioD+Z+JksjGqkxipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jGAbBuYb; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 074ca176be8111eea2298b7352fd921d-20240129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BV1z6RhlWNg06auDIYk/MDdpCqjlZ59FpMCPjqOKRtU=;
	b=jGAbBuYblAXvhSY4v64dVzIRjJuTYms7CVRqM2NnJId4LgY+FygvuDnanEe7KoFG3uyZ5gqkwqgzLE9v1CU8j1bPmWknL+R1PknhlSPDJ+dXHfRrjDWmyhCljq1iK6LdqzzwlU1ZIfX63XtJTi/jInHiNcPlMW1u7jchP7ARYew=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:f5d1623e-4b76-4505-8bcf-d66654fe7c44,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6e16cf4,CLOUDID:374143fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 074ca176be8111eea2298b7352fd921d-20240129
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1967769698; Mon, 29 Jan 2024 16:33:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
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
	<peilun.suei@mediatek.com>, Liju Chen <liju-clr.chen@mediatek.com>, Willix
 Yeh <chi-shen.yeh@mediatek.com>, Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: [PATCH v9 10/21] virt: geniezone: Add irqchip support for virtual interrupt injection
Date: Mon, 29 Jan 2024 16:32:51 +0800
Message-ID: <20240129083302.26044-11-yi-de.wu@mediatek.com>
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
X-MTK: N

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

Enable GenieZone to handle virtual interrupt injection request.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: kevenny hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/Makefile           |  2 +-
 arch/arm64/geniezone/gzvm_arch_common.h |  4 ++
 arch/arm64/geniezone/vgic.c             | 50 +++++++++++++++
 drivers/virt/geniezone/gzvm_common.h    | 12 ++++
 drivers/virt/geniezone/gzvm_vm.c        | 81 +++++++++++++++++++++++++
 include/linux/gzvm_drv.h                |  4 ++
 include/uapi/linux/gzvm.h               | 66 ++++++++++++++++++++
 7 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/geniezone/vgic.c
 create mode 100644 drivers/virt/geniezone/gzvm_common.h

diff --git a/arch/arm64/geniezone/Makefile b/arch/arm64/geniezone/Makefile
index 69b0a4abeab0..0e4f1087f9de 100644
--- a/arch/arm64/geniezone/Makefile
+++ b/arch/arm64/geniezone/Makefile
@@ -4,6 +4,6 @@
 #
 include $(srctree)/drivers/virt/geniezone/Makefile
 
-gzvm-y += vm.o vcpu.o
+gzvm-y += vm.o vcpu.o vgic.o
 
 obj-$(CONFIG_MTK_GZVM) += gzvm.o
diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 684c35e2d9bc..7b423c1c4549 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -17,6 +17,8 @@ enum {
 	GZVM_FUNC_RUN = 5,
 	GZVM_FUNC_GET_ONE_REG = 8,
 	GZVM_FUNC_SET_ONE_REG = 9,
+	GZVM_FUNC_IRQ_LINE = 10,
+	GZVM_FUNC_CREATE_DEVICE = 11,
 	GZVM_FUNC_PROBE = 12,
 	GZVM_FUNC_ENABLE_CAP = 13,
 	GZVM_FUNC_INFORM_EXIT = 14,
@@ -37,6 +39,8 @@ enum {
 #define MT_HVC_GZVM_RUN			GZVM_HCALL_ID(GZVM_FUNC_RUN)
 #define MT_HVC_GZVM_GET_ONE_REG		GZVM_HCALL_ID(GZVM_FUNC_GET_ONE_REG)
 #define MT_HVC_GZVM_SET_ONE_REG		GZVM_HCALL_ID(GZVM_FUNC_SET_ONE_REG)
+#define MT_HVC_GZVM_IRQ_LINE		GZVM_HCALL_ID(GZVM_FUNC_IRQ_LINE)
+#define MT_HVC_GZVM_CREATE_DEVICE	GZVM_HCALL_ID(GZVM_FUNC_CREATE_DEVICE)
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
 #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
 #define MT_HVC_GZVM_INFORM_EXIT		GZVM_HCALL_ID(GZVM_FUNC_INFORM_EXIT)
diff --git a/arch/arm64/geniezone/vgic.c b/arch/arm64/geniezone/vgic.c
new file mode 100644
index 000000000000..122125f7f8d4
--- /dev/null
+++ b/arch/arm64/geniezone/vgic.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/irqchip/arm-gic-v3.h>
+#include <linux/gzvm.h>
+#include <linux/gzvm_drv.h>
+#include "gzvm_arch_common.h"
+
+int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_DEVICE, vm_id,
+				    virt_to_phys(gzvm_dev), 0, 0, 0, 0, 0,
+				    &res);
+}
+
+/**
+ * gzvm_arch_inject_irq() - Inject virtual interrupt to a VM
+ * @gzvm: Pointer to struct gzvm
+ * @vcpu_idx: vcpu index, only valid if PPI
+ * @irq: *SPI* irq number (excluding offset value `32`)
+ * @level: 1 if true else 0
+ *
+ * Return:
+ * * 0			- Success.
+ * * Negative		- Failure.
+ */
+int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
+			 u32 irq, bool level)
+{
+	unsigned long a1 = assemble_vm_vcpu_tuple(gzvm->vm_id, vcpu_idx);
+	struct arm_smccc_res res;
+
+	/*
+	 * VMM's virtual device irq number starts from 0, but ARM's shared peripheral
+	 * interrupt number starts from 32. hypervisor adds offset 32
+	 */
+	gzvm_hypcall_wrapper(MT_HVC_GZVM_IRQ_LINE, a1, irq, level,
+			     0, 0, 0, 0, &res);
+	if (res.a0) {
+		pr_err("Failed to set IRQ level (%d) to irq#%u on vcpu %d with ret=%d\n",
+		       level, irq, vcpu_idx, (int)res.a0);
+		return -EFAULT;
+	}
+
+	return 0;
+}
diff --git a/drivers/virt/geniezone/gzvm_common.h b/drivers/virt/geniezone/gzvm_common.h
new file mode 100644
index 000000000000..c8d90fee3a18
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_common.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#ifndef __GZ_COMMON_H__
+#define __GZ_COMMON_H__
+
+int gzvm_irqchip_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
+			    u32 irq, bool level);
+
+#endif /* __GZVM_COMMON_H__ */
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index ab5a96400f3c..8d6b7aebaf3a 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/gzvm_drv.h>
+#include "gzvm_common.h"
 
 static DEFINE_MUTEX(gzvm_list_lock);
 static LIST_HEAD(gzvm_list);
@@ -98,6 +99,72 @@ gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
 	return register_memslot_addr_range(gzvm, memslot);
 }
 
+int gzvm_irqchip_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
+			    u32 irq, bool level)
+{
+	return gzvm_arch_inject_irq(gzvm, vcpu_idx, irq, level);
+}
+
+static int gzvm_vm_ioctl_irq_line(struct gzvm *gzvm,
+				  struct gzvm_irq_level *irq_level)
+{
+	u32 irq = irq_level->irq;
+	u32 vcpu_idx, vcpu2_idx, irq_num;
+	bool level = irq_level->level;
+
+	vcpu_idx = FIELD_GET(GZVM_IRQ_LINE_VCPU, irq);
+	vcpu2_idx = FIELD_GET(GZVM_IRQ_LINE_VCPU2, irq) * (GZVM_IRQ_VCPU_MASK + 1);
+	irq_num = FIELD_GET(GZVM_IRQ_LINE_NUM, irq);
+
+	return gzvm_irqchip_inject_irq(gzvm, vcpu_idx + vcpu2_idx, irq_num,
+				       level);
+}
+
+static int gzvm_vm_ioctl_create_device(struct gzvm *gzvm, void __user *argp)
+{
+	struct gzvm_create_device *gzvm_dev;
+	void *dev_data = NULL;
+	int ret;
+
+	gzvm_dev = (struct gzvm_create_device *)alloc_pages_exact(PAGE_SIZE,
+								  GFP_KERNEL);
+	if (!gzvm_dev)
+		return -ENOMEM;
+	if (copy_from_user(gzvm_dev, argp, sizeof(*gzvm_dev))) {
+		ret = -EFAULT;
+		goto err_free_dev;
+	}
+
+	if (gzvm_dev->attr_addr != 0 && gzvm_dev->attr_size != 0) {
+		size_t attr_size = gzvm_dev->attr_size;
+		void __user *attr_addr = (void __user *)gzvm_dev->attr_addr;
+
+		/* Size of device specific data should not be over a page. */
+		if (attr_size > PAGE_SIZE)
+			return -EINVAL;
+
+		dev_data = alloc_pages_exact(attr_size, GFP_KERNEL);
+		if (!dev_data) {
+			ret = -ENOMEM;
+			goto err_free_dev;
+		}
+
+		if (copy_from_user(dev_data, attr_addr, attr_size)) {
+			ret = -EFAULT;
+			goto err_free_dev_data;
+		}
+		gzvm_dev->attr_addr = virt_to_phys(dev_data);
+	}
+
+	ret = gzvm_arch_create_device(gzvm->vm_id, gzvm_dev);
+err_free_dev_data:
+	if (dev_data)
+		free_pages_exact(dev_data, 0);
+err_free_dev:
+	free_pages_exact(gzvm_dev, 0);
+	return ret;
+}
+
 static int gzvm_vm_ioctl_enable_cap(struct gzvm *gzvm,
 				    struct gzvm_enable_cap *cap,
 				    void __user *argp)
@@ -132,6 +199,20 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_vm_ioctl_set_memory_region(gzvm, &userspace_mem);
 		break;
 	}
+	case GZVM_IRQ_LINE: {
+		struct gzvm_irq_level irq_event;
+
+		if (copy_from_user(&irq_event, argp, sizeof(irq_event))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = gzvm_vm_ioctl_irq_line(gzvm, &irq_event);
+		break;
+	}
+	case GZVM_CREATE_DEVICE: {
+		ret = gzvm_vm_ioctl_create_device(gzvm, argp);
+		break;
+	}
 	case GZVM_ENABLE_CAP: {
 		struct gzvm_enable_cap cap;
 
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index 8d4f162903f0..da414c6f81d5 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -122,4 +122,8 @@ int gzvm_arch_vcpu_run(struct gzvm_vcpu *vcpu, __u64 *exit_reason);
 int gzvm_arch_destroy_vcpu(u16 vm_id, int vcpuid);
 int gzvm_arch_inform_exit(u16 vm_id);
 
+int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev);
+int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
+			 u32 irq, bool level);
+
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 9753de18ea5e..2147ef3adf43 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -95,6 +95,72 @@ struct gzvm_userspace_memory_region {
 #define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
 					 struct gzvm_userspace_memory_region)
 
+/* for GZVM_IRQ_LINE, irq field index values */
+#define GZVM_IRQ_VCPU_MASK		0xff
+#define GZVM_IRQ_LINE_TYPE		GENMASK(27, 24)
+#define GZVM_IRQ_LINE_VCPU		GENMASK(23, 16)
+#define GZVM_IRQ_LINE_VCPU2		GENMASK(31, 28)
+#define GZVM_IRQ_LINE_NUM		GENMASK(15, 0)
+
+/* irq_type field */
+#define GZVM_IRQ_TYPE_CPU		0
+#define GZVM_IRQ_TYPE_SPI		1
+#define GZVM_IRQ_TYPE_PPI		2
+
+/* out-of-kernel GIC cpu interrupt injection irq_number field */
+#define GZVM_IRQ_CPU_IRQ		0
+#define GZVM_IRQ_CPU_FIQ		1
+
+struct gzvm_irq_level {
+	union {
+		__u32 irq;
+		__s32 status;
+	};
+	__u32 level;
+};
+
+#define GZVM_IRQ_LINE              _IOW(GZVM_IOC_MAGIC,  0x61, \
+					struct gzvm_irq_level)
+
+enum gzvm_device_type {
+	GZVM_DEV_TYPE_ARM_VGIC_V3_DIST = 0,
+	GZVM_DEV_TYPE_ARM_VGIC_V3_REDIST = 1,
+	GZVM_DEV_TYPE_MAX,
+};
+
+/**
+ * struct gzvm_create_device: For GZVM_CREATE_DEVICE.
+ * @dev_type: Device type.
+ * @id: Device id.
+ * @flags: Bypass to hypervisor to handle them and these are flags of virtual
+ *         devices.
+ * @dev_addr: Device ipa address in VM's view.
+ * @dev_reg_size: Device register range size.
+ * @attr_addr: If user -> kernel, this is user virtual address of device
+ *             specific attributes (if needed). If kernel->hypervisor,
+ *             this is ipa.
+ * @attr_size: This attr_size is the buffer size in bytes of each attribute
+ *             needed from various devices. The attribute here refers to the
+ *             additional data passed from VMM(e.g. Crosvm) to GenieZone
+ *             hypervisor when virtual devices were to be created. Thus,
+ *             we need attr_addr and attr_size in the gzvm_create_device
+ *             structure to keep track of the attribute mentioned.
+ *
+ * Store information needed to create device.
+ */
+struct gzvm_create_device {
+	__u32 dev_type;
+	__u32 id;
+	__u64 flags;
+	__u64 dev_addr;
+	__u64 dev_reg_size;
+	__u64 attr_addr;
+	__u64 attr_size;
+};
+
+#define GZVM_CREATE_DEVICE	   _IOWR(GZVM_IOC_MAGIC,  0xe0, \
+					struct gzvm_create_device)
+
 /*
  * ioctls for vcpu fds
  */
-- 
2.18.0


