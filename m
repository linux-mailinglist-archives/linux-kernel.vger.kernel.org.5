Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28165753600
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbjGNJFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjGNJFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:05:00 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBD31734
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRbiI9ZaLO/MUFmldlLASg2bsJA/fBO7QAaXRqRJpe5amZwwPJ9bTBUxEmegOcKk8WaV7kXcYHzfORK3XsknlGXlN6Kb6uYCtAXLV16mkEzCboaPflZTywKxRl4CohStPULNzsTQGFQFn96/FtRA7Ex5evs5KQ2XEebZVbQfsGg5zslwVFfmgNdVuTCsKSYqfQX6VsVgMb6KZhH0+altM7q1wPCB0ODE8ioE6k5OjHCie+7iTI9wQthv63aCuknhWliBaXIIaYMfNwnAgHY3UumaFM97PcgvzjPrio4QFqF4y2ARXvJj3+KRKbEc7jwIcFiJsZefM6h5HjippJ812w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgakzvXhWNMGwUlo2Bpwo8ud+fKxWXFDp2dIP2gH5Po=;
 b=g8dYCGVArhZKUMtqlKCtu+qX56jki2rIszxN7489svV0UCesnS0OMhCKayCLzTZi5YTRJ7d9/89lgc8J+GCwGKK0rly0EP1AUmCyI+qyzkZljNiX1+/Dj2sSTyy1id43ZGP9Ffuvp9LRM6pzUQBuP7S7Dit9C2NtSoXSZFjAnMClFuXd4DgqANJVH53RXYNbK8Zu4huCW0KsNtSnlo2NHvUHsXmiReAVh9oxxhxPnynOH4pR+K/l49IRr0YjsK/KMaqJJdeS0IfxNRbPM6F12nv5QFsE74azrxrZa2r2u+5W9LcEbrhiK2DotPwfR/h6S6KCJpwv/ZcJpRo5Ab2zlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgakzvXhWNMGwUlo2Bpwo8ud+fKxWXFDp2dIP2gH5Po=;
 b=XAb0Qxl7n044wWhYFJqvD3CqFgP6J+IsK2yMYnt4nA1JMWH0bGUvrqYHBP2UUwmo6v+61Kqib0k4+gxbPbqAv77SAcsiohMDawTHHwlScYH7MRAHQ+4itXQY6fr7xHIHOymLHxj797bevdX/gY9xBkcLY2j4xqhhw4hJYAalB0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7736.eurprd04.prod.outlook.com (2603:10a6:20b:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 09:04:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 09:04:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Frank.Li@nxp.com, aisheng.dong@nxp.com,
        marcel.ziswiler@toradex.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/7] firmware: imx: scu-pd: enlarge PD range
Date:   Fri, 14 Jul 2023 17:09:30 +0800
Message-Id: <20230714090936.937344-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230714090936.937344-1-peng.fan@oss.nxp.com>
References: <20230714090936.937344-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 9732f5e6-bbaa-4bcb-678e-08db8449641d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5MG33Xqrpy1cysjCLRVxS/Ys30LQ6DKT0jMWjIuE5O4NzLdHxiQhUcx3S/TJvkF94TrggGAKnb42dz0kWS20/oM+rBziUHjxQWhvRGo0MQ4rcMwPNM6qZiHO91LZwRBsBPU8u41qc7cJlkt1tn767z4wGDQcyY5UvfQADHS8uqcVqBxKvU1f0rcdWZjUqMj2uAd2wlFtn+hOGOx9ocVRPlFLJuUczA8wxj3UwbwHXHt96S3vKhjHcZzE+Rin68Y+gFxPvFQ8ahWEzHMIaXgyOoQU3MCQ2ybKFQghO4OMtL6nsHOGRGD0GGops745cy6Pe6fjRIV9uLx7OwtnItkACEWMcQNEaGn6Au5yj3RLi5YYDTA1T+cYDJWknRcQ6lmZvYo7xCvHfCu099S1N1x4udfiUbq9zWFpzqneb+3gDXM49RAYTtSQecC/JcSXgkqwaNMZEdgicQ7fCQ5jc7EsrS+1TDLUtwqeoqpmBDtSkblh9hszh1iHiufQZ0+lXawY+QfGTQ5F5RoOGZt82L3UDuoAy7ingrIU4K7fpnH7ExDcxR4aUT9s0w+768V5w65JOhaPiJW6PszuncS0c9gNi4+b5UMBIqfg4OABpMuZFHkt4yvAOKHLUmYMcVKVDiuTjReiU5pICa8LNXVbu9IgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(38100700002)(38350700002)(86362001)(8936002)(6506007)(5660300002)(6666004)(1076003)(8676002)(41300700001)(26005)(186003)(2616005)(2906002)(83380400001)(6512007)(66556008)(52116002)(316002)(4326008)(478600001)(66946007)(66476007)(6486002)(147533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0dV1cW5lFzd5P88iSqIGvQQ8Q/fO0V7QkOnjsjEN+l4AeIm/qfGQEp7VrVz?=
 =?us-ascii?Q?F5GuoU91kj6WWoMg+Cg1QBPbgXJodOwaGPDDeCHrU62srxA8dl17AYeL//KX?=
 =?us-ascii?Q?hS16ZLdRrDim4FEO+W+k/rrOMs9XzNQLNYyMobXhQsbJ6x8w4ym9F+Uy+eqA?=
 =?us-ascii?Q?0aTCVPwS3YhGU2Ei3uJHBnWqQkv+rEaCksdUOFhj6eVX9hj1wgAvLdZ01ehu?=
 =?us-ascii?Q?6A4SknHyS7vl7ipkZNdc//aVsiAj4KIGBagTzzZZK1dfVRhJnLnu0Fy1RLnv?=
 =?us-ascii?Q?meAJ5O+cXNSS3PUSeoGI0/R2375GNotojISp3yUVIKKZ2cshIhiCI6R36E+3?=
 =?us-ascii?Q?f/m8g7h3H7hhg3puJGFQE582H/Ce7LbFImu4jhWW17DR+rlu4oabItkW9gwN?=
 =?us-ascii?Q?iyHpm9dFBRwbze6sp+v+J+6/dfhUBtOncuNtlMCZbbI1lh+rG32DZotaseO0?=
 =?us-ascii?Q?jml6LExLLyOB4NveECMs+8NLHeoiArO7xk9TQFUO0DfOgazvn8sc6Q7DCJHU?=
 =?us-ascii?Q?oQC+qvVBYFcE2WGi2mWHsdeQFxXZeM0Tc7E3FFI1u64zukFR1NeEl1g9r7HL?=
 =?us-ascii?Q?YGme4bbuJMi4kulbr/GFNisdNExwqlMB6t0L54bqtI8QhKXPkHSTrd8e3phe?=
 =?us-ascii?Q?33BzzffmxOh6w3rP77B+WGL8Ziqke0RgJu+AJyDOugaRBGnWnP9KOJNHhwLP?=
 =?us-ascii?Q?CsTqsC2Tb3jwZ0IOhALqG1M/FRoFMLQ83hT7ay1O8o1dGqCzSO+4ze2fsDaC?=
 =?us-ascii?Q?+Sz/2NHoUBrrTt2LuBCcgjWpb7Bi+UzdoQOhf8DozjoIf6aGl6qyu0JxnFGM?=
 =?us-ascii?Q?AIzLLnjEaGpvT2JlN2S6Y8zAm7vHa/Pcl50sjpxzjjzn22eEN5F1yUxMFE4N?=
 =?us-ascii?Q?iqDnKdos+A3lUILMGAOgCDNk7aDG5/UpAaM8MH2zrjXUn4vJkDGMgoWzwurc?=
 =?us-ascii?Q?4D/w1I1mFrIa+93DPhZhNOCDGRubf+kUX8mT0SEcUNAYZUg9BSW5V+MobutK?=
 =?us-ascii?Q?6h0xJ0kq0CrT8zjF2WEw+rCiEOaaSokj1bfIgNVRgEBGaqXfmkwVe2wRFfdS?=
 =?us-ascii?Q?HU5xt2Dh4dnV6lX7BP/+sDeEq+i9exK8qoS4mns3qD9BdTECoGKtk08i1GPK?=
 =?us-ascii?Q?ZMwXY4Byncoa/ydGd+I5zmnvzTzixJuiLlgtt41T4yy8PJNVvXj6fFJGKN4o?=
 =?us-ascii?Q?2tth5EkytUK4SISTWusEQEomaC9opokvS4zlA5dZ192yfeNoA0gShO0Tz4yB?=
 =?us-ascii?Q?bA/9UPHHN7IxZVXRgtlCGbaqLNltEDXeTcMzSQJiIyOca9CZe02AlYmIMLYA?=
 =?us-ascii?Q?cIDhy98j8Ywm+P5TpsjR11Hu5k6iVaDjY9GhX6ijqzMjgBB+VvFg3v9p9h3F?=
 =?us-ascii?Q?1V9jTplpW9j5H4TQtDn33hescDIJCZMQ1f5K5xtZ9weKlDKZ2BcVIj/mzaf+?=
 =?us-ascii?Q?Qf47YlEy7tmTOEbz5NBCLKz2IEl/tutVL4AlVi9V4vtYHIK1o/nGmv8WLNne?=
 =?us-ascii?Q?SDq+iOOid5iYnPM694UH6eeDT2vsd9fnWembZQiLya5MG4Vz4byM6q358d6M?=
 =?us-ascii?Q?yRWi7IRQo6TrMyAruuKRAbsjVOAhQzn6Ihm97Tet?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9732f5e6-bbaa-4bcb-678e-08db8449641d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 09:04:55.3581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2WWIlfqs40kADyfLX9j5DHpykGbw4vIPlsb15eCA05zo5ANz3/PgmvNQ9lunpkdv7KBfkwC8I1ydwoFrU0qpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7736
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There are 5 LPI2C, 5 LPUART and 32 DMA0 Channel resources per imx_rsrc.h,
and they are in i.MX8QM, so enlarge the PD range for them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 84b673427073..5a28f5af592a 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -121,9 +121,9 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
 	{ "audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
 	{ "audio-clk-1", IMX_SC_R_AUDIO_CLK_1, 1, false, 0 },
-	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true, 0 },
+	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 32, true, 0 },
 	{ "dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
-	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
+	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 32, true, 0 },
 	{ "asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
 	{ "asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
 	{ "esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
@@ -143,11 +143,11 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	/* DMA SS */
 	{ "can", IMX_SC_R_CAN_0, 3, true, 0 },
 	{ "ftm", IMX_SC_R_FTM_0, 2, true, 0 },
-	{ "lpi2c", IMX_SC_R_I2C_0, 4, true, 0 },
+	{ "lpi2c", IMX_SC_R_I2C_0, 5, true, 0 },
 	{ "adc", IMX_SC_R_ADC_0, 2, true, 0 },
 	{ "lcd", IMX_SC_R_LCD_0, 1, true, 0 },
 	{ "lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true, 0 },
-	{ "lpuart", IMX_SC_R_UART_0, 4, true, 0 },
+	{ "lpuart", IMX_SC_R_UART_0, 5, true, 0 },
 	{ "lpspi", IMX_SC_R_SPI_0, 4, true, 0 },
 	{ "irqstr_dsp", IMX_SC_R_IRQSTR_DSP, 1, false, 0 },
 
-- 
2.37.1

