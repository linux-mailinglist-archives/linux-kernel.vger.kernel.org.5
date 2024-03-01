Return-Path: <linux-kernel+bounces-88313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0524786DFED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FD41F2167C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55F6DD1D;
	Fri,  1 Mar 2024 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UiZIe6qH"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB06CBF4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291510; cv=none; b=tl3946Gq6RU9mxi9XxgOq2xMjkeyC+o81zWFBAn0Q7l2zcSYm1NQnpWgbscZlSW4Ef5wbWs7YG9XpzQX3YluJL7F1x6prkhn4rNyicZDVi2utZsg0lq2S1hGu9jrYuy+s9hhmriNQJt0JOnAJiE8ZESXveuCcasu4NdHRXsl1oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291510; c=relaxed/simple;
	bh=lcf6ISvRdP93LwevPmIdccsV9c8GNSWRWufOXo3fCOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIISt5/LB8h4ulimxSXCJE/95cVpwi+T2CKZ35E0jfPifFZxZ6FW0Lh/99P21WphMhSerJArXJh+bsuKTKSvtz+NsjOIPe7Vo8nNzAGHwgV37b6+KoHMIPbde9Hg6dCRg+GnJEKbp11p56v7SlXdEXp21dL0UNxU/unGQLtZ7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UiZIe6qH; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7b220aced7bc11ee935d6952f98a51a9-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qA7Fa8xFKt4h1LbtbejWn8H0L71pbaHZe8bM38M5K3Q=;
	b=UiZIe6qHGTxxmL1cXJ6RsF0YKbd7VF0lhFF3iWt+0S7ostsUBsDgG20RKB5yJMsj3zkcm5+4cO3qxgTrx5sakRDnGhU7uDC4dfoKFCXtyE1OFZ/6I2Bvuuok3J/kEzXwa7oz4LXrnPjoqwzKgTrHW7A7w0QWXNXlk2RTwiPyu+U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f60e97e2-b46f-439e-9dcd-c8314d056cc8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:460ce78f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7b220aced7bc11ee935d6952f98a51a9-20240301
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2013887389; Fri, 01 Mar 2024 19:11:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 19:11:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 19:11:39 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jason-ch Chen <jason-ch.chen@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 3/5] soc: mediatek: mtk-cmdq: Add cmdq_pkt_poll_addr() function
Date: Fri, 1 Mar 2024 19:11:24 +0800
Message-ID: <20240301111126.22035-4-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240301111126.22035-1-jason-jh.lin@mediatek.com>
References: <20240301111126.22035-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.772500-8.000000
X-TMASE-MatchedRID: 8X2PBhRYyqJYXTxImR5ZvFVN8laWo90MYu7s3QSSN+Tfc2Xd6VJ+ysxF
	Qxp3PhHyz4sGsPGzdli46TLvlH7amuHxFb2pjr4bhK8o4aoss8pKPIx+MJF9o99RlPzeVuQQXVC
	mjmk3KwwDvKUzYsUZK1fsuOSPFWFcKYkG37rHS8Xzh2yKdnl7WPSEh8AqyHUv/rvU1dGgVf76au
	5bveuHjHhYmQFcXfkdgDLqnrRlXrZ8nn9tnqel2K6NVEWSRWybLIRvJZxdOT8ccxlO3vDdFnpRb
	6jaaE2WB4xikmzQuji9mcsT4mLfgePF7+QNf5yPgesk0PKcIwDLcleArf7N1eS8xlf5yikEjofs
	MjQaxVwyYjbiqIQ3CsykhtyXcigD6rVdgBjDT2r1nXJavJVNag==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.772500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F66502118867CD93F42C699C31E1482D3047D14864830B5BC5BAD1E4B63B00072000:8
X-MTK: N

Add cmdq_pkt_poll_addr function to support CMDQ user making
an instruction for polling a specific address of hardware rigster
to check the value with or without mask.

POLL is an old operation in GCE, so it does not support SPR and
CMDQ_CODE_LOGIC. CMDQ users need to use GPR and CMDQ_CODE_MASK
to move polling register address to GPR to make an instruction.
This will be done in cmdq_pkt_poll_addr().

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Change-Id: I91ff98e06570dc4501187eb29de64aaa65b1cf13
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 38 ++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 16 +++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 3a1e47ad8a41..2e9fc9bb1183 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -12,6 +12,7 @@
 
 #define CMDQ_WRITE_ENABLE_MASK	BIT(0)
 #define CMDQ_POLL_ENABLE_MASK	BIT(0)
+#define CMDQ_POLL_HIGH_ADDR_GPR	(14)
 #define CMDQ_EOC_IRQ_EN		BIT(0)
 #define CMDQ_REG_TYPE		1
 #define CMDQ_JUMP_RELATIVE	1
@@ -406,6 +407,43 @@ int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
 }
 EXPORT_SYMBOL(cmdq_pkt_poll_mask);
 
+int cmdq_pkt_poll_addr(struct cmdq_pkt *pkt, dma_addr_t addr, u32 value, u32 mask)
+{
+	struct cmdq_instruction inst = { {0} };
+	int err;
+	u8 use_mask = 0;
+
+	if (mask != U32_MAX) {
+		inst.op = CMDQ_CODE_MASK;
+		inst.mask = ~mask;
+		err = cmdq_pkt_append_command(pkt, inst);
+		if (err != 0)
+			return err;
+		use_mask = CMDQ_POLL_ENABLE_MASK;
+	}
+
+	/*
+	 * POLL is an old operation in GCE and it does not support SPR and CMDQ_CODE_LOGIC,
+	 * so it can not use cmdq_pkt_assign to keep polling register address to SPR.
+	 * It needs to use GPR and CMDQ_CODE_MASK to move polling register address to GPR.
+	 */
+	inst.op = CMDQ_CODE_MASK;
+	inst.dst_t = CMDQ_REG_TYPE;
+	inst.sop = CMDQ_POLL_HIGH_ADDR_GPR;
+	inst.mask = addr;
+	err = cmdq_pkt_append_command(pkt, inst);
+	if (err < 0)
+		return err;
+
+	inst.op = CMDQ_CODE_POLL;
+	inst.dst_t = CMDQ_REG_TYPE;
+	inst.sop = CMDQ_POLL_HIGH_ADDR_GPR;
+	inst.offset = use_mask;
+	inst.value = value;
+	return cmdq_pkt_append_command(pkt, inst);
+}
+EXPORT_SYMBOL(cmdq_pkt_poll_addr);
+
 int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
 {
 	struct cmdq_instruction inst = {};
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index b6dbe2d8f16a..2fe9be240fbc 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -253,6 +253,22 @@ int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
 int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
 		       u16 offset, u32 value, u32 mask);
 
+/**
+ * cmdq_pkt_poll_addr() - Append polling command to the CMDQ packet, ask GCE to
+ *			 execute an instruction that wait for a specified
+ *			 address of hardware register to check for the value
+ *			 w/ or w/o mask.
+ *			 All GCE hardware threads will be blocked by this
+ *			 instruction.
+ * @pkt:	the CMDQ packet
+ * @addr:	the hardware register address
+ * @value:	the specified target register value
+ * @mask:	the specified target register mask
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_poll_addr(struct cmdq_pkt *pkt, dma_addr_t addr, u32 value, u32 mask);
+
 /**
  * cmdq_pkt_assign() - Append logic assign command to the CMDQ packet, ask GCE
  *		       to execute an instruction that set a constant value into
-- 
2.18.0


