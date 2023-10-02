Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B0A7B540A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbjJBNeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237182AbjJBNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:34:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D18EAD;
        Mon,  2 Oct 2023 06:33:59 -0700 (PDT)
Date:   Mon, 02 Oct 2023 13:33:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696253637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z4vR6z7FcgztoBF309slRuSBwJPiM/3Isa9tBEl+Gr0=;
        b=mOJ+wbg3OBccfwNWEYBZbcCYMawV5RuSyL8mWFnE1C5W6UDEsuoJRmSyxbm/E+AceRWRDp
        wCSDTc+zv1QLsin+RWZZ8WQ/tKfRaTiMvikuyjvGT+u+Kfhc7OQ56FPn0BcwDpRXKr9Muz
        ONIcZq6wdMrA1BryC7pZ17DtQPKA6H4jzhyMo/I+89cCZEywhQl4fM2f2QxN5J6/EFDMO9
        fRym3PgiRlQXYF8rF1ZL6ZeC7Ks5NMhP8VE0C07vWMvtyNk3MyS5Ya2JOn4ny6n744bnLG
        GCBnlSKedpvvDjsuQaveqDHMUGbfvztbvsQ7M7sADrIPC2rSYA+2HCfh8GqHzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696253637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z4vR6z7FcgztoBF309slRuSBwJPiM/3Isa9tBEl+Gr0=;
        b=brH8OE/sPQOW3CTRM+SLFYrHvoA67gjNTKNsBjd4giBKIO3CwBns8VMBzg2FORkMAwJqn2
        1OkfYOjoxIbLtkBg==
From:   "tip-bot2 for Cyril Hrubis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt/docs: Use 'real-time' instead of 'realtime'
Cc:     Cyril Hrubis <chrubis@suse.cz>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231002115553.3007-4-chrubis@suse.cz>
References: <20231002115553.3007-4-chrubis@suse.cz>
MIME-Version: 1.0
Message-ID: <169625363643.3135.2547495399686514705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     83494dc51033506eb60c5e11a335461b2dc42111
Gitweb:        https://git.kernel.org/tip/83494dc51033506eb60c5e11a335461b2dc42111
Author:        Cyril Hrubis <chrubis@suse.cz>
AuthorDate:    Mon, 02 Oct 2023 13:55:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 02 Oct 2023 15:17:14 +02:00

sched/rt/docs: Use 'real-time' instead of 'realtime'

Standardize on a single variant.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231002115553.3007-4-chrubis@suse.cz
---
 Documentation/scheduler/sched-rt-group.rst | 34 ++++++++++-----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index a16bee8..d685609 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -39,10 +39,10 @@ Most notable:
 1.1 The problem
 ---------------
 
-Realtime scheduling is all about determinism, a group has to be able to rely on
+Real-time scheduling is all about determinism, a group has to be able to rely on
 the amount of bandwidth (eg. CPU time) being constant. In order to schedule
-multiple groups of realtime tasks, each group must be assigned a fixed portion
-of the CPU time available.  Without a minimum guarantee a realtime group can
+multiple groups of real-time tasks, each group must be assigned a fixed portion
+of the CPU time available.  Without a minimum guarantee a real-time group can
 obviously fall short. A fuzzy upper limit is of no use since it cannot be
 relied upon. Which leaves us with just the single fixed portion.
 
@@ -50,14 +50,14 @@ relied upon. Which leaves us with just the single fixed portion.
 ----------------
 
 CPU time is divided by means of specifying how much time can be spent running
-in a given period. We allocate this "run time" for each realtime group which
-the other realtime groups will not be permitted to use.
+in a given period. We allocate this "run time" for each real-time group which
+the other real-time groups will not be permitted to use.
 
-Any time not allocated to a realtime group will be used to run normal priority
+Any time not allocated to a real-time group will be used to run normal priority
 tasks (SCHED_OTHER). Any allocated run time not used will also be picked up by
 SCHED_OTHER.
 
-Let's consider an example: a frame fixed realtime renderer must deliver 25
+Let's consider an example: a frame fixed real-time renderer must deliver 25
 frames a second, which yields a period of 0.04s per frame. Now say it will also
 have to play some music and respond to input, leaving it with around 80% CPU
 time dedicated for the graphics. We can then give this group a run time of 0.8
@@ -70,7 +70,7 @@ needs only about 3% CPU time to do so, it can do with a 0.03 * 0.005s =
 of 0.00015s.
 
 The remaining CPU time will be used for user input and other tasks. Because
-realtime tasks have explicitly allocated the CPU time they need to perform
+real-time tasks have explicitly allocated the CPU time they need to perform
 their tasks, buffer underruns in the graphics or audio can be eliminated.
 
 NOTE: the above example is not fully implemented yet. We still
@@ -90,12 +90,12 @@ The system wide settings are configured under the /proc virtual file system:
   The scheduling period that is equivalent to 100% CPU bandwidth.
 
 /proc/sys/kernel/sched_rt_runtime_us:
-  A global limit on how much time realtime scheduling may use. This is always
+  A global limit on how much time real-time scheduling may use. This is always
   less or equal to the period_us, as it denotes the time allocated from the
-  period_us for the realtime tasks. Even without CONFIG_RT_GROUP_SCHED enabled,
-  this will limit time reserved to realtime processes. With
+  period_us for the real-time tasks. Even without CONFIG_RT_GROUP_SCHED enabled,
+  this will limit time reserved to real-time processes. With
   CONFIG_RT_GROUP_SCHED=y it signifies the total bandwidth available to all
-  realtime groups.
+  real-time groups.
 
   * Time is specified in us because the interface is s32. This gives an
     operating range from 1us to about 35 minutes.
@@ -110,7 +110,7 @@ The system wide settings are configured under the /proc virtual file system:
 The default values for sched_rt_period_us (1000000 or 1s) and
 sched_rt_runtime_us (950000 or 0.95s).  This gives 0.05s to be used by
 SCHED_OTHER (non-RT tasks). These defaults were chosen so that a run-away
-realtime tasks will not lock up the machine but leave a little time to recover
+real-time tasks will not lock up the machine but leave a little time to recover
 it.  By setting runtime to -1 you'd get the old behaviour back.
 
 By default all bandwidth is assigned to the root group and new groups get the
@@ -118,10 +118,10 @@ period from /proc/sys/kernel/sched_rt_period_us and a run time of 0. If you
 want to assign bandwidth to another group, reduce the root group's bandwidth
 and assign some or all of the difference to another group.
 
-Realtime group scheduling means you have to assign a portion of total CPU
-bandwidth to the group before it will accept realtime tasks. Therefore you will
-not be able to run realtime tasks as any user other than root until you have
-done that, even if the user has the rights to run processes with realtime
+Real-time group scheduling means you have to assign a portion of total CPU
+bandwidth to the group before it will accept real-time tasks. Therefore you will
+not be able to run real-time tasks as any user other than root until you have
+done that, even if the user has the rights to run processes with real-time
 priority!
 
 
