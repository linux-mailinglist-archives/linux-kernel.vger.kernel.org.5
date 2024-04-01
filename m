Return-Path: <linux-kernel+bounces-127044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A05894623
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E1EB225EE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484C15579A;
	Mon,  1 Apr 2024 20:34:50 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DD941A81;
	Mon,  1 Apr 2024 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003689; cv=none; b=uvOJvFk6TxGHGDF8R9TY3KSV5UZi1zOxSGWUrmkAEKyCBgSMN7xIsE+wzbtvENHKG3GJqGoSZRu7B0M8Yp8VxKxaIBSBRUuwwPost9MUHplqBH0gUzdACujcGa1wJctCHQtO74L6EQBh2lCePDFEQt6Xg2TiIyXgx/at2wHpivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003689; c=relaxed/simple;
	bh=zTb10yAyJzSUvw4jcT+sRrqI5txFvClYEey9vEoTK7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDIYxzuT8RcYDdB96wKTXd3dVxsXtMDcXcsLZZP5AhMF66sYI8KfLoL8dSxHEeytNsKen9Ri/qZxMo1jqb9+8VVHGypJGwopgEQ8KxBgCdE8EjWR+qPqK2HogbEd5w/ZH/Vgk5fz4nFLeGxXiAJvwkq0UqZjwK2Hd/APYqGsPWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e7425a6714so3608952b3a.0;
        Mon, 01 Apr 2024 13:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003687; x=1712608487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXVaY3G/d6Eq8xnia9iWtACY1/LzEUfU4H07xndy94A=;
        b=DLQyj64NvAgTOAZz4W3ipVLdq1YnIF5LHcdj8j6xvaI0pgYL6EJkjx6swFiyJbKwY6
         eS56Cq9TcNM71HA1aQSddPvjh0Qw6QLjPsKPhi0o5NQ4Pj51lqr7bpg7ckcCgcztMIUS
         doRoZJSAWjVFfzPI4alvlJwRP28zED7EFKI83tzUzksC0kWRLKQZJYTCIRnd/ZG7wmN5
         rcsRw/cAVyRDZJ3nZwMtmESUOXkU4KlNxuy3APsEY3lqCERs7o6ZeI//ZeUOgKnnHqFV
         Wi76FBPKQwCqPlqJrZBtiv72AZ3HfrS75um7DpYWKJksJXyQehj5636nghK5Qd9zp49S
         Rp3A==
X-Forwarded-Encrypted: i=1; AJvYcCWa7HKp0yXiAax/spoBP6iveuks3O6PWgKzESwAiuyLBzU84mK1KhI+9LbHVSNnpNpOH/EtDSL4+gdxhc/8kX4M2/Uy6kZGZ93iMPDkGMOqRgRoWajhNG3aYuqqtoofaOMMl0egml6lorqsIItITw==
X-Gm-Message-State: AOJu0YyPbuqkmkpmx9FY7GY6QGTeWfIZE6npIHM6/+NU9NasLvIf0CYT
	QOEAkZ5u/E6PFGFR1Ogzqu7KcDKPP7ENHqN7xv/joep+1c8JW53/RblF1hh3Gth4AxDa/GVE8Ps
	/PNs7rnNfLKsZ5hDTPiQE9c//1gNu1ljJ
X-Google-Smtp-Source: AGHT+IEqBSAtyGt0ACrfNdnK3Wd1mX3wUGY10DvKxFWW1xSE2i9I3WitM3FBROnIDGG1V5FEw2xr0bDvSYih6dvIMQ0=
X-Received: by 2002:a05:6a20:9f0b:b0:1a3:72d6:641e with SMTP id
 mk11-20020a056a209f0b00b001a372d6641emr11951449pzb.20.1712003686951; Mon, 01
 Apr 2024 13:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191224.1046866-1-weilin.wang@intel.com> <20240329191224.1046866-2-weilin.wang@intel.com>
In-Reply-To: <20240329191224.1046866-2-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 1 Apr 2024 13:34:35 -0700
Message-ID: <CAM9d7chzKCM1erCd4aBoGupPrwvY6Siy1mJ60_1XXZP-Bz8d+g@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/5] perf stat: Parse and find tpebs events when
 parsing metrics to prepare for perf record sampling
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Weilin,

On Fri, Mar 29, 2024 at 12:12=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Metrics that use tpebs values would use the R as retire_latency modifier =
in
> formulas. We put all these events into a list and pass the list to perf
> record to collect their retire latency value.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c     | 38 +++++++++++++--
>  tools/perf/util/metricgroup.c | 88 +++++++++++++++++++++++++++++------
>  tools/perf/util/metricgroup.h | 10 +++-
>  tools/perf/util/stat.h        |  2 +
>  4 files changed, 119 insertions(+), 19 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 6bba1a89d030..6291e1e24535 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -162,6 +162,7 @@ static struct perf_stat_config stat_config =3D {
>         .ctl_fd                 =3D -1,
>         .ctl_fd_ack             =3D -1,
>         .iostat_run             =3D false,
> +       .tpebs_events           =3D LIST_HEAD_INIT(stat_config.tpebs_even=
ts),
>  };
>
>  static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> @@ -686,6 +687,12 @@ static enum counter_recovery stat_handle_error(struc=
t evsel *counter)
>         return COUNTER_FATAL;
>  }
>
> +static int __run_perf_record(void)
> +{
> +       pr_debug("Prepare perf record for retire_latency\n");
> +       return 0;
> +}
> +
>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  {
>         int interval =3D stat_config.interval;
> @@ -703,6 +710,16 @@ static int __run_perf_stat(int argc, const char **ar=
gv, int run_idx)
>         int err;
>         bool second_pass =3D false;
>
> +       /* Prepare perf record for sampling event retire_latency before f=
ork and
> +        * prepare workload */
> +       if (stat_config.tpebs_event_size > 0) {
> +               int ret;
> +
> +               ret =3D __run_perf_record();
> +               if (ret)
> +                       return ret;
> +       }
> +
>         if (forks) {
>                 if (evlist__prepare_workload(evsel_list, &target, argv, i=
s_pipe, workload_exec_failed_signal) < 0) {
>                         perror("failed to prepare workload");
> @@ -2106,7 +2123,9 @@ static int add_default_attributes(void)
>                                                 stat_config.metric_no_thr=
eshold,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> -                                               &stat_config.metric_event=
s);
> +                                               &stat_config.metric_event=
s,
> +                                               &stat_config.tpebs_events=
,
> +                                               &stat_config.tpebs_event_=
size);

Maybe it'd be better to pass the stat_config, but it can be done later.


>         }
>
>         if (smi_cost) {
> @@ -2139,7 +2158,9 @@ static int add_default_attributes(void)
>                                                 stat_config.metric_no_thr=
eshold,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> -                                               &stat_config.metric_event=
s);
> +                                               &stat_config.metric_event=
s,
> +                                               &stat_config.tpebs_events=
,
> +                                               &stat_config.tpebs_event_=
size);
>         }
>
>         if (topdown_run) {
> @@ -2173,7 +2194,9 @@ static int add_default_attributes(void)
>                                                 /*metric_no_threshold=3D*=
/true,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> -                                               &stat_config.metric_event=
s) < 0)
> +                                               &stat_config.metric_event=
s,
> +                                               &stat_config.tpebs_events=
,
> +                                               &stat_config.tpebs_event_=
size) < 0)
>                         return -1;
>         }
>
> @@ -2214,7 +2237,9 @@ static int add_default_attributes(void)
>                                                         /*metric_no_thres=
hold=3D*/true,
>                                                         stat_config.user_=
requested_cpu_list,
>                                                         stat_config.syste=
m_wide,
> -                                                       &stat_config.metr=
ic_events) < 0)
> +                                                       &stat_config.metr=
ic_events,
> +                                                       /*&stat_config.tp=
ebs_events=3D*/NULL,
> +                                                       /*stat_config.tpe=
bs_event_size=3D*/0) < 0)
>                                 return -1;
>
>                         evlist__for_each_entry(metric_evlist, metric_evse=
l) {
> @@ -2736,6 +2761,7 @@ int cmd_stat(int argc, const char **argv)
>                 }
>         }
>
> +
>         /*
>          * Metric parsing needs to be delayed as metrics may optimize eve=
nts
>          * knowing the target is system-wide.
> @@ -2748,7 +2774,9 @@ int cmd_stat(int argc, const char **argv)
>                                                 stat_config.metric_no_thr=
eshold,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> -                                               &stat_config.metric_event=
s);
> +                                               &stat_config.metric_event=
s,
> +                                               &stat_config.tpebs_events=
,
> +                                               &stat_config.tpebs_event_=
size);
>
>                 zfree(&metrics);
>                 if (ret) {
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 79ef6095ab28..8e007d60af91 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -277,7 +277,8 @@ static bool contains_metric_id(struct evsel **metric_=
events, int num_events,
>   */
>  static int setup_metric_events(const char *pmu, struct hashmap *ids,
>                                struct evlist *metric_evlist,
> -                              struct evsel ***out_metric_events)
> +                              struct evsel ***out_metric_events,
> +                              size_t tpebs_event_size)
>  {
>         struct evsel **metric_events;
>         const char *metric_id;
> @@ -286,7 +287,7 @@ static int setup_metric_events(const char *pmu, struc=
t hashmap *ids,
>         bool all_pmus =3D !strcmp(pmu, "all") || perf_pmus__num_core_pmus=
() =3D=3D 1 || !is_pmu_core(pmu);
>
>         *out_metric_events =3D NULL;
> -       ids_size =3D hashmap__size(ids);
> +       ids_size =3D hashmap__size(ids) - tpebs_event_size;
>
>         metric_events =3D calloc(ids_size + 1, sizeof(void *));
>         if (!metric_events)
> @@ -323,6 +324,7 @@ static int setup_metric_events(const char *pmu, struc=
t hashmap *ids,
>                 }
>         }
>         if (matched_events < ids_size) {
> +               pr_debug("Error: matched_events =3D %lu, ids_size =3D %lu=
\n", matched_events, ids_size);
>                 free(metric_events);
>                 return -EINVAL;
>         }
> @@ -668,7 +670,9 @@ static int decode_all_metric_ids(struct evlist *perf_=
evlist, const char *modifie
>  static int metricgroup__build_event_string(struct strbuf *events,
>                                            const struct expr_parse_ctx *c=
tx,
>                                            const char *modifier,
> -                                          bool group_events)
> +                                          bool group_events,
> +                                          struct list_head *tpebs_events=
 __maybe_unused,
> +                                          size_t *tpebs_event_size)
>  {
>         struct hashmap_entry *cur;
>         size_t bkt;
> @@ -681,8 +685,56 @@ static int metricgroup__build_event_string(struct st=
rbuf *events,
>         hashmap__for_each_entry(ctx->ids, cur, bkt) {
>                 const char *sep, *rsep, *id =3D cur->pkey;
>                 enum perf_tool_event ev;
> +               /*
> +                * Parse and search for event name with retire_latency mo=
difier R.
> +                * If found, put event name into the tpebs_events list. T=
his list
> +                * of events will be passed to perf record for sampling t=
o get
> +                * their reitre_latency value.
> +                * Search for ":R" in event name without "@". Search for =
the
> +                * last "@R" in event name with "@".

Hmm.. it seems you look for an 'R' modifier and then change it to 'p', righ=
t?
Why not use strrchr to check ':' or '@' and if it's followed by 'R'?

Is the 'R' modifier only used in the metric expressions?  Also please menti=
on
why some events have "@" in the name and others don't.


> +                */
> +               char *p =3D strstr(id, ":R");
> +               char *p1 =3D strstr(id, "@R");
> +
> +               if (p =3D=3D NULL && p1) {
> +                       p =3D strstr(p1+1, "@R");
> +                       if (p =3D=3D NULL)
> +                               p =3D p1;
> +                       p =3D p+1;
> +               }
> +
> +               if (p) {
> +                       char *name;
> +                       char *at;
> +                       struct tpebs_event *new_event =3D malloc(sizeof(s=
truct tpebs_event));
>
> -               pr_debug("found event %s\n", id);
> +                       if (!new_event)
> +                               return -ENOMEM;
> +
> +                       new_event->tpebs_name =3D strdup(id);
> +                       *p =3D '\0';

I think 'p' points to the 'id' string ("cur->pkey").  Is it ok to
change it here?
I guess you may want to do it on the tpebs_name.

Thanks,
Namhyung


> +                       name =3D malloc(strlen(id) + 2);
> +                       if (!name)
> +                               return -ENOMEM;
> +
> +                       at =3D strchr(id, '@');
> +                       if (at !=3D NULL) {
> +                               *at =3D '/';
> +                               at =3D strchr(id, '@');
> +                               *at =3D '/';
> +                               strcpy(name, id);
> +                               strcat(name, "p");
> +                       } else {
> +                               strcpy(name, id);
> +                               strcat(name, ":p");
> +                       }
> +                       new_event->name =3D name;
> +                       *tpebs_event_size +=3D 1;
> +                       pr_debug("retire_latency required, tpebs_event_si=
ze=3D%lu, new_event=3D%s\n",
> +                               *tpebs_event_size, new_event->name);
> +                       list_add_tail(&new_event->nd, tpebs_events);
> +                       continue;
> +               }
>

