Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AE97DE52E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344903AbjKARRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344808AbjKARRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:17:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340EA129
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:17:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GYaNG002351;
        Wed, 1 Nov 2023 17:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=8whd+Yd1cxMelqwjjNgyGUih5bjRsfAE6RJPlfXanJc=;
 b=r8aotf2A+mXWwlbNrUk5jpTRUsfQdJdeF/PFpwq0cd7RzyE8szX7GokMEMQ0Uspq7+va
 g9U+m+FumN66wiUL/9PObYQCxcQZZy7sumNVU/3Rsac0atcLypmjrjqpGdzIZSq30V28
 K3HEsy7sklTsakLQjDQ/GCFqrc3JGHwSoD/QQ8CyRGLmUaTl9VW9KoS6UHA+20SRukKm
 8NUS+HLExzHfEQVjsnaaGpyLFNqbA4TFvKvv27k2b2UltWVGhdPI/OWWhIVsAHfQyQI3
 i1+qFn5yNQlbip3S1OUsN/X45DR1EVKhfR/4h9QzHm1XU14K3BE2KSOtVQ0IY87VDibI pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0t6b7t71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1FoQ7g020069;
        Wed, 1 Nov 2023 17:16:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr7d2va-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNaKs1yfDXN8GagrQVRbEaigKaYZHJkGYvp69Jo0K1XvZKpCoUD78fVeuIGsPoJWn07W6YE08ZDFGFGdDwSRQVyxsyDmnfUXGAyXL+mmR5qAgLfaQffoVCmJhs9Nn7vgoByibvXFzeESjBARLSGZJE9yV2AtPtt8eokdf6ins7lWuWtchzsfTiAMJQYakQw+Vr6LhgDbgbkXQGWhNd9ssdVAgUXgF1kmxY0TgYqbMwTnQvaMYSoHH1R7ki39/bQKMaDoFL8fPZUCZKBp18OdDd/pSnpj+JYxGq3cHn4FNGU58wzvwYZabKZV/L8xpKRDEAtwazKho9UsVk6JqeAccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8whd+Yd1cxMelqwjjNgyGUih5bjRsfAE6RJPlfXanJc=;
 b=oMLg7T/REVgfdH8Zb9qMXJBcQUYfSZQxM00wHZ5PEbm/layE62XGlZ51T/nzKgwIaFhFGsYGDUIJTx0uZu+z5uOYKbGxB/jYbiNqrbPgrzqr1zYZu8KD72pvUjIotsvjK52XIb04BxhkKVqO7kZYgv+Ga9T0XTzef7BSoOdlXkq1lWsd2HDhJkNTy6J8wXWjQbVukDe3w4ao8JXYV7tlqNp+gtWZWx6jINvTqyDwT617g/xZTL/nZwP4VvMcHOE9N0gzSV9ZYf0YLur3ZDYJ+V+1s/s+WZHc4Lqf6Yb9pCYFOr9iOFBm/oPP+bVkwPbnyKkBD8ql9o1B/RxgLFByqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8whd+Yd1cxMelqwjjNgyGUih5bjRsfAE6RJPlfXanJc=;
 b=zi4+U8vRnKFEzVEg4NA4dIC1BWBjO+Rbj0DV7Y0EFQ131WOiVOGrVR6mhpLCvaq1jxInmT6lucUPA9v4hhI0xUX/bSsDpPO+OQyDT89l6mOMMUjs/pS+3LztF1MRpCC+rJp7oYHV66xOw0DQ//XQEA03R1ivQn7p64bc3QZsRyE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 1 Nov
 2023 17:16:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 17:16:56 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 11/12] maple_tree: Don't find node end in mtree_lookup_walk()
Date:   Wed,  1 Nov 2023 13:16:28 -0400
Message-Id: <20231101171629.3612299-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
References: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:408:60::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 4876f74d-3778-4315-fac2-08dbdafe59e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqQiRW+Ly42Q53O924nK1IrJdMf/uo6xNj2BY0FXaz7eWbDcgcVGqU/ndOhpS32fkFDbFPwRujETddQkDughz08x1y8gL900U4Z1MPbs4S55X0HRHe3cuWQ8JOBgvtwXx+VQZn3LUAsaEXTge8rGXcYHc1zql5CxXMLgtY2rjyJx2YzToGkvSv7R6sxE7QleEdSGFIclNtUD+DFP3lJAgen/HADrqmgEq/5i3+NWojAwuM69pkSE/nWyH9Yt52M2DvBei3fkMaTCtklqSSaYZGsA+CWB0KWi+f20kcuYjWSW3oaMXuvSfMW19OrDYmOImcAbyYU0Xs33a7kn5SFkWGprBm3na1Z3w5la8b9zxrZh52V1ZAgMxlCrJ/0XjJrJ7AZX8xcL/0QMJdguOhb86ejT/Ai0om2w1heob8PDqBvuoIIsy9woWQJQazapgIHkkzV0bfwTsiymhiVsO1wlqoLL/RaZrI5Zoa12wRbJy6vy2wud9Uk7Dy1L8CnPL5tzEdA3xT4k50OJ8w41xltyloGXmrj7klyN27G/7eCtQlk0g+SilWOjTSeSY3fG8G3B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6486002)(8936002)(2906002)(4326008)(41300700001)(8676002)(5660300002)(6666004)(6506007)(66476007)(107886003)(83380400001)(1076003)(2616005)(36756003)(26005)(6512007)(38100700002)(316002)(86362001)(478600001)(66556008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zw03HPwY1tnNqKmawLRoO3KebHZf0fEBO88WlQbH2FN9/vCeaLmLQBrLjWyA?=
 =?us-ascii?Q?Nw14QWIxDvGrTc9YQRMzsD19qrNpeMc6uWIUU8T6RyiDAUI45MdivWjdPilj?=
 =?us-ascii?Q?+pqm6+2nOq83N7qorRKkz/Eo2O1rGYuOcfTzzq0nhEdZ2lysXS9jescHzS81?=
 =?us-ascii?Q?IDI+hVnSk3CZApAtq/rmK90h+YwqjdiYPvkCXOJ0rSk0ufwl9ol7Iess5z+h?=
 =?us-ascii?Q?vqYKVe7qpmOFVFck1uTtp9N2CRX1Ci1Qz2sTO/hyHyqgXtzq7bWdBHFk4Cta?=
 =?us-ascii?Q?xisUHOhq/DH0HaAqZ8Zq/d03Z00fKb4+UC1CHp4uwPyOSH++z2VGtQVIy7p8?=
 =?us-ascii?Q?wRl2OK9L2tHiOkQqkkrGVdvCWNIo+BvJLnB7Ir4CRU/sZttxLSCgj2f8k7wL?=
 =?us-ascii?Q?IDs79ApQBZNp//+dXuH7SXDo0++pM4YL6E3Yg3fr7EjJe115R2+PkyA+A6j8?=
 =?us-ascii?Q?0XaKtLO678N9caS43wsvz3JSExN3L9NLgQaLgevp9rmxybT9Hfw5FVUoJo68?=
 =?us-ascii?Q?1gXDKRPZll/9uzdt7cn299H8+VJICmSGdKPiFNJishb7l5zqfir78Xs6GZvy?=
 =?us-ascii?Q?cjQWsGirFjKrA5rxjIL3pskEn1Rec7WuTHK92J4BfQcTmsBAgKnhr85KLCkb?=
 =?us-ascii?Q?yxKpPjqNsCh9yNQwQv1/Iq+tmGppQTq9iMZCp8QR0aeGDDWyYMK/hUFOGpNT?=
 =?us-ascii?Q?TEMMbBFLLEInZUfRR9ygP0FfQ2seSELhikddvQYZ8jA2UYxcXiVpvsazfyDM?=
 =?us-ascii?Q?//4oqms4WyROyT3JVvUmTSeRcAaIi1AqJbyYC0YE2KJ5FxGYa+C6vNgxqq7Y?=
 =?us-ascii?Q?b/Wwi7/IxDMbkaK02epsPTAKPm27wofRwGHVpbDWHYeWLHVzKG/EEdB8fYn4?=
 =?us-ascii?Q?Ta7pV4gSisOQaFYdWndKDAHO/I7bkPL5knsC5CGwDjAtkIfHsBp9fekU3VaX?=
 =?us-ascii?Q?3E4SkACztkoaX1OU2u8ti1BCUql6/y44q6/FhkrvDKG6rzucmbQ9rDQcKTKT?=
 =?us-ascii?Q?+EFiYn0CiQDWdevV441qaR1jydZO74uBG5u9gSZDRdwBKsUgm7+iZucsz8C2?=
 =?us-ascii?Q?V9YeDlYKhqgkreQOoQ519C7xmpH1X9vwnPb780UxJ9tBZrMT0O+0ixruc0FP?=
 =?us-ascii?Q?xj6D6J0Cb8c64blZS61PiW4D1bM980URJufW4KIey4k9Fqao4ZvifKUHXh+g?=
 =?us-ascii?Q?NHx3fXx1jIvlFl8S03k+56sGyE0gVcjdavq1kjBb9LFvoEvq754RFg+Yw+zR?=
 =?us-ascii?Q?FjAreF4q8io61rEnaWGwL70xZn/13A1OL4pzxtvmifgge9kb7OWaQbKnnUlO?=
 =?us-ascii?Q?mBbSYnQ/T3MzNlvCO7+OJKjZNFSDIlZbQcdZ35e49nlGI72ZWBckXJn3LvEA?=
 =?us-ascii?Q?N5YKiZYqkUl8h6EzpTys4a2RTrEobfMr4oNBwnMLyZKUnBegqSsVQWJW+OiQ?=
 =?us-ascii?Q?rEuynP7TQ0T6qW75Y0vnXK6FpmAWucU03Q0dBuUApgRZr8kPRDGUDQkZ4rHh?=
 =?us-ascii?Q?iK+nS7mRqPpvaoCsDLafJMRxkJOpopjLNxOcWZIMt1yirxWBEvgLdpeVHHS3?=
 =?us-ascii?Q?UjUm3auC0rKAiDjabQ0XlMMxkK4lQ4l/odhEGLEJblEa7oIPFP+1zUyihoaY?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NrK/kCKcCo505tXeHGSCM3ZNZp/WG5BFH92wswuVeaXO7QmM8b6EfsLmX/MjREn6lDV13lwQL5Kz4bIT/NQPYqwDzjj5klGFJy64kLT6xOO3hJdB+tXuoyF5HmAd1bkHwh+UKk0K45I5cXTGOWLvJzx3J8oJWaDtFjnp6VVDIl0+Fl5509ALpGu6puqIoaibuNnI1cjV+DrAedA2xNW/dmUhwT3sq++wU/diJa2agPXYxZItm9fQYxf1vlfp4skGAC0is703GxAYIH9J9USQOCN73yZcKCNptsFYjp2FISekEdO8e8qVb0HOSkduicV7cJYRzkhL5WRSbwN25WFhF7akqkesEyEDRJZ9a64Y5eHi1slrrBgaCrCOgjo4BN6YbXjNZvn5M0PB9G8b3uVPXSSkXFLXlFyq0b5jh5YhkywvbhPHGc4enMW/xpSAH03oaa3jzD3vj7tCdvVgTmwPqJy1qN/Zx7WTcUkQ6TvXqktJTmyRqNevglIQaQhNv6gOpa81hvDcX4Ek2IJVXEGNgfBndZrBBoR0hRvI3RjACgp5v7jwW/iuBKP9O6NVlOgKZrVhm5oxhSPMABHP5DGvPkgn7S74ojZdl7/TW66XQJEL4OFg6Pn7Dme+ouDiO1E0uW6kJJvAyj3CGrteOBcY5DhYnECYVefSlQocpit509KfbswR18IOraP1M/Je2g5brgf9vuYYj+gntYziIIK0BQmsVs8CLl1UB/TxPesmvIZtY5M1+C8yFK5N1aW/xOt0UnWHc9R5lTIpRABUfyoqvYMwsBX3t5ZpCxU7nvQy8K6NvdL8aJSdsG14lNkSnyC5tqt+KSvKCmmGQ+8r1LsX1YSq0XDZOKHBFEAAEmZDdjrZ0QBoV/2dahAvZtR284y5a7ZkLqDq/yZDp+T3zfJ+9w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4876f74d-3778-4315-fac2-08dbdafe59e6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:16:56.8727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAoH8iucL29OvpAjFYvlzDlJ3ItlcNW68PzoKoLUr7ESiK+hW47ANY58Xka6SiGK2Um4vuhSgSNW3IKbK818oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010134
X-Proofpoint-GUID: Xfg-W5ZBtaBmw_FkDP_lhgHJkXzsx5s3
X-Proofpoint-ORIG-GUID: Xfg-W5ZBtaBmw_FkDP_lhgHJkXzsx5s3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the pivot being set is now reliable, the optimized loop no longer
needs to find the node end.  The redundant check for a dead node can
also be avoided as there is no danger of using the wrong pivot since the
results will be thrown out in the case of a dead node by the later
check.

This patch also adds a benchmark test for the function to the maple tree
test framework.  The benchmark shows an average increase performance of
5.98% over 3 runs with this commit.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c      | 12 +++---------
 lib/test_maple_tree.c | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e45734676471..a91adaf17306 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3732,23 +3732,17 @@ static inline void *mtree_lookup_walk(struct ma_state *mas)
 	enum maple_type type;
 	void __rcu **slots;
 	unsigned char end;
-	unsigned long max;
 
 	next = mas->node;
-	max = ULONG_MAX;
 	do {
-		offset = 0;
 		node = mte_to_node(next);
 		type = mte_node_type(next);
 		pivots = ma_pivots(node, type);
-		end = ma_data_end(node, type, pivots, max);
-		if (unlikely(ma_dead_node(node)))
-			goto dead_node;
+		end = mt_pivots[type];
+		offset = 0;
 		do {
-			if (pivots[offset] >= mas->index) {
-				max = pivots[offset];
+			if (pivots[offset] >= mas->index)
 				break;
-			}
 		} while (++offset < end);
 
 		slots = ma_slots(node, type);
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index b82c02f15380..d36dc64a93e4 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -42,6 +42,7 @@ atomic_t maple_tree_tests_passed;
 /* #define BENCH_NODE_STORE */
 /* #define BENCH_AWALK */
 /* #define BENCH_WALK */
+/* #define BENCH_LOAD */
 /* #define BENCH_MT_FOR_EACH */
 /* #define BENCH_FORK */
 /* #define BENCH_MAS_FOR_EACH */
@@ -1753,6 +1754,19 @@ static noinline void __init bench_walk(struct maple_tree *mt)
 }
 #endif
 
+#if defined(BENCH_LOAD)
+static noinline void __init bench_load(struct maple_tree *mt)
+{
+	int i, max = 2500, count = 550000000;
+
+	for (i = 0; i < max; i += 10)
+		mtree_store_range(mt, i, i + 5, xa_mk_value(i), GFP_KERNEL);
+
+	for (i = 0; i < count; i++)
+		mtree_load(mt, 1470);
+}
+#endif
+
 #if defined(BENCH_MT_FOR_EACH)
 static noinline void __init bench_mt_for_each(struct maple_tree *mt)
 {
@@ -3606,6 +3620,13 @@ static int __init maple_tree_seed(void)
 	mtree_destroy(&tree);
 	goto skip;
 #endif
+#if defined(BENCH_LOAD)
+#define BENCH
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	bench_load(&tree);
+	mtree_destroy(&tree);
+	goto skip;
+#endif
 #if defined(BENCH_FORK)
 #define BENCH
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
-- 
2.40.1

