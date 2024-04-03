Return-Path: <linux-kernel+bounces-129540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05653896C5B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 900D7B2926D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071A713D2B1;
	Wed,  3 Apr 2024 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rs/wCJGT"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611AD13BC2A;
	Wed,  3 Apr 2024 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139980; cv=none; b=ZBMyaN0V427UZSuOiItdYWYzWoXuCNysnnYjbbb0g6XNKxyPxP+OqNUHKuTGKd2Ccws/WUfnVsQQ77NQJBbpaF67w0qhX09nFb34hegE1R7wHF66M6BQx2JoDYeb2QnL8VRBAMFgvK8rdI9OOrdE5WAocQxnlPp+9PfAz/dbjpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139980; c=relaxed/simple;
	bh=GJgVddcGoW5bxK2gZCR0J0oPNmiu9Ano7+kxoSEJ/Jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruTNJ50EhkyHfXimRmRWJ4FTuiRELxocfTu5H4vsc+08gntJaHMtMTX3ESXBb04nBYNhSVTOmpDT7/ImgeseiSH00TN+Ha80J9uBvXmVoYU65/d/HyAfj4bQt2gwhhyA7c3XLvgIb1w86E3O11Xl332XtVEtpcWvpVghabV75vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rs/wCJGT; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 93f1071af1a411ee935d6952f98a51a9-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CaEo9t4w8Wnx0t6QxvMtg/WxTOIvZPRuUESUXWMpGKI=;
	b=rs/wCJGT1WUWkU3j2imEh8539mP+2+pMW+xN+hIqOPax1o7RcQc7l1ErPwEb6wHMqyJ67N1udkT5dmLVTrj+nZiL8b3mpSEr3Ln4CXBV6P/H1bqPRoVgAWsObHQGJxRuT93wZktSJr3y8VatkvLSR3Csh9KB4Jsg1Fr+e2Zr5No=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:1f0c02e4-f1c5-4b73-ae95-6f49cdc6b6bb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:7d6faa00-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 93f1071af1a411ee935d6952f98a51a9-20240403
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1888370716; Wed, 03 Apr 2024 18:26:05 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 18:26:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 18:26:04 +0800
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
Subject: [PATCH v5 06/10] soc: mediatek: cmdq: Add cmdq_pkt_finalize_loop for looping cmd with irq
Date: Wed, 3 Apr 2024 18:25:58 +0800
Message-ID: <20240403102602.32155-7-shawn.sung@mediatek.com>
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

Add cmdq_pkt_finalize_loop to CMDQ driver.

cmdq_pkt_finalize_loop appends end of command(EOC) instruction and
jump to start of command buffer instruction to make the command
buffer loopable.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 23 +++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 42a0194198d5b..3e5a9c4592fd0 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -568,6 +568,29 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 }
 EXPORT_SYMBOL(cmdq_pkt_finalize);
 
+int cmdq_pkt_finalize_loop(struct cmdq_pkt *pkt)
+{
+	struct cmdq_instruction inst = { {0} };
+	int err;
+
+	/* insert EOC and generate IRQ for each command iteration */
+	inst.op = CMDQ_CODE_EOC;
+	inst.value = CMDQ_EOC_IRQ_EN;
+	err = cmdq_pkt_append_command(pkt, inst);
+	if (err < 0)
+		return err;
+
+	/* JUMP to start of pkt */
+	err = cmdq_pkt_jump(pkt, pkt->pa_base);
+	if (err < 0)
+		return err;
+
+	pkt->loop = true;
+
+	return err;
+}
+EXPORT_SYMBOL(cmdq_pkt_finalize_loop);
+
 int cmdq_pkt_flush_async(struct cmdq_pkt *pkt)
 {
 	int err;
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 7bd77d40a5720..f986117d930c0 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -371,6 +371,14 @@ int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr);
  */
 int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
 
+/**
+ * cmdq_pkt_finalize_loop() - Append EOC and jump to start command.
+ * @pkt:	the CMDQ packet
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_finalize_loop(struct cmdq_pkt *pkt);
+
 /**
  * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
  *                          packet and call back at the end of done packet
-- 
2.18.0


