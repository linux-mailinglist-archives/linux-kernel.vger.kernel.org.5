Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CA27875A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242670AbjHXQkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbjHXQkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:40:07 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2071.outbound.protection.outlook.com [40.107.241.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CE6198;
        Thu, 24 Aug 2023 09:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gItj5gKHYUB7cCx59f/F6eybBaDpgJEas6QpDntYbaTh0TZcMCwDQ2kpDkE73Qld6Z0qP/C5MIcXI2j+bRSgG4eHxIi4solS0VbotTb2+I9Rt4/r/OPbdaa9S6u22+fkZpeTDbgQuj5GvFTdP7GQ+IDGHmbRzCRvmewP8POZ9ZbdvH58kjuc91q2OeZsOYb7LGEhpDAKofIIhz5d+nclKSznvDECn0mnjJxqQ7JYKvmdKrc1r0uaT0l8Ys/xvfPiBcOVIYswz0nPadjml9yI6BLJeFtpQ+wJ8sof6mchDvKZhjuhEPoT8Ord89sn1A4U9iLuJ85nn5860DN40Yn6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9bU2w+1c5AVcMzseRZGcsJzj74jmPq8gvvaYsvk/oc=;
 b=DBYJ1sWh9zl4ry5/lU2YWH9KBRUb3EolOfWYMpMeVmdOObsYV4ZrYZnaqYcokedfKHIb9Pe9PJRyeE+cIHbqqhxzKj3iXDQXgZProXII5Fd0N1cIhjFLBdQSg68EBNeFJn6Vt8zTbZd1WdnVjAAdCzYJHWKpdORqp90xAsL3C6jXFgfwGVNKNCOu6FAJSUgboUETczXSypeJeSxIrRpg7Uq1cqDAWEP1xeAGC0nhFsP093OnVB84P37jqbU8CPXwPUnTUkPifh/do/mUjIfBir51VWfF4uHvXgKFMwNfx6BXcdaz9DA7s/V9VPLFESBUhmpvyGe8F8nKxqHeZseQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9bU2w+1c5AVcMzseRZGcsJzj74jmPq8gvvaYsvk/oc=;
 b=NwpAPRiDV8jSLAJx/a9w4AIJyTLSNU0GVsDvotlqJg5xYi9Ldbw2X9+yb7tx9VjFOgUVy/K5sQ9mvk80Skgj7FQlxxMHx2lmPookIWFtlwJ++HQy1rDVQX+Cv4VhMkW0tDpW0+CHaSD3xC/XYTQL2G4RZn67K0f90+nNTazsAEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:40:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:40:01 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     festevam@gmail.com
Cc:     Frank.Li@nxp.com, clin@suse.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, eagle.zhou@nxp.com,
        imx@lists.linux.dev, joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Subject: [PATCH v2 2/3] arm64: dts: imx93: add dma support for lpuart[1..9]
Date:   Thu, 24 Aug 2023 12:39:21 -0400
Message-Id: <20230824163922.2952403-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824163922.2952403-1-Frank.Li@nxp.com>
References: <20230824163922.2952403-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: b3851787-0972-4b50-196a-08dba4c0c29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpcDasHvulm4GSACu+SMzUVrwTUJFARMJYVyqwmHJjiDOsLgVvjD9A0hEPiEJUnrKhNnaoVORL2IDR8SfvhJs90gXszjA02e3wee5wMjpjb0d6SwzRDNrqC7VPqzkv5D8e0FGMfPC2cQQqKBnYyQuWpbzBAx/IB+TQNvGjE755dZBg3hpc2IJ6bpBsQusK2kHcJdi28O+28knj99boA/MxoPEyq96OVdHMIYITv77xkdYDSalzyx7CApIH7h/lPGJSLhtULFUUoQZUXuGayRjX3eDW2iVuQcsWSlpFqTH5578bSaEfAF48Jjz3EnxXXU8O3d0ITeMr5EwN2RM3POzNBUFuv1ScwlTQGjn3Ko8rli8dnc9qY2vuwrQNu8ck+yURuskpbn0q3j2wScsGCOFMjWPm+2uHWD79lUz7WIv0QtIkRtTFhIpQYGmzvmn3bkBWmwfrbDCfSO8+kIRLnsV+V+IsVV0PXURJIp8iwAZVvF/pZVzTClxU07EsmdQmG7n6zzbpdBJGXg17rfLm3SJmiNzEFkKfo1P28C6LCpdGcgWaaBdAfPSqBqWEEVbzTllLAPGIxC3vlI+7L0ZkvIyJRJVBcWIt6KD++3FwUW5Kuk2F0s+y5Bq5QZOba0hYufY9+3tVSZDCDLQOAmnmHOSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(83380400001)(7416002)(26005)(38350700002)(6666004)(38100700002)(66556008)(66946007)(66476007)(6916009)(316002)(478600001)(41300700001)(6512007)(6506007)(2906002)(86362001)(52116002)(6486002)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S61T99LSCyBvrdv14kU3ApxDojRkaLmhj/bFp1vq/iKa3m2+E+mcgzPdIuLU?=
 =?us-ascii?Q?5M8/7CCc3ChkBPYAGmMzEvqN+zC6MprEqBHZ/Xv+FP9m/+FpruV9tJO76zlr?=
 =?us-ascii?Q?Jnb9l5qCv/7pnD6+iTSHsPmfTB0PPP5GeL5NozJ/Zxplr4b2rPeHp6MxrM7d?=
 =?us-ascii?Q?ah9qnOf6leRmEccUZY0t8Q56+DJc+aMlr5Kf3LvUAWzGWNK3kEn6qFfkcgKj?=
 =?us-ascii?Q?LOO1QyOHUSYnwR9c8+8lCND1qC1glfOenEegwGz/9yR6lrW528SLPlv3GNL2?=
 =?us-ascii?Q?CM2sCoucvQeCz31dcDEJ0hDTEkyjuT998yCwE2hWokk2PZlutKmPMsVqiqto?=
 =?us-ascii?Q?yPkwKvifMWU8p7t/DtT3hPnO6URnyjNtwYx9H1WSrsIjpyJMu2ODgwPF8xoE?=
 =?us-ascii?Q?HuSdH+vAhOKnXoj0bASO5QA7whRx4TwNjuZNnOnl/3Fb6e5W8G0eyAT8BbsO?=
 =?us-ascii?Q?xyGfrpT6HHToW+KGaTpul4GbGcF1B9SykZcpjW8OJNHvOloVscnd7eKiBn1a?=
 =?us-ascii?Q?24nKN9WDkD2UDgODzIl4DkbtYJj1y0d8M9FM7Jq5NKyEB4ot7qV8AxKjpKlA?=
 =?us-ascii?Q?1lZl41NtQmYY3GRpo/uWhsNDiccMuuZFEWoglZHsuSd5LSIB5entavSY7UjW?=
 =?us-ascii?Q?pkK858ynuczgjDrfQA3uPFHVJehzHeJYadhdkmdhf5rhh0zFKn0W6om5EHDe?=
 =?us-ascii?Q?54G6rdjoi4pS+/lkAVpjU7/n+1AARzHp/xaERUrp9YgBq7Y9dSb3FoVnOo7D?=
 =?us-ascii?Q?CZKEOSq5R7gFVrdfLCNmQ9ykgNYq1uglHtAZXPl/Nk9An9KnifvErfZ6LK+L?=
 =?us-ascii?Q?ySCZ1xk1yVNMoa6tjtdW3KaGk1TcYv7Q/w16iEI6l9540KErd/CpINt2pZqB?=
 =?us-ascii?Q?mGr/N0nPJTtB6S9sw59Ow61T7vQ55f0dnOeECyJNSiOaBMIhnn0jL9zAgpWK?=
 =?us-ascii?Q?RNQF9JBUcCEoek4geTlJMcrdPryP4OtSfnSvu9+ksMiU2t7gzMgj7k39EFB/?=
 =?us-ascii?Q?a3vSVgbnCoMqVEW1J9ceyiOEiFR1rR//OaA7kzxgemzvxd0o5eU6HkKLZ43j?=
 =?us-ascii?Q?zO9amKxodGam110IdchjHYOKxQHRIwnMuW/VRQqPbm8LjjAUTV3XM/LQ1rFO?=
 =?us-ascii?Q?P5dMbmJSITW3WbsDFln2+DerG9g75YUqnoz89FKvWDP3BjDM/2jzHX9tDiKh?=
 =?us-ascii?Q?pRukZbGjlPz48pRN/OB/ZWXxa8B50AYLWMxF5jUm+ZTwKUyOcXD8x2jg+1/a?=
 =?us-ascii?Q?hOyvd8eMqYBuY3ivjsnujJDDc+LQSKejQEsJA0MUMGyeJQMUXZ/ksZQMkcHg?=
 =?us-ascii?Q?q3s+Hn0o7Q+4u/z52Cp6iDQYYZhbu9Fh7rBpOiAXBQW3/AsUrPPzJ8stM6qY?=
 =?us-ascii?Q?hpajwBmYsdpIbRo3F71g+3VMyylIWYoVMkDoNjiMVBv18r9OKt2mBFC0BO2L?=
 =?us-ascii?Q?i+iMOzljRYAon2QSpl/ZHiU1W1Vn4k77VdUTIG7597RqoNvrw55frp/N1CK0?=
 =?us-ascii?Q?J1Pkxdc56ficuLdafNcu5svroig7bbaRz/rVmGc/xPC1/lyZ7atYMwQNRewV?=
 =?us-ascii?Q?cQSlfgJjUotooigO5UtJR6GYTmhsAYLnDukxjQqp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3851787-0972-4b50-196a-08dba4c0c29a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:40:01.0227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHp2VqWkuXoJJ+7q5zyceaXfTI7Mlq0N2cpaNmTMcUGOtiDssLgFzKwZt2VCyoivoDK7WEebiIMX70+0FA3rxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma support for lpuart[1..9].

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index acdca18673b7..849543d35ed7 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -336,6 +336,8 @@ lpuart1: serial@44380000 {
 				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART1_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma1 16 0 0>, <&edma1 17 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -345,6 +347,8 @@ lpuart2: serial@44390000 {
 				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma1 18 0 0>, <&edma1 19 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -666,6 +670,8 @@ lpuart3: serial@42570000 {
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 17 0 0>, <&edma2 18 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -675,6 +681,8 @@ lpuart4: serial@42580000 {
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 19 0 0>, <&edma2 20 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -684,6 +692,8 @@ lpuart5: serial@42590000 {
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 21 0 0>, <&edma2 22 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -693,6 +703,8 @@ lpuart6: serial@425a0000 {
 				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 23 0 0>, <&edma2 24 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -731,6 +743,8 @@ lpuart7: serial@42690000 {
 				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 87 0 0>, <&edma2 88 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -740,6 +754,8 @@ lpuart8: serial@426a0000 {
 				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 89 0 0>, <&edma2 90 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
-- 
2.34.1

