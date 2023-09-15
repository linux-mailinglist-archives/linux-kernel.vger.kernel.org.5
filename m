Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5ED7A2256
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbjIOP1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbjIOP0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:26:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C0C10CC;
        Fri, 15 Sep 2023 08:26:34 -0700 (PDT)
X-UUID: 3d60e07a53dc11ee8051498923ad61e6-20230915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gEKcGfOdbb/ypCFeWjMTerPJybqZBvAl/dHd3Jy2NTQ=;
        b=IKacZjHqLF2RYa5DVWiUprUMOkA2SPjskE5sRpKzbYoVOOuOHFmJOkmjMO5GBjGAXIiW2PAILqpm5H2s1RaGjYtUQquXsET5MyhRYYopNT+6tYATLTlERzZa5pU4pukD5+OQeHF+U+XjSFowxfeuJlYIthst77CMWew5DRNnk5U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:4d170fa3-a3a7-401a-8843-e07ab91ff1ca,IP:0,U
        RL:25,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:7ee313c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 3d60e07a53dc11ee8051498923ad61e6-20230915
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <william-tw.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 268018361; Fri, 15 Sep 2023 23:26:28 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Sep 2023 23:26:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Sep 2023 23:26:26 +0800
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
Subject: [PATCH v2 3/3] dt-bindings: hwinfo: Add mtk-socinfo driver
Date:   Fri, 15 Sep 2023 23:26:07 +0800
Message-ID: <20230915152607.18116-4-william-tw.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230915152607.18116-1-william-tw.lin@mediatek.com>
References: <20230915152607.18116-1-william-tw.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.957100-8.000000
X-TMASE-MatchedRID: v6XyZOeCJ6AQKuI1NEGZQXew7fOv9rv4/oVxXwNIskffUZT83lbkEEd0
        Rzx07LDVnD3AxwqeC/rkllaluas5jhhzK7qAlTSLGVyS87Wb4lxh59nsX2QuC9zOQo7mTgA+B/o
        dLTuYYLIlCUygZetDZEw3m0nPdhDkQF24kZp9Ww+eAiCmPx4NwJuJ+Pb8n/VxLzP5snaeb1Qqtq
        5d3cxkNRqXnrxrKCOXNyXiktngl2+lBw28bqWvBSjlogU60mUGrOK2X7HwMosh2LyHk3j0fbb1y
        JyFMGW7fTAUk3BtRD0d/NlE8oyWLLgVDf+0/00JF0aD5ljt43pMcHZD6gqu7wxMjfifIXfowkvV
        oA11Twp+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.957100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 4F5FBE3B3D86B8BE0E3CEF07A5A469906665476C1D1E64B6B9808915176020262000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
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
 .../bindings/hwinfo/mtk-socinfo.yaml          | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml

diff --git a/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
new file mode 100644
index 000000000000..74f03f1dc404
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwinfo/mtk-socinfo.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwinfo/mtk-socinfo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoC ChipID
+
+maintainers:
+  - William Lin <william-tw.lin@mediatek.com>
+  - Matthias Brugger <matthias.bgg@gmail.com>
+  - Kevin Hilman <khilman@kernel.org>
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description:
+  MediaTek SoCs store various product information in eFuses, including
+  Chip ID and Revision fields, usable to identify the manufacturer,
+  SoC version, plus segment and marketing names.
+
+properties:
+  compatible:
+    const: mediatek,socinfo
+
+  nvmem-cells:
+    maxItems: 2
+    description: Phandle to nvmem cells containing SoC identification data
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
+        socinfo {
+            compatible = "mediatek,socinfo";
+            nvmem-cells = <&socinfo_data1>, <&socinfo_data2>;
+            nvmem-cell-names = "socinfo-data1", "socinfo-data2";
+        };
+
-- 
2.18.0

