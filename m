Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7B75AB1A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjGTJlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjGTJk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:40:56 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831945270
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fr0xe+Qj02btzyH4KmclFPQWU3hB1N9m9iXaPHWDfgmxcaHUWHnD5nzUTi5KgkRW2ATHWpd7XXKCh+mBfbjPGOAgDyJJ98IeJXWatMQ/g1GsCExZQ/rtDOW9gD/4OVB0jZB2zTOkZcsJMmPCBIll536F4YN44hYzWwbOM4MnIuC4KxfCBfNf0T/eEh+BrQGhyXCH0uPeYGXmBvLThzig86xhLZzNi7yHHaxULbn5FsI/sedlpNViukvl1cHntEg9TfXj8Bk/YZYRFPGJnAsfoZF5zD1nE+QPCYWv4unctWp20ORq3UdJbGaQ6HQbIkRqfLi47DpMN7mTrp4nry9tdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF948BRl8NffqmzXY2ZKiRJwHdKM7ujns57fiU8YtXw=;
 b=je1sbruIwgLGCXV1skM3O3hhSJsr3Er8fmdm70BiW/LkjSu/HWXL2wT9YkaYOdl1qMzUaoHfz+jnqX5A5P7cKxgf6JwZEH4uiTbgIlsKZZPVE/a1woV3uh5g4wlrwzFJhLFswGe7d/94oUu3mdO+faQVXy6QhhC4FL9KV83iE2iMY646Ro4daGGrbRUclnLSIlg6q41xoiK6JSVsEu4Zf83ceAtA72Ml0MiN2GsecUwUjax5fZpy838u08m2SHElb2J1M6tsWKAYU3MabVpqSiI0EzWMYN4Kek+0jFQ7xjNhxv1wiRcptaaqqlvBAs586DXa+SP1cMSqIGTisFjbeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF948BRl8NffqmzXY2ZKiRJwHdKM7ujns57fiU8YtXw=;
 b=GIgtKS7BRjWqg9Z0ZNIlPm96MGUCNDfC9xUG46KgqdXf4Jx1f7Vcml+8M+/eY3rAdXY34FQwQd/DGPQn+rdE69tOh0x9UUCR9+oZUo0B87i6qAI39SSoLa7ttJM9VYeZ5CjNuq+pYwoqmO3P2Y2UaTEts3ke9dYGY2KEHjTdibU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 09:36:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:36:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/8] firmware: imx: scu: increase RPC timeout
Date:   Thu, 20 Jul 2023 17:41:22 +0800
Message-Id: <20230720094128.536388-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230720094128.536388-1-peng.fan@oss.nxp.com>
References: <20230720094128.536388-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b62922-7912-4082-50ae-08db8904d911
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21YCztD04QcZndJJsDGBvr/bCiRp2qPvL8hjmECGIvV/fHx+MqXvyHU/Knd/G3n1MBBGMqs7moshOAABHQhS/f6ajFgLsnCioOdc+jUVReGpHfrskKIQH1KYvAcyPnrSGzPpc0rzdzPPQeUngHx//+lvbMtC9URMV78zoZ8vtzQbElL2vUG4Gsl5BmEl2x4/mgY67eEJ4K9MOf3BWQZQjQc+wKVp2i+3skDZHqGNgVDTB3ddq0xL/vvShg3Ly2JxWBa1yjGe66PXxeEIfeVIYKZdHjV91nl4Nb2lbEZIlObuI+GiSi0liBrQFidGAoMt1u0sUWB0x030kDPZqxV9tvfPxttFQYaZFNfH6RK0sw9rKZa2miUEKeSldQju5J2UvZ+sYr1cqC3kKxz6GE542O2xSQ1RUOA+BxyRZY5qTg94fwjeLSm87jnXMD9W/iDuIaUZ1myyajeB3cjr6OeH1N+MsqxzqD6wnYeDwPhkHO4K3B/DVBH01hMJ7DcDEx8s5iNgBiHdaLVCbaBkluq3ejFL0RCI/uq92X6jM5gCuZpOEFl/mJ3owIfw5lZlQauYBgS4n47cHBmrz09HkExfMMYZ8pUKL9jZJRMrBDDiEcyebuJwvXV6+/dbDjRYC4xP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(26005)(83380400001)(6506007)(1076003)(316002)(41300700001)(6512007)(186003)(2616005)(478600001)(66476007)(6666004)(52116002)(6486002)(38350700002)(66946007)(66556008)(4326008)(38100700002)(86362001)(8936002)(4744005)(5660300002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OKWBO3cwHnUyUWSw7a/DQ1ehUKblv/ZXgeydElPzqz26LlpyeJf2qXjq49oU?=
 =?us-ascii?Q?RiyO8vryZk4/f4i5ShDKrYLKOaLYbLkQbrh7g3u1pWs975rFvyyy3F1m+a/C?=
 =?us-ascii?Q?5md9Atm+/lkD/p+o/NB89oxcfqxwj4fZ1/GO8+A/SzyhaFN59dhR0B1iOm8x?=
 =?us-ascii?Q?lFlf8/fqfPVpeMFPwmKvYgdFzcM2wrZ98YSlglyPSlPqdfY2U7YUF8+qq06b?=
 =?us-ascii?Q?KAfcaMPfunK0ZnDYJpnR+l58uejVLSfM82bB6BTgl4Ihxtsy4Adg5ST0Kd6D?=
 =?us-ascii?Q?wcv7n22tRWHA7bfLKL3shWUNyWxwqeZ/sGkyOfXGVRa47HRDCYqBXNEbbyWj?=
 =?us-ascii?Q?H0JFtddvmZzGc0NSl9z55U6ovRNjNTt8BcHYGb6wss2IW4M0BxadTug75Sbs?=
 =?us-ascii?Q?DbO1cHb42YdFXb4Get8cbqYRr7RjrQvV0oGNCHoFSaA9ymEJYRhUEOM3mbx+?=
 =?us-ascii?Q?7TDHAg7NBoiHeyi8pQ6S96QHyqs/ufO3vWHipsQM78dncLwan7gxj1nIV8WF?=
 =?us-ascii?Q?GKYtuNy8vFX+99lb8rqBQaGSAg5xp4x+0QUrp71TRuIZC0/uraG4Gmy57Z4F?=
 =?us-ascii?Q?Lt4kApAX5MviN6Y99im3eWlaSmTo+8Lofgp1M97WQz4OkrsSElo9r0uU/+bL?=
 =?us-ascii?Q?uEJ8jb1tVUmhG4HJkAv/VstHd0iZbtfAqDB3t0iX4pbj91gMGINk4bg9DWLv?=
 =?us-ascii?Q?rp3w1XehYc044UzFEuwpqVyTuamNiS4m67eXIUgJda71qKDCWwS3n3Z18MFl?=
 =?us-ascii?Q?8jX0USbvSlr0PkNRHVnPgc9IkCwjBEqKyFFZ5mlhGEuquyin3XDPdgLEVLd+?=
 =?us-ascii?Q?pi3+ByV4e1OB0tLCArl+37vla8QPNs/CtuCs02fCC77vfYMm01QyLWKTm6YY?=
 =?us-ascii?Q?vo0krkOPbYSxke/vuJq1xYfEoFVbIdl3+Ej0k2jJak6FYLrx8pGRkZckMmeS?=
 =?us-ascii?Q?XfpexcoC/RMURA0y9PVFFZTkU8AXP1497sUAO/RlsQ3BJ3Ht41ZAz4u42XHY?=
 =?us-ascii?Q?1HRNy56Uw+whrveto4eoZzyWByVjBzl9e7bTylcCXD5FcTe+egQwYymj8Qc8?=
 =?us-ascii?Q?oOVESxGLUFI9k/kBu/Iio+GcrzRACOKCUaamf1udCfIl+/esHUNzUEGcuPj2?=
 =?us-ascii?Q?FROWQi4XgwCjZTyFpM9UL9g2z8/54bcXShnH2o34hJ9FQWz2tmMcvhjKshxC?=
 =?us-ascii?Q?KftK8TF65hzKEBs0IXbslyI82v6RJ+JvlYmDCI+75eEfPZ7Z/yPmke+57b5M?=
 =?us-ascii?Q?CzUsvnJTzTq+f00h1Ap6k40cqiUOFCmTOG9eBgSKDaTpY+HC+ujdhH7nj+mq?=
 =?us-ascii?Q?NbqxGaMYy7PiW1JRopZN/4XAkyvhDsROLar6QYKMa4Rh/7t1L8GnPM3UbKMb?=
 =?us-ascii?Q?PcuWR027l6BWDgSbH8p6rWgrmcJ4Cw0cVn9seS1C62QrVfYXW82vRHrVO8PT?=
 =?us-ascii?Q?FkdkBiIh/fB6o4nZvqV3oI1RumCw0b6Oh7vJspch89A2ts0+Ouo1QYpd+jJo?=
 =?us-ascii?Q?uAD0/3Zs9wim7zD/Kbz4qNWctaDDDBV3/ROKOH6JgnFuoN2SuZsQWzyRmIBa?=
 =?us-ascii?Q?EsmXPuYWxo/qErznTdmx8mSfnc8Q7t+/uQeJTcBX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b62922-7912-4082-50ae-08db8904d911
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:36:52.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9hyoGA4e7N1dcQ9nxTHgOEVGG4RP71fme+FU1NsCAb3VgTTxIs57WTMgEQvHrDzGQPX7fTiFsGFi9ZfaQRsFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9367
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

When system loading is high, we can met some command timeout
issue occasionaly, so increase the timeout to a more safe value.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 2d24359420d8..14ff9d3504bf 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -20,7 +20,7 @@
 #include <linux/platform_device.h>
 
 #define SCU_MU_CHAN_NUM		8
-#define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
+#define MAX_RX_TIMEOUT		(msecs_to_jiffies(3000))
 
 struct imx_sc_chan {
 	struct imx_sc_ipc *sc_ipc;
-- 
2.37.1

