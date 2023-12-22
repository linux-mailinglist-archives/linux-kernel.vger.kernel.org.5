Return-Path: <linux-kernel+bounces-9346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6850F81C463
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FD22885F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71206C2D4;
	Fri, 22 Dec 2023 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DprMx1ed"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F236112;
	Fri, 22 Dec 2023 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eb260b40a08511eeba30773df0976c77-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lzqgP1KtFuX6XI7J7hHjisyucvK/askOV/faVONQtp0=;
	b=DprMx1edUEgqyYqN4ZvDX8Iba0jf0xOAiM1LHulQb5Og7EJcYTDyjOvuNvo9zs71aUk6fwu/zBYA4xPpGJoE4KR/L3O3cnKjibQuPD6OcGVCjml7i1oHGZeP6Pph6rMSmfGqduT/2TrQCsQdwq/8hPDpJXwQdanDWa50dnxiYKM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:17e7acfa-76df-4bea-b8cf-74c2b8372b26,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:a3b8738d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eb260b40a08511eeba30773df0976c77-20231222
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2015340799; Fri, 22 Dec 2023 12:52:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
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
Subject: [PATCH v3 4/9] soc: mediatek: cmdq: Add cmdq_pkt_write_s_reg_value to support write value to reg
Date: Fri, 22 Dec 2023 12:52:23 +0800
Message-ID: <20231222045228.27826-5-jason-jh.lin@mediatek.com>
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
X-TM-AS-Result: No-10--1.192500-8.000000
X-TMASE-MatchedRID: k8Cd32tj8sFvH7GZAcw0g8nUT+eskUQPLoYOuiLW+uU06dhcpwNHEBFx
	R5JQAS6O09NQNrxIpFYQ5m8HWfjjn5/1JE49xL3GaUe/i9AephOlAfiiC1VA/aUIR8WYCZ8yo8W
	MkQWv6iXBcIE78YqRWo6HM5rqDwqtSjEbty+5RAw3D5+9hEAfnqdHW2GAcBekaA/4J+I0pB6tRT
	0UuGYQUzfmXwixG2Ih7CbXtL4xRRJ83aVkj2fp76V2chaMw8OHwZBgUyJVEbl6Fw8/PpTMRaVvm
	iAyeA2kc5MSfkiJFI5QBJtcKcOYfpRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.192500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	7665CB8DB71DB0D075B3BF58E3AF737164242C705814F4F76513766263AE46EF2000:8
X-MTK: N

Add cmdq_pkt_write_s_reg_value to support write a value to a register.

It appends write_s command to the command buffer in a CMDQ packet,
ask GCE to excute a write instruction to write a value to a register
with low 16 bits physical address offset.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 13 +++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 11 +++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 60f8ecbab5e7..dfef436d9b8a 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -287,6 +287,19 @@ int cmdq_pkt_write_s_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
 }
 EXPORT_SYMBOL(cmdq_pkt_write_s_value);
 
+int cmdq_pkt_write_s_reg_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx, u32 value)
+{
+	struct cmdq_instruction inst = {};
+
+	inst.op = CMDQ_CODE_WRITE_S;
+	inst.dst_t = CMDQ_REG_TYPE;
+	inst.reg_dst = high_addr_reg_idx;
+	inst.value = value;
+
+	return cmdq_pkt_append_command(pkt, inst);
+}
+EXPORT_SYMBOL(cmdq_pkt_write_s_reg_value);
+
 int cmdq_pkt_write_s_mask_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
 				u16 addr_low, u32 value, u32 mask)
 {
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 73eadda1dd2d..d1cd8108cad0 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -208,6 +208,17 @@ int cmdq_pkt_write_s_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
 int cmdq_pkt_write_s_mask_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
 				u16 addr_low, u32 value, u32 mask);
 
+/**
+ * cmdq_pkt_write_s_reg_value() - append write_s command to the CMDQ packet which
+ *				  write value to a register with low address pa
+ * @pkt:	the CMDQ packet
+ * @high_addr_reg_idx:	internal register ID which contains high address of pa
+ * @value:	the specified target value
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_write_s_reg_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx, u32 value);
+
 /**
  * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
  * @pkt:	the CMDQ packet
-- 
2.18.0


