Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F3A78179B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245573AbjHSGKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245277AbjHSGJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:09:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C784420F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58daaa2ba65so24813747b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692425384; x=1693030184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CHNiRakjnSFrwZPm4w1kCxtDJ8+gWDLA3nwnMrmLA0=;
        b=5WZpVYez9PBWui0B26Zfb8zt7IV6megCpewMZYC+ulTfA4HwwZOoAHBUZGhzT7w8QH
         jftRuVHlgopl/lzcc/vXiXBfjfPh8V5ytVVNKoa/pfG0GbqIkpnUGRISsSn16T5PqUnQ
         uCt3alcMeQ4r1xTzhGYgxm1jYD/sxmXgLfxNDAhynQz88guSjIb0cA01QABFAxO7/U3w
         jLxYI3x8Y3Sjfz3pa2m2DDE56lcuR81mI9UKdxaNMK3ADU+9ZQLUa0Mmd5t+voelUveV
         x+3VanSU21kJtNvqCO1mmCsgVbysDONggEnkkvInX8SMXIXhhM1jX05s541R3b0gqiJH
         IXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692425384; x=1693030184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CHNiRakjnSFrwZPm4w1kCxtDJ8+gWDLA3nwnMrmLA0=;
        b=KigErI/46TC1lFSCdrfS1ZXJ4WeWfuEL8ySCDBrAONMAyNGoN8HYG2MUzWqNErWNdh
         dpgyNWv4hLebfyyBfheMn0Gn1eOExf2Zdmtkq0/VC+ciscuLT83Ung6vKF1BlJ3p49gl
         gBRmJnAHmXWJOb190oG39aRc/bdAi/uaIVtbKAzEVaXkcjpNKaRPACMaGKNW7uyPvlmj
         ynwRDDJHyhjXkQocjCqCMfkl3Db1hgPNZJSUZtkd4LxRap00/XmaJx0SOeF5obtZAeKZ
         Pu4Fx5hsgWfPpHe7JjJNmQVIiaJJriTLjeXbVjcMgr+zcPIGp5NsQCeN0phJff2CZEJ1
         he6A==
X-Gm-Message-State: AOJu0YymtcIEMK+tSJzp5N+NY+KJbMJuy1doVPwwbIlPVD/aADLGC/xS
        pjC6Zbw793AxWdOE8mSNCAyNtRZljrCBxZ7ICRyaJUBjGjonBYD9surAT03015Uz0c6bkX8kDPh
        lRtSdVqOIq8LTwKo+sBCdSGhsk/ekQvcAHMN5rQhzzcy0f2Pn9OxCW4YsjpyYcfxy+2wV2Qw=
X-Google-Smtp-Source: AGHT+IH6bsTvzrf5MZy5XKS4cNOc6EPPwJK8oOKSWaR1iS2xwh86/tM7ZLRyG4VGZXwp+T1qJliPYThNf9x4
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:b707:0:b0:579:f832:74b with SMTP id
 v7-20020a81b707000000b00579f832074bmr10079ywh.10.1692425383720; Fri, 18 Aug
 2023 23:09:43 -0700 (PDT)
Date:   Sat, 19 Aug 2023 06:08:43 +0000
In-Reply-To: <20230819060915.3001568-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230819060915.3001568-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819060915.3001568-10-jstultz@google.com>
Subject: [PATCH v5 09/19] locking/mutex: Switch to mutex handoffs for CONFIG_PROXY_EXEC
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Connor O'Brien" <connoro@google.com>,
        John Stultz <jstultz@google.com>
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

From: Peter Zijlstra <peterz@infradead.org>

Just the very earliest framework logic to provide
the config option and switch to using mutex
handoffs.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[rebased, added comments and changelog]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[Fixed rebase conflicts]
[squashed sched: Ensure blocked_on is always guarded by blocked_lock]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
[fix rebase conflicts, various fixes & tweaks commented inline]
[squashed sched: Use rq->curr vs rq->proxy checks]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Split out only the very basic initial framework
 for proxy logic from a larger patch.]
Signed-off-by: John Stultz <jstultz@google.com>
---
v5:
Split out from core proxy patch
---
 kernel/Kconfig.locks   | 2 +-
 kernel/locking/mutex.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 4198f0273ecd..791c98f1d329 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -226,7 +226,7 @@ config ARCH_SUPPORTS_ATOMIC_RMW
 
 config MUTEX_SPIN_ON_OWNER
 	def_bool y
-	depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW
+	depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW && !PROXY_EXEC
 
 config RWSEM_SPIN_ON_OWNER
        def_bool y
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 687009eca2d1..5125bbab4119 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -913,6 +913,10 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 	mutex_release(&lock->dep_map, ip);
 
+#ifdef CONFIG_PROXY_EXEC
+	/* Always force HANDOFF for Proxy Exec for now. Revisit. */
+	owner = MUTEX_FLAG_HANDOFF;
+#else /* CONFIG_PROXY_EXEC */
 	/*
 	 * Release the lock before (potentially) taking the spinlock such that
 	 * other contenders can get on with things ASAP.
@@ -935,6 +939,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 			return;
 		}
 	}
+#endif /* CONFIG_PROXY_EXEC */
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
-- 
2.42.0.rc1.204.g551eb34607-goog

