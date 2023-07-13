Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9244752E13
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjGMX4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGMXz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:55:58 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6DF270D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:55:57 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b89e3715acso6097235ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689292557; x=1691884557;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aU6i2F+6ULOqe59AteyNAXfrQcm92q4cIphddyoISBg=;
        b=NF6O5MTFFdpAf7KY2vn4PEUxgePYskzv+hy9CflU7krDrWiV62rur4Y1jkafVZjbKi
         ErdZM1vLSo/v1sdXKAuV4qLVmx1uzv8nhG85y4cWKmveJxAjtZvQ8p3c5oX1D41xZejF
         DY1qsZIE8brBNjLYgJY1XEzlMAXQZw9J+Tlbabj9C9OTiNE6vkyHopgT3hqKlNEhkpSC
         zxcq/j1wg5fnra82tgd6wNYbUfXztI2rLDQlFKh2ZPfxcUBczUfsesoZ3dInTssxi6jP
         Ek1Fewjeqlv5gpyAzPQ6piCkc7hiaW+J/jhGWAO4HJ/0c4JBqnpvIHsCJqqrZ2f1qjWS
         +nnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689292557; x=1691884557;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aU6i2F+6ULOqe59AteyNAXfrQcm92q4cIphddyoISBg=;
        b=Ns43ecmo82tUKRedlQkderdPOp1HC2LbngVqbJetG5JRK+i+znHDAvO3gfAZEeNwAZ
         bdw7YrkoTuxqoxr056noTCyb2QXg/uSSIWlxkIgLoOTyA4vC4uvtZsYm+ce/4X1OR31K
         XrXRyki54KQm6L7dwoaPi4sKR8LGOKiBzpC13Gxn8BjKcXTn58MTGbFlEUzoSL2ug0EK
         l1WorrbrCJ3Cn5H5YU5BbzyRBQSWZIfI3GyOgBiPESNBDX71WAesZ0Gt1Eul5U8Cxs/z
         Ku/mFSRuNxPoMymKtu2LdkRlmykPB2oPbkvSiKmv0gbbd3wUeAo1i+PuU/YPh3TGtvXl
         jhfw==
X-Gm-Message-State: ABy/qLaqYRRmoHzNM5OtE/1jRurDKmC3G7D4ypIEcg3zCAo9zJ5pUm9C
        IaW6BQv6XMW08plwyuVMfRln0ozsXbWOJQ==
X-Google-Smtp-Source: APBJJlGgKWTVl+VINClkkV4Sy6K7FrLwMBHCEPNjB11bji1KzzILm4Qp0tGIfuzjNJrtOsHwnsm3CheIxzsfjQ==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:902:b282:b0:1ba:1704:89d1 with SMTP
 id u2-20020a170902b28200b001ba170489d1mr9970plr.10.1689292556910; Thu, 13 Jul
 2023 16:55:56 -0700 (PDT)
Date:   Thu, 13 Jul 2023 23:55:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230713235553.4121855-1-jiaqiyan@google.com>
Subject: [PATCH v1] mm/hwpoison: rename hwp_walk* to hwpoison_walk*
From:   Jiaqi Yan <jiaqiyan@google.com>
To:     naoya.horiguchi@nec.com
Cc:     linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the discussion of "Improve hugetlbfs read on HWPOISON hugepages",
Matthew Wilcox suggests hwp is a bad abbreviation of hwpoison, as hwp
is already used as "an acronym by acpi, intel_pstate, some clock
drivers, an ethernet driver, and a scsi driver"[1].

So rename hwp_walk and hwp_walk_ops to hwpoison_walk and
hwpoison_walk_ops respectively.

raw_hwp_(page|list), *_raw_hwp, and raw_hwp_unreliable flag are other
major appearances of "hwp". However, given the "raw" hint in the name,
it is easy to differentiate them from other "hwp" acronyms. Since
renaming them is not as straightforward as renaming hwp_walk*, they
are not covered by this commit.

[1] https://lore.kernel.org/lkml/20230707201904.953262-5-jiaqiyan@google.com/T/#me6fecb8ce1ad4d5769199c9e162a44bc88f7bdec

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 mm/memory-failure.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e245191e6b04..cb232e41f6c0 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -721,7 +721,7 @@ static void collect_procs(struct page *page, struct list_head *tokill,
 		collect_procs_file(page, tokill, force_early);
 }
 
-struct hwp_walk {
+struct hwpoison_walk {
 	struct to_kill tk;
 	unsigned long pfn;
 	int flags;
@@ -756,7 +756,7 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static int check_hwpoisoned_pmd_entry(pmd_t *pmdp, unsigned long addr,
-				      struct hwp_walk *hwp)
+				      struct hwpoison_walk *hwp)
 {
 	pmd_t pmd = *pmdp;
 	unsigned long pfn;
@@ -774,7 +774,7 @@ static int check_hwpoisoned_pmd_entry(pmd_t *pmdp, unsigned long addr,
 }
 #else
 static int check_hwpoisoned_pmd_entry(pmd_t *pmdp, unsigned long addr,
-				      struct hwp_walk *hwp)
+				      struct hwpoison_walk *hwp)
 {
 	return 0;
 }
@@ -783,7 +783,7 @@ static int check_hwpoisoned_pmd_entry(pmd_t *pmdp, unsigned long addr,
 static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 			      unsigned long end, struct mm_walk *walk)
 {
-	struct hwp_walk *hwp = walk->private;
+	struct hwpoison_walk *hwp = walk->private;
 	int ret = 0;
 	pte_t *ptep, *mapped_pte;
 	spinlock_t *ptl;
@@ -817,7 +817,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 			    unsigned long addr, unsigned long end,
 			    struct mm_walk *walk)
 {
-	struct hwp_walk *hwp = walk->private;
+	struct hwpoison_walk *hwp = walk->private;
 	pte_t pte = huge_ptep_get(ptep);
 	struct hstate *h = hstate_vma(walk->vma);
 
@@ -828,7 +828,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 #define hwpoison_hugetlb_range	NULL
 #endif
 
-static const struct mm_walk_ops hwp_walk_ops = {
+static const struct mm_walk_ops hwpoison_walk_ops = {
 	.pmd_entry = hwpoison_pte_range,
 	.hugetlb_entry = hwpoison_hugetlb_range,
 };
@@ -850,7 +850,7 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 				  int flags)
 {
 	int ret;
-	struct hwp_walk priv = {
+	struct hwpoison_walk priv = {
 		.pfn = pfn,
 	};
 	priv.tk.tsk = p;
@@ -859,7 +859,7 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 		return -EFAULT;
 
 	mmap_read_lock(p->mm);
-	ret = walk_page_range(p->mm, 0, TASK_SIZE, &hwp_walk_ops,
+	ret = walk_page_range(p->mm, 0, TASK_SIZE, &hwpoison_walk_ops,
 			      (void *)&priv);
 	if (ret == 1 && priv.tk.addr)
 		kill_proc(&priv.tk, pfn, flags);
-- 
2.41.0.255.g8b1d071c50-goog

