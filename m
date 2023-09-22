Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F217AA7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjIVEgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjIVEgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:36:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D121F1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:36:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b59e1ac70so25832257b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695357386; x=1695962186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJjrcHsRRDC/E8xCadhRO+d676g6LTNm1iG8XOf+yCU=;
        b=b0+pcqOcSGJgZ09DIgxP+JFc0LwSIrGZAmmYspKWWLAczPZKPX3RdfBWJcNGtSD2PC
         g5vnSNg64BWR+A4DEWSK6TBnyCNxBseldG3jCLIWITJ4T9lH7AAp+AMBDpwbQsk7ANg6
         oL4laPY3CSQigHEXdpNCuB+pzdKLcpCkgqD2Jf/u+YjmUhgItHCwckebkwXdOMexDNDr
         POldY2mxLNqBwOoMog2SsEhj3zA9vrQko0/NfRcZss1dApIx6lmapS0TVsOEXNAcH9SB
         OeMqFiIiZPcVJLpDlb3vGw2BNLpQweXLl2QpivB4gFpuWSno1/hITXyovkLWYfX82nIt
         W2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695357386; x=1695962186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJjrcHsRRDC/E8xCadhRO+d676g6LTNm1iG8XOf+yCU=;
        b=ZNAnVR4jOHach/DLtkvMXnH9tYiuSE0nn/C3JfTkNNZhHTekFNhGY9YcAEg0DA9Drb
         Ea2HxXJeV4TLZfJHx1drsROxNobA9B8pc+bSnjTh2pUCwOuOc+ViKRFVvNryk7+nT6Em
         alOW/qJGeIUXgc5p1hg/7vjPbJPe00azEqqVpT7Ln3W/fmbV1SjCp4NEXj6ae4zf36sZ
         FgWrVHj4/DThWRLr2qwD51rwBLOfJCE9ImxVXCbGQQL+tmpoRdRDZC0QFZFtEyR4FZgu
         MzSNRVf6TOQssr6u+lXkEIkL++hnPdBPJp5wJfP5/UP9+wbEH5Ozm9L/osiCHicBByfO
         VLBA==
X-Gm-Message-State: AOJu0Yy0QS+1a8f/sIPwo1YUWK2MaKco+OITG+E1mZFjhKrxAC1jknND
        UI1MdzWTTSAm397yVhZcEVPaPMTaJSGXS5gRoO21Y9dRuucwsqH9MBZZRlS2DZ0Rv3agi6K6ZoE
        +66hvDkjgnBDu76gegZyZ3YsksZgk+c7Bf8CzUztIRJCUtFUBabqajJQF2/u+8ZiYp8LBAIk=
X-Google-Smtp-Source: AGHT+IFNOkIsULGPsfSNQHS7oQY8u5wdhSTdRmt2j5wpIX+plt9ZpRiCueKYzeAursc8A2FvuZN6V53qxjOo
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:ca16:0:b0:d81:8e4d:b681 with SMTP id
 a22-20020a25ca16000000b00d818e4db681mr94662ybg.12.1695357385708; Thu, 21 Sep
 2023 21:36:25 -0700 (PDT)
Date:   Fri, 22 Sep 2023 04:35:59 +0000
In-Reply-To: <20230922043616.19282-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230922043616.19282-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922043616.19282-2-jstultz@google.com>
Subject: [PATCH 1/3] test-ww_mutex: Use prng instead of rng to avoid hangs at bootup
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting w/ qemu without kvm, and with 64 cpus, I noticed we'd
sometimes hung task watchdog splats in get_random_u32_below()
when using the test-ww_mutex stress test.

While entropy exhaustion is no longer an issue, the RNG may be
slower early in boot. The test-ww_mutex code will spawn off
128 threads (2x cpus) and each thread will call
get_random_u32_below() a number of times to generate a random
order of the 16 locks.

This intense use takes time and without kvm, qemu can be slow
enough that we trip the hung task watchdogs.

For this test, we don't need true randomness, just mixed up
orders for testing ww_mutex lock acquisitions, so it changes
the logic to use the prng instead, which takes less time
and avoids the watchdgos.

Feedback would be appreciated!

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/test-ww_mutex.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 93cca6e69860..9bceba65858a 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -9,7 +9,7 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <linux/ww_mutex.h>
 
@@ -386,6 +386,19 @@ struct stress {
 	int nlocks;
 };
 
+struct rnd_state rng;
+DEFINE_SPINLOCK(rng_lock);
+
+static inline u32 prandom_u32_below(u32 ceil)
+{
+	u32 ret;
+
+	spin_lock(&rng_lock);
+	ret = prandom_u32_state(&rng) % ceil;
+	spin_unlock(&rng_lock);
+	return ret;
+}
+
 static int *get_random_order(int count)
 {
 	int *order;
@@ -399,7 +412,7 @@ static int *get_random_order(int count)
 		order[n] = n;
 
 	for (n = count - 1; n > 1; n--) {
-		r = get_random_u32_below(n + 1);
+		r = prandom_u32_below(n + 1);
 		if (r != n) {
 			tmp = order[n];
 			order[n] = order[r];
@@ -625,6 +638,8 @@ static int __init test_ww_mutex_init(void)
 
 	printk(KERN_INFO "Beginning ww mutex selftests\n");
 
+	prandom_seed_state(&rng, get_random_u64());
+
 	wq = alloc_workqueue("test-ww_mutex", WQ_UNBOUND, 0);
 	if (!wq)
 		return -ENOMEM;
-- 
2.42.0.515.g380fc7ccd1-goog

