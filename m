Return-Path: <linux-kernel+bounces-24206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A650B82B911
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04727B251D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FCD107A0;
	Fri, 12 Jan 2024 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Sy/rvxmF"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BE2EAD9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0raumT7mtLW8mYdk9OjWwOZwjiTldTXybczaka4mhdkEq5Dfhf7eqlLJbVUOaRh8P3GfrG6kPqhRaOrNrtNeyDcBkMidwod6c5kIzlsY4A5swLD8wncix23Ssx1v2HDsH7pTatcBSuI6gOK7HJ+p5dVnSNcR5EMkhXxYnMTwixRBaMMB4qMQO6TXCAMSJ5qR5gmlH7N9XvpdtpxNjKndwHdi//kkwl63oC0J7sh9hiIazuwB3ds5qbrD3H4DqO37pLywRq26WoxWMQtytfzCcbRpVqnq4huUNkYpEdKXyeMyRDoYJp4g96XqbWgaJfcZQ7wCIJjjwSwqaG8zyxVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEMxFkW5JMYxxCjmvZ1uNxzi4tkhLTUgKt9RWXzRUQA=;
 b=exfFN9ltYwzjYqGZrZknfKd/Gx357UYJydVPC3utQovTvQQvz4xoD0wT/PoGXdQ/kcAB8q8TSLsyIlb5QDT3WTJBn+oQh+Yuef7+QufZdoLN17uZ/ezKXX+XgubC+2uDDcjQfu8NsOK4hsmq//FKwk1AcTLucK8e1zWAhaBgmcg0Jcn3dFIuygl2tEyHZ1nE906snehtmy6d4xzQyTEaUSyjI0QTVMVYO+QM39V/RHZMPF0tY4GqPvdUdmt6tO7pggNwfLSdNXhYo6+inqKchbJpTcQVuF7Xids37GqS7AcIbJ96kBkMeWPqAuP5Q2shAmHB1ukNeEDfzfL4+VL+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEMxFkW5JMYxxCjmvZ1uNxzi4tkhLTUgKt9RWXzRUQA=;
 b=Sy/rvxmFuVzhLuUxHPJei/EZ7lgVZx3zOqD45pH/lhvkwKgeJ83M1JIe7wHbfiqwc3O0k1AvL38v32aanz7au95lG+KXYhxhMp1k2TuWg/hLy2QSGAVNQf3LbR1XmX02L6EXAnjjgLtoU0Fk1JB7aAu7EfgqEmhiN/qHlzOpz1ASCCFs5bIRXf1Octfgz3Vpb9VZkqghCJgbHpPZp22VCHhkD28BCGD7/EUM6MjRvLjz92QfZNnRneR9CKETW/lCiNyLwqOyKHoRtMogXX/qOEcxGX+29XgZXC6YFJ4hPk9rz+fijmmzdlZe8wpXBinVpCUFdljQgBlo13aWwCxd6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB6598.apcprd06.prod.outlook.com (2603:1096:101:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 01:20:38 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 01:20:38 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: fix high order atomic alloc flags issue
Date: Fri, 12 Jan 2024 09:20:29 +0800
Message-ID: <20240112012029.1363-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::13)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 19dad426-14b1-43f2-1da7-08dc130caf90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Znq2oxDMrMVUnOT1vFbKYqYDEKfJKRBMHBMPz1kF0sAozjIacrSBJFrP7K0E2f2tWMA4BNRr8YI4j6lagLHemCDJuUOvhmI+ML02nfUm3IaKmrXYPI7DrSrHVoIx47+qurb3xStlsPCeWKW1bHqR8JtRqzjUSgFHexICpOaFMZXr6NAD5PtMVtBxSu2Ly/PiSEAaybR1j33cJlmfCyEzox68mpr8BEw9uswwDVIhQXRGtXXfyyRkYb09KHY0w08Ef3vRI+qOmNoUEvgO6Br+H+oDjKNQlGPeOk6idSsJ1LC1f20SU32375FtptrP3pGOIOyZEPsCt91hvFLNmFJSrn0cKL2WehTlPGMT3ju3U46oMj5WsqMiaNbuk6rIWYfyo13RaYxhcL6MLiGSSg7IbjGdmS75xspOII1bHz9IJtuIrahnMQXpNRXZPSEHXHb0mJ38oQtl7AdpsocdJa9z3Pi0j3AoHKRQL8jaXRsz7SLNiFA693ZZwXgA9YxDgS1MVpoG6v2qUzCeGWU3s8y5Pk/XR3IMhDxno+iVuIv3QaXUAZrb8rxMHrZfdrhWHucC6GE0qldQSS9WF2XORTs6w795hLg20w/7kSesp+CsJken6f5N/505kwcufF4+WniE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(6512007)(6506007)(107886003)(38350700005)(52116002)(1076003)(2616005)(26005)(38100700002)(86362001)(36756003)(2906002)(8676002)(41300700001)(4326008)(8936002)(5660300002)(83380400001)(66556008)(478600001)(66476007)(316002)(6486002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y2BexOMxQ5f9kTxt+7kiiDY0ydz6zg801nNMkUgkVjoehl8fSJ4XH7JWY/N4?=
 =?us-ascii?Q?KPFWlC8snaoIqGLbQTO5qMWmijc14RIFg9H0Nbx+rl4sv8DD39HtTUC2p4B8?=
 =?us-ascii?Q?ObWlTC8tH5TOCM+PJh3Dbm8dI1b9J7sVZcPed3HbrwlynwVKOwzi/Ao7PzRh?=
 =?us-ascii?Q?NV/4Dm/8T+aDlZeiyjbdjv9mXs2Dxh1FaK0CWq3U6xjoG1Okp7nkfGPvYYxZ?=
 =?us-ascii?Q?4ZNA+v5ARmfkVsM4A9cas3jI/zjfoD0uF2VX1RKDRP1LvMVzyvVICPVjK/6q?=
 =?us-ascii?Q?zr+nBlxQTmdbLndZF1p5SLGNJmvJmx8AMLXIu14LBjNLvdEsOfVaHVbouMA+?=
 =?us-ascii?Q?rzchbezjnZ1CfQMIsYu2zdBjuJKUgPbARooJFNMkXPznZRU7pXCLcqb9hMgw?=
 =?us-ascii?Q?4NkORdufJm6Drm4SAbLJTm4QkmXmGBqF8QhMk9O/AVc3/TFGcv3JvRTVbMXd?=
 =?us-ascii?Q?trk9ptonB7w2AxRvcGYAbUfkNnx2yC3cm4MXfiFfZuCGxiQ62uN3R8onk4WF?=
 =?us-ascii?Q?kCkvs/CGxo56n0paICPlR0AY+Ja2jX36e7fbDdbZZrfeGUen3U99RHgUbFnJ?=
 =?us-ascii?Q?aPaQr6WobUhs5jjBEKV6BwHEH5RqcR+odApqmpiwRpnBK59vM7+xJ6tY62R9?=
 =?us-ascii?Q?yoHgEN1u0Iy9sFAzadg0PGpw8Pok2PMCmYVxHzdwFtQoOAkUMwIKXNBE1jUV?=
 =?us-ascii?Q?AWAgoAw7Il3kr5fCknxK3Vyy7f7G6NgAqTwF+B2yWJR3VT3u9gxM5LDsAwxL?=
 =?us-ascii?Q?CBGNaxNm1Rr0crti/UQpdBdndlXoc62Of9hThaze6ZIbmsvJC8CmWcxdHo2t?=
 =?us-ascii?Q?4Ei9P/IB27WtYwh/ZoOJsJmBzNhZbYhAO+BA/xY35/QAvbz3xzv3gIafTkLm?=
 =?us-ascii?Q?ebBC5ZfzlTj0dW6vA/3K3ghP7gNlsjh/9uaxhaXAcU8ZWt/WYQVF3y0wev+I?=
 =?us-ascii?Q?gMSTtizQxzgiAXoXwjAyLf0W+baUrfKyYJwtqg35c0HKLwfCAwQdD2690GZO?=
 =?us-ascii?Q?/4sgAzjUvqWhwvNTvEheEjCC8VEKhYucYaTmmF9Iynb8m6zdsguY1jcESYfO?=
 =?us-ascii?Q?w2DeQ0fM+Js0mIAPz4tmq6K5JS1UnAqzOzMRSHwdxfdb0ODkckhU6569e7l2?=
 =?us-ascii?Q?LBWD4IeIyQ+cjRIZOv7tDcftFz8dfIFp/vajjG8BQZmyW6znQEWFjEMzmQ7m?=
 =?us-ascii?Q?lNnyh6UkXtSdZdG/TbNpkezDvEdJa/zpsM8wG9YOrCI+jG6H3xpmlkVirlBh?=
 =?us-ascii?Q?mtRXNqg+o5IrVELI+WnAINFsE0YhgnD9PKCvHCYTKdnuRd3rPeREEfUQUiQX?=
 =?us-ascii?Q?ufq9PlHj3DTL10+qbyHwqnI1vHFEYA4zkD5OFcYhSiX6G9CdkiabNoJgZlP1?=
 =?us-ascii?Q?8zr22/C9x6Xzccf2gAc9tvlD+yInmyMPGZBVQ2hZyjfu8lUJPLbYpQt2F1Es?=
 =?us-ascii?Q?hMXF65SPHEoZCheaCa0aufjgqb73gBUvFNwghgpXec3uaYcGcU9gwKinu/YB?=
 =?us-ascii?Q?Hg6p8xRW3g2aN4PwdRgCZS0UTysRserH7+ckYUBBF5G1BtJToYkbqt+ik2uC?=
 =?us-ascii?Q?aPnVsz30dSbwtI1yjJR0mXn1Oxfb+MKxkvupA8eK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dad426-14b1-43f2-1da7-08dc130caf90
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 01:20:38.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jaYux3nV2k23IMa8SL3BQKYHP+fQSm/hq7y/qZWIEHt7C/H6saLGZg6iVZaQyInNWmS9RfZQaKf5TER44MNjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6598

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


