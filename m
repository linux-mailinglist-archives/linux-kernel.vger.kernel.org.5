Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E257F3E95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjKVHGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjKVHGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:06:16 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2134.outbound.protection.outlook.com [40.107.117.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21F41A4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:06:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiF/51+YJLugmjv3/w+QZjPANRlcv9o9YzrR3nCaVCWmM7dT/oMgvdNgcufZmt1ZShs0EEyOc9NPb/8RPs121BdUbsttpaDkSdP3X2Fm00k5dPFmzYYn2LlGNz3Z+KLTERb0xwt7GTqqe2MebsMZZrUNtVR0tOfWLpNd2ioczlaVyEtTszAFzml1tO2/O0jwhcsxbQfyZRim9BVJlOqOlzyQvAPSE2i5nMBNjWIlHiZw/HFCSWdFxerEwsix+SZsPvpj2su2UqWJe6wuLw0pHEvmXk5uatnnAoOLej4J5Nw5DgPcxjzdquuhPHj8lF5olxL6O9REJ27ZOs81qekx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AS/BDuUI/fRxsY5oJxPDU+Nddln7hHB90OOcqoMPlk=;
 b=c+kK6bnsIShqRpXqBqwp/vaauO4hFsotIL4wjXV1XlZuSYjFNB1ynL209reRwGcbBdM0qmQ7qNb2T56+ijK7d9g6a8CKDRyKD75xxXqSwvJuP3pAZ5+T89z8ZJs9l4X4xa5ZnO847vf9t49J7syb0a4uzURmxgsw9fGLbEaltcjQ0cRSh1rrWwl1CzfAzVDQ1/G5lGqOMr2VZbNWqVs9Sujg3rplweJbrwmzD6dM5yqx/+ydL6nzBQk2bEgWjijf34hGebGDBeYsDB09OILyL9CtsjHEaE62UYgys79+e4Jjmtk5p+gDi54KsWzl6y++Pk+xR2rWOYUqnTA7PqExQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AS/BDuUI/fRxsY5oJxPDU+Nddln7hHB90OOcqoMPlk=;
 b=by5ruwbZDtU7hy4tgCpnv0XBmmOwYkvmnGErxTwxgDQHRlOQPcXg1cGdcf/p1llt/SPTPayulpIZuRZd1rnXjraVNCCx4OO0GbmJiJJ8Nccpi40adcOxp4PMlRz6ikHGgzm7Oj4z5/atvrcamsPnXOdQ0VLZmRrONOpfmxd5a2wopt7MDOWCqePmhEttTA0KjB62OWL4sazr399pmXQk/pWwdhn4GI+hOD5d0NGsN1biVf22zBLen+6Ub6AulIn59kOQBepupQCJoctUIN3zgmLg7X9Dy/rdvi7k3iIp8A9/5iNwYe5OAjKDycrQbd2NQxbGDS7Giw0z8WaWxJldEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB6192.apcprd06.prod.outlook.com (2603:1096:400:332::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 07:06:09 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 07:06:09 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v4] mm: ALLOC_HIGHATOMIC flag allocation issue
Date:   Wed, 22 Nov 2023 15:05:58 +0800
Message-ID: <20231122070558.1774-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 940bdbf7-46ab-4406-4ba2-08dbeb297fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFknu7NUMbirHoGe0szQAZ0bAetoI0bXwuCzWniAIGN9OMju5qBAxVAh/BuYdMndBaKeGEewas5lm7bYv8i0YghQxwIb2Cbu/5KfpxFxBw6DGMA7a3jGeTk6k7Z+bDWdAN4EgrPxpoWYh/NB0d6lbTQVnrJjrkdCypSjy8vgSjgI3U4WrUYLCm9QOzIWGW0/joliAAxcO2Am9XQ2EXWNlCg4jyMkwjrkZ+zMVT+jbk4n+60zDt4aEdKI4H8IE3lJ3hfWMF4YK6bFrLFCcY6a6hjCUN+0vd/JcVvNSrO0SOX14iCRYKOE/c2f1Va9XOofykEjkV2GKRdO825frGIa2sqZ/PF7QDg3DZl6U8nkHykG6sYs1exyEnPX49JtTz4KoIEgq1CPvVP6mq3vCveC+X3Cgpvoe8mdroTMJWGPJ7sVT2mX+Nh+cjv71scWt2e827Xyy5W9Ao7HdaaBWWMTjJA0UOxhfiKmx+myLRYVW87QQRxQmLCWNNmPUOuIqIkM1umI+Ul6RVNE5UM9+TO+DBHsidQKNG7e84gYzuk1Jfo8L/6SR/ZD3vEnH4Vp63catsgM/QkHO5zko5dFeCCJni0YUSNK28tXvS0FbDPJBvUX7C59Hz44anuRGc0CEFT8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(39850400004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(316002)(66556008)(1076003)(107886003)(2616005)(26005)(66946007)(41300700001)(478600001)(66476007)(54906003)(6512007)(6506007)(6486002)(83380400001)(52116002)(6666004)(8676002)(8936002)(4326008)(2906002)(5660300002)(38350700005)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HTBPxGBTRdMgMcAKA8kWObdBq6422pOguphwm+MK+t2TnZc4MBBID2k2FDHW?=
 =?us-ascii?Q?5k53w0+WP8L9PP8414HQL+lb9feDxIkAv1IGgKikQaRMfTUoBD7Nk2TAOiNz?=
 =?us-ascii?Q?ljdJaqCDvVdyd9z/GT9HhQOuHMJB0ErRjWQCMg9I+mqx0tOhQw/kBiM3YtTi?=
 =?us-ascii?Q?M4X0akt/ipReu9FZKpI98BUcRRtQVG+ijFBcHH6LzSZdQs4zlBwnbkzo8GLI?=
 =?us-ascii?Q?G71XcUFGLZV2/BSicUxBWbF3lMvvoWiJSbjrQrDcBB3Lj4gIUhx7PiFaZjkr?=
 =?us-ascii?Q?81vKzdmblq13S41+lcZPLPUbArt1XJz2LBxUr7vcUKPo5rTwGivWeKuMfsFO?=
 =?us-ascii?Q?mlwgDs1Zxgrchhg6QhZQ9aH2xufWTSvccmJLJg3Fy3nHu56z7uakNG5Dka1Z?=
 =?us-ascii?Q?lxBLA3R4ojmVz+SE4vcKcE7H/aDtpLTZNBX2+jmkezK9o8iWICbUG5SXpHWk?=
 =?us-ascii?Q?oSDYrv/PKXhQmJP5YLdwCzLlgNCuqMZRA9ECr1sWUtJQS/DY72zWIFbE+Xts?=
 =?us-ascii?Q?LhRqDmLYUcVaVFtF4W6FFyjGvkH94IWzWFXC8DKeYBHjYWe0hZVljkCNaJqP?=
 =?us-ascii?Q?n4JfNMTz8zBOREeBBKK3Yv2isr5wMVBLRCGgtbgbHePpxoGb/rjpkMx5nY0I?=
 =?us-ascii?Q?6gHWNxrHX0WdieGIO20wmkR5OZPfohFWzzXLO6V9S4LvzfVCDSGVPF0L9t26?=
 =?us-ascii?Q?0doc4xHcJTK0oXBnrp758QjXQBqVwHPatljM3bF8MhjLe+TWSVU8zgt0TscC?=
 =?us-ascii?Q?ZM02WrYom/lkFKXFLQtqG2P4GQdhml/76XSWC09k3frCw/VXniBZSxhOlrN5?=
 =?us-ascii?Q?6FRRIJ4VrBOjrwwLK3rgXxHc/kOfbe2zjCI0j6T1wEl4AtL/5C0RQ1jx8SMB?=
 =?us-ascii?Q?1w8c4JSIS/UWEn0a3txbSynMpEkwaE6GwAr2tgL6686qy45y1hd+1SA+HjT8?=
 =?us-ascii?Q?AIzFe4OjsjhPyTJ8ay4sVpf3xsnn4AI+hVBfEKVeTiz6ZGxSkFr0qHSBauaM?=
 =?us-ascii?Q?hGPK8UadB4sozr4Nie/AugXoeQhDFXln1t4vUmFlCPYZZubMPku2q4okXGkP?=
 =?us-ascii?Q?4cu/ChTDJggV3A658glpHYUmvDDgz3MO483wyJ7SrJVH1zEh+0bn4mm58rpC?=
 =?us-ascii?Q?4k8OnkZ9r1FYgqGydfHa+DiSU8IDuFBIiNug2gj2OiVl76NRk7w2fXVjld4A?=
 =?us-ascii?Q?i1Ite0d5UBUNcEO5rKuxfYUV6b7VM/9dWqVNL7D9dC5RHQ/6bAwbawRcylUh?=
 =?us-ascii?Q?K8jjW4ciuG6t7lFLuUiHvo0/T9biQ2rjfrMbHXxC4ixLnH5kYD7qu1nPQ52z?=
 =?us-ascii?Q?OEsLpPNrMLGmhHhR90RNKo4DqnDA3O/Ej9N9xjdw7yHSMnUZE3Dx2wF1hXpm?=
 =?us-ascii?Q?tUonxKAo3ail7l4koDFuRG/rLMKeyTxyryBcCbEQ7QSjsIzehXj94U+zz/Xv?=
 =?us-ascii?Q?U8IKHtV6Do3jtTl3YzO4AeucFgnFITRAoQK6KrtclBjlhk1oVz+UzGBMP8oP?=
 =?us-ascii?Q?vxS9wgJI+7uSgTuU+GhndogkUoHx8cu0xHmyhdtw59VKAOamoSMa+am7GBNN?=
 =?us-ascii?Q?LbZz/JcB5qy7SuyjlkEcT3nOvikaeK3aSmH+/kMr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940bdbf7-46ab-4406-4ba2-08dbeb297fda
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 07:06:08.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svKydN0ah0rXFSHCjqK+5XOyxYI0s+IdkUz+30AlR1pfgJr2jRHY8x3ZzFfGccQqO49qfoiXHILHGNV2bV073A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6192
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

Changelog:
v1 -> v2:
Update comments and modify variable highatomic_allocation to highatomic.

v2 -> v3:
Update base on the latest Linus' tree or Andrew's tree.

v3 -> v4:
Update base on the latest Linus' tree or Andrew's tree.

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

