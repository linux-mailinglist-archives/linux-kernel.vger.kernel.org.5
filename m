Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53256769634
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjGaMYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjGaMYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:24:24 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2088.outbound.protection.outlook.com [40.107.117.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90CE1986;
        Mon, 31 Jul 2023 05:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEj1REix7eQtkoOKvY2H6lTOR8TnTgUZCntHZMti4puzvBjgJ8UD735rZCjs5RuVlQqOhglyenRZ0jiBE2ulmOwPxPpZfFeIPZAaOwWt/rFpA73Hk3Lp/K7zx0ealIZECbfn53ej3NtteFpk+bf4lp+N7ihlsm/8gCb7TwXR09XPxPbJrkJay4zS5TZBi4XWdIh52ETIjTcuWrjEayrhb2pc+d+KOOOCXKHAi7obCbfl47KMJohPqdT33seE8wvYk7D0zT1HV9CnQUm0Zk//I6Cvm7rNCGyhZQ0xZiaGNQcKe4/nerb8u6811iHD+6YVxq9bJMSMM6/IqJOwlOeWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOLd5+svMEXrWDYv1UujEcBb8tqRvQVMRVlUko3NMV4=;
 b=EaE4ukht7VFyQTXZq6WwcqTn9037RneD9Qwx2BxSEHIohwLGgLxJscdquhco8is4EVzgBsqbCvA4C41ssBsVL8h0LvSjzJIXY8tFH0nWrrG5sSRI6pFVmfFaT0pb0txkasIFnOUtGNuG4vMCLITYhsR/xkhmOZaWPFGFsCpJ5psdAzRfU2LE7iG65scAdCBKkA/XTsI5wi6pqtV/cjH8lfoCWFl6Nv7iCJWFT9SRe2msaHdKQknccX/+ta6MUo8up14TNzyHUn0n9W83Cev8WI7l1wkpgBojYt2D4VDS3F/QA1s+18szlJ8u9panSX3sJLMYPg4R56Nhr8M5gHTrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOLd5+svMEXrWDYv1UujEcBb8tqRvQVMRVlUko3NMV4=;
 b=WCmHi0O+4hQ/c+DuCKRbwNK+73k0J9nDt7N43CE5opA1A+im6rgZgEhU7mmqKk2g84gUVy3iXwfTWzEfxuBoMesfOnCxk2hIyGAmuuB5fLQxrmTQB2+vszjbny9REeQ4jJpZXu6KyHmweJV1NhaaPzF3ML77YvPHipzVPAc8U7Q=
Received: from PS2PR03CA0008.apcprd03.prod.outlook.com (2603:1096:300:5b::20)
 by TY0PR03MB6241.apcprd03.prod.outlook.com (2603:1096:400:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 12:23:27 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:300:5b:cafe::c7) by PS2PR03CA0008.outlook.office365.com
 (2603:1096:300:5b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.17 via Frontend
 Transport; Mon, 31 Jul 2023 12:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 31 Jul 2023 12:23:26 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Mon, 31
 Jul 2023 20:23:25 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 31 Jul 2023 20:23:25 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id E90BA64741; Mon, 31 Jul 2023 15:23:24 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v4 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO documentation
Date:   Mon, 31 Jul 2023 15:23:22 +0300
Message-ID: <20230731122323.172834-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230731122323.172834-1-tmaimon77@gmail.com>
References: <20230731122323.172834-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|TY0PR03MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf20ea8-9743-4736-fa0e-08db91c0f120
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VkBHX3tuFhnKZShSxdcg0bqBrfv6PVnmO7nZumUvAudJx99WSle8q4A9QFCD?=
 =?us-ascii?Q?GQOPl/1pMsUI1cPQrUCeymPN/omphGBvuHAETplvKdGiUTzG10PbTyb3NIzP?=
 =?us-ascii?Q?9PMX97WkaXuvc7wZxRpSaQlSW9NYb1j2OxP9c2WaT0FSBNN2++Q9LcO9Zujp?=
 =?us-ascii?Q?tGi6a1WeB+YaR9mLhCu+KyX8DXdP1IzH4X7vQavU230KTh/5lSROmCHFuMt3?=
 =?us-ascii?Q?keg2eivU5ufApkBni88/EbWscizAyZVhvvVQ7yTh/aJ3A/rU60oBHBoaeDGW?=
 =?us-ascii?Q?JdqGZywpl7moI28/Zo7ezKsGHPCyOHGjFJzFxAtF5/4t/67sLIHQD4UN/Lhx?=
 =?us-ascii?Q?EgFTW8ATmrZUc4xOasyqU1IMiFWNd1RD7MhK2GjDvNoMv4NsHGc1AYscEzvT?=
 =?us-ascii?Q?ud+U/ac1etB/ueiv7aA91TNuCD6T/lUUx0NCroNIORUJYrsVzH1IIRR7XT3V?=
 =?us-ascii?Q?B+6ip/scyFSnudtFN367bCJ3/YeANX6ZtmvQdFOJfOEPOkyU1jWWGU8nO92F?=
 =?us-ascii?Q?egSlbKqK6WiL2t8B8H/pKob5NJnZaZd0wNKTB9APiQ1hH1hiRf6XuCkwtGa3?=
 =?us-ascii?Q?si6GHnK7aN8HfkRlfSc9gU6XV9ppFW0rFt3kbh1wC9rD3Z8uSxjQDjEwBwP7?=
 =?us-ascii?Q?CejgE6SQ+PpHbu28YT5bOxhzS0FNtmMdVprnLa3YtYqjJ0ljIFwrEFKWxC9R?=
 =?us-ascii?Q?S4Z1Rz5KEqP+eHoS314qmipHlvJIXR56q6y5U6ivohywpM/a6ALiidoHLUaJ?=
 =?us-ascii?Q?rXYHe/JX0yCi1UaesYqwqo5jkBO/53tgZObprXVppVpcERi/G73OU5cwHgGy?=
 =?us-ascii?Q?20rNWC8AcsGuQ9PO9awXoZz+AoWBGOYMk8iHSCRR3Skl4zuQVYOQbKe1L8Ey?=
 =?us-ascii?Q?BpagtNxwOyRTx0TOBvHb478CPmSq4+eKldBA4bFXsXdERHtcVoW6nN1NNyHM?=
 =?us-ascii?Q?sZgnhGMaxd92Vl8wVg+9jgLAI7ceNbuOBg0qxHm/qN1cIbTEUFWXNZ+scFkH?=
 =?us-ascii?Q?usVWiI7BVfPVJHaPTm0yTCIUzA=3D=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(82310400008)(61400799003)(451199021)(40470700004)(46966006)(36840700001)(966005)(40460700003)(36860700001)(73392003)(336012)(6266002)(42882007)(186003)(47076005)(36756003)(2616005)(83380400001)(55446002)(81166007)(921005)(83170400001)(82740400003)(356005)(1076003)(26005)(82202003)(40480700001)(2906002)(70586007)(70206006)(42186006)(316002)(4326008)(5660300002)(7416002)(41300700001)(8676002)(8936002)(76482006)(478600001)(110136005)(54906003)(45356006)(32563001)(35450700002)(473944003)(414714003)(357404004);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 12:23:26.7963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf20ea8-9743-4736-fa0e-08db91c0f120
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6241
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

Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
pinmux and GPIO controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 215 ++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
new file mode 100644
index 000000000000..6a4e0d9c8f50
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
+  '-mux':
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
+		  spi1cs3, spi1cs23, smb3c, smb3b, bmcuart0a, uart1, jtag2,
+                  bmcuart1, uart2, sg1mdio, bmcuart0b, r1err, r1md, r1oen,
+		  r2oen, rmii3, r3oen, smb3d, fanin0, fanin1, fanin2, fanin3,
+		  fanin4, fanin5, fanin6, fanin7, fanin8, fanin9, fanin10,
+		  fanin11, fanin12, fanin13, fanin14, fanin15, pwm0, pwm1, pwm2,
+		  pwm3, r2, r2err, r2md, r3rxer, ga20kbc, smb5d, lpc, espi, rg2,
+		  ddr, i3c0, i3c1, i3c2, i3c3, i3c4, i3c5, smb0, smb1, smb2,
+		  smb2c, smb2b, smb1c, smb1b, smb8, smb9, smb10, smb11, sd1,
+		  sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8, pwm9, pwm10, pwm11,
+		  mmc8, mmc, mmcwp, mmccd, mmcrst, clkout, serirq, lpcclk,
+		  scipme, smi, smb6, smb7, spi1, faninx, r1, spi3, spi3cs1,
+		  spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b, smb0c, smb0den,
+		  smb0d, ddc, rg2mdio, wdog1, wdog2, smb12, smb13, spix,
+		  spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3, hgpio4,
+		  hgpio5, hgpio6, hgpio7 ]
+
+      function:
+        description:
+          The function that a group of pins is muxed to
+        enum: [ iox1, iox2, smb1d, smb2d, lkgpo1, lkgpo2, ioxh, gspi,
+                smb5b, smb5c, lkgpo0, pspi, jm1, jm2, smb4den, smb4b,
+                smb4c, smb15, smb16, smb17, smb18, smb19, smb20, smb21,
+                smb22, smb23, smb23b, smb4d, smb14, smb5, smb4, smb3,
+		spi0cs1, spi0cs2, spi0cs3, spi1cs0, spi1cs1, spi1cs2,
+		spi1cs3, spi1cs23, smb3c, smb3b, bmcuart0a, uart1, jtag2,
+                bmcuart1, uart2, sg1mdio, bmcuart0b, r1err, r1md, r1oen,
+		r2oen, rmii3, r3oen, smb3d, fanin0, fanin1, fanin2, fanin3,
+		fanin4, fanin5, fanin6, fanin7, fanin8, fanin9, fanin10,
+		fanin11, fanin12, fanin13, fanin14, fanin15, pwm0, pwm1, pwm2,
+		pwm3, r2, r2err, r2md, r3rxer, ga20kbc, smb5d, lpc, espi, rg2,
+		ddr, i3c0, i3c1, i3c2, i3c3, i3c4, i3c5, smb0, smb1, smb2,
+		smb2c, smb2b, smb1c, smb1b, smb8, smb9, smb10, smb11, sd1,
+		sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8, pwm9, pwm10, pwm11,
+		mmc8, mmc, mmcwp, mmccd, mmcrst, clkout, serirq, lpcclk,
+		scipme, smi, smb6, smb7, spi1, faninx, r1, spi3, spi3cs1,
+		spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b, smb0c, smb0den,
+		smb0d, ddc, rg2mdio, wdog1, wdog2, smb12, smb13, spix,
+		spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3, hgpio4,
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

