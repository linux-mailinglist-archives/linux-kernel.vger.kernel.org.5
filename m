Return-Path: <linux-kernel+bounces-93232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8FD872C99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0913C1C2168E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D383DDA5;
	Wed,  6 Mar 2024 02:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IT8a+wLt"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F31D2F7;
	Wed,  6 Mar 2024 02:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691154; cv=none; b=nVx+ZqyzvfJvoY4+T/cJxxqq8bxziheeWmckYN+xhSnEkD4LSR/pPCli66R7Uethu9bPMRZWmlMfSdYH1fZuU40d8Gkixh0dIGa77DQ5TAGcoUDazx1qF2Y5377g7Ece5Lh9/u+pk5Dh8eHXDTfu3s5x0GJa6tEev1elpqYOxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691154; c=relaxed/simple;
	bh=FDdSKs8osnmu3BSbByUHCZN+J1ekfCyTC2ZQLn86zmg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G0WXz266halw488cGegRGZZOJk4j6qZJ2s9/NAiRfeCQ68o+eu8JID7/BaML4UKy3sxfKPoiXfMDNpGpp+yMGxmp786vf+SHnmYw7vGGPU0Q33i9teywTSYtaIwwuSJXoWOs+ufNOfjL92dJrB3pHQWsj0petX+4o6g6lyynZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IT8a+wLt; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fabbc0b8db5e11ee935d6952f98a51a9-20240306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=77P3giULlv83SXb4JB8L4IRfGqmm3Ld83AhH+UMtJzk=;
	b=IT8a+wLtQXw8PaIJBZq/QqW9d+2YGnLoNEBmiLPsHZMum8Witp6i3hc6mW0l23PbL0nMHXlclsvs0mtKcy7c19E0i8+RhzfWePDxMMO9kfEVf2dg8qiCuU91Cetm7dHXuEEhoFgcCzeVzRTeaqET0uxyz2o5g8DloGhvJyliRLw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:b4cda8d8-738f-4374-86a2-230e3c84f04a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:87fb0f90-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: fabbc0b8db5e11ee935d6952f98a51a9-20240306
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <irui.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1199237248; Wed, 06 Mar 2024 10:12:27 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Mar 2024 10:12:26 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Mar 2024 10:12:25 +0800
From: Irui Wang <irui.wang@mediatek.com>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Tiffany Lin <tiffany.lin@mediatek.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<nicolas.dufresne@collabora.com>, Yunfei Dong <yunfei.dong@mediatek.com>,
	Longfei Wang <longfei.wang@mediatek.com>, Maoguang Meng
	<maoguang.meng@mediatek.com>, <sebastian.fricke@collabora.com>
CC: Irui Wang <irui.wang@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3] media: mediatek: vcodec: Handle VP9 superframe bitstream with 8 sub-frames
Date: Wed, 6 Mar 2024 10:12:23 +0800
Message-ID: <20240306021223.14417-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.704300-8.000000
X-TMASE-MatchedRID: 61qs6S/TXDLsgU6kU4VK+KKa0xB73sAAgDRlwc+wR6edCqKtxM6bhy2f
	RWXvh9E9X3E2fHKxS5KuhFLSFG7xdxdAkyS/8v/XA9lly13c/gGH7D1bP/FcOtM2my+Pv+HL0c8
	aNDRHFani8zVgXoAltsIJ+4gwXrEtec3QM3secWbczxMp1BlefbKx6BptLBaOTuz1STu0jwnIP0
	9yQZcG688DF2M8b0VflExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.704300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5EBF45FC3B78C1905E70C4BACA90B4BFA1BABC8770E7EF027E79EB4560DC7DAF2000:8
X-MTK: N

The VP9 bitstream uses superframes, which each contain 8 sub-frames,
enable accessing the last superframe by increasing the range of the index
vaidation as the maximum number of superframes is 8 and not 7, so that the
last sub-frame can be decoded normally with stateful vp9 decoder.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
changed with v2:
 - update commit message only.

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


