Return-Path: <linux-kernel+bounces-94831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E828745B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788A21C233EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B45EED6;
	Thu,  7 Mar 2024 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BxgMekuo"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC84689
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709775310; cv=none; b=q+wvPX+S31lVRkwPNbacQFfD++widfCyR9s5/QlKTMLkWlsHrs4aZrjO0sPp05AouNbnK8iCytXtTg7UzvgTeiNHCaj4v5dAyzK3RzQrmGpguNHXLUpUUL4i3X+4wavHhLTfRHtG8aDCPa5DCOk4uTCmS2yIteOnB2Z8+uSOnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709775310; c=relaxed/simple;
	bh=R/P93C+nqKjNKCG4RARbCb1k/JmGUftQywMIFpKDj7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Th7QYUO2zDddSLBVxBl7cQW1yxo1DdeDTwPePBOX1ze79+ILhj/8bC7u4U32Pkal+8oMDZufKqJD4kum6poa4bAYICvE8Q8T0Eqp+nbM5t5J3O5UGyNPZj402GcWFycTET8GRAYcwr4HN5DVsOnXukXBgugz9zvFXEt3m8wQpZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BxgMekuo; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eab59080dc2211eeb8927bc1f75efef4-20240307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8IVxyUh81LU6YKFwdjw+QHiZscbAIjJJqLNb5lFP15s=;
	b=BxgMekuoy3sIxhgP/GyqRyCKSAm4/l/2OwuBQbsKkxp3VEXtsvy378UqmuwXALIP+MvKREOKgWJr3nfYUQQI6lDAp/CejQmxOfVe0IiOzLHH7EBzBg3ONEHeHTo37ijo9goNNALcca0rBakMsQVO7uqNwQ5wIytpn9wKRe2ctSk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:b3581e90-60a6-41c0-b047-ae350ae1cf6c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:d7353481-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eab59080dc2211eeb8927bc1f75efef4-20240307
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 325059637; Thu, 07 Mar 2024 09:35:01 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
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
Subject: [PATCH v2 2/4] soc: mediatek: mtk-cmdq: Add cmdq_pkt_mem_move() function
Date: Thu, 7 Mar 2024 09:34:56 +0800
Message-ID: <20240307013458.23550-3-jason-jh.lin@mediatek.com>
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

Add cmdq_pkt_mem_move() function to support CMDQ user making
an instruction for moving a value from a source address to a
destination address.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 26 ++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 12 ++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index b0cd071c4719..111b5b47ac8f 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -299,6 +299,32 @@ int cmdq_pkt_write_s_mask_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
 }
 EXPORT_SYMBOL(cmdq_pkt_write_s_mask_value);
 
+int cmdq_pkt_mem_move(struct cmdq_pkt *pkt, dma_addr_t src_addr, dma_addr_t dst_addr)
+{
+	const u16 high_addr_reg_idx  = CMDQ_THR_SPR_IDX0;
+	const u16 value_reg_idx = CMDQ_THR_SPR_IDX1;
+	int ret;
+
+	/* read the value of src_addr into high_addr_reg_idx */
+	ret = cmdq_pkt_assign(pkt, high_addr_reg_idx, CMDQ_ADDR_HIGH(src_addr));
+	if (ret < 0)
+		return ret;
+	ret = cmdq_pkt_read_s(pkt, high_addr_reg_idx, CMDQ_ADDR_LOW(src_addr), value_reg_idx);
+	if (ret < 0)
+		return ret;
+
+	/* write the value of value_reg_idx into dst_addr */
+	ret = cmdq_pkt_assign(pkt, high_addr_reg_idx, CMDQ_ADDR_HIGH(dst_addr));
+	if (ret < 0)
+		return ret;
+	ret = cmdq_pkt_write_s(pkt, high_addr_reg_idx, CMDQ_ADDR_LOW(dst_addr), value_reg_idx);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(cmdq_pkt_mem_move);
+
 int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear)
 {
 	struct cmdq_instruction inst = { {0} };
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 1dae80185f9f..f07c9e2e0855 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -182,6 +182,18 @@ int cmdq_pkt_write_s_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
 int cmdq_pkt_write_s_mask_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
 				u16 addr_low, u32 value, u32 mask);
 
+/**
+ * cmdq_pkt_mem_move() - append memory move command to the CMDQ packet
+ * @pkt:	the CMDQ packet
+ * @src_addr:	source address
+ * @dst_addr:	destination address
+ *
+ * Appends a CMDQ command to copy the value found in `src_addr` to `dst_addr`.
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_mem_move(struct cmdq_pkt *pkt, dma_addr_t src_addr, dma_addr_t dst_addr);
+
 /**
  * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
  * @pkt:	the CMDQ packet
-- 
2.18.0


