Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC29F7D7CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344159AbjJZGfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjJZGfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:35:20 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840619C;
        Wed, 25 Oct 2023 23:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNSHgTrXuEjSRwTJgBAJ1HDlRykUxA23loP+59XVvpIJwKEWsfPiKC5hNq/1dDj40X/w+SvSe7B4qfevSfpzorM8zepr0vqjk44Ice5pbwNVAYfMGmJQwDvJXlOkbqkPtBXc2q7x8EZIHBPObKD2dIAZ1eUrQxS1bAFWrqjO4o7Iba5Q4g1JxaUaaBq6gxfezV49QhRRcg1MP1slPHQpymgsxOw+mErs2ar8q0TNXhJ2S3wW7iFAxJYPlG6LeDE5qzxjej1rkESAguvKVbETz7aFPbWmqtXC+WfkO82mhgnpXXw7YuhiIz+NbZu3UuyVn6FkkZqVJdrtzfB1r+Oy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33oE9C7e9Ahb19UhmQe1QiWb7+p+q0jdEhReRCxGfPA=;
 b=dtk0vlI+BzvnekBwT6VZXpmMoLzJRvJSWe6TtafcEehtxNukW2hqwm0O8x2LmpjD0bFBJiiuWHHN/Pk1EirhMuj+vrMqRAFSuha9v6EbE8JSnJQZPA41mMeQPx98zFU3oj4iZcDId0JLWH2L/flEeDK+GRLFUgdS+sNtP9MjSibgtEat5jSvwXKqbrTO4Z6FY9DuOWhQAr5hMFMKaTgqg1CsQq9lqJ4sTtOPkr1hFmvQPxHV/eXtpAu5dqc1L4YrHNSMBNs1WYrwuW8LT5EtgrxFJ9v4zKPeZGnQQ/TXpYI1usG41ZzQ8myKyCbv4IQYDV41wvNTna7dP8shcjAx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33oE9C7e9Ahb19UhmQe1QiWb7+p+q0jdEhReRCxGfPA=;
 b=SqqSMHqIofa2dItmuQtLijER2fs2iOBETN4dsBriYi1+VxGSFXKD4uviZ1fbk2GmPfF40SIBHBOx2jkkpV3YFyxPsxXV6EGFhv3018Z0QD8WEy6aCUNO0rzk2+EwFdB8sbNdAVldLc46UYUs+c503IFDcrPZpGTTnVYPTjpp6Uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8303.eurprd04.prod.outlook.com (2603:10a6:102:1c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16; Thu, 26 Oct
 2023 06:35:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4%4]) with mapi id 15.20.6933.011; Thu, 26 Oct 2023
 06:35:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, abelvesa@kernel.org, mturquette@baylibre.com
Cc:     clement.leger@bootlin.com, sudeep.holla@arm.com,
        cristian.marussi@arm.com, kernel@pengutronix.de,
        geert+renesas@glider.be, pure.logic@nexus-software.ie,
        a.fatoum@pengutronix.de, aford173@gmail.com, absahu@codeaurora.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: clk-conf: bypass setting rate/parent if already same
Date:   Thu, 26 Oct 2023 14:39:41 +0800
Message-Id: <20231026063941.1882023-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: cb04b454-ebe6-43b1-a8a4-08dbd5edb606
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFnQ/nFhoQsrYQG3CvToPnlUFpxOGptxJr2U9rPrwRc5gT3mEBkZz8xJ8VC6l7k2nMamDUUDNOUnkwYhJqpLTCdy1Zxbw2kDnvTqckO/0A7Rnz6Sk9bUbSdCIBeR+11XC7eCuPahkidz/y+58jYZ9AkWW6aglPdnN6AtdTrv4XsKtFmeBCJXV+jBVDMs03zaSLc6ffRVpRXrqBb111Xt+ftQITns2OhxRe5POT6nymxlqABrhChfJDJXoaR+LoZwVc3vEeI8nEGguZ4dEIym5M4SUwLUXx2HiWo2PY23K6M7nROTayze26Nmqdmfp0yDn3MmCFiXEg77ypIvLNiwnvVLizofY2GtuIDyDQFPFkxMsJ8Njhp/3gSA8j895iWa2ed8ou6cFksgB7nWiGQqAwPSGKyeLflOBIucx5fi9769+ut9f44dv8LSRUhJisU9voU7X5jRVy+0XC4Lp3XMCi29cN8Wb5vR5a7ZGh3ddc9RZDhZz+l+K2BWSPn6RM2FYBEeR2gID1DvVS4TiyiVneQ5qwiSI++Mfcky7TFw86YUuULuHiTzUG16nlPDFie51Ntt7By+2JSoNHzEFAPwesyHUem4ZDe5adYai7AEp9EP/uu8y9PWVYjRsYDyDcNH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6486002)(6512007)(6506007)(6666004)(52116002)(478600001)(5660300002)(8676002)(4326008)(8936002)(41300700001)(86362001)(26005)(38350700005)(83380400001)(1076003)(2616005)(38100700002)(66946007)(66476007)(66556008)(7416002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?87ZFxdXAkPavObmgjLXTVgve8NFYZV1gWIMXYqFEUD9pZEYWyPA9FYLEuzQu?=
 =?us-ascii?Q?U3jLkt78YBBPwnyWj8rC9LjG6IVnmlYcjEn8kYdc4XjUmgj4c2EydFXHZ2VY?=
 =?us-ascii?Q?F0x5j5iNfTEAuXAIkTMnlT2dP7Hxo0HPn9NZksL7kXgK6hOSXjQ8W7bJfcPB?=
 =?us-ascii?Q?I9/3/j+BlEKpHpFgF37d7tdGFlnZKHWgTz8vRTdUWHH9HYcsuFM80sRGlt7M?=
 =?us-ascii?Q?RN5i9Ja6ooLRp2wJmBKl8hCaNiBzkjontnjk4A+MjaPK6iP9dP1tZf23AkRj?=
 =?us-ascii?Q?nECjvK6P6ZoFdve1VsF6W9n+jPzsaoEFteqowYynBwhqBl5ljuBS0ShjdZhg?=
 =?us-ascii?Q?bh/8wdSWQJyEybnkFs4iUXW+qxwU9lbDAQ5jj/A4pBA/sj9XCDgUFe9X+lDs?=
 =?us-ascii?Q?RzT3PZSFv2roVzMVuvOWTBQRddvz0uww0rXFaL4F0GQeITjOrlB7EckZKcay?=
 =?us-ascii?Q?6o4gKUEfBnE+AA1CJj7llh4Aye6JBFg9eBTaaZYSXeURz7sf91NcCdiutHgK?=
 =?us-ascii?Q?zxFMuG+zHR6mU/fsfFQEiXFwwdjJAMAD5XdJFtWtbnvpBk78/w0HBxyWD7L4?=
 =?us-ascii?Q?CbdUcIBaU6HRagz1fo5wyXSL8NUEfgKmKeAuWDd40nT955TgHvKvi49U1JE7?=
 =?us-ascii?Q?Q5BjJEXPX0b+5s0TdpvXCjz7Lo5DpUqB42lEBL/4K25iQsiverTCxQnjJNz0?=
 =?us-ascii?Q?MUZW5n2bUrZzd0d32fpN8ZZrrxfdo81XmgVjIcI1qPMeKL0MVCAzPPtqxhMl?=
 =?us-ascii?Q?0Mfa7yYrIqYE7glyE1iRTBg2GOybPOwPM3cPuhuPCdJUTc1vEQaxQTorggXl?=
 =?us-ascii?Q?PqSQpvaSBvVVZVGhF4W99U14y9z4FOvYDKysq1NfoTnCYsyMvc4OCtNvBHw/?=
 =?us-ascii?Q?zaJFGYlEY6TeX5QhEDZ7e65fy3bFcUzbGD/Rd5zra+wbzSc1GOABftueS8/W?=
 =?us-ascii?Q?TgZBWUQ2mgLmp3HDjuMWfRZj+Mf5W47voecGOOCzO9/8dADukxzecQiI3WPK?=
 =?us-ascii?Q?xbg6PNavbhr8ZEXTVm3Rafd2CImSaUaG/gHna8FldpPyqefqt23QOjheTpyU?=
 =?us-ascii?Q?AdmbuWaW0ew5IbIl57wYh1bGOa5HPyX3Vk8xqG3zPEOfOouHJDAer377Zo6E?=
 =?us-ascii?Q?9xBI6s/tkkSzmklTsHAC5V5WKXZayW86fMmQ53ngY9H/ooMcmb/WIQo4kpQ5?=
 =?us-ascii?Q?3qmQhqdS1Wv1QEa3Y74UXelhuh6btVzKUOaNtTvba3UXPvf6EDylojyZ0vtN?=
 =?us-ascii?Q?qaHIcukUYBRh42IEDfmGdmcAEPNKPizTkh5eWYYyfiWnTskdMms88Z8kl9Vi?=
 =?us-ascii?Q?G9tIk1LXBDH6H+bEWJsJVpFsZyYTqGD2dg6AJPbbyyPnFJu0kOpXCLVe8gFJ?=
 =?us-ascii?Q?LUAJd0W5L+91CgQT3z+OtIPXHLYUlospqFH0oyLsuSXyHaH9aEzKNXddf0cl?=
 =?us-ascii?Q?/8G6tKth+mJX/GSSSRyWG/WuzyF79R2shszruTbvdqB7WbSd5k9EXaWvaL6r?=
 =?us-ascii?Q?a2QJWtvn/afhr7uQ2Bf58gPDt1QPfgedG3Bjpvj4KNUEAVYNdkAFUtXPf+Zs?=
 =?us-ascii?Q?SWrPGSgS89lnwxknTpCY1yK9qb5eMfSMmSDbUPV1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb04b454-ebe6-43b1-a8a4-08dbd5edb606
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 06:35:14.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89fOFjZVEjm6H/HEmygkU0Xcs7ZmZENs7lAQTyQt70L90paTJOi7UsCHfDO9+kyX/kw5sDOO9D3azTqkvn3pNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

If the original rate and parent is already the same as what users
wanna to configure through assigned clock rate and parent, there
is no need to configure them again which may cause more cpu cycles
or more SCMI RPC calls.

So check the rate and parent first, and bypass when the original
rate and parent are same as requested by device tree node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-conf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 1a4e6340f95c..c9ff4fcc8875 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -65,7 +65,11 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 			goto err;
 		}
 
-		rc = clk_set_parent(clk, pclk);
+		if (__clk_get_hw(pclk) != __clk_get_hw(clk_get_parent(clk)))
+			rc = clk_set_parent(clk, pclk);
+		else
+			rc = 0;
+
 		if (rc < 0)
 			pr_err("clk: failed to reparent %s to %s: %d\n",
 			       __clk_get_name(clk), __clk_get_name(pclk), rc);
@@ -112,7 +116,10 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 				return PTR_ERR(clk);
 			}
 
-			rc = clk_set_rate(clk, rate);
+			if (clk_get_rate(clk) != rate)
+				rc = clk_set_rate(clk, rate);
+			else
+				rc = 0;
 			if (rc < 0)
 				pr_err("clk: couldn't set %s clk rate to %u (%d), current rate: %lu\n",
 				       __clk_get_name(clk), rate, rc,
-- 
2.37.1

