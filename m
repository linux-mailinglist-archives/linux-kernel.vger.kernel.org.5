Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010307DC9DF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjJaJtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjJaJtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:49:01 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D6ED8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:48:58 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-584a761b301so4316447a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698745738; x=1699350538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rYhUK3Ef9ZtO2nV4gKtW07Ip2faB9tXLb6bMWZbknSY=;
        b=FVdlKeYNVbGwEj3wWYnJ5gODeiJ5bwzsZvcEPknKdezwtdQudLj4cg0uBWfIOpVTHO
         a99vfA04iUnIAHecg4wJtKl+CsM7j1DPCx89szuF+eZxkAc/2w9YHlVzk9MUE0lsHQBB
         8FU3rtRTAx1c+VjjTZ3sGjSR8QXJhpoLcrspLZgOhZ+ZR2ST/GS8NSqvcBklPeMr+4AC
         CPWnjE7sDrXZFpainFHvOUR3uXIFHh44YjEL8VEiHKjmH1wBVasrizRrA6hQ534f8BOk
         fgnS9kvwnala+iYDC6TQfVQs/SKJRr2uw4a/29ExQzKhLDYu5UjeQZfno/E4xlM2evr3
         PE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698745738; x=1699350538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYhUK3Ef9ZtO2nV4gKtW07Ip2faB9tXLb6bMWZbknSY=;
        b=eL40EaAu3iVcSUDyxuhwEgfKWiqArVKu1oxDVMe7bGdEd0XLhcY/6YvXSFV4lS9jGm
         fES4weG3f5g1++CXxJONFs8jjwtJ35A4gAhgH8TCNNFndf60gYmLX7weLIRL95Mj7SE5
         1Jub8EPoGjt9/pOFGeC1I86qDpqaltQhpZ0ajTxOq/3os7Mfy7TbZVyZmbgsz6g3i+v5
         zoDlK5cuLFjrwG8SLZv5/OAq2s79nH4/ys/MIEESea1wRu7a8ltccZGyJjsSA5M/45Vj
         +wT0pevzjdAtk7IEUv2rAUgA6PKByryual3YSrrpgywsmHJypb5EzBWjQ0CyElkyEVRl
         zoeA==
X-Gm-Message-State: AOJu0Yxnj458KWRgG+hJPmAq9aGGPAsW4qNZPxi8J52A9X1LENFn6fej
        5Zf0K2AJX4WlrQhDSd+nCFESIg1ue02rhcD2b0JYxA==
X-Google-Smtp-Source: AGHT+IFodctCoBfntSB97ytv+c3eYTsmabXo8s/B2A8Y0mzQyyrkapI4MRtIqtFwOVg6oauPSK49g6vsxsHjXcSIwik=
X-Received: by 2002:a17:90a:19ce:b0:280:2985:56af with SMTP id
 14-20020a17090a19ce00b00280298556afmr7095622pjj.45.1698745738085; Tue, 31 Oct
 2023 02:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231026170913.32605-1-vincent.guittot@linaro.org>
 <20231026170913.32605-2-vincent.guittot@linaro.org> <83d6a790-3d18-4922-850b-b60e88761786@arm.com>
In-Reply-To: <83d6a790-3d18-4922-850b-b60e88761786@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 31 Oct 2023 10:48:46 +0100
Message-ID: <CAKfTPtCLc3z6k9MwW6XKHjbh78AFrAg1T1MONYtf8N8GGR6fGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/schedutil: rework performance estimation
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     wyes.karny@amd.com, peterz@infradead.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, vschneid@redhat.com, bristot@redhat.com,
        bsegall@google.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, beata.michalska@arm.com,
        linux-kernel@vger.kernel.org, qyousef@layalina.io,
        viresh.kumar@linaro.org, mingo@redhat.com, mgorman@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Mon, 30 Oct 2023 at 18:45, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Vincent,
>
> On 10/26/23 18:09, Vincent Guittot wrote:
> > The current method to take into account uclamp hints when estimating the
> > target frequency can end into situation where the selected target
> > frequency is finally higher than uclamp hints whereas there are no real
> > needs. Such cases mainly happen because we are currently mixing the
> > traditional scheduler utilization signal with the uclamp performance
> > hints. By adding these 2 metrics, we loose an important information when
> > it comes to select the target frequency and we have to make some
> > assumptions which can't fit all cases.
> >
> > Rework the interface between the scheduler and schedutil governor in order
> > to propagate all information down to the cpufreq governor.
> >
> > effective_cpu_util() interface changes and now returns the actual
> > utilization of the CPU with 2 optional inputs:
> > - The minimum performance for this CPU; typically the capacity to handle
> >    the deadline task and the interrupt pressure. But also uclamp_min
> >    request when available.
> > - The maximum targeting performance for this CPU which reflects the
> >    maximum level that we would like to not exceed. By default it will be
> >    the CPU capacity but can be reduced because of some performance hints
> >    set with uclamp. The value can be lower than actual utilization and/or
> >    min performance level.
>
> You have probably missed my question in the last v1 patch set.

Yes, sorry

>
> The description above needs a bit of clarification, since looking at the
> patches some dark corners are introduced IMO:
>
> Currently, we have a less aggressive power saving policy than this
> proposal.
>
> The questions:
> What if the PD has 4 CPUs, the max util found is 500 and is from a CPU
> w/ uclamp_max, but there is another CPU with normal utilization 499?
> What should be the final frequency for that PD?

We now follow the same sequence everywhere which can be summarized by:

for each cpu sharing the same frequency domain:
    util = cpu_util(cpu)
    eff_util = effective_cpu_util(util, &min, &max)
    eff_util = sugov_effective_cpu_perf(eff_util, min, max) which
applies the dvfs headroom if needed
    max_util = max(max_util, eff_util);

EAS anticipates the impact of the waking task on utilization and max
but the end result is the same as above once the task is enqueued so I
didn't show it for simplicity

Coming back to your example
  CPU0 has uclamp_max = 500 and an actual utilization above 500. Its
eff_util will be 500
  CPU1 doesn't have uclamp_max constraint and an actual utilization of
499 which will be increase with dvfs headroom to 623 in
sugov_effective_cpu_perf()

The final max util will be 623

With the current implementation we apply the dvfs headroom to the
final max_util (which is the CPU0 with uclamp_max == 500) whereas we
now apply the dvfs headroom on each CPU inside
sugov_effective_cpu_perf()

The main difference is that if CPU1 has an actual utilization of 400,
the max_util of the frequency domain will be 500 whereas it is 625
after applying dvfs headroom with current implementation

>
> In current design, where we care more about 'delivered performance
> to the tasks' than power saving, the +20% would be applied for the
> frequency. Therefore if that CPU with 499 util doesn't have uclamp_max,
> it would get a decent amount of idle time for its tasks (to compensate
> some workload variation).

CPU1 with 499 still gets its 25% margin or I missed something in your example ?

Vincent

>
> Regards,
> Lukasz
