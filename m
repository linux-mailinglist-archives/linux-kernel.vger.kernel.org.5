Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB6772378
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjHGMLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjHGMLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:11:07 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFBB10FC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNhHvCN95HFcaroFlsoY/hBuSb33rMXRHL/c1u8Y35TAAeMmLO3/0URruARf/xIZTTM1/Hcfhm11eAbcHwgMx1vGnDiX4qJ4bXdqjKn0dtZ4NXIs/atpna/XYEPilgTzD0biHu45l0PLc7WXJPFfBM6oEIx6jyoQh+8hygj9qU112ioBKcpIMWWN3i9wOWxZhqCt416ssUzohQfSsz8z+sZi5WCidxpPosZjRqy1bKS2RMOdrYhYNlgDlLsApSzwva3pjPqwCB1bhfZSh7mqS3kEuqJAdhiT6FiDcoERjPQ7BxwcHIiCy8LgIFfBIZ8VHVlsQrHBzZ/MYrc+yX+Ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QALHUzHVhQKD3fKu06vGPOUlJ4GnUotQExquzQP0wVA=;
 b=ZgktJeP+6/4NI2sMFre/x+AzPGSt5BemZwm84OAej8yiM92F/lageMhgWe6+CyuDaVZ9O66c2Q0iQIyKiWjBPJ5RzgCA5CgDpMhKnD3HcgmZ9qqlseejJCsSxzxlMIxU4YY3zPBuT1hdXY8Z55poW176wBzIgIilAbPp0MMvg+KwjfgccLbEVRlP45cid/5xe6SDU9Bj+O6EglUPwq/I0FhazttQ3iUaSF+4Z4AnBGw3KWs2I/8luyae7ekQ4clO/FlggWtpsmhoQla4EGsAd24lzwMvkLzdMamUI5H+QzG6ivJIbxqR5lXqOaYCcmMxmbo5iWZPAouzD1Gc7i6l4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QALHUzHVhQKD3fKu06vGPOUlJ4GnUotQExquzQP0wVA=;
 b=XfGYCZYYLuF/5FXMz/UOIyUgbw24YEZhOYKVLj1xBHVSXauRXTNb7MbVnCyhCcCGwpJJ9f/CwH58spvI1r/GZwmhIPf3nZbY5BiSmBhk89uC4t/DqzyUKc9jsVzavpU7hPX+V3OvwNgBHkxcXPcoui7XX+HYRYFd6+xB9y3lOQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 12:10:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 12:10:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 7/8] firmware: imx: scu-irq: enlarge the IMX_SC_IRQ_NUM_GROUP
Date:   Mon,  7 Aug 2023 20:14:31 +0800
Message-Id: <20230807121432.3970610-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
References: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: e352db2d-243e-4ecd-9991-08db973f4423
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6HhAO2H8iqme8Q+43z5+Jk2xftCLnK/TdJhy6F50dQdrRqrl9y6PwtTrcGigRgNNWP45LHsW++jEEmUhp0veMRGZu8+f1w+wKEljM3QHSkiKkac46YqxiqCTVgD03QliEdmo1FfPM6wrQL9I96sM53pIOY4Nlye24h0gn2mT33L3YBRjuTGOxEp6gnJ+KGg9Ocp1Bkt+9AGVOY0VHbHfDlKzqoaNHhH8jxTH5jUCt14ItX/wGwhhfakMtM5jrki6GhcqHC3SwhFghk4puZX6gSpju7tgyztK60M7KpCxgGCW/RkacoQHZh9S8SOqttkzN+To161kqJdzWhw/zshatQfR8Dsn3sqBB2e6xjuJyHH1voE0sIDKeNBrEfIzO/YCwuPwxBltig1pD50q8Qogv6979/dgDN+2W0kfAb09bWeRqd+ufWNTu6WzQ6Ie36e/A2LNjAVFEdxxv73oMAsxD+72ADUHLkbOYBEj5JaLoGHmqLRczD5+GiZQEWfEJiHJ1tVFZFrglMs4gcBQYFwi+zHS+wGKgeR17W9LQ0h/woh1NZTM1RwLPftnTzHrMGxZpGRNGlWnQqZ6GHzcwZ8gz4Akf4c29AIumiZC0lBL3Zv0ZiB86CIdtK4BXkEgHSOB/Fs885GEyT36AkgsZM7gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(1800799003)(186006)(2906002)(83380400001)(4744005)(5660300002)(2616005)(6666004)(52116002)(38100700002)(38350700002)(6486002)(66476007)(66556008)(66946007)(6512007)(4326008)(316002)(41300700001)(86362001)(8936002)(26005)(8676002)(1076003)(6506007)(478600001)(147533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7RXrWQY3u1BmxLF5+uTQpqmojjlzBFGZe6/FMvapUTzb65B5TGc4bHzmV+88?=
 =?us-ascii?Q?qLVur7AY/UNvE5SYbKIqYlmSMtSD7S4wzKYa9l1tFVw+8oBGV9m/nlD4KkZB?=
 =?us-ascii?Q?z7L/jVMDw3qOiSag0InHW2J8S6BVyclPMFjWGL/WZzoMWESjq9knOgcDudtH?=
 =?us-ascii?Q?+XRqJD+seJ0YpOFTpKIBpFULXLzJvcu+QxkyYaT5wKKdY26ZSilE+dEyHBF/?=
 =?us-ascii?Q?3WfKAx5fBpL6hG79tf/TWnZtvrVXvuy0zyPDIeutCpiP5+xOqr2hY710I5KP?=
 =?us-ascii?Q?e3iNqGUc0DJjgBjPzDyUD/GQ31Z4cCIGd9mjXXC4mCNnXRzo49p8gGkZDZY5?=
 =?us-ascii?Q?tuI76jf5ClYh25FiZ6ExTwOlfV8A3i/BWJlhlMeYptLYdOZKG5QT10FLzcu7?=
 =?us-ascii?Q?9fKrf9k4KbxzkJ7kmSXUjk5r76XlGHogFAaFFlREyUAagxbmj8JoeLT/HLS5?=
 =?us-ascii?Q?CABQcfZwLWEUhLOXCefjRBcSNf9sUu2WI2t0WbogESqF1rs3ClMUrROtooM7?=
 =?us-ascii?Q?sVb2LVoN+rfLJAeJ4gBO2kLvMTRVfDk5/7dhSROSvS0qwXNptrUxbEZURSbO?=
 =?us-ascii?Q?Dhh0cSXgCRyaNIGMxMkIX2sTBUcQtREw52oHKyAioysUWDdJIHEiWJcHxlLn?=
 =?us-ascii?Q?V9P+Z9Y9s9lRk4k4xU7A3t85ZSRm0VutM9VDTGnXKvHNHfGXZuWpxN4eoTGa?=
 =?us-ascii?Q?TZpzspoLRcuBLyHTS5j9yD258Vlg3IQs8NNpbOOt1J2ad+oIN2NahZXj7KEI?=
 =?us-ascii?Q?1T+HMEkAANLtM+aM+DRj+Pe18cTWOU/Z7SjiEpeX9W9aS9yRwyjCJmRkP+2Z?=
 =?us-ascii?Q?ZXVAYYoH5B3zZJQYdC9qcF8i3WE0fc72+b+CGAszuP+oxsv0maugT/q4tnMm?=
 =?us-ascii?Q?px3MjMBAcniCvkG0vuemaUQXTWEf2pya/R+OuEnLeTx4qBmKiqWO5u2JDqHd?=
 =?us-ascii?Q?5JtlS9Z1C/geKf9saiHUYmIU/xiJKQEX4z/MbI1zdq3K8Dp8s2ztaIAS49jQ?=
 =?us-ascii?Q?ZkmMBzyWTXkg2DDyPOFylTmn3WjqR3BzTKg4g/em/Ex2Flqi0hhbAl9Y8IX/?=
 =?us-ascii?Q?3QRBoLMT8O3b2WlAeZbrryBSydRLzMK/BP9yRMcVef8CXqIg7Rpt5xOXk0hV?=
 =?us-ascii?Q?IT1RtKGpoT3/p3wdQrhsH0UI+vPsaZFSciNXu8J7MpoM+eHog142XIl+g0J0?=
 =?us-ascii?Q?mJZT5Xmex0Xh0ZO+Cszelgtcr729Xs6cFaGo93FqRk0U9uQGZYiRhXUGe87Q?=
 =?us-ascii?Q?p1tqFM4VE+UsEg7Yb2dR8+MZVxpMuMSGVplXqYqMujBIy4YPYjGzCvk2/fen?=
 =?us-ascii?Q?J75a2pCYR5apMl+ffToTDEHvUZtd3qwNHxkVHcbQJGDJj4wriBQCsbvgVpF6?=
 =?us-ascii?Q?Een4ozRRy0INFd9lzyV4wuAPn6W+yhTsjV2MyXNRxfpG7K/WMCnAcnkf/7QW?=
 =?us-ascii?Q?UgnRdMyJL2PJisOxTf2wacHBNNWX1sFVOboPfG0P2S2IPDG3DTU/s8OjK0QX?=
 =?us-ascii?Q?2S/T2mOLflHvLyErnaAVbzU2+rumXPSae6Wl5do0OAIUwabW7F6bCgLKtZxS?=
 =?us-ascii?Q?BegsJgV+baD33I54TSZayBxp6/x9NzSugkBTplI3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e352db2d-243e-4ecd-9991-08db973f4423
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 12:10:18.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1jvOfRgTgizfTn8YbsXhKKrhtLt3CKUbhinCvHfGdnqXyyWaoQKPH8PR4B6l3deBdxCb7T5VWujUP0qM543wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per SCFW update, update the IMX_SC_IRQ_NUM_GROUP to 9.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 6549f3792a0f..8d902db1daf2 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -14,7 +14,7 @@
 
 #define IMX_SC_IRQ_FUNC_ENABLE	1
 #define IMX_SC_IRQ_FUNC_STATUS	2
-#define IMX_SC_IRQ_NUM_GROUP	4
+#define IMX_SC_IRQ_NUM_GROUP	9
 
 static u32 mu_resource_id;
 
-- 
2.37.1

