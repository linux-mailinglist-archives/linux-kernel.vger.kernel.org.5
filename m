Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D137F3227
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjKUPRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKUPRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:17:48 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2073.outbound.protection.outlook.com [40.107.117.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5636410C;
        Tue, 21 Nov 2023 07:17:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/JHQGiRNBCEF82+ClkeK9nQEBLnp5F8a2VJJ8SHO/b+YpnYKBNFSvEf8YC7ZpWBDoGTwzMbGT40YJQiHwzUW54EzC1lTzUYM/motTA4uhtcZWNRFplXaB+0NPQgg1Pe5ywBgg54xdStlFvq1yX42e2A1WgYXeGS4LI2PZg2UIlgrTjIPEuRH9DZu4IIx/ouwoMdNSwl/9ciUlyefAf4lbX2D44Wds7t1wPU5JXLzFtiJro1vnUW/iGq00Z2xE2c1UgqBXPkIZ4L41p8pqCoi5gN2zigQYmbeL39ddJtGwZgYFGn7jAI/mfuBiJ1H3Drt6B9fVJDxaoohH9dIrxTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bYMlNrJC8z7wsD7AY1RL+6SbJo0K0vixD3e97989V4=;
 b=mG4jQ1w4Z1eUizMn/4jkqv7cc3rR7dANLg1Lyg3pfoXODHI8ZYDVH+HR1S+7bmVooA0yVknt57A99hRcWonEYF/K8ssSOeBLkPzYwr0ZJV//zRAApBHKVZJcq+Vj5botvASQzy/deIJAGDKHVvqNmakhon7gOnzK4IT9MAFjghevMuX/MpRcTsVIPxSOYuqz3VtmJEkTY+7m/exFnV4x0Nqms/2YQMrMlEc2mMq9OVNm6lkonVsnwPZOMREn7x1CV5IgRG47wVeTOOADrB2IlwU7AzWuvtyHbyG6TUwoiD1Hg5L/SB4WKghUsgSAX2pdDZJSWOSY8Z6ZKWVHaHPjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nuvoton.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bYMlNrJC8z7wsD7AY1RL+6SbJo0K0vixD3e97989V4=;
 b=Vdkdo9LEXmTWZkpaU98iQR0StyejQr3zWtPzrWGRBsNCngUBo+5gUvZfjha5jWaL/rFce6HoFWwtIwGYI91jC1eheDkh5NlbkWXt5ButNlLOk/vfoaaag9kJUc/3oAIynGg5Kawvy0jOTKAYiRT4QgtnzuQJAGMhCRMrwl0s09c=
Received: from SG2PR04CA0214.apcprd04.prod.outlook.com (2603:1096:4:187::17)
 by SI2PR03MB5531.apcprd03.prod.outlook.com (2603:1096:4:126::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 15:17:40 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:187:cafe::4e) by SG2PR04CA0214.outlook.office365.com
 (2603:1096:4:187::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 15:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 15:17:39 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 21
 Nov 2023 23:17:38 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Nov 2023 23:17:38 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id BD5805F63D;
        Tue, 21 Nov 2023 17:17:36 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 50B72235CE25; Tue, 21 Nov 2023 17:17:36 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>, <peppe.cavallaro@st.com>,
        <joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
        <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: net: Add support NPCM dwmac
Date:   Tue, 21 Nov 2023 17:17:32 +0200
Message-ID: <20231121151733.2015384-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231121151733.2015384-1-tmaimon77@gmail.com>
References: <20231121151733.2015384-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|SI2PR03MB5531:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf72705-85d7-41a8-ecab-08dbeaa50033
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhycYkGzp1IQg2JdEqlGIXm8L/S0BphKbxDxCTfrULdx3375rA47PZB9lGsjhHPmMC5PcLTdx2+lXQTrcMAdn7oSKi1Mhf25SRKI22jLhD4qLELgqMQn8usui/LGUjNEAqCaUhhLvDsXhoC6OJNe0BujJoOCFWhO24CYrfbs9mujnX2rjYNGoJjLydxx4NQ+AQkNRTb4Zbj1jdEzD61n8+51SxeT8oo2a9s4lypMU/MujaUUqEFdvoLXZIGG7iD3v75vjzX+79bJpIkRIIz1tEmnqJkTwO3tGCGVmPvnBKLh6HtjE1rK6hheI9smX9p17c9pjUkPxSCsLkBUBKlgcnj3mrKLbouvyOqNNjv0IRZlavbmc/5GVnySX4+IY5GRAPnqWJwFcylptqSORoIKOIEtMpt2bOc9afksHvAxac0X4QyleuAF8YywGYEeNNihb2hLHfYWz8jULvlAZL3Y85gN2/YvVgUCkjPmeiR1jFOkRRDYdSjxJ/tUVrMYZtLdDMNyTEWrJ/MsNiAV8PflIdoefYAOl1MVX3a0d1GtAB9GcZiPoibP/yfIexQKWpQ/uWCNmGoz5Y7jsud3A3UyoWBx4VWwJnLKLtjugC9dpq+r6H9YUK1Mtp4og18EgwGXCf/tBSCrjZN72GUgICZiDsnGWchpoY9T0NDhv+mXSF21OBAiyMpFN9T29kS4q6l4QTiLOBPIb+j/bQa4YGIG/14svmLKLWvFr+8p+xlPuW38pqj+yjzilPF5+n9dB4V2kWMxl3XTrTgmrQCU6vvNpqrLxyxRI2Lw6ztLaNf182M8Mf6/4O+NZHPS4I7iQ2cuDVAcdaVvzTRdY2ovt6466bA7PTDqsegXmhmyv0PvX2bOjWVGBrv376xj/1hQ1Ghh6FtWH0NoGhu97e4HsmXbXQ==
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(61400799012)(48200799006)(36840700001)(46966006)(40470700004)(336012)(1076003)(2616005)(26005)(6266002)(478600001)(6666004)(42882007)(47076005)(36860700001)(73392003)(82202003)(83380400001)(7416002)(2906002)(4326008)(5660300002)(41300700001)(8676002)(110136005)(76482006)(70586007)(42186006)(54906003)(70206006)(966005)(8936002)(316002)(356005)(81166007)(921008)(82740400003)(83170400001)(36756003)(55446002)(40460700003)(40480700001)(45356006)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 15:17:39.5869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf72705-85d7-41a8-ecab-08dbeaa50033
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5531
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Nuvoton BMC NPCM dwmac driver(sgmii).

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/net/nuvoton,npcm8xx-sgmii.yaml   | 72 +++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,npcm8xx-sgmii.yaml

diff --git a/Documentation/devicetree/bindings/net/nuvoton,npcm8xx-sgmii.yaml b/Documentation/devicetree/bindings/net/nuvoton,npcm8xx-sgmii.yaml
new file mode 100644
index 000000000000..6a5f2cade7c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nuvoton,npcm8xx-sgmii.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nuvoton,npcm8xx-sgmii.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM DWMAC SGMII Ethernet controller
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - nuvoton,npcm8xx-sgmii
+  required:
+    - compatible
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - nuvoton,npcm8xx-sgmii
+          - const: snps,dwmac-3.50a
+  reg:
+    items:
+      - description:
+          The first range represent DWMAC controller registers.
+      - description:
+          The second range represent PCS configuration registers.
+
+  clocks:
+    items:
+      - description: GMAC main clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,npcm845-clk.h>
+
+    ahb {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      gmac0: ethernet@f0802000 {
+          compatible = "nuvoton,npcm8xx-sgmii","snps,dwmac-3.50a";
+          reg = <0x0 0xf0802000 0x0 0x2000>, <0x0 0xf0780000 0x0 0x200>;
+          interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+          interrupt-names = "macirq";
+          clocks = <&clk NPCM8XX_CLK_AHB>;
+          clock-names = "stmmaceth";
+          phy-mode = "rgmii-id";
+      };
+    };
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5c2769dc689a..ba52dbc85144 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -66,6 +66,7 @@ properties:
         - ingenic,x2000-mac
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
+        - nuvoton,npcm8xx-sgmii
         - qcom,qcs404-ethqos
         - qcom,sa8775p-ethqos
         - qcom,sc8280xp-ethqos
-- 
2.33.0

