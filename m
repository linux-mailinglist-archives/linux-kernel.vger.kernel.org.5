Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28DE7AE066
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjIYUt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjIYUty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:49:54 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04249BE;
        Mon, 25 Sep 2023 13:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYabwhcK8vUnqB5J1d/wRdIIJWvdLllAIDSDY+KNrE+wih0bpzFQLwGqPsgPBiioc4XUojYJXNs0+I5AWshP1ctuzB3+7FQkUI8Ykn3zFfE6+6FPOAbTrWqzOWFIXJI4SKRt9olC8irTjGG2KoCoLTu8ET8H8qoccUTJvcI8Y3JSMnm+ll1XO/YzjQbjb3akNX+fsNxQ4gHsBPZOloS/EdquEFOr2KUKYpfDlYv3yvDSa0e0kpjr4gLnxpyS+s05vOh5qKSvkz19j44XRQkf3e400YI/tews+GPDaJ0lLJ7KclqyH2ZJo/D/i0sUgdOt/jCruaxxM0ov1LmqZl9cFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mfBnXjeCHsGDXxbW8TeN2BBSejaAP702s9QJTVLp9c=;
 b=dhqF4gesi7jBDU0FighJNjuHvaAYKBw0Izxv8cMjs0POvj8+63uxP1K2x+Q6p5R9iMqXPNIwvdGuUCDIDX/t3bB86vs2gIJJp+M8c70lzn/Xre3xGHdpqUOYnpLuA6k8fIlRMb6F6gNeQ4BPtpeEZLxZD9Iv1SuOjSs+Qj/M45UfQSN7Z1EENv6qhaDg6HxSgB6Mh8buXeWJMmuHF2r/MkfhGXdxCOZnak3A6uVPgDK48Z19dSEBngorhnb6fHEx+cNTCYzuEbQiCEScT9vAXrHT/3vcIWn4YTBIyflZ09rwp74sK5ggfnG/okFxOZiZAOr+/4otxz2r5zJUBtb/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mfBnXjeCHsGDXxbW8TeN2BBSejaAP702s9QJTVLp9c=;
 b=JYMH49LnVo5GuJgEeRNZTR8BJJXbWb59T4xadXEW1MDbihYwBaHgcqY4/rLiRO0SZWYs1R4cDCYmIv+EeDeSobdgQ5mex9vRcmuETZ0PE7HbznJoB+zODJy87tum5qNk0iK+fDska6WK45k+9VaT+TpG/kY77xX28V3jQf4mC2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7809.eurprd04.prod.outlook.com (2603:10a6:20b:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 20:49:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 20:49:44 +0000
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
Subject: [PATCH v2 2/7] arm64: dts: imx8: add edma[0..3]
Date:   Mon, 25 Sep 2023 16:49:08 -0400
Message-Id: <20230925204913.3776656-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a1e8b8d1-207f-4fb4-7e0f-08dbbe08f243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dUcjQK4FmFml/dMJOB94TxrYrsRF9LpktG7vv/BNcGtN0jgrTKf7c3sH+DdVNEGqHewpZB0cBR7qLuU1QZS6obEwdUFQpJZe8fjh/xLUNogEfB0dIez47aIB2Y6bSbaQjR5S7cpBdcVLhp9PW9/yvSIDHmt9lRbNMBlYoSHUviMef2dJwzuoGPSvA6omcRC8ImEoAdTSVOIR7F6mpxxWlKHboRfR4NutJEu6sTx798vu3U+XAeRc2rPZsfZbMTUrl0uvnMENBDCXIdYQSA94Gq9Pi9NE6M025rsf1rXSMt3b4BFyQCCj8p+lKn0p+EnTaBC5UuH+Ch79cTbdN0Q4W9/Cg2sbtVS7zfFG4c/gngkcEtjxU+Dun2T/yLRVXUkpyb0M82KjydbdL+ejglRz7PvRmmOHLLjLytQkM+TZUEcllRg/tqOZAZrd0wEuwNRLW3gURTOWttPZvCX7BDi+IQwzsGsn/3SF2KZiFuWwh0frmt9+jEKZNYPipXu9aDhhfNwGHrdQSELaC8hq+jZOzdMM/ndWz8y6rOfK6F5a7D4hZi1MD5Ym8EPI1RoBWUjzMxPo1DqXweT6lWLDGrvEhYpwFlUvzMIVGpSVs+gvzQzcMwauy848bveukg8bZnFkOpoK97QPuow88dS7eOsEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(5660300002)(83380400001)(2906002)(316002)(41300700001)(8676002)(7416002)(8936002)(36756003)(4326008)(2616005)(86362001)(66476007)(66556008)(66946007)(1076003)(6486002)(52116002)(6512007)(6666004)(6506007)(26005)(38100700002)(38350700002)(478600001)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X8AR4HhVKUratJGLdhPd861pEgEdbppuvztNlIa8Y6cJxLqgK9gs7/5SanU7?=
 =?us-ascii?Q?twYcab8a2n9p+6qtGlMice4DppYxfNcqF4nBCociFmlrtZorpoN/vRF8fGxu?=
 =?us-ascii?Q?JX8uORpu4MJuJ+5jLw3PUKzsgpAq5BDtvXsEnPri8NQZapePTTTGqN3GhF65?=
 =?us-ascii?Q?hIfLkqQpNepINZcpgofTZKscCUuc69brRR8dUhSpfG3hjA1nirs9vmpl1Z3R?=
 =?us-ascii?Q?/VGYM4QAxs5RQp9geP+opuxLRJkIoQ9gczDVC6t1XnA7j+CVcjEGG9wqElle?=
 =?us-ascii?Q?jm7Xb8z2VGrZcKNzRgJAafuAZ4LSur+6QwmjT6cE0c8ifcQJTLrjKpJutg5Q?=
 =?us-ascii?Q?epvVGLZoRdgDQKvEdxBHYismM9g+6VhAQ8oAYCRRfRU7UfZbfyE4tu1kIDqb?=
 =?us-ascii?Q?B91ahx4CCvcQr9QmVhqdFz7yXy/95TU3cVb2e3mKBV4kI7hcI7BTXNiEEAVH?=
 =?us-ascii?Q?6/ceg4iSGmJ+aSkQddZPrt9j0XeKJl59aArDPznuVOfU0viM7AHhpw5EUNgG?=
 =?us-ascii?Q?/TidEzxYvswl3u9kMfh+m3V3cu1qzmJkf+sYilw4OFmHAuPT3jh+pmYypQ6E?=
 =?us-ascii?Q?KeqOoBQHWsNWYGtW7avzlK5Kd3uRhaiKEPlw0bOpVTVZQl68EFajDSc3r+u+?=
 =?us-ascii?Q?dKQWqC06aDrao1+srMT9H9dRWjELvafP+hGYtv7uOaQq2BXS6+akwSWx51zG?=
 =?us-ascii?Q?zleMzZ9Nbx46zoaqVrTZ7rMwcialBz7uoXAv6yKESOugDBYp+ianMDcWvJYQ?=
 =?us-ascii?Q?B6Oq1++QkbJHcQJnCR6+qovvhfJDKe/cZSrkqlRKOWmMXnieI5rN+ADgUAwE?=
 =?us-ascii?Q?rJkpuGlA1iKyYZjvJ2GHC/NECaeFfxJbNt3inoWBK+pSzotMLhz4MBfml/rG?=
 =?us-ascii?Q?Yy3Ge4B2vOWetu8WP0m3P3/rZhFb7EXKJ8av4W4lgw3llC3zPkWq2PAQEeo5?=
 =?us-ascii?Q?okFQWWc1yHfuqPPC9aHeE2eXwtY+8QtBRNc5vZ/+y1+BuVAIXhww2t7iIv7O?=
 =?us-ascii?Q?6gm8snDoQ9bGC+2niKaeMVDp2g6GnQnD8xg6b/nr36QfrEOJAmQAbufORhO0?=
 =?us-ascii?Q?qm28V65sotdLHFcDBxSYK/kDdYjTuKfQvGCi133UkBdBCFOLAn4KE1tbWfLE?=
 =?us-ascii?Q?ZGN6p6Ei4F6NcfmzXVgm5NaJOiGJ1YoVAk0vk1fT+5SRS38IeZN0m+6hx2X/?=
 =?us-ascii?Q?n49fkL2zUKIa+8Tjuxnaqy+o9n1yKwALoGaI4pHYdHR7RtoNrJXxuXJncYLR?=
 =?us-ascii?Q?Q/NgUKlWVHkTZCbWfZALub/1DRQhhCdTDREWTReET0WSxNrSA6mSRv7BFd0J?=
 =?us-ascii?Q?z6wY7Ooff2MoxpuoEhXBo024g3RyLlGViYMOmXZgVaW91MDWC/Xl134laHuF?=
 =?us-ascii?Q?FXQdrlv9vNsi2K2IeRNHdmHHIiHsxQj1Ish5o+Gqh2/7LEbx7PannkPy/YJH?=
 =?us-ascii?Q?LWOnt9LggCWI+vED0ZSixxEUcXpBkF0hd7H56h5l1xixSnV+1sRJLFhcgFxy?=
 =?us-ascii?Q?wzkPkXOXuCNJnJgyGXUyzNNA0J6DW0OIm3U+Fyo+aG7W9LElN9EFlqdL1HGv?=
 =?us-ascii?Q?hvpxOeRPc/T7rGpHH14=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e8b8d1-207f-4fb4-7e0f-08dbbe08f243
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:49:43.9603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPlaDSzsjD5MqhcEd0yPCxyhAhj0DE4Zn1vk2AjRNn4/tEcBlxOMpPwI8HjBH9LvZSxXGWpxtqRE8Tl3jRFVEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

edma<n> is missed, add them.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-audio.dtsi     | 88 +++++++++++++++++++
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 62 +++++++++++++
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   | 30 +++++++
 .../boot/dts/freescale/imx8qm-ss-dma.dtsi     | 52 +++++++++++
 4 files changed, 232 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index f248e78fb1e0..9d75ce467569 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -20,6 +20,63 @@ audio_subsys: bus@59000000 {
 	#size-cells = <1>;
 	ranges = <0x59000000 0x0 0x59000000 0x1000000>;
 
+	edma0: dma-controller@591f0000 {
+		compatible = "fsl,imx8qm-edma";
+		reg = <0x591f0000 0x190000>;
+		#dma-cells = <3>;
+		shared-interrupt;
+		dma-channels = <24>;
+		dma-channel-mask = <0x5c0c00>;
+		interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>, /* 0 asrc 0 */
+			     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>, /* 1 */
+			     <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>, /* 2 */
+			     <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>, /* 3 */
+			     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>, /* 4 */
+			     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>, /* 5 */
+			     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>, /* 6 esai0 */
+			     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>, /* 7 */
+			     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>, /* 8 spdif0 */
+			     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>, /* 9 */
+			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 10 unused */
+			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 11 unused */
+			     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>, /* 12 sai0 */
+			     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>, /* 13 */
+			     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>, /* 14 sai1 */
+			     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>, /* 15 */
+			     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>, /* 16 sai2 */
+			     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>, /* 17 sai3 */
+			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 18 unused */
+			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 19 unused */
+			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 20 unused */
+			     <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>, /* 21 */
+			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 22 unused */
+			     <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>; /* 23 unused */
+		power-domains = <&pd IMX_SC_R_DMA_0_CH0>,
+				<&pd IMX_SC_R_DMA_0_CH1>,
+				<&pd IMX_SC_R_DMA_0_CH2>,
+				<&pd IMX_SC_R_DMA_0_CH3>,
+				<&pd IMX_SC_R_DMA_0_CH4>,
+				<&pd IMX_SC_R_DMA_0_CH5>,
+				<&pd IMX_SC_R_DMA_0_CH6>,
+				<&pd IMX_SC_R_DMA_0_CH7>,
+				<&pd IMX_SC_R_DMA_0_CH8>,
+				<&pd IMX_SC_R_DMA_0_CH9>,
+				<&pd IMX_SC_R_DMA_0_CH10>,
+				<&pd IMX_SC_R_DMA_0_CH11>,
+				<&pd IMX_SC_R_DMA_0_CH12>,
+				<&pd IMX_SC_R_DMA_0_CH13>,
+				<&pd IMX_SC_R_DMA_0_CH14>,
+				<&pd IMX_SC_R_DMA_0_CH15>,
+				<&pd IMX_SC_R_DMA_0_CH16>,
+				<&pd IMX_SC_R_DMA_0_CH17>,
+				<&pd IMX_SC_R_DMA_0_CH18>,
+				<&pd IMX_SC_R_DMA_0_CH19>,
+				<&pd IMX_SC_R_DMA_0_CH20>,
+				<&pd IMX_SC_R_DMA_0_CH21>,
+				<&pd IMX_SC_R_DMA_0_CH22>,
+				<&pd IMX_SC_R_DMA_0_CH23>;
+	};
+
 	dsp_lpcg: clock-controller@59580000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x59580000 0x10000>;
@@ -65,4 +122,35 @@ dsp: dsp@596e8000 {
 		memory-region = <&dsp_reserved>;
 		status = "disabled";
 	};
+
+	edma1: dma-controller@599f0000 {
+		compatible = "fsl,imx8qm-edma";
+		reg = <0x599f0000 0xc0000>;
+		#dma-cells = <3>;
+		shared-interrupt;
+		dma-channels = <11>;
+		dma-channel-mask = <0xc0>;
+		interrupts = <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>, /* 0 asrc 1 */
+			     <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>, /* 1 */
+			     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>, /* 2 */
+			     <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>, /* 3 */
+			     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>, /* 4 */
+			     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>, /* 5 */
+			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 6 unused */
+			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 7 unused */
+			     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>, /* sai4 */
+			     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>; /* sai5 */
+		power-domains = <&pd IMX_SC_R_DMA_1_CH0>,
+				<&pd IMX_SC_R_DMA_1_CH1>,
+				<&pd IMX_SC_R_DMA_1_CH2>,
+				<&pd IMX_SC_R_DMA_1_CH3>,
+				<&pd IMX_SC_R_DMA_1_CH4>,
+				<&pd IMX_SC_R_DMA_1_CH5>,
+				<&pd IMX_SC_R_DMA_1_CH6>,
+				<&pd IMX_SC_R_DMA_1_CH7>,
+				<&pd IMX_SC_R_DMA_1_CH8>,
+				<&pd IMX_SC_R_DMA_1_CH9>,
+				<&pd IMX_SC_R_DMA_1_CH10>;
+	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index a206526665d6..0519edd3f520 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -145,6 +145,68 @@ adma_pwm: pwm@5a190000 {
 		power-domains = <&pd IMX_SC_R_LCD_0_PWM_0>;
 	};
 
+	edma2: dma-controller@5a1f0000 {
+		compatible = "fsl,imx8qm-edma";
+		reg = <0x5a1f0000 0x170000>;
+		#dma-cells = <3>;
+		dma-channels = <16>;
+		interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd IMX_SC_R_DMA_2_CH0>,
+				<&pd IMX_SC_R_DMA_2_CH1>,
+				<&pd IMX_SC_R_DMA_2_CH2>,
+				<&pd IMX_SC_R_DMA_2_CH3>,
+				<&pd IMX_SC_R_DMA_2_CH4>,
+				<&pd IMX_SC_R_DMA_2_CH5>,
+				<&pd IMX_SC_R_DMA_2_CH6>,
+				<&pd IMX_SC_R_DMA_2_CH7>,
+				<&pd IMX_SC_R_DMA_2_CH8>,
+				<&pd IMX_SC_R_DMA_2_CH9>,
+				<&pd IMX_SC_R_DMA_2_CH10>,
+				<&pd IMX_SC_R_DMA_2_CH11>,
+				<&pd IMX_SC_R_DMA_2_CH12>,
+				<&pd IMX_SC_R_DMA_2_CH13>,
+				<&pd IMX_SC_R_DMA_2_CH14>,
+				<&pd IMX_SC_R_DMA_2_CH15>;
+	};
+
+	edma3: dma-controller@5a9f0000 {
+		compatible = "fsl,imx8qm-edma";
+		reg = <0x5a9f0000 0x90000>;
+		#dma-cells = <3>;
+		dma-channels = <8>;
+		interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd IMX_SC_R_DMA_3_CH0>,
+				<&pd IMX_SC_R_DMA_3_CH1>,
+				<&pd IMX_SC_R_DMA_3_CH2>,
+				<&pd IMX_SC_R_DMA_3_CH3>,
+				<&pd IMX_SC_R_DMA_3_CH4>,
+				<&pd IMX_SC_R_DMA_3_CH5>,
+				<&pd IMX_SC_R_DMA_3_CH6>,
+				<&pd IMX_SC_R_DMA_3_CH7>;
+	};
+
 	spi0_lpcg: clock-controller@5a400000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5a400000 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index a9095964ac91..0a477f6318f1 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -15,6 +15,36 @@ &adc0 {
 	interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&edma2 {
+	interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 291 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&edma3 {
+	interrupts = <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &i2c0 {
 	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
 	interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index e9b198c13b2f..297ad4ef4a78 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -44,6 +44,58 @@ can2_lpcg: clock-controller@5acf0000 {
 	};
 };
 
+&edma2 {
+	reg = <0x5a1f0000 0x170000>;
+	#dma-cells = <3>;
+	dma-channels = <22>;
+	dma-channel-mask = <0xf00>;
+	interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>, /* unused */
+		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>, /* unused */
+		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>, /* unused */
+		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>, /* unused */
+		     <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>;
+	power-domains = <&pd IMX_SC_R_DMA_0_CH0>,
+			<&pd IMX_SC_R_DMA_0_CH1>,
+			<&pd IMX_SC_R_DMA_0_CH2>,
+			<&pd IMX_SC_R_DMA_0_CH3>,
+			<&pd IMX_SC_R_DMA_0_CH4>,
+			<&pd IMX_SC_R_DMA_0_CH5>,
+			<&pd IMX_SC_R_DMA_0_CH6>,
+			<&pd IMX_SC_R_DMA_0_CH7>,
+			<&pd IMX_SC_R_DMA_0_CH8>,
+			<&pd IMX_SC_R_DMA_0_CH9>,
+			<&pd IMX_SC_R_DMA_0_CH10>,
+			<&pd IMX_SC_R_DMA_0_CH11>,
+			<&pd IMX_SC_R_DMA_0_CH12>,
+			<&pd IMX_SC_R_DMA_0_CH13>,
+			<&pd IMX_SC_R_DMA_0_CH14>,
+			<&pd IMX_SC_R_DMA_0_CH15>,
+			<&pd IMX_SC_R_DMA_0_CH16>,
+			<&pd IMX_SC_R_DMA_0_CH17>,
+			<&pd IMX_SC_R_DMA_0_CH18>,
+			<&pd IMX_SC_R_DMA_0_CH19>,
+			<&pd IMX_SC_R_DMA_0_CH20>,
+			<&pd IMX_SC_R_DMA_0_CH21>;
+	status = "okay";
+};
+
 &flexcan1 {
 	fsl,clk-source = /bits/ 8 <1>;
 };
-- 
2.34.1

