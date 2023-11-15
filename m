Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919697EC998
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjKORXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKORXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:23:49 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA4B6;
        Wed, 15 Nov 2023 09:23:45 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c320a821c4so6160618b3a.2;
        Wed, 15 Nov 2023 09:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069025; x=1700673825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTK9z1mQzSb0VlhTBdpKdiKWd6PG5ky2hj7vrHjyW9I=;
        b=hfqI1Sop2sFHQqWmdBp1ruLCEyZqcFGnl1oCx4U2ddQZ1V5pucHaeWx5/wyjUm/d0R
         wVL7itmUXsma+gdE6UVafr6QvU2kUHrgWE3yaBp4q1riE3qnxqkHBZfmBHz4bFTBBWHX
         t2bfPvJp1l82v4utFucyuGQCU0t+a5Bos4DWtWoR08cQ4arapapmzrbNBJBd4SwcMCC8
         l0GWg8Hk3IC0SPrGeG/WlECl3AJfbP81ag6CzubXlRsTt7YZCqBsf5YOi6pRNOnkYHfp
         YubrTpJIENt9BPWJgzZnE/kOJmKCDmy2EA4X6Uw+RmT3/3j2g3zOOktqLzHwktGHnAuq
         KOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069025; x=1700673825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTK9z1mQzSb0VlhTBdpKdiKWd6PG5ky2hj7vrHjyW9I=;
        b=H4wFWYKXMBSK6qbVM8hu6ahSp/qSsOe2q4aOKJpcAJRXV5ik6daGFXzy2GlnGOKaxP
         kAEWjcSI98K+JcLj9siFDcw5QNPaGZISS/Pn1KOahwT5f9z47jb4A7e1E3ZAOa+5tBbW
         Dj0dhXfaDGxBOH4np0PxXUiSaliFZuvzP9tYf4FCRJxvyETan2vcU3duXeHrfqNPywBR
         p1CuA+fmmgwsMF0ouJ7QcZ/97Lz4qBbwW8MxaPKss2NzAQWX0rBFR2NmlzAIgcDs0Zv8
         +EJly0j9vi+JYNc51/XyROLxKCGQ5Ci3i0/RJrL56eKw3/DgyevaclBamzgjaxjodrQ0
         9Eew==
X-Gm-Message-State: AOJu0YzzurVsEBhu9dgZE2HFzBAe1qbrnuMKX0crbcs0Ub1CRCPSF61s
        04DyOaY7HwWMv874q1nUpuk=
X-Google-Smtp-Source: AGHT+IGNsXjvW227SqhFPnx1Frisjm2+pSechijeDmxtfugz9FHzFwX6/mOFCBiXaFoXWITxZzIjjQ==
X-Received: by 2002:a17:90b:1c8c:b0:281:5860:12f3 with SMTP id oo12-20020a17090b1c8c00b00281586012f3mr11011502pjb.3.1700069024963;
        Wed, 15 Nov 2023 09:23:44 -0800 (PST)
Received: from localhost (fwdproxy-prn-016.fbsv.net. [2a03:2880:ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id a23-20020a17090a6d9700b00267b38f5e13sm122648pjk.2.2023.11.15.09.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:23:44 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
Subject: [PATCH v5] zswap: memcontrol: implement zswap writeback disabling
Date:   Wed, 15 Nov 2023 09:23:44 -0800
Message-Id: <20231115172344.4155593-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During our experiment with zswap, we sometimes observe swap IOs due to
occasional zswap store failures and writebacks-to-swap. These swapping
IOs prevent many users who cannot tolerate swapping from adopting zswap
to save memory and improve performance where possible.

This patch adds the option to disable this behavior entirely: do not
writeback to backing swapping device when a zswap store attempt fail,
and do not write pages in the zswap pool back to the backing swap
device (both when the pool is full, and when the new zswap shrinker is
called).

This new behavior can be opted-in/out on a per-cgroup basis via a new
cgroup file. By default, writebacks to swap device is enabled, which is
the previous behavior. Initially, writeback is enabled for the root
cgroup, and a newly created cgroup will inherit the current setting of
its parent.

Note that this is subtly different from setting memory.swap.max to 0, as
it still allows for pages to be stored in the zswap pool (which itself
consumes swap space in its current form).

This patch should be applied on top of the zswap shrinker series:

https://lore.kernel.org/lkml/20231106183159.3562879-1-nphamcs@gmail.com/

as it also disables the zswap shrinker, a major source of zswap
writebacks.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 12 ++++++++
 Documentation/admin-guide/mm/zswap.rst  |  6 ++++
 include/linux/memcontrol.h              | 12 ++++++++
 include/linux/zswap.h                   |  6 ++++
 mm/memcontrol.c                         | 38 +++++++++++++++++++++++++
 mm/page_io.c                            |  6 ++++
 mm/shmem.c                              |  3 +-
 mm/zswap.c                              | 14 +++++++++
 8 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3f85254f3cef..2b4ac43efdc8 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1679,6 +1679,18 @@ PAGE_SIZE multiple when read back.
 	limit, it will refuse to take any more stores before existing
 	entries fault back in or are written out to disk.
 
+  memory.zswap.writeback
+	A read-write single value file. The default value is "1". The
+	initial value of the root cgroup is 1, and when a new cgroup is
+	created, it inherits the current value of its parent.
+
+	When this is set to 0, all swapping attempts to swapping devices
+	are disabled. This included both zswap writebacks, and swapping due
+	to zswap store failure.
+
+	Note that this is subtly different from setting memory.swap.max to
+	0, as it still allows for pages to be written to the zswap pool.
+
   memory.pressure
 	A read-only nested-keyed file.
 
diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 522ae22ccb84..b987e58edb70 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -153,6 +153,12 @@ attribute, e. g.::
 
 Setting this parameter to 100 will disable the hysteresis.
 
+Some users cannot tolerate the swapping that comes with zswap store failures
+and zswap writebacks. Swapping can be disabled entirely (without disabling
+zswap itself) on a cgroup-basis as follows:
+
+	echo 0 > /sys/fs/cgroup/<cgroup-name>/memory.zswap.writeback
+
 When there is a sizable amount of cold memory residing in the zswap pool, it
 can be advantageous to proactively write these cold pages to swap and reclaim
 the memory for other use cases. By default, the zswap shrinker is disabled.
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 83590fd0d6d1..3901ff4dae63 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -219,6 +219,12 @@ struct mem_cgroup {
 
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	unsigned long zswap_max;
+
+	/*
+	 * Prevent pages from this memcg from being written back from zswap to
+	 * swap, and from being swapped out on zswap store failures.
+	 */
+	bool zswap_writeback;
 #endif
 
 	unsigned long soft_limit;
@@ -1931,6 +1937,7 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
 void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
 void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
+bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg);
 #else
 static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 {
@@ -1944,6 +1951,11 @@ static inline void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg,
 					     size_t size)
 {
 }
+static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
+{
+	/* if zswap is disabled, do not block pages going to the swapping device */
+	return true;
+}
 #endif
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index cbd373ba88d2..b4997e27a74b 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -35,6 +35,7 @@ void zswap_swapoff(int type);
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
 void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_lruvec_swapin(struct page *page);
+bool is_zswap_enabled(void);
 #else
 
 struct zswap_lruvec_state {};
@@ -55,6 +56,11 @@ static inline void zswap_swapoff(int type) {}
 static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
 static inline void zswap_lruvec_init(struct lruvec *lruvec) {}
 static inline void zswap_lruvec_swapin(struct page *page) {}
+
+static inline bool is_zswap_enabled(void)
+{
+	return false;
+}
 #endif
 
 #endif /* _LINUX_ZSWAP_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 786c7edf5836..5ad71ce31c74 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5522,6 +5522,8 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	memcg->zswap_max = PAGE_COUNTER_MAX;
+	WRITE_ONCE(memcg->zswap_writeback,
+		!parent || READ_ONCE(parent->zswap_writeback));
 #endif
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
@@ -8146,6 +8148,12 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 	rcu_read_unlock();
 }
 
+bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
+{
+	/* if zswap is disabled, do not block pages going to the swapping device */
+	return !is_zswap_enabled() || !memcg || READ_ONCE(memcg->zswap_writeback);
+}
+
 static u64 zswap_current_read(struct cgroup_subsys_state *css,
 			      struct cftype *cft)
 {
@@ -8176,6 +8184,31 @@ static ssize_t zswap_max_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static int zswap_writeback_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	seq_printf(m, "%d\n", READ_ONCE(memcg->zswap_writeback));
+	return 0;
+}
+
+static ssize_t zswap_writeback_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int zswap_writeback;
+	ssize_t parse_ret = kstrtoint(strstrip(buf), 0, &zswap_writeback);
+
+	if (parse_ret)
+		return parse_ret;
+
+	if (zswap_writeback != 0 && zswap_writeback != 1)
+		return -EINVAL;
+
+	WRITE_ONCE(memcg->zswap_writeback, zswap_writeback);
+	return nbytes;
+}
+
 static struct cftype zswap_files[] = {
 	{
 		.name = "zswap.current",
@@ -8188,6 +8221,11 @@ static struct cftype zswap_files[] = {
 		.seq_show = zswap_max_show,
 		.write = zswap_max_write,
 	},
+	{
+		.name = "zswap.writeback",
+		.seq_show = zswap_writeback_show,
+		.write = zswap_writeback_write,
+	},
 	{ }	/* terminate */
 };
 #endif /* CONFIG_MEMCG_KMEM && CONFIG_ZSWAP */
diff --git a/mm/page_io.c b/mm/page_io.c
index cb559ae324c6..5e606f1aa2f6 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -201,6 +201,12 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		folio_end_writeback(folio);
 		return 0;
 	}
+
+	if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio))) {
+		folio_mark_dirty(folio);
+		return AOP_WRITEPAGE_ACTIVATE;
+	}
+
 	__swap_writepage(&folio->page, wbc);
 	return 0;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 0d1ce70bce38..ccbaaa5f1c16 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1514,8 +1514,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 
 		mutex_unlock(&shmem_swaplist_mutex);
 		BUG_ON(folio_mapped(folio));
-		swap_writepage(&folio->page, wbc);
-		return 0;
+		return swap_writepage(&folio->page, wbc);
 	}
 
 	mutex_unlock(&shmem_swaplist_mutex);
diff --git a/mm/zswap.c b/mm/zswap.c
index 943090dfe793..caa467e40009 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -152,6 +152,11 @@ module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool, 0644);
 static bool zswap_shrinker_enabled;
 module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
 
+bool is_zswap_enabled(void)
+{
+	return zswap_enabled;
+}
+
 /*********************************
 * data structures
 **********************************/
@@ -589,6 +594,9 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 	struct zswap_pool *pool = shrinker->private_data;
 	bool encountered_page_in_swapcache = false;
 
+	if (!mem_cgroup_zswap_writeback_enabled(sc->memcg))
+		return SHRINK_STOP;
+
 	nr_protected =
 		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
 	lru_size = list_lru_shrink_count(&pool->list_lru, sc);
@@ -619,6 +627,9 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
 	unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
 
+	if (!mem_cgroup_zswap_writeback_enabled(memcg))
+		return 0;
+
 #ifdef CONFIG_MEMCG_KMEM
 	cgroup_rstat_flush(memcg->css.cgroup);
 	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
@@ -934,6 +945,9 @@ static int shrink_memcg(struct mem_cgroup *memcg)
 	struct zswap_pool *pool;
 	int nid, shrunk = 0;
 
+	if (!mem_cgroup_zswap_writeback_enabled(memcg))
+		return -EINVAL;
+
 	/*
 	 * Skip zombies because their LRUs are reparented and we would be
 	 * reclaiming from the parent instead of the dead memcg.
-- 
2.34.1
