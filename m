Return-Path: <linux-kernel+bounces-9352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A4581C474
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9F91F25E92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B48218038;
	Fri, 22 Dec 2023 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eY6sUOpf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA91D306;
	Fri, 22 Dec 2023 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eaf843a4a08511eeba30773df0976c77-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Vo7/8SdJTy6PD+1QaQcWVlel/mcBE+WmrpBeWZ3cneU=;
	b=eY6sUOpfqyatahaw++pVC3GYiWQy2Fnm/0hvpaa+q7USWTpWbv8kdifzzNNrRxNcIPiB2aCBJ21jAT3mkbUEN6z3QTjhICQNONEbI0C3lGsaQjvUU/uQirmISkrC1SojrUYM3zDhhprs7Kr1QzO0w8pof5jlp6/zEoOVupPFRPQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:c68073c6-e522-4887-ac6c-70643eeae8cc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:a4b8738d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eaf843a4a08511eeba30773df0976c77-20231222
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2030041288; Fri, 22 Dec 2023 12:52:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Dec 2023 12:52:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Dec 2023 12:52:31 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Jason-ch Chen <jason-ch.chen@mediatek.com>, Johnson Wang
	<johnson.wang@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
	Shawn Sung <shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3 7/9] mailbox: mediatek: Move reuseable definition to header for secure driver
Date: Fri, 22 Dec 2023 12:52:26 +0800
Message-ID: <20231222045228.27826-8-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.411300-8.000000
X-TMASE-MatchedRID: K02MXwpCiCtLbaTfilVXfTPDkSOzeDWWf6/Md8Lb2l/1gF7PCEF9bli5
	r+TKtIsr64Ta3P14gV2y7ec+ITUwMzW+K/PcvqBra0aUozXm0DYh9mNF8ZPJ2Cz+5QCTrE/sgK6
	qCGa1Z9euDlY3VLd7CFn74Xleqcq0QBI3/CURWxx05zsoB1UKTqk89YpdLgI7DpCUEeEFm7AtiD
	c0qML5ZNwAFNNtZv2wtcF3I8fd45iXBXaJoB9JZxRFJJyf5BJe3QfwsVk0UbuGrPnef/I+eqzZI
	n3r7BwhnZgsMwbJ9WzENc1hpwdtvClyqLZvurBwC8XKjsVbJjU=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.411300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: ACEFB8A57DD322DB60FA41F160643FA22A28B778E24856E957B2F5837CA286092000:8
X-MTK: N

To support CMDQ secure driver, move some reuseable definition to header.
- define: e.g. CMDQ_GCE_NUM_MAX, CMDQ_THR_BASE, CMDQ_THR_SIZE.
- struct: e.g. cmdq_thread, cmdq, cmdq_task.
- include: e.g. <linux/clk.h>.

Add "#include <linux/mailbox_controller.h>" for the function that takes
"struct mbox_chan * chan" as a parameter. That may occur a build error
if secure driver header includes the mtk-cmdq-mailbox.h.
- function: e.g. cmdq_get_shift_pa(struct mbox_chan *chan).

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c       | 30 ---------------------
 include/linux/mailbox/mtk-cmdq-mailbox.h | 33 ++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 5390b6488ebc..04321f7e10c3 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -3,7 +3,6 @@
 // Copyright (c) 2018 MediaTek Inc.
 
 #include <linux/bitops.h>
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
@@ -22,13 +21,10 @@
 
 #define CMDQ_OP_CODE_MASK		(0xff << CMDQ_OP_CODE_SHIFT)
 #define CMDQ_NUM_CMD(t)			(t->cmd_buf_size / CMDQ_INST_SIZE)
-#define CMDQ_GCE_NUM_MAX		(2)
 
 #define CMDQ_CURR_IRQ_STATUS		0x10
 #define CMDQ_SYNC_TOKEN_UPDATE		0x68
 #define CMDQ_THR_SLOT_CYCLES		0x30
-#define CMDQ_THR_BASE			0x100
-#define CMDQ_THR_SIZE			0x80
 #define CMDQ_THR_WARM_RESET		0x00
 #define CMDQ_THR_ENABLE_TASK		0x04
 #define CMDQ_THR_SUSPEND_TASK		0x08
@@ -59,32 +55,6 @@
 #define CMDQ_JUMP_BY_OFFSET		0x10000000
 #define CMDQ_JUMP_BY_PA			0x10000001
 
-struct cmdq_thread {
-	struct mbox_chan	*chan;
-	void __iomem		*base;
-	struct list_head	task_busy_list;
-	u32			priority;
-};
-
-struct cmdq_task {
-	struct cmdq		*cmdq;
-	struct list_head	list_entry;
-	dma_addr_t		pa_base;
-	struct cmdq_thread	*thread;
-	struct cmdq_pkt		*pkt; /* the packet sent from mailbox client */
-};
-
-struct cmdq {
-	struct mbox_controller	mbox;
-	void __iomem		*base;
-	int			irq;
-	u32			irq_mask;
-	const struct gce_plat	*pdata;
-	struct cmdq_thread	*thread;
-	struct clk_bulk_data	clocks[CMDQ_GCE_NUM_MAX];
-	bool			suspended;
-};
-
 struct gce_plat {
 	u32 thread_nr;
 	u8 shift;
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index f78a08e7c6ed..43eae45a08c9 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -7,10 +7,17 @@
 #ifndef __MTK_CMDQ_MAILBOX_H__
 #define __MTK_CMDQ_MAILBOX_H__
 
+#include <linux/clk.h>
+#include <linux/mailbox_controller.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#define CMDQ_GCE_NUM_MAX		2
+
+#define CMDQ_THR_BASE			0x100
+#define CMDQ_THR_SIZE			0x80
+
 #define CMDQ_INST_SIZE			8 /* instruction is 64-bit */
 #define CMDQ_SUBSYS_SHIFT		16
 #define CMDQ_OP_CODE_SHIFT		24
@@ -79,6 +86,32 @@ struct cmdq_pkt {
 	bool			loop;
 };
 
+struct cmdq_thread {
+	struct mbox_chan	*chan;
+	void __iomem		*base;
+	struct list_head	task_busy_list;
+	u32			priority;
+};
+
+struct cmdq {
+	struct mbox_controller	mbox;
+	void __iomem		*base;
+	int			irq;
+	u32			irq_mask;
+	const struct gce_plat	*pdata;
+	struct cmdq_thread	*thread;
+	struct clk_bulk_data	clocks[CMDQ_GCE_NUM_MAX];
+	bool			suspended;
+};
+
+struct cmdq_task {
+	struct cmdq		*cmdq;
+	struct list_head	list_entry;
+	dma_addr_t		pa_base;
+	struct cmdq_thread	*thread;
+	struct cmdq_pkt		*pkt; /* the packet sent from mailbox client */
+};
+
 u8 cmdq_get_shift_pa(struct mbox_chan *chan);
 
 #endif /* __MTK_CMDQ_MAILBOX_H__ */
-- 
2.18.0


