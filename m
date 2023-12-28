Return-Path: <linux-kernel+bounces-12596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F47881F769
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16077B212DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46A713AFB;
	Thu, 28 Dec 2023 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PiGcFdH9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7D91094C;
	Thu, 28 Dec 2023 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1d68ff84a56f11eea2298b7352fd921d-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gfo+mnevbXibofurAxG5aBch0aj6GeiAbMqg/MuT0Xw=;
	b=PiGcFdH9xO8GtTh3e3iGvBSWjyusjRPKPl/AavW/psob6vNigwOQmbZ/bakmPXDx63yom4wXvRJjtHRC4fe4TQQKcvJtP8zOiW7K6Vk3vvwSxp5weg5ChYQdvtHGF0ho7ywPdpD7AgAREh3I3bo7L+a84Qrfo/8PLHCyF/IIFzI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:28b2b58c-900e-40b4-96ed-e49c54edcdd0,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:7452aa8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1d68ff84a56f11eea2298b7352fd921d-20231228
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1491263163; Thu, 28 Dec 2023 18:51:54 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
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
Subject: [PATCH v8 07/20] virt: geniezone: Optimize performance of protected VM memory
Date: Thu, 28 Dec 2023 18:51:34 +0800
Message-ID: <20231228105147.13752-8-yi-de.wu@mediatek.com>
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
X-TM-AS-Result: No-10--0.003600-8.000000
X-TMASE-MatchedRID: zE/i+aVSjJsZ6xRDKEbMaNiE0w2W/7Q3/Hd4CUWIS/FpG3YgOhBCuQjF
	DcaUmBsUpS2cZKjpLToO4n8yU3xhRxUBkTmMruyZH5YQyOg71ZZCX8V1FiRRkt9RlPzeVuQQ3oz
	JRX7b4NkmfcNIN7VbRo1dWY54wxAFmllju3jrF/fk7k9yXJiqqqX1XMd/Sqvu/NpLPdn/hpoxus
	Ts+1Wml74pbmY0xUgVJaKl+0U6UWPiimiHGwu19nV7tdtvoibaMApqy5cfknW6pZ/o2Hu2YVJdN
	0iGOn3tTn+fNZkPrPp07/QbLesPz7XelipDxg4WpvwZ9GmdwDPDHSNFHFxB8/EJBoK3pfxusLNr
	5Tqhtfhwgnkk+pd27qURI4lev9W4Lwqc1RzlixdVTfJWlqPdDIVdLK46KrcfYz/3/txqBcCjxYy
	RBa/qJft6/2HgfIgDVymkLM+r7VTKayT/BQTiGjwnJG6y6APDCfuX9gtKKrM/ljJl6wadbvgXwz
	fIgjJpBZqrXzpkhfwJu8n0vSF2OSD6U7ex/HeSXG4zWpB0a4S3kXwPFnmkCYa81qTkNaCydATQd
	tPksR+3/JiWOe6GXXSWgQ2GpXdZhztLVWA1eE9DDKa3G4nrLQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.003600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6995C31FCB2002FA198BF31FD19C7BA351E922BABBC38A8A2CB987D59DE3B20C2000:8
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
 arch/arm64/geniezone/vm.c         | 146 ++++++++++++++++++++++++++++++
 drivers/virt/geniezone/Makefile   |   3 +-
 drivers/virt/geniezone/gzvm_mmu.c | 108 ++++++++++++++++++++++
 3 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/geniezone/gzvm_mmu.c

diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 02f94c86fbf1..e669a63ccac3 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -156,6 +156,122 @@ static int gzvm_vm_ioctl_get_pvmfw_size(struct gzvm *gzvm,
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
+	u64 pfn, prev_pfn, gfn_end;
+	int nr_pages = 1;
+	int i = 0;
+
+	if (unlikely(total_pages == 0))
+		return -EINVAL;
+	gfn_end = gfn + total_pages;
+
+	/* entry 0 */
+	if (gzvm_gfn_to_pfn_memslot(slot, gfn, &pfn) != 0)
+		return -EFAULT;
+	consti[0].address = PFN_PHYS(pfn);
+	consti[0].pg_cnt = 1;
+	gfn++;
+	prev_pfn = pfn;
+
+	while (i < max_nr_consti && gfn < gfn_end) {
+		if (gzvm_gfn_to_pfn_memslot(slot, gfn, &pfn) != 0)
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
+ * populate_mem_region() - Iterate all mem slot and populate pa to buffer until it's full
+ * @gzvm: Pointer to struct gzvm.
+ *
+ * Return: 0 if it is successful, negative if error
+ */
+static int populate_mem_region(struct gzvm *gzvm)
+{
+	int slot_cnt = 0;
+
+	while (slot_cnt < GZVM_MAX_MEM_REGION && gzvm->memslot[slot_cnt].npages != 0) {
+		struct gzvm_memslot *memslot = &gzvm->memslot[slot_cnt];
+		struct gzvm_memory_region_ranges *region;
+		int max_nr_consti, remain_pages;
+		u64 gfn, gfn_end;
+		u32 buf_size;
+
+		buf_size = PAGE_SIZE * 2;
+		region = alloc_pages_exact(buf_size, GFP_KERNEL);
+		if (!region)
+			return -ENOMEM;
+
+		max_nr_consti = (buf_size - sizeof(*region)) /
+				sizeof(struct mem_region_addr_range);
+
+		region->slot = memslot->slot_id;
+		remain_pages = memslot->npages;
+		gfn = memslot->base_gfn;
+		gfn_end = gfn + remain_pages;
+
+		while (gfn < gfn_end) {
+			int nr_pages;
+
+			nr_pages = fill_constituents(region->constituents,
+						     &region->constituent_cnt,
+						     max_nr_consti, gfn,
+						     remain_pages, memslot);
+
+			if (nr_pages < 0) {
+				pr_err("Failed to fill constituents\n");
+				free_pages_exact(region, buf_size);
+				return -EFAULT;
+			}
+
+			region->gpa = PFN_PHYS(gfn);
+			region->total_pages = nr_pages;
+			remain_pages -= nr_pages;
+			gfn += nr_pages;
+
+			if (gzvm_arch_set_memregion(gzvm->vm_id, buf_size,
+						    virt_to_phys(region))) {
+				pr_err("Failed to register memregion to hypervisor\n");
+				free_pages_exact(region, buf_size);
+				return -EFAULT;
+			}
+		}
+		free_pages_exact(region, buf_size);
+		++slot_cnt;
+	}
+	return 0;
+}
+
 /**
  * gzvm_vm_ioctl_cap_pvm() - Proceed GZVM_CAP_PROTECTED_VM's subcommands
  * @gzvm: Pointer to struct gzvm.
@@ -177,6 +293,11 @@ static int gzvm_vm_ioctl_cap_pvm(struct gzvm *gzvm,
 	case GZVM_CAP_PVM_SET_PVMFW_GPA:
 		fallthrough;
 	case GZVM_CAP_PVM_SET_PROTECTED_VM:
+		/*
+		 * To improve performance for protected VM, we have to populate VM's memory
+		 * before VM booting
+		 */
+		populate_mem_region(gzvm);
 		ret = gzvm_vm_arch_enable_cap(gzvm, cap, &res);
 		return ret;
 	case GZVM_CAP_PVM_GET_PVMFW_SIZE:
@@ -205,3 +326,28 @@ int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 
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
index 000000000000..f24fa7e6d975
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_mmu.c
@@ -0,0 +1,108 @@
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
-- 
2.18.0


