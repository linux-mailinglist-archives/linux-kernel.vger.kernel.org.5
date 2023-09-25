Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E067AD1ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjIYHmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjIYHmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:42:04 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2068.outbound.protection.outlook.com [40.107.241.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658CEE3;
        Mon, 25 Sep 2023 00:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Annb5OLt1bPVlDsFGcJV2A/CHZsA7KNAYfGlYKA13hWcO7HVmeLJ9LuQjdGLi+1Pd5m/lqJ/JIWQP2YpdTPH0vzfYxhmDHeiWA9fK7DDobO+dCgwZ6gU+eDi3Ed+dw4eE8HCpaf5eXB7M1HC9MBfu7dLP+VfVhmbGNmuT2b6K7Nsfx1gh7wQ2LFmOGk9Nk8VaO7Z7Hq0iBRPThnvYgsjCOM3TyMP41Q6onz/GPa2vZNGRQH63lkE4w5kpigPmGsf9tX/JXpdWsz8Y/WMuK1+ZIg9n+L99KDL4M2yh4TnIDMEx22ugtyuf9vGX8aLLfKgmUh8IZQiIEdEIcthpzuyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Cz0ga+f/D+gXGXJyWWMdxP/dfG05Spg63Yu835pajU=;
 b=WiCxrXWfUMJEZDVIAYmT43aoVpfBeHk4VHePHOVxGEzXPxnM+2e1MvLYig1xvvsk55sTmzhQypuCERA8GHPC58uFzH9qSQgv8T3RRqOXWg64ZBqlO0rPwDMnTxe6CbmDgSi5RcOd0+0OuLh8a2b4N1LqtWEGlm6DFE8VIF9Htsix1J99+mnOLKDwcr+V/w5Mg4k6/zqX1PxoN0XhqvjlGBxh8X1LnMf2MUXbJTNzXR/ZnVubR7IYGYLN9m5xmA8ZPaKZTA1ftWMMPUc48Ws8AwUdyG07T8m+Fv8VIvA7Tkq5K44APKXHq9LBb87XMKlA7fPQcQZvIA4NeBobXJB0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Cz0ga+f/D+gXGXJyWWMdxP/dfG05Spg63Yu835pajU=;
 b=YbC+f7RI5IixwoDKvqZq8WJNvatuJIJnAKos6gbTQ1vbnHDxdG2UEu26+4Gqgnfv1bUcsbXlnvMvmG7ucHZkJeySSj6pTL4kr//PhcCO+kteOTI62qF9+q7ASPLhFe7mQzH4SRl5yGSZUgK5QrvKYqLnMya0qdeexhqzCB96h5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8218.eurprd04.prod.outlook.com (2603:10a6:10:24a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 07:41:54 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 07:41:54 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mirela.rabulea@oss.nxp.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] arm64: dts: imx8-ss-img: Assign slot for imx jpeg encoder/decoder
Date:   Mon, 25 Sep 2023 15:41:30 +0800
Message-Id: <20230925074131.10133-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB9PR04MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 796e50a0-c195-4c15-60ef-08dbbd9ae37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ku+E82jYaisEdUzVV030WEY7ymItABceY4VTUSXB2gAnB0TbkIUUCygpNcjUMH9rZuvugUAGooklAhvpg/+l5ayazLy3/8SKiH12ja9maYBXsaaOJx8P5soGV11YdABxuFNusJ8Oc1ExSo3ZWtLL8r1WHQXvbUARKltS2hKSvH7WhgNKpET710qXE5PIX1umpmXB4r+g7LvPyr23WGxEH61asO/jnL4Y04O03n6LKx9TQCooC5yEFIY60nR/4q+q+WOymZoLTVvU7FI2ibJlSbeYy64RzcfDgM+d6APNh2BoGfc10fC9ZV8YifOmBG96mH+mzWsaWUUg47u52P/OpUmEc7Ps2sEnIUUG145GU11nxcKa4awgyNUxSEEv9hUVr39USNKxY7OiFvzQaFyknvrjFv5q9ElAvPkph+qmDrAzDoAqpJlpqgPFuJuBKg3dq9XYKmAsvwFxmgJB79QraabfBd7VB+7NZuVo53Fv/EaoINLi1iLjpWg1jJVBBDMnSU0t4sfjddoBqQW/DXaZ27InmrSVwAgJqkM6NdqGAZAjsZOZrUPuSLdT5HBT4vSb9UKLNnBY3pWGwc4YmuDdv5Av+cdo1qNh8M8WEVeBp1S9ZcQOFnylc81M/oPwy8/q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(316002)(7416002)(41300700001)(26005)(2906002)(5660300002)(8676002)(478600001)(66556008)(44832011)(66476007)(66946007)(4326008)(8936002)(6486002)(6666004)(6506007)(52116002)(6512007)(36756003)(1076003)(2616005)(83380400001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LNMiqKQBJSLQ39AikKqZtCcT1cF1DwZ6ZWRe4zIS7v9JIS3qVLNGlvgJpc/Y?=
 =?us-ascii?Q?f1cUy4ubHmYxo6QKUfKPBxpkSPALHc8z9y57VffQ37OQRQ7CENwg3+TYJBs1?=
 =?us-ascii?Q?U3mnY2orJVQqSdGpGFjSL53CCVywrZWy8LKL1pbDdO1WNGZD5oawFzJBB09J?=
 =?us-ascii?Q?mGdhHsPxRkV3K+6Cdh5pqT+V7Tg8G8hGmyzEdSqXWiVMi2Ek95zbeisQq3vl?=
 =?us-ascii?Q?/g5OGuSknEBgqFCFD+PI6PFwHb1U/PII16kIjV6j2H43W8S/UiXGz78pnKoY?=
 =?us-ascii?Q?Z7wh39dlTjJZYb2nP9jCsUMNzaqv65FYCcn/P+0LuKHBNZgOyrTTpd7C64AO?=
 =?us-ascii?Q?zQBE32+oguVTKX8Vo4hV7nHLE0AGfS80ujeNM2VTeGRAQh86twSc3qFrqjc8?=
 =?us-ascii?Q?hJ532vgp9uxb4DM699xxrOLbWvYvCZndLqAP2wtrUfuikKH4Z+/6TClvi/Ov?=
 =?us-ascii?Q?dNCRF60Q2yXtpfsJDR59h3nQOaCoo/Pcr+LkphJAiwQNbsAUgbMg6pdcaPjN?=
 =?us-ascii?Q?fUREUdVDLIWZiui5nSe01L6ZZbdSzBt8lIGpYBRiplC5015As1rEbdHWIgks?=
 =?us-ascii?Q?McrypYG+qgNtsAGaaz+wbLU3gG/9K2ggXrj/HuPqC+kgT/9T4HDQwZK8IhAs?=
 =?us-ascii?Q?256IVF/Pwy+pS+XzYTNMZycB3/BiyYnoFMstxb2yRd+Fu1+YGJOc9rS+8Gl2?=
 =?us-ascii?Q?bv6Nisgske11zSCQ25xY+PSs2KeDzkATUIo9MnuZW7m2o5s7mYwTPEVhcsqr?=
 =?us-ascii?Q?GTl/8PaBRNCePfD8XQ4oo0QAh2cxj0LFqlwStyY9OEc3NxvaEsrjY7QzTc39?=
 =?us-ascii?Q?Sm/sYys/vLpZ/z7DlrTMChaa76g9C+YU0fhmpU388MltWXd14C/C2ARdaWkv?=
 =?us-ascii?Q?OjHOI6Sqfy5+QbqDBgLdko4v12AKILay9AFnlTK8otyQea8zl8WEI7UgplVY?=
 =?us-ascii?Q?UgnIBX2yAUPpFuRRlc5mslnBCn2rtETKPCQOvUbgAWIl4YyF3LF7yJBqF05Y?=
 =?us-ascii?Q?6DPIItYsrywkca5OMn1HkoVWpMIhH3FhUQNctSpSJEYk7hgjOYFnkR60u0rw?=
 =?us-ascii?Q?MV0Y31g4BUbaSSDldVX7rgIid3HS3z1XMsY04Dpqnoqj0E/xqDgwZ2a+mJUU?=
 =?us-ascii?Q?YGPpJkq1BQK7lDN3rCSpqqUU2e9SJjbsiV/2eOeqBk27Rhei5S+oIUv/E4Fk?=
 =?us-ascii?Q?b/YYOOxiOdw8k7JPSkEzCAYeSR46a3y4oSBVlRndS74gFi/jmEvVhXyQLzAc?=
 =?us-ascii?Q?DxCqihy0Jd1qFJlhJt+hRN6Ovz35uYjdHm1o/O7GySpMgWkEpWxNYXFVgLoQ?=
 =?us-ascii?Q?Ea3ZGvRy8Ek3D60HnCh/keCXI0XlIUqR/MAQYbEn6pUy/Zgi2h5RBpbVylqr?=
 =?us-ascii?Q?5oND+aw7lpEfu4wVjb7zbvS5iSo7E4co5eC/8QgMhmJOH14xDbSl3ARl8Xvh?=
 =?us-ascii?Q?xI5qxde9OvgVGmsq8dXeFMRM7uAb5t7Lz3zmZ449vBDwg2ZK426c1BUdTgou?=
 =?us-ascii?Q?MfTxflVezGQooUBL2I6OZ7lHUuKxtwKh/GV131oD+4dYiCcvLqFFGOl3ImlH?=
 =?us-ascii?Q?9HBJ9na5M8N2ZnrT3jzX6A2mLUXr/jBRlxYB60vK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796e50a0-c195-4c15-60ef-08dbbd9ae37c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 07:41:54.4834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jg7eqbj2rDN1Vg9jH+yycEyDcDEWukGBfAIFGH3CtIwlL+N9PqnY1Ak8XnNKKxJ69jzWbRXI62zhr1W5kjSIFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are total 4 slots available in the IP,
and we only need to use one slot in one os,
assign a single slot for imx jpeg device node,
configure interrupt and power domain only for 1 slot,
not for the all 4 slots.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8-ss-img.dtsi | 22 +++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
index a90654155a88..3043c416c43e 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
@@ -18,10 +18,7 @@ img_ipg_clk: clock-img-ipg {
 
 	jpegdec: jpegdec@58400000 {
 		reg = <0x58400000 0x00050000>;
-		interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&img_jpeg_dec_lpcg IMX_LPCG_CLK_0>,
 			 <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "per", "ipg";
@@ -29,18 +26,13 @@ jpegdec: jpegdec@58400000 {
 				  <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
 		assigned-clock-rates = <200000000>, <200000000>;
 		power-domains = <&pd IMX_SC_R_MJPEG_DEC_MP>,
-				<&pd IMX_SC_R_MJPEG_DEC_S0>,
-				<&pd IMX_SC_R_MJPEG_DEC_S1>,
-				<&pd IMX_SC_R_MJPEG_DEC_S2>,
-				<&pd IMX_SC_R_MJPEG_DEC_S3>;
+				<&pd IMX_SC_R_MJPEG_DEC_S0>;
+		nxp,slot = <0>;
 	};
 
 	jpegenc: jpegenc@58450000 {
 		reg = <0x58450000 0x00050000>;
-		interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&img_jpeg_enc_lpcg IMX_LPCG_CLK_0>,
 			 <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "per", "ipg";
@@ -48,10 +40,8 @@ jpegenc: jpegenc@58450000 {
 				  <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
 		assigned-clock-rates = <200000000>, <200000000>;
 		power-domains = <&pd IMX_SC_R_MJPEG_ENC_MP>,
-				<&pd IMX_SC_R_MJPEG_ENC_S0>,
-				<&pd IMX_SC_R_MJPEG_ENC_S1>,
-				<&pd IMX_SC_R_MJPEG_ENC_S2>,
-				<&pd IMX_SC_R_MJPEG_ENC_S3>;
+				<&pd IMX_SC_R_MJPEG_ENC_S0>;
+		nxp,slot = <0>;
 	};
 
 	img_jpeg_dec_lpcg: clock-controller@585d0000 {
-- 
2.38.1

