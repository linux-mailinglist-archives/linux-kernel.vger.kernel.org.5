Return-Path: <linux-kernel+bounces-136320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B07AB89D2A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1C9B23B8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354E7E0FF;
	Tue,  9 Apr 2024 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BoojvV8+"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100877620;
	Tue,  9 Apr 2024 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712645091; cv=none; b=ThhGiDPVoVxlE6if6hloI4FBEukxLitcK+Yd7KQWtZiOcOzjrPPigbspBk5YucOMzYuvVN37/pp7aKrOdTG4LsNpxaosp6iZbiqXULcCrwijJYbE33EdJ23IAFYxOLHKdGOqtBghvE93h+GuKdFUqPPN8nMnjnv9ah5f3kPR2fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712645091; c=relaxed/simple;
	bh=/EfGLAuXNn7CJOSxT1lml+odygEvkvbadyeR0pxnBBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCZnY+By7vm7eeNW+mzN/FcFde6loGXF/BQ9/POZFZhhX8o2byLETUerL/hRls6K123O12rtSSFuT1HukEqHD4p90Fn3vV6w9p/ytdyGFVrs5Uh4kHtemM0bW70/uKwYASTuGo13mGZdAEY2Y7WNfMcN3FkpFMb1Usff/qscZ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BoojvV8+; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a403833ef63c11ee935d6952f98a51a9-20240409
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=j+KhJ6EB+cj5pLe9kHuoAtVj6VnwdkbMa6xi4h0zCuA=;
	b=BoojvV8+DUW9VoMCbk89fTA67VTYCNcm52XxbOx0TriTEkzE1Pl9AIB4XfJ88e2sk/4hhpljuoT5BQUw9aBW9PWJySzBFLiIjFosYAqclsivxfneTTml4pUvpB1/6Tcuok7mwIGE1CQxQxD7I8izmQSlXaqPP2/wvT1qVsF6XhU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:83e5c2b7-8a56-4704-92c8-4d49f117abf3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:aa9b5b91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a403833ef63c11ee935d6952f98a51a9-20240409
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2018417611; Tue, 09 Apr 2024 14:44:40 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 Apr 2024 14:44:36 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 Apr 2024 14:44:35 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
CC: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, "Yunfei
 Dong" <yunfei.dong@mediatek.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,4/5] media: mediatek: vcodec: add MT21 format definition
Date: Tue, 9 Apr 2024 14:44:30 +0800
Message-ID: <20240409064431.16909-5-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240409064431.16909-1-yunfei.dong@mediatek.com>
References: <20240409064431.16909-1-yunfei.dong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.600600-8.000000
X-TMASE-MatchedRID: 3/Lgny1vFHgmcIFfEYO7XAPZZctd3P4BWDdWpJMntKjANHjiWWI+7TMS
	YlM6Tw/V4vM1YF6AJbbCCfuIMF6xLSdET58jp62SNp7AbDE1MbDAd5zs4vPBYwrnM+1Obl9yatZ
	PNGSV67f7iywLUKDZp2vSF656JZcx4Zwt/wu7ol2frG2VghuuRVSMwMhT0DhthJVRlkc0uv5GBX
	oeyrLHXVBo425nomviD2TeXwRpghwOIqZ2uUSDWA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.600600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 1B045FBF83946BA5E3B4A30D4C91362BFE0DFD92C4D4CD15C374A30A36CF54C02000:8
X-MTK: N

Adding the definition of MT21 format to calculate bytesperline
and sizeimage of plane[0] and plane[1].

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 drivers/media/v4l2-core/v4l2-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 0d5de132e07f..6dba989c2291 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -271,6 +271,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		  .block_w = { 64, 64, 0, 0 }, .block_h = { 64, 64, 0, 0 }},
 		{ .format = V4L2_PIX_FMT_MM21, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 1, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 1, .vdiv = 2,
 		  .block_w = { 64, 64, 0, 0 }, .block_h = { 64, 64, 0, 0 }},
+		{ .format = V4L2_PIX_FMT_MT21C, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 1, 1, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 1, .vdiv = 2,
+		  .block_w = { 64, 64, 0, 0 }, .block_h = { 64, 64, 0, 0 }},
 
 		/* YUV planar formats */
 		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 2, .vdiv = 2 },
-- 
2.18.0


