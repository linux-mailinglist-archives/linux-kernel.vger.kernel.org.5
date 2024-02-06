Return-Path: <linux-kernel+bounces-54173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B7C84ABD5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E1C1F2319F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363EC5676F;
	Tue,  6 Feb 2024 01:59:24 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491256755;
	Tue,  6 Feb 2024 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707184763; cv=none; b=bgdWTHUb9kIbXKfa+c2qIJENk50g7/ggPf+7iHHSEvVCzP6xRVDNdXadIq5elSZccECRKferVj1o85CkbacuCKaRYaVW/HLwdaiIGOg9Ns6ZblRMMXvqPLI1Qd2/0juN9/IRuN9T4zILN6bMndre7MxSxSZPhaiom4Yr3FEbM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707184763; c=relaxed/simple;
	bh=r9vumAN298IoFTVS6I0M+7tr2vqxdeO5Wmn0EhONg0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTQ6CJ0pO0B4KkGarDdl3vBrScbMeKhZlQvc/BrYgLvG2yZ8ivRYfq8ATkTDbjZJBd04d8nvLhvQg0JvIbdTw39l+ji7keCM1BLLgmvjErWxvXf18reCbY3riQ0OQ/bW4hcHPygKlHfHSGEqIune7uCeFoXxS6F9XG/lPBzr9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e055baec89so85711b3a.1;
        Mon, 05 Feb 2024 17:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707184761; x=1707789561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEiZj/ZXcZZxKH4nqZMCH9OZNvgzBPAEeqnI2Uq/nDI=;
        b=Xun1Xv8nYH470q9JO9Cilq0RYObM83gocZ3hyJkOEbHcBGDrI6+nHgkqEe4Z4ghHYw
         LTZp2g3ctrOesd/YU7wLywnNo2yTV48MnbPGsFt0JZtl+Yp6d0YLbvWe2KB2EroeYGGE
         d234+0LXvEVfIfJlK32/q4sm7pkanM0WHYW5Re+mPinI2Smtn8q4l16D25F8sz2Jq5Zx
         yfZj+Fcw3BI00rLW+7Iwne7UxOA0xFgNrrQGYquhIoTwIcamYvCxURoqsgMI8gFd1juL
         p/8eyaaNd9/wf2o3hm0Is5d4XQOhGWdks/bS1B8Kp3rf3Zp2442KO1sHw4N5T0vskUzD
         Dtyw==
X-Gm-Message-State: AOJu0Yz/6HotvCtemkfDqSteh3ZBafoF49W0dNiDwkJ7nUXVYnHvEQit
	WIwgeUGDiKUH4Ln+jQ4KJMuqazc+rqW2+7QWCi5m/JxsN527ENYMaqSIJ3NlUfks68Br2idOlGd
	dGmd8nSm0y8u90hfJ767ueGre2to=
X-Google-Smtp-Source: AGHT+IFtTT+cNJ2Ga/C9pnXdHHiwdsgl3cX+ktVlsQ113oFR3LoU8gSJJmD60Ez0iQMFxRs82lHfzl6iuApxo9YT+js=
X-Received: by 2002:a05:6a00:23cc:b0:6e0:5372:48a2 with SMTP id
 g12-20020a056a0023cc00b006e0537248a2mr3004692pfc.15.1707184760909; Mon, 05
 Feb 2024 17:59:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202022512.467636-1-irogers@google.com>
In-Reply-To: <20240202022512.467636-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 5 Feb 2024 17:59:09 -0800
Message-ID: <CAM9d7chAU=arK2y7RDHtxfRcQ80Az6dzGB0_+01iZ346tSob3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf stat: Pass fewer metric arguments
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
> Pass metric_expr and evsel rather than specific variables from the
> struct, thereby reducing the number of arguments. This will enable
> later fixes.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-shadow.c | 75 +++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 42 deletions(-)
>
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index e31426167852..f6c9d2f98835 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -355,23 +355,22 @@ static void print_nsecs(struct perf_stat_config *co=
nfig,
>                 print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0=
);
>  }
>
> -static int prepare_metric(struct evsel **metric_events,
> -                         struct metric_ref *metric_refs,
> +static int prepare_metric(const struct metric_expr *mexp,
>                           struct expr_parse_ctx *pctx,
>                           int aggr_idx)
>  {
>         int i;

You may add local variables with the same name to reduce
the amount of diff.

Thanks,
Namhyung

>
> -       for (i =3D 0; metric_events[i]; i++) {
> +       for (i =3D 0; mexp->metric_events[i]; i++) {
>                 char *n;
>                 double val;
>                 int source_count =3D 0;
>
> -               if (evsel__is_tool(metric_events[i])) {
> +               if (evsel__is_tool(mexp->metric_events[i])) {
>                         struct stats *stats;
>                         double scale;
>
> -                       switch (metric_events[i]->tool_event) {
> +                       switch (mexp->metric_events[i]->tool_event) {
>                         case PERF_TOOL_DURATION_TIME:
>                                 stats =3D &walltime_nsecs_stats;
>                                 scale =3D 1e-9;
> @@ -391,19 +390,20 @@ static int prepare_metric(struct evsel **metric_eve=
nts,
>                                 pr_err("Invalid tool event 'max'");
>                                 abort();
>                         default:
> -                               pr_err("Unknown tool event '%s'", evsel__=
name(metric_events[i]));
> +                               pr_err("Unknown tool event '%s'",
> +                                      evsel__name(mexp->metric_events[i]=
));
>                                 abort();
>                         }
>                         val =3D avg_stats(stats) * scale;
>                         source_count =3D 1;
>                 } else {
> -                       struct perf_stat_evsel *ps =3D metric_events[i]->=
stats;
> +                       struct perf_stat_evsel *ps =3D mexp->metric_event=
s[i]->stats;
>                         struct perf_stat_aggr *aggr =3D &ps->aggr[aggr_id=
x];
>
>                         if (!aggr)
>                                 break;
>
> -                        if (!metric_events[i]->supported) {
> +                       if (!mexp->metric_events[i]->supported) {
>                                 /*
>                                  * Not supported events will have a count=
 of 0,
>                                  * which can be confusing in a
> @@ -419,19 +419,19 @@ static int prepare_metric(struct evsel **metric_eve=
nts,
>                                  * reverse the scale before computing the
>                                  * metric.
>                                  */
> -                               val =3D aggr->counts.val * (1.0 / metric_=
events[i]->scale);
> -                               source_count =3D evsel__source_count(metr=
ic_events[i]);
> +                               val =3D aggr->counts.val * (1.0 / mexp->m=
etric_events[i]->scale);
> +                               source_count =3D evsel__source_count(mexp=
->metric_events[i]);
>                         }
>                 }
> -               n =3D strdup(evsel__metric_id(metric_events[i]));
> +               n =3D strdup(evsel__metric_id(mexp->metric_events[i]));
>                 if (!n)
>                         return -ENOMEM;
>
>                 expr__add_id_val_source_count(pctx, n, val, source_count)=
;
>         }
>
> -       for (int j =3D 0; metric_refs && metric_refs[j].metric_name; j++)=
 {
> -               int ret =3D expr__add_ref(pctx, &metric_refs[j]);
> +       for (int j =3D 0; mexp->metric_refs && mexp->metric_refs[j].metri=
c_name; j++) {
> +               int ret =3D expr__add_ref(pctx, &mexp->metric_refs[j]);
>
>                 if (ret)
>                         return ret;
> @@ -441,14 +441,8 @@ static int prepare_metric(struct evsel **metric_even=
ts,
>  }
>
>  static void generic_metric(struct perf_stat_config *config,
> -                          const char *metric_expr,
> -                          const char *metric_threshold,
> -                          struct evsel **metric_events,
> -                          struct metric_ref *metric_refs,
> -                          char *name,
> -                          const char *metric_name,
> -                          const char *metric_unit,
> -                          int runtime,
> +                       struct metric_expr *mexp,
> +                       struct evsel *evsel,
>                            int aggr_idx,
>                            struct perf_stat_output_ctx *out)
>  {
> @@ -465,55 +459,55 @@ static void generic_metric(struct perf_stat_config =
*config,
>
>         if (config->user_requested_cpu_list)
>                 pctx->sctx.user_requested_cpu_list =3D strdup(config->use=
r_requested_cpu_list);
> -       pctx->sctx.runtime =3D runtime;
> +       pctx->sctx.runtime =3D mexp->runtime;
>         pctx->sctx.system_wide =3D config->system_wide;
> -       i =3D prepare_metric(metric_events, metric_refs, pctx, aggr_idx);
> +       i =3D prepare_metric(mexp, pctx, aggr_idx);
>         if (i < 0) {
>                 expr__ctx_free(pctx);
>                 return;
>         }
> -       if (!metric_events[i]) {
> -               if (expr__parse(&ratio, pctx, metric_expr) =3D=3D 0) {
> +       if (!mexp->metric_events[i]) {
> +               if (expr__parse(&ratio, pctx, mexp->metric_expr) =3D=3D 0=
) {
>                         char *unit;
>                         char metric_bf[64];
>
> -                       if (metric_threshold &&
> -                           expr__parse(&threshold, pctx, metric_threshol=
d) =3D=3D 0 &&
> +                       if (mexp->metric_threshold &&
> +                           expr__parse(&threshold, pctx, mexp->metric_th=
reshold) =3D=3D 0 &&
>                             !isnan(threshold)) {
>                                 color =3D fpclassify(threshold) =3D=3D FP=
_ZERO
>                                         ? PERF_COLOR_GREEN : PERF_COLOR_R=
ED;
>                         }
>
> -                       if (metric_unit && metric_name) {
> -                               if (perf_pmu__convert_scale(metric_unit,
> +                       if (mexp->metric_unit && mexp->metric_name) {
> +                               if (perf_pmu__convert_scale(mexp->metric_=
unit,
>                                         &unit, &scale) >=3D 0) {
>                                         ratio *=3D scale;
>                                 }
> -                               if (strstr(metric_expr, "?"))
> +                               if (strstr(mexp->metric_expr, "?"))
>                                         scnprintf(metric_bf, sizeof(metri=
c_bf),
> -                                         "%s  %s_%d", unit, metric_name,=
 runtime);
> +                                         "%s  %s_%d", unit, mexp->metric=
_name, mexp->runtime);
>                                 else
>                                         scnprintf(metric_bf, sizeof(metri=
c_bf),
> -                                         "%s  %s", unit, metric_name);
> +                                         "%s  %s", unit, mexp->metric_na=
me);
>
>                                 print_metric(config, ctxp, color, "%8.1f"=
,
>                                              metric_bf, ratio);
>                         } else {
>                                 print_metric(config, ctxp, color, "%8.2f"=
,
> -                                       metric_name ?
> -                                       metric_name :
> -                                       out->force_header ?  name : "",
> +                                       mexp->metric_name ?
> +                                       mexp->metric_name :
> +                                       out->force_header ?  evsel->name =
: "",
>                                         ratio);
>                         }
>                 } else {
>                         print_metric(config, ctxp, color, /*unit=3D*/NULL=
,
>                                      out->force_header ?
> -                                    (metric_name ? metric_name : name) :=
 "", 0);
> +                                    (mexp->metric_name ?: evsel->name) :=
 "", 0);
>                 }
>         } else {
>                 print_metric(config, ctxp, color, /*unit=3D*/NULL,
>                              out->force_header ?
> -                            (metric_name ? metric_name : name) : "", 0);
> +                            (mexp->metric_name ?: evsel->name) : "", 0);
>         }
>
>         expr__ctx_free(pctx);
> @@ -528,7 +522,7 @@ double test_generic_metric(struct metric_expr *mexp, =
int aggr_idx)
>         if (!pctx)
>                 return NAN;
>
> -       if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, =
aggr_idx) < 0)
> +       if (prepare_metric(mexp, pctx, aggr_idx) < 0)
>                 goto out;
>
>         if (expr__parse(&ratio, pctx, mexp->metric_expr))
> @@ -630,10 +624,7 @@ void *perf_stat__print_shadow_stats_metricgroup(stru=
ct perf_stat_config *config,
>
>                 if ((*num)++ > 0)
>                         out->new_line(config, ctxp);
> -               generic_metric(config, mexp->metric_expr, mexp->metric_th=
reshold,
> -                              mexp->metric_events, mexp->metric_refs, ev=
sel->name,
> -                              mexp->metric_name, mexp->metric_unit, mexp=
->runtime,
> -                              aggr_idx, out);
> +               generic_metric(config, mexp, evsel, aggr_idx, out);
>         }
>
>         return NULL;
> --
> 2.43.0.594.gd9cf4e227d-goog
>

