Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6A47CFB75
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346047AbjJSNmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjJSNmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:42:33 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2091.outbound.protection.outlook.com [40.107.117.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8EF124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq+O0aZ3bvv1b9R1LihihwBAtEmGba5r1vZjf5UXQZRXTZ/iVKZqLslW5jlGA+v0fTOabq2g6wix0B6wZILxFAgC2+c27K/qxpqmQ/FqtPkKBquac4Wt1mKjYXE6D9Ze0ci6Zudhdsh+0Josg32R/IF8YhQ1hmJj7rwVHaDZz5MYPEy201ntTAiCyNDMZ6xAL1rBo22BwJr8w28SuI7MepqH/Z8HzBW2Ga0DmH0bneGLPysop0w8tZWzuua1gGdz0EPYXaVAjHIIdqJ9hnS9iF7ByjbOFPtwiWnasbf95IVfRQLOZjsEFCqVH6SMU7I94BRRqyNcqUgMqOO89bfwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVCbfCgY6uphg+FnjetqR8dr7AX+sQTlt8WYhEGY+o4=;
 b=khvHRX4tsy7+nPHcSZgo4mBTzMVR729TH6c09YTh4oJGxDE5ucrkl+iBt0hGx/oHBaZSB69OopgMIVAtRVxF9Te80upYJUROMKSnapp/wjD/VUjGGLt78kcc/3Tb7rKPbJfC9/uKbPitz+7rKbKlSai+DF+ozp0dVQC3TummcAT2yvfWzJZZlhfe9EiXoaEqa8XQ62TvczK/fZ8JvZQahh94EyGofPqRFInjDBi1+o3k0Z2WOcBu09G3zpB3SVyq1MbZCpB7FOtB2cZBEKM0lWthMyXCs4bCkKOtsE46mXWoqETQnFIMEua4GpNvYkidC85M6JG83WtQ0GX+wkmyRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVCbfCgY6uphg+FnjetqR8dr7AX+sQTlt8WYhEGY+o4=;
 b=PIHxwSfaITQXMCdj5dnqk3utlwjDvfASQ7KXYXvwF2nHvXF9l0cM1ze3SvuOW2j/Yd3Erqb/3yj+bQ4i2MSjweLTdb6GPmWnLs3tTT7GNf91G8g8ufjbm38P1QJMIbvxmD87dMjiC217DsfHLTz125kvNmuygv+r975cqvFtaKwvNQ7x5kwBJgitP06FxmkT9BPmajYxkIp9RkeGWFRs1dm8HAOFXx8FcUyZcUzx4i6Q0j3ixa8G/zes5Lu56pdnl68+1BeClrqRTzS/j3qCMDUvZTFoSyCdQ6CAXTNDvStnp7PkHqV6WLunVXbqnnT0b8yFGQMyyPHI2IOQ2kNv4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR0601MB4100.apcprd06.prod.outlook.com (2603:1096:820:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 13:42:25 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5%7]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 13:42:25 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2 1/2] mm:vmscan: the dirty folio in folio list skip unmap
Date:   Thu, 19 Oct 2023 21:42:10 +0800
Message-ID: <20231019134211.329-2-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
In-Reply-To: <20231019134211.329-1-justinjiang@vivo.com>
References: <20231019134211.329-1-justinjiang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR0601MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b87a9b-9ba3-44b5-57f1-08dbd0a93a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbiBw1XMl0txTun8RDH29Wd/0b2lj8DjVhJqQxuPf1yLycFSEvwg2u6F9Vi+xPpmJtxBs9zwq0TszyXKYoJH0hW5dCZZa2AxQyLhUzkBgD0SrGMselkBPd39k5eJTCcjadFVDwfSZceS2QaRGcAsRcA/vIMDu2mrmEQhmTO4ELiP4oCu3RKUshRpSEp+PMw/AhKO7i/0lhMA9S1oOZlKsdccgWh/rJ96qo5zsjtjSdLT2HLGTtudP1rLjg2MvY7w4fZmO8/KBONXv+2WZr72BQZm3IXKpZV+0x9c/5+6EE/A0Ao6RYnHu8vvo19ErQ0ntU+x3KFVv6KdbKQDnH8/AeXFlW1cQpEti2CHV0VztTHgHQtpS5RprKPWGRLpuJzEecIRDnvda1bIJpGO8b01QJ8PGc5nOTIlL0Y5QpnJCTvPy0vvRl1XRu8jNWejPPOlnrU5k38LJ6BwBbmS4SUv/j3SMpW46ueQYZjqRtS+j24opY5sNWGy6/KWHjNbgrZTogo0o1Iz+S+U7Yc4inpAYCiz9jkj+aBpPBxS1apa50ilx0u2heNRfk9fr81g1Y9lKrdrlHXKWTDxCLGEwr97Lu68Zn1Fkdx1ss/Gpc8dpiNQtndLd0jLUKfBvNhDabEWbvbHhJDuGIVP9XTxn1PoRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(8676002)(52116002)(6666004)(2616005)(1076003)(6506007)(107886003)(26005)(66476007)(478600001)(316002)(66946007)(8936002)(4326008)(66556008)(6486002)(83380400001)(38100700002)(6512007)(2906002)(86362001)(41300700001)(5660300002)(38350700005)(36756003)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZNeDOHIYXvjbV1P4L4YJha/ivuTB9MAN7jGUCjS8onVTvnUXMBGMhrczIB5v?=
 =?us-ascii?Q?Opv7jQZROt9ouFAtk83QVBLozNmnlT3gCNyG+KVjwEj/WBIqDYtbL7TrSPHB?=
 =?us-ascii?Q?J2vh7yeSEd5NFX91EUhegTH8eBhMIJMS76RVYAz3GMpPNcBhGB8qVlcPcno7?=
 =?us-ascii?Q?MGHyyMKOsiavklKVZzg3hkr01mnxz7x6s2mBTl1iRCm4+B4FqrySAA0GvcT7?=
 =?us-ascii?Q?jXdrym9zWAWtiwHnCUMSolzZQ3UDYSRmproecBKMEIPoIx9taAJxX1d2g/dm?=
 =?us-ascii?Q?+ZplJIs7M0+5oS9qxw6nlUv4axIB5HqRYVV2GxgOMmhI7EcoTFsPpA7MZDCX?=
 =?us-ascii?Q?9yH9aHa12RR5uX0QKXsZcW+jVs8xoEV2uKChHxWsO4RkNkqPE+UEw3fqDPIL?=
 =?us-ascii?Q?z6UvblmTP694PvjfSSG7Rb1ZcLQmLw2EKklOU9jkkPDjHtpWSKqaUKgU9s9g?=
 =?us-ascii?Q?IIAzRUWU+oXGHZvhQ1/EjNPbCwtWk27ALedFlFg6q/dVqhJeyQQGPA67aR9M?=
 =?us-ascii?Q?alFzTRt9flbclf9elPIEtc9eQEp5BSJb+JhtvQDpC/10UQCiZNCcfCpH3oSK?=
 =?us-ascii?Q?k97dH/NhFV7OL57U01Gq8HT/4eXOMBCgtsP7XtQzTVuxiHrciB4txnYUPzqB?=
 =?us-ascii?Q?oJBI9aByq8N0rNvMQyoqoZjunH5F2T30B5sy1s4PNpbw84pVVBecan8NNOvc?=
 =?us-ascii?Q?MyOl5VlLKNbEcbICF8GchnweGOdQZyIIoVZsOWCMwwk7LY1WbdG4syJUvotJ?=
 =?us-ascii?Q?AmbCqF/GKAtie5+eXfeW0InFFhMba1rVAkPCoDCu4tyD52hprU7VKawet+4z?=
 =?us-ascii?Q?BnvJEtpTbb9kIgsJIdvkwoY0gNMryiMYSgWCoJp6D97WpB+QpYwqrgy82j05?=
 =?us-ascii?Q?sydD7bg7lrzDF7KrTZRsZplRrC9xrdSqaVu8U6p4d7F6cnL4JVaVkXxJKtIq?=
 =?us-ascii?Q?GAsmPIFAiXVpPzdO597KGbIyuSmcvc7KtaCZFzCoW7xoysZaUQBK1QrSENqj?=
 =?us-ascii?Q?Tk/xWtNXlRDTMPCDBJ3ULWiU3Z+oDZVhwL7M+e4Rn2sK/KBE9jKkEMAkv9YW?=
 =?us-ascii?Q?oNpdckDVnkxrM8t2r9bFg6u5Ni+JAUivvoQqOWX/3kg6NkZMomwG2wxEAg5h?=
 =?us-ascii?Q?glMGraL18JRfU77xuFbKgTQf8JM25umVZraHaYsmcrLbmmj9EKE4MzexgDt+?=
 =?us-ascii?Q?d7PFLiNcucvjxblNnQRpr+dGxfol8Sr27OQi8oYb9tkEwLmK87uu6gHFY3jR?=
 =?us-ascii?Q?xiCQXUtxbK50XqA/U3hfksfqBEY7vnWCC3oNsZ6mWdqlb6HLB4/Iumqxb5M4?=
 =?us-ascii?Q?wDD1TuLFgU+2e7tgOsK5Y9o7vzVAF+06ZB1fGEYsV+JKZ26qp6Qkz0mi5NB1?=
 =?us-ascii?Q?88w5NGM42stIa2PIl3ZqOHG8hnbEuBFrCaBn3Ti+WKbv1+tXSrq8H3fME++X?=
 =?us-ascii?Q?tQ+heJVDqy6aFbhZWdztloMHQUPcfgH1wsDOCImM9/TjFxzscySuXFemmmfa?=
 =?us-ascii?Q?sTZodOj4YEL0ZjvK4BgdUfzobk3byps8obu0ype6JKGYel2d+dVuELIaVU6/?=
 =?us-ascii?Q?ppQOcEzcFOjd+63O8i8iGzFVVjCxOC4sAG4bxRnr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b87a9b-9ba3-44b5-57f1-08dbd0a93a7b
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:42:25.3689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1u3HQh8zdjHXZUEe6mnxqCoZ/17xYNYbHRcWwyAhznrP5CHjd205wVQqrjabqZvamJSUP4maVXoqyMpypyfjhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

