Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41FC7C6920
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjJLJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjJLJMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:12:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017E3CC;
        Thu, 12 Oct 2023 02:12:15 -0700 (PDT)
X-UUID: 6b75705868df11ee8051498923ad61e6-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qcuFsWl+TQUGvg3JkMe15rl4uK68feAJJ2PHKXmZyy8=;
        b=vE3yEPkWp6DyfWudcIrVfo9zkA2F8l5qtCofEYdFLv58gKDlqwysjRhoM4yChOM5HX0+fJzI7Ia+MDnhHJshxMRSvvgWOYD65lxRq38YjJHUDIFxq1FbQ9UMk9kIWiixKQQ8ajLsSu7P1XCkE8onPg/PTFEaE4DEiFfY5dzJM5g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ab895b68-4b6f-4244-b75a-43ab9481f050,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5f78ec9,CLOUDID:7285f314-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 6b75705868df11ee8051498923ad61e6-20231012
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1763418392; Thu, 12 Oct 2023 17:12:08 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 17:12:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 17:12:07 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v7 00/12] add support MDP3 on MT8195 platform
Date:   Thu, 12 Oct 2023 17:11:54 +0800
Message-ID: <20231012091206.20165-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.705500-8.000000
X-TMASE-MatchedRID: 1nGv09E/7kfsAGjS6lxxKhlckvO1m+Jc0r/qCu/cY51GL0g1nVmkYYnz
        ULiU6+ud0lMwLmE2TtsfomBuE1LWz2Nwa9aM37neEhGH3CRdKUXL0ev0kxsIk7hrZTuJiYxuoUY
        /oTarxwDMmJZFFJPEpV9cRW5pTniDpljg/F9ExYRc/msUC5wFQWjb0AoQdda6D1JjPBpBp1ocAJ
        RwO9xbIL31gS5fE2u9FvhdPTrJ1Srj0QYD9nJt/23NvezwBrVmLL6mJOIs/va0rcU5V/oSeyacn
        bShnMCc9j3dzZfJjbRg62EFNWAoiBBAYzpZxAP8tG07VELUSnRozho8K1gAGkk7tZaD19NMo8WM
        kQWv6iVfx6Zf83Do5VcppCzPq+1UkGUtrowrXLg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.705500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E007537F27B8D70FCABFF5CD3C18660ECDC71C93D670D8C0C3E653D707F8F1E02000:8
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

Changes since v6:
- Rebase on v6.6-rc5.
- Dependent dtsi files:
  https://patchwork.kernel.org/project/linux-mediatek/list/?series=792079
- Dependent bindings:
  https://patchwork.kernel.org/project/linux-mediatek/list/?series=792477
- Move the patch that fixes compile warnings from this series and
  create a separate standalone patch.

Changes since v5:
- Rebase on v6.6-rc2.
- Dependent dtsi files:
  https://patchwork.kernel.org/project/linux-mediatek/list/?series=786511
- Dependent bindings:
  https://patchwork.kernel.org/project/linux-mediatek/list/?series=786520
- Integrate MMSY/MUTEX structure in "mdp_probe".
- Fix the build warnings that were detected by the linux-media
  build scripts tool.

Changes since v4:
- Rebase on v6.6-rc1
- Remove any unnecessary DTS settings.
- Adjust the usage of MOD and clock in blending components.

Changes since v3:
- Depend on :
  [1] https://patchwork.kernel.org/project/linux-media/list/?series=719841
- Suggested by Krzysztof, integrating all newly added bindings for
  the mt8195 MDP3 into the file "mediatek,mt8195-mdp3.yaml".
- Revise MDP3 nodes with generic names.

Changes since v2:
- Depend on :
  [1] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek/list/?series=711592
  [2] MDP3: https://patchwork.kernel.org/project/linux-mediatek/list/?series=711618
- Suggested by Rob to revise MDP3 bindings to pass dtbs check
- Add parallel paths feature.
- Add blended components settings.

Changes since v1:
- Depend on :
  [1] MDP3 : https://patchwork.kernel.org/project/linux-mediatek/list/?series=698872
  [2] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek/list/?series=684959
- Fix compilation failure due to use of undeclared identifier in file "mtk-mdp3-cmdq.c"

Hello,

This patch is used to add support for MDP3 on the MT8195 platform that
contains more picture quality components, and can arrange more pipelines
through two sets of MMSYS and MUTEX respectively.

Moudy Ho (12):
  media: platform: mtk-mdp3: add support second sets of MMSYS
  media: platform: mtk-mdp3: add support second sets of MUTEX
  media: platform: mtk-mdp3: introduce more pipelines from MT8195
  media: platform: mtk-mdp3: introduce more MDP3 components
  media: platform: mtk-mdp3: add checks for dummy components
  media: platform: mtk-mdp3: avoid multiple driver registrations
  media: platform: mtk-mdp3: extend GCE event waiting in RDMA and WROT
  media: platform: mtk-mdp3: add support for blending multiple
    components
  media: platform: mtk-mdp3: add mt8195 platform configuration
  media: platform: mtk-mdp3: add mt8195 shared memory configurations
  media: platform: mtk-mdp3: add mt8195 MDP3 component settings
  media: platform: mtk-mdp3: add support for parallel pipe to improve
    FPS

 .../platform/mediatek/mdp3/mdp_cfg_data.c     | 729 +++++++++++++-
 .../platform/mediatek/mdp3/mdp_reg_aal.h      |  25 +
 .../platform/mediatek/mdp3/mdp_reg_color.h    |  31 +
 .../media/platform/mediatek/mdp3/mdp_reg_fg.h |  23 +
 .../platform/mediatek/mdp3/mdp_reg_hdr.h      |  31 +
 .../platform/mediatek/mdp3/mdp_reg_merge.h    |  25 +
 .../platform/mediatek/mdp3/mdp_reg_ovl.h      |  25 +
 .../platform/mediatek/mdp3/mdp_reg_pad.h      |  21 +
 .../platform/mediatek/mdp3/mdp_reg_rdma.h     |  24 +
 .../platform/mediatek/mdp3/mdp_reg_rsz.h      |   2 +
 .../platform/mediatek/mdp3/mdp_reg_tdshp.h    |  34 +
 .../platform/mediatek/mdp3/mdp_reg_wrot.h     |   8 +
 .../platform/mediatek/mdp3/mdp_sm_mt8195.h    | 283 ++++++
 .../platform/mediatek/mdp3/mtk-img-ipi.h      |   4 +
 .../platform/mediatek/mdp3/mtk-mdp3-cfg.h     |   2 +
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 440 +++++++--
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.h    |   1 +
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 895 +++++++++++++++++-
 .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  93 +-
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 139 ++-
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  50 +-
 .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  15 +
 .../platform/mediatek/mdp3/mtk-mdp3-regs.c    |  18 +
 .../platform/mediatek/mdp3/mtk-mdp3-regs.h    |   1 +
 .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     |   3 +-
 25 files changed, 2744 insertions(+), 178 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_aal.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_color.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_fg.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_hdr.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_merge.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_ovl.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_pad.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_tdshp.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_sm_mt8195.h

-- 
2.18.0

