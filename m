Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05877AE069
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjIYUt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjIYUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:49:57 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A15E11C;
        Mon, 25 Sep 2023 13:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnYkfEG86w8a+SsOTrdCwIM4eL67gIActHLDjKAprGl+pGYcI/TDp/n00kGPeQv2qDSQNYj4Dm4IqUggtftBqGAv8zFc4dv+lpnmGSgUyg3rMpEo7pGIe7rrb6Yx1idQoE/YXM3v0YMjsqpjeC7SEc6HNE72K9eM4pru+crVK5ylQV6MzGnuvSdRZ4LWfenTs1HRPGdlOibjr0AYTwhc0kQP6385lqiRnntAxc+5s+WY4Hu4GzWGGAqTt6ZbF7IZ1q3KBvj80Q0kLbJNciwY1/JeJIxpY8YD0XUY6gi8uBGq8eGzp4iUAFG1QPBIjc7l3UNhzrxcGn989yC/806ImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DbFSI8cHeJchxMQZU0XXD3MSc8RBDv5nvNCCVIx3Yc=;
 b=lU4Smvdf0U/jMNQbfqBM46qdPn04h+i7KOOR7xiUKFc0tBcQZ5UWBgyzrzZQyPA3gHmOJEwdNoYhL64JMQhqGr19SxOtw1O7CDhs0mTa7u1G9xX7D6hTp1lNfAQlAMhmG77rxI4DDOImwxAEzr6aExc5CfplcovAurQinjFhqcAc3dTIK8kyu7gg21d1Bw1H4DMmuYN5ZL3mrulu3BTwi+s7iWr6vjiCUxCbDJdFvmmOOK6XV+v/1xjq1FFxQ19+UfESHZEHgksaWUgjqfB6FDUpw2TwAJfxOogeAmJg9S2/ozRdnHL4MoEYxItt5OcCdOM03Jo/uwoMj8MW7JqUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DbFSI8cHeJchxMQZU0XXD3MSc8RBDv5nvNCCVIx3Yc=;
 b=cqNAB4G+AXImHU5MM6j6H80o0AwDFgCtauj0UmUz/qcY04PesvuUsjgQb6byqtcYgfNjVm8N9hxcAQql8sn1moxeY7WiGxmD2Dz3JRf2hWvIo8RkZzUccVY/ksUk/YD2VzcJwrrKmA3GWOyYVRnxb+rRfrnd9xOkB3RmidPNmgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7809.eurprd04.prod.outlook.com (2603:10a6:20b:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 20:49:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 20:49:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, shawnguo@kernel.org
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shenwei.wang@nxp.com,
        sherry.sun@nxp.com
Subject: [PATCH v2 3/7] arm64: dts: imx8: add edma for uart[0..3]
Date:   Mon, 25 Sep 2023 16:49:09 -0400
Message-Id: <20230925204913.3776656-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925204913.3776656-1-Frank.Li@nxp.com>
References: <20230925204913.3776656-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::14) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: bd252ac4-e810-46e6-3fb5-08dbbe08f4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PifcHWdDpk/k6NlkrEfe546t1a/97SZbH7+elgUFDkh79MaF+OzgL8AKBfZ8ac+Pv0E7kqwjZ4G0VVNhRM+KfIO9lXLtte32L4KVEZ15y7YlGsHV8Hf9Z/GrIVnRA2R3hY7ba6nQUbR0m31WOS5IC6MSLaGHlfepzhNaaRLGD9XwEIlGY3wQ7Pfg8kVnYrNE2hbHqPEK5EQFC5fqLjTUKP//Q8gOeJ1u2fF7CUQ09Ulen4aTgwEMmOloPxlKdZA1x6di2Tp/peDul/Qvq6OKCpbkcuOBsuzp4QUq/xTmJyoOQaVaeiNq1gU+zmPSmzDO6g0Hd0XvqygJdbyltIXPFHUfyJvYuFap/7n5+PCXYCRpiXx/+3kh/8u7XNpuJwGf2e5HjpTqXtBtp+JS7wYyGh2cIrpHw1UoKduh3a1sdZ5m3TrVH5UdBpNpH8wXZjudx7A00hr1x0EHVMvzmasVxIi3zBMemO+1w1s2ZIK3xNwsxZEcc5UCwNwPSEQwNw+yzwiJKDqeBW6zGL92LETjPTm0J1zqlIsvJ/3MF+mypnaK3R/o4YdPTgUHbhclmF14GZ3GGcbKcz6gQADS1ELOdEp3w3oIlbK7br30fCjAyVwAif9C4YrBi60uvOW7r9cd/GuMGznL4e21r7F0/GoG/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(5660300002)(83380400001)(2906002)(316002)(41300700001)(8676002)(7416002)(8936002)(36756003)(4326008)(2616005)(86362001)(66476007)(66556008)(66946007)(1076003)(6486002)(52116002)(6512007)(6666004)(6506007)(26005)(38100700002)(38350700002)(478600001)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Q8yA44YTQXFM9e949JGZhCZ3sakcIWjnz7GdpIdd8Z40BqwymeRFBf1O/OM?=
 =?us-ascii?Q?YttPzC34mlHtFhWkvERDV2EHk7KfRZAXWKwN/+k7+fsCtzE3K/VajAXEPmG4?=
 =?us-ascii?Q?vzNUw+io1v715ckH/tleve5p9xpTuc1dNj7y1dLChebS4B4x4yZnks7wZqGu?=
 =?us-ascii?Q?PwL9PRDk+8DBc74+qkOsjWnzJSN3dH6P0WOitMorzfX0Mdsol49IUq/Ysq1J?=
 =?us-ascii?Q?o3kmmqmFLmKOADK11QvTF6+YpHrr0AXJ6biX9usHss7TDNv7LmYuBJ7aHYTR?=
 =?us-ascii?Q?gCiTXv6trHIgYBB4DIaI/KVls33S/eQ6J7Fxf//aaYlAsuI0ON+ly+IHxkkI?=
 =?us-ascii?Q?gUooslxB+ep3HGUqoyQhK02uX8wLDlxErPPZTIM/SStWEumt4HdNe2yCBM2Z?=
 =?us-ascii?Q?ryZFqZhXZWCVyXju68VsMhXK3zk6ChN2xYD2OX/Uct0C8QveuNnO+cbBa7WF?=
 =?us-ascii?Q?ADHEcd9gF3wNMGWioqP+f/JBoHpAsr13fQ5Y4h+LCi6U9RBwBrbY9nNZXbQX?=
 =?us-ascii?Q?q+T7YkP2l1B7U+Asr1OrAStFN+wSRaBOj5Lr4X/Wq79ZPrPkV+XnGCkIaykr?=
 =?us-ascii?Q?m0mv+TTeC1+XhVAnQNQfzkY26+MS5SAUYBcJO/TF+k0XUDv/S1coIwdvRiBP?=
 =?us-ascii?Q?TJw2WnfLONXmyynUwVokuJEYomuKX8zQfXiHQrBdLiKQIQdDAeazr3mfuz48?=
 =?us-ascii?Q?UlplKbPh5isMrOfJ/bDiABUcRCuko2onsEjHd++wLbQQbCBejzUgzMNzkcNv?=
 =?us-ascii?Q?w0Z+t29T0F8Oe79kjuU2QD1xyTZx2ZbwD/ca5TRG2KrO39sqXnVmLcPI31Bc?=
 =?us-ascii?Q?rbW3MdTw4tQEyisnYkgF94VnOudGmw9mgWyJM9kLf2QZ8EEL+vGcL8QTnhaA?=
 =?us-ascii?Q?i8BWyuScrZudzsUpk3ZcGOxlHKigUNN6IyMU2k/Z2rUq6WsEDvhG+o/+v3Xg?=
 =?us-ascii?Q?M/qUlxcUWCabxXb2YJ9GCS0NAFACYcsYfsyqyBInvV3BSrQKlC7CP9MzNlAr?=
 =?us-ascii?Q?Dx2F5v+NFU2/0/cAa06RUHOInel4GEslTFxeNg+LSWXpX/fv3rm51/c64seX?=
 =?us-ascii?Q?OJu7oKt3Klosk1FO2YCdyps6HS0VRLQwWxatLfvwT5e94zip24tGDEbJqZvU?=
 =?us-ascii?Q?YAptWUx8Bsa9ma4gKr7apppkjGjv5caLeTz/Zii6aFeGbpy8OEG83dAfJWKd?=
 =?us-ascii?Q?+0dEz90mPl/0uh8RP2PzHx5xMTjnDMgZML/HpFlqiOdxbjGFnrA+dNmo0bxn?=
 =?us-ascii?Q?9mxIcLvMBFQ+XrD87IEAr5XNZYyRYmwTQ5v8YobM5fwI2HwUG+jJx6iOOTaE?=
 =?us-ascii?Q?1JU9978z6nu07Fj0S1WMR2OE6kdKcIH1nJGK3/NrkhNbIkofkCjlfodce/KB?=
 =?us-ascii?Q?S1iyp0OCpETdUYblYYi24G+Q/QL1Z3V9ce0qUQjgwZxJtW+V17xL/lxvwSD+?=
 =?us-ascii?Q?WS9seQ0GT34qF9j/CHiM80+ns7Lwa8oYo6mN3J5Gl/PlbijRt3407MUe9pgI?=
 =?us-ascii?Q?hIU+yyPlw2LzCPAH028XPCxxOhyZTQ5p2K2J8HPavkuKPUocK9qBUf5+8bTE?=
 =?us-ascii?Q?mgSLq+Cv0XbRAgl9kWc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd252ac4-e810-46e6-3fb5-08dbbe08f4da
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:49:48.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUqDfY9utXfATDxrPqUises3QKHuDxuqJHF/mqtBTk2JBc0R4eGiFaVIxHP+iKJSqq9EykBtkj8XAmApZFCM/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma support uart[0..3].

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 0519edd3f520..8fd924dfb029 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -93,6 +93,8 @@ lpuart0: serial@5a060000 {
 		assigned-clocks = <&clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_0>;
+		dma-names = "tx","rx";
+		dmas = <&edma2 9 0 0>, <&edma2 8 0 1>;
 		status = "disabled";
 	};
 
@@ -105,6 +107,8 @@ lpuart1: serial@5a070000 {
 		assigned-clocks = <&clk IMX_SC_R_UART_1 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_1>;
+		dma-names = "tx","rx";
+		dmas = <&edma2 11 0 0>, <&edma2 10 0 1>;
 		status = "disabled";
 	};
 
@@ -117,6 +121,8 @@ lpuart2: serial@5a080000 {
 		assigned-clocks = <&clk IMX_SC_R_UART_2 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_2>;
+		dma-names = "tx","rx";
+		dmas = <&edma2 13 0 0>, <&edma2 12 0 1>;
 		status = "disabled";
 	};
 
@@ -129,6 +135,8 @@ lpuart3: serial@5a090000 {
 		assigned-clocks = <&clk IMX_SC_R_UART_3 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_3>;
+		dma-names = "tx","rx";
+		dmas = <&edma2 15 0 0>, <&edma2 14 0 1>;
 		status = "disabled";
 	};
 
-- 
2.34.1

