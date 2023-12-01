Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAAA8004B6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377717AbjLAHZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAHZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:25:28 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2102.outbound.protection.outlook.com [40.107.215.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415E91A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:25:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gg7BiY+oXS39jK4AuuQBimVu0gYVmKYtAQ6cd/jc+wfPQ78+9oMRXHkq2vT5VV3+b0mGe4naID50uGfCJ8HHbjbg+98q2meyBr4j+zcDtgOfI/J/uhSASObezBjF2i5w0MiZEs75SOmPJy7K42J1jSQQaFlH767v42PyW8j6dqhrYw7hOzFlu9pyaV0O6b5ipqbBHm7ypmD2e8U9AiW+llJRLrQ+vYLHI6p1JCZ7VN5ZU/UTXpsiLb1Oil24Ar6Pflba2gt+jAXE7cH66CZ65yWcCyHENipGfPOG396E/sdQUgXLFadU+T1vzzrukLUuULRyW4uivTMqQ9gIenTRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tI8oEPip3Q7kwfhovo59YbyVALnN/SAlZobRe3NHgcI=;
 b=S0YtpLEoLevdg5AXea2JUgFeRElPdciPSVBDhby9HX3g2VUsydYBFJW5FUX4bDB/G8uxuh//QkZgV0KtWSmrZqfqEyucuRs/YLdwwLVQ8URqLIO+p7rFej7sl5ET77ZDPSG0SXNMMqwv36rQ5uXy5CMEeMuUzq0YiLyTIQqBgthHA9fGI0zDu6669L8GwndirWLPelwjYcpOMSUWHbIkYfm0lwsqB4Y/ieBg0GybvZ2Ui8YTuetciHXiYPIWU1m1+ONuY5YG6OUpRGO+OSuspYxDe6BuFRu2dAHUKge+ajMxnXIMIz8T4eurLPXhjAfAy/QSiDuGh0kQt+ZcYhXPbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI8oEPip3Q7kwfhovo59YbyVALnN/SAlZobRe3NHgcI=;
 b=ps4fdZTY6t7974ttrIu1t6CVC5jFLKqldhASi2o6uFwIgPeXF0dxWT5AjiB8ZO/o3P548BigjhaziewY4cvTlqaYuoWgmlRsru1krkDZO+y8b0iCSV/ZgxGtdWcHetEYn7J9Te0QNcY/i4jK6KxyXsSRqJZKlZJ2Gs0++qOUx2/hg2/muwh/Lh3P8uvaJ4xRDW5yXdhKk4bGOnmAS7AUmH1KHB/J66igI8WJ+PRMY4r95nX6OKPGGhHfvPCL+e7BS/MhhTmyklrAFyKkdPbmbW/lWd+rVomXu0o0IPJt2P2cJumZ32grLUEJsA6I6x6zbymKzcEIK+v/es7JKqz7SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by PSAPR06MB4166.apcprd06.prod.outlook.com (2603:1096:301:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26; Fri, 1 Dec
 2023 07:25:27 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7046.015; Fri, 1 Dec 2023
 07:25:27 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: ALLOC_HIGHATOMIC flag allocation issue
Date:   Fri,  1 Dec 2023 15:25:18 +0800
Message-ID: <20231201072518.1974-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|PSAPR06MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9d3d66-8454-438d-89dd-08dbf23eb063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yR52UFA/yIuu95uBN8G0C/l8pP3xQ4OGy9LGBVsmZUZ3Qgn0S0I2bjCHfY2eM/PftzprH88P4xr+0qxjZ3RxXyAADQbGvMaNC27L+qEKnEbgA99ioAoYEDJ8tZP4eFGGdNOyrJmQNZrqlc5sy/6kGLLuRS1G/6Jst2bTSBbTX5qTrIayzLYSSCp14P8UOByuglmjFiO4q0s3H15PSFPjdW1+FV4LGgSNBN2WWqSZ2hGnv6I9O6+M7HlnF0lDFgRCDCxAmhh9g+mt6u2njaJ38smP8/ExOSBrgC9CagrG27DOgdsTOEK080YBJCJbZh2MmBN0p4mCIMc/fYM5xtFrn1w3zZ5/SlI74YgJ7W51W3oifeBwroG4alAnUeqM/pj9L/V+CpDw2BwcqJc0HIyhomK2H2QACwrn81sRjpAElLZB+NoYmI21v9NW3xKZ3Fik2iV/qI9MQvI7Ke1gbIdaZcVNQS70vcRh+2WR2HPl1UE1xrPTiKI99xM8d3nOeVGd4cMoqw4nCazL381INZxUflHwZ4qEuyP3wbjnRNNoEOqzQSTHMldV5ORLKyGLN6gs4NXzZlECay7bejZ44IMKu7NzGJPcSfzbZHUgiy8SCGEwThMqiDXYaTAzUTX3L/aE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(86362001)(6512007)(36756003)(38100700002)(5660300002)(107886003)(66556008)(66946007)(66476007)(2616005)(1076003)(2906002)(4326008)(8676002)(38350700005)(8936002)(316002)(83380400001)(41300700001)(26005)(6486002)(478600001)(52116002)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Pr8o/qfTPV2RygtU8mrDUrqEih79wLhLS6lH9mXCKxKYtpfwDuKoQookhyT?=
 =?us-ascii?Q?O01Qf8O6cH2v3gKxMlU30AISppHDuJCJ8ZYSm9AusAUiTv03kGypl0wkbFvl?=
 =?us-ascii?Q?8kAuewS4wW7HQSSFNPQkZN9cxhnnmp//DDZ9sokkuP9jl+7Xt1CIFX8n5dDG?=
 =?us-ascii?Q?uXcx2nsHD1kul3JPkWm6AvybPNsArNRllugPaThNAttGCgW1wui2VQVCVn8s?=
 =?us-ascii?Q?mrABG1hQ7wmSNC7ggj9mw0nPBHJpPXt7ElUVptwaakn4AF6BQk8LngsxQ4CK?=
 =?us-ascii?Q?Xha2cp7ImOfineNQm1CFMEZYwgv4lrFq3P7EaAQcKA3HTGKyzsue5s8CU69+?=
 =?us-ascii?Q?Qh9P8ARDW3zWZxBgvkYsrocNvg66eEWKPBrHl4AUhPPW6A/1wcZIg6TGfTAP?=
 =?us-ascii?Q?f3XKu0XtfSM7pJRoJryj16EEiUogHxtyXBgHD8UkAz784tq8Q7v0cSiOv+oA?=
 =?us-ascii?Q?ncOdFPfNbUqFmZJW2Nn4G792VNCHo4cnZWfgUPhEHrR3ognEbdAcAbG7y2Zd?=
 =?us-ascii?Q?iYaQX2K5yr5iOWHWoA0spIidz4EzIw0Gihb/TgpOGFKakncnJJXXEukkJrdL?=
 =?us-ascii?Q?D+TYqvcoKsM/GTyYoIu7+dnSNzBLmB6tyS7tJ7VuI55m5Gb7KEbMgGW9YxYg?=
 =?us-ascii?Q?j9KVsRCzf3S5/xv2bE9antDW2JeKQJBOgUjGVKg4nXSaMnvLx4X7N0vJ36dR?=
 =?us-ascii?Q?O+lTN4k3D+Jx4mUuvrEhvYMSB5JCKNxxP3JmNkDJjd0naaC7QHYabqoT5poB?=
 =?us-ascii?Q?F70SF6FpIJ1tKcOa9u5vw+IbLcW+fbK5m8G0GL4BZL9BfK/LLLt6sEwINa4m?=
 =?us-ascii?Q?rUKJR7HyWdkbKg43eySH0sRXppicrhgiZhJ8Cy2Baj6kZJQIq67/O/ApdzSI?=
 =?us-ascii?Q?dFbj9Qk5I1/paRdvBmlA+oewBmfrtshNw5J+qODrbHV5i8bS7Gq6d+rP9Gvi?=
 =?us-ascii?Q?DWMx445EKAkmXsgPCb3Apf3CITgnoeOX1w19lKLRzLjSviFPTXI3j1gTX+tU?=
 =?us-ascii?Q?QCduDMs0IUqJvXYpewKXbDelKUdi2EBxPKlCnG3WEIYdh/yEajCnmQYMh0JR?=
 =?us-ascii?Q?0eNlyEz0HboHuCEHQZ7wLLhg0zpKaNvHSHlKL5Gh/zJspgkMLP40bBHALBQd?=
 =?us-ascii?Q?HCgUe21tWsW8OQS4rC1YIOu/jAiRernuhDnXPvztUrh3mH0ZBNTQZBgMhhHx?=
 =?us-ascii?Q?dN0VeR1W4cDhka/hYr+MdE5DP65t4YhcDdlqt8za6ODjEKmR1yC8DMmA5eIp?=
 =?us-ascii?Q?cfsbknB++zfjJvQdj/rLs/B/DwzpL5jla2BuqfpLmVAvl8qb8BXu/PyfBH+X?=
 =?us-ascii?Q?ON37+zCr3DVXL0QWfGQEXy4iVoCJLoTptVy4ug87Ha6Yv09kNCYHfnvAG7V5?=
 =?us-ascii?Q?lKD+ES/dq5/cXWtw0WwxYXrVe6xJZJKKAZhkUtIgCBYl68kvw8NpO5AV0wnu?=
 =?us-ascii?Q?0dWPN5+pkZiwZPW4Mb1mhuCcRv8raej3+6vHxyhCuvWwyorxn/VE5n9vFyKu?=
 =?us-ascii?Q?ixoO9K4sURucbZEu73KrcMNbRcoY2q6CIqTviJTW91tono6f9YHVKnkVzmHn?=
 =?us-ascii?Q?S7Rj+w+6Xr8JSYuONJ1bW8686+KuCKme+/ApDdlI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9d3d66-8454-438d-89dd-08dbf23eb063
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 07:25:27.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrBPZ/lyVN2Z+LjH/fQdu2EVqfrKRkgef6Ih5rOVL4dSH4XDMaLEHt3nWCjKcDe3ml0xQ/Ul5r0MRJVOxShWYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4166
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
index 2f646773a934..95de1204e1e5
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2861,11 +2861,20 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
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
@@ -2929,7 +2938,7 @@ static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
 			gfp_t gfp_flags, unsigned int alloc_flags,
-			int migratetype)
+			int migratetype, bool *highatomic)
 {
 	struct page *page;
 
@@ -2949,6 +2958,24 @@ struct page *rmqueue(struct zone *preferred_zone,
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
@@ -3219,6 +3246,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
+	bool highatomic = false;
 
 retry:
 	/*
@@ -3350,7 +3378,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
-				gfp_mask, alloc_flags, ac->migratetype);
+				gfp_mask, alloc_flags, ac->migratetype, &highatomic);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
@@ -3358,7 +3386,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
+			if (unlikely(highatomic))
 				reserve_highatomic_pageblock(page, zone);
 
 			return page;
-- 
2.39.0

