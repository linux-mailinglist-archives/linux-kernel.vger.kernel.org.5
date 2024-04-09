Return-Path: <linux-kernel+bounces-136321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A4989D2A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E60B2845A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07267EEF0;
	Tue,  9 Apr 2024 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TvHxiaBb"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FDC7C090;
	Tue,  9 Apr 2024 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712645093; cv=none; b=FdV7v9ciEEdMRsKy65WL1On2c4EbjF1j/0/TNgCleZ1IHe/SuNPQh/6aUbseinpGfk0XObkKARJD4s5n4i1N1zOnEkhRmKgJtcxUWGa7X3AVA8GWfyBdGOjtLOMSpFAL/M6IlkPhGOGFvQ+J/SK7qkSZQZXtj7tDJJSUfouC9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712645093; c=relaxed/simple;
	bh=sPbXPWvg5+mZ/6oQLlNfovqlH0U3jK5wpCleZwSaPXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBt79RHuJOoUJqTHxNNlDRR/QqNSKMdlWpD98yM0q4wUzySAPnqUVH7TgKBFFwCc0wLEAEk+8XXIzsXeVVq/ZnJRhKmNEFAMaK41Ig4ZWDz0gmfFS00j2cp0V7LOsNajtV5RoNO1FZ8rCxbYX3W8NkqyXRxYbkUy/b/miJerne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TvHxiaBb; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a406fb0ef63c11ee935d6952f98a51a9-20240409
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MZosmWHxYSHcRW0nI04JC77u+V6QJPuWaadF+FdFu+s=;
	b=TvHxiaBbAj7mB/fuGZ8+7OKidmp29p5fII3uUIpoEOg2S8tG8pVigtiYJzfCxf+uvw+TR6aqOo+sMiUKre5NELBfEhins30Fb8u3mxEscnTb7mfF3OUfKNzZjHO59oHiyySM9ceKStOR0FzQVvRhPIlI44K6NDaLp4wnomQuTJk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2dc70a6e-aff6-47d8-ae24-97788bb88c13,IP:0,U
	RL:0,TC:0,Content:39,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:9
X-CID-META: VersionHash:6f543d0,CLOUDID:754a7482-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:2,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a406fb0ef63c11ee935d6952f98a51a9-20240409
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1778975413; Tue, 09 Apr 2024 14:44:40 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 Apr 2024 14:44:37 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 Apr 2024 14:44:36 +0800
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
Subject: [PATCH v2,5/5] media: mediatek: vcodec: fix incorrect sizeimage for 10bit bitstream
Date: Tue, 9 Apr 2024 14:44:31 +0800
Message-ID: <20240409064431.16909-6-yunfei.dong@mediatek.com>
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
X-TM-AS-Result: No-10--3.412300-8.000000
X-TMASE-MatchedRID: uGd8VeYUEEWhmMaez4U1AFz+axQLnAVBTI0NfY99MMnfUZT83lbkEEtH
	ojrK13E4Xbw7dgf/8HlAA7ZKGvXdAC1Wsi+5O6Jcsyw+ZJnFumQcZd/OW4yvKkYx760ONDcW9Gb
	SSaq0f4Oh3i6rZZP9+lCkJPtKWaaNDPIzF4wRfrAURSScn+QSXt0H8LFZNFG7CKFCmhdu5cWqtb
	6GDxXi6iofexNkV7fbMknYdva+C6W5yj/z7E7qhyhZ9FGlWWy3Z1gP/jdV4D1SjXz3n1GYt9lEd
	4EsQOBGa8q+62VkyTppp55fZDlsr34cY/B7JqXaYZ1R7NXn0MdBmmCXcKyFFJ6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.412300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8939B90B9B248E41F954A5A918956B972837D3BCB544E7A6922A45827A39B2232000:8
X-MTK: N

The sizeimage of each plane is calculated the same way for 8bit and
10bit bitstream. Using v4l2 common interface v4l2_fill_pixfmt_mp to
separate.

Fixes: 9d86be9bda6c ("media: mediatek: vcodec: Add driver to support 10bit")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 28 ++++++-------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
index 9107707de6c4..fbfba69682ea 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
@@ -262,40 +262,28 @@ static int vidioc_try_fmt(struct mtk_vcodec_dec_ctx *ctx, struct v4l2_format *f,
 		int tmp_w, tmp_h;
 
 		/*
-		 * Find next closer width align 64, height align 64, size align
-		 * 64 rectangle
+		 * Find next closer width align 64, heign align 64, size align 64 rectangle
 		 * Note: This only get default value, the real HW needed value
 		 *       only available when ctx in MTK_STATE_HEADER state
 		 */
 		tmp_w = pix_fmt_mp->width;
 		tmp_h = pix_fmt_mp->height;
+
 		v4l_bound_align_image(&pix_fmt_mp->width, MTK_VDEC_MIN_W, frmsize->max_width, 6,
 				      &pix_fmt_mp->height, MTK_VDEC_MIN_H, frmsize->max_height, 6,
 				      9);
 
-		if (pix_fmt_mp->width < tmp_w &&
-		    (pix_fmt_mp->width + 64) <= frmsize->max_width)
+		if (pix_fmt_mp->width < tmp_w && (pix_fmt_mp->width + 64) <= frmsize->max_width)
 			pix_fmt_mp->width += 64;
-		if (pix_fmt_mp->height < tmp_h &&
-		    (pix_fmt_mp->height + 64) <= frmsize->max_height)
+		if (pix_fmt_mp->height < tmp_h && (pix_fmt_mp->height + 64) <= frmsize->max_height)
 			pix_fmt_mp->height += 64;
 
+		v4l2_fill_pixfmt_mp(pix_fmt_mp, fmt->fourcc, pix_fmt_mp->width, pix_fmt_mp->height);
 		mtk_v4l2_vdec_dbg(0, ctx,
-				  "before resize wxh=%dx%d, after resize wxh=%dx%d, sizeimage=%d",
+				  "before resize:%dx%d, after resize:%dx%d, sizeimage=0x%x_0x%x",
 				  tmp_w, tmp_h, pix_fmt_mp->width, pix_fmt_mp->height,
-				  pix_fmt_mp->width * pix_fmt_mp->height);
-
-		pix_fmt_mp->num_planes = fmt->num_planes;
-		pix_fmt_mp->plane_fmt[0].sizeimage =
-				pix_fmt_mp->width * pix_fmt_mp->height;
-		pix_fmt_mp->plane_fmt[0].bytesperline = pix_fmt_mp->width;
-
-		if (pix_fmt_mp->num_planes == 2) {
-			pix_fmt_mp->plane_fmt[1].sizeimage =
-				(pix_fmt_mp->width * pix_fmt_mp->height) / 2;
-			pix_fmt_mp->plane_fmt[1].bytesperline =
-				pix_fmt_mp->width;
-		}
+				  pix_fmt_mp->plane_fmt[0].sizeimage,
+				  pix_fmt_mp->plane_fmt[1].sizeimage);
 	}
 
 	pix_fmt_mp->flags = 0;
-- 
2.18.0


