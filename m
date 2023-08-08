Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB38774549
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjHHSkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjHHSjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:39:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966A014E747
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:04:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5897d05e878so7609027b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514263; x=1692119063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Pj22MKmr8XIhh1K0aihl/wpxs9R/qGJHCHsUaf0qEA=;
        b=s0xWzXU70VZY4/sag/71nAGjSBw0VTsldkRXrQv6hNF6rmShd40JQtJnRdQyZ+iqTK
         5KBQnevbciD9hRputkVCUki0nuPPo4YuQTp9SNDBBj+h3SW0+ck2qUTTiLIzA/wkNxvI
         cV27wWiHSGKysqfzCqw0NyAIKFMx5eNV1ALBXhVGzL6BXLdu5Zw1zDJeXqHrdxizGWSK
         qBqsnCIZn1yJYMDNyqqnMwg2RLRE2tUousQzZENCNcI/5HzaxlTYgjrN8ZCGr7mXQBXv
         8xw+9R2b353EPTq7m6N0FNmy65uljEbsKpFSHBeTpHnlHUNjJaOGLe/rR6dT+yEB71Br
         BBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514263; x=1692119063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Pj22MKmr8XIhh1K0aihl/wpxs9R/qGJHCHsUaf0qEA=;
        b=bvsCN8+ZXGxcO/QkYZs3phxJA6p1IYz50mWqRr43Mqk7QDkqrDSNdRIz6/F9SMKw/N
         V6X1bjUt0C7B8n0mog0hbHvoxQYJl/tEkDQyOr0DYYjhgSwesTPdlnxct7SjpvGu0Ey6
         CkXCrHEGQPZwltuSeL+nKWNOENU31IcP8Wamow3gTF1MGIFkNzhPJFpKVWMMfR3inQDD
         R2FJjoImCX93dqJrjYU5/B9IpqJv/mw57NoFBZbtxK5wWP7Onc4FK5aZL1n+lNbuSnYU
         4h9lv4olWH/sb56n0KbWDKgsCnXYPRRKNLJI+0+/Nwp7k0g0lruFSlmILhA9lL4L5uJp
         tXvQ==
X-Gm-Message-State: AOJu0YwcCKkrR7YU/PNXsFkPSE99CA4CZxvZQUUgHNd3Jt9SvP9+r/yU
        r7eQAPe7iaBT/DBFIXz2HMIZqXsKsgOKC6QdW8EjHwbQ83xWklcIAyt/3wreZuHjL2epw9jba4u
        55FV/uvE8+zN7c/7XjRf10Bc0Dr7mIhDco13G5omxW9F6dKU61ExuJ2q9uCpHP9QCl+Spq0U=
X-Google-Smtp-Source: AGHT+IHqx2QI+7pJSjzr9uHQXPaw5pVfN0pf1+WRluhAo+loAGS0f/4XjbvkD6Leg6ztTpG/cWZBXZsgpUxj
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:770c:0:b0:551:eb6:1ea6 with SMTP id
 s12-20020a63770c000000b005510eb61ea6mr48746pgc.10.1691476027531; Mon, 07 Aug
 2023 23:27:07 -0700 (PDT)
Date:   Tue,  8 Aug 2023 06:26:43 +0000
In-Reply-To: <20230808062658.391595-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230808062658.391595-1-jstultz@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230808062658.391595-4-jstultz@google.com>
Subject: [RFC][PATCH 3/3] test-ww_mutex: Make sure we bail out instead of livelock
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen what appears to be livelocks in the stress_inorder_work()
function, and looking at the code it is clear we can have a case
where we continually retry acquiring the locks and never check to
see if we have passed the specified timeout.

This patch reworks that function so we always check the timeout
before iterating through the loop again.

I believe others may have hit this previously here:
https://lore.kernel.org/lkml/895ef450-4fb3-5d29-a6ad-790657106a5a@intel.com/

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
Reported-by: Li Zhijian <zhijianx.li@intel.com>
Link: https://lore.kernel.org/lkml/895ef450-4fb3-5d29-a6ad-790657106a5a@intel.com/
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/test-ww_mutex.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 358d66150426..78719e1ef1b1 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -465,17 +465,18 @@ static void stress_inorder_work(struct work_struct *work)
 			ww_mutex_unlock(&locks[order[n]]);
 
 		if (err == -EDEADLK) {
-			ww_mutex_lock_slow(&locks[order[contended]], &ctx);
-			goto retry;
+			if (!time_after(jiffies, stress->timeout)) {
+				ww_mutex_lock_slow(&locks[order[contended]], &ctx);
+				goto retry;
+			}
 		}
 
+		ww_acquire_fini(&ctx);
 		if (err) {
 			pr_err_once("stress (%s) failed with %d\n",
 				    __func__, err);
 			break;
 		}
-
-		ww_acquire_fini(&ctx);
 	} while (!time_after(jiffies, stress->timeout));
 
 	kfree(order);
-- 
2.41.0.640.ga95def55d0-goog

