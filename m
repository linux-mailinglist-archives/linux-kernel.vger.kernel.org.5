Return-Path: <linux-kernel+bounces-104118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9148F87C92E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE19B2391B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B78DF9DE;
	Fri, 15 Mar 2024 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bldC4cM9"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149071426E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487758; cv=none; b=rLPk+EU3HenUcAtDDyFIWcBUKDdYFYnXWyzLhiPBL7CoWTn77WQZMJycaprqBCx8WbvBR0egfF0I3hxOoeM4qzTK94F97jNpUF7YNHbguY0xB4OzfAkubJTWcEvzFK73IZZFu6gYLhXzOGdWsDWYZuFEBKyyUqenjrtkLgjeefc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487758; c=relaxed/simple;
	bh=iigvwIzocTdodmsZFYOAJEizvEhANV9bcbRZVi17hK4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F+N6QTggzpVt7gLOT0ozM06pP14b4G5XH+G0aZGSJCJQpadQtmHOpx6pH3q25mFOQVvKkOEukpmw98MKbk8hd5TSTTa2xIb5M5qOQugjp2Cs9lgxFpr80W+fl1RpK5dCVUmZfDvhOlx3F48OK6rPhFdB6j+KIbjaAYDtEiT4s30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bldC4cM9; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ad414a9ce29d11ee935d6952f98a51a9-20240315
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yRWP9snI8RAx/YHERzDgmRG2nMqfLoPSeiF3f8FNgLU=;
	b=bldC4cM9793BaKcuaQ0gkl4VpnCoZlK0X4MKNorbxVZSnYciSY1gLj36okttM+p8tCVru4t9xaLBIlpN2wutowW8HYiwAV33cAMaecRtcazC4w2KDU1X4dUaF4wgFmuxobfErVVQgTdNnB8i6gMIbrjDvFWNcbgVHPMzPY4vrwA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:cb2ebeb4-4c6e-44e9-b35e-548607db4fa8,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-35
X-CID-META: VersionHash:6f543d0,CLOUDID:81357090-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: ad414a9ce29d11ee935d6952f98a51a9-20240315
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <shuijing.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1316206159; Fri, 15 Mar 2024 15:28:53 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Mar 2024 15:28:52 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Mar 2024 15:28:51 +0800
From: Shuijing Li <shuijing.li@mediatek.com>
To: <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jitao.shi@mediatek.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Shuijing Li
	<shuijing.li@mediatek.com>
Subject: [PATCH] mediatek: dsi: Correct calculation formula of PHY Timing
Date: Fri, 15 Mar 2024 15:29:17 +0800
Message-ID: <20240315072945.19502-1-shuijing.li@mediatek.com>
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
X-TM-AS-Result: No-10--2.215100-8.000000
X-TMASE-MatchedRID: YZSAQvmCNEE926lAoePLB6Yb59qT2vdqEbxKVXd70tXfUZT83lbkEEFN
	G6vV64Np89MfnAiuroaG184Y5LIraR8TzIzimOwPC24oEZ6SpSmcfuxsiY4QFErqa51gGLvDwDD
	qsyMeG4EW6WhcUTCY/falSjsNC8GOBNZu/eAwGF85FgWkTMqhfn6+pNxelVQZ8K6z02AXwE6f9V
	II1fK9/PI2nuDg9d7QFezHPq6MHFSrV/xdKQcFSY0leYQxW8u2lExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.215100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5A67AD3405B3FBFC63F4F8117293508A52A6B56E3483D38D0BF2920C847618F52000:8
X-MTK: N

This patch correct calculation formula of PHY timing.
Make actual phy timing more accurate.

Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
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


