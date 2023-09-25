Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBFB7AE06D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjIYUuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjIYUuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:50:10 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27667139;
        Mon, 25 Sep 2023 13:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDFOHZ7H1mtjqdypEjiIWTpPO2u+zKCN5lJByuhnYxxIqnKKwKOWP4SMfHGqur0zj8LyxtG+9J1XiZLUMZ/6l4ws9UmOuMDI5Uyp6ftxOXWbfSB2SfahxEEiHpkDm7K/evzSgnNPTqsB2owXKvhcXd8zyNT1WTU4jZbKNPLYmG94T8tJF8oI3n/5m5U99Rt+JssmwHGSW3iTyTUQBIJ+bLwBhd7of8y4hey49qK98Jn3U3OBlW3H9HsXZOQ84cpB9IOH8n7z/m+OdyHJ/dRdo6irlQXuMvR0CKfvFLNMAXbe5uuVb9kcDD+cqyaCD4kkBcqGyooQM8iYcHIrh/SQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZSnVPRDxEWRqZcw355AboQBhOaIkOI+gi2/LCxEEHs=;
 b=W5DkUXsRe24UwOUianzSxt2cepKDMc0uvnsMbGkSTDGZE+92LgbUOmABpQ2Tz4MjCTdE8mSLuImrnR4H7s6DasxSE6CHk31rE953uXd8nNI89fIWs72EQoexGTcvfUEH900esDYFRj2VeFw9HfqealYuHGxojVbtlB3LSdtMWeEPU0hFtuWd2lFVozoglY5AvFCODG9iHfevwuw2EBiTs7R9EvBFzqLze1eAPj1dCM3IHoUzTjPzPiul49Kr0lJibl0YgsfCRp9gio4IPpXIm2+Ko4jz6U5EpxkypCBgc46SkUhUS8N9NBi/c8zdKETMsPmgYnFcM3ugluDdsk2n5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZSnVPRDxEWRqZcw355AboQBhOaIkOI+gi2/LCxEEHs=;
 b=TfJ+ssEsEnQRRWS0YJEIzRY/JIVPsa7XheOV2tCXOYIuo0ENgrevblLtDbRKHD3GDWjBbnMFBvDYpoBI9gSY82fbKOELQgErrUjgvFSFJpkNczDf2DcKKlv32t/cx2aI/k0zRoe23EAlrkxPwzZ6nrzFclEvKGxoX//gep6nWfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7809.eurprd04.prod.outlook.com (2603:10a6:20b:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 20:49:58 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 20:49:58 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, shawnguo@kernel.org
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shenwei.wang@nxp.com,
        sherry.sun@nxp.com
Subject: [PATCH v2 5/7] arm64: dts: imx8: update lpuart[0..3] irq number
Date:   Mon, 25 Sep 2023 16:49:11 -0400
Message-Id: <20230925204913.3776656-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925204913.3776656-1-Frank.Li@nxp.com>
References: <20230925204913.3776656-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::14) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 085d22c6-559a-4d68-f46f-08dbbe08fa9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVtmcTIdz8flAifSg2ISerd/o0GgN2P+hwS2mywy7NEGuxoh1/KaeHwpYoQpKJ/CBCbwv9aoQsFLbe+x8ZwLqkM/DoILG2B3D0xl41YUZ+EfcFQGKcdLGg+/v2yPCGce0eEpYnRxVAvfCPZpvYfF1mXKqPo0Typ+v9xRmWYG/rblefFbauiGi5T+taLpMkccvwDF0BwhwjaDA3nx621p0VpPXdWfYUD50wgKMC+LBNu05wgV0+EUBzk+qAxwTri+rgWELGfTpaTo7wmGI3EUCzGU8tjpsKO19GrnLkLfdBCVCgGo52BaAO4oLYZt2v7e3e5MWGlVmdWGUNZl2OPxBfvJeLWWF9/Ky7lBizeAnuPEpeoXqCjm+FCWGAyz99bYrNrAlWhgIckQqYvi3hLnx+brrV4eOLAV9p59p1i73wk1zoPNRg1fJwV08RnWBLuoexoppXxxGqU+Ii4cEww+jROlQAU2oPwRiNq7/U0+V34Issze48h28kB9doZ0L6SbzvXqx939H7XRe1eHBzG4TtO5pO2m+4QExbPJl+5+5+MjLBQpwgiM9I/1/wRXEcaHQH+DOHHXYFR3pTLWBatxhQSX4HXz7vGyZKfUToTCnJ8Sdpl/4CGsfhwPXTGHBsBTein8uY+n3MWJpt+IS+MBPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(5660300002)(83380400001)(2906002)(316002)(15650500001)(41300700001)(8676002)(7416002)(8936002)(36756003)(4326008)(2616005)(86362001)(66476007)(66556008)(66946007)(1076003)(6486002)(52116002)(6512007)(6666004)(6506007)(26005)(38100700002)(38350700002)(478600001)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xbuMC5kgYQxSngm+HiEQtG+jnnSOEDF4Emxb8DABTmJ/WDZHJFq7Xehn0gCw?=
 =?us-ascii?Q?r3JgrT/+5lhA1QK+/k/RbGEarD4DFHuJNrQe3H5wUJCrsQa5cFVLK/XBjuTa?=
 =?us-ascii?Q?9NdCmg0HewxYr8ykIlvu9Qjyud459cQKxWwmIW3f8njdS7zs/2sJR8mbFE60?=
 =?us-ascii?Q?5HBtROQfv+xKCnLVaRPZquYNl30uasJrFxIFOC87hJK8wY4sSPgfXS9bW13M?=
 =?us-ascii?Q?aBv0Q4GBXCer7SZaGHd6vZmssC5mTSbDxF9fzyCMHLZMi2XvzmIUV2ZAaKOe?=
 =?us-ascii?Q?TyfVGdl+pq4gZ7/sE97AOB1yWzKzrCMh31oHjS4ZpohzRRH4yRvs8Tmnsqoc?=
 =?us-ascii?Q?sdcw05UEVCM/mdKQi7Llt+/lfurhAepCknYNM9n6ixAVbvazOIfypYuVCbCt?=
 =?us-ascii?Q?uI8MO/AhBqZafHBcGIo2EdAJN6qa7N2z18HuxS5CsASEsRTorPbHEOuB2uh3?=
 =?us-ascii?Q?t2MROHzEQEIxTGh6YY+JK19VSiXnSQ1I7A/QTyHJSS3vkF51IJsH84t21X0X?=
 =?us-ascii?Q?0aa5G/5wchOrCTGBHRYVAZTfeJD+rLek1e0zbEEx0MS+UePU5ZHvJnun2Skv?=
 =?us-ascii?Q?z+Kj2XHWfE8u1Xluh064+1NlaELHzCw/bYGHGK3bWlImopuiQijwsN9H5xwW?=
 =?us-ascii?Q?Ajf4ds5o7oVig9o960hAenyZGguHwU7bXiFGej4IxMjyUuf6qFJZ2GX0VXRY?=
 =?us-ascii?Q?Z37A2wYdx/GzF8dewNq5o4lEB5wFbDZIWMUeR5DvKomYo+ebn4PnnZGlYbCr?=
 =?us-ascii?Q?ngIme9oT7TyL3Bn+cc6wU3WBHxKshroKS/d/3PmKZP4Xzs0ncdbaAXf6J5tQ?=
 =?us-ascii?Q?WAFm6WVrivlgPjIW9u6tazVoE065/ogyxOWLEJjESq624T4np9kncgpjVbUz?=
 =?us-ascii?Q?bZZrADLXDXNx+E/kdkfc73ZUH69FPpeN8rgOLgvPA+ObYwVfra3FtC1bvw8P?=
 =?us-ascii?Q?D3Tn5O/Ix0i8/cC6LAGkTETDQqd+8HG/IZftrc4x7iqjyNS5HpJlq//CvALZ?=
 =?us-ascii?Q?I3R2aWyANnGIN5rfzPXMbEu618Ny+SYPL84ZYZY8vDsafX2EbR82k8OQPmoN?=
 =?us-ascii?Q?JpDBjyVRCAPnmIDEdngjDkoLJdrpYVpaIFR4Ci1fao6mh7nQn4tnbqGs0GDc?=
 =?us-ascii?Q?86amT3zignuF9IEcbkLGf5XkDG+54Rs0D2XzrXMzXtfc+Ap00Qhu8NN8A2Qf?=
 =?us-ascii?Q?ZZ6vYFVk562Ooy4Jpx0LyAY1AKT/O+h7Z93Ak9uFFsE6Edo8KtjcSj4e0Gi5?=
 =?us-ascii?Q?EyaW/peMa/76+qdpMhPvGNPxIsiOVMNonCvyif1KL1REx6SC9nADrtOq3qYx?=
 =?us-ascii?Q?hxSqwr3KYiE/jOCTIZBIohHZ1h+u0IgrYoqtbkDyhJfJJf3wlp0sDNdYAweg?=
 =?us-ascii?Q?jdkI7DXEjnOeNfvS/8nu/HDwQmu8+rOl8AqGHv2FX/GDl4NsVf1UdpRzpZip?=
 =?us-ascii?Q?T88qHofL9UpJ+jP12A1NEZiXAHK2LIzvTR75Nc1lg2ae1Sk/yA7p8n246f3X?=
 =?us-ascii?Q?Fz/cW+/5AERhjPYkzY2MqmVEJHPj86h8kpdG6ar4T2NkPVF1aho/ZekO4UXV?=
 =?us-ascii?Q?rKbbDv56B+S7QCFq6LQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085d22c6-559a-4d68-f46f-08dbbe08fa9d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:49:57.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ON03p2W7W7JI5QV13vNNsk6bC+AJIvnRfNViguSjQ24Wjoiszb2sSQQ4RefVjCwJU5+oUlzQ5/TzkHkhXm8bIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original irq number combined UART irq and DMA irq. These doesn't match
uart driver and dma engine's expection.

Update to the irq numbers, which just uart can trigger.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 8fd924dfb029..ce66d30a4839 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -86,7 +86,7 @@ lpspi3: spi@5a030000 {
 
 	lpuart0: serial@5a060000 {
 		reg = <0x5a060000 0x1000>;
-		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&uart0_lpcg IMX_LPCG_CLK_4>,
 			 <&uart0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
@@ -100,7 +100,7 @@ lpuart0: serial@5a060000 {
 
 	lpuart1: serial@5a070000 {
 		reg = <0x5a070000 0x1000>;
-		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&uart1_lpcg IMX_LPCG_CLK_4>,
 			 <&uart1_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
@@ -114,7 +114,7 @@ lpuart1: serial@5a070000 {
 
 	lpuart2: serial@5a080000 {
 		reg = <0x5a080000 0x1000>;
-		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&uart2_lpcg IMX_LPCG_CLK_4>,
 			 <&uart2_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
@@ -128,7 +128,7 @@ lpuart2: serial@5a080000 {
 
 	lpuart3: serial@5a090000 {
 		reg = <0x5a090000 0x1000>;
-		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&uart3_lpcg IMX_LPCG_CLK_4>,
 			 <&uart3_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
-- 
2.34.1

