Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4067E770A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345680AbjKJCJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKJCJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:09:02 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E17B3A8D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:08:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ykd+rnm5zHUKI+q8slq7PHmR4YbN9oPz41o25GzOVR6Pyc3FZIUaVDMxu5CI87ETSDHpKQGhxijNPK/o/LKdZsE80VncX9dzMQUOXcapJ0eWKhSQWYuv3mr6RhfeathKig9S5eRxiZTPxLkPP+PCPNEis57kFs0G6MvGaJVEKCO4CZBeD70s/CRztVmVfsaDDdYRCgjx+pwWFD8FfxnRUdmc1kz37cU+CmQvBmPlNIYwTixb5zSTS0kemxhJSy0h3bYMmGXqe5Tnua0VPU9Gs8sQr9blSmtcMVeIfpbINeZsjtvMi0NVyM41IunRYTm2Wg58hkk6ZryILzDLs6y/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEHzdTQw4QE60omPT1zzECNZ08783nqJY6cDC0sfvDA=;
 b=YTYkd6lDFJppNb+YHFW74P4lOkMOkLWZUb8RTnfeU5U/NjL2H7ZyysvsqvSzWxdc/3jiw2L0LRdNNx4SlLkd4pfiOxx86ZYYPXjR785p44/u9D8iO0ZH9t6jyD8l26ZzOyDo92zLavGoUumaoj16u4+FJGPjHyb7yi3l1V4TSPgERT8BScoqydH9idfF6CHauE5pnYcmAGXHoeuJuN8tyMcvWduZCro3g6HrHarMTxcpvKcTw9ljDFkK3d9TpS8FiqpfTXUJ7qBzTz/2QvjwIbCLGVZtUuSRuPuDqs3BxG4rYHFvko39Wjm8d8X6L6iVnrY0N1VT+y3k5IR/GIDSzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEHzdTQw4QE60omPT1zzECNZ08783nqJY6cDC0sfvDA=;
 b=DXNIrR6P8mavzaENO/FtkRWbEYJ3R7SFBN8jssZ98KNMx9Drlnxy/X+0ih5l1HJG1vmPk/AwwRYSymmc1fAY72k0cdOlAcufOgI5unh24ktwQqB4hlF073steRDpwJ9rPhDO0r+gJvuWOEQR2WvS9wsFFWZQpfY1pblJ05MmNfvw5IsnYC3xo9ppFCJ5LTMFwMv8QHQzPQf41rfFskrviCSKrveGzI9I3qWwRcal+XIOt2OLv2ZQI5gSGJH8daEHoSbbDLXButN0IB7hyVB+9INwCjCT8GOygxyIz0BJ+7beX+bise6SvLMPIOubC0IrAE8eedijr/80tCwQbqQjSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB5158.apcprd06.prod.outlook.com (2603:1096:101:5a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.31; Fri, 10 Nov
 2023 02:08:51 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.6954.027; Fri, 10 Nov 2023
 02:08:50 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>, opensource.kernel@vivo.com,
        Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v3] mm: ALLOC_HIGHATOMIC flag allocation issue
Date:   Fri, 10 Nov 2023 10:08:40 +0800
Message-ID: <20231110020840.1031-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa1ae64-ba7d-4358-0a87-08dbe191fa76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njurPcDw5IMtQCd1Nw2TvmAkK8pl5zop6csv4JZW7nKAwXbVFVx13PNVVL7a9mg6gNpfwJ5pnterXrj1gb0164jJkSTAeZ+TRgBM5ZlPtiLopShmLoZea31Kzi8voRnMmrGkgGdKSXmByk2A3rcQiP66Oq/khE5vf0mGwfBA1ovq0RUq+cEj0D6YKNgbJ//59oqGQQfxSaaEj7HmhQjeUpbUYvdBr9AFNJFAPzpNt4Hcphrn+qJqVxDnyhnJh59uHNnnIYyZ+E2VbcAjw/H6/+PmwNp1fjyRmdVTCAzsh9KG8DSGv50bSHziTgHmAgCsfgt0c2r5SZJxnbbKmuSFalRwYQWFO+PQfOe6aGZ8IyvnXBs0n/GT1ZTVfg8k7Ihee61ZNrQ/OsnszDDeR4BGgdkj/eLD8ER0sRlZ5CfATtUaCK2yeL2y7Z9z4M+9NAn18fx6PUZle35HAwUF6LWOSy8Y8xNU1GxUp7NV2aPyaACS4ATHnaTZ09XHZNu087Z8xCItAF1sfKXLXdT2q4qZqoEbwT+d+kZ3vmkikRLe6yKhmsR5Vraubu6FCezIIfiyfbaOWkAjDggBkgN+0Gq3THzRdcasFrlC/8X7dLIQ2K1CimfwS/05wOCA6S0v/KDx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(36756003)(52116002)(316002)(6486002)(478600001)(26005)(8936002)(107886003)(6506007)(6512007)(2616005)(1076003)(5660300002)(6666004)(66556008)(66946007)(66476007)(54906003)(83380400001)(41300700001)(2906002)(86362001)(38100700002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ItDOUkhu+6VHUsMSYGPTODTz4JgZg7b8qSkmO843d0a+vuYMYYVCyoonVNYx?=
 =?us-ascii?Q?hMjXj69Q348KDlhnhspCulo6wxU7eZ8AHHpCZEAUv3HSMa4zOE+XvSEfiWrQ?=
 =?us-ascii?Q?vlDS9X2uBVx6Lvnbgll/rzbxKptoLbG0u5/5Fk+Wegc3Q4+1OC16MSolfc0+?=
 =?us-ascii?Q?YEHg25QpwJNhS1+e/uIQZ9Tjs0CfLC7PxyKTa4T+zaOi3Jh3Zh9DwBrxi8ut?=
 =?us-ascii?Q?ozAbiSe/xZP3DfC2ImsunDI2HoUNc/F2SGpFBQ7D2cCr24EmrnThJOKKumMo?=
 =?us-ascii?Q?iQUXcZ+R3GfZQKV+kGmYi6AbullMnMkqzZjzKeVuJ8YKl1Fd1k7bE1CauZf1?=
 =?us-ascii?Q?6s8EfV1ki61ueckWJNhKlSDpmnGlaDKYGpcEguakSEicE8Cm0R1h8nh7AdrN?=
 =?us-ascii?Q?2FV43tGgv5dvulHPw6bAVGQFrR0P1ouTrG2XZ+ogoCqqEeZP2YaBm97DMlnS?=
 =?us-ascii?Q?45Mqxe/Upl09QdfKFXnO7ly5gN56euZyEM26Zvvvj691XGovm7Gqi1FZ8SC/?=
 =?us-ascii?Q?I4V5kY+kXzyKu5+04dcmcnn44Uuf6WpFhSLWC4wvlvxH5AfAa1xPxb3ma6uL?=
 =?us-ascii?Q?j4JC+ktkMKU+xNDjIBWFwn5fQvMYWfzUFaTJz6e1FUZcr69rPOUcf5THifCj?=
 =?us-ascii?Q?RRZfy2R9gv8YnB3BTi03YqlijMijZ31h1iFALG4I8cG2ezy7hnwxFAo6w1a9?=
 =?us-ascii?Q?N5jr3EfTApHjr+MmMMq66q7ux+TyNHF87vHnWzqjCz7TSQBxDgcK/FB/Vw1H?=
 =?us-ascii?Q?JzCSTYawdd/tUJzea7MT3CA295igmCEnQJ6NzVDvUu/ia8yaylnodzCe/an3?=
 =?us-ascii?Q?2irNcUd7VKZPlr4Sq+/iZoyTngtr+u/9J0hHO5V+UcnsxHzEK1IWp85W33Hy?=
 =?us-ascii?Q?iVJkPykEh4v7xHDMH6+WWk6JW5wgY7JsQXhtTywfO6bXko36zRz6CcrnCRus?=
 =?us-ascii?Q?JfWHsCxxiKy1AXZMgPEmOGfgcnpvE+dFbUPrI6IRmhJEKDST/gUT/pEhaICR?=
 =?us-ascii?Q?BKFilcJqdN1y1XxVjHGnkirLNQBbiVrOIAYklZtl64V3FPebL7Grgv94vz9U?=
 =?us-ascii?Q?fqhcPaRE5DK2QY51tTt4NcuA5EahqiMNHIPACOTjqPSeG8q0SygqwR+1qCxR?=
 =?us-ascii?Q?Q4TCEO8Owx88tM31hSGZBuh7uEBdcmDZ6tfFr2ejhO5VczxCaTgs1395TEHM?=
 =?us-ascii?Q?QVvvP1Lg6fz+er76ZVlLVrSVmCLuuFu9jgsCvqtCNMJE0Jk+StpRQhQZ542R?=
 =?us-ascii?Q?RGcrg+ETM3pzCrgpGqe8jlpqDlFmxuBS+gGUXf3IRsMosaiVy5+YakoUBpLy?=
 =?us-ascii?Q?3C8yjRUPKyv1FmMiC1Pj6svp7rDQ0QefgNuZ2z0xeP5nqTR/bW/nd+cpMfkw?=
 =?us-ascii?Q?N3kGt9/qY7c0PZqU1Cr0Ilea7MeWu/Ahrot9QRrUeHiRuC0O3oxoeogDZasn?=
 =?us-ascii?Q?Jz+JZemvUU5CtZ5R1+/rEH39octxCgnJGWSWfQK3cXYja86ReAno36KJFb6v?=
 =?us-ascii?Q?RsAIavo3+Pe8MHQjExG51y+kK6VVN60qGozrwxrsszgVsNy+3VaImJ6CUq7p?=
 =?us-ascii?Q?pkWhMkaviiG78E6Qahmkw8GPfdpSM8ouTTQMHWTd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa1ae64-ba7d-4358-0a87-08dbe191fa76
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 02:08:50.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hkb7uMf+ITbQtkKaX6yTTA4NNPY9H/kHjVKm3Y9U39pJDPeLOHJtNZzgyKSD3x/POuUzmyH2x8mXdyLt5Vc1Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5158
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retain (and update) the changelog with this patch.

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

v2:
Add a new bool* argument to pass return flag instead of *alloc_flags
and add the related comments.

 mm/internal.h   |  1 -
 mm/page_alloc.c | 41 ++++++++++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 98c14b16ce81..1d67c141902d 100755
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -905,7 +905,6 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #endif
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
-#define ALLOC_PCPLIST		0x1000 /* Allocations from pcplist */
 
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 67cec88164b1..3c84c3e3eeb0 100755
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2854,6 +2854,11 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int batch = nr_pcp_alloc(pcp, zone, order);
 			int alloced;
 
+			/*
+			 * If pcplist is empty and alloc_flags is with ALLOC_HIGHATOMIC,
+			 * it should alloc from buddy highatomic migrate freelist firstly
+			 * to ensure quick and successful allocation.
+			 */
 			if (alloc_flags & ALLOC_HIGHATOMIC)
 				goto out;
 
@@ -2925,8 +2930,8 @@ __no_sanitize_memory
 static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
-			gfp_t gfp_flags, unsigned int *alloc_flags,
-			int migratetype)
+			gfp_t gfp_flags, unsigned int alloc_flags,
+			int migratetype, bool *highatomc_allocation)
 {
 	struct page *page;
 
@@ -2938,19 +2943,33 @@ struct page *rmqueue(struct zone *preferred_zone,
 
 	if (likely(pcp_allowed_order(order))) {
 		page = rmqueue_pcplist(preferred_zone, zone, order,
-				       migratetype, *alloc_flags);
-		if (likely(page)) {
-			*alloc_flags |= ALLOC_PCPLIST;
+				       migratetype, alloc_flags);
+		if (likely(page))
 			goto out;
-		}
 	}
 
-	page = rmqueue_buddy(preferred_zone, zone, order, *alloc_flags,
+	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
 							migratetype);
 
+	/*
+	 * The high-order atomic allocation pageblock reserved conditions:
+	 *
+	 * If the high-order atomic allocation page is alloced from pcplist,
+	 * the highatomic pageblock does not need to be reserved, which can
+	 * void to migrate an increasing number of pages into buddy
+	 * MIGRATE_HIGHATOMIC freelist and lead to an increasing risk of
+	 * allocation failure on other buddy migrate freelists.
+	 *
+	 * If the high-order atomic allocation page is alloced from buddy
+	 * highatomic migrate freelist, regardless of whether the allocation
+	 * is successful or not, the highatomic pageblock can try to be
+	 * reserved.
+	 */
+	if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
+		*highatomc_allocation = true;
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
-	if ((*alloc_flags & ALLOC_KSWAPD) &&
+	if ((alloc_flags & ALLOC_KSWAPD) &&
 	    unlikely(test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags))) {
 		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
 		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
@@ -3218,6 +3237,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
+	bool highatomc_allocation = false;
 
 retry:
 	/*
@@ -3349,7 +3369,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
-				gfp_mask, &alloc_flags, ac->migratetype);
+				gfp_mask, alloc_flags, ac->migratetype, &highatomc_allocation);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
@@ -3357,8 +3377,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC) &&
-				unlikely(!(alloc_flags & ALLOC_PCPLIST)))
+			if (unlikely(highatomc_allocation))
 				reserve_highatomic_pageblock(page, zone);
 
 			return page;
-- 
2.39.0

