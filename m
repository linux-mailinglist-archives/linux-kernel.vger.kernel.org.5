Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B688E7A4443
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbjIRINq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240853AbjIRINd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:13:33 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8873E5E;
        Mon, 18 Sep 2023 01:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+sIGLgiUvOf6lXvD1klkEFSZSGZWLLnsW6A4bgVGUVid3XlvzRCo/2q/opCcOEADtIW3qU1jaGV3wu0CDLFeusTjUFkzhIuZ2jvwVSFSrF/TmcqVGug9sigAKdcjkz6eSYg71h3ki03ZBCsUXypq/gWsnqGQqEeZKy2dWltoE+E9eYzwcmIC3PI0m86MQOp9BnC/SMLh6tkxwL9Puim9CprXg+nzaCvYg2OpM8o1ncDPGxObfiBcH0uOL9BrrsF8WYM0sVw4oxWQ/eypv0Yrv2Z0p9uIdGPpukXgv8fw7ymdoCWuwcpxv3DRBh1uFR7uzabnJjwwLFeYW+IXi+FSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXr59Rq1uZ2nUwvwHArttqzzJnZcwdqlcA6cGqrl3Gc=;
 b=h4kuSp/DYRgbktDgQssRVSqy4LRnvEQuQ04FXddK/Q+pOLWLyQc9m3Mk471G2k6knudldRJgqyTweXJy/vBadGzff8vYZJnkyPs3jUiH+fMmMPru77FXjlbL84ZZf7RxDa7F3vslwnRMjl/sfZRKTOGJqx6i9JVnbl8Ci7V5yb6QhgsNjLnRKNbkP2BfqKFsKrI2WeYMitTRDyEoBf4hCnSz/4YcIBvSRXzAYYdDdvMwQZZ5kzDDU98ES8nBrw+gcrMqE/JjRmYDBv6dlK7QhZPdy6ZbPlW8asjl8W/0M8TKrQWVwkaSuH+x3x/4egLOFYR7vrdiOIKHD9YWKhuc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXr59Rq1uZ2nUwvwHArttqzzJnZcwdqlcA6cGqrl3Gc=;
 b=SEALeswHOGf7VODNsjoMu8Q7G3Eam+m1cnkEl8dJ8iX0Si09MtnhHvOK3BWW7g+83VhZwQHLkpqChVL2RDR44QYb4cQgpSLZ0TJftg9PCGJZHpe/fHYElREhdKivHZ5xbaGvVtwTIhYlJhz1UfUQRMO1wZT3Es9LP+JK7KU2jRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 08:12:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:12:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Mon, 18 Sep 2023 16:16:10 +0800
Subject: [PATCH v3 6/6] arm64: dts: imx93: update gpio node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-vf610-gpio-v3-6-ada82a17adc5@nxp.com>
References: <20230918-vf610-gpio-v3-0-ada82a17adc5@nxp.com>
In-Reply-To: <20230918-vf610-gpio-v3-0-ada82a17adc5@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695024993; l=3170;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=SIdbIE7CpI/4V5dWp7tqZZ3kaf6GR+H5NOQPt9VJs8U=;
 b=IFUmTB0AUy+P68uU/qaQmDGqmC0OokDREeLYUmABw83EwgzWa5Wrvxozu6dhNEDGzFuVB0CVw
 bRNvR2P3GELDOYK/BD702ZAQmZrQFlpKRQP7ld+YOFx8jRtyk0lfRsp
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 7960fcfc-8574-4b91-dcf0-08dbb81ef737
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYGNhG6OrjMJMxCJvlS0F9XmlFpI/TFQSOttu3c04BNtWBdI211p85pyVQINU4E+oVnWJR2Yf071Ojv9Z2cC9d2uxsrcgjY3H+kZevFVRsj8skTW7HL6Ly+CNZwpPCz6KLImXYIOnsK5TyBS1iEa3sylJ2KI8LMo9buWRBEmV6VJjlK8a/CNCK1H4+v1SYXJpao6z98zoa3WtBtO99SYuM/HM/x8DI/EiI8CUlnMNXHL6N5LKY1xTnzqpRRph8Y1F5xBSgXs8zdlsheUeFfWpIKhiwvr4oOrHDPxql5ODnC/rb+4Insu0DIaojIjljownepwHFH+dCHvURGbyNHAum7bD8ld7GSBE0ttgEabTtJaW3vr+gK3BoKGL+b0zTP+F/SeY/WMcNw0X0C8TqPE9a4hhMPUCOe97q2GkWWCGcrvp2haTSFbEwrHJ/SZTxyabdX6jVmoMAOGXfbBhq1LzjQ2RryxUdhTn9DPs6HnIke4aqJ/z3aBdPoi/mgSseOUynIOlC9NJrYdGtZ8zXC+DETt+QkAs+K/EVB8j1vGFLkIaudMx3Cg+gOreSvD+5Om2CkbnL65vMT2cYUahWduchdbcCEt/u2dL0Nynep4EaxhqbbAs+Itm281UrZ1soz5fYGqsTpKvmHqGPyZT6877w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199024)(1800799009)(186009)(6666004)(6506007)(6486002)(52116002)(38350700002)(86362001)(38100700002)(36756003)(921005)(26005)(2906002)(6512007)(9686003)(83380400001)(478600001)(5660300002)(4326008)(316002)(110136005)(8676002)(8936002)(41300700001)(7416002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnhYenVGQjRnNFNzOWgwRWlXWGRqL0dpVjIxaDRUMDlVS08vdHJrQVBiRFdU?=
 =?utf-8?B?VFI4YW04Y2x6RXpIUmx0S1A4OGNKUnBJbGF5MXkxbzJOWmJyTEhBcDhsL1BY?=
 =?utf-8?B?K0h1YzdBdGViMkxpaDM4a00vaVNwcDZrS0JhNnBnbitWOUM5b1BxRTJCdWZa?=
 =?utf-8?B?U2FHYTkvWDIwczdQR0xYZlY2ODQ1ZXJGa3JXc04yUEJqa2ZKTTg0TTZLSVQx?=
 =?utf-8?B?ZmVrRW8xUDkzWlRnYTQvYlVIanBmMEcxaE5CaDRXQWRRenFkTWVucGZObnJS?=
 =?utf-8?B?K2JVTFhlVXBGYUpqMmdOWHlPVWExUEdxRXN4KzdJbmZTR2ZXV0ZMdi96TVVk?=
 =?utf-8?B?RXZxRlpFQjN4K1B2UlF1c0NIQ3ZlN2djTzZ4OXFQTWhDdHpRRlJsamZKdjV1?=
 =?utf-8?B?MFBuR2lzTnNUNEZvcWdwaFVVekhCdHU3NTFpS04yNnhlNnh3a3FxcUxtZ0hC?=
 =?utf-8?B?SGZSRFdnMW5ENHMreTVXOWFGdlB3bTBVTmd4VlVjcWNwM0JWN1pNL0RNZUxo?=
 =?utf-8?B?Z2p4NjV4eVZaZzAzNjZDR3MxWGpiV3l0MlNxMElNZ2pDanBrTFRiU0NDVkhH?=
 =?utf-8?B?NFA1LzR1VHQ3TnlCZE5DWjRiWEVNNVA3SWNrdnNrYllGcktDcHl4ZEpyNm91?=
 =?utf-8?B?OSsyS3pxWlZyU2xoMEZsS0hab1FLNmxoUGpCQUlRUWUreVdtQURLWENGR1Mw?=
 =?utf-8?B?S1hLQUx0Q0VQOXorVVQ5Qmhvb09aVjRYUDJqUnBzK004QWg3RnFpSFloVTF0?=
 =?utf-8?B?aXY2N1ZUOXZEMXlJV2N4eTJ5UlB1KzFJeUtyb0t2V0VoRStsVFlmWVlxMlZL?=
 =?utf-8?B?elN0ZW1YeHV5SG1JTk9sTk9ETmpKU1VDUXdpMmtxMll5amYxaWJxVGRQelk4?=
 =?utf-8?B?VlZOQTdFMXV6ZEJObGNGbXRBOXRUbkJGbnlCcllpb2NkUk9HSUg1NVRzUVd5?=
 =?utf-8?B?T2lQZW5RczRiSnFVQnY0ZkxVWEN1T0dZZEhTamtSOFBpNmZQNXpyUHNoYkFv?=
 =?utf-8?B?QjVpZm1zQ3dzL3RjWlBNOGNYRXpIeU9JWGZXbVpvY2Z2QS80SlhjSkdLVFRa?=
 =?utf-8?B?M24zblVCNFlZMWJ2R1I2bUZLSTk5RXVCVnl6ZUlFQ3FWYW1YSlBRY0VNbG13?=
 =?utf-8?B?enoyLzFoUkFSM2dEOTVwTzRpbkVJRFpxQkcvVTBtUzJLNkpTQzRQUWZBcFFt?=
 =?utf-8?B?ZERLYktNbmdBdlFVRGR2Y2I0OC9ydnk1RjJVUEFNNkhHbUFwMUhjTFY2dmpU?=
 =?utf-8?B?bEhCSklXMllKZnNpaHNmOEJzMm00Qzluc015Ti9PK3liNENzS3VzaTY3cGxt?=
 =?utf-8?B?bmlTZVFlYVdzMjVtaG11V1NrRkMxbjZ2cFNmWHpvTm1IbE5lNzJ5eGRqTjl1?=
 =?utf-8?B?M1lDbHRibVV3TjJZV1BLVjl6Nmp1b3NOeHB6blpPbHBUU1BqMFdUd0MxYUpx?=
 =?utf-8?B?cTBwMCt3UzYxOFM2dkhKT0phYzZkQmRQRmNpc01MT2dHVW1TOHVjbllxVk82?=
 =?utf-8?B?dFlpSVFVaDhjNyt4eS9Kd1FrbWh4NEQzRTVwVXByMEdIT0FZVnlRN01BbDhm?=
 =?utf-8?B?S2lmTTgxM3p1VmFnMUx2cE5heWY3NytUSXdJNVBSTEk1akVtMGZxUzNVNzJS?=
 =?utf-8?B?YVhNZkhURnRPVXFnOVAxTEk3aVN2aXlmUnM2TUZqbmpWOVJKaGtMZ2ZlQkJj?=
 =?utf-8?B?T2c1cXlKMEdsTVV3dmN3M1dXdnlaQzI2U1hwUlphVUorNU9UaVFDMWRhRWtU?=
 =?utf-8?B?YzZLRXlTb0R6WXRRdE9QZXBGU24rWjY5OHNEa2FtRGhpRndsU2lwNmNwK3lT?=
 =?utf-8?B?TVpzaHV0WGJIL2RVUGRFb1l2bTFYdm5GdHRvUlF0dWNBK1k3KzJKSWNoekRU?=
 =?utf-8?B?KzNrN0VwOE9rdlVnVTlqcnljRFVEYU1JUTQ2aTBwOGpWamMwNGFWTERCa0Fl?=
 =?utf-8?B?bXRBZXZLYWRpYUpmeFpEcERQbGExR2czU1hScVMwN0h2dlJ3bDV6cmFTUEwv?=
 =?utf-8?B?cFI5Umh0R2NQaVkzTmk3dUFDQXhodDZnZ3gwVDN0Y1ZTVFRxcVFzakZFQUxa?=
 =?utf-8?B?RUZvcS9yV0hIT3o2eU53Z0lKQjgwT09EY3lFRGJERlp3QXlpS3lIK05QK3gv?=
 =?utf-8?Q?t4SBYgOiux1BXAnZ5JiodmrLK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7960fcfc-8574-4b91-dcf0-08dbb81ef737
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:12:14.0501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guuDI4aT82dU3Ai1bXQ87SKTMIuE2jw34rhUbhcqgQukS4nMW0VIYc92zDQs8GhDShUAKNhcCt5t343DeM4wjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7104
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

