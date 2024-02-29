Return-Path: <linux-kernel+bounces-86868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0986F86CBF8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06AD1F21CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A738513A24A;
	Thu, 29 Feb 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t9X5t50N"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816A13774E;
	Thu, 29 Feb 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218137; cv=none; b=H2lVD4M3dtMeH/fsc17T8qLbvWjYCou3dnI8m6HuBTANRjkxZxH9r/Eb5uL5/oLmjk63+Eq05YDrEFuklnsVLOTZFxMg31pKZ7Ukp73QHMGjKHRkCd8xJdFbzJ2APwavfi1Scatej4+wvtHJPLcrk46T6W7cL93k9W6nI/Tosm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218137; c=relaxed/simple;
	bh=8qxm2EUd1GBdaNHFwmqaPZlDwV9oEoF87vIIJhfsHvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTiAHLSdoUbDz7RnF2s18e72IfQxUThdfmjtMElKHYpkaA/hvhDF9I3zm3qyimh6ZlM4veF9kYAVfhexi2vIIje+UC78VAbbnDfwe5Q2bhFdFBo1kKINUbolR1yt5yPrN5BWQ1RG/AXw15V6KEUc4JR9KBH4d/MY+AJcP4PZtx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=t9X5t50N; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a5a7ecbad71111ee935d6952f98a51a9-20240229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xDG8l2SWrThETTz0X8GaI7q6C/OjXyr+z9ITCFXfGU8=;
	b=t9X5t50NSLtuxE4JHRmOkY/JVkkTRaIs261nzQTHyRAHL+rzUNSPb2gmVJUb7V3BTtpUOk16YSdwBRXnaOoCXxM0+K3Fvi7sL7inYY0gUHiQ4Jf33QmK9/WdZOjv9wJAqFdHBxC9lMM4eX/cUYYZ8RGJtPSByLlqlKltBiSBE+c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:1c624b77-03af-409c-a419-a959695f69ca,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:c617f580-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a5a7ecbad71111ee935d6952f98a51a9-20240229
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1419325452; Thu, 29 Feb 2024 22:48:48 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Feb 2024 22:48:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 29 Feb 2024 22:48:46 +0800
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
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Fei Shao
	<fshao@chromium.org>
Subject: [PATCH v2 3/3] drm/mediatek: Add gamma support for MT8195
Date: Thu, 29 Feb 2024 22:48:44 +0800
Message-ID: <20240229144844.1688-4-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240229144844.1688-1-jason-jh.lin@mediatek.com>
References: <20240229144844.1688-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.629100-8.000000
X-TMASE-MatchedRID: 9EQCYzKTMIqGeTbGWdRz1q+dYEguu4aV6SXuwUgGH0iph3WXFw7gPvKC
	81FnsF5IThbvLLI8RvPxY0WGgfScA49oUcx9VMLgFEUknJ/kEl7dB/CxWTRRu92KvEVWmYr1BOK
	CpVgJA9x4D937VKhYB4w3t2bVuZQpkVlgDMhSSLYI5Nn50T/hXg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.629100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5EC83FE603B7E51A97315C15E93E9AAB287B3C02EFBFBA32B9D31BD516A6F8A72000:8
X-MTK: N

Since MT8195 compatible is in the single enum group, we have to add its
compatible into mediatek-drm component binding table to ensure that
it can be bound as a ddp_comp.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogiaocchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 14a1e0157cc4..93303bff8f34 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -707,6 +707,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_GAMMA, },
 	{ .compatible = "mediatek,mt8183-disp-gamma",
 	  .data = (void *)MTK_DISP_GAMMA, },
+	{ .compatible = "mediatek,mt8195-disp-gamma",
+	  .data = (void *)MTK_DISP_GAMMA, },
 	{ .compatible = "mediatek,mt8195-disp-merge",
 	  .data = (void *)MTK_DISP_MERGE },
 	{ .compatible = "mediatek,mt2701-disp-mutex",
-- 
2.18.0


