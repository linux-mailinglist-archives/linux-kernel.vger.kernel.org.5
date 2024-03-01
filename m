Return-Path: <linux-kernel+bounces-88576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B6586E3A3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892551F24026
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A981F6F505;
	Fri,  1 Mar 2024 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="soIjvjJ6"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC873A8D8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304254; cv=none; b=DmnOw+NWtT/mCqV3ndS2oP+GNDYq1GkDynVpN85qj65UkyrytdylwPgWfPALt6HdeqnHwVIq43PpNLVs3Cr7D1Ms8QxwHUomNu2OZQFkkBiRIc7VysxOkhaia/vhPk6XFOEfhIGJNHiCqQLAQPwh7sVBXL+GlJ0DSME9UHEHN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304254; c=relaxed/simple;
	bh=u/qdQKxxHWxdR7mQ6yXNAv14RbtVmZcngF2KU/ZM66Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXzwfkt/Yfj6UMdRXGbBI625nG4aqWAwd7jBIWuV35JgBCMzXeMmvldpDs0WW6bFzMV5ZI1HKoHdYE6oVr6fpYdnxpFNbSePzYFhyWroeMIZUEX3SCdXynAk1lIlOm9Fy1jH8Om1/mEi3oNGPsiPyRl4erJTczCsLLmGGF6JuiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=soIjvjJ6; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 27947ccad7da11ee935d6952f98a51a9-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iVlDUuKVmuA7JnvVmCn0d4WsSJI5tUjOae/sjyXi08c=;
	b=soIjvjJ66bjrsLIo9EriHpWPsAoonwwvPafWH09/xpPWB0Dy6r6sXmG7vTGsbVtZgogrQtBVwqT7gNZGmBrMkjrj4e96TyWJTCkIWkKUd6B811NrSgWEsd5S7IyVqv5+vm/fQ9zjN2BP14uKKqMiXCswf83NVfshhkgBsGnTaRY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:015bffb2-fdce-449a-ba64-d7da00ee4c05,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:352c66ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 27947ccad7da11ee935d6952f98a51a9-20240301
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 194215741; Fri, 01 Mar 2024 22:44:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 22:44:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 22:44:04 +0800
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
Subject: [RESEND, PATCH 1/5] soc: mediatek: mtk-cmdq: Add specific purpose register definitions for GCE
Date: Fri, 1 Mar 2024 22:43:59 +0800
Message-ID: <20240301144403.2977-2-jason-jh.lin@mediatek.com>
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

Add specific purpose register definitions for GCE, so CMDQ users can
use them as a buffer to store data.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
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


