Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDD67A5EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjISJx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjISJxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:53:20 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2951E1B2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3K7/gBvFj6wtgHu/E33aLKKT6/WPYhGfKCHgpX/MLRPwKyfBA8B2oRiwmpj4wM4gByuYbR5rJMVVEMjwLITUTMAH3zJNbcBuaZg9bSQOjyZRac5a9xw4OXGi6inzfAWvt5YI7hgVttRrhp+UDoteYutsHbMtLs/dL63MHts884rGhLc9oFI2JbBDb4FDgun5Unv5vQSrdjmvz2b2qwS5bzI3Gj1zGYIOikGJnQxvtarxCRiixSxPHTJFBwJb3ba/6VpmNLEoyUMK+oZiMOUM8S++qCJe4EAVb51kct0t1NTP/MEDdUhDtfzF+lPNJ8Ng2fQZ9S/Fx6qwlzPikSTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3LE/55I82eILXxLyiQt1PFXjevKzFe0iPNNK+GMHa0=;
 b=jMsUWITaoOTX9CLpX9gipLkx0VzBB5Wi44TF6xt+DmXHFmMpiEeGg5RHqeJfn3ORRMKeY3TP69qHaw9m00X2NsFKkJgQn4mcN55JLy9QO5q8OmKTDwyQcAadtGytYxgi/p2dKxiMApUh9Z3gkEn/h6/efBsm8qtPX09VwvZTHgVbPVn6g1Egmg641hHDmX+OYqWLO+yZ7chXZteq+1+OAeh5J9IsyXza9Kkp3gbIh+WFkZN8zw1FCoDy6lPI/rK6dUCTdbbPvIUdeU+Y5jZdjHrShpVQw/G2R2/4oB5hNISeo2T1Vk/Hn2u235zJNe3pzuoqV3cRZ/ShHfufT5ZwWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3LE/55I82eILXxLyiQt1PFXjevKzFe0iPNNK+GMHa0=;
 b=hKjzNrybsVtdDL9nUn6FC/gq14pLsnLQgZbqhaldcryUDvJreq7bbsVXsa6RqRwAQIXLG6lfewY3iomX15LR4VjIehSA+wB5ZXAko5diD1Tnd3vTsQOFW03D+yHPpDQApV8qM84yB6H9LwRsR/uyHVy0rm0fgwWwO/S9cVDBOkjDSHTlx+4+FPQR6vXJubYEPel/ltrgSuGbWM+kFdoq6srowDvIdlDt2dMEtTOjjGHinh5FIKNg9JwLucTfuY/MmfSZqAW8h8J25Ssm53Q0hD0NfcBrRod3VzRGxbIqFPOOw1Ef2h3UE6WRlmUcpsrLquxU3RE529fFhGM0FszKYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB6982.apcprd06.prod.outlook.com (2603:1096:101:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 09:53:09 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02%4]) with mapi id 15.20.6792.020; Tue, 19 Sep 2023
 09:53:09 +0000
From:   Huan Yang <link@vivo.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org (open list),
        damon@lists.linux.dev (open list:DATA ACCESS MONITOR),
        linux-mm@kvack.org (open list:DATA ACCESS MONITOR)
Cc:     opensource.kernel@vivo.com, Huan Yang <link@vivo.com>
Subject: [RFC 1/2] mm/damos/filter: Add workingset page filter
Date:   Tue, 19 Sep 2023 17:52:34 +0800
Message-Id: <20230919095237.26613-2-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 18eccd68-fc61-49f5-a951-08dbb8f63aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e96jzMI9iprI7XXNXNYFSCpcQc9/uzUucCHUqkL4J8TZ5XdZy/dXXRExqASO1L8eeY+DX5Ek8QmcrVImiErfXSPbr9mLaXSrSAltulqCQC8tgIBTY2Ety8VNnrnfkshK9Q0G67rsvbb0Jsu12X9gCHhOkPLsT6Ohf/YfhhDVCcxLc0/7Nf1LYdQpSrH6HX1PwWSH4DJxPwR8bA6/glqooQRrZK8MA2IZ5HylN6OwmpoFWyILMlt9lEDBYwq46OcAh6m4ZlZDiJVX7iFb4m+Dm1mrDwNqjhF1Esy05E5vzEtuaUOOhrqnyWnqEAj7qVos4qXb130Knce+kgwrtxSfEixF0t6lFoUW9fKr+EOKhNUF448kgfn63gSzXyO0+dHtw8N7VIAMuKTQynl92xVw9XYemKXeBOSiT2KPMz/V1PHSt82ssq2Y7rAUqNJF2MUU1sPFLtrTa+enkahr11j3BhcQ3XXkhiwF49rTEs+0GTYWBbcS3rHWDowc7TZYHPJOs44r750udZOR9MYhw+M1ldCkWuIjiRfeTbtkrAdK6sZhCnJOWf8Jn+N7RE4DU+J8bn6eldisOqKbhEYUysWKiVrSBmXyQbHHIGSJ92ouCF4i/7AzzNWwv8iziuAqSWFI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(4326008)(5660300002)(6506007)(6486002)(52116002)(8676002)(8936002)(316002)(41300700001)(66946007)(66556008)(478600001)(66476007)(6666004)(2906002)(110136005)(6512007)(83380400001)(1076003)(26005)(107886003)(2616005)(38100700002)(36756003)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fj1xWew2/iEDUDY382b8Co2MaYuuIMf1iH377AW2axgZKvdDCW3LwDE4FzSt?=
 =?us-ascii?Q?4wRCeUEIwk+Pfjk3sfvvxsrBX9Q8RHNb3txe113lZTwWK2EaubR7k1gDeupR?=
 =?us-ascii?Q?hYgJIg7fqYO2qLfQspwZhfxJeFYW2X2Jq8rsBYVFUWsXZvpGIl9jdOPBIwGr?=
 =?us-ascii?Q?RLGIPjpXI2SwGiIhP7sSRcvD3HSGkGQ0n2iDi5zb7+slfjbtRi/RAHwlDzUt?=
 =?us-ascii?Q?saW3VWhf2FmIR0yVljGhMxrQPKGkfpo60C+eBRB5iJBRJVW0lbByVRBhaIv6?=
 =?us-ascii?Q?749FLS2dqWGZ2BRGRg6dzZe9eaBqxl7rRE5BhVearsbiXJtQ+RGRIxdn/Nwz?=
 =?us-ascii?Q?HXpdni1phYXMgmmFjmnsGvzC3qsxcWYbmpvXyZIrYhzp6v3hpo33I4EfMw/N?=
 =?us-ascii?Q?fGkkcZNJ0CmXdb/zKozfF3Rf6fiTj6dEdymcdWS+6w47DLM2zHF8R19waLFl?=
 =?us-ascii?Q?vCe/FX4SuAXkayLl3xoPXcSp6ZKYt0wWZB3FpBr3jLGnYISHATA9YnA/i4d1?=
 =?us-ascii?Q?ekETAIjX1Nrps5Z/SNwzDcq8EtNBXyorufPq6kdbAM6/mGm3RBDx1/XK0I7E?=
 =?us-ascii?Q?R6AlZh8Pki6iZcqcbiMJW4vgxixW/zfrhapecroIFoSQybUtqEPI2pIULnY8?=
 =?us-ascii?Q?x+FbH5H4ySNnKVA5RHULjLlaIFltq+B97x0T/kgBFWSDntSS0tghiMbQmveU?=
 =?us-ascii?Q?HrYNbpQBJplr8qEfIMzDFttAtWtE03nJT9XSujZQJGJhlKuC7x4HipUNpTlA?=
 =?us-ascii?Q?0swtbR9v7K3En3omDeCSOYhf9vo3GpAdMwpelW9XlrzB42aBwcInNPCPFHcm?=
 =?us-ascii?Q?f8UgiguzJizvmVVLyJt6/aNRQZUOajwbt11LU6RAb7J/j0bC70U8fxIPYhJg?=
 =?us-ascii?Q?ECse4sazWplIplvcrrMICmhv0Dizzkp8BpWKtPKcrvdXme1HMc8Goemlzmli?=
 =?us-ascii?Q?wywpdeTKkQrsHR1wn7a9qk+x4XOgKfnRtqFU71hgeX5r7q45vigY1aZscW4i?=
 =?us-ascii?Q?t7tgObQhFAh3PxUl3W5JgtW/OdAbMuBYWQh1nLhs21I1HpknjEFZHvvrjVA4?=
 =?us-ascii?Q?swfWudmWbEr63G4NnBa6atc0WJdJqLAFrnoNfChVVVx3yDrZJpBRy4pR4nWw?=
 =?us-ascii?Q?YgshJ2ujZlAAe++vL/DOO0hNyzLGyMRmYC/ffbo2Fl1RWm+FtV6HpXLU4ivL?=
 =?us-ascii?Q?u7+DCG4yjo2YHdKOVuCvJFpVCI9+IoHhJELLXYDgUO5r+5iz7HIGgY+z6oHd?=
 =?us-ascii?Q?5LMCdmFY1zsIyDQkQxuGs86Z07TAk6FRG1dIE13fa3MPCBOfB4yddCyRDxKs?=
 =?us-ascii?Q?OeDoTWliSAYzHjghaCaRTo9UCnhHj4EHsojLjqMYgI5azwyRTDwbB24oPPOi?=
 =?us-ascii?Q?VOYMSJ4nyM9bpyQWPlt0EwmivYelZfFP7BUkeW9TsTvvswmImL6RKm0bEcfe?=
 =?us-ascii?Q?3KY7FZb/VO6aUUs+XYi3bCj1DCNg1+Z0cwjUrr6noYW7uLLqru8w+uudF9y7?=
 =?us-ascii?Q?c32iz90NhrQo1yTvT61l029gykDiY3gOCU8fVMuMVFYBjuTP09mSV2r4CAut?=
 =?us-ascii?Q?shth8M13j+QFBog4urm9kzDTL3s3n183bK8EyM8d?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18eccd68-fc61-49f5-a951-08dbb8f63aab
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 09:53:09.0354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wkp5VNq9fImUqPdezvxygNIt3uAX4Zi/v/bZBKCQAYqYZnyJCCcVNTstFDVPoWIdTfqqQMJQ1/BNOcnzWzO3wQ==
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

Some page if marked as workingset, we'd better not touch it.
So, for damon pa scheme, this patch just add an new filter
DAMOS_FILTER_TYPE_WORKINGSET, which will filter page if it
marked as workingset.

Like skip anon, add a control skip_workingset.

To make code clean, fold reclaim's filter create logic into
__damon_reclaim_create_filters.

Signed-off-by: Huan Yang <link@vivo.com>
---
 include/linux/damon.h | 17 +++++++++-------
 mm/damon/core-test.h  |  7 +++++++
 mm/damon/paddr.c      |  4 ++++
 mm/damon/reclaim.c    | 47 ++++++++++++++++++++++++++++++++++---------
 4 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ae2664d1d5f1..8e8f35df6a5e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -228,22 +228,25 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
+ * @DAMOS_FILTER_TYPE_WORKINGSET: Workingset pages, need protect.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
  *
- * The anon pages type and memcg type filters are handled by underlying
- * &struct damon_operations as a part of scheme action trying, and therefore
- * accounted as 'tried'.  In contrast, other types are handled by core layer
- * before trying of the action and therefore not accounted as 'tried'.
+ * The anon pages type, memcg type, workingset page type filters are handled
+ * by underlying &struct damon_operations as a part of scheme action trying,
+ * and therefore accounted as 'tried'.  In contrast, other types are handled
+ * by core layer before trying of the action and therefore not accounted as
+ * 'tried'.
  *
  * The support of the filters that handled by &struct damon_operations depend
  * on the running &struct damon_operations.
- * &enum DAMON_OPS_PADDR supports both anon pages type and memcg type filters,
- * while &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR don't support any of
- * the two types.
+ * &enum DAMON_OPS_PADDR supports both anon pages type, memcg type and
+ * workingset page type filters, while &enum DAMON_OPS_VADDR and &enum
+ * DAMON_OPS_FVADDR don't support any of the two types.
  */
 enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
 	DAMOS_FILTER_TYPE_MEMCG,
+	DAMOS_FILTER_TYPE_WORKINGSET,
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	NR_DAMOS_FILTER_TYPES,
diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..c752e6e3cf3e 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -351,6 +351,13 @@ static void damos_test_new_filter(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, filter->list.prev, &filter->list);
 	KUNIT_EXPECT_PTR_EQ(test, filter->list.next, &filter->list);
 	damos_destroy_filter(filter);
+
+	filter = damos_new_filter(DAMOS_FILTER_TYPE_WORKINGSET, true);
+	KUNIT_EXPECT_EQ(test, filter->type, DAMOS_FILTER_TYPE_WORKINGSET);
+	KUNIT_EXPECT_EQ(test, filter->matching, true);
+	KUNIT_EXPECT_PTR_EQ(test, filter->list.prev, &filter->list);
+	KUNIT_EXPECT_PTR_EQ(test, filter->list.next, &filter->list);
+	damos_destroy_filter(filter);
 }
 
 static void damos_test_filter_out(struct kunit *test)
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 909db25efb35..8a690505e033 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -12,6 +12,7 @@
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
+#include <linux/mm_inline.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -204,6 +205,9 @@ static bool __damos_pa_filter_out(struct damos_filter *filter,
 			matched = filter->memcg_id == mem_cgroup_id(memcg);
 		rcu_read_unlock();
 		break;
+	case DAMOS_FILTER_TYPE_WORKINGSET:
+		matched = folio_test_workingset(folio);
+		break;
 	default:
 		break;
 	}
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 648d2a85523a..26ae8fa5d088 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -107,6 +107,15 @@ module_param(monitor_region_end, ulong, 0600);
 static bool skip_anon __read_mostly;
 module_param(skip_anon, bool, 0600);
 
+/*
+ * Skip workingset pages reclamation.
+ *
+ * If this parameter is set as ``Y``, DAMON_RECLAIM does not reclaim workingset
+ * pages.  By default, ``N``.
+ */
+static bool skip_workingset __read_mostly;
+module_param(skip_workingset, bool, 0600);
+
 /*
  * PID of the DAMON thread
  *
@@ -148,10 +157,25 @@ static struct damos *damon_reclaim_new_scheme(void)
 			&damon_reclaim_wmarks);
 }
 
+static int __damon_reclaim_create_filters(struct damos *scheme,
+					  enum damos_filter_type type,
+					  bool matching)
+{
+	struct damos_filter *filter = damos_new_filter(type, matching);
+
+	if (unlikely(!filter)) {
+		/* Will be freed by next 'damon_set_schemes()' below */
+		damon_destroy_scheme(scheme);
+		return -ENOMEM;
+	}
+
+	damos_add_filter(scheme, filter);
+	return 0;
+}
+
 static int damon_reclaim_apply_parameters(void)
 {
 	struct damos *scheme;
-	struct damos_filter *filter;
 	int err = 0;
 
 	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
@@ -162,15 +186,18 @@ static int damon_reclaim_apply_parameters(void)
 	scheme = damon_reclaim_new_scheme();
 	if (!scheme)
 		return -ENOMEM;
-	if (skip_anon) {
-		filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
-		if (!filter) {
-			/* Will be freed by next 'damon_set_schemes()' below */
-			damon_destroy_scheme(scheme);
-			return -ENOMEM;
-		}
-		damos_add_filter(scheme, filter);
-	}
+
+	err = skip_anon && __damon_reclaim_create_filters(
+				   scheme, DAMOS_FILTER_TYPE_ANON, true);
+	if (err)
+		return err;
+
+	err = skip_workingset &&
+	      __damon_reclaim_create_filters(
+		      scheme, DAMOS_FILTER_TYPE_WORKINGSET, true);
+	if (err)
+		return err;
+
 	damon_set_schemes(ctx, &scheme, 1);
 
 	return damon_set_region_biggest_system_ram_default(target,
-- 
2.34.1

