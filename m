Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1CA7AF218
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjIZSDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjIZSDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:03:09 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF3911F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:03:01 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-414ba610766so48441cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695751381; x=1696356181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fG3vIfPo5yol0BVmzq+e6p47Tw2I82MeM0wmrspuJLQ=;
        b=um0JECdhF1tycyiS8AeSMCzcHggcYXCl9Rk+bF6xkrCZCCCWaCwqrHNPcPD3pPcFtp
         p7nUyCI/a/ia3ONcHi1BeiP/mKMSNZbdfmRddXHwOHnJvIx4Z5kBVF7jEMhFbpk00m59
         E+ytKmAffpGvkD2p4fPiO3dxbxkd0GplfH11WSGEj7sX3MpV4oT3MrdMhGjPuzE+sLTH
         o3eU6zx3B3Z8k+m0pjFCOR3/XeJVe7VJK1Qe3y4GYsE5r7pfExsv4qUSxPO1laZYNoZW
         gf5l2dDhq0tRUUvVPatUTthym0PDd6NHYwPOKELxT0opKa7PFXeC5XKI5/u2taWY5inF
         Iz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751381; x=1696356181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fG3vIfPo5yol0BVmzq+e6p47Tw2I82MeM0wmrspuJLQ=;
        b=IZIgtqKMw0e0gH+oAjGP1nlTPksmDsohFLy6vm/o4lGyt/nOGlmv3pIYGVjSPUmTqM
         IS92+Hbn64AV9oZynLKJqQ+1rVhvojdKx8PXw7RrbvFytjlSqLPCuCYBd3lINVdYCd2c
         vuIEyNmgAStWtEiKYWsWeS25Q/PcfEK+cPpa0R/Ku1wPj1QTTsEw08la5liIz6nFfKlK
         bPbUiTG1LqULGisCw3mvWxInIABVpV3O6ruSWo302pIG61kI5eDW7oUltWqziNP5zjCc
         kHWu+66/mfPtQ7Rjr1YBVh9hKa/f/S2h/K1uE+dXKX6jMCt16GflsMmcq87oJOayIhEr
         daJw==
X-Gm-Message-State: AOJu0YyzHcsfW7rsD2yQ0tU7O73EAO2VoxUvl/qeeTwAUYf1wX+vpFNS
        Z0Nr3/H2t0yUaU3HVkDRRyjlcwC0Dmd8QbXdbN/1MQ==
X-Google-Smtp-Source: AGHT+IGbzKHyIqDxIB8t2yyWwteM+BcXKq4YWgWnj5Ouj1SVxWO4HfwutwHdlSluuw25Lv08nSyys87kBbVOm6ArGbQ=
X-Received: by 2002:ac8:7e8d:0:b0:403:b1d0:2f0a with SMTP id
 w13-20020ac87e8d000000b00403b1d02f0amr420630qtj.28.1695751380840; Tue, 26 Sep
 2023 11:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230926031034.1201145-1-irogers@google.com> <f4b23e81-9a49-a3ba-d666-4b8f90e9720c@linux.intel.com>
In-Reply-To: <f4b23e81-9a49-a3ba-d666-4b8f90e9720c@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 26 Sep 2023 11:02:49 -0700
Message-ID: <CAP-5=fWx1EJjt8K=vKC=xyVWO+VXX=Cnb+6YOjExQaFVG4pL=A@mail.gmail.com>
Subject: Re: [PATCH v1] perf vendor events intel: Fix broadwellde
 tma_info_system_dram_bw_use metric
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 26, 2023 at 7:02=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-09-25 11:10 p.m., Ian Rogers wrote:
> > Broadwell-de has a consumer core and server uncore.
>
> Besides this one, compared with the bdx-metrics.json, there is one
> uncore metrics missed in the bdwde-metrics.json, uncore_frequency.

You're right and I knew it related to this:
https://github.com/intel/perfmon/blob/cddf6ebe4cc23b71a5d8bf7fa007b3e2cb706=
c2e/scripts/create_perf_json.py#L760
On Tigerlake UNC_CLOCK.SOCKET works fine so maybe the exclusion was an erro=
r:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json?h=3Dperf-tool=
s-next
On BDW-DE if I do the same trick as UNC_ARB and use the BDX resolution
then that works too. So I'll fix that and send out a v2.

Thanks,
Ian

> > The uncore_arb PMU
> > isn't present and the broadwellx style cbox PMU should be used
> > instead. Fix the tma_info_system_dram_bw_use metric to use the server
> > metric rather than client.>
> > The associated converter script fix is in:
> > https://github.com/intel/perfmon/pull/111
> >
> > Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell varian=
t events/metrics")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
> Thanks,
> Kan
> > ---
> >  tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.j=
son b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > index 8fc62b8f667d..d0ef46c9bb61 100644
> > --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > @@ -652,7 +652,7 @@
> >      },
> >      {
> >          "BriefDescription": "Average external Memory Bandwidth Use for=
 reads and writes [GB / sec]",
> > -        "MetricExpr": "64 * (arb@event\\=3D0x81\\,umask\\=3D0x1@ + arb=
@event\\=3D0x84\\,umask\\=3D0x1@) / 1e6 / duration_time / 1e3",
> > +        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) =
/ 1e9 / duration_time",
> >          "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
> >          "MetricName": "tma_info_system_dram_bw_use",
> >          "PublicDescription": "Average external Memory Bandwidth Use fo=
r reads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwi=
dth, tma_sq_full"
