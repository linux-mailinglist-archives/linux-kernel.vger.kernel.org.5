Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3C57F6C93
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343940AbjKXHJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKXHJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:09:06 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157E9D73;
        Thu, 23 Nov 2023 23:08:55 -0800 (PST)
X-UUID: 5027d3b08a9811eea33bb35ae8d461a2-20231124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ucv5SkaPMyQeyclM1BmQvoovqtCfyR4/Dim+QgBHR1o=;
        b=VxqIVKdEubNRAiNV6Wh2gZcuNNU45Kx+CqV7exlVNKARHV8q6Pd1eED17au59VCuIg25SemqGcqi0fgFBVstFAt7D/rYLzHMYDpp6W5QZn3ZpYObVHGJYTZenzzMJ1nFZjh2DZSSWQcSJ1wZxVXYZ/4g/H/qa9YVXlu+73Pu0DY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:c4da0c24-fde7-4f50-85e5-3cf1f87637d7,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:ee596e60-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5027d3b08a9811eea33bb35ae8d461a2-20231124
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1285014261; Fri, 24 Nov 2023 15:08:47 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 24 Nov 2023 15:08:46 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 24 Nov 2023 15:08:45 +0800
From:   Axe Yang <axe.yang@mediatek.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Wenbin Mei" <wenbin.mei@mediatek.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Axe Yang <axe.yang@mediatek.com>
Subject: [PATCH v1 2/2] dt-bindings: mmc: mtk-sd: add 64-steps tuning related property
Date:   Fri, 24 Nov 2023 15:08:39 +0800
Message-ID: <20231124070839.12484-3-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124070839.12484-1-axe.yang@mediatek.com>
References: <20231124070839.12484-1-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.449000-8.000000
X-TMASE-MatchedRID: iSQL5szRvdEWnPlK0Y8cfo4V8tCoXo/ShV0srjoqtx/1yFIyxT4nyxJ4
        B8fZD6Dx7p17JCLIX7cfSuixqQMLLLvhKf49TtYAbBu6+EIezdyZf5btvM85AQ6QlBHhBZuw9BQ
        FWu9qPYararPPtIvi4m9yZj3aufb5HxPMjOKY7A8LbigRnpKlKTpcQTtiHDgWBpMM+r6atzvo8X
        R0jECZh16xAW23XWT/308PTuSCsS/VQpeWxO19jEMMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.449000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 4C2FCFED837D2B2B439CA89CB93E6C99526F618A8D15075F1ED0FF75C59294CD2000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'mediatek,tune-64-steps' option. This property will give MSDC
a chance to achieve a more optimal calibration result, thus avoiding
potential CRC issues.

Signed-off-by: Axe Yang <axe.yang@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 3fffa467e4e1..c33301e2ea33 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -145,6 +145,14 @@ properties:
     minimum: 0
     maximum: 7
 
+  mediatek,tune-64-steps:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Some Soc need enable 64-steps tuning for better delay value to avoid CRC issue.
+      If present, tune 64 steps to cover a complete clock cycle.
+      If not present, tune only 32 steps. For eMMC and SD, this can also yield
+      satisfactory calibration results in most cases.
+
   resets:
     maxItems: 1
 
-- 
2.25.1

