Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551C2774611
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjHHSwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbjHHSwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:52:21 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8511A768
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:06:11 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-76c939bc1adso863973385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514368; x=1692119168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ymit3zFEWIjWyELyB8FrEwDrQYWKERmL2cdBLLRpncg=;
        b=uATKww8C8iuNmq5K/nNL2TZ1RoKZ2lf8Udwev/WUIv+xt73/VYFR7POfB9NqlYawLr
         fFjA7oonJ6O/CzAycnXQorpgkf7Sutqk3c1VJEZAPvFn7RGHVCDUIy3KxapCP4pMnKjw
         sBT+s42fYb11lQ8DUlSiilqdqmfIvXov5RSHEy+SSPWvtnoJdFMAuTAn1CPv4W0FWtSF
         glExNj6G1w4VUcFmXoy1ehLeYERic5ZTAv3lGfouaSuy8Ob2jWj+vP0jpiOVh/IMNmWp
         kKCbrPWhrd6peQiKunvaTjhH45uA43v5uGjHOS9M55k7o1+nisGXvfbTy3ec5hx+jbCF
         KjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514368; x=1692119168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ymit3zFEWIjWyELyB8FrEwDrQYWKERmL2cdBLLRpncg=;
        b=hl4KiGysQHS50OdYGLbS+Wdb28M/PB8tJCbE+pwZCbC1SYfAUF6Adi/T5JyVcGOXRL
         ZOVqHMPgenzV/FyTJxMjV8yztxvUK3QwSD8hw4P24JE84pqk6HhxbGyQ6wrzejFRxkdT
         0KYquB7UEPssY0E4ph78BtRVatBanRZgB8CX7N6KNuQ+gxW+5eMh8nIDUgRyyM67QIrF
         ABD/qNw2xlN1fJ8xw6Yh9+qUIYQPMaXY1WcKQ7xz96OtxzBGP0/0a5pihRPNaV8oaVzE
         paB2ipw+MQ8QdVhTacyzd2uGhX4dWtwL3Ks4ZykaTvjuRNMzFNmshjIpeSjUnMEPq2Vf
         oz4A==
X-Gm-Message-State: AOJu0YyFcELR/hcwb9dxw41R6wL7mYFFX6U4ESOMXd+jXnGY8FYMtMZq
        lECDUox1qv6Wwf341zaX9jynZLPGEJFVvdaygkHcV3TuyVivHrDyTys9mNODpAwHdhWU17Zzxei
        Nyyq3uoimtovn5Bhh0qQRN9E3/dC4sf4GSgNv1O2nhGJvgW8pV5NuVatp76INGw6LXJn7obc=
X-Google-Smtp-Source: AGHT+IFtBEywd6rcRcrgJzjs0aS0ORYXNdltbuVrMFXOFw9bGdzgPs2KuGt4qxEZ/wllTfZha/bqiOJNj34Z
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:3ecf:0:b0:564:3087:dd22 with SMTP id
 l198-20020a633ecf000000b005643087dd22mr50812pga.9.1691476025927; Mon, 07 Aug
 2023 23:27:05 -0700 (PDT)
Date:   Tue,  8 Aug 2023 06:26:42 +0000
In-Reply-To: <20230808062658.391595-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230808062658.391595-1-jstultz@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230808062658.391595-3-jstultz@google.com>
Subject: [RFC][PATCH 2/3] test-ww_mutex: Fix potential workqueue corruption
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Li Zhijian <zhijianx.li@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases running with the test-ww_mutex code, I was seeing
odd behavior where sometimes it seemed flush_workqueue was
returning before all the work threads were finished.

Often this would cause strange crashes as the mutexes would be
freed while they were being used.

Looking at the code, there is a lifetime problem as the
controlling thread that spawns the work allocates the
"struct stress" structures that are passed to the workqueue
threads. Then when the workqueue threads are finished,
they free the stress struct that was passed to them.

Unfortunately the workqueue work_struct node is in the stress
struct. Which means the work_struct is freed before the work
thread returns and while flush_workqueue is waiting.

It seems like a better idea to have the controlling thread
both allocate and free the stress structures, so that we can
be sure we don't corrupt the workqueue by freeing the structure
prematurely.

So this patch reworks the test to do so, and with this change
I no longer see the early flush_workqueue returns.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Li Zhijian <zhijianx.li@intel.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/test-ww_mutex.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 9bceba65858a..358d66150426 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -479,7 +479,6 @@ static void stress_inorder_work(struct work_struct *work)
 	} while (!time_after(jiffies, stress->timeout));
 
 	kfree(order);
-	kfree(stress);
 }
 
 struct reorder_lock {
@@ -544,7 +543,6 @@ static void stress_reorder_work(struct work_struct *work)
 	list_for_each_entry_safe(ll, ln, &locks, link)
 		kfree(ll);
 	kfree(order);
-	kfree(stress);
 }
 
 static void stress_one_work(struct work_struct *work)
@@ -565,8 +563,6 @@ static void stress_one_work(struct work_struct *work)
 			break;
 		}
 	} while (!time_after(jiffies, stress->timeout));
-
-	kfree(stress);
 }
 
 #define STRESS_INORDER BIT(0)
@@ -577,15 +573,24 @@ static void stress_one_work(struct work_struct *work)
 static int stress(int nlocks, int nthreads, unsigned int flags)
 {
 	struct ww_mutex *locks;
-	int n;
+	struct stress *stress_array;
+	int n, count;
 
 	locks = kmalloc_array(nlocks, sizeof(*locks), GFP_KERNEL);
 	if (!locks)
 		return -ENOMEM;
 
+	stress_array = kmalloc_array(nthreads, sizeof(*stress_array),
+				     GFP_KERNEL);
+	if (!stress_array) {
+		kfree(locks);
+		return -ENOMEM;
+	}
+
 	for (n = 0; n < nlocks; n++)
 		ww_mutex_init(&locks[n], &ww_class);
 
+	count = 0;
 	for (n = 0; nthreads; n++) {
 		struct stress *stress;
 		void (*fn)(struct work_struct *work);
@@ -609,9 +614,7 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 		if (!fn)
 			continue;
 
-		stress = kmalloc(sizeof(*stress), GFP_KERNEL);
-		if (!stress)
-			break;
+		stress = &stress_array[count++];
 
 		INIT_WORK(&stress->work, fn);
 		stress->locks = locks;
@@ -626,6 +629,7 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 
 	for (n = 0; n < nlocks; n++)
 		ww_mutex_destroy(&locks[n]);
+	kfree(stress_array);
 	kfree(locks);
 
 	return 0;
-- 
2.41.0.640.ga95def55d0-goog

