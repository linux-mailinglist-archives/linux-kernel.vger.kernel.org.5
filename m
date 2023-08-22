Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E92678464A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbjHVPyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjHVPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:54:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4390ECF0;
        Tue, 22 Aug 2023 08:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyHWOOYtAYgPucp18Zfx/OyE3I1iKdeWh5t8LrTxgERwz1ki4lWsKziz12L94/Z6FnQMUsZZ1sbgwoyflKDCHlLq8wITm5n3Od0UvCGj90N3k4xWncxb+F8fpSZYYv2+SfbKErSJk6c8uXXPq/VAFo7GC8vbHrbxDflsEvV3XGCL/LKBLPd/Rym9hkZiUIJ0MvFSxz7LcWkJrpAsWZbJO/CXQaHzrGttyvuIYQXu2DGp1uU/l0pdUPhTfonX1RX6UPJkQ0Wj4CmGiYPVu9PzvbZ40j7DUCLM0GFtv6U5VpsZGL7kylS4Eo915wowgDAnq86wxIK7HNkdXR0pOpyvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix4KHLWKO6rLls08N8vEt9/Epdvy/VhAyYEcrsEn5co=;
 b=GjKryd48pKQdp9A2gmQFOD2rwgAZs2Tb+D4v5k1U1LBOJuA3VsnO/KApae6UzqlBXScsAAPadZT3BuE7Mqr3UfLTyphBoKbGqbpH8cGJmbd+kqJMfqHIOVPHr+elg2fxfz1GEsyNNrCfbULc/efPYX2RguchLURH+841RehIm4FxRD8amFaVCw8Gu9oqGigMXqQV9/Dv6kiswaTgzMJchLrkDsmOhvYzjTjfqyQaofykGwHi6SwSJoUIuBW0p+6j/xCp4wZv1921El/IkKev17RllGtBBmUUepgCJzIuZ7TKFb4evmek86EmWsm40dD+ClToI/EvKje61xRwTDcg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix4KHLWKO6rLls08N8vEt9/Epdvy/VhAyYEcrsEn5co=;
 b=rrv1xb901s//cp0FCJ6nulHTLsURDd5B0P/GXilgxtjBjpYoynSjWhv5rOZzjboR+sS/UXazierxyf4gAxsknU8FmDJ5x8dtOhGd+xkFLLnNVf+BWiYjEHIZiJLMYcsVf5plynaXRdhMTz5Alg6yJnDilbs0bTfG3KcxdnR2Wb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:54:03 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 15:54:03 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, shawnguo@kernel.org, joy.zou@nxp.com,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        pierre.gondois@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de
Subject: [PATCH 2/5] arm64: dts: imx8: add edma[0..3]
Date:   Tue, 22 Aug 2023 11:53:30 -0400
Message-Id: <20230822155333.2261262-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822155333.2261262-1-Frank.Li@nxp.com>
References: <20230822155333.2261262-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc82366-5512-4e0b-677d-08dba3280238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tM0r/Sj0+xX41qB5M98vKICoc7ZJGsEBG48IdZCT5q7fLyBCMcquW1Jly50zNMiT716iJNYbaYoRv8RzFgSW4LuGOpvW6iFP1ObYTN/D7oCXhWDN3X+JSjIaqlSPYgKkXn1zEn+eTDFona+I5PmGQQrnXlmgNi6YLiAKnCZiH4BEFWT4CKJoK89P31eXJFgjeeGSBN2pN9atOUX9Mor8iKq2Szt3zjVHfH/ea6F112p964FNtvUGHEpxT3LnaYLZ9OBYFtxN2bKZLDH2yY3ouo00QE7KScgT6Sgf7X9XD6siCkBWvXQpCRls2BRH0FbaicIIv4xSb28WAdWu99Hfdt1cJNfBMS4MNSttAHIolrscJPERT2ahJrosLwnCA2IVc3IqtHnIGeSbez7ePKYFfuvcGaWcevDK/Xezgn1nzimjyEQQFY/pFYTWbe0chhFtfdjROgI9IIrKhIYopRZbwfSG+o/ht27vrCuyHztWBLW8fbyD1CqrA5vgzlDUh/8q1tVgawcAOk1yMn8YZs43BYa+X1irUlHezQH4JpATjqKlVduFpxXfHfabeJahgvu1gHDJrmmExtBqJHkji7sLMYoy/9k8024N/WmE6es4rhw6XZrlhxe491GhSo3Hs/lqieO8OSzKp8EVVD9Q39q10A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(7416002)(38350700002)(52116002)(6486002)(38100700002)(6506007)(83380400001)(5660300002)(86362001)(26005)(8936002)(2616005)(4326008)(66946007)(316002)(66476007)(66556008)(6512007)(6636002)(478600001)(8676002)(6666004)(41300700001)(36756003)(1076003)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+h1F51Rsy6RdukNpS+gu5ZNSQZbEUwRm+k+ViRudQ+lhIZi7NdBJZYwwRZSC?=
 =?us-ascii?Q?xbmLlpZ+o2yTnfnMoGyBoUIVV9jqcOmXVDgFN1qrFbh2zLkIAOxV9wFl9HT2?=
 =?us-ascii?Q?qNtESwHIoMylBmKH9U38kUVIPcd+b9GFcLw/w5o+zo7Vu/P61wd4Rvohe3TG?=
 =?us-ascii?Q?tlN72rooFwnRC3MUT/36HpI59SWhgehhQwl7LlbPenRItej/yCaecziT14Ft?=
 =?us-ascii?Q?uDvZQSqlUhDJ/NtM7gXTvgZU9rUWGVWSSAqfZ7sG/MWoJJPGoADwx2vSvTKq?=
 =?us-ascii?Q?f8X1PHUNY4EHLvhJWkG5LP4gS1qCkc/Wxbm+MgOa1yhyY2VK0lQLb0oazM3h?=
 =?us-ascii?Q?WACOJ1fXNZ8GfdDjt02B1PvtVYW1Gdnj9AIBXNc0Epqa9MiPYTr09Hkzt517?=
 =?us-ascii?Q?vgLukjgV/mwcGmZtO1ORkBoB7GJMiPylHgrexShoirdRla+xwtCTpJhwNZFj?=
 =?us-ascii?Q?IUFq+AuAJHwj+rLJj7RS9aeBlUDMwtQ7ohnUWVrNsIUjuVm5K5D0ECjBxG8+?=
 =?us-ascii?Q?U0OrHAZcJXMxWS1UGNQKThl4SMbQL2OXAERG8ZlQeaMGOph9m9zgORN62qiZ?=
 =?us-ascii?Q?RSV411h+jUTI2IlhDXyLnBIOqORzjrEU5zLb5xuNCF/jezi8z7LPfcjqNTgP?=
 =?us-ascii?Q?OsoFHW+HMds7P0XW3jASqm6qAYApqUj6aFySNomdgw6YgUxgNxBiQBItdN5i?=
 =?us-ascii?Q?gFSO1kA5M9LlgX5U3HizY2aCclb291R2yYUJA0ou+C+WuJfg5rhRYsREkP04?=
 =?us-ascii?Q?kU4i0tdX/QGNY71cbx6UjCiTFWz4ADp9nvRXDIk1F4rutqe1mU01k9gEppgB?=
 =?us-ascii?Q?xmXg57Cpi1FxEgYh6l1L+BfxtgBYEA6uoCcp4ai0sSj0sI9uTnxTcPPg6l00?=
 =?us-ascii?Q?AaKaflfmG3nraJAwYLy7B8DNcV+VV89O0EyQ9/bd/1c95GX5i+peER1RqoNg?=
 =?us-ascii?Q?SiDYrkR9xTM9bzyuwcP7odFJkMFp2TnFfrrqlIsHUTtSRzsHgJ9/VqYK+Qt/?=
 =?us-ascii?Q?AEjyzcL/0mjwKHa8hJU/uubOX2vfprLRzGpn60b4dNqeqzWvhtd2WZKBZwF9?=
 =?us-ascii?Q?s/OsKymOm99PJpDJqhTf3PTqo7H54aSR6AlVyCJ0eIoOSEk+pospi2eH2+Lz?=
 =?us-ascii?Q?LyifWMGOOhgmlp0ykg/tRHXxUPFIB4Iteen0ye3zF3IGb/AdS9rfZDMLSqIF?=
 =?us-ascii?Q?IiC/ECxFIzNJ/LPtGdgHJni5lejJXRVRfmPPc0x1mHhVI2JvAyBVLCLDOdvX?=
 =?us-ascii?Q?uhD0laaGK2/s304pi/Zi5v3FFOF9cmZeRGItJt3rMRu04XeTrNiyDRvJdtwW?=
 =?us-ascii?Q?CKUj/jgjGhvicco6HbmyJH2BVkgM+Ox3DJoKHRtov6xaNvjlR+XRbKBb0cmF?=
 =?us-ascii?Q?LUuaze/qPfWG/Jcc3Tpm0oSB4twMfxoaz2Y6+fJwgrhMsz6h/pUmn+WcEpvy?=
 =?us-ascii?Q?6Wube6fZci+3fawHwIUdEGC97UHS0gegNCNO57OhkN5WALPdQM4Dj5Va9boR?=
 =?us-ascii?Q?BctVCyI/fQLZZJNxeCsGNJnyDc3u4LLjzUyCBnskel4VhvUXFqHPJJcID6oK?=
 =?us-ascii?Q?5cmy1AMIT7xNY84n69e6JO9Zn0x43VY7pfEJYJjl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc82366-5512-4e0b-677d-08dba3280238
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:54:03.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsTld4bJJaRiz9Eq47s89LFt/wmIS2WaCTxN49CSTqcuHVi2RcCxPllms9FXOZx+2PjTCZT8BxbzLQc0ZhiLOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

edma<n> is missed, add them

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-audio.dtsi     | 88 +++++++++++++++++++
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 62 +++++++++++++
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   | 30 +++++++
 3 files changed, 180 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index 6c8d75ef9250..8870acf8f743 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -20,6 +20,63 @@ audio_ipg_clk: clock-audio-ipg {
 		clock-output-names = "audio_ipg_clk";
 	};
 
+	edma0: dma-controller@591F0000 {
+		compatible = "fsl,imx8qm-edma";
+		reg =   <0x591f0000 0x190000>;
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
+		reg =   <0x599f0000 0xc0000>;
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
index adb98a72bdfd..76e4aaaf307f 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -132,6 +132,68 @@ lpuart3: serial@5a090000 {
 		status = "disabled";
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
index 6881330ab4c6..7e98c5e5624b 100644
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
 	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 	interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

