Return-Path: <linux-kernel+bounces-142363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90028A2AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC41284D86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636B869D0A;
	Fri, 12 Apr 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ugcBNBpv"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59E61699;
	Fri, 12 Apr 2024 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912977; cv=none; b=DDcMNXvpim0+n+UvX2MEb0HSPCrvU9jjmRkfCZLJHf2smR8LV6etxHnF31jNn0R2lJHT0xfLCSYJCYd8eszdWpcyoa6SMzDh5AMZNNnn9mXgJ+6zDFhTMjS4OGNmd6eGTpy8zI3NNOIeC8fbuVZEdTaO0LrnJsRAmGxQFlTE4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912977; c=relaxed/simple;
	bh=BzlNrzl5D2F5WQrvJ9H7O11ZWKl8WwvPToYeH2zg7+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3MwzVEZbUe5ylbM/dv8ArT13Xrm4esB+Ozhf/u/CoqoGPVZ60s7mTUKUSK0S5tzy5BWK2Qww0TPMg3O4Fc/Ibw4YQZ4rIMExw8o9R61zDWYl9I5ISgwUATIzn22c74CSZDwNZ4K4YOUfm8wvwtcRL977p4KFeeYmkKNbfKp4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ugcBNBpv; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5e7ced10f8ac11eeb8927bc1f75efef4-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jPr3bvZBdd5E1h6M3D8zcxCN5u5BMOrPbofv972+aLo=;
	b=ugcBNBpvIXu1RWQyaGzfejTyUczPsfndzpL7u/dFXOCwnmqlU8wzSfcU4TW6J5MSbtXJMeBXbhshudV2WhLkiFQysrc7UWB9mIS1TLE7XF9UZBRJleJLY4idwNhGI9JT9iDGPZw4c9q/v+5U/xyap1b9YqzW+yhY4/ACN42/81o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:b845f1fb-68d4-4474-a35f-26bd3694688a,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:76f19882-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5e7ced10f8ac11eeb8927bc1f75efef4-20240412
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1675237864; Fri, 12 Apr 2024 17:09:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 17:09:28 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 17:09:27 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: Jeffrey Kardatzke <jkardatzke@google.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>, "Nicolas
 Dufresne" <nicolas.dufresne@collabora.com>, Hans Verkuil
	<hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Sebastian Fricke
	<sebastian.fricke@collabora.com>, Tomasz Figa <tfiga@chromium.org>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: Chen-Yu Tsai <wenst@chromium.org>, Yong Wu <yong.wu@mediatek.com>,
	"Hsin-Yi Wang" <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
	"Daniel Vetter" <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, Yunfei
 Dong <yunfei.dong@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>,
	"Brian Starkey" <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T
 . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5,23/23] WIP: media: mediatek: vcodec: support av1 svp decoder for mt8188
Date: Fri, 12 Apr 2024 17:08:51 +0800
Message-ID: <20240412090851.24999-24-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412090851.24999-1-yunfei.dong@mediatek.com>
References: <20240412090851.24999-1-yunfei.dong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.072700-8.000000
X-TMASE-MatchedRID: 88yMuGKknhqvVT6bfkFW/gI0yP/uoH+DHgnyJJNAX/iHlDUCu0I+XO2V
	VVLUIzQwlTJXKqh1ne0dfirAFZmGYqK176S49UNHYx1jPJKy+DyOJZyIAulM0xL6MU7t349bWTF
	H84r4cDTElENY51zDnGrJO+UOcr7FhZLJcCUIEcwQNC45RlqcS7/MqlpyYVLByQv2gAzw8M137k
	G+4Njn2eYsPL+HjAe54uhsKr1Kx63wUuSygkLx9HTnOygHVQpOjOOSc4z5QmidwU/qXYxHvNEvk
	7xjlIKiKhaRYmVvcr6XGdInC6ew6h8TzIzimOwPC24oEZ6SpSkj80Za3RRg8LaqWIJNoC8hCYs1
	Ur12Geap9ek8QMdqp6slruXwmByowV0i7pCRH4E=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.072700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 14439F2A996812C155479D3D1B5C839D6F0DACCFAE2052A185B130A04C00298D2000:8
X-MTK: N

From: Xiaoyong Lu <xiaoyong.lu@mediatek.com>

Change av1 driver to support secure video playback(svp) for
mt8188. Need to map shared memory with optee interface and
wait interrupt in optee-os.

Signed-off-by: Xiaoyong Lu <xiaoyong.lu@mediatek.com>
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../vcodec/decoder/vdec/vdec_av1_req_lat_if.c | 97 ++++++++++++-------
 1 file changed, 63 insertions(+), 34 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
index a081e12d67d6..c40ee2646b6c 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
@@ -58,6 +58,9 @@
 #define SEG_LVL_ALT_Q 0
 #define SECONDARY_FILTER_STRENGTH_NUM_BITS 2
 
+#define AV1_IQ_TABLE_SIZE	0x12200
+#define AV1_CDF_TABLE_SIZE	0xFE80
+
 static const short div_lut[DIV_LUT_NUM + 1] = {
 	16384, 16320, 16257, 16194, 16132, 16070, 16009, 15948, 15888, 15828, 15768,
 	15709, 15650, 15592, 15534, 15477, 15420, 15364, 15308, 15252, 15197, 15142,
@@ -641,6 +644,8 @@ struct vdec_av1_slice_fb {
  * @frame:		current frame info
  * @state:		status after decode done
  * @cur_lst_tile_id:	tile id for large scale
+ * @tile_group:		tile group info
+ * @reservd:		reserved
  */
 struct vdec_av1_slice_vsi {
 	/* lat */
@@ -665,6 +670,8 @@ struct vdec_av1_slice_vsi {
 	struct vdec_av1_slice_frame frame;
 	struct vdec_av1_slice_state state;
 	u32 cur_lst_tile_id;
+	struct vdec_av1_slice_tile_group tile_group;
+	unsigned int reservd[4];
 };
 
 /**
@@ -692,7 +699,6 @@ struct vdec_av1_slice_pfc {
  * @cdf_temp:           cdf temp buffer
  * @tile:               tile buffer
  * @slots:              slots info
- * @tile_group:         tile_group entry
  * @level:              level of current resolution
  * @width:              width of last picture
  * @height:             height of last picture
@@ -717,7 +723,6 @@ struct vdec_av1_slice_instance {
 	struct mtk_vcodec_mem cdf_temp;
 	struct mtk_vcodec_mem tile;
 	struct vdec_av1_slice_slot slots;
-	struct vdec_av1_slice_tile_group tile_group;
 
 	/* for resolution change and get_pic_info */
 	enum vdec_av1_slice_resolution_level level;
@@ -774,24 +779,28 @@ static int vdec_av1_slice_init_cdf_table(struct vdec_av1_slice_instance *instanc
 
 	ctx = instance->ctx;
 	vsi = instance->vpu.vsi;
-	remote_cdf_table = mtk_vcodec_fw_map_dm_addr(ctx->dev->fw_handler,
-						     (u32)vsi->cdf_table_addr);
-	if (IS_ERR(remote_cdf_table)) {
-		mtk_vdec_err(ctx, "failed to map cdf table\n");
-		return PTR_ERR(remote_cdf_table);
-	}
-
-	mtk_vdec_debug(ctx, "map cdf table to 0x%p\n", remote_cdf_table);
 
 	if (instance->cdf_table.va)
 		mtk_vcodec_mem_free(ctx, &instance->cdf_table);
+	vsi->cdf_table_size = AV1_CDF_TABLE_SIZE;
+	mtk_vdec_debug(ctx, "svp %d. cdf table size 0x%x\n",
+		       instance->ctx->is_secure_playback, vsi->cdf_table_size);
 	instance->cdf_table.size = vsi->cdf_table_size;
 
 	ret = mtk_vcodec_mem_alloc(ctx, &instance->cdf_table);
 	if (ret)
 		return ret;
 
-	memcpy(instance->cdf_table.va, remote_cdf_table, vsi->cdf_table_size);
+	if (!instance->ctx->is_secure_playback) {
+		remote_cdf_table = mtk_vcodec_fw_map_dm_addr(ctx->dev->fw_handler,
+							     (u32)vsi->cdf_table_addr);
+		if (IS_ERR(remote_cdf_table)) {
+			mtk_vdec_err(ctx, "failed to map cdf table\n");
+			return PTR_ERR(remote_cdf_table);
+		}
+
+		memcpy(instance->cdf_table.va, remote_cdf_table, vsi->cdf_table_size);
+	}
 
 	return 0;
 }
@@ -805,25 +814,26 @@ static int vdec_av1_slice_init_iq_table(struct vdec_av1_slice_instance *instance
 
 	ctx = instance->ctx;
 	vsi = instance->vpu.vsi;
-	remote_iq_table = mtk_vcodec_fw_map_dm_addr(ctx->dev->fw_handler,
-						    (u32)vsi->iq_table_addr);
-	if (IS_ERR(remote_iq_table)) {
-		mtk_vdec_err(ctx, "failed to map iq table\n");
-		return PTR_ERR(remote_iq_table);
-	}
-
-	mtk_vdec_debug(ctx, "map iq table to 0x%p\n", remote_iq_table);
 
 	if (instance->iq_table.va)
 		mtk_vcodec_mem_free(ctx, &instance->iq_table);
+	vsi->iq_table_size = AV1_IQ_TABLE_SIZE;
 	instance->iq_table.size = vsi->iq_table_size;
 
 	ret = mtk_vcodec_mem_alloc(ctx, &instance->iq_table);
 	if (ret)
 		return ret;
 
-	memcpy(instance->iq_table.va, remote_iq_table, vsi->iq_table_size);
+	if (!instance->ctx->is_secure_playback) {
+		remote_iq_table = mtk_vcodec_fw_map_dm_addr(ctx->dev->fw_handler,
+							    (u32)vsi->iq_table_addr);
+		if (IS_ERR(remote_iq_table)) {
+			mtk_vdec_err(ctx, "failed to map iq table\n");
+			return PTR_ERR(remote_iq_table);
+		}
 
+		memcpy(instance->iq_table.va, remote_iq_table, vsi->iq_table_size);
+	}
 	return 0;
 }
 
@@ -1380,7 +1390,7 @@ static int vdec_av1_slice_setup_tile_group(struct vdec_av1_slice_instance *insta
 					   struct vdec_av1_slice_vsi *vsi)
 {
 	struct v4l2_ctrl_av1_tile_group_entry *ctrl_tge;
-	struct vdec_av1_slice_tile_group *tile_group = &instance->tile_group;
+	struct vdec_av1_slice_tile_group *tile_group = &vsi->tile_group;
 	struct vdec_av1_slice_uncompressed_header *uh = &vsi->frame.uh;
 	struct vdec_av1_slice_tile *tile = &uh->tile;
 	struct v4l2_ctrl *ctrl;
@@ -1621,7 +1631,9 @@ static void vdec_av1_slice_setup_lat_buffer(struct vdec_av1_slice_instance *inst
 
 	vsi->tile.buf = instance->tile.dma_addr;
 	vsi->tile.size = instance->tile.size;
-	memcpy(lat_buf->tile_addr.va, instance->tile.va, 64 * instance->tile_group.num_tiles);
+	if (!instance->ctx->is_secure_playback)
+		memcpy(lat_buf->tile_addr.va, instance->tile.va,
+		       64 * vsi->tile_group.num_tiles);
 
 	vsi->cdf_table.buf = instance->cdf_table.dma_addr;
 	vsi->cdf_table.size = instance->cdf_table.size;
@@ -1638,7 +1650,7 @@ static void vdec_av1_slice_setup_seg_buffer(struct vdec_av1_slice_instance *inst
 	/* reset segment buffer */
 	if (uh->primary_ref_frame == AV1_PRIMARY_REF_NONE || !uh->seg.segmentation_enabled) {
 		mtk_vdec_debug(instance->ctx, "reset seg %d\n", vsi->slot_id);
-		if (vsi->slot_id != AV1_INVALID_IDX) {
+		if (!instance->ctx->is_secure_playback && vsi->slot_id != AV1_INVALID_IDX) {
 			buf = &instance->seg[vsi->slot_id];
 			memset(buf->va, 0, buf->size);
 		}
@@ -1649,7 +1661,7 @@ static void vdec_av1_slice_setup_tile_buffer(struct vdec_av1_slice_instance *ins
 					     struct vdec_av1_slice_vsi *vsi,
 					     struct mtk_vcodec_mem *bs)
 {
-	struct vdec_av1_slice_tile_group *tile_group = &instance->tile_group;
+	struct vdec_av1_slice_tile_group *tile_group = &vsi->tile_group;
 	struct vdec_av1_slice_uncompressed_header *uh = &vsi->frame.uh;
 	struct vdec_av1_slice_tile *tile = &uh->tile;
 	u32 tile_num, tile_row, tile_col;
@@ -1732,7 +1744,9 @@ static int vdec_av1_slice_setup_lat(struct vdec_av1_slice_instance *instance,
 		return ret;
 
 	vdec_av1_slice_setup_seg_buffer(instance, vsi);
-	vdec_av1_slice_setup_tile_buffer(instance, vsi, bs);
+	if (!instance->ctx->is_secure_playback)
+		vdec_av1_slice_setup_tile_buffer(instance, vsi, bs);
+
 	vdec_av1_slice_setup_lat_buffer(instance, vsi, bs, lat_buf);
 
 	return 0;
@@ -1795,10 +1809,15 @@ static int vdec_av1_slice_setup_core_buffer(struct vdec_av1_slice_instance *inst
 
 	/* frame buffer */
 	vsi->fb.y.dma_addr = fb->base_y.dma_addr;
-	if (plane == 1)
-		vsi->fb.c.dma_addr = fb->base_y.dma_addr + size;
-	else
-		vsi->fb.c.dma_addr = fb->base_c.dma_addr;
+
+	if (!instance->ctx->is_secure_playback) {
+		if (plane == 1)
+			vsi->fb.c.dma_addr = fb->base_y.dma_addr + size;
+		else
+			vsi->fb.c.dma_addr = fb->base_c.dma_addr;
+	}
+	vsi->fb.y.size = instance->ctx->picinfo.fb_sz[0];
+	vsi->fb.c.size = instance->ctx->picinfo.fb_sz[1];
 
 	/* reference buffers */
 	vq = v4l2_m2m_get_vq(instance->ctx->m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
@@ -1821,6 +1840,7 @@ static int vdec_av1_slice_setup_core_buffer(struct vdec_av1_slice_instance *inst
 		}
 
 		vref->y.dma_addr = vb2_dma_contig_plane_dma_addr(vb, 0);
+		vref->y.size = size;
 		if (plane == 1)
 			vref->c.dma_addr = vref->y.dma_addr + size;
 		else
@@ -1897,7 +1917,13 @@ static int vdec_av1_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 		goto error_vsi;
 	}
 	instance->init_vsi = vsi;
-	instance->core_vsi = mtk_vcodec_fw_map_dm_addr(ctx->dev->fw_handler, (u32)vsi->core_vsi);
+	if (ctx->is_secure_playback)
+		instance->core_vsi =
+			mtk_vcodec_dec_get_shm_buffer_va(ctx->dev->optee_private, MTK_VDEC_CORE,
+							 OPTEE_DATA_INDEX);
+	else
+		instance->core_vsi = mtk_vcodec_fw_map_dm_addr(ctx->dev->fw_handler,
+							       (u32)vsi->core_vsi);
 
 	if (!instance->core_vsi) {
 		mtk_vdec_err(ctx, "failed to get AV1 core vsi\n");
@@ -1909,11 +1935,12 @@ static int vdec_av1_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 		mtk_vdec_err(ctx, "remote vsi size 0x%x mismatch! expected: 0x%zx\n",
 			     vsi->vsi_size, sizeof(struct vdec_av1_slice_vsi));
 
-	instance->irq_enabled = 1;
+	instance->irq_enabled = !ctx->is_secure_playback;
 	instance->inneracing_mode = IS_VDEC_INNER_RACING(instance->ctx->dev->dec_capability);
 
-	mtk_vdec_debug(ctx, "vsi 0x%p core_vsi 0x%llx 0x%p, inneracing_mode %d\n",
-		       vsi, vsi->core_vsi, instance->core_vsi, instance->inneracing_mode);
+	mtk_vdec_debug(ctx, "secure %d:vsi 0x%p core_vsi 0x%llx 0x%p, inneracing_mode %d\n",
+		       ctx->is_secure_playback, vsi, vsi->core_vsi, instance->core_vsi,
+		       instance->inneracing_mode);
 
 	ret = vdec_av1_slice_init_cdf_table(instance);
 	if (ret)
@@ -2106,7 +2133,9 @@ static int vdec_av1_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 			vdec_msg_queue_qbuf(&ctx->msg_queue.lat_ctx, lat_buf);
 		return -EBUSY;
 	}
-	vsi->trans.dma_addr_end += ctx->msg_queue.wdma_addr.dma_addr;
+	if (!instance->ctx->is_secure_playback)
+		vsi->trans.dma_addr_end += ctx->msg_queue.wdma_addr.dma_addr;
+
 	mtk_vdec_debug(ctx, "lat dma 1 0x%pad 0x%pad\n",
 		       &pfc->vsi.trans.dma_addr, &pfc->vsi.trans.dma_addr_end);
 
-- 
2.18.0


