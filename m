Return-Path: <linux-kernel+bounces-136319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F1889D2A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8710E1C21499
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346AE7E0F0;
	Tue,  9 Apr 2024 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Q+XYIX2f"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A3F763F1;
	Tue,  9 Apr 2024 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712645091; cv=none; b=YDkcm791oXQvR1/HX7izF1HAtFk6/3tq4NcmIzYIK/5hUcs4OwuXy/6s8FJeGF/0xprznMXBXIwsxtnfTjJHiLbx0F7ABVoJUXU/e6gZRO5BKtscoy796ZHGWGt7m4TNgdSbCU2hFa38Mr25+3AkvsxQ2J6Dx+T1ZPAk3l7MNcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712645091; c=relaxed/simple;
	bh=cM9aQNPKr9G1RIwmRD1GqXwT7YVQbHWvN+ToiMWkmbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihuljhBnWPQG+/c1eJogGrf+wg7b5OOXa2vYRgRVoTD6vQHb+Zfu8vbgqNkclUH+CMGvxXJDJ5AYmsjhbSef2zgxpGmXf6rUQ3Sc2iFXdomtfF0P/MXxzIa5vQUHR6EbtX8V84c26dkAkG1HQdXkHfUUvHHDb6J0s+3mrfHFAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Q+XYIX2f; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a1f191f8f63c11eeb8927bc1f75efef4-20240409
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0qktbKEYPGtydjVRM7cyZ/EYPJ31azkhEL8i3TDFy3s=;
	b=Q+XYIX2fMe4mEV/CGSEceDtX48INUC6oDvlE+P8kRX1zUhdbCGW7AsB8SP2zl9ZveHZAERQykOEhM48HKy5dZU13ailBbotjVqpP9NuiG8BRtR5a1zi9ikUDF3fhGDai5fuhN+kC84+R4rQakDClatXvCr0xTh+NnxCeJiVPv/4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f425eba1-25a0-4db0-80e0-4a2fcc5cb8ea,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:6f543d0,CLOUDID:999b5b91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a1f191f8f63c11eeb8927bc1f75efef4-20240409
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 998046553; Tue, 09 Apr 2024 14:44:37 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 Apr 2024 14:44:34 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 Apr 2024 14:44:33 +0800
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
Subject: [PATCH v2,2/5] media: mediatek: vcodec: fix incorrect MT2R format information
Date: Tue, 9 Apr 2024 14:44:28 +0800
Message-ID: <20240409064431.16909-3-yunfei.dong@mediatek.com>
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
X-TM-AS-Result: No-10-0.534700-8.000000
X-TMASE-MatchedRID: 6V/MDP75lNskAJTC0ghkVEOZWaJBszmqMZm0+sEE9mvjud2x7TPVt5kC
	erFMaabilTJXKqh1ne1uEZBMMoyNb/QkvsXHc/4WngIgpj8eDcBpkajQR5gb3qbj/c4OO+6RKra
	uXd3MZDWJDHD1rfJi5yF7K4DO6AFEByI5NST1E38DmPU85Y9e5vNFxnD1qTXUg+TrRUrIbbBdx2
	UK2QfpuasNTb2hMWvDdOpdgj9khs5Br/EfNXvU1fNho9kAt8htLJl1Svx/Hh8xu7K+8aG0gEjdE
	2R0SZiwQwymtxuJ6y0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-0.534700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A58515800F8D61D2C85AC02EF66A19E85DC0B71DA7AC0702082136D86EB4CDE42000:8
X-MTK: N

Changing the bpp and hdiv values to make sure the bytesperline
of plane[0] and plane[1] are the same. The width and height are
64 align.

Fixes: 1dff2beb60d3 ("media: mediatek: vcodec: Add capture format to support 10bit raster mode")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 drivers/media/v4l2-core/v4l2-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 8587cd14741c..cef1492dba22 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -267,8 +267,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_YUV48_12, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_MT2110T, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 5, 5, 0, 0 }, .bpp_div = { 4, 4, 1, 1 }, .hdiv = 1, .vdiv = 2,
 		  .block_w = { 64, 64, 0, 0 }, .block_h = { 64, 64, 0, 0 }},
-		{ .format = V4L2_PIX_FMT_MT2110R, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 5, 10, 0, 0 }, .bpp_div = { 4, 4, 1, 1 }, .hdiv = 2, .vdiv = 2,
-		  .block_w = { 16, 8, 0, 0 }, .block_h = { 32, 16, 0, 0 }},
+		{ .format = V4L2_PIX_FMT_MT2110R, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 5, 5, 0, 0 }, .bpp_div = { 4, 4, 1, 1 }, .hdiv = 1, .vdiv = 2,
+		  .block_w = { 64, 64, 0, 0 }, .block_h = { 64, 64, 0, 0 }},
 
 		/* YUV planar formats */
 		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 2, .vdiv = 2 },
-- 
2.18.0


