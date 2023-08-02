Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A065E76C330
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjHBC4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjHBC4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:56:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F72722
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:56:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c647150c254so860889276.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 19:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690944980; x=1691549780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6cxPzKelBRogs1RcqlDIpKMeY4RfiCOB4MpGgBN/Dg=;
        b=Jrr8nzKXxGfH9rZ05coei/Z5XkXPQKYffsRvq0JJPMkpPWKSPML6OO06eZDIof3ZxE
         FqR3adURv8HbiY0CSWCrzORDmomvxAk0WLRY9cf18uCIkdSyJjl/VvbdCY4q9Wy7Oc4w
         +pskRXdmBEFfcC42q/5pqN3PxM0TzWr4gK4sE9xc5wu50UZc34qQkFTahmwhRGZJVytQ
         iQt96NsYT5jF6oFb+S9xqxKcAjWxbIwls+nZQCaZUiFG50rjkxYUVoWP/KSzWH+XfZJr
         RVj4ctwi+migEpHkjEJI3k5GUHjwOtKhv4c0gSFmtgVSST9QuZmYcyIVrwx+qWlaHlyG
         UnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690944980; x=1691549780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6cxPzKelBRogs1RcqlDIpKMeY4RfiCOB4MpGgBN/Dg=;
        b=j/KJZ08S87CF+Dv2lgQEYpr+HMV+cNmAv/rvlp6o1j2v75ssqlBWRXwPYbQrJfmzZM
         yIVWOcPPBbhfqHCyTX1qayu2NYVL8e69bSMqzL2Lxt/svAvlPcMWlOVnpE5X0lH+Ujps
         nKjYlE+Xan7r2En5HUkiHB+1PJtz5o+eLdXqpeHPE/1JNrzr+u5d3l9OQDIilS1vphwp
         6nCMnaaouUvkQRf6/tiqqbzv2pNBNhqZGeGzN/Lqpza1iLfTSt3dY8uS4vF7HDw0gFK/
         ZK5aDCjSLbxOeuzlPjkLOcfgaABJZ3uADuMLxfpX4vbRR2Bji5zEH5Ih6/SwyEFrugpU
         vWuA==
X-Gm-Message-State: ABy/qLZINZXh4okmW1tXYkmTxGalIe27BzBI7+FIwNMBCPN5kyYfRYg5
        JocX0pzp74XJ7lyM7Mfxw1hp4NwCVuOB7PYV5Q==
X-Google-Smtp-Source: APBJJlHvG4mc4jsYVOJYfZ7h42Tv/EwdyD/HOeVXUVvtcmr8y48s75g7rEDYvVAnOWGuPl5UYIq68sSDD86PJyMPYA==
X-Received: from kalesh.mtv.corp.google.com ([2620:15c:211:201:aa5f:ff75:318:255])
 (user=kaleshsingh job=sendgmr) by 2002:a25:b084:0:b0:bd5:dc2d:9d7f with SMTP
 id f4-20020a25b084000000b00bd5dc2d9d7fmr167401ybj.4.1690944980290; Tue, 01
 Aug 2023 19:56:20 -0700 (PDT)
Date:   Tue,  1 Aug 2023 19:56:03 -0700
In-Reply-To: <20230802025606.346758-1-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20230802025606.346758-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230802025606.346758-2-kaleshsingh@google.com>
Subject: [PATCH v2 2/3] mm-unstable: Multi-gen LRU: Avoid race in inc_min_seq()
From:   Kalesh Singh <kaleshsingh@google.com>
To:     yuzhao@google.com, akpm@linux-foundation.org
Cc:     surenb@google.com, android-mm@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Brian Geffon <bgeffon@google.com>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inc_max_seq() will try to inc_min_seq() if nr_gens == MAX_NR_GENS. This
is because the generations are reused (the last oldest now empty
generation will become the next youngest generation).

inc_min_seq() is retried until successful, dropping the lru_lock
and yielding the CPU on each failure, and retaking the lock before
trying again:

        while (!inc_min_seq(lruvec, type, can_swap)) {
                spin_unlock_irq(&lruvec->lru_lock);
                cond_resched();
                spin_lock_irq(&lruvec->lru_lock);
        }

However, the initial condition that required incrementing the min_seq
(nr_gens == MAX_NR_GENS) is not retested. This can change by another
call to inc_max_seq() from run_aging() with force_scan=true from the
debugfs interface.

Since the eviction stalls when the nr_gens == MIN_NR_GENS, avoid
unnecessarily incrementing the min_seq by rechecking the number of
generations before each attempt.

This issue was uncovered in previous discussion on the list by Yu Zhao
and Aneesh Kumar [1].

[1] https://lore.kernel.org/linux-mm/CAOUHufbO7CaVm=xjEb1avDhHVvnC8pJmGyKcFf2iY_dpf+zR3w@mail.gmail.com/

Fixes: d6c3af7d8a2b ("mm: multi-gen LRU: debugfs interface")
Cc: stable@vger.kernel.org
Cc: Yu Zhao <yuzhao@google.com>
Cc: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - Add Fixes tag and cc stable

 mm/vmscan.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 489a4fc7d9b1..6eecd291756c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4439,7 +4439,7 @@ static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_scan)
 	int prev, next;
 	int type, zone;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
-
+restart:
 	spin_lock_irq(&lruvec->lru_lock);
 
 	VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
@@ -4450,11 +4450,12 @@ static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_scan)
 
 		VM_WARN_ON_ONCE(!force_scan && (type == LRU_GEN_FILE || can_swap));
 
-		while (!inc_min_seq(lruvec, type, can_swap)) {
-			spin_unlock_irq(&lruvec->lru_lock);
-			cond_resched();
-			spin_lock_irq(&lruvec->lru_lock);
-		}
+		if (inc_min_seq(lruvec, type, can_swap))
+			continue;
+
+		spin_unlock_irq(&lruvec->lru_lock);
+		cond_resched();
+		goto restart;
 	}
 
 	/*
-- 
2.41.0.255.g8b1d071c50-goog

