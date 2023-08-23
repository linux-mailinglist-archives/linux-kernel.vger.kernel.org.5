Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45174785F16
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbjHWSBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbjHWSB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:01:27 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC6EE9;
        Wed, 23 Aug 2023 11:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ3wEuNnwl4xxLSAYKBONUo9Q2Y6R3FWdnKrPtJc3CXOGdNmi+Upc77CEzsWDG5kp9oBLFEoEp5dTbESckUSdECyd50HTq4KncnMgHbuhx7zIMOfNDvaD+i3XjT1fVB3MFavYSQbuNAtIpfgd0hJ8aPxNdwwWf1360j1w//l53cuDJYRdnP5BOA34K1NF1TAr9o47yKFYto/z8EnCbDbcJP8S46tFouFP+kyOk5xoEq07IOWxyq74nz9SLGrsgfWZtUJJE+Unw//v/QbSqRgbKm2v3HuthrcBNIEONPLWxMr7KeD8E2QWq44WuaLDzhkSHE5FlSZoSM6+7eoVZzy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxltGxRBPC+mjp6JKNHw0o6snzMx++xQtp3mo+URWL0=;
 b=Y27ogCvcr0iu0NRBlvKWUbgzXsRR16CnOLMpA1fR4ghaWhOfcIysyaj9nNYDOdXibUNlURNwXHj/uQe65WzcyB1384xbbm+2s72toD1rc2kxD/HuF//s8FnWGk5AnxtJUdu/1sk3cQFrqNQiUv9UxPJYu3atr97rXUH0UdGzKZDg6wj+C0EAXYZj/+/2xobtmFyly4gmB8ZrJEE8xW9NAx3JbM2zDSixwIhQFFW0cZyvp1YYwABRvZFnCcw/0a2QvJtctX8zewUCvlqZdEhylh59s9eX3JMXFIB0zWkegcMhNgoh9sPKk4UCAheNmac97nNCuHyQZ4P84UUTWSzRlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxltGxRBPC+mjp6JKNHw0o6snzMx++xQtp3mo+URWL0=;
 b=G2UtQfK0wLWnP2yV7UiTNoSP/ADRFUkEK4qWqvAO+i2Px18brIQz6oZVi4Z+LONID6xBJoIFMYTloqwvM2g1LK1ybp3QRJUnTkqAE2bAPcjtKzQJH8u6hRpeC1Gllg7LVOlbNAbLFrIM1Kb3/Et9t4n3JGCJL3OGDXaJ6d2kFhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 18:01:23 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 18:01:23 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Subject: [PATCH 2/3] arm64: dts: imx93: add dma support for lpuart[2..9]
Date:   Wed, 23 Aug 2023 14:00:54 -0400
Message-Id: <20230823180055.2605191-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823180055.2605191-1-Frank.Li@nxp.com>
References: <20230823180055.2605191-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: fec0217d-2e33-46d7-b8d2-08dba402f667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDKQ7CZzSWD3wskkkTMwRdvPpAPFWP6pgdz8jpWylWzUXwcDxXS+KZvNfkwyGeiVSFFv0RkENHu1q2WzCwLrJg2EMwemvNpBIFKoChtXab4eNh0F7OdScZqf0OLb4oQ1c1pYyPy680DSEmnI/sJFWMZ0+bS50TyKAj/obNcZP9XmXeMtGBgyEUzzKvh4FgnoWFO2Sl3u8GZhMlu3Ukv61j2giFWuCu0gTvqAn4OmW7k1n/Wafi7uCWpQqV0FoG7rAMzMEIU8l4B3eCmXSCMbJn0tQDwXUXNViqMiAcZ2/t0NVeWXnRb4juHsN4guitHcAxD8saxiVQEVKIvonTPOSWUoUQFH3wii0FIVIo6mfb8rSRMjBWX9gTV3HvdguLv/j7D+nCsLAZxc3vd+Pm2syTZ5Z6vF4GN6YegV68FO8O6KR++LMIES5n+To8VP78Y3IZ+unObmj0omHyDSns+/0phsmxZhQ7X7gaiFKK+3ld3o2HcA5eH4Sw5e5EmhAoygk3Kn502lgZjvQfb8BHshl40Uv/LZi9F8uBVCTMlSCSQGumrQQxoKZoXlH+WvlNYWjDLrecl+P8apujbOG/Xzzat0DLmwzs55gR6hHp/LQg3EbKPbpRCX5SB8XjZlEWiBJv2pPi8dcp7lpK6gtausgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(1800799009)(186009)(2906002)(7416002)(83380400001)(6506007)(6486002)(52116002)(38350700002)(38100700002)(5660300002)(26005)(86362001)(34206002)(8676002)(2616005)(8936002)(4326008)(37006003)(66946007)(316002)(6512007)(66476007)(66556008)(478600001)(6666004)(36756003)(1076003)(41300700001)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m51ai6jiSoVs0wqosY5XOA2yoUDMmzkmKmdZJ7ycdPNJmmnuv06+F2iFke8m?=
 =?us-ascii?Q?a1qr4PouPpppkUPPOJRx8+h3i8sQ7Oslasa9B7zK2ckoUoRPvlJko59ak9c8?=
 =?us-ascii?Q?iVQGXFsno2J1oei/5HTvcPLFxC0JU5H51hWcEwfccyIxQWdMfLud8tBf9ZTO?=
 =?us-ascii?Q?QttP3cLrgGxIZXYnAZFj+ZJ+rMnt8VRGtIGqTXqyqtKPiT2jAF7v3FOPo4NG?=
 =?us-ascii?Q?nrqbj3Y2/AnEPKPIPsf+PI1g3XF7b9USb/oeDuagOqm3H1mdxR18JQOYdfTv?=
 =?us-ascii?Q?xaaIemPb4dYAvb9YMKacE0LnfrhZZsK772P+8lN0155msx+CL6jPqU26+KA9?=
 =?us-ascii?Q?z38zzXykWmvz0ii5CcCwJUHwcDb03zM2MISTfGEJZpuPBURWyXKdnspkv+7c?=
 =?us-ascii?Q?OYA/PZuK96bbVvfYGfkRjVEuyirmQB9RFU9i7V/FiWFrox5JxSRJE3mVehzS?=
 =?us-ascii?Q?02f45KwLB2Bfh+DYlcgUu3ikbJCjCirOZU7vfbqaRHNpqkPIHRi8opGdBpgM?=
 =?us-ascii?Q?n/cl3xyHPukkaV08cCEFL6LScoR0jwdVOkHoPGRaD4RYd38iDda6HYbC6aho?=
 =?us-ascii?Q?w518/n2l26LfNkZXuNzfrMZa15meH2gweK09IjJriiemzIPQTwK42qAEVwz6?=
 =?us-ascii?Q?3waGJFaiEo61F/+HtUTzF1eb6DZ3NeT1GP0CfjuQh3/zG7Bfkn02W4vExUg7?=
 =?us-ascii?Q?k2maevWRFzJtgouCevbiP2RI1we0OLd3O4h0u9fttnj9c9dTnHqIdKR5AHfu?=
 =?us-ascii?Q?3T0EcmkK1xX2uUq8PZUmes0jNOeJOfyUzY8sjX0FUdWK7RCZaMe2bhVVLg8q?=
 =?us-ascii?Q?ewtCAdFxlCl5jWQKDEmsgJgiQjMiG5Oa65sXPnuVd+A8SJ98wLuRLHByWqnC?=
 =?us-ascii?Q?yuQV78x5abqNzIOVTz2goY9yjsgFYdbb9AcgpMUZOK7+SKu/rty1K1hbhCJ4?=
 =?us-ascii?Q?VgVlH/1FY7xQwuaAvmHZQJ6E1qG1byutlOI/48EjTYv6i3Y2P9YyT6QQi34q?=
 =?us-ascii?Q?6AS8kGT+X6yUZapikpxAZTZLTO1AhO2jwbLfpUksEFteDtwl46gZNortRZDq?=
 =?us-ascii?Q?Dlkjg5Ia2NG059aHQssPgdFvoxxtgcbndPfGABYpkh1GpQPid4oAmeXewJ9G?=
 =?us-ascii?Q?8J1dV72oC3OWzmHiswFwj3CohyoJfHiFBsiwaF0zV1McFedqPqz4zSRi13wy?=
 =?us-ascii?Q?Cxo9hTtrwBZKN4WvQMLfIUL/DgiKoUSP5RZj260J7IY9r79/9tyfNEGldnv0?=
 =?us-ascii?Q?Q+Y00CybmljrTv9Oaby8YiNZFHMpA48yvJdrBZWeJPQUGBT9u8ERVf+Iu1xI?=
 =?us-ascii?Q?Xrs3bi537Qe4URUBm4WFnFVZpsScbhnr9fx0seQtTajBD1xMNYtfVBZmassp?=
 =?us-ascii?Q?wtfd9towhP61VeOy0C85I0FKD8AYdCre7iMCh247rNQJDux59ZOP9hwTdAxn?=
 =?us-ascii?Q?dRxiptuDy4AHeqxhQERLgz6ZUM+wQcMLWKCD34eeCT3uiN5N3tdgprz8Fh9g?=
 =?us-ascii?Q?6YwU1kr/kOsAZBoDu2+0mn6qFBgLUgj0o7XL+ZJhFdXsPZ+h/MjrhZs0k9JA?=
 =?us-ascii?Q?HMgOcUiamym2rWrrTgg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec0217d-2e33-46d7-b8d2-08dba402f667
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 18:01:23.5586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRM1lq8txOLrIWA2Sp0LLZve4vlstWEC5jCCzhR0uKGcxSwK2PhDfnZJzFwYckIPq0aT/wVn+j4nbFp1XqxbCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7502
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma support for lpuart[2..9]. The lpuart1 is debug console.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index acdca18673b7..c731eca4b3b5 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -345,6 +345,8 @@ lpuart2: serial@44390000 {
 				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma1 18 0 0>, <&edma1 19 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -666,6 +668,8 @@ lpuart3: serial@42570000 {
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 17 0 0>, <&edma2 18 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -675,6 +679,8 @@ lpuart4: serial@42580000 {
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 19 0 0>, <&edma2 20 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -684,6 +690,8 @@ lpuart5: serial@42590000 {
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 21 0 0>, <&edma2 22 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -693,6 +701,8 @@ lpuart6: serial@425a0000 {
 				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 23 0 0>, <&edma2 24 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -731,6 +741,8 @@ lpuart7: serial@42690000 {
 				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 87 0 0>, <&edma2 88 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -740,6 +752,8 @@ lpuart8: serial@426a0000 {
 				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 89 0 0>, <&edma2 90 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
-- 
2.34.1

