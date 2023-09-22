Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9157AA9FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjIVHVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjIVHVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:21:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EF519E;
        Fri, 22 Sep 2023 00:21:25 -0700 (PDT)
X-UUID: a1422ab8591811eea33bb35ae8d461a2-20230922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wPAZy6ESnioZH+kLVb+rHtDuQKaIt/qY8aIqjrMpNI8=;
        b=abMw3/OluEkMml71zip8usveH/mS3rnrTEW4CREkdKCLx803z1ThElM50w8qdc7z3Qzgppy/ciS5GCESQYC7N6WQkAAKpvdaRgw1jSDx5NzYcWuSeM/2D7m+fRm8XK6d2pqGm0V1yyoGWH2QqfZNqAGHAu1fSWrlLw6F1SMp6F4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:aff142e0-53b0-4731-a6bb-c22457bfaf7c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:edff54c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a1422ab8591811eea33bb35ae8d461a2-20230922
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1341433875; Fri, 22 Sep 2023 15:21:21 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Sep 2023 15:21:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Sep 2023 15:21:19 +0800
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
Subject: [PATCH v6 16/16] dt-bindings: display: mediatek: padding: add compatible for MT8195
Date:   Fri, 22 Sep 2023 15:21:16 +0800
Message-ID: <20230922072116.11009-17-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230922072116.11009-1-moudy.ho@mediatek.com>
References: <20230922072116.11009-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.605700-8.000000
X-TMASE-MatchedRID: GIpmbigRs3YmeoNhEXvE7G2o1QHNgyqmTJDl9FKHbrmYBF1C0J2QPjQz
        47GqDWjpxMujmXyGahWAMuqetGVetiVvu9chHp+mavP8b9lJtWr6C0ePs7A07UngwKs5Oejndfs
        EYn95p1jMEhTpea+dDIkuQ3d6HWsPu1Ii4zlP1MS5oVd3QmEYa8O/L+lMgFvnZq/fVZQlgjNDSz
        XF+Fvp08SXKPXaAS7AdmtRsRmKkASJZPT2ZDPuzPD2QfzMDLjhIh26TkmSN3fAvpLE+mvX8g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.605700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: A2674B259BDA25597753A9CF5C6B203C700B88EA8905DFC3C85DC3BD0E88977D2000:8
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for the PAD block in MediaTek MT8195 that
is controlled by MDP3.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../bindings/display/mediatek/mediatek,padding.yaml           | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
index db24801ebc48..636b69133acc 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
@@ -20,7 +20,9 @@ description:
 
 properties:
   compatible:
-    const: mediatek,mt8188-padding
+    enum:
+      - mediatek,mt8188-padding
+      - mediatek,mt8195-mdp3-pad
 
   reg:
     maxItems: 1
-- 
2.18.0

