Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D4280EB5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346477AbjLLMUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjLLMUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:20:06 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E52F83;
        Tue, 12 Dec 2023 04:20:07 -0800 (PST)
X-UUID: c5cef7b698e811eea5db2bebc7c28f94-20231212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LOeISYIMwrahEh+sFl08FEXIH6/vlOrNqyOUcSSrrh4=;
        b=rMcCgjXZqFjrYZ95hoyu8d3/5Ej4rriqxH7jIwJt9UsBkXSpFgg8OXoJmen2ooWR9lZ9JRq1M2hTXrNVdhMAqWuP+UbNBea5U0TQNcTSh0NYJJ4BXcuuuG2tyMG4TVlQOACB6NN843Bzr4BFfi/qSis/MrF5YlbP1ZJ/KLrsF94=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:0b3f6a7e-1b58-4c5b-bb96-6a71b4057623,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:343b1c61-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c5cef7b698e811eea5db2bebc7c28f94-20231212
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1040439749; Tue, 12 Dec 2023 20:20:01 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Dec 2023 20:20:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Dec 2023 20:20:00 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>, Sean Paul <sean@poorly.run>,
        Fei Shao <fshao@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH v4 00/17] Support IGT in display driver
Date:   Tue, 12 Dec 2023 20:19:40 +0800
Message-ID: <20231212121957.19231-1-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on mediatek-drm-next.

This series adds support for running IGT (Intel GPU Tool) tests
with MediaTek display driver. The following changes will be
applied:

1. Add a new API for creating GCE thread loop to retrieve CRCs
   from the hardware component
2. Support hardware CRC calculation in both VDOSYS0 and VDOSYS1
3. Support alpha blending in both VDOSYS0 and VDOSYS1

Changes in v4:
- Seperate the patch into smaller ones
- Change the title of some patches
- Revert the changes that are not related to the series

Changes in v3:
- Modify the dt-binding document of Mediatek OVL
- Set DRM mode configs accroding to the hardware capabilities
- Replace cmdq_pkt_jump_absolute() with cmdq_pkt_jump()

Changes in v2:
- Simplify CMDQ by adding commands that are currently used only
- Integrate CRC related codes into new APIs for Mixer and OVL to reuse
- Add CPU version CRC retrieval when CMDQ is disabled

Hsiao Chien Sung (17):
  soc: mediatek: Add register definitions for GCE
  soc: mediatek: Disable 9-bit alpha in ETHDR
  dt-bindings: display: mediatek: ovl: Modify rules for MT8195/MT8188
  drm/mediatek: Add OVL compatible name for MT8195
  drm/mediatek: Set DRM mode configs accordingly
  drm/mediatek: Support alpha blending in OVL
  drm/mediatek: Support alpha blending in Mixer
  drm/mediatek: Support alpha blending in display driver
  drm/mediatek: Support CSC in OVL
  drm/mediatek: Support more color formats in OVL
  drm/mediatek: Turn off the layers with zero width or height
  drm/mediatek: Support CRC in display driver
  drm/mediatek: Support CRC in OVL
  drm/mediatek: Support CRC in OVL adaptor
  drm/mediatek: Add missing plane settings when async update
  drm/mediatek: Fix errors when reporting rotation capability
  drm/mediatek: Add comments for the structures

 .../display/mediatek/mediatek,ovl.yaml        |  12 +-
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |   7 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       | 326 +++++++++++++++---
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |  32 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       | 261 +++++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h       |  39 +++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |   7 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |  35 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  30 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |  16 +
 drivers/gpu/drm/mediatek/mtk_drm_plane.c      |  15 +-
 drivers/gpu/drm/mediatek/mtk_ethdr.c          | 106 +++++-
 drivers/gpu/drm/mediatek/mtk_ethdr.h          |   5 +
 drivers/soc/mediatek/mtk-mmsys.c              |   1 +
 include/linux/soc/mediatek/mtk-cmdq.h         |  10 +
 15 files changed, 834 insertions(+), 68 deletions(-)

--
2.18.0

