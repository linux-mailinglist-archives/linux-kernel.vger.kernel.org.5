Return-Path: <linux-kernel+bounces-129534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBDD896C3E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A32A28AB22
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACAF13A868;
	Wed,  3 Apr 2024 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Mgqw48cu"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F891369A1;
	Wed,  3 Apr 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139975; cv=none; b=sF+w4NPMqp4Hzviz6Rk9UvlUMLb0zUvZSNWSEc8CQdLF9EvAjuvRLLzlKAPKt9ELUdoR21+iuM7ql2rgt6neqWcNCzmqOSilom7PfdpB6C9EByS1axjMC5igM17WUmmS5gRSP5nZ+F7niPmikrCvW/ChPaB6C7oBOsJORehsiaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139975; c=relaxed/simple;
	bh=9xO4LGa3aQ7PIRaEnzklNRgJPNezVUHg+++HuslAGcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/W8fQ55B4YsdOnCkzWkMVkFOdAVKSZgvrl7EUAzT9UE9liyY33lxDwH9M6uHC/yWToA06Aw1HmyLqAi4ooiLNhIUg+MjrpmgXzxtim5gcL1k3kriGV0HKx1+cp/29x74xHf25Y5wwuaG1a0h1deYmRWz13dtR/kCmFa+6XVUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Mgqw48cu; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 948981f2f1a411eeb8927bc1f75efef4-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w9esVtcsVLWuIOEYSc/JKGQ0Zy+DWUvB3n2nojlJx2k=;
	b=Mgqw48cuFx9qaDt3R0E8AaDxUhO0dOQD4S4+7t2MVfNzhoDLFHKY0rTa1UIVEVqnle7b9+ePy2RjhVKT8psrQVXARp12jKVIPLfPdE0Mb4I/a/i3PPkniHFQfCy/y4UH1AVxlFtcqBINd+fBACYhhz6mRqFZM9jhwg5ARjWA7E4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:6ff2f287-9381-41ea-a649-d6f8514e0964,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:2afcc585-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 948981f2f1a411eeb8927bc1f75efef4-20240403
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 59256901; Wed, 03 Apr 2024 18:26:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
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
Subject: [PATCH v5 04/10] soc: mediatek: cmdq: Add cmdq_pkt_write_s_reg_value to support write value to reg
Date: Wed, 3 Apr 2024 18:25:56 +0800
Message-ID: <20240403102602.32155-5-shawn.sung@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.023400-8.000000
X-TMASE-MatchedRID: d+baqQ3qUqdvH7GZAcw0g8nUT+eskUQPLoYOuiLW+uW3zA6sbFwEjUiO
	7+wNDdeY8AyWk2NFMNbijpjet3oGSAQmkMsZWj5BaK+MsTwM+1lD3kXYiJVSRAbYcy9YQl6essf
	Gi2vQI7ji8zVgXoAltsIJ+4gwXrEtWBd6ltyXuvu7p9y7WlAwYv9XKjczNRSzdkokiizq+eSNgZ
	n0ZESZa4XO5VpZXxmYePCEu2U9xgShnbnFPdRZvgea3kOUi79I/CPHo3PMGmuAhOcaQrQ0U1GyR
	coeF18qmKP0zzpTAeGwod8xOMKmvMCBO+zxAW5pftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.023400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	BCBF0BDA709DBE8153C81139EA83AFD7A199DB842321E3A92A1AB23467E6F9482000:8
X-MTK: N

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

Add cmdq_pkt_write_s_reg_value to support write a value to a register.

It appends write_s command to the command buffer in a CMDQ packet,
ask GCE to excute a write instruction to write a value to a register
with low 16 bits physical address offset.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 13 +++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 11 +++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 72350138591c3..42a0194198d5b 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -292,6 +292,19 @@ int cmdq_pkt_write_s_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
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
index 1edb391ec604a..7bd77d40a5720 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -207,6 +207,17 @@ int cmdq_pkt_write_s_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
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
  * cmdq_pkt_mem_move() - append memory move command to the CMDQ packet
  * @pkt:	the CMDQ packet
-- 
2.18.0


