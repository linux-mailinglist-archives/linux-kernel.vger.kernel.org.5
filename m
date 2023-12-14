Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75CC81277C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443209AbjLNGAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbjLNF7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:59:46 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D1188;
        Wed, 13 Dec 2023 21:58:55 -0800 (PST)
X-UUID: d9b4b0aa9a4511eea5db2bebc7c28f94-20231214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=EnSvj2tYZP4NI1G6ATpw31JLDKJW7cSSRiBu7nXACMM=;
        b=gxgxSkFViOAvE73nLU7jo14ni4wASj4BO5NDacSKDkqqLHSodEsyWPfcRuwgKGxg32CUUvhY/oDMUu4GOKkuHGIMHMHIz2I91UzomfUOktXTLVrFQbHItn+A3SRijhw/uJ2BwCeibuIGlh82wCek5u/KKH4wKWH8uFjk9YgNX2I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:9ae5fcbd-17f7-4770-842b-baf99f42421f,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:5d391d7,CLOUDID:895fc673-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: d9b4b0aa9a4511eea5db2bebc7c28f94-20231214
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1709734976; Thu, 14 Dec 2023 13:58:49 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Dec 2023 13:58:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Dec 2023 13:58:47 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        "Roy-CW . Yeh" <roy-cw.yeh@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        xinlei lee <xinlei.lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v12 00/23] Add display driver for MT8188 VDOSYS1
Date:   Thu, 14 Dec 2023 13:58:24 +0800
Message-ID: <20231214055847.4936-1-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on mediatek-drm-next branch of
kernel/git/chunkuang.hu/linux.git

Changes in v12:
- Rebase on mediatek-drm-next branch of kernel/git/chunkuang.hu/linux.git

Changes in v11:
- Change "mtk-padding" to "mtk-disp-padding" for consistency
- Remove patch "drm/mediatek: Remove ineffectual power management codes
  for backward compatibility

Changes in v10:
- Remove "Reviewed-by" tags from the following commits:
    - drm/mediatek: Power on/off devices with function pointers
    - drm/mediatek: Manage component's clock with function pointers
- Separate the commit into smaller ones
    - (new) drm/mediatek: Remove ineffectual power management codes

Changes in v9:
- Add a static inline function to power off the device
- Change driver name to "mediatek-disp-padding"
- Fix typo and kernel doc format error

Changes in v8:
- Power on/off the components with .power_on() and .power_off()
- Remove mtk_padding_config()
- Remove "Reviewed-by" tags from "drm/mediatek: Add Padding to OVL adaptor"

Changes in v7:
- Start/Stop the components in OVL Adaptor with function pointers
- Refine Padding driver
- Fix underrun when the layer is switching off

Changes in v6:
- Separate the commits into smaller ones
- Add DPI input mode setting
- Fix VDOSYS1 power-on issues

Changes in v5:
- Reuse .clk_enable/.clk_disable in struct mtk_ddp_comp_funcs
  in mtk_disp_ovl_adaptor.c
- Adjust commits order

Changes in v4:
- Add new functions in mtk_disp_ovl_adaptor.c to enable/disable
  components and reuse them when clock enable/disable
- Rename components in mtk_disp_ovl_adaptor.c and sort them in
  alphabetical order

Changes in v3:
- Define macro MMSYS_RST_NR in mtk-mmsys.h and update reset table
- Fix typos (ETDHR -> ETHDR, VSNYC -> VSYNC)
- Rebase dt-bindings on linux-next
- Refine description of Padding
- Squash reset bit map commits for VDO0 and VDO1 into one

Changes in v2:
- Remove redundant compatibles of MT8188 because it shares the same
  configuration with MT8195
- Separate dt-bindings by modules
- Support reset bit mapping in mmsys driver

Hsiao Chien Sung (23):
  dt-bindings: display: mediatek: ethdr: Add compatible for MT8188
  dt-bindings: display: mediatek: mdp-rdma: Add compatible for MT8188
  dt-bindings: display: mediatek: merge: Add compatible for MT8188
  dt-bindings: display: mediatek: padding: Add MT8188
  dt-bindings: arm: mediatek: Add compatible for MT8188
  dt-bindings: reset: mt8188: Add VDOSYS reset control bits
  soc: mediatek: Support MT8188 VDOSYS1 in mtk-mmsys
  soc: mediatek: Support MT8188 VDOSYS1 Padding in mtk-mmsys
  soc: mediatek: Support reset bit mapping in mmsys driver
  soc: mediatek: Add MT8188 VDOSYS reset bit map
  drm/mediatek: Rename OVL_ADAPTOR_TYPE_RDMA
  drm/mediatek: Add component ID to component match structure
  drm/mediatek: Manage component's clock with function pointers
  drm/mediatek: Power on/off devices with function pointers
  drm/mediatek: Start/Stop components with function pointers
  drm/mediatek: Sort OVL adaptor components
  drm/mediatek: Refine device table of OVL adaptor
  drm/mediatek: Support MT8188 Padding in display driver
  drm/mediatek: Add Padding to OVL adaptor
  drm/mediatek: Return error if MDP RDMA failed to enable the clock
  drm/mediatek: Remove the redundant driver data for DPI
  drm/mediatek: Fix underrun in VDO1 when switches off the layer
  drm/mediatek: Support MT8188 VDOSYS1 in display driver

 .../bindings/arm/mediatek/mediatek,mmsys.yaml |   1 +
 .../display/mediatek/mediatek,ethdr.yaml      |   6 +-
 .../display/mediatek/mediatek,mdp-rdma.yaml   |   6 +-
 .../display/mediatek/mediatek,merge.yaml      |   3 +
 .../display/mediatek/mediatek,padding.yaml    |  81 ++++++
 drivers/gpu/drm/mediatek/Makefile             |   3 +-
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |   8 +
 drivers/gpu/drm/mediatek/mtk_disp_merge.c     |   2 +-
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 274 +++++++++++-------
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  16 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |  10 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |   2 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |  20 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   5 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   2 +-
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       |  19 +-
 drivers/gpu/drm/mediatek/mtk_padding.c        | 160 ++++++++++
 drivers/soc/mediatek/mt8188-mmsys.h           | 210 ++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c              |  27 ++
 drivers/soc/mediatek/mtk-mmsys.h              |  32 ++
 drivers/soc/mediatek/mtk-mutex.c              |  51 ++++
 include/dt-bindings/reset/mt8188-resets.h     |  75 +++++
 include/linux/soc/mediatek/mtk-mmsys.h        |   8 +
 23 files changed, 890 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
 create mode 100644 drivers/gpu/drm/mediatek/mtk_padding.c

--
2.18.0

