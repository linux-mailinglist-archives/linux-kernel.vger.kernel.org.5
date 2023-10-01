Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77DB7B4641
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbjJAIYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjJAIYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:24:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F6F83;
        Sun,  1 Oct 2023 01:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkDW6C49i8ZrrCbHLRa1agjHboh9rHkup3Z69/fCqCo/jozVRDtbbzEpiU+xDxemzm0G0nWGphu+ASBQO1pfV5N0PMhD06ApMtAxvyatHJZ5Mmxsk6wEpjA5cUDe6lUdIi8qSFzDnEY9DEbfcifqIIQY4kH97M0s7e+mZWxG1llyFji912r8ddF/KxTJNMWD07WX6PieETwot0jaEFAAtdoykq5GgqC0ZS/wkv7EkS43hxCpR2+vnGt4GlZqIhLk+qABkunJ0WuIdxiyNuxGoXYHpJ3aSiWCBFTdFTGYu32Es0fE4AiWLEEaf9DuDNSVPSxDd5ytFhxN/RozepkH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXr59Rq1uZ2nUwvwHArttqzzJnZcwdqlcA6cGqrl3Gc=;
 b=dyUnPg62ek/7uQZLU9duoOpYftBpAjC8ajwm/hw+Jr7KGMALxI/wuArc8WdByelK1GFJ91bvnB86Wgfd+Jw3x8DgST8hFXbMaVrGL83xW85kIqgL0YxOusSMke7aeBAa8dkZcHti8MGdAO10Kri4AATpZoViOJS4QZFNCcoYEBnwzmB8g0n8U/0dhMBaLPFIf7prqc2YGvRBD1e44rDjOFWJMcrLa+zsL4Hj3QJZkoSx59OFKz8nifJawQRCwi+xmpEhj7BMlapng4V//cDk+YpGlslWZKLPxm5948YeFcbiOQUUeJa6KJbW/u1zpGZO6RZNPyD7mUKojGDkizUJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXr59Rq1uZ2nUwvwHArttqzzJnZcwdqlcA6cGqrl3Gc=;
 b=dyOap+v+VLw+HA4R7HUoYtT0udFxfCKLVTPZf9RjoeCb7uaMbvpunr1sfqH9wj82+Z4oNdSIpgXEuuKVhHqm+UcFSwBPhOFU2m/obrkeCzxQjZbQjRn0SMl7EN8W6TLhQb2i+/g8i54r6i10LNVFFtosyu1GQVFXXbIeXk9mQvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9518.eurprd04.prod.outlook.com (2603:10a6:102:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Sun, 1 Oct
 2023 08:23:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 08:23:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sun, 01 Oct 2023 16:27:58 +0800
Subject: [PATCH v5 7/7] arm64: dts: imx93: update gpio node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-vf610-gpio-v5-7-8d873a8f224a@nxp.com>
References: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
In-Reply-To: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696148883; l=3170;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=SIdbIE7CpI/4V5dWp7tqZZ3kaf6GR+H5NOQPt9VJs8U=;
 b=sw0eRM102oJX7aMzGWC4D81n4Q1BozEFDpHuSOvwyVPnBvUMICCODZWfzMbLpK7cssQ/IWtnG
 bcbaVBHqgnFCY3tw6qDq3sz2oqX00wJ7OX0UzuvRuooNFI2KI1l/ByI
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9518:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e5f2d2-435d-4082-0e26-08dbc257bff2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7t17DrZCwTsv4ds1X59MG1mb2Z3e1YqhBnDMi5TFavQt+XkaUN3vEfKeI5LJ5f1Fx/q3NjGIT7g5TNnNxPI37r5SePOln9Kk7qRkmlhBpQnJg/YZwGa/jHQ3EK1jo3Q9ALwLCvVwJ8ZhkBfhkDPOeT+IOC6X9ZIx2vEN8eQQwx6UfiTiv/HyqQKN5U2CGiomTl6aObwhDisht8v/Ogq37S3MeFTI3lc1Z79mqbnjaNfSXoyw2FjtebEdytNar26bJKwbuzZ83TWUNOdmWyUwQz4Yl0he59PEdywsgwvEiLWxE76G+bDPOMybGz/hkqrW4EYC48N7m3/+qKDlJfoREzLY3gQ5E4gYNZWIEwKuBoggk9eJF1r6T0m40WuGdqphAAraB7UiJ9fc0a4kahZccKjwS+q4ZByEcg4WP2EwfXYRWYehKNe7tKOD85N5tgjj0cI8MUDJWVnzUeBwYQR+klL5V4UbPY50ru4E4zmBp3CjfPCrIgrXyW6cbsiVuXsepS6zClDOvFKK/oEehMwYr5HzbSASfAj3xeyfv5d5LC2Wa32TQx1MpFyb3Kga+LiGudExryM2n0e7Vc36lR78rcPxJm5V4qF6QW56wP6f49l+zlTIcRiwDQpxVJTq9uaN1gqpuJeSBBYsQ3z9Owx0qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(9686003)(316002)(66476007)(66556008)(66946007)(8676002)(26005)(8936002)(41300700001)(36756003)(83380400001)(478600001)(6486002)(52116002)(6506007)(86362001)(6512007)(921005)(38100700002)(38350700002)(110136005)(2906002)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEhoaTl4NGRxWkhNY3I1N21xWCtpaDk5MnpoQWcybXNpKzluNUNPWGV3c1lo?=
 =?utf-8?B?aEhZQ2pxbnZ4VE96SFpJQThvV3RSTWpQZzlpRUNDcmhTcUs0K2xVSmFhRHUv?=
 =?utf-8?B?WDdtc3FIYUhJS3Q5ajVjUHhaMjBwN2plWHVWTG5TZG1vZ1NCUVpINUlTOExx?=
 =?utf-8?B?L2krTHdrYWtqUC85TnNKaGdQaGl6YU1CbmxNLy9zempKSWF6dmNKbDNFRGpq?=
 =?utf-8?B?TjlnU1JUamZDOXU5RDgxeE4wZUFLbEx6Zm5MeitTSnM3VHVPLzhIRkROYVM3?=
 =?utf-8?B?K2xPS2hYWEJoQlBnMkZ3cHhnaFNSbUtFSmF6YVIva2pZYlEyUlhxSXEzR2FU?=
 =?utf-8?B?OTJSMHV2YnRpYTNFN2FsaG83bzc0QmxHUkx1ak1QVWlMamw4MXhPZ2JCSWxv?=
 =?utf-8?B?NGJQczBnbnQzekdwalRFZUNCUWZwczlOcDNRRlBzWC82TUtoRHM1M244d0hR?=
 =?utf-8?B?Z25adFd5ZWE5U2VycGlncjJ2VktqN2ZzVzEzOEcrK0I4S3lDVzdvU2FxSXpk?=
 =?utf-8?B?emZEYmtqZXBWc1hTTlZjZG04RTh2T0VWMDc1QW5ocGg4RURnTFljb1l3UDdL?=
 =?utf-8?B?MmZsV0xWRWVLNnh0eC9rZFJBUVFzdXc1RWZWS0luRnlZbmxJSnpYY0R2S25k?=
 =?utf-8?B?a3cyMG9mK1RGSlp2Mk1PSURsTUh3bEhmSllQaFFKK2dDb3ArS2lCVUVvaFFh?=
 =?utf-8?B?LzdrU2FGMktleUFYdjc4dGQ4RXI1MmQwRmplKzkyTU9UVlUyZzNUR2d3c1BO?=
 =?utf-8?B?cStISTZSV1VGOGNvdlB0RXQ1UzVRdU9CVVR0dkpNb2wrSGIzc2dnZmlpcTR4?=
 =?utf-8?B?WjFFaHBTWDhuTGRMVVhtSUFPUHNoME5MeHFPMVR5TjB4d3ZyK1ZJSnlkRnJW?=
 =?utf-8?B?YmM1b2w1SUFURXBqaFg1ZnVEM3FCQ3poZXg0ODhqKythLzRnbUx1YTVuaGVj?=
 =?utf-8?B?RlFoc0kxVXh4b1VOSGhtR0tLVmhMVlV1YU9lendlYnNoVXllN0tZTW1CR1VX?=
 =?utf-8?B?ODY2dnBoZkNKandSL3VvdEdzMmN0MDF0Mk92RDVvU1c5Qm1OdnEvUkZmNCs0?=
 =?utf-8?B?WVZ3U201RHh1TjhMU2pIZkhNNFdMck41dUJ4anp6RHM2aVFZaGJPNFUyaW5k?=
 =?utf-8?B?dkNhekdMR2dNY1lWbGFEM1Fya0UreGhzQUxZOWx6WUxaWVd3ZStiMVFYZy82?=
 =?utf-8?B?Q21UL3dRNHViSEpZajQ4QlZGbisyc0czRkxGRHBOV2dDMjRINitnblNTbitj?=
 =?utf-8?B?WUx6ZnhqUDZOcU1lbjk2bExaS0NXQ2RPUHFPU2JVVktNTnBCRnZwbW1MRk0z?=
 =?utf-8?B?bnl2RHJSWlB3Rm4yZVprRDB3NWNGOGgrV3VkTU05VXM3UisxZXcrbEFaVXpQ?=
 =?utf-8?B?VE1lUHZndDNhQ0JOYlZWQUxyTXBzY05uUlVOVVdSUFRqbTBvWUl3Ymcyd3g0?=
 =?utf-8?B?MnEweUhXaWJIcmIvU0gya1VScWo4TC9LWEZnZE03RUV5L0NIbW5qVWlqVGxJ?=
 =?utf-8?B?Z1pjYTRnZ05MSDFwaG4vTTl6UGZnMVRybVpQeDJoYTF6OG4wNFUxemkwNmUw?=
 =?utf-8?B?ZWMwcHpIcUNKNlB6Zi92Z3AvQ1BSQW5hR1JnQnF6S1V5bjkxQVVodXFTa1Zv?=
 =?utf-8?B?YlpIaUI1ei9KSXdpaC94RWZQbW9oSmM4cE9HN1NkT1d2ZHFoMFhVbFM4VkZU?=
 =?utf-8?B?Qi92eDFIVFpEYmR2SFRXQmlOQ2F5Y092WnMyTDVSL1AxUUhzQ3ZpWGFpS29n?=
 =?utf-8?B?dHFEcW9zbW1lMXZqK1N4bDBNVGJIQ1g1eS9HL3BRSUhEVTUvdlpJZEkxSWls?=
 =?utf-8?B?MGUvZDJ2ZUJQeGx0NmUvMDh0WGxTRXNEMmI5T2JnQjlTV2pNdWZWSXNnQ0RX?=
 =?utf-8?B?cmZ3U1pvTW9LQXd0RFVBbjJhNlcvTGh5OHF2Sk5NRWV5M2hOMDN6bG5xQVNa?=
 =?utf-8?B?ZHJ3RnJWamlSb3hSVWlSTlpiWk84TXdlWUFSWjNJdmxpejRWdURWNktXenpq?=
 =?utf-8?B?UXJtMFhOUkFYV2hWenVrd3p1Slgvek5SVXZpbzg3SkM0MVVBL3ZEWlZhWldq?=
 =?utf-8?B?MzZLdWUxVkIzK0NJQUpNUTRBVnVMTWRkNGdubm9BZ1hLeWdSVFpHTDhkai90?=
 =?utf-8?Q?OJlAC5cgnBEM7bl9vpGpNgkBk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e5f2d2-435d-4082-0e26-08dbc257bff2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:23:54.2625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0Cu1wCUn2F0bomj4uqeiHQrG5pfVYOYxFp+mdcdBNVL3a6q0lPKEkbXsYBpo4Du96GXa60Z4YpLSbB5RuLcqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9518
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per binding doc, i.MX93 GPIO supports two interrupts and one register
base, compatible with i.MX8ULP. The current fsl,imx7ulp-gpio compatible
could work for i.MX93 in gpio-vf610.c driver, it is based on the base
address are splited into two with offset added in device tree node.

Now following hardware design, using one register base in device tree node.

This may break users who use compatible fsl,imx7ulp-gpio to enable
i.MX93 GPIO.

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

