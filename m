Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5D07CD1D0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbjJRBaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJRBaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:30:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FF7B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/AVY3ucn7LHJg02fMB2JBV6F1BM7xorhrTqsgfS/jH5wVSpVmBB4B6NFXwqKROWgqjLvBVKBfmThK4IauVI+Wtv2aOP+X2iVo882B2wPtz5aFzSagZCk89bW+NEWmZb6hCS+1uz+jlvAXqtVjqXxnLAWSELPSgJyESFVyB68U2c4pn5wBgCXod9/UR3q+xcYsESVh6O/F08oPy/YlcQe/qtz2FoUx0ses6Kd2NPE9rnbCrlHKffJOyqtDPoK0TabIzokNaVQMPhieQQ9q1gn3CBYFBFoGH6x18ZajM1oVEX1nbl/x58R/KzE0iRTvlfv6FKCMPQc4Ahuip/MYAX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yVZ0BIDjoJrLxb95hWZe1lpouF8PNNMU62WbPJonyg=;
 b=ZpxDktEowjVMrTShiwx+rtbmJRse2EjbyZmY+Q1EkdA04+FscBe01BGY/f06FwH7JhISlN596mxMH5lBDMhUy2Ede0yRRxNeRJNOBBxdi6DwkZsQJjzIV0HYwwpJAhBY2JTbb49KTPeknZxugkBqDX89e7Ksc76Vy//VqDgUjD8K6m9hNlVtQLaeV188OG5sDTJKQdTl8dZkNEnUzEeoCYAiA9bFWT60BcASskBB5XSfKMwnd+hF89eLAXfG/L+py9kav1XI8+mUpIi+KGI0Cin+ffbirx18WGR3mkOXuv/aAkhFhDTE+7O6zX8puM/yLQK1D44dofmrSkaknW0idw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yVZ0BIDjoJrLxb95hWZe1lpouF8PNNMU62WbPJonyg=;
 b=gRDbmzN7BSB4TOZK6dLdUnsBpccbHQ99CgPDmxvy1rwO2bYimNm/TXAWOmmQ+cjqazpqGmDcS023xL+CIfgeusm/Gc7/8UYw379sxQ6+0UeNDEyfnhub7lcMWg74T0lMO5eX0BpgFHmfv8ADGkV+JlxI9vd9wyUQsOQMQEEwMr5RhZ7XGa76XaAyEjyFFRXaeNbBqep4+n4KFsQA5Q9UVyIGX3TuiV7N87iR2S9dPozCw4OtAkToNjLXelFycSY/ecPvq/mp+bVuyc8OAjgvC/giE5sklLQ2sniaQtyzRySry2VTCJj0v5cvB7CKba0y0RJKZof0tbNI2ycO4mbUVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB6432.apcprd06.prod.outlook.com (2603:1096:101:16f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.38; Wed, 18 Oct
 2023 01:30:12 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5%7]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 01:30:12 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: vmscan: the dirty folio unmap redundantly
Date:   Wed, 18 Oct 2023 09:30:03 +0800
Message-ID: <20231018013004.1569-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: bd620673-d41f-4f36-320e-08dbcf79c61e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: db8U2WixJyn6lqh9hDCe9EGJZaGClXa4km0PLWtJJmPzpAT7mpJFFwLWiUOynEHyZK34Zfp2kQgqkgphy9fFaGEP9fsze4OYrYM2J35GNj8UYL9p9UV3CmgZ2ol02Xic5EMGhwsr7i1y9sXUdwFlN1iteD1Tjld6C2Y5+JFm32R1KspD8gPcqDJn7mnJ89kyOflaI2ZcVFhIMLKERvRc7eFcDGG2ie4y8dvZX5w+t15s7xg8zY/BPbZffnzi7QxkuedgyGQq392HQbwKNe27WFLWV2nlNolLxPl1RpbO5eQs7HcCZcMI/2xJ9ft1glQ6/b7/PZdtbL0/neMTXXm+TKv5qGNJWXW3qXw1ay4dtYhtC6XIR3C+aH5kjUDyZinaa9h1Uo3x8iAwwTWzmQ4wh4eP/c1nrSWRpstfhkarLmgqEOH1z+B4SflOOYiFM3/C55kXwACv53lLdhTBlrDuDPzCFl+fCl2e7RBOxtQmDkiUqvn2uY3JkLzzOpBBd+RqRSL+8C4981nx0FsZrtDdzTRlwnzaulHZ70r9g6FUPu1mZvnDFY6J1VGIcEbWr0ZMLFI0cAoq53iYxXdQ9C8hHpYTlTqa05tn4RTM4bqsn7+F5xPUpp5p5qGB1R6WXyMcYV/6QP1bC2Cf3TqwJ1RtXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(8676002)(8936002)(4326008)(38100700002)(41300700001)(5660300002)(86362001)(2906002)(6506007)(52116002)(6512007)(508600001)(6486002)(6666004)(107886003)(38350700005)(36756003)(26005)(83380400001)(1076003)(2616005)(66556008)(66476007)(66946007)(316002)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dFHgPDpX6vssO4HtSsovOZaI50969kNzy4gRMsF4/9g1HGIgnLYYopLbLxha?=
 =?us-ascii?Q?ec8MMAdfsKb0A/G7TFrkfP/vkJP+YZ9Zo1jB5/jTMRQRnA93pCM7/SW2nn6G?=
 =?us-ascii?Q?i3jaq0/fzypqgXpTC6bI5AwDjeXWNtpQcZeI17rWY/ZTVS3I/+WvOA9IMvxw?=
 =?us-ascii?Q?Gs12zR7153a8sBGJsdnBX4uPTAUd6nMXbWjVvC+KzQhloZkSwOPIgfWrrtZ3?=
 =?us-ascii?Q?16GfepFgQogfLIKQH/qpuQ2d5Pg4wXB/jrDDOWVT33SQon48FzXaGy/sLGXy?=
 =?us-ascii?Q?tKDvVgn9weizXh269K51Vae+YpY6USangrp0X6GNWC8A/YDD2yiR4Jdcz+ZT?=
 =?us-ascii?Q?Z2pT0691LAMXejVL32Duq1kxnhJEZL4ZTyvaKwFX7iV0zNfHDm/4GfgNmAPt?=
 =?us-ascii?Q?5CQAGih5zmwgTiNCec1lGeKRhLUSdnoiuHb3TOSooSVHIyyI/aijmPbqw+O9?=
 =?us-ascii?Q?MGC7UQq9GcSlBg1F/3yyUgBzHbrNKjReijwSZKn0xUHwzhdDm1FDqOku4Z8r?=
 =?us-ascii?Q?RZRq6X01ByzR5/3rErnsuiCLj3fozPrHhUd9iiuAoiPP+ayrYPrJzvYNoxL4?=
 =?us-ascii?Q?H6ctq72zdAd/0klhY6I7IKUamkJZ6+LBd18jYULxIIBcmq7D21NEO2GNRbCK?=
 =?us-ascii?Q?Z+/mhftf/m5tOTqXyDZNkNAxAy6mUxzcgePDOENKqaM3u6zrYPSdQIdY4D95?=
 =?us-ascii?Q?BgjVE7gLI1i1JiOjC0z3SZ4MIg6eKqTYjM9FKi7M2qN19V+HkK6nNkSWQDzi?=
 =?us-ascii?Q?4AaIzekf/Y792PiM+DqHtcHxUof+V6tYYMko1UBTxsr4dhuzSNlLCzD/ggr5?=
 =?us-ascii?Q?aKFO47KdsMHSb60a2xET1H988tzIsvLDJ/NEBYZ8KZnndI0V0ufUP7tYiqSo?=
 =?us-ascii?Q?/lRYEfIMozUDCZK3TdVbdh4NyOFtL2fAczzYHYccvdyyKrDsZR76e2ZS3BhL?=
 =?us-ascii?Q?c5/1+q0u1lHODrI8LO65K3l/OktqP9rly1e78Rzxpf4VPuSOPsR+iMNYH0O5?=
 =?us-ascii?Q?6lzNSFlpQoNbgs99P7vzwdN3wHyx+FSp8l4xbrAoVeR1EP8ehFjdAprWbu70?=
 =?us-ascii?Q?thxAS9WaCu9Yat1L0fxE72PTlmpR627va3l86P4pYIPDN2llfbD3EIHZ1uQY?=
 =?us-ascii?Q?Uh3ViZRRrwk25Tp0T6WyMuZZ06MnQw+pwVM6/qFFXJ9ZrR60mlDn4PtGAtVM?=
 =?us-ascii?Q?Pb1FmtpdOHQKARMjwcLG71DruUf/3AmopScHI62rl0vPZirglvSz0Maya9zz?=
 =?us-ascii?Q?1o4cv2Lqi+0Pz0rtKDU+p0BTtdVa5cFLe0N+RHnQkjMoGHQuCKLif5bOQVoG?=
 =?us-ascii?Q?xddcEgL/eRPj1sXGOVpgzle2AXVeszXAraDzEeLOl7UffaLhuuU72Jal62UK?=
 =?us-ascii?Q?YfP7BBpsDDigVfYyznXX0bFEj6QXbOPI6gfveMnjwuKIo1gkw1smqPcRFCLi?=
 =?us-ascii?Q?9WVqwkdpInmno49YTGlfnt/xjYO/DyR6sBumVsgygo5wnZe9aJbZ8EKjOQsw?=
 =?us-ascii?Q?PpeOlJzFpAsFwWPLRvz1xW43xHPSMEovowjVBsXHXuhTrEULgRqzp5kY7xeF?=
 =?us-ascii?Q?O1KFK1JLvEAF45ygjFeKpiIkANeyMPllCK7oOa9i?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd620673-d41f-4f36-320e-08dbcf79c61e
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 01:30:12.6182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2TbUyZh0O4ScRGAGIGHnsOCWRM6HASvPqgYkARtOY/+CK6XuP+2vcMS6IsOfZWnohM3l3abXrcJBSX02+2b6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6432
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the dirty folio is not reclaimed in the shrink process, it do
not need to unmap, which can save shrinking time during traversaling
the dirty folio.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/vmscan.c | 72 +++++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 35 deletions(-)
 mode change 100644 => 100755 mm/vmscan.c

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2cc0cb41fb32..cf555cdfcefc
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1261,6 +1261,43 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			enum ttu_flags flags = TTU_BATCH_FLUSH;
 			bool was_swapbacked = folio_test_swapbacked(folio);
 
+			if (folio_test_dirty(folio)) {
+				/*
+				 * Only kswapd can writeback filesystem folios
+				 * to avoid risk of stack overflow. But avoid
+				 * injecting inefficient single-folio I/O into
+				 * flusher writeback as much as possible: only
+				 * write folios when we've encountered many
+				 * dirty folios, and when we've already scanned
+				 * the rest of the LRU for clean folios and see
+				 * the same dirty folios again (with the reclaim
+				 * flag set).
+				 */
+				if (folio_is_file_lru(folio) &&
+					(!current_is_kswapd() ||
+					 !folio_test_reclaim(folio) ||
+					 !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
+					/*
+					 * Immediately reclaim when written back.
+					 * Similar in principle to folio_deactivate()
+					 * except we already have the folio isolated
+					 * and know it's dirty
+					 */
+					node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
+							nr_pages);
+					folio_set_reclaim(folio);
+
+					goto activate_locked;
+				}
+
+				if (references == FOLIOREF_RECLAIM_CLEAN)
+					goto keep_locked;
+				if (!may_enter_fs(folio, sc->gfp_mask))
+					goto keep_locked;
+				if (!sc->may_writepage)
+					goto keep_locked;
+			}
+
 			if (folio_test_pmd_mappable(folio))
 				flags |= TTU_SPLIT_HUGE_PMD;
 
@@ -1286,41 +1323,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 		mapping = folio_mapping(folio);
 		if (folio_test_dirty(folio)) {
-			/*
-			 * Only kswapd can writeback filesystem folios
-			 * to avoid risk of stack overflow. But avoid
-			 * injecting inefficient single-folio I/O into
-			 * flusher writeback as much as possible: only
-			 * write folios when we've encountered many
-			 * dirty folios, and when we've already scanned
-			 * the rest of the LRU for clean folios and see
-			 * the same dirty folios again (with the reclaim
-			 * flag set).
-			 */
-			if (folio_is_file_lru(folio) &&
-			    (!current_is_kswapd() ||
-			     !folio_test_reclaim(folio) ||
-			     !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
-				/*
-				 * Immediately reclaim when written back.
-				 * Similar in principle to folio_deactivate()
-				 * except we already have the folio isolated
-				 * and know it's dirty
-				 */
-				node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
-						nr_pages);
-				folio_set_reclaim(folio);
-
-				goto activate_locked;
-			}
-
-			if (references == FOLIOREF_RECLAIM_CLEAN)
-				goto keep_locked;
-			if (!may_enter_fs(folio, sc->gfp_mask))
-				goto keep_locked;
-			if (!sc->may_writepage)
-				goto keep_locked;
-
 			/*
 			 * Folio is dirty. Flush the TLB if a writable entry
 			 * potentially exists to avoid CPU writes after I/O
-- 
2.39.0

