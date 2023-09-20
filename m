Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561777A74CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjITHtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbjITHsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:48:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74664196
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:47:55 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:47:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695196074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Ccbm6EVXWZ73/IidtXy2FCH3h9Uxi+XEyBqgR20Wdw=;
        b=MGdy/kZO0w9DZREc5WrJKoRafUGMhQUMPE8ReXNhO4wdntEzKVuQJuQ8iegsCq8no/KAuK
        I6Eyqo4rkZYL8SaQPIpzUkBj18j29SehGdEDq0mHWxioYdo7q+RkLVnKDOzPxWzqc8cuYP
        AsUeV2kBUpWvlpz/X8ZhuuV+/1RdKXPupIWqp/WVVKklkvmiQATR1vhGb13nCWUbqn0ylc
        NJj8rIqu+tXH/zkD17TgZZ9V8wXDonaik+mAYjoiILGAED8tR/OZJuyToIWECrRKXBSQjv
        F07VlsDkheMrzoDbWjPh8bnP0G0qwz0TNLkvW7VCwWGAPX5UsNH7KNqikoyRtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695196074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Ccbm6EVXWZ73/IidtXy2FCH3h9Uxi+XEyBqgR20Wdw=;
        b=bqqNiXXsJTrqgoF5ulbvr53FJLfg4RVA6cmKvwzbMjZyuYxgORqegIFp8JFPtnsfqHO9uN
        AHDj4ofRGyx10aBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>, x86@kernel.org
Subject: [PATCH] signal: Correct spelling typos in ptrace_stop().
Message-ID: <20230920074752.G21mcqOI@linutronix.de>
References: <20230803100932.325870-2-bigeasy@linutronix.de>
 <169515461116.27769.12932058744920773528.tip-bot2@tip-bot2>
 <ZQqXvPhesRmAtjvR@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQqXvPhesRmAtjvR@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo spotted typos in the recently added comment and suggested
corrections.

Use 'On' instead of 'One' and remove one superfluous 'the' in a
sentence.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index f2a5578326ade..384b77ad1bc15 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2330,7 +2330,7 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 
 	/*
 	 * The previous do_notify_parent_cldstop() invocation woke ptracer.
-	 * One a PREEMPTION kernel this can result in preemption requirement
+	 * On a PREEMPTION kernel this can result in preemption requirement
 	 * which will be fulfilled after read_unlock() and the ptracer will be
 	 * put on the CPU.
 	 * The ptracer is in wait_task_inactive(, __TASK_TRACED) waiting for
@@ -2343,7 +2343,7 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	 * view but extends the runtime by one HZ tick time due to the
 	 * ptracer's sleep.  The preempt-disable section ensures that there
 	 * will be no preemption between unlock and schedule() and so
-	 * improving the performance since the ptracer will observe that
+	 * improving performance since the ptracer will observe that
 	 * the tracee is scheduled out once it gets on the CPU.
 	 *
 	 * On PREEMPT_RT locking tasklist_lock does not disable preemption.
-- 
2.40.1

