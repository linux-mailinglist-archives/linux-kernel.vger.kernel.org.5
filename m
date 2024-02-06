Return-Path: <linux-kernel+bounces-54177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8354B84ABDF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EBBB2304C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC7356B64;
	Tue,  6 Feb 2024 02:02:55 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502C5675B;
	Tue,  6 Feb 2024 02:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707184974; cv=none; b=aN1d7GJgWH9v1B61ZdL/n9JbtzrVSwBPWzWsvwHQArCWGdZyA10IIt+xDITs6wI6sYlI0Z6SfzlkskCK7Udl9CWlqRg3t2J7k6Vw40+SArWPUC4onywzF+Leb2UTLcCdGPq+l/3WYwsygsK8p8VsnBGcPTUA/qaApCrT+qKVu34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707184974; c=relaxed/simple;
	bh=o7p4l451b42i8P3WAvXEX6P6/8g1ZcZZJ4JdcH7FOto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mx0VwtlUfFynrneXMUQ36EZTAjJzTr2hxfQIH9wp9Q4J1I0WPdWGX7RnDkMsPHj27+lmMPnYa4nNkcoov0mJu9FelEH5/k4C1g/XasISfvTGTEsMy2nyrONr/1jnHb0KAxJ4DdWcpMoboTpORuyTg8ryDi6/euWFrJOw/EVW104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bda4bd14e2so4504754b6e.2;
        Mon, 05 Feb 2024 18:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707184972; x=1707789772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbWG5P5LKH6JeXdd57gmbHwoExYBxYEX1BmES5BVCOg=;
        b=vD46fO5BNzCxRD3Nx5FZBoadeKtpfSPtl6Y56MfEx/t5NYVRiIaDmU4MlcKrKIxBXe
         ipUDAjLGUnQKp7HTJQpV+4S7UwRLd1mSVSrKCqV48GynkyswXIQ79iv0sXiPvcA2LFmp
         XpGfrwhaR1XYjtIkaFGd7i19oFf8yr6ds/i7/SWqS/VdDW494yVLRvjyJq5GsiiUmoyQ
         0ySjfxKHSXmoxaBrkFxiOD5XKo0nyXwBXXcJd2jGkC8ncLM89txFBGh6TJr114nu2Bb0
         VbSd09wmId0kmI3zI7aMTCR7LaVINyz3VBud9tcMpDpbr7tyI6Wapl2d5yhYP8Nk4x5s
         umIQ==
X-Gm-Message-State: AOJu0YwdXymVPL6J8b0jbpoQ6Lc26QWuT0yvnYvvBMY5tnqboaYDgOhX
	SxxNRBk4qIj59Fvrb7ILni7BN0MEKzTnhRfsTkYm0eSoccEayVf0Uz+TX5EPk5JSY994jdZZkUi
	fiWjt7vLM5PbLRacUMSoTN++wRLE=
X-Google-Smtp-Source: AGHT+IEOKicIAVppBbtoAv5yBeUTTbF86HVVLo8F8dMmYDIUqIBIQgVWb4dpIPckDmnVq8e/X7n4J7fi2jOy8jPmwUU=
X-Received: by 2002:a05:6808:2019:b0:3bf:bd6e:9384 with SMTP id
 q25-20020a056808201900b003bfbd6e9384mr1108809oiw.33.1707184971903; Mon, 05
 Feb 2024 18:02:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202022512.467636-1-irogers@google.com> <20240202022512.467636-2-irogers@google.com>
In-Reply-To: <20240202022512.467636-2-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 5 Feb 2024 18:02:40 -0800
Message-ID: <CAM9d7cgv3zPNohz6eWwH7qaQyY0QMRK_sqtJdumeGrD5tMW9Yg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf metrics: Compute unmerged uncore metrics individually
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, John Garry <john.g.garry@oracle.com>, Kaige Ye <ye@kaige.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 6:25=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> When merging counts from multiple uncore PMUs the metric is only
> computed for the metric leader. When merging/aggregation is disabled,
> prior to this patch just the leader's metric would be computed. Fix
> this by computing the metric for each PMU.
>
> On a SkylakeX:
> Before:
> ```
> $ perf stat -A -M memory_bandwidth_total -a sleep 1
>
>  Performance counter stats for 'system wide':
>
> CPU0               82,217      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      9=
2 MB/s  memory_bandwidth_total
> CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      0=
0 MB/s  memory_bandwidth_total
> CPU0               61,395      UNC_M_CAS_COUNT.WR [uncore_imc_0]
> CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_0]
> CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_1]
> CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_1]
> CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
> CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
> CPU0               81,570      UNC_M_CAS_COUNT.RD [uncore_imc_2]
> CPU18             113,886      UNC_M_CAS_COUNT.RD [uncore_imc_2]
> CPU0               62,330      UNC_M_CAS_COUNT.WR [uncore_imc_2]
> CPU18              66,942      UNC_M_CAS_COUNT.WR [uncore_imc_2]
> CPU0               75,489      UNC_M_CAS_COUNT.RD [uncore_imc_3]
> CPU18              27,958      UNC_M_CAS_COUNT.RD [uncore_imc_3]
> CPU0               55,864      UNC_M_CAS_COUNT.WR [uncore_imc_3]
> CPU18              38,727      UNC_M_CAS_COUNT.WR [uncore_imc_3]
> CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_4]
> CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_4]
> CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
> CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
> CPU0               75,423      UNC_M_CAS_COUNT.RD [uncore_imc_5]
> CPU18             104,527      UNC_M_CAS_COUNT.RD [uncore_imc_5]
> CPU0               57,596      UNC_M_CAS_COUNT.WR [uncore_imc_5]
> CPU18              56,777      UNC_M_CAS_COUNT.WR [uncore_imc_5]
> CPU0        1,003,440,851 ns   duration_time
>
>        1.003440851 seconds time elapsed
> ```
>
> After:
> ```
> $ perf stat -A -M memory_bandwidth_total -a sleep 1
>
>  Performance counter stats for 'system wide':
>
> CPU0               88,968      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      9=
5 MB/s  memory_bandwidth_total
> CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      0=
0 MB/s  memory_bandwidth_total
> CPU0               59,498      UNC_M_CAS_COUNT.WR [uncore_imc_0]
> CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_0]
> CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_1] #      0=
0 MB/s  memory_bandwidth_total
> CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_1] #      0=
0 MB/s  memory_bandwidth_total
> CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
> CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
> CPU0               88,635      UNC_M_CAS_COUNT.RD [uncore_imc_2] #      9=
5 MB/s  memory_bandwidth_total
> CPU18             117,975      UNC_M_CAS_COUNT.RD [uncore_imc_2] #     11=
5 MB/s  memory_bandwidth_total
> CPU0               60,829      UNC_M_CAS_COUNT.WR [uncore_imc_2]
> CPU18              62,105      UNC_M_CAS_COUNT.WR [uncore_imc_2]
> CPU0               82,238      UNC_M_CAS_COUNT.RD [uncore_imc_3] #      8=
7 MB/s  memory_bandwidth_total
> CPU18              22,906      UNC_M_CAS_COUNT.RD [uncore_imc_3] #      3=
6 MB/s  memory_bandwidth_total
> CPU0               53,959      UNC_M_CAS_COUNT.WR [uncore_imc_3]
> CPU18              32,990      UNC_M_CAS_COUNT.WR [uncore_imc_3]
> CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_4] #      0=
0 MB/s  memory_bandwidth_total
> CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_4] #      0=
0 MB/s  memory_bandwidth_total
> CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
> CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
> CPU0               83,595      UNC_M_CAS_COUNT.RD [uncore_imc_5] #      8=
9 MB/s  memory_bandwidth_total
> CPU18             110,151      UNC_M_CAS_COUNT.RD [uncore_imc_5] #     10=
5 MB/s  memory_bandwidth_total
> CPU0               56,540      UNC_M_CAS_COUNT.WR [uncore_imc_5]
> CPU18              53,816      UNC_M_CAS_COUNT.WR [uncore_imc_5]
> CPU0        1,003,353,416 ns   duration_time
> ```
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/metricgroup.c |  2 ++
>  tools/perf/util/stat-shadow.c | 31 +++++++++++++++++++++++++++----
>  2 files changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index ca3e0404f187..c33ffee837ca 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -44,6 +44,8 @@ struct metric_event *metricgroup__lookup(struct rblist =
*metric_events,
>         if (!metric_events)
>                 return NULL;
>
> +       if (evsel->metric_leader)
> +               me.evsel =3D evsel->metric_leader;
>         nd =3D rblist__find(metric_events, &me);
>         if (nd)
>                 return container_of(nd, struct metric_event, nd);
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index f6c9d2f98835..1be23b0eee2f 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -356,6 +356,7 @@ static void print_nsecs(struct perf_stat_config *conf=
ig,
>  }
>
>  static int prepare_metric(const struct metric_expr *mexp,
> +                         const struct evsel *evsel,
>                           struct expr_parse_ctx *pctx,
>                           int aggr_idx)
>  {
> @@ -398,8 +399,29 @@ static int prepare_metric(const struct metric_expr *=
mexp,
>                         source_count =3D 1;
>                 } else {
>                         struct perf_stat_evsel *ps =3D mexp->metric_event=
s[i]->stats;
> -                       struct perf_stat_aggr *aggr =3D &ps->aggr[aggr_id=
x];
> +                       struct perf_stat_aggr *aggr;
>
> +                       /*
> +                        * If there are multiple uncore PMUs and we're no=
t
> +                        * reading the leader's stats, determine the stat=
s for
> +                        * the appropriate uncore PMU.
> +                        */
> +                       if (evsel && evsel->metric_leader &&
> +                           evsel->pmu !=3D evsel->metric_leader->pmu &&
> +                           mexp->metric_events[i]->pmu =3D=3D evsel->met=
ric_leader->pmu) {

Is it just to check we're in --no-aggr (or --no-merge)?
Then it'd be simpler to use stat_config->aggr_mode.

Thanks,
Namhyung


> +                               struct evsel *pos;
> +
> +                               evlist__for_each_entry(evsel->evlist, pos=
) {
> +                                       if (pos->pmu !=3D evsel->pmu)
> +                                               continue;
> +                                       if (pos->metric_leader !=3D mexp-=
>metric_events[i])
> +                                               continue;
> +                                       ps =3D pos->stats;
> +                                       source_count =3D 1;
> +                                       break;
> +                               }
> +                       }
> +                       aggr =3D &ps->aggr[aggr_idx];
>                         if (!aggr)
>                                 break;
>
> @@ -420,7 +442,8 @@ static int prepare_metric(const struct metric_expr *m=
exp,
>                                  * metric.
>                                  */
>                                 val =3D aggr->counts.val * (1.0 / mexp->m=
etric_events[i]->scale);
> -                               source_count =3D evsel__source_count(mexp=
->metric_events[i]);
> +                               if (!source_count)
> +                                       source_count =3D evsel__source_co=
unt(mexp->metric_events[i]);
>                         }
>                 }
>                 n =3D strdup(evsel__metric_id(mexp->metric_events[i]));
> @@ -461,7 +484,7 @@ static void generic_metric(struct perf_stat_config *c=
onfig,
>                 pctx->sctx.user_requested_cpu_list =3D strdup(config->use=
r_requested_cpu_list);
>         pctx->sctx.runtime =3D mexp->runtime;
>         pctx->sctx.system_wide =3D config->system_wide;
> -       i =3D prepare_metric(mexp, pctx, aggr_idx);
> +       i =3D prepare_metric(mexp, evsel, pctx, aggr_idx);
>         if (i < 0) {
>                 expr__ctx_free(pctx);
>                 return;
> @@ -522,7 +545,7 @@ double test_generic_metric(struct metric_expr *mexp, =
int aggr_idx)
>         if (!pctx)
>                 return NAN;
>
> -       if (prepare_metric(mexp, pctx, aggr_idx) < 0)
> +       if (prepare_metric(mexp, /*evsel=3D*/NULL, pctx, aggr_idx) < 0)
>                 goto out;
>
>         if (expr__parse(&ratio, pctx, mexp->metric_expr))
> --
> 2.43.0.594.gd9cf4e227d-goog
>

