Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B64787F17
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 06:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbjHYEwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 00:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjHYEvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 00:51:36 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BAF1FD2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:51:34 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40c72caec5cso180461cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692939093; x=1693543893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPFyyKMSssNX8avgS44LTxp2qnFm6/B0jvZ21cpGXLk=;
        b=FBl1UivoDQtUIUksVjHTkoZ6n2tK7zRoU6FiOsFc0VFCTsH8gcBw00EL6qyN2a5+sb
         iK+rQhhFr89SgCJVZ71zNQsQH4P9tCekaR7zI7xsLIGq3ouwhuyM3N21/HOvVjyrsWvD
         JxfUaA82T9pbQ1uqSQS0d6PukVs+lR13M57PGDMt2OuUc4qeltboMRxkmi4mndYonQ1O
         sLpNjTXL9uxW2BPBEy1NbbNoBhkGQJ1fG0e3KijOM4Qsye2/Hgw6aBgYysDzwkAf+RaN
         TjIz5O4B0sWV155jmCJPrr661QMaIYymyL+89yvFfTXYHlNn9zPzUOMolurN4PWqZsL1
         ovRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692939093; x=1693543893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPFyyKMSssNX8avgS44LTxp2qnFm6/B0jvZ21cpGXLk=;
        b=I36gqSInRRnP6UmwS0w5NhYUUm24LLIPU3AdfRB/vU1+XrDvNSivoOW0pxZUSI23Fm
         0GLFG59UTS2ZgtsWVTy5RzZ5FjjnP7CQRF/eJzOlJMV9+HsJ/XM88Q7h3uk5hJ2v2vYW
         OJm2LY9mJon0knwh7oEJnR0ExjJ0U4KZ2BUwK6SRgpjZfwNfUfLduG+xdj4pYCQX/PEV
         y3DmEfi12obOaqtr83sG9emFIh8/C9nok8l36/56Y6atlxLTaIAwag4JY+BZA6/5YiCV
         4vwXPBHyTHzYS+3SUUCpjADMlEzfkN/ibBJDPv/rbOYy6QEz7uPTxnPUsHxtP3Finkhm
         JW5g==
X-Gm-Message-State: AOJu0YzVilmeMHaUuAouazRG1N4Fj5H1Zi3Thig3Hdtn9GPqmSVtxHW2
        Yja9TnTcSQvHBEYbS1ztP64xS1cF1I4PygglerUlGCLSvLS0xtErt81w7Q==
X-Google-Smtp-Source: AGHT+IEDndaQpZqCUxYnXWbxxdq4b7vxoWXcbvDIOtr2iuaNWb0yaxCQqreDRgTOsMCtCqcAiJKKakJxRPLmmS7OLhQ=
X-Received: by 2002:a05:622a:1748:b0:404:8218:83da with SMTP id
 l8-20020a05622a174800b00404821883damr118639qtk.1.1692939093178; Thu, 24 Aug
 2023 21:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230821012734.18241-1-yangjihong1@huawei.com> <20230821012734.18241-2-yangjihong1@huawei.com>
In-Reply-To: <20230821012734.18241-2-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 21:51:22 -0700
Message-ID: <CAP-5=fXexLBnq1pkHPR5uXR-bL3CFTzEWkFnxHVs-71+S0yZSg@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] perf evlist: Add perf_evlist__go_system_wide() helper
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
> For dummy events that keep tracking, we may need to modify its cpu_maps.
> For example, change the cpu_maps to record sideband events for all CPUS.
> Add perf_evlist__go_system_wide() helper to support this scenario.
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/perf/evlist.c                  | 9 +++++++++
>  tools/lib/perf/include/internal/evlist.h | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index b8b066d0dc5e..3acbbccc1901 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -738,3 +738,12 @@ int perf_evlist__nr_groups(struct perf_evlist *evlis=
t)
>         }
>         return nr_groups;
>  }
> +
> +void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf=
_evsel *evsel)
> +{
> +       if (!evsel->system_wide) {
> +               evsel->system_wide =3D true;
> +               if (evlist->needs_map_propagation)
> +                       __perf_evlist__propagate_maps(evlist, evsel);
> +       }
> +}

I think this should be:

void evsel__set_system_wide(struct evsel *evsel)
{
        if (evsel->system_wide)
               return;
        evsel->system_wide =3D true;
        if (evsel->evlist->core.needs_map_propagation)
...

The API being on evlist makes it look like all evsels are affected.

Thanks,
Ian

> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/in=
clude/internal/evlist.h
> index 3339bc2f1765..d86ffe8ed483 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -135,4 +135,6 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist=
,
>  void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
>
>  void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel=
 *leader);
> +
> +void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf=
_evsel *evsel);
>  #endif /* __LIBPERF_INTERNAL_EVLIST_H */
> --
> 2.30.GIT
>
