Return-Path: <linux-kernel+bounces-129106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFD7896515
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39511B230ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112CF5C8FC;
	Wed,  3 Apr 2024 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EQydvTcp"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B27548FF;
	Wed,  3 Apr 2024 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127377; cv=none; b=RcssNRzobGf8w3n36uKYRV3L3IT2tam/eTpA2N4CfLacJxj2S0B2SbGjrvkA9Lzdj33SLOgsfW89EC0WiPKlYkLi5gTMN4oXj6E7LXoPAVg402gXBljOup0p6dcrH9Eqv57CgacLNP7pd0GNrKDGDyBbdtc1Mr7nUAqcisfPeyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127377; c=relaxed/simple;
	bh=AL3q3ReRCJOxrc6vlvwbec1rNRN/cKVeyg6cWyL+caY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEwpz4kWZYH7MR/Q7TqCFxv5SnAHwBuVYmrHCfTuAqSoKqmL9huRbxcxiJR71dpDtj7gfDmfJjPz9vpDuJrnSBDgdvTa0YDuQeywGgTMXQRBVgj9U+jgBl5lXj1c3gMxWeQTQCJDEVy9ryA1LPXpq9OjiT5oThziR4TQEz80Id0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EQydvTcp; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3fddd3f0f18711ee935d6952f98a51a9-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=r4qQPZc+/GoLDQPudtupT2SUtqhm0p/NGdk0sBfQwhQ=;
	b=EQydvTcpZSdT1ijOHbj/9DpATzG7ioj5NNRqI8wo/7CSGapsenaaVnEgRcLgGMNZw6Da4MN7c9LU26ZP0JgwkNqAyl426a3Pgm+2SHqlAxMVqOFIfGBVOV8LgGr7GJAt3l3at5dAeATOotOzUJP91CeSXh9YAq+9zD2sM+qa3y4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:76e01155-dd72-426e-83d8-4f24e9543bc6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:ca0f2a91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3fddd3f0f18711ee935d6952f98a51a9-20240403
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1565896701; Wed, 03 Apr 2024 14:56:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 14:56:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 14:56:05 +0800
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
Subject: [PATCH v4 3/9] soc: mediatek: cmdq: Add cmdq_pkt_logic_command to support math operation
Date: Wed, 3 Apr 2024 14:55:57 +0800
Message-ID: <20240403065603.21920-4-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240403065603.21920-1-shawn.sung@mediatek.com>
References: <20240403065603.21920-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.613300-8.000000
X-TMASE-MatchedRID: iSQL5szRvdE7GQ7VM/DlUU0IfQOJvRLRSOZtBHQ3LLxaW2Ktn+I8/uOY
	+B3JL0OUK+GE57usLIhYo3G+rvxrNW94Ipa1otxokdRuK7C3A1n54F/2i/DwjTNzZQXTq3sOeKL
	mRI5Hi0ZOYdz5QZC+SvIEyraL6t40Nyl1nd9CIt0URSScn+QSXt0H8LFZNFG7CKFCmhdu5cXAcF
	symLAWlc2OsWYJwQvYi/g2Rw5ZUryMvy+Qk/2Wz5wuVXSj7k6UWVkme70ZEbPwaG2wK/lzInigr
	56Dlh1VxEMoHJn1dXAXRoPmWO3jekxwdkPqCq7vDEyN+J8hd+jCS9WgDXVPCp6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.613300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9D6CA23782573202F0982113052E333616E5BFDAF8BF754CAF83594983E7EADF2000:8
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
 drivers/soc/mediatek/mtk-cmdq-helper.c | 36 ++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 42 ++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 8acd8e38283e0..818e6ab24370a 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -15,9 +15,18 @@
 /* dedicate the last GPR_R15 to assign the register address to be poll */
 #define CMDQ_POLL_ADDR_GPR	(15)
 #define CMDQ_EOC_IRQ_EN		BIT(0)
+#define CMDQ_IMMEDIATE_VALUE	0
 #define CMDQ_REG_TYPE		1
 #define CMDQ_JUMP_RELATIVE	1
 
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
@@ -470,6 +479,33 @@ int cmdq_pkt_poll_addr(struct cmdq_pkt *pkt, dma_addr_t addr, u32 value, u32 mas
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
+	inst.arg_c = right_idx_value;
+	inst.src_reg = left_idx_value;
+	inst.reg_dst = result_reg_idx;
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


