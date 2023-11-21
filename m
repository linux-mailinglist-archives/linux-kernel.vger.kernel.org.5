Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820B37F2354
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjKUBwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKUBwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:52:22 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2101.outbound.protection.outlook.com [40.107.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7A7CA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:52:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVCQ6kw7Ix4274RRsKIbqPnVyxAOYcxJJJHU9+/62ChgR8qnLS/c2pqFHH82LpuDEn8xY2FgSn7Nt3dBOI6EjO/ct8Ovur2xNT3IttYVaZFwGTrttnqSd+s11JV6kET4KDau4kG9H4PmFGKIljya8YoTlLJMBWSZoLcm1OwB5qBg58OaEgioOyZAR2gZlolGPL54/QNoqV9q9eq02VncljL8wyxpP0YCCg0dGhsEZhGxvMkMO4hi4Oq9HhXSlYw+dLTiS3aotqZ33IvVPBZARuE3KHyyQx+W1ynQy+GWtizqh43Uy0WDANV2Jl8+W+UD4cKHQXCsBDGtAkVEJCieVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqzKcYNIn8Nxi7uzfnlcZAemNTobvxLPiCHuepzsLfg=;
 b=KRjvNyv4BPpkqv4I/hegSgGEV0We6M4YQwYIcOS1Sn1az46EwWt6k1MeLOldCKuyp8Tx5j99jdm1aeJ3VTFPxQD2fFhJRbzF6azLYkl/xEUfVmaZjXkfwCh4IUC9XcCKMttPTaJ4ru1Y6unRam7P1No0lXuNNujNxJDNLWlG4dBDBGROHff0RyxT8JKA0vvjCf9i04mhyAV0v2b68TP4b33JliuKWOeyNX5Vj2nFLycKg6w3Y9PU4quMN3VlS+EPgmK5z9eLiv0lo4EdVOnP2rCZupZAzfJHoxPBf0d9JslMuyGKvGNoWP572v3BEYvd2GZ5k5aj45sipHGbAo2U4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqzKcYNIn8Nxi7uzfnlcZAemNTobvxLPiCHuepzsLfg=;
 b=cqMQff9gET5iWjgjMhI6Y4V6R+lLCQVIh7x07tOpfiqL6HpxEbWQBr9hHBx73ZQZAX3if/bGLHGkGYy+MWxd9WDyTwBvXN0hVjVTBwuMaonrOFr273rhlq39VvDpKFmIm3qbiwcSiw5m7hVvHbRVHKuDpXcWZJrw0YENKF6ABcb35MeoH9wYxyyPRRIvqa7tPJJR3gTD0cEF2w25sRsRU8VaKdsTJ9NFhaVOBqxE6OBUdAhpuiBMozxyHPzousHWmyY0j3TkOHJR/8Z20WwXanNmove0hxRxNqf9GA/tCNuoge+jryiBrtFLMuhPpVN2zJ+RF110i6Zsn82qc+nEiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB6448.apcprd06.prod.outlook.com (2603:1096:820:f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 01:52:13 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 01:52:13 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2] mm: ALLOC_HIGHATOMIC flag allocation issue
Date:   Tue, 21 Nov 2023 09:52:04 +0800
Message-ID: <20231121015204.177-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: f8286dc3-e408-4ae2-3b61-08dbea347afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dc2uo0pD6du+rmsZZ6nPe+9u2EW6E8tPJzjBtLT+Nc2uRG9zlr+BKPPssYowwuCz7QUEa7966t2sTGRGEfKTmwUvulm/Mrhqva+CXHnvNNeWhb/4485nJLc1LsfhYOuePr3AOhkHCvbf67U/T9I7n8ZLE47nCmTdVEvrbcU3sKkiq6SIGdtsnw7/h3cnr/RVs+qSF5RPhuEKNDfDmS7S2BhyA8zDBr9FyZ3rC4aXR+RosAnInoaYy46zcoS0dAxkrdxvOzHRWn6GlZ8Uq+A2mkI1vNWqQ1a3IeMhZe7igQXmaPgHwPjbYoI9t4QRQ0tvDu26eFFcwvVvEWDCeYTbx5d3wqxS3ruReANwMmWRt2nBammA0JR83C9T2dVOT4F8QGfK1yzL+VenNOpNQbOok5YZbIUVFGxMfcgn+c4Klc3vYyOI+O+W7o+ZtD8QTQvGiIrTkKuU2zQp9cWlbOogWe+QuTMDJYLHhZ52eCGa0pOCC/pb64V7aBcGP38CYyDMk0wj5iSOaLSw5xmt+QUPOIUeU9Xr0BS8If7muHbIDPGEVciuHf5jajFmFCb7imIAE02VAN9rtFDYAIDFcxDB9PSFnAReHgg3T8O7BG+xyzGBOoCICL91X1gvBF9Fy7vW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(316002)(66556008)(107886003)(26005)(1076003)(2616005)(41300700001)(66476007)(54906003)(66946007)(478600001)(6512007)(6506007)(83380400001)(52116002)(6486002)(6666004)(8936002)(8676002)(4326008)(2906002)(5660300002)(38350700005)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IoQD6HDs2QrrLsnpkpWiP8TfogWk/+U860M4kd3tA6fWKykSiFvCK9fDRVPj?=
 =?us-ascii?Q?Qh1e6gIW/gR3h3nXHduMJ4fM74td4DdbivSpG/y1k4U6kZrEtwowOCVMLUpH?=
 =?us-ascii?Q?sxGeLa1Cj+6YzD7x4N8LnogfS2UPPbhM/fo0RAPZc+9ZBev4On+touQlFJsf?=
 =?us-ascii?Q?ClLN0ApEj9TJcZC63rakIgrg+a2XEeBYPHkeCJYphUWCkqjB8GzVtT63FDk1?=
 =?us-ascii?Q?3koCqvvu+MuRNdQNgKYCFSn1olfyTjbYdXhfJFx7fbMNKifL9one9v47N7LQ?=
 =?us-ascii?Q?4RW4A/muY7NXxOJaBR+MAnGfmehPe7x+ie4V822hTugfm37BSr3MWdFiROYf?=
 =?us-ascii?Q?1MKq8T0RhMvPjR67aP0adj+lPI8ChtkZ0N7yKmYEqt200IHmPHkhnpPoAaHN?=
 =?us-ascii?Q?ejtrCKHHfTvlXONFj8wxO8WGWDRY7t5Xoh3ZGJnqegOeRDzo0ShX5A9ULbbN?=
 =?us-ascii?Q?VlbqlguCbePLH8t4hbK5twiyWbqQL8Zx7DpREwnGO3mlEzHsvqcniF6v4h2h?=
 =?us-ascii?Q?EH+UEo23JObF48ems3h4h2GQImDEDyY276mKJv2A3hF6YyQTK/bh9ERDs1Jn?=
 =?us-ascii?Q?ube+Ii1FCPjvJGFXvs033OZeDA37SytH6cry3BnZxUaUrjo7dsZctn7nCjTN?=
 =?us-ascii?Q?+w4Ur1XASFrGdi4KoI81HGBzcjdzXjtwICcntBm0dQyhezxr7YszxyTYZLgm?=
 =?us-ascii?Q?yGVHe4ZNsXE88/2ABVQnQzVn17Rk9noVJUJSM2kcyiYGxMbs7Gw3nrQ/P4Rb?=
 =?us-ascii?Q?fLMRYA15vd87VafzhmyaUaymgvN2EyoG11O0QDqejSiNvzR89vNpguCr72v8?=
 =?us-ascii?Q?ntFy9sNDpzTRP7LCLrNr13GAtLgOc4k8AWRSKnR8ngaynpmKC0Y6/h89hvES?=
 =?us-ascii?Q?U6DEFtZd8NdgZjJdYIdyIOVL0BsE/Hu5DQOQJ80PgD+TIP5NMFkNW+y8E4oa?=
 =?us-ascii?Q?lcJ/+3Pird5u7vWgLbDajR6XMO8TVpA+ceMnW2HLFOjG3mdO71M810YntSlF?=
 =?us-ascii?Q?EUZ7EPaw6E8LCyYw6Vcaow/lJfa67cZfIhWpP+tq72xhyuJe1WNq4OfXTQNR?=
 =?us-ascii?Q?2M4R4jrWFSnkQLcEAAwy7lfpnHU4TE8AYhN42QRyMvaVmkSfe2B3j1ogeZRP?=
 =?us-ascii?Q?xUHPXDs7W7Jw82nNrYe+OdGqcOObiD3QQHD72AFvNeBJjb5eY9s2fgmLOc7p?=
 =?us-ascii?Q?QARdR6BJlTSbJl8IYYSu8LrQ42VoI9poMIvHl/KG9ocwOIB/VuifdVJgwxEe?=
 =?us-ascii?Q?UMNfBW4D9BMsj8crsZPl1v7hRr2KYifsq+7my0WjaHMgffpzHzzWkOXhlJEA?=
 =?us-ascii?Q?ng6zeFQxpyS72n8awMv4/swpEi3024J1A7TOfr0J/WfC2Md8w/Q5Y6Wseh3F?=
 =?us-ascii?Q?oCmrn2bb0W76kP8U7VrcYqHXTG0ihZl5VNfDXwogn5PpgBXYCE1iFfd4kwTh?=
 =?us-ascii?Q?53oxz602bi9fHyKHxcCopenXRIvnIJMiRExuwfXxXm94uRSSu4FTMAbS74BW?=
 =?us-ascii?Q?D1iKCWthtJtVUdnbGjZEGFw7B7pVEK9Zt1Hx+QOS1I77MMQP9TH1H9x0B77p?=
 =?us-ascii?Q?UUoIcQIPvZwqHBT5fIwkKZGweYzxEMel158CwgkV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8286dc3-e408-4ae2-3b61-08dbea347afb
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 01:52:12.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4aOyATKUmZB3ZvNUZ2phfW5abnfbzQK4McGKzohJJ5wd8iqDTrQQV7MsbD6c7V4ritQQRfNLWocvxIqD4Fs5gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6448
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update comments and modify variable highatomic_allocation to highatomic.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Changelog:
v1:
In case that alloc_flags contains ALLOC_HIGHATOMIC and alloc order
is order1/2/3/10 in rmqueue(), if pages are alloced successfully
from pcplist, a free pageblock will be also moved from the alloced
migratetype freelist to MIGRATE_HIGHATOMIC freelist, rather than
alloc from MIGRATE_HIGHATOMIC freelist firstly, so this will result
in an increasing number of pages on the MIGRATE_HIGHATOMIC freelist,
pages in other migratetype freelist are reduced and more likely to
allocation failure.

Currently the sequence of ALLOC_HIGHATOMIC allocation is:
pcplist --> rmqueue_bulk() --> rmqueue_buddy() MIGRATE_HIGHATOMIC
--> rmqueue_buddy() allocation migratetype.

Due to the fact that requesting pages from the pcplist is faster than
buddy, the sequence of modifying the ALLOC_HIGHATOMIC allocation is:
pcplist --> rmqueue_buddy() MIGRATE_HIGHATOMIC --> rmqueue_buddy()
allocation migratetype.

This patch can solve the failure problem of allocating other types of
pages due to excessive MIGRATE_HIGHATOMIC freelist reservations.

In comparative testing, cat /proc/pagetypeinfo and the HighAtomic
freelist size is:
Test without this patch:
Node 0, zone Normal, type HighAtomic 2369 771 138 15 0 0 0 0 0 0 0
Test with this patch:
Node 0, zone Normal, type HighAtomic 206 82 4 2 1 0 0 0 0 0 0

 mm/page_alloc.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 49890d00cc3c..8e192c21e199 100755
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2851,9 +2851,9 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int alloced;
 
 			/*
-			 * If pcplist is empty and alloc_flags is with ALLOC_HIGHATOMIC,
-			 * it should alloc from buddy highatomic migrate freelist firstly
-			 * to ensure quick and successful allocation.
+			 * If pcplist is empty and alloc_flags contains
+			 * ALLOC_HIGHATOMIC, alloc from buddy highatomic
+			 * freelist first.
 			 */
 			if (alloc_flags & ALLOC_HIGHATOMIC)
 				goto out;
@@ -2927,7 +2927,7 @@ static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
 			gfp_t gfp_flags, unsigned int alloc_flags,
-			int migratetype, bool *highatomc_allocation)
+			int migratetype, bool *highatomic)
 {
 	struct page *page;
 
@@ -2950,19 +2950,18 @@ struct page *rmqueue(struct zone *preferred_zone,
 	/*
 	 * The high-order atomic allocation pageblock reserved conditions:
 	 *
-	 * If the high-order atomic allocation page is alloced from pcplist,
+	 * If the high-order atomic allocation page is allocated from pcplist,
 	 * the highatomic pageblock does not need to be reserved, which can
-	 * void to migrate an increasing number of pages into buddy
-	 * MIGRATE_HIGHATOMIC freelist and lead to an increasing risk of
-	 * allocation failure on other buddy migrate freelists.
+	 * avoid migrating an increasing number of pages into buddy highatomic
+	 * freelist and leading to an increased risk of allocation failure on
+	 * other migrate freelists in buddy.
 	 *
-	 * If the high-order atomic allocation page is alloced from buddy
-	 * highatomic migrate freelist, regardless of whether the allocation
-	 * is successful or not, the highatomic pageblock can try to be
-	 * reserved.
+	 * If the high-order atomic allocation page is allocated from buddy
+	 * highatomic freelist, regardless of whether the allocation is
+	 * successful or not, the highatomic pageblock can try to be reserved.
 	 */
 	if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
-		*highatomc_allocation = true;
+		*highatomic = true;
 
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
@@ -3234,7 +3233,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
-	bool highatomc_allocation = false;
+	bool highatomic = false;
 
 retry:
 	/*
@@ -3366,7 +3365,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
-				gfp_mask, alloc_flags, ac->migratetype, &highatomc_allocation);
+				gfp_mask, alloc_flags, ac->migratetype, &highatomic);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
@@ -3374,7 +3373,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(highatomc_allocation))
+			if (unlikely(highatomic))
 				reserve_highatomic_pageblock(page, zone);
 
 			return page;
-- 
2.39.0

