Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC779792C05
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352220AbjIERFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354867AbjIEPLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:11:54 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2102.outbound.protection.outlook.com [40.107.117.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A42191
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 08:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcwDqya3WL2ckSQyMjX6lDW6oupSmhTvXQFzezQLJ3erp3W33nq7h6v3DQtxTloB4QK6m7n5vsw7JxlQnWUrcORkgQ38FfXCsGhNAE0wX8FDtkENfJtePjlq6+F7EPihM/NempegOBVq4wVigHt7P2w2pO7aRY1FlpYvAk7GH/tSIt/Njgkice7z52cKl3/13BKGWQYduJwf6HkmcNvi2w6TW4jm9q1xrIbYxNH5IBDRy53LLhiB+vS0IMKo6YoT65hW4usLfvKLRVElOyC6cTVtP7CzJ2TsHInwLHBKCK80wjPAVKAmfyp3xKo0DvEJJVAblnnPPWtoDh4HY76ztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAmy2ovKFFeM4S9smnbu/WqS71+rhndZozmVUFO3lLY=;
 b=He5q1N9IwpgvqVGjJzbFunkpgwcgKlnA6YAkwDkSd/nbT66CY/OjVgYb8kG+LqHOmnUS81TCdVRyVJkOf+dHY2ngii6fnxvBgvmCjzpY7X4nZACSdtGA6XEvVx/pIRmWk32Ag4EeauaGofeNPZMaH8Xe8cwbaXAZm8cSzCaxJhGp+okcXUYbLoc04bsSqySoA8IAbqAamylCV+Bix/qNCwc+XZjQkUp66/9JrzebbnKCF23uNx89hhJHo0znFpB+xqrXDjcAX+mkZ4H95keUTZGSkJbf+fKrJXdxKA59NrwhuVsBU39/wQC+wU3gL/I7QTS1JJlDTdlHYzzw/td1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAmy2ovKFFeM4S9smnbu/WqS71+rhndZozmVUFO3lLY=;
 b=pFsqX280iVrAV4ppPygXPzBgHBX6bGw8ZvPlTktgUWC50KPUVaVtTh/I6dgFtQ2JaOS9/fhUozEVPorS8Xd7LaeC/7NhHt39m3rgqYHFFnZZTdcIz/gjmGTqbrrjpx5H+zPt+mGsAevmEB8hTmDj7biZYbHRiFkNYPRRcUNYZSFL9/FuwHUtRLECq12lcseDm/LgKitM4q9cRBDNbDkBkmCsmEaBsv79H5dC2U212E0IJqW+S6voUku/c6H0UR8M5tbrK756OJ0zENs2OJxBmDAQ6SPtBTeUe4gUFujNm7DjkMEk1JOrKlSaFeXjMBetPJ+HlnR+EdYSlrtPUbvbZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB5589.apcprd06.prod.outlook.com (2603:1096:101:c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 5 Sep
 2023 15:11:45 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc%4]) with mapi id 15.20.6745.034; Tue, 5 Sep 2023
 15:11:45 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: page_alloc: ALLOC_HIGHATOMIC flag allocation issue
Date:   Tue,  5 Sep 2023 23:11:34 +0800
Message-ID: <20230905151134.1195-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB5589:EE_
X-MS-Office365-Filtering-Correlation-Id: 72df2566-2bc0-4ab2-312b-08dbae226adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydMoK1w7PtWkKInY/qA+6NDf/EJfwrsQjvoGtFSOtpyR10Gc9lhN0kOha0ehHPLMVQSKGdh/jbivIHogiOvV6INLxqqQkCot8OAbUfnmu3rytm/VTbbbQFxFbtX5m4j6tqD/l1I+sD1VxTAQTETYV4se/FDkQOzkSJXYrbMBYrmb/c90LxajJ0zVcHE+TE6T7ZEONeKI1a/MY2Z6K1AEE3Ao7ftI8I1AVmY9/f3oURKOe7mmf+xqFvhtvckWb9AqZ/fVXyJH+HwWXhtg7LvK/DpiSL9MW6OwgGFhFR7jA8a1RK/9VlxXPbRduVCeJw0shh9WNvDXXtN0aAy7GYnRjoeE21GweAID7avIzPd/S0bCqKZdADR5QTxqDwilPUxZA15GY1JqicrEAlcUfjPkHiANtp6QXmnpAupukUrxQcUKTg8sWS1JMhqUMaDHtcIqefHyDyOAiWDiAzJk5Wq2O8GMyz1kmN/7VjqzgKOwchPpsvoI1nMepqmfyV3kKlhSqakVqJN2oOk9gIfcDVmFUKm9moEX5PuoBfjmsjFpVJ2KOuD8Kvo/kUtY78Dl733LtpWjRapup8bMVCzJ3UR6V5gkhaltNOarnpWrIuj38NnCZl3Cq+xEOYO3ftzDuJ7j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(1800799009)(186009)(451199024)(2906002)(38350700002)(38100700002)(36756003)(86362001)(1076003)(107886003)(8936002)(8676002)(4326008)(6666004)(2616005)(26005)(5660300002)(52116002)(41300700001)(6512007)(66476007)(66556008)(66946007)(316002)(6506007)(6486002)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?thU7jcXB6yKq6DDTiCI1XmcJJdkwLgMxHG3duD/2VSHs2x8Qtl5GnuTrlvTT?=
 =?us-ascii?Q?tghSE2NRCvppP/u72vt7a+t2/S1xrdBoOA01hqidGbJ3aRAlaxmNzOMSyDyk?=
 =?us-ascii?Q?0hvRli4dKeJi/gp3JIl53l34rU2qBF7kzCy4D8RuZkqVVgvPC5ISHbyH8gzy?=
 =?us-ascii?Q?0NGYmz7MX1DfLTrGDP6TRpmjF7fA+K90OX7h5+MLwub467h+dIgaLqWTpkok?=
 =?us-ascii?Q?0e2ydQqZudQlfPrqfmMX61bQd0ADyp6blKB8a25JmwfXUeaDnj7XNwKOOiQ/?=
 =?us-ascii?Q?F8FVKdQ5I/NpxT8LILMqTD5A3xOaUMYzUWc4ocsdaq5JVZqAcEKnYXlL7HgT?=
 =?us-ascii?Q?3LqRo6Z9Amj+NvG+DGWsipiayqu+RJWzaF/YdcJn5LFVHLUwygcDedQX/DJk?=
 =?us-ascii?Q?LcdtsHwa7u29UrZpT7q4AIGhzw63sP7KKCdVIHz9Dm2G8YhY2tzrlAfawfgo?=
 =?us-ascii?Q?lNDOJstexMojBvMixMICZe78pigjDNlE7AVz69NLwmpt0I1KnGfRx+6nHiKO?=
 =?us-ascii?Q?Dzsb/d31SenXhKI8VGDB4YZeCnYYzElEyeTAhgofmqcKKldkvlCuBtALLXIW?=
 =?us-ascii?Q?eovWqIR6yRzTq36ISW/x2IwemQtaFei4gP4sggCq5iDwxGNgRI20nX1XRRkN?=
 =?us-ascii?Q?KgkamZ6rEIRrVm7JQ4Xxbmov3LxytxAbnADzxo7+K7OVbTzQhs4wsSOZZaui?=
 =?us-ascii?Q?G4SFWW7ADHbaAhAADlOePECYp0+VJhwpiEXWGT0mOltESQL03e5ZP2rCeEFU?=
 =?us-ascii?Q?1xxCCy8QFx+58VnFmksc4dJM7QPVi0OF9265/OsF5lrf3yJoEZW/OyNbwMsW?=
 =?us-ascii?Q?R0qMfnzPGsMYJDZLL2MIug88g5E20ARFf71iHP5eTveQyssCKUwgpcNASKH3?=
 =?us-ascii?Q?TnhZT6C9cyH0fThOVwr3BfC+rGZc9finEkw9dpm6e5BXdQlY+cnf5ExNQdPR?=
 =?us-ascii?Q?UNOQLyavSajnareWIp6cUsDywgwjlk6qZ6MZaCC1Y4r9yymxbsgyx/BSoavA?=
 =?us-ascii?Q?DoJF6Z02/jpMIww16tWeYN0pbM0821KJgaOSwpIxFXNNqQpMFsNj9ctjvqf6?=
 =?us-ascii?Q?+87zyt6wm0SPUCqK3kVxYAXIkZj702UB7ojRKvLLA3456E2lgD4y/K9gxIfu?=
 =?us-ascii?Q?25Wt75WrH2fHcWEkTNqTZmBct4en0i8U1r25Ce5DvZDtX40HBFVqVu5oCW8V?=
 =?us-ascii?Q?NfEvpdVzscFyIJ6vdptxuczJ9OdEFqktfKyyKjQDx/0xDp7usfRsDZq7JdTc?=
 =?us-ascii?Q?Sg4tKGW7BHFHSLouBe9iFtF9Mt8NPBWPuhfn7mit1pUiaGaEgMmay+pn3deQ?=
 =?us-ascii?Q?BGAIC8qvVogQe/pCxy3R0kv1Y+SpkEJ9Wg3U2+Pgx0k2mqk1uvRTn4Y7vFPr?=
 =?us-ascii?Q?oiX3PgMO+Sz92Cy/MKQKZl0HyIr8CLirO7fYwbG683o5LNBvexJ2GLiTLrb1?=
 =?us-ascii?Q?Qe16ApBfNI0tZkCaF85ToTO4Yy7tBpKYV8qPDILhrARgMxckXADfAFL4LpVJ?=
 =?us-ascii?Q?MIB8+GjduydFAijVysnkNNYMTCPlCpd74A517ILkC3VLaUEaQO8r0bsfU6yR?=
 =?us-ascii?Q?4tiKizSh+AYddbvO86fwPX101lroYJ8K8ctEMboV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72df2566-2bc0-4ab2-312b-08dbae226adb
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 15:11:45.1354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsNZy9HG4U9sdQX20ygZOZH9MomFMS75B2Wd7vQng9KDOoQeVT+UpLHYJOVm3yYBWw4AgB0fEFr9qrD7XdNTrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5589
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
is order1/2/3/10 in rmqueue(),if pages are alloced successfully
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

This patch can solve the failure problem of allocating other types of
pages due to excessive MIGRATE_HIGHATOMIC freelist reservations.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/internal.h   |  1 +
 mm/page_alloc.c | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)
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
index fefc4074d9d0..14b51d1ef4c3
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2716,6 +2716,9 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int batch = READ_ONCE(pcp->batch);
 			int alloced;
 
+			if (alloc_flags & ALLOC_HIGHATOMIC)
+				goto out;
+
 			/*
 			 * Scale batch relative to order if batch implies
 			 * free pages can be stored on the PCP. Batch can
@@ -2730,6 +2733,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 					migratetype, alloc_flags);
 
 			pcp->count += alloced << order;
+out:
 			if (unlikely(list_empty(list)))
 				return NULL;
 		}
@@ -2792,7 +2796,7 @@ __no_sanitize_memory
 static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
-			gfp_t gfp_flags, unsigned int alloc_flags,
+			gfp_t gfp_flags, unsigned int *alloc_flags,
 			int migratetype)
 {
 	struct page *page;
@@ -2805,17 +2809,19 @@ struct page *rmqueue(struct zone *preferred_zone,
 
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
@@ -3195,7 +3201,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
-				gfp_mask, alloc_flags, ac->migratetype);
+				gfp_mask, &alloc_flags, ac->migratetype);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
@@ -3203,7 +3209,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
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

