Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713697F0EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjKTJMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjKTJMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:12:05 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3464DE5;
        Mon, 20 Nov 2023 01:11:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ant3OvfpWhuxlxILatK4g1ODKupBb2gvt0jHBei5JH9njnNv2rVbTs0y+IK5OvkeKx0HnQBJBqhMHA3XcI+8KE910hfG1z1+sR/5E4N3bvh0fThpFYseGTiBEm7hI3ogqMw/bO0YkReLMhGV914PX7a+WWg2WN2WhooNPeWTbpkJDX2bdwRfBZJJ+PPJiF5v5/UcyW3eYTH3uS/+wEXJklEIVFTvynPWaZMqoqq4RvETyqbXvnwwd1P8253lG0GBB3q14LMtOxGJ1TLKlfVgKSGUzTDOoshRJqBchhy+CMc4IVe/BhUrih9AaalDAdfHRYCBH16qWqYN6SNN7m1rxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjJQMqMV5aGZi33hJTV0HP4lkIVFV1wV9mkNDyQS85M=;
 b=lUCIIQJVSGaWjRpWG4vrhGqP5C0eF3bgmC0vmtDoqG8VRZh3lLkyxuZ3UXjyiTgeKS8J0KtOdXsA/jObvPWbfgLlIAI4yz8T715ddsST/DoMoFVKgC/4HJHKo80tndXvhTanBT9/mIdSwfxp/E4VpCw8RvP8b4exF9/SZHy29frTGyRb/iSQbGPLNAsmkoKlC20SOKoZrUlXlDgUvEoT8z0qG9bHtJsSUoRgPtuzhOVui09vANQffZUlYI6DTFkhXY5k2NDoTv4JO+XUIZdXXx0bG7rWf5M8hYX6oJ9DTPPxZ7OqrvCugqK4jjyzuhNNZlu7zqFD5y+j/gyC+F8CpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjJQMqMV5aGZi33hJTV0HP4lkIVFV1wV9mkNDyQS85M=;
 b=Q6AdERwyAvWhW3KfXAaJ0IOWe3VO+MYr6g6NDM9IjuW2IkRdnUP3JDGrc72zwQZV/PMwxwGUTsxxKKJjkmKqmnNCBRy976aAe1S3kc5Gh3Ytije75vy38BO7SxwcWQdYgTsfhFNAr5ng1Fe6FcCTH4qCUlK+q/J/L6Arq484SMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by PAXPR04MB9399.eurprd04.prod.outlook.com (2603:10a6:102:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 09:11:55 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768%6]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 09:11:55 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [RESEND v2 1/3] arm64: dts: imx93: Add audio device nodes
Date:   Mon, 20 Nov 2023 16:49:03 +0800
Message-Id: <20231120084905.664-2-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231120084905.664-1-chancel.liu@nxp.com>
References: <20231120084905.664-1-chancel.liu@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0052.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::24) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|PAXPR04MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 34fc6aa3-14d1-4266-993d-08dbe9a8bd6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMSmPsRFkcme06luzzGJ4gi5LloT2Wa2oQzF3FVKrgcbalMonQqLaQAcqIDRfxGtpxYAdVeLV24GoPJQUGwJ3CAZaHJx5NLAyVTpmBMwFVYPS2dGtxVle+0RcyqrHfOA/rrw4hYziNkZsKmUWbnR5SLLCz7kc6C1CQpme+cnxRUokPcYQ6Is+fKG8yWf3Ru31/n8dbFjUSBEVF+Cl8qKPipTaykUb+Jri2Jz8abQwxq8s3kqW8mgTyiUJzThTIT5PuTcbt0sOKZC4w1FTuBthptYZI1V6rmJQcRWkrf/YKKuOYk2TlAk/9SLmoP3OMnsM5y4itQcVoZQqQ91wWAXGpU2DIhgCyDtu6Ab+I2u1ubLWUZx0k+pHStl9mI1utuhL5aEO8Zmp5skir4eJpyBS+ZW2UoNWAwbjdQ7YL/YIEOmAyxraoVhd7uftaHLW6xxVvMWTYm/cOgu3tTLfJAoWbG98NcA//G1iBk3vw9BQlk1j8kM8FsEJTh2iwtONqlwPG2Dg+jwJuQhQuSOoQ+bhb6WDgQSC0xNLsmUPXiZyGgxhgDVxzmi220cgyQ1k4eKC2AERR6NzOrepbxCAze3A9wvB7ibbVeK656y+SHV9mTP7c+73d1AK8a3giGUTH5h8TkondfwXUPQThBmCKSSjQ7coNMN19vvzbs1PBzBjTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(36756003)(5660300002)(86362001)(7416002)(44832011)(2013699003)(2906002)(38350700005)(921008)(6512007)(6506007)(52116002)(2616005)(1076003)(26005)(83380400001)(6486002)(478600001)(6666004)(4326008)(8676002)(8936002)(38100700002)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X0SK+0DaMPZSox81fqxS8bv/tNROy1GyBWi1gkPaQrTNFqx3QGXEpJoKkPJi?=
 =?us-ascii?Q?6XpROZAgBfXLhRurs27XLiWw9trmcjtTVcFGpOFEc8xCga94qmbgEeZTIkAM?=
 =?us-ascii?Q?sI8XqqBq9L/b714TN1dEbqsaQk68R7f0stTY3YTG0HhZLiIT2/q9ZPrVeJ6p?=
 =?us-ascii?Q?PWZR8Doify6NqOuql/vV9lj3blAhSv/TUQIRtUM7SLWwpotr6AfR7zWeBxKx?=
 =?us-ascii?Q?yJ02eCp8f0AyBNFpKXmfbBg550Q8KuCEwTICs+U+z7wgY8n6e2eyAFId/UWw?=
 =?us-ascii?Q?px5e7EL1S+DXCOkAKRzp+536H20YHigK9gs9vOmUOm+iPPuWdRuyYIXshYL4?=
 =?us-ascii?Q?k63YALzDFj1MtR8LTZCxE/HWvq6AJc0sN+LSzKPCQIRk9bguGGB1DudcpZ07?=
 =?us-ascii?Q?5K4RMnZIVqQtc2GzKiqzbDgXhi3mIa1Z7YFO8St9buvADVjdrcF3YOM1a/rW?=
 =?us-ascii?Q?KLEPgU0HX7iGaLzNB2p/atR3TBymkdQc24W1eathPTY2QBvfMtcn/O312UO1?=
 =?us-ascii?Q?8WH+vohZ3tqHAIcF9YhS6WLBFhDg9Ci2l5To0UuvylbrQ0FDcRj6gerA/j8+?=
 =?us-ascii?Q?xeY2XcwDOIDbkAYJ7S8sHxNLKgAa9bYFD4IzVVtEzCZ1gb2RcWGeFEXc0Wlb?=
 =?us-ascii?Q?cfQo83MoUeC6SOYo75r+SReO3mFG5lAIIODyQCMXoBiaMoDqgo7SgBnttUWy?=
 =?us-ascii?Q?7qSeA65VPAJF5BJvQTvBiWTT+6mk8ewNkbCn1p56Qq2saoYSVWAqhk45pbQx?=
 =?us-ascii?Q?AbvUM2J2JAhc7iAHODk/6cxkaDbwUxpx5tZbMXPlCbfxokUqHj7JVBhd0Gh+?=
 =?us-ascii?Q?tCL8d58ny1OquCixQKCBAjCC+eHi2lHVnwAi5k/qq0SSYS0XfJbxUFpwx5Pi?=
 =?us-ascii?Q?48zu/491HOzRH/wTv/gnLoaa3sc7Z2UnihPsUFbinK6DbpdVyQaoZ3Ir3ApE?=
 =?us-ascii?Q?SUXr3DL7Lih0wNHxh2YsyEfDyDWi2jQzN7SihlLXB/yA5Kwj8ZAmAKGlGf1T?=
 =?us-ascii?Q?0ZMeFQpk74RAb59IdeUsUWj/Wl22SGYsD/3YcGhjpHZYqSRoVLUQYwzwsjVf?=
 =?us-ascii?Q?ZHgjgvQsHytis/Vg1J04utTQIA+R8qWW/3fqd2GPf2yw7FaH2rLqYunMq8mu?=
 =?us-ascii?Q?f6vox+8hxAL9c1WoZF/o2dOyjtai7v74t9g+DDF5h5O7PiX1nNcGVFTAogcy?=
 =?us-ascii?Q?1Q0DbCy0mB6T/XlYY9CjN42VZF3hXqjQQS9gPNC5fZWIpq82E33do1H93X0x?=
 =?us-ascii?Q?+gwfBj3DdBy8wWoNcd1Yu4Z8e52X2UUeNTaMoRxaTdnCKQoW7+iPntA+KH6E?=
 =?us-ascii?Q?rwNCq3xwvit5DoU509+hYJsmpS425f0TPjkh9Qd5CJ1QAh77V0BP0FPNLbFK?=
 =?us-ascii?Q?n6AnNab0dl04zk+xr1bmI3DYJ9HkQidxCnj4KvxDv1XnsVxNLTTzKuNxz/I6?=
 =?us-ascii?Q?LBsXdWQpfzll4zGUN49uRrGCn49nzdo4V2NZAousENt3HCS95ne3+4yMcbEd?=
 =?us-ascii?Q?8AQrkqnPdUWMUYhAKT0Fjo2lTYSKoTQl+j+tlWFwg/IpzAWvNzn32Lc6fxif?=
 =?us-ascii?Q?Bz9rTSTTRRehPVmxVef2S2+RUJQq4MHb/z/J3oS0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fc6aa3-14d1-4266-993d-08dbe9a8bd6f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 09:11:54.9854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GENSf206SdYk4RptSWkfW/wrdabMx/I97vZRyOjg/mJ3axLJfnSmqH9m2osU81GyiJ48eh+Az/LB6ULrSOFOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9399
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio devices nodes including SAI, MICFIL, XCVR and MQS.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 87 ++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index ceccf4766440..9a7bff39519c 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -171,6 +171,18 @@ cm33: remoteproc-cm33 {
 		status = "disabled";
 	};
 
+	mqs1: mqs1 {
+		compatible = "fsl,imx93-mqs";
+		gpr = <&aonmix_ns_gpr>;
+		status = "disabled";
+	};
+
+	mqs2: mqs2 {
+		compatible = "fsl,imx93-mqs";
+		gpr = <&wakeupmix_gpr>;
+		status = "disabled";
+	};
+
 	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -367,6 +379,19 @@ flexcan1: can@443a0000 {
 				status = "disabled";
 			};
 
+			sai1: sai@443b0000 {
+				compatible = "fsl,imx93-sai";
+				reg = <0x443b0000 0x10000>;
+				interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_SAI1_IPG>, <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_SAI1_GATE>, <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_DUMMY>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&edma1 22 0 1>, <&edma1 21 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			iomuxc: pinctrl@443c0000 {
 				compatible = "fsl,imx93-iomuxc";
 				reg = <0x443c0000 0x10000>;
@@ -447,6 +472,23 @@ tmu: tmu@44482000 {
 				#thermal-sensor-cells = <1>;
 			};
 
+			micfil: micfil@44520000 {
+				compatible = "fsl,imx93-micfil";
+				reg = <0x44520000 0x10000>;
+				interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_PDM_IPG>,
+					 <&clk IMX93_CLK_PDM_GATE>,
+					 <&clk IMX93_CLK_AUDIO_PLL>,
+					 <&clk IMX93_CLK_DUMMY>;
+				clock-names = "ipg_clk", "ipg_clk_app",
+					      "pll8k", "clkext3";
+				dmas = <&edma1 29 0 5>;
+				dma-names = "rx";
+				status = "disabled";
+			};
 
 			adc1: adc@44530000 {
 				compatible = "nxp,imx93-adc";
@@ -738,6 +780,51 @@ flexspi1: spi@425e0000 {
 				status = "disabled";
 			};
 
+			sai2: sai@42650000 {
+				compatible = "fsl,imx93-sai";
+				reg = <0x42650000 0x10000>;
+				interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_SAI2_IPG>, <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_SAI2_GATE>, <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_DUMMY>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&edma2 59 0 1>, <&edma2 58 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			sai3: sai@42660000 {
+				compatible = "fsl,imx93-sai";
+				reg = <0x42660000 0x10000>;
+				interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_SAI3_IPG>, <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_SAI3_GATE>, <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_DUMMY>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&edma2 61 0 1>, <&edma2 60 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			xcvr: xcvr@42680000 {
+				compatible = "fsl,imx93-xcvr";
+				reg = <0x42680000 0x800>,
+				      <0x42680800 0x400>,
+				      <0x42680c00 0x080>,
+				      <0x42680e00 0x080>;
+				reg-names = "ram", "regs", "rxfifo", "txfifo";
+				interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
+					 <&clk IMX93_CLK_SPDIF_GATE>,
+					 <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_AUD_XCVR_GATE>;
+				clock-names = "ipg", "phy", "spba", "pll_ipg";
+				dmas = <&edma2 65 0 1>, <&edma2 66 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			lpuart7: serial@42690000 {
 				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x42690000 0x1000>;
-- 
2.42.0

