Return-Path: <linux-kernel+bounces-22268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEF8829B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5567D1F246C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B87A48CEF;
	Wed, 10 Jan 2024 13:47:48 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2080.outbound.protection.partner.outlook.cn [139.219.17.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E084176B;
	Wed, 10 Jan 2024 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5R1flFFzrEjiVSbfLv83qEwCzxPVjlRM45DVfZVzeVLNGW1N2qP5HVKJl7NpLwv6OqmTSNK4wb9uwUpL26B6U1A3k0T0Vcp2yDvibrnGQ8q6U82A9auXoZ8Xy4M6e88xCpjvIh2iMRwJrAwtLxNrl35XXgPzuX5eYBWkiAr5WZiriRvitRx0CfWe7p5df7B7lCABV2jjly9gribE29jNlgJW1bV33ORN7t1mZfFn7slpZd76kf1ZXdIWf7Zbf2SDUMkKczZZJbXeMEM1KZBi76lTwIJ0eIDrRq+lvp5A0cE3/aAIFoOmrxgDNUs5HLW5Q2nKJMw0SA0FAre7TZK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ4mvyrT6i9c2vFdoxJNtLD2ewK3tmwEKiOMAJbdP2c=;
 b=ekNXtRWkK7e7NxVWAXixBysuYlbSLqXetr5VGp9M/oUdZHltSHcE6ROy6sVpZ8wE2aM573301kZZKXoO8+IMrGBUP1nmJB7U4XGC4MxYWmdw08fWBrqjsvCJhtEZs3WactE8mLrrjEKB6ZvuzuRawJX3wexgMjm0DjwSQ4Dy1DyV0YxpJjQ26UJwDj0THiGOXyt16hzZf+kNvTSAavVsyFv98VM+2ZSsfuMhf6o71NSf0PNpzzAXUQvp3g7M/bt6nObBCHKwqgt7/MRyNsDJPgbtizs3EpTKUAe9Ftne8QFCl+ool2cdjxBRSzzyjQ16t/jpwp5/TPesY5hemrOODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0626.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:32:42 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:32:42 +0000
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
	leyfoon.tan@starfivetech.com
Subject: [RFC v3 16/16] riscv: dts: starfive: jh8100: Add clocks and resets nodes
Date: Wed, 10 Jan 2024 21:31:28 +0800
Message-Id: <20240110133128.286657-17-jeeheng.sia@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 94b13b7a-04ff-48f3-731c-08dc11e09f14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qtlDHrn5DU5NirGFrgM4Usm3w/MWRK7AhKdsePy09sFUJrJ3/cQ3UVu4tzKqUsKGKiBIOk3Idt0QvkzFTraTB5hnruv+1zl2AZDmG5zIXeDgppoKNyziGICRQuJbpXt/1NxLqN9em7bbqO/d66uK0FusKrC3xhY9RfXvLIVI+ZFm+SpsS0pga4CD3SzbPdYwAYE8J7Xs1gEX4KZYxRpVD0l9zbEAIvoOd5/ukoaAIFJhlIzu09L/HYrPoYYfokCdSkqDRwjkFBjlp6rhBJ8I3RwrviWm275aED/UMVtSKA2A296kvpVG2QKdV7KjOWVWbTkXlWdbOQDSLLmwZiuZWbss93S40WwEInteSYW9hiGdtXQmtM/cxZ/c7dKYKAyf2EK/XyQRE1BwG+vCLudL86fwutTPQfY35jPdZ7SUeuNPD6QlfJCLLZu5EJVCLsW74MxWcbymMsxfUt7TAIU4DBVM9tcogvw1516vTaRXHNDvQ55B9QiUMisD9XCJRKUt1Kkt1K5b+JKkXscBSBjqSukPNsn7Kvk8m88GqNbBF20ZYcxLZiFoakM/YQ48fGj0msGcJyIuAgKaJyC4u94MDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(346002)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(921011)(26005)(107886003)(52116002)(2616005)(41320700001)(6666004)(83380400001)(1076003)(86362001)(40160700002)(40180700001)(38100700002)(36756003)(38350700005)(5660300002)(7416002)(4326008)(55236004)(6636002)(66556008)(66476007)(66946007)(41300700001)(2906002)(8936002)(8676002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?erRgXhahq7a/kKrSyi7Ws/mUO/b3tMOPENzVOaks3SgdwokI5p6p0eOTCa5k?=
 =?us-ascii?Q?5OuZA05ip1rmFIKxwLuOsgiq8Y10IVlmm9r1UBqF7FSNS4Bjbw0RWI0cHpFN?=
 =?us-ascii?Q?UfRAnG11Wl51A64G+czEG1FBDWCuIiajNemTYj7LrE1nxI9audzJZ+rI+hVg?=
 =?us-ascii?Q?sQMSFqr0ZIH1pUzYhgbyxRHMQrEdHffCUFdMp9YrovFuRssFfs5utneEYsaa?=
 =?us-ascii?Q?/JuXUkqbwVdhCRNVbfNJL9dUohI6YJWU/xAMMNDX23RT5yShlq1K5orE2WRN?=
 =?us-ascii?Q?ILa2WDvZz5e4/W9jrfZcaYLT7gDPYeCfnkdOibqeBFPopORmo9TRb13HU/W5?=
 =?us-ascii?Q?1XWKL92VawzrVfBdxh7Eyvn1bScrn4MTNLqHm46oRmP3jbJSWQKIPXvx3gz+?=
 =?us-ascii?Q?ZF7ZaVBCKmMM0xwCvz+mpygWLIlPj6cf421/U770jKYd88MOXxvrfBsWakBz?=
 =?us-ascii?Q?9v3u0NLwViNss+QihN3lH10DMLpEq5Xtxf3IJPzw59dr2YECcU6Ny5eTtRaL?=
 =?us-ascii?Q?txQHAuh8jHyoPs3dbUD/tWUeORYcsNuWKLeLjFD+orOHNkYsoO8iFTHmi2J7?=
 =?us-ascii?Q?Is5TbcK8dc1jhA+eowGXCBnuHuSiwccQjblHf9k2alUra4IMDkgVZNY2lAzX?=
 =?us-ascii?Q?ICIrTegnXXU5lKD5uGz9f8p2LH3XlBF1cycKvh2+Ww0/FejDOnFLi6yJqO8r?=
 =?us-ascii?Q?bBjQ9i8Pz9ccvoi6K37vUqMHsl+q7LzDhdyB1dJjWEoE/YmOxu18J9Z40wC/?=
 =?us-ascii?Q?ZEvUpgkCfMjo6849+n72+enQ+jep1LNnXbPODcYMLQWpCtRyahEs39HzU3q1?=
 =?us-ascii?Q?hiGmSgtovdLJv45ZAbr9jCX60ZtkhA2r+Y6QhHdXp3maoZ2hC6HrV+LXMotI?=
 =?us-ascii?Q?DrvxwwSna2Hwo3y9fIH981O7p63TqjASS+oAryMPoTBEa5kY4wbIO2EK4th3?=
 =?us-ascii?Q?ekXYTm3T4CjN0adjFG0RbduZFwUO/ulVLKpVPP/O3qC4BspcFmAfHEGPvVZu?=
 =?us-ascii?Q?01oZrnyWqAsYy7wlqHmJMxcTXh+bQxZktvRYibIl4p9QMsLQ+LSMn211jAJt?=
 =?us-ascii?Q?zWcuLbGJJqYOQXQu0FhW1obxBakPyY1v6qLFGH0bRkOEyqaHBJ+ZJ39M5k3p?=
 =?us-ascii?Q?qMmYHlfRYYgvQu1b42ybAyKuek/CKf1qD8WfgXg5UOehmiB7kW3dfmNlwjxN?=
 =?us-ascii?Q?JFOcD0ytTNB6F8n1HbGicedDCx/87Bhew5R4qEcba+9zEffTWHwbTsqhLrDT?=
 =?us-ascii?Q?+FWTUB72GzZLAx49cY7wFjqfbilZ7phmN5FvbAXshv/WxewSPxZxgheU2q4e?=
 =?us-ascii?Q?GztSLiF+cI0cKtuCzjY1qBRhXdgpfrMrAH1+ASj4YS9p43WRhlj09o/CqQFG?=
 =?us-ascii?Q?EYTqDW3i5Co97JvogniY/ew6SWywcfUniF0857SxlMSsR/s8cCuLG0GoShSH?=
 =?us-ascii?Q?WI3Jjqu38WMqnuCG7rNxBCRawD009hFxHIj06enzpPJIWuvegZM7J2CXtyvZ?=
 =?us-ascii?Q?LvtHsul0iG4A9y7hE1+wp2MpeikUdH0DbwP6JQci7OsoAlNitpOfWTlyy2z/?=
 =?us-ascii?Q?QpaE3c2ZwON/8IC3ePxAp6OU0N709FAoC9NyPB0VnoKkG6WqKdQJYx7XtcMK?=
 =?us-ascii?Q?E6p6OX/+uybniNqI3mtmHiU=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b13b7a-04ff-48f3-731c-08dc11e09f14
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:32:42.0823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCa3lBUCLhp5bc3CVPulu59GXzxE11rPETiZ6SiiXMkhMLLL8cbX1NH8OxI5i0oaoNsig9+bbJRmFu/fUpcHcHicPZUu0jahztBe7lBGWb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0626

Add SYSCRG/SYSCRG-NE/SYSCRG-NW/SYSCRG-SW/AONCRG clock and reset
nodes for JH8100 RISC-V SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh8100.dtsi | 313 +++++++++++++++++++++++
 1 file changed, 313 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh8100.dtsi b/arch/riscv/boot/dts/starfive/jh8100.dtsi
index f26aff5c1ddf..5ba826e38ead 100644
--- a/arch/riscv/boot/dts/starfive/jh8100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh8100.dtsi
@@ -4,6 +4,8 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/clock/starfive,jh8100-crg.h>
+#include <dt-bindings/reset/starfive,jh8100-crg.h>
 
 / {
 	compatible = "starfive,jh8100";
@@ -279,6 +281,210 @@ clk_uart: clk-uart {
 		clock-frequency = <24000000>;
 	};
 
+	osc: osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+
+	i2srx_bclk_ext: i2srx-bclk-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12288000>;
+	};
+
+	i2srx_lrck_ext: i2srx-lrck-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <192000>;
+	};
+
+	mclk_ext: mclk-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <49152000>;
+	};
+
+	usb3_tap_tck_ext: usb3-tap-tck-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	glb_ext_clk: glb-ext-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <30000000>;
+	};
+
+	usb1_tap_tck_ext: usb1-tap-tck-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	usb2_tap_tck_ext: usb2-tap-tck-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	typec_tap_tck_ext: typec-tap-tck-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	spi_in0_ext: spi-in0-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	spi_in1_ext: spi-in1-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	spi_in2_ext: spi-in2-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	i2stx_bclk_ext: i2stx-bclk-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12288000>;
+	};
+
+	i2stx_lrck_ext: i2stx-lrck-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <192000>;
+	};
+
+	dvp_ext: dvp-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <150000000>;
+	};
+
+	isp_dphy_tap_tck_ext: isp-dphy-tap-tck-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	vout_mipi_dphy_tap_tck_ext: vout-mipi-dphy-tap-tck-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	vout_edp_tap_tck_ext: vout-edp-tap-tck-ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	rtc: rtc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+
+	gmac0_rmii_func: gmac0-rmii-func {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	gmac0_rgmii_func: gmac0-rgmii-func {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	aon50: aon50 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	aon125: aon125 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	aon2000: aon2000 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <2000000000>;
+	};
+
+	aon200: aon200 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+	};
+
+	aon667: aon667 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <667000000>;
+	};
+
+	pll0: pll0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <2000000000>;
+	};
+
+	pll1: pll1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1782000000>;
+	};
+
+	pll2: pll2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1843200000>;
+	};
+
+	pll3: pll3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1866000000>;
+	};
+
+	pll4: pll4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <2000000000>;
+	};
+
+	pll5: pll5 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1500000000>;
+	};
+
+	pll6: pll6 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1782000000>;
+	};
+
+	pll7: pll7 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <2400000000>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -357,6 +563,99 @@ uart4: serial@121a0000  {
 			status = "disabled";
 		};
 
+		necrg: clock-controller@12320000 {
+			compatible = "starfive,jh8100-necrg";
+			reg = <0x0 0x12320000 0x0 0x10000>;
+			clocks = <&osc>, <&syscrg JH8100_SYSCLK_AXI_400>,
+				 <&syscrg JH8100_SYSCLK_VOUT_ROOT0>,
+				 <&syscrg JH8100_SYSCLK_VOUT_ROOT1>,
+				 <&syscrg JH8100_SYSCLK_USB_WRAP_480>,
+				 <&syscrg JH8100_SYSCLK_USB_WRAP_625>,
+				 <&syscrg JH8100_SYSCLK_USB_WRAP_240>,
+				 <&syscrg JH8100_SYSCLK_USB_WRAP_60>,
+				 <&syscrg JH8100_SYSCLK_USB_WRAP_156P25>,
+				 <&syscrg JH8100_SYSCLK_USB_WRAP_312P5>,
+				 <&syscrg JH8100_SYSCLK_USB_125M>,
+				 <&nwcrg JH8100_NWCLK_GPIO_100>,
+				 <&syscrg JH8100_SYSCLK_PERH_ROOT>,
+				 <&syscrg JH8100_SYSCLK_MCLK>,
+				 <&syscrg JH8100_SYSCLK_PERH_ROOT_PREOSC>,
+				 <&syscrg JH8100_SYSCLK_AHB0>,
+				 <&syscrg JH8100_SYSCLK_APB_BUS_PER1>,
+				 <&syscrg JH8100_SYSCLK_APB_BUS_PER2>,
+				 <&syscrg JH8100_SYSCLK_APB_BUS_PER3>,
+				 <&syscrg JH8100_SYSCLK_APB_BUS_PER5>,
+				 <&syscrg JH8100_SYSCLK_VENC_ROOT>,
+				 <&syscrg JH8100_SYSCLK_SPI_CORE_100>,
+				 <&glb_ext_clk>, <&usb3_tap_tck_ext>,
+				 <&usb1_tap_tck_ext>, <&usb2_tap_tck_ext>,
+				 <&typec_tap_tck_ext>, <&spi_in0_ext>,
+				 <&spi_in1_ext>, <&i2stx_bclk_ext>, <&i2stx_lrck_ext>;
+			clock-names = "osc", "axi_400", "vout_root0", "vout_root1",
+				      "usb_wrap_480", "usb_wrap_625", "usb_wrap_240",
+				      "usb_wrap_60", "usb_wrap_156p25", "usb_wrap_312p5",
+				      "usb_125m", "gpio_100", "perh_root", "mclk",
+				      "perh_root_preosc", "ahb0", "apb_bus_per1",
+				      "apb_bus_per2", "apb_bus_per3", "apb_bus_per5",
+				      "venc_root", "spi_core_100", "glb-ext-clk",
+				      "usb3-tap-tck-ext", "usb1-tap-tck-ext",
+				      "usb2-tap-tck-ext", "typec-tap-tck-ext", "spi-in0-ext",
+				      "spi-in1-ext", "i2stx-bclk-ext", "i2stx-lrck-ext";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		nwcrg: clock-controller@123c0000 {
+			compatible = "starfive,jh8100-nwcrg";
+			reg = <0x0 0x123c0000 0x0 0x10000>;
+			clocks = <&osc>, <&syscrg JH8100_SYSCLK_APB_BUS>,
+				 <&syscrg JH8100_SYSCLK_APB_BUS_PER4>,
+				 <&syscrg JH8100_SYSCLK_SPI_CORE_100>,
+				 <&syscrg JH8100_SYSCLK_ISP_2X>,
+				 <&syscrg JH8100_SYSCLK_ISP_AXI>,
+				 <&syscrg JH8100_SYSCLK_VOUT_ROOT0>,
+				 <&syscrg JH8100_SYSCLK_VOUT_ROOT1>,
+				 <&syscrg JH8100_SYSCLK_VOUT_SCAN_ATS>,
+				 <&syscrg JH8100_SYSCLK_VOUT_DC_CORE>,
+				 <&syscrg JH8100_SYSCLK_VOUT_AXI>,
+				 <&syscrg JH8100_SYSCLK_AXI_400>, <&syscrg JH8100_SYSCLK_AHB0>,
+				 <&syscrg JH8100_SYSCLK_PERH_ROOT_PREOSC>,
+				 <&dvp_ext>, <&isp_dphy_tap_tck_ext>, <&glb_ext_clk>,
+				 <&vout_mipi_dphy_tap_tck_ext>, <&vout_edp_tap_tck_ext>,
+				 <&spi_in2_ext>, <&pll5>;
+			clock-names = "osc", "apb_bus", "apb_bus_per4", "spi_core_100",
+				      "isp_2x", "isp_axi", "vout_root0", "vout_root1",
+				      "vout_scan_ats", "vout_dc_core", "vout_axi", "axi_400",
+				      "ahb0", "perh_root_preosc", "dvp-ext",
+				      "isp-dphy-tap-tck-ext", "glb-ext-clk",
+				      "vout-mipi-dphy-tap-tck-ext", "vout-edp-tap-tck-ext",
+				      "spi-in2-ext", "pll5";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		syscrg: clock-controller@126d0000 {
+			compatible = "starfive,jh8100-syscrg";
+			reg = <0x0 0x126d0000 0x0 0x10000>;
+			clocks = <&osc>, <&mclk_ext>, <&pll0>, <&pll1>,
+				 <&pll2>, <&pll3>, <&pll4>, <&pll6>, <&pll7>;
+			clock-names = "osc", "mclk-ext", "pll0", "pll1", "pll2",
+				      "pll3", "pll4", "pll6", "pll7";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		swcrg: clock-controller@12720000 {
+			compatible = "starfive,jh8100-swcrg";
+			reg = <0x0 0x12720000 0x0 0x10000>;
+			clocks = <&syscrg JH8100_SYSCLK_APB_BUS>,
+				 <&syscrg JH8100_SYSCLK_VDEC_ROOT>,
+				 <&syscrg JH8100_SYSCLK_FLEXNOC1>;
+			clock-names = "apb_bus", "vdec_root", "flexnoc1";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		uart5: serial@127d0000  {
 			compatible = "starfive,jh8100-uart", "cdns,uart-r1p8";
 			reg = <0x0 0x127d0000 0x0 0x10000>;
@@ -374,5 +673,19 @@ uart6: serial@127e0000  {
 			interrupts = <73>;
 			status = "disabled";
 		};
+
+		aoncrg: clock-controller@1f310000 {
+			compatible = "starfive,jh8100-aoncrg";
+			reg = <0x0 0x1f310000 0x0 0x10000>;
+			clocks = <&osc>, <&gmac0_rmii_func>,
+				 <&gmac0_rgmii_func>, <&aon125>,
+				 <&aon2000>, <&aon200>,
+				 <&aon667>, <&rtc>;
+			clock-names = "osc", "gmac0-rmii-func", "gmac0-rgmii-func",
+				      "aon125", "aon2000", "aon200",
+				      "aon667", "rtc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
2.34.1


