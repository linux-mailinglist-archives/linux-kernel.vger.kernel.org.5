Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C627E954F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjKMDEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMDEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:04:00 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2118.outbound.protection.outlook.com [40.107.255.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4311704
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:03:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJKTO19eKM1jdYmJUfuZNmYViipZJpRfAEoBvzmAXg5suxNQwXc1HabbB0bATtGUQD0DCqdy1YB9DwqsBrz1m5o605aF9nfY5CZKYfsYd6TxfvbVzbJE3B1B1wGkJetfTkE9zPO6pF+J7h3a7dw6wch609/2GwWKdBXkp+GdnXI0vEfo8vLJ52jpn8UUMWOa/j3mxIuN0mmOuPYA0MLhsCAR14iml4kaXvm0U6EBom8lttGoVGDxMRSAaRme4hYrx/F35jo/qHCZb+l94m5ZkKxo9ZNRsLuw+oPknbNrttuq8NVUAhrvF4lnWv5VZgXoF5ai5F/ZezpLDXY+8SV8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBeZTAyGspQwRPIMNiuVt1kp+s/UGwHOXaMl87chj/U=;
 b=EPb7vny8B+442hIYtRhEuQEJ7nd9CLog8+J40ZDPJHbpwRizU8saXM4i3bQElOINYlVqze+mWHnZgXsmTQ+4Bgf9rhKg0lOu2VGBDPMx1/lfkx/CWinHOUj3FKHXaOngKej0A1PthKkTqV//Zg59NQnZ7v87XJ83uwWOq3CdLDJMqVfoKTlLP7SSPt3h15fnitUfTv53JU8t76W1aGhrPQL6mxFevccR9UgxC2yWjeXNJpiK8gRT6vADS1P0Rgz68JGSOiYJAs/7wdZ4/9mJkSr2y3M6mmxbIAKSyRIwsilqPaFC+p1wUA1j+GI7H89qZ6LuwlQHT4FzFlpwh/CqOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBeZTAyGspQwRPIMNiuVt1kp+s/UGwHOXaMl87chj/U=;
 b=FRqthJx1cDzk4aHlWPU3N8uobObSscUg2nKAzMirMWzt05XGYBLGLluxMnHzkpkHZGvgWB2HmN5xrEB5qW2ARcEASPIjayFsGdcapUvH403ACrVsJZ+h3tihCaQ5riLi4gl/d4rkQ53gZSMipV854N9cN5eL9K6PN+BUozJbpGWCTNiGM63AYy3FqAnmKt/nhxsDDGonH7kWiJLZSdGuJnKwmTVXUZiidKCSnj257ix9yDXD/mJeq+ssu8O2kUscnlw3EAcBLBqZHlqIh1ADSnkCV8StCR99yKAbF5O4S60jUBtGLbNGNOXk6AfeC2xIMrBaRceNqlz2JvYHHJyIAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR0601MB5655.apcprd06.prod.outlook.com (2603:1096:820:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.33; Mon, 13 Nov
 2023 03:03:53 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.6954.027; Mon, 13 Nov 2023
 03:03:53 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: ALLOC_HIGHATOMIC flag allocation issue
Date:   Mon, 13 Nov 2023 11:03:43 +0800
Message-ID: <20231113030343.1984-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR0601MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: af778645-3021-4298-d925-08dbe3f529f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKtAS3vqkEUQPrHNAsNYLIO4oagX/Mn/inW8C2QSY9WasK7tctmMBNv8L3CYPwVr6ZZrobY7rHWrxWJiVibUEknLO8Zq5WLm/x4yO9bOZLHOJQXmE1dQeSnS7RnPviLNOmED8Vsv5TW8lvhm94dlJBidH1bibCHYtMZ93EMTWjCAEM898N0WPFZzbDQaSvbMxeeEt2VG5F5SYTof4kGlrTQypBpBowOr0rU6s4KK3sMr4H6VOMop0+uF5sDdyFUb/v1Iwbh9nc+n9QENIczE7sjR5GjexxejIV6Oft1PhU4Jl3YdSPt3uq1++Phso81b7CpVIask1ijiovBz3swD9kv0APID7zer+ZUzJBHyXhc2Dsa4CgUhxitvQLde0KS6fxPPrMtWPuuc/tc+ONp6P9ZBdjs6sa0hUHct7TvKT9r4YVX9IeQtJReot2fwEv+nO/uXEvdYy1hoWVhA/i2oPqPEgPnPVGyahXxG1gH1iqjSzHUr425NWTt11ZhF+D9hYAxuW1FiM05EW/QwdGk5azy9wqufgvL2dGl9/VAE0L4rIYv7s5OgU8NAP9bK+TGIcy52XfqawmXW5kmfBAc+cGtRXHcyMv+1VVzJD8Ha9joHYzhkGYfuxxA6thvXfaYO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6486002)(316002)(478600001)(52116002)(6506007)(38350700005)(5660300002)(86362001)(41300700001)(66946007)(54906003)(66556008)(66476007)(2906002)(4326008)(8676002)(8936002)(38100700002)(36756003)(2616005)(107886003)(26005)(1076003)(83380400001)(6666004)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gVo/IjeLxiSetDR1YeYJILhY5mVa/hMh5Y/h1iuxlapGbsVbXb496z2ISSMZ?=
 =?us-ascii?Q?KdYssVOgUZOZ1ilqdGWIUvd1unPnsHi24G40XdVkjOcnz/FswMZZVQp/UvM2?=
 =?us-ascii?Q?ubV/AQFg1HeWbOrx3KK/7/KideKna1jb0xsa3C4OX4aJlYdcaudZF+WP3eFR?=
 =?us-ascii?Q?RuHgU3YcYpiLsl6bEOuR4yw+A4ewT4yYOMI7JUT2XbzXdmWdj1Y3Ib5qY9Jc?=
 =?us-ascii?Q?HMyPiFQk862/Vde3/BiPE2FvmQ1Ci4LVOmLqMVt6WbxmdePMS/UXe0rjUnfV?=
 =?us-ascii?Q?EMPbZ2ZMbyMZm6Qcm054pgiMEkks+MRYEiWdInclalQMxHWVdvgGdljfPI+a?=
 =?us-ascii?Q?aoMSdc1xCdJORP8m5h+BGn4PjmR42lotjplDErfj8FeEze1mfwjaBtYZlYLI?=
 =?us-ascii?Q?0m50UxbhDxX1JiX5ZmTImFPtfvDoUz5UdcnvVzvzejLs9oeM6iu9UYGP6JU9?=
 =?us-ascii?Q?ubsd9MrG+1H5KObV+V+TlN06bfxaZIJPh7JUvU+Bp7cUDik5AnGtBNUb1SoQ?=
 =?us-ascii?Q?hQYF3MgPMf6AHEqmL0Ihw8xs0b9RfQTJWw7+f2Nwzofk4D0XrBQRqrDZWaVV?=
 =?us-ascii?Q?Dk6u0Qe6ancfo4s2G8eUnJD7Y9IyiOsSwd52rI2gEtqIXNC1+1YMnOKv3URR?=
 =?us-ascii?Q?nENtlBQnYshtKmkHX+rDK8N5/68CtowTR9yk3l2pU+K/jLXMoCfTQBCEV8PY?=
 =?us-ascii?Q?9lJFu+XK9ZgE7lim0cckqVGKZnRDoT4v1avJF2xZ3EhGF4zc8v9pQ3ubWK93?=
 =?us-ascii?Q?5BY4rR6fSmRQ6Ws1rTyIIs9y9V5yNquJX+pk3LSiW8A1rZpFzr2sGe/GWRuJ?=
 =?us-ascii?Q?/EF9oEAiFPYv2ugUdm7eIF/zX04YlALsclnRHQCGPPhAf1fz9JWQiCWi4xTK?=
 =?us-ascii?Q?SowCXGmrVOt3r/I/tX3VsWu0v+tr8fZ0VoGwkxUrJKcDQSMPS7cb5Ar4YS63?=
 =?us-ascii?Q?lE/32nYcv8llaRApKtxAKl0/w96vjOXbz90BiaqK2l1Ipf8H6iS+L6JVMsXF?=
 =?us-ascii?Q?WkLYbI4zLMYGDqSB0d1VePGkSwhRsHHZ0Z5gfTpb6o9HBGzBHpHO4j4Xl4PQ?=
 =?us-ascii?Q?uySiCKYNecLRLvDydb5/YIQRv57eZsoxNOUo98WCNtxGsKUeIFiLBNz7Tee7?=
 =?us-ascii?Q?XMPY6MQ5B6+uP3zdY2RNbOOlp7gIop6i4RubJIschswk5w4Ye32xyMXB+df7?=
 =?us-ascii?Q?UIdBSoIgc4OyzDk9IuEey1O7ueOBFll2ddbVzPsekvxy3/DQfx7heOAfpCzc?=
 =?us-ascii?Q?Spa3tGrlgVKkGx5w3l0WDMwT8BK/Lk9P1xbpmFyN8PLfVwP4coSVtjAKI5qh?=
 =?us-ascii?Q?DrztJZnVkVS1RPsREw44HhXFi+jL188hfYS91eACKafEuJbA9WFURWK1A+ba?=
 =?us-ascii?Q?J6Zl1ibcLGf0QM8lnP8Uj9mlz+1hZ7Iizet88NtawLtZusaSq+/sBH0FNp/K?=
 =?us-ascii?Q?zp8gqMWKKHi1piAPakxjs+91oEtQB6OMxJT1412v7JeXSMAkPH+Cn5X+4VM6?=
 =?us-ascii?Q?/aGqpvlhTwFmDTjtOUgZN7ZDz5KiPYFc4oxEDZF+yzdfHdeJijT88n75crNS?=
 =?us-ascii?Q?j+vgPqTpxYykkc1EDrEXV9V60ULWHcwW+11hrvP/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af778645-3021-4298-d925-08dbe3f529f6
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 03:03:52.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZ79QLDWkrE/keP8cJFaJ5zrTx8H2HdTcY6bho7pJ5WLBHaN3AyK5J82hdv3VYWq2QToSkzhovbddEVp7/vVGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 mm/page_alloc.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 mm/page_alloc.c

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7a8dac0c1c74..49890d00cc3c
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2850,11 +2850,20 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int batch = nr_pcp_alloc(pcp, zone, order);
 			int alloced;
 
+			/*
+			 * If pcplist is empty and alloc_flags is with ALLOC_HIGHATOMIC,
+			 * it should alloc from buddy highatomic migrate freelist firstly
+			 * to ensure quick and successful allocation.
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
@@ -2918,7 +2927,7 @@ static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
 			gfp_t gfp_flags, unsigned int alloc_flags,
-			int migratetype)
+			int migratetype, bool *highatomc_allocation)
 {
 	struct page *page;
 
@@ -2938,6 +2947,23 @@ struct page *rmqueue(struct zone *preferred_zone,
 	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
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
+
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
 	if ((alloc_flags & ALLOC_KSWAPD) &&
@@ -3208,6 +3234,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
+	bool highatomc_allocation = false;
 
 retry:
 	/*
@@ -3339,7 +3366,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
-				gfp_mask, alloc_flags, ac->migratetype);
+				gfp_mask, alloc_flags, ac->migratetype, &highatomc_allocation);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
@@ -3347,7 +3374,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
+			if (unlikely(highatomc_allocation))
 				reserve_highatomic_pageblock(page, zone);
 
 			return page;
-- 
2.39.0

