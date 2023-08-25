Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8B5787EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 06:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241066AbjHYEQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 00:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240984AbjHYEQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 00:16:24 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6DD1FEA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:16:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4036bd4fff1so168701cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692936981; x=1693541781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVJbwQJBz4fIhry+uL3sWXjwZFHZzrz63eCkxNfFeEg=;
        b=e8bFzWmHf03M8HfSss8etDZ5SiePii+NFvLIl/lE9evGbFW/46KxPFfFpi/FKdXf9L
         yG762qPEjASMfACqfYr74KkKfa3t5g2yrDljs6Yx2Fxff+xMQNBUlQe5In5+iO41SyrK
         BZttaQpdEcjQaO7vLbpvsLyHj4fY9cO+veeZnzJeCnRWU68uSyWIGaPWS8PVBq8IFjV9
         bY7RkHKJpC3k1g0GS372fbNpChD3Z4RF8bwawqTPCeYLsAS7pwUcgofErPQpGqYG8y5v
         wINjKPyclsLFkBVb7rfIgzYpl7B3VcQR46j35HBTItzLgRFWAPrZ65A/A9APfuFCImBE
         V0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692936981; x=1693541781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVJbwQJBz4fIhry+uL3sWXjwZFHZzrz63eCkxNfFeEg=;
        b=g3gVOvWKa7wBLOaHa+t9tnnexfUXdgg7+HnzYLxoOezYBBI5gzDY+QNQizcw+v99/2
         TVCA+fJiXEM7u7tqH+tZcRpMK0FHlLnF133BnDR7tAcVk3Xaem+EasAIQWP0gQxcjsTE
         CGcYXphXTJG7xSdFHbKVUeRB1WJl4PWaStV4MDTA8nJu2SBC1REYPAkMOuiYsPOF2SyK
         dCfqqPkImI4twkpiVTxbWAgQrza13bZVU3GTgOJzjGVytQVuANljCS9tByZIDu5rgdPr
         yk7dBgKpdEC8MZY4VAhffHmGwwDcWqm5PAE+qXeHsbb10TciBtq5hqzsTV+hUiBIeQsm
         /2qA==
X-Gm-Message-State: AOJu0Yw24z8t9ErIEstNtf5el3bM3fDe4jtrKXYeXtR5oGYjdsIm+KOx
        UM6bCBfa5svKbFeuVFihd46SrWKGbyefZKnNk98Osg==
X-Google-Smtp-Source: AGHT+IE4V9Zc0SlNJEupRrn3MM6gX37NNqqjFDP7/Okcsn/QLAbipTiG1YcB7O1zkePViZ7vLYLb42kmb7ZQe197c/k=
X-Received: by 2002:ac8:5a11:0:b0:3f6:97b4:1a4d with SMTP id
 n17-20020ac85a11000000b003f697b41a4dmr92615qta.23.1692936980740; Thu, 24 Aug
 2023 21:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com> <1692606977-92009-3-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1692606977-92009-3-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 21:16:08 -0700
Message-ID: <CAP-5=fXnZq=5W7pzTcukRbQANF8VoW7rnz312JG09Wtk1tR1WQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] perf metric: "Compat" supports matching multiple identifiers
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 1:36=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> The jevent "Compat" is used for uncore PMU alias or metric definitions.
>
> The same PMU driver has different PMU identifiers due to different
> hardware versions and types, but they may have some common PMU metric.
> Since a Compat value can only match one identifier, when adding the
> same metric to PMUs with different identifiers, each identifier needs
> to be defined once, which is not streamlined enough.
>
> So let "Compat" supports matching multiple identifiers for uncore PMU
> metric.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 5e9c657..ff81bc5 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -477,7 +477,7 @@ static int metricgroup__sys_event_iter(const struct p=
mu_metric *pm,
>
>         while ((pmu =3D perf_pmu__scan(pmu))) {
>
> -               if (!pmu->id || strcmp(pmu->id, pm->compat))
> +               if (!pmu->id || !pmu_uncore_identifier_match(pmu->id, pm-=
>compat))
>                         continue;
>
>                 return d->fn(pm, table, d->data);
> --
> 1.8.3.1
>
