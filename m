Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA45761D68
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjGYPaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjGYPaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:30:21 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FD31BFA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:30:20 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-348db491d0eso7530165ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690299019; x=1690903819;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xhE9XsD0g4wx9dsqDGPYdjP8oiwA1xffTts0iPPbMaA=;
        b=hffYucyNVb6seRbWvm88DN0MQEUtnnUOfJ7cFeaeu6oJAP7n/EyIn7PV3SlKi35ocP
         tuShb7yd4UPwIuPuZiSR3ImMOUuxWI+eIkdUyk4lAVtCn224h5bNa5wSO9gjlsbAcrLK
         oE5d2JiTKfDZZ2f81SHs76WCFgkbQ4QFMDXqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690299019; x=1690903819;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhE9XsD0g4wx9dsqDGPYdjP8oiwA1xffTts0iPPbMaA=;
        b=gOKugRuFbKeFYBfTW0zkB/hc660OqCiKOt56AnbICwJOc18vfvXTs/GzdfCkTh5ALe
         SkSEI67qjpyietmCcPLIUN+XhsKpPr8YyHjCUbWPzGg0N6b+f766jsnm/tLo2JZCsU+V
         fHv2MB5s9yH5zc/DmDXd22FdGU/wAAOdRDYwe1vcHJSIHCDOWgSE0fo9JyHLC0hDYW4I
         xGpyjjrcbBAC92+QTlPwYc6FqsloQ/kDsE0BQv6ws99K76gCKE44+VqSVBMQi7fGt0gI
         inIjxUdw0MPDazBFIcNEOmd2JO1UyGZKL+RK/vcOi9sv9DjV6whcejK0D6oyT9TVtteQ
         0+Lg==
X-Gm-Message-State: ABy/qLYkHgfAKqfylzxj7D+LeH0EC6b38fJ31gBl+q+veM6vP423iu6P
        cz3qCQEqVExosn0/dsfNDVB6wQ==
X-Google-Smtp-Source: APBJJlF980/aWeGYxbmv80Q7LAOlsMhc6nJ1dNtflz0Vn/hhdE73EUikUDV04ieSdRKXVjLgo6V2CQ==
X-Received: by 2002:a05:6e02:d4c:b0:348:d775:a382 with SMTP id h12-20020a056e020d4c00b00348d775a382mr2972955ilj.28.1690299018593;
        Tue, 25 Jul 2023 08:30:18 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id y9-20020a92d209000000b00345d10ea524sm3773299ily.65.2023.07.25.08.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:30:17 -0700 (PDT)
Date:   Tue, 25 Jul 2023 15:30:17 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        rcu@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [BUG] Re: Linux 6.4.4
Message-ID: <20230725153017.GA1191712@google.com>
References: <4b231ce5-7bb8-4abf-9c40-04aa676d1e45@paulmck-laptop>
 <123C6650-490B-4D08-96B4-39B118AD0054@joelfernandes.org>
 <fa417689-cf91-4687-8308-3ffe6759cf1d@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa417689-cf91-4687-8308-3ffe6759cf1d@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 04:17:32PM -0700, Paul E. McKenney wrote:
> On Mon, Jul 24, 2023 at 07:04:14PM -0400, Joel Fernandes wrote:
> > 
> > 
> > > On Jul 24, 2023, at 12:00 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > ﻿On Mon, Jul 24, 2023 at 09:36:02AM -0400, Joel Fernandes wrote:
> > >>> On Sun, Jul 23, 2023 at 11:35 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >>> 
> > >>> On Mon, Jul 24, 2023 at 12:32:57AM +0000, Joel Fernandes wrote:
> > >>>> On Sun, Jul 23, 2023 at 10:19:27AM -0700, Paul E. McKenney wrote:
> > >>>>> On Sun, Jul 23, 2023 at 10:50:26AM -0400, Joel Fernandes wrote:
> > >>>>>> 
> > >>>>>> 
> > >>>>>> On 7/22/23 13:27, Paul E. McKenney wrote:
> > >>>>>> [..]
> > >>>>>>> 
> > >>>>>>> OK, if this kernel is non-preemptible, you are not running TREE03,
> > >>>>>>> correct?
> > >>>>>>> 
> > >>>>>>>> Next plan of action is to get sched_waking stack traces since I have a
> > >>>>>>>> very reliable repro of this now.
> > >>>>>>> 
> > >>>>>>> Too much fun!  ;-)
> > >>>>>> 
> > >>>>>> For TREE07 issue, it is actually the schedule_timeout_interruptible(1)
> > >>>>>> in stutter_wait() that is beating up the CPU0 for 4 seconds.
> > >>>>>> 
> > >>>>>> This is very similar to the issue I fixed in New year in d52d3a2bf408
> > >>>>>> ("torture: Fix hang during kthread shutdown phase")
> > >>>>> 
> > >>>>> Agreed, if there are enough kthreads, and all the kthreads are on a
> > >>>>> single CPU, this could consume that CPU.
> > >>>>> 
> > >>>>>> Adding a cond_resched() there also did not help.
> > >>>>>> 
> > >>>>>> I think the issue is the stutter thread fails to move spt forward
> > >>>>>> because it does not get CPU time. But spt == 1 should be very brief
> > >>>>>> AFAIU. I was wondering if we could set that to RT.
> > >>>>> 
> > >>>>> Or just use a single hrtimer-based wait for each kthread?
> > >>>> 
> > >>>> [Joel]
> > >>>> Yes this might be better, but there's still the issue that spt may not be set
> > >>>> back to 0 in some future release where the thread gets starved.
> > >>> 
> > >>> But if each thread knows the absolute time at which the current stutter
> > >>> period is supposed to end, there should not be any need for the spt
> > >>> variable, correct?
> > >> 
> > >> Yes.
> > >> 
> > >>>>>> But also maybe the following will cure it like it did for the shutdown
> > >>>>>> issue, giving the stutter thread just enough CPU time to move spt forward.
> > >>>>>> 
> > >>>>>> Now I am trying the following and will let it run while I go do other
> > >>>>>> family related things. ;)
> > >>>>> 
> > >>>>> Good point, if this avoids the problem, that gives a strong indication
> > >>>>> that your hypothesis on the root cause is correct.
> > >>>> 
> > >>>> [Joel]
> > >>>> And the TREE07 issue is gone with that change!
> > >> [...]
> > >>>> Let me know what you think, thanks!
> > >>> 
> > >>> If we can make the stutter kthread set an absolute time for the current
> > >>> stutter period to end, then we should be able to simplify the code quite
> > >>> a bit and get rid of the CPU consumption entirely.  (Give or take the
> > >>> possible need for a given thread to check whether it was erroneously
> > >>> awakened early.)
> > >>> 
> > >>> But what specifically did you have in mind?
> > >> 
> > >> I was thinking of a 2 counter approach storing the absolute time. Use
> > >> an alternative counter for different stuttering sessions. But yes,
> > >> generally I agree with the absolute time idea. What do you think Paul?
> > >> 
> > >> Do we want to just do  the simpler schedule_timeout at HZ / 20 to keep stable
> > >> green, and do the absolute-time approach for mainline? That might be better
> > >> from a process PoV. But I think stable requires patches to be upstream. Greg?
> > >> 
> > >> I will try to send out patches this week to discuss this, thanks,
> > > 
> > > Heh!!!
> > > 
> > > Me, I was just thinking of mainline.  ;-)
> > 
> > Turns out it is simple enough for both mainline and stable :-).
> > Will test more and send it out soon.
> 
> Woo-hoo!!!  Some times you get lucky!

Better luck today than yesterday since yesterday a Linux distro update
stalled my development. :-). Thanks to backups that I got back up quickly..

Here is the mostly tested patch as preview. I am running the full suite now
after confirming it fixed TREE07. Looks OK? (I also confirmed with prints
that stuttering timing is the same as before).

---8<-----------------------

From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH] rcutorture: Fix stuttering races and other issues

The stuttering code isn't functioning as expected. Ideally, it should
pause the torture threads for a designated period before resuming. Yet,
it fails to halt the test for the correct duration. Additionally, a race
condition exists, potentially causing the stuttering code to pause for
an extended period if the 'spt' variable is non-zero due to the stutter
orchestration thread's inadequate CPU time.

Moreover, over-stuttering can hinder RCU's progress on TREE07 kernels.
This happens as the stuttering code may run within a softirq due to RCU
callbacks. Consequently, ksoftirqd keeps a CPU busy for several seconds,
thus obstructing RCU's progress. This situation triggers a warning
message in the logs:

[ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9

This warning suggests that an RCU torture object, although invisible to
RCU readers, couldn't make it past the pipe array and be freed -- a
strong indication that there weren't enough grace periods during the
stutter interval.

To address these issues, this patch sets the "stutter end" time to an
absolute point in the future set by the main stutter thread. This is
then used for waiting in stutter_wait(). While the stutter thread still
defines this absolute time, the waiters' waiting logic doesn't rely on
the stutter thread receiving sufficient CPU time to halt the stuttering
as the halting is now self-controlled.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/torture.c | 46 +++++++++++++---------------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 68dba4ecab5c..63f8f2a7d960 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -719,7 +719,7 @@ static void torture_shutdown_cleanup(void)
  * suddenly applied to or removed from the system.
  */
 static struct task_struct *stutter_task;
-static int stutter_pause_test;
+static ktime_t stutter_till_abs_time;
 static int stutter;
 static int stutter_gap;
 
@@ -729,30 +729,17 @@ static int stutter_gap;
  */
 bool stutter_wait(const char *title)
 {
-	unsigned int i = 0;
 	bool ret = false;
-	int spt;
+	ktime_t now_ns, till_ns;
 
 	cond_resched_tasks_rcu_qs();
-	spt = READ_ONCE(stutter_pause_test);
-	for (; spt; spt = READ_ONCE(stutter_pause_test)) {
-		if (!ret && !rt_task(current)) {
-			sched_set_normal(current, MAX_NICE);
-			ret = true;
-		}
-		if (spt == 1) {
-			torture_hrtimeout_jiffies(1, NULL);
-		} else if (spt == 2) {
-			while (READ_ONCE(stutter_pause_test)) {
-				if (!(i++ & 0xffff))
-					torture_hrtimeout_us(10, 0, NULL);
-				cond_resched();
-			}
-		} else {
-			torture_hrtimeout_jiffies(round_jiffies_relative(HZ), NULL);
-		}
-		torture_shutdown_absorb(title);
+	now_ns = ktime_get();
+	till_ns = READ_ONCE(stutter_till_abs_time);
+	if (till_ns && ktime_before(now_ns, till_ns)) {
+		torture_hrtimeout_ns(ktime_sub(till_ns, now_ns), 0, NULL);
+		ret = true;
 	}
+	torture_shutdown_absorb(title);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(stutter_wait);
@@ -763,23 +750,16 @@ EXPORT_SYMBOL_GPL(stutter_wait);
  */
 static int torture_stutter(void *arg)
 {
-	DEFINE_TORTURE_RANDOM(rand);
-	int wtime;
+	ktime_t till_ns;
 
 	VERBOSE_TOROUT_STRING("torture_stutter task started");
 	do {
 		if (!torture_must_stop() && stutter > 1) {
-			wtime = stutter;
-			if (stutter > 2) {
-				WRITE_ONCE(stutter_pause_test, 1);
-				wtime = stutter - 3;
-				torture_hrtimeout_jiffies(wtime, &rand);
-				wtime = 2;
-			}
-			WRITE_ONCE(stutter_pause_test, 2);
-			torture_hrtimeout_jiffies(wtime, NULL);
+			till_ns = ktime_add_ns(ktime_get(),
+					       jiffies_to_nsecs(stutter));
+			WRITE_ONCE(stutter_till_abs_time, till_ns);
+			torture_hrtimeout_jiffies(stutter - 1, NULL);
 		}
-		WRITE_ONCE(stutter_pause_test, 0);
 		if (!torture_must_stop())
 			torture_hrtimeout_jiffies(stutter_gap, NULL);
 		torture_shutdown_absorb("torture_stutter");
-- 
2.41.0.487.g6d72f3e995-goog

