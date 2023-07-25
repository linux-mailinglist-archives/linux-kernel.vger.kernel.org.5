Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25648761808
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjGYMJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjGYMJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:09:01 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73114A3;
        Tue, 25 Jul 2023 05:08:59 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9d16c1f3bso4826259a34.2;
        Tue, 25 Jul 2023 05:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690286939; x=1690891739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqbTYqHPW5G2PshmRl+ifQ5TqeqIDG0r/Sx2QgnUwCM=;
        b=C5V348bba05ggtGk26INvBjn5EZdSpLflXMX91bNHbmcrwtaWa5RlvONcCcvoCuYsz
         PBvpIrIWJP+tYZPZVEKWf57tOMtBx1VALnzqaFhlvxxehhYUwYwb8tovKqngvzQSorsN
         VfmOaxuZjtovZuPMet5dxo+bLLjGXpyy6kxlE+Dp1jXa1zFwehRnqLwdbGApGvCIrtKo
         iIkcfqy+AAgKuLWCCSnnGdnYiRoZwmF369cQRdUJrwYTYdFMnHfjYxqs+PixvAPnACiz
         rHTy4i3g3UXM2h0fFnvvlffQu7VUt+mXzD10nXXnPZZmO3vSKLb8SxgqN90JZ0cmZzcz
         R3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690286939; x=1690891739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqbTYqHPW5G2PshmRl+ifQ5TqeqIDG0r/Sx2QgnUwCM=;
        b=FY24w964jNjXsLHWrp6jO95wZY205l3clCLghnQz6DLTMvPdziqo9YZgCJqjIFuldM
         UD9oL4i+6G/8aYSo7GLXFIDySCrtH3dqi7cYkoc0CgbhXSTjyak6xjlg/1IzDqLAHJet
         fKct8+aU5p6vPXbamTBtE3o9WYRMs82q9QTDdzgUcUWH3ZP2eduVRDOJJYCer0fSG7h/
         hJjrInaufdbo/byVH1Z5lEfCUcfz4P2OQhZ46/MNjVzTMYDKAiIaxCctjVgpI2e1yogm
         3MZzZeJ/3R4FO5/sK0w8R3KgimROjyudb12lNToEzs9A3zo0bE7FI3jVP5J/d4v4hj9n
         EWJw==
X-Gm-Message-State: ABy/qLbQKNjSYftHx1z5d/wlhh9QJIOK715Xn9tMJFudnw06HLUO98sE
        X/jKbGalEAgvVRGKmk2xe77fHinHnc42b9HkL2I=
X-Google-Smtp-Source: APBJJlE3b445OMBoqHVxrvPrZ+9Z+J48d6XyZOeRjIf+UI0qhpXJnjzwusIw+psipvUeiogRxI4xTXEQjCCg/In7FYI=
X-Received: by 2002:a05:6870:f10e:b0:1bb:51e4:9489 with SMTP id
 k14-20020a056870f10e00b001bb51e49489mr9200271oac.11.1690286938581; Tue, 25
 Jul 2023 05:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230719130527.8074-1-xuewen.yan@unisoc.com> <20230721221944.dthg3tf25j4qgc2z@airbuntu>
 <CAB8ipk8b8ZfwXN7KK-zFVPQ-8i37h64v-wz2ErB3AANaZ9w7aA@mail.gmail.com>
 <20230724155328.7odez6dcoafksr3i@airbuntu> <CAB8ipk-VuD2oMDaV6B6i-eoKE+JZ0FpsUZAdT0R5S3to07JkFw@mail.gmail.com>
 <CAJZ5v0gGXyURiqcspDdLf99dKjoFKDRZ=nc55b9OHXRdat8T_w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gGXyURiqcspDdLf99dKjoFKDRZ=nc55b9OHXRdat8T_w@mail.gmail.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 25 Jul 2023 20:08:47 +0800
Message-ID: <CAB8ipk9NBQKjOLurtzTQO8KwQAKLPJ8YGjnLwSo5q1BrPeLSbA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: next_freq need update when
 cpufreq_limits changed
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Xuewen Yan <xuewen.yan@unisoc.com>, viresh.kumar@linaro.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        guohua.yan@unisoc.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Rafael

On Tue, Jul 25, 2023 at 4:51=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Jul 25, 2023 at 4:21=E2=80=AFAM Xuewen Yan <xuewen.yan94@gmail.co=
m> wrote:
> >
> > On Mon, Jul 24, 2023 at 11:53=E2=80=AFPM Qais Yousef <qyousef@layalina.=
io> wrote:
> > >
> > > On 07/24/23 11:36, Xuewen Yan wrote:
> > > > On Sat, Jul 22, 2023 at 7:02=E2=80=AFAM Qais Yousef <qyousef@layali=
na.io> wrote:
> > > > >
> > > > > On 07/19/23 21:05, Xuewen Yan wrote:
> > > > > > When cpufreq's policy is single, there is a scenario that will
> > > > > > cause sg_policy's next_freq to be unable to update.
> > > > > >
> > > > > > When the cpu's util is always max, the cpufreq will be max,
> > > > > > and then if we change the policy's scaling_max_freq to be a
> > > > > > lower freq, indeed, the sg_policy's next_freq need change to
> > > > > > be the lower freq, however, because the cpu_is_busy, the next_f=
req
> > > > > > would keep the max_freq.
> > > > > >
> > > > > > For example:
> > > > > > The cpu7 is single cpu:
> > > > > >
> > > > > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # while true;do =
done&
> > > > > > [1] 4737
> > > > > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # taskset -p 80 =
4737
> > > > > > pid 4737's current affinity mask: ff
> > > > > > pid 4737's new affinity mask: 80
> > > > > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_ma=
x_freq
> > > > > > 2301000
> > > > > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_cu=
r_freq
> > > > > > 2301000
> > > > > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # echo 2171000 >=
 scaling_max_freq
> > > > > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_ma=
x_freq
> > > > > > 2171000
> > > > > >
> > > > > > At this time, the sg_policy's next_freq would keep 2301000.
> > > > > >
> > > > > > To prevent the case happen, add the judgment of the need_freq_u=
pdate flag.
> > > > > >
> > > > > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > > > > Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
> > > > > > Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
> > > > > > ---
> > > > > >  kernel/sched/cpufreq_schedutil.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cp=
ufreq_schedutil.c
> > > > > > index 4492608b7d7f..458d359f5991 100644
> > > > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > > > @@ -350,7 +350,8 @@ static void sugov_update_single_freq(struct=
 update_util_data *hook, u64 time,
> > > > > >        * Except when the rq is capped by uclamp_max.
> > > > > >        */
> > > > > >       if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
> > > > > > -         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next=
_freq) {
> > > > > > +         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next=
_freq &&
> > > > > > +         !sg_policy->need_freq_update) {
> > > > >
> > > > > What about sugov_update_single_perf()? It seems to have the same =
problem, no?
> > > >
> > > > There is no problem in sugov_update_single_perf, because the next_f=
req
> > > > is updated by drivers, maybe the next_freq is not used when using
> > > > sugov_update_single_perf..
> > >
> > > Ah I see; we just use prev_util but the request will go through and t=
he driver
> > > should observe the new limit regardless of what util value we pass to=
 it. Got
> > > ya.
> > >
> > > >
> > > > But  for the last_freq_update_time, I think there are some problems
> > > > when using sugov_update_single_perf:
> > > > Now, there is no judgment condition for the update of the
> > > > last_freq_update_time. That means the last_freq_update_time is alwa=
ys
> > > > updated in sugov_update_single_perf.
> > > > And in sugov_should_update_freq: it would judge the
> > > > freq_update_delay_ns. As a result, If we use the
> > > > sugov_update_single_perf, the cpu frequency would only be periodica=
lly
> > > > updated according to freq_update_delay_ns.
> > > > Maybe we should judge the cpufreq_driver_adjust_perf's return value=
,
> > > > if the freq is not updated, the last_freq_update_time also does not
> > > > have to update.
> > > >
> > > > Just like:
> > > > ---
> > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufre=
q_schedutil.c
> > > > index 458d359f5991..10f18b054f01 100644
> > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -381,6 +381,7 @@ static void sugov_update_single_perf(struct
> > > > update_util_data *hook, u64 time,
> > > >         struct sugov_cpu *sg_cpu =3D container_of(hook, struct
> > > > sugov_cpu, update_util);
> > > >         unsigned long prev_util =3D sg_cpu->util;
> > > >         unsigned long max_cap;
> > > > +       bool freq_updated;
> > > >
> > > >         /*
> > > >          * Fall back to the "frequency" path if frequency invarianc=
e is not
> > > > @@ -407,10 +408,11 @@ static void sugov_update_single_perf(struct
> > > > update_util_data *hook, u64 time,
> > > >             sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
> > > >                 sg_cpu->util =3D prev_util;
> > > >
> > > > -       cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cp=
u->bw_dl),
> > > > +       freq_updated =3D cpufreq_driver_adjust_perf(sg_cpu->cpu,
> > > > map_util_perf(sg_cpu->bw_dl),
> > > >                                    map_util_perf(sg_cpu->util), max=
_cap);
> > > >
> > > > -       sg_cpu->sg_policy->last_freq_update_time =3D time;
> > > > +       if (freq_updated)
> > > > +               sg_cpu->sg_policy->last_freq_update_time =3D time;
> > > >  }
> > >
> > > Sound reasonable in principle, but it could lead to overhead; for exa=
mple when
> > > the system is busy and maxed out, the last_freq_update_time will neve=
r be
> > > updated and will end up continuously calling to the driver to change =
frequency
> > > without any rate limit AFAICS. Which might not be an acceptable overh=
ead,
> > > I don't know. Logically this is wasted cycles preventing the tasks fr=
om doing
> > > useful work. I think we need to look at such corner cases and treat t=
hem
> > > appropriately to not call the driver if we go with this approach.
> >
> > Hi Qais,
> >
> > I can understand what you mean, but I don't think this is a problem.
> > For the driver, the calculation of whether to update the frequency may
> > not be the main time-consuming, but the main time-consuming may be the
> > frequency conversion time of the hardware. If the hardware does not
> > need frequency conversion, the operation of calculating the frequency
> > takes a very short time.
> > If the operation of calling the driver frequently is unacceptable, can
> > prev_util be used?
>
> No, it's better to pass the data to the driver directly and let it
> sort that out in this particular case.

Yes, I know. we should not interfere with the driver's behavior.

By the way, What do you think of the patch fixing the sugov_update_single_f=
req?

Thanks!

---
xuewen

>
> > ---
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sc=
hedutil.c
> > index 4492608b7d7f..3febfd032eee 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -379,7 +379,9 @@ static void sugov_update_single_perf(struct
> > update_util_data *hook, u64 time,
> >  {
> >         struct sugov_cpu *sg_cpu =3D container_of(hook, struct
> > sugov_cpu, update_util);
> >         unsigned long prev_util =3D sg_cpu->util;
> > +       unsigned long prev_bw_dl =3D sg_cpu->bw_dl;
> >         unsigned long max_cap;
> > +       bool freq_updated;
> >
> >         /*
> >          * Fall back to the "frequency" path if frequency invariance is=
 not
> > @@ -406,10 +408,14 @@ static void sugov_update_single_perf(struct
> > update_util_data *hook, u64 time,
> >             sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
> >                 sg_cpu->util =3D prev_util;
> >
> > -       cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->b=
w_dl),
> > +       if (prev_util =3D=3D sg_cpu->util && prev_bw_dl =3D=3D sg_cpu->=
bw_dl)
> > +               return;
> > +
> > +       freq_updated =3D cpufreq_driver_adjust_perf(sg_cpu->cpu,
> > map_util_perf(sg_cpu->bw_dl),
> >                                    map_util_perf(sg_cpu->util), max_cap=
);
> >
> > -       sg_cpu->sg_policy->last_freq_update_time =3D time;
> > +       if (freq_updated)
> > +               sg_cpu->sg_policy->last_freq_update_time =3D time;
> >  }
> >
> >  static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u=
64 time)
> >
> >
> > BR
> > ---
> > xuewen
> > >
> > >
> > > Cheers
> > >
> > > --
> > > Qais Yousef
> > >
> > > >
> > > >
> > > > BR
> > > > Thanks!
> > > >
> > > > ---
> > > > xuewen
> > > > >
> > > > > LGTM otherwise.
> > > > >
> > > > >
> > > > > Cheers
> > > > >
> > > > > --
> > > > > Qais Yousef
> > > > >
> > > > > >               next_f =3D sg_policy->next_freq;
> > > > > >
> > > > > >               /* Restore cached freq as next_freq has changed *=
/
> > > > > > --
> > > > > > 2.25.1
> > > > > >
