Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD6675DAD0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 09:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjGVHrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 03:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjGVHrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 03:47:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3750A2715;
        Sat, 22 Jul 2023 00:46:27 -0700 (PDT)
X-UUID: a410dda6286311eeb20a276fd37b9834-20230722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=H+k1CPRqEAg82W85WQsOuCMjFC5FoSAfKe4FKLj1mVA=;
        b=EXB7Ah6TLRvDyREAXXPbF/9eOA1jIzuqEz5rHc+AJ+ZPoaxyM1lYVJrQn57bPXyP9FBYEKkPbkKPAR3t2Mbyb7S84AwPjS0nvopBqsAR4fWTzFPgV2zijUfo21VpDi3yl5KzP9dtuajZoXkpfKusJnOQ0Pzfyezn4G9PSzomGwQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:4169e7c9-271e-48d9-ab9e-804ceed8db20,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:176cd25,CLOUDID:9f05f48e-7caa-48c2-8dbb-206f0389473c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a410dda6286311eeb20a276fd37b9834-20230722
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 16540335; Sat, 22 Jul 2023 15:44:51 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 22 Jul 2023 15:44:50 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 22 Jul 2023 15:44:49 +0800
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
        "Steve Cho" <stevecho@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        "Mingjia Zhang" <mingjia.zhang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,0/3] media: mediatek: vcodec: Add driver to support 10bit
Date:   Sat, 22 Jul 2023 15:44:45 +0800
Message-ID: <20230722074448.30671-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Dong <yunfei.dong@mediatek.corp-partner.google.com>

Define two capture formats V4L2_PIX_FMT_MT2110R and
V4L2_PIX_FMT_MT2110T to support 10bit in mt8195, mt8199 and more.
Getting the size of each plane again when user space set 10bit
syntax to driver.

V4L2_PIX_FMT_MT2110R is used for H264, and V4L2_PIX_FMT_MT2110T
is used for AV1/VP9/HEVC.

patch 1 Add driver to support 10bit
patch 2 Add capture format V4L2_PIX_FMT_MT2110T to support 10bit tile mode
patch 3 Add capture format V4L2_PIX_FMT_MT2110R to support 10bit raster mode
---
- compared with v1:
- Fix set non sps return -EINVAL issue.
- Driver test pass in mt8195/mt8188 with tast and Youtube.
- Run v4l2 compliance in mt8195/mt8188 pass.
- fluster test as below:
- h264: (JVT-FR-EXT: 29/69  JVT-AVC_V1: 95/135)
- h265: (JCT-VC-HEVC_V1: 142/147)
- vp9 : (VP9-TEST-VECTORS: 1/6  VP9-TEST-VECTORS: 276/305)
- av1 : (CHROMIUM-10bit-AV1-TEST-VECTORS: 22/23   CHROMIUM-8bit-AV1-TEST-VECTORS: 11/13
-        AV1-TEST-VECTORS: Ran 237/239)

- send the first version v1:
- Run 10bit VP9/AV1 fluster test pass.
- Will return error when the 10bit parameter no correctly in function mtk_vdec_s_ctrl.
---

Reference series:
[1]: this series depends on v6 which is send by Yunfei Dong.
     message-id: 20230704131349.8354-1-yunfei.dong@mediatek.com

Mingjia Zhang (3):
  media: mediatek: vcodec: Add capture format to support 10bit tile mode
  media: mediatek: vcodec: Add capture format to support 10bit raster
    mode
  media: mediatek: vcodec: Add driver to support 10bit

 .../media/v4l/pixfmt-reserved.rst             |  13 ++
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  |  22 ++-
 .../vcodec/decoder/mtk_vcodec_dec_drv.h       |   5 +
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 144 +++++++++++++++++-
 drivers/media/v4l2-core/v4l2-common.c         |   4 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
 include/uapi/linux/videodev2.h                |   2 +
 7 files changed, 188 insertions(+), 4 deletions(-)

-- 
2.18.0

