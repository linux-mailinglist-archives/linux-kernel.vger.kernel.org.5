Return-Path: <linux-kernel+bounces-24203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6314C82B906
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05377286FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CF4EC5;
	Fri, 12 Jan 2024 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fxI74Co5"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2102.outbound.protection.outlook.com [40.107.215.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323F6A3F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6QN6GY1EJyBPZ3Km+xegYZYV5SZ4ZZejnVFg6CY7WG0z+XtRUhOLX0mS0U9tnJjiqCwSnpKQzqNxF4+7J7jf03BDDzHvVUMA8zbLxeXYa8Qo7R0sbjMRfUWEjy2wUViijOefp9pONvbQLM5SHzSSuzcy+6ovWQAHshFtSkM/5m3Lw29/L5VVb95QPal5GZZD5sVH1DSZg90+2MOWkbmpXDJNBWFczLCG2KcweIh1ahxUT9wwJsz2V8KzhD+PF4GGIcG2OFRREiMTqxOcwHY8GWqwSV1icraQi5dVFEcQSwc2eVzWySgKGCN8yoNAZXWkbjC+xGOke/vgQxORRfXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEMxFkW5JMYxxCjmvZ1uNxzi4tkhLTUgKt9RWXzRUQA=;
 b=B6ZBQPRKfAtia5WJQZUVi70rJWLZ/AKLWEDnnpiPP5gI87PSJiDM9Ilq1aZIIpke6mX4V66BqcltR6j/x+bNB+6Y5HpSSbvUYPBB17t9ga4I+cyW48Qx/PIYQ5A152Y5ddl7gN6m7c8QnXqCRR2aH56AZuA6J0AmA9U5tm8BsnPy68tuaS7FrFS4v+P3ey22D4pZoz99encaOOr7ZdfMS2ZQXkXEX3WoCHZ3IgHaE83X7sk3hp+GEYiWo6sNI8KPzD73vH2T167A7xmZsuxodquLuq1CEST46LGuN7ARii3q6KT5rI5k3c6O9p3iw5iotnuARkG8D/U+ZlqAk9k6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEMxFkW5JMYxxCjmvZ1uNxzi4tkhLTUgKt9RWXzRUQA=;
 b=fxI74Co51H1IUncN2UZuHfiO0I+OkAaEZqAFTR8MUDaCwP9c57bV1j/wpg1oxK+WnYJp5ovu0PluZHcvJJEUnIeNqPrW+u+uF2jO+BrkY7HUiFLLWcCrN09BAKkjMpaUvnakFBJo2zZhcvlTtcw2/3d0PQTRloJXMKlEWndm9vOrMOazhKFkDvofunZ6yPaQnTfG573JM5yuQEfa2CxAVTJ0s+tSipyM8u3KsoV/JRXU9h2iOzDcWOKEo0UGDW/pPU91zvAEiQBYHsraOPcC3az+8vP7j6lsisgQVmYcoiATux4JSL8Bs91GDdyjX18ces+8mkUQZUi3EpJHLnWMsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYSPR06MB6338.apcprd06.prod.outlook.com (2603:1096:400:433::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 01:15:15 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 01:15:14 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] fix high order atomic alloc flags issue
Date: Fri, 12 Jan 2024 09:14:45 +0800
Message-ID: <20240112011445.1351-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYSPR06MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: f80586cc-4eaa-4a85-fcbf-08dc130bee8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y6TOnbBykqJAj3o2m4PjQL/Z0GDC59y0E4Y+QqixtFOjzFZkJJEO/FjZA4axoN/lTBUP5UHhnAoyX0ppSO4o6ENzwjJOpViRRkYOiNJwqrE6oiXMgjaMV4rUIhDpsdLAAzW+SMDsIQojq939Ij865sSA2Y4UJFypoPq8TbErleVTWDmzVzO1B05PNuRCS353IMPyuvyeN0XxyASJtALQcG4diM5jFz6C9hDNYaJttWZ3fKfHUFknAld3zKwxH/LC+KgnJ/dMxcr0h24Xg9cR+uLwsot7FhC8Hev1Eu6F+cXu9yYctyDKvJykmyAx4WdpD3SvnY1BZ376duHsmYWLsP/1DofmP5fm4u6+De0abLUgI9JpQ6u+xxdCXisxxAw8Lj7hMAooU3N+eCYaKLJHm62Od/WogIsCVMr7BLdsIh7ncu0PmIxkotMBHOzIpNDjQsx7kqBTKl2Kh6+u84c+rHF0s3oD1NPKbvhfZX3b8+GtmkVwSVURoMEsjgN2YrjqC++XJJoQPJjODXo1YwOuahyt2RCnyLi00SsVrxGfcHgA5VYnfx9WkUexz0R4oT4Or6QIsE+7Fg/SmlXCNEZ0IuFZAmaYym3K8z7uCVu+CD76EaTzYPZSkbGW3vwhW1dt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(5660300002)(83380400001)(8936002)(8676002)(4326008)(2906002)(86362001)(2616005)(107886003)(1076003)(26005)(6666004)(6506007)(6512007)(52116002)(478600001)(36756003)(66946007)(316002)(66556008)(66476007)(6486002)(41300700001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wb3tm/L8OPwURQzve4F36BnZPvOZ4Tz34/0+yDf0lNZs8AKvD71sxN6lntyK?=
 =?us-ascii?Q?ZDYBK8sVYIsCZTok3wXyNW7IPZc/69yzyDcQfUhymG98CtzUsr/qJYH9LQEr?=
 =?us-ascii?Q?1Eqxa61XKHYeGxbk5+ku+a4cxTuNM8NP4iZv9SdCrHY3Pt3wJgJL5vqFJT3Y?=
 =?us-ascii?Q?ZAtcm9jfQL8KOXxT5mezPC80yBIo2z9CMC7QfU0ccTYVaTsAK8WlvD2MBwFe?=
 =?us-ascii?Q?byz2vw0XdTlK3nC1exL1k+BRSuuRtL6Omth8qKWIIvH+cTjMX9N1Vo6mWWFM?=
 =?us-ascii?Q?JjnsSs9U+qGtQ8KIA93/St096sKcwHaLEDaSim4Vi6m+HOdDWj4jj7MD1xlL?=
 =?us-ascii?Q?rrhgYCak8ML85U98THI0gymNWPJ7QKz13oWdQbcN5F5u0w4inhAl25VjA/Ov?=
 =?us-ascii?Q?lqN/HwzHiFUM/T0m7rdNv/DqYO3vJU+/etmhYx6nV58yh1Qn+pDnqpuq6KCp?=
 =?us-ascii?Q?t97XvyZnL6UObk7hyAOoozfo3Xy+HSZ/AiXOCvtBdTUEAEGg+iJmmNLICOL+?=
 =?us-ascii?Q?fIX8z09KTyrwXEgK7wQOaG55PpWwFcP55xuV8sTqlu/Oey+ECmnv+xewqFBO?=
 =?us-ascii?Q?Hi8IWt30VSkJ7+5FT9q34H84RJwdgdvvvs+xLql0RXTFOIDaNGe7MT4DM+4j?=
 =?us-ascii?Q?ovPX8Y007RGgCxeOPZk6rRs5LHGCGXonuXXs1IkzKD1jVI/v+frPuehm4ch5?=
 =?us-ascii?Q?OB7FNs6uTXasLlL0hr4QmXrTeDicdfJtMiA1F1RAD9y+RBZOJZQI0w46tk46?=
 =?us-ascii?Q?l+lIENiHALToOSWYRdqL2vQ+cSGBqaSVte1JeLo8PAMUFdR5P5CnquafLUea?=
 =?us-ascii?Q?a/ZWRso+q3z4KK3KMxzXhp4ma4Nmw/TEBJYD87UhMfUitXuLQJgrfZ4b5T6b?=
 =?us-ascii?Q?iOYKrLArPSLZ78GdAOuFYZTBoP41MCw5Ut31fYyDJ469IgilxbJUsvesCl2H?=
 =?us-ascii?Q?GT58p76X1AzSWH2Bt9ZTHBlAqVqjibvNZQuTTw3C2zDVurLxLApVvwRZlUIU?=
 =?us-ascii?Q?32fExsSWSW9UjcC04il8naUhjFcO0DCUfPp326wxVbxtgoyZMmNCtfMZ3ktD?=
 =?us-ascii?Q?O5YZNTlt1MDT6rWXWXyuZQqRad2c5y8uiYf+kpYK19Fu5Hpx9rWQIR/joraO?=
 =?us-ascii?Q?h7Ybn3sfJ5IlO9YndXdVTtgDWv3qH6ZM5OM/vR7NsOEPQnAZRKJ59rl2f1/j?=
 =?us-ascii?Q?jnRIzTv4iPS3n07HJG8h9+/ulv5RzVBwPHhk9gYnVrjuyPUC+8DV8gkVjJbo?=
 =?us-ascii?Q?ugoQlRYwqpw0llC0KhGmoGRz8e60PUIV3SkbPVU2Bfk3KTfFXCKZqdyNG/Tq?=
 =?us-ascii?Q?lfFxcNTbxGAc7G7jezOWsRdRPurKwBHB4kFO67g7D76zJG8Ig6wt4rMkOuQ5?=
 =?us-ascii?Q?G6IYtV6K/Xf6uUI0AUegtXKvbFIVlb9f2XQTtKMpzUr95oiDpIBXK7CxY5iL?=
 =?us-ascii?Q?XsNJ8FQgG/y1bK1GjsNYbi+o9HWfm9AZb5KVgeWeBsZ98PKRTpGB1l37K6wu?=
 =?us-ascii?Q?Pmz6BMD4NDiX/2YjbhJassIrBidCLoxn+f+0X/kAhgcxtszGXJf0VNOvPrvW?=
 =?us-ascii?Q?aeQ5ramU+PkSk095OLKbhJwJylWwslvY4QDdThUh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80586cc-4eaa-4a85-fcbf-08dc130bee8a
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 01:15:14.8755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9D8zVe4I47CnRcF5DGoCeA3WOEHtRb8WoGrpD47dQrWpl5Bdep1/zPZuNxOvoj3YoXiG3OcqmyyR5YIiyEygQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6338

In case that alloc_flags contains ALLOC_HIGHATOMIC and alloc order
is order1/2/3/10 in rmqueue(), if pages are allocated from pcplist
successfully, a free pageblock will be also moved from the allocated
migratetype freelist to MIGRATE_HIGHATOMIC freelist, rather than
alloc from MIGRATE_HIGHATOMIC freelist first. So this will result
in an increasing number of pages on the buddy highatomic freelist
and an increased risk of allocation failure on other migrate freelists
in buddy.

Currently the sequence of ALLOC_HIGHATOMIC allocation is:
pcplist --> rmqueue_bulk() --> rmqueue_buddy() MIGRATE_HIGHATOMIC -->
rmqueue_buddy() allocated migratetype.

Due to the fact that requesting pages from the pcplist is faster than
buddy, the sequence of the ALLOC_HIGHATOMIC allocation is modified:
pcplist --> rmqueue_buddy() MIGRATE_HIGHATOMIC --> rmqueue_buddy()
allocation migratetype.

This patch can solve the failure problem of allocating other migrate
type pages due to the excessive MIGRATE_HIGHATOMIC freelist reserved
pages.

In comparative testing, cat /proc/pagetypeinfo and the HighAtomic
freelist size is:
Test without this patch:
Node 0, zone Normal, type HighAtomic 2369 771 138 15 0 0 0 0 0 0 0
Test with this patch:
Node 0, zone Normal, type HighAtomic 206 82 4 2 1 0 0 0 0 0 0

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/page_alloc.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 mm/page_alloc.c

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5be4cd8f6b5a..ba4a3adde9d9
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2853,11 +2853,20 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int batch = nr_pcp_alloc(pcp, zone, order);
 			int alloced;
 
+			/*
+			 * If pcplist is empty and alloc_flags
+			 * contains ALLOC_HIGHATOMIC, alloc from
+			 * buddy highatomic freelist first.
+			 */
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
@@ -2921,7 +2930,7 @@ static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
 			gfp_t gfp_flags, unsigned int alloc_flags,
-			int migratetype)
+			int migratetype, bool *highatomic)
 {
 	struct page *page;
 
@@ -2941,6 +2950,24 @@ struct page *rmqueue(struct zone *preferred_zone,
 	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
 							migratetype);
 
+	/*
+	 * The high-order atomic allocation pageblock reserved:
+	 *
+	 * If the high-order atomic page is allocated from pcplist,
+	 * the highatomic pageblock does not need to be reserved,
+	 * which can avoid migrating an increasing number of pages
+	 * into buddy highatomic freelist and leading to an increased
+	 * risk of allocation failure on other migrate freelists in
+	 * buddy.
+	 *
+	 * If the high-order atomic page is allocated from buddy
+	 * highatomic freelist, regardless of whether the allocation
+	 * is successful or not, the highatomic pageblock can try to
+	 * be reserved.
+	 */
+	if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
+		*highatomic = true;
+
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
 	if ((alloc_flags & ALLOC_KSWAPD) &&
@@ -3211,6 +3238,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
+	bool highatomic = false;
 
 retry:
 	/*
@@ -3342,7 +3370,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
-				gfp_mask, alloc_flags, ac->migratetype);
+				gfp_mask, alloc_flags, ac->migratetype, &highatomic);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
@@ -3350,7 +3378,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
+			if (unlikely(highatomic))
 				reserve_highatomic_pageblock(page, zone);
 
 			return page;
-- 
2.39.0


