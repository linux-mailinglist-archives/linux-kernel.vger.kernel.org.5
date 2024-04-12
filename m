Return-Path: <linux-kernel+bounces-142095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C468A277F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFFFC1F22806
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8CD5A4D1;
	Fri, 12 Apr 2024 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DxsfAisp"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7945339D;
	Fri, 12 Apr 2024 06:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905083; cv=none; b=SX23OpZ318jo4vBgharChXWxjZ6r6CDdPkPq5KpKlixFd/tSbHRvfbC4DAGiVvNaEuxcejChv3kV9pfU1GMQqiYEY60OOGUHemsnP986ARDgty56M/iaUOt17CQVwcicT2t5sMGEUTE6Kann7kUUz2STuganQ+imj1bG0Swa3B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905083; c=relaxed/simple;
	bh=p/b3gEbC9bj8WBEn6G2zXQf0fplABZW3DLXEB9QJE7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYjVUIbQ8zMv+EySY1tXI0v9clhnMaProACdUmD9LE9Iupoj4ndNLjWtrhbCW0UNEwH+rTKdRXsZrVmUAv5z3uFyVDaVyAKGYTyQqqTkBguItazhK9rPb+72JVOBivDxXBBef6j55ZZpk/G0ub/dIVnxi/HVqsJEUXMWrZDErQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DxsfAisp; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f9a0a768f89911eeb8927bc1f75efef4-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RvqAJLclmygd/KaYK6kKF+HTkiMHUHtz8dfFia/SmYY=;
	b=DxsfAispzeSFbnvRoOTWWVZZquOuNjN+2ZdIj1Fj+PJiY7WBxhsXifpTe3ucS3JV/ZUk3ESOY+ZbzYArEYP0XYa70SUZNqyNpxWZvrnSyltpX1Eg8FfGlpWJAsP3dstMRKzWBPem80wwj+LZyjK3l0j50GQhXy2fURpO2XGyFXQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a5f94f02-bd1a-4142-8e4c-f1bf217b0048,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:2d3fd4fa-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f9a0a768f89911eeb8927bc1f75efef4-20240412
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1612116802; Fri, 12 Apr 2024 14:57:49 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 14:57:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 14:57:48 +0800
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
Subject: [PATCH v10 20/21] virt: geniezone: Add tracing support for hyp call and vcpu exit_reason
Date: Fri, 12 Apr 2024 14:57:17 +0800
Message-ID: <20240412065718.29105-21-yi-de.wu@mediatek.com>
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

Add tracepoints for hypervisor calls and VCPU exit reasons in GenieZone
driver. It aids performance debugging by providing more information
about hypervisor operations and VCPU behavior.

Command Usage:
echo geniezone:* >> /sys/kernel/tracing/set_event
echo 1 > /sys/kernel/tracing/tracing_on
echo 0 > /sys/kernel/tracing/tracing_on
cat /sys/kernel/tracing/trace

For example:
crosvm_vcpu0-4874    [007] .....    94.757349: mtk_hypcall_enter: id=0xfb001005
crosvm_vcpu0-4874    [007] .....    94.760902: mtk_hypcall_leave: id=0xfb001005 invalid=0
crosvm_vcpu0-4874    [007] .....    94.760902: mtk_vcpu_exit: vcpu exit_reason=IRQ(0x92920003)

This example tracks a hypervisor function call by an ID (`0xbb001005`)
from initiation to termination, which is supported (invalid=0). A vCPU
exit is triggered by an Interrupt Request (IRQ) (exit reason: 0x92920003).

/* VM exit reason */
enum {
	GZVM_EXIT_UNKNOWN = 0x92920000,
	GZVM_EXIT_MMIO = 0x92920001,
	GZVM_EXIT_HYPERCALL = 0x92920002,
	GZVM_EXIT_IRQ = 0x92920003,
	GZVM_EXIT_EXCEPTION = 0x92920004,
	GZVM_EXIT_DEBUG = 0x92920005,
	GZVM_EXIT_FAIL_ENTRY = 0x92920006,
	GZVM_EXIT_INTERNAL_ERROR = 0x92920007,
	GZVM_EXIT_SYSTEM_EVENT = 0x92920008,
	GZVM_EXIT_SHUTDOWN = 0x92920009,
	GZVM_EXIT_GZ = 0x9292000a,
};

Signed-off-by: Liju-clr Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/vm.c          |  4 ++
 drivers/virt/geniezone/gzvm_vcpu.c |  5 +-
 include/trace/events/geniezone.h   | 84 ++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/geniezone.h

diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index a477546c5a1a..c00142f2e942 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -7,6 +7,8 @@
 #include <linux/err.h>
 #include <linux/uaccess.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/geniezone.h>
 #include <linux/gzvm.h>
 #include <linux/soc/mediatek/gzvm_drv.h>
 #include "gzvm_arch_common.h"
@@ -44,11 +46,13 @@ int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
 		.a6 = a6,
 		.a7 = a7,
 	};
+	trace_mtk_hypcall_enter(a0);
 	arm_smccc_1_2_hvc(&args, &res_1_2);
 	res->a0 = res_1_2.a0;
 	res->a1 = res_1_2.a1;
 	res->a2 = res_1_2.a2;
 	res->a3 = res_1_2.a3;
+	trace_mtk_hypcall_leave(a0, (res->a0 != ERR_NOT_SUPPORTED) ? 0 : 1);
 
 	return gzvm_err_to_errno(res->a0);
 }
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index e135d9388090..28bd690e4b7c 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -10,6 +10,8 @@
 #include <linux/mm.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+
+#include <trace/events/geniezone.h>
 #include <linux/soc/mediatek/gzvm_drv.h>
 
 /* maximum size needed for holding an integer */
@@ -103,6 +105,7 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void __user *argp)
 
 	while (!need_userspace && !signal_pending(current)) {
 		gzvm_arch_vcpu_run(vcpu, &exit_reason);
+		trace_mtk_vcpu_exit(exit_reason);
 
 		switch (exit_reason) {
 		case GZVM_EXIT_MMIO:
@@ -141,11 +144,9 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void __user *argp)
 		default:
 			pr_err("vcpu unknown exit\n");
 			need_userspace = true;
-			goto out;
 		}
 	}
 
-out:
 	if (copy_to_user(argp, vcpu->run, sizeof(struct gzvm_vcpu_run)))
 		return -EFAULT;
 	if (signal_pending(current)) {
diff --git a/include/trace/events/geniezone.h b/include/trace/events/geniezone.h
new file mode 100644
index 000000000000..4fffd826ba67
--- /dev/null
+++ b/include/trace/events/geniezone.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM geniezone
+
+#define _TRACE_GENIEZONE_H
+
+#include <linux/gzvm.h>
+#include <linux/tracepoint.h>
+
+#define GZVM_EXIT_REASONS \
+EM(UNKNOWN)\
+EM(MMIO)\
+EM(HYPERCALL)\
+EM(IRQ)\
+EM(EXCEPTION)\
+EM(DEBUG)\
+EM(FAIL_ENTRY)\
+EM(INTERNAL_ERROR)\
+EM(SYSTEM_EVENT)\
+EM(SHUTDOWN)\
+EMe(GZ)
+
+#undef EM
+#undef EMe
+#define EM(a) TRACE_DEFINE_ENUM(GZVM_EXIT_##a);
+#define EMe(a) TRACE_DEFINE_ENUM(GZVM_EXIT_##a);
+
+GZVM_EXIT_REASONS
+
+#undef EM
+#undef EMe
+
+#define EM(a)       { GZVM_EXIT_##a, #a },
+#define EMe(a)      { GZVM_EXIT_##a, #a }
+
+TRACE_EVENT(mtk_hypcall_enter,
+	    TP_PROTO(unsigned long id),
+
+	    TP_ARGS(id),
+
+	    TP_STRUCT__entry(__field(unsigned long, id)),
+
+	    TP_fast_assign(__entry->id = id;),
+
+	    TP_printk("id=0x%lx", __entry->id)
+);
+
+TRACE_EVENT(mtk_hypcall_leave,
+	    TP_PROTO(unsigned long id, unsigned long invalid),
+
+	    TP_ARGS(id, invalid),
+
+	    TP_STRUCT__entry(__field(unsigned long, id)
+			     __field(unsigned long, invalid)
+	    ),
+
+	    TP_fast_assign(__entry->id = id;
+			   __entry->invalid = invalid;
+	    ),
+
+	    TP_printk("id=0x%lx invalid=%lu", __entry->id, __entry->invalid)
+);
+
+TRACE_EVENT(mtk_vcpu_exit,
+	    TP_PROTO(unsigned long exit_reason),
+
+	    TP_ARGS(exit_reason),
+
+	    TP_STRUCT__entry(__field(unsigned long, exit_reason)),
+
+	    TP_fast_assign(__entry->exit_reason = exit_reason;),
+
+	    TP_printk("vcpu exit_reason=%s(0x%lx)",
+		      __print_symbolic(__entry->exit_reason, GZVM_EXIT_REASONS),
+		      __entry->exit_reason)
+
+);
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.18.0


