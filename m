Return-Path: <linux-kernel+bounces-6728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36384819C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E8D2847AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227C0224C2;
	Wed, 20 Dec 2023 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E4hwHjys"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC5208A2;
	Wed, 20 Dec 2023 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2524dfbc9f2111eea5db2bebc7c28f94-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=CdU2676FRynX/MDB7fl2lJe4/NB6e97cAqd453bdqPk=;
	b=E4hwHjysH/un7bXmmhnh1LIRNsOP8Rhk/7bZ10/HMTBeNHEqEQlaqoYwnEDH4kksfQfz/fnyaw7hL6y+pnaaoGjAhlKQ60AuNWfNSECKpR5VnBXIUWsu9rtTeW0ifjz5Ix1YLuJoJOwdgXLiverv1fz/QH+f6a5BBHcRxtcRkdM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:d1977fe1-8353-4ad9-b788-129c09329523,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:e38ffa81-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 2524dfbc9f2111eea5db2bebc7c28f94-20231220
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <moudy.ho@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1367280753; Wed, 20 Dec 2023 18:18:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 18:18:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 18:18:39 +0800
From: Moudy Ho <moudy.ho@mediatek.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Moudy Ho <moudy.ho@mediatek.corp-partner.google.com>
Subject: [PATCH v9 00/12] add support MDP3 on MT8195 platform
Date: Wed, 20 Dec 2023 18:18:26 +0800
Message-ID: <20231220101838.21510-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Moudy Ho <moudy.ho@mediatek.corp-partner.google.com>

Changes since v8:
- Rebase on linux-next.
- Dependent dtsi files:
  Message ID = 20231030094840.2479-1-moudy.ho@mediatek.com
- Dependent bindings:
  Message ID = 20231220100853.20616-1-moudy.ho@mediatek.com

Changes since v7:
- Rebase on linux-next.
- Dependent dtsi files:
  https://patchwork.kernel.org/project/linux-mediatek/list/?series=797543
- Dependent bindings:
  https://patchwork.kernel.org/project/linux-mediatek/list/?series=797555
- Patch [9/12] has made corresponding adjustments in response to the changes in
  the compatible name of the PAD component in DTSI and binding.
- Adding WROT compatible name in the MDP driver's of_match_table in [9/12] to
  avoid deactivating 'pm_runtime_*' functions.

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
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 142 ++-
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  50 +-
 .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  15 +
 .../platform/mediatek/mdp3/mtk-mdp3-regs.c    |  18 +
 .../platform/mediatek/mdp3/mtk-mdp3-regs.h    |   1 +
 .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     |   3 +-
 25 files changed, 2747 insertions(+), 178 deletions(-)
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


