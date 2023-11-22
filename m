Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0743D7F3B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbjKVBjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKVBjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:39:41 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F082A4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:39:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avDjjiCCTs92uVb3t9Zz3z9XVh+6B4ChHc9nqSQ4/Ynou94l9wzLqiQ4Pso3kDevKkJx8XKE5cLX2ZgAawpZP66x6fC0EDcRtZLgX4aZ3Zaa0j+tPa/+qAusEZ8FaLUuJvtDE38OkUDlAdTqfshRMLiXnYhRDCB8tP2hXuQEovKeVuEG14FyokbD69Fi6yFacgcsyh7FwGGBiuvj9BpyjL168TvT/mL5/l6ISCWwUpBKhHPlM93qrZgSgUlk8RJpryLIMYRpdIigDUUFJqN4+32NEcTBaK/9lzsH4LnI6QG1Q9UVwuqWpjrRK0MO5hGsuVimv/y9LNJC96GTC2PRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1E9B1UsA9ko9frPuWzIhxvWJ+iGT5YqtLalyzTP3bZ4=;
 b=lWqHAg8L92OsIGwjpXFY1Bc8WsrhEPB6PfPXJNNQMxUyIU3iWbVgRKGCCo7VJskYkmz3S6yY2inrHJTZJvV4o16ms8I2vV9RYOLwttfXNrGcqHJTQk4YTICaHoLdVj14Y+zKgaRpP87zmUInlEGJv0jyplGgYis3F6jkdq4p4atmj7AkN/mW7L/HQRbO3VPZ2v1HuOGdiJE5E7dOpFFCtFqV9xQmpG8HxqoSBG3n8MQnW7mUoYrDMYaoGAlY/FnDJ3c0OgNOPVJGmv+qa51Cnko2cscgrV/OiJeUQhDf7swTT/a/MPD5Vf9pVL68Pu/P4wJ2/FNkUjioQNE9BscP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E9B1UsA9ko9frPuWzIhxvWJ+iGT5YqtLalyzTP3bZ4=;
 b=l9ryEpcMIqiYM/Zm1Ug3f38T8UNHWHGUB+eXZbwXSmN2bG5j1FpN4Z09Ybks9UHrbMFq/SdLZg2Nzdvow3NjTzzXkLNrIgKYiGd+kbk7Pbuq3FaTebzzejUwL7NJm6gvUDsdfNBiJI4YzQkD7wejJZEghP51+lGAxmRqeEnx/kXCkHb5kSK5cJ6YmxYtLM2qJLfdYtYoyoWTrt+N7vAlW1/6k0R2/mqQz0t60EpVvhK/R8lQXKn5rClb1PXTq0BmAu1dRiZQqTqbHXecToA+8EgXAzTYITOMV8E2RREoN/XzzW+iKGt5Q4bC1Ef5mtsPkgy5ZB/MKYq6wf1eBKyoew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SI2PR06MB4393.apcprd06.prod.outlook.com (2603:1096:4:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 01:39:33 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 01:39:33 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v3] mm: ALLOC_HIGHATOMIC flag allocation issue
Date:   Wed, 22 Nov 2023 09:39:25 +0800
Message-ID: <20231122013925.1507-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SI2PR06MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: f8306092-db65-4962-3669-08dbeafbe0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHBE2bbvucF1a5IgFfTZ76jy9jY1jaXj+qMcGRCVRen2562byYgbrfXboFx+HXd/a4tUbZAace/6IWhJSuss92BpYVFY3815wXWJ/pyKD9cZV1RtpkRw+pvuF+VA2EydDnaAfapsfku6MkxL+dsFQQtdYFrlut3/9WzRjuFRhmG30qAwCJogTlwzCl0QEYv3JNd452rUkU9nkT8b6KcJiRSi4iHpOXD1PgRLm3eA9OEQw1JMXCduVDz4cybScSsBVgP/caKPEyChBR4/6DIinLoPT4cqZS2NRo72Ktj+1NbvcTtYbreMUGHv11Q25ImDs9L6Y8mgOpEQcGmy1axbb3QyG28j18wEAdfuyxYuwihmxr/f6Qyl9XK7ZtdRHJ9Gv4IaPcOKyddXgIGotLoTuuSMtJ+5Zdrk0vP8BJeMvKOyhy2ruZVn32PY3wIrc8rO4+qtwHhOmoEgtJyb5Qa5odwUgjufh/PsF2Hpmq1vA9s/SOHb7lwShSOr78yh4e04xvCQy0JTNf9L4i87xNLzUGQwvR5kh23PMPz6+o2ooOeOySoXruN5pUH8INdvl4+x+8Epe/1XD8MEpEHCUQOsn7FZVYyyO3nVxWoJ9x6aJzA0FDk4vf2Z4g2G7zaMpwwR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(2906002)(36756003)(8936002)(8676002)(4326008)(86362001)(41300700001)(6666004)(6512007)(6506007)(52116002)(478600001)(38350700005)(6486002)(26005)(1076003)(2616005)(107886003)(316002)(66946007)(66556008)(66476007)(83380400001)(54906003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Th06fQYCNiu7KVDLF+E+zT4Kk0uN/F/hzScBcZQTaZAFhfZaOiQJNK7xOY7V?=
 =?us-ascii?Q?zgW08rQVhTPFOI6eiR5NwKUAV4U08hezfdqKcPwNX8w+7PAvYelnXsqtaiFQ?=
 =?us-ascii?Q?n3vsKAUwdgn7DSGDC3DGK7fp03hNw4jUTTlqJccB96m/qgyalNGd+2Bnvhd/?=
 =?us-ascii?Q?AJyJu+pxMopgMQqSyERn2vCipKn5EeeYGhHS9AI5jo/NIQ5OkO5CGs7VUvrw?=
 =?us-ascii?Q?mz4kWrMEzgqxXB1CXhbXpZyTF42g6IyLTUevqPQWdjfFxrIzqO4UbSKRu2A2?=
 =?us-ascii?Q?ShusGPRMna+xpJ0QJQpJ7J6quo9B1ssAsP8D5/6672CoHJfX8TxVa8kpetgT?=
 =?us-ascii?Q?8S5qZp+lSw1qQlu0ewsVyYGkqi+p90xiRKX1spRRH8pLMgDltqkIg+eJe7uv?=
 =?us-ascii?Q?UDKaKiFcq5abf+19tUSZsyohrKxos2pCvGUMd3x1rs263Q246wFBXeQ7ZUTg?=
 =?us-ascii?Q?XtD7J+BPA3CagLfSKOs1kEI8LabH3OMOoxouBfwFJDL5nxRkerBxlAor1CSh?=
 =?us-ascii?Q?Rqhhkhh2KJMq3dOyUoXuBCYHz4rjvqzt1VAY9jrczKOS1vpDn/+i3qx/nBQq?=
 =?us-ascii?Q?InacHvclhg2UXnQxN0uVNSLcMvfhcCvjmbCXwN3A7EmeLqHgdVBa1erhl+E5?=
 =?us-ascii?Q?x9NYQY901HacZr37ML/WBNgZW2uLvv1ZgDPq+zih0yO4kyKeHImap4cFFz03?=
 =?us-ascii?Q?5PeKA5PdV/p8yCfHGmLEqq4cxVTOHlwyaLiifOWk/XfAG8IBsp6FMNcAP2zM?=
 =?us-ascii?Q?XxshEbtnH0FziRxDEeanVD7CxBS92WTtAX4g5iWVeV0bVcOAV1VJlt9at+JX?=
 =?us-ascii?Q?qqWR3awUfJOM4C5q6EGLr85btZLt9m6y2jRhUeb7h72dR1n95RSZSxOeU2FV?=
 =?us-ascii?Q?GQmudvyFaZX4mljKw0lHlnPmzbd3alwO7UYZqMFxzQORhyiikv5iQSO3SS7j?=
 =?us-ascii?Q?ZYgmwblpzmzLJiro5ZspS8rXlJxZKhotPO37iCr87cQWitNnFiSqYGWXTJ14?=
 =?us-ascii?Q?H3HF4jY7yPnjq+rwM7t8y/GOkFpdd6JceCht7xA8tKHdKPzRU9uO/cR+QK3E?=
 =?us-ascii?Q?hmmiFF0dgAULJnRIQhljlq1mmAUsePOS402L2g5oFaYNoJmXV9wdg8dPTmgP?=
 =?us-ascii?Q?ydM8nwPNs3S2/isKaGd5XAEtfSgcOl22hdBaHp0F2I/mXXDm/FyRGvlWgr1f?=
 =?us-ascii?Q?EhcFM3LVJy6HsSsKzVRFwQRlDkcoq+lPhQ7D0ZRqmD6glbYP11nV7JV5S6rJ?=
 =?us-ascii?Q?Q+tENku4DNCnXD2jMGnLq9Q2TCUvA1zsj5q/fby1jw1FxOdO/vl4gNK0sCAp?=
 =?us-ascii?Q?vkBHbpZ65HFnSQ5uOGoPzNfzK61mEQAEf/3rBSPVjO8hyKKRBf+eOST0LSfY?=
 =?us-ascii?Q?mZGJ80qwbN+ON9AbpY72ZrN5XiUcoevT3I7ZuNU7L9D3zO55JpeXmnFFE9Vr?=
 =?us-ascii?Q?cvhEKU4pKTppxlTZ1B8NamI02XwB97o1zPFw02/S4WQNRn1kzm5iFAY2e+r6?=
 =?us-ascii?Q?uP1hMy3Lgbveq5K0B4rf2mFdJpaSQjFzM9G20ciTufmlccSTP6Xb9lXn4dyj?=
 =?us-ascii?Q?lW3iuMNTGO1pp9TvOjj1zdN2+vlMDGGjt1ZDrppR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8306092-db65-4962-3669-08dbeafbe0d7
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 01:39:33.4258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCsW7z+mNXiVxIlj0wwul5P6asPRyZnMZ6A8WqmrXhLd2iMoRa3jR4EG/PyQLkcsiP0+v2A8P+iCLQc8nRVCdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4393
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update base on the latest Linus' tree or Andrew's tree.

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
Update comments and modify variable highatomic_allocation to highatomic.

 mm/page_alloc.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 49890d00cc3c..693e86fc9850 100755
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2851,9 +2851,9 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int alloced;
 
 			/*
-			 * If pcplist is empty and alloc_flags is with ALLOC_HIGHATOMIC,
-			 * it should alloc from buddy highatomic migrate freelist firstly
-			 * to ensure quick and successful allocation.
+			 * If pcplist is empty and alloc_flags contains
+			 * ALLOC_HIGHATOMIC, alloc from buddy highatomic
+			 * freelist first.
 			 */
 			if (alloc_flags & ALLOC_HIGHATOMIC)
 				goto out;
@@ -2927,7 +2927,7 @@ static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
 			gfp_t gfp_flags, unsigned int alloc_flags,
-			int migratetype, bool *highatomc_allocation)
+			int migratetype, bool *highatomic)
 {
 	struct page *page;
 
@@ -2948,21 +2948,22 @@ struct page *rmqueue(struct zone *preferred_zone,
 							migratetype);
 
 	/*
-	 * The high-order atomic allocation pageblock reserved conditions:
+	 * The high-order atomic allocation pageblock reserved:
 	 *
-	 * If the high-order atomic allocation page is alloced from pcplist,
-	 * the highatomic pageblock does not need to be reserved, which can
-	 * void to migrate an increasing number of pages into buddy
-	 * MIGRATE_HIGHATOMIC freelist and lead to an increasing risk of
-	 * allocation failure on other buddy migrate freelists.
+	 * If the high-order atomic page is allocated from pcplist,
+	 * the highatomic pageblock does not need to be reserved,
+	 * which can avoid migrating an increasing number of pages
+	 * into buddy highatomic freelist and leading to an increased
+	 * risk of allocation failure on other migrate freelists in
+	 * buddy.
 	 *
-	 * If the high-order atomic allocation page is alloced from buddy
-	 * highatomic migrate freelist, regardless of whether the allocation
-	 * is successful or not, the highatomic pageblock can try to be
-	 * reserved.
+	 * If the high-order atomic page is allocated from buddy
+	 * highatomic freelist, regardless of whether the allocation
+	 * is successful or not, the highatomic pageblock can try to
+	 * be reserved.
 	 */
 	if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
-		*highatomc_allocation = true;
+		*highatomic = true;
 
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
@@ -3234,7 +3235,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
-	bool highatomc_allocation = false;
+	bool highatomic = false;
 
 retry:
 	/*
@@ -3366,7 +3367,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
-				gfp_mask, alloc_flags, ac->migratetype, &highatomc_allocation);
+				gfp_mask, alloc_flags, ac->migratetype, &highatomic);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
@@ -3374,7 +3375,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(highatomc_allocation))
+			if (unlikely(highatomic))
 				reserve_highatomic_pageblock(page, zone);
 
 			return page;
-- 
2.39.0

