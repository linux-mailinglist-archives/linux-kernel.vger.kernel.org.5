Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385977AAF76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjIVK0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjIVK0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:26:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2914319E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:26:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-403012f276dso22509295e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695378382; x=1695983182; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JQDUb7KhUsZMyWCvkCoiLMEvV1UXgf+f9G42+tW7AOU=;
        b=ZD7ZoKisQfqQk1+tFCsdTJgS0cakydVGo1/j+3TJ4Zguzyy0qskUWOZE99CHgbWV3W
         c0xpeKCbigpZpaV3X0Yhvf7FVVrWjagyr705/OMm9NOw/UBBdLQdqmj9YvNHTuAhl6yo
         UwFKx64t/+qmBdjQtuPcf09VVOeVZEmy7F4ToBGGQnzJWiNY5UIPfLuGdyzpzOFe9ceg
         mJS6lDvwg/5TAhVN67QJS0wkkKsDsTNsShPGi5NA4Ar0n18g69SWGdZB5pLelTHJj9p/
         tRvsYs1SM5NQom5UfdGxhdAoDREQ7BjlMNdO5D2gllBAVRZ7tn1rKyRfA4f4+xClQLhR
         Q0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695378382; x=1695983182;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQDUb7KhUsZMyWCvkCoiLMEvV1UXgf+f9G42+tW7AOU=;
        b=cFA1eKGSLUuYOWf1Xp9TvL9UXAEZ0tGpNU5TBCvOEfn/rI0RO1TdHZNkfPcRsipfGT
         Wq0S7MjiuGcC57LvUpAJm15L++aXJodcO5eZ7Ga3uA8vO6q5GnNP6Rwp9eW+9MZ0I7LT
         7WCYucQdXBhd2kPWLJYlldJ6st+kkjPCQRKpSsBwOu7xok+Csv5LGZcXA2Z73bwJhrLn
         Wwktfl02fqYU3IA/VWoHYek4wrnxV4Iatl+RNx7OovYggvwKRbfkaMl2hOqoSOwlkDtF
         hMOUOu5/Se0iUkleURXFUs5LtI/EPe4dQFpnp3e99e+buANcakEhUgc+B56bPakKkTOY
         sv7g==
X-Gm-Message-State: AOJu0Yzd8hGckrPVOiAN7lu9Elti+vShfTsnRFeODG/wIsbpl68E4Nyr
        DHt86urWVr3RB5YMRN1Wk10=
X-Google-Smtp-Source: AGHT+IFvePphPdNIKfKGW8D7MsTKJ3Cmw1WB287qz+/HbX/dGgAURvsfIz3qxNEVYDsiZ6A3hj1KbA==
X-Received: by 2002:a05:600c:3d8c:b0:405:315f:e676 with SMTP id bi12-20020a05600c3d8c00b00405315fe676mr3839473wmb.3.1695378382367;
        Fri, 22 Sep 2023 03:26:22 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id e15-20020a05600c218f00b00402ff8d6086sm4228515wme.18.2023.09.22.03.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 03:26:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 22 Sep 2023 12:26:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] scheduler fix
Message-ID: <ZQ1ryz9yFQ3Bcc3J@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-09-22

   # HEAD: cff9b2332ab762b7e0586c793c431a8f2ea4db04 kernel/sched: Modify initial boot task idle setup

Fix a PF_IDLE initialization bug that generated warnings on tiny-RCU.

 Thanks,

	Ingo

------------------>
Liam R. Howlett (1):
      kernel/sched: Modify initial boot task idle setup


 kernel/sched/core.c | 2 +-
 kernel/sched/idle.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2299a5cfbfb9..802551e0009b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9269,7 +9269,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	 * PF_KTHREAD should already be set at this point; regardless, make it
 	 * look like a proper per-CPU kthread.
 	 */
-	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
+	idle->flags |= PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 342f58a329f5..5007b25c5bc6 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -373,6 +373,7 @@ EXPORT_SYMBOL_GPL(play_idle_precise);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
+	current->flags |= PF_IDLE;
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
 	while (1)
