Return-Path: <linux-kernel+bounces-129538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61526896C49
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED631C26C5B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487EE13C69F;
	Wed,  3 Apr 2024 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kEa0IzeA"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653FC13A411;
	Wed,  3 Apr 2024 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139978; cv=none; b=mVaKqc4mRYMkEcLcBMNbBwAWnq3jJxxoYNROWbicQfpUZR2Qg17fWlAQZ+ULprwF0Na/9FPAIPFdhu5R3Xg7tmqlBn2ZFzUxBBk/nDcS9iwkuslmB6Dnr/EuO7EHLNQ9v5REqWacwFnNQITgU8Psvbeiov8ZFpNFVdHYo6tl1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139978; c=relaxed/simple;
	bh=3qKoZ6YgbTQtLg9qRCujoyUM/Eyrn5CSdv258g/MUQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rw8FTjf6bZR4+rFPyE91l/IEoY9z4FV8LTLVrLk4EFDF3huBagqWDPbnvp9hVztZuP2dcqLDb2Zl17yxgS0dgzsJ+fH934tMZEyVVN8nyukg0bP13+DHIQx4xJXVvgp68hLmghCNFZXSvgB2vwUF+X/G4+hQaMfrjJCEC5hGL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kEa0IzeA; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 941ff9eef1a411ee935d6952f98a51a9-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=npIW13bgHexCVVqoGhlPSDwYczA5gkfDJSJKFTSYKKg=;
	b=kEa0IzeA5eyUb/hm82gxYxeXYUOiHB9F/YLVWCqe00fzbNxiSaflOUPO3cHlMQL0za4v1cKO342UdBQ8lcHqmtBIiOHoq7YSSAfA65eXAq0OFXlU5yiGnrxawBVnkhbjbDURJ9m1KtWWPDmdJiLY36poneFPhcVydza8CgD2imA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:8681d16e-3406-4aae-9ed8-d9d376d763ed,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:92564582-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 941ff9eef1a411ee935d6952f98a51a9-20240403
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1582456156; Wed, 03 Apr 2024 18:26:05 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
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
Subject: [PATCH v5 03/10] soc: mediatek: cmdq: Add cmdq_pkt_logic_command to support math operation
Date: Wed, 3 Apr 2024 18:25:55 +0800
Message-ID: <20240403102602.32155-4-shawn.sung@mediatek.com>
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

Add cmdq_pkt_logic_command to support math operation.

cmdq_pkt_logic_command can append logic command to the CMDQ packet,
ask GCE to execute a arithmetic calculate instruction,
such as add, subtract, multiply, AND, OR and NOT, etc.

Note that all arithmetic instructions are unsigned calculations.
If there are any overflows, GCE will sent the invalid IRQ to notify
CMDQ driver.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 39 ++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 42 ++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 8acd8e38283e0..72350138591c3 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -15,9 +15,21 @@
 /* dedicate the last GPR_R15 to assign the register address to be poll */
 #define CMDQ_POLL_ADDR_GPR	(15)
 #define CMDQ_EOC_IRQ_EN		BIT(0)
+#define CMDQ_IMMEDIATE_VALUE	0
 #define CMDQ_REG_TYPE		1
 #define CMDQ_JUMP_RELATIVE	1
 
+#define CMDQ_GET_ARG_B(arg)		(((arg) & GENMASK(31, 16)) >> 16)
+#define CMDQ_GET_ARG_C(arg)		((arg) & GENMASK(15, 0))
+
+#define CMDQ_OPERAND_GET_IDX_VALUE(operand) \
+	({ \
+		struct cmdq_operand *op = operand; \
+		op->reg ? op->idx : op->value; \
+	})
+#define CMDQ_OPERAND_TYPE(operand) \
+	((operand)->reg ? CMDQ_REG_TYPE : CMDQ_IMMEDIATE_VALUE)
+
 struct cmdq_instruction {
 	union {
 		u32 value;
@@ -470,6 +482,33 @@ int cmdq_pkt_poll_addr(struct cmdq_pkt *pkt, dma_addr_t addr, u32 value, u32 mas
 }
 EXPORT_SYMBOL(cmdq_pkt_poll_addr);
 
+int cmdq_pkt_logic_command(struct cmdq_pkt *pkt, u16 result_reg_idx,
+			   struct cmdq_operand *left_operand,
+			   enum cmdq_logic_op s_op,
+			   struct cmdq_operand *right_operand)
+{
+	struct cmdq_instruction inst = { {0} };
+	u32 left_idx_value;
+	u32 right_idx_value;
+
+	if (!left_operand || !right_operand || s_op >= CMDQ_LOGIC_MAX)
+		return -EINVAL;
+
+	left_idx_value = CMDQ_OPERAND_GET_IDX_VALUE(left_operand);
+	right_idx_value = CMDQ_OPERAND_GET_IDX_VALUE(right_operand);
+	inst.op = CMDQ_CODE_LOGIC;
+	inst.dst_t = CMDQ_REG_TYPE;
+	inst.src_t = CMDQ_OPERAND_TYPE(left_operand);
+	inst.arg_c_t = CMDQ_OPERAND_TYPE(right_operand);
+	inst.sop = s_op;
+	inst.reg_dst = right_idx_value;
+	inst.src_reg = left_idx_value;
+	inst.arg_c = result_reg_idx;
+
+	return cmdq_pkt_append_command(pkt, inst);
+}
+EXPORT_SYMBOL(cmdq_pkt_logic_command);
+
 int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
 {
 	struct cmdq_instruction inst = {};
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index f708bcfebdd8a..1edb391ec604a 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -25,6 +25,31 @@
 
 struct cmdq_pkt;
 
+enum cmdq_logic_op {
+	CMDQ_LOGIC_ASSIGN = 0,
+	CMDQ_LOGIC_ADD = 1,
+	CMDQ_LOGIC_SUBTRACT = 2,
+	CMDQ_LOGIC_MULTIPLY = 3,
+	CMDQ_LOGIC_XOR = 8,
+	CMDQ_LOGIC_NOT = 9,
+	CMDQ_LOGIC_OR = 10,
+	CMDQ_LOGIC_AND = 11,
+	CMDQ_LOGIC_LEFT_SHIFT = 12,
+	CMDQ_LOGIC_RIGHT_SHIFT = 13,
+	CMDQ_LOGIC_MAX,
+};
+
+struct cmdq_operand {
+	/* register type */
+	bool reg;
+	union {
+		/* index */
+		u16 idx;
+		/* value */
+		u16 value;
+	};
+};
+
 struct cmdq_client_reg {
 	u8 subsys;
 	u16 offset;
@@ -286,6 +311,23 @@ int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
  */
 int cmdq_pkt_poll_addr(struct cmdq_pkt *pkt, dma_addr_t addr, u32 value, u32 mask);
 
+/**
+ * cmdq_pkt_logic_command() - Append logic command to the CMDQ packet, ask GCE to
+ *		          execute an instruction that store the result of logic operation
+ *		          with left and right operand into result_reg_idx.
+ * @pkt:		the CMDQ packet
+ * @result_reg_idx:	SPR index that store operation result of left_operand and right_operand
+ * @left_operand:	left operand
+ * @s_op:		the logic operator enum
+ * @right_operand:	right operand
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_logic_command(struct cmdq_pkt *pkt, u16 result_reg_idx,
+			   struct cmdq_operand *left_operand,
+			   enum cmdq_logic_op s_op,
+			   struct cmdq_operand *right_operand);
+
 /**
  * cmdq_pkt_assign() - Append logic assign command to the CMDQ packet, ask GCE
  *		       to execute an instruction that set a constant value into
-- 
2.18.0


