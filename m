Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4498767BFB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 05:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbjG2Dl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 23:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjG2DlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 23:41:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C57846B1;
        Fri, 28 Jul 2023 20:41:22 -0700 (PDT)
X-UUID: c4dd92502dc111eeb20a276fd37b9834-20230729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=igoiCjJKQT1M3exb7NUJhcghlRjy5CrQZYQZIjk5STM=;
        b=CIYhQxaGFuuq62q3dvf5l0SmPGutcNa5k/WSkYxfo8efqSbEw1LcVGMIExAXYJ3VTCeSzGWPPbZkZFC5G87doeFgCcUJg+NuKckBrRL/H62Xl5vRWHIwi/DwYn4TlQUxkeB4m+84tjKRrZ9XuskLKvOcmONFycroDba4dFejEkM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:76120e3e-52e3-49e5-b9c6-25927477cc26,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:1fcc6f8,CLOUDID:a04473d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c4dd92502dc111eeb20a276fd37b9834-20230729
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1671848962; Sat, 29 Jul 2023 11:41:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 29 Jul 2023 11:41:13 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 29 Jul 2023 11:41:12 +0800
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
        Mingjia Zhang <mingjia.zhang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3,0/3] media: mediatek: vcodec: Add driver to support 10bit
Date:   Sat, 29 Jul 2023 11:41:09 +0800
Message-ID: <20230729034112.16993-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
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
- compared with v2:
- add the compliance test result: Total for mtk-vcodec-dec device /dev/video-dec0: 46, Succeeded: 46, Failed: 0, Warnings: 0
- this patch is based on separate encoder and decoder patch series.
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
     20230729025515.16029-1-yunfei.dong@mediatek.com

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

