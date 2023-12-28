Return-Path: <linux-kernel+bounces-12578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9329F81F71B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C1E1F221EA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59CC6FC9;
	Thu, 28 Dec 2023 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KwezTvUh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2FC6AA4;
	Thu, 28 Dec 2023 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1d452424a56f11ee9e680517dc993faa-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Iq6rJB1BQH7MyG3Gy+ASArAtPbHoNPf+L6Y9qIZXqT4=;
	b=KwezTvUhc9SEXf/HOO9hYS1zyr/f6wMA+ZQhNev+26MAcZINRz3YS7fxTIz+iOlU7dw/pmph6/Ky4T9yfkdSwmraiuMn+x2kWOblYYQHT2IxxvsibJZybwbqdiCeHQkqnvkchXwjV4JNc8UeT5ChIsEq5JACBe/w0dOFNw7NvMk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:fe350c73-ceef-4f65-bad9-a1152a85fb91,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:6652aa8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1d452424a56f11ee9e680517dc993faa-20231228
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 282449682; Thu, 28 Dec 2023 18:51:54 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 18:51:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 18:51:52 +0800
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
Subject: [PATCH v8 12/20] virt: geniezone: Add memory region support
Date: Thu, 28 Dec 2023 18:51:39 +0800
Message-ID: <20231228105147.13752-13-yi-de.wu@mediatek.com>
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
X-TM-AS-Result: No-10--3.824400-8.000000
X-TMASE-MatchedRID: Bo0EIJTmAYww2a0RxGqSGyVypP66BP0QNNuh+5zmS68Cgjr7b0ytGZas
	fA8Y/RCF8B1Eq8wDKAEQzM3Grt8RghUBkTmMruyZhK8o4aoss8pKPIx+MJF9o99RlPzeVuQQpc2
	xgJAY6Lr/EdEp4HtkngHGJy9aPQkxszLAY5oHhBDd+fuf9kcapoLFgHaE9Li9myiLZetSf8mfop
	0ytGwvXiq2rl3dzGQ1GpeevGsoI5cQJynOlhtYA8Q7a6Na0HQ6lJ1S0ZwYWeCnBPLGCcWvdY81M
	YOHBWg40IN+0dwpKpfxB9z4/W00szQYCzO07oGaAKujjK1QWmoXRoPmWO3jekxwdkPqCq7vDEyN
	+J8hd+jCS9WgDXVPCn7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.824400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	1624FFF9F46991932BF1A1BFE4C1831830FDC23E280DD411864D1804B0037B542000:8
X-MTK: N

From: "Jerry Wang" <ze-yu.wang@mediatek.com>

Hypervisor might need to know the precise purpose of each memory
region, so that it can provide specific memory protection. We add a new
uapi to pass address and size of a memory region and its purpose.

Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Liju-clr Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |  2 ++
 arch/arm64/geniezone/vm.c               | 10 ++++++++++
 drivers/virt/geniezone/gzvm_vm.c        |  7 +++++++
 include/linux/gzvm_drv.h                |  3 +++
 4 files changed, 22 insertions(+)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 67c7864c3afc..8d1406beeaed 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -22,6 +22,7 @@ enum {
 	GZVM_FUNC_PROBE = 12,
 	GZVM_FUNC_ENABLE_CAP = 13,
 	GZVM_FUNC_INFORM_EXIT = 14,
+	GZVM_FUNC_MEMREGION_PURPOSE = 15,
 	NR_GZVM_FUNC,
 };
 
@@ -44,6 +45,7 @@ enum {
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
 #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
 #define MT_HVC_GZVM_INFORM_EXIT		GZVM_HCALL_ID(GZVM_FUNC_INFORM_EXIT)
+#define MT_HVC_GZVM_MEMREGION_PURPOSE	GZVM_HCALL_ID(GZVM_FUNC_MEMREGION_PURPOSE)
 
 #define GIC_V3_NR_LRS			16
 
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 0afdb49b71f5..210f7569d7cc 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -130,6 +130,16 @@ int gzvm_arch_destroy_vm(u16 vm_id)
 				    0, 0, &res);
 }
 
+int gzvm_arch_memregion_purpose(struct gzvm *gzvm,
+				struct gzvm_userspace_memory_region *mem)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_MEMREGION_PURPOSE, gzvm->vm_id,
+				    mem->guest_phys_addr, mem->memory_size,
+				    mem->flags, 0, 0, 0, &res);
+}
+
 static int gzvm_vm_arch_enable_cap(struct gzvm *gzvm,
 				   struct gzvm_enable_cap *cap,
 				   struct arm_smccc_res *res)
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index d67bf647b615..4134605cbf7d 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -72,6 +72,7 @@ static int
 gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
 				struct gzvm_userspace_memory_region *mem)
 {
+	int ret;
 	struct vm_area_struct *vma;
 	struct gzvm_memslot *memslot;
 	unsigned long size;
@@ -96,6 +97,12 @@ gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
 	memslot->vma = vma;
 	memslot->flags = mem->flags;
 	memslot->slot_id = mem->slot;
+
+	ret = gzvm_arch_memregion_purpose(gzvm, mem);
+	if (ret) {
+		pr_err("Failed to config memory region for the specified purpose\n");
+		return -EFAULT;
+	}
 	return register_memslot_addr_range(gzvm, memslot);
 }
 
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index 406bc9f821b2..d35ca179b688 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -152,6 +152,9 @@ void gzvm_drv_irqfd_exit(void);
 int gzvm_vm_irqfd_init(struct gzvm *gzvm);
 void gzvm_vm_irqfd_release(struct gzvm *gzvm);
 
+int gzvm_arch_memregion_purpose(struct gzvm *gzvm,
+				struct gzvm_userspace_memory_region *mem);
+
 int gzvm_init_ioeventfd(struct gzvm *gzvm);
 int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args);
 bool gzvm_ioevent_write(struct gzvm_vcpu *vcpu, __u64 addr, int len,
-- 
2.18.0


