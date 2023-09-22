Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250A57AA7E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjIVEgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjIVEge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:36:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D852E18F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:36:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8571d5e71aso2203978276.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 21:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695357388; x=1695962188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FFCV0sch6yU/8LYuNDFjRf1SrTydnK4Yn1LXrMsCSk4=;
        b=yXERfMhY4eBgTkKkc75ZyeMIdpnGWdA75CrRE8zXbbt+Q7Xl0wlfNNATH2T4OfOpS7
         w2t+T59imlmUC77GplKSx09TzP96vffUY54q2b90PsA0CvBJWBNNeCKa3lQgk9Pf4End
         8OpP5yi1mYxQ6x41+89Kje2Ayg8xZ9sQZQNIhi0jdt6+tZdBOmkdbxXPWZdu0gdw8A0Z
         nW1keo/5k1zZM215s8/vzUmQU4EPj845jfAUZgC3o8c6Y/YDd9xXgLECz1UKbTX6/E8Y
         olcj83NMpKeA1llx9vAjD/L1up2+O8O8asL+gDhEhU92T/mFB5RlzzXmetqx/BVoyteI
         /n/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695357388; x=1695962188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFCV0sch6yU/8LYuNDFjRf1SrTydnK4Yn1LXrMsCSk4=;
        b=RoSOpqbEUqRdBDuvMBxUDQFVo+dhsQV/yVGTdM8pK46k14DbQ2OcObwR9jdE3aMfdh
         vKR+QmxtA5QY+zVcYXSGjD1gI/nJtk15rzOw4GeyFhH6As1KqWMjRfHD9HBxQOnsOIkN
         VYuj5qzhNkVkLRcHMk/9pWoaLdWv0IfDAPxDdjP4CFM1hVI5PrdsaopZVlvULjBNEe5I
         mF23RVdPlrabhG6c6QHvC5UMGEWazS66sJRM7LojvwyISfDv4PDXOiRIT2L8KTDmI38V
         hQ2SQvB+1DMu7XiA12+FbMlFduOyoyCugJ/nxqHwhuiSAfqlHkdSCpkwNEJTHIyQXbcv
         9Xhg==
X-Gm-Message-State: AOJu0YxSd60EeYZ7Hkpt+dhP0oHXAaF5tupubSKL61GMgOS9SPLpO0AH
        j/0CGbm2jCw+AMtsr6fMN2vaAfUXeS/WjRAVLpbyHjIMKQL1thJZEIzeITK+5PfNpSzL67vkevV
        0OE05q1gC1IwKLgwAZYUlqMv5pXeBZa2W23bUsRlLw30QCpzzvKXBhOODZDVCG+w/O1ZXZuI=
X-Google-Smtp-Source: AGHT+IHV7SMIXl/z2ZcUCI9wh8uElpYjP827jcLFnNhWQLUNorHifjF1jTcRD63C6a9rfv1vjhH5LttK/Cqh
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:4081:0:b0:d10:5b67:843c with SMTP id
 n123-20020a254081000000b00d105b67843cmr96648yba.4.1695357387716; Thu, 21 Sep
 2023 21:36:27 -0700 (PDT)
Date:   Fri, 22 Sep 2023 04:36:00 +0000
In-Reply-To: <20230922043616.19282-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230922043616.19282-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922043616.19282-3-jstultz@google.com>
Subject: [PATCH 2/3] test-ww_mutex: Fix potential workqueue corruption
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
2.42.0.515.g380fc7ccd1-goog

