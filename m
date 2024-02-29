Return-Path: <linux-kernel+bounces-86076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 998BF86BF42
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CFF1F241EF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F3836AF9;
	Thu, 29 Feb 2024 03:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iCAyrNOE"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B225364A4;
	Thu, 29 Feb 2024 03:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709175782; cv=none; b=p2X26LO2aPNvmJ0BYzn5Bf0Dr7SwPg0jIv6gTIW9NQhQt2RC+DFbgC76J/p2RGu2D2NGv/iynXlt9GhAqo4g8GoqBcLHrNgh1WeQxT0m/GsMSf/l5YmXWfWfarf1iuTCewIpRAb7KCKYBk6oPJ0rAf6yntD20DvWFWwRBhhzTfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709175782; c=relaxed/simple;
	bh=d5YeaavC8vb1W+Ug/VmFLsdkSOi7EID7OlQsAE8E4fQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W09ByOyoG/PXjDwgja6ElxI98luE0NSDX+t2++YkIf8T2IZz8CAhrtm+JInIIhMv94zJcFWyDnw7yLcb/u4v/qZ6I81BMXZ7cvXSLbZJfg/EvgRFLR+SdweoNBog9Apcv2m+c478xqmUVFgA0hzmwyGVIiQrEAlUbghHc0IdUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iCAyrNOE; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 083293a2d6af11eeb8927bc1f75efef4-20240229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=aYhv12Ei/4yfF7DsV5pcHLs6C/tsptVLgekgyTfK2o0=;
	b=iCAyrNOEQs9Co0VSv0GRswhR6Bf56YLJoqqT1eBCOd5DVcyEtkqbN/+LvByPUNNoBkNPoayMBAdbw3W6Rhta8oufRgHXyYZ3HVHSIMMlzAYV7ts/oYRjOm5dJWRkWnQ4ZYFek59zSk1bKSIZzXHy4/YnaWSntZ6/gVbG7mSMmv4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:0dd5f1ff-7977-4477-8f68-18c58b84eb8b,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:6f543d0,CLOUDID:5f2353ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 083293a2d6af11eeb8927bc1f75efef4-20240229
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <irui.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1682834460; Thu, 29 Feb 2024 11:02:54 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Feb 2024 11:02:52 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 29 Feb 2024 11:02:51 +0800
From: Irui Wang <irui.wang@mediatek.com>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Tiffany Lin <tiffany.lin@mediatek.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<nicolas.dufresne@collabora.com>, Yunfei Dong <yunfei.dong@mediatek.com>,
	Longfei Wang <longfei.wang@mediatek.com>, Maoguang Meng
	<maoguang.meng@mediatek.com>
CC: Irui Wang <irui.wang@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] media: mediatek: vcodec: Handle VP9 superframe bitstream with 8 sub-frames
Date: Thu, 29 Feb 2024 11:02:49 +0800
Message-ID: <20240229030249.3404-1-irui.wang@mediatek.com>
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

The VP9 bitstream has 8 sub-frames into one superframe, the superframe
index validate failed when reach 8, modify the index checking so that the
last sub-frame can be decoded normally with stateful vp9 decoder.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
changed with v1:
 - add a new define 'VP9_MAX_SUPER_FRAMES_NUM' for superframes.
---
 .../mediatek/vcodec/decoder/vdec/vdec_vp9_if.c        | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c
index 55355fa70090..039082f600c8 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c
@@ -16,6 +16,7 @@
 #include "../vdec_drv_base.h"
 #include "../vdec_vpu_if.h"
 
+#define VP9_MAX_SUPER_FRAMES_NUM 8
 #define VP9_SUPER_FRAME_BS_SZ 64
 #define MAX_VP9_DPB_SIZE	9
 
@@ -133,11 +134,11 @@ struct vp9_sf_ref_fb {
  */
 struct vdec_vp9_vsi {
 	unsigned char sf_bs_buf[VP9_SUPER_FRAME_BS_SZ];
-	struct vp9_sf_ref_fb sf_ref_fb[VP9_MAX_FRM_BUF_NUM-1];
+	struct vp9_sf_ref_fb sf_ref_fb[VP9_MAX_SUPER_FRAMES_NUM];
 	int sf_next_ref_fb_idx;
 	unsigned int sf_frm_cnt;
-	unsigned int sf_frm_offset[VP9_MAX_FRM_BUF_NUM-1];
-	unsigned int sf_frm_sz[VP9_MAX_FRM_BUF_NUM-1];
+	unsigned int sf_frm_offset[VP9_MAX_SUPER_FRAMES_NUM];
+	unsigned int sf_frm_sz[VP9_MAX_SUPER_FRAMES_NUM];
 	unsigned int sf_frm_idx;
 	unsigned int sf_init;
 	struct vdec_fb fb;
@@ -526,7 +527,7 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst *inst)
 	/* if this super frame and it is not last sub-frame, get next fb for
 	 * sub-frame decode
 	 */
-	if (vsi->sf_frm_cnt > 0 && vsi->sf_frm_idx != vsi->sf_frm_cnt - 1)
+	if (vsi->sf_frm_cnt > 0 && vsi->sf_frm_idx != vsi->sf_frm_cnt)
 		vsi->sf_next_ref_fb_idx = vp9_get_sf_ref_fb(inst);
 }
 
@@ -735,7 +736,7 @@ static void get_free_fb(struct vdec_vp9_inst *inst, struct vdec_fb **out_fb)
 
 static int validate_vsi_array_indexes(struct vdec_vp9_inst *inst,
 		struct vdec_vp9_vsi *vsi) {
-	if (vsi->sf_frm_idx >= VP9_MAX_FRM_BUF_NUM - 1) {
+	if (vsi->sf_frm_idx > VP9_MAX_SUPER_FRAMES_NUM) {
 		mtk_vdec_err(inst->ctx, "Invalid vsi->sf_frm_idx=%u.", vsi->sf_frm_idx);
 		return -EIO;
 	}
-- 
2.18.0


