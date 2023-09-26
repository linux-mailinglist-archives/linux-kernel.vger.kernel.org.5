Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5747AE42F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjIZD3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjIZD3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:29:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2052.outbound.protection.outlook.com [40.107.6.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3FCFF;
        Mon, 25 Sep 2023 20:29:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+ee7fEQjqiVSz1SKCYbYtwyYMdYhcB4KlPQlayidCI0JZlAimx6wiTOEUSM7z9tESQkyqxdJVtWQNZJ/pkK6tqwrhkhNfGffx1h/qNDP/tCHP3cAUT0H2iv/xQ456NXdit0sv5opHt37QwJBEAjwO6mvsb+4fdAj06CjWvPymiyzuF2fDz6oQvlZ5oTpHDDI2btWExE5sw+Ru855K/9tjdA2gTRoLRxLroE5+qrjZkhXvt7Y85OCNA/XYfT0FbTCLs3t4z8hPmhiL6TcGrYlKWinnIe5TcKefPY47fsiBRUQjJj/dECVPGap809Lh4WDY32biFYwHlcHICPExWzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXr59Rq1uZ2nUwvwHArttqzzJnZcwdqlcA6cGqrl3Gc=;
 b=WaNkSK+eTzV1Yazk7NZqjlGz3YVEIJujawwLOqlRGszITz+0H7JY6DS98qDtMO8muyatvEIEa9l0RSEoX/tXuCOZ1xdqW/+lvfO9OiF8JxnTX39ofqFOIjTDBOXQF3Qk4gkvkszlEo9s0jltBVq3stBQEbRhAdJb+iEDQbPmeTFhmFRe4nRT/B0iely3HZe+MPQuN1Cc5zjGVPj+PqvgQdUxULDuCN+KOmaBvUKWYLtSTipLGNWFJI+EIKEY0/UCtW637D+slny+iPbAHDyCGM2QdozHbpR1JT9wjVMs2tSeDPzi4StCQ2VItZ9+9oTNOdX9bcuG86btL0Chphedfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXr59Rq1uZ2nUwvwHArttqzzJnZcwdqlcA6cGqrl3Gc=;
 b=hW9e/HyTLHc8SA3ahGbR10P1FtNvD9OMvznjTbcfa0iQhPmNNstNGYEB/Mk2/v4gdQKJe8JBViukovOTcS4m7BKXJjXhLBELtM6ur28Fd6MyFf4TfNc7sl41KvlAkmUcFTvyJ6WhPGZXymG4hPNFYUkwZFkPy+wXGA7lb5PMLOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 03:29:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 03:29:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 26 Sep 2023 11:33:23 +0800
Subject: [PATCH v4 7/7] arm64: dts: imx93: update gpio node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-vf610-gpio-v4-7-b57b7f6e8368@nxp.com>
References: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
In-Reply-To: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695699209; l=3170;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=SIdbIE7CpI/4V5dWp7tqZZ3kaf6GR+H5NOQPt9VJs8U=;
 b=bpD9jOV0Ez+oRseiOp6hYbQ2KRVr2f4mJdhDkmyAuytpOXn7i1/oTeqbMAeIn3C5rasvI01UK
 4pjNJLdVW9lCx1Xt10LAyIms8G3tFL6xYltHXCwDV4PZbIpfPs3GFAJ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 47808d27-003e-4e0a-699d-08dbbe40c5a3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MgriXEJT9qwsjPC+t3dtAl9jx/F1a2dvOzjPVUeWHIN3djhJrip3z18xRJdrUpplgXeIB9vjfizZOhdU2h/oHVf+/wuHWI/C36VGRiVNiGxq8hhX1vUdlV6h40h2BfZMTd1QT0x7isOEMhTj6XoY3KRik+y5zZd7OAnNKTIf5OBaJ2Hzhz9YinDcWmAYK7d3uJwLlfgzXgvrV5uZ7GwBp4O+iaW2/vztJe0RwLYnFAqqqwDShgnHD4t46BIHIHGp8d5vZEg7RBSuFUAsGH1R2Zz5DDOlfOwbgW/ooT06s9bDbKcW9mARQmZKeyKW638bw3t18PTIM9a1n/nRdKKNn2aqZlmdkGPzoOD94bCr0Eo/YKHuL6lbWBwzo7l2CwoVTXavhAKc0Y9HYrBFSWBiwF6W80DY1N4R3TXCEns/AkFUtZXflRBZ+08bVmKebGiR6ihQDy8dKh1+nYnYOT1HCBbVOeu8z/FovvzhPpnNWVs0wZfK0Q7XkmEoFR7QomxYmgK6g15YbSA5Vr4VCLBLn0hfCVHBs73slDTqo8yFd3l5KghQ7bfwgdt0yuF5raMK2ie1dY4fH/vlIMbSWLsedhDqY3BmORNaIIXoVAO4mevmuHoNYmjKfOr3bO2tDWVN2//pjR4UjNYkoUZm8rW5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(41300700001)(8936002)(4326008)(8676002)(7416002)(66476007)(66946007)(66556008)(316002)(26005)(110136005)(86362001)(2906002)(921005)(6486002)(478600001)(38350700002)(83380400001)(36756003)(52116002)(38100700002)(6512007)(9686003)(5660300002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0dKcGpFZXFrd01OSVJtRmtjdXJ1c1NPNnBqazQyZy83TmR3MG4wc2RMcXgz?=
 =?utf-8?B?QzFLNTZXb1dKa3h4MytWb3VyRlZJRDlTa3c1aU5aTEFuamorVi9MdE9aSHhw?=
 =?utf-8?B?ZExueS9WTzhudVlacW5XYVNhR3FhSjY4UnRUeEoreWlGWUdta3p3b0tadXFH?=
 =?utf-8?B?MTdhaGpjcXhIZDlweDEwQ00xdGg3bnBINVhuZFpuSHhqb0ZEamZvaVhSaXIz?=
 =?utf-8?B?ai8xOXl5WVpTRE43bWNUWVBsVk1DV2E4cHZDMGNVME14U0loSFNtMGVsZFpR?=
 =?utf-8?B?QngwTEQ4WTJKVStvNjJvSzJaeEtkbmo1ODJYb054U1hkTjU1NGVjVjlYTkNN?=
 =?utf-8?B?VkpKNGZPVE1jSWg0M1FPSE1ud0RkVkxkQUFxYUxSQ2Z1YlpCOXBjM3ExZ1Fa?=
 =?utf-8?B?M2RJb0VITmZZUzdsTlNDOGdLUHlER2JmTHlnL3ZZMmNGVHc2SHdZS0lndFAr?=
 =?utf-8?B?RUxZOWhLRTRTNWpSMjlyOEJMb2RLT1U2NzZMb3pKcmk5d3l3Z0FQMjgxVzNm?=
 =?utf-8?B?L2ljV2E3S3l6clpxZnRUcWkwRHBvLzJQeVFHMVgvd0llUi81eXZ6aWxRTFlj?=
 =?utf-8?B?NXNtL1JRdU5ROWhISTB2TG8vMmhCM3Exc2VQZVR1M2Y5YStQbVNHcUxJYjJp?=
 =?utf-8?B?VnFLS3ZDaDN0cHJJK2hoQ3lzd1BlejdZUzVHV1JHNEpCNHZhZFFBdERnQkgx?=
 =?utf-8?B?Mk5MUGJUOXZnL202aVp4Z1JTZ0dXTWwzS0tieUhrNW1zdHRSdStTRkNicity?=
 =?utf-8?B?SjVzNDMvLzdBdnYxd0dtZlNSNFFnNy9YdzlOaUx4Ky9NMXJLSGFHRHZiUUpW?=
 =?utf-8?B?bDl4b21QVUZBTGdoUjVjUUU4dWRaUFFrUXhNY3ZqZ29xeFdZSzJLNlhsZHcx?=
 =?utf-8?B?SWI2c3JKMmczd0VSbUtEWm1Zdjd0SGtlVUhOdDdKQUM3b0d5ZWEydHZTdUQv?=
 =?utf-8?B?b2NTL01GZ2k4M0VkN2FrcXdxTnZ5WHljMHlGaDRmSnFNYnlwQzAya3F5NFhK?=
 =?utf-8?B?ZUEvZmduOC84ZXdUU0pJTGphUThzK1BlWFEzK1F6NlNqbytJa1JGNGpnajRp?=
 =?utf-8?B?NHBvK2pwRm0vcjgrZWdNK2h2Rk1TYnBncGtGeUFrN0s3VFdHckU2SVFIVTZa?=
 =?utf-8?B?Y25ReHlLUkNwV05obUFPRVc1UVJRblJqeDRYbFZIbHNjaG9RWnE5V2dmVEt3?=
 =?utf-8?B?ak1FcVRiL29nWWxxTURaZzErZFVJeFpKaGlIVTB3TVdtOFVhdEpwODlOSU9M?=
 =?utf-8?B?d05zVzEwWFhnTW9tOFFwRldaL2xhUmFBNnJyMGRpSEJMY1hLTUZNTG9SZHA3?=
 =?utf-8?B?c2hFSkxNcHJKdnFib0s2czRKNmpqYTNWNzhIeHhLSXFIa2xISi9RNDZHMEth?=
 =?utf-8?B?V0RoRlVodWExaW5RdkFVSE5FdDl6andPaTBHbGFZK2hweGhkTjdBemFaM0xy?=
 =?utf-8?B?cVZ1L2NXeXllOGNXaW1meHFOdkJlVHp6OVR6dWFIL3k2eGt3eDVaeUhLZ2ZG?=
 =?utf-8?B?NjVkTE9ZTFFZazVST0YyTitvOUYvbzdUYkVMNEJnaHo0K2c1NnR5ZTNxanFE?=
 =?utf-8?B?aWhjYnBHRjhrN2dRL1hoN1Y2VmEvZU5YNXFhbFhwZ1p0ak1mWUUwU0xkeW12?=
 =?utf-8?B?eTNJZ2JxRmxjVlRMSFhPMElqVXpPV2pENzBSc3hRczZnQXNqR3ZlR0xYaVhs?=
 =?utf-8?B?Tiszb09VR1NoYVBaVE9rY2FibDd6cWhhUkVCTWJaM1NpY3VDd2M3Z3dVVDMz?=
 =?utf-8?B?TU5iajVNN1ZSMURBd0dHajVvZHhOVVBJdUFrTmk2QmdGemZvWUQraEM2dnpK?=
 =?utf-8?B?L1ZrSlRGQldQeGw2MllTbWtUbFR3b3dtbDNNOTZWRWZiQmRqTFY5Smh1SjZY?=
 =?utf-8?B?enFLSDVicjNmQjN3c3pKbml6M3NNQjdiU0t5Zkt4ZDJFSTU0YisvZ3Q0TVFj?=
 =?utf-8?B?Z3plL2RROG04Wk5qS052NGY1Kys4U3VQcjNad0xZajJpcU5sc1VYZG9jVnV6?=
 =?utf-8?B?V1VVWEVXMmR6TnFPWmhzWTBDN2tFMUx2c3BodlRoV205dUpkY25XUE90VGMw?=
 =?utf-8?B?QzJyWjRVa2NrMHllM2g1dGJEeTNTT3dPNGJOeTgwTmVPMWJ0aGIwK0dmd3da?=
 =?utf-8?Q?0xp6hwVKhgFkI0PrR/+yfJYOr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47808d27-003e-4e0a-699d-08dbbe40c5a3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 03:29:20.7532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtqrKbZtmBDfft7I8rDV2Rw2LnOewpd6RZknl6eRSgET8FQHWEC7tZP9vvsSDSSGr8WcohHFdzrNdBfOqdQ7Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per binding doc, i.MX93 GPIO supports two interrupts and one register
base, compatible with i.MX8ULP. The current fsl,imx7ulp-gpio compatible
could work for i.MX93 in gpio-vf610.c driver, it is based on the base
address are splited into two with offset added in device tree node.

Now following hardware design, using one register base in device tree node.

This may break users who use compatible fsl,imx7ulp-gpio to enable
i.MX93 GPIO.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 6f85a05ee7e1..4b111b8c1931 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -825,11 +825,12 @@ usdhc3: mmc@428b0000 {
 		};
 
 		gpio2: gpio@43810080 {
-			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x43810080 0x1000>, <0x43810040 0x40>;
+			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x43810000 0x1000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&clk IMX93_CLK_GPIO2_GATE>,
@@ -839,11 +840,12 @@ gpio2: gpio@43810080 {
 		};
 
 		gpio3: gpio@43820080 {
-			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x43820080 0x1000>, <0x43820040 0x40>;
+			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x43820000 0x1000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&clk IMX93_CLK_GPIO3_GATE>,
@@ -854,11 +856,12 @@ gpio3: gpio@43820080 {
 		};
 
 		gpio4: gpio@43830080 {
-			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x43830080 0x1000>, <0x43830040 0x40>;
+			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x43830000 0x1000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&clk IMX93_CLK_GPIO4_GATE>,
@@ -868,11 +871,12 @@ gpio4: gpio@43830080 {
 		};
 
 		gpio1: gpio@47400080 {
-			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x47400080 0x1000>, <0x47400040 0x40>;
+			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x47400000 0x1000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&clk IMX93_CLK_GPIO1_GATE>,

-- 
2.37.1

