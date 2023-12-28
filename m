Return-Path: <linux-kernel+bounces-12595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D13A81F761
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89F328162A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C97A12E73;
	Thu, 28 Dec 2023 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Lo2laa39"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C355883D;
	Thu, 28 Dec 2023 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1dfe8072a56f11ee9e680517dc993faa-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xW8hVotvHotL6krXgxKJc9ErsX+05lenE/bojp2ISzc=;
	b=Lo2laa3954ySZL3yqivr4ZteXTrOkH11HPB9EQ1HXZXSoNH/JeThuUHn8MaP2Q/e9l5wvaYQlu5czkKeyAX3WtBvbkFXD6Xm0XlBRs673E4Y21AAeTo8DDh3On2Dy8uS/0OdVsTt/qasO/V14sdaxbja4hvBW5p1+KyNg1Of1DM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:047fc40f-c931-446d-8e17-860c1bfbd77f,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:8052aa8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1dfe8072a56f11ee9e680517dc993faa-20231228
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1044121278; Thu, 28 Dec 2023 18:51:55 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 18:51:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 18:51:54 +0800
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
Subject: [PATCH v8 20/20] virt: geniezone: Enable PTP for synchronizing time between host and guest VMs
Date: Thu, 28 Dec 2023 18:51:47 +0800
Message-ID: <20231228105147.13752-21-yi-de.wu@mediatek.com>
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
X-TM-AS-Result: No-10--10.205400-8.000000
X-TMASE-MatchedRID: y128Pza/oi5PB4rXagQZ+5LPLrFS265P4Ob1SHQRSIgNqAa+u3rIYNwB
	sjzU/tkx4ZQqYHZtqxhYo3G+rvxrNao77AcuQhw7A9lly13c/gHt/okBLaEo+BjO8pfx4H7gcam
	vz988laISXSK8uF+jaPAL7Jj8ilE4LZbtj42l31G4jAucHcCqnZYcYQ11P5U/xKLCLOyCW5B25K
	XQ4QIGJr1A4/e8Np0k4I4a/QXu4NCR8u6DOJbzp8nUT+eskUQP7h2RrsKOiu0+gR+s21UkWIEpJ
	RcbelqdADXE8V3mpEVDNcDXkV4d67bfdDP+zORmdXz3l78F3YmkWoMjFfK3Xpsoi2XrUn/Jn6Kd
	MrRsL14qtq5d3cxkNZd/mwLf2BVU/u97Tz1Q+0kDBDLbZrqaEgJOsKQTld6amsvvnoS3ZploBmT
	SwRxjXg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.205400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B6588E4DCCA6A6BBB11B70BD92DA304BAE5B390917BB5CF0848221A8B653C5822000:8
X-MTK: N

From: "Kevenny Hsieh" <kevenny.hsieh@mediatek.com>

Enabled Precision Time Protocol (PTP) for improved host-guest VM time
synchronization, optimizing operations needing precise clock sync in
virtual environment.

Signed-off-by: Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/Makefile           |  2 +-
 arch/arm64/geniezone/gzvm_arch_common.h |  3 +
 arch/arm64/geniezone/hvc.c              | 73 +++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_exception.c |  3 +-
 include/linux/gzvm_drv.h                |  1 +
 include/uapi/linux/gzvm.h               |  1 +
 6 files changed, 80 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/geniezone/hvc.c

diff --git a/arch/arm64/geniezone/Makefile b/arch/arm64/geniezone/Makefile
index 0e4f1087f9de..553a64a926dc 100644
--- a/arch/arm64/geniezone/Makefile
+++ b/arch/arm64/geniezone/Makefile
@@ -4,6 +4,6 @@
 #
 include $(srctree)/drivers/virt/geniezone/Makefile
 
-gzvm-y += vm.o vcpu.o vgic.o
+gzvm-y += vm.o vcpu.o vgic.o hvc.o
 
 obj-$(CONFIG_MTK_GZVM) += gzvm.o
diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index fbaf2da792a4..e697223f0fd6 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -93,6 +93,8 @@ static inline u16 get_vcpuid_from_tuple(unsigned int tuple)
  * @__pad: add an explicit '__u32 __pad;' in the middle to make it clear
  *         what the actual layout is.
  * @lr: The array of LRs(list registers).
+ * @vtimer_offset: The offset maintained by hypervisor that is host cycle count
+ *                 when guest VM startup.
  *
  * - Keep the same layout of hypervisor data struct.
  * - Sync list registers back for acking virtual device interrupt status.
@@ -101,6 +103,7 @@ struct gzvm_vcpu_hwstate {
 	__le32 nr_lrs;
 	__le32 __pad;
 	__le64 lr[GIC_V3_NR_LRS];
+	__le64 vtimer_offset;
 };
 
 static inline unsigned int
diff --git a/arch/arm64/geniezone/hvc.c b/arch/arm64/geniezone/hvc.c
new file mode 100644
index 000000000000..603db0fad3d8
--- /dev/null
+++ b/arch/arm64/geniezone/hvc.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+#include <linux/clocksource.h>
+#include <linux/kernel.h>
+#include <linux/timekeeping.h>
+#include <linux/gzvm_drv.h>
+#include "gzvm_arch_common.h"
+
+#define GZVM_PTP_VIRT_COUNTER 0
+#define GZVM_PTP_PHYS_COUNTER 1
+/**
+ * gzvm_handle_ptp_time() - Sync time between host and guest VM
+ * @vcpu: Pointer to struct gzvm_vcpu_run in userspace
+ * @counter: Counter type from guest VM
+ * Return: Always return 0 because there are no cases of failure
+ *
+ * The following register values will be passed to the guest VM
+ * for time synchronization:
+ * regs->x0 (upper 32 bits) wall clock time
+ * regs->x1 (lower 32 bits) wall clock time
+ * regs->x2 (upper 32 bits) cycles
+ * regs->x3 (lower 32 bits) cycles
+ */
+static int gzvm_handle_ptp_time(struct gzvm_vcpu *vcpu, int counter)
+{
+	struct system_time_snapshot snapshot;
+	u64 cycles = 0;
+
+	ktime_get_snapshot(&snapshot);
+
+	switch (counter) {
+	case GZVM_PTP_VIRT_COUNTER:
+		cycles = snapshot.cycles -
+			 le64_to_cpu(vcpu->hwstate->vtimer_offset);
+		break;
+	case GZVM_PTP_PHYS_COUNTER:
+		cycles = snapshot.cycles;
+		break;
+	default:
+		break;
+	}
+
+	vcpu->run->hypercall.args[0] = upper_32_bits(snapshot.real);
+	vcpu->run->hypercall.args[1] = lower_32_bits(snapshot.real);
+	vcpu->run->hypercall.args[2] = upper_32_bits(cycles);
+	vcpu->run->hypercall.args[3] = lower_32_bits(cycles);
+
+	return 0;
+}
+
+/**
+ * gzvm_arch_handle_guest_hvc() - Handle architecture-related guest hvc
+ * @vcpu: Pointer to struct gzvm_vcpu_run in userspace
+ * Return:
+ * * true - This hvc has been processed, no need to back to VMM.
+ * * false - This hvc has not been processed, require userspace.
+ */
+bool gzvm_arch_handle_guest_hvc(struct gzvm_vcpu *vcpu)
+{
+	int ret, counter;
+
+	switch (vcpu->run->hypercall.args[0]) {
+	case GZVM_HVC_PTP:
+		counter = vcpu->run->hypercall.args[1];
+		ret = gzvm_handle_ptp_time(vcpu, counter);
+		return (ret == 0) ? true : false;
+	default:
+		break;
+	}
+	return false;
+}
diff --git a/drivers/virt/geniezone/gzvm_exception.c b/drivers/virt/geniezone/gzvm_exception.c
index af26d1c82791..e6209b3b3a3e 100644
--- a/drivers/virt/geniezone/gzvm_exception.c
+++ b/drivers/virt/geniezone/gzvm_exception.c
@@ -56,7 +56,6 @@ bool gzvm_handle_guest_hvc(struct gzvm_vcpu *vcpu)
 		ret = gzvm_handle_relinquish(vcpu, ipa);
 		return (ret == 0) ? true : false;
 	default:
-		break;
+		return gzvm_arch_handle_guest_hvc(vcpu);
 	}
-	return false;
 }
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index a4e6c7eb9c17..fcdc6c30baea 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -192,6 +192,7 @@ int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu);
 bool gzvm_handle_guest_exception(struct gzvm_vcpu *vcpu);
 int gzvm_handle_relinquish(struct gzvm_vcpu *vcpu, phys_addr_t ipa);
 bool gzvm_handle_guest_hvc(struct gzvm_vcpu *vcpu);
+bool gzvm_arch_handle_guest_hvc(struct gzvm_vcpu *vcpu);
 
 int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev);
 int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index a98787a18c36..cd854afb445e 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -195,6 +195,7 @@ enum {
 
 /* hypercall definitions of GZVM_EXIT_HYPERCALL */
 enum {
+	GZVM_HVC_PTP = 0x86000001,
 	GZVM_HVC_MEM_RELINQUISH = 0xc6000009,
 };
 
-- 
2.18.0


