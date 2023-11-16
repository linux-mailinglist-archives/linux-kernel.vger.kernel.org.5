Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9F67EDF26
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbjKPLFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjKPLFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:05:08 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11E8D68;
        Thu, 16 Nov 2023 03:04:58 -0800 (PST)
X-UUID: f77b8122846f11ee8051498923ad61e6-20231116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0Ilth5/ml3BcwAlDzYOZhC1QcQ8Nl7amXfdm70cmsFs=;
        b=fpZ3lmp0+bvgL892nZ5IGe1H2o+9Gu99Fptc6Jv145rRlqoErEHyVNCCrWS7X231Bm4jaIdZNWDh7B7ZB50vr3q+br9zs0szokOE/znbWJNL2f1PwHAQVfrS/WOuyWX8WoAyX3vtiQeOaMk8JejmXipwJSzMvSzafJI0Cm3Mgf8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:edec14d6-afc7-4488-99f6-45cca4cfa66c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:21b42260-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f77b8122846f11ee8051498923ad61e6-20231116
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 914367294; Thu, 16 Nov 2023 19:04:52 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 16 Nov 2023 19:04:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 16 Nov 2023 19:04:50 +0800
From:   Mark Tseng <chun-jen.tseng@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <chun-jen.tseng@mediatek.com>
Subject: [PATCH v2 3/3] dt-bindings: soc: mediatek: add mt8186 and mt8195 svs dt-bindings
Date:   Thu, 16 Nov 2023 19:04:47 +0800
Message-ID: <20231116110447.3598-4-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231116110447.3598-1-chun-jen.tseng@mediatek.com>
References: <20231116110447.3598-1-chun-jen.tseng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.474800-8.000000
X-TMASE-MatchedRID: qaEF7sysRdbHCChNBbZThQPZZctd3P4BfS0Ip2eEHnwj/1Rbkzl1E95/
        HgWYxplM5MIx11wv+CPKayT/BQTiGijkRB+q9uV+zy8CehqGChcZFyQzNomHSPw3dlYD1EcdbIw
        NL10fUKRHHh78pbcuPOJbiTiJZfShnIItpVenOepwSFus9SMLZKDE4wLr4uZ8dATQdtPksR+3/J
        iWOe6GXXSWgQ2GpXdZhztLVWA1eE9DDKa3G4nrLQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.474800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 2900993E6A7A7315122D62FB8CF6B5365F34A2DCA102FD1D6EA2428A43DA99852000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support more SoC svs compatible in dt-bindings.
1. MT8186
2. MT8195

Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
index 7eda63d5682f..742b91d1d28e 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
@@ -22,8 +22,10 @@ properties:
   compatible:
     enum:
       - mediatek,mt8183-svs
+      - mediatek,mt8186-svs
       - mediatek,mt8188-svs
       - mediatek,mt8192-svs
+      - mediatek,mt8195-svs
 
   reg:
     maxItems: 1
-- 
2.18.0

