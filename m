Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D337A2D36
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbjIPCAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjIPCAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:00:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B319E1FD6;
        Fri, 15 Sep 2023 19:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0zOz8puqy67dB8FKeazUR1A0f+pdlOpPFM+VO2RQS0g6ccKqb023sdlrw+C6GchhaUYyv8JcUoiuazq8ph0WCrwdOecPYFtwpgjGttOrJIYCf7Coh/xhuocNxIxLhHdXoCHDyupwjftAv7ijEH7ZuTFPRL+HxKdHEuB+WxU9W2WlUQQVJOxnFlrnbMj0ei3SOTebhojyywQ/uVnhYzJdLBwjcK2CFnE4EUQS1ggC0T986pn2g8ep39TZ4lQdbHZDqrex2oI//Ku0qvUsJh7FNBbhmcP5gVKadFoirNQlvZeswnYfxXtm5u8pOIfVrjeKrUYdubrSFfwVuXXv/y/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUoJYOkc74aTn7OwouSGG5sIrL44ShOtaRFR9siZXKg=;
 b=EIwkZ4wbWVVUc6VM7N3ptURls6kvW8T3vwAUvAn4aWSK7VuWbfia28JPnYRl5pCf7/z0z4Puccsxk67LQY+K8LUS+1rpbi2zOvCWYoumywvEqrSEGC8M2ghyalbnR5ZJHIRyPnmCvDpVruxw1RWa9zABZRt15nsryhLAZ3oCtOBzqUWi2JfPK5/t/s5mnGIwodI/YZUvOu6G189Ymaag5YKhrqPnE6507cOtmclMiYB9q71X2Yyd1EWjy/orhKm38wayB+mE4unWHpilEmlB2MtdmDSZLqEmPXy+1mQbBBKexNe19+CFTwmcgeyFt8FLq8RnetdSqlThYJR9ijZkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUoJYOkc74aTn7OwouSGG5sIrL44ShOtaRFR9siZXKg=;
 b=JPkjK6POCCfMfSIChbWDea6QdTl6KvBwRHdKE+g+c8EKnUTce/IBXy9NIRHb/9UB+lgCoTojxnVzcpjHffwlm7AqFX1rd5TLYPU+fJriGWlflPtfLbEjZxJ9aGX4iO5N3OtYk92BBETT36h/9SmTHHdUlGeKUnlRzHIaJxN7eXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 02:00:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.023; Sat, 16 Sep 2023
 02:00:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sat, 16 Sep 2023 10:04:02 +0800
Subject: [PATCH v2 6/6] arm64: dts: imx93: update gpio node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-vf610-gpio-v2-6-40823da788d7@nxp.com>
References: <20230916-vf610-gpio-v2-0-40823da788d7@nxp.com>
In-Reply-To: <20230916-vf610-gpio-v2-0-40823da788d7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694829858; l=2846;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=NuO0Jx3iqgnF1U/F/674/K44XfQc3sjrhMAeImj0660=;
 b=Xfag7iQODsDxU4MKXQzIFwP/SLKKWSdpvW1QT0MAOED9c3G309B1URGp+pD+9SRFWKMS1FixY
 qbLA4SRgvWkCLY3i1ild88rhFYw3p8BvX3KBiPF+6FhSOQHufpYK2fW
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 5349b1b9-abc5-4301-95f6-08dbb658a251
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCez/4EYpmHjaqfs7Za++nPA9nO53ix6asoqi4u/8UKoWyKHLxMhE9h3UqWUjJSSbZJfUMpUeHv3A44y+3KCec4wjTbiF6GRYpGiSdJdaovsFezHkhMh19PyXbUhUXtJuVeK6b/MT71Q63a6lIlEc8QH64Y1iXR/NDLAuJWytGtKqLtqbItFTCgg+ESx8X+3iUCYa25RcaSCXTXcmUIabnoZ8t6/qpagqt8ln9vy9FJuW25P54VDg2gQ8XZMgQbRbCPE5Psie18p7w6SxVS0f8xuaImJgEmoZVHQTkHlO9KpwUshIqUa0cA8Y695uZ86DU0S9c8y+eO6oql8Nu1n6UM8Cq/e7EVjPKQ4GcBXitzVgQJgGSazs6lbGfm8L0arVjS/KlN7MMDm7Uc3Q3GwC4MU3nv8L7i5Ewjltpqqj8N0XVrmIMTmjFhX62mLEh0Cqj0pvuRqmzLYpmprWZ6cshIZRz+vOdoqMU9rQ/c7+2PrlNiDb8p6Krgf3/T0ciLwOQhCb9cG8P9NH1jjb6Omi10HX3w8TX9yUh4FkmBEePKcES4ST+E4SgLl0iMNE7pzRty6PD52gd9aS6Eows8USFnPdyEJutSPNdIWAeSmQOIqzlTuUlCVGS1+X+lt8nrV0uhwYHJlQWXxM0AiHTt73w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199024)(186009)(1800799009)(6512007)(6506007)(6486002)(5660300002)(66476007)(66556008)(66946007)(110136005)(316002)(26005)(52116002)(9686003)(41300700001)(921005)(8936002)(8676002)(4326008)(478600001)(83380400001)(15650500001)(2906002)(86362001)(7416002)(36756003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mklrc0EyUGwzdXJOc1huaHB0T3JpUG12WTdWdW83RDVPVUN0WUc3QzJlQjJz?=
 =?utf-8?B?OTREd3NPaXpDZ1YyYXNacXJSRkVLMFlFVk8xcE1KVE94c0tDMEhsTVkvczNN?=
 =?utf-8?B?enFOVUxoWVZWWUNUZEo5NGtSSy9wNG43UTYzSTIwOHQ2cE5nVGRHM1VQOTZ3?=
 =?utf-8?B?ZkppNmQyYWRKd2FmUU8raDMxaUhETmF1MFZLajVhRTFGM3NoQTIwdnFNL3VF?=
 =?utf-8?B?OE11OGxQK0NWMENjZmRVL2VMUXoxb0l2WkpZYkU4L0w3NXZEM2xKRVpwa3V0?=
 =?utf-8?B?dnJ2L2xBeXdkcldCWThoWDc2WTJpREJIdjRsUnM0emc0eUtUbmE5K1NwdWdu?=
 =?utf-8?B?U0wvWXB6ejBqaXhVejBDZWgxZVYxWTUzV3JOSVJkSmZXOTU5eDRRWFJCMEdE?=
 =?utf-8?B?N240QWZTcmU5RThCOUZDWklUN3pkakJMdmJZSW5xZ1BLYm1HMkhmdHA2VXZG?=
 =?utf-8?B?M1RXMUxRa3hhVlJzVzBlQXhMb1B0SDBzMTBnUVpBZHZnMVB4SUswL0lUUFd0?=
 =?utf-8?B?SUlYbEhYNDZjNWNsNWlZSGliNEFxejV5b2ZETkN1Ni9kNXJyRFRLTzZmOUVm?=
 =?utf-8?B?b1FiQ282MGpXajFPL09RanM5TTFYR01GbkFXV3FwUmg1cHZVMzYrM20yZFdt?=
 =?utf-8?B?THpSUVRCZVRaSlpwYnpwQTB6Y0F4MmlDTTBoOUtBZ0Z4aVd3Y2lzUFpzWURy?=
 =?utf-8?B?V1hINERGTVlWZWFWUHBMQnh4cjJHVVpoT2c4VnJDSFduaXRwY0JVYlBaUWNr?=
 =?utf-8?B?UGxyU2dWL0hMS2hScWRSQU5YbWw5NnRBdDFDYkVVcnpxb2NCTXNwWG0yS0tl?=
 =?utf-8?B?YjZJbmJRb0UvZUpwQTFPM3l6Y1VKVnVoZUR1L2c1bis0eURlRlBaTW5YUVAr?=
 =?utf-8?B?NEdER09Dam1NSit0QlAya1FtU3dRNU5CRHJNdldtcVJWWjhiTndCbUFMNmtl?=
 =?utf-8?B?bVlvZ0FkdHd1aXFaWEVyU1o5bjlZalJ6UWhCNE44TjloS3AvaEVubFUzNGtn?=
 =?utf-8?B?TUV3N1FjN2g4d2UxbnVqM01wdGltNGMzYWsvSmJGTUtRdU8xMUdPdFY2ZVk4?=
 =?utf-8?B?TnhiK0ZzQ1JFYzNtMHpMenBnbkw4QXN2aDZnbUJ1cHg3eFBVVk8vMFBGNmVv?=
 =?utf-8?B?VzU0ekRSOFdUSXdtMitnTmwzRnE2MlN4djl0SFpIaWZrSDlsbWI0bmIxVVRP?=
 =?utf-8?B?NTdXSTZFSGlwcTF0bHVzS0IyQ201SGhGWjkwL3dYdFRKR3o3Q3JMZ3BZeFhy?=
 =?utf-8?B?OUJ6MzVvUnV4TmIrUjh1VzRkSWhPeXJIUUhxOXBTQUdXaStaY0I0VUlwZnRR?=
 =?utf-8?B?K2szYTA3Q05vWFd0d3ArOVp0UFpTajBJRlFyK1lTRkE2eW1HNituQmhkQ1hY?=
 =?utf-8?B?cFVLK3BBb3A4Mm56L0JBQTc4U1lMN3R2SXlwWFNBYWNXUDFFWGhvTUExOUgx?=
 =?utf-8?B?dTRSdlUyWWZ6L2dIQzFiVk1tcEdSV0dJb3NVaThYRTRGUDR6cUVwSkFJR1l3?=
 =?utf-8?B?aVJDR2NzVUhpTXU5RE85NHp2bTdxbDZ0RUtyTzdwR1JZSWcwU2I4bEtDMGJh?=
 =?utf-8?B?YlArMkY3OHlyVFdSY3dHYjlra21KZVdBckRURUV3MDY0THhCN1NGdzVRTDBR?=
 =?utf-8?B?NHJNNnJmeW80c3FrQkdQdW5KWGZNUysyNldJV2hRVEpQYUR6UDYzbkNsUEtL?=
 =?utf-8?B?cXh6MThTSWxYWVhubXUxTGwzazFkTmJ3SzVHb3ZoOFJxdkRZeWtnbzg3bnFl?=
 =?utf-8?B?MFQreUdFVWZBSGVjb2hHRUkzcTNxMWc4ejQ4enRPb3JIRmUvMFBkT08xY3RU?=
 =?utf-8?B?VHFUWTkrNFJtQnJyTEtORDQwS3ZBTUg0WllKRDNNTGN1Z09YRnUwRWp3S3pO?=
 =?utf-8?B?UlVsTWZSWDVuN0VCOEJvMUprV2dCZFJqbTJRQ1hWZGhTZUk4UVZERGprUmhN?=
 =?utf-8?B?NldYcVdLM0ZvcU1JZ1llUjZXa0RKVVJnZkdVWEF6aUVuU1ZoOEFITHczV1FS?=
 =?utf-8?B?aktEMzh1ZVhxYkZqMUFVQktUa0NEY3dUMFFkbXNZVjFZQlQ4ZjFCaHZmaldm?=
 =?utf-8?B?aDl0dUdpVmpCTk1jeXJxZDlTTW93TXFoUFFNTzcxN3pBSXBnZXdEVXkrSUF0?=
 =?utf-8?Q?+A2SYVszmw2VdGtx0UHl/nP+9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5349b1b9-abc5-4301-95f6-08dbb658a251
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 02:00:00.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuMUYQtJvbAKktY91rxRIiH6d8+dkfUEFAA/lIkPwMMP5b6WPRgFBiTrN1g9WuqLz3lXp2nyl9pm8SIvZ72bhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per binding doc, i.MX93 GPIO supports two interrupts and one register
base, compatible with i.MX8ULP. So update the node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 6f85a05ee7e1..4b111b8c1931 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -825,11 +825,12 @@ usdhc3: mmc@428b0000 {
 		};
 
 		gpio2: gpio@43810080 {
-			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x43810080 0x1000>, <0x43810040 0x40>;
+			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x43810000 0x1000>;
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
-			reg = <0x43820080 0x1000>, <0x43820040 0x40>;
+			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x43820000 0x1000>;
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
-			reg = <0x43830080 0x1000>, <0x43830040 0x40>;
+			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x43830000 0x1000>;
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
-			reg = <0x47400080 0x1000>, <0x47400040 0x40>;
+			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
+			reg = <0x47400000 0x1000>;
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

