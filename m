Return-Path: <linux-kernel+bounces-13968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4527821621
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A8B210A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FBCEC4;
	Tue,  2 Jan 2024 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="rEX0qrhp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171CDA44
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 01:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ep+rYCaNMjyllSZxT+PRPHW0bN9TBjgs7YuJRYb03PNV3+l8jRz+LNBPa9hmncs33MPgpUAnWNsp+TJUGim4DmbJ19J5rQHpzBMGzQi53CklariCu+Y8nUPUExxN3T1MDOIsEBWvnHEaR3FTv55LZn3kKIZkcbxsQFazuMfY+MKT4+XZ7a8daqXSmyf/+0dJ5Izx4DxzbVTVMKg04jupjIL0LXUVMfbHA660hUcnfmIcZse5U/sM+dablZoTJoGCqhyfysPueYaKhttSKZKzZMfOKrhozMhtfPAaWDHvCwcaMHU1elJILcYmEy54ftt1IBE7q41UrBwINZBfvCwI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cP7aLvCu+UKrOocFOpZ/Pae5qB4cu0c2v/cQ7cguLM=;
 b=fgEjsMk+2fXnKfXSKzoTZB3PqDDvHzE5HMu7jxJtd6+ABElM0qqJMe9kPk0ViJkT9/kFLFTmAOL9zMRX1ZrwFz56EDSN5Y/EUWIkCUPlF8l4XukNWafe/eddrdoQ0vLLberRSNLiXj1vkJwq/l261ZHRO+OgQgnazYIwRN6hHXgXm9OiuS8JiXVGA0ZWDZ0b7FG+frc5q0OFm+6TeTOjNLj4+IznOJJSMNFua0qf95Z0I3CMVd9BYsBcmpkmQ3IY8BYaKstqGV8hoPkK7gpWo41+cMn0ed1dWLMj5PcdpdxGF/AUxpsa33GtYgpO3YvF7xVb19d11Gp9IQekS/IiIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cP7aLvCu+UKrOocFOpZ/Pae5qB4cu0c2v/cQ7cguLM=;
 b=rEX0qrhpDSltoCd/hgWSeGfNj+JOjOSQfkMS9C79wVEo+AEnFHVCDrl874aaB+kY18ijG38HkCUzXHfcUmxLBpqgrJ2EhJYGUQsY0Az/VWWRFGuQO9tld+0x6hZ1ZDkwQiK53uVcW1XKIf5ZE7rd+jLiBScVdq+KJ/r27w20rKdsbC32gLtVqkNH69chc6L6L6qTREMBhkjSzGL/dnQDk7cpyGHe5FDCCbAeQJl4ZQec+sEocX6hjStaVYh7ATqoVXIewcdJAONYX8wskBr+LFrvkNY4kAyaOFsCRsT5hjIi95MNd0FDgaBGQBO6Q1huTQJEC3zL1uhXsGH6kh/sjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SI2PR06MB3977.apcprd06.prod.outlook.com (2603:1096:4:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 01:24:58 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 01:24:58 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2] mm:fix high-order atomic alloc_flags issue
Date: Tue,  2 Jan 2024 09:24:49 +0800
Message-ID: <20240102012450.1061-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SI2PR06MB3977:EE_
X-MS-Office365-Filtering-Correlation-Id: 8235421f-6d52-4ef9-cf34-08dc0b31a27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hNbmUPm8ACfoOLqbVdVxgKavaiTDSBbmab+iueNUvwG3jdYXpe16+aHxg2DVRGOZDBRR5T4Dq9nFWjm22T1F9k0x+0ik/JO4iAJlj6ILu20IRLWvMsb98iEFzmRzsx1o3Vw6CZKPYoIa9wOLLpNrj+uVcoq93RltGzTdSpHLH70OlH5j9mbVQQkvTW3gCzILjgNGrmrBTqEukBMyJJ5raQ5j1qtkbIxL3P68UAQWU67dFB2GYyyI5JJKYOjlswVZezFLvePEdTk08v6A6KqQMmtjxVWDiFxGRXqjvPPGkGX48ME6FVDNBXsgmHcBk3/vS9GyI1xjLPkdQvUe4yGvPoEq7pgjZ3V1rd/+xf5ZS4YWeVM2SE0Aw4N65RzQdGP1ftNJeT7zntDdppEvYBYPrgOjVnfW2t6cyVHGMr4RhOFPiwWDQY6xLTqj+wIKLSqZWVBESmQEjRCM7fmXfo7iEWUo4MMY2kY57V4QiZu1Zm5HMdx1yoxTbeypNIFHLNMUmezvtPbNhiBKU1HTeLylaxFqg+1KqF100/Hg1U7n5BOwEZmiB9FVCTApYpN0NuPM6X9Z+cKIb5v4tYaF//8A3lQkPgIOCh/6qhyJPSR6hApTq5ZDA7+F6e19EKo/h2ns
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(136003)(376002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(1076003)(2616005)(26005)(107886003)(83380400001)(38100700002)(66946007)(66556008)(66476007)(316002)(36756003)(6486002)(478600001)(86362001)(5660300002)(2906002)(8936002)(8676002)(4326008)(38350700005)(6666004)(6512007)(6506007)(41300700001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?20ypzdj6NpJgSqpct9cNPzeLnfBXxjAkNukIkVvlX42n2AtlZIgmbGSCw4C7?=
 =?us-ascii?Q?pMKuX1AXpNbhGZKHl/s1YhjJD8yrDqL1kAXN9rxRcyVIvxJQ/n2IwnW6rzsv?=
 =?us-ascii?Q?Yo9/ikmcUVfITbdxUWAs7ylJCNmCqUJs0SkFQsV6nkTIz/09Pq44wH0rqMl0?=
 =?us-ascii?Q?SrxFmdbIL8Iu95HDvNtaIGqSbkKkzuMNJvGlKM+mrVNp1LU8NhstJwIwg8bS?=
 =?us-ascii?Q?IoRv3xN4ZmeLS8mvwT6+25d1Dv2F3Ce0x9E3wcOZuw6OtdZi1OiJohSAEBEF?=
 =?us-ascii?Q?UROPXgHI6V71Juwryi+njHhp4MYxZxO3aiV/fqt3aCBTk2fLSWr++Sv57ekW?=
 =?us-ascii?Q?Z/b9RCYS8fcKNfgr9boY1xMDFTuS/bw1mE5M6pyxUZH0AJwW7RC3ukj+jA46?=
 =?us-ascii?Q?XJfOSYRG3CQJ3pcRd4TPvOfMTkG/L5mzM1+7X3RP3FXNE0olGam4XI9Z0HhC?=
 =?us-ascii?Q?nsKO3W/mqUFZV2WbZVpdOvbnsuwVNxorbPqS0g1MT7NyCGP1vkS5Ly38V6i5?=
 =?us-ascii?Q?9Bw5xLO0q6tNqUttOe/4Lh0fNigRU5nslpPMdVgTWXxAutfaTY56P7XdeMHn?=
 =?us-ascii?Q?+ZUz5z5iwj3qFPCS6u8gCe/icDlXUmVgDyYqdG1U9PFA04vRY5Xz8xOCEQko?=
 =?us-ascii?Q?pZPCB4H6g0dSh5hs2h7lMQs+r1wy53BwZlMWV4Cw2OoqwGO0dnkkg4WE0znx?=
 =?us-ascii?Q?UPu7A2CZeB9y96j+90BDnn3sQSJHEP06TYqhcHIHePYSOXZUr96MTVqLBSSo?=
 =?us-ascii?Q?3q2O2yuNowt9P4rYW0k4Dxt8SFw6pG/X3GnFMIc/qq/nNk7fxnur/vz/0abX?=
 =?us-ascii?Q?Y+a6dGMaJe6ppkd9ATXL2GrKJYGqWERwjPPh/5rfJuZWb5vNcASZ8sf5tToo?=
 =?us-ascii?Q?RXNoYFCuC1+8w2gNxeHhFDPrQLuDm1z3ebQZ+grXQe8rtlNe8NfOWKGjOWES?=
 =?us-ascii?Q?jaI2ZhKlt2WAMljRtTbNYOUf2N8RLddvbmLXrcqf9dVjleEIV0/4z6f65gSn?=
 =?us-ascii?Q?zQsD/cOPlLVpUexEnW88FggqXRhQIFNdxIKaaGVqvVyfJq/NIc7UviNM+yDr?=
 =?us-ascii?Q?TGe+jBUQg21KqO3Mms2L3pvrLSPXzFa5lYAUo7MwEVhOEo/h/vZqdN+WLuSH?=
 =?us-ascii?Q?+gG7GVGFQ6ZOo+J31VrZ7eiQun/sFgBLPzqcxCD+hRH9z8qIyqWTj82h+UOB?=
 =?us-ascii?Q?5wkUM57WtW6ZOe5HE+f/53IjsRqs5VOvj16neisFZDJ/62DjZyJENbGlZ9w6?=
 =?us-ascii?Q?iNfPBoxh8zcZNph7gKFUYAeilGumrIK9cVoJrwSC3twW2q1cEYmtsFM0NfAM?=
 =?us-ascii?Q?LSQIqjzePKn7/DwshGwXv00z6uInwG4GEAGHgdRUsH+VFZqT9XQp/QIUkLXH?=
 =?us-ascii?Q?1Gi97FgCbWvfd0dfzA+7AKLweYbT3vKg2HP5IJaY6jPH43kPY1yFaI/vxGay?=
 =?us-ascii?Q?hX0ylQx6fgHe3IBAZvyJixMetTeuNdzMQBoV5qgCovTPtw5c15MloYOIYdxA?=
 =?us-ascii?Q?244uDMF/h1gAGnuNVW9R/rtr0AwWI5D3vZfpCRGItY4kvj5vLCBA3fZFFAtc?=
 =?us-ascii?Q?pAV/KJndxeJFyrpTg0kdoWO2n9iXzp+jxM+fDn1T?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8235421f-6d52-4ef9-cf34-08dc0b31a27d
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 01:24:58.8663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxmyxAdAkCsZtAZcOs/S2hiFdOQAJEVQu0daCzad8dmlyVmPGqiUXCn7qj7zA0qFLmt1UORNNa1eECHGAqJS8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3977

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
Changelog:
v1->v2:
Update based on the latest version.

 mm/page_alloc.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 mm/page_alloc.c

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f46af8616cac..7ac548791a4f
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2854,11 +2854,20 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
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
@@ -2922,7 +2931,7 @@ static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
 			gfp_t gfp_flags, unsigned int alloc_flags,
-			int migratetype)
+			int migratetype, bool *highatomic)
 {
 	struct page *page;
 
@@ -2942,6 +2951,24 @@ struct page *rmqueue(struct zone *preferred_zone,
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
@@ -3212,6 +3239,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
+	bool highatomic = false;
 
 retry:
 	/*
@@ -3343,7 +3371,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
-				gfp_mask, alloc_flags, ac->migratetype);
+				gfp_mask, alloc_flags, ac->migratetype, &highatomic);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
@@ -3351,7 +3379,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
+			if (unlikely(highatomic))
 				reserve_highatomic_pageblock(page, zone);
 
 			return page;
-- 
2.39.0


