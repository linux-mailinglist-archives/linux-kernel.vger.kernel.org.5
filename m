Return-Path: <linux-kernel+bounces-9350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD2281C46E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C6B1F250EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A2E168B6;
	Fri, 22 Dec 2023 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YGHObL/P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8363A7;
	Fri, 22 Dec 2023 04:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eaf4f550a08511eeba30773df0976c77-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=psOz/D6w4cz5Ki4AhGxRPNaz/YjLmA8Yz1FbmApe4v4=;
	b=YGHObL/PFf49d4JEZ/9H51A91DHpk3IHwGF3Uq+rKu4VCRO84WCK3NXUObM3dcA7SP8Jio9tekPUOwGyoD9oUd8RtOCVR7HZF+6D850aN67pPrVufGzj6dgdWMMa6w83sJXoozMmeDJcsRM0ZjxEDDy1ggfTczPztfnw7AUcMSE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:976dfcfc-67b4-4003-9530-4f9f495b9986,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:a4d20c82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eaf4f550a08511eeba30773df0976c77-20231222
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1062368413; Fri, 22 Dec 2023 12:52:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
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
Subject: [PATCH v3 6/9] soc: mediatek: cmdq: Add cmdq_pkt_finalize_loop for looping cmd with irq
Date: Fri, 22 Dec 2023 12:52:25 +0800
Message-ID: <20231222045228.27826-7-jason-jh.lin@mediatek.com>
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
X-TM-AS-Result: No-10--0.492500-8.000000
X-TMASE-MatchedRID: wDTc/wNgEcO6S8yZYvyqCb2xWbKjBfWPuLwbhNl9B5VOCtCDJNptxhFx
	R5JQAS6O09NQNrxIpFYQ5m8HWfjjn8xcivU0QoqPaK+MsTwM+1mlAfiiC1VA/eLsQIDmr3S5cBd
	H+AtoPBrL7a7vhpw6CIAy6p60ZV62Mhe627A+8aHdB/CxWTRRu+rAZ8KTspSzWT4KJpMmg3S77I
	sKEkexbNJvOnGME/lLUUuOsHK3otwxOgedmAunpWBME6/SK5iEAY/ZF9gZTzXp92WPce4cNxkUg
	0Ll9q5JF0aD5ljt43pMcHZD6gqu7wxMjfifIXfowkvVoA11Twp+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.492500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9F3AB5016B390CB062D039916EE8A520BB800B7261D22405B9ABB79809388DDB2000:8
X-MTK: N

Add cmdq_pkt_finalize_loop to CMDQ driver.

cmdq_pkt_finalize_loop appends end of command(EOC) instruction and
jump to start of command buffer instruction to make the command
buffer loopable.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 23 +++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index dfef436d9b8a..b6ba8b5d0db7 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -475,6 +475,29 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
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
index d1cd8108cad0..39994fc8a4f5 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -329,6 +329,14 @@ int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr);
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


