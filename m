Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA457BCF43
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 18:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344941AbjJHQjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 12:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbjJHQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 12:39:17 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C97B3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 09:39:15 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a2a9e5451bso149596439f.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696783155; x=1697387955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4koq0qb+9EqMhvH22U5EdqI24pJGwiBkHVIALKouyD8=;
        b=VR1liPfqYq+FKEUJzjKg05tdWPrcJdKf+diBpOfF3IcS+A+gtUbRY+x7EpI1Yj2h/D
         HUkMcU6xeRjBs2e6qNBQfHHUOUBGECjs2bS7qrLyYlAZLr8vdpTX+DIl7SsonyRF7mOV
         JEBWodgyTngj0LKLaQsu/m0bg1e3Mmxm67ECM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696783155; x=1697387955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4koq0qb+9EqMhvH22U5EdqI24pJGwiBkHVIALKouyD8=;
        b=LayBcavjo1bSNihMb7hvyrtWzQuSaWOwS7soRds5Xzex26M26xmLwa4iGrfZHsjR9H
         HypsUV8VLrkt64BskP4PFSK93I7WWeyqpE2wYnNzPHz2ZHYaFOlMsqykPHiGyaI8vx0Y
         zETPTXRJsaXjNrpWA6uMcE+SUsVJSNDL1RxHu7vWb/9RObKuxgpTQCDJroVoeP16PWAt
         EqYYApEBvhKotKxhXBsbhryUC50L3ZzWNw8dKjJu9/VBcwmcDpxAfW5Wb7m0aI5Orck+
         HJGG+rdnnDnCnNfV3p0srCkBth2GhdEqnfNhlqL1x2ZMDaSqNmc6AY7mMd32y+ay9BGo
         Yg4w==
X-Gm-Message-State: AOJu0Yw6dDtnxwza+1Zx8IlnwDvcjE+4V+MhuRSrM6lZufS984pKXhwW
        Ne4d+kH8GKYEkSGPy0oOYvePNg==
X-Google-Smtp-Source: AGHT+IHOpitYJabM74nkMZmNhro4z5jj4hd3Ps+vU5OcvGL1ZOiyHv5hfF32DtZIoA0TlsB/uV604w==
X-Received: by 2002:a6b:e31a:0:b0:791:acd7:233f with SMTP id u26-20020a6be31a000000b00791acd7233fmr11895757ioc.15.1696783155058;
        Sun, 08 Oct 2023 09:39:15 -0700 (PDT)
Received: from localhost (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id p7-20020a5ecb07000000b0079fa3d0d790sm1897662iom.31.2023.10.08.09.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 09:39:14 -0700 (PDT)
Date:   Sun, 8 Oct 2023 16:39:12 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Hsin Yi <hsinyi@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
Message-ID: <20231008163912.GA2338308@google.com>
References: <20231005161727.1855004-1-joel@joelfernandes.org>
 <20231006200129.GJ36277@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006200129.GJ36277@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Oct 06, 2023 at 10:01:29PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 05, 2023 at 04:17:26PM +0000, Joel Fernandes (Google) wrote:
> > From: Vineeth Pillai <vineethrp@google.com>
> > 
> > Whenever a CPU stops its tick, it now requires another idle CPU to handle the
> > balancing for it because it can't perform its own periodic load balancing.
> > This means it might need to update 'nohz.next_balance' to 'rq->next_balance' if
> > the upcoming nohz-idle load balancing is too distant in the future. This update
> > process is done by triggering an ILB, as the general ILB handler
> > (_nohz_idle_balance) that manages regular nohz balancing also refreshes
> > 'nohz.next_balance' by looking at the 'rq->next_balance' of all other idle CPUs
> > and selecting the smallest value.
> > 
> > Triggering this ILB can be achieved by setting the NOHZ_NEXT_KICK flag. This
> > primarily results in the ILB handler updating 'nohz.next_balance' while
> > possibly not doing any load balancing at all. However, sending an IPI merely to
> > refresh 'nohz.next_balance' seems excessive, and there ought to be a more
> > efficient method to update 'nohz.next_balance' from the local CPU.
> > 
> > Fortunately, there already exists a mechanism to directly invoke the ILB
> > handler (_nohz_idle_balance) without initiating an IPI. It's accomplished by
> > setting the NOHZ_NEWILB_KICK flag. This flag is set during regular "newly idle"
> > balancing and solely exists to update a CPU's blocked load if it couldn't pull
> > more tasks during regular "newly idle balancing" - and it does so without
> > having to send any IPIs. Once the flag is set, the ILB handler is called
> > directly from do_idle()-> nohz_run_idle_balance(). While its goal is to update
> > the blocked load without an IPI, in our situation, we aim to refresh
> > 'nohz.next_balance' without an IPI but we can piggy back on this.
> > 
> > So in this patch, we reuse this mechanism by also setting the NOHZ_NEXT_KICK to
> > indicate nohz.next_balance needs an update via this direct call shortcut. Note
> > that we set this flag without knowledge that the tick is about to be stopped,
> > because at the point we do it, we have no way of knowing that. However we do
> > know that the CPU is about to enter idle. In our testing, the reduction in IPIs
> > is well worth updating nohz.next_balance a few more times.
> > 
> > Also just to note, without this patch we observe the following pattern:
> > 
> > 1. A CPU is about to stop its tick.
> > 2. It sets nohz.needs_update to 1.
> > 3. It then stops its tick and goes idle.
> > 4. The scheduler tick on another CPU checks this flag and decides an ILB kick is needed.
> > 5. The ILB CPU ends up being the one that just stopped its tick!
> > 6. This results in an IPI to the tick-stopped CPU which ends up waking it up
> >    and disturbing it!
> > 
> > Testing shows a considerable reduction in IPIs when doing this:
> > 
> > Running "cyclictest -i 100 -d 100 --latency=1000 -t -m" on a 4vcpu VM
> > the IPI call count profiled over 10s period is as follows:
> > without fix: ~10500
> > with fix: ~1000
> > 
> > Fixes: 7fd7a9e0caba ("sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle")
> 
> Hurm.. does this really warrant a Fixes tag? Afaict nothing is currently
> broken -- this is a pure optimization question, no?

IMHO it is a breakage as it breaks NOHZ -- a lot of times the ILB kicks back
the CPU stopping the tick out of idle (effectively breaking NOHZ). The large
number of IPIs also wrecks power and it happens only on 6.1 and after. Having
the fixes tag means it will also goto all stable kernels >= 6.1. Hope that
sounds reasonable and thank you for taking a look!

thanks,

 - Joel

