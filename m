Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCC375ECE3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjGXHzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjGXHzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:55:35 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2072.outbound.protection.outlook.com [40.107.13.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD4DE57;
        Mon, 24 Jul 2023 00:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUYU97ExfxFF7QTiMIDQiCnPLz5cF2ZEjgZw0WXeJyPT/w62UCy3Di3VyUY1RniczVvaqqBfzjTUotglCcFoQDK0BS92QZuwBO/Yipqww6W4ViUimpiEw/6sUmdchkP5ejMz5z9eLAZQD6HjBLtl2gh2Zn3CfxN8h+tLN+TSi1hsxV8Vo24F+LpH5C6tjsbjqoe7iIjgrUNOskdV68XR+djGzCZWTUrGrTvLwgHrpMraHJ8Udo+KiDAH0TN3LruQfWbBBJt3RQrfsNcoITOfo6YNlnoOphoJxuykP9z+Asb4BGB0GjYhCmptm9azaNjH1FbTiPjkAS4W0JuwAOJ5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dII9VVZ2KCLXc/SpPp7Wz6XGj+4DOpNTXqxJeoW1jaU=;
 b=ohA7B6m/C9mj4GBbvgfMmO2SN9wE36wEiODWe9NFyZiF7b6L+b7CXVECLa5+nLbBvwM+oUTFvlclIGVQKdiZ9HGYmyVO5uD4abaN+oZ1sbiAOnuCLaNHLXhRMzYKO1uVsaH4mmh/xXVQocH8jLXJE167FAHpiYsijZFMiOfwkp3PrVZeLe4ycgQtN0FgQgX3eA6tKf5z/dnIWK7v7CcKwHF6bsP3j5Z4FyaXW08rzm55pqXIxYqzfEvO7ndkngvqIUfs/xgIQ+cmriGFEGp07f2Ssd5p/rxgD1dr2IaKz5THN+rXIovdY8Q2maBGI1QrDc6wHgopyWw/aDn2lK9V9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dII9VVZ2KCLXc/SpPp7Wz6XGj+4DOpNTXqxJeoW1jaU=;
 b=d0axnzWYSqgMItQ7/V9qSP/lNfkATpjD1tJHVfpb4l5QJ/yUY8bQKPCPRvXn1/SQrnKxjAdoXY0eqP/JHWqFQH/Fqj+IR1h3YRvi/hHGHHccgi0qtDQS/kwy86HZ/FrE3qoIKPbRGSZZy599vwGEUbDxgp/ekjUyTaK+UgbQrV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:54:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:54:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 08/10] arm64: dts: imx8ulp-evk: add spi-nor device support
Date:   Mon, 24 Jul 2023 15:58:31 +0800
Message-Id: <20230724075833.2763190-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
References: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a2852e-2faf-44c0-4b40-08db8c1b326e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K10uMKAU+EAyHTMLPTNs1B83TZX+91wEZoI+HxepKyQJUQMRzkT/42leqy2xs4J8jkIFRxXbAJMBoq4k/KAL7eQl1o6uS1eS8qXxXN2c/yx2cMHNqrOIqYevXHLZIDy3cQkPO+2m0wlji44r696vHK0usepDuvtZuX4HuEZkoTO4JIgx+BAZandWAe5oCzXFcdYXfkvNG1npOlWFyRGKnEV1yX0yic4Yno97UQKgFZdQIS3kDh63RqeaDoRLsjSGEqZmzWXDnZQR/UBLE7KE/X8pxfSR8fxG7rOacXE/MX+efRQRmD9AQUyD0+/p+kxd09lQDlfxUP/QiS3CLZmR7FmgRqa9CGuydLOUbx9W0LXxkIF7LXVKNHdgXAkrduuEwvNeIljQuf+tYh1luL3flHi954PP+tHDVHGGoG0SwfbzsKcgVTWwA4Sve0PGmX6gJCUMHI9+lSItc3zh850FBxIqxIdQ8Xlfqa8TsMnLZ0FW7CDWYH7C2PE954dWE9GBowi74O3BBZttkxYUncDgnzkQGEWvAbHIz590+PIrNp7Vs4iAty+1U4xrGRb1Yk3yGP1ch4vAvpwVwO6CdWwXQmdOhc8zBuyWjUPG0aGC2TvlDqU5nZH2JNivshjuE3tuUbhB+UWPfz+C95xzUBttKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(8936002)(5660300002)(8676002)(41300700001)(316002)(2906002)(66556008)(66476007)(66946007)(38350700002)(1076003)(26005)(6506007)(38100700002)(6512007)(54906003)(83380400001)(86362001)(52116002)(4326008)(478600001)(6486002)(6666004)(2616005)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YyHUC829gho3hcGJXJiIhnO9KF3NRUm04sGuKME9KRLJCyxKdpXdz7nPAd+c?=
 =?us-ascii?Q?gI6DqZTGTuo9RyjvQuZN1CPV1C72DZ+zOOIFe3R2ihMrlwn/GAzSNjWyGTdw?=
 =?us-ascii?Q?pMS5AhRUxbALlTz2SQ4Y6M8S5HOVGmu7KIeVUYBNpfYiLLkpGHVSfathPjVX?=
 =?us-ascii?Q?yj+fDZv8E+olqDKqZBYxMI5lDd4RpihKwhNAR2Pji3Pdi4KOPx7HDlG0AxUK?=
 =?us-ascii?Q?aaoQeda1JKk1tYR9qurWqMBiT+bisQeM0ElhVGapFWjrV/9fcTtIXEWijxyB?=
 =?us-ascii?Q?14WwzY2j4YGnxj2HUXdA8VRsMmYU+63cV+7MZaS5ZfjFTDG1bUmREqVUt6u8?=
 =?us-ascii?Q?kj/NLMWDrZbY9lb8UyKQ0GuW4xzs2U9bsCI9w++WDLnvvi6EDnTbz3+CSNaH?=
 =?us-ascii?Q?pIp8rRBzeAtpknbncQYWmsQb4y+XgobLdFySDMuaR76eWw9+p7/UZGreelAh?=
 =?us-ascii?Q?jvSobi4mKf3S6qFbfV1iKgzPtKgWkeBh/W1ULAwcNHkGRJMWpXx45eJAGsdv?=
 =?us-ascii?Q?UY7tAWW36OA2Qrxvk9qzFu5rE7irtoyiUCoGF4/ARmM9mmBjs7a7gyA+1JbM?=
 =?us-ascii?Q?IQrVhK2/iaVWthnOnQrRuShyW0NScUe04ApSWfbgg0QRUqey+Sl5z3qLJmXg?=
 =?us-ascii?Q?sPbDxBkZg0Q6tIlQBiiChStGGL+UQ1MD3ARbPEhhfAWS65AXcSTOUmuJe9hX?=
 =?us-ascii?Q?Z/12VAG2E//haBKdFX3s4/feB4KiZh+pj7h4bQiChT3DO9LT5v4igP7uVguI?=
 =?us-ascii?Q?nYO/OnU25+gJlNbHoHMk9nzi8v3fXhJ3C1j3gezHdxwJ50mEGRfGtzyT/A1Y?=
 =?us-ascii?Q?5mM+ct+OMw9KB9VvluwWKVM5QidMFWcO//VB+ZT0tt8AR6Wqsm2MI8aOUZZy?=
 =?us-ascii?Q?dzuQeUqhF24NK3N6IQDO+K+VrHrpmbd3C/BuS+Xk3IwIOb7YQYl4VUbf4bXj?=
 =?us-ascii?Q?FckrDSbD2pAO0ZEThlq7PduZ1PYQ3JI3g2Zhib+IwdyZRqmYLkUGm4So297I?=
 =?us-ascii?Q?4nf8cKhXVSRpeSQyItcRJXSLVUZsqZoYIrcNjnhww9isnOpkvUASsTs2B0Vz?=
 =?us-ascii?Q?lw5Xp9VbDePM3xakIJw0FC6oQ/VLG5pBdTffNUIEIAigWsrDTYKGtgdeWf1b?=
 =?us-ascii?Q?gTntyqMr5TgOOoMNpAkxUFYIm+3B14maGQg5uJe2S83dKn2762iDjKtIqr6o?=
 =?us-ascii?Q?nj3rQ3I4G4iD5aEtP9+wbdsZEDgscCZNP+x+5ek8NjUz+L9He1leA1MO0ouD?=
 =?us-ascii?Q?UD5w5fpT9mS6T8pp5a3J7b12buyhuaIVANvgCkZ+NFYZKSl+pzjJufDIyBw7?=
 =?us-ascii?Q?3Jrb1jGsCz1bT21CvB2PNc1Dx3bn3naldbHN1HE20r7BevNyZAfRZHIaXDO1?=
 =?us-ascii?Q?wqzfEbqYfXx6X/IXhQgiJoGCUnGcn3BtWz39cQZyxDzsTJpwWC1Von3SAk6h?=
 =?us-ascii?Q?GuFfrfU+erzFZ8LtEXXkkYlcfAVzbNx5HmyM+k+e6O7/PQVp6kHJJBTWhV3H?=
 =?us-ascii?Q?oP+Q3A7s50JL+qYcbvDPoaEsGM1xdDbZoZDaCH54IxdLiU1axdoeJUBPHNk/?=
 =?us-ascii?Q?3bQX6vt5/JGAjC63U0GkRzIqlJPIWWT/SNot9aWW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a2852e-2faf-44c0-4b40-08db8c1b326e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:54:24.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GE8Rt0EzggIoDdg41dcVob1W8hOiHmZfTlBDewfz2i6GRqbn5T8CobXxhVYQaa/7gHGvNLiUMe4L2iyy2b1BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

Add spi-nor support.
- 8 bit mode for RX/TX.
- Set the clock rate to 200MHz.
- add default/sleep pinctrl.

Co-developed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index d66e31cf83fe..f841b722597e 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -95,6 +95,21 @@ &cm33 {
 	status = "okay";
 };
 
+&flexspi2 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_flexspi2_ptd>;
+	pinctrl-1 = <&pinctrl_flexspi2_ptd>;
+	status = "okay";
+
+	mx25uw51345gxdi00: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <200000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &lpuart5 {
 	/* console */
 	pinctrl-names = "default", "sleep";
@@ -159,6 +174,23 @@ MX8ULP_PAD_PTF10__ENET0_1588_CLKIN 0x43
 		>;
 	};
 
+	pinctrl_flexspi2_ptd: flexspi2ptdgrp {
+		fsl,pins = <
+
+			MX8ULP_PAD_PTD12__FLEXSPI2_A_SS0_B	0x42
+			MX8ULP_PAD_PTD13__FLEXSPI2_A_SCLK	0x42
+			MX8ULP_PAD_PTD14__FLEXSPI2_A_DATA3	0x42
+			MX8ULP_PAD_PTD15__FLEXSPI2_A_DATA2	0x42
+			MX8ULP_PAD_PTD16__FLEXSPI2_A_DATA1	0x42
+			MX8ULP_PAD_PTD17__FLEXSPI2_A_DATA0	0x42
+			MX8ULP_PAD_PTD18__FLEXSPI2_A_DQS	0x42
+			MX8ULP_PAD_PTD19__FLEXSPI2_A_DATA7	0x42
+			MX8ULP_PAD_PTD20__FLEXSPI2_A_DATA6	0x42
+			MX8ULP_PAD_PTD21__FLEXSPI2_A_DATA5	0x42
+			MX8ULP_PAD_PTD22__FLEXSPI2_A_DATA4	0x42
+		>;
+	};
+
 	pinctrl_lpuart5: lpuart5grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTF14__LPUART5_TX	0x3
-- 
2.37.1

