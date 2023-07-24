Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46CC75EB8F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjGXGee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjGXGeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:34:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3066FD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DS+sFXaBL1f2P2ppmG/NA61JO8WjfI2CwLJrYG46r6vZo2DGiZR8DZgmloIroRPGCgp4G7SdvSpj+5rf4Lb97uaXha8fUEpfd/NMKFPja53+h34zzX1Cv60Mb2rD87YIPtuPFPcHjx4i7dDjPPCe0CHQ65WE2rRTsGzBJtt+nA24fNZuEakqsZXZNaYB8J9SA8pwNhRZzOENoMveQZbUjp2aAe6RAOZyz72SI7A8a9GQbUht9TBWawESpB0IUDYy6jjka8S2jDACb0nu6euP86KUZM85WkUiIhQYIxb76XCQbDnP7Xf1ieGjvhnDgSAZdz5CQfiAaWmkQqkDoLmEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1EaanuMVw3yN21IXzDoO2thxcz5R4f6468cftBXaho=;
 b=YKF1t/m68AlfP6+oSSgGEYh2mTc46wK8rTvfthV+8tsaksMZDkNoZi40+IjSssUfwOFWsASJjrLllYvfQpxeZ7R0/R+TDkdulzAQ9UQAIm8oW5Vq7uVZnmYTnJ42ohwAHow5mXmoDtNA7D/nqJcxFumGy9a+PmgUPD/rUunj2W4n9o6qbx5r47uVZYsSzKJroKewT3ezeFMIRq1CwquvejXzwiMTXg+L4GuNkHRC4JvkFqJXqkw8Pjw4BQgh4N3xu9EEzz30fBCjcylmEkoIfWXh0gSfaf81ILP44qHsXhRUg+O1FLQBIf2FQnjePxVj52KQOKLYPwKSLvD/Gh6pGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1EaanuMVw3yN21IXzDoO2thxcz5R4f6468cftBXaho=;
 b=YAYl3+dkkZn/0J0Li7kqeYEyF/6kBnLkcqPpPPqsj5D8dlOpn5o2YRoER7PeaQ1iZdw02mN/UedBC6ipnlFlPvGYplyscJS49MoN3yoMDygrqE8ezJQorNCK7307uBFfZN4w+Ojp2QJzKV0opNC82odwUKo9c2W6/JaDl4vYQdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9092.eurprd04.prod.outlook.com (2603:10a6:102:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:34:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:34:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 3/8] firmware: imx: scu: drop return value check
Date:   Mon, 24 Jul 2023 14:38:47 +0800
Message-Id: <20230724063852.2666930-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724063852.2666930-1-peng.fan@oss.nxp.com>
References: <20230724063852.2666930-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e28c3e-6a11-4583-6e1e-08db8c10007c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3lOI+F1hkRKY52PCllMMF3uqfctcx+CLGhub+4lGF26FFc7KjId+4FCb8xI7XWoDvxTwbe+HkVODzZz08o2eWgj0ve1Hg1/bsb3MMZL38VRND5FJF8u403+ENd9MVwWlnRBGeLJnXEa6T36q9tNIXcJlHqm1u0lSvD71sX4OrPzwyfbDPTNkPYBpL24Bl7qRaS0KtnZjB7z4cUuDduLfqIwMn2h9KSPrew7bWg5LeyyPgjsxfT84pKw5+2kLLd/Fb7Z71Q1Lp3mlOogbwjgo9ny5XFx/KVzLo2MUGv26om26l/2iGXBXLOf3iT0Oqzf9B/8oAr+49C/ptJMLzY5nEOLYarntL1/MRX+kn2khIZDOU5AB1S5XGhjkQL+9/Ws41FrBZIN6Luo9xsSkdhXzY6WFVnQUNXDcp+vzn1yiOQJ1pZx5dc4D3L+8667EHvBKD5JNGQiuuo7P7IG/HzcaExtky429vj2wU9RmOmGyaPKodV3tSNlJ4iY5rkEO7EqmnMrDy/WL76EJEyJGD4hYifZ2hMIVG4B6iNJE+CtytzQVQX7qDP+8hCRrwCeX6/CldtEM73vjQnNbxhCNj+6odWH4OfDYfoQ+DAQq3f/LE4e9N0hijr+dymN42IPm3Wr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(38100700002)(478600001)(38350700002)(8676002)(6512007)(83380400001)(186003)(6506007)(26005)(2616005)(1076003)(5660300002)(86362001)(8936002)(6666004)(6486002)(52116002)(66946007)(66476007)(66556008)(316002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NUCEYkvgZGO18sVVA92g7FGxA+sJEUEVK1KHLn3ox3pYJ1DmDHSybAql/v0n?=
 =?us-ascii?Q?MDJmRnYTzFP+iSqDC+fK+BvE8nbiFD3ygT+NWiyPZRD61cKSXFFOWeQScSii?=
 =?us-ascii?Q?ioGVvSYBigU/yKc6MeApgzMFIQES/MG7/S/LBRlVcOJJzkUPxZipYtxL/J77?=
 =?us-ascii?Q?LW5MPa70WuD+W/s9YuxeWEPTVTaFifa92QSSFW9x/q9qJDFutaqiBt+HJ+nu?=
 =?us-ascii?Q?u+p+xusUffkeaMBymgRtJcAoOW7QuLO55zLmPQLOJ3ltSYX4zTN9+lRoURc9?=
 =?us-ascii?Q?UKBGuDMtBwkJ+VvXVZwZz2/ez3cN9PLRg/we3MIFGGiy2sTyqeMPGNvFB7I4?=
 =?us-ascii?Q?QM60qisWA6W2Jg2OfUxDKF0oBDpGIFPjgZLfeGscZpr0ySgfikbBEqT0/SjM?=
 =?us-ascii?Q?2GFPxICojrH3chYrtL7VTDEQROMpu15nZSF/bLoRfJuhDxwSHT6xaLzq0j6v?=
 =?us-ascii?Q?fMqNIhOetTDF6SYU9pmzstiGLN10a4CtTzYPUhf6VTyA7/Nv+YiS8Hh0d8T2?=
 =?us-ascii?Q?xFBoK3/5cVekvZIkkx193H+y0frpFGoXHTeIcPBsDtSqW8Gpnd/5qrAi5Xtc?=
 =?us-ascii?Q?qs18g0sdKjUN+TV2tPN0sa1ySH5T9FNtVqabI5mXYe+CzDMeI6INdF54DKVk?=
 =?us-ascii?Q?zalI11KajyQqDpBJKmZt6mbSQ+2iVKT+Gbze8uqL121n5S1/BPNCq9B35w0n?=
 =?us-ascii?Q?0YAtx6Ev0FBcJ+O7d4KlIu0KxliWkFb4Mo9v1rtmX4IzKe9MSAQVLSP9lmxd?=
 =?us-ascii?Q?KJ3Dfllew6Hd9jlQzR9nKMlMH/HV50Cr3dJJBBo8hv02eNJ8MzdHNfyK8Lwr?=
 =?us-ascii?Q?wusco7r3eqvYrAwxX/Uqqgb4Y5OG6wyMeAsvJ/bwqwxBFtqa8wxdyT7yCd5F?=
 =?us-ascii?Q?7BfGOxUCQWMh4zWRosRM/j3GX5MUY3by3xJECJfecfB2XDzidP9DUUQK091v?=
 =?us-ascii?Q?El0+vC8v9RLUl5RZ+QEI1WiPt4K9Y5oY9ZEapP+vUYZ0MMc/Q/DFKyw5Mtfh?=
 =?us-ascii?Q?/7TYmfFw1gIE5doJBeCTxEYcwxREiwssmLOkzfZVAQiS4IomhpWaH+aqd3BZ?=
 =?us-ascii?Q?TTIVHC6Q40ODlFBW8hp6DvCqabxwPMWCDv2facgwoeC3igYxU6+hmpDWOqS1?=
 =?us-ascii?Q?c7kdsPgb3HdF+SHnQc4nsxC1PJBvmGlFw1K4abRonBg3BBXH+/YXaYe/ItqY?=
 =?us-ascii?Q?OggPkcaBFL69lTq8guKV0EOXC1TsNqww5L5rFqSJQn0MJdG5phsevtIVRclQ?=
 =?us-ascii?Q?oL7sYtktB5Lw+oVNq9kETJ1vnhhkuMhj2kR2dXLjY+OpbgHVFrIEpBGcu4jD?=
 =?us-ascii?Q?pNDK1ef4bXgteNUsUHvufcikludCKJJrCwmxsq1iNXNdESwLgKwhUd69kiOV?=
 =?us-ascii?Q?zNOBe2rfcrTKuHoyVVdjGYZJ4e7zPw1E2qo2Zx6PuV1SU841TPDWsTc7p0TF?=
 =?us-ascii?Q?lzPxmGaVZ3yZH3qqV6HxhLojYKtD8Zv8qtSTQJl11ZVmKfFHmJhC5MxIZfDr?=
 =?us-ascii?Q?IyZmiUkJgAH6fBStSNendYjTg8uXKlJ4T7qql+zv6uvm1H97Td/Zh4PdiHb0?=
 =?us-ascii?Q?wPe7lk5yaOUT0gBuAbFrJGgiNBapH70EV7Aa7R9J?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e28c3e-6a11-4583-6e1e-08db8c10007c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 06:34:16.1633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDeqvRRLnjY3joOMsBQa2bFc/PPfCM/27KsmLHgW5772nR9THS7JSv9YnH5ZbD4ZXtBN/L7Ya//U7Es5Q6inOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

For IMX_SC_MISC_FUNC_UNIQUE_ID, the scfw has a return value,
and the imx-scu always return 0. So drop the return value check.

BTW, also initialize msg to 0.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-soc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-soc.c b/drivers/firmware/imx/imx-scu-soc.c
index 2f32353de2c9..ef9103987e76 100644
--- a/drivers/firmware/imx/imx-scu-soc.c
+++ b/drivers/firmware/imx/imx-scu-soc.c
@@ -33,20 +33,15 @@ struct imx_sc_msg_misc_get_soc_uid {
 
 static int imx_scu_soc_uid(u64 *soc_uid)
 {
-	struct imx_sc_msg_misc_get_soc_uid msg;
+	struct imx_sc_msg_misc_get_soc_uid msg = { 0 };
 	struct imx_sc_rpc_msg *hdr = &msg.hdr;
-	int ret;
 
 	hdr->ver = IMX_SC_RPC_VERSION;
 	hdr->svc = IMX_SC_RPC_SVC_MISC;
 	hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
 	hdr->size = 1;
 
-	ret = imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
-	if (ret) {
-		pr_err("%s: get soc uid failed, ret %d\n", __func__, ret);
-		return ret;
-	}
+	imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
 
 	*soc_uid = msg.uid_high;
 	*soc_uid <<= 32;
-- 
2.37.1

