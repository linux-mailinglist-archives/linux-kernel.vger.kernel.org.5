Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1895C7F620A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbjKWOvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345882AbjKWOvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:51:07 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5892D44
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:51:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqU6CjSBqSXbXWVMLwq+4Pcs0k7UreyKZ8A5fstHtKM+ZWSIMAQnqCpnJwAPe3GBSTItvqjuHTKZSlkVgjJS9d5YpFrNK6hcVnTqXR0Ads7QIy179ADPixUHpzTLNe0eUvrj2Q3Vx5aq1ipAX2cBc9UWr+kgI5ZBT7RyRd1WlX2yoIboafb23FswYXLnnYuVe+/k6Dc3N128ZwcsWkzm1VVIeuEntqBBJT52F2O4AAmHXVtZ+VAawaqK5/XS5JtIsPSQS27+jvKrWzjEuLffFwZApn/JIXCO7ZdOHJeA1f2yGGNPG+AbGl+Bd+pKXLXG9qYSQGDkwv+5K9VCSkRZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTIqclJ02i6ZeRgQeohCcDYE1go2oPIXQLh0H/48ifA=;
 b=IZ7SQLd8DgjpjuVcSPYOYqPcxGBKVoCcMQeQAP9G5EXVAuGgRYS0tmMsGf6WcmV8R4hCOGstBgXV2+YixUCZAuitsxZKSw+3dMq1HONekJtjlcwUHu10IAb2O+0MICxE1tkvpCjZH5W0TkU8Hk9LvNjGc9d1M36yJZi29gO2RR5/qD1x1gpchea30Q5hb4L7PvRDld6DKkklKAmDb1mArPXkEqpqIF2fNvyGA/zPWGMP6D3OVMMhuMDKYyNiD2rIAHd7u27CtIiXJwxlqLmFxBBoQQlBCUJjFnHkOTjeJIQmAfxQ8D/M5jWixhDm5/p2MpT/gvXT6rkJapztmAoREw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTIqclJ02i6ZeRgQeohCcDYE1go2oPIXQLh0H/48ifA=;
 b=QuE0QEHf9we8vOWJPWshwkMsXaKN3qFzG9nGdwoBW+RaiZ5mzqAJRjAOlq1ZuzqfTAAfjUFHf09xVgSAe4jN8GCD+yf0KSHxggoDPvaQgWrlntL/vaEVVhqyyPiowTqYFxFFacYZh+Kiw4ghbLikhu+Dd+cdjBQXpjTFCqvCiq0J4sq2Viv6hKuLD2g7M6cWXFMxCZK6wKwCPS2mgNQeBa1gHRK5Ny2/r+oaD8D/1DENKi4SZnCJouU5RlTHsxlG+okF/+uMNu6iY4xGlZrK5AD22oW9rCEwRqzQUtfowEpPn+zkqhqvwiJ8OQxvAzvsKkBtRiQsEjpqzURVBjtuLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 14:51:02 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 14:51:01 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: ALLOC_HIGHATOMIC flag allocation issue
Date:   Thu, 23 Nov 2023 22:50:52 +0800
Message-ID: <20231123145052.613-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e58b87-1099-4013-31a3-08dbec339bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtAiuyJo86hWd1L9U8T1vxrR8dDGY9pCyd2OiFbr2S98pV9XuVkDy1ZIxpBGYCmc8f26t5r0dtU1Rl/KAdOrd1eNFp4hHC3+0zPpiGPKX+QXZLN93096WHuSv3pTsu9kr6WECHo/H1YY2houB0fAYGKnnFXRcbhcytGsYY4d6++qRNgOCsTEF1IiPd6/GRhs2BGjbGe8+UN6nbvHrtjyRa4fWF3vfbbhHrjY/dJ8+k0eQrkVTXzApIzs8cF0iBIOB82H8UyO5bLYPeBsCLcH+dtk9zhgkGc9M4oKAoltlPvCB+ETU6jmaun8QpRxkLNP4jufFqy/YR/Nbl/CyH0Un/r0t0JNiez7F6Kfq3vrj9SiMwYUwx0zZdDLRwYOTbdkQacQbkqTrmSVSzKS5VnGF9YTzRWgPWiBGSpd6BQJjG8mrEIZ4DzRLPQVEQ+RhXbpfxSXs3qWAlDql6wsS67vSxEP4cNq9mLWb4tBu92zpSepAhrNGrqdEyYYPlEFoJOVUk8cs3Wbu0dhrCWqNobNEy3aEqQ3Hi7mMvZfugwTUV4trnfk+rTdgwz66khVLVW9TKKu6jYV/P5ToFoW0WhalrWxgFodyiAQSeALGnGMgEFi+0DR6+eVnSRZmoMhTNPn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(107886003)(6512007)(6666004)(52116002)(1076003)(2616005)(26005)(38100700002)(6506007)(4326008)(8676002)(8936002)(316002)(2906002)(41300700001)(478600001)(6486002)(5660300002)(54906003)(66946007)(66556008)(66476007)(86362001)(36756003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CmphaCVlr+iX+McgNOk+6qsvCUUINPKbfaRQQh23dHldjFD3Ooc6qxOF4i4q?=
 =?us-ascii?Q?pgKiewOqvVfeP5r2OKzBhZR0GQc3ugZenvCuYZc7gcifvTvTGF9vZv1FtTF7?=
 =?us-ascii?Q?gmbnYlvCpWhf1JMmcS0KSOhd4pwPSrQjl0uDpa7Pl61hMv2onXZXfKHEMPh+?=
 =?us-ascii?Q?HIBFvX1PaO/LOuuwr6PFLb9WxWNjweOTVioMOW2A200avWoFVe3ytkOHcws8?=
 =?us-ascii?Q?d3IrizE1d6QhwXgDVBOYWSOzcK4x/WNHgUtSJ0uVJSlN8/CP7Ymi8Z9p8VT+?=
 =?us-ascii?Q?kEJ6VzVnixhM/B5sK7Owg1pKQRpk/PRs3pRYqx0o6u45SqBPqzSAlcNICjbU?=
 =?us-ascii?Q?swGpy6i6tFK5eWCjsS/Z2YEOYY2p9fRvD5DotKt+xkYEWHAmCgEY37OCIdj2?=
 =?us-ascii?Q?EXO4Z7YRhQiFnerlYyPvqoKHjBL8zpaFVFjNQsv0pH9PEBn1vWD+UTqqkUJ7?=
 =?us-ascii?Q?PgGA5ztlTuGi7zIoWn8nb/DJILyWqIMfLKTKQ/1KGbDZvG4aFhnCkMaoV2d8?=
 =?us-ascii?Q?T+TYYwmaH+AK7akMyEQ8XabA5kmjU0UCI4X1va62KQtiUfrPBhrdUqtIhjFQ?=
 =?us-ascii?Q?bgfgUP0p6YuwGqhL+FfMXSSKvRWpqHi8eIvAQ4TeazPxBalk9b+VTozmYLAI?=
 =?us-ascii?Q?+XpUesVLrNBbx1+cQxkN7cEMoAtKm21IdkXaaSF+5oQ7AOPyxh5d+6wgwyCG?=
 =?us-ascii?Q?/YNqI0J/6QgFXKMUTz88FDpi9Byy9DKc8ytJHt/sGZjoAgs+a21gK5bU7EvD?=
 =?us-ascii?Q?ASs/H9a29HkzFjLVurpwbBgqZPQhD3zzkA2icwx6PiwPN3CZ8ODz3RLSodk4?=
 =?us-ascii?Q?MhGETFuSA7YfyCWdp7fwjfsPzqbFZlRrU72nZww793WbhKesj0D6X28O76qJ?=
 =?us-ascii?Q?rSl/FhlUjSMBhBhSMvrCZbhWc1UyvkkQe1M/0u5vh49QFAWDJEUHb4GoQvV5?=
 =?us-ascii?Q?d7XSMn+VdhKYxW4kiMtZGFt+4kWpcIZUe0D9Sgqcd8nExyss78aXT68g4Thq?=
 =?us-ascii?Q?LhLqWJnHaLa+pJYfGCMFgYdjYm5ji21i4IHKagBHHKi3ibGedMb/MxgcXNOU?=
 =?us-ascii?Q?Z8h0QFSM/tNCWLJfT3qB34p9SI3A1cBwFU4V9YuHGVZphiF99COC3OVG1kA2?=
 =?us-ascii?Q?hFWV8bpxkizcRTJPc5Q/zboSKqKyQAKD6C/JJ5+tebj2rBp+R8e7ToiR9bym?=
 =?us-ascii?Q?lxuZksOchLh7kvur93NJW79j9DIewWksFxgmBSUvBeuiuBbfGXT4ZvylQnyG?=
 =?us-ascii?Q?dEkDJAPYt4M1IafA9vvNL/dAh9eihsuMhxdMPYtbxQfyckvQY2Y0cp6BT62e?=
 =?us-ascii?Q?/tDt0DqqJCuHG5yonlW6QGQz64yi4VdKOx+Y05VPSDkgObS0QsRRm8KD69oe?=
 =?us-ascii?Q?XprRorAq6Tlifj05ZRxOg3Bd7ttzEz4mhQgMWEG4lPDFm3TXn14S3M5Q4knv?=
 =?us-ascii?Q?AusdnPIrygU9wQ93pG1Rb/oeXh+WHKFslmm38jCyr6ZCNCqSzkw442Fviuo7?=
 =?us-ascii?Q?w6OmtSSkIcP0kE2GZbqg5KiB15rutfoFwj8VqA1biOc9Lv+W8V7dKveQykhg?=
 =?us-ascii?Q?CfueKPL4UvRARAdyYJbdxpkvDTW8KLUWWdgoJlI1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e58b87-1099-4013-31a3-08dbec339bf4
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 14:51:01.1204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/q89At5e2XAjSYoGvpije7S57L1nOdO2lPNF14Egy7phrn1VoSJihbhvUo94P0yCwe9BuVYPXRYftDA+2kVWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 7a8dac0c1c74..693e86fc9850
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2850,11 +2850,20 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int batch = nr_pcp_alloc(pcp, zone, order);
 			int alloced;
 
+			/*
+			 * If pcplist is empty and alloc_flags contains
+			 * ALLOC_HIGHATOMIC, alloc from buddy highatomic
+			 * freelist first.
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
+			int migratetype, bool *highatomic)
 {
 	struct page *page;
 
@@ -2938,6 +2947,24 @@ struct page *rmqueue(struct zone *preferred_zone,
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
@@ -3208,6 +3235,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
+	bool highatomic = false;
 
 retry:
 	/*
@@ -3339,7 +3367,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
-				gfp_mask, alloc_flags, ac->migratetype);
+				gfp_mask, alloc_flags, ac->migratetype, &highatomic);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
@@ -3347,7 +3375,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
+			if (unlikely(highatomic))
 				reserve_highatomic_pageblock(page, zone);
 
 			return page;
-- 
2.39.0

