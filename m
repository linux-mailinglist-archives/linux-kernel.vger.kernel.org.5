Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FAD7604FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjGYCCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGYCCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:02:02 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3AF10EF;
        Mon, 24 Jul 2023 19:02:01 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1bb571ea965so1672702fac.0;
        Mon, 24 Jul 2023 19:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690250520; x=1690855320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTvSWbkjA+14tviFPtc6ENPHaYeKtI5EUeqn7dS9Ih4=;
        b=R3h6tq4xVbAvAZ5BYduxZpo+1vk2oNZZrISipKxyf1bHn9EubFi9H8nV3EGv8X5HtK
         O8LTQsceIQBS4Jy+/FbePFBYRt03Z+iK7rf00LTpvJvOxKyndwb4RBmKeaCOGp3ns2Wl
         UhL4WHbyjjq6HbgtJX7aG/zMFm85tGdewUI/7O7au2+/viN7x7p2ieSajy0H/zr5aOo/
         dbFNVs9/gEFOhmda+Of2ya4NtqlYNzopCk2NLXNL+e5ofc77147WAweQxcFPuClKM7o6
         wsLJpIPytV/t+vvhqwRqo8iFjcT2jOstVtwhhDrzMuj8C3BcZxO3zecySnTgo8TRNX+Z
         ZMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690250520; x=1690855320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTvSWbkjA+14tviFPtc6ENPHaYeKtI5EUeqn7dS9Ih4=;
        b=eGhSGKu2KHrF/qD3xAI3kHXWH8+8anBBPxv2JVRqr4OrsI9cFaS+p1CMIcc9j48+lv
         nsoBR3ht06PBhgwmp8gaTp6Wk8A/DIeOYByD1vyv0CDZ0OGOjhoivETMMM8NI/Nm11Ts
         zx09fEogxAw7bnozDTa/P7byXyqJnoX1m35QCZG2GUlmDCB0+e7CBUEZ1gYJn3Sk+j3H
         IPtbeZLmzug5grKV7nOAPYFzDC99KHBXrBjt+waKxdXY98DMM0pyIvDxA0xPbzE8MC2X
         NaD9WcpuguZcCFAcTaQf/XYey/ce2UivXwEu0UNxwSWl5a+SUrYjn60RvWMOP2/YDc0Y
         Ezog==
X-Gm-Message-State: ABy/qLaIFQMYlAYwL0HZzDYJtwqNA7V/2XT3ohtwMLFqCg8VA0H2Ml6L
        DVGhvkFYotbg6QpF/Et4aW6OM9kLfL3v5PyddjE=
X-Google-Smtp-Source: APBJJlEl8F38eCWK9GOfrLiFbHZsO5XCzSSIcxiAMm1LjLb9etzSDppTe2qUaoD1W+Jr/6HuiAkqMQXooXzcxaSLKCc=
X-Received: by 2002:a05:6870:d7a8:b0:1bb:831b:79e6 with SMTP id
 bd40-20020a056870d7a800b001bb831b79e6mr3509525oab.16.1690250520248; Mon, 24
 Jul 2023 19:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230719130527.8074-1-xuewen.yan@unisoc.com> <20230721221944.dthg3tf25j4qgc2z@airbuntu>
 <CAB8ipk8b8ZfwXN7KK-zFVPQ-8i37h64v-wz2ErB3AANaZ9w7aA@mail.gmail.com> <18b0d54b-f8d2-ff38-f5c8-697dc838e3ce@arm.com>
In-Reply-To: <18b0d54b-f8d2-ff38-f5c8-697dc838e3ce@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 25 Jul 2023 10:01:49 +0800
Message-ID: <CAB8ipk-DOAE8u5eYmfR9RaP57Y494z5CtUkCVTPQDzSxE7Rwwg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: next_freq need update when
 cpufreq_limits changed
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, guohua.yan@unisoc.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On Mon, Jul 24, 2023 at 11:33=E2=80=AFPM Pierre Gondois <pierre.gondois@arm=
.com> wrote:
>
>
>
> On 7/24/23 05:36, Xuewen Yan wrote:
> > On Sat, Jul 22, 2023 at 7:02=E2=80=AFAM Qais Yousef <qyousef@layalina.i=
o> wrote:
> >>
> >> On 07/19/23 21:05, Xuewen Yan wrote:
> >>> When cpufreq's policy is single, there is a scenario that will
> >>> cause sg_policy's next_freq to be unable to update.
> >>>
> >>> When the cpu's util is always max, the cpufreq will be max,
> >>> and then if we change the policy's scaling_max_freq to be a
> >>> lower freq, indeed, the sg_policy's next_freq need change to
> >>> be the lower freq, however, because the cpu_is_busy, the next_freq
> >>> would keep the max_freq.
> >>>
> >>> For example:
> >>> The cpu7 is single cpu:
> >>>
> >>> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # while true;do done&
> >>> [1] 4737
> >>> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # taskset -p 80 4737
> >>> pid 4737's current affinity mask: ff
> >>> pid 4737's new affinity mask: 80
> >>> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
> >>> 2301000
> >>> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_cur_freq
> >>> 2301000
> >>> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # echo 2171000 > scali=
ng_max_freq
> >>> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
> >>> 2171000
> >>>
> >>> At this time, the sg_policy's next_freq would keep 2301000.
> >>>
> >>> To prevent the case happen, add the judgment of the need_freq_update =
flag.
> >>>
> >>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> >>> Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
> >>> Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
> >>> ---
> >>>   kernel/sched/cpufreq_schedutil.c | 3 ++-
> >>>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_=
schedutil.c
> >>> index 4492608b7d7f..458d359f5991 100644
> >>> --- a/kernel/sched/cpufreq_schedutil.c
> >>> +++ b/kernel/sched/cpufreq_schedutil.c
> >>> @@ -350,7 +350,8 @@ static void sugov_update_single_freq(struct updat=
e_util_data *hook, u64 time,
> >>>         * Except when the rq is capped by uclamp_max.
> >>>         */
> >>>        if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
> >>> -         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq)=
 {
> >>> +         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq =
&&
> >>> +         !sg_policy->need_freq_update) {
> >>
> >> What about sugov_update_single_perf()? It seems to have the same probl=
em, no?
> >
> > There is no problem in sugov_update_single_perf, because the next_freq
> > is updated by drivers, maybe the next_freq is not used when using
> > sugov_update_single_perf..
> >
> > But  for the last_freq_update_time, I think there are some problems
> > when using sugov_update_single_perf:
> > Now, there is no judgment condition for the update of the
> > last_freq_update_time. That means the last_freq_update_time is always
> > updated in sugov_update_single_perf.
> > And in sugov_should_update_freq: it would judge the
> > freq_update_delay_ns. As a result, If we use the
> > sugov_update_single_perf, the cpu frequency would only be periodically
> > updated according to freq_update_delay_ns.
> > Maybe we should judge the cpufreq_driver_adjust_perf's return value,
> > if the freq is not updated, the last_freq_update_time also does not
> > have to update.
> >
> > Just like:
> > ---
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sc=
hedutil.c
> > index 458d359f5991..10f18b054f01 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -381,6 +381,7 @@ static void sugov_update_single_perf(struct
> > update_util_data *hook, u64 time,
> >          struct sugov_cpu *sg_cpu =3D container_of(hook, struct
> > sugov_cpu, update_util);
> >          unsigned long prev_util =3D sg_cpu->util;
> >          unsigned long max_cap;
> > +       bool freq_updated;
> >
> >          /*
> >           * Fall back to the "frequency" path if frequency invariance i=
s not
> > @@ -407,10 +408,11 @@ static void sugov_update_single_perf(struct
> > update_util_data *hook, u64 time,
> >              sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
> >                  sg_cpu->util =3D prev_util;
> >
> > -       cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->b=
w_dl),
> > +       freq_updated =3D cpufreq_driver_adjust_perf(sg_cpu->cpu,
> > map_util_perf(sg_cpu->bw_dl),
> >                                     map_util_perf(sg_cpu->util), max_ca=
p);
> >
> > -       sg_cpu->sg_policy->last_freq_update_time =3D time;
> > +       if (freq_updated)
> > +               sg_cpu->sg_policy->last_freq_update_time =3D time;
> >   }
> >
>
> Hello Xuewen,
> FWIW, the patch and explanation for sugov_update_single_perf() seem sensi=
ble to
> me. Just a comment about cpufreq_driver_adjust_perf() and
> (struct cpufreq_driver)->adjust_perf(): wouldn't their prototype need to =
be
> updated (i.e. not return void) to do the change suggested above ?

Yes, their function type should be changed from void to bool or init.
For this patch, I just raise a question for everyone to discuss. If
this is a problem, the official patch needs to be revised later.

BR
xuewen

>
> Regards,
> Pierre
>
> >
> > BR
> > Thanks!
> >
> > ---
> > xuewen
> >>
> >> LGTM otherwise.
> >>
> >>
> >> Cheers
> >>
> >> --
> >> Qais Yousef
> >>
> >>>                next_f =3D sg_policy->next_freq;
> >>>
> >>>                /* Restore cached freq as next_freq has changed */
> >>> --
> >>> 2.25.1
> >>>
> >
