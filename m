Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4FE80781A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442785AbjLFSvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379299AbjLFSux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:50:53 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAC011F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:50:52 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bf1de91c6so302e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701888651; x=1702493451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiEVffTns7PIqQ/RAadvgn3sb/RobCrYF2AQlXdHHDA=;
        b=CQ1/DmfurmbzdEo7Xg/Y72BzCXhXjbnZuLRy9f/R5ZsmXwT3crBN9sMU93OTxkMgxK
         QXhAzJjvuj+Fmj4LYXx5lOviOoXpZ6cQhJ8CIsaKG+ZziLMcGYqzP4Niv6PQJ3ID1GFJ
         GiFS9sKXuj1pVp8PxKr+fJTjRHi/uxM3bGV55g6E6S07aX0RnXJAIUgyAiJTBb9ymNAB
         GMqkh2rxrJJqNNIxCSJThN+0iQgyTo7UCSL06AyZZVq6pUH/QvFqGny1bMzt+wHY+RcW
         GpGuOCe77BgGfMx9Wuzf0fZCUFNnU2aKg2cI32K+j4Ys8OQ3/3MunKVg+cfqW701r66U
         r3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888651; x=1702493451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiEVffTns7PIqQ/RAadvgn3sb/RobCrYF2AQlXdHHDA=;
        b=ATOWbgkFeRrk6MrBOjpUbRytweqH9/zV9moW2q7KtOeU2vqXvPmnwiY7pqeF/njxZL
         eO8C+qFBzTkufCIA5c5Ms0GiQAMhfjCIZ7vqsAv7P5JhAxlZa5GK+Gu3YflqCslFCEP3
         A02Y8MgONNn8GiTE7gerjBchSkHMkhPI+2LcZVnoY4iKpVNb7bKH+9bZoXMz/9jic05P
         MvzwEkog6vTCGnlKKcKZCGzihq558fad+NRxbjo0QARzf6wVzmsCkZgzAOwZgsQ+nMe5
         1k4M5ICVb0iVY1gtMzc94UrMsNBFf4fuZkXxcEcytBySg9YL8ua9A3P5l5XN6E1B3Pv2
         Pg5Q==
X-Gm-Message-State: AOJu0Yyxg5muvbi+8d6NKOS1k4iLPKzT8Du4xw+6PwK11B5iSqDgpc+M
        yq0GFn75+EYCvSf3FDUL+HJOWrAjc/HWN6/n2xVJHQ==
X-Google-Smtp-Source: AGHT+IF1NKwWhmuZPkZcFo+RgjaoJj8x930q4YdMfIeeSSthD+3IZUr3jkeZx0WAFgBi7l4yz1zEFi145oH2+YCDCv0=
X-Received: by 2002:a05:6512:3452:b0:50b:f51a:2999 with SMTP id
 j18-20020a056512345200b0050bf51a2999mr74435lfr.4.1701888650850; Wed, 06 Dec
 2023 10:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20230614090710.680330-1-sandipan.das@amd.com> <1320e6e3-c029-2a8c-e8b7-2cfbb781518a@amd.com>
 <ZXByT1K6enTh2EHT@kernel.org> <CAP-5=fUoD=s9yyVPgV7tqGwZsJVQMSmHKd8MV_vJW438AcK9qQ@mail.gmail.com>
 <ZXC1U8y4JAUaQ6lm@kernel.org>
In-Reply-To: <ZXC1U8y4JAUaQ6lm@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Dec 2023 10:50:39 -0800
Message-ID: <CAP-5=fW_2iWEyOKao8MpMZWu7AQNX6-UKN1nEhr=mMxk0fUJKg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Retry without grouping for all metrics test
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ayush Jain <ayush.jain3@amd.com>,
        Sandipan Das <sandipan.das@amd.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, Ingo Molnar <mingo@kernel.org>,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, barnali@linux.ibm.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
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

On Wed, Dec 6, 2023 at 9:54=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Wed, Dec 06, 2023 at 08:35:23AM -0800, Ian Rogers escreveu:
> > On Wed, Dec 6, 2023 at 5:08=E2=80=AFAM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > > Humm, I'm not being able to reproduce here the problem, before applyi=
ng
> > > this patch:
>
> > Please don't apply the patch. The patch masks a bug in metrics/PMUs
>
> I didn't
>
> > and the proper fix was:
> > 8d40f74ebf21 perf vendor events amd: Fix large metrics
> > https://lore.kernel.org/r/20230706063440.54189-1-sandipan.das@amd.com
>
> that is upstream:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git log tools/perf/pmu-events/ar=
ch/x86/amdzen1/recommended.json
> commit 8d40f74ebf217d3b9e9b7481721e6236b857cc55
> Author: Sandipan Das <sandipan.das@amd.com>
> Date:   Thu Jul 6 12:04:40 2023 +0530
>
>     perf vendor events amd: Fix large metrics
>
>     There are cases where a metric requires more events than the number o=
f
>     available counters. E.g. AMD Zen, Zen 2 and Zen 3 processors have fou=
r
>     data fabric counters but the "nps1_die_to_dram" metric has eight even=
ts.
>
>     By default, the constituent events are placed in a group and since th=
e
>     events cannot be scheduled at the same time, the metric is not comput=
ed.
>     The "all metrics" test also fails because of this.
>
>     Use the NO_GROUP_EVENTS constraint for such metrics which anyway expe=
ct
>     the user to run perf with "--metric-no-group".
>
>     E.g.
>
>       $ sudo perf test -v 101
>
>     Before:
>
>       101: perf all metrics test                                         =
  :
>       --- start ---
>       test child forked, pid 37131
>       Testing branch_misprediction_ratio
>       Testing all_remote_links_outbound
>       Testing nps1_die_to_dram
>       Metric 'nps1_die_to_dram' not printed in:
>       Error:
>       Invalid event (dram_channel_data_controller_4) in per-thread mode, =
enable system wide with '-a'.
>       Testing macro_ops_dispatched
>       Testing all_l2_cache_accesses
>       Testing all_l2_cache_hits
>       Testing all_l2_cache_misses
>       Testing ic_fetch_miss_ratio
>       Testing l2_cache_accesses_from_l2_hwpf
>       Testing l2_cache_misses_from_l2_hwpf
>       Testing op_cache_fetch_miss_ratio
>       Testing l3_read_miss_latency
>       Testing l1_itlb_misses
>       test child finished with -1
>       ---- end ----
>       perf all metrics test: FAILED!
>
>     After:
>
>       101: perf all metrics test                                         =
  :
>       --- start ---
>       test child forked, pid 43766
>       Testing branch_misprediction_ratio
>       Testing all_remote_links_outbound
>       Testing nps1_die_to_dram
>       Testing macro_ops_dispatched
>       Testing all_l2_cache_accesses
>       Testing all_l2_cache_hits
>       Testing all_l2_cache_misses
>       Testing ic_fetch_miss_ratio
>       Testing l2_cache_accesses_from_l2_hwpf
>       Testing l2_cache_misses_from_l2_hwpf
>       Testing op_cache_fetch_miss_ratio
>       Testing l3_read_miss_latency
>       Testing l1_itlb_misses
>       test child finished with 0
>       ---- end ----
>       perf all metrics test: Ok
>
>     Reported-by: Ayush Jain <ayush.jain3@amd.com>
>     Suggested-by: Ian Rogers <irogers@google.com>
>     Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>     Acked-by: Ian Rogers <irogers@google.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Ananth Narayan <ananth.narayan@amd.com>
>     Cc: Ingo Molnar <mingo@redhat.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Ravi Bangoria <ravi.bangoria@amd.com>
>     Cc: Santosh Shukla <santosh.shukla@amd.com>
>     Link: https://lore.kernel.org/r/20230706063440.54189-1-sandipan.das@a=
md.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com
>
> > > Ian, I also stumbled on this:
>
> > > [root@five ~]# perf stat -M dram_channel_data_controller_4
> > > Cannot find metric or group `dram_channel_data_controller_4'
> > > ^C
> > >  Performance counter stats for 'system wide':
>
> > >         284,908.91 msec cpu-clock                        #   32.002 C=
PUs utilized
> > >          6,485,456      context-switches                 #   22.763 K=
/sec
> > >                719      cpu-migrations                   #    2.524 /=
sec
> > >             32,800      page-faults                      #  115.125 /=
sec
>
> <SNIP>
>
> > > I.e. -M should bail out at that point (Cannot find metric or group `d=
ram_channel_data_controller_4'), no?
>
> > We could. I suspect the code has always just not bailed out. I'll put
> > together a patch adding the bail out.
>
> Great, thanks,

Sent:
https://lore.kernel.org/lkml/20231206183533.972028-1-irogers@google.com/

Thanks,
Ian

> - Arnaldo
