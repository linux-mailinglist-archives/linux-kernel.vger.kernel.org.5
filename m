Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83657767C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjHIS6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjHIS6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:58:16 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn20314.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::314])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11947E72;
        Wed,  9 Aug 2023 11:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CF5yJ/9Wj8aVvMNCpbCBY1wwAAKFO5+RR0/o1+h1suGnjNzP/TO4CyoRmuBadu5h2apueYvlWbS3H6g5UZeIItJ2gEGu9rwNuchtYDHx4UuT7QpsUyFIIlQeK4wVr0nWbdUEWp4XLTpATS7xggbihPhlCr66zgNdej5Qv9aHNN3xeocaBgbq9kpkZ2rv04NJy6/n9L4gHU2W/TRwzfz863w77jUXq4MJIp3S7+UnnNHyM87uz68fj4tIc3XRQ/Ad8OZ551YYn3p60WpfG4FZBlvcWiX2k7+8+LDxg6oR9shLEEGEWpBAOuZJpl1S7ierv9/nKaQ2D4XK8ZnUlnYgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2Qfi6BcIr/1NzLpP10C9wJWSlIrb7Ny8RLCCJ/3dDs=;
 b=Tul4br5z37/lx1Cc9qOWfhT4JE6BjmiwKi6qqDwm43whF/MTNsJe7x7CficfqUWFy+/tectzV4J5gkpIlykGGYzN7TrAjjeiBZsbKSME0tMrt6DvOk5WCjkeGL8ejZZ33dZT6BinLk8XUx2lbYgeaT/7r3IoiexBlmh/qet+s4KKx50ULY7K/RfZIbqydXUnxykYj3OMab6VbSFJXelmo4oI0c8kjTnzzCxB1YsQlvQ9nmxzRcApP4oE92nlvmTwvEAxzSl3zqP3k4eeBEDEOb63n6W5ONo6mluOZfTSGYNM8Nz9lK/FoPwY5+PzDoQDNpCrWvgOR5AjbCViHvFG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2Qfi6BcIr/1NzLpP10C9wJWSlIrb7Ny8RLCCJ/3dDs=;
 b=DzHuS6D4fLNcHT5JaTxlYkgRxjGfbAwhfLs2Bv+LPuep4w8pYIV4RzyFmWGUMdMLCNCljpgxyXEjmYAa8SMqZvFOd1zBGccev6MI5J2WhgibTvSXtPZmG+/V5vIL1Eo+D0dv+Xnv+67823jYqWDcdZvtroH3I7NMXCRhfGnWJ9s=
Received: from KL1PR01CA0085.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::25) by SG2PR03MB6537.apcprd03.prod.outlook.com
 (2603:1096:4:1d1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 18:58:08 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:820:2:cafe::67) by KL1PR01CA0085.outlook.office365.com
 (2603:1096:820:2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 18:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 18:58:08 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Thu, 10
 Aug 2023 02:58:07 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 10 Aug 2023 02:58:07 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 920FA6473F; Wed,  9 Aug 2023 21:58:06 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH RESEND v5 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO documentation
Date:   Wed, 9 Aug 2023 21:57:21 +0300
Message-ID: <20230809185722.248787-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230809185722.248787-1-tmaimon77@gmail.com>
References: <20230809185722.248787-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|SG2PR03MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: c824f8f1-5163-4ceb-a129-08db990a9210
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fok2Eb8Zsd+K8+JSz6ieEXR0s3Vph1fadjReUHvmkimKfwk408LZsZruQDlF?=
 =?us-ascii?Q?FFzXtt6lpaIuHC0yggK93KJr8dUQ7yv2RpD2qWci6tToyXNO1tnh/zhebc+m?=
 =?us-ascii?Q?xN9ae7Mm9OMDFfNPZxyEhrtB+Rt/88pVRbEMlSzxuEQA4FeAt2csRTTefJ//?=
 =?us-ascii?Q?Y8AQgm+fWPcJ3IuaXkNfHjHfsmXtmcIjG6Zpk5E+XLUx8wSIPicE44AojgqM?=
 =?us-ascii?Q?F6NFo42urAtvUrEqyqvHze1gu9SzDXtJ+1Q+xG6ms5geV1+J3irfisunfeKc?=
 =?us-ascii?Q?zN6fubAjxCZJ16gi/UofgyS/SygJPLNInzNW4iR0gDjJvGTk42hAjSe+CndV?=
 =?us-ascii?Q?HNfx0Qet10maHOPuxqRn0b+WRVbBMgZBR3ktOQfmNqJzLAKg27pk6+P5jvoK?=
 =?us-ascii?Q?Yye2bs7zlH4vsfZCv0layx5lylI18KnJyI5dZWu1sYroRekBsquY3Xnd3Djm?=
 =?us-ascii?Q?k4KR2gVtK39Fj4oDJemKp2e6/GY22APfXaqz0ltrm/iuh+tHzvRl8Eci86Ku?=
 =?us-ascii?Q?eEiYnL0zLGqiqw4mw3q/FDhYJzbgufUKho4ZsL0MVMgEonBZLrlcN2YOiwEP?=
 =?us-ascii?Q?Z2ikZe6doFFcGUWKURlbATl7XwCDEWfzKZ0JPUqeCWgs0tA9gC3w2HfKpxmQ?=
 =?us-ascii?Q?qqprkv6415hNOHi5V5iPVEXEHuJ6dAu8DDE0runOU3Vrif8RGFZoUk/thX6s?=
 =?us-ascii?Q?DpvQPVTMYAYpuNkHyawT/O5xNVvmrmoPUOpJk0esBPgiDrZrwsMDCfxvhM3E?=
 =?us-ascii?Q?I2TqS8gNJaK/5D/l9YISga82ydvaR+BTnUQ5EaML8uFCMWefkUGlfFrYeH5L?=
 =?us-ascii?Q?Jnk91gqP18/McJgI4HKCvM0ACZ2wlzU2vQV54UobewLYY4wVwhS7/gYP3GNJ?=
 =?us-ascii?Q?E2bv4vX1zm+XnErxwBHcxEL3XpbLuIAaVE3HqHZ8Ckpwg3F6oPCC5viW2Wkf?=
 =?us-ascii?Q?VG69yL4mpwnOsXZHNyjZBATi/T2TvZtKybu9xg0n7rMo2lmcG34lr/bAGziv?=
 =?us-ascii?Q?I034HdTQ8gW6YzQFYBtuZxEm9uJ+0LYKWrBRbCZYmOrlEgv7gh5Of13Vd/cW?=
 =?us-ascii?Q?SIPr3I2koDQtGJsz73ef/4QOcGrugZGh/Qezjgcsyk06aqdl16o=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(5400799015)(186006)(82310400008)(451199021)(61400799003)(48200799003)(36840700001)(46966006)(40470700004)(966005)(7416002)(8676002)(70206006)(70586007)(40480700001)(36860700001)(8936002)(6666004)(5660300002)(478600001)(76482006)(41300700001)(316002)(54906003)(110136005)(42186006)(4326008)(6266002)(336012)(73392003)(82202003)(42882007)(1076003)(26005)(40460700003)(2906002)(2616005)(47076005)(921005)(356005)(82740400003)(81166007)(83380400001)(34020700004)(36756003)(83170400001)(55446002)(45356006)(32563001)(84790400001)(35450700002)(12100799036)(473944003)(414714003)(357404004);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 18:58:08.2030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c824f8f1-5163-4ceb-a129-08db990a9210
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6537
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
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

