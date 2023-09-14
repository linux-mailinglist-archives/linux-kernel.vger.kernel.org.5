Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD0979FB55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjINFwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjINFwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:52:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB89C6;
        Wed, 13 Sep 2023 22:51:57 -0700 (PDT)
X-UUID: cbe2beb052c211ee8051498923ad61e6-20230914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XktwoFmEl+lkK+mPUsbdG5q4GIhGBLcSDrHiFJ9BnaI=;
        b=UoG0yCvg9ZQ8MIuU5WTXv21bPBGECKWsQGqdKAnM1o2aEzAiTCC85gSZ4MXpC6e/2W19Ki+RLPqZSLBTJMJ1b+9pxNmBPS0CtX7chLHUm0Z5g7HfBdskY/N0jb66il4B7pAnoJO8boGlJglqHqAtbqU1BjFMfR+lWty45/1yu9M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:b4a1fc1e-f9b9-4e64-bd0d-8969b80b19f7,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:0ad78a4,CLOUDID:27b0aeef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cbe2beb052c211ee8051498923ad61e6-20230914
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2082722401; Thu, 14 Sep 2023 13:51:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Sep 2023 13:51:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Sep 2023 13:51:47 +0800
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
Subject: [PATCH v8 1/2] dt-bindings: arm64: mediatek: add mt8395-evk board
Date:   Thu, 14 Sep 2023 13:51:44 +0800
Message-ID: <20230914055145.16801-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.406900-8.000000
X-TMASE-MatchedRID: lpk7+cih7u/q1YwE48CuWzujYXrbVGSb+Gz435tISEEVhrI1wflQjFRE
        vM+xXlqD6fGu170eFKvy7+YHWQ1L0aXzgcphDfm8dARARTk4h58Tc3GwbO2sy9zOQo7mTgA+z5z
        AIum8OcQIT+/jqQ4Nat/mwzNqfNY58oWuLhK0Tf0D2WXLXdz+AX0tCKdnhB58I/9UW5M5dRMLky
        6aORxHNY6HM5rqDwqtYx92y2IPTjRTTCPM7kqwGZPdI+n5+nlkqLD4oqjfsuK97bCqjq1IxqJcT
        oeDNRQPKQZCV/5LXE98mXaK+7yQBPiL9NazHms+4sOrsb4iT/K/bbEolHIgZUOc7GjOamnWv5a9
        cmIodEspRnLV2kwrLg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.406900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 990BFE8136E2808AD8C50A134398F14273A999608EED9E7DB16F26BAB8DEEB3F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add compatible for MT8395.
2. Add bindings for the MediaTek mt8395-evk board, also known
as the "Genio 1200-EVK".

The MT8195 and MT8395 belong to the same SoC family,
with only minor differences in their physical characteristics.
They utilize unique efuse values for differentiation.

The booting process and configurations are managed by boot
loaders, firmware, and TF-A. Consequently, the part numbers
and procurement channels vary.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
 1 file changed, 5 insertions(+)

Changes for v2:
 - add more detail description for mt8395.
 - add bindings for mt8395, and mt8395-evk.

Changes for v3:
 - add back bindings for mt8195 compatible.

Changes for v4:
Changes for v5:
Changes for v6:
 - No change, update Reviewed-by tag only. Thanks.

Changes for v7:
 - Drop description which used by multiple boards.

Changes for v8
 - Drop "dts: " in $subject by Conor's suggestion. Thanks.

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index ae12b1cab9fb..de1a41a68f5d 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -248,6 +248,11 @@ properties:
           - enum:
               - mediatek,mt8365-evk
           - const: mediatek,mt8365
+      - items:
+          - enum:
+              - mediatek,mt8395-evk
+          - const: mediatek,mt8395
+          - const: mediatek,mt8195
       - items:
           - enum:
               - mediatek,mt8516-pumpkin
-- 
2.18.0

