Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76759785BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjHWPOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbjHWPOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:14:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D98F101
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:14:04 -0700 (PDT)
X-UUID: ac209c5241c711ee9cb5633481061a41-20230823
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1pcjglTSpnV4ck5LHD+yc4GfBKzydE659VWXWlLUwgs=;
        b=kpmfZ+/Iz6yZs3fvsYB0Og+98n+ibaeYrbAATuhbKNUjS9ycbHb/DiM1xWATy0P1la99QbZ5r/0wMOOBkEKoql32z9I65hokESYsjUDSsunHX7hN3TyAPf27GmB0v2Wfsg4rlP7NzMBq7da/s49vgDUkrEIMaCqPxxakuMyCvw4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:445fa00f-8d12-45b5-bd18-3b8ab4306aed,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.31,REQID:445fa00f-8d12-45b5-bd18-3b8ab4306aed,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:0ad78a4,CLOUDID:0a6bddee-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:230823231355Q8KYJDC1,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: ac209c5241c711ee9cb5633481061a41-20230823
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2127990620; Wed, 23 Aug 2023 23:13:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Aug 2023 23:13:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 23 Aug 2023 23:13:52 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH 00/15] Support IGT in display driver
Date:   Wed, 23 Aug 2023 23:13:17 +0800
Message-ID: <20230823151332.28811-1-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for running IGT (Intel GPU Tool) tests
with MediaTek display driver. The following changes will be
applied:

1. Add a new API for creating GCE thread loop to retrieve CRCs
   from the hardware component
2. Support hardware CRC calculation in both VDOSYS0 and VDOSYS1
3. Support alpha blending in both VDOSYS0 and VDOSYS1
4. Fix minor bugs that are found during IGT test

Hsiao Chien Sung (15):
  soc: mediatek: Add register definitions for GCE
  soc: mediatek: Disable 9-bit alpha in ETHDR
  soc: mediatek: Support GCE thread loop
  mailbox: mtk-cmdq: Support GCE thread loop
  drm/mediatek: Support alpha blending in display driver
  drm/mediatek: Support alpha blending in VDOSYS0
  drm/mediatek: Support alpha blending in VDOSYS1
  drm/mediatek: Move struct mtk_drm_crtc to the header file
  drm/mediatek: Add OVL compatible name for MT8195
  drm/mediatek: Support CRC in display driver
  drm/mediatek: Support CRC in VDOSYS0
  drm/mediatek: Support CRC in VDOSYS1
  drm/mediatek: Add missing plane settings when async update
  drm/mediatek: Adjust DRM mode configs for IGT
  drm/mediatek: Fix errors when reporting rotation capability

 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |   3 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       | 304 ++++++++++++++++--
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |  15 +
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |  97 +++---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h       |  64 ++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |   3 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |   5 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  12 +-
 drivers/gpu/drm/mediatek/mtk_drm_plane.c      |  15 +-
 drivers/gpu/drm/mediatek/mtk_ethdr.c          | 170 +++++++++-
 drivers/gpu/drm/mediatek/mtk_ethdr.h          |   4 +
 drivers/mailbox/mtk-cmdq-mailbox.c            |   5 +
 drivers/soc/mediatek/mtk-cmdq-helper.c        |  30 ++
 drivers/soc/mediatek/mtk-mmsys.c              |   1 +
 include/linux/mailbox/mtk-cmdq-mailbox.h      |   1 +
 include/linux/soc/mediatek/mtk-cmdq.h         |   9 +
 16 files changed, 646 insertions(+), 92 deletions(-)

--
2.18.0

