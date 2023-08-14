Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F5977BCD6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjHNPRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjHNPRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:17:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A3619BB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:16:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589db0ba2e1so38633207b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692026214; x=1692631014;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/FNoZQB0IrLaKqGcAaCCQtd/SwINEujNen6PFYywNmQ=;
        b=Syd749r+wn/31GfcBZ2X1EmM8zOBT3WHN3gRME1+GWTQKeuS/r1PTSbEnPXHTwGHwe
         6fnC4j8d1fVeqUEjKApqDPF/0xYsuJSLnk6UEBLeKjNU84fJOo9Qij8huJ/ZiRRBhPAO
         rmdzwAM+EdgClvgMsvs/I/fsVDh7o7JA5Vvtpq1gwsZjVds09RvWlssJNWOnc+s3ogCd
         xdJBuSqn95iMh+mtkpV37HzhOze6UfxJ3EqiJGh5GpMWFL/E5Fx/dD6eQpKlwfBTu+d3
         uqbpDpJZHSBkqaADM23Swa5RWpd4ZoY3kiCu1eZUQetrUSaLIpoaHPvU7sEFqDSFXAj+
         cflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692026214; x=1692631014;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FNoZQB0IrLaKqGcAaCCQtd/SwINEujNen6PFYywNmQ=;
        b=OtRmKoiOAcACfh9Y27Ri1IYnkh4vPpUp6kBJU5nvXuzGnTDAiNqqxrNBQZlT0mZWeP
         odj7gfZDqAFe51oyw4ELPXyee87MNtilqzwSKeKAcN5dQgW9RjzZunHxiJW3AVI257Qt
         vUO1jAWE1teJ8fKt5DHc9SzWLMvNwXcvkJf0xjZHnux/Znglgq6ZWcTcyVQ5qbjfMifR
         jKw0h2OI2nzpEJPZYbBKj46/qsk0S5oUMu4gAtRKTSOj1TD7cB7T0hXLDX3jwiKCiRUz
         58xb/qYsLiX0d6Mgjj/f5mTXlxQygwj0Bvr4xFa6/kHW7iQYcnEpuxRCzHbF+I+E011P
         PZCw==
X-Gm-Message-State: AOJu0YxSUKNRRO2yYODQDWJNgwqtTjmsUO5VsdpsHpA6jFV2jsU52EAr
        DHul6c/tAPZffF110POc1QEZoR3ffYMUcAQ0YHbdBNHhhWb6aNdcqL37tQV3WB56pCJY92romts
        kXo4Rflmp0pT1eiZbw7QymTkZiXhNkfuX5cyosK2N4P74vPl4ZM/AE1qIoovVZIAWqryPvEFo06
        AWNw==
X-Google-Smtp-Source: AGHT+IGNjXXgrbDzHO8XmjU8hvNW3ac8in3D1QL3hTJWGpwZ0u3oHyq6TITxY7sjk641/7DG+3aOn6ThNsHUDiw=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a05:690c:300f:b0:589:6c60:f4a0 with SMTP
 id ey15-20020a05690c300f00b005896c60f4a0mr240385ywb.0.1692026214561; Mon, 14
 Aug 2023 08:16:54 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:16:36 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230814151636.1639123-1-tjmercier@google.com>
Subject: [PATCH mm-unstable] mm: multi-gen LRU: don't spin during memcg release
From:   "T.J. Mercier" <tjmercier@google.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     android-mm@google.com, "T.J. Mercier" <tjmercier@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a memcg is in the process of being released mem_cgroup_tryget will
fail because its reference count has already reached 0. This can happen
during reclaim if the memcg has already been offlined, and we reclaim
all remaining pages attributed to the offlined memcg. shrink_many
attempts to skip the empty memcg in this case, and continue reclaiming
from the remaining memcgs in the old generation. If there is only one
memcg remaining, or if all remaining memcgs are in the process of being
released then shrink_many will spin until all memcgs have finished
being released. The release occurs through a workqueue, so it can take
a while before kswapd is able to make any further progress.

This fix results in reductions in kswapd activity and direct reclaim in
a test where 28 apps (working set size > total memory) are repeatedly
launched in a random sequence:

                                       A          B      delta   ratio(%)
           allocstall_movable       5962       3539      -2423     -40.64
            allocstall_normal       2661       2417       -244      -9.17
kswapd_high_wmark_hit_quickly      53152       7594     -45558     -85.71
                   pageoutrun      57365      11750     -45615     -79.52

Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Cc: stable@vger.kernel.org
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 mm/vmscan.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 157ed68470ee..c7c149cb8d66 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4856,16 +4856,17 @@ void lru_gen_release_memcg(struct mem_cgroup *memcg)
 
 		spin_lock_irq(&pgdat->memcg_lru.lock);
 
-		VM_WARN_ON_ONCE(hlist_nulls_unhashed(&lruvec->lrugen.list));
+		if (hlist_nulls_unhashed(&lruvec->lrugen.list))
+			goto unlock;
 
 		gen = lruvec->lrugen.gen;
 
-		hlist_nulls_del_rcu(&lruvec->lrugen.list);
+		hlist_nulls_del_init_rcu(&lruvec->lrugen.list);
 		pgdat->memcg_lru.nr_memcgs[gen]--;
 
 		if (!pgdat->memcg_lru.nr_memcgs[gen] && gen == get_memcg_gen(pgdat->memcg_lru.seq))
 			WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
-
+unlock:
 		spin_unlock_irq(&pgdat->memcg_lru.lock);
 	}
 }
@@ -5447,8 +5448,10 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 	rcu_read_lock();
 
 	hlist_nulls_for_each_entry_rcu(lrugen, pos, &pgdat->memcg_lru.fifo[gen][bin], list) {
-		if (op)
+		if (op) {
 			lru_gen_rotate_memcg(lruvec, op);
+			op = 0;
+		}
 
 		mem_cgroup_put(memcg);
 
@@ -5456,7 +5459,7 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 		memcg = lruvec_memcg(lruvec);
 
 		if (!mem_cgroup_tryget(memcg)) {
-			op = 0;
+			lru_gen_release_memcg(memcg);
 			memcg = NULL;
 			continue;
 		}
-- 
2.41.0.640.ga95def55d0-goog

