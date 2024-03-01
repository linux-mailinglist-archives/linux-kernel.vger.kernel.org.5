Return-Path: <linux-kernel+bounces-88575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB9886E3A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D751F24E4F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1966D41C7A;
	Fri,  1 Mar 2024 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rfp3hl9i"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA9D3985A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304254; cv=none; b=O8OhKsZbN6WGk2EKPD7ImvmcQdaZ6z2SI/O8WCaPvFrKg/nZh9fs8M087nBeq0jKXeKxxomSealxQs+zSmRCLuK5ugaZWSiGr1JgcKmzZcTEL0d70Xpc7suMfPJIf42g+uFzwNLv3ZH6HRanCXNG3oxIlXwQ7cVQistrj1OWVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304254; c=relaxed/simple;
	bh=Akl9Bh+YJIiyMPc9g7WpxKAyGeUsUlx4vxBArfJWXXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6Q14+0Jlp/oAs+v8psHvj3tH5zItNDMSTsGVD/e2u5Aimz3wdE7w0dONtAHyumxH5g/hGb9den/vz40LzlnzkOCsf1Hp7L+PULXdGDRPoQ6B/hnGMdm34Y8CkGLncIBrnwNA591ntn8/NVEnKQovXW6NoiRtyfE2FRSLWnn1rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rfp3hl9i; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 27aecbc0d7da11eeb8927bc1f75efef4-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=b2jtfBQ99XTwNQWIlhNqeShiovjYiw2SHuwp+NS8xzo=;
	b=rfp3hl9iawLTDiftCT5bJCtp/CPmY6z9TDO+Sk0/Zgih5bvYS2Iacijqfvg/vGFJVr5QdmSf877IZGCxJPlQzcWPFKM2Z0VwJlXybb3C3/BTL++eFZsghgJcNh1eGsic7uQT67kfQxXazTFGeA2G8Nvnwl+lyLAvZ5JROcPCesg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:434e1981-6f7f-4a6c-bee0-8e548015b2d3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:66370181-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 27aecbc0d7da11eeb8927bc1f75efef4-20240301
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 410278015; Fri, 01 Mar 2024 22:44:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 22:44:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 22:44:04 +0800
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
Subject: [RESEND, PATCH 2/5] soc: mediatek: mtk-cmdq: Add cmdq_pkt_mem_move() function
Date: Fri, 1 Mar 2024 22:44:00 +0800
Message-ID: <20240301144403.2977-3-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
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
 include/linux/soc/mediatek/mtk-cmdq.h  | 10 ++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index b0cd071c4719..3a1e47ad8a41 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -299,6 +299,32 @@ int cmdq_pkt_write_s_mask_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
 }
 EXPORT_SYMBOL(cmdq_pkt_write_s_mask_value);
 
+s32 cmdq_pkt_mem_move(struct cmdq_pkt *pkt, dma_addr_t src_addr, dma_addr_t dst_addr)
+{
+	s32 err;
+	const u16 tmp_reg_idx = CMDQ_THR_SPR_IDX0;
+	const u16 swap_reg_idx = CMDQ_THR_SPR_IDX1;
+
+	/* read the value of src_addr into swap_reg_idx */
+	err = cmdq_pkt_assign(pkt, tmp_reg_idx, CMDQ_ADDR_HIGH(src_addr));
+	if (err < 0)
+		return err;
+	err = cmdq_pkt_read_s(pkt, tmp_reg_idx, CMDQ_ADDR_LOW(src_addr), swap_reg_idx);
+	if (err < 0)
+		return err;
+
+	/* write the value of swap_reg_idx into dst_addr */
+	err = cmdq_pkt_assign(pkt, tmp_reg_idx, CMDQ_ADDR_HIGH(dst_addr));
+	if (err < 0)
+		return err;
+	err = cmdq_pkt_write_s(pkt, tmp_reg_idx, CMDQ_ADDR_LOW(dst_addr), swap_reg_idx);
+	if (err < 0)
+		return err;
+
+	return err;
+}
+EXPORT_SYMBOL(cmdq_pkt_mem_move);
+
 int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear)
 {
 	struct cmdq_instruction inst = { {0} };
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 1dae80185f9f..b6dbe2d8f16a 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -182,6 +182,16 @@ int cmdq_pkt_write_s_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
 int cmdq_pkt_write_s_mask_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
 				u16 addr_low, u32 value, u32 mask);
 
+/**
+ * cmdq_pkt_mem_move() - append memory move command to the CMDQ packet
+ * @pkt:	the CMDQ packet
+ * @src_addr:	source address
+ * @dma_addr_t: destination address
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


