Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE814756BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjGQSVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjGQSVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:21:34 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB022113
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:21:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so51017615e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689618070; x=1692210070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+cnXP+tRfU9RzsyLkHrPlPDYsaNLXEDZaNzezEt64o=;
        b=1/olb9Q8/7SAxFzfgmIPKq6ZX3Fn2wWryMrrhligpVsqHoMIY4a/7tOll8HeiPY+2D
         WPdjWRikLCLiP2//oDmmrX33vxRCcvZhB12Rg3IzDpmS3JdFspyUJmUL1EKM8Z5dCD4h
         Ys0zucu0gvnQxegGKvtTxu2kEkC0Ue/S8/pwBx1PngZ0gp/V/n6vlf6aGUQ5u3UJnoPA
         OrKLlRge+y+Qi6HS5dzuLYmDGZr9RQsyBwctZIRUsRIbkVuWZUbQec71qIAMYXexaYQi
         hXvS5NtKqrkn0zecUGC5APv3FPTH6hPG8N5YGB59V0ijrm6dlvEoEWS0w8rNKIDuJBbU
         g/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689618070; x=1692210070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+cnXP+tRfU9RzsyLkHrPlPDYsaNLXEDZaNzezEt64o=;
        b=ApiwdQq5+tS9AnM/NGPQEBGmCvmuaHwAO6cYqg5jkH8SGgZViWyRSjgAHjXG8V9q4V
         Cw+60mLF9mgbH+7HMN2QhsKI0WUsFc2aeXyaL1E8zNNXhr2aqKuqVuEHbqXNzgW8d5GN
         ogJLWck4IBRFV3nTvE0u109/5JBe5kX1bCirSiPVgTIPQShzKKEvgr6CGL0Ru9ceCqAL
         XVkvX82CPohs34nBwRBzXTvyYpEifGhEuu+8tvAUTgqh3zWXkndZSjVyVERPqeIKZM0b
         grrS/PJ2qAugTr6AOKwqJ+X9xypp/fLwv6M/a1DLF3KrOGEK7lvvj9oTzRsiNVeF+dCh
         fD0g==
X-Gm-Message-State: ABy/qLb1f8i/ZVCoFsNEILkYZRvkO/65ESZ6z4dDxYs7kZHKwIFeysiE
        MnJsRD55ISe6kIwVJDVxt1kfxw==
X-Google-Smtp-Source: APBJJlG2spVP+ZKk5RN1uUCXHb4BWS+XNEnf2J7fLCbRinmyF8G0ySobBFdPh2f0Ixt6PIrfeQum/A==
X-Received: by 2002:a1c:7c0e:0:b0:3f7:3685:1e10 with SMTP id x14-20020a1c7c0e000000b003f736851e10mr97205wmc.40.1689618069200;
        Mon, 17 Jul 2023 11:21:09 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id u13-20020a7bcb0d000000b003fbd597bccesm8489734wmj.41.2023.07.17.11.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 11:21:08 -0700 (PDT)
Date:   Mon, 17 Jul 2023 19:21:06 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Message-ID: <20230717182106.g6j3jpsjp35psl5y@airbuntu>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <aa4a22b8-fc23-8c67-bdea-b6aac8f7e250@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa4a22b8-fc23-8c67-bdea-b6aac8f7e250@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Vincent and Peter

On 07/17/23 14:47, Lukasz Luba wrote:
> Hi Qais,
> 
> The rule is 'one size doesn't fit all', please see below.
> 
> On 7/11/23 18:58, Qais Yousef wrote:
> > Hi Kajetan
> > 
> > On 01/05/23 14:51, Kajetan Puchalski wrote:
> > 
> > [...]
> > 
> > > @@ -510,9 +598,11 @@ static int teo_enable_device(struct cpuidle_driver *drv,
> > >   			     struct cpuidle_device *dev)
> > >   {
> > >   	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> > > +	unsigned long max_capacity = arch_scale_cpu_capacity(dev->cpu);
> > >   	int i;
> > >   	memset(cpu_data, 0, sizeof(*cpu_data));
> > > +	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
> > 
> > Given that utilization is invariant, why do we set the threshold based on
> > cpu capacity?
> 
> 
> To treat CPUs differently, not with the same policy.
> 
> 
> > 
> > I'm not sure if this is a problem, but on little cores this threshold would be
> > too low. Given that util is invariant - I wondered if we need to have a single
> > threshold for all type of CPUs instead. Have you tried something like that
> 
> A single threshold for all CPUs might be biased towards some CPUs. Let's
> pick the value 15 - which was tested to work really good in benchmarks
> for the big CPUs. On the other hand when you set that value to little
> CPUs, with max_capacity = 124, than you have 15/124 ~= 13% threshold.
> That means you prefer to enter deeper idle state ~9x times (at max
> freq). What if the Little's freq is set to e.g. < ~20% fmax, which
> corresponds to capacity < ~25? Let's try to simulate such scenario.

Hmm what I'm struggling with is that PELT is invariant. So the time it takes to
rise and decay to threshold of 15 should be the same for all CPUs, no?

> 
> In a situation we could have utilization 14 on Little CPU, than CPU capacity
> (effectively frequency) voting based on utilization would be
> 1.2 * 14 = ~17 so let's pick OPP corresponding to 17 capacity.
> In such condition the little CPU would run the 14-util-periodic-task for
> 14/17= ~82% of wall-clock time. That's a lot, and not suited for
> entering deeper idle state on that CPU, isn't it?

Yes runtime is stretched. But we counter this at utilization level by making
PELT invariant. I thought that any CPU in the system will now take the same
amount of time to ramp-up and decay to the same util level. No?

But maybe what you're saying is that we don't need to take the invariance into
account?

My concern (that is not backed by real problem yet) is that the threshold is
near 0, and since PELT is invariant, the time to gain few points is constant
irrespective of any CPU/capacity/freq and this means the little CPUs has to be
absolutely idle with no activity almost at all, IIUC.

> 
> Apart from that, the little CPUs are tiny in terms of silicon area
> and are less leaky in WFI than big cores. Therefore, they don't need
> aggressive entries into deeper idle state. At the same time, they
> are often used for serving interrupts, where the latency is important
> factor.

On Pixel 6 this threshold will translate to util_threshold of 2. Which looks
too low to me. Can't TEO do a good job before we reach such extremely low level
of inactivity?


Thanks

--
Qais Yousef

> 
> > while developing the patch?
> 
> We have tried different threshold values in terms of %, but for all CPUs
> (at the same time) not per-cluster. The reason was to treat those CPUs
> differently as described above.
> 
> Regards,
> Lukasz
