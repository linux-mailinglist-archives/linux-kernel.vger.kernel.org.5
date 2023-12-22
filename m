Return-Path: <linux-kernel+bounces-9348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A9381C46C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF981C2155C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8C2156F8;
	Fri, 22 Dec 2023 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RJ0e3mop"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF00D5686;
	Fri, 22 Dec 2023 04:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eb29d1e4a08511eeba30773df0976c77-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XefOp4ZJvMjNDUufB+lwYo0EoScCX1JmmrJqNPVCwco=;
	b=RJ0e3mopkEqK63hLaWJT/Gnx1EMxNhMhRrVl8CFs2glnNCqj3Ch7Ya/bAkPgYJGCY+rQxHfC0byRLHCMWhiBGHW3QdqMu2wKi6Yv/K7DmKV1YaaYX1HEDF6hwBAlQEKnIVydQMbeinSP5aRN5UNGCGRN35oiOVoCHqJxswHhYWs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:3d833785-f4a7-428b-a562-bcfc1827b90e,IP:0,U
	RL:0,TC:0,Content:44,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:44
X-CID-META: VersionHash:5d391d7,CLOUDID:0f1a5e2e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eb29d1e4a08511eeba30773df0976c77-20231222
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1425945041; Fri, 22 Dec 2023 12:52:33 +0800
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
Subject: [PATCH v3 5/9] mailbox: mtk-cmdq: Support GCE loop packets in interrupt handler
Date: Fri, 22 Dec 2023 12:52:24 +0800
Message-ID: <20231222045228.27826-6-jason-jh.lin@mediatek.com>
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
X-TM-AS-Result: No-10--6.634800-8.000000
X-TMASE-MatchedRID: yvDAzrttxFXlOkrqlJanurMjW/sniEQKLoYOuiLW+uUnArDy4nBG1Hv9
	jBhUgWuo8rh5UHP2/XFYo3G+rvxrNW94Ipa1otxo4pdq9sdj8LXljSRvSGpq3Ddnd59Af7CPaza
	5eRS5azTftLFtxOSbQ4Ay6p60ZV62fJ5/bZ6npdg7AFczfjr/7EBFd4FGrBKQyOewPmnLzhtVIo
	CVHgZEDqFC7/IJnZXOFNQUJ0xmGqI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.634800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F6326F6ACD43B13C78C9E85D2560378FEB293B7531CAB4A1C8754E0662C85E852000:8
X-MTK: N

1. Add a loop flag for CMDQ packet struct.
CMDQ helper will use a loop flag to mark CMDQ packet as lopping command
and make current command buffer jumps to the beginning when GCE executes
to the end of command buffer.

2. Add a looping task handle flow in irq handler.
GCE irq occurs when GCE executes to the end of command(EOC) instruction.
If the CMDQ packet is a loopping command, GCE irq handler can not
delete the CMDQ task and disable the GCE thread.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c       | 11 +++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 27ff3a3ccf2f..5390b6488ebc 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -267,6 +267,17 @@ static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 
 	curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR) << cmdq->pdata->shift;
 
+	task = list_first_entry_or_null(&thread->task_busy_list,
+					struct cmdq_task, list_entry);
+	if (task && task->pkt->loop) {
+		struct cmdq_cb_data data;
+
+		data.sta = err;
+		data.pkt = task->pkt;
+		mbox_chan_received_data(task->thread->chan, &data);
+		return;
+	}
+
 	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
 				 list_entry) {
 		task_end_pa = task->pa_base + task->pkt->cmd_buf_size;
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index a8f0070c7aa9..f78a08e7c6ed 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -76,6 +76,7 @@ struct cmdq_pkt {
 	size_t			cmd_buf_size; /* command occupied size */
 	size_t			buf_size; /* real buffer size */
 	void			*cl;
+	bool			loop;
 };
 
 u8 cmdq_get_shift_pa(struct mbox_chan *chan);
-- 
2.18.0


