Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21D7FFD14
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376391AbjK3Usa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjK3Usa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:48:30 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005C2D40
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:48:34 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso1295e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701377313; x=1701982113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lDbR5wn/ymhzANEbstkor6jRTtY0ksRtmkAGEgVn3ME=;
        b=c68nmUyn7+GdxK0l9ja1a0VcOWtqcXOOGjajdIyD6+8k0y0R4Au3jI6lvPrQzmZyJN
         2PkvNbIRZCddExGR53DD36OXokzDkVXErQ+FBTKB6RY1Fx8Sciw85Wov/ssJbyDlPUQX
         wvmK+GYxpc343e/HeTKnQqlPslSAXrZYxxvG3E7rFxjMo5dOWh4emMvPXVOF9VSgeafJ
         55TT8smWaxH/e3bg8/oNBF9e2z13IgauuQR73DiNJe8SzrHLah5EbKWBO1GqDA0g9OB9
         RBE4syT1eo9KbhesACFq1vBiXm1AX7PhChy8PYKzKeoW8xTfMiv14wgpncY4V0wmNU0K
         0Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377313; x=1701982113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDbR5wn/ymhzANEbstkor6jRTtY0ksRtmkAGEgVn3ME=;
        b=HXtqozH+peffivRgJzstD/rwYpUpAQUuKpUkylOCtEdjZWE+jBDf4iYNb22pmWJx1C
         ohshcxqryrvMunUzXNI7LRmFqS0mxkrRaSbd0OqVb+PQXrVFzIAV/KnjKwyj5PIuMhus
         rDW9YmRIcfYoOWM2vhpVKBEq3Tsiw5TwsEJ8kXjV+ANlJHvdTZ78mgKsDMJIJz7P0lbV
         9uOrFgGWoQJhd19yu4GaS4Cxnk7BnpMMhySo24arYxbEUwGGKVDD+iytij6YCq7+zaFD
         uZGykxtWIbT26Gu0nUldcGSWZY1VGNHJu6EjLRA3YkSPvcVvs+x5eWn87pwgqKSV1v8U
         vrKQ==
X-Gm-Message-State: AOJu0YxF+w7jHLf8j9ImyaotiXpqzSmwD8vOGL9vkOW+TeqbfdvaChIJ
        lDyipfuNfM6EHHs97K+GWIi+vQ==
X-Google-Smtp-Source: AGHT+IEWEtiVFKWOO64KC6IV7yjdz4Ob7/rD3TYHW6b0lUwhNd8FJc+db/wlIt7p6MnnQ9/yGFkmqA==
X-Received: by 2002:a1c:7202:0:b0:40b:4355:a04b with SMTP id n2-20020a1c7202000000b0040b4355a04bmr15152wmc.6.1701377313270;
        Thu, 30 Nov 2023 12:48:33 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:9869:5af3:4653:dd50])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b0040b347d90d0sm6680258wmq.12.2023.11.30.12.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:48:32 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] locking: Document that mutex_unlock() is non-atomic
Date:   Thu, 30 Nov 2023 21:48:17 +0100
Message-ID: <20231130204817.2031407-1-jannh@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen several cases of attempts to use mutex_unlock() to release an
object such that the object can then be freed by another task.
My understanding is that this is not safe because mutex_unlock(), in the
MUTEX_FLAG_WAITERS && !MUTEX_FLAG_HANDOFF case, accesses the mutex
structure after having marked it as unlocked; so mutex_unlock() requires
its caller to ensure that the mutex stays alive until mutex_unlock()
returns.

If MUTEX_FLAG_WAITERS is set and there are real waiters, those waiters
have to keep the mutex alive, I think; but we could have a spurious
MUTEX_FLAG_WAITERS left if an interruptible/killable waiter bailed
between the points where __mutex_unlock_slowpath() did the cmpxchg
reading the flags and where it acquired the wait_lock.

(With spinlocks, that kind of code pattern is allowed and, from what I
remember, used in several places in the kernel.)

If my understanding of this is correct, we should probably document this -
I think such a semantic difference between mutexes and spinlocks is fairly
unintuitive.

Signed-off-by: Jann Horn <jannh@google.com>
---
I hope for some thorough review on this patch to make sure the comments
I'm adding are actually true, and to confirm that mutexes intentionally
do not support this usage pattern.

 Documentation/locking/mutex-design.rst | 6 ++++++
 kernel/locking/mutex.c                 | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locking/mutex-design.rst
index 78540cd7f54b..087716bfa7b2 100644
--- a/Documentation/locking/mutex-design.rst
+++ b/Documentation/locking/mutex-design.rst
@@ -101,6 +101,12 @@ features that make lock debugging easier and faster:
     - Detects multi-task circular deadlocks and prints out all affected
       locks and tasks (and only those tasks).
 
+Releasing a mutex is not an atomic operation: Once a mutex release operation
+has begun, another context may be able to acquire the mutex before the release
+operation has completed. The mutex user must ensure that the mutex is not
+destroyed while a release operation is still in progress - in other words,
+callers of 'mutex_unlock' must ensure that the mutex stays alive until
+'mutex_unlock' has returned.
 
 Interfaces
 ----------
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2deeeca3e71b..4c6b83bab643 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -532,6 +532,11 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
  * This function must not be used in interrupt context. Unlocking
  * of a not locked mutex is not allowed.
  *
+ * The caller must ensure that the mutex stays alive until this function has
+ * returned - mutex_unlock() can NOT directly be used to release an object such
+ * that another concurrent task can free it.
+ * Mutexes are different from spinlocks in this aspect.
+ *
  * This function is similar to (but not equivalent to) up().
  */
 void __sched mutex_unlock(struct mutex *lock)

base-commit: 3b47bc037bd44f142ac09848e8d3ecccc726be99
-- 
2.43.0.rc2.451.g8631bc7472-goog

