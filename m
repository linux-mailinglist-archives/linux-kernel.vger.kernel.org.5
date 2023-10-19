Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D047CFAAC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345856AbjJSNPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345494AbjJSNPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:15:07 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541498
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9QY1dxPHAn4Zx7A/ycRUF+TreMuWVmq14wK8cjQCxHwzZuob/1AahWf7IhDrD9YF0zvx1HSDKlGOPEH3fH7daKi5A+lncfcMNK9klvuCSnd8MvFEX7EnoAPDyiUxnoYRzIZo0tJhrelv7BSFEN5QpdAmzUyYLwrHzbVlSroF3DSt4rRYJ+LVVPElLurLIOcZBfNnAEE56hFo5yeJm/xp5N5bPuTY50Z08UCU8ROtA/rS297k9/D4RbfO1Bxi6U7soI8i9tuLjPYqbXL7FRRsDjfh6yJoJ3GLkTyi4pO5Zjo0M6+1hDOB7Kgb/A3LW3AwUhyLPaV5vRn6n6ZHSLjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVCbfCgY6uphg+FnjetqR8dr7AX+sQTlt8WYhEGY+o4=;
 b=e3k6DNOjmaqI5xOkGIJddfVakZWwNT9CSwjad02flAKxdnbqiisN3/mmhXYn9I/z2Mpx5uXRw/lg/bUQASERb2nzG/mtZ+qzujz3QLz0EITgKOhmt67ISy7oDOUYqm9arw2nl2HUj2CbdYCCbC11c+I0XmcChB1AydzcT0lWTDhJhMC7EGzJN1S2reSnS4ZHgMDs82LlFf0j4t/boHxEWFPQL3TLpBnPZ6urFrvMs+GkSq6ZtVTtr7mXZa8yksKe0EINcKidgG34Xv3SYpWb6aHJiZxiyFNbVmhvYKN/USrx+TcAFF4CUAjorwmv10kyoMDUU6A3coeYVPAGBoTIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVCbfCgY6uphg+FnjetqR8dr7AX+sQTlt8WYhEGY+o4=;
 b=oIqedpkDNK4kMlYxG3W+0qHZ3WxLlqIAymP4ElhFeUOZth6ZpMK3QtsQIo+xGU7jbvaYNbNTPuZUa4ZiLupSUqSqz07DV7mdsmJNN2sJ5OWG9jemYuNXIFNCYDafaVP038IoBD8GfEjFTyXpLDX0r+xAXCGN2P0ajauCB09+aZHWyJZpsve/FhrBb07TdVkuT+UKKkeIXgQiXKucGhaiPik/thd8kNKwAaC+G/GK9Dxh8ePYCsd/ODVb3SymjACgCeEXj006Le3GPi0zf2Mgg5H0JE6ehsf6INQVYrnpoxYUpu10Mm7Fgjayz3sVxT1PwvPaCs8NhUSjY1H3Ofcukg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by PSAPR06MB4470.apcprd06.prod.outlook.com (2603:1096:301:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 13:15:00 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5%7]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 13:15:00 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2 1/2] mm:vmscan: the dirty folio in folio_list skip unmap
Date:   Thu, 19 Oct 2023 21:14:45 +0800
Message-ID: <20231019131446.317-2-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
In-Reply-To: <20231019131446.317-1-justinjiang@vivo.com>
References: <20231019131446.317-1-justinjiang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0252.apcprd06.prod.outlook.com
 (2603:1096:4:ac::36) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|PSAPR06MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: e188ed6c-90b9-43aa-0779-08dbd0a565a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DHS/WHs1IjQVsApHeLVYgiRFe1PDoN1JMEQ1Tm+SSh/b3tyWKrxj1aDtTI9fNZdf8/TgZNTRiNrvcw+PGh5eP+Y5f//GAkx4+hKK7tkQ0HOEKC0y6VDHgnHtDe2431anqcHSQ5lOXM9nGgUdnGJ+mxN5iqIqTGKxA5aiCruaQ0QtrzUXDJCcDTgn4mSnFpk8nvw2W6quRC48ZS6gnjW/LDDe2xX4x1DteYk9yLYOlodsgn/Bb7VzO5Sfmp6ViQqxWCUVUPpOY/1KNabBim90vAAES8hqI10gVZ+O+fko0QiQEolyLsJtjZB4Z70NYN+/O/Ziar4cvFGcoknffKBfUNSog+Oln5D9wJW4XsitJqL43CKh2tOr21xna+g5njiVByF2rwMs1EO09n3ziF6WS94VxRoZWbfmcjEvq7xHZnn/GnoHRNQ5z0YKPOaTWKKzRzMVcJhvwM1mW4+7qAhISF2czffYgnObThVkTSPy1GwNsNeDdYddPr6faOCdY5xqrBQ12bg+m4ool15+8pplGTKZZKy2KDDpOgLlzAZacBktpDDamlyx6XsDjVTXLHio4m1qA049M5pRaEkPd1njsq1p374wC5PqL4r05qJI0C895i6d0j58KS0axmphrg8SutSlFjaKIsCyXzwQbZuvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(366004)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6666004)(2906002)(52116002)(6506007)(6486002)(478600001)(41300700001)(4326008)(8676002)(8936002)(5660300002)(66476007)(66556008)(66946007)(316002)(83380400001)(36756003)(26005)(38350700005)(1076003)(6512007)(107886003)(38100700002)(2616005)(86362001)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5vB90dhy0ZXy0r62r028RWkd9HDcJdyhwICByWP3t+ryyUVcFix42Y9Uwo1e?=
 =?us-ascii?Q?KhrZvdFJPYhPBepynrXuxetYI+hlgCrKok4vtgYKVGDhCo+4pKNjmRJy4eP0?=
 =?us-ascii?Q?Ek5ir3BLpuyDRQODLBHkfLCg5CoRw0EXp7uv/YXsQNsEBG6xgoSIVlh71Ly4?=
 =?us-ascii?Q?gOukGjM56CTZB+tHJFwsWiOzeIGR4eM8tZogP0yEGiriL90TyjHaJuIMuU1r?=
 =?us-ascii?Q?xpKjYGxuFZb2U+wQYh9MWBKJIi2P4ebJkIKjjABf5/ozmhyMIihONm6KwL9O?=
 =?us-ascii?Q?Wq/Yxx16ywOI8yxA7SQEh6yC0pBQrHmfUpptyYpnyihrl0i9fzRoOcbWGh+m?=
 =?us-ascii?Q?ybvqhByuSifGsCUfRjxbZuPEtA0o/r7btwT5e0eseBsHiFY1EXDx1e6vo0eO?=
 =?us-ascii?Q?JCtyZy9ydV8bOQnjtrW0J+56ysQWgzCkfjTuxxk5hzp6CwOE0OAo2PdcfdSk?=
 =?us-ascii?Q?jkoN1lFqa+nMvTl5ETta5829aKEZWm1yPJuTQof5aF2wo8AR+cMz+TUYgdjL?=
 =?us-ascii?Q?YU3h/bNuBpYr0mTmDd7SEAPDPJcjThJJ1mUKlfdKD74TtznlOUYcTMw6hsPG?=
 =?us-ascii?Q?vTgRJwanXyJeiBnKljMsOKzpoHXbMZu6u6P93LLyJm3Gm6EnD+qoloKVreLq?=
 =?us-ascii?Q?GQqgeyRckCnpZ35rEx2y1rziUq0WlqkYBDHiQhpjPKACy/f1EQNToogTPzGh?=
 =?us-ascii?Q?wFNwq5Y30l2RO8oy5PQT77Xev45hqKD3oDpSzMZ8QMlas7VrEL/XOUGKLw5b?=
 =?us-ascii?Q?3JcBrohZgadjo/HQABp40vxmZRoptakiVGtDLzfk1QqjjFWmWEbt8xv3MvP6?=
 =?us-ascii?Q?N+fHm7hx+ggRHp15Qm4s+DdFzVZoFpsfGfcM7zB2x8WkD2Knm+rwyyv9P7AG?=
 =?us-ascii?Q?gy5OCukKrpmlvwsKizgN7ssvXrYigSS09RufsoVOXJEq39lpcX/zWtdummwR?=
 =?us-ascii?Q?kdAA1BQWu8j156d6nsH01AF400dfLWeRavDoN9C5Q7BVOw22tClaKCKjmv6/?=
 =?us-ascii?Q?LZvFmSNBo9cfE1HMKemgvy62/Zr9RcrGt6knOvR8iHgJLG8X1E8jE7hiiPJK?=
 =?us-ascii?Q?ht1NGRKQk9jahxc9Kyv7O5xnwW91Ch/vSJyftD00w1kJUOijmp0LNxHyl9tP?=
 =?us-ascii?Q?FSe0ykT3ZVsjp7+m4nVDEkz+h2JX5qojhwmfWCa3MkNPmbpHzCldGX3Q0q9M?=
 =?us-ascii?Q?qnq2AQKWQ2YKEDFKrKFTgqWuGRv9s7QhS1fkXeH1DbMSoK8IKUheb21haDLY?=
 =?us-ascii?Q?fs9YFr82EqZ8z5Ie8tHNj+vwtxRgSIIBgrN+KFSUUTNjFBRQJgX674KXlTtY?=
 =?us-ascii?Q?tgzFkDr17gIajDGBp/AJKlK9FKahNXFVf6XnRESOyzK4g27iw/d4COEfVrdW?=
 =?us-ascii?Q?MejqUK5XNc5hNhBetALAD7iCfxi6CfTSUBbl9TuYFCQ2vdboqGtnI58PKetW?=
 =?us-ascii?Q?CXvj0H4+U8h2MexZHf/UdC3/cT4tu+YlhVZ2uiR6FtozVmoEwKNYlkuRSIOd?=
 =?us-ascii?Q?QFJVREjg/KjY/grn18RsBsAQEM5uNfDXZq2c1pGYVzjNUB0cpCLnY1UbmNNv?=
 =?us-ascii?Q?aPJfteKoOgjbNgpvzyTUElOZdYRTC6QwgYfFG+ir?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e188ed6c-90b9-43aa-0779-08dbd0a565a1
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:14:59.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSjMmEFfByqao/3v+0PEbPxtbWyxqjuSsF5XG7xvf3mYinAp2/q4z/H5Pbp1sbcjWnf5QTxd7BYuByQbS4d6Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the shrink_folio_list() the sources of the file dirty folio include
two ways below:
1. The dirty folio is from the incoming parameter folio_list,
   which is the inactive file lru.
2. The dirty folio is from the PTE dirty bit transferred by
   the try_to_unmap().

For the first source of the dirty folio, if the dirty folio does not
support pageout, the dirty folio can skip unmap in advance to reduce
recyling time.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Changelog:
v1->v2:
1. Keep the original judgment flow.
2. Add the interface of folio_check_pageout().
3. The dirty folio which does not support pageout in inactive file lru
   skip unmap in advance.

 mm/vmscan.c | 103 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 66 insertions(+), 37 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a68d01fcc307..e067269275a5 100755
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -925,6 +925,44 @@ static void folio_check_dirty_writeback(struct folio *folio,
 		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
 }
 
+/* Check if a dirty folio can support pageout in the recyling process*/
+static bool folio_check_pageout(struct folio *folio,
+						struct pglist_data *pgdat)
+{
+	int ret = true;
+
+	/*
+	 * Anonymous folios are not handled by flushers and must be written
+	 * from reclaim context. Do not stall reclaim based on them.
+	 * MADV_FREE anonymous folios are put into inactive file list too.
+	 * They could be mistakenly treated as file lru. So further anon
+	 * test is needed.
+	 */
+	if (!folio_is_file_lru(folio) ||
+		(folio_test_anon(folio) && !folio_test_swapbacked(folio)))
+		goto out;
+
+	if (folio_test_dirty(folio) &&
+		(!current_is_kswapd() ||
+		 !folio_test_reclaim(folio) ||
+		 !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
+		/*
+		 * Immediately reclaim when written back.
+		 * Similar in principle to folio_deactivate()
+		 * except we already have the folio isolated
+		 * and know it's dirty
+		 */
+		node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
+			folio_nr_pages(folio));
+		folio_set_reclaim(folio);
+
+		ret = false;
+	}
+
+out:
+	return ret;
+}
+
 static struct folio *alloc_demote_folio(struct folio *src,
 		unsigned long private)
 {
@@ -1078,6 +1116,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (dirty && !writeback)
 			stat->nr_unqueued_dirty += nr_pages;
 
+		/* If the dirty folio dose not support pageout,
+		 * the dirty folio can skip this recycling.
+		 */
+		if (!folio_check_pageout(folio, pgdat))
+			goto activate_locked;
+
 		/*
 		 * Treat this folio as congested if folios are cycling
 		 * through the LRU so quickly that the folios marked
@@ -1261,43 +1305,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			enum ttu_flags flags = TTU_BATCH_FLUSH;
 			bool was_swapbacked = folio_test_swapbacked(folio);
 
-			if (folio_test_dirty(folio)) {
-				/*
-				 * Only kswapd can writeback filesystem folios
-				 * to avoid risk of stack overflow. But avoid
-				 * injecting inefficient single-folio I/O into
-				 * flusher writeback as much as possible: only
-				 * write folios when we've encountered many
-				 * dirty folios, and when we've already scanned
-				 * the rest of the LRU for clean folios and see
-				 * the same dirty folios again (with the reclaim
-				 * flag set).
-				 */
-				if (folio_is_file_lru(folio) &&
-					(!current_is_kswapd() ||
-					 !folio_test_reclaim(folio) ||
-					 !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
-					/*
-					 * Immediately reclaim when written back.
-					 * Similar in principle to folio_deactivate()
-					 * except we already have the folio isolated
-					 * and know it's dirty
-					 */
-					node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
-							nr_pages);
-					folio_set_reclaim(folio);
-
-					goto activate_locked;
-				}
-
-				if (references == FOLIOREF_RECLAIM_CLEAN)
-					goto keep_locked;
-				if (!may_enter_fs(folio, sc->gfp_mask))
-					goto keep_locked;
-				if (!sc->may_writepage)
-					goto keep_locked;
-			}
-
 			if (folio_test_pmd_mappable(folio))
 				flags |= TTU_SPLIT_HUGE_PMD;
 
@@ -1323,6 +1330,28 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 		mapping = folio_mapping(folio);
 		if (folio_test_dirty(folio)) {
+			/*
+			 * Only kswapd can writeback filesystem folios
+			 * to avoid risk of stack overflow. But avoid
+			 * injecting inefficient single-folio I/O into
+			 * flusher writeback as much as possible: only
+			 * write folios when we've encountered many
+			 * dirty folios, and when we've already scanned
+			 * the rest of the LRU for clean folios and see
+			 * the same dirty folios again (with the reclaim
+			 * flag set).
+			 */
+			if (folio_is_file_lru(folio) &&
+				!folio_check_pageout(folio, pgdat))
+				goto activate_locked;
+
+			if (references == FOLIOREF_RECLAIM_CLEAN)
+				goto keep_locked;
+			if (!may_enter_fs(folio, sc->gfp_mask))
+				goto keep_locked;
+			if (!sc->may_writepage)
+				goto keep_locked;
+
 			/*
 			 * Folio is dirty. Flush the TLB if a writable entry
 			 * potentially exists to avoid CPU writes after I/O
-- 
2.39.0

