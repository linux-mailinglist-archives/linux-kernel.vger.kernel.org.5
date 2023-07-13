Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21CF751CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjGMJQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjGMJQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:16:31 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2093.outbound.protection.outlook.com [40.107.215.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD311FF7;
        Thu, 13 Jul 2023 02:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRreXphAdyN5tJ0V7gkic0Ppuo/qzRkXaiJ2lwVFUGjW2xUREQIOCrcrvtMDYZ3SAUxzg2+EyEPguhUXoMglhv/N/eyYXdd/pKpYIPF6n1FgNPERddcpHMF0kFJzRfdDOWoZCHTMWpXQG8HJOZLzDGFj7BJc6ARPwZMiFDY9Y2ROqWZAdOzXEw+cnJQ74X96GMYakoNMZ3M1G0Zx1Irj7nIU+HfIobuTjrSwCc/4gP+dMBswK8GJG/oBI9ggpWeKqDU6fJNzrgi3KcpOIIbUxpaYE6yrjHoIKKpSzPPlJOmN9YrmKT23J3k/DrSewaqNf0mu8Fpxvs9aU+EGIgUJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfYpq+IE4hFbCk72pVldbrrIxv1BugRqam0dFq+0RdM=;
 b=dGE4ZQp8Z5a8A3uBbXI3yEBnbzcILbp7HSd+H0QRxdTdA1yMLXFXzC4eAO8hGuWjSQ8ycJEODggb8YjAPD378VvfrpZghSGAWFTknX2/BJ7Jk5NEfO0CaTq1149dmONoF3CtqjFJAJFGPOQTG5jFVOMpCwlpAkRcNt/jlZ41taBTc7Vup+ZguDp7UxhugjHD3IEhU6JWBH/9bPgxMGqkPv3XBVLTzw77fqenDEiXyc72GkBCq7kaTLdViriqkYbCZ3CUphs3hoE0KXcP7AUJdNOkglCAwQ/6ahoFKf6ahlDVn2/v5LkgOVPzK/m0Sz7wapn+NBEfv8XEBx/KqZfCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfYpq+IE4hFbCk72pVldbrrIxv1BugRqam0dFq+0RdM=;
 b=F5l2MvsVQG2PeIfPPFAaIKd5sWCG8Bg3ofoSYAe5YvM2oY/qb03Xq9dp62PekKjad1rb6GGa6EwOshh0cEAF85wWJiEIxyw9A2X+Burc3nCy0YIRszDrTOBKFCk6oz3tcV53F7RKtaI79BIJmi/U5G9irxrF0eSG03zvXhtTCE5nW7JxXbR5pZ2YEwojklw4GkJUyijnPR2PatB6K84OmyXBxnDXwncp8JJoqvMa4q6MRXflExuKzeSUEb9VQ1pa0/7+sdXn5NSTHnBNfMhTCbKTUlgNGRWJC3HmywwU99XuDutcSk+IzWgpoYtQ/cegdFFRsA7mFwK0kGAbuJJcmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TY0PR06MB5612.apcprd06.prod.outlook.com (2603:1096:400:31f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Thu, 13 Jul 2023 09:16:17 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:16:16 +0000
From:   Wang Ming <machel@vivo.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, gregkh@linuxfoundation.org,
        Wang Ming <machel@vivo.com>
Subject: [PATCH v1] block: Remove error checking for debugfs_create_dir()
Date:   Thu, 13 Jul 2023 17:14:39 +0800
Message-Id: <20230713091452.3997-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0191.apcprd04.prod.outlook.com
 (2603:1096:4:14::29) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TY0PR06MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccfc38f-65e0-47f1-a4e9-08db8381cf44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txwyOIcr4GEqvWO5J86gtq7qT1pefJVEAHM4ocmRciKBHebgUJNoRBqFEVvfDboMa5lYth3Ii08NNrE8V7RGO2M+z8aqhtkzlwWuO78AspEJX/270FCYMThL6V7/0e6IoGQsammQp6XP0mXWO/PJASZNOFp7xhaatl5Dh1Ws/3ED7nPaKZEtHr8HAxU6DaMKaSvZkSkABwDY8kgbfimmiUcqyU9Sq0kGsYOXfmEqkFq3K+WIjJBRYVMYDaXO241AJQqvdD/fOYCSURhl1H6Vv2xfnAk6KLqH4Ahz7pU94p6xJV4PgYOUSlz7OZ1Q3sS2zHr7NT2FISn1+4YF3nxpV3VUlTBdDHCSVtCVRe3WwCOadiUTyXle6A7Tw4ZIUPgZOWrr0I5BUiirpRbJ6uci1JvpwBRLu0BUi8UyiIjGRmIqk4j/Cmu6bKeJ6t5dTQdCDsChDf3NHyqMwHkHSqaBet97SPMBrO10UFaB5XO4Km4PW3V5AiPFvG9zOZdYw0kYQ7+QxPLUeMDxCGe9Q/phnCyB0fxLuhk1oMnVujVN7BsuilGRxLJNSMS7SIG5O0MGsv/FlnKF1BAPDy7m8rCfJsYFS5mrc3zXvaxdA7Il47hVd+0WeSqA5hBIxfH39ZU3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(186003)(1076003)(26005)(2616005)(6512007)(2906002)(478600001)(107886003)(83380400001)(4744005)(4326008)(41300700001)(66556008)(66476007)(5660300002)(316002)(8676002)(8936002)(66946007)(6486002)(52116002)(6666004)(36756003)(6506007)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g4xL1ED7w8axDigEnmxbP2Gy5wJHzkyhW/QnI3k4gUbQvG5sdczsOVfRSJGp?=
 =?us-ascii?Q?QmjymD5TRbc8t8EYjHlAApJlChn3c9ixWike19a/59LrIVsFC6ReAZQil8Wf?=
 =?us-ascii?Q?1qswNqBIpLzXFUkYlXaEZiu7WfgWR7qNUn3Xgg3DDv95kYwx0Z6UmGoD+I4L?=
 =?us-ascii?Q?CqQ6sBnYGE8wFkqNWXdLnwFeKFJ3ndbRxos0SRskFo14s2axoNmrUpif+Am6?=
 =?us-ascii?Q?2wSmNYR0EOpCgGIKPxKJXd+AGFJAYpSh70vCZjVT09n9rBRITsh/AsKzGlj5?=
 =?us-ascii?Q?fJ9SYqNJGSa/jRlqhegj6MckWC9uF23OqedJvqRKDxYohocxh2y83xsORXir?=
 =?us-ascii?Q?/kk4OLd0huYDkuOd2X/q3uyDYi8TLyov3F00rJi5LcpI5r3iZlhoU98Y44o8?=
 =?us-ascii?Q?lDuiV+x00P6eTPCLV5DwhrurrlxSi/1II6dFAUoepjcUDt8HD+3gusYOfMZB?=
 =?us-ascii?Q?qTqQpKfdwhAHTp85zDL9Kqxqc0SqK+znU9oIBl0Yi2reNMWF+EBhWyz8y6vm?=
 =?us-ascii?Q?WxX+aFdi4zdW9tU/7G0jMfs1SIywkmiaxE57Qz4vd8zCzo71/M8j1W04m0Q6?=
 =?us-ascii?Q?uPngs/+2MUdEYK9DLpWac1yblU6xa0o93LUkw+toy/TaPlLyBwswGCmERLNp?=
 =?us-ascii?Q?Rw5sSzQyhHqZGvoFHspfMwBp6DA48JeaPqvpLyvi/JWJolw1uMB/49pzVlDw?=
 =?us-ascii?Q?4Xti/1G7lROsGJ45l+29W4hFhbi1q1I/xDphINx/cL9oeyIj5xjpD8Y5JVTa?=
 =?us-ascii?Q?oWzygeYoI6+972mwq9Le0Z6e+hdyhrijKX/jj5SEsYDrGjUcCjpT394ehIxo?=
 =?us-ascii?Q?IwGk52VEWGvj4SPrc2/hzToeF2G2hqLmOlzlORBi3KpXUYoTPSe2hVzDqJfG?=
 =?us-ascii?Q?O5JVECpfeLx5Zfq+T8WgnRUvUjLjuc+ij1WGlS7XcobULWQkP1wRPAmrDVTC?=
 =?us-ascii?Q?EkkQRQh7ZwLG4kyugetp35GXouUZOzTuKekavsJzdxE/udeB7d7YVindLag3?=
 =?us-ascii?Q?AJpGO2FCn0BNoHqc5m7J8JpvgSFdrp+Do9leFbGu7gjG8qdVHjYd0biaBQcB?=
 =?us-ascii?Q?vuxA4mvpPGH6UfKN/W4qqIPddJ3vQdaDyuSgfdICfXsUgN12KkFZXrm/nAy7?=
 =?us-ascii?Q?hB1QxWUAIUn0gc7adsvYGnIrJG6Cf8gxJPRaHNLqwslvHqE2XEZRTZMiC/IT?=
 =?us-ascii?Q?TaaQi6zCCwcu1UiGa5b6le8xDVuj1HwV9HuV3+lPNHp9JTarh/NYT0zE4sf5?=
 =?us-ascii?Q?WmbPEGB+PpF+4bXwh4Sxcw4ZVdFZ+YmG66Q9zoBUs3gIBX2hqLMDe6q21/gS?=
 =?us-ascii?Q?FLirrjl6f4VbjoLohM9f3w1PLZSLaG0+erqXOwPrFQzmvhAVUTytrBPpBnZH?=
 =?us-ascii?Q?tnL9gYktV2VjZhnhxVp0X1OIQaQ64Lzq0YGqXY8YL5CeWEkQR5bA5wNDwY8i?=
 =?us-ascii?Q?Put6qZm01ELxMAgxSehfeZvaAWUPP4Fr/gJctNs69ujYuA5XXiL+CLCSl0cF?=
 =?us-ascii?Q?LQXX9c/86gNPkYhveQBoEtJbGDWjK+ilY3Cpo+GHCUgaiUMbTTe+CDCh8vQt?=
 =?us-ascii?Q?lFDMkF2fACRcmvyKhm5s+LkRLpSUEulfHbcgt987?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccfc38f-65e0-47f1-a4e9-08db8381cf44
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:16:15.7754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08CPA6n7oTIo58d46yGdleKHX+x2bYXWmAxdY2m3KKuMskNCv4JRq/P5O9CoszKL4AOK0cr2mLW6e8eMFPu1Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5612
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is expected that most callers should _ignore_ the errors
return by debugfs_create_dir() in pkt_debugfs_dev_new().

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/block/pktcdvd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index a1428538bda5..1d07208faeeb 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -497,8 +497,6 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 	if (!pkt_debugfs_root)
 		return;
 	pd->dfs_d_root = debugfs_create_dir(pd->disk->disk_name, pkt_debugfs_root);
-	if (!pd->dfs_d_root)
-		return;
 
 	pd->dfs_f_info = debugfs_create_file("info", 0444, pd->dfs_d_root,
 					     pd, &pkt_seq_fops);
-- 
2.25.1

