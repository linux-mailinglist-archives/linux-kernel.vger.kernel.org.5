Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B34782602
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjHUJFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjHUJFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:05:05 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2124.outbound.protection.outlook.com [40.107.215.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF5C1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDy076UBqa+Pl+WqnSIoLKuR/+S0Ymy4XNS5umDpnpIkyBSlKpF5iAy8Z507WipEw7YtjU3k2XJTHZoVFWOj3Lbco+7kc7fguJrSOCXOV3KjbAZqAB1xIO0fHzXppITpQkGS5tBurt0kCpP6X00XTrJkxpnCvgT6DBPY6kRVCwEij9j7fh35Q+wGxYXfpLDSVh0szV2n7zTbghNzRxumMlKe/ULRGdn6dKEwOJnUR90XtClLt89IQg6mmpOGpKQlXn1ovrbETEOw6+S0S9/y6BKqY0vcbPmsLhWZBqaEgU4KAvUxDc1XeFsEyhpqFU3nezj5IE//bp4F88vf1zh5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/t6qNiGCo4BGyRINUotar8Fev75t48czW3tiwz18c4=;
 b=VSjocaxC7mdpduGBm+ju6sKxJ5BrcHEaP05nWBCgKFK+diOciReoWXC9NvBxOpF3JCRCivHObB9G4GTCREabr7rUru3di+mwd/lHELfpkt/tO7y+510NVVD/j+2+fT4+ebiXXhsniOx3RAUTpJznSRFo+IMkXrz/tayGWoY6P1JMm5y2SgYkpbuuD6B/eRblp3UDn4yIa8AWU8hhJNPq0PSu9Fv+tMY2ljyLeUP0NWT/CV0nmX2dCDOyQ6ynTtEYN1O1H/LFBVwFmxidJgbgrbWlUy/hhAAQnHPiS4a8J213MJLacQmSveJVO5rGMfFs/fROfBn8huJGTy/6flEPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/t6qNiGCo4BGyRINUotar8Fev75t48czW3tiwz18c4=;
 b=Q2k3kcyRLf0zo6HjOyVTbw82YAsvFLNJw9qw4hmnj+gpIg5rJCxNyy8w8UPUmB2XBaOaRu2ZdqOYVQ9zg7DiSqXWJiuerBq+cIREOtDlNIWgCx4jS9phvMTzOdI5Xec4Ap7oGk7IGQtQU9Gwy01qz5n8hutaK0t9WyrEs4dqTbSd/tSXQmMwrxt4ZeGBmihY/ij6BWa9OcRGdmPKmTw+43oU3VzGuqiu6APh16LsYwNjLu8G+qH4Gpyhe0P8TUTWHQsTHFQV76yJ36kbydF+gPKZKakWDuUUzr4b+BVYhFVX/i/BaH6+E5u93n7xO314zK0zE5jk7v2mc+aKZMoNnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by JH0PR06MB6557.apcprd06.prod.outlook.com (2603:1096:990:31::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 09:04:58 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 09:04:58 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: ALLOC_HIGHATOMIC flag allocation issue
Date:   Mon, 21 Aug 2023 17:04:49 +0800
Message-ID: <20230821090449.939-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::28)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|JH0PR06MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 274492d5-b892-41a6-9acf-08dba225b177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUW+m5Gz6jESAgjT1cenl3ymXGI1+BUXtxtytQdxmmgPb16+cTfWbd2nk0z1+gpahm6nvX1MYBnVpjQASAdvKqMU7HyNP+QCId6qv9nBbD83b7HK0Usbsnd/NvSivAQiO5Ci00yO1W2o4xZKaQxCp+bm50dIoqYB8so3gFtG751zU4GUrFfFNG+6RImIAupcvQk09JucFkg2oiRCjaF1EojOy61U6RecT24BRHdNOVxMJZLJiYsU9tI28dp4gpXKfrPGV+3udOf106+2dSDyppXIiOCOwYb0TeQ0+V0x9dd99sQjAXKQyLwWpGfOigVy9hVDj9KicYayys3i5n/j6uMXVXV+kYucQChMdRAWsqqrkRwglgYc8JsZY2QlIjS5FX/B/CCu23u2KOkgAVNXxYwI87RNyeK7ovQnmDnjdHz+GD6pFYWS3yq6Xss+9VHes0boh++TDI7vW3HYyAPhz3btx1GcU2NIYUH7A2zcEYdAWXYzR//u34YmIFM3oga93V891y0bzB/TFIqcCntrn/4GtKn8DtDz3dduz1Wb97jdDVDxFWjYjyv4menLA1uROz5pqFicGC/Epesv8k9caTRwKrevkKYko/J06UYNb18LBRVhtf2jPH7WHjrh2SHS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(2906002)(83380400001)(52116002)(38350700002)(38100700002)(6506007)(6486002)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(107886003)(4326008)(316002)(66946007)(6512007)(66556008)(66476007)(478600001)(6666004)(41300700001)(36756003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8sSHt04dJ/9tJkPaVPzRu+eQ+cW6bJJVLJnaGIzxb1Qy1VfbeN7/oRN7Nt7m?=
 =?us-ascii?Q?ohHLsulwTFtl0oKgvr5v/FqCNSSkXuCkxR3LqXO4G2X2VFtM+ZikbqogoVVK?=
 =?us-ascii?Q?B4RJElbKHf+Mi7uRbeEXMn8JAM4mVj/qLVpcLVaKR5oZt7erBlTy8j7TQ3R/?=
 =?us-ascii?Q?pIfmJfmrNkDmaAk0o3U4jEIbUahVD78REwhxuImJhpf79Wu7IPjFBVOzTAem?=
 =?us-ascii?Q?JGCg5OcCFEIrJbx+Zbe66LOymGv5XG3hOSf+WbpyAU2CXrAB1SLF8iZrZ5I/?=
 =?us-ascii?Q?x0iE+yGErnymo4M8bNvTMeEDNeaObEaABQ/80u72e4qN3T44ZDfWjsg27tDb?=
 =?us-ascii?Q?xqXRbTthNt3hGWs+H+fB/CkZo96aIM+WyvcG2aQ0L2hwY3Wmd5GCX0E1/rAZ?=
 =?us-ascii?Q?/6t07viOMYw/SxxwZX0DlGya08+HRDXnn4ADDL8PG4EpPHjYpU62LRCl37Fc?=
 =?us-ascii?Q?IrwJvl7ukPWYK2UvHoyRlrguV4izcigTjdbZaEaG6VVD7fwAuxb4y1F0Am4f?=
 =?us-ascii?Q?7n3EHLZQgQV6lPO+O9T7uVOtv/9whldBaQ+7z5SG9Bx5/gTeuZp1WBZ9xwto?=
 =?us-ascii?Q?SV+1fGffeE8EOiHFuAvnEKJf+8l4jS3ZHNIip1CHcPNrXh0q+VYitu5RkTTs?=
 =?us-ascii?Q?sw8ElxEyxqAUTomLLeLJtIfc5aaccryaU1Vf0obWWPWuDjF89hjXPQJ83VbY?=
 =?us-ascii?Q?ymvT16dzV83HJy3aJ2obYBvwR9+hjYLnE56PqymZ9aCBAOYuUzRlZkEGvi4r?=
 =?us-ascii?Q?FUmi89fTPR+t7yawDMXsQlabNck7cdJvdv+upW7gEjBKnqU8DjufJp9hgr18?=
 =?us-ascii?Q?kYgFlBa5AbDelcq/wvoao1nrAKjYdoI7EbEY1pwf5laPfyCWySpfLmDOn8lE?=
 =?us-ascii?Q?F/jAU73+g9gS1FpMcarLjZFXtJgmzXJLqITpvxhRgDllNYmniCT9T6xxlHu2?=
 =?us-ascii?Q?MpEqjeBiTdHms1h79S1SbWJN+Zyqo8EUv0KyM8qObSC9SvYEaufeRSwwST+D?=
 =?us-ascii?Q?Gik05ZXrkjxiRcibG5hz1DYpQ4QbhCO9VMWNVHpO6ihkJu3dFoznxUjeMYy4?=
 =?us-ascii?Q?sd+/5X/l9HM1VEKaoG9VFlc6G1KGlrw3Hvx+xFNsTr3EUW5vdLdhT6bahi0c?=
 =?us-ascii?Q?GxA2FBXr8zwfDKj8gfEhfQ6Dloe29xSYdnadCX4A6+VN7B3XGycbXvyopTf6?=
 =?us-ascii?Q?itG/f1/S+Ej2DDu7ejCY3mp2IDGbuPXfetZpLYOm5HTHuHk2lEJ/8CAuS+Cw?=
 =?us-ascii?Q?KwL8pONScq78BhEj+A3hbNLyIQW1t8FMFmOTmvEDL8722fPFolc+G7167lzd?=
 =?us-ascii?Q?iqwNQmfQKOakJCdy4iT+OqFQMehyUFy6lH1Mp+tjyMldIjYUaGcYDX/BVSha?=
 =?us-ascii?Q?l3ApxT4P2Wbe5aafY/hu7fB58uA4dJpWXeBr12jbNFzALB3WomKBOacMDOXR?=
 =?us-ascii?Q?8D3iFEg/hwykBiqTTOpHRHk/Ud155TwPWViARJKVwRjEARyFvSAo23Uf77G2?=
 =?us-ascii?Q?804cxt0qT+g8Oes86BStIY7RqubrohBHUs5ywK5q0mTGL6BNLCebVH3A4PaX?=
 =?us-ascii?Q?gR+SwMpIdU+f65xRThxnoZrEvd57XZZUpdd+5ZnD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274492d5-b892-41a6-9acf-08dba225b177
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 09:04:58.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kF74CfYImBMh/RlsD5R3j5KQSfy+lFh4hHsMLmA4dLelNT2Nvkwjz0Dr6zx6kkMGnXYCF14nNLQdd59QaTLBWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6557
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of alloc_flags contain ALLOC_HIGHATOMIC and alloc order
is order1/2/3/10 in rmqueue(), if pages are alloced successfully
from pcplist cache, and move a free pageblock from the alloced
migratetype freelist to MIGRATE_HIGHATOMIC freelist, rather than
alloc from MIGRATE_HIGHATOMIC freelist firstly, so this will result
in an increasing number of pages on the MIGRATE_HIGHATOMIC freelist,
pages in other migratetype freelist are reduced and more likely to
allocation failure.

Currently the sequence of ALLOC_HIGHATOMIC allocation is:
pcplist cache --> buddy (batch >> order) allocation migratetype
freelist --> buddy MIGRATE_HIGHATOMIC freelist --> buddy allocation
migratetype freelist.

Due to the fact that requesting pages from the pcplist cache is faster
than buddy, the sequence of modifying the ALLOC_HIGHATOMIC allocation is:
pcplist --> buddy MIGRATE_HIGHATOMIC freelist --> buddy allocation
migrate freelist.

This patch can solve the allocation failure of the Non-ALLOC_HIGHATOMIC
alloc_flag due to excessive pages reservations in MIGRATE_HIGHATOMIC
freelists.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/internal.h   |  1 +
 mm/page_alloc.c | 22 ++++++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)
 mode change 100644 => 100755 mm/internal.h
 mode change 100644 => 100755 mm/page_alloc.c

diff --git a/mm/internal.h b/mm/internal.h
index 7499b5ea1cf6..a3b3fdda8031
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -844,6 +844,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #endif
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
+#define ALLOC_PCPLIST		0x1000 /* page alloced from pcplist */
 
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 442c1b3480aa..afcd0f875c92
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2722,6 +2722,8 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int batch = READ_ONCE(pcp->batch);
 			int alloced;
 
+			if (alloc_flags & ALLOC_HIGHATOMIC)
+				goto out;
 			/*
 			 * Scale batch relative to order if batch implies
 			 * free pages can be stored on the PCP. Batch can
@@ -2736,6 +2738,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 					migratetype, alloc_flags);
 
 			pcp->count += alloced << order;
+out:
 			if (unlikely(list_empty(list)))
 				return NULL;
 		}
@@ -2798,7 +2801,7 @@ __no_sanitize_memory
 static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
-			gfp_t gfp_flags, unsigned int alloc_flags,
+			gfp_t gfp_flags, unsigned int *alloc_flags,
 			int migratetype)
 {
 	struct page *page;
@@ -2814,21 +2817,23 @@ struct page *rmqueue(struct zone *preferred_zone,
 		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
 		 * we need to skip it when CMA area isn't allowed.
 		 */
-		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
+		if (!IS_ENABLED(CONFIG_CMA) || *alloc_flags & ALLOC_CMA ||
 				migratetype != MIGRATE_MOVABLE) {
 			page = rmqueue_pcplist(preferred_zone, zone, order,
-					migratetype, alloc_flags);
-			if (likely(page))
+					migratetype, *alloc_flags);
+			if (likely(page)) {
+				*alloc_flags |= ALLOC_PCPLIST;
 				goto out;
+			}
 		}
 	}
 
-	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
+	page = rmqueue_buddy(preferred_zone, zone, order, *alloc_flags,
 							migratetype);
 
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
-	if ((alloc_flags & ALLOC_KSWAPD) &&
+	if ((*alloc_flags & ALLOC_KSWAPD) &&
 	    unlikely(test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags))) {
 		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
 		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
@@ -3208,7 +3213,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
-				gfp_mask, alloc_flags, ac->migratetype);
+				gfp_mask, &alloc_flags, ac->migratetype);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
@@ -3216,7 +3221,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
+			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC)
+				&& unlikely(!(alloc_flags & ALLOC_PCPLIST)))
 				reserve_highatomic_pageblock(page, zone);
 
 			return page;
-- 
2.39.0

