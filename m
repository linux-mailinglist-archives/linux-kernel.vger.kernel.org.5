Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325287D28DC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjJWDHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjJWDHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:07:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E885119;
        Sun, 22 Oct 2023 20:06:57 -0700 (PDT)
X-UUID: 3643face715111ee8051498923ad61e6-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zWD/0C1R8GP7QSgH+H1V2Hdqamu8Yrw8EeQW94hFmqE=;
        b=mD0vwbMwEx1kj58LGntT2Jdsc+WbcUhZpukwXTC4N1KGTiXm3D6OBF54Rg/FYUJ1Yuw9YCyb6GrMZdImMRWAKwR3pi8uOH3OtF5mg9idy2c1gBhfCRqUcuCnkocJDvSdytIeYboAhp/aTIV8jnuPDC9aZnt6Z37GLMP9pmXqQF0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:322978b5-3b59-4c12-ad44-0aa4e7b122da,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:bd50a4fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3643face715111ee8051498923ad61e6-20231023
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 207590965; Mon, 23 Oct 2023 11:06:51 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 11:06:49 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 11:06:48 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
CC:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,7/7] media: mediatek: vcodec: Set the supported vp9 profile for each platform
Date:   Mon, 23 Oct 2023 11:06:40 +0800
Message-ID: <20231023030640.16393-8-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023030640.16393-1-yunfei.dong@mediatek.com>
References: <20231023030640.16393-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the maximum VP9 codec profile for each platform.
The various mediatek platforms support different profiles for decoding,
the profile of the codec limits the capabilities for decoding.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
index eb8590edb579..d54b3833790d 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
@@ -109,7 +109,8 @@ static const struct mtk_stateless_control mtk_stateless_controls[] = {
 			.id = V4L2_CID_MPEG_VIDEO_VP9_PROFILE,
 			.min = V4L2_MPEG_VIDEO_VP9_PROFILE_0,
 			.def = V4L2_MPEG_VIDEO_VP9_PROFILE_0,
-			.max = V4L2_MPEG_VIDEO_VP9_PROFILE_3,
+			.max = V4L2_MPEG_VIDEO_VP9_PROFILE_2,
+			.menu_skip_mask = BIT(V4L2_MPEG_VIDEO_VP9_PROFILE_1),
 		},
 		.codec_type = V4L2_PIX_FMT_VP9_FRAME,
 	},
@@ -632,6 +633,20 @@ static void mtk_vcodec_dec_fill_vp9_level(struct v4l2_ctrl_config *cfg,
 	};
 }
 
+static void mtk_vcodec_dec_fill_vp9_profile(struct v4l2_ctrl_config *cfg,
+					    struct mtk_vcodec_dec_ctx *ctx)
+{
+	switch (ctx->dev->chip_name) {
+	case MTK_VDEC_MT8188:
+	case MTK_VDEC_MT8195:
+		cfg->max = V4L2_MPEG_VIDEO_VP9_PROFILE_2;
+		break;
+	default:
+		cfg->max = V4L2_MPEG_VIDEO_VP9_PROFILE_1;
+		break;
+	};
+}
+
 static void mtk_vcodec_dec_reset_controls(struct v4l2_ctrl_config *cfg,
 					  struct mtk_vcodec_dec_ctx *ctx)
 {
@@ -658,6 +673,11 @@ static void mtk_vcodec_dec_reset_controls(struct v4l2_ctrl_config *cfg,
 		mtk_v4l2_vdec_dbg(3, ctx, "h265 supported profile: %lld %lld", cfg->max,
 				  cfg->menu_skip_mask);
 		break;
+	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:
+		mtk_vcodec_dec_fill_vp9_profile(cfg, ctx);
+		mtk_v4l2_vdec_dbg(3, ctx, "vp9 supported profile: %lld %lld", cfg->max,
+				  cfg->menu_skip_mask);
+		break;
 	default:
 		break;
 	};
-- 
2.18.0

