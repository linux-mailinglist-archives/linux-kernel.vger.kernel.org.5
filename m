Return-Path: <linux-kernel+bounces-22235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3C829B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630CAB20B15
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA0448CCE;
	Wed, 10 Jan 2024 13:32:22 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2051.outbound.protection.partner.outlook.cn [139.219.146.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D0248CC3;
	Wed, 10 Jan 2024 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqrK3H0DGc4ASFng5Q9t1CUUBY8kLEz+0djvFFX5biOcVYF8dxio8OAo51h8R/p/QtOTNG2MEiXG/779JJY0PvP0ZhCrRwEYroWBQavuIeAOasyN0Izy6sVNgJ6vJXP0CjopslUX1odrB4PHXhA1ygn4YMg1Ul69M5C2aCWUSt5tJUZp7wUUr85FlHXCdEOoaNDLj+QBxbBMWp86/iz/P8SMkR3CXAX/ki4TMxmnqBoCuGM1yx1X814ejb+OmSI1sTvQcuVCgIkMgeUNkPZGe4RNpjLhoIotkbnCs5EZFeS80NcLZIyMMhbXkvNQFD3mqg6ySizcDcgkPVgfTJlFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGTdrvMf3V+j6XKfQX8+cel+jy9nwGvJoJXk7ZIf5/U=;
 b=efloWJQLRJjkTvW+FlyvI+TBZf4mudDhCYGP2X9h/QdPaw+ShdIRVln7Hk3DSJbC/aUSx39JkqPKVA48e/wYOv/2J/ueL/+yjX22o/NHGB094p628mR4LAJVL0sFQuPRp5tkAcgCH2o6ZuCve0nEZ8H7ojiglaxS7movgLAj1pk0iXXo9TmU6h2ARatQytHESUAIdC8w7laSqTx+wPI8pFDN+TY4xMzQgUC2nvxHVIfUUMLNNv0cYUCvm7/QhiW36RDy9zbJy8xZaJGHU1pO2+RAQO6hNZcVz19VpkFDK5aSAwb+jt/xkH0T7caIrKetd2tyFy4KxZle+agp70AtXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0626.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:32:08 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:32:08 +0000
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
Subject: [RFC v3 07/16] dt-bindings: clock: Add StarFive JH8100 North-West clock and reset generator
Date: Wed, 10 Jan 2024 21:31:19 +0800
Message-Id: <20240110133128.286657-8-jeeheng.sia@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8630f33a-9d50-4c7d-c237-08dc11e08b1a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+um0bp0235BtF9LaGvx/92Ce3Sg9ISbnfKrbVhZCuBaUoq9SSFVUX9cDpahm3Wl8DCLLoJmHH789suHjdaA9EZVSpV5AlPPLKIVT5yI6HhWGNrCkPktH1hvFTsIjfluMr/KDfUWx4jyjXN8qt2G3wXmsRW62DtMtlvwt9BXWdOOqvQG/eGdKbZZ6Ws+gdsL4HY0/F1qmdYHczywaEx/83VnL10MBXmHscW8LOPMIjONFI2BebAMP8RoNz0O1MijaJyfP0UPoLFYv4oNkrXw7rG4+8heAsDtzL7oUdN48jUNnwiufTHaCh9pGsUeFZpe+FDVj0jUTWTV5WAJbzz2283iDHazCWMT56hfecl6+FoYd18v7ArlKc30xPMvnvfEcORV7rzKWyqCgS3dwB719EFjJ0CgxV8yF1f9IZFvz7rtcaxeRCg/SWyCil+Oi0lBGadJl78kuxQovrNmU9BHXDQxuLUxKPxz5rgAqk79gmjVr7s6clIeJLZdNgC2XY/GMWLgpGSrvtCeqmEhdLnX3Zqsx4FnweqwnT6v4ASXx5MP3CtdZ5/NWodqe14suWTgyDjsG7Ly+TToXPJY3JlWOP0K+9oML+7z1DiNZr+7UjdtIRh0IcfejD+UQxkId3M2x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(346002)(396003)(366004)(230273577357003)(230922051799003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(921011)(26005)(52116002)(2616005)(41320700001)(6666004)(83380400001)(1076003)(86362001)(40160700002)(40180700001)(38100700002)(36756003)(38350700005)(5660300002)(7416002)(4326008)(55236004)(6636002)(66556008)(66476007)(66946007)(41300700001)(2906002)(8936002)(8676002)(966005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v6Vwz7tOq2fJhCOwmwAuvqFQ4EHEyUr+XGL2NbPQ6bvGR3Rm+cV8KKUEdNhx?=
 =?us-ascii?Q?alT+0RHKyMGfog2ifzs0rYx70xdtEvqUW9kAMBfeVfQldoCdE58zXTuVj8cg?=
 =?us-ascii?Q?4VJADs7fTyDiV9cUsLIQImG3POoOIzF1NwSBBsaD/jbS0+oU6zyhmbsQllhR?=
 =?us-ascii?Q?evj9BH96Z34+VmRXd5LIqfDUdNpGRjZOhzQqf76HnUxitMSpvqOcp3HliYEf?=
 =?us-ascii?Q?o6jiBCtoHKxT0YMiWGLl6dls/8dkytmQqyDKb4riIxwykTD2Y1aggwVD7pnS?=
 =?us-ascii?Q?8FEukrNVnBXDXDetuXyX7HJpzFbu3fhliAQSnfPfR+lK0pSl/pXkSccF2ZJ3?=
 =?us-ascii?Q?41Z0ubUX43IvacaFV/gvbmd1D9mH5BKCNkOWNqgmGl/UWyLjOR850EJtSb1M?=
 =?us-ascii?Q?ntqQ/rW4LgkacXxk3v5vTwPyWldvmDjJQaEfFEq8x/6bySNMPxON9vJZyUmf?=
 =?us-ascii?Q?OP57DboDjP8+RAKCuce2E0ZJcrisDT5AQdaiU4sDbid2qcrUJKnwmDO207r3?=
 =?us-ascii?Q?WtuGleMvL6lp5g6UHF1uTRS0LScLwOfp9X32kWJ38S+nMnUTFjgOsx/FFK4z?=
 =?us-ascii?Q?y3focZG9Q7KjgFbJSgKeiB3YLTzMTlpmRGIQ851HeqrhF3WpodpIVt2Gt+S5?=
 =?us-ascii?Q?gtBJEj4owTsJMdkNH2m8t3QrFgdSDDP6MrMkT3yDiJmiW5OIu31zS2PjhK3x?=
 =?us-ascii?Q?qdPhjut+toUB1UMRNd17pdJLjX0yib+n5A8X/UBDkIsP+ULvWphhUyvEIYpz?=
 =?us-ascii?Q?RnrSU7dmzcNZZMtT7dL5p7i4Nbb1Qlejws4W0SILy41HfB8LQoJlfI9ljplY?=
 =?us-ascii?Q?+5c67Rkl6YvsH9g5ZneguK84SdhWZ45NKZ+g91OS+GUP0KpyytwOahGbaddf?=
 =?us-ascii?Q?RvQx4cwTkNTGYXcc7u5+Ht5BgHxGeRrqMGjXH6XLmQmy3GFBs+rRbCK6xYcY?=
 =?us-ascii?Q?U4sJaEChfH2UkOagNgsjA2fMLvbiA66iPaNwy3do2OJwNhE2Y07zhfKoaStF?=
 =?us-ascii?Q?66uic2KNRjMClLok7A3yql75shd+SnfUIoKOmkhLHap7oe1GvTOAywW0px3k?=
 =?us-ascii?Q?gokoOo6tfwOeansW27HW+D7RyWBYsrA88zu9Gh0iwnuZnLYMnYzNqa5UWOgb?=
 =?us-ascii?Q?O7R4jBPBRCes5AOAmFxCXc/SojQ8k4vZ74p0rWuxHQrCOuPUs4LIAJu+GQl1?=
 =?us-ascii?Q?zIw6hpnVlWkWcRHP/2Lb++9rlxoeBuuquA2Q5hgsU9MJEZTbsJp2iX1P9jvA?=
 =?us-ascii?Q?JFhvTn5myIKvqMAhGUhB0xw4RF+1EbYjXScH+fYHNsrqPdBxFr9y4T+xWs4r?=
 =?us-ascii?Q?YLZ2DaWhznornmRa0IjCJL1mzKc+V31OLi2Ezq8H2T/0fUwQAkNPSvpODcIO?=
 =?us-ascii?Q?+acZgR0uAuiyhyhtecEytKRSP55zObn8GeFrZHB8BtyKP+BP4xAAPVOS4203?=
 =?us-ascii?Q?m8heD1jdVFZonecmvMdjbRtBT2LN8J7EXaeqfapMgVDI7Hvj7UAqkaIjiaQ7?=
 =?us-ascii?Q?H/YLAEWwQKo/CVgMqyFPgVWzDEHKZMlldQ1FAyKYDDY//YzLa5KvDMRDokb7?=
 =?us-ascii?Q?NsnvsJJ6vQPA6yrrFp4Y80OGIwW4wixh5jpvfXlRRy3VAoqEvdpk4LqWe7Rp?=
 =?us-ascii?Q?anxlXbIDqHyorY5frmoWO2g=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8630f33a-9d50-4c7d-c237-08dc11e08b1a
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:32:08.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYoEwLvyOsJmHvK15nA+NpGq/ba/BmIZCWSmW3fHh4g80+uIodNDh93E4zD2GFfifhCqQPtaBplwA6t0u3s4p4tSf0E4l7fssmmjTq5ilGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0626

Add bindings for the North-West clock and reset generator (NWCRG) on
JH8100 SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/starfive,jh8100-nwcrg.yaml | 119 ++++++++++++++++++
 .../dt-bindings/clock/starfive,jh8100-crg.h   |  43 +++++++
 .../dt-bindings/reset/starfive,jh8100-crg.h   |  14 +++
 3 files changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh8100-nwcrg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh8100-nwcrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh8100-nwcrg.yaml
new file mode 100644
index 000000000000..be0f94e64e6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh8100-nwcrg.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh8100-nwcrg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 North-West Clock and Reset Generator
+
+maintainers:
+  - Sia Jee Heng <jeeheng.sia@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-nwcrg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (24 MHz)
+      - description: APB_BUS clock from SYSCRG
+      - description: APB_BUS_PER4 clock from SYSCRG
+      - description: SPI_CORE_100 clock from SYSCRG
+      - description: ISP_2X clock from SYSCRG
+      - description: ISP_AXI clock from SYSCRG
+      - description: VOUT_ROOT0 clock from SYSCRG
+      - description: VOUT_ROOT1 clock from SYSCRG
+      - description: VOUT_SCAN_ATS clock from SYSCRG
+      - description: VOUT_DC_CORE clock from SYSCRG
+      - description: VOUT_AXI clock from SYSCRG
+      - description: AXI_400 clock from SYSCRG
+      - description: AHB0 clock from SYSCRG
+      - description: PERH_ROOT_PREOSC from SYSCRG
+      - description: External DVP clock
+      - description: External ISP DPHY TAP TCK clock
+      - description: External golbal clock
+      - description: External VOUT MIPI DPHY TAP TCK
+      - description: External VOUT eDP TAP TCK
+      - description: External SPI In2 clock
+      - description: PLL5
+
+  clock-names:
+    items:
+      - const: osc
+      - const: apb_bus
+      - const: apb_bus_per4
+      - const: spi_core_100
+      - const: isp_2x
+      - const: isp_axi
+      - const: vout_root0
+      - const: vout_root1
+      - const: vout_scan_ats
+      - const: vout_dc_core
+      - const: vout_axi
+      - const: axi_400
+      - const: ahb0
+      - const: perh_root_preosc
+      - const: dvp-ext
+      - const: isp-dphy-tap-tck-ext
+      - const: glb-ext-clk
+      - const: vout-mipi-dphy-tap-tck-ext
+      - const: vout-edp-tap-tck-ext
+      - const: spi-in2-ext
+      - const: pll5
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
+    clock-controller@123c0000 {
+        compatible = "starfive,jh8100-nwcrg";
+        reg = <0x123c0000 0x10000>;
+        clocks = <&osc>, <&syscrg JH8100_SYSCLK_APB_BUS>,
+                 <&syscrg JH8100_SYSCLK_APB_BUS_PER4>,
+                 <&syscrh JH8100_SYSCLK_SPI_CORE_100>,
+                 <&syscrg JH8100_SYSCLK_ISP_2X>,
+                 <&syscrg JH8100_SYSCLK_ISP_AXI>,
+                 <&syscrg JH8100_SYSCLK_VOUT_ROOT0>,
+                 <&syscrg JH8100_SYSCLK_VOUT_ROOT1>,
+                 <&syscrg JH8100_SYSCLK_VOUT_SCAN_ATS>,
+                 <&syscrg JH8100_SYSCLK_VOUT_DC_CORE>,
+                 <&syscrg JH8100_SYSCLK_VOUT_AXI>,
+                 <&syscrg JH8100_SYSCLK_AXI_400>,
+                 <&syscrg JH8100_SYSCLK_AHB0>,
+                 <&syscrg JH8100_SYSCLK_PERH_ROOT_PREOSC>,
+                 <&dvp_ext>, <&isp_dphy_tap_tck_ext>,
+                 <&glb_ext_clk>, <&vout_mipi_dphy_tap_tck_ext>,
+                 <&vout_edp_tap_tck_ext>, <&spi_in2_ext>, <&pll5>;
+        clock-names = "osc", "apb_bus", "apb_bus_per4", "spi_core_100",
+                      "isp_2x", "isp_axi", "vout_root0", "vout_root1",
+                      "vout_scan_ats", "vout_dc_core", "vout_axi",
+                      "axi_400", "ahb0", "perh_root_preosc", "dvp-ext",
+                      "isp-dphy-tap-tck-ext", "glb-ext-clk",
+                      "vout-mipi-dphy-tap-tck-ext", "vout-edp-tap-tck-ext",
+                      "spi-in2-ext", "pll5";
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh8100-crg.h b/include/dt-bindings/clock/starfive,jh8100-crg.h
index 611613961e17..626173e14940 100644
--- a/include/dt-bindings/clock/starfive,jh8100-crg.h
+++ b/include/dt-bindings/clock/starfive,jh8100-crg.h
@@ -119,4 +119,47 @@
 #define JH8100_SYSCLK_HD_AUDIO_ICG_EN					107
 #define JH8100_SYSCLK_NNE_ICG_EN					108
 
+/* NWCRG clocks */
+#define JH8100_NWCLK_PLL5_DIV2						0
+#define JH8100_NWCLK_GCLK5						1
+#define JH8100_NWCLK_GPIO_100						2
+#define JH8100_NWCLK_GPIO_50						3
+#define JH8100_NWCLK_GPIO_150						4
+#define JH8100_NWCLK_GPIO_60						5
+#define JH8100_NWCLK_IOMUX_WEST_PCLK					6
+#define JH8100_NWCLK_I2C6_APB						7
+#define JH8100_NWCLK_I2C7_APB						8
+#define JH8100_NWCLK_SPI2_APB						9
+#define JH8100_NWCLK_SPI2_CORE						10
+#define JH8100_NWCLK_SPI2_SCLK_IN					11
+#define JH8100_NWCLK_SMBUS1_APB						12
+#define JH8100_NWCLK_SMBUS1_CORE					13
+#define JH8100_NWCLK_ISP_DVP						14
+#define JH8100_NWCLK_ISP_CORE_2X					15
+#define JH8100_NWCLK_ISP_AXI						16
+#define JH8100_NWCLK_ISP_DPHY_TAP_TCK					17
+#define JH8100_NWCLK_FLEXNOC_ISPSLV					18
+#define JH8100_NWCLK_VOUT_PIX0						19
+#define JH8100_NWCLK_VOUT_PIX1						20
+#define JH8100_NWCLK_VOUT_SCAN_ATS					21
+#define JH8100_NWCLK_VOUT_DC_CORE					22
+#define JH8100_NWCLK_VOUT_APB						23
+#define JH8100_NWCLK_VOUT_DSI						24
+#define JH8100_NWCLK_VOUT_AHB						25
+#define JH8100_NWCLK_VOUT_AXI						26
+#define JH8100_NWCLK_VOUT_MIPI_DPHY_TAP_TCK				27
+#define JH8100_NWCLK_VOUT_EDP_PHY_TAP_TCK				28
+#define JH8100_NWCLK_UART5_CORE_PREOSC					29
+#define JH8100_NWCLK_UART5_APB						30
+#define JH8100_NWCLK_UART5_CORE						31
+#define JH8100_NWCLK_UART6_CORE_PREOSC					32
+#define JH8100_NWCLK_UART6_APB						33
+#define JH8100_NWCLK_UART6_CORE						34
+#define JH8100_NWCLK_SPI2_ICG_EN					35
+#define JH8100_NWCLK_SMBUS1_ICG_EN					36
+#define JH8100_NWCLK_ISP_ICG_EN						37
+#define JH8100_NWCLK_VOUT_ICG_EN					38
+#define JH8100_NWCLK_UART5_ICG_EN					39
+#define JH8100_NWCLK_UART6_ICG_EN					40
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh8100-crg.h b/include/dt-bindings/reset/starfive,jh8100-crg.h
index c4e2501491ab..b25f6522f3d4 100644
--- a/include/dt-bindings/reset/starfive,jh8100-crg.h
+++ b/include/dt-bindings/reset/starfive,jh8100-crg.h
@@ -18,4 +18,18 @@
 #define JH8100_SYSRST_NNE					6
 #define JH8100_SYSRST_HD_AUDIO					7
 
+/*
+ * NWCRG resets: assert0
+ */
+#define JH8100_NWRST_PRESETN					0
+#define JH8100_NWRST_SYS_IOMUX_W				1
+#define JH8100_NWRST_I2C6					2
+#define JH8100_NWRST_I2C7					3
+#define JH8100_NWRST_SPI2					4
+#define JH8100_NWRST_SMBUS1					5
+#define JH8100_NWRST_UART5					6
+#define JH8100_NWRST_UART6					7
+#define JH8100_NWRST_MERAK0_TVSENSOR				8
+#define JH8100_NWRST_MERAK1_TVSENSOR				9
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JH8100_H__ */
-- 
2.34.1


