Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8717E76B301
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjHALUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjHALUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:20:04 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2072.outbound.protection.outlook.com [40.107.117.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6899B210E;
        Tue,  1 Aug 2023 04:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUQ25AFlAMiFbjRLOWKzGwlsAOeyV9XBqp+QNEbHcDhdn1kcdDaEoGS8Zm6F5dyDOuCJaycRGd61kAxdSfOeBKxhiUqemlwZg95PgrAg7VG4/au3mu2rCLO5xmF2a5PsEtFf1U0upEIM8LxbpT+S0/2ml/HSIa2dse3anh3runOKY97i9J3xPxYmAWoO2H3q9Yk58n363rhOwBK01AoGHGaW75aaFqqYDDSO2xHcxkQd5lsemV5fOCpwkqw+f6IxeKZqKDUfsmxOT705V0uWo3LFhcYgJrZEyDEsdB7QbdoJH7AtxLRuu93BNtYNe5KGBmoP7wIeZzP0Yr0XpclqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2Qfi6BcIr/1NzLpP10C9wJWSlIrb7Ny8RLCCJ/3dDs=;
 b=Xe1trOyWqL9casCUU2692SlA4YlWpocYu2VlVunC8wIpuBIYVNKpNnoRYCMzsXIiySpwU+odsuAIGo+eAgaeDIQ1DLGmU0oaWPAW+iuMK6q8FMPI++pGUGu4AnmaQNduGq3yjKd/9CmCU6N6c832Tdgpj78rD6j/oelPYEAdQA+BJQY3uAc1mRO6rS5/xfdoX1nUiPVxO+fSgZg83AUNeCa+cUKT/g7lMg3MKn5A8xgu3MvuEw4RuChJOq2K8O6/j9rF4QeDwBOj6j9ttYw7dSZA0zOYSGCVGIILg8aWhMzK2GSxC41RK3x/rl5UBEEDHpbVTXSillg11lZ/43bTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2Qfi6BcIr/1NzLpP10C9wJWSlIrb7Ny8RLCCJ/3dDs=;
 b=qgq5Bux4K8qhspeRcP8pzc5cQrZHTWCTgXNDI1OrwRyNhh0UA1XpgvDLauBlPkqV4t58RXstwYxLWSxg8SzHEsZi8bALujE7v4bwEm3wCyUrwMSECJiCl99DawwcRmJmBJGQQR6H/nRQJ9NTbrjodEQrIhM0ThItEAAOqQxlZSk=
Received: from SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) by
 SI2PR03MB6026.apcprd03.prod.outlook.com (2603:1096:4:14a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.43; Tue, 1 Aug 2023 11:17:17 +0000
Received: from SG2APC01FT0059.eop-APC01.prod.protection.outlook.com
 (2603:1096::cafe:0:0:5c) by SG2P153CA0009.outlook.office365.com
 (2603:1096::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.4 via Frontend
 Transport; Tue, 1 Aug 2023 11:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG2APC01FT0059.mail.protection.outlook.com (10.13.36.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6631.44 via Frontend Transport; Tue, 1 Aug 2023 11:17:17 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 1
 Aug 2023 19:17:15 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 1 Aug 2023 19:17:15 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id C575F64741; Tue,  1 Aug 2023 14:17:14 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linus.walleij@linaro.org>, <j.neuschaefer@gmx.net>,
        <zhengbin13@huawei.com>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v5 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO documentation
Date:   Tue, 1 Aug 2023 14:17:11 +0300
Message-ID: <20230801111712.45653-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230801111712.45653-1-tmaimon77@gmail.com>
References: <20230801111712.45653-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0059:EE_|SI2PR03MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: de1661b9-2d5f-4e5c-22cc-08db9280dde2
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kdpPmNftqjsS+xZAhJUaTZX70CHj5hiqP1Ha/6dEfczOUyxxyzfD9Y0ekPVI?=
 =?us-ascii?Q?zQliqu5jDl3nlnyUWk3wAsCcRK0JJruflMjlYsJ46Cbq3F7gSmG8+mYdSZ+W?=
 =?us-ascii?Q?Ep9vLB01x2ITeTzptg8MkrWUDLaUcAXITPmqTe1CDEsG0Ca8o92FoTiefRs1?=
 =?us-ascii?Q?QUQtTN+fkhcqpuD3EEj5Hdizlf5NO+dvlmRx1XGDrhz/xKAEdU8UDQLpu6pj?=
 =?us-ascii?Q?ZfvWc8obG/+JRz5Vsnqtc+J9XKmU7Z3SfzAYIFpa2HcYmHt7GFSVLVqTYbiO?=
 =?us-ascii?Q?xNERHqh6xX9xs768bpq+FJljP0MRud70vhM8K0xuifCsq9txgGDOh9WJL02z?=
 =?us-ascii?Q?6sP3NlqAfRgsAvnzyW3618ADrb58bw8RgpdkZzeYv7Q+gZfply5RlnqCKCQB?=
 =?us-ascii?Q?RL44fiZwRdN2Jcv0f/4Yq4/DUCnFiTk0AZNmYqVDozosRANC8cbWvAg4Ng69?=
 =?us-ascii?Q?CZf7o30/5aJKAA8u6sDlZgqNbzO0jEg1S9LPVYEHpeTHEVU7/NFoCgQwZH5N?=
 =?us-ascii?Q?qDMfrZSPr/WaeXrCkqGm7LwAIvQp+L/KP0LI1XEUV54/+afNPkg+/5NyOBVA?=
 =?us-ascii?Q?GFORUC875xlZtdxxcV0qFMa12evh5P5ZrMOxSqww6FtFEd5xpVUhahxZKiSi?=
 =?us-ascii?Q?NS6SVnu0zcyIvAXxEu0Q5lMZ8OKFf19y3UyUx23RaLeyuwByZzDOfsqI79L7?=
 =?us-ascii?Q?RKVhrsWoj37Nln/anfLxfJEMcaaeMnR2Dwdo/QjCyBhLaJLic1vN3Rhkpczl?=
 =?us-ascii?Q?fp+nKRICVmKDOwPD4tFBEWX1JS04zSomA5kyc0+QAv3xBwFKw+2uFBvD/ntB?=
 =?us-ascii?Q?Uy3HtBCbIV0Xz3UWkgi6AD/fekx2UA0dBd6LxXm+pwR5lUv68wHRoN7aGToT?=
 =?us-ascii?Q?+e6+4L4+jpKADXbSObuA+X5dCwjOU0wStuyx++sb8CPHs86z2C0hFdddASlZ?=
 =?us-ascii?Q?utnwpmmGNx/KKAzIfyUMThlGtBT68XFjbtvMbFGXVdd1j4eDTiItK8HnMak0?=
 =?us-ascii?Q?E1j1?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(61400799003)(82310400008)(46966006)(40470700004)(36840700001)(966005)(478600001)(110136005)(6666004)(54906003)(76482006)(186003)(6266002)(336012)(82202003)(1076003)(26005)(2906002)(42882007)(2616005)(70586007)(4326008)(41300700001)(70206006)(316002)(7416002)(8936002)(8676002)(73392003)(5660300002)(356005)(82740400003)(81166007)(40460700003)(36756003)(83170400001)(55446002)(36860700001)(47076005)(40480700001)(42186006)(83380400001)(45356006)(32563001)(35450700002)(414714003)(473944003)(357404004);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 11:17:17.8017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1661b9-2d5f-4e5c-22cc-08db9280dde2
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0059.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6026
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
pinmux and GPIO controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 215 ++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
new file mode 100644
index 000000000000..8a12f5134450
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
@@ -0,0 +1,215 @@
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
+      pinctrl: pinctrl@f0800260 {
+        compatible = "nuvoton,npcm845-pinctrl";
+        ranges = <0x0 0x0 0xf0010000 0x8000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        nuvoton,sysgcr = <&gcr>;
+
+        gpio0: gpio@f0010000 {
+          gpio-controller;
+          #gpio-cells = <2>;
+          reg = <0x0 0xB0>;
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
+
-- 
2.33.0

