Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A55C7A96D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjIURGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjIURFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:05:19 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA222132;
        Thu, 21 Sep 2023 10:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz+kJ1McC4G0UGlIZYL5TdzDNEXtCA/b/TEkIKeAffXKIuHu441XpkHMGW0GOCKrZ60wn2plnne8kspxp6EobzaxGrBbE2pnp8oazH2ZpjHivzLUeu4GIs+Fv97uqAHQDn94e5Ftnq9WAR6epAIkNI/2LY/iEDMNzDYu+2r9ETrjxbMx5ghtTqebdo/yplwMQjHDirOQRUkJqYLjITTC7pk6s3n79isfuRZI+yD24Zi6XJ+UGj7rWfh0KvKNL6soF0xIqE2vyYCL71f+j7AN+ZuBqubv0B3wzQEFN2AMdDBCvkayHfdIEUR4HzsPJhOZk8gRUChZxJpxPRAo8lB9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bEuT3Akp62ZfYHy6luVNNKX9T0bttqvL2nGd1nvaRw=;
 b=e3owzuXksOowFq5g+ccWGLCmudEhC33KLdpTGzQpGR9IfNwMZ98Y/Ghcz43hInQkc4WJxxkE1ZIaApygoa+rOGkRbDAamfe09ogrzXGT1aa9aHFFVYmJ8eBvqAc5Lsq73gJTcXLaRys3nh2Em+lmc1T+yaYChou1yWe2IKPWDfaKaci1DxKaEIQQFgLUf/XHjIkqfdjzmTlygMOUGy2RBWuj1xJP/0NHASEgFW0Z+ydcaNJ+Teyx3ynBY7eswjmv8ayJbspINZcM+/fXDAW9r7VRoy5vUlYBwSfY/TLoB+h9purQ3owNGc6ciJg2t05EhHEqsg+chbjhQhqIFRuu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bEuT3Akp62ZfYHy6luVNNKX9T0bttqvL2nGd1nvaRw=;
 b=hn6lIcjYP4+lEc3MPfgEnK0HXOH1FpeC33iGwtIECqsT9428Sm7ELRgKtLnSCFhvoK2vwuL14N7B4jUj2dEWhEK7zmF+K6jaEQ2Iw5AgCv1O2ap6l/KM1nUvzn7X6Q+ffkhPTf77xou9UR6ui3webTO0zYb+OQRIB6+vKBLCgoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8414.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 06:36:47 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 06:36:47 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mirela.rabulea@oss.nxp.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] arm64: dts: imx8-ss-img: Assign slot for imx jpeg encoder/decoder
Date:   Thu, 21 Sep 2023 14:36:19 +0800
Message-Id: <20230921063620.22962-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfa275b-f6f9-43a6-e321-08dbba6d2113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fzrwvFw3yr/6+zPPHcol9simBdkVInK/zjrffqmXjweb7yvFnL6/+v0i5B3Pky6MMAEKQ8b+jAv0m5X9yTVA8p/IjQ82CgN/j37lzNWSO4S7P0hrR/ZW/DTVhlIXpvxdIgud1Ph4QtB8C/Yf4ruV8SbajV4Ta0/ZQ0rSXkaIpw+HakaPwnKj5/4Dt0tynJCQCyaHaD3ZOCxHo9SUELkA7QrGE4emn+m/mcBhjR2K8AmT9RX/4m74+pbS7jyu0IW1DtSPvhlPZqy6EykRya1MKlCC9HLwS39E7xrvw5DYDl6z2zdD2sj/JZPkWIVAq3Ythj0Ex1aAjouVYtjPYMb8B58J7V5s+jAoLK0qx/1M5UcbkZBMmnFUOvg9n6AkXQh85MPNuLmw4EwHQzQ9g8ow1VYfCBnP2BH/DCrRSJKwr4IAYfYlLjO7M7E6mDdjTv/jizQpRwtStbyxwDMJQUTMeGKBe4M8WMvkwlmQfmU2rtxCTXrXmmwR+Ri40lVdoLyzjHIPwM+qIvn4z9pRmfxkeTovDfd7UWUqobiS2ZwwYyZJRfF0q62gMsiOMqrscs+LCqV3Bzw9nV8TjaZOISNDjlIBPExhVPF1wC4pb6+IUK2w76MR/pr3zVdcz8XSrx8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(1800799009)(451199024)(186009)(26005)(316002)(8936002)(8676002)(1076003)(41300700001)(2616005)(52116002)(6486002)(36756003)(6666004)(6512007)(86362001)(83380400001)(38350700002)(38100700002)(4326008)(66476007)(66946007)(66556008)(6506007)(478600001)(2906002)(7416002)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OyXi91qpXcBEYjesbYzAn5rcuuO0nwrYBN9TjlGnJhCDWsZ7J8vUZ82gZEnP?=
 =?us-ascii?Q?R3IwZojucBhHdglhwAcTUg2+b0h6Wlf7paPzBd8OvAFkHUTR2z8T7CMHsrd1?=
 =?us-ascii?Q?+DdEKSQ6OOumh1k8jiSuFUQOJm5t7eVAtROkU3yeDpFvNpZbvarv9kZz/Qdy?=
 =?us-ascii?Q?heZJyVm3wWXD6F4qYJ4QHCR4SOIx5qhX+ktvpSMcbn9/u+VOVBSFlrQuvUQj?=
 =?us-ascii?Q?dT39xUMmP4EP4crYN1xS7lAlcnEu7EkK6nfRfJf5TYXSvQcGwmBnUWHHX6Nn?=
 =?us-ascii?Q?Zttlo/1g4p69uGDodEUkPBRcAB6sv6jJ6Uz5DLQ6iokKPU0PCAgd2lpxz683?=
 =?us-ascii?Q?iuD8cqw3mf+kh1bO+b73dhe5h6UcrNLl2q4bRrsn1eAicB618QLrJESJE+ay?=
 =?us-ascii?Q?PNOSlN/ALa0+kPuSrZqsS5hKjWxz+qWsTqFA1sXk/HaojYEY7rwgk464lceN?=
 =?us-ascii?Q?DIqv13R27daAtWeiUMf5Ow3825W/nliMlQYOVBT8COrUNF13GadavXVT0XXB?=
 =?us-ascii?Q?Dtxis0rxmd/2wkKvFMTkrAyv/gHiVddGlJtXqhOmgcceMD2ynJD74M1oLfrA?=
 =?us-ascii?Q?htYKi/PkNTrzh6eMfWsFt9tN4lPVDq/+BuphoSTVc8J4Q7JbbmpzBKrg4eEV?=
 =?us-ascii?Q?0zxm0AHvFOGikqZ2q9cN06kpHYgpKB8w5qY4D/QGM3J4iKoJ9Z2TLlIduzEA?=
 =?us-ascii?Q?uQLYaFobOJB+C7TGxkbHJCptwsciy73Jl48Q4a6tUdNUNFdxqklaVpsPx8aN?=
 =?us-ascii?Q?RUB2jI9faPZbu+WM2YDbgZTxKIGiXVXSykZVBqe02C062i9VXXJMYVS/wgyX?=
 =?us-ascii?Q?ZhjDeWUdxVp0XUr4p89FBx/H122Dztw0+HeK0kfo7un3P97Mo6q5/6KQ1eQ4?=
 =?us-ascii?Q?Wl6g21KQmxjMRdXbiIW0ydpgjD/vYhOLZowi7auTU95yFhD2EXyKqkFmgEpt?=
 =?us-ascii?Q?GBmafFm9WFLJ+MTNB67JXEbnPCxauuoPitKcC+j0EqSg/polKLz/hHjZeNVt?=
 =?us-ascii?Q?3oWeYmx+0/TqzNql+1LVvnrDCLvegn+FQ0jQ1r0F93/H7Ykah5OTrn6cyjYv?=
 =?us-ascii?Q?GYPlMB+r3YEEvefsdwSTkJCdrQG5frRAxUkVunLcT3VxDHutnnoUT5pLwcKk?=
 =?us-ascii?Q?GhkXJAs6kqUw5c7U7+3t1NB/sNyn+W8n2kqDlymaHj03rcWwsKRXR05jlmtp?=
 =?us-ascii?Q?507NriqBJLc2DsfwJCfHpc5lVQXalR9ZdzlpdyIU29cB8iDs7HMoPggtLWvs?=
 =?us-ascii?Q?EHG1m492coBZOWgXnPci80nl3rqBlSE3kPhZLYEGzh3gMdGu7rTLbacVUxEm?=
 =?us-ascii?Q?mzfvN9Q13KRj5phf09RF0BQSkn+a1B7JFpTAgYOD87EOsm7TNupBq6YFb9Fo?=
 =?us-ascii?Q?WNUGG0MKZlnPjV9rcAY7wmUmq51jlLEFBxXEg4WbMhmfIcQ3uULRFKCKkM5b?=
 =?us-ascii?Q?hj+rLQE9d29BovMd4LzOol6159ljvgIDFAEsgcsN/FveUQLd8n2DAhvcbo6t?=
 =?us-ascii?Q?NStjo3F69tyRHF7FcUbDhTrW0hnemMc+hr10JWyEavl9ymP3a7UrRUmHG9Q2?=
 =?us-ascii?Q?2o6aetT5lJQtWUzfug3C6ckM0MX62wmAZ8NNqhRK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfa275b-f6f9-43a6-e321-08dbba6d2113
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 06:36:47.4895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Moi6k7N6czf4uvTchL7IjdFX96yK8W9nzBd5h8uFLvCSqQJixjJI6Wl2uWF3DQv9JMTOUgru5maplT3gqYVptA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8414
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

assign a single slot,
configure interrupt and power domain only for 1 slot,
not for the all 4 slots.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8-ss-img.dtsi | 22 +++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
index a90654155a88..176dcce24b64 100644
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
+		slot = <0>;
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
+		slot = <0>;
 	};
 
 	img_jpeg_dec_lpcg: clock-controller@585d0000 {
-- 
2.38.1

