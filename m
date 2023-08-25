Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3DB787F05
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 06:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbjHYEbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 00:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjHYEas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 00:30:48 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC09D1FEA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:30:46 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40c72caec5cso177851cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692937846; x=1693542646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSZ59QrUnMt9ZpOMYaZKJjZM9eqCCHfNbYbhSsFNDng=;
        b=CrKpvoaW0c8RK5pY0ZwM+tmQeHztQ/GJO+MXeaDG/LKtclB0181BTzuIHku9pXfSD7
         tvAJzP4rgeH7Tca8fvz6D81MWxH1WEExypeUMLva6kZvANlweCBKT80AFWtPNeRnB7oB
         bqq7mTrbuN7VmKABk4ZCCDKz6ImAJzfP/gNYkeXZ2GmO4H/7Rf9kcGyp+Zkg3mNEFtkk
         aNJBMyGH8lAuvA+mUI9YuIcFG9Jpxl+H/zfyOrxDKD6kjJODnFbdDd/QCxv84CQs0hZM
         u1Ug6LcQFJ6In+CViPTvF1rccmYAILCpxl3M9OXTC+3JTYCDuY3Et2J7WkEkitpwn1NZ
         ZnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692937846; x=1693542646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSZ59QrUnMt9ZpOMYaZKJjZM9eqCCHfNbYbhSsFNDng=;
        b=kMfjYCGkOa084aELCFHYma5/e+JRB5TMLe6q9CbgDd0ffq6/ouQWmq+NnA9vt4vm4a
         LWp/VPDRPh9lPY77sByPoFF34MMa8k0N9OhIvZBFdRHNfix4Y2wjmi/jo47S4S3Ev01L
         rW1KXG9Z8Qz8p14LlfVeCRaPjvjFj5NnR/PQKoEag6b+DSN0FWefn2UrCtWTl5U3GBsp
         E3roB9+Q7HqbT9PmLo4TBJDfqQav2aodBod/tLZkxCshVmByxB3fDH4pVmpJrX0NRU0S
         JRAb8L53Rl8b72KRtNmI6VZWPFpZpl/EkbAeLkQ118lM5X5Kigya4rqZn1bDb+Fy6mVO
         po0w==
X-Gm-Message-State: AOJu0YwaOK0QcSO+eBvN5MllHqIMGVKTEH5tYyVhQJlN6DQH3jirTVo5
        EQrGlT3wSippCd4y27HhTEn4DdvlV+vo+MTNIFlwSg==
X-Google-Smtp-Source: AGHT+IFmXhTxwOuSacGy8gyLRz9DLJSlM8rZRREOGmtai2bquNZD1j5qnG5Toiu7/aCmfokZONYI757MsHtsC9qFbmo=
X-Received: by 2002:a05:622a:1a0b:b0:410:653f:90e8 with SMTP id
 f11-20020a05622a1a0b00b00410653f90e8mr94849qtb.11.1692937845821; Thu, 24 Aug
 2023 21:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com> <1692606977-92009-7-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1692606977-92009-7-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 21:30:33 -0700
Message-ID: <CAP-5=fUBZS49rPvBE-14K9QeWZQgd-BUsOXRmTsLRqPYyVSU=A@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] perf test: Add pmu-event test for "Compat" and new event_field.
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
> Add new event test for uncore system event which is used to verify the
> functionality of "Compat" matching multiple identifiers and the new event
> fields "EventIdCode" and "Type".
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>

Thanks for the tests! I've no issue with them beside the already
mentioned ';'. This will need updating for:
https://lore.kernel.org/lkml/20230824183212.374787-1-irogers@google.com/
https://lore.kernel.org/lkml/20230825024002.801955-1-irogers@google.com/

Thanks,
Ian

> ---
>  .../pmu-events/arch/test/test_soc/sys/uncore.json  |  8 ++++
>  tools/perf/pmu-events/empty-pmu-events.c           |  8 ++++
>  tools/perf/tests/pmu-events.c                      | 55 ++++++++++++++++=
++++++
>  3 files changed, 71 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json b/t=
ools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> index c7e7528..06b886d 100644
> --- a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> +++ b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> @@ -12,5 +12,13 @@
>             "EventName": "sys_ccn_pmu.read_cycles",
>             "Unit": "sys_ccn_pmu",
>             "Compat": "0x01"
> +   },
> +   {
> +           "BriefDescription": "Counts total cache misses in first looku=
p result (high priority).",
> +           "NodeType": "0x05",
> +           "EventIdCode": "0x01",
> +           "EventName": "sys_cmn_pmu.hnf_cache_miss",
> +           "Unit": "sys_cmn_pmu",
> +           "Compat": "434*;436*;43c*;43a01"
>     }
>  ]
> diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-ev=
ents/empty-pmu-events.c
> index e74defb..25be18a 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c
> @@ -245,6 +245,14 @@ struct pmu_events_map {
>                 .pmu =3D "uncore_sys_ccn_pmu",
>         },
>         {
> +               .name =3D "sys_cmn_pmu.hnf_cache_miss",
> +               .event =3D "type=3D0x05,eventid=3D0x01",
> +               .desc =3D "Counts total cache misses in first lookup resu=
lt (high priority). Unit: uncore_sys_cmn_pmu ",
> +               .compat =3D "434*;436*;43c*;43a01",
> +               .topic =3D "uncore",
> +               .pmu =3D "uncore_sys_cmn_pmu",
> +       },
> +       {
>                 .name =3D 0,
>                 .event =3D 0,
>                 .desc =3D 0,
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.=
c
> index 3204252..79fb3e2 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -255,9 +255,24 @@ struct perf_pmu_test_pmu {
>         .matching_pmu =3D "uncore_sys_ccn_pmu4",
>  };
>
> +static const struct perf_pmu_test_event sys_cmn_pmu_hnf_cache_miss =3D {
> +       .event =3D {
> +               .name =3D "sys_cmn_pmu.hnf_cache_miss",
> +               .event =3D "type=3D0x05,eventid=3D0x01",
> +               .desc =3D "Counts total cache misses in first lookup resu=
lt (high priority). Unit: uncore_sys_cmn_pmu ",
> +               .topic =3D "uncore",
> +               .pmu =3D "uncore_sys_cmn_pmu",
> +               .compat =3D "434*;436*;43c*;43a01",
> +       },
> +       .alias_str =3D "type=3D0x5,eventid=3D0x1",
> +       .alias_long_desc =3D "Counts total cache misses in first lookup r=
esult (high priority). Unit: uncore_sys_cmn_pmu ",
> +       .matching_pmu =3D "uncore_sys_cmn_pmu0",
> +};
> +
>  static const struct perf_pmu_test_event *sys_events[] =3D {
>         &sys_ddr_pmu_write_cycles,
>         &sys_ccn_pmu_read_cycles,
> +       &sys_cmn_pmu_hnf_cache_miss,
>         NULL
>  };
>
> @@ -704,6 +719,46 @@ static int __test_uncore_pmu_event_aliases(struct pe=
rf_pmu_test_pmu *test_pmu)
>                         &sys_ccn_pmu_read_cycles,
>                 },
>         },
> +       {
> +               .pmu =3D {
> +                       .name =3D (char *)"uncore_sys_cmn_pmu0",
> +                       .is_uncore =3D 1,
> +                       .id =3D (char *)"43401",
> +               },
> +               .aliases =3D {
> +                       &sys_cmn_pmu_hnf_cache_miss,
> +               },
> +       },
> +       {
> +               .pmu =3D {
> +                       .name =3D (char *)"uncore_sys_cmn_pmu0",
> +                       .is_uncore =3D 1,
> +                       .id =3D (char *)"43602",
> +               },
> +               .aliases =3D {
> +                       &sys_cmn_pmu_hnf_cache_miss,
> +               },
> +       },
> +       {
> +               .pmu =3D {
> +                       .name =3D (char *)"uncore_sys_cmn_pmu0",
> +                       .is_uncore =3D 1,
> +                       .id =3D (char *)"43c03",
> +               },
> +               .aliases =3D {
> +                       &sys_cmn_pmu_hnf_cache_miss,
> +               },
> +       },
> +       {
> +               .pmu =3D {
> +                       .name =3D (char *)"uncore_sys_cmn_pmu0",
> +                       .is_uncore =3D 1,
> +                       .id =3D (char *)"43a01",
> +               },
> +               .aliases =3D {
> +                       &sys_cmn_pmu_hnf_cache_miss,
> +               },
> +       }
>  };
>
>  /* Test that aliases generated are as expected */
> --
> 1.8.3.1
>
