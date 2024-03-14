Return-Path: <linux-kernel+bounces-103192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC85E87BC29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F16287E92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE266FE14;
	Thu, 14 Mar 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SKHK/NgL"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78BE6F061;
	Thu, 14 Mar 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710416706; cv=none; b=hrGKuKm0vQ5JdqXLtDYKjTB2dMd1yysu7icTn9od4Q2OzDeueMc6PMf6jG4NCt8eVVxrJyJie2D4H81A4/M71Mx102ghGjfqrubCF6/pPq2rLstAeimu/yliCfWXIqEvAOZAzPP/2h27hWup0A5utwVIDTyMVk5VFrypswSeeCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710416706; c=relaxed/simple;
	bh=Tzgs6E22qADnub+ztlez74QocimSxRichLR0YdIYHcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7N5aoaJ0DraqaU6JqNtmdEBYwen9TDL17lvFWKb8lcdfeiuROTFVTAxPlHnPvS1G37islho9hMWlfRL5pPlkCJCTX7Fc6I+Mejss1sv2gnaR15khVMSOBRZ7uvThnDuP7s2sugdAlNteeJTH5SONYPCihwMI99ieQ+X1yekq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SKHK/NgL; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 48b22baae1f811ee935d6952f98a51a9-20240314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xjEJno96bD5tgsAn7mLNw2YKHVLmVtZVdeyR6hZF0ZM=;
	b=SKHK/NgL9rpWNqkPr5aGEAF4DYC1+rew6OQHEt0r47hfgxriihbCfQaJ/gJnmjNibzfUVVjmnvhxPHWTU/LJaQqTgHCEI36cNwa5Tke4dnAshGmkLOtUjr5nFB2ZAEl5E9+NDhyZ5npLdjhjOqJO1yyax3a82j3kBcaYk++F098=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:64f57e1b-f4f9-4f39-b5ba-1bceccd20f3c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:95238081-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 48b22baae1f811ee935d6952f98a51a9-20240314
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 919694691; Thu, 14 Mar 2024 19:44:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Mar 2024 19:44:56 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Mar 2024 19:44:55 +0800
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
Subject: [PATCH v2,2/4] media: mediatek: vcodec: change flush decode from capture to output when stream off
Date: Thu, 14 Mar 2024 19:44:50 +0800
Message-ID: <20240314114452.17532-3-yunfei.dong@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.281600-8.000000
X-TMASE-MatchedRID: unEMfRhYf4hq+Lkur34drZ7tR0mnRAg1YQ3TTmGSkBbI9BHsOEzeNssM
	7AnHhwCP9t03FccVflZ7nZmSglxg9qjC6/MNUxOoTVa+L3Zgqc4hmbYg1ZcOnivhXWbzMGmSWYF
	jags77eHOH4XDH3WaNlzzIJrqcl2Qcc8G9KynN+O4jAucHcCqnQKdh+kSDJQ4myiLZetSf8mfop
	0ytGwvXiq2rl3dzGQ1ccq6xMOUB5C11XTBVnnfxZPUItZxH5HT9zy568Mc/3z+HwbTrrVhjRrOk
	gZH0Ez6ovNuEZsmdzMmQ264bcESAAGkJ4wL+O5PIy3mhHtdzn7zYaPZALfIbSyZdUr8fx4fMbuy
	vvGhtICw8QUP6tkDzUMMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.281600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F2620DF513159DBF6F04DA83B4019E98B8F37DF3F5AA9BC3C156E41C16C9851D2000:8
X-MTK: N

The buffer remove and buffer done of output queue is separated into two works,
the value of owned_by_drv_count isn't zero when output queue stream off, need
to change flush decode from capture to output when stream off.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
index 409a105c5c12..3766e2176899 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
@@ -845,32 +845,32 @@ void vb2ops_vdec_stop_streaming(struct vb2_queue *q)
 				v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
 			}
 		}
-		return;
-	}
-
-	if (ctx->state >= MTK_STATE_HEADER) {
-
-		/* Until STREAMOFF is called on the CAPTURE queue
-		 * (acknowledging the event), the driver operates
-		 * as if the resolution hasn't changed yet, i.e.
-		 * VIDIOC_G_FMT< etc. return previous resolution.
-		 * So we update picinfo here
-		 */
-		ctx->picinfo = ctx->last_decoded_picinfo;
 
-		mtk_v4l2_vdec_dbg(2, ctx,
-				  "[%d]-> new(%d,%d), old(%d,%d), real(%d,%d)",
-				  ctx->id, ctx->last_decoded_picinfo.pic_w,
-				  ctx->last_decoded_picinfo.pic_h,
-				  ctx->picinfo.pic_w, ctx->picinfo.pic_h,
-				  ctx->last_decoded_picinfo.buf_w,
-				  ctx->last_decoded_picinfo.buf_h);
+		if (ctx->state >= MTK_STATE_HEADER) {
+			/* Until STREAMOFF is called on the CAPTURE queue
+			 * (acknowledging the event), the driver operates
+			 * as if the resolution hasn't changed yet, i.e.
+			 * VIDIOC_G_FMT< etc. return previous resolution.
+			 * So we update picinfo here
+			 */
+			ctx->picinfo = ctx->last_decoded_picinfo;
+
+			mtk_v4l2_vdec_dbg(2, ctx,
+					  "[%d]-> new(%d,%d), old(%d,%d), real(%d,%d)",
+					  ctx->id, ctx->last_decoded_picinfo.pic_w,
+					  ctx->last_decoded_picinfo.pic_h,
+					  ctx->picinfo.pic_w, ctx->picinfo.pic_h,
+					  ctx->last_decoded_picinfo.buf_w,
+					  ctx->last_decoded_picinfo.buf_h);
+
+			ret = ctx->dev->vdec_pdata->flush_decoder(ctx);
+			if (ret)
+				mtk_v4l2_vdec_err(ctx, "DecodeFinal failed, ret=%d", ret);
+		}
 
-		ret = ctx->dev->vdec_pdata->flush_decoder(ctx);
-		if (ret)
-			mtk_v4l2_vdec_err(ctx, "DecodeFinal failed, ret=%d", ret);
+		ctx->state = MTK_STATE_FLUSH;
+		return;
 	}
-	ctx->state = MTK_STATE_FLUSH;
 
 	while ((dst_buf = v4l2_m2m_dst_buf_remove(ctx->m2m_ctx))) {
 		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
-- 
2.18.0


