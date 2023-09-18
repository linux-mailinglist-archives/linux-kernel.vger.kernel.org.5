Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBBE7A55D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjIRWnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIRWnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:43:15 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09399A4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:43:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41761e9181eso75641cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695076989; x=1695681789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkA2tP7ShROmXYUca5ROVTkzc0fQkfspEmj0l8gwITc=;
        b=td/IUMc2bAXCwg1wNRAGk0f0C7WuUXgoHY1GN71ibsCIUPEHJTxXE1cpRMimda/UUs
         r6GmZOuTaA3YFoIUTTgdJiEDFRHf/Fs2hZoHLr76UxAwt8GJxJ5vBS05WSrVMpA6yPEi
         MCt1gj0MTsOw5ad+G+5Hd+lCp0aiOL9v1UietF0GGMw8cIxz5orRaygb//MMrAm8OUiE
         2S1fcExJF1nmFVD4mPYEl/qZ2XACKZEJ+sRO84cUvol4iBKNZ6wWZrhHPqRpkC/mG7oj
         ndKhMmf+pGFeMkcOAPd5T2WAdl7cF5DRMvyteYphsGr9DGsNqpT03etAB9WzT+wvOSKC
         kfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695076989; x=1695681789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkA2tP7ShROmXYUca5ROVTkzc0fQkfspEmj0l8gwITc=;
        b=rVg0pbO3dRep13DC2XB/SwPls4Gn4JqCWqT3R8T8epnTwofllRuCaBXLKC3mO7wPWW
         xeCRnReUIT6/Mz+FlWhiQx3hpm6b3+12+GWRsEaWS48dfPg4achRfz1ddwgTRhQU+9qY
         wi4SjmoQeRqY27TLS2QHqA4dQSIKy5njvpmVn7qr52hkIrb9cgmPHVP5HAlMeEy7vb8R
         nXIiqVVHr74AzCnM6NVfjea+xRlSMZprcuh4soN8Z/1Gk/5PGLZWuLRIpeTQm4MrjBCs
         x2C3UmncCI6zye9yMNc5xARTpIcj1oZe4aWe8HAZ848ZvjQi/ZO3G99bLLM7ACRU9bTA
         UnMA==
X-Gm-Message-State: AOJu0YwjUMaL/bgIDt9MDvgvizMOJOSz6Jf0M1SN/AEJFa3T9iq+rZTL
        ZAVRtS4w6t6sKXnykG2UkfCmBAnwrxt4nuF9E83cug==
X-Google-Smtp-Source: AGHT+IGkyLJEmxr6+28yK7YcgQDu8sMFGox3exomPip397JrALaD6XitMWzJFjqljMbCkZFmPubsuWj8e+HyDsjxDVc=
X-Received: by 2002:ac8:5bcd:0:b0:410:839d:941d with SMTP id
 b13-20020ac85bcd000000b00410839d941dmr109702qtb.20.1695076989011; Mon, 18 Sep
 2023 15:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com> <CAL715WJxmMbXkZSE3p_+ODGxabgrXREsBo9aFu9G9=qkYZeH9A@mail.gmail.com>
In-Reply-To: <CAL715WJxmMbXkZSE3p_+ODGxabgrXREsBo9aFu9G9=qkYZeH9A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 18 Sep 2023 15:42:57 -0700
Message-ID: <CAP-5=fUjNiDv=KQ7t8jqfOfOt5i8HGvt8Vv1hn2-hLxX_Kqucg@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 5:46=E2=80=AFPM Mingwei Zhang <mizhang@google.com> =
wrote:
>
> On Fri, Sep 15, 2023 at 9:10=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Dummy events are created with an attribute where the period and freq
> > are zero. evsel__config will then see the uninitialized values and
> > initialize them in evsel__default_freq_period. As fequency mode is
> > used by default the dummy event would be set to use frequency
> > mode. However, this has no effect on the dummy event but does cause
> > unnecessary timers/interrupts. Avoid this overhead by setting the
> > period to 1 for dummy events.
> >
> > evlist__add_aux_dummy calls evlist__add_dummy then sets freq=3D0 and
> > period=3D1. This isn't necessary after this change and so the setting i=
s
> > removed.
> >
> > From Stephane:
> >
> > The dummy event is not counting anything. It is used to collect mmap
> > records and avoid a race condition during the synthesize mmap phase of
> > perf record. As such, it should not cause any overhead during active
> > profiling. Yet, it did. Because of a bug the dummy event was
> > programmed as a sampling event in frequency mode. Events in that mode
> > incur more kernel overheads because on timer tick, the kernel has to
> > look at the number of samples for each event and potentially adjust
> > the sampling period to achieve the desired frequency. The dummy event
> > was therefore adding a frequency event to task and ctx contexts we may
> > otherwise not have any, e.g., perf record -a -e
> > cpu/event=3D0x3c,period=3D10000000/. On each timer tick the
> > perf_adjust_freq_unthr_context() is invoked and if ctx->nr_freq is
> > non-zero, then the kernel will loop over ALL the events of the context
> > looking for frequency mode ones. In doing, so it locks the context,
> > and enable/disable the PMU of each hw event. If all the events of the
> > context are in period mode, the kernel will have to traverse the list f=
or
> > nothing incurring overhead. The overhead is multiplied by a very large
> > factor when this happens in a guest kernel. There is no need for the
> > dummy event to be in frequency mode, it does not count anything and
> > therefore should not cause extra overhead for no reason.
> >
> > Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dummy con=
structor")
> > Reported-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evlist.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 25c3ebe2c2f5..e36da58522ef 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(struct evl=
ist *evlist)
> >                 .type   =3D PERF_TYPE_SOFTWARE,
> >                 .config =3D PERF_COUNT_SW_DUMMY,
> >                 .size   =3D sizeof(attr), /* to capture ABI version */
> > +               /* Avoid frequency mode for dummy events to avoid assoc=
iated timers. */
> > +               .freq =3D 0,
> > +               .sample_period =3D 1,
> >         };
> >
> >         return evsel__new_idx(&attr, evlist->core.nr_entries);
> > @@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct evlist *=
evlist, bool system_wide)
> >         evsel->core.attr.exclude_kernel =3D 1;
> >         evsel->core.attr.exclude_guest =3D 1;
> >         evsel->core.attr.exclude_hv =3D 1;
> > -       evsel->core.attr.freq =3D 0;
> > -       evsel->core.attr.sample_period =3D 1;
> >         evsel->core.system_wide =3D system_wide;
> >         evsel->no_aux_samples =3D true;
> >         evsel->name =3D strdup("dummy:u");
> > --
> > 2.42.0.459.ge4e396fd5e-goog
> >
>
> Thank you very much for the change. I have one quick question about
> the PMU unthrottling logic. When I am looking into the function
> perf_adjust_freq_unthr_context(), I see the loop with PMU stop and
> start in each iteration. Is there a good way to avoid this PMU reset
> operation while quickly figuring out the event in frequency mode?

Agreed. I think before the pmu_disable could be avoided for this condition:
```
if (event->hw.interrupts !=3D MAX_INTERRUPTS &&
    (!event->attr.freq || !event->attr.sample_freq))
        continue;
```
Fixing up the event stop/start looks harder.

Thanks,
Ian

> Thanks.
> -Mingwei
