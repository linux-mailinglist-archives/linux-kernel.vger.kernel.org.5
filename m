Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FC9798848
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbjIHOIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjIHOIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:08:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28C113E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:08:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4018af1038cso22697595e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694182079; x=1694786879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=knefqKnKudMhyKCMDl9dcPSwDlbRdgYwFRKX7lYoAZY=;
        b=v0GkABOU/haf6Vx3PKL5fw2tK/WDF9k8Y6oVabYnz5AnMa1i4ngBtUSkZde+uDDwMU
         8rnU4ti2w1qljlhZNIE4hoJfZWL/aJYnsrjEZd+B9fe8PqTo0qDFDTKkSoPe26/0C8po
         tElRt6bcxjlkg2AlAk0VLDip3UEXnYgGOP0Vs92wVBfV+++jxWLGsDpu+KB6aikdYogD
         gH+jPoRbHUVwPgCFyNsSvj0WaijG280+t7kmUjtfeTrwgbJAAIX225KkAXeUhSuG06sI
         a+Q5QYfh6u5dRsZNDeVyMdiGlEiaMHYPXsg83HOh9qmBtMlai6mGU39/5uewXpYNT39y
         7KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694182079; x=1694786879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knefqKnKudMhyKCMDl9dcPSwDlbRdgYwFRKX7lYoAZY=;
        b=u0e+7Ygs7F5GXPUSIOIO3xPtxFT0jrXd14azRtEkG0ZWWddy7hgZBmx4k1TUqTY1+q
         NMZb6En9EPtQ5BH4uKxsmMuAZFWXLRcC7myKUbeyuwthDumRngbdfLpl8sRSs+hXfm7r
         fmUG1Jhxx7xoGL45JvW74WSYRLLE+Y+dUtYYjh73o0JlN4RXeF6aPAwjIuabRmG8rXA5
         znBwnb1kWvWMzpXHrEoHRLkIauaFHC1Rk5c2cXh3/7OGYbXRxOTVRnpuy4iLRD47ZhtL
         Lm4bDfjS2FbOVS8DCmzF4cTA49bVun0/yJV0ef6lNdUOPy1eTZScBENB2K32iBOYosNy
         i+MA==
X-Gm-Message-State: AOJu0Yz1A8JXq/rBsDvdi8eDoRDVbNDpWsT1Eq7S5yIoSPtrdDOMjc6W
        U0VEGirDeXfg4igU+gsh+oq1tw==
X-Google-Smtp-Source: AGHT+IGPnLwSnpCvmxWC4UEMa9xp5Cqr7U6OvD105BcfjVnKiCbSO1y6/vKrhU9ECEPYLs1gF8y35w==
X-Received: by 2002:a05:600c:202:b0:3f7:cb42:fa28 with SMTP id 2-20020a05600c020200b003f7cb42fa28mr2173332wmi.28.1694182079077;
        Fri, 08 Sep 2023 07:07:59 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id t24-20020a1c7718000000b003fee7b67f67sm2055508wmi.31.2023.09.08.07.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:07:58 -0700 (PDT)
Date:   Fri, 8 Sep 2023 15:07:57 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230908140757.haewcuwsumphcv7p@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230907130805.GE10955@noisy.programming.kicks-ass.net>
 <20230908001725.mtqbse3xwhzvo5qp@airbuntu>
 <44fc6d03-c663-53de-e4f7-e56687c5718d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44fc6d03-c663-53de-e4f7-e56687c5718d@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/23 09:40, Dietmar Eggemann wrote:
> On 08/09/2023 02:17, Qais Yousef wrote:
> > On 09/07/23 15:08, Peter Zijlstra wrote:
> >> On Mon, Aug 28, 2023 at 12:31:56AM +0100, Qais Yousef wrote:
> 
> [...]
> 
> > But for the 0.8 and 1.25 margin problems, actually the problem is that 25% is
> > too aggressive/fast and wastes power. I'm actually slowing things down as
> > a result of this series. And I'm expecting some not to be happy about it on
> > their systems. The response_time_ms was my way to give back control. I didn't
> > see how I can make things faster and slower at the same time without making
> > decisions on behalf of the user/sysadmin.
> > 
> > So the connection I see between PELT and the margins or headrooms in
> > fits_capacity() and map_util_perf()/dvfs_headroom is that they expose the need
> > to manage the perf/power trade-off of the system.
> > 
> > Particularly the default is not good for the modern systems, Cortex-X is too
> > powerful but we still operate within the same power and thermal budgets.
> > 
> > And what was a high end A78 is a mid core today. So if you look at today's
> > mobile world topology we really have a tiy+big+huge combination of cores. The
> > bigs are called mids, but they're very capable. Fits capacity forces migration
> > to the 'huge' cores too soon with that 80% margin. While the 80% might be too
> > small for the tiny ones as some workloads really struggle there if they hang on
> > for too long. It doesn't help that these systems ship with 4ms tick. Something
> > more to consider changing I guess.
> 
> If this is the problem then you could simply make the margin (headroom)
> a function of cpu_capacity_orig?

I don't see what you mean. instead of capacity_of() but keep the 80%?

Again, I could be delusional and misunderstanding everything, but what I really
see fits_capacity() is about is misfit detection. But a task is not really
misfit until it actually has a util above the capacity of the CPU. Now due to
implementation details there can be a delay between the task crossing this
capacity and being able to move it. Which what I believe this headroom is
trying to achieve.

I think we can better define this by tying this headroom to the worst case
scenario it takes to actually move this misfit task to the right CPU. If it can
continue to run without being impacted with this delay and crossing the
capacity of the CPU it is on, then we should not trigger misfit IMO.

> 
> [...]
> 
> > There's a question that I'm struggling with if I may ask. Why is it perceived
> > our constant response time (practically ~200ms to go from 0 to max) as a good
> > fit for all use cases? Capability of systems differs widely in terms of what
> > performance you get at say a util of 512. Or in other words how much work is
> > done in a unit of time differs between system, but we still represent that work
> > in a constant way. A task ran for 10ms on powerful System A would have done
> 
> PELT (util_avg) is uarch & frequency invariant.
> 
> So e.g. a task with util_avg = 256 could have a runtime/period
> 
> on big CPU (capacity = 1024) of 4ms/16ms
> 
> on little CPU (capacity = 512) of 8ms/16ms
> 
> The amount of work in invariant (so we can compare between asymmetric
> capacity CPUs) but the runtime obviously differs according to the capacity.

Yep!


Cheers

--
Qais Yousef
