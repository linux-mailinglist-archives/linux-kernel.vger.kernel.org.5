Return-Path: <linux-kernel+bounces-88577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F1786E3A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029F5285E54
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526076FBB7;
	Fri,  1 Mar 2024 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DUVqWY0x"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1763AC0C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304255; cv=none; b=HCnqeMWYLtGLRzq25zep1shHNAABDUTpPYW9/G9GtTqF9J1G4pL1JsxusbV+j1WKQSERdlwDcFyjPwmuIipndf4LtjVdMOY+Tm6H+HDPvWONs27DEyNOBHr5SGkTgARkc4pwhU7fscwDS+nfrx7W8D+yNafpYlrSw3Is8aZOQtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304255; c=relaxed/simple;
	bh=nEBISZhRLnmZQR1GppQaZadHgVStFIak6rMZ86tO/Gc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpqQBZpLh+7+oXSTGCNv11CuSM7FL7JVRf6u4RNTAGJu+760dY4JjUVqFbfzS926ye51cgaBJzRGN0Hrhv1KCTWW/lwE2TCyPG3BsKvXOlaRCZ0WHfh/3zMeSmjRJAyxkEmaH3Js8A3E1iYgRfQOXBYclma7cm0WHVcFG/C+0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DUVqWY0x; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2795cee0d7da11ee935d6952f98a51a9-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oTUfVJxuZrvqX09d0OmYEW32i4hjXrbksVX4sghk4+0=;
	b=DUVqWY0xfQM3U/Lc9kZVGgIjr6AmlXxLN1MznG5LeScY7l7x9H6AiiXgGmrFWn7FKpGNc/d7BEAPph6Xn+e9E8dnQKrBWAiExsRVnQLlc9Le1tpTqeobujiRLUWjnDr3CNsVWGXEQvtJGf2dJQ73YGP5lLnBrodZEoi549MWlYI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:49fbbb22-8d38-4923-8944-c6ae1f536402,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:3044e88f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2795cee0d7da11ee935d6952f98a51a9-20240301
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1447994538; Fri, 01 Mar 2024 22:44:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 22:44:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 22:44:05 +0800
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
Subject: [RESEND, PATCH 4/5] soc: mediatek: mtk-cmdq: Add cmdq_pkt_acquire_event() function
Date: Fri, 1 Mar 2024 22:44:02 +0800
Message-ID: <20240301144403.2977-5-jason-jh.lin@mediatek.com>
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

Add cmdq_pkt_acquire_event() function to support CMDQ user making
an instruction for acquiring event.

CMDQ users can use cmdq_pkt_acquire_event() and cmdq_pkt_clear_event()
to acquire GCE event and release GCE event and achieve the MUTEX_LOCK
protection between GCE threads.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 15 +++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  |  9 +++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 2e9fc9bb1183..0183b40a0eff 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -342,6 +342,21 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear)
 }
 EXPORT_SYMBOL(cmdq_pkt_wfe);
 
+int cmdq_pkt_acquire_event(struct cmdq_pkt *pkt, u16 event)
+{
+	struct cmdq_instruction inst = {};
+
+	if (event >= CMDQ_MAX_EVENT)
+		return -EINVAL;
+
+	inst.op = CMDQ_CODE_WFE;
+	inst.value = CMDQ_WFE_UPDATE | CMDQ_WFE_UPDATE_VALUE | CMDQ_WFE_WAIT;
+	inst.event = event;
+
+	return cmdq_pkt_append_command(pkt, inst);
+}
+EXPORT_SYMBOL(cmdq_pkt_acquire_event);
+
 int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
 {
 	struct cmdq_instruction inst = { {0} };
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 2fe9be240fbc..de93c0a8e8a9 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -202,6 +202,15 @@ int cmdq_pkt_mem_move(struct cmdq_pkt *pkt, dma_addr_t src_addr, dma_addr_t dst_
  */
 int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear);
 
+/**
+ * cmdq_pkt_acquire_event() - append acquire event command to the CMDQ packet
+ * @pkt:	the CMDQ packet
+ * @event:	the desired event to be acquired
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_acquire_event(struct cmdq_pkt *pkt, u16 event);
+
 /**
  * cmdq_pkt_clear_event() - append clear event command to the CMDQ packet
  * @pkt:	the CMDQ packet
-- 
2.18.0


