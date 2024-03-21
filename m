Return-Path: <linux-kernel+bounces-109607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61444881B58
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853BF1C21535
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194958C0A;
	Thu, 21 Mar 2024 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rcE+o6Ra"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D242900;
	Thu, 21 Mar 2024 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710989612; cv=none; b=iVrC67fiIyNxLI9fspeW1Jlzwm7R1PKFHWZQBHzUMxCt1iSFHZP4qu60TF8WlzyYCZ1ZXHKp61//pJaP/BXW+mWAZRBJ+JPAdyCSs+fwWmMeL3Abzs9s03lYYN+aX9hengNHr9EZdS9OdgzmPquWX+VWeVjhX8Ld1JfN0RWOcJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710989612; c=relaxed/simple;
	bh=eo+ILn1yVL+eUHddicreGPPV2axiQWDRLrtq0wEfMHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BejmYFAn3D9912bTO5Nj6Q7T10gmCyZurPgPgccu07cDZOKnqJ4epGmrYEunAmne1keIDE1qy530+KPlqA4nYiqEVG6Q3dFeo8XxwN/Uz2ehz/U3k6sQ7qpVQ+mSg0tRN7DD8B7JXyijbDJD2WMxx4RV6r9MDqYoJmOSJcU9CPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rcE+o6Ra; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710989605; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=X8tD7UvfXBzWvm9Y4f3XbRl4iyNBOMkrLc/z+hoj+zo=;
	b=rcE+o6RaarqxMLOU+wTXo+9SNg4OcVn/VqVNGu/Jy3PVCr+4b7XQFfwwWwwV+GNo5R4QP0IimVqMWXqteenmBnmwfUvYIvtEdQVntSpzKJfRqGzKPub9fNd+ZuNATnPrjYYoPbCaKmsSdFiUtF0Ou0QLlIIGkdz9iWKfzxDMUAI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W2zFIEa_1710989603;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W2zFIEa_1710989603)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 10:53:25 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	lenb@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	linux-edac@vger.kernel.org
Cc: tianruidond@linux.alibaba.com,
	Tyler Baicar <baicar@os.amperecomputing.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH v2 1/2] ACPI/AEST: Initial AEST driver
Date: Thu, 21 Mar 2024 10:53:16 +0800
Message-Id: <20240321025317.114621-2-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240321025317.114621-1-tianruidong@linux.alibaba.com>
References: <20240321025317.114621-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tyler Baicar <baicar@os.amperecomputing.com>

Add support for parsing the ARM Error Source Table and basic handling of
errors reported through both memory mapped and system register interfaces.

Assume system register interfaces are only registered with private
peripheral interrupts (PPIs); otherwise there is no guarantee the
core handling the error is the core which took the error and has the
syndrome info in its system registers.

In kernel-first mode, all configuration is controlled by kernel, include
CE ce_threshold and interrupt enable/disable.

All detected errors will be processed as follow:
  - CE, DE: use a workqueue to log this hardware errors.
  - UER, UEO: log it and call memory_failure in workquee.
  - UC, UEU: panic in irq context.

Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 MAINTAINERS                  |  11 +
 arch/arm64/include/asm/ras.h |  71 +++
 drivers/acpi/arm64/Kconfig   |  10 +
 drivers/acpi/arm64/Makefile  |   1 +
 drivers/acpi/arm64/aest.c    | 834 +++++++++++++++++++++++++++++++++++
 include/linux/acpi_aest.h    |  92 ++++
 include/linux/cpuhotplug.h   |   1 +
 7 files changed, 1020 insertions(+)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 include/linux/acpi_aest.h

diff --git a/MAINTAINERS b/MAINTAINERS
index dd5de540ec0b..34900d4bb677 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -330,6 +330,17 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/acpi/arm64
 
+ACPI AEST
+M:	Tyler Baicar <baicar@os.amperecomputing.com>
+M:	Ruidong Tian <tianruidond@linux.alibaba.com>
+L:	linux-acpi@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Supported
+F:	arch/arm64/include/asm/ras.h
+F:	drivers/acpi/arm64/aest.c
+F:	include/linux/acpi_aest.h
+
+
 ACPI FOR RISC-V (ACPI/riscv)
 M:	Sunil V L <sunilvl@ventanamicro.com>
 L:	linux-acpi@vger.kernel.org
diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
new file mode 100644
index 000000000000..04667f0de30f
--- /dev/null
+++ b/arch/arm64/include/asm/ras.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_RAS_H
+#define __ASM_RAS_H
+
+#include <linux/types.h>
+#include <linux/bits.h>
+
+/* ERR<n>FR */
+#define ERR_FR_RP                      BIT(15)
+#define ERR_FR_CEC                     GENMASK_ULL(14, 12)
+
+#define ERR_FR_RP_SINGLE_COUNTER       0
+#define ERR_FR_RP_DOUBLE_COUNTER       1
+
+#define ERR_FR_CEC_0B_COUNTER          0
+#define ERR_FR_CEC_8B_COUNTER          BIT(1)
+#define ERR_FR_CEC_16B_COUNTER         BIT(2)
+
+/* ERR<n>STATUS */
+#define ERR_STATUS_AV		BIT(31)
+#define ERR_STATUS_V		BIT(30)
+#define ERR_STATUS_UE		BIT(29)
+#define ERR_STATUS_ER		BIT(28)
+#define ERR_STATUS_OF		BIT(27)
+#define ERR_STATUS_MV		BIT(26)
+#define ERR_STATUS_CE		(BIT(25) | BIT(24))
+#define ERR_STATUS_DE		BIT(23)
+#define ERR_STATUS_PN		BIT(22)
+#define ERR_STATUS_UET		(BIT(21) | BIT(20))
+#define ERR_STATUS_CI		BIT(19)
+#define ERR_STATUS_IERR		GENMASK_ULL(15, 8)
+#define ERR_STATUS_SERR		GENMASK_ULL(7, 0)
+
+/* These bit is write-one-to-clear */
+#define ERR_STATUS_W1TC		(ERR_STATUS_AV | ERR_STATUS_V | ERR_STATUS_UE | \
+				ERR_STATUS_ER | ERR_STATUS_OF | ERR_STATUS_MV | \
+				ERR_STATUS_CE | ERR_STATUS_DE | ERR_STATUS_PN | \
+				ERR_STATUS_UET | ERR_STATUS_CI)
+
+#define ERR_STATUS_UET_UC	0
+#define ERR_STATUS_UET_UEU	1
+#define ERR_STATUS_UET_UER	2
+#define ERR_STATUS_UET_UEO	3
+
+/* ERR<n>CTLR */
+#define ERR_CTLR_FI		BIT(3)
+#define ERR_CTLR_UI		BIT(2)
+
+/* ERR<n>ADDR */
+#define ERR_ADDR_AI		BIT(61)
+#define ERR_ADDR_PADDR		GENMASK_ULL(55, 0)
+
+/* ERR<n>MISC0 */
+
+/* ERR<n>FR.CEC == 0b010, ERR<n>FR.RP == 0  */
+#define ERR_MISC0_8B_OF		BIT(39)
+#define ERR_MISC0_8B_CEC	GENMASK_ULL(38, 32)
+
+/* ERR<n>FR.CEC == 0b100, ERR<n>FR.RP == 0  */
+#define ERR_MISC0_16B_OF	BIT(47)
+#define ERR_MISC0_16B_CEC	GENMASK_ULL(46, 32)
+
+struct ras_ext_regs {
+	u64 err_fr;
+	u64 err_ctlr;
+	u64 err_status;
+	u64 err_addr;
+	u64 err_misc[4];
+};
+
+#endif	/* __ASM_RAS_H */
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index b3ed6212244c..639db671c5cf 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -21,3 +21,13 @@ config ACPI_AGDI
 
 config ACPI_APMT
 	bool
+
+config ACPI_AEST
+	bool "ARM Error Source Table Support"
+
+	help
+	  The Arm Error Source Table (AEST) provides details on ACPI
+	  extensions that enable kernel-first handling of errors in a
+	  system that supports the Armv8 RAS extensions.
+
+	  If set, the kernel will report and log hardware errors.
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 143debc1ba4a..b5b740058c46 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
 obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
 obj-$(CONFIG_ARM_AMBA)		+= amba.o
 obj-y				+= dma.o init.o
+obj-$(CONFIG_ACPI_AEST) 	+= aest.o
diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
new file mode 100644
index 000000000000..ab17aa5f5997
--- /dev/null
+++ b/drivers/acpi/arm64/aest.c
@@ -0,0 +1,834 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Error Source Table Support
+ *
+ * Copyright (c) 2021, Ampere Computing LLC
+ * Copyright (c) 2021-2024, Alibaba Group.
+ */
+
+#include <linux/acpi.h>
+#include <linux/acpi_aest.h>
+#include <linux/cpuhotplug.h>
+#include <linux/kernel.h>
+#include <linux/genalloc.h>
+#include <linux/llist.h>
+#include <acpi/actbl.h>
+#include <asm/ras.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "ACPI AEST: " fmt
+
+#define CASE_READ(res, x)						\
+	case (x): {							\
+		res = read_sysreg_s(SYS_##x##_EL1);			\
+		break;							\
+	}
+
+#define CASE_WRITE(val, x)						\
+	case (x): {							\
+		write_sysreg_s((val), SYS_##x##_EL1);			\
+		break;							\
+	}
+
+#define for_each_implemented_record(index, node)			\
+		for ((index) = node->interface.record_start;		\
+			(index) < node->interface.record_end;		\
+			(index)++)
+
+#define AEST_LOG_PREFIX_BUFFER	64
+
+/*
+ * This memory pool is only to be used to save AEST node in AEST irq context.
+ * There can be 500 AEST node at most.
+ */
+#define AEST_NODE_ALLOCED_MAX	500
+
+static struct acpi_table_header *aest_table;
+
+static struct aest_node __percpu **aest_ppi_data;
+
+static int *ppi_irqs;
+static u8 num_ppi;
+static u8 ppi_idx;
+
+static struct work_struct aest_work;
+
+static struct gen_pool *aest_node_pool;
+static struct llist_head aest_node_llist;
+
+static u64 aest_sysreg_read(u64 __unused, u32 offset)
+{
+	u64 res;
+
+	switch (offset) {
+	CASE_READ(res, ERXFR)
+	CASE_READ(res, ERXCTLR)
+	CASE_READ(res, ERXSTATUS)
+	CASE_READ(res, ERXADDR)
+	CASE_READ(res, ERXMISC0)
+	CASE_READ(res, ERXMISC1)
+	CASE_READ(res, ERXMISC2)
+	CASE_READ(res, ERXMISC3)
+	default :
+		res = 0;
+	}
+	return res;
+}
+
+static void aest_sysreg_write(u64 base, u32 offset, u64 val)
+{
+	switch (offset) {
+	CASE_WRITE(val, ERXFR)
+	CASE_WRITE(val, ERXCTLR)
+	CASE_WRITE(val, ERXSTATUS)
+	CASE_WRITE(val, ERXADDR)
+	CASE_WRITE(val, ERXMISC0)
+	CASE_WRITE(val, ERXMISC1)
+	CASE_WRITE(val, ERXMISC2)
+	CASE_WRITE(val, ERXMISC3)
+	default :
+		return;
+	}
+}
+
+static u64 aest_iomem_read(u64 base, u32 offset)
+{
+	return readq_relaxed((void *)(base + offset));
+}
+
+static void aest_iomem_write(u64 base, u32 offset, u64 val)
+{
+	writeq_relaxed(val, (void *)(base + offset));
+}
+
+static void aest_print(struct aest_node_llist *lnode)
+{
+	static atomic_t seqno = { 0 };
+	unsigned int curr_seqno;
+	char pfx_seq[AEST_LOG_PREFIX_BUFFER];
+	int index;
+	struct ras_ext_regs *regs;
+
+	curr_seqno = atomic_inc_return(&seqno);
+	snprintf(pfx_seq, sizeof(pfx_seq), "{%u}" HW_ERR, curr_seqno);
+	pr_info("%sHardware error from %s\n", pfx_seq, lnode->node_name);
+
+	switch (lnode->type) {
+	case ACPI_AEST_PROCESSOR_ERROR_NODE:
+		pr_err("%s Error from CPU%d\n", pfx_seq, lnode->id0);
+		break;
+	case ACPI_AEST_MEMORY_ERROR_NODE:
+		pr_err("%s Error from memory at SRAT proximity domain 0x%x\n",
+			pfx_seq, lnode->id0);
+		break;
+	case ACPI_AEST_SMMU_ERROR_NODE:
+		pr_err("%s Error from SMMU IORT node 0x%x subcomponent 0x%x\n",
+			pfx_seq, lnode->id0, lnode->id1);
+		break;
+	case ACPI_AEST_VENDOR_ERROR_NODE:
+		pr_err("%s Error from vendor hid 0x%x uid 0x%x\n",
+			pfx_seq, lnode->id0, lnode->id1);
+		break;
+	case ACPI_AEST_GIC_ERROR_NODE:
+		pr_err("%s Error from GIC type 0x%x instance 0x%x\n",
+			pfx_seq, lnode->id0, lnode->id1);
+		break;
+	default:
+		pr_err("%s Unknown AEST node type\n", pfx_seq);
+		return;
+	}
+
+	index = lnode->index;
+	regs = lnode->regs;
+
+	pr_err("%s  ERR%uFR: 0x%llx\n", pfx_seq, index, regs->err_fr);
+	pr_err("%s  ERR%uCTRL: 0x%llx\n", pfx_seq, index, regs->err_ctlr);
+	pr_err("%s  ERR%uSTATUS: 0x%llx\n", pfx_seq, index, regs->err_status);
+	if (regs->err_status & ERR_STATUS_AV)
+		pr_err("%s  ERR%uADDR: 0x%llx\n", pfx_seq, index, regs->err_addr);
+
+	if (regs->err_status & ERR_STATUS_MV) {
+		pr_err("%s  ERR%uMISC0: 0x%llx\n", pfx_seq, index, regs->err_misc[0]);
+		pr_err("%s  ERR%uMISC1: 0x%llx\n", pfx_seq, index, regs->err_misc[1]);
+		pr_err("%s  ERR%uMISC2: 0x%llx\n", pfx_seq, index, regs->err_misc[2]);
+		pr_err("%s  ERR%uMISC3: 0x%llx\n", pfx_seq, index, regs->err_misc[3]);
+	}
+}
+
+static void aest_handle_memory_failure(struct aest_node_llist *lnode)
+{
+	unsigned long pfn;
+	u64 addr;
+
+	if (test_bit(lnode->index, &lnode->addressing_mode) ||
+		(lnode->regs->err_addr & ERR_ADDR_AI))
+		return;
+
+	addr = lnode->regs->err_addr & (1UL << CONFIG_ARM64_PA_BITS);
+	pfn = PHYS_PFN(addr);
+
+	if (!pfn_valid(pfn)) {
+		pr_warn(HW_ERR "Invalid physical address: %#llx\n", addr);
+		return;
+	}
+
+	memory_failure(pfn, 0);
+}
+
+static void aest_node_pool_process(struct work_struct *__unused)
+{
+	struct llist_node *head;
+	struct aest_node_llist *lnode, *tmp;
+	u64 status;
+
+	head = llist_del_all(&aest_node_llist);
+	if (!head)
+		return;
+
+	head = llist_reverse_order(head);
+	llist_for_each_entry_safe(lnode, tmp, head, llnode) {
+		aest_print(lnode);
+
+		status = lnode->regs->err_status;
+		if ((status & ERR_STATUS_UE) &&
+			(status & ERR_STATUS_UET) > ERR_STATUS_UET_UEU)
+			aest_handle_memory_failure(lnode);
+		gen_pool_free(aest_node_pool, (unsigned long)lnode,
+				sizeof(*lnode));
+	}
+}
+
+static int aest_node_gen_pool_add(struct aest_node *node, int index,
+				struct ras_ext_regs *regs)
+{
+	struct aest_node_llist *list;
+
+	if (!aest_node_pool)
+		return -EINVAL;
+
+	list = (void *)gen_pool_alloc(aest_node_pool, sizeof(*list));
+	if (!list)
+		return -ENOMEM;
+
+	list->type = node->type;
+	list->node_name = node->name;
+	switch (node->type) {
+	case ACPI_AEST_PROCESSOR_ERROR_NODE:
+		list->id0 = node->spec.processor.processor_id;
+		if (node->spec.processor.flags & (ACPI_AEST_PROC_FLAG_SHARED |
+						ACPI_AEST_PROC_FLAG_GLOBAL))
+			list->id0 = smp_processor_id();
+
+		list->id1 = node->spec.processor.resource_type;
+		break;
+	case ACPI_AEST_MEMORY_ERROR_NODE:
+		list->id0 = node->spec.memory.srat_proximity_domain;
+		break;
+	case ACPI_AEST_SMMU_ERROR_NODE:
+		list->id0 = node->spec.smmu.iort_node_reference;
+		list->id1 = node->spec.smmu.subcomponent_reference;
+		break;
+	case ACPI_AEST_VENDOR_ERROR_NODE:
+		list->id0 = node->spec.vendor.acpi_hid;
+		list->id1 = node->spec.vendor.acpi_uid;
+		break;
+	case ACPI_AEST_GIC_ERROR_NODE:
+		list->id0 = node->spec.gic.interface_type;
+		list->id1 = node->spec.gic.instance_id;
+		break;
+	default:
+		list->id0 = 0;
+		list->id1 = 0;
+	}
+
+	list->regs =  regs;
+	list->index = index;
+	list->addressing_mode = node->interface.addressing_mode;
+	llist_add(&list->llnode, &aest_node_llist);
+
+	return 0;
+}
+
+static int aest_node_pool_init(void)
+{
+	unsigned long addr, size;
+	int rc;
+
+	if (aest_node_pool)
+		return 0;
+
+	size = ilog2(sizeof(struct aest_node_llist));
+	aest_node_pool = gen_pool_create(size, -1);
+	if (!aest_node_pool)
+		return -ENOMEM;
+
+	addr = (unsigned long)vmalloc(PAGE_ALIGN(size * AEST_NODE_ALLOCED_MAX));
+	if (!addr)
+		goto err_pool_alloc;
+
+	rc = gen_pool_add(aest_node_pool, addr, size, -1);
+	if (rc)
+		goto err_pool_add;
+
+	return 0;
+
+err_pool_add:
+	vfree((void *)addr);
+
+err_pool_alloc:
+	gen_pool_destroy(aest_node_pool);
+
+	return -ENOMEM;
+}
+
+static void aest_log(struct aest_node *node, int index, struct ras_ext_regs *regs)
+{
+	if (!aest_node_gen_pool_add(node, index, regs))
+		schedule_work(&aest_work);
+}
+
+/*
+ * Each PE may has multi error record, you must selects an error record to
+ * be accessed through the Error Record System registers.
+ */
+static inline void aest_select_record(struct aest_node *node, int i)
+{
+	if (node->interface.type == ACPI_AEST_NODE_SYSTEM_REGISTER) {
+		write_sysreg_s(i, SYS_ERRSELR_EL1);
+		isb();
+	}
+}
+
+/* Ensure all writes has taken effect. */
+static inline void aest_sync(struct aest_node *node)
+{
+	if (node->interface.type == ACPI_AEST_NODE_SYSTEM_REGISTER)
+		isb();
+}
+
+static int aest_proc(struct aest_node *node)
+{
+	struct ras_ext_regs regs = {0};
+	struct aest_access *access;
+	int i, count = 0;
+	u64 regs_p;
+
+	for_each_implemented_record(i, node) {
+
+		/* 1b: Error record at i index is not implemented */
+		if (test_bit(i, &node->interface.record_implemented))
+			continue;
+
+		aest_select_record(node, i);
+
+		access = node->access;
+		regs_p = (u64)&node->interface.regs[i];
+
+		regs.err_status = access->read(regs_p, ERXSTATUS);
+		if (!(regs.err_status & ERR_STATUS_V))
+			continue;
+
+		count++;
+
+		if (regs.err_status & ERR_STATUS_AV)
+			regs.err_addr = access->read(regs_p, ERXADDR);
+
+		regs.err_fr = access->read(regs_p, ERXFR);
+		regs.err_ctlr = access->read(regs_p, ERXCTLR);
+
+		if (regs.err_status & ERR_STATUS_MV) {
+			regs.err_misc[0] = access->read(regs_p, ERXMISC0);
+			regs.err_misc[1] = access->read(regs_p, ERXMISC1);
+			regs.err_misc[2] = access->read(regs_p, ERXMISC2);
+			regs.err_misc[3] = access->read(regs_p, ERXMISC3);
+		}
+
+		if (node->interface.flags & ACPI_AEST_INTERFACE_CLEAR_MISC) {
+			access->write(regs_p, ERXMISC0, 0);
+			access->write(regs_p, ERXMISC1, 0);
+			access->write(regs_p, ERXMISC2, 0);
+			access->write(regs_p, ERXMISC3, 0);
+		} else
+			access->write(regs_p, ERXMISC0,
+					node->interface.ce_threshold[i]);
+
+		aest_log(node, i, &regs);
+
+		/* panic if unrecoverable and uncontainable error encountered */
+		if ((regs.err_status & ERR_STATUS_UE) &&
+			(regs.err_status & ERR_STATUS_UET) < ERR_STATUS_UET_UER)
+			panic("AEST: unrecoverable error encountered");
+
+		/* Write-one-to-clear the bits we've seen */
+		regs.err_status &= ERR_STATUS_W1TC;
+
+		/* Multi bit filed need to write all-ones to clear. */
+		if (regs.err_status & ERR_STATUS_CE)
+			regs.err_status |= ERR_STATUS_CE;
+
+		/* Multi bit filed need to write all-ones to clear. */
+		if (regs.err_status & ERR_STATUS_UET)
+			regs.err_status |= ERR_STATUS_UET;
+
+		access->write(regs_p, ERXSTATUS, regs.err_status);
+
+		aest_sync(node);
+	}
+
+	return count;
+}
+
+static irqreturn_t aest_irq_func(int irq, void *input)
+{
+	struct aest_node *node = input;
+
+	if (aest_proc(node))
+		return IRQ_HANDLED;
+
+	return IRQ_NONE;
+}
+
+static int __init aest_register_gsi(u32 gsi, int trigger, void *data,
+					irq_handler_t aest_irq_func)
+{
+	int cpu, irq;
+
+	irq = acpi_register_gsi(NULL, gsi, trigger, ACPI_ACTIVE_HIGH);
+
+	if (irq == -EINVAL) {
+		pr_err("failed to map AEST GSI %d\n", gsi);
+		return -EINVAL;
+	}
+
+	if (irq_is_percpu_devid(irq)) {
+		ppi_irqs[ppi_idx] = irq;
+		for_each_possible_cpu(cpu) {
+			memcpy(per_cpu_ptr(aest_ppi_data[ppi_idx], cpu), data,
+			       sizeof(struct aest_node));
+		}
+		if (request_percpu_irq(irq, aest_irq_func, "AEST",
+				       aest_ppi_data[ppi_idx++])) {
+			pr_err("failed to register AEST IRQ %d\n", irq);
+			return -EINVAL;
+		}
+	} else {
+		if (request_irq(irq, aest_irq_func, IRQF_SHARED, "AEST",
+				data)) {
+			pr_err("failed to register AEST IRQ %d\n", irq);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int __init aest_init_interrupts(struct acpi_aest_hdr *hdr,
+				       struct aest_node *node)
+{
+	struct acpi_aest_node_interrupt *interrupt;
+	int i, trigger, ret = 0, err_ctlr, regs_p;
+
+	interrupt = ACPI_ADD_PTR(struct acpi_aest_node_interrupt, hdr,
+				 hdr->node_interrupt_offset);
+
+	for (i = 0; i < hdr->node_interrupt_count; i++, interrupt++) {
+		trigger = (interrupt->flags & AEST_INTERRUPT_MODE) ?
+			  ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
+		if (aest_register_gsi(interrupt->gsiv, trigger, node,
+					aest_irq_func))
+			ret = -EINVAL;
+	}
+
+	/* Ensure RAS interrupt is enabled */
+	for_each_implemented_record(i, node) {
+		/* 1b: Error record at i index is not implemented */
+		if (test_bit(i, &node->interface.record_implemented))
+			continue;
+
+		aest_select_record(node, i);
+
+		regs_p = (u64)&node->interface.regs[i];
+
+		err_ctlr = node->access->read(regs_p, ERXCTLR);
+
+		if (interrupt->type == ACPI_AEST_NODE_FAULT_HANDLING)
+			err_ctlr |= ERR_CTLR_FI;
+		if (interrupt->type == ACPI_AEST_NODE_ERROR_RECOVERY)
+			err_ctlr |= ERR_CTLR_UI;
+
+		node->access->write(regs_p, ERXCTLR, err_ctlr);
+
+		aest_sync(node);
+	}
+
+	return ret;
+}
+
+static void __init set_aest_node_name(struct aest_node *node)
+{
+	switch (node->type) {
+	case ACPI_AEST_PROCESSOR_ERROR_NODE:
+		node->name = kasprintf(GFP_KERNEL, "AEST-CPU%d",
+			node->spec.processor.processor_id);
+		break;
+	case ACPI_AEST_MEMORY_ERROR_NODE:
+	case ACPI_AEST_SMMU_ERROR_NODE:
+	case ACPI_AEST_VENDOR_ERROR_NODE:
+	case ACPI_AEST_GIC_ERROR_NODE:
+		node->name = kasprintf(GFP_KERNEL, "AEST-%llx",
+			node->interface.phy_addr);
+		break;
+	default:
+		node->name = kasprintf(GFP_KERNEL, "AEST-Unkown-Node");
+	}
+}
+
+/* access type is decided by AEST interface type. */
+static struct aest_access aest_access[] = {
+	[ACPI_AEST_NODE_SYSTEM_REGISTER] = {
+		.read = aest_sysreg_read,
+		.write = aest_sysreg_write,
+	},
+
+	[ACPI_AEST_NODE_MEMORY_MAPPED] = {
+		.read = aest_iomem_read,
+		.write = aest_iomem_write,
+	},
+	{ }
+};
+
+/* In kernel-first mode, kernel will report every CE by default. */
+static void __init aest_set_ce_threshold(struct aest_node *node)
+{
+	u64 regs_p, err_fr, err_fr_cec, err_fr_rp, err_misc0, ce_threshold;
+	int i;
+
+	for_each_implemented_record(i, node) {
+		/* 1b: Error record at i index is not implemented */
+		if (test_bit(i, &node->interface.record_implemented))
+			continue;
+
+		aest_select_record(node, i);
+		regs_p = (u64)&node->interface.regs[i];
+
+		err_fr = node->access->read(regs_p, ERXFR);
+		err_fr_cec = FIELD_GET(ERR_FR_CEC, err_fr);
+		err_fr_rp = FIELD_GET(ERR_FR_RP, err_fr);
+		err_misc0 = node->access->read(regs_p, ERXMISC0);
+
+		if (err_fr_cec == ERR_FR_CEC_0B_COUNTER)
+			pr_debug("%s-%d do not support CE threshold!\n",
+					node->name, i);
+		else if (err_fr_cec == ERR_FR_CEC_8B_COUNTER &&
+				err_fr_rp == ERR_FR_RP_SINGLE_COUNTER) {
+			pr_debug("%s-%d support 8 bit CE threshold!\n",
+					node->name, i);
+			ce_threshold = err_misc0 | ERR_MISC0_8B_CEC;
+		} else if (err_fr_cec == ERR_FR_CEC_16B_COUNTER &&
+				err_fr_rp == ERR_FR_RP_SINGLE_COUNTER) {
+			pr_debug("%s-%d support 16 bit CE threshold!\n",
+					node->name, i);
+			ce_threshold = err_misc0 | ERR_MISC0_16B_CEC;
+		} else
+			pr_debug("%s-%d do not support double counter yet!\n",
+					node->name, i);
+
+		node->access->write(regs_p, ERXMISC0, ce_threshold);
+		node->interface.ce_threshold[i] = ce_threshold;
+
+		aest_sync(node);
+	}
+}
+
+static int __init aest_init_interface(struct acpi_aest_hdr *hdr,
+				       struct aest_node *node)
+{
+	struct acpi_aest_node_interface *interface;
+	struct resource *res;
+	int size;
+
+	interface = ACPI_ADD_PTR(struct acpi_aest_node_interface, hdr,
+				 hdr->node_interface_offset);
+
+	if (interface->type >= ACPI_AEST_XFACE_RESERVED) {
+		pr_err("invalid interface type: %d\n", interface->type);
+		return -EINVAL;
+	}
+
+	node->interface.type = interface->type;
+	node->interface.phy_addr = interface->address;
+	node->interface.record_start = interface->error_record_index;
+	node->interface.record_end = interface->error_record_index +
+					interface->error_record_count;
+	node->interface.flags = interface->flags;
+	node->interface.record_implemented = interface->error_record_implemented;
+	node->interface.status_reporting = interface->error_status_reporting;
+	node->interface.addressing_mode = interface->addressing_mode;
+	node->access = &aest_access[interface->type];
+
+	/*
+	 * Currently SR based handling is done through the architected
+	 * discovery exposed through SRs. That may change in the future
+	 * if there is supplemental information in the AEST that is
+	 * needed.
+	 */
+	if (interface->type == ACPI_AEST_NODE_SYSTEM_REGISTER)
+		return 0;
+
+	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	size = interface->error_record_count * sizeof(struct ras_ext_regs);
+	res->name = "AEST";
+	res->start = interface->address;
+	res->end = res->start + size;
+	res->flags = IORESOURCE_MEM;
+
+	if (insert_resource(&iomem_resource, res)) {
+		pr_notice("request region conflict with %s\n",
+			res->name);
+	}
+
+	node->interface.regs = ioremap(res->start, size);
+	if (!node->interface.regs) {
+		pr_err("Ioremap for %s failed!\n", node->name);
+		kfree(res);
+		return -EINVAL;
+	}
+
+	node->interface.ce_threshold = kzalloc(sizeof(u64) *
+				interface->error_record_count, GFP_KERNEL);
+	if (!node->interface.ce_threshold)
+		return -ENOMEM;
+
+	aest_set_ce_threshold(node);
+
+	return 0;
+}
+
+static int __init aest_init_common(struct acpi_aest_hdr *hdr,
+						struct aest_node *node)
+{
+	int ret;
+
+	set_aest_node_name(node);
+
+	ret = aest_init_interface(hdr, node);
+	if (ret) {
+		pr_err("failed to init interface\n");
+		return ret;
+	}
+
+	return aest_init_interrupts(hdr, node);
+}
+
+static int __init aest_init_node_default(struct acpi_aest_hdr *hdr)
+{
+	struct aest_node *node;
+	union aest_node_spec *node_spec;
+	int ret;
+
+	node = kzalloc(sizeof(struct aest_node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->type = hdr->type;
+	node_spec = ACPI_ADD_PTR(union aest_node_spec, hdr,
+					hdr->node_specific_offset);
+
+	memcpy(&node->spec, node_spec,
+			hdr->node_interface_offset - hdr->node_specific_offset);
+
+	ret = aest_init_common(hdr, node);
+	if (ret)
+		kfree(node);
+
+	return ret;
+}
+
+static int __init aest_init_processor_node(struct acpi_aest_hdr *hdr)
+{
+	struct aest_node *node;
+	union aest_node_spec *node_spec;
+	union aest_node_processor *proc;
+	int ret;
+
+	node = kzalloc(sizeof(struct aest_node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->type = hdr->type;
+	node_spec = ACPI_ADD_PTR(union aest_node_spec, hdr,
+					hdr->node_specific_offset);
+
+	memcpy(&node->spec, node_spec,
+			hdr->node_interface_offset - hdr->node_specific_offset);
+
+	proc = ACPI_ADD_PTR(union aest_node_processor, node_spec,
+					sizeof(acpi_aest_processor));
+
+	switch (node->spec.processor.resource_type) {
+	case ACPI_AEST_CACHE_RESOURCE:
+		memcpy(&node->proc, proc,
+				sizeof(struct acpi_aest_processor_cache));
+		break;
+	case ACPI_AEST_TLB_RESOURCE:
+		memcpy(&node->proc, proc,
+				sizeof(struct acpi_aest_processor_tlb));
+		break;
+	case ACPI_AEST_GENERIC_RESOURCE:
+		memcpy(&node->proc, proc,
+				sizeof(struct acpi_aest_processor_generic));
+		break;
+	}
+
+	ret = aest_init_common(hdr, node);
+	if (ret)
+		kfree(node);
+
+	return ret;
+}
+
+static int __init aest_init_node(struct acpi_aest_hdr *node)
+{
+	switch (node->type) {
+	case ACPI_AEST_PROCESSOR_ERROR_NODE:
+		return aest_init_processor_node(node);
+	case ACPI_AEST_MEMORY_ERROR_NODE:
+	case ACPI_AEST_VENDOR_ERROR_NODE:
+	case ACPI_AEST_SMMU_ERROR_NODE:
+	case ACPI_AEST_GIC_ERROR_NODE:
+		return aest_init_node_default(node);
+	default:
+		return -EINVAL;
+	}
+}
+
+static void __init aest_count_ppi(struct acpi_aest_hdr *header)
+{
+	struct acpi_aest_node_interrupt *interrupt;
+	int i;
+
+	interrupt = ACPI_ADD_PTR(struct acpi_aest_node_interrupt, header,
+				 header->node_interrupt_offset);
+
+	for (i = 0; i < header->node_interrupt_count; i++, interrupt++) {
+		if (interrupt->gsiv >= 16 && interrupt->gsiv < 32)
+			num_ppi++;
+	}
+}
+
+static int aest_starting_cpu(unsigned int cpu)
+{
+	int i;
+
+	for (i = 0; i < num_ppi; i++)
+		enable_percpu_irq(ppi_irqs[i], IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int aest_dying_cpu(unsigned int cpu)
+{
+	int i;
+
+	for (i = 0; i < num_ppi; i++)
+		disable_percpu_irq(ppi_irqs[i]);
+
+	return 0;
+}
+
+int __init acpi_aest_init(void)
+{
+	struct acpi_aest_hdr *aest_node, *aest_end;
+	struct acpi_table_aest *aest;
+	int i, ret = 0;
+
+	if (acpi_disabled)
+		return 0;
+
+	if (!IS_ENABLED(CONFIG_ARM64_RAS_EXTN))
+		return 0;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_AEST, 0, &aest_table)))
+		return -EINVAL;
+
+	ret = aest_node_pool_init();
+	if (ret) {
+		pr_err("Failed init aest node pool.\n");
+		goto fail;
+	}
+
+	INIT_WORK(&aest_work, aest_node_pool_process);
+
+	aest = (struct acpi_table_aest *)aest_table;
+
+	/* Get the first AEST node */
+	aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
+				 sizeof(struct acpi_table_header));
+	/* Pointer to the end of the AEST table */
+	aest_end = ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
+				aest_table->length);
+
+	while (aest_node < aest_end) {
+		if (((u64)aest_node + aest_node->length) > (u64)aest_end) {
+			pr_err("AEST node pointer overflow, bad table.\n");
+			return -EINVAL;
+		}
+
+		aest_count_ppi(aest_node);
+
+		aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest_node,
+					 aest_node->length);
+	}
+
+	aest_ppi_data = kcalloc(num_ppi, sizeof(struct aest_node_data *),
+				GFP_KERNEL);
+	if (!aest_ppi_data) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	ppi_irqs = kcalloc(num_ppi, sizeof(int), GFP_KERNEL);
+	if (!ppi_irqs) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	for (i = 0; i < num_ppi; i++) {
+		aest_ppi_data[i] = alloc_percpu(struct aest_node);
+		if (!aest_ppi_data[i]) {
+			pr_err("Failed percpu allocation.\n");
+			ret = -ENOMEM;
+			goto fail;
+		}
+	}
+
+	aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
+				 sizeof(struct acpi_table_header));
+
+	while (aest_node < aest_end) {
+		ret = aest_init_node(aest_node);
+		if (ret) {
+			pr_err("failed to init node: %d", ret);
+			goto fail;
+		}
+
+		aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest_node,
+					 aest_node->length);
+	}
+
+
+
+	return cpuhp_setup_state(CPUHP_AP_ARM_AEST_STARTING,
+			  "drivers/acpi/arm64/aest:starting",
+			  aest_starting_cpu, aest_dying_cpu);
+
+fail:
+	for (i = 0; i < num_ppi; i++)
+		free_percpu(aest_ppi_data[i]);
+	kfree(aest_ppi_data);
+	return ret;
+}
+subsys_initcall(acpi_aest_init);
diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
new file mode 100644
index 000000000000..679187505dc6
--- /dev/null
+++ b/include/linux/acpi_aest.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef AEST_H
+#define AEST_H
+
+#include <acpi/actbl.h>
+#include <asm/ras.h>
+
+#define AEST_INTERRUPT_MODE		BIT(0)
+
+#define ACPI_AEST_PROC_FLAG_GLOBAL	(1<<0)
+#define ACPI_AEST_PROC_FLAG_SHARED	(1<<1)
+
+#define ACPI_AEST_INTERFACE_CLEAR_MISC	(1<<0)
+
+#define ERXFR			0x0
+#define ERXCTLR			0x8
+#define ERXSTATUS		0x10
+#define ERXADDR			0x18
+#define ERXMISC0		0x20
+#define ERXMISC1		0x28
+#define ERXMISC2		0x30
+#define ERXMISC3		0x38
+
+struct aest_node_interface {
+	u8 type;
+	u64 phy_addr;
+	u16 record_start;
+	u16 record_end;
+	u32 flags;
+	unsigned long record_implemented;
+	unsigned long status_reporting;
+	unsigned long addressing_mode;
+	struct ras_ext_regs *regs;
+	u64 *ce_threshold;
+};
+
+union aest_node_processor {
+	struct acpi_aest_processor_cache cache_data;
+	struct acpi_aest_processor_tlb tlb_data;
+	struct acpi_aest_processor_generic generic_data;
+};
+
+union aest_node_spec {
+	struct acpi_aest_processor processor;
+	struct acpi_aest_memory memory;
+	struct acpi_aest_smmu smmu;
+	struct acpi_aest_vendor vendor;
+	struct acpi_aest_gic gic;
+};
+
+struct aest_access {
+	u64 (*read)(u64 base, u32 offset);
+	void (*write)(u64 base, u32 offset, u64 val);
+};
+
+struct aest_node {
+	char *name;
+	u8 type;
+	struct aest_node_interface interface;
+	union aest_node_spec spec;
+	union aest_node_processor proc;
+	struct aest_access *access;
+};
+
+struct aest_node_llist {
+	struct llist_node llnode;
+	char *node_name;
+	int type;
+	/*
+	 * Different nodes have different meanings:
+	 *   - Processor node	: processor number.
+	 *   - Memory node	: SRAT proximity domain.
+	 *   - SMMU node	: IORT proximity domain.
+	 *   - Vendor node	: hardware ID.
+	 *   - GIC node		: interface type.
+	 */
+	u32 id0;
+	/*
+	 * Different nodes have different meanings:
+	 *   - Processor node	: processor resource type.
+	 *   - Memory node	: Non.
+	 *   - SMMU node	: subcomponent reference.
+	 *   - Vendor node	: Unique ID.
+	 *   - GIC node		: instance identifier.
+	 */
+	u32 id1;
+	int index;
+	unsigned long addressing_mode;
+	struct ras_ext_regs *regs;
+};
+
+#endif /* AEST_H */
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 624d4a38c358..f0dda08dbad2 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -186,6 +186,7 @@ enum cpuhp_state {
 	CPUHP_AP_CSKY_TIMER_STARTING,
 	CPUHP_AP_TI_GP_TIMER_STARTING,
 	CPUHP_AP_HYPERV_TIMER_STARTING,
+	CPUHP_AP_ARM_AEST_STARTING,
 	/* Must be the last timer callback */
 	CPUHP_AP_DUMMY_TIMER_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
-- 
2.33.1


