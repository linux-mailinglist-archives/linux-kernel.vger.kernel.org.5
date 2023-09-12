Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4B279D333
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbjILOGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjILOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:06:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CE310D0;
        Tue, 12 Sep 2023 07:06:24 -0700 (PDT)
X-UUID: 8b8ccdd6517511eea33bb35ae8d461a2-20230912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rNgLa+HhSNZr9Hjy39soCUFNOV2RX95rmgWgPtyQNEQ=;
        b=kwGQgt17GkFS8Y84rpG9K7rbs8wL+AAWPh/VPYLbGCLl5LlQaBvkhjaNwz+S/nEhe2h4O0/ygJtyMxyICw37dK8pekx7hLgFccVgdBDjrez8SFHwZ07/JJvoyBg7o4xhxjsy/QtDf+REpbDxuaIXbaC1X2V9ZYrgKiD2d6M9SLQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:4073fd3b-abfb-418c-aa3a-46fa68ccfe42,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:224fc0be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 8b8ccdd6517511eea33bb35ae8d461a2-20230912
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 200188691; Tue, 12 Sep 2023 22:06:18 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Sep 2023 22:06:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Sep 2023 22:06:16 +0800
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
Subject: [PATCH 1/2] dt-bindings: arm64: dts: mediatek: add mt8390-evk board
Date:   Tue, 12 Sep 2023 22:06:12 +0800
Message-ID: <20230912140613.6528-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.599100-8.000000
X-TMASE-MatchedRID: wDTc/wNgEcPq1YwE48CuWzujYXrbVGSb+Gz435tISEEVhrI1wflQjFRE
        vM+xXlqD6fGu170eFKuyRoa4j2Wmwl0ieHN50/kHGVyS87Wb4lxMK/nxnH1Imt9RlPzeVuQQgUU
        VL8XjqG1MBruKEpUm1YAy6p60ZV62rpt78afcDNfdB/CxWTRRuwihQpoXbuXFYGD0jtQn7uY4k+
        tw8+90FWv7iqfaN5JJ8IcYCFSkrV+H3NS75geVYsvXQ70MBOo/sGmU/3v9/UDy5NNKxZqzmBRRg
        vUvjjq9aaeeX2Q5bK9+HGPweyal2mGdUezV59DHQZpgl3CshRSeqD9WtJkSIw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.599100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: CA750230478EBDA7B5581D811481455AAC4A8857A58B2B196E3FF117102DCEB02000:8
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
 Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

dependencies for v1:
 - This patch should be applied after the following patch set
  - mt8365's bindings
   - https://lore.kernel.org/linux-arm-kernel/20230912092444.31635-1-macpaul.lin@mediatek.com/T/
  - mt8395's bindings
   - https://lore.kernel.org/lkml/20230911115717.26184-1-macpaul.lin@mediatek.com/T/
  - mt8188's bindings
   - https://lore.kernel.org/lkml/a4e1a80ebd19896410f50b0297e05dce06fb47cc.camel@mediatek.com/T/

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index d8e449c6a7d7..047204a4aff5 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -251,6 +251,12 @@ properties:
       - items:
           - const: mediatek,mt8365-evk
           - const: mediatek,mt8365
+      - description: MediaTek Genio 700 Boards (Genio 700 EVK)
+        items:
+          - enum:
+              - mediatek,mt8390-evk
+          - const: mediatek,mt8390
+          - const: mediatek,mt8188
       - description: MediaTek Genio 1200 Boards (Genio 1200 EVK)
         items:
           - enum:
-- 
2.18.0

