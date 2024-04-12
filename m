Return-Path: <linux-kernel+bounces-141847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880678A2436
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150051F23756
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF717C95;
	Fri, 12 Apr 2024 03:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QSYjclwt"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850F11798C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891544; cv=none; b=K3k9ziXi/miGlHjzbSmTtWtP6PHUiNQx1meDN5oE1hwaOxUZhKDPOMEXOmJDXI2lSR4zsE+a3FdIX+zptu8JbRyKfkbDD89lW8aqTqTxPwmIydm/iT9EcCOOQZjOMUWPeytJKT0qDO7yCWF3JVzGJPxg47GN561f92Ql7bKEEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891544; c=relaxed/simple;
	bh=uiSlNDRCf0qfFN8aIdPnTrSZzk0wTj8oxBrDGhgYJuU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OfVDwq4cBKuMdy7IDuTaHTRTwKKPglBoOXjAhj1JqfiXvrZ6Oc7IzkUbYfYoZJS+8XUq+bgS7xysLxKhgjqWwyvKRl4KH7/9mzqLKONkg2zdHYX9h2ohm1L5PNQFP9zlfc/vQgCl191/X4audVew61b6XKKCNPNvn8nKEVdSJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QSYjclwt; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 75fba116f87a11ee935d6952f98a51a9-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=e/7WS9CaOwn/eKLmv5GyWR9tHofOvhiIhxgl1+N1pl0=;
	b=QSYjclwtEiNIkVxVBDIOMSg1pufRRxgd1Mtm3TbvD6JDNpLIHOR5Ny7jHCXHH9LqyX2qleIKF7L1+9gvll5rok9bK2LWBYQFSpFG36qytY6yWsnQwA+wMUXWUv6Caq59vK5f6QkU6gXwZs+nlOtKWVWm0zou2KPuc50E6/lOuoI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:b11edb3f-011f-4d19-9b37-bd3a6c96ee67,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:2d237c91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 75fba116f87a11ee935d6952f98a51a9-20240412
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <shuijing.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1316343109; Fri, 12 Apr 2024 11:12:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 11:12:10 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 11:12:10 +0800
From: Shuijing Li <shuijing.li@mediatek.com>
To: <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jitao.shi@mediatek.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Shuijing Li
	<shuijing.li@mediatek.com>
Subject: [PATCH v2] mediatek: dsi: Correct calculation formula of PHY Timing
Date: Fri, 12 Apr 2024 11:11:39 +0800
Message-ID: <20240412031208.30688-1-shuijing.li@mediatek.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-0.633600-8.000000
X-TMASE-MatchedRID: /Sl7yZT/bBI926lAoePLB3V7tdtvoiba+usHeIAEdV/7eDzreGwykXGp
	r8/fPJWibmtAlFao2lnnaqDS132s4nAvdl/gU+kWe8FaKRfM2oMAa2OncjP1G9iCsYPC4Ul2+Vi
	hXqn9xLEG8FDLLrNywcMR+p3i+7r+SSOWVJeuO1AURSScn+QSXt0H8LFZNFG7MGpgBNI6BaPNJt
	heTOpPzdOSf5nvskmEEcLnS87bz6f5kjJDG0OmloJIjfAzZ/NPWPN3/J2RV2mHSGi7LAgkKJt+N
	NnvujuxaS00v5SMoE6ElVGWRzS6/kYFeh7KssddUGjjbmeia+IPZN5fBGmCHDkCyv2R+K5WftwZ
	3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-0.633600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	AB5D098F171CEC07E897EF910FAFBB6BE93F6B478FC6CB898481F0DBEC61CB022000:8
X-MTK: N

This patch correct calculation formula of PHY timing.
The spec define HS-PREPARE should be from 40ns+4*UI(44ns) to
85ns+6*UI(91ns). But current duration is 88ns and is near the boundary.
So this patch make the duration to 64ns so it is near the safe range.

Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
---
Changes in v2:
Add a commit to describe the improvements to this patch in detail,
per suggestion frome previous thread:
https://patchwork.kernel.org/project/linux-mediatek/patch/20240315072945.19502-1-shuijing.li@mediatek.com/
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 33 +++++++++++++++---------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index a2fdfc8ddb15..d1bd7d671880 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -235,22 +235,23 @@ static void mtk_dsi_phy_timconfig(struct mtk_dsi *dsi)
 	u32 data_rate_mhz = DIV_ROUND_UP(dsi->data_rate, 1000000);
 	struct mtk_phy_timing *timing = &dsi->phy_timing;
 
-	timing->lpx = (60 * data_rate_mhz / (8 * 1000)) + 1;
-	timing->da_hs_prepare = (80 * data_rate_mhz + 4 * 1000) / 8000;
-	timing->da_hs_zero = (170 * data_rate_mhz + 10 * 1000) / 8000 + 1 -
-			     timing->da_hs_prepare;
-	timing->da_hs_trail = timing->da_hs_prepare + 1;
-
-	timing->ta_go = 4 * timing->lpx - 2;
-	timing->ta_sure = timing->lpx + 2;
-	timing->ta_get = 4 * timing->lpx;
-	timing->da_hs_exit = 2 * timing->lpx + 1;
-
-	timing->clk_hs_prepare = 70 * data_rate_mhz / (8 * 1000);
-	timing->clk_hs_post = timing->clk_hs_prepare + 8;
-	timing->clk_hs_trail = timing->clk_hs_prepare;
-	timing->clk_hs_zero = timing->clk_hs_trail * 4;
-	timing->clk_hs_exit = 2 * timing->clk_hs_trail;
+	timing->lpx = (80 * data_rate_mhz / (8 * 1000)) + 1;
+	timing->da_hs_prepare = (59 * data_rate_mhz + 4 * 1000) / 8000 + 1;
+	timing->da_hs_zero = (163 * data_rate_mhz + 11 * 1000) / 8000 + 1 -
+		timing->da_hs_prepare;
+	timing->da_hs_trail = (78 * data_rate_mhz + 7 * 1000) / 8000 + 1;
+
+	timing->ta_go = 4 * timing->lpx;
+	timing->ta_sure = 3 * timing->lpx / 2;
+	timing->ta_get = 5 * timing->lpx;
+	timing->da_hs_exit = (118 * data_rate_mhz / (8 * 1000)) + 1;
+
+	timing->clk_hs_prepare = (57 * data_rate_mhz / (8 * 1000)) + 1;
+	timing->clk_hs_post = (65 * data_rate_mhz + 53 * 1000) / 8000 + 1;
+	timing->clk_hs_trail = (78 * data_rate_mhz + 7 * 1000) / 8000 + 1;
+	timing->clk_hs_zero = (330 * data_rate_mhz / (8 * 1000)) + 1 -
+		timing->clk_hs_prepare;
+	timing->clk_hs_exit = (118 * data_rate_mhz / (8 * 1000)) + 1;
 
 	timcon0 = timing->lpx | timing->da_hs_prepare << 8 |
 		  timing->da_hs_zero << 16 | timing->da_hs_trail << 24;
-- 
2.43.0


