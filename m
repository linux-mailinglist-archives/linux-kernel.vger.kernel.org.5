Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A067AC659
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 04:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjIXCxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 22:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXCxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 22:53:38 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2099.outbound.protection.outlook.com [40.107.117.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F06113
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 19:53:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGYnuWlAmhCn4usxeYr4WW6xXTgw+yEo3QJQ4oArWT9zJ2zqWgOc076JhRy5cg0lGOAYmpiMDRCG4Rq61yyT30HC46MOuyzukqYnQ7BA2VdO/SCRU5I41oAvJR9bIT2u5xYYU2go/75poVfHvADMuN3JewvgjyqmNZ/vu/o1g2thNGA5GitXuj80moBeEcI0VcIY3IJCoFpCVy05Qexr7DNmx3QKOBqjcwtk+hjxinFquY5JHw1Shk6zy6ApVtOa6yeBhi7IJxjx2W6pz5DASbKd8eMZJCwutgEpgG5Z34fPF7IvotbUq+37kl2ccWxORFo7BXS3DWyv0O4iuZw5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzysWamZK+9kW6UWVQs3wGfzLoPboH5hnc5SyBpbi3s=;
 b=fAnZ14YCNp6XhFD7i4E0m9vjeMlzfFKmeegwJt/g45wfX1Y288DYld7rxe2EIC3Uy7xp3Qk4Owj6WbASOQItK0CqibeBIyVjgiqzZVwzeqpf1pOng9rwDIoVOJ1yBR1IHcQY9p/lHi2xdy0hEmSZqCf4qecZpDd/DRx4sFzIDtJgMgGjR0te44lJ3Mr0gM3F7281JwSJkTmT35cWI8PXQ85qoTWdIq6FrOBU4OjRslIXfPm2Svdy73gV/nKzVqD59P807imDJ8z1gkvFnVvFwNWr0rbwzL24y6ctfv2ngIdXowMH0OyEd7hMRN/gI8bt/4S60ppjfAue72s7u13Xmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzysWamZK+9kW6UWVQs3wGfzLoPboH5hnc5SyBpbi3s=;
 b=O3m2GLuLkE58NymbtDLQ74RI26SmS/wEoy6DR6iC7uXbeqI9bx/4tXjGfroLWxL7IJQuQRtKxujcM/H5rAVUdcRv6VbgQMwzcDSlm0hRbc1FxXHv/8K+5T78p1wS7hQw2pAJqL+noac+WFIrfEez13rU3MwAQPXV0a6GwsBH6OIJb3y696e9FzzIzSP6mHLQp3bHWSN1sdPVMyzK4EzUJBVkvbbr15XlU+SQxLoWj8B0iWU2QmshodTTM1OcnOi9I/PB/1JS8RBJHx7ZD5wIWuRdBMCqqHdQeK5312VF1wwIGm/COvQeFJoY0A5RbKL6STmpWGZIsNwX8njnuSOlRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB5326.apcprd06.prod.outlook.com (2603:1096:101:6b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sun, 24 Sep
 2023 02:53:26 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc%4]) with mapi id 15.20.6813.027; Sun, 24 Sep 2023
 02:53:26 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: vmscan: fix kswapd nr_to_reclaim repeated calculation
Date:   Sun, 24 Sep 2023 10:53:15 +0800
Message-ID: <20230924025315.285-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5e4e1f-9536-4973-dbd2-08dbbca96c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXlSlhs2ErNGQNG2yP0dmcu70BCB/QTijEn8doJIM4sw6VzM/8GnxNbZDz6uCsFJK/fBC/oji68bnIR3apCWQzbssIYSkOMkK6+jgMJt8nWzhJwKvL/zNS0rel6wEjS1XrgWSE5CetPTHOa30gJ4GPngxovoKbNcKoYq229XpfBY55XqHECzqD4m4e+4C54++pJm7wjFL5HEX1DgVu/d9cYCsoVVI6bq7ik4k0rCUV7PZ96Fd2pJddWV/n3qFCBomRareAyktr3DpZurSrBe/YjwM7+mkkZnlu+AHq7UajdRk6K7bUFeJ14KVRwOn/N3oiM+WLfCDr0m1EG1XsIoR+/jDBUenEd2Y618fy/57Sj5/GbHkTtIURSw+XrYC9yYgJnzEFE9qBzlBsU8aG2o88X+irZEhJwW7jbabtGyIMNCtiB7a7SGV5ztnSpQxUIxeWp/Q3U5gLI8rFSgaifiJVOlsOeiRbekPrsMaszA1bjpDBLvJC+CG8DNCRkC5+tXN/o6AQRB/VfF4llB9mBap8v+OSTpsBrGU9l5FfaHNBuxiZF9+LAXmQz3zt8/+gwjNis2h4DVIjUf2Y+81NCtHgA24/xiCQbVcIu1e9GIiSBEIKZuaaomfmfjhOfRn+SZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(186009)(1800799009)(2906002)(8936002)(8676002)(4326008)(5660300002)(66476007)(66556008)(66946007)(6666004)(478600001)(6486002)(6506007)(52116002)(6512007)(26005)(41300700001)(2616005)(1076003)(107886003)(316002)(83380400001)(36756003)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aGXEtHL/YQcv6TNby+4y772RvuEO3211ZYoISeEi1FZkONyh8JPt2k1lr0nO?=
 =?us-ascii?Q?s5KJbBBaL3KjUgZbFOEFmBQs+caWx6unvmmshL6S7QbMBQ4237qeIt0PHuDf?=
 =?us-ascii?Q?YIGJ8DacRKk8NxG2d0QZB0eKilq+/OMEXAxxHok9UQoLgiqieso1rMEoLz7C?=
 =?us-ascii?Q?vCHl3jKPAHb66A0vqn49qAH81QKA/MvxONqefn5NqbHiWcRMWyO82GZpn1xZ?=
 =?us-ascii?Q?ZkmM6ICA4MAxBOawRrz8Bj7hOtsefLmzuSxTxCpid9SkLj3i5b+zfzzEA80v?=
 =?us-ascii?Q?+VWSnD3G8nyt8ztpoDWCycuID8Lb8xL0KJul95PJbYFwtwi9ncUPHZ5mJaJQ?=
 =?us-ascii?Q?huR4x/Q4XBNXQlJGl4Q1Gyl72/IxJ2UgupsPt0fYsR0wdEQInwU/yKccSyVc?=
 =?us-ascii?Q?RpBmPgbNfQoIcX4vek0BsUQD09BQ4X+Myz2huuv37tGwJ1Gcy/IwL/YoO6Ss?=
 =?us-ascii?Q?G1KRvDXqG+9f7qnD5CAfOiD/FerVlkgG+C+a7GnQGnNvCtzz13APd1ulCWZr?=
 =?us-ascii?Q?e3oFQ5xmuVFWlpGEMc2miXTv3fOJNabGwhtrLcROoI5PqJWAfsWxyrXTlN2x?=
 =?us-ascii?Q?Jm3fmiNz6aMPDbfPa81QfkdEwgjQw1Ph4s2/k659POWzusTOaGADb5Gm8BYF?=
 =?us-ascii?Q?msJo0kc4yCSfp+Dx1rCnFo4zOAEu8XLC26GTSNUtqMo2qIKc2E0wv0swAyi2?=
 =?us-ascii?Q?zzkJU1SQ3Uo2FuC1oxEDaiZAnfwiZp4KqNuB1J0hDn7WNhV03cC0GYccnjWE?=
 =?us-ascii?Q?A2Tdab2YfIbxQqYCVAIUgHGiCDUSMX3gQISqquCaqrLclQe5uoLSd5itaShH?=
 =?us-ascii?Q?R2W7kviErLFjZQM0GM6Ot6UiqUT4sKpMVMmnwpVT9aKK1jtVX8BZnRO0JwoA?=
 =?us-ascii?Q?HEaemkg/xhgnXCSDWzwZIH9yEGC7RAIKx3q6r/vD03UocGxzuaOApuuuQlnP?=
 =?us-ascii?Q?Q97+UU+L8TULPkALTQxNrFdjJ+5E8OtOfLEXZpKP90Bh5eIoJhID6LRT6fKa?=
 =?us-ascii?Q?nmPS6ZSxoLSDrDAF7MJtTiiEPqKr8oFmmD/9B5aLZ1VKxZk/5kY7FIl5S/Mt?=
 =?us-ascii?Q?qsZnCedeVHOFRCJitvsBzWAAsD3y8W2uXnvcO5C6B1OY+eIEI5rO36l8Wodw?=
 =?us-ascii?Q?ZlfQ/e755sfIdegEK9ugbhHqV1iqOiEOwk3UCy2Er6+q36v+/K8Be2fnZE8a?=
 =?us-ascii?Q?rKSFHJdG3eV5tlB7hN6IqA0ygpf9yecrYdwLSBwnWnbqoKlCkZ3c4nkcc2dV?=
 =?us-ascii?Q?pjJC7j8fdiAPCqSkSYyJXDlXBt/pKfFOdaF9kdmonTAIhgYCpOZT7N4deh9Y?=
 =?us-ascii?Q?pqd9Z5RGXJrwPwL9Pc5ZC7JGatKrXqTLSirz+xz2KOpjKj/jYc5Y3157RdCz?=
 =?us-ascii?Q?DiUPHUVOzfNW6GhRo5Yvceh4DimhA3k/ULyVSKbcsUQ0TlEWpzJBWNv3HgUd?=
 =?us-ascii?Q?TIvM9U9g+ExMCNVfhc1HHIB9jFd3QB71VZX5hOHreyIgegkY5IdsONfYXD3A?=
 =?us-ascii?Q?mg07d7xPoKqomb6no2pgsJVAwGRsahtQgFbrjb7Tn+j1rip1Uu2gCHURpKcm?=
 =?us-ascii?Q?iNKPnEaz+06p1PbvNYjH34Jsm/+xDk62zM3KLu0J?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5e4e1f-9536-4973-dbd2-08dbbca96c23
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2023 02:53:25.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9HpfAgIeaiJ+peRz8KI10S7xrGpSGue0VQdG7jocpRo/o0MxtXQI/U1fIRibJscH2TlzUlteM8Xxmz8ffvIlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5326
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kswapd recycling shrink, high watermark is fixed, meaning the 
nr_to_reclaim value is fixed, so there is no need to repeatedly
calculate the nr_to_reclaim value during each iteraton.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/vmscan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 mm/vmscan.c

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a4e44f1c97c1..1aab3549969e
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6638,7 +6638,9 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
 	int z;
 
 	/* Reclaim a number of pages proportional to the number of zones */
-	sc->nr_to_reclaim = 0;
+	if (sc->nr_to_reclaim > 0)
+		goto shrink;
+
 	for (z = 0; z <= sc->reclaim_idx; z++) {
 		zone = pgdat->node_zones + z;
 		if (!managed_zone(zone))
@@ -6647,6 +6649,7 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
 		sc->nr_to_reclaim += max(high_wmark_pages(zone), SWAP_CLUSTER_MAX);
 	}
 
+shrink:
 	/*
 	 * Historically care was taken to put equal pressure on all zones but
 	 * now pressure is applied based on node LRU order.
@@ -6725,6 +6728,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		.gfp_mask = GFP_KERNEL,
 		.order = order,
 		.may_unmap = 1,
+		.nr_to_reclaim = 0,
 	};
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
-- 
2.39.0

