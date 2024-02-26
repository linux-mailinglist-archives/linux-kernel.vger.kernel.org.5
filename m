Return-Path: <linux-kernel+bounces-81587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C948677DB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5634A1F2491B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2BC12EBF8;
	Mon, 26 Feb 2024 14:06:29 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F45212C806;
	Mon, 26 Feb 2024 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956388; cv=none; b=UxfT1S+XGWfbz333VuGVeNAns7fS9Sz30jHKyjWpQCPF+BBATMSL0A0x6f2wCy18BIP497MNWFUPTBgeyFf5g59ruZXQTP3xXTJ/Spl/tTdoXfp645QoG9r2/sMOy4HM+It+6RAIboOIGXMbknm2AAd4jR5O+wHzFTHfTyF6xw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956388; c=relaxed/simple;
	bh=NUk0r1jrb5I7n+/isN9uEsOAk3VhDiA1jU8BnjP6q5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q81FaF1r+8uHPUCTIHMXt8GTlaQWjNFyb+SJkpKD2yjd2MNF5/uTmKJlZ/gRy9nXOIav5iRRvYS/s2MICtxdnPIxNjSbu1XtPKLlAbQcU7WCo7gDgmMXkALXmO43o52ha5ofxscvpUR55BUMttmExXCPog9fC2QO3JvP3ZmcNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-8d-65dc9adceeac
From: Honggyu Kim <honggyu.kim@sk.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com
Subject: [PATCH v2 6/7] mm/damon/sysfs-schemes: add target_nid on sysfs-schemes
Date: Mon, 26 Feb 2024 23:05:52 +0900
Message-ID: <20240226140555.1615-7-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240226140555.1615-1-honggyu.kim@sk.com>
References: <20240226140555.1615-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsXC9ZZnoe6dWXdSDabtMrSY2GNgMWf9GjaL
	XTdCLP7vPcZo8eT/b1aLEzcb2Sw6vy9lsbi8aw6bxb01/1ktjqw/y2Kx7haQtfnsGWaLxcvV
	LPZ1PGCyOPz1DZPF5EsL2CxeTDnDaHFy1mQWi9lH77E7CHv8PziJ2WPp6TdsHhuagMTOWXfZ
	PVr23WL3WLCp1KPlyFtWj8V7XjJ5bFrVyeax6dMkdo8TM36zeOx8aOnxYvNMRo/e5ndsHp83
	yQXwR3HZpKTmZJalFunbJXBlXF0wnb3gulXFxwm32RsYlxp0MXJySAiYSBx/+4cFxr59dQcT
	iM0moCZx5eUkIJuDQ0TAQWLVV4UuRi4OZoEGFokfny+B1QsL+EscnrCcGaSGRUBVom2dEkiY
	V8BMouvfL0aIkZoSj7f/ZAexOQXMJf4fbmcDKRcCqjl6mxmiXFDi5MwnYBOZBeQlmrfOZgZZ
	JSFwjF3ie+dLqNMkJQ6uuMEygZF/FpKeWUh6FjAyrWIUyswry03MzDHRy6jMy6zQS87P3cQI
	jL5ltX+idzB+uhB8iFGAg1GJh9eh9k6qEGtiWXFl7iFGCQ5mJRHecJmbqUK8KYmVValF+fFF
	pTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYQwSEvGbm/NZbP69KaPn8qaoV
	pU+Tf2QwKiztbJASzsrYlX5OUXf20QNbH7xc7zPpZcaeLdHGvB2nAqbpP+XPOchaqxLnq7bA
	8PW+ythV5ncnrV5x8l/J6/0ORQfTP/mZTX3B8km+vNjqX810r3+Ovv9Dti0ve9K+v+CLynrn
	WO/sbrmp3Gu/KLEUZyQaajEXFScCANrcd+m6AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXCNUNLT/fOrDupBr+/KFtM7DGwmLN+DZvF
	rhshFv/3HmO0ePL/N6vFiZuNbBafn71mtuh88p3R4vDck6wWnd+Xslhc3jWHzeLemv+sFkfW
	n2WxWHcLyNp89gyzxeLlahaHrj1ntdjX8YDJ4vDXN0wWky8tYLN4MeUMo8XJWZNZLGYfvcfu
	IO7x/+AkZo+lp9+weWxoAhI7Z91l92jZd4vdY8GmUo+WI29ZPRbvecnksWlVJ5vHpk+T2D1O
	zPjN4rHzoaXHi80zGT16m9+xeXy77eGx+MUHpgDBKC6blNSczLLUIn27BK6Mqwumsxdct6r4
	OOE2ewPjUoMuRk4OCQETidtXdzCB2GwCahJXXk4Csjk4RAQcJFZ9Vehi5OJgFmhgkfjx+RIL
	SI2wgL/E4QnLmUFqWARUJdrWKYGEeQXMJLr+/WKEGKkp8Xj7T3YQm1PAXOL/4XY2kHIhoJqj
	t5khygUlTs58AjaRWUBeonnrbOYJjDyzkKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZec
	n7uJERhpy2r/TNzB+OWy+yFGAQ5GJR5eh9o7qUKsiWXFlbmHGCU4mJVEeMNlbqYK8aYkVlal
	FuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MO7dPfsYU8OBR6rquvop
	3mKHUifcvyzWssDszQmTtS7CwhFJe1pWvlKt8TB361ObJqC9aNf2ipjZ7hp1uTVrOPNMmzs1
	//DzLbBZwFy39a+ClES9U2y8p5RK8X4p7utcq3bt3bygob3Mnq14SfQ+d/23H30nGm/bXXcu
	n6/TXrHmkl9XuO8lJZbijERDLeai4kQAbAwRP7ACAAA=
X-CFilter-Loop: Reflected

From: Hyeongtak Ji <hyeongtak.ji@sk.com>

This patch adds target_nid under
  /sys/kernel/mm/damon/admin/kdamonds/<N>/contexts/<N>/schemes/<N>

target_nid can be used as the destination node for DAMOS actions such as
DAMOS_DEMOTE or DAMOS_PROMOTE in the future.

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 include/linux/damon.h    | 11 ++++++++++-
 mm/damon/core.c          |  5 ++++-
 mm/damon/dbgfs.c         |  2 +-
 mm/damon/lru_sort.c      |  3 ++-
 mm/damon/reclaim.c       |  3 ++-
 mm/damon/sysfs-schemes.c | 37 ++++++++++++++++++++++++++++++++++++-
 6 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d7e52d0228b4..4d270956dbd0 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -321,6 +321,7 @@ struct damos_access_pattern {
  * @apply_interval_us:	The time between applying the @action.
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
+ * @target_nid:		Destination node if @action is "promote" or "demote".
  * @filters:		Additional set of &struct damos_filter for &action.
  * @stat:		Statistics of this scheme.
  * @list:		List head for siblings.
@@ -336,6 +337,10 @@ struct damos_access_pattern {
  * monitoring context are inactive, DAMON stops monitoring either, and just
  * repeatedly checks the watermarks.
  *
+ * @target_nid is used to set the destination node for promote or demote
+ * actions, which means it's only meaningful when @action is either "promote" or
+ * "demote".
+ *
  * Before applying the &action to a memory region, &struct damon_operations
  * implementation could check pages of the region and skip &action to respect
  * &filters
@@ -357,6 +362,9 @@ struct damos {
 /* public: */
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
+	union {
+		int target_nid;
+	};
 	struct list_head filters;
 	struct damos_stat stat;
 	struct list_head list;
@@ -661,7 +669,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			enum damos_action action,
 			unsigned long apply_interval_us,
 			struct damos_quota *quota,
-			struct damos_watermarks *wmarks);
+			struct damos_watermarks *wmarks,
+			int target_nid);
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
 void damon_destroy_scheme(struct damos *s);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3a05e71509b9..0c2472818fb9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -316,7 +316,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			enum damos_action action,
 			unsigned long apply_interval_us,
 			struct damos_quota *quota,
-			struct damos_watermarks *wmarks)
+			struct damos_watermarks *wmarks,
+			int target_nid)
 {
 	struct damos *scheme;
 
@@ -341,6 +342,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->wmarks = *wmarks;
 	scheme->wmarks.activated = true;
 
+	scheme->target_nid = target_nid;
+
 	return scheme;
 }
 
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index dc0ea1fc30ca..29b427dd1186 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -279,7 +279,7 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 
 		pos += parsed;
 		scheme = damon_new_scheme(&pattern, action, 0, &quota,
-				&wmarks);
+				&wmarks, NUMA_NO_NODE);
 		if (!scheme)
 			goto fail;
 
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index f2e5f9431892..fd0492637fce 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -163,7 +163,8 @@ static struct damos *damon_lru_sort_new_scheme(
 			/* under the quota. */
 			&quota,
 			/* (De)activate this according to the watermarks. */
-			&damon_lru_sort_wmarks);
+			&damon_lru_sort_wmarks,
+			NUMA_NO_NODE);
 }
 
 /* Create a DAMON-based operation scheme for hot memory regions */
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index ab974e477d2f..973ac5df84eb 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -147,7 +147,8 @@ static struct damos *damon_reclaim_new_scheme(void)
 			/* under the quota. */
 			&damon_reclaim_quota,
 			/* (De)activate this according to the watermarks. */
-			&damon_reclaim_wmarks);
+			&damon_reclaim_wmarks,
+			NUMA_NO_NODE);
 }
 
 static int damon_reclaim_apply_parameters(void)
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 9bc48932eb6c..8bf5aa98d916 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/numa.h>
 
 #include "sysfs-common.h"
 
@@ -1175,6 +1176,7 @@ struct damon_sysfs_scheme {
 	struct damon_sysfs_scheme_filters *filters;
 	struct damon_sysfs_stats *stats;
 	struct damon_sysfs_scheme_regions *tried_regions;
+	int target_nid;
 };
 
 /* This should match with enum damos_action */
@@ -1202,6 +1204,7 @@ static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
 	scheme->kobj = (struct kobject){};
 	scheme->action = action;
 	scheme->apply_interval_us = apply_interval_us;
+	scheme->target_nid = NUMA_NO_NODE;
 	return scheme;
 }
 
@@ -1424,6 +1427,32 @@ static ssize_t apply_interval_us_store(struct kobject *kobj,
 	return err ? err : count;
 }
 
+static ssize_t target_nid_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+
+	return sysfs_emit(buf, "%d\n", scheme->target_nid);
+}
+
+static ssize_t target_nid_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+	int err = 0;
+
+	if (scheme->action != DAMOS_DEMOTE &&
+	    scheme->action != DAMOS_PROMOTE)
+		return -EINVAL;
+
+	/* TODO: error handling for target_nid range. */
+	err = kstrtoint(buf, 0, &scheme->target_nid);
+
+	return err ? err : count;
+}
+
 static void damon_sysfs_scheme_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
@@ -1435,9 +1464,13 @@ static struct kobj_attribute damon_sysfs_scheme_action_attr =
 static struct kobj_attribute damon_sysfs_scheme_apply_interval_us_attr =
 		__ATTR_RW_MODE(apply_interval_us, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_target_nid_attr =
+		__ATTR_RW_MODE(target_nid, 0600);
+
 static struct attribute *damon_sysfs_scheme_attrs[] = {
 	&damon_sysfs_scheme_action_attr.attr,
 	&damon_sysfs_scheme_apply_interval_us_attr.attr,
+	&damon_sysfs_scheme_target_nid_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme);
@@ -1690,7 +1723,8 @@ static struct damos *damon_sysfs_mk_scheme(
 	};
 
 	scheme = damon_new_scheme(&pattern, sysfs_scheme->action,
-			sysfs_scheme->apply_interval_us, &quota, &wmarks);
+			sysfs_scheme->apply_interval_us, &quota, &wmarks,
+			sysfs_scheme->target_nid);
 	if (!scheme)
 		return NULL;
 
@@ -1721,6 +1755,7 @@ static void damon_sysfs_update_scheme(struct damos *scheme,
 
 	scheme->action = sysfs_scheme->action;
 	scheme->apply_interval_us = sysfs_scheme->apply_interval_us;
+	scheme->target_nid = sysfs_scheme->target_nid;
 
 	scheme->quota.ms = sysfs_quotas->ms;
 	scheme->quota.sz = sysfs_quotas->sz;
-- 
2.34.1


