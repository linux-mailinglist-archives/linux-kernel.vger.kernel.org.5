Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC1B7CBBA2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjJQGrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjJQGrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:47:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC7FE8;
        Mon, 16 Oct 2023 23:47:31 -0700 (PDT)
X-UUID: 04a9d6246cb911eea33bb35ae8d461a2-20231017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qf+7xfahKnfF6lGO2CMiwO2Ukoj8O7Qnr8MyqJJEMnY=;
        b=Azykfa5FNMaYj3Kyj5WzXx4S2bJtkLV6HZ2+96hRjv28lq9kxFS+oSvcAz7/2QSdsFjUBuoPIOfdFa2CHuRHcmfb0lwsM9UZurQecwHoW2iFbSSbzDlpR5bYRG1+72+7rE1iB1xvwVSSO4AusWnh9Jfzdy1tsgUhQ3S/v+BTvBI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2f6ab231-e423-4a16-a95f-f960ac26c190,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:75012015-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 04a9d6246cb911eea33bb35ae8d461a2-20231017
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 731003446; Tue, 17 Oct 2023 14:47:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Oct 2023 14:47:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Oct 2023 14:47:18 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>, Sean Paul <sean@poorly.run>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH v3 00/11] Support IGT in display driver
Date:   Tue, 17 Oct 2023 14:47:06 +0800
Message-ID: <20231017064717.21616-1-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.125500-8.000000
X-TMASE-MatchedRID: 2M1vhZdKI+q0Ksgzm0Grb0vrB8UvzFr4uLwbhNl9B5VcKZwALwMGswaT
        alM8C773zVZHFuZcThYl6rr8933abg7WYEeNmTZn7spMO3HwKCAhHWssEmb8zsRd6VScTqylI6E
        H/j35nyhiYqp1f8ouR+8AJ9RS6zXQD7+f/jfUYxID2WXLXdz+AbLiLKO9VZOinaIcQMBRvbSjxY
        yRBa/qJcFwgTvxipFajoczmuoPCq1sVXiEzAZQKTrxL9jf8Q32kxH4pkZWPWronF1rgIxheCQGD
        b1YJqxA
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.125500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 1B8B68A1E5211F3A5AD423F4B16ADFB010B6C5046DBD0491A959E66D86B718892000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
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

Changes in v3:
- Modify the dt-binding document of Mediatek OVL
- Set DRM mode configs accroding to the hardware capabilities
- Replace cmdq_pkt_jump_absolute() with cmdq_pkt_jump()

Changes in v2:
- Simplify CMDQ by adding commands that are currently used only
- Integrate CRC related codes into new APIs for Mixer and OVL to reuse
- Add CPU version CRC retrieval when CMDQ is disabled

Hsiao Chien Sung (11):
  soc: mediatek: Add register definitions for GCE
  soc: mediatek: Disable 9-bit alpha in ETHDR
  dt-bindings: display: mediatek: ovl: Modify rules for MT8195/MT8188
  drm/mediatek: Add OVL compatible name for MT8195
  drm/mediatek: Set DRM mode configs accordingly
  drm/mediatek: Support alpha blending in display driver
  drm/mediatek: Support alpha blending in VDOSYS0
  drm/mediatek: Support alpha blending in VDOSYS1
  drm/mediatek: Support CRC in display driver
  drm/mediatek: Support CRC in VDOSYS0
  drm/mediatek: Support CRC in VDOSYS1

 .../display/mediatek/mediatek,ovl.yaml        |  12 +-
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |   6 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       | 309 ++++++++++++++++--
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |  23 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       | 261 ++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h       |  39 +++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |   6 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |  35 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  40 ++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |  19 ++
 drivers/gpu/drm/mediatek/mtk_drm_plane.c      |  11 +
 drivers/gpu/drm/mediatek/mtk_ethdr.c          | 121 ++++++-
 drivers/gpu/drm/mediatek/mtk_ethdr.h          |   5 +
 drivers/soc/mediatek/mtk-mmsys.c              |   1 +
 include/linux/soc/mediatek/mtk-cmdq.h         |  10 +
 15 files changed, 839 insertions(+), 59 deletions(-)

--
2.18.0

