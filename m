Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED4E753601
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjGNJFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbjGNJFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:05:04 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEC226B2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmX+WiLJUqycw5wyjBzWXsecReYm2EPP0z5Udnu8oolS+l9P/FMxSD6rk10wmxepuOCi12BlEpIJr+JpjMUqTeZUk+vdahKO+g2E6B/eGbVnZbV9Sd+JqEWbxKSLadeuwqrt0C9lurVgfL5aGivpui5OU7Xex1b/8U0C1tN9AJAIX6gTm+aw9+kB+KmtIQpfCIqqMaTLH6cTOEiaIznsrjfZ8SyJX5LhsX9RgCvXIDAdzmKO09Y6pGD7t6ZniBWdeQ6ZbW8caUKArCCeQFs5vhKRpgyXs7KUovod+4SuLN+Tj/d6p2g3N8pAXBm7hKu7ttHou3LpcnKAw9JrHf+pAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J37eXCFZLSHUH85nR66Qc5fBXUVeFIQ7PyfW6Vi4MFk=;
 b=BbaCoZGL67WkkOUJW/5EROzMRGomsgm2YOJMWgMSQI0xoj+gaH7Z9IHtM+PKV/8yqTHWCGxQ1EdTSy4X492ugCPnMpN1DRLauob5DnLQlyXThdvhMIyqe+EWl4eGa6PaGmqkbEA6Exb2IfSvC+TAJK2I1tbeajhbDR9yqgHPYIjxwunxyDqGsLew6wO/RMe/CcmSFNKMBuOhoAxXb8XrlNhofXj5cmL+dEvKYOhWjZNV8lbHZsTERLhHmAJv+1+kVJKgOcTXLbegqZhgVV7JHJBVDZOJWCTK+4DlXltUbtCm2WJ7iIWOXTLQhtfdK3sa4G2eKrmcRU2FXvu1VAvidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J37eXCFZLSHUH85nR66Qc5fBXUVeFIQ7PyfW6Vi4MFk=;
 b=a0q5YO3/JneBp6Tv1JUy0/5l7zUo8k77jCcLKgE7BO2UtX6VzRChWT+A8FmFwY1Jm14qKPOaDC84yjX0xegurnBYh5hwJIsoHs14g8eBrSn1dYZtCch3Q7XXgwCaPRJhwTmTKKZ9CnlbG74ixfAjSVl1JfjiKjS07sjNxUCi60s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7736.eurprd04.prod.outlook.com (2603:10a6:20b:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 09:04:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 09:04:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Frank.Li@nxp.com, aisheng.dong@nxp.com,
        marcel.ziswiler@toradex.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/7] firmware: imx: scu-pd: add more PDs
Date:   Fri, 14 Jul 2023 17:09:31 +0800
Message-Id: <20230714090936.937344-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cfcf299c-9800-40cf-5a9e-08db84496652
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GdZNFhnxyjrzojxrWBG/we4+sQiLH3VOFWdSYyr4FJqoTh1qiNs4MMUK/MuClqIBWxndQ6nUHspmJ5tkHOB1XpzgtQKaGIH7McB5TVbuYcfKlj/Wyu/Q2vQK5FtAz83S3Rp9Xb1laRhieYXOubIAPNQ8jlvPEInehaN7mI6ZzJlnw+rebBGhzR7ZfJxMtUemia1ceV3BYEx5nl8opoYlFsn76RJfaps0/tGSBjvRopykkDIb8XncHEq7U5MT2d3V5fpRB+fjGcbHjMhITjHDnOmF6j5GEP00sX/szmzVuO1r7Scm51sn0C0r6mh8A3gi8e1ZcumMlK5tgS5ksAuhBzIraRolfmFs+jfwI75KmXsrs/Vg9PxQn5o5QL0rahIcvNgYt8+gXEa8DG2kCJapbSvJkOPWf/z9E2Enc5794Lsqv97VBlwn7BSxlPdl1Jb65FjcA4peXIvtnBwNwRe9QqdczRViC0rb7jdM9j8NieY8bnxnvjrG577Tjq33Tf97K19vJJjTVGM1wEwoY6yMsqiEcHbTHJvXhptQqY1Wiwh9gMVWlnEoZQx4qf4bdrgfVsKtfS8b8hjiVD4bX9+1fGNHAUzyqtIZe8IQxPfprKs0Lsi0U2Ouq8NMWxbdOFye
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(38100700002)(38350700002)(86362001)(8936002)(6506007)(5660300002)(6666004)(1076003)(8676002)(41300700001)(26005)(186003)(2616005)(2906002)(83380400001)(6512007)(66556008)(52116002)(316002)(4326008)(478600001)(66946007)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OnPmVhcy3x3saSsy9DO28HePJBIx3oJlSf6XqYYG6xQOhvlaCRSxEypvxku3?=
 =?us-ascii?Q?w0fgRdjgKPvDNzvdqXEKSpAQf9CbRUqfst0KyfVSrjkcNPdUD6n2rZeyKuF2?=
 =?us-ascii?Q?sCxEufff9jhHtKDnVf+VxRFzfccDx1jlHvOm3XyRt5m/hcewepIEh21BURSj?=
 =?us-ascii?Q?/JSww27uh0yvywx1+QOVZzEZHkZaZZTbHqEBUUyAyqf6h79tTPLpFM3nhq06?=
 =?us-ascii?Q?mdhYlpNngnhGZpxf0svu93caRCXqsGPv7mwXh2IDcFIE7FKRGiaSX7G2PG6J?=
 =?us-ascii?Q?oRa6xYNe3J+H9x6G/Z/5qv98rkg867C4eI2MsG6qLITJ7MZeHd7Rgnt3rKPE?=
 =?us-ascii?Q?w1wEmtW+ATSm/PK1mKn69CwxgfldW2tEWYpXF1Sup1Ai3p4U19mF8Ml1kc9+?=
 =?us-ascii?Q?G6cgCn87bd71ExNGszURhzZCWoe5OeuvRRV0/cgI3G3afTsHWz5ekDZ+qXFL?=
 =?us-ascii?Q?uygH3DPD7JhYlmJMOGFQ5Z14TKny5EF2EqXecNxhHtoKH9G9Z2FWLNioNnXE?=
 =?us-ascii?Q?LzBZ5OWkMHY7iT5j+uXS3NjukmebaN70megmoVjaQbwXzW4T6QZTKuIspi9b?=
 =?us-ascii?Q?Iodxo4a4KvRQCe2SwpwaGiC8v6YbVPnhgLPTaOeeLY3dsqqZ0x54262FwyBR?=
 =?us-ascii?Q?9HAuVR3xo/+epUULw7KfQyxBwDmmFOdiLshdn2LgmX0PH1JPwlOwb3bWJG9j?=
 =?us-ascii?Q?srtjomH5mP1lk2bA3U/hOupYsbe1lMeUXu26ydHmJaQQIq0hfAbqc7l62v3B?=
 =?us-ascii?Q?jNULEON/iB7a/5Oxu23J4JduWJvX/KBt982FLrs0wee5muFtA0J5VPCxqjxF?=
 =?us-ascii?Q?fHnN0ST2K963J9VXl/b9cO7z2bIF1PdQuXxxGj2N15QJGy0AzCH3RTjQpkxI?=
 =?us-ascii?Q?YblNEXJijzddOYfDVT+VNndu3v4v7y0sMWdMHWUCkNQFFKTidCyGLQcpfqST?=
 =?us-ascii?Q?5ZZKDzje5LEFFTVgYZNhgX74KI/QZnMhfFQgu/a1RaLpdifuH9cg5rt35n4t?=
 =?us-ascii?Q?D6StSUzkAmn3Z3oqAycx3jUVBCaQBJhmZlhOimvBKmDF3oA55KTn6/VbpFLc?=
 =?us-ascii?Q?lYZ6N8jN9G520J8oj+GD+v3cwkA1qAHEOuAwL09qEGcdc7bIb9RRBYVaGwRC?=
 =?us-ascii?Q?VzHwa4ZRjBqTZCs/b56LI/dNqagYfAq+c5DmDcBIBJ7s/pMVxMnihcJZwO97?=
 =?us-ascii?Q?bS9XwPmkzzj/wOVelJ59Sw9A9fQLD7mRdvnShWXjmvHZPgwOoew7djEWpGtq?=
 =?us-ascii?Q?tQ3k4c+FRMzE5tdkxk1IEhu2T0QjX3X416/1aM6iP1Pko59oJJ4fSrgQ8eeN?=
 =?us-ascii?Q?3USHFgW/4SnFdBFl2sB0LGfoJJGyXWgeGaILJA11MQgxF4GtZ97E0k+2G1Bl?=
 =?us-ascii?Q?Hvf47YFiBnGKEvFFsu/NTSI1f0bd10hmwHucRvTXo/6rS7pEYU8Wy6kLTOwq?=
 =?us-ascii?Q?OSSWTsWTaR3nJ3Lo0v+WXzXpdxLg3O/llAijdSFm+HOFmOUaGpUtB14SSRw5?=
 =?us-ascii?Q?Nr5VViFtzjtyssVf3GbWlLp3oqBgQ51rb9/6cmPtIIEKaAW13IGUkm4cU7xB?=
 =?us-ascii?Q?68HHY9zpNR0Lic7T6eL/QOaaj/Thq3tQtB7bX/Xf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcf299c-9800-40cf-5a9e-08db84496652
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 09:04:58.8842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzqQWL2wk8AroPINA9W80xNXZK0pvY8qrcvKakVuXv+CIzCWUmrvCMu9qfrQYByxCQ/xCga79f7Z1LrgfqaFVA==
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

Add more PDs for i.MX8QM and i.MX8DXL, including
dma-ch, esai, gpu1, v2x-mu, seco-mu, hdmi, img and etc.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 65 +++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 5a28f5af592a..08583a10ac62 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -121,12 +121,16 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
 	{ "audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
 	{ "audio-clk-1", IMX_SC_R_AUDIO_CLK_1, 1, false, 0 },
+	{ "mclk-out-0", IMX_SC_R_MCLK_OUT_0, 1, false, 0 },
+	{ "mclk-out-1", IMX_SC_R_MCLK_OUT_1, 1, false, 0 },
 	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 32, true, 0 },
 	{ "dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
 	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 32, true, 0 },
+	{ "dma3-ch", IMX_SC_R_DMA_3_CH0, 32, true, 0 },
 	{ "asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
 	{ "asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
 	{ "esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
+	{ "esai1", IMX_SC_R_ESAI_1, 1, false, 0 },
 	{ "spdif0", IMX_SC_R_SPDIF_0, 1, false, 0 },
 	{ "spdif1", IMX_SC_R_SPDIF_1, 1, false, 0 },
 	{ "sai", IMX_SC_R_SAI_0, 3, true, 0 },
@@ -146,8 +150,10 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "lpi2c", IMX_SC_R_I2C_0, 5, true, 0 },
 	{ "adc", IMX_SC_R_ADC_0, 2, true, 0 },
 	{ "lcd", IMX_SC_R_LCD_0, 1, true, 0 },
+	{ "lcd-pll", IMX_SC_R_ELCDIF_PLL, 1, true, 0 },
 	{ "lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true, 0 },
 	{ "lpuart", IMX_SC_R_UART_0, 5, true, 0 },
+	{ "sim", IMX_SC_R_EMVSIM_0, 2, true, 0 },
 	{ "lpspi", IMX_SC_R_SPI_0, 4, true, 0 },
 	{ "irqstr_dsp", IMX_SC_R_IRQSTR_DSP, 1, false, 0 },
 
@@ -163,10 +169,15 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 
 	/* GPU SS */
 	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true, 0 },
+	{ "gpu1-pid", IMX_SC_R_GPU_1_PID0, 4, true, 0 },
+
 
 	/* HSIO SS */
+	{ "pcie-a", IMX_SC_R_PCIE_A, 1, false, 0 },
+	{ "serdes-0", IMX_SC_R_SERDES_0, 1, false, 0 },
 	{ "pcie-b", IMX_SC_R_PCIE_B, 1, false, 0 },
 	{ "serdes-1", IMX_SC_R_SERDES_1, 1, false, 0 },
+	{ "sata-0", IMX_SC_R_SATA_0, 1, false, 0 },
 	{ "hsio-gpio", IMX_SC_R_HSIO_GPIO, 1, false, 0 },
 
 	/* MIPI SS */
@@ -186,11 +197,20 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "lvds1-pwm", IMX_SC_R_LVDS_1_PWM_0, 1, false, 0 },
 	{ "lvds1-lpi2c", IMX_SC_R_LVDS_1_I2C_0, 2, true, 0 },
 
+	{ "mipi1", IMX_SC_R_MIPI_1, 1, 0 },
+	{ "mipi1-pwm0", IMX_SC_R_MIPI_1_PWM_0, 1, 0 },
+	{ "mipi1-i2c", IMX_SC_R_MIPI_1_I2C_0, 2, 1 },
+	{ "lvds1", IMX_SC_R_LVDS_1, 1, 0 },
+
 	/* DC SS */
 	{ "dc0", IMX_SC_R_DC_0, 1, false, 0 },
 	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true, 0 },
 	{ "dc0-video", IMX_SC_R_DC_0_VIDEO0, 2, true, 0 },
 
+	{ "dc1", IMX_SC_R_DC_1, 1, false, 0 },
+	{ "dc1-pll", IMX_SC_R_DC_1_PLL_0, 2, true, 0 },
+	{ "dc1-video", IMX_SC_R_DC_1_VIDEO0, 2, true, 0 },
+
 	/* CM40 SS */
 	{ "cm40-i2c", IMX_SC_R_M4_0_I2C, 1, false, 0 },
 	{ "cm40-intmux", IMX_SC_R_M4_0_INTMUX, 1, false, 0 },
@@ -205,11 +225,56 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "cm41-mu-a1", IMX_SC_R_M4_1_MU_1A, 1, false, 0},
 	{ "cm41-lpuart", IMX_SC_R_M4_1_UART, 1, false, 0},
 
+	/* CM41 SS */
+	{ "cm41_i2c", IMX_SC_R_M4_1_I2C, 1, false, 0 },
+	{ "cm41_intmux", IMX_SC_R_M4_1_INTMUX, 1, false, 0 },
+
+	/* DB SS */
+	{ "perf", IMX_SC_R_PERF, 1, false, 0},
+
 	/* IMAGE SS */
 	{ "img-jpegdec-mp", IMX_SC_R_MJPEG_DEC_MP, 1, false, 0 },
 	{ "img-jpegdec-s0", IMX_SC_R_MJPEG_DEC_S0, 4, true, 0 },
 	{ "img-jpegenc-mp", IMX_SC_R_MJPEG_ENC_MP, 1, false, 0 },
 	{ "img-jpegenc-s0", IMX_SC_R_MJPEG_ENC_S0, 4, true, 0 },
+
+	/* SECO SS */
+	{ "seco_mu", IMX_SC_R_SECO_MU_2, 3, true, 2},
+
+	/* V2X SS */
+	{ "v2x_mu", IMX_SC_R_V2X_MU_0, 2, true, 0},
+	{ "v2x_mu", IMX_SC_R_V2X_MU_2, 1, true, 2},
+	{ "v2x_mu", IMX_SC_R_V2X_MU_3, 2, true, 3},
+	{ "img-pdma", IMX_SC_R_ISI_CH0, 8, true, 0 },
+	{ "img-csi0", IMX_SC_R_CSI_0, 1, false, 0 },
+	{ "img-csi0-i2c0", IMX_SC_R_CSI_0_I2C_0, 1, false, 0 },
+	{ "img-csi0-pwm0", IMX_SC_R_CSI_0_PWM_0, 1, false, 0 },
+	{ "img-csi1", IMX_SC_R_CSI_1, 1, false, 0 },
+	{ "img-csi1-i2c0", IMX_SC_R_CSI_1_I2C_0, 1, false, 0 },
+	{ "img-csi1-pwm0", IMX_SC_R_CSI_1_PWM_0, 1, false, 0 },
+	{ "img-parallel", IMX_SC_R_PI_0, 1, false, 0 },
+	{ "img-parallel-i2c0", IMX_SC_R_PI_0_I2C_0, 1, false, 0 },
+	{ "img-parallel-pwm0", IMX_SC_R_PI_0_PWM_0, 2, true, 0 },
+	{ "img-parallel-pll", IMX_SC_R_PI_0_PLL, 1, false, 0 },
+
+	/* HDMI TX SS */
+	{ "hdmi-tx", IMX_SC_R_HDMI, 1, false, 0},
+	{ "hdmi-tx-i2s", IMX_SC_R_HDMI_I2S, 1, false, 0},
+	{ "hdmi-tx-i2c0", IMX_SC_R_HDMI_I2C_0, 1, false, 0},
+	{ "hdmi-tx-pll0", IMX_SC_R_HDMI_PLL_0, 1, false, 0},
+	{ "hdmi-tx-pll1", IMX_SC_R_HDMI_PLL_1, 1, false, 0},
+
+	/* HDMI RX SS */
+	{ "hdmi-rx", IMX_SC_R_HDMI_RX, 1, false, 0},
+	{ "hdmi-rx-pwm", IMX_SC_R_HDMI_RX_PWM_0, 1, false, 0},
+	{ "hdmi-rx-i2c0", IMX_SC_R_HDMI_RX_I2C_0, 1, false, 0},
+	{ "hdmi-rx-bypass", IMX_SC_R_HDMI_RX_BYPASS, 1, false, 0},
+
+	/* SECURITY SS */
+	{ "sec-jr", IMX_SC_R_CAAM_JR2, 2, true, 2},
+
+	/* BOARD SS */
+	{ "board", IMX_SC_R_BOARD_R0, 8, true, 0},
 };
 
 static const struct imx_sc_pd_soc imx8qxp_scu_pd = {
-- 
2.37.1

