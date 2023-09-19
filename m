Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42A17A5ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjISJyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjISJxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:53:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E9E119
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQEUYX8FCPAcDOj8gwHrqV3oXwWG0OT0Y7a/g3SIjeWdGRcIYRDCo4SCm9Wdi1pFq19t1ui43SDzeyFXe6pJiWCHdJ7bSeYiUfL/HDz3bxeSLVFzmgOeSEvKUr8zX/zi00riUDRXqDi2UGkuinaa5ZdfMoFhBElxwg/+ni4BENe5iOlktvCB9OkYCGnYbpyHojQXqQlyPWP69Uay0pieo7maM5ECqsRvRA9qCnO8w4FXHMC2292SGt1DCRB1d8UKs7tug6CsKF+QIB4zrYeG0G6CCo5n4JxlT9ozjgxDIqus507dSeSvLxqRFo3INkPys1JRDSxJ3Db7vs+2RCB21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jx9WTUZiqUt0CjqcK2hwmvIj8D257d25wRI58f+0wyk=;
 b=E92YNQ80+yU6qQQas2UZBHE7Y4hKxs2N78+c4PJ4+MIhEHJAYQnQEEX5itNzLvjaMf/Ip6HBEPg4zOmh7qF0qYHpSE0bnzkd3w9Yvua8aQsCKrZzeGfAf+Cl3VGETqFdOPwoXaTlZZyxBA99wP3pe+xv8MFXP4kpfPhi+bMKULwT2wihsVmUpYcpNS++TFB5BIFDj3JBeG/AcUFfLUF+bq30CIYXjYUnefzoB7u8gnUQpM6wi2mmdlrhugsEH+hN/ns6iQ391PPa/4RikO3LOkyspyPR24mEFJUspiPmlN/iD1iZDUuqX3UwdSdHz+9dO4fOyLS7S5FoyH907Nqe2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jx9WTUZiqUt0CjqcK2hwmvIj8D257d25wRI58f+0wyk=;
 b=BPd8bXtYUGjCErvn8rK5GYcPaG2gEea9oT8OvK+U96aaMxDfUFS6gXDk9doQ1kqPpdcfRI5ToHaULhTubskBn0CJgzmDBYlPRTLBvePiYybxmharBc3hkjbKlYSgeCUhH8rRkttBOwc1nMXtG5kql/aCWiL5x2+4X0oulltVTH75NWYncjIZPO3yy25C/NzzPu5c42xSbrlKgeuZBGNZyR7BQjnaSUU5AnFIjqfMm4i8O7pMQy9gwpwP64ZNdPCLUl66WC39IGDJUgeE+TXq9uYAD7QnM9SAN/S3UP6R9DGJrCyL2/fWTTEGuoUvE37HWMpja9h47yRFhEwoAnqEXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB6982.apcprd06.prod.outlook.com (2603:1096:101:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 09:53:13 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02%4]) with mapi id 15.20.6792.020; Tue, 19 Sep 2023
 09:53:13 +0000
From:   Huan Yang <link@vivo.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org (open list),
        damon@lists.linux.dev (open list:DATA ACCESS MONITOR),
        linux-mm@kvack.org (open list:DATA ACCESS MONITOR)
Cc:     opensource.kernel@vivo.com, Huan Yang <link@vivo.com>
Subject: [RFC 2/2] mm/damos/filter: Damos filter cleanup
Date:   Tue, 19 Sep 2023 17:52:35 +0800
Message-Id: <20230919095237.26613-3-link@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919095237.26613-1-link@vivo.com>
References: <20230919095237.26613-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::10) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 50394122-3ebc-42e5-19c8-08dbb8f63d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+zMk75QJ65qWbeuWtr+CB91Ku3BiJ1kC//DbvThBiJNN3m332BiNnYmIAl/uOr8VmrCo4e4ECgpr4qCLBrgldoan+sbnbGgWtcgszFwQ/cZqoCTLhaW+s+8734a2c85PhkQ8Zs/3Y5RQjftp7mbtsxcPRVg/jgdQ2yul0POY8mWSOTHeUU6Q7Rn3EiDuKgjcdHbwQQLFBxFddABkCy0+cUFOJ82I0J4wEHoaDCTT0aHSrtn5OCvMl2sTiGKp6OH1iWErdax9pJVXeYvDsjjD2HTEu/zNSaV2SfOxz2Lxb515hlVYbQRXpqY5WXX7IHy+YevJ9yxxOjMOvYwFQ22qWU+A+WOdEF1eCGQfcubiWAo2Vi8IE1yS/o7JL8Sjzzry9fY/yrAU4Y8t5X1csm17KgsPrR+iNW0RztJkla5wuSsjctjfyu+Wriun8cToZr+oE8cxngPirwbyKWZquplC4Y9iE35J9NmUTN0+WbCcZjyCY+3/7oUR/8ENsCZlRdAaC5fsh8QF9oR5kxzSR/prKrfdtfT7TGJ+GlSI1ABjzRtfaGTTGvl+JY0xQJoXnnkjkF2a55xZEucb6YdEYl6CAzr9l954B1ODyz9MYua4Uik2xEVQZu94bq3UNYAwQeG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(4326008)(5660300002)(6506007)(6486002)(52116002)(8676002)(8936002)(316002)(41300700001)(66946007)(66556008)(478600001)(66476007)(6666004)(30864003)(2906002)(110136005)(6512007)(83380400001)(1076003)(26005)(107886003)(2616005)(38100700002)(36756003)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f0V7b6sCfwJzCwQ6bVLam0tWonhbNq/U7CAp4I30B0XX42lisjyAX2s5cOWO?=
 =?us-ascii?Q?ZsADDL0zBLfySnX6mZxcZtRTI3M9dLkTzhX8Lu2xxL+7r/StepkkD9dDt3x8?=
 =?us-ascii?Q?lq5qtL1adQuzKRWPiS3tcVcEJLIy2gRxH/AKeTDa6YZTJ/4h7NN/sMPoZQtd?=
 =?us-ascii?Q?fiTQbJrOEryzgkrDC7k2ifeIvBwHz797Kl8AXRMIsdEtoCUsWhU3eQUYLhWq?=
 =?us-ascii?Q?fkx+l4rRw2GTSSqxS1XSibYguRNWgEwK95VDwkXDoV2KZ3/3vKwEBIq/juIG?=
 =?us-ascii?Q?4VibVyJD/9NSA+RTuGUaRGFRmhJLTxcYkH09Us57O3PIM6d6p2sBmS6g08Ix?=
 =?us-ascii?Q?JRyPshGmFgF/VpRr7ZuMkcZNCFkfZm/sAcBT9z/KjPWHj31XnRyqRITBhEHv?=
 =?us-ascii?Q?D/zgbBkqoHt0vibZgbwwFkbv9BevAqPWnuizKNpNzdJUray3gFAhd3eUXosD?=
 =?us-ascii?Q?DIDSq+9J7m9KbFQlgnfiQWKwbsTK+pRKkvBuWf/mmDVv2IvDW6zyduT5DLbJ?=
 =?us-ascii?Q?m0Ijfj/YwrBgcwlhf0VdpJnIkx52Zy5u+Cc4sziawl2h4zbytDbXJjQSNmUo?=
 =?us-ascii?Q?6eHnAcxxsmT9WdNON9pFgG3PBRinEIWMItE5OQi1zcOTJnes7BOxkSEfEDHQ?=
 =?us-ascii?Q?YWrmtpWJIPjhLQ9GRrL8146C+farGhzJRw2eCNT7jmJTNrj8214/dTMGiIKZ?=
 =?us-ascii?Q?kq9BGkJnd/nXKU5a++PDmANyLEDKoAkHjY9BAFMlVzJ/UfWJ5yas9ScOSI1A?=
 =?us-ascii?Q?zZg0Oio1rnbX8xHMvv2XnsUs3uhE89UtSgTNWOQ/GorUCDtOVWQ3oYyhzPSA?=
 =?us-ascii?Q?xzKAYBHCHg5WEBaekPO4bLtYZ9UL2saCgYnQfKVy64o2+T9VJ5toDcsFXuDr?=
 =?us-ascii?Q?wCqhd1YnFFveu3SSqdQwocJeXK5Crkof9B+1SZziffghVIZRH+ziXSOYc/x7?=
 =?us-ascii?Q?1x/7G2byw2tGKmZWkQw6n4i3D+7QwyLmc58tAKSwwfkCEQD3KYTYBI14l4ad?=
 =?us-ascii?Q?pHsbDQD5hQSUH3tO+GjhqOTXzO3ZmQMy7IbxXBAhkyIk5ymEM6UBGd5UkDCw?=
 =?us-ascii?Q?VuwYmPazIjZmlDfXDmoE3YgnHXINBVyurG+WsbDD4vqeTLwrBwKjuka/fU9H?=
 =?us-ascii?Q?VBPyZUOqBT9qLm0S3++wb+RBT+kEnbhQKlOk+hsS//Cbsirggvam+9XFfrGo?=
 =?us-ascii?Q?kYufQF/cFRjh2ZZ/7eTz8oVm93/gqgDdL7sT17fH1O8/N9Xkxy+EUwg6PSfp?=
 =?us-ascii?Q?F7heUmiW2h3V8DbTxGnwFuTc+voDlhKZHPmLb70iuDSVSAOZ6l2xWpTD1q4+?=
 =?us-ascii?Q?QcKWn8KSjrTCt5/Lwcm4M53Ghx+/XRBvbTE/W4SGOqxgaxBkK8Zmep4xULeK?=
 =?us-ascii?Q?6LdvIWvTk5KSKatgkAF1Wp06negjBduWWUxbwS5kKf3dIbjAad0tdTMM0/m7?=
 =?us-ascii?Q?1EItfzVOBKp2llWAOaSPPCi6l3gzEgaWFaMsDQsQYV+DhIA1RJkf/e6v5MM7?=
 =?us-ascii?Q?Fa5tlGiPQS17epGdMIIFLfNsem4LnO1QhqZTq99xwwGO/MK74BhAYIvXP96Z?=
 =?us-ascii?Q?O88xrDswpyDZQv3SFEkzAjGGe7NM9vm2CRwGDUYw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50394122-3ebc-42e5-19c8-08dbb8f63d66
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 09:53:13.6911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8uwDVJrBCl0qkcQhSscUvKqZlpOmj8/gsUHr/oIBIc0iDRFmxBpq6Rcee8pIrPoNvao59w38dhA/kkFA8I1/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now damos support filter contains two type.
The first is scheme filter which will invoke each scheme apply,
second is scheme action filter, which will filter out unwanted action.

But this implement is scattered in different implementations and hard
to reuse or extend.

This patch clean up those filter code, move into filter.c and add header
to expose filter func.

Each filter implement register itself into filter_fn array, and user
can invoke this by there inited type in filter.

Signed-off-by: Huan Yang <link@vivo.com>
---
 include/linux/damon.h    |  65 +------------------
 mm/damon/Makefile        |   2 +-
 mm/damon/core.c          |  93 ++++-----------------------
 mm/damon/filter.c        | 135 +++++++++++++++++++++++++++++++++++++++
 mm/damon/filter.h        | 119 ++++++++++++++++++++++++++++++++++
 mm/damon/paddr.c         |  31 +++------
 mm/damon/reclaim.c       |   1 +
 mm/damon/sysfs-schemes.c |   1 +
 8 files changed, 280 insertions(+), 167 deletions(-)
 create mode 100644 mm/damon/filter.c
 create mode 100644 mm/damon/filter.h

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 8e8f35df6a5e..03c718b30bfe 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -222,63 +222,6 @@ struct damos_stat {
 	unsigned long qt_exceeds;
 };
 
-/**
- * enum damos_filter_type - Type of memory for &struct damos_filter
- * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
- * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
- * @DAMOS_FILTER_TYPE_ADDR:	Address range.
- * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
- * @DAMOS_FILTER_TYPE_WORKINGSET: Workingset pages, need protect.
- * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
- *
- * The anon pages type, memcg type, workingset page type filters are handled
- * by underlying &struct damon_operations as a part of scheme action trying,
- * and therefore accounted as 'tried'.  In contrast, other types are handled
- * by core layer before trying of the action and therefore not accounted as
- * 'tried'.
- *
- * The support of the filters that handled by &struct damon_operations depend
- * on the running &struct damon_operations.
- * &enum DAMON_OPS_PADDR supports both anon pages type, memcg type and
- * workingset page type filters, while &enum DAMON_OPS_VADDR and &enum
- * DAMON_OPS_FVADDR don't support any of the two types.
- */
-enum damos_filter_type {
-	DAMOS_FILTER_TYPE_ANON,
-	DAMOS_FILTER_TYPE_MEMCG,
-	DAMOS_FILTER_TYPE_WORKINGSET,
-	DAMOS_FILTER_TYPE_ADDR,
-	DAMOS_FILTER_TYPE_TARGET,
-	NR_DAMOS_FILTER_TYPES,
-};
-
-/**
- * struct damos_filter - DAMOS action target memory filter.
- * @type:	Type of the page.
- * @matching:	If the matching page should filtered out or in.
- * @memcg_id:	Memcg id of the question if @type is DAMOS_FILTER_MEMCG.
- * @addr_range:	Address range if @type is DAMOS_FILTER_TYPE_ADDR.
- * @target_idx:	Index of the &struct damon_target of
- *		&damon_ctx->adaptive_targets if @type is
- *		DAMOS_FILTER_TYPE_TARGET.
- * @list:	List head for siblings.
- *
- * Before applying the &damos->action to a memory region, DAMOS checks if each
- * page of the region matches to this and avoid applying the action if so.
- * Support of each filter type depends on the running &struct damon_operations
- * and the type.  Refer to &enum damos_filter_type for more detai.
- */
-struct damos_filter {
-	enum damos_filter_type type;
-	bool matching;
-	union {
-		unsigned short memcg_id;
-		struct damon_addr_range addr_range;
-		int target_idx;
-	};
-	struct list_head list;
-};
-
 /**
  * struct damos_access_pattern - Target access pattern of the given scheme.
  * @min_sz_region:	Minimum size of target regions.
@@ -607,16 +550,14 @@ static inline void damon_insert_region(struct damon_region *r,
 	t->nr_regions++;
 }
 
+void damon_split_region_at(struct damon_target *t,
+				  struct damon_region *r, unsigned long sz_r);
+
 void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges);
 
-struct damos_filter *damos_new_filter(enum damos_filter_type type,
-		bool matching);
-void damos_add_filter(struct damos *s, struct damos_filter *f);
-void damos_destroy_filter(struct damos_filter *f);
-
 struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			enum damos_action action, struct damos_quota *quota,
 			struct damos_watermarks *wmarks);
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index f7add3f4aa79..789ab0a9d9c9 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y				:= core.o
+obj-y				:= core.o filter.o
 obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
 obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
 obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs-schemes.o sysfs.o
diff --git a/mm/damon/core.c b/mm/damon/core.c
index bcd2bd9d6c10..a74932fcdb11 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -22,6 +22,8 @@
 #define DAMON_MIN_REGION 1
 #endif
 
+#include "filter.h"
+
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
 static bool running_exclusive_ctxs;
@@ -263,41 +265,6 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	return 0;
 }
 
-struct damos_filter *damos_new_filter(enum damos_filter_type type,
-		bool matching)
-{
-	struct damos_filter *filter;
-
-	filter = kmalloc(sizeof(*filter), GFP_KERNEL);
-	if (!filter)
-		return NULL;
-	filter->type = type;
-	filter->matching = matching;
-	INIT_LIST_HEAD(&filter->list);
-	return filter;
-}
-
-void damos_add_filter(struct damos *s, struct damos_filter *f)
-{
-	list_add_tail(&f->list, &s->filters);
-}
-
-static void damos_del_filter(struct damos_filter *f)
-{
-	list_del(&f->list);
-}
-
-static void damos_free_filter(struct damos_filter *f)
-{
-	kfree(f);
-}
-
-void damos_destroy_filter(struct damos_filter *f)
-{
-	damos_del_filter(f);
-	damos_free_filter(f);
-}
-
 /* initialize private fields of damos_quota and return the pointer */
 static struct damos_quota *damos_quota_init_priv(struct damos_quota *quota)
 {
@@ -780,9 +747,6 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
-static void damon_split_region_at(struct damon_target *t,
-				  struct damon_region *r, unsigned long sz_r);
-
 static bool __damos_valid_target(struct damon_region *r, struct damos *s)
 {
 	unsigned long sz;
@@ -881,49 +845,16 @@ static void damos_update_stat(struct damos *s,
 static bool __damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos_filter *filter)
 {
-	bool matched = false;
-	struct damon_target *ti;
-	int target_idx = 0;
-	unsigned long start, end;
-
-	switch (filter->type) {
-	case DAMOS_FILTER_TYPE_TARGET:
-		damon_for_each_target(ti, ctx) {
-			if (ti == t)
-				break;
-			target_idx++;
-		}
-		matched = target_idx == filter->target_idx;
-		break;
-	case DAMOS_FILTER_TYPE_ADDR:
-		start = ALIGN_DOWN(filter->addr_range.start, DAMON_MIN_REGION);
-		end = ALIGN_DOWN(filter->addr_range.end, DAMON_MIN_REGION);
-
-		/* inside the range */
-		if (start <= r->ar.start && r->ar.end <= end) {
-			matched = true;
-			break;
-		}
-		/* outside of the range */
-		if (r->ar.end <= start || end <= r->ar.start) {
-			matched = false;
-			break;
-		}
-		/* start before the range and overlap */
-		if (r->ar.start < start) {
-			damon_split_region_at(t, r, start - r->ar.start);
-			matched = false;
-			break;
-		}
-		/* start inside the range */
-		damon_split_region_at(t, r, end - r->ar.start);
-		matched = true;
-		break;
-	default:
-		break;
-	}
+	struct damos_filter_ctx dfctx = {
+		.scheme = {
+			.ctx = ctx,
+			.target = t,
+			.region = r,
+		},
+		.filter = filter,
+	};
 
-	return matched == filter->matching;
+	return damon_filter_invoke(&dfctx);
 }
 
 static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
@@ -1161,7 +1092,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
  * r		the region to be split
  * sz_r		size of the first sub-region that will be made
  */
-static void damon_split_region_at(struct damon_target *t,
+void damon_split_region_at(struct damon_target *t,
 				  struct damon_region *r, unsigned long sz_r)
 {
 	struct damon_region *new;
diff --git a/mm/damon/filter.c b/mm/damon/filter.c
new file mode 100644
index 000000000000..a451d5428fe2
--- /dev/null
+++ b/mm/damon/filter.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Data Access Monitor Filter
+ *
+ * This filter contains the scheme filter, which will be called
+ * for each scheme apply check. action filter will be called when
+ * scheme action invoke.
+ *
+ * Author: Huan Yang <link@vivo.com>
+ */
+#include <linux/damon.h>
+
+#include "filter.h"
+
+typedef bool (*DAMON_FILTER_FN) (struct damos_filter_ctx *dfctx);
+
+/* Scheme action filter */
+
+static bool damos_anon_filter(struct damos_filter_ctx *dfctx)
+{
+	return folio_test_anon(dfctx->action.folio) == dfctx->filter->matching;
+}
+
+static bool damos_memcg_filter(struct damos_filter_ctx *dfctx)
+{
+	struct damos_filter *filter = dfctx->filter;
+	struct mem_cgroup *memcg;
+	bool matched;
+
+	rcu_read_lock();
+	memcg = folio_memcg_check(dfctx->action.folio);
+	if (!memcg)
+		matched = false;
+	else
+		matched = filter->memcg_id == mem_cgroup_id(memcg);
+	rcu_read_unlock();
+
+	return matched == filter->matching;
+}
+
+static bool damos_workingset_filter(struct damos_filter_ctx *dfctx)
+{
+	return folio_test_workingset(dfctx->action.folio) ==
+	       dfctx->filter->matching;
+}
+
+/* Scheme filter */
+
+static bool damos_addr_filter(struct damos_filter_ctx *dfctx)
+{
+	bool matched = false;
+	struct damos_filter *filter = dfctx->filter;
+	struct damon_target *t = dfctx->scheme.target;
+	struct damon_region *r = dfctx->scheme.region;
+	unsigned long start, end;
+
+	start = ALIGN_DOWN(filter->addr_range.start, DAMON_MIN_REGION);
+	end = ALIGN_DOWN(filter->addr_range.end, DAMON_MIN_REGION);
+
+	/* inside the range */
+	if (start <= r->ar.start && r->ar.end <= end) {
+		matched = true;
+		goto got_result;
+	}
+	/* outside of the range */
+	if (r->ar.end <= start || end <= r->ar.start) {
+		matched = false;
+		goto got_result;
+	}
+	/* start before the range and overlap */
+	if (r->ar.start < start) {
+		damon_split_region_at(t, r, start - r->ar.start);
+		matched = false;
+		goto got_result;
+	}
+	/* start inside the range */
+	damon_split_region_at(t, r, end - r->ar.start);
+	matched = true;
+
+got_result:
+	return matched == filter->matching;
+}
+
+static bool damos_target_filter(struct damos_filter_ctx *dfctx)
+{
+	bool matched = false;
+	struct damon_target *ti, *t = dfctx->scheme.target;
+	struct damon_ctx *ctx = dfctx->scheme.ctx;
+	struct damos_filter *filter = dfctx->filter;
+	int target_idx = 0;
+
+	damon_for_each_target(ti, ctx) {
+		if (ti == t)
+			break;
+		target_idx++;
+	}
+	matched = target_idx == filter->target_idx;
+	return matched == filter->matching;
+}
+
+static DAMON_FILTER_FN filter_fn[NR_DAMOS_FILTER_TYPES] = {
+	/* Damos scheme action filter */
+	damos_anon_filter,
+	damos_memcg_filter,
+	damos_workingset_filter,
+	/* Damos scheme filter */
+	damos_addr_filter,
+	damos_target_filter,
+};
+
+
+bool damon_filter_invoke(struct damos_filter_ctx *dfctx)
+{
+	return filter_fn[dfctx->filter->type](dfctx);
+}
+
+struct damos_filter *damos_new_filter(enum damos_filter_type type,
+		bool matching)
+{
+	struct damos_filter *filter;
+
+	filter = kmalloc(sizeof(*filter), GFP_KERNEL);
+	if (!filter)
+		return NULL;
+	filter->type = type;
+	filter->matching = matching;
+	INIT_LIST_HEAD(&filter->list);
+	return filter;
+}
+
+void damos_destroy_filter(struct damos_filter *f)
+{
+	damos_del_filter(f);
+	damos_free_filter(f);
+}
diff --git a/mm/damon/filter.h b/mm/damon/filter.h
new file mode 100644
index 000000000000..5d724e8276fc
--- /dev/null
+++ b/mm/damon/filter.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Data Access Monitor Filter
+ *
+ * Author: Huan Yang <link@vivo.com>
+ */
+#ifndef __DAMON_FILTER_H__
+#define __DAMON_FILTER_H__
+
+/**
+ * enum damos_filter_type - Type of memory for &struct damos_filter
+ * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
+ * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
+ * @DAMOS_FILTER_TYPE_ADDR:	Address range.
+ * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
+ * @DAMOS_FILTER_TYPE_WORKINGSET: Workingset pages, need protect.
+ * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
+ *
+ * The anon pages type, memcg type, workingset page type filters are handled
+ * by underlying &struct damon_operations as a part of scheme action trying,
+ * and therefore accounted as 'tried'.  In contrast, other types are handled
+ * by core layer before trying of the action and therefore not accounted as
+ * 'tried'.
+ *
+ * The support of the filters that handled by &struct damon_operations depend
+ * on the running &struct damon_operations.
+ * &enum DAMON_OPS_PADDR supports both anon pages type, memcg type and
+ * workingset page type filters, while &enum DAMON_OPS_VADDR and &enum
+ * DAMON_OPS_FVADDR don't support any of the two types.
+ */
+enum damos_filter_type {
+	/* Damos action filter, tried */
+	DAMOS_FILTER_TYPE_ANON,
+	DAMOS_FILTER_TYPE_MEMCG,
+	DAMOS_FILTER_TYPE_WORKINGSET,
+	/* Damos scheme filter */
+	DAMOS_FILTER_TYPE_ADDR,
+	DAMOS_FILTER_TYPE_TARGET,
+	NR_DAMOS_FILTER_TYPES,
+};
+
+/**
+ * struct damos_filter - DAMOS action target memory filter.
+ * @type:	Type of the page.
+ * @matching:	If the matching page should filtered out or in.
+ * @memcg_id:	Memcg id of the question if @type is DAMOS_FILTER_MEMCG.
+ * @addr_range:	Address range if @type is DAMOS_FILTER_TYPE_ADDR.
+ * @target_idx:	Index of the &struct damon_target of
+ *		&damon_ctx->adaptive_targets if @type is
+ *		DAMOS_FILTER_TYPE_TARGET.
+ * @list:	List head for siblings.
+ *
+ * Before applying the &damos->action to a memory region, DAMOS checks if each
+ * page of the region matches to this and avoid applying the action if so.
+ * Support of each filter type depends on the running &struct damon_operations
+ * and the type.  Refer to &enum damos_filter_type for more detai.
+ */
+struct damos_filter {
+	enum damos_filter_type type;
+	bool matching;
+	union {
+		unsigned short memcg_id;
+		struct damon_addr_range addr_range;
+		int target_idx;
+	};
+	struct list_head list;
+};
+
+/**
+ * struct damos_filter_ctx - Represents a context for each filter
+ * @scheme:     Each scheme filter context
+ * @action:     Each scheme action filter context
+ * @filter:     DAMOS action target memory filter instance
+ *
+ * User need pass this for each invoke filter, and each filter
+ * will invoke a specified filter function by filter type which
+ * user already target it when register filter.
+ */
+struct damos_filter_ctx {
+	union {
+		/* Use by scheme filter */
+		struct {
+			struct damon_ctx *ctx;
+			struct damon_target *target;
+			struct damon_region *region;
+		} scheme;
+
+		/* Use by action filter */
+		struct {
+			struct folio *folio;
+		} action;
+	};
+
+	struct damos_filter *filter;
+};
+
+bool damon_filter_invoke(struct damos_filter_ctx *dfctx);
+
+struct damos_filter *damos_new_filter(enum damos_filter_type type,
+				      bool matching);
+
+static inline void damos_add_filter(struct damos *s, struct damos_filter *f)
+{
+	list_add_tail(&f->list, &s->filters);
+}
+
+static inline void damos_del_filter(struct damos_filter *f)
+{
+	list_del(&f->list);
+}
+
+static inline void damos_free_filter(struct damos_filter *f)
+{
+	kfree(f);
+}
+
+void damos_destroy_filter(struct damos_filter *f);
+
+#endif //__DAMON_FILTER_H__
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 8a690505e033..748300655ba4 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -16,6 +16,7 @@
 
 #include "../internal.h"
 #include "ops-common.h"
+#include "filter.h"
 
 static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long addr, void *arg)
@@ -189,30 +190,14 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 static bool __damos_pa_filter_out(struct damos_filter *filter,
 		struct folio *folio)
 {
-	bool matched = false;
-	struct mem_cgroup *memcg;
-
-	switch (filter->type) {
-	case DAMOS_FILTER_TYPE_ANON:
-		matched = folio_test_anon(folio);
-		break;
-	case DAMOS_FILTER_TYPE_MEMCG:
-		rcu_read_lock();
-		memcg = folio_memcg_check(folio);
-		if (!memcg)
-			matched = false;
-		else
-			matched = filter->memcg_id == mem_cgroup_id(memcg);
-		rcu_read_unlock();
-		break;
-	case DAMOS_FILTER_TYPE_WORKINGSET:
-		matched = folio_test_workingset(folio);
-		break;
-	default:
-		break;
-	}
+	struct damos_filter_ctx dfctx = {
+		.action = {
+			.folio = folio,
+		},
+		.filter = filter,
+	};
 
-	return matched == filter->matching;
+	return damon_filter_invoke(&dfctx);
 }
 
 /*
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 26ae8fa5d088..1fdd55c03f1f 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 
 #include "modules-common.h"
+#include "filter.h"
 
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 527e7d17eb3b..98cd93b28b21 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 
 #include "sysfs-common.h"
+#include "filter.h"
 
 /*
  * scheme region directory
-- 
2.34.1

