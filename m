Return-Path: <linux-kernel+bounces-103193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E634D87BC2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3DC287E12
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE9370CC4;
	Thu, 14 Mar 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CNMuBz3v"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE46FE03;
	Thu, 14 Mar 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710416709; cv=none; b=g6VxNPprzJPY6Tx0/LKY854Hl2Gs308JLnIK9JC2HCOmFV9D17Gd9I4m6eaQ9zJAWXcFNUUJKmV0pJ8xb0HotW7mvvMoM1Prn7lOJ3F8Bb8h2zDNS2i9wv3ZJOZ2a56HH9Alaq/HxitPG8kH4GNlzxzTE0s8E6Ph8wG70SmFUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710416709; c=relaxed/simple;
	bh=tPwnJbZdYYzatxuqkiiBWXwydhS7rxPxnEYBgw8lA0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3O0sj0zRwlT0+QrCwIO8YIVYj9wnJIaoIki45PXBrEJRw57iH6rSw4GG94JaCVgNJqniQJfqhSshtTMeNTL16+lC7I7puaV7dyy7QQqFTLi9CtIlof3vH7/c3wkjzZYxR9xeKE40MFsX4yQGoWEKNaYXxgpIqYrpEpiXixMAFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CNMuBz3v; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 497b0ae8e1f811eeb8927bc1f75efef4-20240314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GaIDC2m2nJb1fg6AN4p/QKYjriwNenP9PPh0twqZQZM=;
	b=CNMuBz3vSGGU4ncZI3CQhlBVn/ocE571c8gEefl4S4tzd3/pWRcdv6yqwTLjFPd8rWtygSLeSKGdlePS6RYoY7/vTDBQKLI3IUHGawdRXXBTbTKtVN/8zzwaFeEW3YApMGHHf293QmNBO4FZIVWFtJc44nfki8MzW1cCm/026Ik=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:0131446c-01a8-4291-b5c5-6bd068f54ebd,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-35
X-CID-META: VersionHash:6f543d0,CLOUDID:263a6790-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 497b0ae8e1f811eeb8927bc1f75efef4-20240314
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 84433996; Thu, 14 Mar 2024 19:44:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Mar 2024 19:44:58 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Mar 2024 19:44:57 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
CC: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, Yunfei
 Dong <yunfei.dong@mediatek.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,4/4] media: mediatek: vcodec: replace v4l2_m2m_next_src_buf with v4l2_m2m_src_buf_remove
Date: Thu, 14 Mar 2024 19:44:52 +0800
Message-ID: <20240314114452.17532-5-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314114452.17532-1-yunfei.dong@mediatek.com>
References: <20240314114452.17532-1-yunfei.dong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

There isn't lock to protect source buffer when get next src buffer, if
the source buffer is removed for some unknown reason before lat work queue
execute done, will lead to remove source buffer or buffer done error.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 22 +++++++++----
 .../vcodec/decoder/vdec/vdec_av1_req_lat_if.c | 25 ++++++--------
 .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c | 33 ++++++++-----------
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
index 3060768e0ea9..bb2680f3ec5b 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
@@ -328,7 +328,7 @@ static void mtk_vdec_worker(struct work_struct *work)
 	bool res_chg = false;
 	int ret;
 
-	vb2_v4l2_src = v4l2_m2m_next_src_buf(ctx->m2m_ctx);
+	vb2_v4l2_src = v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
 	if (!vb2_v4l2_src) {
 		v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
 		mtk_v4l2_vdec_dbg(1, ctx, "[%d] no available source buffer", ctx->id);
@@ -363,7 +363,7 @@ static void mtk_vdec_worker(struct work_struct *work)
 		mtk_v4l2_vdec_err(ctx, "vb2 buffer media request is NULL");
 
 	ret = vdec_if_decode(ctx, bs_src, NULL, &res_chg);
-	if (ret && ret != -EAGAIN) {
+	if (ret) {
 		mtk_v4l2_vdec_err(ctx,
 				  "[%d] decode src_buf[%d] sz=0x%zx pts=%llu ret=%d res_chg=%d",
 				  ctx->id, vb2_src->index, bs_src->size,
@@ -380,11 +380,21 @@ static void mtk_vdec_worker(struct work_struct *work)
 	    ctx->current_codec == V4L2_PIX_FMT_VP8_FRAME) {
 		if (src_buf_req)
 			v4l2_ctrl_request_complete(src_buf_req, &ctx->ctrl_hdl);
-		v4l2_m2m_buf_done_and_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx, state);
-	} else {
-		if (ret != -EAGAIN)
-			v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
+		if (vb2_v4l2_src)
+			v4l2_m2m_buf_done(vb2_v4l2_src, state);
+
 		v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
+	} else {
+		if (!ret) {
+			v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
+		} else {
+			if (src_buf_req)
+				v4l2_ctrl_request_complete(src_buf_req, &ctx->ctrl_hdl);
+			if (vb2_v4l2_src)
+				v4l2_m2m_buf_done(vb2_v4l2_src, state);
+
+			v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
+		}
 	}
 }
 
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
index f277b907c345..339c5c88da1a 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
@@ -1052,23 +1052,18 @@ static inline void vdec_av1_slice_vsi_to_remote(struct vdec_av1_slice_vsi *vsi,
 	memcpy(remote_vsi, vsi, sizeof(*vsi));
 }
 
-static int vdec_av1_slice_setup_lat_from_src_buf(struct vdec_av1_slice_instance *instance,
-						 struct vdec_av1_slice_vsi *vsi,
-						 struct vdec_lat_buf *lat_buf)
+static int vdec_av1_slice_setup_lat_from_src_buf(struct vdec_av1_slice_vsi *vsi,
+						 struct vdec_lat_buf *lat_buf,
+						 struct mtk_vcodec_mem *bs)
 {
-	struct vb2_v4l2_buffer *src;
-	struct vb2_v4l2_buffer *dst;
-
-	src = v4l2_m2m_next_src_buf(instance->ctx->m2m_ctx);
-	if (!src)
-		return -EINVAL;
+	struct mtk_video_dec_buf *src_buf_info;
 
-	lat_buf->src_buf_req = src->vb2_buf.req_obj.req;
-	lat_buf->vb2_v4l2_src = src;
+	src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
+	lat_buf->src_buf_req = src_buf_info->m2m_buf.vb.vb2_buf.req_obj.req;
+	lat_buf->vb2_v4l2_src = &src_buf_info->m2m_buf.vb;
 
-	dst = &lat_buf->ts_info;
-	v4l2_m2m_buf_copy_metadata(src, dst, true);
-	vsi->frame.cur_ts = dst->vb2_buf.timestamp;
+	v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb, &lat_buf->ts_info, true);
+	vsi->frame.cur_ts = lat_buf->ts_info.vb2_buf.timestamp;
 
 	return 0;
 }
@@ -1717,7 +1712,7 @@ static int vdec_av1_slice_setup_lat(struct vdec_av1_slice_instance *instance,
 	struct vdec_av1_slice_vsi *vsi = &pfc->vsi;
 	int ret;
 
-	ret = vdec_av1_slice_setup_lat_from_src_buf(instance, vsi, lat_buf);
+	ret = vdec_av1_slice_setup_lat_from_src_buf(vsi, lat_buf, bs);
 	if (ret)
 		return ret;
 
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
index 0dedbc3680e8..2697e04f4313 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
@@ -693,39 +693,34 @@ static int vdec_vp9_slice_tile_offset(int idx, int mi_num, int tile_log2)
 }
 
 static
-int vdec_vp9_slice_setup_single_from_src_to_dst(struct vdec_vp9_slice_instance *instance)
+int vdec_vp9_slice_setup_single_from_src_to_dst(struct vdec_vp9_slice_instance *instance,
+						struct mtk_vcodec_mem *bs)
 {
-	struct vb2_v4l2_buffer *src;
 	struct vb2_v4l2_buffer *dst;
+	struct mtk_video_dec_buf *src_buf_info;
 
-	src = v4l2_m2m_next_src_buf(instance->ctx->m2m_ctx);
-	if (!src)
-		return -EINVAL;
+	src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
 
 	dst = v4l2_m2m_next_dst_buf(instance->ctx->m2m_ctx);
 	if (!dst)
 		return -EINVAL;
 
-	v4l2_m2m_buf_copy_metadata(src, dst, true);
+	v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb, dst, true);
 
 	return 0;
 }
 
-static int vdec_vp9_slice_setup_lat_from_src_buf(struct vdec_vp9_slice_instance *instance,
-						 struct vdec_lat_buf *lat_buf)
+static int vdec_vp9_slice_setup_lat_from_src_buf(struct vdec_lat_buf *lat_buf,
+						 struct mtk_vcodec_mem *bs)
 {
-	struct vb2_v4l2_buffer *src;
-	struct vb2_v4l2_buffer *dst;
+	struct mtk_video_dec_buf *src_buf_info;
 
-	src = v4l2_m2m_next_src_buf(instance->ctx->m2m_ctx);
-	if (!src)
-		return -EINVAL;
+	src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
+	lat_buf->src_buf_req = src_buf_info->m2m_buf.vb.vb2_buf.req_obj.req;
+	lat_buf->vb2_v4l2_src = &src_buf_info->m2m_buf.vb;
 
-	lat_buf->src_buf_req = src->vb2_buf.req_obj.req;
-	lat_buf->vb2_v4l2_src = src;
+	v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb, &lat_buf->ts_info, true);
 
-	dst = &lat_buf->ts_info;
-	v4l2_m2m_buf_copy_metadata(src, dst, true);
 	return 0;
 }
 
@@ -1155,7 +1150,7 @@ static int vdec_vp9_slice_setup_lat(struct vdec_vp9_slice_instance *instance,
 	struct vdec_vp9_slice_vsi *vsi = &pfc->vsi;
 	int ret;
 
-	ret = vdec_vp9_slice_setup_lat_from_src_buf(instance, lat_buf);
+	ret = vdec_vp9_slice_setup_lat_from_src_buf(lat_buf, bs);
 	if (ret)
 		goto err;
 
@@ -1796,7 +1791,7 @@ static int vdec_vp9_slice_setup_single(struct vdec_vp9_slice_instance *instance,
 	struct vdec_vp9_slice_vsi *vsi = &pfc->vsi;
 	int ret;
 
-	ret = vdec_vp9_slice_setup_single_from_src_to_dst(instance);
+	ret = vdec_vp9_slice_setup_single_from_src_to_dst(instance, bs);
 	if (ret)
 		goto err;
 
-- 
2.18.0


