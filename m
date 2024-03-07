Return-Path: <linux-kernel+bounces-94832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5658745B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0EF1C22AE3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2D107A9;
	Thu,  7 Mar 2024 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jkv12huo"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E5522A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709775310; cv=none; b=ieEvIkkWARJQGoaM/+f+uFgL4PQWn5jUHBd6HWHEvmTxS7BV269NrqtLE4NqSXG4cfdFuGkfhsXtg+OpXqKsvsF+Uq2f7BmqfIq8rMc2p6VubC0N5bQC6UQVrxWBLoL+XbOzNY7DASGCfE3OY+WEcBma2E8Ya2PPf5hByuiomG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709775310; c=relaxed/simple;
	bh=4r4KWlRoqECrwFIL6FhF0v9TG+MhL307VEh/8qYN/kI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXSw99CB1VtbUBljok9wuRtGajWvp3mfivSECk7hBm2eVH56t/OWeKfmYCq3LyKx0WXiW8slMHlaXs7i+q5bCSVyGT+h9mH4va2LPklIhqFenCf9ayMD5UnQ2cCXeFy2YUTmiEKAcNAFecwcnpgxOiKCh9iE6qZ7mpiJntRAZb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jkv12huo; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eacc32fedc2211eeb8927bc1f75efef4-20240307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qozeXGlq1HPWjhIPE+mUg1AVfOhg2AA2XM+Vk2n0Jm0=;
	b=jkv12huo17kEpX6Rc/d+5qiGFtpBFFqIKF4HpNvm8bxboSaUpyuKiBwgg/C4UH7Fmb5m2t6A3YBix3C+9IzirQFEBxgUkGqtBdwoqZzUSjZdHKWMKl2Z4Bvfo9Ir51VqMCYUy/86yErK48wr2t8WuJbaKWXRUcPceLhjtK5dyN0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c8f51fb7-7739-4635-9570-7d48783a8903,IP:0,U
	RL:0,TC:0,Content:33,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:33
X-CID-META: VersionHash:6f543d0,CLOUDID:262399ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eacc32fedc2211eeb8927bc1f75efef4-20240307
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1547065403; Thu, 07 Mar 2024 09:35:02 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Mar 2024 09:35:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Mar 2024 09:35:00 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jason-ch Chen <jason-ch.chen@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 3/4] soc: mediatek: mtk-cmdq: Add cmdq_pkt_poll_addr() function
Date: Thu, 7 Mar 2024 09:34:57 +0800
Message-ID: <20240307013458.23550-4-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240307013458.23550-1-jason-jh.lin@mediatek.com>
References: <20240307013458.23550-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Add cmdq_pkt_poll_addr function to support CMDQ user making
an instruction for polling a specific address of hardware rigster
to check the value with or without mask.

POLL is a legacy operation in GCE, so it does not support SPR and
CMDQ_CODE_LOGIC. To support polling the register address which doesn't
have the subsys id, CMDQ users need to make an instruction with GPR and
CMDQ_CODE_MASK operation to move the register address to be poll into GPR.
Then users can make an POLL instruction with GPR to poll the register
address assigned in previous instruction.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 49 ++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 16 +++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 111b5b47ac8f..4f69df743505 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -12,6 +12,8 @@
 
 #define CMDQ_WRITE_ENABLE_MASK	BIT(0)
 #define CMDQ_POLL_ENABLE_MASK	BIT(0)
+/* dedicate the last GPR_R15 to assign the register address to be poll */
+#define CMDQ_POLL_ADDR_GPR	(15)
 #define CMDQ_EOC_IRQ_EN		BIT(0)
 #define CMDQ_REG_TYPE		1
 #define CMDQ_JUMP_RELATIVE	1
@@ -406,6 +408,53 @@ int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
 }
 EXPORT_SYMBOL(cmdq_pkt_poll_mask);
 
+int cmdq_pkt_poll_addr(struct cmdq_pkt *pkt, dma_addr_t addr, u32 value, u32 mask)
+{
+	struct cmdq_instruction inst = { {0} };
+	u8 use_mask = 0;
+	int ret;
+
+	/*
+	 * Append an MASK instruction to set the mask for following POLL instruction
+	 * which enables use_mask bit.
+	 */
+	if (mask != GENMASK(31, 0)) {
+		inst.op = CMDQ_CODE_MASK;
+		inst.mask = ~mask;
+		ret = cmdq_pkt_append_command(pkt, inst);
+		if (ret < 0)
+			return ret;
+		use_mask = CMDQ_POLL_ENABLE_MASK;
+	}
+
+	/*
+	 * POLL is an legacy operation in GCE and it does not support SPR and CMDQ_CODE_LOGIC,
+	 * so it can not use cmdq_pkt_assign to keep polling register address to SPR.
+	 * If user wants to poll a register address which doesn't have a subsys id,
+	 * user needs to use GPR and CMDQ_CODE_MASK to move polling register address to GPR.
+	 */
+	inst.op = CMDQ_CODE_MASK;
+	inst.dst_t = CMDQ_REG_TYPE;
+	inst.sop = CMDQ_POLL_ADDR_GPR;
+	inst.value = addr;
+	ret = cmdq_pkt_append_command(pkt, inst);
+	if (ret < 0)
+		return ret;
+
+	/* Append POLL instruction to poll the register address assign to GPR previously. */
+	inst.op = CMDQ_CODE_POLL;
+	inst.dst_t = CMDQ_REG_TYPE;
+	inst.sop = CMDQ_POLL_ADDR_GPR;
+	inst.offset = use_mask;
+	inst.value = value;
+	ret = cmdq_pkt_append_command(pkt, inst);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(cmdq_pkt_poll_addr);
+
 int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
 {
 	struct cmdq_instruction inst = {};
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index f07c9e2e0855..b0004d097e23 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -255,6 +255,22 @@ int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
 int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
 		       u16 offset, u32 value, u32 mask);
 
+/**
+ * cmdq_pkt_poll_addr() - Append blocking POLL command to CMDQ packet
+ * @pkt:	the CMDQ packet
+ * @addr:	the hardware register address
+ * @value:	the specified target register value
+ * @mask:	the specified target register mask
+ *
+ * Appends a polling (POLL) command to the CMDQ packet and asks the GCE
+ * to execute an instruction that checks for the specified `value` (with
+ * or without `mask`) to appear in the specified hardware register `addr`.
+ * All GCE threads will be blocked by this instruction.
+ *
+ * Return: 0 for success or negative error code
+ */
+int cmdq_pkt_poll_addr(struct cmdq_pkt *pkt, dma_addr_t addr, u32 value, u32 mask);
+
 /**
  * cmdq_pkt_assign() - Append logic assign command to the CMDQ packet, ask GCE
  *		       to execute an instruction that set a constant value into
-- 
2.18.0


