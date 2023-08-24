Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01F7786FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbjHXNJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240990AbjHXNJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:09:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4C2198B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:09:44 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7923ae72111so129052039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692882584; x=1693487384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IQQpR3MAafD1THOWkmLsuJVXQvtSFGGapULogd1q9ek=;
        b=Ld4hokF01xieggHdn+kNcOXxfwADeQCtK+5AZ+pdXQA94BzW1G+k68NfgkbLG89UDk
         zNKe5bqt8X1IrPbo6ehcdjhVV5z/l86/3mYZS0Z0rrXRV1MXdRp0oUwZYaCjCSyRJR5R
         k9gH5GqGvXRuytxGe+zOPMTrmEXa+1W1ZfIgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692882584; x=1693487384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQQpR3MAafD1THOWkmLsuJVXQvtSFGGapULogd1q9ek=;
        b=HDH2xiV++WqZl6zjOa7/FPAtTy6rDP1TLH0oS+iOYB3ZG1aRMq3AGSg6Y8+v+xXkWf
         LBSutOHmwWIbuscp2HfvGrQ5tvFMyB0426Bn8Jk1zvqcRdd86Iuc9a4d0j9AXwypuFM9
         BeR1Wq/sHSwE0cMvch5RKy9hqepEcRc/+EDBLs1ugUhtnixsGg7pUs0SyunJRGyuVa/S
         Ypx+OXozu9fOEkXBHtF9PuSLpkIeOy6Mvk1kl8jTak/Lkm5KNQhbgMMObwo7rlMCrX7J
         QSaiyDoiiGh8WzkqqDi5E04uRIGrKe7AJXduElXdXcLcHe0g/gdPst7ciWUN/yhcLlux
         IFgA==
X-Gm-Message-State: AOJu0YxADbJixydXCnKNnA9bA0D/7Q6lZY16JuZ6ZEO0yqCmzBU6AXyF
        8r4JJZC0sue2FQz/GZ6vwwZFnw==
X-Google-Smtp-Source: AGHT+IEC2LoFxn9FbGroATYlp69itwV5taaqzDJRKV1XbKzCcjlBXmDZy1vtRhSXoDijm4XHZYEi6A==
X-Received: by 2002:a6b:dc0c:0:b0:792:70f2:a8ed with SMTP id s12-20020a6bdc0c000000b0079270f2a8edmr1593060ioc.4.1692882584151;
        Thu, 24 Aug 2023 06:09:44 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id u3-20020a02cbc3000000b0043167542398sm4573459jaq.141.2023.08.24.06.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:09:43 -0700 (PDT)
Date:   Thu, 24 Aug 2023 13:09:42 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Z qiang <qiang.zhang1211@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
Message-ID: <20230824130942.GA3810470@google.com>
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org>
 <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx>
 <03fe7084-0509-45fa-87ee-8f8705a221a6@paulmck-laptop>
 <CAAhV-H5Z3s=2_OyA_AJ1-NqXBtNrcs-EmsqYcrjc+qXmJ=SitQ@mail.gmail.com>
 <16827b4e-9823-456d-a6be-157fbfae64c3@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16827b4e-9823-456d-a6be-157fbfae64c3@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 04:40:42AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 24, 2023 at 10:50:41AM +0800, Huacai Chen wrote:
> > Hi, Paul,
> > 
> > On Thu, Aug 24, 2023 at 6:41 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Aug 24, 2023 at 12:03:25AM +0200, Thomas Gleixner wrote:
> > > > On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> > > > > On Thu, Aug 17, 2023 at 3:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >> > If  do_update_jiffies_64() cannot be used in NMI context,
> > > > >>
> > > > >> Can you not make the jiffies update conditional on whether it is
> > > > >> called within NMI context?
> > > >
> > > > Which solves what? If KGDB has a breakpoint in the jiffies lock held
> > > > region then you still dead lock.
> > > >
> > > > >> I dislike that..
> > > > > Is this acceptable?
> > > > >
> > > > > void rcu_cpu_stall_reset(void)
> > > > > {
> > > > >         unsigned long delta;
> > > > >
> > > > >         delta = nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_ns());
> > > > >
> > > > >         WRITE_ONCE(rcu_state.jiffies_stall,
> > > > >                    jiffies + delta + rcu_jiffies_till_stall_check());
> > > > > }
> > > > >
> > > > > This can update jiffies_stall without updating jiffies (but has the
> > > > > same effect).
> > > >
> > > > Now you traded the potential dead lock on jiffies lock for a potential
> > > > live lock vs. tk_core.seq. Not really an improvement, right?
> > > >
> > > > The only way you can do the above is something like the incomplete and
> > > > uncompiled below. NMI safe and therefore livelock proof time interfaces
> > > > exist for a reason.
> > >
> > > Just for completeness, another approach, with its own advantages
> > > and disadvantage, is to add something like ULONG_MAX/4 to
> > > rcu_state.jiffies_stall, but also set a counter indicating that this
> > > has been done.  Then RCU's force-quiescent processing could decrement
> > > that counter (if non-zero) and reset rcu_state.jiffies_stall when it
> > > does reach zero.
> > >
> > > Setting the counter to three should cover most cases, but "live by the
> > > heuristic, die by the heuristic".  ;-)
> > >
> > > It would be good to have some indication when gdb exited, but things
> > > like the gdb "next" command can make that "interesting" when applied to
> > > a long-running function.
> > 
> > The original code is adding ULONG_MAX/2, so adding ULONG_MAX/4 may
> > make no much difference? The simplest way is adding 300*HZ, but Joel
> > dislikes that.
> 
> I am not seeing the ULONG_MAX/2, so could you please point me to that
> original code?
> 
> The advantage of ULONG_MAX/4 over ULONG_MAX/2 is that the time_after()
> and time_before() macros have ULONG_MAX/4 slop in either direction
> before giving you the wrong answer.  You can get nearly the same result
> using ULONG_MAX/2, but it requires a bit more care.  And even on 32-bit
> HZ=1000 systems, ULONG_MAX/4 gets you more than 12 days of gdb session
> or jiffies-update delay before you start getting false positives.
> 
> Then things can be reset after (say) 3 calls to rcu_gp_fqs() and
> also the current reset at the beginning of a grace period, which
> is in record_gp_stall_check_time().

I like Paul's suggestion a lot except that if someone sets a breakpoint right
when the jiffies is being reset, so then we have to come back to doing
Thomas's suggestion.

So maybe a combination of Paul's and Thomas's suggestions (of using
last_jiffies_update with the NMI-safe timestamp read) may work.

> It would be better if RCU could get notified at both ends of the debug
> session, but given gdb commands such as "next", along with Thomas's
> point about gdb breakpoints being pretty much anywhere, this might or
> might not be so helpful in real life.  But worth looking into.

True, I was curious if rcu_cpu_stall_reset() can be called on a tickless
kernel as well before jiffies gets a chance to update, in which case I think
your suggestion of biasing the stall time and later resetting it would help a
lot for such situations.

thanks,

 - Joel


> 							Thanx, Paul
> 
> > Huacai
> > 
> > >
> > >                                                         Thanx, Paul
> > >
> > > > Thanks,
> > > >
> > > >         tglx
> > > > ---
> > > > --- a/kernel/time/tick-sched.c
> > > > +++ b/kernel/time/tick-sched.c
> > > > @@ -51,6 +51,13 @@ struct tick_sched *tick_get_tick_sched(i
> > > >   */
> > > >  static ktime_t last_jiffies_update;
> > > >
> > > > +unsigned long tick_estimate_stale_jiffies(void)
> > > > +{
> > > > +     ktime_t delta = ktime_get_mono_fast_ns() - READ_ONCE(last_jiffies_update);
> > > > +
> > > > +     return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Must be called with interrupts disabled !
> > > >   */
> > > >
> > > >
