Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B0479DEDF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 06:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbjIMEFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 00:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjIMEFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 00:05:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BB41727;
        Tue, 12 Sep 2023 21:05:03 -0700 (PDT)
X-UUID: b117c71651ea11ee8051498923ad61e6-20230913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=z3Yjahx9vU9QnGy7ZpITb4HawIlKK3wiRM4IUKhA0R8=;
        b=nnmlBPqexpx3kkBVNlNDuLWYyDCc4VKF86tVSXhAEXqq3KxgusdzLVqSw6NaIFo30uTsxMHNPQ840QcFAbmxRubcdlF4D2LqZiCboV55E3mPSWDN8K8FAfqEEG7J8zGP6DvFKvcDvdr+OPIsApMZ17iLwkzNiayNVAe+E7win1U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:20e1bade-7354-4e63-aeb5-2bfd486cf13b,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:e00bc6be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: b117c71651ea11ee8051498923ad61e6-20230913
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 48298237; Wed, 13 Sep 2023 12:04:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Sep 2023 12:04:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 13 Sep 2023 12:04:51 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: arm64: dts: mediatek: add mt8390-evk board
Date:   Wed, 13 Sep 2023 12:04:48 +0800
Message-ID: <20230913040449.29560-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.797300-8.000000
X-TMASE-MatchedRID: iSQL5szRvdHq1YwE48CuWzujYXrbVGSb+Gz435tISEEVhrI1wflQjFRE
        vM+xXlqD6fGu170eFKuyRoa4j2Wmwl0ieHN50/kHGVyS87Wb4lyy4iyjvVWTotzOQo7mTgA+kpS
        2cE3ZkFJ3I1qXcZvalI3p8NudO7SfHxPMjOKY7A/x0Der+6P8v8RB0bsfrpPInxMyeYT53RlhpP
        cp3TMWK+2s+KtXCAx7gm8QSCiqkQpWj+qkP0Qxr/6179No8WMQNvoFzIxcNi/vyKh2wp2o+Lpa2
        pwQg/QX1rLo/RSaKNkc/j4aI5S1Lnr9GD0zfOvEAaqvv/mhgrEIcy9ODq9nmVZca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.797300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 79149F659C9303CA7F43BCC1F7E2ED36479B43A947522AEAA44550B8A3F5B4922000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add compatible for MT8390.
2. Add bindings for the MediaTek mt8390-evk board, also known
as the "Genio 700-EVK".

The MT8390 and MT8188 belong to the same SoC family,
with only minor differences in their physical characteristics.
They utilize unique efuse values for differentiation.

The booting process and configurations are managed by boot
loaders, firmware, and TF-A. Consequently, the part numbers
and procurement channels vary.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
 1 file changed, 5 insertions(+)

dependencies for v1:
 - This patch should be applied after the following patch set
  - mt8365's bindings
   - https://lore.kernel.org/linux-arm-kernel/20230912092444.31635-1-macpaul.lin@mediatek.com/T/
  - mt8395's bindings: v6
   - https://lore.kernel.org/lkml/20230911115717.26184-1-macpaul.lin@mediatek.com/T/
  - mt8188's bindings
   - https://lore.kernel.org/lkml/a4e1a80ebd19896410f50b0297e05dce06fb47cc.camel@mediatek.com/T/

Changess for v2:
 - drop description for multiple boards
 - update dependencies with the following patch sets
  - mt8395's bindings: v7
   - https://lore.kernel.org/linux-arm-kernel/20230913032057.3197-1-macpaul.lin@mediatek.com/T/  

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 0248bb458180..3968d5934fa2 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -252,6 +252,11 @@ properties:
           - enum:
               - mediatek,mt8365-evk
           - const: mediatek,mt8365
+      - items:
+          - enum:
+              - mediatek,mt8390-evk
+          - const: mediatek,mt8390
+          - const: mediatek,mt8188
       - items:
           - enum:
               - mediatek,mt8395-evk
-- 
2.18.0

