Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284457F0A94
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 03:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjKTCg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 21:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjKTCg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 21:36:28 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2128.outbound.protection.outlook.com [40.107.117.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9264136
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 18:36:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDvwIN9CiU6JTmeGqfgbE4EYd/OMZbbfS809mvgCfuPc8cQnkVrbFSGIn1lnhDsMFBjb46GWLGjRLDtlLISFEWamRgB+Ch68zh/8LMqQbHyy7ac4p4IlD8yqJ9IoOaPKmCoSDC8jSakMD9SVTJ2gnLkGiss6rQiFklw++37lxVUM8CZf9/XiuGlc7qN4cyCSHXQqzWFLhUOyJqHQBDw51PGjSyXPXNUTNtkhjv3sP7AKh1qS/u03bRyGnZuEbvetpWeQ1jZ6pwYc5JHv8Fw1FnhP2EzOOUEyqSRo7fdR1dhppCdFLPaJtVsnqnocXrSx36Q8jBXJ4STGy+8gDQNGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBeZTAyGspQwRPIMNiuVt1kp+s/UGwHOXaMl87chj/U=;
 b=k+DTft1EJlAsqLfUDP+aTIXU/3AAD2n/oEqVQ54dbd6T7TWFfkkTPpjKUH0d7eLQctdxay7CwT5wcfY3ura9Jez/VBZFHhpWKA+LGaC1KKtTNslYWiWM77vmPrVf+431fTeL6JlFsJwB0VTKuMpCL8J+XAYrJvD5tfxTd+s4ozybhVEZnoxx42pm656i4tPsG5jhR23VVyGCTSdQ+LCMrt5fV08Sp3LHEoFMy/Vql7j7XF7TE9BQiyoAtAXs1QyLDVJVZvMjgdE5S+BZWRt9SsK4G/bJALUutGRiQwjNcaoVvdG0ohYjGZXCTTcnGo/JVBOymRgObNPuVJb3G7TJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBeZTAyGspQwRPIMNiuVt1kp+s/UGwHOXaMl87chj/U=;
 b=QyiZTQymHzekfNYfZxg3qbrywd2gTMkik/NrhLW8AnTi2FcLjeSsGtsXlB8/FTbxvcn0hyAWD0bJJ7qEGXJKZMd7nYBtVxtM1TXet8bhPR334iu+UBmT3PgsUWq1IprI8vJJ7uB2nztXOC4mryMXGj/DIxUcyCZIjpstAFuiNF9NeKQTBG8bdXawq6xd0Nkg2CdfwobN645ksfDa2ajVn9KbFlOVP/MntJrx1aiYMqdwhPa+psjLtQiKDHP7RAZnpueFGQ7Bo4MwPg3Dg7osNMeOLSqiTZGjPd3HBBzTGaylK2N0i7rOOSvUihIb+12eDDYDh4L7zg0Tk09pQ2H6fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by JH0PR06MB6679.apcprd06.prod.outlook.com (2603:1096:990:3d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 02:36:15 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 02:36:15 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: ALLOC_HIGHATOMIC flag allocation issue
Date:   Mon, 20 Nov 2023 10:35:36 +0800
Message-ID: <20231120023537.1785-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0221.apcprd06.prod.outlook.com
 (2603:1096:4:68::29) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|JH0PR06MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6e01ab-624e-47a6-f838-08dbe97177b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DlfYmKiPQbZ/mGFN6ow7HrSerKg1ON2pOsStCNaJ52VcNs6MpcxHiuWwOGc7N5YKKcrT5wZ4lqkH9NLDt6KJnO2s9tVQfFClqItLTWWGHiVB7aEdEetF9Y7xm9nX/AohvuHRg1NSBhFSJaaYgIrtT7pFhGqXX3+kRuZFygZPnZ+5o2WDM0yFrClF5st4kcTFgXA7JO7KQJdOhqJZKFTUhy4TU1tEKGPUlifKKTu+w0IBDgF7hOKSdbRP/klTAA7PcLWJ/Kkhk+D1bZKOvupmENLBp9LYcRRq402AuWvJuU3arAZp2rSosxhX2ktAm6Sr0JxvxhE1W7WQjAF2yOaB29E69tZ642dmsHn2XIQ3Amijr9T0OUOWnymwNv2PqqvHIJRWLfs4W6yGC4b0spBSDZcekfx80HUaUZAgPC3UZKuJMI1DkcDBxk47BG8vRMLWO7083r0BphPEjS5wInsx7cwNi7Kt3vUFiMoBQQDeus5hA/JB30/FYsGy2TuGI/VEMyI5mfDGUzL+mmrKcxx6Y5nZKFa0t22wV3cCJS18uxBkudt10Vq0ZbFNKDzAO7aFFFVMr+Xcv1oh+xrqbuhJC97bJoqhiTp6oS2cWRtqgy2Rwkz3mX1oM7vmah6F/85z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39850400004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(1076003)(107886003)(2616005)(52116002)(6506007)(41300700001)(6512007)(38350700005)(83380400001)(36756003)(26005)(4326008)(8676002)(8936002)(5660300002)(478600001)(86362001)(6486002)(6666004)(2906002)(38100700002)(66476007)(66556008)(66946007)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vXvb4Zrne1IJQOK9cU7nHKI+I4nxRjNSEk/RU+7JyZn3TfVRJHhoXAe//TwD?=
 =?us-ascii?Q?QUHtuDF1UsRgMek4RDxpdM9lOFBPSIS3Co6iGKpEVYDTyuKqeQQjFUClC31K?=
 =?us-ascii?Q?P/yw+BIOFwdF9VLp9gpfgdS21Qth40GEArW7+3ppo7kAOPNLjIoZSDil7Pac?=
 =?us-ascii?Q?uuKOA4X+D6svX2EEsAgdHwqQrvVrQgstuqafzDwHF0DOzJyTtjvSefzQxPdh?=
 =?us-ascii?Q?r562tH+LoO9My5vHdsphv7FiMAbr/DlXJROkJoKzjSoHeew5mT3s4FdUAN1u?=
 =?us-ascii?Q?sXh4aqjvE6X9wKD4jEzzTFPCfyUHFQZIqF7w5wi+4cvAEF4Rqp+Xt8L2nLHY?=
 =?us-ascii?Q?VQvtX2U1LE5x/3BZCzPJhEbtqUsQQFq4GYgzOjpc88EIV+K+xfNniR+dR9Dz?=
 =?us-ascii?Q?oKnEubDUrZvn6gJAF3ufxlypvKOJa3Wr2epNddPREVWuXANRraVAT9c4iHlg?=
 =?us-ascii?Q?J1rEzHo4FYDC0U4Cn8qVnyrC5TCTIUPuldnn5nXHzyX0kJRQCLvb+9pKTGNj?=
 =?us-ascii?Q?1F/NJr3D12Eun+ZageAbwYfWtQBqJk1hwOTaV/N6VXIIctt1babL/PpChsyu?=
 =?us-ascii?Q?haf4mwQlGu7h5TLg0R6v57lenbFX23VBGRdS5LreeMANkL5hbAT3W8UW3zKW?=
 =?us-ascii?Q?BlZHWfkfF7SqEBEyUDLo1cQHc+nuEGV0cuvqVZxFRLCEphnTRxHmtefkHlWI?=
 =?us-ascii?Q?dy2flpFrU/Y5Q+O2k5y4myewNmypcv+lcR0xMbQmyqELqsmTgIqMC3ssnkOE?=
 =?us-ascii?Q?7VkeLm2k37zY9u3S1VtkcmkC9J2JW9vvQusbkGMHTWXDZqgAuY+/Su3gvPE9?=
 =?us-ascii?Q?/SJn4BOo3+lxPYJuHoNECewlJCvafnSZDonm+z+A2EDXO4dzpHXNUcZdZkL3?=
 =?us-ascii?Q?SqBhEadN5MEsZ1MIyUN0cJeSPefEuNEoh06rEZEvhtshHzdF7H40JF06uPoI?=
 =?us-ascii?Q?pVymp3Izwmzaty+kRh2SaZW5t/0DeqsUcpx1P/jETzvhUlK7FWU2zfpMvT8n?=
 =?us-ascii?Q?+iU04T0RbH9/Olp99pOiFHeNQEL6xau7/OVZyIlNOfboDcI8pbXYE5S11LFx?=
 =?us-ascii?Q?U45jUBAtlX44/vTnPgkBZQ69maENLZwNQvquhpuZ+okdMY0MZsndg3g0B/eL?=
 =?us-ascii?Q?Bw9FFrEzHmauyEbjBOEHwv2AMxo2YPRrjaUU5g1OKnMH1CIR9uiuRIH9x61K?=
 =?us-ascii?Q?uoS0iBcpmHs0heoL7bXVNGxkautvv/88K4rr3lyW7DVxw+pPNiZ1+PRQPWDq?=
 =?us-ascii?Q?mAaO5AhBjHqv8wAZVq6O4gntRnr4F/5z9UmWtSKUOTTynwQuY/KXY45sWuJv?=
 =?us-ascii?Q?tzL9qQ5mGrr4LaarwlB9MFAb12JEAIAle1fMLKOnOsiqUKQLVgqOeafw6wG8?=
 =?us-ascii?Q?DCdm7N5LFXZJawBCQYeq81YypDBfZSFZ7oC0JZ3WXdGsm5NFQCvDsaAFvBcu?=
 =?us-ascii?Q?Eq4M3JjT7kI1NLf4qHU5sKbjCH+tbyOt/GVqb1h4Xfxvc/FxEgja0IKKQr3U?=
 =?us-ascii?Q?mal729eD08rgVJv/Ymbj9tJ+Dr+YAtLIX68aLLoEMEP7t6HTVVjua+Yko+fo?=
 =?us-ascii?Q?O5PWZaYp37ig92YeUKZ7u2DS+V62aKxoeSnqWHJ5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6e01ab-624e-47a6-f838-08dbe97177b9
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 02:36:15.3714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbiRN8ccgMeh+OqjfihootNs2MYFu1KRCaeFeBShT1QP4LalJd5aGilekP2Mbq6AcbmqK45AfAtV9FaRxRzxRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6679
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

