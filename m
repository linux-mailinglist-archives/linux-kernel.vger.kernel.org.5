Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ECD78B2AA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjH1OJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjH1OJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:09:11 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2058.outbound.protection.outlook.com [40.107.255.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6F8113;
        Mon, 28 Aug 2023 07:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3lq7yvhU+7I+l7xvreW3ddPKS0RMvYVIoXgIQ9aoOajV3gRl9JHpnIRt20jw0KPPgddI1HAOmVdwB9bwkMwf6fk2BHMC8pb7NZPjmvpSrIa6JrzGoUNo7jamDxgI4eFfEiT5WQ3VRNE/TM+fPbWsPiuaFJlSrNf0KarYtc/2LC5MON/TzEQ6K93JD/3o0JFGjdyvw4qBv35sdEYwntSV4Z+WtclFxeYoETauqlWrZ87GXkxEWk8j8n6bRk5X3LZW7QMpZcXWCpLqj293xqY2fmuhvRoIV+6+3Vc4xlTnwMdTTp4iNsHs+X9zLFTjAw9+Ha4ZqKsbf4ow4HvCqywyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11m/X9kIMuNM1PtGRcoGQQp8unapmTIv+9LacjFx58c=;
 b=aEPWBUi1gU0Fjv1C3Y4BmIecXH1VrG//GZOLEHmQO9EDxLPTiOIA5JfedLFM8+LfjWR4zRde2kLTtuT1oSJ0D406Jv9hGyhLK+xaFz0T3XjCjAvpnA8Yiy/sVX+rIWcpWTWK/DKtxy4sjdONSIQW1YBHSPLlTYSoZnnwnedTjDpEScggU3lG+eXG0/85EA8g+hhe8J/XPVyqu1u+VXACT5XU4ITVxtZbtKVNU4XqE1edEhTdXSXpyhbIXyl9iwJjwrvpPtQruvOfQYA2Od7UZ0sgKsEQRUQzaeAyezAK3C9E3Jp5bJaZeZSTG6q7WpPoN2ZkfsGeUOJ0uJ0Ak8Mgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11m/X9kIMuNM1PtGRcoGQQp8unapmTIv+9LacjFx58c=;
 b=LwwfrSs/ZjL9BjOQkLmJWfvfzmzraiizLeY3OTZuBgucDDWrnMGatd6OtTKNxITieFpGSxRlfGBxNrSryNXDoNkWgOUjAuIDRSLqMNJGlGrPkgMzrgkKlx9vke5E9aT5IP/RUE9s5vFXFNtobSI/49hbd5dU2gS97oVESMHzd5Y=
Received: from SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26) by
 SEZPR03MB7374.apcprd03.prod.outlook.com (2603:1096:101:12d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:08:54 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:1:cafe::57) by SG2PR06CA0194.outlook.office365.com
 (2603:1096:4:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 14:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 14:08:53 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Mon, 28
 Aug 2023 22:08:51 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 28 Aug 2023 22:08:51 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 44E0064741; Mon, 28 Aug 2023 17:08:51 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO documentation
Date:   Mon, 28 Aug 2023 17:08:48 +0300
Message-ID: <20230828140849.21724-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230828140849.21724-1-tmaimon77@gmail.com>
References: <20230828140849.21724-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|SEZPR03MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a175351-6b7d-4cb3-b85b-08dba7d04f95
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tFXp/f6JkohcZmeW0tQAjjPeT/NCd75tcDfZBo2fkKWWoiPhkLij+nQKXRWN?=
 =?us-ascii?Q?i4saQO8GzYiKxKjCNHYctdbndNeNGspMjj0EEkCBdrtb1LN1w8mViEIgSMQm?=
 =?us-ascii?Q?brakVQ6VCLzKL9GMFqN1/fnMksngl1okxFlm0vKumfqRzKodmEhI5KyN765g?=
 =?us-ascii?Q?hGVJltbhXnK9GSwFTS0mpPB/GpHl81NVaIamqrVRmitjEAShTk9jIDve60+n?=
 =?us-ascii?Q?hBIGfIKvyHM8X9WflJYOSnsuvApvusqI7g01vlr/kxnxCL0d/DoDAqGVnMtT?=
 =?us-ascii?Q?9nE/6eC1gDp/i42Ip/BOebY+5qDffutwoFIp3oj/ZXePdxvbkGrDutr9xRBi?=
 =?us-ascii?Q?uwR6WDJS4RWt43zYBN2lpYC5nq35L0isv973OCG6bSpqVQuxJrNSX3otzatm?=
 =?us-ascii?Q?2I9K905yaMHjAWkwwtkmNzjf/GTFSd9CZ1c7KYdyYm1Kf6eIDleRZ8oXVgAA?=
 =?us-ascii?Q?kZj5EBC3fHHlPAJHRPAOKtm9mZYaZc1Bc8ZmXHfmsb1boxgJ22chKhLgvJ+6?=
 =?us-ascii?Q?fVyxVpHwx0Dt+SWZGeavD4NlutU9s6uiU3YywTFhPcKp7P3cYHIro7vcaPCH?=
 =?us-ascii?Q?JM/QnBTf36fPGQNzjjfKTMgjalUhIRbyevG0+6ABRV5hEA1IoUP82lRIzHQ0?=
 =?us-ascii?Q?y23iqHDx2+sC+3+MFpQtunB7WEf5zK9yVpxGlhFC8C622CO8UzPcauFOmXFF?=
 =?us-ascii?Q?PdmHZd7sRI66V/z93pIPMfoWxoNWtRPiiRxv3GtgqHxLnoVyTVqyfO6U4WTB?=
 =?us-ascii?Q?29NIGwzCwP5WvsF6ELL0VkQhXnva8Uwp6C157/dqRt8oiasmlFaWpG4P9GaT?=
 =?us-ascii?Q?SUeji7Yb70Td+9pfRadyt6fJoFPKXvun+jt/rAkliDwChR1qIpV+BgeIetp5?=
 =?us-ascii?Q?r3xUrPqa8aohZ5+qqLzmI+bJW7dkymfGa8oxNZFiVJcFArssM7jTGGDBRdlh?=
 =?us-ascii?Q?9gFJFul6rg5qKsNIvRGfyqN6KN6jKiMNw4FKVRWrPxbYlRTM9C98E2en7oVI?=
 =?us-ascii?Q?+wwSGWP7+IQdMWjgrBbm7KXb/Rc0Mk3ONNXIUw1uatOLu0Z7A7Ps9hP8B9lu?=
 =?us-ascii?Q?5uFnd0WN?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199024)(186009)(48200799006)(61400799006)(82310400011)(46966006)(36840700001)(40470700004)(12101799020)(83170400001)(6666004)(36756003)(356005)(2906002)(55446002)(921005)(81166007)(82740400003)(36860700001)(6266002)(47076005)(40480700001)(26005)(42882007)(336012)(1076003)(82202003)(478600001)(83380400001)(70206006)(966005)(73392003)(110136005)(4326008)(2616005)(76482006)(5660300002)(70586007)(8676002)(41300700001)(42186006)(316002)(7416002)(40460700003)(54906003)(8936002)(45356006)(32563001)(35450700002)(414714003)(473944003)(357404004);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:08:53.2211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a175351-6b7d-4cb3-b85b-08dba7d04f95
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7374
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
pinmux and GPIO controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 216 ++++++++++++++++++
 1 file changed, 216 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
new file mode 100644
index 000000000000..e4b9f3da2cf0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
@@ -0,0 +1,216 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/nuvoton,npcm845-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM845 Pin Controller and GPIO
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+description:
+  The Nuvoton BMC NPCM8XX Pin Controller multi-function routed through
+  the multiplexing block, Each pin supports GPIO functionality (GPIOx)
+  and multiple functions that directly connect the pin to different
+  hardware blocks.
+
+properties:
+  compatible:
+    const: nuvoton,npcm845-pinctrl
+
+  ranges:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  nuvoton,sysgcr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: a phandle to access GCR registers.
+
+patternProperties:
+  '^gpio@':
+    type: object
+
+    description:
+      Eight GPIO banks that each contain 32 GPIOs.
+
+    properties:
+      gpio-controller: true
+
+      '#gpio-cells':
+        const: 2
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 1
+
+      gpio-ranges:
+        maxItems: 1
+
+    required:
+      - gpio-controller
+      - '#gpio-cells'
+      - reg
+      - interrupts
+      - gpio-ranges
+
+  '-mux$':
+    $ref: pinmux-node.yaml#
+
+    properties:
+      groups:
+        description:
+          One or more groups of pins to mux to a certain function
+        items:
+          enum: [ iox1, iox2, smb1d, smb2d, lkgpo1, lkgpo2, ioxh, gspi,
+                  smb5b, smb5c, lkgpo0, pspi, jm1, jm2, smb4den, smb4b,
+                  smb4c, smb15, smb16, smb17, smb18, smb19, smb20, smb21,
+                  smb22, smb23, smb23b, smb4d, smb14, smb5, smb4, smb3,
+                  spi0cs1, spi0cs2, spi0cs3, spi1cs0, spi1cs1, spi1cs2,
+                  spi1cs3, spi1cs23, smb3c, smb3b, bmcuart0a, uart1, jtag2,
+                  bmcuart1, uart2, sg1mdio, bmcuart0b, r1err, r1md, r1oen,
+                  r2oen, rmii3, r3oen, smb3d, fanin0, fanin1, fanin2, fanin3,
+                  fanin4, fanin5, fanin6, fanin7, fanin8, fanin9, fanin10,
+                  fanin11, fanin12, fanin13, fanin14, fanin15, pwm0, pwm1, pwm2,
+                  pwm3, r2, r2err, r2md, r3rxer, ga20kbc, smb5d, lpc, espi, rg2,
+                  ddr, i3c0, i3c1, i3c2, i3c3, i3c4, i3c5, smb0, smb1, smb2,
+                  smb2c, smb2b, smb1c, smb1b, smb8, smb9, smb10, smb11, sd1,
+                  sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8, pwm9, pwm10, pwm11,
+                  mmc8, mmc, mmcwp, mmccd, mmcrst, clkout, serirq, lpcclk,
+                  scipme, smi, smb6, smb7, spi1, faninx, r1, spi3, spi3cs1,
+                  spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b, smb0c, smb0den,
+                  smb0d, ddc, rg2mdio, wdog1, wdog2, smb12, smb13, spix,
+                  spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3, hgpio4,
+                  hgpio5, hgpio6, hgpio7 ]
+
+      function:
+        description:
+          The function that a group of pins is muxed to
+        enum: [ iox1, iox2, smb1d, smb2d, lkgpo1, lkgpo2, ioxh, gspi,
+                smb5b, smb5c, lkgpo0, pspi, jm1, jm2, smb4den, smb4b,
+                smb4c, smb15, smb16, smb17, smb18, smb19, smb20, smb21,
+                smb22, smb23, smb23b, smb4d, smb14, smb5, smb4, smb3,
+                spi0cs1, spi0cs2, spi0cs3, spi1cs0, spi1cs1, spi1cs2,
+                spi1cs3, spi1cs23, smb3c, smb3b, bmcuart0a, uart1, jtag2,
+                bmcuart1, uart2, sg1mdio, bmcuart0b, r1err, r1md, r1oen,
+                r2oen, rmii3, r3oen, smb3d, fanin0, fanin1, fanin2, fanin3,
+                fanin4, fanin5, fanin6, fanin7, fanin8, fanin9, fanin10,
+                fanin11, fanin12, fanin13, fanin14, fanin15, pwm0, pwm1, pwm2,
+                pwm3, r2, r2err, r2md, r3rxer, ga20kbc, smb5d, lpc, espi, rg2,
+                ddr, i3c0, i3c1, i3c2, i3c3, i3c4, i3c5, smb0, smb1, smb2,
+                smb2c, smb2b, smb1c, smb1b, smb8, smb9, smb10, smb11, sd1,
+                sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8, pwm9, pwm10, pwm11,
+                mmc8, mmc, mmcwp, mmccd, mmcrst, clkout, serirq, lpcclk,
+                scipme, smi, smb6, smb7, spi1, faninx, r1, spi3, spi3cs1,
+                spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b, smb0c, smb0den,
+                smb0d, ddc, rg2mdio, wdog1, wdog2, smb12, smb13, spix,
+                spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3, hgpio4,
+                hgpio5, hgpio6, hgpio7 ]
+
+    dependencies:
+      groups: [ function ]
+      function: [ groups ]
+
+    additionalProperties: false
+
+  '^pin':
+    $ref: pincfg-node.yaml#
+
+    properties:
+      pins:
+        description:
+          A list of pins to configure in certain ways, such as enabling
+          debouncing
+        items:
+          pattern: '^GPIO([0-9]|[0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-6])'
+
+      bias-disable: true
+
+      bias-pull-up: true
+
+      bias-pull-down: true
+
+      input-enable: true
+
+      output-low: true
+
+      output-high: true
+
+      drive-push-pull: true
+
+      drive-open-drain: true
+
+      input-debounce:
+        description:
+          Debouncing periods in microseconds, one period per interrupt
+          bank found in the controller
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 1
+        maxItems: 4
+
+      slew-rate:
+        description: |
+          0: Low rate
+          1: High rate
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1]
+
+      drive-strength:
+        enum: [ 0, 1, 2, 4, 8, 12 ]
+
+    additionalProperties: false
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+required:
+  - compatible
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+  - nuvoton,sysgcr
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pinctrl: pinctrl@f0010000 {
+        compatible = "nuvoton,npcm845-pinctrl";
+        ranges = <0x0 0x0 0xf0010000 0x8000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        nuvoton,sysgcr = <&gcr>;
+
+        gpio0: gpio@0 {
+          gpio-controller;
+          #gpio-cells = <2>;
+          reg = <0x0 0xb0>;
+          interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+          gpio-ranges = <&pinctrl 0 0 32>;
+        };
+
+        fanin0_pin: fanin0-mux {
+          groups = "fanin0";
+          function = "fanin0";
+        };
+
+        pin34_slew: pin34-slew {
+          pins = "GPIO34/I3C4_SDA";
+          bias-disable;
+        };
+      };
+    };
-- 
2.33.0

