Return-Path: <linux-kernel+bounces-129431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 069B0896AB2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2663A1C25CAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EFC13248C;
	Wed,  3 Apr 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eiJRGOy+"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865431350EB;
	Wed,  3 Apr 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136629; cv=none; b=rZIB3lVln9hMxdW1pX9IsGKEFxJLiuonQguo/SFN06qPEMYQWR6iz+MaLrRuQPntuWOyDMNsNNfR0BZmWbUrmAHxFQ5p4YNcbyY/a78KvHuzCG6T/he1n+lGjBOwoQ1OBDuqanLhqrSelC+s2CuFrgbPJNXW+PUoEsqhsXmULm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136629; c=relaxed/simple;
	bh=9v9/qRXgY1gDCX8J53AjFEj95UmJNbA67i2azxtGSYg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FPd6zw3GH1YF/Ky7OaLh39cUNH7Zh/sP5KF6cdsVyMNMenmkG/gxAPhaWMOsut4WSfQg/8McFABtoZeJt7yEjo/6mpW8/wmIzmWzizRUDQ0oLv3qXCb+KS2xZnHUh/JxNwDmGX/tE+lWKIijFkqjbZ9ZszgM3HEQ3CGLCUcIjA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eiJRGOy+; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: caaf9332f19c11eeb8927bc1f75efef4-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Wn/76pYQR540CZbFJPHpX8ZPYvd3JaV3IggNNQ6u4qw=;
	b=eiJRGOy+/8Mz8jPvvzIxhYx2dZpUfwldR3fDlu+oumJoPi2yFxcmEr2i2/xC8IZBakAETPUzz6hQgW9GXlDPvOjZbxLbz90ggRFgrWIw9XSGh0iDpI3YLYwI5I+ko7MuhkhVgWVEuEbIDZccWGi+K7qcXIDDrODg/ncKijOcm0U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:6d969045-7c73-4bf9-81d8-00744efc7bde,IP:0,U
	RL:0,TC:0,Content:43,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:43
X-CID-META: VersionHash:6f543d0,CLOUDID:50c94482-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: caaf9332f19c11eeb8927bc1f75efef4-20240403
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1435720581; Wed, 03 Apr 2024 17:30:21 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 17:30:20 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 17:30:19 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Sebastian Fricke <sebastian.fricke@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, Hans Verkuil
	<hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>
CC: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, Yunfei
 Dong <yunfei.dong@mediatek.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH] media: mediatek: vcodec: fix the error sizeimage for 10bit bitstream
Date: Wed, 3 Apr 2024 17:30:18 +0800
Message-ID: <20240403093018.13168-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The sizeimage of each plane are calculated the same way for 8bit and
10bit bitstream. Need to enlarge the sizeimage with simeimage*5/4 for
10bit bitstream when try and set fmt.

Fixes: 9d86be9bda6c ("media: mediatek: vcodec: Add driver to support 10bit")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 47 ++++++++++++++-----
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
index 9107707de6c4..45209894f1fe 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
@@ -259,6 +259,7 @@ static int vidioc_try_fmt(struct mtk_vcodec_dec_ctx *ctx, struct v4l2_format *f,
 		pix_fmt_mp->num_planes = 1;
 		pix_fmt_mp->plane_fmt[0].bytesperline = 0;
 	} else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
+		unsigned int dram_y, dram_c, dram_y_10bit, dram_c_10bit;
 		int tmp_w, tmp_h;
 
 		/*
@@ -280,22 +281,42 @@ static int vidioc_try_fmt(struct mtk_vcodec_dec_ctx *ctx, struct v4l2_format *f,
 		    (pix_fmt_mp->height + 64) <= frmsize->max_height)
 			pix_fmt_mp->height += 64;
 
-		mtk_v4l2_vdec_dbg(0, ctx,
-				  "before resize wxh=%dx%d, after resize wxh=%dx%d, sizeimage=%d",
-				  tmp_w, tmp_h, pix_fmt_mp->width, pix_fmt_mp->height,
-				  pix_fmt_mp->width * pix_fmt_mp->height);
+		dram_y = pix_fmt_mp->width * pix_fmt_mp->height;
+		dram_c = dram_y / 2;
+
+		dram_y_10bit = dram_y * 5 / 4;
+		dram_c_10bit = dram_y_10bit / 2;
 
 		pix_fmt_mp->num_planes = fmt->num_planes;
-		pix_fmt_mp->plane_fmt[0].sizeimage =
-				pix_fmt_mp->width * pix_fmt_mp->height;
-		pix_fmt_mp->plane_fmt[0].bytesperline = pix_fmt_mp->width;
-
-		if (pix_fmt_mp->num_planes == 2) {
-			pix_fmt_mp->plane_fmt[1].sizeimage =
-				(pix_fmt_mp->width * pix_fmt_mp->height) / 2;
-			pix_fmt_mp->plane_fmt[1].bytesperline =
-				pix_fmt_mp->width;
+		if (pix_fmt_mp->num_planes == 1) {
+			if (ctx->is_10bit_bitstream) {
+				pix_fmt_mp->plane_fmt[0].bytesperline = pix_fmt_mp->width * 5 / 4;
+				pix_fmt_mp->plane_fmt[0].sizeimage = dram_y_10bit + dram_c_10bit;
+			} else {
+				pix_fmt_mp->plane_fmt[0].bytesperline = pix_fmt_mp->width;
+				pix_fmt_mp->plane_fmt[0].sizeimage = dram_y + dram_c;
+			}
+		} else {
+			if (ctx->is_10bit_bitstream) {
+				pix_fmt_mp->plane_fmt[0].bytesperline = pix_fmt_mp->width * 5 / 4;
+				pix_fmt_mp->plane_fmt[1].bytesperline = pix_fmt_mp->width * 5 / 4;
+
+				pix_fmt_mp->plane_fmt[0].sizeimage = dram_y_10bit;
+				pix_fmt_mp->plane_fmt[1].sizeimage = dram_c_10bit;
+			} else {
+				pix_fmt_mp->plane_fmt[0].bytesperline = pix_fmt_mp->width;
+				pix_fmt_mp->plane_fmt[1].bytesperline = pix_fmt_mp->width;
+
+				pix_fmt_mp->plane_fmt[0].sizeimage = dram_y;
+				pix_fmt_mp->plane_fmt[1].sizeimage = dram_c;
+			}
 		}
+
+		mtk_v4l2_vdec_dbg(0, ctx,
+				  "before resize:%dx%d, after resize:%dx%d, sizeimage=0x%x_0x%x",
+				  tmp_w, tmp_h, pix_fmt_mp->width, pix_fmt_mp->height,
+				  pix_fmt_mp->plane_fmt[0].sizeimage,
+				  pix_fmt_mp->plane_fmt[1].sizeimage);
 	}
 
 	pix_fmt_mp->flags = 0;
-- 
2.25.1


