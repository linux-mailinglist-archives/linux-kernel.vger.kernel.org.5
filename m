Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C91679A1AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjIKDRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 23:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjIKDQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:16:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1A6115
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 20:16:47 -0700 (PDT)
X-UUID: a011722c505111ee8051498923ad61e6-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=P/xh8LLjglbBDLC4ylTbCB0rsbjDqqmy1RdqQs9RxwE=;
        b=F7zUcV/KfVzTGb08u2DL9cwk2oX0kRtj6Dlj1ff7vK2BKYzmbpRt/nlw7u8XEh6QRtygsAnjITiK8NGMW2oXc4PPGuSZsBSba86IbFcecV2tV/wwZV/yYUm8vqZZrPqa7dCSP1fMiUMI13fOCVGKJKAwOaKUWFDBi2LGtdZ7QQY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:5c1ec8e2-ac8a-4b91-9812-bf470a4c8169,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:0322c813-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a011722c505111ee8051498923ad61e6-20230911
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 972710428; Mon, 11 Sep 2023 11:16:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 11:16:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 11:16:38 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH v6 00/20] Add display driver for MT8188 VDOSYS1
Date:   Mon, 11 Sep 2023 11:16:10 +0800
Message-ID: <20230911031630.12613-1-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.619200-8.000000
X-TMASE-MatchedRID: a9kaGDGTtUZYXTxImR5ZvIa7OiQBC9buWjWsWQUWzVoOkJQR4QWbsO/S
        cgNpr80IQx8Td33i8d2uJFuPllf7ymjez20/QikW4bl1FkKDELdo3Yq5PCwLAjRCaZSKE/OsjBH
        2O7lhl4DL5aw8frs3tCsSrChctaUl7H2DvWppibMXKqR+w9a7UJFLUnnvueyB0pEcoXqJQB2QP7
        8+ZDAwILLAsxfbhF+E41HTVfNlY5/DmEfzPAj6Oh+WEMjoO9WWKhNpTcvbdUKbKItl61J/yZ+in
        TK0bC9eKrauXd3MZDWiZ3sWC9weZPl6k2ye1XLCUWVtiCFltaZlbKOMhqs+K4Dgg8P9QZMv
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.619200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 2FEFC1DCB34FB1A5D39A564376FA7000D2209471E1F4816C351A11C7081256DD2000:8
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

Changes in v6:
- Separate the commits into smaller ones
- Add DPI input mode setting

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

Hsiao Chien Sung (20):
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
  drm/mediatek: Refine device table of OVL adaptor
  drm/mediatek: Sort OVL adaptor components
  drm/mediatek: Add component ID to component match structure
  drm/mediatek: Manage component's clock with function pointers
  drm/mediatek: Make sure the power-on sequence of LARB and RDMA
  drm/mediatek: Support MT8188 Padding in display driver
  drm/mediatek: Add Padding to OVL adaptor
  drm/mediatek: Support MT8188 VDOSYS1 in display driver
  drm/mediatek: Set DPI input to 1T2P mode

 .../bindings/arm/mediatek/mediatek,mmsys.yaml |   1 +
 .../display/mediatek/mediatek,ethdr.yaml      |   6 +-
 .../display/mediatek/mediatek,mdp-rdma.yaml   |   6 +-
 .../display/mediatek/mediatek,merge.yaml      |   3 +
 .../display/mediatek/mediatek,padding.yaml    |  81 +++++++
 drivers/gpu/drm/mediatek/Makefile             |   3 +-
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |   3 +
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 216 +++++++++---------
 drivers/gpu/drm/mediatek/mtk_dpi.c            |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   4 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   2 +-
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       |  20 +-
 drivers/gpu/drm/mediatek/mtk_padding.c        | 136 +++++++++++
 drivers/soc/mediatek/mt8188-mmsys.h           | 210 +++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c              |  23 ++
 drivers/soc/mediatek/mtk-mmsys.h              |  32 +++
 drivers/soc/mediatek/mtk-mutex.c              |  51 +++++
 include/dt-bindings/reset/mt8188-resets.h     |  75 ++++++
 include/linux/soc/mediatek/mtk-mmsys.h        |   8 +
 19 files changed, 764 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
 create mode 100644 drivers/gpu/drm/mediatek/mtk_padding.c

--
2.18.0

