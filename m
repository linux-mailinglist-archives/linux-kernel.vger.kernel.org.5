Return-Path: <linux-kernel+bounces-42366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56CA84006C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9031D1C220E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BC4604C8;
	Mon, 29 Jan 2024 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DtajdotY"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9444055E44;
	Mon, 29 Jan 2024 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706517200; cv=none; b=kJ/jyRiFt97BkJdlX8DN2w+hBgbC2utAz1S7Cg1h7U7JklgHSMSrpXXbd0nNFb/2KWPGBzpkgwH5p3s13ETBqvP4eCkZwKMDU4CqFTIV7UAcfuZLj6CNkTmTTw9SA1mXX/yfnGt57qYEPjH2LAtuUoGaPjYB8C1FklPi0in6pHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706517200; c=relaxed/simple;
	bh=LIIFKHUwZr30x3CKXC93mBw9Fbu5evh1vdN5BWZeogU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISmIYHZa0cvSDiD82HmMTStGY1n0Sdro6r37Q0LCIHOeJuTYcvNtN/Y0JQ69Gf2r7voKdWl+/njCJkfjwDsK8kEHIZSae8ccQVuC1m6l9R6+7ltKOYLniXAo9NXNyeWCydMckyzbaRKrPbVX4uMgvxJJ8hdF165cNK7CtkBBHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DtajdotY; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 087936ccbe8111eea2298b7352fd921d-20240129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vJ6SnD9MWpz/gLXXEictIBaqCdlg7dI3la2NXwfkwhU=;
	b=DtajdotYy9MZNQSYqr/AGypdFEbxzk/CxkjgV3ByozB7y2+AMjnNJMDVZNvBRcMe4lcLnscHI+oo3W+7NlWJJnvZYExerRfViyDFveyTTxYuaokYN2JrduI88KBFGvVZQcLKmyyZh3kWed+Jffc/3g3Jtl6fgSf5TZvUjbqWvT4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:eba8fa69-8709-4f76-913b-a60749e96fda,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6e16cf4,CLOUDID:b8185e83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 087936ccbe8111eea2298b7352fd921d-20240129
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1330966115; Mon, 29 Jan 2024 16:33:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
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
	<peilun.suei@mediatek.com>, Liju Chen <liju-clr.chen@mediatek.com>, "Willix
 Yeh" <chi-shen.yeh@mediatek.com>, Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: [PATCH v9 15/21] virt: geniezone: Add demand paging support
Date: Mon, 29 Jan 2024 16:32:56 +0800
Message-ID: <20240129083302.26044-16-yi-de.wu@mediatek.com>
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
X-TM-AS-Result: No-10--17.768100-8.000000
X-TMASE-MatchedRID: oTdiyqBUbz/fN9bhMNhpTUhwlOfYeSqxtDSfcMR+7ZOl4EP+dy+wBFme
	FuNCwtl4vfKrrb4bmIr2in0s6cYY8X45uBZmw209Bg/PsQ7Io2FAq6/y5AEOOlcZNuxCoduSwdk
	C9Ck+1Y6L1LF6ImdQDhd62hU8T8MrhQAimBygnyKEryjhqiyzyitovaaHxlUr70m3PKqB7tGKW8
	BvXyLiE7NGh1y6CuUYYICOfGVBJhkGtTV246rrNLcPsR57JkIzCt59Uh3p/NVnerzbhugqsqmw5
	s23nMRbW+5AYAhakwh8T/TWUlMbt9KK1Pn5CI9QdXu122+iJtq2McZY43zJ423D6f6IpbLISGGK
	QPXm3qarQS40bMqMVoJl/jaG2IOvH3WbO3ydfMICg1rav4R3DY4lnIgC6UzTQQ1XgvCe7sF1j44
	ZYEw/4TbBFkyI1h9E8LlyAg2vp/phfSDU2do4zDTk6JGbrQhuc3ewuwbSaG7FpA1uJFd1mmjd66
	WKC/o1q/mwkeU+RjGG184Y5LIraR8TzIzimOwPC24oEZ6SpSk6XEE7Yhw4FpRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.768100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 7E0E6069382AFDA3521653DFCF99F7BB5D4D28421E2AF609D4AA5BB967BA201F2000:8
X-MTK: N

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

This page fault handler helps GenieZone hypervisor to do demand paging.
On a lower level translation fault, GenieZone hypervisor will first
check the fault GPA (guest physical address or IPA in ARM) is valid
e.g. within the registered memory region, then it will setup the
vcpu_run->exit_reason with necessary information for returning to
gzvm driver.

With the fault information, the gzvm driver looks up the physical
address and call the MT_HVC_GZVM_MAP_GUEST to request the hypervisor
maps the found PA to the fault GPA (IPA).

There is one exception, for protected vm, we will populate full VM's
memory region in advance in order to improve performance.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: kevenny hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |  2 ++
 arch/arm64/geniezone/vm.c               |  9 ++++++
 drivers/virt/geniezone/Makefile         |  4 +--
 drivers/virt/geniezone/gzvm_exception.c | 39 +++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_main.c      |  2 ++
 drivers/virt/geniezone/gzvm_mmu.c       | 38 ++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vcpu.c      |  6 ++--
 drivers/virt/geniezone/gzvm_vm.c        | 25 ++++++++++++++++
 include/linux/gzvm_drv.h                |  7 +++++
 include/uapi/linux/gzvm.h               | 12 ++++++++
 10 files changed, 140 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virt/geniezone/gzvm_exception.c

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index afb91713fc45..1f0c7a3fede8 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -24,6 +24,7 @@ enum {
 	GZVM_FUNC_INFORM_EXIT = 14,
 	GZVM_FUNC_MEMREGION_PURPOSE = 15,
 	GZVM_FUNC_SET_DTB_CONFIG = 16,
+	GZVM_FUNC_MAP_GUEST = 17,
 	NR_GZVM_FUNC,
 };
 
@@ -48,6 +49,7 @@ enum {
 #define MT_HVC_GZVM_INFORM_EXIT		GZVM_HCALL_ID(GZVM_FUNC_INFORM_EXIT)
 #define MT_HVC_GZVM_MEMREGION_PURPOSE	GZVM_HCALL_ID(GZVM_FUNC_MEMREGION_PURPOSE)
 #define MT_HVC_GZVM_SET_DTB_CONFIG	GZVM_HCALL_ID(GZVM_FUNC_SET_DTB_CONFIG)
+#define MT_HVC_GZVM_MAP_GUEST		GZVM_HCALL_ID(GZVM_FUNC_MAP_GUEST)
 
 #define GIC_V3_NR_LRS			16
 
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 41ad1692dd18..a7a8a1bb6388 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -388,3 +388,12 @@ u64 gzvm_hva_to_pa_arch(u64 hva)
 		return GZVM_PA_ERR_BAD;
 	return par;
 }
+
+int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
+			u64 nr_pages)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_MAP_GUEST, vm_id, memslot_id,
+				    pfn, gfn, nr_pages, 0, 0, &res);
+}
diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index 9956f4891df2..2e12870637d5 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -8,5 +8,5 @@ GZVM_DIR ?= ../../../drivers/virt/geniezone
 
 gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o \
 	  $(GZVM_DIR)/gzvm_mmu.o $(GZVM_DIR)/gzvm_vcpu.o \
-	  $(GZVM_DIR)/gzvm_irqfd.o $(GZVM_DIR)/gzvm_ioeventfd.o
-
+	  $(GZVM_DIR)/gzvm_irqfd.o $(GZVM_DIR)/gzvm_ioeventfd.o \
+	  $(GZVM_DIR)/gzvm_exception.o
diff --git a/drivers/virt/geniezone/gzvm_exception.c b/drivers/virt/geniezone/gzvm_exception.c
new file mode 100644
index 000000000000..31fdb4ae8db4
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_exception.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/gzvm_drv.h>
+
+/**
+ * gzvm_handle_guest_exception() - Handle guest exception
+ * @vcpu: Pointer to struct gzvm_vcpu_run in userspace
+ * Return:
+ * * true - This exception has been processed, no need to back to VMM.
+ * * false - This exception has not been processed, require userspace.
+ */
+bool gzvm_handle_guest_exception(struct gzvm_vcpu *vcpu)
+{
+	int ret;
+
+	for (int i = 0; i < ARRAY_SIZE(vcpu->run->exception.reserved); i++) {
+		if (vcpu->run->exception.reserved[i])
+			return -EINVAL;
+	}
+
+	switch (vcpu->run->exception.exception) {
+	case GZVM_EXCEPTION_PAGE_FAULT:
+		ret = gzvm_handle_page_fault(vcpu);
+		break;
+	case GZVM_EXCEPTION_UNKNOWN:
+		fallthrough;
+	default:
+		ret = -EFAULT;
+	}
+
+	if (!ret)
+		return true;
+	else
+		return false;
+}
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
index 4e5d1b83df4a..af5ab8949206 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -28,6 +28,8 @@ int gzvm_err_to_errno(unsigned long err)
 		return 0;
 	case ERR_NO_MEMORY:
 		return -ENOMEM;
+	case ERR_INVALID_ARGS:
+		return -EINVAL;
 	case ERR_NOT_SUPPORTED:
 		return -EOPNOTSUPP;
 	case ERR_NOT_IMPLEMENTED:
diff --git a/drivers/virt/geniezone/gzvm_mmu.c b/drivers/virt/geniezone/gzvm_mmu.c
index 3c87eee1321f..cc007944eaa5 100644
--- a/drivers/virt/geniezone/gzvm_mmu.c
+++ b/drivers/virt/geniezone/gzvm_mmu.c
@@ -114,3 +114,41 @@ int gzvm_vm_allocate_guest_page(struct gzvm_memslot *slot, u64 gfn, u64 *pfn)
 	return 0;
 }
 
+static int handle_single_demand_page(struct gzvm *vm, int memslot_id, u64 gfn)
+{
+	int ret;
+	u64 pfn;
+
+	ret = gzvm_vm_allocate_guest_page(&vm->memslot[memslot_id], gfn, &pfn);
+	if (unlikely(ret))
+		return -EFAULT;
+
+	ret = gzvm_arch_map_guest(vm->vm_id, memslot_id, pfn, gfn, 1);
+	if (unlikely(ret))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * gzvm_handle_page_fault() - Handle guest page fault, find corresponding page
+ *                            for the faulting gpa
+ * @vcpu: Pointer to struct gzvm_vcpu_run of the faulting vcpu
+ *
+ * Return:
+ * * 0		- Success to handle guest page fault
+ * * -EFAULT	- Failed to map phys addr to guest's GPA
+ */
+int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu)
+{
+	struct gzvm *vm = vcpu->gzvm;
+	int memslot_id;
+	u64 gfn;
+
+	gfn = PHYS_PFN(vcpu->run->exception.fault_gpa);
+	memslot_id = gzvm_find_memslot(vm, gfn);
+	if (unlikely(memslot_id < 0))
+		return -EFAULT;
+
+	return handle_single_demand_page(vm, memslot_id, gfn);
+}
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index 77138e749e9a..455ae2e4285c 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -113,9 +113,11 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void __user *argp)
 		 * it's geniezone's responsibility to fill corresponding data
 		 * structure
 		 */
-		case GZVM_EXIT_HYPERCALL:
-			fallthrough;
 		case GZVM_EXIT_EXCEPTION:
+			if (!gzvm_handle_guest_exception(vcpu))
+				need_userspace = true;
+			break;
+		case GZVM_EXIT_HYPERCALL:
 			fallthrough;
 		case GZVM_EXIT_DEBUG:
 			fallthrough;
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 538549ef405c..9f7e44521de5 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -23,6 +23,31 @@ u64 gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn)
 	return memslot->userspace_addr + offset * PAGE_SIZE;
 }
 
+/**
+ * gzvm_find_memslot() - Find memslot containing this @gpa
+ * @vm: Pointer to struct gzvm
+ * @gfn: Guest frame number
+ *
+ * Return:
+ * * >=0		- Index of memslot
+ * * -EFAULT		- Not found
+ */
+int gzvm_find_memslot(struct gzvm *vm, u64 gfn)
+{
+	int i;
+
+	for (i = 0; i < GZVM_MAX_MEM_REGION; i++) {
+		if (vm->memslot[i].npages == 0)
+			continue;
+
+		if (gfn >= vm->memslot[i].base_gfn &&
+		    gfn < vm->memslot[i].base_gfn + vm->memslot[i].npages)
+			return i;
+	}
+
+	return -EFAULT;
+}
+
 /**
  * register_memslot_addr_range() - Register memory region to GenieZone
  * @gzvm: Pointer to struct gzvm
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index aacedb9c74ca..f6e4c5152ee5 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -29,6 +29,7 @@
  */
 #define NO_ERROR                (0)
 #define ERR_NO_MEMORY           (-5)
+#define ERR_INVALID_ARGS        (-8)
 #define ERR_NOT_SUPPORTED       (-24)
 #define ERR_NOT_IMPLEMENTED     (-27)
 #define ERR_FAULT               (-40)
@@ -123,6 +124,8 @@ int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
 int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void __user *argp);
 int gzvm_arch_create_vm(unsigned long vm_type);
 int gzvm_arch_destroy_vm(u16 vm_id);
+int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
+			u64 nr_pages);
 int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  void __user *argp);
@@ -143,6 +146,10 @@ int gzvm_arch_vcpu_run(struct gzvm_vcpu *vcpu, __u64 *exit_reason);
 int gzvm_arch_destroy_vcpu(u16 vm_id, int vcpuid);
 int gzvm_arch_inform_exit(u16 vm_id);
 
+int gzvm_find_memslot(struct gzvm *vm, u64 gpa);
+int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu);
+bool gzvm_handle_guest_exception(struct gzvm_vcpu *vcpu);
+
 int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev);
 int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
 			 u32 irq, bool level);
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 09b1457f1270..73fd6a81116f 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -181,6 +181,12 @@ enum {
 	GZVM_EXIT_GZ = 0x9292000a,
 };
 
+/* exception definitions of GZVM_EXIT_EXCEPTION */
+enum {
+	GZVM_EXCEPTION_UNKNOWN = 0x0,
+	GZVM_EXCEPTION_PAGE_FAULT = 0x1,
+};
+
 /**
  * struct gzvm_vcpu_run: Same purpose as kvm_run, this struct is
  *			 shared between userspace, kernel and
@@ -245,6 +251,12 @@ struct gzvm_vcpu_run {
 			__u32 exception;
 			/* Exception error codes */
 			__u32 error_code;
+			/* Fault GPA (guest physical address or IPA in ARM) */
+			__u64 fault_gpa;
+			/* Future-proof reservation and reset to zero in hypervisor.
+			 * Fill up to the union size, 256 bytes.
+			 */
+			__u64 reserved[30];
 		} exception;
 		/* GZVM_EXIT_HYPERCALL */
 		struct {
-- 
2.18.0


