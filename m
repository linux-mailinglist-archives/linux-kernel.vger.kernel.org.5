Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8686F78A16D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 22:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjH0Ugk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 16:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjH0Ugf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 16:36:35 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2076.outbound.protection.outlook.com [40.107.255.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B23D127;
        Sun, 27 Aug 2023 13:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FieR/IMKB8UqKB0Ns5HNF45vISsq2uuVlWTO6iuN8gnTmrLnuD2UMpypbr/XKK/H2FYrCEt1/Gh2ljmP0tFRtA+M/k8AoS6J8DNhA6MA9JfCF8EWT2G7vG9a8ddnZHnJo9VPD7ba5c3UWWZQYkQjRIMOIjj2md5dU2C+q8luxVBymyX4v4FKlRZP4e6sjLoR581dyeqG7xgWskm26uT3IFBtN5bgKRYgoPyIcK9HW7SQOTcZhqXuKz6/OVx/mo+b3CMYkFY2Mtj/5OpRsUUKThUJp481fqbjDKtMdCFqu6pKazlhRQENnC30ReN97TDk6x+Hdkz4SLy7qP41hjUfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4lH7yud9XBDMcMR2T2GtyguIjqA1a/Oacn2u/B8/mw=;
 b=DI1PMQEsemRcc94dBsVH47nFzsk1EJpSLeDi+BiWIc4+sFeyPoV7b8aeoePQ6NysidZUPAT9J+lioAvNwrAnh0EZuFr9hvy3KUVLjUohFz6Uvq+Nx32hic5FoQrnI28tiLVbezHX6ULu5lQl2imbMPA23C+IylNv5DHQ//TKZLtV3o5mSz/yzvh6lsq9nkop/Hu/a1klMSEANjEJeLpzPcwr02cRie1iEGaAEy5bVhYO2KYx5lh0xO7PiK+Kx3CeLyj7yZAubcsjMMkRgcXN+6bIGrf53wA90azNsXrbytoZ+3A7ULZroNSlhOWGpNzPQJpBnhVddgePCq6U39G37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4lH7yud9XBDMcMR2T2GtyguIjqA1a/Oacn2u/B8/mw=;
 b=IsewwyIiGoG315Vf+eOQmxdGZcl4UGYNRLST6uT69ZRWEXmqino79leM12ZyBy5xx+kFrKfZdud4ssbOQJ13HJKOYBAzJAptyvzd+xTYOU7KSOcvhFUzMM+fsuC55ZDd7K2yAoWa+6bzwWZueaGWZrxCOFcZkGJ8ysd6e8zGemI=
Received: from PS2PR04CA0008.apcprd04.prod.outlook.com (2603:1096:300:55::20)
 by TYSPR03MB7823.apcprd03.prod.outlook.com (2603:1096:400:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 20:36:27 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:300:55:cafe::1b) by PS2PR04CA0008.outlook.office365.com
 (2603:1096:300:55::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Sun, 27 Aug 2023 20:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6699.15 via Frontend Transport; Sun, 27 Aug 2023 20:36:27 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Mon, 28
 Aug 2023 04:36:26 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 28 Aug
 2023 04:36:26 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 28 Aug 2023 04:36:26 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 92B5764741; Sun, 27 Aug 2023 23:36:25 +0300 (IDT)
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
Subject: [PATCH v6 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO documentation
Date:   Sun, 27 Aug 2023 23:36:11 +0300
Message-ID: <20230827203612.173562-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230827203612.173562-1-tmaimon77@gmail.com>
References: <20230827203612.173562-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|TYSPR03MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c39216d-d9ab-4548-1cf5-08dba73d49a7
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5+DDmzVZI1ku1Oy1HYnUnSL1tyv7iIsHeWzkxw26biPSf6bRLSbTDMoeiUAY?=
 =?us-ascii?Q?mBdofGoozxNeFeN6HjCNTXxvdFqIYWkbSfi2QUkdPJ4anLg+Kk0Geo9TTZAx?=
 =?us-ascii?Q?wy/bjXemj8GZcojYcn5jsaSXPhai7rp4YyrwnE5ay/H4QZq1Ujq6RQ8EfL4c?=
 =?us-ascii?Q?qWLUqu5ZbE+eXAxyzS0n5RNBYsXK9sCEY2joUyElO9E9IV8gWETaBykdPCR0?=
 =?us-ascii?Q?ffESK1/1NNp5ZNX7ztmlNXgTdZJk3+ulpRoyL8a1taRUlG+LMqNouBCwkj4Z?=
 =?us-ascii?Q?70TsJaaTFR4BWDLE86GCXndC+xw71yWd1rdCS+nQPdoTDCBClf2iTpVIOF8i?=
 =?us-ascii?Q?bCXSQbZSCikHTdEiTy/xIk6wbKRpsFmgyEYriygFwfK2UgPU7mqgrBElCneE?=
 =?us-ascii?Q?ieujbh0d+9AufQKrFM+sC7BXqH+zYAw0q/JNmjdmODiOaoVI/eROkyXS3MJ4?=
 =?us-ascii?Q?1EIn20TBAbnawey+FGuLwQevlFSc7d+A8+YTFLonPWSJA6aGzzTgN7MDlnTL?=
 =?us-ascii?Q?3neJOuxYet6kZax2qOTrqHtjrXCpccGYF/JsrdubTng/TAgnA4Btqlt1Yumd?=
 =?us-ascii?Q?UkGp5wLE3DqqT71Pm9qmLH66jvWBAmWDr+A11fx1DCNZ/oV9kEwvL/I3FYc+?=
 =?us-ascii?Q?Q6QEAOwY1HkpJo57uclAJQttFtZ6faZpsK/Qld9Gt1K5LKZRSr2F7lXJOllF?=
 =?us-ascii?Q?EoxvFdcb/tgEbLqVUhkuPNxqzjRU3RChiNj4s9iveoYpsgSvx7ahOMyQ3+M4?=
 =?us-ascii?Q?Nd8e7fHTYE1NezB8A0ViMGta7LeJSpwAhHuDHeceM8ez+W2m43YooZZddpR4?=
 =?us-ascii?Q?Wo1UpXktGXXiEqQevsOVjzlq3nAmvQ8f0pNeFmK555fHz1Zfe1vCDFng1STj?=
 =?us-ascii?Q?sWEdH7q3oYDnXJFZxP/h2WeYTijVZ6AgereppSdI59oTDuC7xRB8LKGPxSHJ?=
 =?us-ascii?Q?hLVmev9ea8+hCtCxxlBnErVN+LIBVS8O/bOxM/rFN9PpKghj5To+RIUBa3Pb?=
 =?us-ascii?Q?b5yJrqc9GNbU9k8rcxTx9lj99k3UBUT3xKay32af4Kg6bMJpgXXKrsWzrUvy?=
 =?us-ascii?Q?6GB7K7N4?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(82310400011)(186009)(451199024)(48200799006)(61400799006)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(42186006)(54906003)(70206006)(76482006)(70586007)(356005)(110136005)(478600001)(82740400003)(966005)(81166007)(921005)(7416002)(2906002)(55446002)(316002)(8936002)(41300700001)(5660300002)(8676002)(4326008)(83380400001)(36860700001)(47076005)(73392003)(42882007)(83170400001)(6666004)(1076003)(26005)(82202003)(336012)(6266002)(2616005)(36756003)(12101799020)(45356006)(32563001)(35450700002)(473944003)(414714003)(357404004);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 20:36:27.2964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c39216d-d9ab-4548-1cf5-08dba73d49a7
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7823
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
 .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 214 ++++++++++++++++++
 1 file changed, 214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
new file mode 100644
index 000000000000..a895c60e3eb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
@@ -0,0 +1,214 @@
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
+        gpio0: gpio@0 {
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
-- 
2.33.0

