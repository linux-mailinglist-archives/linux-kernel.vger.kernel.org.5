Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653D1787F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 06:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240527AbjHYEzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 00:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238532AbjHYEzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 00:55:16 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB5B1FD2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:55:13 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40a47e8e38dso103211cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692939313; x=1693544113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UK9NVtWAgJG26oBVv+ugNcP8zu19Nzww0/cbuK0LKZU=;
        b=MU6eA2NshUQx9YMB3iZZJtKoCm0v0il/KBTcCJK8yvtz1olQRcGk8RF05Sw1tWaaHH
         x39al0Ob36T/KAkjLAwJ3VkChShoxX6035TVMxEZ9uE/HmteFSJurmKIKfLO6IXcU85/
         NAmkac9Rz8MxV/sluc9ryyNnj6k8Xm3dRj0TKh2SMZ+Y7INnyCnJp7SeqU/ZrrhPOLEn
         /8mvcc+wqr+2aq9kKnHhJk1G3tPZIo5qEYPZ035oN6BiGUirdCgOz8xeFjXtqKeB6u0W
         DrUeqBHZQ9sctSnmGus72kA25KzSRyV3MWMtm1KMr8YkNIJCwZFijNiuhf7QLZfUSNkO
         yfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692939313; x=1693544113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK9NVtWAgJG26oBVv+ugNcP8zu19Nzww0/cbuK0LKZU=;
        b=Eauf9DS4lqvO7jgLDwfydtbRdvETkqpxXK9civGJuW96RZlXpxgIfmNInbDZMZnCr8
         W//HWRFmRSNZnEDbozqiuOLmMiVsM2C8FEQLuxiiTBMLPE/acsiYNTXxDDnNTFsZUOsn
         bUsxQfQwdtLK03MAfQy4iY2guHAuANbjwTsblHX2PXfj6bfa9S2LBz9cqleknZHRmVXL
         zCXqH5d+rokULvRHL5KCpQ1u9E1MfGAkvZOYhZYCngy9+Ob1AJbGewU2rmVqZL2eexBB
         jsfsuibZNZDHpxrWq2Xh7ORIxJW7mPAF9MdBM267KgKOuqMMOFljj2Hv9Gt8NuOT6GjA
         b2Hg==
X-Gm-Message-State: AOJu0YyLjtbt+sMrKupPcUTwq1YsuRcTx3nU/Ys0Zzj1IwSGZjKNaPFy
        NuxRos2Uv/I0Enq5evyeX5B2RyU7TfDOlobw2WuHAg==
X-Google-Smtp-Source: AGHT+IFE9mZvnAi5E7Oy2yBGlF7nZ1VVggJms2FC9NjJexufTqRq5Fiy/5Hx4gqtsfzMZSkM/j2JQ3NKRnRjjVR3T3g=
X-Received: by 2002:ac8:5ad2:0:b0:410:9d71:ba5d with SMTP id
 d18-20020ac85ad2000000b004109d71ba5dmr117201qtd.25.1692939312913; Thu, 24 Aug
 2023 21:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230821012734.18241-1-yangjihong1@huawei.com> <20230821012734.18241-3-yangjihong1@huawei.com>
In-Reply-To: <20230821012734.18241-3-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 21:55:01 -0700
Message-ID: <CAP-5=fVw9eO=rVLHL+XuaFxsfwD+ji2f9xWdOv3AkaYj9A+w0A@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] perf evlist: Add evlist__findnew_tracking_event() helper
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
> Currently, intel-bts, intel-pt, and arm-spe may add a dummy event for
> tracking to the evlist. We may need to search for the dummy event for
> some settings. Therefore, add evlist__findnew_tracking_event() helper.

Given the first two sentences I don't understand why this is
evlist__findnew_tracking_event and not evlist__findnew_dummy_event?
Are you setting tracking on other events other than dummy? If so, then
the commit message isn't right. If not then I'd prefer not to use
tracking event in the function name.

>
> evlist__findnew_tracking_event() also deal with system_wide maps if
> system_wide is true.

Could you fix the explanation here, what does "deal with system_wide"
mean? A kerneldoc comment and explanation of the system_wide argument
would be useful.

Thanks,
Ian

> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-record.c | 11 +++--------
>  tools/perf/util/evlist.c    | 18 ++++++++++++++++++
>  tools/perf/util/evlist.h    |  1 +
>  3 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 34bb31f08bb5..12edad8392cc 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1293,14 +1293,9 @@ static int record__open(struct record *rec)
>          */
>         if (opts->target.initial_delay || target__has_cpu(&opts->target) =
||
>             perf_pmus__num_core_pmus() > 1) {
> -               pos =3D evlist__get_tracking_event(evlist);
> -               if (!evsel__is_dummy_event(pos)) {
> -                       /* Set up dummy event. */
> -                       if (evlist__add_dummy(evlist))
> -                               return -ENOMEM;
> -                       pos =3D evlist__last(evlist);
> -                       evlist__set_tracking_event(evlist, pos);
> -               }
> +               pos =3D evlist__findnew_tracking_event(evlist, false);
> +               if (!pos)
> +                       return -ENOMEM;
>
>                 /*
>                  * Enable the dummy event when the process is forked for
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 7ef43f72098e..25c3ebe2c2f5 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1694,6 +1694,24 @@ void evlist__set_tracking_event(struct evlist *evl=
ist, struct evsel *tracking_ev
>         tracking_evsel->tracking =3D true;
>  }
>
> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, bool=
 system_wide)
> +{
> +       struct evsel *evsel;
> +
> +       evsel =3D evlist__get_tracking_event(evlist);
> +       if (!evsel__is_dummy_event(evsel)) {
> +               evsel =3D evlist__add_aux_dummy(evlist, system_wide);
> +               if (!evsel)
> +                       return NULL;
> +
> +               evlist__set_tracking_event(evlist, evsel);
> +       } else if (system_wide) {
> +               perf_evlist__go_system_wide(&evlist->core, &evsel->core);
> +       }
> +
> +       return evsel;
> +}
> +
>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const cha=
r *str)
>  {
>         struct evsel *evsel;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 664c6bf7b3e0..98e7ddb2bd30 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -387,6 +387,7 @@ bool evlist_cpu_iterator__end(const struct evlist_cpu=
_iterator *evlist_cpu_itr);
>
>  struct evsel *evlist__get_tracking_event(struct evlist *evlist);
>  void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tra=
cking_evsel);
> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, bool=
 system_wide);
>
>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const cha=
r *str);
>
> --
> 2.30.GIT
>
