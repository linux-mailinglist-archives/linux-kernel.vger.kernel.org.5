Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD58787F31
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbjHYFRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbjHYFRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:17:25 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4051FE3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:17:23 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4036bd4fff1so177341cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692940642; x=1693545442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8OuiAMwZJhaleqWk94iWXzD0CFXxddqtCXkikO5hlA=;
        b=WqkoV8Sx1Vw4+Rjmqfnkrv1t+ldQUHtoa1krDS+BwFxhFBZSZxfX3u8GeBxrc0p0zQ
         n6VBQF4z/ufXF6+/4WotuywUkvyns2gER9bynGFsOFypi7ED2X7tdB7zVat0AVz4hJQf
         nqTF6ikJ9TOauFjPXAfSHDco1fHKP0fTIIFg4XNw/ftjz22lGbZ6ZfE+WCO6MI8hWv1R
         JMnfRvXHfUHlF3RqFmXNC7s+AEUmawRguZ9o1AyA6j+c3QL1hYeMH/73xL/L8ztG9j9d
         UEWg6k+2oeOkxiLDCQovKiahVLSrtcVnhZWyTGx05P7eYuY+5JlqaVw9fMOBcZVmaOjQ
         T/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692940642; x=1693545442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8OuiAMwZJhaleqWk94iWXzD0CFXxddqtCXkikO5hlA=;
        b=jBYU594TBpRPTqX1RiJ5D4V7F70QMPnHG0hU7dLvAVFSRP2a4YnvYCg7kKhOWxlrxc
         HPRFD5xcAsg6TPGtByX8KfpWhws+/nhQZsKIRVP8dV5qHtW1vY5FEWTTl5emhPrnmArU
         /0vN1wAZ7nbhXX3OnoQWVO+jgLytRJCM1yxcZfgXIL6vxZXDSfIWUnAiXiiSYBrWfn+1
         /8LGu9CBE0qcqBlnTr/MXKu40U2hsFxxzBKYjJPN+zIP5EMeVTgGmVDVLSeTEIL5SFOI
         znEtaeJe0PtZO0URuTcGqPBWL7zjrgWMHBb3cvJUVGiVmTa7rwrxGPt73d0a+L/Ys69N
         6rAQ==
X-Gm-Message-State: AOJu0YwFbbUkcLTCx2Exf8pIMG+9D6ytwb8jZRc1ItHxHELQTJkOyDGa
        KxXQhiuhbaOb328yTW3eVWH6ucajzH+rs/ZbYER73w==
X-Google-Smtp-Source: AGHT+IHvcF6Ar1G6X7BGB67oPyJ5OTpJWxjCvqgTgGxIsLSWqrSfvMq/Do0aKB6vfwrtibzrIhHHYmktBdD6wmnU4ZU=
X-Received: by 2002:ac8:5a83:0:b0:3ef:5f97:258f with SMTP id
 c3-20020ac85a83000000b003ef5f97258fmr159750qtc.16.1692940642092; Thu, 24 Aug
 2023 22:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230821012734.18241-1-yangjihong1@huawei.com> <20230821012734.18241-5-yangjihong1@huawei.com>
In-Reply-To: <20230821012734.18241-5-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 22:17:10 -0700
Message-ID: <CAP-5=fXZXQryyfjzSYRv6zqmttt7rt4gUc0KPudu0qtSc1XPow@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
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

On Sun, Aug 20, 2023 at 6:30=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> User space tasks can migrate between CPUs, we need to track side-band
> events for all CPUs.
>
> The specific scenarios are as follows:
>
>          CPU0                                 CPU1
>   perf record -C 0 start
>                               taskA starts to be created and executed
>                                 -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>                                    events only deliver to CPU1
>                               ......
>                                 |
>                           migrate to CPU0
>                                 |
>   Running on CPU0    <----------/
>   ...
>
>   perf record -C 0 stop
>
> Now perf samples the PC of taskA. However, perf does not record the
> PERF_RECORD_COMM and PERF_RECORD_MMAP events of taskA.
> Therefore, the comm and symbols of taskA cannot be parsed.
>
> The solution is to record sideband events for all CPUs when tracing
> selected CPUs. Because this modifies the default behavior, add related
> comments to the perf record man page.
>
> The sys_perf_event_open invoked is as follows:
>
>   # perf --debug verbose=3D3 record -e cpu-clock -C 1 true
>   <SNIP>
>   Opening: cpu-clock
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 =3D 5
>   Opening: dummy:u
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0x9 (PERF_COUNT_SW_DUMMY)
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>     read_format                      ID|LOST
>     inherit                          1
>     exclude_kernel                   1
>     exclude_hv                       1
>     mmap                             1
>     comm                             1
>     task                             1
>     sample_id_all                    1
>     exclude_guest                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 6
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 =3D 7
>   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 =3D 9
>   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 =3D 10
>   sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 =3D 11
>   sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 =3D 12
>   sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 =3D 13
>   sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 =3D 14
>   <SNIP>
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt |  3 ++
>  tools/perf/builtin-record.c              | 44 +++++++++++++++++++++++-
>  2 files changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Docume=
ntation/perf-record.txt
> index d5217be012d7..1889f66addf2 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -374,6 +374,9 @@ comma-separated list with no space: 0,1. Ranges of CP=
Us are specified with -: 0-
>  In per-thread mode with inheritance mode on (default), samples are captu=
red only when
>  the thread executes on the designated CPUs. Default is to monitor all CP=
Us.
>
> +User space tasks can migrate between CPUs, so when tracing selected CPUs=
,
> +a dummy event is created to track sideband for all CPUs.
> +
>  -B::
>  --no-buildid::
>  Do not save the build ids of binaries in the perf.data files. This skips
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4ee94058028f..ae2e21b945fa 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -906,10 +906,44 @@ static int record__config_off_cpu(struct record *re=
c)
>         return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts=
);
>  }
>
> +static bool record__tracking_system_wide(struct record *rec)

I think this would be better named something like:
record__need_system_wide_dummy_event

Thanks,
Ian

> +{
> +       struct record_opts *opts =3D &rec->opts;
> +       struct evlist *evlist =3D rec->evlist;
> +       struct evsel *evsel;
> +
> +       /*
> +        * If all (non-dummy) evsel have exclude_user,
> +        * system_wide is not needed.
> +        *
> +        * all_kernel and all_user will overwrite exclude_kernel and
> +        * exclude_user of attr in evsel__config(), here need to check
> +        * all the three items.
> +        *
> +        * Sideband system wide if one of the following conditions is met=
:
> +        *
> +        *   - all_user is set, and there is a non-dummy event
> +        *   - all_user and all_kernel are not set, and there is
> +        *     a non-dummy event without exclude_user
> +        */
> +       if (opts->all_kernel)
> +               return false;
> +
> +       evlist__for_each_entry(evlist, evsel) {
> +               if (!evsel__is_dummy_event(evsel)) {
> +                       if (opts->all_user || !evsel->core.attr.exclude_u=
ser)
> +                               return true;
> +               }
> +       }
> +
> +       return false;
> +}
> +
>  static int record__config_tracking_events(struct record *rec)
>  {
>         struct record_opts *opts =3D &rec->opts;
>         struct evlist *evlist =3D rec->evlist;
> +       bool system_wide =3D false;
>         struct evsel *evsel;
>
>         /*
> @@ -919,7 +953,15 @@ static int record__config_tracking_events(struct rec=
ord *rec)
>          */
>         if (opts->target.initial_delay || target__has_cpu(&opts->target) =
||
>             perf_pmus__num_core_pmus() > 1) {
> -               evsel =3D evlist__findnew_tracking_event(evlist, false);
> +
> +               /*
> +                * User space tasks can migrate between CPUs, so when tra=
cing
> +                * selected CPUs, sideband for all CPUs is still needed.
> +                */
> +               if (!!opts->target.cpu_list && record__tracking_system_wi=
de(rec))
> +                       system_wide =3D true;
> +
> +               evsel =3D evlist__findnew_tracking_event(evlist, system_w=
ide);
>                 if (!evsel)
>                         return -ENOMEM;
>
> --
> 2.30.GIT
>
