Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5B787F03
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 06:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbjHYE17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 00:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjHYE1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 00:27:34 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C8C1FEA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:27:32 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34cabf65ee8so102315ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692937651; x=1693542451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ECeZvJgWFqtvuD7lpXIBJzl5ySRLWKUmXwSQbbS8+U=;
        b=CTKbdpKutG2ZtFvieJDjMh/qF+j9+oMKWYoFKNHfNCWNUYf9xKuvYv5vUWNuvmK7n+
         488Twg616fT0l1WsmEGMUbHKeIQNXofmFP9k0W/n2wnEnn2onJ5AkjTT3wjBK5076JdN
         LA1BK+A6fsuOMT/nda3HYH1V148TE4Mg4w47v0ZSj7SDkNwPyoJBxn21psMwMoA14Ic2
         JEf16THyEGt33cVjmMdnBPb9z0q1pwOBP9wbhnps83eiaNYRMVzooWoSzHPNbHK2iX5F
         16r5cx7q/GnVIpCBCAjYuCcvWWaNBcNzQgxArp2oN7TvB25qCkUIHCq2Gz4o57ikfCXe
         Vd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692937651; x=1693542451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ECeZvJgWFqtvuD7lpXIBJzl5ySRLWKUmXwSQbbS8+U=;
        b=Pi7qUCeYmf9ldyEcsNZYJOcf+x+fSrfmOSsJ8vMtxuXPlHkwqlWnSwCb2BUWChYMEx
         ZhGaV5m+mtFY/SJ9UF1Xf0ApUHlwT+K9f8uJ5ycTulJ/pw59qe+4GPio9zv0w190Z7gU
         AcxlpLbkl24Tte6pDnHBloscIm6pd5JQRhSgwPKy9QCQx52sByTYHRe2ecEhhNA2rkfL
         l7dOHGVW0kSk1G3iUviFBsubo7mZ7/aktqVCE+ZDCYBh3K2qRsUMlfmlU7Gp9oLE+o+N
         UmwP3lGLnLukdTZxOZB/O8WweZvDJEPoKrPdSVmFJDzfabhK/kizNs2lR4D8NODFa2Wt
         xdJA==
X-Gm-Message-State: AOJu0YxM5uDpauYrWQ6hlVyOcrhTyuEB9vrzridimvVpQn5i5es36T0F
        Y9id9VEvXFPhti+wgRIFG5A9UCuWKDs86tta1Rcc0A==
X-Google-Smtp-Source: AGHT+IFv/SzSk0p4koyu2JQ/XSi3hHVcudbdNIEaHl1uPsRmsmpaKPExCbP18OxKVldfw6PlA9l4VHrQF+Il/84PT/A=
X-Received: by 2002:a05:6e02:1a0b:b0:348:f9a8:19d4 with SMTP id
 s11-20020a056e021a0b00b00348f9a819d4mr88953ild.29.1692937651400; Thu, 24 Aug
 2023 21:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com> <1692606977-92009-6-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1692606977-92009-6-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 21:27:19 -0700
Message-ID: <CAP-5=fVfc1RQO_OnSFAU4rtKfSTiWpS5PghovFjuPxruty19LQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] perf test: Make matching_pmu effective
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 1:36=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> The perf_pmu_test_event.matching_pmu didn't work. No matter what its
> value is, it does not affect the test results. So let matching_pmu be
> used for matching perf_pmu_test_pmu.pmu.name.

Could you rebase this onto the latest perf-tools-next, I'd like to test thi=
s.

Thanks,
Ian

> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> ---
>  tools/perf/tests/pmu-events.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.=
c
> index 1dff863b..3204252 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -238,7 +238,7 @@ struct perf_pmu_test_pmu {
>         },
>         .alias_str =3D "event=3D0x2b",
>         .alias_long_desc =3D "ddr write-cycles event. Unit: uncore_sys_dd=
r_pmu ",
> -       .matching_pmu =3D "uncore_sys_ddr_pmu",
> +       .matching_pmu =3D "uncore_sys_ddr_pmu0",
>  };
>
>  static const struct perf_pmu_test_event sys_ccn_pmu_read_cycles =3D {
> @@ -252,7 +252,7 @@ struct perf_pmu_test_pmu {
>         },
>         .alias_str =3D "config=3D0x2c",
>         .alias_long_desc =3D "ccn read-cycles event. Unit: uncore_sys_ccn=
_pmu ",
> -       .matching_pmu =3D "uncore_sys_ccn_pmu",
> +       .matching_pmu =3D "uncore_sys_ccn_pmu4",
>  };
>
>  static const struct perf_pmu_test_event *sys_events[] =3D {
> @@ -599,6 +599,11 @@ static int __test_uncore_pmu_event_aliases(struct pe=
rf_pmu_test_pmu *test_pmu)
>                         struct pmu_event const *event =3D &test_event->ev=
ent;
>
>                         if (!strcmp(event->name, alias->name)) {
> +                               if (strcmp(pmu_name, test_event->matching=
_pmu)) {
> +                                       pr_debug("testing aliases uncore =
PMU %s: mismatched matching_pmu, %s vs %s\n",
> +                                                       pmu_name, test_ev=
ent->matching_pmu, pmu_name);
> +                                       continue;
> +                               }
>                                 if (compare_alias_to_test_event(alias,
>                                                         test_event,
>                                                         pmu_name)) {
> --
> 1.8.3.1
>
