Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9FE79F7D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjINCRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjINCQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:16:59 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E8B1FDF;
        Wed, 13 Sep 2023 19:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pvq5Ou+yXHJ1efHOnXdhYzLX8Ts6wZcxibPrNf/I4+wIlQh4Jflni8oyicJjBr8eZx8PSLVlW5bEc6oAqIOnEKO7WxLMarpi0i4WvHcb1ifXLqI2b3DJagPF6qLxIUsBIKgEmXUZCy9iO7IMPJCv5lZsshsLIECQ0QUfPfkD7yPM2QVhYPNVjNZEIxdknuzPSJqypiN+PNzVQiDSj7zDi5ELm9rBPTmCK6viL/+x+GYmWGVUClAFRt4Q/itij0X7hrPs4poOOgP7to3xlWbPxJ89GcOiOB29+RK8IlGEUHL9q7D5TldOizKIcPY2PQnE5hQaXBOfES9cda+YjHDnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGZC91X1IV0ho/GK04vC7f1CNuE+p7MQBld+ORMvSM4=;
 b=F5cVl9+yme20MH+kg7ebzwTzqS6ckoHzOfq+9uRs05KhCQYz7DSXWcWpVnUu7TxlHb4asDvRABGCfwf+C0wUStsYb4bKb+RjQWMHkCrwda2ZDcO+xdzhFHWQoW4gH9+eMada84PTY1o1ldqsokCIsAybbLpbQA8HLvmA+zjZr5uFVvZ+xeVN9S5PaVzjO8pM3MjJLQ05yJxpNksYNaafi/xDKiNczHRczgQPrY8sccsCjzksj87Q5wws4GPMhpXUmlUGWzCLuqWiRJGowS3yzoCN7F5Y6pYERJeh+61sG5Ea3OEiADTV/ERONziGclkS7coJG7oXWHJIhKuMkrFXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGZC91X1IV0ho/GK04vC7f1CNuE+p7MQBld+ORMvSM4=;
 b=LnhRTCL4rXRBFG/RofQ9BdMdg8y/JN6VC3BuMMGfd3BZEVzzU1ZG/9ndLvZY6NIuIMOgkbtZLSGgSFB6wvouAZDmRML4ypIXMcH2eYRYQNLVku82rn/v3tBR4+L0Cqi65lBK36Xh0jRmLNQCrmm1AfOT6YB+ccxGxXmSyLSa/cA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7257.eurprd04.prod.outlook.com (2603:10a6:102:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 02:16:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 02:16:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Thu, 14 Sep 2023 10:21:01 +0800
Subject: [PATCH 5/5] arm64: dts: imx93: update gpio node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-vf610-gpio-v1-5-3ed418182a6a@nxp.com>
References: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
In-Reply-To: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
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
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694658076; l=2695;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=lYwaBTu6cwY6bIMf9obxoXYCEK5Y+uWB28zKOkNRXOI=;
 b=mhA5EyrWw4CMFttxN0uJbPGrla9agD43l0wbBsv4CsJeRaLIVkx4nABVKjXrpO2SmJYyLrtTz
 JhUySZs/By7DpCt1R5utKvVqzeI3HqYaO60mbt7W8cb8HLShvMOCXFT
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 96186bb5-0379-4250-042d-08dbb4c8a8af
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKWyF0RuMKztowH5NV1OmYZGODIgVgt5O3i4ABXj092bk8aT+ZFqIK8JUW60HLKfl35J2HwsmFuEdYyGaRO89SLgRGIuYB7E7EP7EYX007R1anjqOD/yYP5Sq6nbbG+jd/nVYa7tDz1cH9iZ5o2FuM2IeUBqWJrG6TdJBgymoJeNbRafT6406e43ULKmAUnJ4mvIMojU1f5vOVgReIQH0oUk7srSnmc2qlWYy5Bj3+Llk/2qz4JXMLgakbRkJKaj7Zc4mknp1OKYp4Mac2wV7MOcpC61+UZyXDh1gTXNtDphqjxP1i3iK9lrxnmgYWPwxM+VUIhjbgJcG+52gjefT6fUftTrxiOl1X8TKfkbEsHCqI89NArQGEnmIaMsTDLFp+o6Rp8gyeffft/Ro6RaInD8aA/N7FJDQwGZV3ev/Q6B0PVelO7sAqwl2AFRXkdo7rkIDcT6hTYWWD5Pz5pEhYlzyKwcFgPc22wjlKnPUchNJ+Oi3Ld87lBuNNqXwwUD0G7cs23msMBgHsC99MmDWBgYWDfDUIdU4mZy8kxjZJ1U9Hoa1RrieTWMqZmr9KKucwNYvd/HFlulDO7edZEUzUYswktCqryMAazIshxEk6d0Y7QzDS/ltWwzDGscrrtHVooInXgmPvCXffmuVP3JuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199024)(1800799009)(186009)(15650500001)(7416002)(2906002)(5660300002)(8676002)(8936002)(41300700001)(4326008)(66556008)(66476007)(26005)(66946007)(110136005)(316002)(478600001)(52116002)(6666004)(9686003)(6506007)(6486002)(6512007)(83380400001)(36756003)(921005)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnlEVDJvTVlLTURRWDlJSUw4VExEQVRvQm1tQmdtbThHaTNlNEx4emZ1R0tU?=
 =?utf-8?B?QVF5VXYwcWkrTlNoWUFtVU9ZczhZdUQwcDJpdHFIWEE0L2hDazR4MTI2U2g2?=
 =?utf-8?B?OTU2VytBMGV6RWNWZzJsdVBaUWMvUHZYdzRObTlzTVRRd29SS1NHcVBweEhl?=
 =?utf-8?B?TU83MkdGMmlRK2kvWm04NkdESWFLU1gxSll6Y1Y0My92QVM5bFgvZU9vNzEv?=
 =?utf-8?B?NXB3RVJqU1pOcjVBN2tBSUordTluQ2dqVXJLaWpORlJHeTBpRzQxL1ZLN1N4?=
 =?utf-8?B?eDBlajJMbDJ4MDRSUi9LSmd5Ty9SWFJHRHQrcSszb0RoM1M5L0g5Q25NT3oz?=
 =?utf-8?B?MEFuZVUxZm41QUhGNEVDS2N1Z2lHdlZaWjhQS1gxRDhSTWl5NmVLaWVYZzU3?=
 =?utf-8?B?VVBqcDRycGxMRjVPZ2FnR0pvQlVNSHBqbFUrVHdPb250bXNCRDU5ZktKRDRl?=
 =?utf-8?B?NGFIVjdBbm1HRDNobjBxNHgwRWV6OHp6cVVkS3VNR0xBVWFkd1B4V2JRWTVK?=
 =?utf-8?B?bTQ3Mm5Ick0xSXlnbjBWS0d3OCtHSjkxdmN6Qk0rVmtDNXdyOUx0bzJzZHRL?=
 =?utf-8?B?WTArR2s2WE1pWmE3SUNXU2l5UWtaWVB4dUJQQTQ4ZXZwN0dsL2ZCa3QwWEpq?=
 =?utf-8?B?YjBtdDVZL293TENVZTJtcVc3cnJHWSsvNTVuTGkxekxyUXVVUzk1VFEzRGE2?=
 =?utf-8?B?SC9aakZHT2NlNzBwTzlNOVVFTEdYUjh3cnpJdWp5U1M0OS9MR2oySFNpKzhI?=
 =?utf-8?B?dDQ5L2k4MWpQenRSbzRLRHRjSUlpQjUzY2Y3TVlIQ2wwVjRtU1FwWTg0dXZ1?=
 =?utf-8?B?aTZtZGR6TE4rdjV3a0ZvK0kwMkYvSERVaVVzTXZVYysyWG85ZEdtbm9GMFps?=
 =?utf-8?B?S3NXd2l2dmdzc3RzbzBjSGFidHlkdmhZcHA3OXBRQUNONDJhRDBOdkZOL3dB?=
 =?utf-8?B?ZVBvQVhHcmRBQ21WNkJPVVBUQmt3cUc3bVJsVnEzNzVndmlnWTdqUzQvS0hY?=
 =?utf-8?B?elZqWDBHaS9pZFZNYTk1NnZYRTNNRGpDbktncC9pWTR5bGczYy9qaGlXYmVk?=
 =?utf-8?B?aWJGVWJwTkJQalFKZ2Fkd29BM1dEL08zemVhdzlhMkRhT0p0ZTg2ODdaa2dM?=
 =?utf-8?B?Z2JEWFArejdoR3Z0RDhWaU10QVFBaWpxOUE5QzFLOXhERHovOU1id2QwSXZo?=
 =?utf-8?B?Nmt5dFQyeHVYRC9NZGJ5dU0rOW1PbU5IOUdnVVJrV1Jjak43bCt6MTExM1U4?=
 =?utf-8?B?VUJGK2xuNjcwQlA3M1g4U1BNSEFNcy9UdW05czVFQ3JyZi8rR0ZCekVwZTdE?=
 =?utf-8?B?TG14NG1UcUo5dHgxOFRqWnFNT0s1YytoVWkrSEl4alFtSGxaSXkwOHdqc3F0?=
 =?utf-8?B?QnRZYVpJdWRPTGFWeUVkTVFiT1JJbGkrdjNlNWJ1YmlsL2xLRDN2VWs0T1JZ?=
 =?utf-8?B?bGZtcTY0RHZwb1M0YmxUUFFsWHpmTm95SkpMdGdoRWFwcWdET0hzYURuc3I5?=
 =?utf-8?B?ck83V0lYUWw3cFJ6alQ0L3p4WWtZZmd2MmZRMXc5TXlzVEJ4N1dUM0NsdWs2?=
 =?utf-8?B?S3M0dUNXckNTem9XUklnMjdCeThyWVBmS3ZndS9oL2tlNmZ4Rng1cXdLNXZF?=
 =?utf-8?B?UGxKa0FCa1djSkJuYzErZXlLUWFKK1NhUmlBa0NZREgzcVl6RktqMEl4Szhs?=
 =?utf-8?B?SDdKdiswWDlJUkUwamt2b3ZxVXRTRCtTT3d3aEhzQ3pWMy9WYy9ZdUFPcnNm?=
 =?utf-8?B?RW1NUjB0M25ZdFlBYTRJQzdiU2xteTh1VDVxTDhvMlRHSS9VenhmYmVUblhM?=
 =?utf-8?B?YmlrZmZQNURlU1o1OWxBeE5kR0QxZVoyS01ONC8rOWdLMzVER3dET0dZamJH?=
 =?utf-8?B?c2xCdTdURGs2OHE1N0RBUDBBcjQ3REhzZG9XaGZoWTlmeXFhUUhXQ2NvUzhO?=
 =?utf-8?B?UUtHbUU2cWtJTkx5UUpWNy9SazkwRWltQzhGcTlJYUFGeE1wQWRCSUUxcXp4?=
 =?utf-8?B?bjg4N1Rsb3dqOEFJYlFKRVFpOTFjd2NXL05qQWFSRkNrMzZVd1hvVmo3MkpW?=
 =?utf-8?B?OFNRMWViS1laaGh2SUVhTGlCN1ExbE84Z3VSbElOMzJvdFNWWFNxQy8xVFB2?=
 =?utf-8?Q?0tLQ5zUfTHIWfgIOmq2VV/Vqq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96186bb5-0379-4250-042d-08dbb4c8a8af
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:16:52.0584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVwDo6yVefj/FkY2bsvwb7zxr9CxAJjGghzFOm6dVuLrAkQLfvCefASPTtZnvjWoNmwCuEB2C6LUfObeyIJoyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7257
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per binding doc, i.MX93 GPIO supports two interrupts, and not
compatible with i.MX7ULP. So update the node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 6f85a05ee7e1..011c34a57c53 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -825,11 +825,12 @@ usdhc3: mmc@428b0000 {
 		};
 
 		gpio2: gpio@43810080 {
-			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
+			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
 			reg = <0x43810080 0x1000>, <0x43810040 0x40>;
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
+			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
 			reg = <0x43820080 0x1000>, <0x43820040 0x40>;
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
+			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
 			reg = <0x43830080 0x1000>, <0x43830040 0x40>;
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
+			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
 			reg = <0x47400080 0x1000>, <0x47400040 0x40>;
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

