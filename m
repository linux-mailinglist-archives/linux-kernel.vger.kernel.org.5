Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF5E7E9991
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjKMJ6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjKMJ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:58:13 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E24010E;
        Mon, 13 Nov 2023 01:58:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFioDkOChCLmgExHPpkiIn5scXnBo1zXFsErTvietutHC10tdTf5/r60UbB7R83v4fhJFBKzMs2SNWTpJK1VI9ugi4uvJkneZpte8p6N8j9b+wPj5EHB79jokkFcTeh2q/AuB6JYtoc1ZC3BcUNSz75exwwlPRWLZ/4oMXy74zozVw5W32CKsT7WdtKcpdMPkKaxzRaNQEW+xGgREabBAVT8CM+RoG87ZASgTJTu990Zs8ZGGydbaTpvVsqG/ktZUWkDFuZhhEOcZw/llFJmfaRxN3CtM7QUvWn0tv1UpfJxBA3AwtpuRDejcvOlhmQdTbPRO/Iwn3GJHBFUb75pzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKUIKxHQt/A0j6hIELfJ3x0CdVonSpswLmJhOXP9gwQ=;
 b=TOHay3M6tE+wBY8p5gConPSeBv7S2zWoLmVVdwSA+4+E16dGKBkw32i4ojuYmmfgXpy2L3BVmM89wMtry3npAh7/ZURf6/O7h3LZEGkamtlqZuzehp6+nsPvHRu3Lzk2XYBvbCRKxG/tj1LwpCvhazzOG7Fz5D2XA7L4+jhIaOWMczKR61euzUWskOZ3tikl6DSwWbfQoylEIleJpzR/JimD50VHi6+3pceoamDS/5DTRcR4yG+jJYnXqHCCUfTbWyiWAVjX7qy7+B+fQXk4IZPcjxKoYwG9pd+iwhixq9xgeTKsDI7hn4sjPX4ZfaW1DNvf54BwMc67/QeW0WqkdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKUIKxHQt/A0j6hIELfJ3x0CdVonSpswLmJhOXP9gwQ=;
 b=MjVK4qRFy78D1lF2e3moS0gNHER76zhwFcuLYfsIu2711v12DIkeYKuTbRbtxl7maL8imu0yaPjFUAQ4v7/3hFPosZJD5zYCExy8oDy9Bp4hHpO9eq+M9e3+L/NcWnpkSe/USk8nCAlbOEaATNRHNSMV5xzIU/20Hw4ELSamX+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM8PR04MB7441.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 09:58:06 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d99:f43f:65a3:9bf]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d99:f43f:65a3:9bf%6]) with mapi id 15.20.7002.015; Mon, 13 Nov 2023
 09:58:06 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        peng.fan@nxp.com, ping.bai@nxp.com
Subject: [PATCH] arm64: dts: imx93: correct mediamix power
Date:   Mon, 13 Nov 2023 18:02:29 +0800
Message-Id: <20231113100229.3885321-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AM8PR04MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ffdcd3-0699-44e9-f2eb-08dbe42f08bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzNVssG0yAsavQcbVhyAej4yoFMwL068hcP5edSwgzJdb2tmwCZ+QglOqH+6d0QMLtwXoUSTT9haWS8oKz1OaefyF3p5aP2Yf8ToncfzgxqbH1Pq7U7IaO2QqPcKB+i1GnxU5AupK2DcM5qx+HGNFzHwXJm7mgIJEl5WVvUvc7RzJ1uoW5fPfo+9WeDprqCHjCVwilhNX292Ntxd/GzrN7yhqIvgtkQ0JTx2OKgRwj68gqSoFQBpoj3K3X2U3Jq5HZkoFO7cKgK5dqIBLpMxveRjYVztXKCUlvzi1L2j2kudG++k0xTW2ZnSHnADjLU7UXfxKMr6Op4Km4rvytAllyIJ0x1xqw7V3Le0EvKxilCVMAS86BNHsTh0EEV9xY6hEvPV5tpBZYqgDRetD3fyu3PmpM4yEizirrBm7XKS1NrAax5sqRjgIFudaS1gEXB96r3JakwrIW82S45TyIsHEDqdmy6tExNmMg6VFGcgwM7wkiApYgbBNEXI5d+lx1p6ga2s1AfGLrJdnTPPcQ46uSvx8d2+MEjvA98ZridsNOeum29p7U6vfnGYchq7/lGSKHVIAY/RTPopN4Z/Kw45pfqIht1v7rsYpntpZjQVckY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(1076003)(38100700002)(83380400001)(86362001)(7416002)(5660300002)(2616005)(6512007)(6506007)(52116002)(38350700005)(478600001)(6666004)(6486002)(966005)(36756003)(66946007)(316002)(66476007)(66556008)(8676002)(4326008)(8936002)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GRXVYvMr2pu4eF9SKkh62w+XNQYqQWs59vyRl2kXuwz2IoEuDlYnxUy9pBRX?=
 =?us-ascii?Q?QeWGWMaIcm6aU6wcVweKTtBlTfNIWk/wrpwciWN/g2nZFldNyElSHnSi7Iq3?=
 =?us-ascii?Q?Q5FjpSOTqfQYP6AUD4re+sh1H9EfDa847KgKI9Hp0+yZfcypoTybQ+4ToheU?=
 =?us-ascii?Q?F8u8Ju/xuFK7WIQ/3DmVL6PUNGbGTnbTXuYnHoI/6FaUjWFVdTLYFSJxGhps?=
 =?us-ascii?Q?6sWth0GBBMyY9nSIN6d8qDYYDwUQ9v3/ZZs0U8r0rsu/S4V6Adb1PA5KzsQr?=
 =?us-ascii?Q?zru333rbSIwlB7609YUPGQsM5a5ukLYJMPir0xiz7DbyZX1OtDFyAAM5A7Bc?=
 =?us-ascii?Q?XPc6gBA/Qo+a/MJvmPvCpvnCpUe6CoI9Mim3cjrMtURMYmmGF9YsWDhQsNLZ?=
 =?us-ascii?Q?FxWfhhiV0M+dnhcQeH5rQ7sUVjS9Av45no9rUzgtYDJ1eUvI7tz544+lTaDF?=
 =?us-ascii?Q?aEF7/e6JKXqDoQekI5cb3eGoZGtYAN0QMz4rXlxTO1Vb/OLuj+AUG+Xj+7+j?=
 =?us-ascii?Q?Gc46ByBU53/tBgWHuja0yEkf4Zs+iyze4LM29zbGax8EJDFxpFkbo1eyOaer?=
 =?us-ascii?Q?JOqnBH4mEcA60ESagwACvyjrMQb0rDvduHCqLB7Il646Hf2pTqlTkLk9eWN6?=
 =?us-ascii?Q?A7VGVkH5V4NiCc4gQdKvZ4uX5W7P1ATw8S++c+EXsiluCF7fhaRtDTXix/H1?=
 =?us-ascii?Q?9hzvWO17LzOhPenXnzaBo9DyqDTU+YnT+wDaEKmhMG3swVYRfTuWRdLxndf/?=
 =?us-ascii?Q?dQsQlAc+Aw2y6Y07VmNnuTvNzroZ5kzSVyQdkqreahLbA1O3XaHaUwy/8/5k?=
 =?us-ascii?Q?nwSRiZREpyyD8J4lJ8TuYUOVU16kuSEhnh+qAdmdJ48MzP8TuiiN4jcsXJC+?=
 =?us-ascii?Q?7Da8cUSbIgREPNnYCpEK88U91fteSv6ZH4Loz2Hg8MEtAmU6oR5MrIXgSpOW?=
 =?us-ascii?Q?tKSWFwdumz7xcblCAkwanKOxzNujA6bnmVweFPSoDaz7OcVMlNHXPJWPvVXS?=
 =?us-ascii?Q?fgm0LXajEjp0+4C1yzGF57MtoyiV7Ei3WYKxbFDYTk8ubTN1yA7C0Cso0gPm?=
 =?us-ascii?Q?S9dt+JRndVDn0wA4ieyLiAa3hABrSa7uGUW0KDzOTnRUel8tYwrQNWXqvDaJ?=
 =?us-ascii?Q?2Bik7Qr3Kk2XVEQrCxuTObpS528ut/+MjPMOQ+vuseqFfJeeyrwtTJ8wcE9v?=
 =?us-ascii?Q?SfCNauAPUYCYedNxXXj+gpoWNPlcz5gactDs4VoJbeVnb+holj9OVY/bt7bC?=
 =?us-ascii?Q?98b33mtp5GIJ2/EJjxkAkTWVRfgVjmhLupB3QbOxxt3NEvlMHcakf8ASHxC+?=
 =?us-ascii?Q?V+prbtgN66qBCYqIslbxYr+JiGhCIcdz40laK6Z3CmEs3tWz5/rvzxxDyuMb?=
 =?us-ascii?Q?j71Bn51txtZiwBYra5Fkhv4OBzjhUaSbHzz6VQchD8RQAVu4VFpp/sDW+fjv?=
 =?us-ascii?Q?f6ON+gea5VZTuzd71YCKzLuvQp9l5Bx5Z8ZFgsSJ3J3acRfR0sp3V9S4wLjO?=
 =?us-ascii?Q?xD/dCObFXg69Xtqq1ioAI6W4pwmEJdVE5DVA0Q78MEsjnCDwnq73hX81Vcmg?=
 =?us-ascii?Q?YqJtyFM8g3kNu20gWnL9Y1dw9CGv7qNf+OXd1pMD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ffdcd3-0699-44e9-f2eb-08dbe42f08bb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 09:58:06.6853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8ock1S9WepqWP1j++RMeyrDKNCwCwADCe2Q1d2EZ1wEX7Ap2fAHqBI3BPRYxsWFQfjsTmWYGNxGIjxVTwEYag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7441
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

"nic_media" clock should be enabled when power on/off mediamix, otherwise
power on/off will fail. Because "media_axi_root" clock is the parent of
"nic_media" clock, so replace "media_axi_clock" clock with "nic_media"
clock in mediamix node.

Link: https://github.com/nxp-imx/linux-imx/commit/ce18e6d0071ae9df5486af8613708ebe920484be
Fixes: f2d03ba997cb ("arm64: dts: imx93: reorder device nodes")
Fixes: e85d3458a804 ("arm64: dts: imx93: add src node")
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
I rebased the patch found in the link above upon v6.7-rc1 and improved
the commit message a bit.

 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 91d3c5003a2c..0f65658a40bf 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -417,7 +417,7 @@ mediamix: power-domain@44462400 {
 					compatible = "fsl,imx93-src-slice";
 					reg = <0x44462400 0x400>, <0x44465800 0x400>;
 					#power-domain-cells = <0>;
-					clocks = <&clk IMX93_CLK_MEDIA_AXI>,
+					clocks = <&clk IMX93_CLK_NIC_MEDIA_GATE>,
 						 <&clk IMX93_CLK_MEDIA_APB>;
 				};
 			};
-- 
2.37.1

