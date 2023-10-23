Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7B7D290B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjJWD1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjJWD1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:27:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70C8188;
        Sun, 22 Oct 2023 20:27:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbQALbbQj1LwvUk19DWrL56Pby6Fs3wpYWtce/ZpX7bRzYvGz0fIT3q4v3JjD/bDZSD3Mb4dV6iOuQitBdRxBog0kHjoKDBrdvzK2FvWvMweKwC3PkKnPsHky9HcdLn8zqOgaeEJQRq1lHF0eXoRFSpiiMKsZE3d/MGv736YpYfzRLV0D0DqZaINu7iXyuCAhxFltz/VX9TL+QZn8LaXI1UXBmNQh0uxqWAoGs/yp/q6AKvOxW2cwLtMtwJmwLGlRhRnc75BmhR/ugzOqzs+6dhNsTqRxJdoTRHdWZa4J48Khh4wMvXFKq4MO3YFB+Np9v2nBLkuPr9WGIa0Zy5tGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpJEnhGnv/FRnZxW7L8btznOIL+JEFUy0S+58xWJYOI=;
 b=PY3o2LNZo3ZNgv3Un/XD1qwhJbH7lykbQ19fTSiovpwKQXm2N3T6oCv/RPn9ypJsnbi/0+GJQoOAp0z/BuJDhYZx9s1rkpRmcuiguTkmNMWU4flYJAHe+QmK3NX9dl0LMIQ9ojKr6t8k2WVwcoTLvaoYBW++8/UKWCSJvStSMZhdbeBXVpCmGYcUh+Q8Jhtq1lyY7l9Fw371zSAkZeK2LAr4fy2Nu7aMrsak/llzebfjaUgfp0nZYfLwyk8ZEJ0/gfdS/wSeKpQL+P4Suovi2RPio0rhwGTtLutLfsv25AO0sdYi1Ijek+HQUgIhBuJSEKwjShVRHm2nJU/ZHYmxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpJEnhGnv/FRnZxW7L8btznOIL+JEFUy0S+58xWJYOI=;
 b=Tr3wPEUKXYHsjQITdSEsNEF7eMX4n6cO+BooS5CGko9egeKGUDj3Aqpl4LS+ZfXnPaTcwFuQ2GjlIt1PcjfAzAt2T0E38ODAAHa3XDuVcO3n3n9GgR/pE+fQWQhA4Mu2N316LRH3QvKPtnqNpYziNE6cN2IIfySie2THomny9oU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 23 Oct
 2023 03:27:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4%4]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 03:27:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sboyd@kernel.org, abelvesa@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/2] arm64: dts: imx93: update analog node
Date:   Mon, 23 Oct 2023 11:31:44 +0800
Message-Id: <20231023033144.3694131-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231023033144.3694131-1-peng.fan@oss.nxp.com>
References: <20231023033144.3694131-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b2b1c3-6a31-457e-ed74-08dbd377fc07
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4dkLqDT+YEaZKw0GzpnRMTetAyh032M3ZjTHB0TUTpUeefbsArzPKcaGEUaczNJVqTfLXBlIsZeKhdLLQAxIJH/qYGN+uNdFrWXgw5L+zs1azF2ZWlOYt89Uw3pK8XjA0j/zek+3RSmJ8g5fMAtm7oCHNxs7AT9ZD7ez2qxZL6BlFMZuxN4U2ljB+GIdkjNI4m1p60tpduXsi7N6G3vHueFbZ4Yw1k2hOkJo/uQz/VCNdEQUFKpUMwb2MT7Lv29z4jK8zTyKjKpem9UUzWVp800qt6jeHF63ptfXQ/T7YlocPPUJznT2B5qXX6pYbZ11oVN4TH73q9FahvYkau6KQn8c84/v8G3krJH/YIud8ynPgwgMQEGkLCG4mDRwt8wyd1PTbwrtrmMmUqo/ezGT1FXUGlrd4812ZIoqrjnqHfhvnzIw9g/gQLWv9DfU23dwIoPm/Z1cqMAvl5CyHtHRnuX09EBR4V3XB3hNvXP3+lN4IpZvuq+JhK8UMgtOGbPD1HWZdveGq+4te6KJZ7RZfI9X2wZYQO/RBxBkgLqSx2KlG28qukaQ6/wFU6HFv8U/Vpt9ZNfPNR80fa690rzYuZeH5m5Rhqg8iTSUZ2XKhRt1VdlyjDe3Nmp5vO59Crm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(4326008)(86362001)(8936002)(5660300002)(8676002)(52116002)(6666004)(6512007)(7416002)(15650500001)(4744005)(2906002)(83380400001)(1076003)(6506007)(2616005)(26005)(38100700002)(66946007)(66476007)(66556008)(478600001)(6486002)(316002)(38350700005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tU+/bqLHF0UgRO0oFxPC0c+GjqAV7HsFgSnNAkVkswdpg0uzl2R1X9BT5VGn?=
 =?us-ascii?Q?5H0MjJXVy6C9n20AphRZQ6w5TAB+9Rs0gcErD2ISA3IPsBb597EEyGL5sY2U?=
 =?us-ascii?Q?4UuEPkAI2bvgMrnV3CsHHTT5HlpIMe3g10mNfNt+hWq8Rp3TncKBlGwBGRBS?=
 =?us-ascii?Q?STr5Xwl8jAZcaDZIqCiWHzpO5vCjPznaImXySRhTyxX2rYKpkjiHW7BvQUsC?=
 =?us-ascii?Q?1EwgPcyIs8IOGwwMKj4xBJLFL13q27NKfdTNHMflaGhGWA8A5kGGmvURb7zF?=
 =?us-ascii?Q?96e9wqZ6Qhuaf+BBqBW+hmGWzgNRGq2DMzvyDxBMT8JZJyBlLcvg6pEO+NAX?=
 =?us-ascii?Q?p3LSSXPrKwdsU+BLPQeKBRSID+TCM7ZLFrAqSOWx599ukI2UuuoDhczmi9KH?=
 =?us-ascii?Q?pKgzp6yiVACPPzavexzRA6NgWx+tPdHZFFvGwsRGN0UN8QuB5jZhM/+codcr?=
 =?us-ascii?Q?W0ZSnSO+X8Fb6VnjLCbN9oSwxaVzAS6H2lQrhTwd76cj1K5lO1C5S5nHzzSh?=
 =?us-ascii?Q?1i29u5EyOVummqW3HVH7BZgHeLj7v29F65ov8IQOpuzjImzztJaAo+bfpqj1?=
 =?us-ascii?Q?YqUS/Rgm1mUp7jAikcnfv2fEKTkzWT7IL4Hzd3cz7jKHVBXkE9J+AtCDCyGu?=
 =?us-ascii?Q?1C31zGoWWQSywEi4wySyoVD/jYoxkxRu4P4chPjo7vgVG1vb3DPAvf0Zmtx8?=
 =?us-ascii?Q?3T31qd31GvkGc488ewqOW2eQk9cjWxiF7DB9eKlvvLVsiyv03RtOUeF/nfzA?=
 =?us-ascii?Q?SvTgDjSQRNAWmfnENT1/bF9YDg/h5K3Aycgg7uSh2lNeA2BpJXKtckS4UkoC?=
 =?us-ascii?Q?4WR4RJpYScjyZbtGNFB7bse55XF8jRmvDxsV9OYwo5Q3hBtiwb/0/qqOXQD+?=
 =?us-ascii?Q?u8xLYeiM6LtrHKetw6hzpMoLUPolTgoRhOmcLmIpcgPRNOcTgYN5ZnTBxnUH?=
 =?us-ascii?Q?eNrP+FjArTmkqWsDPmf85CBPamoaeTv39voQ2ALKA/S6bVJSJzocOmSdIIGf?=
 =?us-ascii?Q?cocHFK5yusi+1gqskYcFO06k+Hq5VNTqfY9sXWutwQl45+7YqnN0Kog7JgdL?=
 =?us-ascii?Q?J1iz68KPQ4BQKC00ts8aNPmjoiPly2hBtSkiv8nmA/6cIBzXdbzMVeHvYC/1?=
 =?us-ascii?Q?JqKktvbjC1yllw+3g7VG93eEh7r7rt+1pz9cT+gqR3BIw8ThH0s+GgORIx1n?=
 =?us-ascii?Q?5t/V5UePV4oj+ewYM6t2kKd/rr5sWUPXCmhUBmuwlAJcYOWZ7NRvMFJE900c?=
 =?us-ascii?Q?xNur21Iq8X2xhvw8YKRWZYRjdgDhzZQz3jIE/tk7vIx5z/wIqHCC41fLgOdu?=
 =?us-ascii?Q?jellH2JkuVornnn45BdDhF9ZCXG5sTNjF2ZXc9HZCaIhVqUw2aAFrV0F45KW?=
 =?us-ascii?Q?iGdb6AasdnERNmXshkdUNRltafkNFTHY5QH0R4YFClmPZUlx5dts2GHkVZq3?=
 =?us-ascii?Q?RBLxRQukY4UWJBubddmobvdNdmkt4SoHmTbMc5BDtF1QqHkDAcD+biPvzeu9?=
 =?us-ascii?Q?4/HbGWGu5aOjFX5v2q64pUo1Tph1WPG4eNcYMDF98Lt0gnCII8snJqv7vXrr?=
 =?us-ascii?Q?N60g6KZwzmm05fioIQVcWrNpiWcOnWI63UJKviK5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b2b1c3-6a31-457e-ed74-08dbd377fc07
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 03:27:28.9257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7b9ow+MpXdaxLnCEUQ6Dqg1YAm8klxu903PNHGvLpW5E4I+znOXuO4pyNTtSux8tAtf7vQFMbZbcuqafejbJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The analog module produces PLL and OSC for Clock Controller Module. Since
the binding doc has been updated to clock-controller for this module,
Let's also update the device tree node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update subject/commit
 Drop node alias

 arch/arm64/boot/dts/freescale/imx93.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index ceccf4766440..235f1ae583e5 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -422,9 +422,10 @@ mediamix: power-domain@44462400 {
 				};
 			};
 
-			anatop: anatop@44480000 {
-				compatible = "fsl,imx93-anatop", "syscon";
+			clock-controller@44480000 {
+				compatible = "fsl,imx93-anatop";
 				reg = <0x44480000 0x2000>;
+				#clock-cells = <1>;
 			};
 
 			tmu: tmu@44482000 {
-- 
2.37.1

