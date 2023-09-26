Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D867AE42D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjIZD3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjIZD3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:29:25 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2086.outbound.protection.outlook.com [40.107.6.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0349DC;
        Mon, 25 Sep 2023 20:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvJbpy4ZRuEchzzAuEAEiQ1OB6mtyEibwYnatUkc0qvcBQ3jrA+98q1W9DB29nes2ygtCMZhLdNjHcbcMnTJzBNWzWWK+9JNkm+1SiU4pGM3NV61xsk15iQ/vxwYffvWUEo4Bt/2FxPUGdjoY/qkv3lgU5/JBgR0+dLRuiThuglC4XNXCpYUtZ7kqU0Yi8gFyel4k8ojeYzhNiggzO5Y84MJ84H0TcIHM+j3t1asYNwiQT1onxi/OBHGK43tK0QwNB8cQC/fNby0xNZl7nXnTBQ/le3v+gWoOUicvjIvwnCtSYP3SEYCft1j4mj9/0AADAbB8/ASPQsRo/S9Gr+m2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHFXluGVzWt02RyFWyPuMFSCqz5Y1oXytkU5t9k+fKI=;
 b=DeQ5FAs7WmitfaQg/wecuAjH0Tydd70t7PPTu/dPO1JGrILWR4ZKtOOQg2wMk0fVx2HLAwKKQ/EOzBOuiUQ0blKLg0XwVGOGfWJ7exdIIV7xtqYpqVJI0uE7y+y8qdJXWfoWkL/C2LUWNZ+l5majtdfwwYOVYmW78cosYol7MKaQtt0Ptw+rz4kVoZH4Y7nVsN4k7yNQKN+oONKgw0psWEWfdPTALJCdNK2L6Cczw/X5KAWr3RtRXuR9l6n4tzK6OSqpLiiAET8yN9Ud0Gw4UNNGQhTXTI36bZGweX9Qmpga1A2pMHbRIBxNZU0MmZvQ1XVEzVGYdAmspJYpgbIn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHFXluGVzWt02RyFWyPuMFSCqz5Y1oXytkU5t9k+fKI=;
 b=fkTHqYgAglN67pIhDIbpMt9d+MXXO4Jle/7eXXwuzY6PMb/QcFCUBK7507xxyks+XWg/3s3wbPRj/fl7ihSMUj0mFE2W2qetmSCV5TGBMxab2ebnQTGxE9Kv6aDqEygUQsieoNHuwWJsitDNeGliYLObRNWLl2QAJyEDccK7KhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 03:29:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 03:29:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 26 Sep 2023 11:33:22 +0800
Subject: [PATCH v4 6/7] arm64: dts: imx8ulp: update gpio node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-vf610-gpio-v4-6-b57b7f6e8368@nxp.com>
References: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
In-Reply-To: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
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
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695699209; l=2557;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=OBv9Fl8cAe6WZDwRqWWAbBALhbody3v57Vb/+6bcRug=;
 b=hMzFP7eFJ9RATpzZ0o91C27xX0sR0zhWvWgF2ZUJeq7BRSbeMKKbI/1p7+WDtGJeuBk5QAqrG
 0DUh3T8TyzeBKSNdpdxtoV0KT2dWrqv1eguNhCWfh4pA41qfeumJwVk
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c9ad97-031c-438f-c7ff-08dbbe40c290
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztpVzaZfZHEpsbix2AASsquwGxcvM2hFOmWMVPyiiJC+a1DwYyalQzaMRTg6OJ5GUeduKUhHMljrU+h7zoF5sjAeLSsS73WrNdzcj/jhpUQHEJ/xK12+AN47/x6UKKnenU7Iv8MBHi05nAPo4MQ+mHxVSfGDXOvvJThLiYpMB2IKzoZj+ZOPw6CqOdiLMr2UkGJJx18X5xrecoeNRE7f4377RtCQCegeuGl3xNeXtvuN2cxphB+nTP2ygr6myBnYeL7uSe9w8VI+EMYSTif7cxltCOJTa1bCZI83BC7j/i78x+dlNKLnJPyJqHI/ZrC9s/UdjH9/2BGPlV/DEBkXOXOkgXTtVXF2wNQd2ZxlmfHa+JAXyKXt26ly9sG2DZpx0TaPJpzfHQJqC0cfPHl8XcXI+YK+ldpChe+gYEDGxzUdyIEQlv4IBZTDmQ1ck75hck4dh+CkzHTnpJAhgtPUVQCyBRkVrof8dIZSheos9J/JnEvfKdaMjGS5JYA/puPrMYFh9s+gNvDnk7n/d/ISX86aUCqEDO6grt8uUI+JC5FflknoeAdxwhXN3/I0MB0284qwkQUBV0liNPWbiHYdIsoua5h1zqAcnIHJTzrlUGRsUeSXob6oZ3NIT5jDL9u2xYXwH6/5IsCbccJMz3VZGZVu/q06RR7/4Juwl/c6jLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(41300700001)(8936002)(4326008)(8676002)(7416002)(66476007)(66946007)(66556008)(316002)(26005)(110136005)(86362001)(2906002)(921005)(6486002)(478600001)(38350700002)(83380400001)(36756003)(52116002)(38100700002)(6666004)(6512007)(9686003)(5660300002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFM0bEJBMEZTYVVlcnhiQ09sWlJzWkhZelphaURWTmsycUx6bnhScitzZVhO?=
 =?utf-8?B?czhXcGh6OGxqZ2pPV0J4UzdBNHR6aVJJMVN2R0l2aVdrVWdrQUhaQm4xT2FH?=
 =?utf-8?B?MnJwUVQ3aWtXcTdqVEk2SDVwdkRNaXpxREF6OXRlN21vVjBuT3ljbUdudUFk?=
 =?utf-8?B?UzAyT3Z2NXArWXE2T0Nra1JBVGswUnZpWkVJOXVsWmZyMGI1LzV2Tm9WMmxU?=
 =?utf-8?B?WEdDamVqb2ZwNm9UWmpQT29iWldidHlueUJaRERqb3NycUxOT01hM3BmMjht?=
 =?utf-8?B?RDVUaE1POTE1Qnl4bkRqQ3dIaDRXZGNxazhGbCt1bmI2TkN1Y2NJNStrVEZ0?=
 =?utf-8?B?cE1lbmFQUHVFVDZqeTdBM0RvSzhCWnRray90NlJpOVlMbkJLVGVvRGYydXRC?=
 =?utf-8?B?UHdTU1ozM2h1RHVlL1MvUzdJcEIyOGZFSkxubWFCQk5mOGJuYVJndjJjTkhJ?=
 =?utf-8?B?T2daa2FvN3p1cjV3NUtSMDFnNlFsNkV6bG5JaDExWlhUOHBUaElwNEtOcEM2?=
 =?utf-8?B?ZjJGbXZoMkNDVmJTSFExVlF0YnRVZ1d3SXhqTFdYN0NzUzZtNEhEY1F4dW91?=
 =?utf-8?B?dTdHS3Y4d1RZSVVxeUlwMk5lN2YzVkloTVU1d212SmNqYjB6all2MWxlbG81?=
 =?utf-8?B?c3o2V3RuRG52UU1DaFkzYUNuMHBwWVdXbkFWTGQ3Vlo4Y0tlVVUxTnhsQkNa?=
 =?utf-8?B?L1lXUWcvMUJTeHNicjRBUzJJRHZwelc4bGNjSExzVjAzaGxPTW1EZFFEWmlD?=
 =?utf-8?B?Sk1iZWExTFRNY3cxVTh1RWFmekVwaDFTZkYycHYrYnZpTnlyUksxYmN6akFN?=
 =?utf-8?B?NlUzbmpWeDVLb09wRHJNS0kyTlhsK0xMVmFTaU1xVmNGNGdwcHFhQjRmV1Bo?=
 =?utf-8?B?Y0ZEeEF5T1lhMXk2d25sSlNRd1U1N2g3bkwxQjhHUzUxcElSQXFuUWdRT0dx?=
 =?utf-8?B?TmZSMkw5QkFkZTByRERIUkZIaFFueDFrMlh1b1lZaEVLT3Z3N0FSTFV3K2ov?=
 =?utf-8?B?TWVzdVR1czFTUXlqWG83WXZJWFFUZ1dwakNsV2dMNDlFeU9uRGJpRG83VU5q?=
 =?utf-8?B?RG1BVjAySDVLcnVNeGhHMVNNbUtlUkVZQWxiaXdrcmR0ZG1EMWE0R24rVDJC?=
 =?utf-8?B?dnZiWG02VXNOT3NTSEkzNUNiYVZ3SmdWVkFJa2ZvVjhDOUt4MUJvRHdKUDNY?=
 =?utf-8?B?b1VpRklmdlpaaEtwQnladGxyUXRlamx3YkpVZFd5aE9jMTFFTFNHSXRZUjZO?=
 =?utf-8?B?aDdrbTRlbE1rQi93bnRsUVoyNlFVUzhVL2oyVHZubVFiQ1p6b0dZVnhUQkI1?=
 =?utf-8?B?UXp4ZFYyVnRnbE9sdnVlZ1hPWXliWFpkVS9NVVp5Y3Y1dERJQzJycjIxS25M?=
 =?utf-8?B?SWlma0VJMHNBUWltMWFiYWtBMzJZREZMTmJNOGVzUTJmOU5VWXRJZzdERHpI?=
 =?utf-8?B?bGdpc3NJMkR1NXFsaFlBQUUyYktHbktzOCtMYm1ablJWalBzcFdiaTNiaS9U?=
 =?utf-8?B?a0dXVHFkSDZtbXdLVWJnWWlxbmRIdVVNeGhnd0FENlRMSmZvd0xyK0Q4Q2lW?=
 =?utf-8?B?NC9uU3dTZUR2UldjWVl4WnlwK3lqY0hyd0dEL0lGNVk1SXQ4Rzk1K0hBTU1s?=
 =?utf-8?B?RUhrUWdqNnJnZE9FK09qeVdFQjdrYlcwbnlZZG9nL3YwenJmRUhYdzFFdmRT?=
 =?utf-8?B?dFhnZHlUTFhXaW9HYmVHS1pCRk5WSDd6cHNaNTNWUmNoZ3B6NTVpYzFiLzZC?=
 =?utf-8?B?Qk5ZelJ2MnF6Vytyd3M5RkNoZXdsNnNXekFIc2F6Y3NYd3RZQkdRc1pSWU5C?=
 =?utf-8?B?MDd0RzR2WWpKT21ydFhqL1R1dTR3ektLeTUyUk5WR0J0WmRQOUo5dGxsZ1BD?=
 =?utf-8?B?QzB3eU52R3B0dFRkRUp2ajBmdWlmOFdYUDN5b0pReHpySXBaSXUxVDRGYTZK?=
 =?utf-8?B?cWp1WUxEYk1kUi9UZ3NHdDFpa28zWlR0L28zbU15dlROOWF5cnVBNmZmd1Yz?=
 =?utf-8?B?by9pYzJHSnBOWmVjTjdzdXBKWHdPUVJidXJhbjVJVVJnZWorYXB6VndvV2Nl?=
 =?utf-8?B?d1Q4azV6cGloVjlyOU8wUThSMzY2aXFKZ0hUTzZRZWhtTld1anRzSndYVm9p?=
 =?utf-8?Q?Xuj5clcuEWHMIKmTnzdjdZ2cT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c9ad97-031c-438f-c7ff-08dbbe40c290
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 03:29:15.5540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1kETmk8Ql0w4c79rMhRClQAasMujF4tMTarJIwC+52zpNU9o409z7JXETO2wyRanuuJd9WLr+/fSTpRsHp/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8ULP GPIO supports two interrupts and one register base,
the current fsl,imx7ulp-gpio compatible could work for i.MX8ULP in
gpio-vf610.c driver, it is based on the base address are splited
into two with offset added in device tree node. Now following
hardware design, using one register base in device tree node.

This may break users who use compatible fsl,imx7ulp-gpio to enable
i.MX8ULP GPIO.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 8a6596d5a581..3921fdace792 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -484,11 +484,12 @@ fec: ethernet@29950000 {
 		};
 
 		gpioe: gpio@2d000080 {
-				compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
-				reg = <0x2d000080 0x1000>, <0x2d000040 0x40>;
+				compatible = "fsl,imx8ulp-gpio";
+				reg = <0x2d000000 0x1000>;
 				gpio-controller;
 				#gpio-cells = <2>;
-				interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				clocks = <&pcc4 IMX8ULP_CLK_RGPIOE>,
@@ -498,11 +499,12 @@ gpioe: gpio@2d000080 {
 		};
 
 		gpiof: gpio@2d010080 {
-				compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
-				reg = <0x2d010080 0x1000>, <0x2d010040 0x40>;
+				compatible = "fsl,imx8ulp-gpio";
+				reg = <0x2d010000 0x1000>;
 				gpio-controller;
 				#gpio-cells = <2>;
-				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				clocks = <&pcc4 IMX8ULP_CLK_RGPIOF>,
@@ -533,11 +535,12 @@ pcc5: clock-controller@2da70000 {
 		};
 
 		gpiod: gpio@2e200080 {
-			compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x2e200080 0x1000>, <0x2e200040 0x40>;
+			compatible = "fsl,imx8ulp-gpio";
+			reg = <0x2e200000 0x1000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&pcc5 IMX8ULP_CLK_RGPIOD>,

-- 
2.37.1

