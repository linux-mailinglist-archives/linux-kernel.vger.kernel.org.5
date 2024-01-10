Return-Path: <linux-kernel+bounces-22237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B5829B44
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934DA1F24E22
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AEF495D8;
	Wed, 10 Jan 2024 13:32:28 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2051.outbound.protection.partner.outlook.cn [139.219.146.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13348CEB;
	Wed, 10 Jan 2024 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW02hHSqnk0yBRcLfEvQBuyTyiwiWggH50WwQU3ibWMhxJykrRr1WZrigCCsP0hOWXuGDa6QjoC5UxBs82pQ76sqsfbFcZlec0sFIsQCKZXFnlKMgmGZDdVQV6R45bUZjNGOKo3O6uQ1GM017FNcJ+E9B1gkIBvNKUJm9MnBD0bW2rKrWhRY/lgd21Loza250njE9H4A7+M/twuXNrzKt8GjF7zhXrYCu6lqEBgtWEMwVrVZHxaed6kLXLfprQXDWGMJjZQmj8I9RFzBy8FUa47L/HU9pcoiJEbnDpSI1VOaW1ccLUxp//uNF98pcUHVnGv5s85KNoEY1sYvCq74IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eri7qDQ5Xr4knoEOeX0QzfbwHPtJCgnsbkXb2xcfC2Y=;
 b=Uowht90lOy+9AD9+p5bpQxtFyIiJ40puWnkDPHDw9ywpXwiE5xNuWGk8p4yngDxO2VoJjK55JX6L8yopLiCbVnASMXzHKJLpa/q3O8KNnDYUUAlskhFPTirFJwscJO9dO7kLXnB/wt8fV2z/lSoYHjFk65fUmZ1QnTiVqXZtLnRmA+P1yh1Ci+Veoh247+yK99r58dMTwMlW8lw3GbccCZ5YCN5zZfqTw9XP0GtAwvvM7MofhxtAa1Iy3TfbZ/A5ivPiH7k4AzcliliuWF4g9/Rox3/JHUUfS4FpFGqiRCEK9sMTBOa/zws2YH1v+PaI8zGrM/jiNRkZFAtZJgshXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0626.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:32:16 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:32:16 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: kernel@esmil.dk,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	emil.renner.berthing@canonical.com,
	hal.feng@starfivetech.com,
	xingyu.wu@starfivetech.com
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	jeeheng.sia@starfivetech.com,
	leyfoon.tan@starfivetech.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC v3 09/16] dt-bindings: clock: Add StarFive JH8100 North-East clock and reset generator
Date: Wed, 10 Jan 2024 21:31:21 +0800
Message-Id: <20240110133128.286657-10-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0626:EE_
X-MS-Office365-Filtering-Correlation-Id: 7706d732-1d8b-47ee-3bad-08dc11e08f9a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RYpK0pclWH5ozU3Ek35UXnFtG4DbNp8jbM+aT+WiPt7z3YnkSLCJv2nnT+ArU5Nx6ZqtzI/gH2+q74lZrBt9rQtJBxwrliajH2iXEtHAdiPNuQT9UXteby80wEr20Qm2ED6U0cea6m5KFDEp585iCDu7LurorGVj5AjkCueknEQFuEEoCbZAIDKiFA+i1ZDUC1ylnkTfAkGhBDPX3Ojgb96daIlOyr+PotFc59JPkROpHahqzm27RFw0dYPiDuCx438TdYXDhOqXcwwPc/Q5wXvyTNOvQPtXw9xInyab57QqOKA7zoFJApbFj+W0+P+RECc0oeieG3wma4MHVCzAu3m6XVZTz6G8ynWC5XbmtQuQ3bO/t2dFJSEk0o1rOVlRmee2Jhb0Zb0BZ5VR1Bn/crWl691f8ns5UAfedUpSGXTRNZxxbEw9M195Hah5z2nyfLHo8F4247gEPi8kpWhliZVw/gjsUyHRnCET/RnirSyJHGuSkDrWYzsI+UqM5W27pcRUOh8PtOFnlVzQAmX9etGp2SvgRkooqGjMtDB25LFdXRzN1UrZtLWbPxlSSBHD5fJ1rslQNjrkB/YkHxAGv36XqB2k9dWFxNiHMzXTkyNBgFe9h633v+ZD1MWSJ2cb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(346002)(396003)(366004)(230273577357003)(230922051799003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(921011)(26005)(52116002)(2616005)(41320700001)(6666004)(83380400001)(1076003)(86362001)(40160700002)(40180700001)(38100700002)(36756003)(38350700005)(5660300002)(30864003)(7416002)(4326008)(55236004)(6636002)(66556008)(66476007)(66946007)(41300700001)(2906002)(8936002)(8676002)(966005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OwoHGJF6T7iu3vrYteWmO2rATczbrv2oZMfNlD/nXEiqYMq00wURBs89SD/D?=
 =?us-ascii?Q?YiY406gMLI/eNxSRyfgLfw3FiRMDDq+FRFbl0qyqq8uCw/qCTg0PZ/X/IyR2?=
 =?us-ascii?Q?b/boLmWWURuCs88vfC5tuOUpg0kwadAsmNLPGpUHS+IzBZK/ljuodSzaEtMy?=
 =?us-ascii?Q?tPsF2p1V3wi10QMJcgkPb8V9zAy3a7iIt/KvyR/I7MRiv0gcaRyYATE+Aaf7?=
 =?us-ascii?Q?dZ2AfC0pzkKIE0Neml/Zc5GcUqoBxEbY6c3j7waeUKfmWxT75fwVzyGEDB/b?=
 =?us-ascii?Q?7d836D3K3FS4urePYa6BVvD2UyP/VRp5w0EhLIKdO+OmIymLFEjhYwylE+2l?=
 =?us-ascii?Q?aHudNpQOoiEr9hPeIVbX+wz5cujO+7vakx/xajryYXWGp/XWTDJnRLlSKkUR?=
 =?us-ascii?Q?gsi6npRoBlYQOtf5QPm57aeKHH+jwulSJzo/O8v3QwfeoFbDbja1nMgmSfI2?=
 =?us-ascii?Q?qmbbp818KsxwzGrrC+/I+B5uW5YiwSk8WsyMmIvLkrL34/2bCzzp/dOiKXxe?=
 =?us-ascii?Q?BHN9D+3oNijjiaAPu9sfW/73COb/oJpPyaKRD5B4RMpV86Nw0zVFxJsm6BzW?=
 =?us-ascii?Q?keL4dJ1yczRmcmc3UTWhZv+zlMTrNfX8o6YdXOjwL5By1TOsBRqqVIGZ4qUy?=
 =?us-ascii?Q?cf3WlOvFWSiCCCs/A/ishipXLc5dZ3151YypiL/9U24130/FNpa8vUVMTNku?=
 =?us-ascii?Q?wJAa73HZOABEM+JFvj9iMOuVvRhBHjRocbwzgguN9aP4ZesHBU42aM3USc3r?=
 =?us-ascii?Q?iB1NjZBD/9jimrLu6dHtf6Ji8F25MbeYDSAFhuePgmte9ZzERDLyl3QT/4MA?=
 =?us-ascii?Q?x4CnIZ4hY8TvdejujvCehVgIVU6LRTeUSyvDTEz0M9vw6tr4zZrb156E5mDM?=
 =?us-ascii?Q?j2CNVgBIiPIMEts4MTh63UE/2wfecg+nDOBDobpqvXKpiQVjVei7ytpDAWdq?=
 =?us-ascii?Q?6TvARdPzGAaOgGKdgvEjSxKeiWjk8YzXTace4Ildcqw6HuNLNHvjiAE57Wxr?=
 =?us-ascii?Q?Da77qOWdhXSWHgBAhk1v+7k/ARYlk3Ozusvwp56PDLMcxex+7lWNmKsCjOdx?=
 =?us-ascii?Q?YmrzAF/Jf009A6YlO3RJdymOhwtBeFilNvuMYCuamSbbZid8cmZeTJpBkIrx?=
 =?us-ascii?Q?ESz+6ipHqYoZNhPkIiZ1s9664NQQAWzExDfUUNm0HnNo6pzomrPA54erEUN3?=
 =?us-ascii?Q?yfRzbJD+p353J8qZHhLGanjMFJ43N+a9ukFcDm8wg6HSrt5vPKepdegTg4Ec?=
 =?us-ascii?Q?kt4WCae3cMAwmPQc90PitAUJAB6qMvBxIBY8uwlsY4VSanOOCjBmUqcVv5Mx?=
 =?us-ascii?Q?a87Iy/A2N1DIXkBsQLv25uxhT8RgGp7baoc+C2IISrlUV7oiyr/yGpLza2SS?=
 =?us-ascii?Q?WMup3BUhjNVheDiZP0pp0sV0o8rnvYmk9Vdcg5M4cvNtd+EfbqwL254iS1hw?=
 =?us-ascii?Q?RUXHaUrJxiZvUXA8fWTb0/YYvHi6lsy+lNMkDoDPWWxaDQkfdeGfb1oUzFep?=
 =?us-ascii?Q?qN7Iy1wMMIWbc6KqS3WbKPbZ8zIr5P/RGMg/7nafNp7yTlwdkZe+FHO72cvT?=
 =?us-ascii?Q?SmyUxGhlxx40SXeBtQQkSeKArBeVkpVbdy5TQUKPBmZZdJWUADMUxfW6qmVl?=
 =?us-ascii?Q?mULYcXBd6dPDoF3rtpew6CI=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7706d732-1d8b-47ee-3bad-08dc11e08f9a
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:32:16.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RvZMnKGlbAKrgEjR/L1g6ApHZ078PFNzaUgbsV8WO8nPB1JTxAUkyYtMUkjjrAKRDMytFBT/SPEtKebTFkfJ55nEKxwrT+S6vfO+0nHFsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0626

Add bindings for the North-East clock and reset generator (NECRG) on
JH8100 SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/starfive,jh8100-necrg.yaml | 153 +++++++++++++++
 .../dt-bindings/clock/starfive,jh8100-crg.h   | 177 ++++++++++++++++++
 .../dt-bindings/reset/starfive,jh8100-crg.h   |  59 ++++++
 3 files changed, 389 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh8100-necrg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh8100-necrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh8100-necrg.yaml
new file mode 100644
index 000000000000..f747b85fa457
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh8100-necrg.yaml
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh8100-necrg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 North-East Clock and Reset Generator
+
+maintainers:
+  - Sia Jee Heng <jeeheng.sia@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-necrg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (24 MHz)
+      - description: AXI_400 clock from SYSCRG
+      - description: VOUT_ROOT0 clock from SYSCRG
+      - description: VOUT_ROOT1 clock from SYSCRG
+      - description: USB_WRAP_480 clock from SYSCRG
+      - description: USB_WRAP_625 clock from SYSCRG
+      - description: USB_WRAP_240 clock from SYSCRG
+      - description: USB_WRAP_60 clock from SYSCRG
+      - description: USB_WRAP_156P25 clock from SYSCRG
+      - description: USB_WRAP_312P5 clock from SYSCRG
+      - description: USB_125M clock from SYSCRG
+      - description: GPIO_100 clock from NWCRG
+      - description: PERH_ROOT clock from SYSCRG
+      - description: Master clock from SYSCRG
+      - description: PERH_ROOT_PREOSC clock from SYSCRG
+      - description: AHB0 clock from SYSCRG
+      - description: APB_BUS_PER1 clock from SYSCRG
+      - description: APB_BUS PER2 clock from SYSCRG
+      - description: APB_BUS_PER3 clock from SYSCRG
+      - description: APB_BUS_PER5 clock from SYSCRG
+      - description: VENC_ROOT clock from SYSCRG
+      - description: SPI_CORE_100 clock from SYSCRG
+      - description: External global clock
+      - description: External USB3_TAP_TCK clock
+      - description: External USB1_TAP_TCK clock
+      - description: External USB2_TAP_TCK clock
+      - description: External TYPEC_TAP_TCK clock
+      - description: External SPI_IN0 clock
+      - description: External SPI_IN1 clock
+      - description: External I2STX_BCLK clock
+      - description: External I2STX_LRCK clock
+
+  clock-names:
+    items:
+      - const: osc
+      - const: axi_400
+      - const: vout_root0
+      - const: vout_root1
+      - const: usb_wrap_480
+      - const: usb_wrap_625
+      - const: usb_wrap_240
+      - const: usb_wrap_60
+      - const: usb_wrap_156p25
+      - const: usb_wrap_312p5
+      - const: usb_125m
+      - const: gpio_100
+      - const: perh_root
+      - const: mclk
+      - const: perh_root_preosc
+      - const: ahb0
+      - const: apb_bus_per1
+      - const: apb_bus_per2
+      - const: apb_bus_per3
+      - const: apb_bus_per5
+      - const: venc_root
+      - const: spi_core_100
+      - const: glb-ext-clk
+      - const: usb3-tap-tck-ext
+      - const: usb1-tap-tck-ext
+      - const: usb2-tap-tck-ext
+      - const: typec-tap-tck-ext
+      - const: spi-in0-ext
+      - const: spi-in1-ext
+      - const: i2stx-bclk-ext
+      - const: i2stx-lrck-ext
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jh8100-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive,jh8100-crg.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh8100-crg.h>
+
+    clock-controller@12320000 {
+        compatible = "starfive,jh8100-necrg";
+        reg = <0x12320000 0x10000>;
+        clocks = <&osc>, <&syscrg JH8100_SYSCLK_AXI_400>,
+                 <&syscrg JH8100_SYSCLK_VOUT_ROOT0>,
+                 <&syscrg JH8100_SYSCLK_VOUT_ROOT1>,
+                 <&syscrg JH8100_SYSCLK_USB_WRAP_480>,
+                 <&syscrg JH8100_SYSCLK_USB_WRAP_625>,
+                 <&syscrg JH8100_SYSCLK_USB_WRAP_240>,
+                 <&syscrg JH8100_SYSCLK_USB_WRAP_60>,
+                 <&syscrg JH8100_SYSCLK_USB_WRAP_156P25>,
+                 <&syscrg JH8100_SYSCLK_USB_WRAP_312P5>,
+                 <&syscrg JH8100_SYSCLK_USB_125M>,
+                 <&nwcrg JH8100_NWCLK_GPIO_100>,
+                 <&syscrg JH8100_SYSCLK_PERH_ROOT>,
+                 <&syscrg JH8100_SYSCLK_MCLK>,
+                 <&syscrg JH8100_SYSCLK_PERH_ROOT_PREOSC>,
+                 <&syscrg JH8100_SYSCLK_AHB0>,
+                 <&syscrg JH8100_SYSCLK_APB_BUS_PER1>,
+                 <&syscrg JH8100_SYSCLK_APB_BUS_PER2>,
+                 <&syscrg JH8100_SYSCLK_APB_BUS_PER3>,
+                 <&syscrg JH8100_SYSCLK_APB_BUS_PER5>,
+                 <&syscrg JH8100_SYSCLK_VENC_ROOT>,
+                 <&syscrg JH8100_SYSCLK_SPI_CORE_100>,
+                 <&glb_ext_clk>, <&usb3_tap_tck_ext>,
+                 <&usb1_tap_tck_ext>, <&usb2_tap_tck_ext>,
+                 <&typec_tap_tck_ext>, <&spi_in0_ext>,
+                 <&spi_in1_ext>, <&i2stx_bclk_ext>,
+                 <&i2stx_lrck_ext>;
+        clock-names = "osc", "axi_400", "vout_root0", "vout_root1",
+                      "usb_wrap_480", "usb_wrap_625", "usb_wrap_240",
+                      "usb_wrap_60", "usb_wrap_156p25", "usb_wrap_312p5",
+                      "usb_125m", "gpio_100", "perh_root", "mclk",
+                      "perh_root_preosc", "ahb0", "apb_bus_per1",
+                      "apb_bus_per2", "apb_bus_per3", "apb_bus_per5",
+                      "venc_root", "spi_core_100", "glb-ext-clk",
+                      "usb3-tap-tck-ext", "usb1-tap-tck-ext",
+                      "usb2-tap-tck-ext", "typec-tap-tck-ext",
+                      "spi-in0-ext", "spi-in1-ext", "i2stx-bclk-ext",
+                      "i2stx-lrck-ext";
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh8100-crg.h b/include/dt-bindings/clock/starfive,jh8100-crg.h
index 626173e14940..c37b42f3eacd 100644
--- a/include/dt-bindings/clock/starfive,jh8100-crg.h
+++ b/include/dt-bindings/clock/starfive,jh8100-crg.h
@@ -162,4 +162,181 @@
 #define JH8100_NWCLK_UART5_ICG_EN					39
 #define JH8100_NWCLK_UART6_ICG_EN					40
 
+/* NECRG clocks */
+#define JH8100_NECLK_FLEXNOC_DMASLV					0
+#define JH8100_NECLK_MAILBOX_APB					1
+#define JH8100_NECLK_SR5_TIMER0_APB					2
+#define JH8100_NECLK_SR5_TIMER0_CH0					3
+#define JH8100_NECLK_SR5_TIMER0_CH1					4
+#define JH8100_NECLK_SR5_TIMER0_CH2					5
+#define JH8100_NECLK_SR5_TIMER0_CH3					6
+#define JH8100_NECLK_SR5_TIMER1_APB					7
+#define JH8100_NECLK_SR5_TIMER1_CH0					8
+#define JH8100_NECLK_SR5_TIMER1_CH1					9
+#define JH8100_NECLK_SR5_TIMER1_CH2					10
+#define JH8100_NECLK_SR5_TIMER1_CH3					11
+#define JH8100_NECLK_USB3_CMN_SCAN_PLL					12
+#define JH8100_NECLK_USB3_CMN_SCAN_SER					13
+#define JH8100_NECLK_USB3_PIPE_IN_SCAN					14
+#define JH8100_NECLK_USB3_SCAN_PIPE					15
+#define JH8100_NECLK_USB3_SCAN_PSM					16
+#define JH8100_NECLK_USB3_SCAN_REF					17
+#define JH8100_NECLK_USB3_USB2_SCAN					18
+#define JH8100_NECLK_USB3_HSCLK						19
+#define JH8100_NECLK_USB3_HSSICLK					20
+#define JH8100_NECLK_USB3_SIECLK					21
+#define JH8100_NECLK_USB3_XCVR_SCAN_PLL					22
+#define JH8100_NECLK_USB3_XCVR_SCAN_SER					23
+#define JH8100_NECLK_USB3_TAP_TCK					24
+#define JH8100_NECLK_USB1_CMN_SCAN_PLL					25
+#define JH8100_NECLK_USB1_CMN_SCAN_SER					26
+#define JH8100_NECLK_USB1_PIPE_IN_SCAN					27
+#define JH8100_NECLK_USB1_SCAN_PIPE					28
+#define JH8100_NECLK_USB1_SCAN_PSM					29
+#define JH8100_NECLK_USB1_SCAN_REF					30
+#define JH8100_NECLK_USB1_USB2_SCAN					31
+#define JH8100_NECLK_USB1_HSCLK						32
+#define JH8100_NECLK_USB1_HSSICLK					33
+#define JH8100_NECLK_USB1_SIECLK					34
+#define JH8100_NECLK_USB1_XCVR_SCAN_PLL					35
+#define JH8100_NECLK_USB1_XCVR_SCAN_SER					36
+#define JH8100_NECLK_USB1_TAP_TCK					37
+#define JH8100_NECLK_USB2_CMN_SCAN_PLL					38
+#define JH8100_NECLK_USB2_CMN_SCAN_SER					39
+#define JH8100_NECLK_USB2_PIPE_IN_SCAN					40
+#define JH8100_NECLK_USB2_SCAN_PIPE					41
+#define JH8100_NECLK_USB2_SCAN_PSM					42
+#define JH8100_NECLK_USB2_SCAN_REF					43
+#define JH8100_NECLK_USB2_USB2_SCAN					44
+#define JH8100_NECLK_USB2_HSCLK						45
+#define JH8100_NECLK_USB2_HSSICLK					46
+#define JH8100_NECLK_USB2_SIECLK					47
+#define JH8100_NECLK_USB2_XCVR_SCAN_PLL					48
+#define JH8100_NECLK_USB2_XCVR_SCAN_SER					49
+#define JH8100_NECLK_USB2_TAP_TCK					50
+#define JH8100_NECLK_TYPEC_PIPE_DIV_SCAN				51
+#define JH8100_NECLK_TYPEC_CMN_SCAN_PLL					52
+#define JH8100_NECLK_TYPEC_CMN_SCAN_SER					53
+#define JH8100_NECLK_TYPEC_SCAN_PIPE					54
+#define JH8100_NECLK_TYPEC_SCAN_PSM					55
+#define JH8100_NECLK_TYPEC_SCAN_REF					56
+#define JH8100_NECLK_TYPEC_USB2_SCAN					57
+#define JH8100_NECLK_TYPEC_HSCLK					58
+#define JH8100_NECLK_TYPEC_HSSICLK					59
+#define JH8100_NECLK_TYPEC_SIECLK					60
+#define JH8100_NECLK_TYPEC_VID0						61
+#define JH8100_NECLK_TYPEC_VID1						62
+#define JH8100_NECLK_TYPEC_XCVR_SCAN_PLL0				63
+#define JH8100_NECLK_TYPEC_XCVR_SCAN_PLL1				64
+#define JH8100_NECLK_TYPEC_XCVR_SCAN_PLL2				65
+#define JH8100_NECLK_TYPEC_XCVR_SCAN_PLL3				66
+#define JH8100_NECLK_TYPEC_XCVR_SCAN_SER0				67
+#define JH8100_NECLK_TYPEC_XCVR_SCAN_SER1				68
+#define JH8100_NECLK_TYPEC_XCVR_SCAN_SER2				69
+#define JH8100_NECLK_TYPEC_XCVR_SCAN_SER3				70
+#define JH8100_NECLK_TYPEC_TAP_TCK					71
+#define JH8100_NECLK_VENC_AXI						72
+#define JH8100_NECLK_VC9000LE_AXI					73
+#define JH8100_NECLK_VC9000LE_APB					74
+#define JH8100_NECLK_VC9000LE_CORECLK					75
+#define JH8100_NECLK_INT_CTRL_APB					76
+#define JH8100_NECLK_PWM_8CH_APB					77
+#define JH8100_NECLK_WDT_APB						78
+#define JH8100_NECLK_WDT						79
+#define JH8100_NECLK_SPI0_APB						80
+#define JH8100_NECLK_SPI0_CORE						81
+#define JH8100_NECLK_SPI0_SCLK_IN					82
+#define JH8100_NECLK_SPI1_APB						83
+#define JH8100_NECLK_SPI1_CORE						84
+#define JH8100_NECLK_SPI1_SCLK_IN					85
+#define JH8100_NECLK_I2C0_APB						86
+#define JH8100_NECLK_I2C1_APB						87
+#define JH8100_NECLK_I2C2_APB						88
+#define JH8100_NECLK_I2C3_APB						89
+#define JH8100_NECLK_I2C4_APB						90
+#define JH8100_NECLK_I2C5_APB						91
+#define JH8100_NECLK_UART0_APB						92
+#define JH8100_NECLK_UART0_CORE						93
+#define JH8100_NECLK_UART1_CORE_PREOSC					94
+#define JH8100_NECLK_UART1_APB						95
+#define JH8100_NECLK_UART1_CORE						96
+#define JH8100_NECLK_UART2_CORE_PREOSC					97
+#define JH8100_NECLK_UART2_APB						98
+#define JH8100_NECLK_UART2_CORE						99
+#define JH8100_NECLK_UART3_CORE_PREOSC					100
+#define JH8100_NECLK_UART3_APB						101
+#define JH8100_NECLK_UART3_CORE						102
+#define JH8100_NECLK_UART4_CORE_PREOSC					103
+#define JH8100_NECLK_UART4_APB						104
+#define JH8100_NECLK_UART4_CORE						105
+#define JH8100_NECLK_I2S0_BCLK						106
+#define JH8100_NECLK_I2S0_LRCK						107
+#define JH8100_NECLK_I2S0_APB						108
+#define JH8100_NECLK_I2S0						109
+#define JH8100_NECLK_I2S0_N						110
+#define JH8100_NECLK_I2S0_BCLK_TX					111
+#define JH8100_NECLK_I2S0_LRCK_TX					112
+#define JH8100_NECLK_I2S0_BCLK_RX					113
+#define JH8100_NECLK_I2S0_LRCK_RX					114
+#define JH8100_NECLK_I2S1_BCLK						115
+#define JH8100_NECLK_I2S1_LRCK						116
+#define JH8100_NECLK_I2S1_APB						117
+#define JH8100_NECLK_I2S1						118
+#define JH8100_NECLK_I2S1_N						119
+#define JH8100_NECLK_I2S1_BCLK_TX					120
+#define JH8100_NECLK_I2S1_LRCK_TX					121
+#define JH8100_NECLK_I2S1_BCLK_RX					122
+#define JH8100_NECLK_I2S1_LRCK_RX					123
+#define JH8100_NECLK_I2S2_BCLK						124
+#define JH8100_NECLK_I2S2_LRCK						125
+#define JH8100_NECLK_I2S2_APB						126
+#define JH8100_NECLK_I2S2						127
+#define JH8100_NECLK_I2S2_N						128
+#define JH8100_NECLK_I2S2_BCLK_TX					129
+#define JH8100_NECLK_I2S2_LRCK_TX					130
+#define JH8100_NECLK_I2S2_BCLK_RX					131
+#define JH8100_NECLK_I2S2_LRCK_RX					132
+#define JH8100_NECLK_I2S3_BCLK						133
+#define JH8100_NECLK_I2S3_LRCK						134
+#define JH8100_NECLK_I2S0_STEREO_APB					135
+#define JH8100_NECLK_I2S0_STEREO					136
+#define JH8100_NECLK_I2S0_STEREO_N					137
+#define JH8100_NECLK_I2S0_STEREO_BCLK_TX				138
+#define JH8100_NECLK_I2S0_STEREO_LRCK_TX				139
+#define JH8100_NECLK_I2S0_STEREO_BCLK_RX_ICG				140
+#define JH8100_NECLK_I2S0_STEREO_LRCK_RX				141
+#define JH8100_NECLK_PDM_4MIC_DMIC					142
+#define JH8100_NECLK_PDM_4MIC_APB					143
+#define JH8100_NECLK_PDM_4MIC_SCAN					144
+#define JH8100_NECLK_CAN0_CTRL_PCLK					145
+#define JH8100_NECLK_CAN0_CTRL						146
+#define JH8100_NECLK_CAN0_CTRL_TIMER					147
+#define JH8100_NECLK_CAN1_CTRL_PCLK					148
+#define JH8100_NECLK_CAN1_CTRL						149
+#define JH8100_NECLK_CAN1_CTRL_TIMER					150
+#define JH8100_NECLK_SMBUS0_APB						151
+#define JH8100_NECLK_SMBUS0_CORE					152
+#define JH8100_NECLK_IOMUX_EAST_PCLK					153
+#define JH8100_NECLK_USB3_ICG_EN					154
+#define JH8100_NECLK_USB1_ICG_EN					155
+#define JH8100_NECLK_USB2_ICG_EN					156
+#define JH8100_NECLK_USBC_ICG_EN					157
+#define JH8100_NECLK_VENC_ICG_EN					158
+#define JH8100_NECLK_WDT0_ICG_EN					159
+#define JH8100_NECLK_SPI0_ICG_EN					160
+#define JH8100_NECLK_SPI1_ICG_EN					161
+#define JH8100_NECLK_UART0_ICG_EN					162
+#define JH8100_NECLK_UART1_ICG_EN					163
+#define JH8100_NECLK_UART2_ICG_EN					164
+#define JH8100_NECLK_UART3_ICG_EN					165
+#define JH8100_NECLK_UART4_ICG_EN					166
+#define JH8100_NECLK_I2S0_ICG_EN					167
+#define JH8100_NECLK_I2S1_ICG_EN					168
+#define JH8100_NECLK_I2S2_ICG_EN					169
+#define JH8100_NECLK_I2S_STEREO_ICG_EN					170
+#define JH8100_NECLK_PDM_4MIC_ICG_EN					171
+#define JH8100_NECLK_CAN0_ICG_EN					172
+#define JH8100_NECLK_CAN1_ICG_EN					173
+#define JH8100_NECLK_SMBUS0_ICG_EN					174
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh8100-crg.h b/include/dt-bindings/reset/starfive,jh8100-crg.h
index b25f6522f3d4..30a99c78341a 100644
--- a/include/dt-bindings/reset/starfive,jh8100-crg.h
+++ b/include/dt-bindings/reset/starfive,jh8100-crg.h
@@ -32,4 +32,63 @@
 #define JH8100_NWRST_MERAK0_TVSENSOR				8
 #define JH8100_NWRST_MERAK1_TVSENSOR				9
 
+/*
+ * NECRG resets: assert0
+ */
+#define JH8100_NERST_PRESETN					0
+#define JH8100_NERST_USB3_APB					1
+#define JH8100_NERST_USB3_TORR_PHY				2
+#define JH8100_NERST_USB3_CONFIG				3
+#define JH8100_NERST_USB1_APB					4
+#define JH8100_NERST_USB1_TORRENT_PHY				5
+#define JH8100_NERST_USB1_CONFIG				6
+#define JH8100_NERST_USB2_APB					7
+#define JH8100_NERST_USB2_TORRENT_PHY				8
+#define JH8100_NERST_USB2_CONFIG				9
+#define JH8100_NERST_USBC_APB					10
+#define JH8100_NERST_USBC_CONFIG				11
+#define JH8100_NERST_VC9000LE					12
+#define JH8100_NERST_INT_CTRL_APB				13
+#define JH8100_NERST_PWM_8CH_APB				14
+#define JH8100_NERST_WDT0					15
+#define JH8100_NERST_SPI0					16
+#define JH8100_NERST_SPI1					17
+#define JH8100_NERST_I2C0					18
+#define JH8100_NERST_I2C1					19
+#define JH8100_NERST_I2C2					20
+#define JH8100_NERST_I2C3					21
+#define JH8100_NERST_I2C4					22
+#define JH8100_NERST_I2C5					23
+#define JH8100_NERST_UART0					24
+#define JH8100_NERST_UART1					25
+#define JH8100_NERST_UART2					26
+#define JH8100_NERST_UART3					27
+#define JH8100_NERST_UART4					28
+#define JH8100_NERST_MAILBOX_PRESETN				29
+#define JH8100_NERST_TIMER0_APB					30
+#define JH8100_NERST_TIMER0_CH0					31
+
+/*
+ * NECRG resets: assert1
+ */
+
+#define JH8100_NERST_TIMER0_CH1					32
+#define JH8100_NERST_TIMER0_CH2					33
+#define JH8100_NERST_TIMER0_CH3					34
+#define JH8100_NERST_TIMER1_APB					35
+#define JH8100_NERST_TIMER1_CH0					36
+#define JH8100_NERST_TIMER1_CH1					37
+#define JH8100_NERST_TIMER1_CH2					38
+#define JH8100_NERST_TIMER1_CH3					39
+#define JH8100_NERST_I2S0_RSTN_APB				40
+#define JH8100_NERST_I2S1_RSTN_APB				41
+#define JH8100_NERST_I2S2_RSTN_APB				42
+#define JH8100_NERST_I2S0_STEREO_APB				43
+#define JH8100_NERST_PDM					44
+#define JH8100_NERST_CAN0					45
+#define JH8100_NERST_CAN1					46
+#define JH8100_NERST_SMBUS0					47
+#define JH8100_NERST_SYS_IOMUX_E				48
+#define JH8100_NERST_DUBHE_TVSENSOR				49
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JH8100_H__ */
-- 
2.34.1


