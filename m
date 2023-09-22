Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372CB7AB46C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjIVPFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjIVPFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:05:40 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BF6C6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:05:33 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41761e9181eso309531cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695395133; x=1695999933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcyhHe0w7Sbcegi0kd6uPadSKLO2Cun8OwrGqBJxXQE=;
        b=kLGz2SzLQdLn5sRl9l58H5hcqPL4u3+9BIrrwt8dL9hZoY/S0SZsX3Vum6r08PKhTk
         wWZYFOOl1yIbE9qemn8KkNLqCZcThDpvCzP/EqNpA7YWNTLBwcgE+2+ErzJrAt4kcaBx
         JeoN0pkXENvYtITpjjJwv8O3bNzGVJaEw63AP7err3GFpy+AxmajPkm6PrgAxfeGA9kX
         w2QzSDMfQMqSPpC7zVkhhrqYnH5GU/aFx1JfKaw4vLB9d3bkjzOFAAvlYB81/IKyP+x9
         Re29TRfjOgweNI2y038/D2Yrqj+KCmw4CviD/6UUg9FrZLrBYrdrO8Fm4MSXr08R+IbN
         tluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695395133; x=1695999933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcyhHe0w7Sbcegi0kd6uPadSKLO2Cun8OwrGqBJxXQE=;
        b=HbAMit0DKeC3zBPfr+PkOA0PQ3Af4Ga2ysiPeLApb6D/8naNQFquVOMCQ7XuyZUVdM
         iUCECUmsF5gzL/3LsKuGVBfkCxGzd7rDTtN0qIexyuNUOZolfc4LzCtCp/QeolQ7wCB6
         d1z4baO8Ft3f/OjKeG7NGj00UepaZljb3vofBBFR4Y0vbXfkJyOBpXFYEU4xzFaJ6MrC
         48k5U/Xsx5x++G7GbxBkPGCBUtwY0E9Q9WgHN9DL/12ZmEUf5WvPtDVGDhB1bcfVWzvY
         hyFi5wju+Sq2rB/vMJddR3ubqTGQS7135dHsNSbhXsG9tYJv8Ors3JUUkL2kEg3tN0Co
         lJvA==
X-Gm-Message-State: AOJu0YwZYpgEnb+JJcs+VZtvrnnMyt/YOzagWGgrTp0u1jrKYhlgym7g
        gKtuXWLBctDLYBGF89AgUiAXjuXrvXmtIikhsvyDKoHa0hwOsGUBCWYv6Q==
X-Google-Smtp-Source: AGHT+IGsppoxkydfRnq+WRxAx37ICAESNT7n0HKsIqMY8xmaXdZvCG9jyD5B074HsDzgCzdiRg/BlmsDJlRoGllpphA=
X-Received: by 2002:a05:622a:1191:b0:403:eeb9:a76 with SMTP id
 m17-20020a05622a119100b00403eeb90a76mr183776qtk.17.1695395132835; Fri, 22 Sep
 2023 08:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com> <08995efc-d5af-6ba6-831b-1a483daabef4@intel.com>
 <CAP-5=fW783G9fUEHrmzUu7UmvOm65Fp6vAQybCcNz2C0QRz26w@mail.gmail.com>
 <8086150e-3c6d-4001-b3cc-bb12ebe15928@intel.com> <CAM9d7chtVQqySGOGQrA065Fr8M2Y6jg9JJccYtMycQFvaheU+Q@mail.gmail.com>
 <f64c4283-6ced-411a-b69f-8c4375fb91f7@intel.com>
In-Reply-To: <f64c4283-6ced-411a-b69f-8c4375fb91f7@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 22 Sep 2023 08:05:21 -0700
Message-ID: <CAP-5=fWJzpQ14CQk+Lf5EY4CwJ4ACPsYT49XJwCnC_qEpS-DAA@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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

On Thu, Sep 21, 2023 at 10:36=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 21/09/23 22:26, Namhyung Kim wrote:
> > Hi,
> >
> > On Mon, Sep 18, 2023 at 11:00=E2=80=AFPM Adrian Hunter <adrian.hunter@i=
ntel.com> wrote:
> >>
> >> On 19/09/23 00:48, Ian Rogers wrote:
> >>> On Mon, Sep 18, 2023 at 1:14=E2=80=AFAM Adrian Hunter <adrian.hunter@=
intel.com> wrote:
> >>>>
> >>>> On 16/09/23 07:09, Ian Rogers wrote:
> >>>>> Dummy events are created with an attribute where the period and fre=
q
> >>>>> are zero. evsel__config will then see the uninitialized values and
> >>>>> initialize them in evsel__default_freq_period. As fequency mode is
> >>>>> used by default the dummy event would be set to use frequency
> >>>>> mode. However, this has no effect on the dummy event but does cause
> >>>>> unnecessary timers/interrupts. Avoid this overhead by setting the
> >>>>> period to 1 for dummy events.
> >>>>>
> >>>>> evlist__add_aux_dummy calls evlist__add_dummy then sets freq=3D0 an=
d
> >>>>> period=3D1. This isn't necessary after this change and so the setti=
ng is
> >>>>> removed.
> >>>>>
> >>>>> From Stephane:
> >>>>>
> >>>>> The dummy event is not counting anything. It is used to collect mma=
p
> >>>>> records and avoid a race condition during the synthesize mmap phase=
 of
> >>>>> perf record. As such, it should not cause any overhead during activ=
e
> >>>>> profiling. Yet, it did. Because of a bug the dummy event was
> >>>>> programmed as a sampling event in frequency mode. Events in that mo=
de
> >>>>> incur more kernel overheads because on timer tick, the kernel has t=
o
> >>>>> look at the number of samples for each event and potentially adjust
> >>>>> the sampling period to achieve the desired frequency. The dummy eve=
nt
> >>>>> was therefore adding a frequency event to task and ctx contexts we =
may
> >>>>> otherwise not have any, e.g., perf record -a -e
> >>>>> cpu/event=3D0x3c,period=3D10000000/. On each timer tick the
> >>>>> perf_adjust_freq_unthr_context() is invoked and if ctx->nr_freq is
> >>>>> non-zero, then the kernel will loop over ALL the events of the cont=
ext
> >>>>> looking for frequency mode ones. In doing, so it locks the context,
> >>>>> and enable/disable the PMU of each hw event. If all the events of t=
he
> >>>>> context are in period mode, the kernel will have to traverse the li=
st for
> >>>>> nothing incurring overhead. The overhead is multiplied by a very la=
rge
> >>>>> factor when this happens in a guest kernel. There is no need for th=
e
> >>>>> dummy event to be in frequency mode, it does not count anything and
> >>>>> therefore should not cause extra overhead for no reason.
> >>>>>
> >>>>> Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dummy=
 constructor")
> >>>>> Reported-by: Stephane Eranian <eranian@google.com>
> >>>>> Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > I'll take the original patch first.
> >
> >
> >>>>> ---
> >>>>>  tools/perf/util/evlist.c | 5 +++--
> >>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> >>>>> index 25c3ebe2c2f5..e36da58522ef 100644
> >>>>> --- a/tools/perf/util/evlist.c
> >>>>> +++ b/tools/perf/util/evlist.c
> >>>>> @@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(struct=
 evlist *evlist)
> >>>>>               .type   =3D PERF_TYPE_SOFTWARE,
> >>>>>               .config =3D PERF_COUNT_SW_DUMMY,
> >>>>>               .size   =3D sizeof(attr), /* to capture ABI version *=
/
> >>>>> +             /* Avoid frequency mode for dummy events to avoid ass=
ociated timers. */
> >>>>> +             .freq =3D 0,
> >>>>> +             .sample_period =3D 1,
> >>>>>       };
> >>>>>
> >>>>>       return evsel__new_idx(&attr, evlist->core.nr_entries);
> >>>>> @@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct evli=
st *evlist, bool system_wide)
> >>>>>       evsel->core.attr.exclude_kernel =3D 1;
> >>>>>       evsel->core.attr.exclude_guest =3D 1;
> >>>>>       evsel->core.attr.exclude_hv =3D 1;
> >>>>> -     evsel->core.attr.freq =3D 0;
> >>>>> -     evsel->core.attr.sample_period =3D 1;
> >>>>>       evsel->core.system_wide =3D system_wide;
> >>>>>       evsel->no_aux_samples =3D true;
> >>>>>       evsel->name =3D strdup("dummy:u");
> >>>>
> >>>> Note that evsel__config() will put it back to freq if -F is used.
> >>>
> >>> Right, I was looking for a minimal fix in part for the sake of back
> >>> porting. For the -F we could do:
> >>>
> >>> ```
> >>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >>> index d5363d23f5d3..806185a39e17 100644
> >>> --- a/tools/perf/util/evsel.c
> >>> +++ b/tools/perf/util/evsel.c
> >>> @@ -1083,11 +1083,15 @@ void __weak arch__post_evsel_config(struct
> >>> evsel *evsel __maybe_unused,
> >>> static void evsel__set_default_freq_period(struct record_opts *opts,
> >>>                                           struct perf_event_attr *att=
r)
> >>> {
> >>> -       if (opts->freq) {
> >>> +       bool is_dummy =3D attr->type =3D=3D PERF_TYPE_SOFTWARE &&
> >>> +               attr->config =3D=3D PERF_COUNT_SW_DUMMY;
> >>> +
> >>> +       if (opts->freq && !is_dummy) {
> >>>                attr->freq =3D 1;
> >>>                attr->sample_freq =3D opts->freq;
> >>>        } else {
> >>> -               attr->sample_period =3D opts->default_interval;
> >>> +               attr->freq =3D 0;
> >>> +               attr->sample_period =3D is_dummy ? 1 : opts->default_=
interval;
> >>>        }
> >>> }
> >>> ```
> >>>
> >>> But this felt like it could potentially have other side-effects.
> >>
> >> Perhaps leave it alone, if the period has already been defined:
> >>
> >> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >> index d5363d23f5d3..ad3e12f5ec88 100644
> >> --- a/tools/perf/util/evsel.c
> >> +++ b/tools/perf/util/evsel.c
> >> @@ -1166,7 +1166,8 @@ void evsel__config(struct evsel *evsel, struct r=
ecord_opts *opts,
> >>         if ((evsel->is_libpfm_event && !attr->sample_period) ||
> >>             (!evsel->is_libpfm_event && (!attr->sample_period ||
> >>                                          opts->user_freq !=3D UINT_MAX=
 ||
> >> -                                        opts->user_interval !=3D ULLO=
NG_MAX)))
> >> +                                        opts->user_interval !=3D ULLO=
NG_MAX) &&
> >> +            !(is_dummy && attr->sample_period)))
> >>                 evsel__set_default_freq_period(opts, attr);
> >>
> >>         /*
> >
> > Or simply like this?
> >
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index d5363d23f5d3..6ce832ce62f1 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1169,6 +1169,9 @@ void evsel__config(struct evsel *evsel, struct
> > record_opts *opts,
> >                                          opts->user_interval !=3D ULLON=
G_MAX)))
> >                 evsel__set_default_freq_period(opts, attr);
> >
> > +       if (evsel__is_dummy_event(evsel))
> > +               attr->freq =3D 0;
> > +
> >         /*
> >          * If attr->freq was set (here or earlier), ask for period
> >          * to be sampled.
>
> I thought there might be corner cases where it made a difference,
> but I can't find any, so that should do.
>

It seemed more intention revealing to do it at creation/initialization
than on a later not obviously executed code path - I'm thinking of
future me trying to understand the code. My priority is the clearing
of the flag, so I'm easy.

Thanks,
Ian
