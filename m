Return-Path: <linux-kernel+bounces-88314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C1C86DFEE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82676B2284F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC54F6E2BD;
	Fri,  1 Mar 2024 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UL2yJr5x"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2566CDD0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291510; cv=none; b=gASEvSEaa9Lx5IZ6ceqisKnraGLAZt3tY7y1m9El6lbSMV+nemoeTaXpVRR9jHZJa0e1rWl1Yit7R5ZG0OLq7GIZiQUOgE32gae4jmu0WnWvYDL3mm6ClFWK6XMmeHOyDc8vv9hlBOhIF/gu1GIYnBYXsOc/F4uaa6+OnzRI32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291510; c=relaxed/simple;
	bh=IVRtfNLXbmzGsyAyeM9ASrfY4QLijvyhcrBsWmpmNNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upOCTp4oL7jTz0hqOH9zfjOSlZ8FeENBqJpZCZLWUt1VU/sQxCjIhfZwqwFdQ+PIjFju/WyWmIi6Ql1Cliz2M1wk0l7UvdptuXbb23q59/iMO63T90tj8iSXAYbEK12qlVw8QkpPmFg25HB7Cedpq1JdBndC35IddGkJ+B98MpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UL2yJr5x; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7b02dbe0d7bc11eeb8927bc1f75efef4-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=naxRfz0glm2gXaKY7qe5Y6Vv0mbtIv1NbKOQNRgTODw=;
	b=UL2yJr5x4skFK0uu7KesApvAQ8W+noPhjn5nBDde5RwhTlpJDaZkF8upIjXuFUx0QssDsx0Lev/sz6zQcIeDRsupHelwzt1erjQAsam+yF/ehppM0g+2xIgZDnfK3RY5fmQrd12t7QWPRlHHI/ABASsXsVcS/2eNPCGzd261dwg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:dbe420e6-f623-4566-b02d-810835401d12,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:f5348084-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7b02dbe0d7bc11eeb8927bc1f75efef4-20240301
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1720413041; Fri, 01 Mar 2024 19:11:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
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
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 5/5] mailbox: mtk-cmdq: Add support runtime get and set GCE event
Date: Fri, 1 Mar 2024 19:11:26 +0800
Message-ID: <20240301111126.22035-6-jason-jh.lin@mediatek.com>
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
X-MTK: N

ISP drivers need to get and set GCE event in their runtime contorl flow.
So add these functions to support get and set GCE by CPU.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Change-Id: I494c34ebc5ec26c82213f2bc03d2033d60652523
---
 drivers/mailbox/mtk-cmdq-mailbox.c       | 37 ++++++++++++++++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index ead2200f39ba..d7c08249c898 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -25,7 +25,11 @@
 #define CMDQ_GCE_NUM_MAX		(2)
 
 #define CMDQ_CURR_IRQ_STATUS		0x10
+#define CMDQ_SYNC_TOKEN_ID		0x60
+#define CMDQ_SYNC_TOKEN_VALUE		0x64
+#define CMDQ_TOKEN_ID_MASK			GENMASK(9, 0)
 #define CMDQ_SYNC_TOKEN_UPDATE		0x68
+#define CMDQ_TOKEN_UPDATE_VALUE			BIT(16)
 #define CMDQ_THR_SLOT_CYCLES		0x30
 #define CMDQ_THR_BASE			0x100
 #define CMDQ_THR_SIZE			0x80
@@ -83,6 +87,7 @@ struct cmdq {
 	struct cmdq_thread	*thread;
 	struct clk_bulk_data	clocks[CMDQ_GCE_NUM_MAX];
 	bool			suspended;
+	spinlock_t		event_lock; /* lock for gce event */
 };
 
 struct gce_plat {
@@ -113,6 +118,38 @@ u8 cmdq_get_shift_pa(struct mbox_chan *chan)
 }
 EXPORT_SYMBOL(cmdq_get_shift_pa);
 
+void cmdq_set_event(void *chan, u16 event_id)
+{
+	struct cmdq *cmdq = container_of(((struct mbox_chan *)chan)->mbox,
+		typeof(*cmdq), mbox);
+	unsigned long flags;
+
+	spin_lock_irqsave(&cmdq->event_lock, flags);
+
+	writel(CMDQ_TOKEN_UPDATE_VALUE | event_id, cmdq->base + CMDQ_SYNC_TOKEN_UPDATE);
+
+	spin_unlock_irqrestore(&cmdq->event_lock, flags);
+}
+EXPORT_SYMBOL(cmdq_set_event);
+
+u32 cmdq_get_event(void *chan, u16 event_id)
+{
+	struct cmdq *cmdq = container_of(((struct mbox_chan *)chan)->mbox,
+		typeof(*cmdq), mbox);
+	unsigned long flags;
+	u32 value = 0;
+
+	spin_lock_irqsave(&cmdq->event_lock, flags);
+
+	writel(CMDQ_TOKEN_ID_MASK & event_id, cmdq->base + CMDQ_SYNC_TOKEN_ID);
+	value = readl(cmdq->base + CMDQ_SYNC_TOKEN_VALUE);
+
+	spin_unlock_irqrestore(&cmdq->event_lock, flags);
+
+	return value;
+}
+EXPORT_SYMBOL(cmdq_get_event);
+
 static int cmdq_thread_suspend(struct cmdq *cmdq, struct cmdq_thread *thread)
 {
 	u32 status;
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index a8f0070c7aa9..f05cabd230da 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -79,5 +79,7 @@ struct cmdq_pkt {
 };
 
 u8 cmdq_get_shift_pa(struct mbox_chan *chan);
+void cmdq_set_event(void *chan, u16 event_id);
+u32 cmdq_get_event(void *chan, u16 event_id);
 
 #endif /* __MTK_CMDQ_MAILBOX_H__ */
-- 
2.18.0


