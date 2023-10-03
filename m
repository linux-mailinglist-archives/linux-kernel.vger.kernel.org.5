Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EE77B74B2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjJCXUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjJCXUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:20:03 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6D4B7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:20:00 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-65b05a45046so8864206d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696375199; x=1696979999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gr7ytQSJEM4PWJG3owCYuTV0LHc0RIEGtoAXWdi3SNg=;
        b=yYw8l/1eiy1Myk1W16vewJKyq8FpO+KWXY4vJdD+R+VF2xjMwv3GH+ri9Upmyc3jpw
         g9DrOpaHno8je8n86wkovmFhfbnJmTekG26j7eGxPkXpiRyOX/FiyXQwAXxj6MTm5QEV
         6K4ODDXnV8ycZ11A44gl6hrIhysjooPI025iD06lcF+sEU96Zym9iDVz8TazJwLZlH3J
         Oq++uv83zRQMeKKDTcm3yLj9Tu4m219B8fhaFY+qwpem5YYrXINpOWyeXjoKdt1yy1oa
         cA5j13k4gnk7j0ClrMnkfUAfD6jRAWkqC6i8vBHl6ora3CsAV32+y0aZrCOYLEbYnOdc
         SvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375199; x=1696979999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gr7ytQSJEM4PWJG3owCYuTV0LHc0RIEGtoAXWdi3SNg=;
        b=AF68PYi5cAZ3DhSBXjvmQiz06P7f4hKG6E1Et58Zkgna/RfXyNZw1HsvkjkJy3omLo
         +enWhF4D3hxcK54KVNIsUJmNiY8XcSe93vSHabDCjCyuU2xT8GBQlQiVtaTb5G+HeI0O
         dw7vZ6tKmuhMXOROAtf0gW+qsA/ahqeJxXzh3wI+IX6tH1vio/wvG4IcozIWi19IV6c9
         dwWIqimN8WnLAvlin9d4O+n453I+T77dGsmLC4Nk9whZ116NYlszEE7j6L/5JgL40L4R
         l5Wc0ZTLLy0JSC+KF8BfR9/zkgyM/ChlaYBNavsTAa2fYaa94VSD2yNE42PfI6iqZ6Vs
         f6Fg==
X-Gm-Message-State: AOJu0YyC21E56qxs08pO5djY6N8x6LN07yMxvbETO9r7zMgcK8qN3FZt
        CVKdkA2MACwbZ2XiaEJLzA01wX8eK/UFeiGhqsOK/uMfQ61wlWDKQZQpjQ==
X-Google-Smtp-Source: AGHT+IEvcQMu5FYspnUWqyzdr864IyyKrLUeCq8snH2RJ9JYBBcfVNju2ylFkqYJnFUTc3dhG3NAbzygacLHjcPfK18=
X-Received: by 2002:a0c:f04c:0:b0:64f:43e9:b34d with SMTP id
 b12-20020a0cf04c000000b0064f43e9b34dmr703500qvl.50.1696375198976; Tue, 03 Oct
 2023 16:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com> <CAL715WJxmMbXkZSE3p_+ODGxabgrXREsBo9aFu9G9=qkYZeH9A@mail.gmail.com>
 <CAP-5=fUjNiDv=KQ7t8jqfOfOt5i8HGvt8Vv1hn2-hLxX_Kqucg@mail.gmail.com>
 <CAL715W+GQuCJm-1SEsNN2qnHghNL1SrzwH9Km5K8UxubEFfYVw@mail.gmail.com>
 <CAM9d7cgKWi0fafwTxSrKLrVZxcwnhwMGz=oNkAsNdOjDwF6pEA@mail.gmail.com> <CAP-5=fWXXi7Y=6Q0k8oLOZmYon+vvg-k4dNUSex_ijcL8ti9sQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWXXi7Y=6Q0k8oLOZmYon+vvg-k4dNUSex_ijcL8ti9sQ@mail.gmail.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Tue, 3 Oct 2023 16:19:22 -0700
Message-ID: <CAL715WJ8w+q_=0_NVZJ=rs0GLs=pYqDiRLcCxxO0gDcGdcvZnw@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To:     Ian Rogers <irogers@google.com>, Jim Mattson <jmattson@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Jihong <yangjihong1@huawei.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 3:36=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Oct 3, 2023 at 1:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > Hello,
> >
> > On Wed, Sep 20, 2023 at 10:05=E2=80=AFPM Mingwei Zhang <mizhang@google.=
com> wrote:
> > >
> > > On Mon, Sep 18, 2023 at 3:43=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > On Sat, Sep 16, 2023 at 5:46=E2=80=AFPM Mingwei Zhang <mizhang@goog=
le.com> wrote:
> > > > > Thank you very much for the change. I have one quick question abo=
ut
> > > > > the PMU unthrottling logic. When I am looking into the function
> > > > > perf_adjust_freq_unthr_context(), I see the loop with PMU stop an=
d
> > > > > start in each iteration. Is there a good way to avoid this PMU re=
set
> > > > > operation while quickly figuring out the event in frequency mode?
> > > >
> > > > Agreed. I think before the pmu_disable could be avoided for this co=
ndition:
> > > > ```
> > > > if (event->hw.interrupts !=3D MAX_INTERRUPTS &&
> > > >     (!event->attr.freq || !event->attr.sample_freq))
> > > >         continue;
> > > > ```
> > > > Fixing up the event stop/start looks harder.
> > > >
> > >
> > > Right, I think putting the check early before pmu_disable() is alread=
y
> > > a great optimization. The only concern I initially had was whether
> > > event->hw.interrupts can be accessed before we disable the pmu. But
> > > after checking this field in other locations, I don't see any problem
> > > at all.
> >
> > The event->hw.interrupts would be increased in the NMI handler
> > so there is a race between the check and the NMI.  That's why
> > I think it checks that after disabling the PMU.
> >
> > But I think we can skip non-sampling events for sure.  Then it
> > would be better to set attr.sample_period =3D 0 rather than attr.freq.
> >
> >     if (!is_sampling_event(event))
> >         continue;
> >
> >     perf_pmu_disable(event->pmu);
> >     ...
> >
> > Thanks,
> > Namhyung
>
> With the PMU disabled, isn't there still a risk of an interrupt still
> being in flight? In other words the disable doesn't prevent a race and
> we'll catch this on the next timer call to
> perf_adjust_freq_unthr_context. I think we can also improve the code
> by just disabling a PMU once, we can take advantage of the
> perf_event_pmu_context and disable that PMU, iterate its events and
> then re-enable the PMU - i.e. no need for an enable and disable per
> event. I'll put a patch together.
>
> Thanks,
> Ian

+Jim Mattson

I initially thought this idea was just an alternative, or a more
professional fix in the perf subsystem. I was wrong...

This would be way better than just skipping frequency events in the
loop. Since if we just skip by event, we may still suffer from huge
overhead if the event list contains many sampling events in frequency
mode. Unfortunately, that is the general case when we do perf record
-e 'eventlist' (IIUC all events in eventlist are in frequency mode if
we don't specify period=3D). So the problem actually remains whenever we
do perf sampling unless we use something like Intel vtune.

On the other hand, since all of the events are presumably CPU core
events, with the fix we pay only once for the PMU reset per hrtimer
regardless of how many events are in frequency mode.

Looking forward to the patch! Please keep us posted if possible.

Thanks.
-Mingwei
