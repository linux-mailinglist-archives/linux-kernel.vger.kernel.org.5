Return-Path: <linux-kernel+bounces-6722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD11819C90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136C928331F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04F620B12;
	Wed, 20 Dec 2023 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="a8GFiY3x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F282030B;
	Wed, 20 Dec 2023 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 25c5470e9f2111eeba30773df0976c77-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/ZrhblwNmoNk6WCoNL1l5kKobKdoWw2M/rTakrHMJLk=;
	b=a8GFiY3xGQvPczsTtebxplyPgcUhWXMxJWiccKp6mGMUIXYAVwjYemEZuLWIdGd9kWbRnEMiow3TKcryghmCeff0bZLRqhtHEckjxUm0ROYwrcC0+qWXjboPrAeRuYaKCsbRQ3Cj/mQFAffeU0aeG9IJWWiSGJmJrkWxEUHaZyY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:18cb7408-f6e8-4504-b948-ff5b25103d39,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:5a71618d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 25c5470e9f2111eeba30773df0976c77-20231220
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <moudy.ho@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 747329352; Wed, 20 Dec 2023 18:18:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 18:18:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 18:18:40 +0800
From: Moudy Ho <moudy.ho@mediatek.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v9 10/12] media: platform: mtk-mdp3: add mt8195 shared memory configurations
Date: Wed, 20 Dec 2023 18:18:36 +0800
Message-ID: <20231220101838.21510-11-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231220101838.21510-1-moudy.ho@mediatek.com>
References: <20231220101838.21510-1-moudy.ho@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.505900-8.000000
X-TMASE-MatchedRID: YrZL2AWxAWj4Q348LKfXOMFWmsryu9Zff6/Md8Lb2l//evmlVf9xZpeS
	PuHyHNrhlTJXKqh1ne1M8qdoCvOVvtUMAwTDOBnsyeVujmXuYYXzWEMQjooUzfA/E6k2GJaZ7GT
	6xzYcVDkF2hjByyhJNIzK/ixG8+5UD7+f/jfUYxKNzYJBKgDdERI1EOUVOliSfc8MDDp7ngfNV5
	Nq+ty0vp+YevDk3A7R0ux40LnYo50tVrIvuTuiXE4eFUkH5CFcX6IRwqkp2m5iZCTkFQiKcKdyK
	1rXVA/F14gnLq0QZ8ckGCG8ofm6hiFVxZ0aZ5M9RlqShqb35p7mTPEuA2FKKWHaXGR9wawU8uux
	xpW0vAQDEAw0qQfgcZ3UOp1CVpRt6qLlkd1ucwaeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8geb2C
	AVWgJwEMCP250uHIxex2g/JLoE+/TU9MzIEhLpBZ/ebcgQGndVysbVDBVaGV+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.505900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: C3A3D1884351911CE8AD5AFE4406A1BED8AF1CC8D3AF0E13C9463B19DCA9EFE12000:8
X-MTK: N

The configuration of the MT8195 components in the shared memory
is defined in the header file "mdp_sm_mt8195.h".

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../platform/mediatek/mdp3/mdp_sm_mt8195.h    | 283 ++++++++++++++++++
 .../platform/mediatek/mdp3/mtk-img-ipi.h      |   3 +
 2 files changed, 286 insertions(+)
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_sm_mt8195.h

diff --git a/drivers/media/platform/mediatek/mdp3/mdp_sm_mt8195.h b/drivers/media/platform/mediatek/mdp3/mdp_sm_mt8195.h
new file mode 100644
index 000000000000..b09f48222d24
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mdp_sm_mt8195.h
@@ -0,0 +1,283 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#ifndef __MDP_SM_MT8195_H__
+#define __MDP_SM_MT8195_H__
+
+#include "mtk-mdp3-type.h"
+
+/*
+ * ISP-MDP generic output information
+ * MD5 of the target SCP prebuild:
+ *     a49ec487e458b5971880f1b63dc2a9d5
+ */
+
+#define IMG_MAX_SUBFRAMES_8195	20
+
+struct img_comp_frame_8195 {
+	u32 output_disable;
+	u32 bypass;
+	u32 in_width;
+	u32 in_height;
+	u32 out_width;
+	u32 out_height;
+	struct img_crop crop;
+	u32 in_total_width;
+	u32 out_total_width;
+} __packed;
+
+struct img_comp_subfrm_8195 {
+	u32 tile_disable;
+	struct img_region in;
+	struct img_region out;
+	struct img_offset luma;
+	struct img_offset chroma;
+	s32 out_vertical; /* Output vertical index */
+	s32 out_horizontal; /* Output horizontal index */
+} __packed;
+
+struct mdp_rdma_subfrm_8195 {
+	u32 offset[IMG_MAX_PLANES];
+	u32 offset_0_p;
+	u32 src;
+	u32 clip;
+	u32 clip_ofst;
+	u32 in_tile_xleft;
+	u32 in_tile_ytop;
+} __packed;
+
+struct mdp_rdma_data_8195 {
+	u32 src_ctrl;
+	u32 comp_ctrl;
+	u32 control;
+	u32 iova[IMG_MAX_PLANES];
+	u32 iova_end[IMG_MAX_PLANES];
+	u32 mf_bkgd;
+	u32 mf_bkgd_in_pxl;
+	u32 sf_bkgd;
+	u32 ufo_dec_y;
+	u32 ufo_dec_c;
+	u32 transform;
+	u32 dmabuf_con0;
+	u32 ultra_th_high_con0;
+	u32 ultra_th_low_con0;
+	u32 dmabuf_con1;
+	u32 ultra_th_high_con1;
+	u32 ultra_th_low_con1;
+	u32 dmabuf_con2;
+	u32 ultra_th_high_con2;
+	u32 ultra_th_low_con2;
+	u32 dmabuf_con3;
+	struct mdp_rdma_subfrm_8195 subfrms[IMG_MAX_SUBFRAMES_8195];
+} __packed;
+
+struct mdp_fg_subfrm_8195 {
+	u32 info_0;
+	u32 info_1;
+} __packed;
+
+struct mdp_fg_data_8195 {
+	u32 ctrl_0;
+	u32 ck_en;
+	struct mdp_fg_subfrm_8195 subfrms[IMG_MAX_SUBFRAMES_8195];
+} __packed;
+
+struct mdp_hdr_subfrm_8195 {
+	u32 win_size;
+	u32 src;
+	u32 clip_ofst0;
+	u32 clip_ofst1;
+	u32 hist_ctrl_0;
+	u32 hist_ctrl_1;
+	u32 hdr_top;
+	u32 hist_addr;
+} __packed;
+
+struct mdp_hdr_data_8195 {
+	u32 top;
+	u32 relay;
+	struct mdp_hdr_subfrm_8195   subfrms[IMG_MAX_SUBFRAMES_8195];
+} __packed;
+
+struct mdp_aal_subfrm_8195 {
+	u32 src;
+	u32 clip;
+	u32 clip_ofst;
+} __packed;
+
+struct mdp_aal_data_8195 {
+	u32 cfg_main;
+	u32 cfg;
+	struct mdp_aal_subfrm_8195   subfrms[IMG_MAX_SUBFRAMES_8195];
+} __packed;
+
+struct mdp_rsz_subfrm_8195 {
+	u32 control2;
+	u32 src;
+	u32 clip;
+	u32 hdmirx_en;
+	u32 luma_h_int_ofst;
+	u32 luma_h_sub_ofst;
+	u32 luma_v_int_ofst;
+	u32 luma_v_sub_ofst;
+	u32 chroma_h_int_ofst;
+	u32 chroma_h_sub_ofst;
+	u32 rsz_switch;
+	u32 merge_cfg;
+} __packed;
+
+struct mdp_rsz_data_8195 {
+	u32 coeff_step_x;
+	u32 coeff_step_y;
+	u32 control1;
+	u32 control2;
+	u32 etc_control;
+	u32 prz_enable;
+	u32 ibse_softclip;
+	u32 tap_adapt;
+	u32 ibse_gaincontrol1;
+	u32 ibse_gaincontrol2;
+	u32 ibse_ylevel_1;
+	u32 ibse_ylevel_2;
+	u32 ibse_ylevel_3;
+	u32 ibse_ylevel_4;
+	u32 ibse_ylevel_5;
+	struct mdp_rsz_subfrm_8195 subfrms[IMG_MAX_SUBFRAMES_8195];
+} __packed;
+
+struct mdp_tdshp_subfrm_8195 {
+	u32 src;
+	u32 clip;
+	u32 clip_ofst;
+	u32 hist_cfg_0;
+	u32 hist_cfg_1;
+} __packed;
+
+struct mdp_tdshp_data_8195 {
+	u32 cfg;
+	struct mdp_tdshp_subfrm_8195 subfrms[IMG_MAX_SUBFRAMES_8195];
+} __packed;
+
+struct mdp_color_subfrm_8195 {
+	u32 in_hsize;
+	u32 in_vsize;
+} __packed;
+
+struct mdp_color_data_8195 {
+	u32 start;
+	struct mdp_color_subfrm_8195 subfrms[IMG_MAX_SUBFRAMES_8195];
+} __packed;
+
+struct mdp_ovl_subfrm_8195 {
+	u32 L0_src_size;
+	u32 roi_size;
+} __packed;
+
+struct mdp_ovl_data_8195 {
+	u32 L0_con;
+	u32 src_con;
+	struct mdp_ovl_subfrm_8195 subfrms[IMG_MAX_SUBFRAMES_8195];
+} __packed;
+
+struct mdp_pad_subfrm_8195 {
+	u32 pic_size;
+} __packed;
+
+struct mdp_pad_data_8195 {
+	struct mdp_pad_subfrm_8195 subfrms[IMG_MAX_SUBFRAMES_8195];
+} __packed;
+
+struct mdp_tcc_subfrm_8195 {
+	u32 pic_size;
+} __packed;
+
+struct mdp_tcc_data_8195 {
+	struct mdp_tcc_subfrm_8195 subfrms[IMG_MAX_SUBFRAMES_8195];
+} __packed;
+
+struct mdp_wrot_subfrm_8195 {
+	u32 offset[IMG_MAX_PLANES];
+	u32 src;
+	u32 clip;
+	u32 clip_ofst;
+	u32 main_buf;
+} __packed;
+
+struct mdp_wrot_data_8195 {
+	u32 iova[IMG_MAX_PLANES];
+	u32 control;
+	u32 stride[IMG_MAX_PLANES];
+	u32 mat_ctrl;
+	u32 fifo_test;
+	u32 filter;
+	u32 pre_ultra;
+	u32 framesize;
+	u32 afbc_yuvtrans;
+	u32 scan_10bit;
+	u32 pending_zero;
+	u32 bit_number;
+	u32 pvric;
+	u32 vpp02vpp1;
+	struct mdp_wrot_subfrm_8195 subfrms[IMG_MAX_SUBFRAMES_8195];
+} __packed;
+
+struct mdp_wdma_subfrm_8195 {
+	u32 offset[IMG_MAX_PLANES];
+	u32 src;
+	u32 clip;
+	u32 clip_ofst;
+} __packed;
+
+struct mdp_wdma_data_8195 {
+	u32 wdma_cfg;
+	u32 iova[IMG_MAX_PLANES];
+	u32 w_in_byte;
+	u32 uv_stride;
+	struct mdp_wdma_subfrm_8195 subfrms[IMG_MAX_SUBFRAMES_8195];
+} __packed;
+
+struct isp_data_8195 {
+	u64 dl_flags; /* 1 << (enum mdp_comp_type) */
+	u32 smxi_iova[4];
+	u32 cq_idx;
+	u32 cq_iova;
+	u32 tpipe_iova[IMG_MAX_SUBFRAMES_8195];
+} __packed;
+
+struct img_compparam_8195 {
+	u32 type; /* enum mdp_comp_id */
+	u32 id; /* engine alias_id */
+	u32 input;
+	u32 outputs[IMG_MAX_HW_OUTPUTS];
+	u32 num_outputs;
+	struct img_comp_frame_8195 frame;
+	struct img_comp_subfrm_8195 subfrms[IMG_MAX_SUBFRAMES_8195];
+	u32 num_subfrms;
+	union {
+		struct mdp_rdma_data_8195 rdma;
+		struct mdp_fg_data_8195 fg;
+		struct mdp_hdr_data_8195 hdr;
+		struct mdp_aal_data_8195 aal;
+		struct mdp_rsz_data_8195 rsz;
+		struct mdp_tdshp_data_8195 tdshp;
+		struct mdp_color_data_8195 color;
+		struct mdp_ovl_data_8195 ovl;
+		struct mdp_pad_data_8195 pad;
+		struct mdp_tcc_data_8195 tcc;
+		struct mdp_wrot_data_8195 wrot;
+		struct mdp_wdma_data_8195 wdma;
+		struct isp_data_8195 isp;
+	};
+} __packed;
+
+struct img_config_8195 {
+	struct img_compparam_8195 components[IMG_MAX_COMPONENTS];
+	u32 num_components;
+	struct img_mmsys_ctrl ctrls[IMG_MAX_SUBFRAMES_8195];
+	u32 num_subfrms;
+} __packed;
+
+#endif  /* __MDP_SM_MT8195_H__ */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
index 08fb0853bcd5..f83ac408306e 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
@@ -10,6 +10,7 @@
 
 #include <linux/err.h>
 #include "mdp_sm_mt8183.h"
+#include "mdp_sm_mt8195.h"
 #include "mtk-mdp3-type.h"
 
 /* ISP-MDP generic input information */
@@ -138,12 +139,14 @@ struct img_frameparam {
 struct img_config {
 	union {
 		struct img_config_8183 config_8183;
+		struct img_config_8195 config_8195;
 	};
 } __packed;
 
 struct img_compparam {
 	union {
 		struct img_compparam_8183 comp_8183;
+		struct img_compparam_8195 comp_8195;
 	};
 } __packed;
 
-- 
2.18.0


