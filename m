Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3662F7C9FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjJPGoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJPGoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:44:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6901997;
        Sun, 15 Oct 2023 23:43:57 -0700 (PDT)
X-UUID: 5e9f99fe6bef11eea33bb35ae8d461a2-20231016
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XXnEJawfMwVUWYvNaTATy0A/cpFKd1ImYAIi5ObQDnU=;
        b=eIR3fklThs+l+haxiaVHZz1E5ED6+51akjp6rzUYxzaaYfVHysofS8ot6+XU8PYsVKds/0Xhmhh/Efq1BCyD8qhoEN2j6Dox3/HQHK7GSNIfDVhSLr9R8692Eax63/7kwYUdQeKLq4x22mzgmwiSm8oWt9qWpxqCh6y3XxX6vIc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:4985995b-9dbf-4062-9052-62031bf620c8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:7036d6f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5e9f99fe6bef11eea33bb35ae8d461a2-20231016
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1165145270; Mon, 16 Oct 2023 14:43:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 16 Oct 2023 14:43:51 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 16 Oct 2023 14:43:50 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
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
Subject: [PATCH 4/7] media: mediatek: vcodec: Setting the supported h264 profile for each platform
Date:   Mon, 16 Oct 2023 14:43:43 +0800
Message-ID: <20231016064346.31451-4-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016064346.31451-1-yunfei.dong@mediatek.com>
References: <20231016064346.31451-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The supported format type of different platforms are not the
same. Need to set the supported profile according to the chip name.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
index 1fdb21dbacb8..84c0bed577ed 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
@@ -559,6 +559,20 @@ static void mtk_vcodec_dec_fill_h264_level(struct v4l2_ctrl_config *cfg,
 	};
 }
 
+static void mtk_vcodec_dec_fill_h264_profile(struct v4l2_ctrl_config *cfg,
+					     struct mtk_vcodec_dec_ctx *ctx)
+{
+	switch (ctx->dev->chip_name) {
+	case MTK_VDEC_MT8188:
+	case MTK_VDEC_MT8195:
+		cfg->max = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10;
+		break;
+	default:
+		cfg->max = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH;
+		break;
+	};
+}
+
 static void mtk_vcodec_dec_fill_h265_level(struct v4l2_ctrl_config *cfg,
 					   struct mtk_vcodec_dec_ctx *ctx)
 {
@@ -585,6 +599,11 @@ static void mtk_vcodec_dec_reset_controls(struct v4l2_ctrl_config *cfg,
 		mtk_vcodec_dec_fill_h265_level(cfg, ctx);
 		mtk_v4l2_vdec_dbg(3, ctx, "h265 supported level: %lld %lld", cfg->max, cfg->def);
 		break;
+	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
+		mtk_vcodec_dec_fill_h264_profile(cfg, ctx);
+		mtk_v4l2_vdec_dbg(3, ctx, "h264 supported profile: %lld %lld", cfg->max,
+				  cfg->menu_skip_mask);
+		break;
 	default:
 		break;
 	};
-- 
2.18.0

