Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9F879F7D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjINCRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjINCQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:16:54 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C921BF3;
        Wed, 13 Sep 2023 19:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMXb17swB8SPGttJb4EyXXXz79wZY+B+Y93DqV4GloRWDDYZZXWFaSvjuT61VCQPqS1nwzeZSyP5JlF5yOrPGhrGLMylerV7s+4CDepfmh898P6xinALit4H3mKiCd0JEHbOL/MgUOeTB0nWMJ1Q4ySW9Hsh5C6SjTJYyGu338zD/DFSLYM4yWKmRpp7JHi1Xp+mIMIQ1QSgnnKDd9JdtW67pTh6eDK2pvsNq+noia3eJhr57MpacKDaDCMc+oRV/a42MkYxA7kARml4ofhOwg/THDOd0+fJoWVxPYKd8JEfNmVmscVGwI1FvxEVVGMvpPvP9/GvOvwu3kf/LgS4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2J8Z7PU5UGmEKnlwt7ZLk3ZLEnkDcSGpTI6QIKlLho=;
 b=XCpGXngvuJeIPCP7xpVfp3rBiyiiV4pSeU3M7qtpSQz92vQNqOxbWb3xTHt3shqUkZnwaY45Y7pXuER9G9hspChrhY9rApugAm8Nk1f5R8KyyFtrCHyGmwEGiTDvkoKAIWwDHf+nWEQ07589QAjKNibORTD1yIEc+QwaBM4RUsRgAAP4fnmKhQKtC8OZSZsydPciYo6AixrJB4iVq62IWBUZ+/L+ORKdVzE6DHWfXmnDyXCGusCeXS4MJ8Gn3h5BR2jzBKSu9g2yBaDuQSDSQQDqzwbmUhDWoML9yiaqbziFDzA5PJpVYUOqkDx5FZvhBBMvuDw8jhjuAyy1D4WOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2J8Z7PU5UGmEKnlwt7ZLk3ZLEnkDcSGpTI6QIKlLho=;
 b=P1PtA6n2uPN7bEQ88Zlbz2AcrQHlEKkBxCYSH/I7I15cpDs4RUenAQDWJpP9WHadljqmq7ZJAhLrX53a5Tuw6K3ZaSySaiWZ+iwibAOSgLOUeZZsa84sqab5gncr52rL8T59BFjN8MIfN0fpCNIEQd5+oznVjMmyMkbUs93xrxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7257.eurprd04.prod.outlook.com (2603:10a6:102:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 02:16:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 02:16:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Thu, 14 Sep 2023 10:21:00 +0800
Subject: [PATCH 4/5] arm64: dts: imx8ulp: update gpio node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-vf610-gpio-v1-4-3ed418182a6a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694658076; l=2170;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=GYZKwjf7dvq2jvYJKddceGSrmXqgRyNisCw3quQOz8c=;
 b=mQsPJ/qbcu/+ZYix+fpyhfvbcj554tU2XkSPJurjq4IbZnB2w8v8TCYwbX5K0apgKAPjw5OH5
 dIjtuier017D5IuE9CKOUKvFddwbLF1KKz8/rKkH2AIGaPxelVXUiFN
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: a0438ff7-af45-4342-ffd3-08dbb4c8a57a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WizI/AWfNAWFEK2CGyk/62C28D/77HDEdf123iO473+WulVjJUcMAfythVVag43N9tHdVS9HEEAsfbP4+0SoUW2mbG1ZXgWap5vkoxigk/lySBGaZ0SQJj26KOjjaUgqp0fWMYmOY2RQdR6r3ohkNDh0MTWSGFA1oBQGY0dRW1G3Lj3SX5/vseeP11MAO67Xkzp6xwqdDH82JmkxrXTqs/EdNI8lizNG5BFudQH19BJWkMpmlcNSLUicNZxkbS0P60gvFHemdZVzlQze6c9vQRktez5kLuYXtDAuv/Ncan8Tx62V8ZOHq32yxZe/Y7MCZ0zWOOOK5hqmEvn4rDzPB+cr518ZJIziqAVytGwRHefrp82dB7CiU/DwMgDY2++4zbdPHAwcoMjHFgNxOJ3tPsTG5Jw9T8tdZ2yBoY7LSKpuXO7v3JU1zejxphmUpT/HmSrOOKrYjh6n8Qt/0+unmbCwI8YEwHxPnpRC6xENt4+FwNlllthsajYlo9vtdpdyKnUUO8H3I+jWe7vLQ4zoGYBFl8uLsYKGjWJlBax0sg6Uulox5XKjm+SKU2IqG7idYp7MptsYk3HShuIHno8fi0HC7nESuQ+t0gZABAP0db10lyIgP9l28mRoTU+KGVoHs1aN4oLvpv09VUHyzrSKUdEsZoBgpaYvN6m7PQ9JNTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199024)(1800799009)(186009)(15650500001)(7416002)(2906002)(5660300002)(8676002)(8936002)(41300700001)(4326008)(66556008)(66476007)(26005)(66946007)(110136005)(316002)(478600001)(52116002)(6666004)(9686003)(6506007)(6486002)(6512007)(83380400001)(36756003)(921005)(38350700002)(86362001)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzJ1Mkw5c1Y2a05QU05zOTR4VXU4SElxK25iTXVZa2ovcmJab1ozaUJ6U2V3?=
 =?utf-8?B?WkN1TmdGZm41YktUMzJhTG01K3NvOE9nQ1NveTQzRWJqY1YwZ0RiR2F0UEpD?=
 =?utf-8?B?UGt4bzA3T2VkajQvVm56WXBQNTU1OWt3RGFuL3dvYWZrdkpWRW10eTZyclUz?=
 =?utf-8?B?QjlVT3NvejVZWGlrbTZCQVlVOVRQTjJkN2g4dWRqQStneGZWeW05alVUTXgv?=
 =?utf-8?B?R1pjWGJUd2paa1E0MDlCYUJ0Qk1EYngvSkVFMVpiMDRjRi9zSVdPYXo2NS96?=
 =?utf-8?B?OVoySDl3MTgrYTBBMEpxZWVHMlRoTXU3eEpVSnoyVkdMUkh6bWtLWVJobFBZ?=
 =?utf-8?B?TTJIUFkvRzFtQmZ3bU9pYldrMHhVNVExaUNuZjJGa2RjUDBKQTliYkxFeDhr?=
 =?utf-8?B?NW1MZWhNR0Y3V2MxNGhNMjJmOWZ5dTBVY3gwVDJnNlMwSFZHaStYbHByTjkw?=
 =?utf-8?B?MGZTTGEyZE1VWG1pMGZNbHJuanNIL3crZjhvSm1VeFdsbE4wTHNPQkdzSkhn?=
 =?utf-8?B?NUtLNmduK1VWdWNYVHhneEVMazBMeVpjY0tlZktqVVJrZ1IxTEwzNEtQMTBt?=
 =?utf-8?B?a2pwTEhtUzQzamNvQnBRVmFmWDFYUG1mNnJjRWFub0wxUmJLbmRwUVNxTzNx?=
 =?utf-8?B?NzkvdnVKSWl3bVhrL2VmUWZsRTRQa09XS2JzUFVuYUVXVGE2Y2dvWHNKNmF6?=
 =?utf-8?B?N3Q2VVJHMlgwdzcvSXNyd293S1ZTaFhrYkJPUi9icVBreXZyVFowTDZ0d0Rl?=
 =?utf-8?B?NU1PQWIzUzdPbUEvRmE4TTNPWmFCNXN1VGdUc2JkTENyOVozMVlCLzJvOGFT?=
 =?utf-8?B?MlJuNEpJc2F4emRYbWFoenc1ZDUvQWw1dlNBaDlhMVVHK29vcndRdmtPbjBv?=
 =?utf-8?B?N1lNUktBMkdYMkFZbHk3ZEphVDBENlByZjlYVlgzVGtpNEgvYTZLVjNzSmh3?=
 =?utf-8?B?REJjLzRHVCtEdXVTSDRzMkFXdUpmdWpEUHhxQVU3RGhvaEpjckVxaHFBNFpx?=
 =?utf-8?B?S05GYkRWOHY3NzR6cUlvc25FbGlPbTJYaUJrQ1F1NGF4clFqd0NPays5bk1Q?=
 =?utf-8?B?VEtkNit1SjQ3ZWtEc1ZjMmd1T3VyU2RlODBQakFOdlRNeUd3clhCQ0lPcVNl?=
 =?utf-8?B?L3ZESkd3Q3hha3VucldaM0RrZTFrWUxkWVB1bVo3Zm1GRU5VZk1vbkd0c0do?=
 =?utf-8?B?cFBvT3BZT3F6TE5GSEVCeE1kbTN1cGRtMjdYQ291YXBvMlV3WGhzRTRIcEs5?=
 =?utf-8?B?RXNQc21nUytEQ2FxSU5QcUo5bEJ6QTJ5aVpVekYzcWtJU08weXg0ZzRQWjl3?=
 =?utf-8?B?R21UL2xKcGxhU3BLUHBsOEtrSTJob3doSDJKd0JpVTVLUmZGaEtPa1dYRWR0?=
 =?utf-8?B?RmJGa3pUYjFlYmR2VVNQYTM0OFkzSDR5bVhmZEZsSE1XZHFZWUtzMTgrK0Nj?=
 =?utf-8?B?NlUyQkcweWJtazBxOUcxazhqY25sTlFQSGN2Vk5zL21naUpsblVNYUhBS1RC?=
 =?utf-8?B?b3VkRTcvdFNQME5TUXdCOG90MEJKUlRSZkQwWFcrdmtVNmRVbWtrRzFTcG5P?=
 =?utf-8?B?dmlLVjAyOHRTQ1NZOUpyYUFVdmdPMDJucFVFTmM4SmE1RlRKazNuMSt6OTVC?=
 =?utf-8?B?NGh6SzYrRWl3cStGWHNWTTBpN3VjaEIwKzF3cjZneGQ2eTFYOFBheEhzNUl4?=
 =?utf-8?B?c004SnJWTnRETVZVMW4rcGdXblNlUjk4bTNmZ1lnT2tVQTB4WXlPeGZyK0Qv?=
 =?utf-8?B?M1Y0elZaZGowU1pycFU5a3F4MEErRldXWjlGeUYvN0VyU0Ztdnl1MHNaSytz?=
 =?utf-8?B?MCtYajNmOTNkek1QY1V5WEs0TlJsQjQ0N29WVkNYaVRGcDRRdWpEenhHdGt5?=
 =?utf-8?B?ZlBEcU0yUGxaTFhPWVd1cUxhQ1FHZzlsK1RGU2JoTWQ2NHgySlRadWdidGgr?=
 =?utf-8?B?V0crWDBuemdpbWV4YjVZWXdrWllET09YZ1FaSFRPV29vMlQzd1Y0NGJjZVNq?=
 =?utf-8?B?V211by92MTJNcnF0NVJ2ZDBjL2lpZmxtRWU1VnRUdnRkakNFZ05Lemg5ZWE2?=
 =?utf-8?B?eDZZemdGK2J2NFJ2ZXpCQXJ1NHhDWkJhcmNJWEVTdS9YZlU3dmprTlZVQmRa?=
 =?utf-8?Q?CkWZQkYNYsRC4Wj0lc9AAz4qu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0438ff7-af45-4342-ffd3-08dbb4c8a57a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:16:46.7084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jCEtEQrvJtmI+Ehn5iy04Ibv1lt8s+wYNc+VEBEv9F0ccKdKeGqiwLmrmclMpzq3IbcU+JiYtBB6xKDgRgzIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7257
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8ULP GPIO supports two interrupts, and actually not compatible
with i.MX7ULP. Update the node following dt-binding doc.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 8a6596d5a581..d80ba041ee0e 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -484,11 +484,12 @@ fec: ethernet@29950000 {
 		};
 
 		gpioe: gpio@2d000080 {
-				compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
+				compatible = "fsl,imx8ulp-gpio";
 				reg = <0x2d000080 0x1000>, <0x2d000040 0x40>;
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
+				compatible = "fsl,imx8ulp-gpio";
 				reg = <0x2d010080 0x1000>, <0x2d010040 0x40>;
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
+			compatible = "fsl,imx8ulp-gpio";
 			reg = <0x2e200080 0x1000>, <0x2e200040 0x40>;
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

