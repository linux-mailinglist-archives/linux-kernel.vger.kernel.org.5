Return-Path: <linux-kernel+bounces-10538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4FE81D5E2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8D31F23D92
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8C320B37;
	Sat, 23 Dec 2023 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CuafQlOz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8C21401B;
	Sat, 23 Dec 2023 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 39bf8ecaa1c111eeba30773df0976c77-20231224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=g3zby7Chx2qa09kTTNK9eMNsXxgeV452k3Eq07i7i1o=;
	b=CuafQlOz6O0ipbWgdhuKPrIajGhKqAUqlnJxPxZqqV84oADif9/qSaPbKgfKocECRSG4k2cx4KDFexiTJ1lAtaoEsaf93NXCer90t67QiIW8wlho8kdCaZw7Z+lfxEJJ1kAvRCzTsAIGb+ogiMEnQALLQ/V0N+JTG1iFkFtA5MY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:e6469c33-3b87-44e0-b2a1-dd89eb410367,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:6157987e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 39bf8ecaa1c111eeba30773df0976c77-20231224
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 860781984; Sun, 24 Dec 2023 02:29:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 24 Dec 2023 02:29:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 24 Dec 2023 02:29:35 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<dri-devel@lists.freedesktop.org>, <linux-media@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, Jason-ch Chen <jason-ch.chen@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jeffrey Kardatzke
	<jkardatzke@google.com>
Subject: [PATCH v3 10/11] drm/mediatek: Add cmdq_insert_backup_cookie before secure pkt finalize
Date: Sun, 24 Dec 2023 02:29:31 +0800
Message-ID: <20231223182932.27683-11-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
References: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Add cmdq_insert_backup_cookie to append some commands before EOC:
1. Get GCE HW thread execute count from the GCE HW register.
2. Add 1 to the execute count and then store into a shared memory.
3. Set a software event siganl as secure irq to GCE HW.

Since the value of execute count + 1 is stored in a shared memory,
CMDQ driver in the normal world can use it to handle task done in irq
handler and CMDQ driver in the secure world will use it to schedule
the task slot for each secure thread.

The reason why we use shared memory to record execute count here is:
1. normal world can not access the register of secure GCE thread in
normal world.
2. calling TEE invoke cmd in the irq handler would be expensive and not
stable. I've tested that a single TEE invloke cmd to CMDQ PTA costs
19~53 us. Maybe it would cost more during the scenario that needs more
CPU loading.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 79617c0f016d..856513a14cda 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -179,7 +179,7 @@ void mtk_crtc_disable_secure_state(struct drm_crtc *crtc)
 		sec_scn = CMDQ_SEC_SCNR_SUB_DISP_DISABLE;
 
 	cmdq_sec_pkt_set_data(&mtk_crtc->sec_cmdq_handle, sec_engine, sec_engine, sec_scn);
-
+	cmdq_sec_insert_backup_cookie(&mtk_crtc->sec_cmdq_handle);
 	cmdq_pkt_finalize(&mtk_crtc->sec_cmdq_handle);
 	dma_sync_single_for_device(mtk_crtc->sec_cmdq_client.chan->mbox->dev,
 				   mtk_crtc->sec_cmdq_handle.pa_base,
@@ -791,6 +791,8 @@ static void mtk_drm_crtc_update_config(struct mtk_drm_crtc *mtk_crtc,
 		cmdq_pkt_clear_event(cmdq_handle, mtk_crtc->cmdq_event);
 		cmdq_pkt_wfe(cmdq_handle, mtk_crtc->cmdq_event, false);
 		mtk_crtc_ddp_config(crtc, cmdq_handle);
+		if (cmdq_handle->sec_data)
+			cmdq_sec_insert_backup_cookie(cmdq_handle);
 		cmdq_pkt_finalize(cmdq_handle);
 		dma_sync_single_for_device(cmdq_client.chan->mbox->dev,
 					   cmdq_handle->pa_base,
-- 
2.18.0


