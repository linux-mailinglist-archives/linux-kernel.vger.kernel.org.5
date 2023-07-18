Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035BB757A55
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjGRLWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjGRLV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:21:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B04BE8;
        Tue, 18 Jul 2023 04:21:58 -0700 (PDT)
X-UUID: 4c2ae040255d11eeb20a276fd37b9834-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FFdnLI10SYOIFcwMRjs55L6+be52n5AbFQ2Gw8StAjo=;
        b=dmYK94FF1qR+OYgKdQ8eqN8D/9eqc5ky4Unz/8QwqA4+pCw27PccyLPpPH7q5YMoCuEjvcXF2vtKuy/MuTcEgvggLhI/rIs+Jur8PJIBg/LqpBINT3iFSBfdn8z/NU+ed9P7HBLs1LVf0kyeKBy+Ca6/H2RQUNyjDJ0wLUHBQ5M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:7f57e5f7-1434-4081-8217-d25933b47e95,IP:0,U
        RL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:20
X-CID-META: VersionHash:176cd25,CLOUDID:6f6ecc8e-7caa-48c2-8dbb-206f0389473c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4c2ae040255d11eeb20a276fd37b9834-20230718
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <william-tw.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1268309920; Tue, 18 Jul 2023 19:21:53 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 19:21:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 19:21:52 +0800
From:   William-tw Lin <william-tw.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        William-tw Lin <william-tw.lin@mediatek.com>
Subject: [PATCH 2/3] dt-bindings: soc: mediatek: Add mtk-socinfo driver
Date:   Tue, 18 Jul 2023 19:21:42 +0800
Message-ID: <20230718112143.14036-3-william-tw.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230718112143.14036-1-william-tw.lin@mediatek.com>
References: <20230718112143.14036-1-william-tw.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dt-binding documentation for mtk-socinfo driver.
mtk-socinfo driver provides SoC-related information.
Such information includes manufacturer information, SoC name,
SoC segment name, and SoC marketing name.

Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
---
 .../bindings/soc/mediatek/mtk-socinfo.yaml    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-socinfo.yaml

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-socinfo.yaml b/Documentation/devicetree/bindings/soc/mediatek/mtk-socinfo.yaml
new file mode 100644
index 000000000000..4420430a9bca
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-socinfo.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mediatek/mtk-socinfo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SOC information
+
+maintainers:
+  - William Lin <william-tw.lin@mediatek.com>
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Kevin Hilman <khilman@kernel.org>
+
+description:
+  The MTK socinfo driver can retrieve several
+  SoC related information based on settings in eFuse.
+  Such information include manufacturer information, SoC name,
+  SoC segment name, and SoC marketing name.
+
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8173-socinfo
+      - mediatek,mt8183-socinfo
+      - mediatek,mt8186-socinfo
+      - mediatek,mt8188-socinfo
+      - mediatek,mt8192-socinfo
+      - mediatek,mt8195-socinfo
+
+
+  nvmem-cells:
+    description:
+      Phandle to the eFuse data for SoC differentiation.
+    items:
+      - description: eFuse data that mtk-socinfo driver uses for SoC differentiation
+
+  nvmem-cell-names:
+    minItems: 1
+    items:
+      - const: socinfo-data1
+      - const: socinfo-data2
+
+required:
+  - compatible
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+        mtk_socinfo: socinfo {
+            compatible = "mediatek,mt8186-socinfo";
+            nvmem-cells = <&socinfo_data1>;
+            nvmem-cell-names = "socinfo-data1";
+        };
+
-- 
2.18.0

