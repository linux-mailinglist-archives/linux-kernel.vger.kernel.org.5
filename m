Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F7175A928
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjGTI0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjGTI0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:26:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31162684;
        Thu, 20 Jul 2023 01:26:00 -0700 (PDT)
X-UUID: 0d188b3426d711eeb20a276fd37b9834-20230720
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ti0CyFMC0wMS7lE760bLV1Vvq4mXC0J3pcCFBbxfNGk=;
        b=bgZlTnJcHjyEuQcQax70b69SALKmbIMt4EYDad/V7qk08/7fxLuyEjOxuTYFf3GpF2RPgJN3Dv3lpiqLv4TnwXwUN3URIgBLafbqgczAwq+sdsqFk0RcHrjuqJqwHqUzXrX1DkkeyTEUFac4SVOUIurxT8XrscQCI6ReFnPb1iM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:63397277-a6eb-43b0-91ee-e99255694dd2,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:176cd25,CLOUDID:2cafec4c-06c1-468b-847d-5b62d44dbb9b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0d188b3426d711eeb20a276fd37b9834-20230720
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <shuijing.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 613676686; Thu, 20 Jul 2023 16:25:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 20 Jul 2023 16:25:56 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 20 Jul 2023 16:25:55 +0800
From:   Shuijing Li <shuijing.li@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <jitao.shi@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Shuijing Li <shuijing.li@mediatek.com>
Subject: [PATCH v3,0/3] Add compatible to increase MT8188 audio control
Date:   Thu, 20 Jul 2023 16:26:01 +0800
Message-ID: <20230720082604.18618-1-shuijing.li@mediatek.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding documentation of dp-tx for MediaTek MT8188 SoC.
Mainly add the following two flag:

1.The audio packet arrangement function is to only arrange audio
packets into the Hblanking area. In order to align with the HW
default setting of g1200, this function needs to be turned off.

2.Due to the difference of HW, different dividers need to be set.

Base on the branch of linus/master v6.4.

Shuijing Li (3):
  dt-bindings: display: mediatek: dp: Add compatible for MediaTek MT8188
  drm/mediatek: dp: Add the audio control to mtk_dp_data struct
  drm/mediatek: dp: Add the audio divider to mtk_dp_data struct

 .../display/mediatek/mediatek,dp.yaml         |  2 +
 drivers/gpu/drm/mediatek/mtk_dp.c             | 47 ++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_dp_reg.h         |  6 +++
 3 files changed, 54 insertions(+), 1 deletion(-)

-- 
2.40.1

