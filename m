Return-Path: <linux-kernel+bounces-94830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285AF8745AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DF3286C37
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49568DDC3;
	Thu,  7 Mar 2024 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DMfWKxIa"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C74C6C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709775309; cv=none; b=upPW0CqppzFFpgLkndvHx0dUekawscHlkWycZGv9QyXhWEm0k0Z3X6niTjEx19Qo7ILjvY6Fv8+n0zbjBgNldQlF7ljmzms4TVJ9qylSzaLW2U158u+Dy1tQm824RzcGY5E19FmmlqAnk0v1/varSsG481yKTI6W7ay2gnmpEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709775309; c=relaxed/simple;
	bh=vwpbGeKVmx7o93hG9wKHHoB80BAftnbdqxZ/KiEkeBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqAOj3nf1psXz0HBIvRxbJgxta58O97PZ935cjWhKSu/yBibG7liM8ZM7+XhSadAh7T6w+CSf7sdPMcCz9kZvXxI08lquYtoPiBopTjYmgDRic7M3nAz02V1paDBHBq1fsIXxxurtwio+lINcihOMmj4GOWvniAPQk3BdTeare8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DMfWKxIa; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eb27e4a0dc2211eeb8927bc1f75efef4-20240307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RYqqPtBkvbJiWQfMZfCGLp/muLNA09FqpLZb1hc35bA=;
	b=DMfWKxIarVDWAxlENUELc0nIYLFXRtyOtzjWz23Ybo6aYfkmg8QHtqDTJ5UbTAtID2h4oeVp762s2S55mY6vOPPsqfqeQiny7du6yMQrp8C4unvL5mevm3MmpdqyCK46ozu6/Sq4O8IbALQYw9ShHT33zAI2FsQSMNDJ3S3huLs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:48fc9845-895e-4fa9-aa3a-2f37be3bd50e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:857bb484-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eb27e4a0dc2211eeb8927bc1f75efef4-20240307
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1345483820; Thu, 07 Mar 2024 09:35:02 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Mar 2024 09:35:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Mar 2024 09:35:00 +0800
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
Subject: [PATCH v2 4/4] soc: mediatek: mtk-cmdq: Add cmdq_pkt_acquire_event() function
Date: Thu, 7 Mar 2024 09:34:58 +0800
Message-ID: <20240307013458.23550-5-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240307013458.23550-1-jason-jh.lin@mediatek.com>
References: <20240307013458.23550-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.190000-8.000000
X-TMASE-MatchedRID: tjEGPsGKY1JYXTxImR5ZvLmIzqGFh/g8Xru95hSuhjQGW3hFnC9N1ayR
	DZpBnTnXX7ScFOAZsbSZymPU+pWEZyZ/E6AE4WkioS0guoV6SZcIYICTzfK2geOxOq7LQlGLEXF
	HklABLo7T01A2vEikVhDmbwdZ+OOfn/UkTj3EvcbhuXUWQoMQty6GDroi1vrlwDR44lliPu0bSl
	ebxhFF4jSbvF4uwAVxd6AheSID9qkfE8yM4pjsDwtuKBGekqUpnH7sbImOEBSxQ8vJIdbM4nTgE
	k8+6RMtbhjW7XFm5idqOdkqmO7+hgrJ3mkvzPSnPdI/7BAgjh+tEClvIxjOUeE71tGkbKASh5sU
	2Hf8T1pJmt82E/eyBQGH0CAFIQWsmb5gmylW+PbGS+seVPx64j6Qrn3xh/cy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.190000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A380A694E5424FE041146DD541B7A1E4D8A5BF088CCF76C4B401026939EB66892000:8
X-MTK: N

Add cmdq_pkt_acquire_event() function to support CMDQ user making
an instruction for acquiring event.

CMDQ users can use cmdq_pkt_acquire_event() as `mutex_lock`
and cmdq_pkt_clear_event() as `mutex_unlock` to protect the global
resource modified instructions between them.

cmdq_pkt_acquire_event() would wait for event to be cleared.
After event is cleared by cmdq_pkt_clear_event() in other GCE threads,
cmdq_pkt_acquire_event() would set event and keep executing next
instruction. So the mutex would work like this:

    cmdq_pkt_acquire_event() /* mutex lock */

    /* critical secton instructions that modified global resource */

    cmdq_pkt_clear_event() /* mutex unlock */

Prevent the critical section instructions from being affected by other
GCE threads.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 15 +++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 4f69df743505..8acd8e38283e 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -343,6 +343,21 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear)
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
index b0004d097e23..f708bcfebdd8 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -204,6 +204,21 @@ int cmdq_pkt_mem_move(struct cmdq_pkt *pkt, dma_addr_t src_addr, dma_addr_t dst_
  */
 int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear);
 
+/**
+ * cmdq_pkt_acquire_event() - append acquire event command to the CMDQ packet
+ * @pkt:	the CMDQ packet
+ * @event:	the desired event to be acquired
+ *
+ * User can use cmdq_pkt_acquire_event() as `mutex_lock` and cmdq_pkt_clear_event()
+ * as `mutex_unlock` to protect some `critical section` instructions between them.
+ * cmdq_pkt_acquire_event() would wait for event to be cleared.
+ * After event is cleared by cmdq_pkt_clear_event in other GCE threads,
+ * cmdq_pkt_acquire_event() would set event and keep executing next instruction.
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


