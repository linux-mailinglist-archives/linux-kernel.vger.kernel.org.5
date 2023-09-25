Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950D97ADDDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjIYRhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjIYRhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:37:46 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CB310E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:37:38 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-418157e979eso31021cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695663458; x=1696268258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3oC1evZWJ326SacIrcxT2CNtsy8SfFDpp9Sazuf0ew=;
        b=L4b4JKOMJAQS1wzQIQaVENlQ8vCTNrhRRO4gaEIDVGVUEdnrJCwPyKsB3gJwy22Aih
         w6LhCF3VOYs1xY3KI2Q5QAsmW7EYkQ9X/xOPE0m6YFv0l7lQQ8rMpJpclm/VHa4FGHfQ
         R19JsLM+MKW5PnBksWl6muwfXaM0BxaWQg8pdVhriuKP4zXCru1trz7NSvwMpHie5RJ0
         VLwU7xpf0lc9TAe1FWrvqQkD6nahSmORZpAkd3ypfBUjFZzNC30P+ausldvFQQ78zpJw
         vXedXoyNLIFfI5Vcdbi/7qLLWunzSIX8UC9MX/uc+ASNWvACPCr4XXQj5Z9KWQrfLOOa
         XVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695663458; x=1696268258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3oC1evZWJ326SacIrcxT2CNtsy8SfFDpp9Sazuf0ew=;
        b=HmbpDjYl3F7kjPKmiZJ4rrDX+wVSa0beBog37yv/9p0uQ0IXJXn1/AaQjZYKPzDo7E
         VRg8DhaVsTGpUjXycsqalWSDkXNekBw52sEGBLLjRdSBmgUx7XO2x4M6OLxaE3rtO99g
         GEhJIzAz4tqL1S3RzpfnSYTJxhEQ6Zha7Yg/9hbLhrbro5XfximKa5wHQuGgSsmpfpY1
         b5DLuAsKlgI8pVlUSi5X7HDtu31MJN/xhGiQe3JP6rANXjbx0fKgaXx990M05OlQcjgP
         usR/JynFTbjxv/aXks9jaRObFUGDJV8DbM34qxyiJQrX0ytqLyIk+ZQYLPlM1xmzsBvj
         Fpog==
X-Gm-Message-State: AOJu0Yw8NdPycOxJz9qTM+c8kJrSgCI4rgxvRIJmDLSVCIOpGGMM5Lxz
        6ygFGOGIN8fZS0JRFOgZf+XfM7G0KZn5VXhc5H8IuQ==
X-Google-Smtp-Source: AGHT+IG+coT63NZ1BJD8RTdgjM2KIprWwwnb/0zPgDdX22CtLe70CwuGQWsDilo5ikT8gOvZNXzmCIR2yoRsjc+TLzo=
X-Received: by 2002:a05:622a:1813:b0:410:a4cb:9045 with SMTP id
 t19-20020a05622a181300b00410a4cb9045mr21499qtc.18.1695663457745; Mon, 25 Sep
 2023 10:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com> <08995efc-d5af-6ba6-831b-1a483daabef4@intel.com>
 <CAP-5=fW783G9fUEHrmzUu7UmvOm65Fp6vAQybCcNz2C0QRz26w@mail.gmail.com>
 <8086150e-3c6d-4001-b3cc-bb12ebe15928@intel.com> <CAM9d7chtVQqySGOGQrA065Fr8M2Y6jg9JJccYtMycQFvaheU+Q@mail.gmail.com>
 <f64c4283-6ced-411a-b69f-8c4375fb91f7@intel.com> <CAP-5=fWJzpQ14CQk+Lf5EY4CwJ4ACPsYT49XJwCnC_qEpS-DAA@mail.gmail.com>
 <9759e3d4-703d-30a6-5334-b33a6e5a38d7@huawei.com>
In-Reply-To: <9759e3d4-703d-30a6-5334-b33a6e5a38d7@huawei.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 25 Sep 2023 10:37:23 -0700
Message-ID: <CABPqkBRroYfif-R+_cxim57M2rAxRCPuuZo7J0S=-Jp2jWE0bg@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 8:35=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> Hello,
>
> On 2023/9/22 23:05, Ian Rogers wrote:
> > On Thu, Sep 21, 2023 at 10:36=E2=80=AFPM Adrian Hunter <adrian.hunter@i=
ntel.com> wrote:
> >>
> >> On 21/09/23 22:26, Namhyung Kim wrote:
> >>> Hi,
> >>>
> >>> On Mon, Sep 18, 2023 at 11:00=E2=80=AFPM Adrian Hunter <adrian.hunter=
@intel.com> wrote:
> >>>>
> >>>> On 19/09/23 00:48, Ian Rogers wrote:
> >>>>> On Mon, Sep 18, 2023 at 1:14=E2=80=AFAM Adrian Hunter <adrian.hunte=
r@intel.com> wrote:
> >>>>>>
> >>>>>> On 16/09/23 07:09, Ian Rogers wrote:
> >>>>>>> Dummy events are created with an attribute where the period and f=
req
> >>>>>>> are zero. evsel__config will then see the uninitialized values an=
d
> >>>>>>> initialize them in evsel__default_freq_period. As fequency mode i=
s
> >>>>>>> used by default the dummy event would be set to use frequency
> >>>>>>> mode. However, this has no effect on the dummy event but does cau=
se
> >>>>>>> unnecessary timers/interrupts. Avoid this overhead by setting the
> >>>>>>> period to 1 for dummy events.
> >>>>>>>
> >>>>>>> evlist__add_aux_dummy calls evlist__add_dummy then sets freq=3D0 =
and
> >>>>>>> period=3D1. This isn't necessary after this change and so the set=
ting is
> >>>>>>> removed.
> >>>>>>>
> >>>>>>>  From Stephane:
> >>>>>>>
> >>>>>>> The dummy event is not counting anything. It is used to collect m=
map
> >>>>>>> records and avoid a race condition during the synthesize mmap pha=
se of
> >>>>>>> perf record. As such, it should not cause any overhead during act=
ive
> >>>>>>> profiling. Yet, it did. Because of a bug the dummy event was
> >>>>>>> programmed as a sampling event in frequency mode. Events in that =
mode
> >>>>>>> incur more kernel overheads because on timer tick, the kernel has=
 to
> >>>>>>> look at the number of samples for each event and potentially adju=
st
> >>>>>>> the sampling period to achieve the desired frequency. The dummy e=
vent
> >>>>>>> was therefore adding a frequency event to task and ctx contexts w=
e may
> >>>>>>> otherwise not have any, e.g., perf record -a -e
> >>>>>>> cpu/event=3D0x3c,period=3D10000000/. On each timer tick the
> >>>>>>> perf_adjust_freq_unthr_context() is invoked and if ctx->nr_freq i=
s
> >>>>>>> non-zero, then the kernel will loop over ALL the events of the co=
ntext
> >>>>>>> looking for frequency mode ones. In doing, so it locks the contex=
t,
> >>>>>>> and enable/disable the PMU of each hw event. If all the events of=
 the
> >>>>>>> context are in period mode, the kernel will have to traverse the =
list for
> >>>>>>> nothing incurring overhead. The overhead is multiplied by a very =
large
> >>>>>>> factor when this happens in a guest kernel. There is no need for =
the
> >>>>>>> dummy event to be in frequency mode, it does not count anything a=
nd
> >>>>>>> therefore should not cause extra overhead for no reason.
> >>>>>>>
> >>>>>>> Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dum=
my constructor")
> >>>>>>> Reported-by: Stephane Eranian <eranian@google.com>
> >>>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>>
> >>> I'll take the original patch first.
> >>>
> >>>
> >>>>>>> ---
> >>>>>>>   tools/perf/util/evlist.c | 5 +++--
> >>>>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> >>>>>>> index 25c3ebe2c2f5..e36da58522ef 100644
> >>>>>>> --- a/tools/perf/util/evlist.c
> >>>>>>> +++ b/tools/perf/util/evlist.c
> >>>>>>> @@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(stru=
ct evlist *evlist)
> >>>>>>>                .type   =3D PERF_TYPE_SOFTWARE,
> >>>>>>>                .config =3D PERF_COUNT_SW_DUMMY,
> >>>>>>>                .size   =3D sizeof(attr), /* to capture ABI versio=
n */
> >>>>>>> +             /* Avoid frequency mode for dummy events to avoid a=
ssociated timers. */
> >>>>>>> +             .freq =3D 0,
> >>>>>>> +             .sample_period =3D 1,
> >>>>>>>        };
> >>>>>>>
> >>>>>>>        return evsel__new_idx(&attr, evlist->core.nr_entries);
> >>>>>>> @@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct ev=
list *evlist, bool system_wide)
> >>>>>>>        evsel->core.attr.exclude_kernel =3D 1;
> >>>>>>>        evsel->core.attr.exclude_guest =3D 1;
> >>>>>>>        evsel->core.attr.exclude_hv =3D 1;
> >>>>>>> -     evsel->core.attr.freq =3D 0;
> >>>>>>> -     evsel->core.attr.sample_period =3D 1;
> >>>>>>>        evsel->core.system_wide =3D system_wide;
> >>>>>>>        evsel->no_aux_samples =3D true;
> >>>>>>>        evsel->name =3D strdup("dummy:u");
> >>>>>>
> >>>>>> Note that evsel__config() will put it back to freq if -F is used.
> >>>>>
> >>>>> Right, I was looking for a minimal fix in part for the sake of back
> >>>>> porting. For the -F we could do:
> >>>>>
> >>>>> ```
> >>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >>>>> index d5363d23f5d3..806185a39e17 100644
> >>>>> --- a/tools/perf/util/evsel.c
> >>>>> +++ b/tools/perf/util/evsel.c
> >>>>> @@ -1083,11 +1083,15 @@ void __weak arch__post_evsel_config(struct
> >>>>> evsel *evsel __maybe_unused,
> >>>>> static void evsel__set_default_freq_period(struct record_opts *opts=
,
> >>>>>                                            struct perf_event_attr *=
attr)
> >>>>> {
> >>>>> -       if (opts->freq) {
> >>>>> +       bool is_dummy =3D attr->type =3D=3D PERF_TYPE_SOFTWARE &&
> >>>>> +               attr->config =3D=3D PERF_COUNT_SW_DUMMY;
> >>>>> +
> >>>>> +       if (opts->freq && !is_dummy) {
> >>>>>                 attr->freq =3D 1;
> >>>>>                 attr->sample_freq =3D opts->freq;
> >>>>>         } else {
> >>>>> -               attr->sample_period =3D opts->default_interval;
> >>>>> +               attr->freq =3D 0;
> >>>>> +               attr->sample_period =3D is_dummy ? 1 : opts->defaul=
t_interval;
> >>>>>         }
> >>>>> }
> >>>>> ```
> >>>>>
> >>>>> But this felt like it could potentially have other side-effects.
> >>>>
> >>>> Perhaps leave it alone, if the period has already been defined:
> >>>>
> >>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >>>> index d5363d23f5d3..ad3e12f5ec88 100644
> >>>> --- a/tools/perf/util/evsel.c
> >>>> +++ b/tools/perf/util/evsel.c
> >>>> @@ -1166,7 +1166,8 @@ void evsel__config(struct evsel *evsel, struct=
 record_opts *opts,
> >>>>          if ((evsel->is_libpfm_event && !attr->sample_period) ||
> >>>>              (!evsel->is_libpfm_event && (!attr->sample_period ||
> >>>>                                           opts->user_freq !=3D UINT_=
MAX ||
> >>>> -                                        opts->user_interval !=3D UL=
LONG_MAX)))
> >>>> +                                        opts->user_interval !=3D UL=
LONG_MAX) &&
> >>>> +            !(is_dummy && attr->sample_period)))
> >>>>                  evsel__set_default_freq_period(opts, attr);
> >>>>
> >>>>          /*
> >>>
> >>> Or simply like this?
> >>>
> >>>
> >>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >>> index d5363d23f5d3..6ce832ce62f1 100644
> >>> --- a/tools/perf/util/evsel.c
> >>> +++ b/tools/perf/util/evsel.c
> >>> @@ -1169,6 +1169,9 @@ void evsel__config(struct evsel *evsel, struct
> >>> record_opts *opts,
> >>>                                           opts->user_interval !=3D UL=
LONG_MAX)))
> >>>                  evsel__set_default_freq_period(opts, attr);
> >>>
> >>> +       if (evsel__is_dummy_event(evsel))
> >>> +               attr->freq =3D 0;
> >>> +
> >>>          /*
> >>>           * If attr->freq was set (here or earlier), ask for period
> >>>           * to be sampled.
> >>
> >> I thought there might be corner cases where it made a difference,
> >> but I can't find any, so that should do.
> >>
> >
> > It seemed more intention revealing to do it at creation/initialization
> > than on a later not obviously executed code path - I'm thinking of
> > future me trying to understand the code. My priority is the clearing
> > of the flag, so I'm easy.
> >
> evsel__apply_config_terms() also sets freq. For example:
>
> # perf record -vv -e dummy/freq=3D100/ true

This example is NOT relevant to the issue.
Of course, if you want to explicitly use the dummy event with
frequency mode, you should be allowed to do so.
The problem we are solving here is different. We are preventing perf
record internal use of the dummy event
from using frequency mode for no good reason as any frequency mode
event adds additional overhead.
The perf record internal dummy event is used for one goal: to capture
MMAP records to avoid a race condition
between synthesize phase and processes being created and not captured
by synthesize. In that mode, it acts
as an aggregator of all MMAP records during the entire run of the
tool. This does not require any frequency mode.


> <SNIP>
> ------------------------------------------------------------
> perf_event_attr:
>    type                             1 (PERF_TYPE_SOFTWARE)
>    size                             136
>    config                           0x9 (PERF_COUNT_SW_DUMMY)
>    { sample_period, sample_freq }   100
>    sample_type                      IP|TID|TIME|PERIOD
>    read_format                      ID|LOST
>    disabled                         1
>    inherit                          1
>    mmap                             1
>    comm                             1
>    freq                             1
>    enable_on_exec                   1
>    task                             1
>    sample_id_all                    1
>    exclude_guest                    1
>    mmap2                            1
>    comm_exec                        1
>    ksymbol                          1
>    bpf_event                        1
> ------------------------------------------------------------
> <SNIP>
>
> Therefore, do we need to perform special processing on dummy events in
> evsel__apply_config_terms?
>
> Thanks,
> Yang
