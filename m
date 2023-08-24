Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA37875A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbjHXQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242661AbjHXQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:40:02 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77E710FE;
        Thu, 24 Aug 2023 09:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibszZL1KVVSOY2KaZUq0PzLmXTLFDvWb6D9R/mQRjcn6RFNR3SFvfKmFU1Wy2xTEKV4hOFwv4fQkRDEsJxhb+7OqqgFvDNBAYozZTMJ7sqBj0tHMcZXhH0woqqmOgZ7Bm5Gi1V9ELLSzBfcHHUb+jyLf6ycSDLHCxdSF6+4nxxEQ43YNRpv71RhsO7K5WdLJbJTfRMkq6aHbwnPH+QMwoP9nesOVoxqBuN1dJuN9K4PsonWITh1abhd4J1mxL48JVCqXP9uNualegUjO7oIfGhWgh2saPm7B0Ue2kynUC8p1846jRGZBTqjdySRPNeU9ROEulfSTSa5M3shQ0/Bxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdEXWQ5Dzm9nHgXzwwC8rR4uE6ALrZmUHzIxl1xLQYM=;
 b=A1BqWJaj7lYznOj8E6ZLFXJm+E0l6MLIkP4GRBYp+zmL3+kySa5hCf3kV9+Ft7OZnzjsRp1BSxfw2jxy5uOyFxp4z55TOczxTgOdNfFBjkBKu6tbLUB2Qw4IsgfzA3dZK2oUvr0SLcNKesiu064EIu+qa+6MIoJzs8vlBz1ef2i+RbVw4jfJAE/6s9WvYytg/hqmsnWzchU5C8oRfnMU4x/8AdKNJmO7S3E/eAOadsRtd5qwNTRWcIRaKDeq/yNR2gjUQTaPMQY9GbzTXC7IfOuNPvO2lTEEVlMFvlqR2iAl7+VjlcvoIFyh3Ow6AdoiTHDuIIG1r2SXBD7YGGXC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdEXWQ5Dzm9nHgXzwwC8rR4uE6ALrZmUHzIxl1xLQYM=;
 b=kNkwLmcClvrzhwYJx95d+nsVLQ7BZ22yft7xGIaCXMyIs2gCPLvtDGB1r5n1EiqML3bo+DZ0sQ61JkJoRNJiIo7YfbH3akiFihr97NG1TWPfLS4jWq9ZRH7Ri8qqoCTP9EM11xo/0PTA6f3od7v02wmHpLjAruql1eMAk+XF+X0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:39:56 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:39:56 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     festevam@gmail.com
Cc:     Frank.Li@nxp.com, clin@suse.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, eagle.zhou@nxp.com,
        imx@lists.linux.dev, joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Subject: [PATCH v2 2/3] arm64: dts: imx93: add dma support for lpuart[1..8]
Date:   Thu, 24 Aug 2023 12:39:20 -0400
Message-Id: <20230824163922.2952403-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824163922.2952403-1-Frank.Li@nxp.com>
References: <20230824163922.2952403-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a89fb1-2723-4598-2031-08dba4c0bfca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXaLoMjdypGk9YfSKbmyV1L1HhGrkHHyAB3CsGfWFNVLCXv2pMgJoQlW6LxGEzQotwB12zf19Fyo5XK9uc0Rx6boGu6rDhbBHl89fn7yNZI/X43hvC7QZcaHQ8EvPl22iplLxjpu2g9rQAKb8lOqfNpI96LX+1RinN8xc3rBVUsR6+xaut4qXK9TgYwooHLn1rYj/e/rzHEPQTVHSHoCjRznMPhtTaf0nAG1XJbB4wE/6k3a6UU5VMLMWrIJsPCAB7h54YGJapav8KwQd0pgMqGZRLv9uwMYWD2hmhdPGlffxriT0O+kXSDsKDaZfQyrRU9hGQt0nRPUKvWIej9ZmgZeZsJk0iGB2WTrb4IRce1msEoLpeKX2hYKvwRxrJeZYQpJ4Kvui/D6MD7hNY06gWGlrkfbQ6wno1KFQ6FUxliWCJhS/I+w6/EM5LKfEXfsRpex+3QSl+f8hZ1SGvWHP5U3SDUxrwPSmZA2Hi7vq0IiIr1LgMCgZ42RmQvRzukkHB+EWHwWRaRwuOVnxmvU+NXo86C0Dya996a2rJnAIp7SBBr/TAWHyySaOF+JNwi8lvP2cxfn+PzVmR0Nq+k6207lRraY/4cE20qHY9t5PTYzMYEGhhoSf1jj0KpH5MtriaxiXBSnugu2keTtyB++RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(83380400001)(7416002)(26005)(38350700002)(6666004)(38100700002)(66556008)(66946007)(66476007)(6916009)(316002)(478600001)(41300700001)(6512007)(6506007)(2906002)(86362001)(52116002)(6486002)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oiu94pujvys2SK9dOAljUD5DPI1Q+Fn71BgVO4xejmJCS9jVeEG/Wp2sbO/d?=
 =?us-ascii?Q?Uwwk8wkuy9pqYx6beDQP6NQoOJMm0INr2Rpj6UJwvn0Kbri2ig0p0cPyIhDT?=
 =?us-ascii?Q?83cfiMTHhUI2IZQsSmNMD82pr+orv3TLgb+bCrn7RmMdQRIf7oVofFIeS+V4?=
 =?us-ascii?Q?2XBo6QkFaVpvpT5XbO5jwIc0PE0LahijiHAZn7rXWQINV+eRNSNpcLXs6YHX?=
 =?us-ascii?Q?+fFFZ/qFZNT8eSibLrCbpLFoKR86pARi0N4fxD0pzIxGZG6TWgomFIilg+i9?=
 =?us-ascii?Q?ykEwStRMP46RnSTV0kWRa7eNlSh6m6W2yOBWnrA/ssL5nrh6h8vl1vLmW+Ge?=
 =?us-ascii?Q?gsBd3PlsZjLlIB5JZhlUXhWWA7O6zF9yVsyNJQXUguBcRBM73AXnmOHtPNbd?=
 =?us-ascii?Q?Ya7drC1ANY/0YDfjE+uaS2XNePrzXdl3E+Y4XZcRM30oFi2P3A/v0tM5B7/M?=
 =?us-ascii?Q?nycz9AsaQ/aMsv+m3s+ixbQtsYGUg3+jwlNXeo4b0cLoELpprwdvNbLJmTse?=
 =?us-ascii?Q?eRThPkvB2XgWBdTdAuFeJkVzwpO3bHukdbdsq/b7KWD9J6WwJQpBa4YbEowo?=
 =?us-ascii?Q?7MpoA6OQrJuPIh8etW4LMkhb6NSLqEL+bH6zM4YmSHkj8qFtNt9cWYXZ7bdX?=
 =?us-ascii?Q?eMOuDzBNxP6G1xquOvzLXgqiolmsIHbw7CcGHOOfT0Ndfn7/3gUC3LHKBTEz?=
 =?us-ascii?Q?/ZGq6pR2S6mtIbvBd8/qoMUJlYKyvbDc4f4PzL1OfjsQubP79Tg/erWHASIz?=
 =?us-ascii?Q?c2rram3puHmN7xdP6D7UbLyi39/+ezcLTO2c/ihffGQzJ2vUp2+NBmuF5DB/?=
 =?us-ascii?Q?h5dhQwnZbP4dTv0omPib83E639QvC9+/R95ArBEVPnCyK4N0cHAbOxuCsJ7u?=
 =?us-ascii?Q?WVciOYiWxe0ep+xDXzOJBbzRWLPgCMnGYmygFHh/RrCI/OC6sxev47LJ1tP2?=
 =?us-ascii?Q?CGOu9w345mK4IF0jlDfnp/oRnF07cCR88BSddu9X88VlWsP/zahVm0Rz44Xx?=
 =?us-ascii?Q?4D4MyKjaLOD853yFHeXQ9lQVu+noUoem4PcEAp6bPstjs5EcBlw89dG39W+x?=
 =?us-ascii?Q?zDA7Q2xhssD2JL4xOKcJwcbQxqrYmQPeqHMRADWpYsVQDeHU/Hm4eGfBlEju?=
 =?us-ascii?Q?lvQsdmyt5uDmpRf4/k6f+Qkk9A/XpN2wTaCkIv+/96GVsnfBkk5R/W7sJel8?=
 =?us-ascii?Q?6CQdqwupu5O/kPH0hpn3/N69TMLn+JV6tz2I0s0lZT5NVYGGLHxuYY/Uqe0g?=
 =?us-ascii?Q?7SxIprhI2ElWf7f8bc0sNiJxsR3tijdAhHevEo32Iu1Ts2A2cYeU0RgBy0GG?=
 =?us-ascii?Q?1EfYtavKiws/OwJpU7hz04Z+dg1gJj23JLtzufAUYCCh0clK3T37VTo+9HfR?=
 =?us-ascii?Q?2qmCRfEazJPXiP1uZFWoF4R2uQ1T8J8uRnCHVnPl4buPZyvvrFl10st6VThv?=
 =?us-ascii?Q?zHpI5wwPawB8+vTyR42QOHsByussw0iZ6BOWhmYQeX4y+bs22nku5OD0vPu/?=
 =?us-ascii?Q?tj/eSOp/Jkx80zgr71VYvfSoh4rLQV/TZg0EEkRyw39MT8Ja6eEboWlYLRaI?=
 =?us-ascii?Q?7j7L/mLYkJpElQ6el5M+kqJo5vO5UISLdtRyFNGy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a89fb1-2723-4598-2031-08dba4c0bfca
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:39:56.3033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PO6GQpZTAy0nZPhshe80uucIMBy44870LBoe9jXo5qR/6ScEo2Jqp6f7kzLGoi0/Wa1uqorUFabUec9Zu9MWSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma support for lpuart[1..8].

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index acdca18673b7..849543d35ed7 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -336,6 +336,8 @@ lpuart1: serial@44380000 {
 				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART1_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma1 16 0 0>, <&edma1 17 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -345,6 +347,8 @@ lpuart2: serial@44390000 {
 				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma1 18 0 0>, <&edma1 19 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -666,6 +670,8 @@ lpuart3: serial@42570000 {
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 17 0 0>, <&edma2 18 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -675,6 +681,8 @@ lpuart4: serial@42580000 {
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 19 0 0>, <&edma2 20 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -684,6 +692,8 @@ lpuart5: serial@42590000 {
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 21 0 0>, <&edma2 22 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -693,6 +703,8 @@ lpuart6: serial@425a0000 {
 				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 23 0 0>, <&edma2 24 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -731,6 +743,8 @@ lpuart7: serial@42690000 {
 				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 87 0 0>, <&edma2 88 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
@@ -740,6 +754,8 @@ lpuart8: serial@426a0000 {
 				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 89 0 0>, <&edma2 90 0 1>;
+				dma-names = "tx","rx";
 				status = "disabled";
 			};
 
-- 
2.34.1

