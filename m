Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBB27BCDB7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbjJHKAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344601AbjJHKA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:00:26 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80F4EA
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 03:00:10 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57b6a7e0deeso2172097eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=transsion-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1696759210; x=1697364010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhruBmH/7vx7sF4+aMlxk61hZnogrYd+YWcZxSg4QF4=;
        b=RnByyuJGBxkqrwDikktQwDZCsmuZV6XUty5yMyj3cFCRV3AuJ7zBanCTY52f6qblFk
         5/cfOXbZnQTPx5b/p9PGAZulcJ/p1xJdQp3iAbryUsUHngVCuQ/8bTGq4pkBFnmcxaQQ
         UHF8X4CQC+CWPDQTGDjl6G4OxMm1hKt0ajp8g9fRd82su62ckzZ872Si1Vw3B3ts4kAO
         DTbMuZvKlEu9r1i8GCTLMClBCoO43p1XOZia6iY3ODGfzs0b9WCQJ5tof/1wKp9YQtgE
         dtiw7bBHtmpPbvSp/xD7ZHgJbJxfIzWTL6OHAyesWYuYqCcW8HM/gB6Oqe9Gm9IJMZgR
         6P9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696759210; x=1697364010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhruBmH/7vx7sF4+aMlxk61hZnogrYd+YWcZxSg4QF4=;
        b=kpCrYBdcykpk6Tfdf9ql89K/DJ6biBOUE3cpmO+p7Pm0su7aKVUsZvmnp1VLGXrW+V
         N0wi7l2h9rpuqyvAv0C94RnxjQbpxuHq1iOhDvJ1AYF+vSRpQITvd5bxGSVtn5qWOHFB
         xFLV9v2hu3ozQxRZGKtxKBg0j/VIrSh5gFS62i7YDkLgRVdCHnP8YeE2JxbLGcv5xGS1
         rtRfh3nREIoQDD4d6gCYhKx2XI9Wl0XrHFRBd7ITepGMhHMUkXW6NQKJ4kiqM7PWXLOr
         hvu3nZHXzRhrKfUjj/8VhZr8vRk04xC+KTP9mAtV7RgDO35+V5uJK439hyuOzPh1wdIc
         ywiA==
X-Gm-Message-State: AOJu0Yzc6QV1gMbJ0eACbq4v8qjClt+y0lM2R0m1hR+QePciDj3lRteg
        Gw75K2anoaGgvwva0qhT2F5pLw==
X-Google-Smtp-Source: AGHT+IHtkKnrm3jMctPq5VJC/qCzlOyj5CuPQEncbsTHJCX7WO3gKj247iDJ9X2uxpVhIZ21mNbn0w==
X-Received: by 2002:a05:6870:6488:b0:1d1:39d8:da1a with SMTP id cz8-20020a056870648800b001d139d8da1amr16056418oab.15.1696759209770;
        Sun, 08 Oct 2023 03:00:09 -0700 (PDT)
Received: from linchengyang-VB.. ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090282c900b001c72c07c9d9sm7126343plz.308.2023.10.08.03.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 03:00:09 -0700 (PDT)
From:   Lincheng Yang <lincheng.yang@transsion.corp-partner.google.com>
X-Google-Original-From: Lincheng Yang <lincheng.yang@transsion.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, willy@infradead.org, hughd@google.com,
        peterx@redhat.com, mike.kravetz@oracle.com, jgg@ziepe.ca,
        surenb@google.com, steven.price@arm.com, pasha.tatashin@soleen.com,
        kirill.shutemov@linux.intel.com, yuanchu@google.com,
        david@redhat.com, mathieu.desnoyers@efficios.com,
        dhowells@redhat.com, shakeelb@google.com, pcc@google.com,
        tytso@mit.edu, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        catalin.marinas@arm.com, lrh2000@pku.edu.cn, ying.huang@intel.com,
        mhocko@suse.com, vishal.moola@gmail.com, yosryahmed@google.com,
        findns94@gmail.com, neilb@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        wanbin.wang@transsion.com, chunlei.zhuang@transsion.com,
        jinsheng.zhao@transsion.com, jiajun.ling@transsion.com,
        dongyun.liu@transsion.com,
        Lincheng Yang <lincheng.yang@transsion.com>
Subject: [RFC PATCH 4/5] mm: add page implyreclaim flag
Date:   Sun,  8 Oct 2023 17:59:23 +0800
Message-Id: <20231008095924.1165106-5-lincheng.yang@transsion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231008095924.1165106-1-lincheng.yang@transsion.com>
References: <20231008095924.1165106-1-lincheng.yang@transsion.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add implyrecalim flag means that the page is reclaim from the user advise.
If the number of restore times for these implyrecalim pages exceeds
workingset_restore_limit, it means they are frequently used and are hot
pages. Otherwise, continue to determine whether it has been restored. If
so, it means that it is frequently used also and belongs to the hot page.

Signed-off-by: Lincheng Yang <lincheng.yang@transsion.com>
---
 include/linux/mmzone.h         |  1 +
 include/linux/page-flags.h     |  3 ++
 include/trace/events/mmflags.h |  3 +-
 mm/madvise.c                   |  1 +
 mm/migrate.c                   |  2 ++
 mm/swapfile.c                  | 64 +++++++++++++++++++++++++++++++++-
 mm/vmscan.c                    |  3 ++
 7 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 5e50b78d58ea..b280e6b0015a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -626,6 +626,7 @@ struct lruvec {
 	atomic_long_t			nonresident_age;
 	/* Refaults at the time of last reclaim cycle */
 	unsigned long			refaults[ANON_AND_FILE];
+	unsigned long			restores[ANON_AND_FILE];
 	/* Various lruvec state flags (enum lruvec_flags) */
 	unsigned long			flags;
 #ifdef CONFIG_LRU_GEN
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a2c83c0100aa..4a1278851d4b 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -138,6 +138,7 @@ enum pageflags {
 #endif
 	PG_hot,
 	PG_cold,
+	PG_implyreclaim,
 	__NR_PAGEFLAGS,
 
 	PG_readahead = PG_reclaim,
@@ -482,6 +483,8 @@ PAGEFLAG(Hot, hot, PF_HEAD)
 	TESTCLEARFLAG(Hot, hot, PF_HEAD)
 PAGEFLAG(Cold, cold, PF_HEAD)
 	TESTCLEARFLAG(Cold, cold, PF_HEAD)
+PAGEFLAG(Implyreclaim, implyreclaim, PF_HEAD)
+	TESTCLEARFLAG(Implyreclaim, implyreclaim, PF_HEAD)
 __PAGEFLAG(Slab, slab, PF_NO_TAIL)
 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)	   /* Used by some filesystems */
 
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index f266f92c41c6..ee014f955aef 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -120,7 +120,8 @@
 	DEF_PAGEFLAG_NAME(swapbacked),					\
 	DEF_PAGEFLAG_NAME(unevictable),					\
 	DEF_PAGEFLAG_NAME(hot),						\
-	DEF_PAGEFLAG_NAME(cold)						\
+	DEF_PAGEFLAG_NAME(cold),					\
+	DEF_PAGEFLAG_NAME(implyreclaim)					\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_UNCACHED(uncached)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
diff --git a/mm/madvise.c b/mm/madvise.c
index a5c19bb3f392..199b48dfa8c5 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -518,6 +518,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 				} else {
 					list_add(&folio->lru, &folio_list);
 					folio_set_cold(folio);
+					folio_set_implyreclaim(folio);
 				}
 			}
 		} else
diff --git a/mm/migrate.c b/mm/migrate.c
index 9f97744bb0a8..691b4f7bf1ae 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -565,6 +565,8 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 		folio_set_hot(newfolio);
 	if (folio_test_cold(folio))
 		folio_set_cold(newfolio);
+	if (folio_test_implyreclaim(folio))
+		folio_set_implyreclaim(newfolio);
 	if (folio_test_checked(folio))
 		folio_set_checked(newfolio);
 	/*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5378f70d330d..629e6a291e9b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -105,6 +105,8 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
 
 atomic_t nr_rotate_swap = ATOMIC_INIT(0);
 
+static unsigned int workingset_restore_limit;
+
 static struct swap_info_struct *swap_type_to_swap_info(int type)
 {
 	if (type >= MAX_SWAPFILES)
@@ -120,11 +122,33 @@ static inline bool swap_info_hot(struct swap_info_struct *si)
 
 bool swap_folio_hot(struct folio *folio, bool hotness)
 {
+	struct lruvec *lruvec;
+	struct mem_cgroup *memcg;
+	unsigned long restores;
+	int delta;
+
 	if (hotness)
 		return true;
 
-	if (folio_test_swapbacked(folio) && folio_test_hot(folio))
+	if (folio_test_swapbacked(folio) && folio_test_hot(folio)) {
+		folio_clear_implyreclaim(folio);
+		return true;
+	}
+
+	rcu_read_lock(); // prevent writing from delaying reading
+	memcg = folio_memcg_rcu(folio);
+	rcu_read_unlock();
+
+	lruvec = mem_cgroup_lruvec(memcg, folio_pgdat(folio));
+	restores = lruvec_page_state(lruvec, WORKINGSET_RESTORE_ANON);
+	delta = restores - lruvec->restores[WORKINGSET_ANON];
+
+	if (folio_test_clear_implyreclaim(folio)) {
+		if (delta > workingset_restore_limit)
+			return true;
+	} else if (delta) {
 		return true;
+	}
 
 	if (folio_test_cold(folio))
 		folio_clear_cold(folio);
@@ -2715,9 +2739,47 @@ static const struct proc_ops swaps_proc_ops = {
 	.proc_poll	= swaps_poll,
 };
 
+static ssize_t workingset_restore_limit_write(struct file *file,
+					      const char __user *ubuf,
+					      size_t count, loff_t *pos)
+{
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint_from_user(ubuf, count, 10, &val);
+	if (ret)
+		return ret;
+
+	workingset_restore_limit = val;
+
+	return count;
+}
+
+static int workingset_restore_limit_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%d\n", workingset_restore_limit);
+
+	return 0;
+}
+
+static int workingset_restore_limit_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, workingset_restore_limit_show, NULL);
+}
+
+const struct proc_ops workingset_restore_limit_fops = {
+	.proc_open = workingset_restore_limit_open,
+	.proc_read = seq_read,
+	.proc_lseek = seq_lseek,
+	.proc_release = seq_release,
+	.proc_write = workingset_restore_limit_write,
+};
+
 static int __init procswaps_init(void)
 {
 	proc_create("swaps", 0, NULL, &swaps_proc_ops);
+	proc_create("workingset_restore_limit", S_IALLUGO, NULL, &workingset_restore_limit_fops);
+
 	return 0;
 }
 __initcall(procswaps_init);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 11d175d9fe0c..8107f8d86d7f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6805,6 +6805,9 @@ static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_data_t *pgdat)
 	target_lruvec->refaults[WORKINGSET_ANON] = refaults;
 	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_FILE);
 	target_lruvec->refaults[WORKINGSET_FILE] = refaults;
+
+	refaults = lruvec_page_state(target_lruvec, WORKINGSET_RESTORE_ANON);
+	target_lruvec->restores[WORKINGSET_ANON] = refaults;
 }
 
 /*
-- 
2.34.1

