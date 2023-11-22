Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3F27F4FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjKVSrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKVSrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:47:32 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2075.outbound.protection.outlook.com [40.92.91.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641E7101
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 10:47:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO6s2M75oijk/6jx5ac/dtlHQVOZFkyzvUMxVPG3LJ0M2Cw06/MuYc4rSHAmEGqTD3JGTGyh85VqUlZH1Eow016cxu0LUTZxuZCadEbtCZeQcqzElwnhB/dyCdWmQMVwjcx68jMpQPhyj4z3jdH5lV1/h/srPaIeQVv+MRuUjOKJdhuMhhYMGmWvslCt7NDPqLiDKWOvWQuaNEq9yyI0ALAMnNdqocJcqJCi70xrBfVNgqSrmg5ahhp83zYXn2cU19sLYjZRUum8aqu1tjvHCNC8Lr8rjJahlUuHnGtTks75+DCltEGh+9A2Q1Ht9s07HnLao2oyIx9geu+bxEwZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAdaREqpc9sX3X6h2LLoWCzx5FXjxLWvu7E/lWR5lEU=;
 b=IhDR4kZ2gqcuGKjsQ39wPU6gYTXND6EUfl+VAF8n5W6KvFSrb+V8xCgzww/80eWEim8W9TDmSmv10fNg+7vvg12C1EuZXA0ACirag601kEYLpfAjLv0DSEsaVDC5y2c8efAhhEH/h6ywIpTE60NmLPBJRdgSnbgFUpCvaY/QKbztsBeJTc4iB2xau7Up7uMZ/TW/B+FUPVmVQb8wRx3FIrDhZ7s42ycnvV71crd1oUSyB0XrLxS74delr8okVfsveCNYEXIOiPUfXaOPou/LLBRY8/nQmLzNcS4Z+8mQGC/qe73ZOL17OjgyYHWjegWypFM2snisJWbt1natxZreZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAdaREqpc9sX3X6h2LLoWCzx5FXjxLWvu7E/lWR5lEU=;
 b=D9eNX2KA2+E90oU7Zy0iMUwchXdD1bIQpAZfvW0rsKBeLeeHK7lzp0T1icuKjtHa+o3vkLt8EwZIpb+jolZ47B/lvoEgs/qJ4Rgu1s+e3BKgWi5nDh8YnEx2uO1G5tTcKTDIuO94VrMVoNBS/tcVJfOLnTvTQ+Df0EN01LHrDWplTvt5ePd0c5QLKyMrfp7lk9aHWeF6ea+QEbHA/Gp0Nd6TCc+LuKL77dOV/7/ziVxYlzrDGissajfJHnISjaCtRn+Z+LAZ5P4SfG15MkWgpGvyBP+kkStuK/Qe34yOEgBi74uOfOMXBgw2X/YjWufgzRLuUNSCZA2t6ovUMuIq0g==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by PAXP193MB1215.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Wed, 22 Nov
 2023 18:47:25 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%5]) with mapi id 15.20.7025.020; Wed, 22 Nov 2023
 18:47:25 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] kasan: Improve free meta storage in Generic KASAN
Date:   Wed, 22 Nov 2023 18:46:31 +0000
Message-ID: <VI1P193MB0752675D6E0A2D16CE656F8299BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [8w/MP3zGraWS4uWjx/FVeWYwAJLviw+P]
X-ClientProxiedBy: LO4P123CA0670.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::16) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20231122184631.32266-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|PAXP193MB1215:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5204d0-7ac3-4dc4-126e-08dbeb8b77e5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhFwHOj97K3IaSouKOz2ZtU+bW284QYopMpEajKo9iqFb8wTBwfOL87yi3PqxkkPGSJAq1AiRorWmvjTNblB577xrfAtJhTprHIPOWHcUAuwIPaVQOPJZDyHdkF5WWzIiqJSe1XBx5dswX9yK9LM6hSIkPGlWYAFu63R1eXIsid1wY2g35wnC554gYlRUyN93mOy+l2OPvJxBPnuCzHwMr18etiyWNrCbYZgOg7rjEfQZxBwRSSsLK++26Jdd4IuweZgP1SKrl91ykfl4LRMRnv/sg8Bk0DNiBTQrYGWouG8GHnXLXLzuRUUDJwsBRiq8PJef9m0sCixlGTgzCzPRLlHNT287MrR7nA7kJIaZjNbj7X+RjHtNEn10nVdanb93MgpGZutPV63dX+9l/+nGXhW+4OSfqXWgI3ZU5EQysQrFfAz6b0fF4ulS/jfyquuLm3vuYvK6v4CXrlQ04FZ75Lts8DoZavZ4sZhCFGC9pko3upacnB6uw9yUACm/6gl1Q4YijPyejsR1g1D3ki/dNViOG/crz3msdWT4XQ806viDcqfGC01sDiSZMAaNxcd
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NykJukja7eguyySaGEKB75IHOb29H2Xo67LGOQGcfROv03MsIXaQi06/j7BX?=
 =?us-ascii?Q?JHxfccaF2Qy7tUNbZ/iujsiadwbcnepdGkulfvYcU5VbK3M28QL+wckQQWTi?=
 =?us-ascii?Q?D8z/m7pLhhbZ0PkOYVMKeuNgPujR68cCbVCBhJGzG81aIidGjnmnH2vnH+7G?=
 =?us-ascii?Q?fZ3d1bOl+gf5zrZ+oA/f2HwvHEuggq1qXREV/krvxZh1BuL4GaVkGOBKJ2lw?=
 =?us-ascii?Q?SOlHZ1nfBXSdCPp2H9EGjbPhbB6zNdMH9EjyRDpt0j4I/PkiHsBGiotRdE4v?=
 =?us-ascii?Q?NHqsCM4VeajXTfWgv5FnG8tkNZ5E4+GIPSts+VwcnSZ3caU9FmUo7CvSnZns?=
 =?us-ascii?Q?3NyybYNijhnlCtKPzSLFiZR686XcTvIIXWVGFs/i0bVGw8zyvYa1fnTRNIZs?=
 =?us-ascii?Q?beFnTOpNQos4wcdaMN4Ien/3Y1jfUpfYqFjhND58r0pfIjOUYjMT0sd89yEo?=
 =?us-ascii?Q?Y2PJGXC61iVbEcuVwKF/Y7tJA0uPjV0T9iqNcVKXcpOx9SLBdxKclrFT7LCB?=
 =?us-ascii?Q?+o2gBO1xHu4tomRcMgGJ4xhMkb+NtsGvBqOA4eeursAmS6t3OpA7GgBKTs43?=
 =?us-ascii?Q?SIPSQcPdKQ8Wom9jPxi7vZIDZc+gT6u/x4Kp0JSfcrQOkDI0lBqIeuHBosrn?=
 =?us-ascii?Q?unP2z6MYwqRnX91P3BhAV8EQkHVfOVvv13OMYEvXEjXUnzXGkrx06Cz7PDPf?=
 =?us-ascii?Q?M0no9FEbqbMEhmlaf9kaj6eQH/7vdWEuW1wZr7RATE/bqmQjtExXlxCjY+FV?=
 =?us-ascii?Q?V2Ewws6MU2EAtuFv6B8y2RhgFSaZQwnkOSQObk1xau+ucPtEvgYcMjnsJ/Sn?=
 =?us-ascii?Q?t5bh1XYZFLtS+njieX6Zc1B+JcbnmNMnkbGuo3RD/eK9slOt2YC6l9FKGX+l?=
 =?us-ascii?Q?W8GLQ0xmVZycCXXnwhTOYTxJeZfiIKdVUbXIFj8+B1C6urrZxtxWWjwG0ENk?=
 =?us-ascii?Q?PfRXbSqNpNRXeje+tCGkak9sYaUk+QYfRT/Ybo4FQokzD/Mc8WN+nbU37f1b?=
 =?us-ascii?Q?i6BnybE1bGKjE6gi3qxuhybSHWMgdIYOBu1jUIar8FJ79KAFK/3gD8lNG2P4?=
 =?us-ascii?Q?LjbaSOZbv4YtYcLK8bG4gwl8psg2JR3bu0vosRppFMqrZmqqGO96onQ3m/re?=
 =?us-ascii?Q?fzZ4isoJOhK1IgIdzeBq6JxKFjYaU5iPjKt5jLgNi/y1/PZ6u2NzYhoO+GE+?=
 =?us-ascii?Q?dTpn0pCGWey8LamIbCs8N0cZFoLY5h0osxFcvBTNWTJSTuVtRhdzVm1JBgU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5204d0-7ac3-4dc4-126e-08dbeb8b77e5
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 18:47:25.1541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently free meta can only be stored in object if the object is
not smaller than free meta.

After the improvement, when the object is smaller than free meta and
SLUB DEBUG is not enabled, it is possible to store part of the free
meta in the object, reducing the increased size of the red zone.

Example:

free meta size: 16 bytes
alloc meta size: 16 bytes
object size: 8 bytes
optimal redzone size (object_size <= 64): 16 bytes

Before improvement:
actual redzone size = alloc meta size + free meta size = 32 bytes

After improvement:
actual redzone size = alloc meta size + (free meta size - object size)
                    = 24 bytes

Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
V2 -> V3: When SLUB DEBUG is enabled, the previous free meta
storage method continues to be used. Cancel the change to
kasan_metadata_size().

V1 -> V2: Make kasan_metadata_size() adapt to the improved
free meta storage

 mm/kasan/generic.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 4d837ab83f08..97713251053c 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -361,6 +361,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 {
 	unsigned int ok_size;
 	unsigned int optimal_size;
+	unsigned int rem_free_meta_size;
+	unsigned int orig_alloc_meta_offset;
 
 	if (!kasan_requires_meta())
 		return;
@@ -394,6 +396,9 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 		/* Continue, since free meta might still fit. */
 	}
 
+	ok_size = *size;
+	orig_alloc_meta_offset = cache->kasan_info.alloc_meta_offset;
+
 	/*
 	 * Add free meta into redzone when it's not possible to store
 	 * it in the object. This is the case when:
@@ -401,23 +406,37 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	 *    be touched after it was freed, or
 	 * 2. Object has a constructor, which means it's expected to
 	 *    retain its content until the next allocation, or
-	 * 3. Object is too small.
+	 * 3. Object is too small and SLUB DEBUG is enabled. Avoid
+	 *    free meta that exceeds the object size corrupts the
+	 *    SLUB DEBUG metadata.
 	 * Otherwise cache->kasan_info.free_meta_offset = 0 is implied.
+	 * If the object is smaller than the free meta and SLUB DEBUG
+	 * is not enabled, it is still possible to store part of the
+	 * free meta in the object.
 	 */
-	if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor ||
-	    cache->object_size < sizeof(struct kasan_free_meta)) {
-		ok_size = *size;
-
+	if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor) {
 		cache->kasan_info.free_meta_offset = *size;
 		*size += sizeof(struct kasan_free_meta);
-
-		/* If free meta doesn't fit, don't add it. */
-		if (*size > KMALLOC_MAX_SIZE) {
-			cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
-			*size = ok_size;
+	} else if (cache->object_size < sizeof(struct kasan_free_meta)) {
+		if (__slub_debug_enabled()) {
+			cache->kasan_info.free_meta_offset = *size;
+			*size += sizeof(struct kasan_free_meta);
+		} else {
+			rem_free_meta_size = sizeof(struct kasan_free_meta) -
+									cache->object_size;
+			*size += rem_free_meta_size;
+			if (cache->kasan_info.alloc_meta_offset != 0)
+				cache->kasan_info.alloc_meta_offset += rem_free_meta_size;
 		}
 	}
 
+	/* If free meta doesn't fit, don't add it. */
+	if (*size > KMALLOC_MAX_SIZE) {
+		cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
+		cache->kasan_info.alloc_meta_offset = orig_alloc_meta_offset;
+		*size = ok_size;
+	}
+
 	/* Calculate size with optimal redzone. */
 	optimal_size = cache->object_size + optimal_redzone(cache->object_size);
 	/* Limit it with KMALLOC_MAX_SIZE (relevant for SLAB only). */
-- 
2.39.2

