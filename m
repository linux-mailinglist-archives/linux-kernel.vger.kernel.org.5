Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6238780FB66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjLLXaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjLLXaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:30:06 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075E3AC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:30:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so10745e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702423810; x=1703028610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PnmSrL3+v85QCcbIqj9sBzPFFRr2KTNuV/Sw5rXiXQ=;
        b=HKE+70NnCsxb1+mlfjC0+5UKMQM7y/u6tYoGY79WB1f3LfLbw/fvOdtzN/FDesv+oG
         k3/xxgYDwQ7t+en0ZQmyE7NyE9tHVcMRmKxahWwHmeNrbDu25yeO7R3RJvUd82ZhetM/
         R9MNDlnyj61DG7f/cKZdqJ4mZ43FzurB/7xSPiG2JDh3IwOCow2bD0HSVXdGZAYoXsUV
         NhfPJh2A6kcFTh4evjht3l522xItZypw4qWnQ4iOD7vAyJ1ioP4mZn3VObPLdC88K433
         ezprD/+gVfOdyymGWa+scxKa6G8mWI7NH+zJqLRu65K7loYJyTSRpXXmOU9sXIQN9f4v
         6m4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423810; x=1703028610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PnmSrL3+v85QCcbIqj9sBzPFFRr2KTNuV/Sw5rXiXQ=;
        b=ONFPKjesulTqaLV+kpCpPnlICoRfOb3OvztZ/JC00DP8B4GUffV863pqdy4nWACHnQ
         GM51JSRD6QqCBBstHZklTLL4pF9ZDHwQTIGi8XjgJl51T739FXwaLHJd9n/Bonum2NgL
         A+YqTufzGsrF+rThWQ+p9/9Vn1MRrvrRJurdYI1sLf2CpQtpc0yi92M+TOQp9qEPLNMJ
         Lz47UxzojC55JWZ6QbRVJmGn/o+r34/rtTQ1neyzfh4enwqE8JAZ+1mx3qoj5R/LvawG
         gftnnX51Xk20k4eF883uhxZjEZURXvggazzGSjvCm8rMGBaq2qdxx5Kt1wfLtKxWZJz9
         ifmQ==
X-Gm-Message-State: AOJu0YyiKmOi4QE4XGISHv0qv9ATE3vMkboP8I0YN2JwFgQvRxQ0S/Ox
        L+om+1q8i6Yg8ao7OibSCxJewt6cedvIG+WhFvGOUw==
X-Google-Smtp-Source: AGHT+IFV6uMwseN532IxDmIh27QR54iqUSOqY20zoZntAtvKKHbHJd2gfFEOveQRDwXmzyUj2mSgQvElOTz7fZ7NSUk=
X-Received: by 2002:a05:600c:3491:b0:40b:33aa:a2b9 with SMTP id
 a17-20020a05600c349100b0040b33aaa2b9mr384563wmq.4.1702423810223; Tue, 12 Dec
 2023 15:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20231212230224.1473300-1-weilin.wang@intel.com> <20231212230224.1473300-4-weilin.wang@intel.com>
In-Reply-To: <20231212230224.1473300-4-weilin.wang@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Dec 2023 15:29:59 -0800
Message-ID: <CAP-5=fUq7t8a=7mF-kQCL_u9AhfhkP3NPfwztpyWYM3mYRNCkg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/18] perf stat: Add basic functions for the
 hardware-grouping stat cmd option
To:     weilin.wang@intel.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Yang Jihong <yangjihong1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 3:02=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Add the first set of functions for the hardware-grouping method. Function
> hw_awre_parse_groups() is the entry point of this metric grouping method.

nit: s/awre/aware/

> It does metric grouping on a combined list of events and will create a li=
st
> of grouping strings as final results of the grouping method. These groupi=
ng
> strings will be used in the same mannor as existing metric grouping
> process.

nit: s/mannor/manner/

> This method will fall back to normal grouping when hardware aware groupin=
g
> return with err so that perf stat still executes and returns with correct
> result.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 210 +++++++++++++++++++++++++++++++++-
>  tools/perf/util/metricgroup.h |   9 ++
>  2 files changed, 218 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index dfbcdb517b78..8d1143ee898c 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1432,6 +1432,101 @@ static int build_combined_expr_ctx(const struct l=
ist_head *metric_list,
>         return ret;
>  }
>
> +/**
> + * hw_aware_build_grouping - Build event groupings by reading counter
> + * requirement of the events and counter available on the system from
> + * pmu-events.
> + * @ctx: the event identifiers parsed from metrics.
> + * @groupings: header to the list of final event grouping.
> + * @modifier: any modifiers added to the events.
> + */
> +static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_un=
used,
> +                                 struct list_head *groupings __maybe_unu=
sed,
> +                                 const char *modifier __maybe_unused)
> +{
> +       int ret =3D 0;
> +
> +       pr_debug("This is a placeholder\n");
> +       return ret;
> +}
> +
> +static void group_str_free(struct metricgroup__group_strs *g)
> +{
> +       if (!g)
> +               return;
> +
> +       strbuf_release(&g->grouping_str);
> +       free(g);
> +}
> +
> +static void metricgroup__free_grouping_strs(struct list_head
> +                                          *grouping_strs)
> +{
> +       struct metricgroup__group_strs *g, *tmp;
> +
> +       list_for_each_entry_safe(g, tmp, grouping_strs, nd) {
> +               list_del_init(&g->nd);
> +               group_str_free(g);
> +       }
> +}
> +
> +/**
> + * hw_aware_parse_ids - Build the event string for the ids and parse the=
m
> + * creating an evlist. The encoded metric_ids are decoded. Events are pl=
aced
> + * into groups based on event counter requirements and counter availabil=
ities of
> + * the system.
> + * @metric_no_merge: is metric sharing explicitly disabled.
> + * @fake_pmu: used when testing metrics not supported by the current CPU=
.
> + * @ids: the event identifiers parsed from a metric.
> + * @modifier: any modifiers added to the events.
> + * @out_evlist: the created list of events.
> + */
> +static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
> +                            struct expr_parse_ctx *ids, const char *modi=
fier,
> +                            struct evlist **out_evlist)
> +{
> +       struct parse_events_error parse_error;
> +       struct evlist *parsed_evlist;
> +       LIST_HEAD(groupings);
> +       struct metricgroup__group_strs *group;
> +       int ret;
> +
> +       *out_evlist =3D NULL;
> +       ret =3D hw_aware_build_grouping(ids, &groupings, modifier);
> +       if (ret) {
> +               metricgroup__free_grouping_strs(&groupings);
> +               return ret;
> +       }
> +
> +       parsed_evlist =3D evlist__new();
> +       if (!parsed_evlist) {
> +               ret =3D -ENOMEM;
> +               goto err_out;
> +       }
> +       list_for_each_entry(group, &groupings, nd) {
> +               struct strbuf *events =3D &group->grouping_str;
> +
> +               pr_debug("Parsing metric events '%s'\n", events->buf);
> +               parse_events_error__init(&parse_error);
> +               ret =3D __parse_events(parsed_evlist, events->buf, /*pmu_=
filter=3D*/NULL,
> +                                   &parse_error, fake_pmu, /*warn_if_reo=
rdered=3D*/false);
> +               if (ret) {
> +                       parse_events_error__print(&parse_error, events->b=
uf);
> +                       goto err_out;
> +               }
> +               ret =3D decode_all_metric_ids(parsed_evlist, modifier);
> +               if (ret)
> +                       goto err_out;
> +       }
> +       *out_evlist =3D parsed_evlist;
> +       parsed_evlist =3D NULL;
> +err_out:
> +       parse_events_error__exit(&parse_error);
> +       evlist__delete(parsed_evlist);
> +       metricgroup__free_grouping_strs(&groupings);
> +       return ret;
> +}
> +
>  /**
>   * parse_ids - Build the event string for the ids and parse them creatin=
g an
>   *             evlist. The encoded metric_ids are decoded.
> @@ -1520,6 +1615,114 @@ static int parse_ids(bool metric_no_merge, struct=
 perf_pmu *fake_pmu,
>         return ret;
>  }
>
> +static int hw_aware_parse_groups(struct evlist *perf_evlist,
> +                               const char *pmu, const char *str,
> +                               bool metric_no_threshold,
> +                               const char *user_requested_cpu_list,
> +                               bool system_wide,
> +                               struct perf_pmu *fake_pmu,
> +                               struct rblist *metric_events_list,
> +                               const struct pmu_metrics_table *table)
> +{
> +       struct evlist *combined_evlist =3D NULL;
> +       LIST_HEAD(metric_list);
> +       struct metric *m;
> +       int ret;
> +       bool metric_no_group =3D false;
> +       bool metric_no_merge =3D false;
> +
> +       if (metric_events_list->nr_entries =3D=3D 0)
> +               metricgroup__rblist_init(metric_events_list);
> +       ret =3D metricgroup__add_metric_list(pmu, str, metric_no_group, m=
etric_no_threshold,
> +                                          user_requested_cpu_list,
> +                                          system_wide, &metric_list, tab=
le);
> +       if (ret)
> +               goto out;
> +
> +       /* Sort metrics from largest to smallest. */
> +       list_sort(NULL, &metric_list, metric_list_cmp);
> +
> +       if (!metric_no_merge) {
> +               struct expr_parse_ctx *combined =3D NULL;
> +
> +               ret =3D build_combined_expr_ctx(&metric_list, &combined);
> +
> +               if (!ret && combined && hashmap__size(combined->ids)) {
> +                       ret =3D hw_aware_parse_ids(fake_pmu, combined,
> +                                               /*modifier=3D*/NULL,
> +                                               &combined_evlist);
> +               }
> +
> +               if (ret)
> +                       goto out;
> +
> +               if (combined)
> +                       expr__ctx_free(combined);
> +       }
> +
> +       list_for_each_entry(m, &metric_list, nd) {
> +               struct metric_expr *expr;
> +               struct metric_event *me;
> +               struct evsel **metric_events;
> +
> +               ret =3D setup_metric_events(fake_pmu ? "all" : m->pmu, m-=
>pctx->ids,
> +                                        combined_evlist, &metric_events)=
;
> +               if (ret) {
> +                       pr_debug("Cannot resolve IDs for %s: %s\n",
> +                               m->metric_name, m->metric_expr);
> +                       goto out;
> +               }
> +
> +               me =3D metricgroup__lookup(metric_events_list, metric_eve=
nts[0], true);
> +
> +               expr =3D malloc(sizeof(struct metric_expr));
> +               if (!expr) {
> +                       ret =3D -ENOMEM;
> +                       free(metric_events);
> +                       goto out;
> +               }
> +
> +               expr->metric_refs =3D m->metric_refs;
> +               m->metric_refs =3D NULL;
> +               expr->metric_expr =3D m->metric_expr;
> +               if (m->modifier) {
> +                       char *tmp;
> +
> +                       if (asprintf(&tmp, "%s:%s", m->metric_name, m->mo=
difier) < 0)
> +                               expr->metric_name =3D NULL;
> +                       else
> +                               expr->metric_name =3D tmp;
> +               } else {
> +                       expr->metric_name =3D strdup(m->metric_name);
> +               }
> +
> +               if (!expr->metric_name) {
> +                       ret =3D -ENOMEM;
> +                       free(metric_events);
> +                       goto out;
> +               }
> +               expr->metric_threshold =3D m->metric_threshold;
> +               expr->metric_unit =3D m->metric_unit;
> +               expr->metric_events =3D metric_events;
> +               expr->runtime =3D m->pctx->sctx.runtime;
> +               list_add(&expr->nd, &me->head);
> +       }
> +
> +       if (combined_evlist) {
> +               evlist__splice_list_tail(perf_evlist, &combined_evlist->c=
ore.entries);
> +               evlist__delete(combined_evlist);
> +       }
> +
> +       list_for_each_entry(m, &metric_list, nd) {
> +               if (m->evlist)
> +                       evlist__splice_list_tail(perf_evlist, &m->evlist-=
>core.entries);
> +       }
> +
> +out:
> +       metricgroup__free_metrics(&metric_list);
> +       return ret;
> +}
> +
>  static int parse_groups(struct evlist *perf_evlist,
>                         const char *pmu, const char *str,
>                         bool metric_no_group,
> @@ -1698,10 +1901,15 @@ int metricgroup__parse_groups(struct evlist *perf=
_evlist,
>         if (!table)
>                 return -EINVAL;
>         if (hardware_aware_grouping) {
> +               int ret;
>                 pr_debug("Use hardware aware grouping instead of traditio=
nal metric grouping method\n");
> +               ret =3D hw_aware_parse_groups(perf_evlist, pmu, str,
> +                           metric_no_threshold, user_requested_cpu_list,=
 system_wide,
> +                           /*fake_pmu=3D*/NULL, metric_events, table);
> +               if (!ret)
> +                       return 0;
>         }
>
> -
>         return parse_groups(perf_evlist, pmu, str, metric_no_group, metri=
c_no_merge,
>                             metric_no_threshold, user_requested_cpu_list,=
 system_wide,
>                             /*fake_pmu=3D*/NULL, metric_events, table);
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index 779f6ede1b51..89809df85644 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -6,6 +6,7 @@
>  #include <linux/rbtree.h>
>  #include <stdbool.h>
>  #include "pmu-events/pmu-events.h"
> +#include "strbuf.h"
>
>  struct evlist;
>  struct evsel;
> @@ -66,6 +67,14 @@ struct metric_expr {
>         int runtime;
>  };
>
> +/**
> + * Each group is one node in the group string list.
> + */
> +struct metricgroup__group_strs {
> +       struct list_head nd;
> +       struct strbuf grouping_str;
> +};

This can go in the C file to reduce the scope.

> +
>  struct metric_event *metricgroup__lookup(struct rblist *metric_events,
>                                          struct evsel *evsel,
>                                          bool create);
> --
> 2.39.3
>
