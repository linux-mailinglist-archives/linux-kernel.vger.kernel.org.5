Return-Path: <linux-kernel+bounces-42363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32406840063
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571AB1C22365
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2676E5FEFE;
	Mon, 29 Jan 2024 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kbYQMCJx"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9154BEC;
	Mon, 29 Jan 2024 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706517199; cv=none; b=XzHJXARiz1uy82qpskRdIGqHOxp3uO5H+HiMPicATOr5/4RmMKsp9GrjYCBkYRpXar1wBO38CnH4YAvfm3zhVSCjSx8euA/bn0VEuBST2MhOIrTvcmJYuG2ZN7MF8X+SzvE32ywg/E5qO/M+lCfsmLYont+tfe6yLLukbarw4uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706517199; c=relaxed/simple;
	bh=62LhPF7OlJ733xM1vIX27w0ziBqPkWy3dXfPYGS5fvo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWoaYNTH3krY+cv0CbFbDLtNfPbX7/btQrBWSQkRpMeZdT/TdPfJWZqljziieyMVse2PFKMvpy8xUzXEO0pjP3U/MGaqYKQK9QOfB//V8+usmhzjudeYrZmCXvxWMxVUo8gSQiCuTYS2dA8YyH1iuW46Vlk16DY51niRuKRxa4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kbYQMCJx; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 087c37bebe8111eea2298b7352fd921d-20240129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zOpMwu4BrT/uKABhkgmLORQQMZCHniuk++mO9S+bEnA=;
	b=kbYQMCJxZDOJTnCBKq6ESF6l5KiSoi7gKpSKbpKPmUcgxha2UPIYGHev7QSTm9mQEyUofMA0wXLnebd7jr851q1jXzXiZ6Rw7Bv6HnJEMKQfQwcdwv8m4GOebViz+N61mguELzZ1AxdFafi+2D9O/UVV8SQE+us9oK+qL4Rhux8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:29a345f5-d1a7-4e38-b858-229606db1281,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6e16cf4,CLOUDID:dc25c58e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 087c37bebe8111eea2298b7352fd921d-20240129
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1687136146; Mon, 29 Jan 2024 16:33:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 Jan 2024 16:33:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 29 Jan 2024 16:33:09 +0800
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
Subject: [PATCH v9 20/21] virt: geniezone: Add tracing support for hyp call and vcpu exit_reason
Date: Mon, 29 Jan 2024 16:33:01 +0800
Message-ID: <20240129083302.26044-21-yi-de.wu@mediatek.com>
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
X-TM-AS-Result: No-10--12.328700-8.000000
X-TMASE-MatchedRID: iEpXmf/25Q09S3IiQd+eNcNrWpY804TGLoYOuiLW+uVh2fnHe1cil1mB
	Y2oLO+3hkVOFsc3HEGn8I8AIZZ2s3pSL8e/MGApZKy67dnbJjn4WnD2CPybLCsXhke5ra0593AG
	yPNT+2TGM0+ypVXg5IEzyp2gK85W+VJTV35UngiMVglQa/gMvfIfsPVs/8Vw6SSUXkvSVAdwluI
	Iv8IIdTRyagBEJyc4yUvgoj+bRd81VY7t+zwxALh3EEAbn+GRbwx0jRRxcQfPxCQaCt6X8bibLS
	tTV0GSXnyhY3ks4RISuJLLaxxUorDcpdZ3fQiLdFEUknJ/kEl7dB/CxWTRRu92KvEVWmYr16Y/h
	PKKZNWrcaLEap++ycVPH31rarD7malNm98FYp20xlMMOLt4SZw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.328700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 486CE25B760893D17ACFBE67EE20347D5C8A90FD3AF21EA0A22D0F97C92714A42000:8
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
crosvm_vcpu0-4838 [004] ..... 76053.536034: mtk_hypcall_enter: id=0xbb001005
crosvm_vcpu0-4838 [004] ..... 76053.540039: mtk_hypcall_leave: id=0xbb001005 invalid=0
crosvm_vcpu0-4838 [004] ..... 76053.540040: mtk_vcpu_exit: vcpu exit_reason=0x92920003

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
 arch/arm64/geniezone/vm.c          |  5 +++
 drivers/virt/geniezone/gzvm_vcpu.c |  3 ++
 include/trace/events/geniezone.h   | 54 ++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 include/trace/events/geniezone.h

diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 571326e70d98..8bec85bf9879 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -7,6 +7,8 @@
 #include <linux/err.h>
 #include <linux/uaccess.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/geniezone.h>
 #include <linux/gzvm.h>
 #include <linux/gzvm_drv.h>
 #include "gzvm_arch_common.h"
@@ -33,7 +35,10 @@ int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
 			 unsigned long a6, unsigned long a7,
 			 struct arm_smccc_res *res)
 {
+	trace_mtk_hypcall_enter(a0);
 	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
+	trace_mtk_hypcall_leave(a0, (res->a0 != ERR_NOT_SUPPORTED) ? 0 : 1);
+
 	return gzvm_err_to_errno(res->a0);
 }
 
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index 86c690749277..138ec064596b 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -10,6 +10,8 @@
 #include <linux/mm.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+
+#include <trace/events/geniezone.h>
 #include <linux/gzvm_drv.h>
 
 /* maximum size needed for holding an integer */
@@ -103,6 +105,7 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void __user *argp)
 
 	while (!need_userspace && !signal_pending(current)) {
 		gzvm_arch_vcpu_run(vcpu, &exit_reason);
+		trace_mtk_vcpu_exit(exit_reason);
 
 		switch (exit_reason) {
 		case GZVM_EXIT_MMIO:
diff --git a/include/trace/events/geniezone.h b/include/trace/events/geniezone.h
new file mode 100644
index 000000000000..1fa44f9c4b3c
--- /dev/null
+++ b/include/trace/events/geniezone.h
@@ -0,0 +1,54 @@
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
+#include <linux/tracepoint.h>
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
+	    TP_printk("vcpu exit_reason=0x%lx", __entry->exit_reason)
+);
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.18.0


