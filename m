Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54537E5084
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjKHGyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjKHGyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:54:23 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC81A5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:54:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNTTU2Sz3ISOUk2WEJ+V9APMeBuNaCvIX7Y5M5uu0UnS5VcoD3d3trM9gzL0vF4BH90hsLq3n3upOxMbCKm/tMoH/qBw6REJ/nqrKluCbOGvzcpsbWVKNXHOuWHWH8uvu2QkYl9sOseLCub/iS2/dioYnYoDh0DsGcqaQn0IxItfhE/NOCVBjQh/J/kdN35475vQmhTwX/Q/5wfdgaKKYDsyqxbosyQ/RGaJHotRz6DwxAfbGES812F8X/HAz8vAg1no30L/z4npaqXGEcdiTnhj0n5juZ2y1rH5zVeZFtor1wsk0OsPuaCxv1Uaf2PCfG/yrIvu02pMEreOSgYp4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTKL6hv9rnjKa07vZUoUXnRqrAT19zfXagwRqdx46IY=;
 b=TuwFVgUWdYHYG4pFoQdUboB5RxOIQhGuhTjLYnu/jr/LjQpYt2C19Py5ygx1N+03xfr95lIANYCNrojzYRMfs+tEsfMcllABsoHmnz9Z7MpfZD7LTueGxPkiyIEo+ujoqASfbJmg1p9ETL6mUpAQKi8XFltghwBX8xoHBBzRB/YiaeIx+uQPyK7mizsE7tN41y0HmVaOgUH8KGxmrGQ+xVsqUUozB18QfQHmT7yjPkAABHePAJgev9a8J+Awrho2Et2xg4o7FdYuU0D9Syeo/UHZnMIZhX+6D1EYRLQOaMmoCQ11hBpVQ9dqqku9OoUKvcCnP6pTmHKAqvkDqkZKOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTKL6hv9rnjKa07vZUoUXnRqrAT19zfXagwRqdx46IY=;
 b=NXQO2lpOgDWDz+ZYI9wqkSuWsfCMyjoE+X59irMumpZ0m0E5JjmBFom32SGzUabwKi/czi7zXEMckHuLfrmWUvfjdp5uO5xbP3Y2AvetHGwUdL9YrK+lCJmuEOluQ5mZHjry3JDuvJy3L3XP3INKV4w8gwlLRNNbK+61XU6Cj8FZQwZR60Pzks39fg5dNvMxkEwQYmq1W3JdcVUxo0g+RnpGiQDI2fA8gKWN8waAhD1hqbBBQB7Vsd6ZN03uLPOUTC5sHxlcXS8Zxa/lcfeV33PXu/rWn17AByUXR4oqM3Apkb+0E0gQMuOG5FehcwaDHjsoLfJttRruJDWEWArwkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYSPR06MB6314.apcprd06.prod.outlook.com (2603:1096:400:417::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 06:54:17 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 06:54:16 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>, opensource.kernel@vivo.com,
        Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm:ALLOC_HIGHATOMIC flag allocation issuse
Date:   Wed,  8 Nov 2023 14:54:07 +0800
Message-ID: <20231108065408.1861-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYSPR06MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 4652b093-a020-4652-483a-08dbe0278668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4FKmdvHRal29dYb5glis9m+7JAObOxJq2/Ex4GdOkMbLl5uRD8ENg/a3eZdsCZ+Vdi1jvBVOlAwYCdMM+DnnxLeji8dgXTnuZ/E4FkNIUGj8cx4+SmFwXprmoT1aS7ogMc8/eLkuvHf8C/mDXwIc45i8MEvjAKeE67lG6QGIrTn9TiXqTTZzpeOwtvLSJ6tQOjsQMn2mXDo386zsaDg4JC0wv4Ck+Pf81P2Dxf0KUzbGycahDmJUWiCnaJxAdC9kJSc3+LnsM9rdbjD6uxOmglioR6LSk2NpVQUhPYJeF0A79eUiHAcQyk2ap8jEzByeoHFlgiRESEcRD16pGXnGeCg4g6dDYwMx4iiSGXJGiyNsl7gUbxy0YwkgjFjIHqRKDpyTSaYMcdn3NDIh05wZWOF82cydx+ke4OAMnSFh1U2IUorYxjh7vpgifCF3alo30GpIRkfgINCQkke7Z3u2prq69LWR+RC4/PeJQhL1JXqKExR2a1u7STF9Ni7foNhdomO42twY/XfD6AYAsGWzsM8Muk+JXg22wfTG65RTO/YpebH/A3y4+Ygpf6Ess6LUyOd20of1JUFamFDCxLkD65f/O+HWh0THpW7Oi6yR1371MDYPAkV9T9+naDmvtF8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(41300700001)(83380400001)(38100700002)(316002)(5660300002)(478600001)(107886003)(52116002)(6486002)(6666004)(6506007)(2616005)(66476007)(66556008)(66946007)(26005)(6512007)(54906003)(1076003)(2906002)(36756003)(86362001)(8676002)(8936002)(38350700005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tc/7EH7STe7hiXNVhjLt8LLhNT5lJCg4vW9Tt7tE6Oco5tWLbQezUzofVVi1?=
 =?us-ascii?Q?ap/jw4BJp/i0p9yhiVyxOptljfmKwzyzkwCAK0ehaR72I9bZ4XWq2no/3crR?=
 =?us-ascii?Q?6q/XyrUjF3tvAUKRZ5uIJV9bhmW3eLd1OsmPy5EbRsV98Y0Z9n5HWLsCsoli?=
 =?us-ascii?Q?oe02TMWj37rH+bFFy6ZVZR4dYBUHCeWkUJ6iDKUxtXk+Lqp6UcRMKiJp87XH?=
 =?us-ascii?Q?UXPfgcIFPdICHxiJk/fDPA7vAlbOrXEEE87Zp3pjju5A+l7cFDS2tEOLDAeb?=
 =?us-ascii?Q?Xd82S1/QmxXUJhI5BScLcr7iABAuJRuJVdELwb9jKzeSvGxuy/WATPkJajfS?=
 =?us-ascii?Q?nDvckUDW90IvcFrasgDWMVqTQj0yfkrVpyMGEXRqMVcRlg/qJTdplftEnAcH?=
 =?us-ascii?Q?AQlawycuZLR/fcU7DNwga+psna9PNzzAtI34r3h5AGFxrcjDgvnm6F+XOlZ/?=
 =?us-ascii?Q?jfhlgObzUKG7ZJ0a44btKQT4JlzpFh2gmvjRlhdcBNxZRp8WpwZqGDIbAhAh?=
 =?us-ascii?Q?NvOFhzpPD4uGgzVMymkrjw/espeVmBkNh3PQfwdQqH1+N01wycV/t624rJ7y?=
 =?us-ascii?Q?/vYRaEp6i0Db+3SJvuRveg4sDXZjEDKLCNap79GmEiX+/Kog9RM9a908Znr7?=
 =?us-ascii?Q?QEAB3hPXyYJMMteX3V4i41Qw8IIgrJJIA2rspW1rTXpYeLaqSNhx5++u6q+p?=
 =?us-ascii?Q?kN/xcC0G782B1NQAHR1n1thJvgxvoHDzRmi9V9+9yQ35GmjyoPinje7C1c9F?=
 =?us-ascii?Q?QF3ATikVlJ7oI22vjnWYBe2Nu0no0r4M+MqYvuwCivfDRquHTO8fKVy8Up49?=
 =?us-ascii?Q?FJ+Uv82LbZXZj8xrX4JEqJ1PPSm0S9zjZDYKagLd6KpJC9bC+4nSA3vI8M/Z?=
 =?us-ascii?Q?SbQD0xyZAnspxWpt9yF23PEHypkcBQiVuzJOtJXRU7BG6jjJqJ57QtmB/A/N?=
 =?us-ascii?Q?hVfXY58O3WY04Sqb7Fur4c1Lke1adef2DyaRxdRcaF/9LbYIbVYVwWaZlFQ7?=
 =?us-ascii?Q?GVfU/QeFNeo0F7BLHE/lCfy933A1TwEYEnZgg0gKDlwlNrLv3kZlPPayfUe9?=
 =?us-ascii?Q?7iQcdYZ6e8KyEa+ONspPu7tla3Qs6WEsGe9nAlqHswCZ0mZgW3IS32nB1n/X?=
 =?us-ascii?Q?4ycBD0GEU3S21cCEA4AcgY0KJ248x7U8b/iE/2MH6UCVrn7lX2+0nK3z7y4Q?=
 =?us-ascii?Q?YMIZIUOAbp3v5ub8ScVN3OE1Sp+8hw/28WuIq2af4WEUbw4THz5HQUTxf4aE?=
 =?us-ascii?Q?zVOT/AlkoMCbpwe+2iJ0KQafyll0+btoYJ0sQ5TMxPJeUGvbW1UnOeR7KZ8G?=
 =?us-ascii?Q?JiTZwyO9v4J4emSOBcMzTEIosOGwUWF1AithISBmKCKlVZMK+1eoGfO9Q50q?=
 =?us-ascii?Q?QihQLAgUohUfzIwNTanY/WyAXp9sgUgojIsxf29pneFKKcN/iRXYLc3omE9g?=
 =?us-ascii?Q?kMWc/BY7bC4iNfvRda7h26qMTUVfXoPYiQW+ZGUZfbqFmBwSvMiGEJ11cqxM?=
 =?us-ascii?Q?ClUHcVvp2QVfLnhEydm2MYs80uqUvdVlVotk04WZvTEjXdjqVX6QokXMAs9w?=
 =?us-ascii?Q?7XGPjVC0tvmPjIBUgcyS4ReC3PcHiLx2DHMMc2h9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4652b093-a020-4652-483a-08dbe0278668
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:54:16.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2t317KZ+gsRZJ5hXE/wlzbj1McFYoT1lGxMH7y1j/+z9CI6QMxtxSpNQNSyOKvcf4rm/BVCw3MXCpjFtJ9ZN+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6314
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/internal.h   |  1 +
 mm/page_alloc.c | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)
 mode change 100644 => 100755 mm/internal.h
 mode change 100644 => 100755 mm/page_alloc.c

diff --git a/mm/internal.h b/mm/internal.h
index b61034bd50f5..f523242baf0c
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -905,6 +905,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #endif
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
+#define ALLOC_PCPLIST		0x1000 /* Allocations from pcplist */
 
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b8544f08cc36..67cec88164b1
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2854,11 +2854,15 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int batch = nr_pcp_alloc(pcp, zone, order);
 			int alloced;
 
+			if (alloc_flags & ALLOC_HIGHATOMIC)
+				goto out;
+
 			alloced = rmqueue_bulk(zone, order,
 					batch, list,
 					migratetype, alloc_flags);
 
 			pcp->count += alloced << order;
+out:
 			if (unlikely(list_empty(list)))
 				return NULL;
 		}
@@ -2921,7 +2925,7 @@ __no_sanitize_memory
 static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
-			gfp_t gfp_flags, unsigned int alloc_flags,
+			gfp_t gfp_flags, unsigned int *alloc_flags,
 			int migratetype)
 {
 	struct page *page;
@@ -2934,17 +2938,19 @@ struct page *rmqueue(struct zone *preferred_zone,
 
 	if (likely(pcp_allowed_order(order))) {
 		page = rmqueue_pcplist(preferred_zone, zone, order,
-				       migratetype, alloc_flags);
-		if (likely(page))
+				       migratetype, *alloc_flags);
+		if (likely(page)) {
+			*alloc_flags |= ALLOC_PCPLIST;
 			goto out;
+		}
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
@@ -3343,7 +3349,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
-				gfp_mask, alloc_flags, ac->migratetype);
+				gfp_mask, &alloc_flags, ac->migratetype);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
@@ -3351,7 +3357,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
+			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC) &&
+				unlikely(!(alloc_flags & ALLOC_PCPLIST)))
 				reserve_highatomic_pageblock(page, zone);
 
 			return page;
-- 
2.39.0

