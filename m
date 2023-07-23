Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F5775DF7D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 02:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjGWAZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 20:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGWAZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 20:25:13 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8585B10FB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 17:25:10 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-348c8fc6eb9so2258575ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 17:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690071909; x=1690676709;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=49CQc5om57PknB0KI/2hfLurHVzLrrNKGtxP13k1/vQ=;
        b=ObVoDgj+LlwJerjZQMZgb/mB1wsMt5apKLN4ArB/w8RhvCePeoNg1ZMfI4CsuADNPi
         mZTGJ1EGDG9HcJZOiUWu5spasgmu2HEkyCuopKxVdCLCRg9MG9AxpMM/7vWg9PO1++gU
         VLELwE37kk/pfcYP+Ins4N5Cu4l7FqYg9UoC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690071909; x=1690676709;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49CQc5om57PknB0KI/2hfLurHVzLrrNKGtxP13k1/vQ=;
        b=hvzQu8moh04mTSfhYUztoDmR69hxrm8lFfmKBpVm6cjRelsPmvRK7y7f50K2a0Kg7V
         NWOtEE9qUfwv5b7MAgVJI3vYxX7lU4pgMqWEnKPuaBt5zO2McBUhaa//SU6t3F86JwVV
         /JMkv8QY53g19exirXQqYEIZnDxhKQ1vG8wayTQVr3EM/4Y5xqDoYBCqVchFX9IerrgC
         qfVT1NHOvFftsT+WgR0L07O5frs0GwICc1yjLx+kL3pruCiMFxusECPIi90BoanWGWcb
         S2WYQEHcexwo5y0Z6FM7phEWox5/eFUeFrHLDfHkSoT1icuppPa1C2TzI5VKHijDvr7I
         aUOg==
X-Gm-Message-State: ABy/qLZMfJZK57FNpURh92stc4p02NwlAycjQltAs+iaRQfkCKXfZY3i
        D1ozuyxpXr6JRFpGb5EfLXRLMQ==
X-Google-Smtp-Source: APBJJlFxDkwk3jrb7WrWq1Q+7OoT+zADZvDtOUr7Wi505SnqIUYEnrkCV0wrT/PV2VBo+fFIG6Zopg==
X-Received: by 2002:a05:6e02:19c9:b0:348:7980:1e65 with SMTP id r9-20020a056e0219c900b0034879801e65mr5077399ill.14.1690071909535;
        Sat, 22 Jul 2023 17:25:09 -0700 (PDT)
Received: from localhost (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id r16-20020a92d450000000b00345cce526cdsm1997119ilm.54.2023.07.22.17.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 17:25:08 -0700 (PDT)
Date:   Sun, 23 Jul 2023 00:25:07 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        rcu@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [BUG] Re: Linux 6.4.4
Message-ID: <20230723002507.GA284241@google.com>
References: <2b8fc10b-785e-48b9-9a38-5c1af81f9578@paulmck-laptop>
 <CAEXW_YQO7OCdkXm_SBcPhAm8V8vMaF_5DQq7PbG9PZb7RFgA_g@mail.gmail.com>
 <f18e165c-9196-4b41-a202-82cfd5ac7f8b@paulmck-laptop>
 <8682b08c-347b-5547-60e0-013dcf1f8c93@joelfernandes.org>
 <eb04b7d0-2f49-4e01-be09-9062d9f08404@paulmck-laptop>
 <32aec6d1-bf25-7b47-8f31-7b6318d5238d@joelfernandes.org>
 <9b42cb38-8375-fc41-475a-2bd26c60a7b9@joelfernandes.org>
 <5dcf7117-cec7-4772-8aad-e100484a84dc@paulmck-laptop>
 <7bfde9f4-2bd6-7337-b9ca-94a9253d847f@joelfernandes.org>
 <ad82995c-061e-4f97-a972-c13a85ad0b72@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad82995c-061e-4f97-a972-c13a85ad0b72@paulmck-laptop>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 10:27:55AM -0700, Paul E. McKenney wrote:
> On Sat, Jul 22, 2023 at 08:38:02AM -0400, Joel Fernandes wrote:
> > 
> > 
> > On 7/21/23 18:08, Paul E. McKenney wrote:
> > > On Fri, Jul 21, 2023 at 03:20:48PM -0400, Joel Fernandes wrote:
> > >> (Trimming the CC list a bit)
> > >> On 7/21/23 08:13, Joel Fernandes wrote:
> > >>> On 7/20/23 15:47, Paul E. McKenney wrote:
> > >>>> On Thu, Jul 20, 2023 at 03:32:35PM -0400, Joel Fernandes wrote:
> > >>>>> On 7/20/23 15:04, Paul E. McKenney wrote:
> > >>>>>> On Thu, Jul 20, 2023 at 12:31:13PM -0400, Joel Fernandes wrote:
> > >>>>>>> Hi Paul,
> > >>>>>>>
> > >>>>>>> On Thu, Jul 20, 2023 at 11:55 AM Paul E. McKenney
> > >>>>>>> <paulmck@kernel.org> wrote:
> > >>>>>>>>
> > >>>>>>>> On Thu, Jul 20, 2023 at 01:27:14PM +0000, Joel Fernandes wrote:
> > >>>>> [...]
> > >>>>>>>>>
> > >>>>>>>>> So likely RCU boosting is failing:
> > >>>>>>>>>
> > >>>>>>>>> The full TREE03 splat:
> > >>>>>>>>> [   54.243588] ------------[ cut here ]------------
> > >>>>>>>>> [   54.244547] rcu-torture: rcu_torture_boost started
> > >>>>> [...]
> > >>>>>>>>> [   54.300499] RIP: 0010:rcu_torture_stats_print+0x5b2/0x620
> > >>>>> [...]
> > >>>>>>>>> [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
> > >>>>>>>>>
> > >>>>>>>>> However, if we are to believe the '9', it appears the object did
> > >>>>>>>>> made it
> > >>>>>>>>> quite some till the end of the pipe array but not until the free
> > >>>>>>>>> pool.
> > >>>>>>>>
> > >>>>>>>> This is from this if/for statement, correct?
> > >>>>>>>>
> > >>>>>>>>                   stutter_waited =
> > >>>>>>>> stutter_wait("rcu_torture_writer");
> > >>>>>>>>                   if (stutter_waited &&
> > >>>>>>>>                       !atomic_read(&rcu_fwd_cb_nodelay) &&
> > >>>>>>>>                       !cur_ops->slow_gps &&
> > >>>>>>>>                       !torture_must_stop() &&
> > >>>>>>>>                       boot_ended)
> > >>>>>>>>                           for (i = 0; i <
> > >>>>>>>> ARRAY_SIZE(rcu_tortures); i++)
> > >>>>>>>>                                   if
> > >>>>>>>> (list_empty(&rcu_tortures[i].rtort_free) &&
> > >>>>>>>>                                      
> > >>>>>>>> rcu_access_pointer(rcu_torture_current) !=
> > >>>>>>>>                                       &rcu_tortures[i]) {
> > >>>>>>>>                                           tracing_off();
> > >>>>>>>>                                           show_rcu_gp_kthreads();
> > >>>>>>>>                                           WARN(1, "%s:
> > >>>>>>>> rtort_pipe_count:
> > >>>>>>>>                                           rcu_ftrace_dump(DUMP_ALL);
> > >>>>>>>>                                   }
> > >>>>>>>
> > >>>>>>> Yes, that's right.
> > >>>>>>>
> > >>>>>>>> If so, this happens when there was a stutter wait, but RCU grace
> > >>>>>>>> periods failed to clear out the backlog during the several seconds
> > >>>>>>>> that
> > >>>>>>>> rcutorture was forced idle.  This might be related to the RCU
> > >>>>>>>> priority
> > >>>>>>>> boosting failure, in which a preempted reader persisted across the
> > >>>>>>>> stutter interval.
> > >>>>>>>
> > >>>>>>> When RCU is operating normally, shouldn't the check
> > >>>>>>> "(list_empty(&rcu_tortures[i].rtort_free)" not run until the preempted
> > >>>>>>> reader unblocks and exits its RCU read-side critical section?
> > >>>>>>
> > >>>>>> Yes, but not just "until", but rather "long after".  If RCU is doing
> > >>>>>> grace periods correctly, an active reader on a given rcu_tortures[]
> > >>>>>> element will prevent .rtort_pipe_count from exceeding the value 2.
> > >>>>>
> > >>>>> Ah ok, so the rtort_pipe_count being 9 is a sign RCU isn't making
> > >>>>> progress
> > >>>>> thus making it absent from the free list.
> > >>>>
> > >>>> Yes, though RCU is -just- -barely- too slow, as one more grace period
> > >>>> would have done it.
> > >>>>
> > >>>>>> The element will not be put on a list until .rtort_pipe_count is equal
> > >>>>>> to RCU_TORTURE_PIPE_LEN, which is 10.
> > >>>>>>
> > >>>>>> This warning usually appears when something is holding up the
> > >>>>>> grace-period
> > >>>>>> kthread.  Historically, this has included deadlocks, missed timers,
> > >>>>>> and whatever else can prevent the grace-period kthread from running.
> > >>>>>
> > >>>>> Makes sense.
> > >>>>>
> > >>>>>>> One thing that confuses me, in the case of
> > >>>>>>> "cur_ops->deferred_free(old_rp);" , the earlier do-while loop may exit
> > >>>>>>> before the async callbacks can finish. So what prevents the
> > >>>>>>> "(list_empty(&rcu_tortures[i].rtort_free)" check from happening before
> > >>>>>>> grace periods happen? Thanks for any clarification.
> > >>>>>>
> > >>>>>> We only enter this code if the stutter_wait() actually waited, and by
> > >>>>>> default this function will wait about five seconds.  Since the
> > >>>>>> rcutorture
> > >>>>>> testing goes idle during this time period (or is supposed to!), if
> > >>>>>> things
> > >>>>>> are working properly, knocking off ten grace periods during that time
> > >>>>>> should be pretty much a given.
> > >>>>>
> > >>>>> Sure, makes sense. And this is not Lazy-RCU so 5 seconds should be
> > >>>>> plenty
> > >>>>> ;). I think I was subconsciously expecting an rcu_barrier() somewhere
> > >>>>> in the
> > >>>>> code before those checks, but that's not needed as you pointed that the
> > >>>>> stutter should be giving enough time for RCU to make progress.
> > >>>>
> > >>>> And there might need to be a call_rcu_hurry() in there somewhere,
> > >>>> now that you mention it.  Which would pretty much defeat any sort of
> > >>>> lazy-RCU-callback testing in rcutorture, but testing of laziness might
> > >>>> need to be separate anyway.
> > >>>>
> > >>>>> So hmm, the count being 9 means that not enough RCU grace periods have
> > >>>>> passed for the rcu_torture object in question thus keeping it always
> > >>>>> allocated. The GP thread not getting CPU can do that indeed, or perhaps
> > >>>>> something else stalling RCU like a preempted reader, length preemption
> > >>>>> disabling on a CPU and so forth..  I'll try to collect a trace when it
> > >>>>> happens.
> > >>>>
> > >>>> Looking forward to seeing what you come up with!
> > >>>
> > >>> So far I found this. Before the crash, GPs took about 50ms, during the
> > >>> crash it took 5 seconds before the warning which aligns with what you
> > >>> mentioned about stutter.
> > >>>
> > >>>
> > >>> The GP that never completed is at this line:
> > >>>
> > >>> [ 2816.041082]    <...>-13       13d.... 1237016139us :
> > >>> rcu_grace_period: rcu_sched 144681 start
> > >>>
> > >>> And fqs loop got a "dti" for CPUs:
> > >>> 1
> > >>> 2
> > >>> 12
> > >>>
> > >>> And I see cpuqs for:
> > >>> 13
> > >>> 6
> > >>> 10
> > >>> 5
> > >>> 4
> > >>> 11
> > >>>
> > >>> No idea what happened to 3, 8, 9, 14, 15. Maybe the "dti" for those did
> > >>> not show in the trace?
> > >>>
> > >>> However, I see that CPU 7 did this:
> > >>> [ 2816.205277]   <idle>-0         7d.... 1237016284us : sched_switch:
> > >>> prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==>
> > >>> next_comm=rcu_torture_rea next_pid=149 next_prio=139
> > >>>
> > >>>
> > >>> and then did this about 3 seconds later:
> > >>> [ 2819.394111] rcu_tort-149       7dNs.. 1237025699us :
> > >>> rcu_grace_period: rcu_sched 144677 cpuend
> > >>> [ 2819.412745] rcu_tort-149       7dNs.. 1237025699us :
> > >>> rcu_grace_period: rcu_sched 144681 cpustart
> > >>>
> > >>>
> > >>> Which means it never switched out from the CPU all this while. Neither
> > >>> did it report cpuqs. Ok it did notice the new GP started, welcome to the
> > >>> party mate ;)
> > >>>
> > >>> That points the issue I think. I wonder if the emergency provisions for
> > >>> forcing quiescent states on NOHZ_FULL CPUs kicked in. ISTR, we had
> > >>> issues with that in the past where we had to fix the tick path to report
> > >>> a QS.
> > >>>
> > >>> I'll add some more traces. Especially around preempted readers, the
> > >>> emergency provisions for forcing a QS and so forth and see if I can dig
> > >>> more information.
> > >>
> > >> In another instance, I caught a stack trace of CPU5 when it did not
> > >> check-in with RCU for 3 seconds or so:
> > >>
> > >> [ 1127.067889]  kmalloc_trace+0x25/0x90
> > >> [ 1127.072823]  rcu_torture_fwd_prog+0x3d8/0xa60
> > >> [ 1127.078749]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
> > >> [ 1127.085468]  ? kthread+0xcb/0xf0
> > >> [ 1127.090040]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
> > >> [ 1127.096626]  kthread+0xcb/0xf0
> > >> [ 1127.100803]  ? __pfx_kthread+0x10/0x10
> > >> [ 1127.107207]  ret_from_fork+0x2c/0x50
> > >> [ 1127.113662]  </TASK>
> > >> [ 1127.117818] Kernel panic - not syncing: kernel: panic_on_warn set ...
> > >>
> > >> It appears it was in "rcu_torture_fwd_prog" at the time. It got stuck
> > >> there for 2 seconds.
> > >>
> > >> Interestingly, I did find the scheduler tick was trying to get in touch
> > >> with the CPU and it was running code on it even:
> > >> [ 5858.463102] rcu_tort-174       5d.h.. 1131149320us : rcu_utilization:
> > >> Start scheduler-tick
> > >> [ 5858.472903] rcu_tort-174       5d.h.. 1131149320us : rcu_utilization:
> > >> End scheduler-tick
> > >>
> > >> So I could add some traces there to figure out what is it upto. ISTR, we
> > >> also send IPIs to these CPUs? So maybe adding some traces there too is
> > >> in order.
> > >>
> > >> Also earlier in dmesg it did this:
> > >> [ 1124.825504] rcu_torture_fwd_prog n_max_cbs: 44181
> > >> [ 1124.832158] rcu_torture_fwd_prog: Starting forward-progress test 0
> > >> [ 1124.840977] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> > >> [ 1126.726621] ------------[ cut here ]------------
> > >> [ 1126.733296] rcutorture_oom_notify invoked upon OOM during
> > >> forward-progress testing.
> > >>
> > >> Before that "cut here", there is a 2 second gap which tells me it got
> > >> stuck there.
> > >>
> > >> So this function rcu_torture_fwd_prog() is keeping the CPU unresponsive
> > >> from an RCU perspective for some reason? Because I never saw the
> > >> "rcu_torture_fwd_prog_cr: Waiting for CBs" message before it panicked.
> > > 
> > > Thank you for digging into this!
> > > 
> > > Yes, rcu_torture_fwd_prog() is supposed to monopolize CPUs.  But it
> > > is supposed to respect stuttering.  It is quite possible that the
> > > synchronization is insufficient.  Or that the "supposed to" never
> > > made it into the code.
> > > 
> > >> Collecting traces again.. ;) thanks,
> > > 
> > > ;-) ;-) ;-)
> > 
> > I narrowed it down to the timer softirq taking too long and doing this
> > for 4 seconds:
> > 
> > [ 6781.411834] ksoftirq-12        0dNs.. 206231531us : sched_wakeup:
> > comm=rcu_torture_rea pid=153 prio=139 target_cpu=000
> > [ 6781.424854] ksoftirq-12        0dNs.. 206231531us : sched_waking:
> > comm=rcu_torture_rea pid=164 prio=139 target_cpu=006
> > [ 6781.437650] ksoftirq-12        0dNs.. 206231533us : sched_wakeup:
> > comm=rcu_torture_rea pid=164 prio=139 target_cpu=000
> > [ 6781.451019] ksoftirq-12        0dNs.. 206231533us : sched_waking:
> > comm=rcu_torture_rea pid=162 prio=139 target_cpu=002
> > [ 6781.463825] ksoftirq-12        0dNs.. 206231535us : sched_wakeup:
> > comm=rcu_torture_rea pid=162 prio=139 target_cpu=000
> > [ 6781.476290] ksoftirq-12        0dNs.. 206231535us : sched_waking:
> > comm=rcu_torture_wri pid=143 prio=139 target_cpu=004
> > [ 6781.489257] ksoftirq-12        0dNs.. 206231537us : sched_wakeup:
> > comm=rcu_torture_wri pid=143 prio=139 target_cpu=000
> > [ 6781.502559] ksoftirq-12        0dNs.. 206231538us : sched_waking:
> > comm=rcu_torture_rea pid=154 prio=139 target_cpu=006
> > [ 6781.515093] ksoftirq-12        0dNs.. 206231539us : sched_wakeup:
> > comm=rcu_torture_rea pid=154 prio=139 target_cpu=000
> > [ 6781.527622] ksoftirq-12        0dNs.. 206231539us : sched_waking:
> > comm=rcu_torture_fak pid=149 prio=139 target_cpu=003
> > [ 6781.539979] ksoftirq-12        0dNs.. 206231541us : sched_wakeup:
> > comm=rcu_torture_fak pid=149 prio=139 target_cpu=000
> > [ 6781.552717] ksoftirq-12        0dNs.. 206231541us : sched_waking:
> > comm=rcu_torture_fak pid=145 prio=139 target_cpu=005
> > [ 6781.565074] ksoftirq-12        0dNs.. 206231543us : sched_wakeup:
> > comm=rcu_torture_fak pid=145 prio=139 target_cpu=000
> > [ 6781.577580] ksoftirq-12        0dNs.. 206231543us : sched_waking:
> > comm=rcu_torture_rea pid=166 prio=139 target_cpu=003
> > [ 6781.590211] ksoftirq-12        0dNs.. 206231547us : sched_wakeup:
> > comm=rcu_torture_rea pid=166 prio=139 target_cpu=000
> > 
> > And I caught the softirq exit which told me it is coming from timer softirq:
> > [ 6781.603150] ksoftirq-12        0.Ns.. 206231552us : __do_softirq:
> > softirq exit: name: TIMER, action handler: run_timer_softirq
> > 
> > Maybe something to do with calls to stuttering or lack of cond_resched()
> > in the torture code somewhere? Unfortunately I was not able to get a
> > stack trace and what is doing the wake ups.
> 
> Huh.  It seems to be waking up each rcutorture kthread twice.

That's actually 2 different tracepoints. So its 2 events per wakeup.

> So maybe
> this is the timed wakeups towards the end of the stutter interval?

Thanks, I'll look into that as well.

> But
> how many kthreads do you have?  Four seconds at about two microseconds per
> kthread would be about 2 million kthreads, so I am guessing that something
> else is also going on.

In the 4 seconds, it repeatedy does the sched_waking on 17 different threads
all are from rcu_torture.

> Or that there are sometimes longer delays between
> wakeups.

I am seeing a delay of 100-200 microseconds or so between them.

> Or maybe it cycles through rcutorture's kthreads, repeatedly
> awakening the set.

Yes.

> Which might actually happen given enough kthreads spinning in
> stutter_wait() doing that occasional 10-microsecond torture_hrtimeout_us()
> call, mightn't it?

Yeah could be, I was planning to trace that code but last when I added traces
there it overflowed my trace buffer. Now I made the buffer 1MB/CPU so
hopefully will survive ;-)

> Perhaps try changing that torture_hrtimeout_us() to something like:
> 
> 	torture_hrtimeout_us(100, 0, NULL);
> 
> Or, better, make that function rely entirely on a single hrtimer per
> kthread.  Which will likely also require spreading the timers across the
> available CPUs.  Perhaps part of the problem here is that there are very
> few online CPUs, not enough to keep up.

Thanks I'll look more into it, good way for me to study the stutter
functionality.

> > This is at least one of the issues. I do believe the fwd prog functions
> > taking too long in the kernel without doing a cond_resched() is another
> > issue but I need to reduce the RCU stall timeout to 2 seconds to see
> > those happen otherwise I think those just get "hidden".
> 
> The rcu_torture_fwd_prog_cond_resched() function is supposed to be taking
> care of that for the callback flooding, but maybe I missed a place where
> a call is needed.
> 
> For the tight loop of readers, there is a call to cond_resched().  Ah,
> but are you running a preemptible kernel?  (If we are still talking
> about TREE03, I believe that is a "yes".)  Maybe try changing the
> cond_resched() in the rcu_torture_fwd_prog_nr() function's loop to
> rcu_torture_fwd_prog_cond_resched()?

Sure, I can try to make this change, but the fwd_prog issue was for TREE07
(non-preemptible).

> > Both these issues appear to be threads spending too much time in kernel
> > mode in non-preemptible kernels. The RCU GP thread was able to get CPU
> > so that wasn't the issue in these instances.
> > 
> > Thoughts?
> 
> OK, if this kernel is non-preemptible, you are not running TREE03,
> correct?

I am running both TREE03 and TREE07 on the same stable kernel version. The
TREE03 issue was related to the boost failure warning. The TREE07 was an
rcutorture object was still allocated with a pipecount of 9 or sometimes 6.
The TREE07 issue is definitely spending of too much time in kernel mode which
is holding up the CPU. The TREE03 issue is likely unrelated, but I thought I
will get to that next after looking into TREE07.

> > Next plan of action is to get sched_waking stack traces since I have a
> > very reliable repro of this now.
> 
> Too much fun!  ;-)

True! :D

thanks,

 - Joel

