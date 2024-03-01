Return-Path: <linux-kernel+bounces-88312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1941D86DFEC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7981C20F88
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6209D6D1B5;
	Fri,  1 Mar 2024 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hYPOTii8"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AAE6BFD4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291509; cv=none; b=hyZrwYKJPrla9NVEF6mv/lVhExEykSdz3e5rNCG3u5Wr0WJpW2kT1ClyQHuoAHaw7iLR84bQxLaIUEoeeJ5BHcY7ON4Yu/rrSs5tMs/27ndLkOiWoYQjRJgs6SLaHisvUqt2wnW/0os5Mipv7bDkl0Pi0De8hs5hZnlSjGTvhbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291509; c=relaxed/simple;
	bh=+ZzBybof3O1nfT2izJvtONi7FpjdVC7vAnBvgujkjoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fggNrkBWxrWvkYQMIfoFxa8VoACXnx4PtGwbIlGVkgwsCG8vSXLvti29rE+6l292zW0yakPFdHQy4Fc4PJ3hvpTeRG8VDGkGZMQxJt3+yio7dauSSx/e2+HeJjQKy5YMNsXCeRqOSe3cqAF6TZFYiFYRR88vX4J96sJT02VHwyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hYPOTii8; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7a9aec38d7bc11eeb8927bc1f75efef4-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+NCPfiqHkGekZ2gLLAx7CBphrzwi9/58aQ7Jf2wXq3o=;
	b=hYPOTii8jrjdvnUKC+u4n3BPeNXIc7BKOwLM3+9rvmLqlCtc4vH+dw67Le1Vwg3UXKIrF3psRMtJLPjUZxuP/206YkE6wBcHhiMfwxItue7x/Y90QwELJNwMRgt0Kl7b3BuJzfBphf/NVaCYgecZ1+bVIsdCMl1zMLX7jXMYAP8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:262fd07a-856c-41f7-91a6-15c5b91c726c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:f4348084-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7a9aec38d7bc11eeb8927bc1f75efef4-20240301
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1564556827; Fri, 01 Mar 2024 19:11:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
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
Subject: [PATCH 1/5] soc: mediatek: mtk-cmdq: Add specific purpose register definitions for GCE
Date: Fri, 1 Mar 2024 19:11:22 +0800
Message-ID: <20240301111126.22035-2-jason-jh.lin@mediatek.com>
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

Add specific purpose register definitions for GCE, so CMDQ users can
use them as a buffer to store data.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Change-Id: Ie72dd86d6ccfb60761461ad128b02d32adaacbc0
---
 include/linux/soc/mediatek/mtk-cmdq.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 649955d2cf5c..1dae80185f9f 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -14,6 +14,15 @@
 #define CMDQ_ADDR_HIGH(addr)	((u32)(((addr) >> 16) & GENMASK(31, 0)))
 #define CMDQ_ADDR_LOW(addr)	((u16)(addr) | BIT(1))
 
+/*
+ * Every cmdq thread has its own SPRs (Specific Purpose Registers),
+ * so there are 4 * N (threads) SPRs in GCE that shares the same indexes below.
+ */
+#define CMDQ_THR_SPR_IDX0	(0)
+#define CMDQ_THR_SPR_IDX1	(1)
+#define CMDQ_THR_SPR_IDX2	(2)
+#define CMDQ_THR_SPR_IDX3	(3)
+
 struct cmdq_pkt;
 
 struct cmdq_client_reg {
-- 
2.18.0


