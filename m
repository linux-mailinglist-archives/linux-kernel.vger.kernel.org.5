Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A38280E2C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345870AbjLLD1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjLLD06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:26:58 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F9C8F;
        Mon, 11 Dec 2023 19:27:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6RVKUPbsuPjpW3Yve+G4cxLgqCcRraIi2LMQ9tcneTmb+IAbTn6Vfek1aftmiYJG64Ui4qgLDSPl4VkuCnyrKs9AniZK9A6lJwjKyRMJ9hS/TElbYHIPW6v5i9SpNIng0FilXJaWlBYNSlEwPnbMZ+RMhp5TyXiCN8W7vGd84GyLtjYaHU2mWb7VRRGCfKZZZgqrnicnuv4/IHLw8Oas2XfotaxfqZ9D8j3zoMnb9FGmZvvLZ0qXnL6Z4mD3+8lujoYw9KeElBnBxLYzGN6ttDYknFFibTELk4TovNF47pIQAbsfw+dZUw1giYCqkYLFiuG54b88aulv1ggLnx3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7oIIAqbzcDOZgSBWU+sOxLWScBOIz8KQyrhRsF24hA=;
 b=PItkxf7EAKVb1XKG5PhU3N4h4WDA41tSA6eZAe3qiy4aGAhymLDlgT8hwUDB+6ror7qxS+sa5H11h/dZCsmPfe6WAF9FXOLXu0gbCCJp6EZyDkVfkfwWvQ7OU8auFUwmsGf+BcZT2SPpo7UpVfkh7kgVllFTPzgY87F/LxL2Ydo08GgTy18fqHnwxnkOdFEWPmmK/l7YdH7aJCxK58vfhpR7QWbZb91+fXAsOSdRDo3d0F6x55hhwXor6RNHmpWFmqEwq+Br9zomxaayGLg8UFG+LO5wVj1n8W7T7zNFE+jzgl5dqFDUM0/xmqOCAVEIncia/ZDQOJhtLgoNuwNk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7oIIAqbzcDOZgSBWU+sOxLWScBOIz8KQyrhRsF24hA=;
 b=MmoRfFBdL4JCkbsfa2iyasY1gKDIxTvG7oTh0YkDIbsSQnQsuk8ARATTZil3mDFXXhUm7F++NnMO6QBrx0L8uXc3021bWsTuKUslm+cWw+BmC2RqHxHfQ2iQ9dwfrOkFzaKUMVHaMMx3HkIzCFepzItEdqZtsIZMtVBxs+G3y+ciHmCQYQedCYXxFn05dKmNFTV3WWsTr27lByjjS5l+ZzWJqzeNGtUCJl/Q85+2sCJbD7IrlXRdFlwMeVi8I9sWQZ+/t+G7bsaOqYDmTRNkGy2IbnNzHNdYCKAAZmgtMLRj23qsS7I6s6BzCtJ0EwfE4vWjus8TSVp0E+0F3++70A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by TY0PR06MB6839.apcprd06.prod.outlook.com (2603:1096:405:10::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 03:27:02 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 03:27:02 +0000
From:   Bixuan Cui <cuibixuan@vivo.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, cuibixuan@vivo.com, opensource.kernel@vivo.com
Subject: [PATCH -next 1/2] mm: shrinker: add new event to trace shrink count
Date:   Mon, 11 Dec 2023 19:26:39 -0800
Message-Id: <20231212032640.6968-2-cuibixuan@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231212032640.6968-1-cuibixuan@vivo.com>
References: <20231212032640.6968-1-cuibixuan@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|TY0PR06MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 67714e02-9049-49e3-7021-08dbfac234ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OPrY0Ju4iZDA/QpvEYw4bOJHF2nupxUDom1gLrJ67jhrXGLfjFMMCtTISpp/TqmKLHIDH2iCOvm4Fh0pdW0MFIQNYuXSHNCtiwz1Tx0JfhhRVkc15itAofxxkRy0czi9nLIursovLKOIdNNX/xAfp54UtomW3cqAmrwvqRJ36CzsnfziLn4+Nu0o4eu4Ske8nA3dSHN6u4ehtLheKHae/uYjcX+uHfMo1Pj7Kea5h6n/yjImY/1pqU33/3G4yIfy3IDmdRI8V/PTQ34RWId4FvmBAQSIysW87EZE+FPr6vvb0nrkf7yCLEQZUQqepPxy3yAFUPFsuVIEHUQ53JqqPaWXya0PsWjwXPeOePebwxjntBE3kcjQWvauoDZ3i04MxPdsTo+/LaCtC2U5MKgIZ6A2tugwFFsScZ0ZdZeFX1UbdQcOdRZZFQjwYLfLweQfDVXUaqwParDFByBErA8aDwjwPb4XVlA1hMGC04l9W77aE3VmtjmWS9sIc4ohhvLCWmo1G4FE/WbpFGD8emLILmjLMG8UVvl4JSFOmDS6NLEjkq8S5TouoCzMencBwKUsAkuPSviL4Ml+0/yUQ+BCpagudlsmWnrhT0X974tfNfBidfv+8o9lBF5dSyPWZ3x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(26005)(1076003)(107886003)(40140700001)(316002)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(5660300002)(52116002)(6512007)(6506007)(6666004)(66556008)(66946007)(8936002)(8676002)(6486002)(66476007)(4326008)(2906002)(41300700001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KFt6CF92Hmsh74MOyXHdEFV85MyYSlnoCQ7QIoCdfDA8a9ZcmjfjV7694Ltu?=
 =?us-ascii?Q?15QGwWXi8yCnkouBg88mk5Cd+da3Jhs0cUqRwokT2F2FKGA1pxvRaUds+HvO?=
 =?us-ascii?Q?/y/zk+OvEyH/bUs1icyE9kLtgWwcjelR70QaUS0/y50nv/4PQYBX7S5EmPU2?=
 =?us-ascii?Q?WKb9NMIMRUnX8U4npf5FR15XowowwwC9f+tKafpjjGTu0oc+Dp5/CZN2HZcy?=
 =?us-ascii?Q?clo2w2qMYKl+fGaruwAHKqHRmBLluaMA+AVDEOK5dOnulXAWVgiI7N5d6uEQ?=
 =?us-ascii?Q?2DVhxYO3zy6wulGEgGIbtC2YFggZpmWaP7ZUAcePy2Q/EpFF8xKW9RX4axJ/?=
 =?us-ascii?Q?oh0NZhBQVYr9qhFfWkqVVwown3r3J+lXHXzwFQJm4iJHyDgLX/uw3S4vGpp/?=
 =?us-ascii?Q?tXMe6WQ3JQsDjcZnL3XvaKBR86B/uquc6qbcj+BmTUx7zHqK/D32V/b2naZs?=
 =?us-ascii?Q?v7o5GPzp+Cw4dLPsfaOjh9/lbKTbF96j5j91387xLjK/9LLPsWct1XyUMw7F?=
 =?us-ascii?Q?lR6g5wyL4A7YknJHxBWE+z2+mAvSPPuAQXxkzwOYC5dqy2EWvVnwDwmQk9wk?=
 =?us-ascii?Q?mbJmFGXXrld1PqYb+cHgiFfOTcy5g0gUAxobbzSjt8JoSWmVepIj6zx5zUJu?=
 =?us-ascii?Q?vd2YOTIdtvCyOiJ5IFpw6hu3j7s2d8UAcAbr3ZUfvKmfntWAwAszaNJr9Og3?=
 =?us-ascii?Q?ebYpgvHQH6PaMNKS1VAEqTJVaGRFW8JYDOM9/jXwh9ZLwkd5EZICQA8P/yeQ?=
 =?us-ascii?Q?HJ9gJOIk8NxvAAfex93uz/9Hmg4UoMJs+GrG7LJUI9fV1NUfOEna8q2rjZ8S?=
 =?us-ascii?Q?Tm20pecHv3HCHuspNwCfevmyXi+lLVLSySvYRNB9NAhr5+TH5q4Hm8hepqsw?=
 =?us-ascii?Q?FjB2T0uolHX2IEaXX1A+DMYQ/i0hvvRyHsaINRLftXsQ+OqfNNSf69lSJ5SL?=
 =?us-ascii?Q?ZOKeJ5N40ariXGoUNEgaX0ySd1kirXWI1bUyBfrEvH7wYSDTDNhpBOZjf+7X?=
 =?us-ascii?Q?bLz8K2G9vfotBlkhGsrUzDZURz9vQG+gXRUQvlV7Ez2Gp25aZ5z7fZn5kD7B?=
 =?us-ascii?Q?JHgFEBfKzg56eHKgJClgapm2eKRfDd8PDU59Wv3QoLMLibi0iH/e5Mm0OV4j?=
 =?us-ascii?Q?sYH5e7QckmjRrgu33z01h+J7inVCczlUwhwta70I2ldX1gpGPaXWjizgUmi0?=
 =?us-ascii?Q?++rENxuEGMBuUJNh0LhrYsz6Sp8XPJQ9Vl1NWjBVa7G0AkI/w//j8F01R6fE?=
 =?us-ascii?Q?vhPpGqBhXSVRgCS6u172N23aXajTfkdvvTeZZlMnbBkwrC8IXfsZJuBE9+JV?=
 =?us-ascii?Q?hu3TrO4zghytnEBWNVxxAeQBWMYOTIgYIYVlaxDJZDkOw3n4SnNjg8Q/5o+W?=
 =?us-ascii?Q?ryDqQOuaKlYBaTUn9zXgwC6ZvIYyUg9YmMG+yS7bvZdOTYiszEDgo0P1bR96?=
 =?us-ascii?Q?Ah+F7hGQU7xEpUoLV87pBwkN7Ar/DqzYp/T4c3htojp/d5Xm0xYCjkeCzq05?=
 =?us-ascii?Q?uQdgM/g/aVsr4hITjMVFXbx++tv9Gk++e0F9it2j58UEkoFyjKq5khCvez8J?=
 =?us-ascii?Q?lnzoUMQOd49a/cPDdFDK71fF75ZMmIakW1sc4b9N?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67714e02-9049-49e3-7021-08dbfac234ec
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 03:27:02.3035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8KcoMiux6zmidmHyrPsPNrFJxv6bsN7aaT06Yr9BlHXXYk5l6GIDVAptjfiubrwNfy3vqAYU9h5JGr9pLvLjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6839
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: cuibixuan <cuibixuan@vivo.com>

do_shrink_slab() calculates the freeable memory through shrinker->count_objects(),
and then reclaims the memory through shrinker->scan_objects(). When reclaiming
memory, shrinker->count_objects() takes a certain amount of time:

	Fun               spend(us)
	ext4_es_count     4302
	ext4_es_scan      12
	super_cache_count 4195
	super_cache_scan  2103

Therefore, adding the trace event to count_objects() can more accurately
obtain the time taken for slab memory recycling.

Example of output:
         kswapd0-103     [003] .....  1098.317942: mm_shrink_count_start: kfree_rcu_shrink_count.cfi_jt+0x0/0x8 00000000c540ff51: nid: 0
         kswapd0-103     [003] .....  1098.317951: mm_shrink_count_end: kfree_rcu_shrink_count.cfi_jt+0x0/0x8 00000000c540ff51: nid: 0 freeable:36

Signed-off-by: Bixuan Cui <cuibixuan@vivo.com>
---
 include/trace/events/vmscan.h | 49 +++++++++++++++++++++++++++++++++++
 mm/shrinker.c                 |  4 +++
 2 files changed, 53 insertions(+)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 1a488c30afa5..406faa5591c1 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -196,6 +196,55 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_memcg_softlimit_re
 );
 #endif /* CONFIG_MEMCG */
 
+TRACE_EVENT(mm_shrink_count_start,
+	TP_PROTO(struct shrinker *shr, struct shrink_control *sc),
+
+	TP_ARGS(shr, sc),
+
+	TP_STRUCT__entry(
+		__field(struct shrinker *, shr)
+		__field(void *, shrink)
+		__field(int, nid)
+	),
+
+	TP_fast_assign(
+		__entry->shr = shr;
+		__entry->shrink = shr->count_objects;
+		__entry->nid = sc->nid;
+	),
+
+	TP_printk("%pS %p: nid: %d",
+		__entry->shrink,
+		__entry->shr,
+		__entry->nid)
+);
+
+TRACE_EVENT(mm_shrink_count_end,
+	TP_PROTO(struct shrinker *shr, struct shrink_control *sc, long freeable),
+
+	TP_ARGS(shr, sc, freeable),
+
+	TP_STRUCT__entry(
+		__field(struct shrinker *, shr)
+		__field(void *, shrink)
+		__field(int, nid)
+		__field(long, freeable)
+	),
+
+	TP_fast_assign(
+		__entry->shr = shr;
+		__entry->shrink = shr->count_objects;
+		__entry->nid = sc->nid;
+		__entry->freeable = freeable;
+	),
+
+	TP_printk("%pS %p: nid: %d freeable:%ld",
+		__entry->shrink,
+		__entry->shr,
+		__entry->nid,
+		__entry->freeable)
+);
+
 TRACE_EVENT(mm_shrink_slab_start,
 	TP_PROTO(struct shrinker *shr, struct shrink_control *sc,
 		long nr_objects_to_shrink, unsigned long cache_items,
diff --git a/mm/shrinker.c b/mm/shrinker.c
index dd91eab43ed3..d0c7bf61db61 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -379,7 +379,11 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 					  : SHRINK_BATCH;
 	long scanned = 0, next_deferred;
 
+	trace_mm_shrink_count_start(shrinker, shrinkctl);
+
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
+
+	trace_mm_shrink_count_end(shrinker, shrinkctl, freeable);
 	if (freeable == 0 || freeable == SHRINK_EMPTY)
 		return freeable;
 
-- 
2.39.0

