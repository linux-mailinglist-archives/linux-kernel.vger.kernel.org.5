Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A5D7D5EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 01:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344651AbjJXXfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 19:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343883AbjJXXfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 19:35:05 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406A8D7A;
        Tue, 24 Oct 2023 16:35:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27d0acd0903so3479919a91.1;
        Tue, 24 Oct 2023 16:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698190503; x=1698795303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b4Ij5pQG5szV54GYUJBKO1wv/LZcmkWQRS+LtnyDhXg=;
        b=WdYKUSCHUBauXXauG93WGbjZY9IVELVpeeX3nsNJpabNF0afu0SnOnh8A06PrYe/+G
         tjAjg7RPQ9OsdQJPWTzPkY0LBRsjvHwOdnTyn14aFtsRr6c85SgfxWvNxS70XGhuMD2h
         cCuqSsbHwY4NmGRdiXkAAsh1h7ITyywETFr9s4cWZvvaogx107MzNJyB0P28DIs1tSbs
         5eRpG/8uOBsYEiL/c5OccYm32Sr+C7hPDVZY1/E8yxBV7gN+yDTMELGZLozFhxJR4Szp
         X9Jtz3KGExFNZbfXR/l0ctA6BMu9ixVvMO0iTUkKDqYCfF3f3oCYs9Bb2uZcK9eaTF0o
         n6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698190503; x=1698795303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4Ij5pQG5szV54GYUJBKO1wv/LZcmkWQRS+LtnyDhXg=;
        b=mY1t4k7panMlwOszVC/jfqYH/1unG7FjPFbj4LhgHp7mJn/XtUPmBPLygJEyseMLW5
         KPbxW1+aNNi/mnixqY04/AAEBmBQMJEu77gsMqoZya9o1Rg9KpUo33pS6ZAL8LB7GOG3
         h9kMcBBG3ARgLGSO07VyG7W7bAALeW55Dc0fapKf7ZQSj+jMufYFliSQ7ju/Pzx9mLPN
         rLtT0yaEQu5UDrPJMBcROHxkiMmgeuzYnlRc5BvYDotVk5Lt2oZW0jVE5LFks3QURgl1
         CbtYqBEtyl9payL65PfKM15qHTqP76hfhB6rnApmuHWP59fxHXWGX2HSL7+w+LUc2Vcl
         wxrg==
X-Gm-Message-State: AOJu0YyiuyUacinJB4omS1iO/lKL5W8re2o8GK+H1MoHBxPuxrXJl3YD
        3G5+KfLgzVLtQdUJVpV4XEQ=
X-Google-Smtp-Source: AGHT+IHnCRDw8I8GGeR+MlaaT+kwS4k/fxb61omhQzxfL7F7XleUyS/Kj/7XfTbFNLKOmrMdoESqhg==
X-Received: by 2002:a17:90b:70b:b0:263:1f1c:ef4d with SMTP id s11-20020a17090b070b00b002631f1cef4dmr11664717pjz.10.1698190502525;
        Tue, 24 Oct 2023 16:35:02 -0700 (PDT)
Received: from localhost (fwdproxy-prn-004.fbsv.net. [2a03:2880:ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id x89-20020a17090a6c6200b0027d06ddc06bsm10378267pjj.33.2023.10.24.16.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 16:35:02 -0700 (PDT)
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
Subject: [RFC PATCH] memcontrol: implement swap bypassing
Date:   Tue, 24 Oct 2023 16:35:01 -0700
Message-Id: <20231024233501.2639043-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During our experiment with zswap, we sometimes observe swap IOs due to
occasional zswap store failures and writebacks. These swapping IOs
prevent many users who cannot tolerate swapping from adopting zswap to
save memory and improve performance where possible.

This patch adds the option to bypass swap entirely: do not swap when an
zswap store attempt fail, and do not write pages in the zswap pool back
to swap. The feature is disabled by default (to preserve the existing
behavior), and can be enabled on a cgroup-basis via a new cgroup file.

Note that this is subtly different from setting memory.swap.max to 0, as
it still allows for pages to be stored in the zswap pool (which itself
consumes swap space in its current form).

This is the second attempt (spiritual successor) of the following patch:

https://lore.kernel.org/linux-mm/20231017003519.1426574-2-nphamcs@gmail.com/

and should be applied on top of the zswap shrinker series:

https://lore.kernel.org/linux-mm/20231024203302.1920362-1-nphamcs@gmail.com/

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 11 +++++
 Documentation/admin-guide/mm/zswap.rst  |  6 +++
 include/linux/memcontrol.h              | 20 ++++++++++
 mm/memcontrol.c                         | 53 +++++++++++++++++++++++++
 mm/page_io.c                            |  6 +++
 mm/shmem.c                              |  8 +++-
 mm/zswap.c                              |  9 +++++
 7 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 606b2e0eac4b..34306d70b3f7 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1657,6 +1657,17 @@ PAGE_SIZE multiple when read back.
 	higher than the limit for an extended period of time.  This
 	reduces the impact on the workload and memory management.
 
+  memory.swap.bypass.enabled
+	A read-write single value file which exists on non-root
+	cgroups.  The default value is "0".
+
+	When this is set to 1, all swapping attempts are disabled.
+	Note that this is subtly different from setting memory.swap.max to
+	0, as it still allows for pages to be written to the zswap pool
+	(which also consumes swap space in its current form). However,
+	zswap store failure will not lead to swapping, and zswap writebacks
+	will be disabled altogether.
+
   memory.zswap.current
 	A read-only single value file which exists on non-root
 	cgroups.
diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 522ae22ccb84..b7bf481a3e25 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -153,6 +153,12 @@ attribute, e. g.::
 
 Setting this parameter to 100 will disable the hysteresis.
 
+Some users cannot tolerate the swapping that comes with zswap store failures
+and zswap writebacks. Swapping can be disabled entirely (without disabling
+zswap itself) on a cgroup-basis as follows:
+
+	echo 1 > /sys/fs/cgroup/<cgroup-name>/memory.swap.bypass.enabled
+
 When there is a sizable amount of cold memory residing in the zswap pool, it
 can be advantageous to proactively write these cold pages to swap and reclaim
 the memory for other use cases. By default, the zswap shrinker is disabled.
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c1846e57011b..e481c5c609f2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -221,6 +221,9 @@ struct mem_cgroup {
 	unsigned long zswap_max;
 #endif
 
+	/* bypass swap (on zswap failure and writebacks) */
+	bool swap_bypass_enabled;
+
 	unsigned long soft_limit;
 
 	/* vmpressure notifications */
@@ -1157,6 +1160,13 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
 						unsigned long *total_scanned);
 
+static inline bool mem_cgroup_swap_bypass_enabled(struct mem_cgroup *memcg)
+{
+	return memcg && READ_ONCE(memcg->swap_bypass_enabled);
+}
+
+bool mem_cgroup_swap_bypass_folio(struct folio *folio);
+
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1615,6 +1625,16 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 {
 	return 0;
 }
+
+static inline bool mem_cgroup_swap_bypass_enabled(struct mem_cgroup *memcg)
+{
+	return false;
+}
+
+static inline bool mem_cgroup_swap_bypass_folio(struct folio *folio)
+{
+	return false;
+}
 #endif /* CONFIG_MEMCG */
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 568d9d037a59..f231cf2f745b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7928,6 +7928,28 @@ bool mem_cgroup_swap_full(struct folio *folio)
 	return false;
 }
 
+bool mem_cgroup_swap_bypass_folio(struct folio *folio)
+{
+	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
+	struct mem_cgroup *memcg;
+	bool ret;
+
+	if (!objcg)
+		return false;
+
+	if (mem_cgroup_disabled()) {
+		obj_cgroup_put(objcg);
+		return false;
+	}
+
+	memcg = get_mem_cgroup_from_objcg(objcg);
+	ret = mem_cgroup_swap_bypass_enabled(memcg);
+
+	mem_cgroup_put(memcg);
+	obj_cgroup_put(objcg);
+	return ret;
+}
+
 static int __init setup_swap_account(char *s)
 {
 	pr_warn_once("The swapaccount= commandline option is deprecated. "
@@ -8013,6 +8035,31 @@ static int swap_events_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int swap_bypass_enabled_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	seq_printf(m, "%d\n", READ_ONCE(memcg->swap_bypass_enabled));
+	return 0;
+}
+
+static ssize_t swap_bypass_enabled_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int swap_bypass_enabled;
+	ssize_t parse_ret = kstrtoint(strstrip(buf), 0, &swap_bypass_enabled);
+
+	if (parse_ret)
+		return parse_ret;
+
+	if (swap_bypass_enabled != 0 && swap_bypass_enabled != 1)
+		return -ERANGE;
+
+	WRITE_ONCE(memcg->swap_bypass_enabled, swap_bypass_enabled);
+	return nbytes;
+}
+
 static struct cftype swap_files[] = {
 	{
 		.name = "swap.current",
@@ -8042,6 +8089,12 @@ static struct cftype swap_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
 		.seq_show = swap_events_show,
 	},
+	{
+		.name = "swap.bypass.enabled",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_bypass_enabled_show,
+		.write = swap_bypass_enabled_write,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/mm/page_io.c b/mm/page_io.c
index cb559ae324c6..0c84e1592c39 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -201,6 +201,12 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		folio_end_writeback(folio);
 		return 0;
 	}
+
+	if (mem_cgroup_swap_bypass_folio(folio)) {
+		folio_mark_dirty(folio);
+		return AOP_WRITEPAGE_ACTIVATE;
+	}
+
 	__swap_writepage(&folio->page, wbc);
 	return 0;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index cab053831fea..6ce1d4a7a48b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1514,8 +1514,12 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 
 		mutex_unlock(&shmem_swaplist_mutex);
 		BUG_ON(folio_mapped(folio));
-		swap_writepage(&folio->page, wbc);
-		return 0;
+		/*
+		 * Seeing AOP_WRITEPAGE_ACTIVATE here indicates swapping is disabled on
+		 * zswap store failure. Note that in that case the folio is already
+		 * re-marked dirty by swap_writepage()
+		 */
+		return swap_writepage(&folio->page, wbc);
 	}
 
 	mutex_unlock(&shmem_swaplist_mutex);
diff --git a/mm/zswap.c b/mm/zswap.c
index c40697f07ba3..f19e26d647a3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -535,6 +535,9 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 	struct zswap_pool *pool = shrinker->private_data;
 	bool encountered_page_in_swapcache = false;
 
+	if (mem_cgroup_swap_bypass_enabled(sc->memcg))
+		return SHRINK_STOP;
+
 	nr_protected =
 		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
 	lru_size = list_lru_shrink_count(&pool->list_lru, sc);
@@ -565,6 +568,9 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
 	unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
 
+	if (mem_cgroup_swap_bypass_enabled(memcg))
+		return 0;
+
 #ifdef CONFIG_MEMCG_KMEM
 	cgroup_rstat_flush(memcg->css.cgroup);
 	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
@@ -890,6 +896,9 @@ static int shrink_memcg(struct mem_cgroup *memcg)
 	struct zswap_pool *pool;
 	int nid, shrunk = 0;
 
+	if (mem_cgroup_swap_bypass_enabled(memcg))
+		return -EINVAL;
+
 	/*
 	 * Skip zombies because their LRUs are reparented and we would be
 	 * reclaiming from the parent instead of the dead memcg.
-- 
2.34.1
