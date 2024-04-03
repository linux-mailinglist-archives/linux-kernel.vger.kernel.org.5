Return-Path: <linux-kernel+bounces-129533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50203896C3B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0122728ACFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBE3137C47;
	Wed,  3 Apr 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B2fi83Um"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D713667E;
	Wed,  3 Apr 2024 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139973; cv=none; b=eRhhsRNWI6GpgzxEFkuuZDJUxPltzeX79yoLjvVAYTSMC+CfC2eCC+HXpX0E9W77wItoFDs6TmHr+MaUeJ8ejBqmVuTUbTYTDjybLZNixcHks4h4Kp0sCMQdFhifCUBbvI6b/0uOWj6EtP+LJhmclS5SceG1ijT/Ft+FIrMUq1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139973; c=relaxed/simple;
	bh=+IlWUGdlzQJfs6Z8haxU/H30P4PqMkeXR7d0fnPUyrE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGMN7XvR1ej0kbXLlaUHxB+F8cIuCSABbGb/Y2k0enLN4/k0T7QnF/0kPdwlhHKlolbYRehXR/M03vuaTAgsXIyO3agdI40kuafIPLLqG9pV20QplSfwAv3PwTGCqZUm7LxOBaiCiDp+XGlLY8ldB05yJT3P6Xn+szJFtsqaV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=B2fi83Um; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 94094a32f1a411eeb8927bc1f75efef4-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pWQwqK2g+iyH/qRI5ZEPoTml58VltqtKSED66kVSq38=;
	b=B2fi83UmKx6wpN7LNYWU3jX/saQt+60hWJrW+mdtK+TsIRl8VG9p+MW6mswmOul9Knkd6aWuyjC9PTis+HbEtcd/O0vyWZWY0gkzsF088iNaMozmLyExT0drKwTnVLg3Xv5+PDPsTxy6wGWgHn2+W7Ch1b+iixU38qB/zEff/JY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f36e961a-4e31-4adf-a132-ed1b31cfa233,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:8c9b2c91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 94094a32f1a411eeb8927bc1f75efef4-20240403
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1019751094; Wed, 03 Apr 2024 18:26:05 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 18:26:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 18:26:05 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Jassi Brar <jassisinghbrar@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, Hsiao Chien Sung
	<shawn.sung@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Houlong Wei <houlong.wei@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH v5 07/10] mailbox: mediatek: Move reuseable definition to header for secure driver
Date: Wed, 3 Apr 2024 18:25:59 +0800
Message-ID: <20240403102602.32155-8-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240403102602.32155-1-shawn.sung@mediatek.com>
References: <20240403102602.32155-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

To support CMDQ secure driver, move some reuseable definition to header.
- define: e.g. CMDQ_GCE_NUM_MAX, CMDQ_THR_BASE, CMDQ_THR_SIZE.
- struct: e.g. cmdq_thread, cmdq, cmdq_task.
- include: e.g. <linux/clk.h>.

Add "#include <linux/mailbox_controller.h>" for the function that takes
"struct mbox_chan * chan" as a parameter. That may occur a build error
if secure driver header includes the mtk-cmdq-mailbox.h.
- function: e.g. cmdq_get_shift_pa(struct mbox_chan *chan).

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c       | 30 ---------------------
 include/linux/mailbox/mtk-cmdq-mailbox.h | 34 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 5906e0343d1fc..e04302ca6ec03 100644
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
index f78a08e7c6ede..092dcadea0d8a 100644
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
@@ -79,6 +86,33 @@ struct cmdq_pkt {
 	bool			loop;
 };
 
+struct cmdq_thread {
+	struct mbox_chan	*chan;
+	void __iomem		*base;
+	struct list_head	task_busy_list;
+	u32			priority;
+	u32			idx;
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


