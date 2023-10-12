Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D8E7C6891
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbjJLIkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjJLIku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:40:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1893BA9;
        Thu, 12 Oct 2023 01:40:43 -0700 (PDT)
X-UUID: 062162b068db11eea33bb35ae8d461a2-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5oPuZOvqen0FMPYfEAl+dBXKiTdxJ+Ejr226OwSHeAA=;
        b=PN/xcoaEgaPyAwmA1Ipe16F0WqDvK0zkJTkup/fLZoBRSSzDQ7P9nOEpSIK0sx5tD4lgvEVnR6GKC9gg6EeHY7tomgplfMH6u+3DJgPk3LbKM63/OhHLIdetcs/hw38slF/feMEcPku98g5G6YeUJc+C2Rzv05ULIEJ1jhNrPGw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:71ed4e3e-ae11-4f02-9c9d-24c2402cc881,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:0eddd8bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 062162b068db11eea33bb35ae8d461a2-20231012
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 753838986; Thu, 12 Oct 2023 16:40:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 16:40:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 16:40:38 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Moudy Ho" <moudy.ho@mediatek.com>
Subject: [PATCH v7 00/16] introduce more MDP3 components in MT8195
Date:   Thu, 12 Oct 2023 16:40:21 +0800
Message-ID: <20231012084037.19376-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.944500-8.000000
X-TMASE-MatchedRID: P9jnqXW9GD/sAGjS6lxxKhlckvO1m+Jc0r/qCu/cY51GL0g1nVmkYT5R
        eTebdoC/4ifNBjPqKM9JnSNmmtyKC1iMfoAkKtzEgZTbeFUhryFbAoaK+wS4jctau7i1GewkQzG
        yMtNT2iodi6rnZPhS04gANQweFs1E717yJ8IcCtsmZusHWPhfCjGZtPrBBPZrY7wPREa5LOgDxm
        wJdBHa0yykokHH0nckrDEfwE8Ux42R9GF2J2xqMxRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7syxk
        dqOJMSC2X5HPRT4be6+grGwIemnJbaq3yu6EJozH8FerAT0dJY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.944500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 93E4BCFCF75A704338DC21C9CB6EA4D573D07B2CB3EBFA5F5CD7390CD74FC1F42000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v6:
- Rebase on v6.6-rc5.
- Dependent dtsi files:
  https://patchwork.kernel.org/project/linux-mediatek/list/?series=792079
- Depends on:
  Message ID = 20231006073831.10402-5-shawn.sung@mediatek.com
- Discard splitting RDMA's common properties and instead use 'allOf' to
  isolate different platform features.
- Revise the incorrect properties in FG, HDR, STITCH, TCC and TDAP bindings.
- Adding SoC-specific compatible string to components, like WROT and RSZ,
  that are inherited from MT8183.
- Fixed typos in TCC patch and enhancing its hardware description.

Changes since v5:
- Rebase on v6.6-rc2.
- Dependent dtsi files:
  https://patchwork.kernel.org/project/linux-mediatek/list/?series=786511
- Depends on:
  Message ID = 20230911074233.31556-5-shawn.sung@mediatek.com
- Split out common propertis for RDMA.
- Split each component into independent patches.

Changes since v4:
- Rebase on v6.6-rc1
- Organize identical hardware components into their respective files.

Hi,

The purpose of this patch is to separate the MDP3-related bindings from
the original mailing list mentioned below:
https://lore.kernel.org/all/20230208092209.19472-1-moudy.ho@mediatek.com/
Those binding files describe additional components that
are present in the mt8195.

Moudy Ho (16):
  dt-bindings: media: mediatek: mdp3: correct RDMA and WROT node with
    generic names
  dt-bindings: media: mediatek: mdp3: merge the indentical RDMA under
    display
  dt-bindings: media: mediatek: mdp3: add config for MT8195 RDMA
  dt-bindings: media: mediatek: mdp3: add compatible for MT8195 RSZ
  dt-bindings: media: mediatek: mdp3: add compatible for MT8195 WROT
  dt-bindings: media: mediatek: mdp3: add component FG for MT8195
  dt-bindings: media: mediatek: mdp3: add component HDR for MT8195
  dt-bindings: media: mediatek: mdp3: add component STITCH for MT8195
  dt-bindings: media: mediatek: mdp3: add component TCC for MT8195
  dt-bindings: media: mediatek: mdp3: add component TDSHP for MT8195
  dt-bindings: display: mediatek: aal: add compatible for MT8195
  dt-bindings: display: mediatek: color: add compatible for MT8195
  dt-bindings: display: mediatek: merge: add compatible for MT8195
  dt-bindings: display: mediatek: ovl: add compatible for MT8195
  dt-bindings: display: mediatek: split: add compatible for MT8195
  dt-bindings: display: mediatek: padding: add compatible for MT8195

 .../display/mediatek/mediatek,aal.yaml        |   1 +
 .../display/mediatek/mediatek,color.yaml      |   1 +
 .../display/mediatek/mediatek,mdp-rdma.yaml   |  88 --------------
 .../display/mediatek/mediatek,merge.yaml      |   1 +
 .../display/mediatek/mediatek,ovl.yaml        |   1 +
 .../display/mediatek/mediatek,padding.yaml    |   4 +-
 .../display/mediatek/mediatek,split.yaml      |  27 +++++
 .../bindings/media/mediatek,mdp3-fg.yaml      |  61 ++++++++++
 .../bindings/media/mediatek,mdp3-hdr.yaml     |  60 ++++++++++
 .../bindings/media/mediatek,mdp3-rdma.yaml    | 108 ++++++++++++++----
 .../bindings/media/mediatek,mdp3-rsz.yaml     |   6 +-
 .../bindings/media/mediatek,mdp3-stitch.yaml  |  61 ++++++++++
 .../bindings/media/mediatek,mdp3-tcc.yaml     |  62 ++++++++++
 .../bindings/media/mediatek,mdp3-tdshp.yaml   |  61 ++++++++++
 .../bindings/media/mediatek,mdp3-wrot.yaml    |  29 +++--
 15 files changed, 449 insertions(+), 122 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-fg.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-stitch.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml

-- 
2.18.0

