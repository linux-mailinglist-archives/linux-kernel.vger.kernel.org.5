Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636D67D062F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346818AbjJTBkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346780AbjJTBkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:40:45 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9715B119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:40:43 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3576121362eso1110585ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1697766042; x=1698370842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh5be8dZ5dcoT5J8JNwZ13KMhHHmnbemy0aycAzw2qI=;
        b=xI8wf3N3hDb622ncSnja0fIzG4grMTp1OelEPRX/VWHTlYsXObTrqplI9Si8vKbNb2
         fJ0/H2vY6x/HC3wa7wxl2aL34cX77rVBEumY+/pSODy+Pz0x61HB35AsDTuqSxeEW31/
         x3WUqUvOaIAWwPalQFXGemCB69C9LloMlhg5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697766042; x=1698370842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yh5be8dZ5dcoT5J8JNwZ13KMhHHmnbemy0aycAzw2qI=;
        b=U+d1ClX5+GddiNTQ+1PAGLF53zYC6F6NWuOrtFO4Xe1dtokUfGDqn0x8OlZYBo+YX1
         OI0PrcBMTgnyeqwb6DE//NrmvQ8QQpMtjbWtGgKyISvpHwceFU0TPyaUgceZY2kjtr6+
         RA1E3D9NXGps4v7BL4ve9svkXH4p6vJkNdknmuI5MQhtA5gaX+MINM9gu4Wfg5Uj9PIT
         x44JRcOK3VB6U8qIbH1PrZ9jPHrwV8etHpU7t2+wRUIOv3o2aZz74k2KRhxIOGZlT+lT
         G0QzlAHHzRnO39gpSHNOK9rF/E9L/zNAGVKAgzp+RP37T9+88yA/HZlA5JuOnU5AcGSu
         Z5dw==
X-Gm-Message-State: AOJu0YxdCsyyD88RxDhHaRo0wNbFEeWvOBlDfPNCpkSJJlFSR1w7m6SH
        Tjh5sGoeX7iyL9IUYWwYEy0yLZ6740IauWkikQtKSA==
X-Google-Smtp-Source: AGHT+IE+gdqb4XnXJMpRAujcCubdS7zs2c+QeY8f6XMP6e5vrZI7w8+tsWTxUqn6RyUaekSHKJjbew==
X-Received: by 2002:a92:cb41:0:b0:357:a3fb:1a81 with SMTP id f1-20020a92cb41000000b00357a3fb1a81mr682373ilq.21.1697766042597;
        Thu, 19 Oct 2023 18:40:42 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id h9-20020a056e020d4900b00350f5584876sm270394ilj.27.2023.10.19.18.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 18:40:42 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/3] sched/nohz: Update comments about NEWILB_KICK
Date:   Fri, 20 Oct 2023 01:40:27 +0000
Message-ID: <20231020014031.919742-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231020014031.919742-1-joel@joelfernandes.org>
References: <20231020014031.919742-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How ILB is triggered without IPIs is cryptic. Out of mercy for future
code readers, document it in code comments.

The comments are derived from a discussion with Vincent in a past
review.

Cc: Suleiman Souhlal <suleiman@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/fair.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 965c30fbbe5c..8e276d12c3cb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11959,8 +11959,19 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 }
 
 /*
- * Check if we need to run the ILB for updating blocked load before entering
- * idle state.
+ * Check if we need to directly run the ILB for updating blocked load before
+ * entering idle state. Here we run ILB directly without issuing IPIs.
+ *
+ * Note that when this function is called, the tick may not yet be stopped on
+ * this CPU yet. nohz.idle_cpus_mask is updated only when tick is stopped and
+ * cleared on the next busy tick. In other words, nohz.idle_cpus_mask updates
+ * don't align with CPUs enter/exit idle to avoid bottlenecks due to high idle
+ * entry/exit rate (usec). So it is possible that _nohz_idle_balance() is
+ * called from this function on (this) CPU that's not yet in the mask. That's
+ * OK because the goal of nohz_run_idle_balance() is to run ILB only for
+ * updating the blocked load of already idle CPUs without waking up one of
+ * those idle CPUs and outside the preempt disable / irq off phase of the local
+ * cpu about to enter idle, because it can take a long time.
  */
 void nohz_run_idle_balance(int cpu)
 {
-- 
2.42.0.655.g421f12c284-goog

