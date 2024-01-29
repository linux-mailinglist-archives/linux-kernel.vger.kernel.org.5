Return-Path: <linux-kernel+bounces-42368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06043840075
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF721C20945
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59B60BB0;
	Mon, 29 Jan 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SnGSwbC6"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653AA55C28;
	Mon, 29 Jan 2024 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706517201; cv=none; b=inWmEN0G7+AZhvlGMTlvp1myIfkigKqV7R4mICsAvRTzZ1saX6xQkPMv0emlB+Hh6FzOWYg9k0pAJFJ7m7pB10tTPlROyehQQ5eW86DEGaddGP0wEkUHDQkzjHJ5+x8q9mWOSxjhk0Ni2/9iXQD6BNs+fIRIJMxI4HIQrrqFfI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706517201; c=relaxed/simple;
	bh=aWAW7g/mQGr0Q+uXJPTbfh+7RhKJVYrZ0lZYXDFX3FE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFte4qhfz2m7isHso4TIjwSmTMzFkgBMaPQu2fDIWcQj0ZgSq67WPIsvp1GGS16pwcI13/TbLsbKANBVnSwdubpB9sihjPLgVKC52YoWTafwwFIsSFtWtBxz1qIeLUZmi9B+EsTSwgqmKxnRXbXR4HRXMsMtEsGpmkW0yk1aSE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SnGSwbC6; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 09c8ca1abe8111ee9e680517dc993faa-20240129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dAJ+F6oRSY6L+f2GMbS+4z3gw8hdhuCJ6CkYP9HGraU=;
	b=SnGSwbC6mKJUHF+mbaxwCQMMX806Kl6oK1NAfKK8uLf8/OtNEVSP56h27Zz9sZ/8R9ssJ5b5ZwIPidRAdGciKBgFAnwAQ9ph0+/FW3HzcGY0vdkEVgioF1sFGDeqMpuY3co4o+mDtBvDNk6iSV0F5ri9IcVLCvE6RxJCge1KS6c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:7431edfc-a07a-426f-87df-1e85aeaf583a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6e16cf4,CLOUDID:2845de7f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 09c8ca1abe8111ee9e680517dc993faa-20240129
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 343817375; Mon, 29 Jan 2024 16:33:11 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
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
Subject: [PATCH v9 14/21] virt: geniezone: Add dtb config support
Date: Mon, 29 Jan 2024 16:32:55 +0800
Message-ID: <20240129083302.26044-15-yi-de.wu@mediatek.com>
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
X-TM-AS-Result: No-10--4.581200-8.000000
X-TMASE-MatchedRID: Ei0WBMmFdJhWj3HFS14pK3a57ruHAnHxf2g6KJZtxl1GL0g1nVmkYXB4
	4IkzjfYy2hTOUzxi3QgS2fXvRIxFxjeE3zHLyrsy4pdq9sdj8LUpWss5kPUFdEuCjz4ggdtwiVt
	eKAOd9rjEfLh+b9VM4YAy6p60ZV62fJ5/bZ6npdjKayT/BQTiGvoYGtXkdu6SxX66abES0VbmFP
	ZczcrbaV9WXuLhSrPlKMHr5zzFy1jRmftpqdCETxWlqYs52zrhPAgtDxnHoPisMABqiZXzYRNRn
	hB8RTFvdATQdtPksR+3/JiWOe6GXXSWgQ2GpXdZbxffl9hhCBw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.581200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3C96B7BEC1847B5F47604C6917AC0E9D7482860BF47E1DACAB00F2BFBB0ED7A22000:8
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
 include/linux/gzvm_drv.h                |  1 +
 include/uapi/linux/gzvm.h               | 14 ++++++++++++++
 5 files changed, 36 insertions(+)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 8d1406beeaed..afb91713fc45 100644
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
index 735a599f7da7..41ad1692dd18 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -140,6 +140,15 @@ int gzvm_arch_memregion_purpose(struct gzvm *gzvm,
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
index 4134605cbf7d..538549ef405c 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -250,6 +250,16 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
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
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index 6e081288d41e..aacedb9c74ca 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -156,6 +156,7 @@ void gzvm_vm_irqfd_release(struct gzvm *gzvm);
 
 int gzvm_arch_memregion_purpose(struct gzvm *gzvm,
 				struct gzvm_userspace_memory_region *mem);
+int gzvm_arch_set_dtb_config(struct gzvm *gzvm, struct gzvm_dtb_config *args);
 
 int gzvm_init_ioeventfd(struct gzvm *gzvm);
 int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args);
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 7c4c95e7e574..09b1457f1270 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -359,4 +359,18 @@ struct gzvm_ioeventfd {
 
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


