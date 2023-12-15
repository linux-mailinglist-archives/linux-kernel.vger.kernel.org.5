Return-Path: <linux-kernel+bounces-643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F2D8143FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB11B22728
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A571944D;
	Fri, 15 Dec 2023 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SUml5VQj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1627718AFB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 14aada4a9b2711eeba30773df0976c77-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=v9t/F+JMbwDsMpqLtuEY4uCI2C3pHq7TrRCe+nmUuRU=;
	b=SUml5VQjVLcFhg/gUBUlMaWawwgAPNBQGaea+EthLCsKtF2tdqb7JkTPVWX1sxseiVc38FUEi/KXpLc/2U1l+JTkJm/H7vZakvxE5WOQeN1a7HWd0IIJrB15GhgxzWz7eHHLCu/oQRgawBMDD2UypgtGiGK1ZYrm3gc9QcsLHmk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:46c75acb-6c41-4f01-a947-42767b5ca89f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:856bb5fd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 14aada4a9b2711eeba30773df0976c77-20231215
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 542733226; Fri, 15 Dec 2023 16:51:04 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 16:51:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 16:51:03 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jeffrey Kardatzke
	<jkardatzke@google.com>, Jason-ch Chen <jason-ch.chen@mediatek.com>, Johnson
 Wang <johnson.wang@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>
Subject: [PATCH v2 1/3] mailbox: mtk-cmdq: Rename gce_plat variable with SoC name postfix
Date: Fri, 15 Dec 2023 15:00:24 +0800
Message-ID: <20231215070026.2507-2-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231215070026.2507-1-jason-jh.lin@mediatek.com>
References: <20231215070026.2507-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Rename gce_plat variable postfix from 'v1~v7' to SoC names.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index de862e9137d5..16c504f8d9d5 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -706,42 +706,42 @@ static const struct dev_pm_ops cmdq_pm_ops = {
 			   cmdq_runtime_resume, NULL)
 };
 
-static const struct gce_plat gce_plat_v2 = {
+static const struct gce_plat gce_plat_mt8173 = {
 	.thread_nr = 16,
 	.shift = 0,
 	.control_by_sw = false,
 	.gce_num = 1
 };
 
-static const struct gce_plat gce_plat_v3 = {
+static const struct gce_plat gce_plat_mt8183 = {
 	.thread_nr = 24,
 	.shift = 0,
 	.control_by_sw = false,
 	.gce_num = 1
 };
 
-static const struct gce_plat gce_plat_v4 = {
+static const struct gce_plat gce_plat_mt6779 = {
 	.thread_nr = 24,
 	.shift = 3,
 	.control_by_sw = false,
 	.gce_num = 1
 };
 
-static const struct gce_plat gce_plat_v5 = {
+static const struct gce_plat gce_plat_mt8192 = {
 	.thread_nr = 24,
 	.shift = 3,
 	.control_by_sw = true,
 	.gce_num = 1
 };
 
-static const struct gce_plat gce_plat_v6 = {
+static const struct gce_plat gce_plat_mt8195 = {
 	.thread_nr = 24,
 	.shift = 3,
 	.control_by_sw = true,
 	.gce_num = 2
 };
 
-static const struct gce_plat gce_plat_v7 = {
+static const struct gce_plat gce_plat_mt8186 = {
 	.thread_nr = 24,
 	.shift = 3,
 	.control_by_sw = true,
@@ -750,12 +750,12 @@ static const struct gce_plat gce_plat_v7 = {
 };
 
 static const struct of_device_id cmdq_of_ids[] = {
-	{.compatible = "mediatek,mt8173-gce", .data = (void *)&gce_plat_v2},
-	{.compatible = "mediatek,mt8183-gce", .data = (void *)&gce_plat_v3},
-	{.compatible = "mediatek,mt8186-gce", .data = (void *)&gce_plat_v7},
-	{.compatible = "mediatek,mt6779-gce", .data = (void *)&gce_plat_v4},
-	{.compatible = "mediatek,mt8192-gce", .data = (void *)&gce_plat_v5},
-	{.compatible = "mediatek,mt8195-gce", .data = (void *)&gce_plat_v6},
+	{.compatible = "mediatek,mt8173-gce", .data = (void *)&gce_plat_mt8173},
+	{.compatible = "mediatek,mt8183-gce", .data = (void *)&gce_plat_mt8183},
+	{.compatible = "mediatek,mt8186-gce", .data = (void *)&gce_plat_mt8186},
+	{.compatible = "mediatek,mt6779-gce", .data = (void *)&gce_plat_mt6779},
+	{.compatible = "mediatek,mt8192-gce", .data = (void *)&gce_plat_mt8192},
+	{.compatible = "mediatek,mt8195-gce", .data = (void *)&gce_plat_mt8195},
 	{}
 };
 
-- 
2.18.0


