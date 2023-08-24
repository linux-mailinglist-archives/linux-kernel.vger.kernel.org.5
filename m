Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2178787644
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242838AbjHXQ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242959AbjHXQ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:59:03 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2064.outbound.protection.outlook.com [40.107.249.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143E919B5;
        Thu, 24 Aug 2023 09:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kr/xIfv37WwIWCQbZqroZmnx+sLuMyGHdgu1QkguevGYaeSTQX41KGqLZkitGcV46S7kxnE4FSvm3qvqJ+NfMFl1N1nYjdEMXjaHoRL9cUpVPyhi11t6ZjZvH3NTagEMc9d7532o/vaHgtCCwAZtORqtUslVwsuVXeuYJ7z4525sp9ussczKAyjDEJDvZp2S/I6d0gnjsooSTe++Xqns9v6R/EvPJV+QsBYlqojQXS2NTpI+sAlCAdyC9Ca+mK/W/OXFGi7aDQY+e0Oa4M0pQGwJ9Zy6smgn4LcEnKTmkI+8B9Mi9JLk7LhzB3BLNZ9gDL7GIWajPY35q0WELkFupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4FByOFObcStR2+8a6wERAZC3kuBjY6MvpiZfH9+oKg=;
 b=VUZRXAJZXWbGLYJuZgtfdufY6qwAUgaeYpOHZ61Z9V1izRnjjhe8BYjALv+Uetd6OK47A4y4D5DMgq94PEbjsa1gxz7kh7T+mjWxmjNWkXRXYev/caehPvnosC9mrTIxtZlMQYMlcgDYM0LjtUxdR+23VKMLOFPpMvvwtE11k4t8eBqYSNz7c9B3Fh2o56mA//rGw+ildqlufYWbCBbkvDjeUbCx52KVznon3zC8G60n3txZoXZ/xiFE4aiR5hjUTptZdHvpUAILzDG6CuaLlE3Rz0z/s/lg77mHHY5HfSsVOWM45s+0HbtIW/E1EFkkMHT2LWQrjskJR07A1CTIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4FByOFObcStR2+8a6wERAZC3kuBjY6MvpiZfH9+oKg=;
 b=fw9Cmi5qVvYOdnz/PKMZ1tArUeKPH9pLFnZPiInu21TwODK7B/pRHrloeRqG52v8NHgv0DCucF9s3SE76ETt/qxARchuCvL4PylpSYqOUC6GxDlRYcriFn4USPB/m5gW/3+WttXS2etjDZP7HglUalbMvrmaM8goORjRHvhmgIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:58:32 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:58:32 +0000
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
Subject: [PATCH v3 2/3] arm64: dts: imx93: add dma support for lpuart[1..8]
Date:   Thu, 24 Aug 2023 12:57:52 -0400
Message-Id: <20230824165753.2953431-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824165753.2953431-1-Frank.Li@nxp.com>
References: <20230824165753.2953431-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b138de-4d9e-4fb1-f5c6-08dba4c35922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUt7SGsLEfPZSAssecbIWFGfgLbfoc8i/8ekst3MK4YVg1RLTBgDbKbfC8XSn+NdV7BNpeLbbQiqXoRAF8WH8+/Q2GyWBznu9FrpMdy2a6WI1PHi5ebMi4v7uxWyCcyLgNjEiWqyjQ6XQmPFYHdyGtW4F+BdVew1zanMAH1FdRy7B2mihZGzYODb1Q92nqM1CZmZoXkLPfYkIIWhxHINvku2i5Kg8/qroUXvU/UfoXiao8P5VpFgiOdh5DuEdmpE4jir7lpcwLsUWKqgmQNRu3Xasvo/Vc/cY0kAAbs4ugh0HeZrkw0wcL+ITeLKhjOEwx9XGY6sRNWBNd1SSvvccgYfkgzQri0aLI/38Qp3HCGuJsMZSgNKYu52bc6O9gCCIa1Sa/iuhWQKHhfYIC4p8udx4dWOzr4wrAx/jTiKbzTSEqxFdrYNCFAoMiiVpn7zybNiqf69j5rbb0yzC3At3HScRCYqVWeX5t174Tre6XpSWQjRhLnIjeqPxYDKqkO4yLnIZKw0tDKFZ95DOfS2CWnbm/Va72KaFQUXoqRrRg2uJIR3sNs49qLLujYbuHeecx5ZuX7g4QEQs1FipzK0Ych5dmPPJbJyQANnVmv/HWlcIzDTkN0LbUoLdO9xxczFVB0FASGy67stUF1k0sbbWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(83380400001)(7416002)(26005)(38350700002)(6666004)(38100700002)(66556008)(66946007)(66476007)(6916009)(316002)(478600001)(41300700001)(6512007)(6506007)(2906002)(86362001)(52116002)(6486002)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qcjnPUBlviQ5sG86hiXuIWHgIAg0qeMbOR5IjEFqmCPIlfXPwnXpaqiYyx7M?=
 =?us-ascii?Q?5P5o5OC5/3f+gD8//OnED2WYtseT8Ue/MTWLMdWeIe/gnSH5f2XFoAfKnsup?=
 =?us-ascii?Q?xKHqb6gzLRQSbLfIiG6BuKa5OK6TVPBe2+ZbIJN8C9jnixuG7LmvglxRtQmj?=
 =?us-ascii?Q?+5U3qO4Ea68CdTOsfphsTdRilmXGteVw7Iu12vslqkiZQxr69GmImzwlllEG?=
 =?us-ascii?Q?FSFgWsswwZp+nQqZ4HHfOl6qnX5jTZKIwcx35V4H8WXcsv7OFdo1H+DLdwnN?=
 =?us-ascii?Q?Jw73yg3clqohLux5aBmTC76jfYx2iTXNQNvB7hKC3biO/NTtbClF8FT0zHN8?=
 =?us-ascii?Q?lzUmE04Y8tEuIfbImkM4pX2Kbf8CBfS93b/tdEoG8Kfcz27NcKJvJAGwMIhi?=
 =?us-ascii?Q?DaujjrL7OuRjhhz/UwQoHvTpFThbXsmWy6RciS77BmQFbsYF74zgoVTePzLr?=
 =?us-ascii?Q?h3yUqiY68RAdyBM/H/F13wEYpg8NBFIn90B1GEC2d5nyvq7sYIPA4xtXQ4BU?=
 =?us-ascii?Q?ZUKIsZjsYzkj9w9AAi0OJfr2832ANRZxvoiiiwjEcdMcNaDyQ6U7R3hToDgq?=
 =?us-ascii?Q?xLxAPB1B3HWQ6Irx5xNVfjzge2EAjTKq1qI745/I5wnf9/Lfehd3R+4FYzIa?=
 =?us-ascii?Q?2fDQGtzIXZwfnOshfy1R8uny8iIb+Z3PvgPwmyg1O3ZmtYAwufvE1AL+TgfE?=
 =?us-ascii?Q?2DGGYmScRDxKM55rE1G61zsUZKJV4o+kbC0WBEFW766QZyD2zBgZoTt0DSKS?=
 =?us-ascii?Q?Q6XQ79791HH9goWZpTOoXJznUu+S2E0PsHQJ9M3sAZR8j+TT4zgqniwRBnB+?=
 =?us-ascii?Q?gGVl6QqHq4wUxxZ/7p9G86KfM9w8aZtS8r+WzAnXzPkZB/LiqeeoAcA+FVC3?=
 =?us-ascii?Q?gxG1T9bckj4h6DCsOPKFIYCVQDbkBKmXRZWseV6bHsRm3O8ouhoBLh1kINI6?=
 =?us-ascii?Q?lFL4QGs+zDcyyI86/0A4G/DBBivIS+0hC0B4AdAqlIsmEL5vFx8xsbYJ9mD1?=
 =?us-ascii?Q?fHdRqwd8mW8kDRz2HTkMGAaszylbdF6/iIaTNjYcY1sGcq7d6zGBVRpG8yyU?=
 =?us-ascii?Q?MrB9WVHLjuZKVSvzFQFXSNmloLBMM4cDzVkdd/eTg4PrQadlGm8tjKPrfRY7?=
 =?us-ascii?Q?YHKOEvyub94KGwODtgHr1TarIkBcS7O/ZV/HbGImCccXNjLbcganclUJkpDx?=
 =?us-ascii?Q?ACJAFfAz7liOdP67yl+lp3+iy3QulZoX0z3Ziomum6YOqP/2/2O20MrwidAi?=
 =?us-ascii?Q?T4mM46BC7xkHEuTi3OKPvg/i+YKwHGK3My2gbnlQFbj2zTbZpoDx0NChgoEV?=
 =?us-ascii?Q?pa0ITudFOJjpY8j17AhccJH+VR/6K6WyPcN6I0hkUTGS6fH886SnQQ4nCyUH?=
 =?us-ascii?Q?T4Bj8K6piAX0ehWNjiizmmfnoFbYD0c0hC/TaqYdxm0OwrijxZ2k1r/ZkUtx?=
 =?us-ascii?Q?wGAKbfPEU6r5CCl3KCxpPeW5fnqLI9lX/xgnkVU+giuRKX3eD7bl8C/TMl9p?=
 =?us-ascii?Q?ojhKPTjig62QI6VbebdMFHDCIbDwvYK5YDfheWKtgdxjl9y3c7qNR+ADNiqq?=
 =?us-ascii?Q?ja6pOid4fTo3HmiI3ug=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b138de-4d9e-4fb1-f5c6-08dba4c35922
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:58:32.5905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LktwSUIUKPTJtvtk1nTMHu4cwRgLbSv7pggqdgT1i0aGZCDUreq2DqRe4DhCuLIAb3q4w7z/H+IpeRBn5vSHvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8582
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
index 22f09203c767..fc1f20f3e86e 100644
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
 
@@ -664,6 +668,8 @@ lpuart3: serial@42570000 {
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 17 0 0>, <&edma2 18 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -673,6 +679,8 @@ lpuart4: serial@42580000 {
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 19 0 0>, <&edma2 20 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -682,6 +690,8 @@ lpuart5: serial@42590000 {
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 21 0 0>, <&edma2 22 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -691,6 +701,8 @@ lpuart6: serial@425a0000 {
 				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 23 0 0>, <&edma2 24 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -729,6 +741,8 @@ lpuart7: serial@42690000 {
 				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 87 0 0>, <&edma2 88 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -738,6 +752,8 @@ lpuart8: serial@426a0000 {
 				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
 				clock-names = "ipg";
+				dmas = <&edma2 89 0 0>, <&edma2 90 0 1>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
-- 
2.34.1

