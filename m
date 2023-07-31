Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028DA7690F6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjGaJAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjGaJAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:16 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0775E109
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffxhLBxZOQZfq5cmAs5xFci8pjLnfhimdGwt2u/NiAFS7Uee7IDSdHGFFg7RYGUUa17B1GcLalZWqU+DPUas99+coV+h0qu7QA+QvgfJOkuAYimV99nMoEzN5K8NnuVi8nefgjRTBz+CULJNdQJSxYbepADykoSBtMlUx75b+IywbOoPuxCtrDjvAf1oUGqOMFrqeP9WsbKjNM1rH0ZjmahPNWUktzbDAcDQqh5HKQZEtJhqa0vScULOA++t4DRQWR4AHCtiUX6HVtQRmFm5Qqo2lUy6j4Gmd6CYo1HQxY7LnLyJVLgIab+NPKEnwGZQEjYKAZM4gp8tDPXpG4gRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF948BRl8NffqmzXY2ZKiRJwHdKM7ujns57fiU8YtXw=;
 b=BegYLT+De8p6Xr4QwdwlwpsPR+QnibhOUxpeMA+kk1T0c5LcJy0+McnwMYm7ubuaCtDNyAqhFwL1OLQGBIlX6nKg0bc8UtZ6tcxu1EQo54dvSxkBkpl6Tcbr4hSibfAfuzpmbPUlO3yEREY6gj5LvMaHBlFnZL+EHFufYjJgK1f1QrD9mCiqeDlq8+kZoOyBd+C0NAHsfGxdp+akGjx1oGx5S2RTsw05lzJ0YoxcK+hSSpLfY4XLUZe4+7gVynqSwTWjO+58F3XhNjFyG5sLNmGvHQ8yVMie/LoJ3s0+0SJkw4hZ2r6WnVZ/GroM7YjgwZ8S2a8JzJLiilQvC1jMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF948BRl8NffqmzXY2ZKiRJwHdKM7ujns57fiU8YtXw=;
 b=FyIh0j79WFES/gCHV6BNAXHqDW85BTp5n/SUtDXkUfDpK2ijFze3u0mswr7iy9y+zrsUD0/EaskyKYDDJyU0MUaDsPHc1DyqIJLExL/clJBgK+dqyi/QFz4C52eYqKkxRXR9AwUmOjG9CiOxiCR0OOk02BHQvoxOCikTHNDjF5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7671.eurprd04.prod.outlook.com (2603:10a6:20b:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 09:00:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:00:10 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 2/9] firmware: imx: scu: increase RPC timeout
Date:   Mon, 31 Jul 2023 17:04:42 +0800
Message-Id: <20230731090449.2845997-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: eec5102c-d0b2-4f28-bf9f-08db91a48b6c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRu4ZALFJnFsOGDPttakVxKWJ7g0dF11bF4gCX2CwVzdUmUYnKH4HM1bEepz3LNnZZQfwNGoKv+TpdzdkGMO0IlcS+JiAMG7zjD+RtREH0pGdTv/ktNBpaLd/uyY/sXtPbmCAJbaiOprW0ZYjVFqhKYaFiBEgoevxU96VqIfgqkKfQfy/VuNDxyOWXp7WYUDA5K2XEjtCZC6smAJJV6le2x/DSbsT1wj+mvEuhzpF0QmmeYbG5ab7hUbFX+tFcjXrFCKH9dy7iSjMpW4MxGXNhvyCK85r5vCxxsvubbhRPBWL2JiNO+THqWs0LeFuMl1VpUnxI22lyZLYSIHd1nI9YAXBZaBv7ZOQW7nIXQGuR6YG6xlwGOD+FkVcnwqCg9d3oIMTewHwjU8nKXaQy8bg3HapwA7gLAhQy5Lw1AzxbnRGR2bMingyA6rtvSKxbXyIJ2JOvETFBPOj97wOsHCdn1H3aijRnyN4KBUg+a0vwoBDSIEFIMfTTO/GRl0LWtuot+T3+uXdyj2lFpkPU56hKkKdpbSUReahmnicq5OT69coqtP/FNzhmnRUSRY3rUowP3Fjrbh9hrMuy0TE5XL2sbSOhUmo2pCJ9eIBglkK8eLOB3HBASbrWPoqgdKc2Ay
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(6512007)(6486002)(52116002)(2616005)(6506007)(1076003)(26005)(83380400001)(186003)(66946007)(66556008)(38350700002)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(8676002)(8936002)(38100700002)(2906002)(6666004)(478600001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9lT7ZgZSbFlBHjqBXtUdMB+39M0BNjb/6k3T/7m5AqLuemGJVFn3dlDTw3jJ?=
 =?us-ascii?Q?4wsHIB2e+j5a6pLzHql6p3c6IIw+ILReW9tU9BpUkxUQl7N1HdpiS6Lrutas?=
 =?us-ascii?Q?/gjGO+s1JnV1RcTnICJITmaQP3uHIfEcO2o5mhNiA1LIoFrUp4NAA1lJm+fb?=
 =?us-ascii?Q?iyVHZuyk65SynR0xMzF8L4+BfCS+/nDc51hNyxbUaqw3CA34rwfeT7pBfg7A?=
 =?us-ascii?Q?s07uZfrqYodH0qahC4R9WIe/S2esHWBDgjXkUo4Ds0GoUjJ+IT347fph5GQj?=
 =?us-ascii?Q?wbePnwDaSea7aQ4YiN0yV+DPyoJu/kV0I83JGHFlFkuWZka7MDwBKwuBZXI7?=
 =?us-ascii?Q?wicUumM8jUj6NjzLdbQuMiTYnEOdUXHKY4KFwBd3ebsKKt3NaG3jV5ApWQ4+?=
 =?us-ascii?Q?erqoYliZCRGsFPV9a4lSpzfaTPxYJSiVSEq/zmDk5uH5FAvEU4q9MKdC+c/C?=
 =?us-ascii?Q?jrkPKaLRjauOI2Bkg7Fr2J7AqVC5b2HnLi0p+FPG2HJUMKAcUYIrLUwf2j2X?=
 =?us-ascii?Q?Hy9tqGxfGsEOU1N6pAUQnK3sJUQPRcCzZHQ+7GqmqQktSam2hW8Wwrci6Jws?=
 =?us-ascii?Q?MKgb7cz5R/ckkhU4Mu1Yk4mwTTF8uAPtLWyuYcoO6GqHMUXPpP7Ce2HettaA?=
 =?us-ascii?Q?jlgn6P4hcUcJILC1dJZbmTy1w/WcLYEUlYneCA83xqcYwX+GxH6gIMI9plPX?=
 =?us-ascii?Q?a0mC2u4fsxh4ZafgaL8dhcg9ThjAxisbtyBJbvlgCWNnIAz9j2kWuyua6v5x?=
 =?us-ascii?Q?FFLpMlJuR7BFGPpRm6ohA2j4HiK7B3pYBeTQb5Q9JShl5i5RnVc3NhqIJayh?=
 =?us-ascii?Q?dCKO+wvQRqGYN/6HUU7MZuCXrgqKDqJ6VOl2niVs5tZSsUKK+ZuIic43H8DV?=
 =?us-ascii?Q?s+WJceOMuL8wk2NSvkL6IhaTm9/qeZZvx+hrBoZhFCskQtGyKdqp2rCGI1ZO?=
 =?us-ascii?Q?sHBNLGtz0cuuzxlImuMMPV9tIYsxKVQQ4HFZpg1FHw7aDNmHr5RC65F54M27?=
 =?us-ascii?Q?OS6C7fqKuD/r9EJ+nOC8rTGG+Gt6c0bvjJ6MmgfydDaOzXxiOJy2vENv4kRI?=
 =?us-ascii?Q?6RXfVPF29frKnZrGWJJBMCD75u7M8BUvW6EFBETuMokN/+vyK135WU2RI4WH?=
 =?us-ascii?Q?/mAUe3/2+u/NNhMhCT5RuzN6+YToLlDFMUwWshDkhV99mdAZbR8nlcciHF99?=
 =?us-ascii?Q?gDot9Az8CYYbwK1v6ks1Df6Kwec5sKO5oD8Z6yJap2cYoUddoTFMHPWp70fJ?=
 =?us-ascii?Q?rnwyVoncIIl44JyuNZbEyLy4M4Z5SqRTd0xY3+mRibfprdGlaoUZrNpu0MJy?=
 =?us-ascii?Q?RjKOKKIwK7M4nHS+CXQc0IbkM6i60qpfpCJYZTMQFw70w8VgoopJ8oAPUZIE?=
 =?us-ascii?Q?jkpdGrcu8oxARCocyj2t2QYFaca2s9i1Hn5USmDCqY87J/tqeX+clrHGnBoK?=
 =?us-ascii?Q?JYD4ymAwxcCxswIMOuezHsAUOy/lXm2i2rBEQ1LQRUxUyWr6TOVvndPa6ity?=
 =?us-ascii?Q?nj77+WtF/HZ9xXx9/3e4SgFH/ZFgYfGminKbjJARm/dX1mH4ONhbPQnkgo8Z?=
 =?us-ascii?Q?JvRdpBm/YoeeMnHsVvLXbtYl9u4nv//EHj8vzHxJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec5102c-d0b2-4f28-bf9f-08db91a48b6c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:00:10.6680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mn04H4asC1HEhsQjQZ4aK3LKnWDuTaPUwjV2POrAsvelTvXsu0Md9kNgNmNUds4v0hic0rzThpVyoSJpXVK6Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7671
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

