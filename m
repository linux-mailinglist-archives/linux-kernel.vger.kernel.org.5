Return-Path: <linux-kernel+bounces-142080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5FF8A2732
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B284BB23082
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F774E1C8;
	Fri, 12 Apr 2024 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rdqzh72y"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3BE47F73;
	Fri, 12 Apr 2024 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905076; cv=none; b=BNpAsQY59t461bLR/zQIQ98CuFCPSuH9roxCgK5KrrmbYmCO4n/pvY7+nRkHpOJR1r1b5vaV90v/AdJTUEk7AZbx2McJ2a/D6iy88LdMSNbGNp7B8W6dI3E78Z5A45HfGBqk4PgEZicIv5oLfomG4tRto09YmrMO9Afp9/asWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905076; c=relaxed/simple;
	bh=eWECpaWlXmXCkFUs7yF9Ep3o2tv36lMHxJejfQDZ4Eg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyuZEt3f0eA4X3OGxbZS7wtjEH8+foO58PtfII0xkrAVmetGFC/pUdbdPYsKjNOIDzZDn++AtAJsfhbjmgAfctQVOTVr+S67OtdzDrzgmFj7AsCYqtLi2ohT10zWbrzWg/sdIxn7y6fdemBpbVzN82qkQeYIGIknU6Wsc6NeNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rdqzh72y; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f8efabe8f89911ee935d6952f98a51a9-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sSySCgSV3af4ODoaA0BfawVDtPsV6EApW6fIDqAIdFg=;
	b=rdqzh72y/XxcRCWaPgIPmi59V+5I4Q2RnlMGJKlcJBOZ9VLqW1YZo6op2psA5+UH7pfip31xwbwfR9cRuTEzuqd5B98hgqNAF9yN66XiLtrbO3bsmUdmN953hw6t3P0g04MnBGTB9kDeRIlG8GsOYBhQiQxAo6UwWrNifdvoIZU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:aa956f05-da07-492e-94d6-deb85534d32c,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:263fd4fa-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f8efabe8f89911ee935d6952f98a51a9-20240412
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 370996844; Fri, 12 Apr 2024 14:57:48 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
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
Subject: [PATCH v10 14/21] virt: geniezone: Add dtb config support
Date: Fri, 12 Apr 2024 14:57:11 +0800
Message-ID: <20240412065718.29105-15-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240412065718.29105-1-yi-de.wu@mediatek.com>
References: <20240412065718.29105-1-yi-de.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: "Jerry Wang" <ze-yu.wang@mediatek.com>

Hypervisor might need to know the accurate address and size of dtb
passed from userspace. And then hypervisor would parse the dtb and get
vm information.

Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Liju-clr Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |  2 ++
 arch/arm64/geniezone/vm.c               |  9 +++++++++
 drivers/virt/geniezone/gzvm_vm.c        | 10 ++++++++++
 include/linux/soc/mediatek/gzvm_drv.h   |  1 +
 include/uapi/linux/gzvm.h               | 14 ++++++++++++++
 5 files changed, 36 insertions(+)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index dabd11438e94..4366618cdc0a 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -23,6 +23,7 @@ enum {
 	GZVM_FUNC_ENABLE_CAP = 13,
 	GZVM_FUNC_INFORM_EXIT = 14,
 	GZVM_FUNC_MEMREGION_PURPOSE = 15,
+	GZVM_FUNC_SET_DTB_CONFIG = 16,
 	NR_GZVM_FUNC,
 };
 
@@ -46,6 +47,7 @@ enum {
 #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
 #define MT_HVC_GZVM_INFORM_EXIT		GZVM_HCALL_ID(GZVM_FUNC_INFORM_EXIT)
 #define MT_HVC_GZVM_MEMREGION_PURPOSE	GZVM_HCALL_ID(GZVM_FUNC_MEMREGION_PURPOSE)
+#define MT_HVC_GZVM_SET_DTB_CONFIG	GZVM_HCALL_ID(GZVM_FUNC_SET_DTB_CONFIG)
 
 #define GIC_V3_NR_LRS			16
 
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 026684c601a8..cbebae3ff663 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -156,6 +156,15 @@ int gzvm_arch_memregion_purpose(struct gzvm *gzvm,
 				    mem->flags, 0, 0, 0, &res);
 }
 
+int gzvm_arch_set_dtb_config(struct gzvm *gzvm, struct gzvm_dtb_config *cfg)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_SET_DTB_CONFIG, gzvm->vm_id,
+				    cfg->dtb_addr, cfg->dtb_size, 0, 0, 0, 0,
+				    &res);
+}
+
 static int gzvm_vm_arch_enable_cap(struct gzvm *gzvm,
 				   struct gzvm_enable_cap *cap,
 				   struct arm_smccc_res *res)
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index f6846602dec5..1fc915b790b8 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -254,6 +254,16 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_vm_ioctl_enable_cap(gzvm, &cap, argp);
 		break;
 	}
+	case GZVM_SET_DTB_CONFIG: {
+		struct gzvm_dtb_config cfg;
+
+		if (copy_from_user(&cfg, argp, sizeof(cfg))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = gzvm_arch_set_dtb_config(gzvm, &cfg);
+		break;
+	}
 	default:
 		ret = -ENOTTY;
 	}
diff --git a/include/linux/soc/mediatek/gzvm_drv.h b/include/linux/soc/mediatek/gzvm_drv.h
index 1c1927b642f6..798880468991 100644
--- a/include/linux/soc/mediatek/gzvm_drv.h
+++ b/include/linux/soc/mediatek/gzvm_drv.h
@@ -179,6 +179,7 @@ void gzvm_vm_irqfd_release(struct gzvm *gzvm);
 
 int gzvm_arch_memregion_purpose(struct gzvm *gzvm,
 				struct gzvm_userspace_memory_region *mem);
+int gzvm_arch_set_dtb_config(struct gzvm *gzvm, struct gzvm_dtb_config *args);
 
 int gzvm_init_ioeventfd(struct gzvm *gzvm);
 int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args);
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 6e102cbfec98..7aec4adf2206 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -364,4 +364,18 @@ struct gzvm_ioeventfd {
 
 #define GZVM_IOEVENTFD	_IOW(GZVM_IOC_MAGIC, 0x79, struct gzvm_ioeventfd)
 
+/**
+ * struct gzvm_dtb_config: store address and size of dtb passed from userspace
+ *
+ * @dtb_addr: dtb address set by VMM (guset memory)
+ * @dtb_size: dtb size
+ */
+struct gzvm_dtb_config {
+	__u64 dtb_addr;
+	__u64 dtb_size;
+};
+
+#define GZVM_SET_DTB_CONFIG       _IOW(GZVM_IOC_MAGIC, 0xff, \
+				       struct gzvm_dtb_config)
+
 #endif /* __GZVM_H__ */
-- 
2.18.0


