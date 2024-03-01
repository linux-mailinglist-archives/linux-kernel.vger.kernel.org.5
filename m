Return-Path: <linux-kernel+bounces-88311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B00686DFEB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE631C21511
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511B26D1B9;
	Fri,  1 Mar 2024 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QuCxVogU"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972046BFDB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291509; cv=none; b=ce0hM2nyUh49CquwtOwimzrxX7bcTYcQQPpMfFxDtoZnhOM1ZXy5qYntNzJc0Ii7xN90Te5HewR5Nkg2oY5tyJ6i5ygLDuyhANjlNYRhBhjSR85BOZQkxQii7AZ8B9rCMKfmHCu6c4EdIvRjkKrNf1PnndnYzrJ4BaIqHsStsYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291509; c=relaxed/simple;
	bh=jDiaDzBreluUVogGgdAngiWbgpQLcW2bwCIudBrvL2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhMGBNFeslZ0phSOtUw/2Cv6Wftei2vfkSizdoVuzPuDZHIRHxFCkmWTJHyZMxscaltcIcWKEj4zU935yYSN6hHzHIkni5fOTKdqlPXqYPqmyn9/sgowQb1GVXC43ojwwUJIkdSdwmM8x9WGHbFtC6i9Ta0MpHbGTuordR7AyLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QuCxVogU; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7b209e14d7bc11ee935d6952f98a51a9-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UVxmeYbrzMU+8yaEOX4EPOp0wcGdCd6eVhh5zyZPpKs=;
	b=QuCxVogU8g0tm5AMeDYPOh7HuiaLMvaQS1/Ihs+QgYPRyjX+d6/Rtc7xwOlWQTTdlABNIO8mTc73fni+tYinjiqYdBGjmBRFH1N3sbJzrg+nW8E3Fhf8v5QDwvX6mXGuUq9Ym7LzizzuHBDxLQNnA4nddg8GI0t/FafUlnStJPc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:918560de-a194-4ab3-b0ea-adf292dde08b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:450ce78f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7b209e14d7bc11ee935d6952f98a51a9-20240301
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1779151631; Fri, 01 Mar 2024 19:11:41 +0800
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
Subject: [PATCH 4/5] soc: mediatek: mtk-cmdq: Add cmdq_pkt_acquire_event() function
Date: Fri, 1 Mar 2024 19:11:25 +0800
Message-ID: <20240301111126.22035-5-jason-jh.lin@mediatek.com>
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
X-TM-AS-Result: No-10--2.904900-8.000000
X-TMASE-MatchedRID: llTo18AJfvFYXTxImR5ZvLmIzqGFh/g8Xru95hSuhjQGW3hFnC9N1ayR
	DZpBnTnXX7ScFOAZsbSZymPU+pWEZ6Q4hw3fFG5zXSKcwPTzq/IhotH7bEpEMkYvSDWdWaRhcHj
	giTON9jLAsw00iUcvQv0h3e0v6EXCUBXVAm5W8RAbmaDSnOqZfsSgMQYKGHsJM6179UxzfjlCFt
	xLdA8EDuLzNWBegCW2wgn7iDBesS0nRE+fI6etkqQVJm8UX/I+1PbVTvjrX7SVbf5EccAu3cf5t
	cGdPaGDfONGJh0XykOuFgtX4tvltd/n8sBhKmAMw26jNhXEhXHyyMgM8a+L0YCE5xpCtDRTUbJF
	yh4XXyqYo/TPOlMB4bCh3zE4wqa8DUCRr8oin+k=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.904900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5A2AF9094C510743033CB018B974CC720722A3FB2D7EA8B6E88EA28690F1A4362000:8
X-MTK: N

Add cmdq_pkt_acquire_event() function to support CMDQ user making
an instruction for acquiring event.

CMDQ users can use cmdq_pkt_acquire_event() and cmdq_pkt_clear_event()
to acquire GCE event and release GCE event and achieve the MUTEX_LOCK
protection between GCE threads.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Change-Id: Icdae6b60345c7ec1d7541ac76d1f06da56959cde
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


