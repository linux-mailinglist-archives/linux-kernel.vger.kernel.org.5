Return-Path: <linux-kernel+bounces-103191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846EF87BC26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7879E1C223D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A898D6FBB8;
	Thu, 14 Mar 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qLmfq5aa"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8058A6F065;
	Thu, 14 Mar 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710416705; cv=none; b=t6s4gFtn/46XZdjteA4Nnkv2BBk2VvGf/swAemhk79YB6ck/YKDFXM1TtKyrD+nf5vz8rX6GTq6aa950xUZGPilJjY64kbvmp/a7DUEPQh1JX9sMBPQ6nLsd6ldYPaOWIgqR1L2tY/6yW9p7QWx6KtIuNYz2AQ598/WaqhT43o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710416705; c=relaxed/simple;
	bh=SXxtb7bxSKRszoVxuzF4Ucwf11/mZoyMMCwTP5EOnFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VH1W0fylXcieO5OT9vXI1b32KGpslxtgpUOxNekkPd7CqNCUmmxtdoILvSFS76lqDtCljC0/NJ4b5Ed7qv2ZGBj3XCKVcenxbL388MHLH+oRE8Egz1iH9NK5RPschih2j8zqkHzVSU5d4VCl5T5YkTSf6uPE9uqh5PtkgER2yUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qLmfq5aa; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 49106a58e1f811ee935d6952f98a51a9-20240314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Y8AOqNEE2z+8/C4fBu6xT5uIPzpeWScBA5hbmroPZmo=;
	b=qLmfq5aaW433KL62H6X/ARRjZexknv8j8OaK7A8VIJgMFNiHz8Kxht99QQopvK1m/QmKJkk88MViSRL+UhPeBHO1s0MrFW42N2n2rVjyoIwSdG7fVAbfbA5Fwe/k5u2pPIsZRhguy0i4CNVHZGuok284S+39anrw9tgcDi6BrB8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:6453353b-d688-4b03-bae5-b7b76f5ee19b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:193a6790-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 49106a58e1f811ee935d6952f98a51a9-20240314
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1847715534; Thu, 14 Mar 2024 19:44:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Mar 2024 19:44:57 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Mar 2024 19:44:56 +0800
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
Subject: [PATCH v2,3/4] media: mediatek: vcodec: flush decoder before remove all source buffer
Date: Thu, 14 Mar 2024 19:44:51 +0800
Message-ID: <20240314114452.17532-4-yunfei.dong@mediatek.com>
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
X-TM-AS-Result: No-10--4.180300-8.000000
X-TMASE-MatchedRID: LQTn7QLkznoEQqIqKFLtTlu4M/xm4KZebnWMzHijq6Sen0qBdy7fjBXb
	HvCbSY/6sTCecWdCeaflMF4v3SREo4x1g1lTiexdA9lly13c/gGOJZyIAulM0xQLE16MmfDLS20
	1H/juErxAEhD9e0n6VSfyuWB93oCTC9YpJ/fXjNeeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8ifEz
	J5hPndGZnMVq7tIlw2tPfRu/NO6WJzOLRNuFmkzrkqWJxjUSaiqe1i8szqq0zFmp618OSM6Obqo
	nfkRZEWXfGn12bbCvxioaYV0aSx3Bz+PhojlLUuev0YPTN868QBqq+/+aGCsQhzL04Or2eZVlxr
	1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.180300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6680B778D7103250B9479887C3CEB8CB3823E585258715E9BDE23C31FE0953662000:8
X-MTK: N

Flush decoder will reset all driver to init status, lat and core work
queue will stop to work. If lat or core work queue in working when
remove all source buffer, will lead to remove source buffer again
or buff done with one non-existent source buffer.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
index 3766e2176899..cdd36a5320cd 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
@@ -835,17 +835,6 @@ void vb2ops_vdec_stop_streaming(struct vb2_queue *q)
 			  ctx->id, q->type, ctx->state, ctx->decoded_frame_cnt);
 
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
-		while ((src_buf = v4l2_m2m_src_buf_remove(ctx->m2m_ctx))) {
-			if (src_buf != &ctx->empty_flush_buf.vb) {
-				struct media_request *req =
-					src_buf->vb2_buf.req_obj.req;
-
-				if (req)
-					v4l2_ctrl_request_complete(req, &ctx->ctrl_hdl);
-				v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
-			}
-		}
-
 		if (ctx->state >= MTK_STATE_HEADER) {
 			/* Until STREAMOFF is called on the CAPTURE queue
 			 * (acknowledging the event), the driver operates
@@ -868,6 +857,17 @@ void vb2ops_vdec_stop_streaming(struct vb2_queue *q)
 				mtk_v4l2_vdec_err(ctx, "DecodeFinal failed, ret=%d", ret);
 		}
 
+		while ((src_buf = v4l2_m2m_src_buf_remove(ctx->m2m_ctx))) {
+			if (src_buf != &ctx->empty_flush_buf.vb) {
+				struct media_request *req =
+					src_buf->vb2_buf.req_obj.req;
+
+				if (req)
+					v4l2_ctrl_request_complete(req, &ctx->ctrl_hdl);
+				v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
+			}
+		}
+
 		ctx->state = MTK_STATE_FLUSH;
 		return;
 	}
-- 
2.18.0


