Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5667789221
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjHYW5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjHYW5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:57:11 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CE3199F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:57:07 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-407db3e9669so50961cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693004227; x=1693609027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pdeCQUIG8CuDNg2gW6Ye4By7O7gngEFxDImQvTFpk4=;
        b=tpQqLfJWO47GVsZCEnOIZ+PPnMV6Jct19IwgBoslcyqj22m0gO3VOM3vIyjbVgz+C/
         g/zoUS9Aopvlq3JlX4Id2fu/QFX8sUYzh7Su2PTOaqHwPAbTa6dpe9bvvAmsR8ELHJSl
         LMmjQKKnX7k+dX3mCXD9sXz9rB9BrJA98vq1WS2B2mLCnshfHgLgOh7OlFUODowCndrm
         +1DlcOPBbtA/ZsNFRSy0xaMkZaWa1A02PrXfBjqnyfvDk67d17tDpJzXuOEGfqi09QRv
         D79ZzVsUHL0a+rSyx2umA7yVA80QbuDEJvFukmK8YH0FLYQ0H91cvkHpNc8xW1WGS7za
         Ym4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693004227; x=1693609027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pdeCQUIG8CuDNg2gW6Ye4By7O7gngEFxDImQvTFpk4=;
        b=kWP+eMymY1IBDOXtHUsBsrMTILxyG6gU+QaEmciq2HQ3yemzOO418u+g5RBoycZNRr
         1i7fTEx4ofn7vaysikwYZ9ovZ0AZissOeVwxnqCCFeJJSMOw5IVaCXiYI0DqByD1vf8i
         iIeBTmX6Bh/Rb+zKTKdEzn881+CxMWuRPK6vYskjt8jfn9byfT4tIm2/IzWLOfDxO7xe
         vD7NMPRQo5QS9yw0A80Ue3g4OStQo22DpnPGKKnRuqqVVeRBuwPghXWgU+PB/I49J6B+
         acyhtGgIYU61UmyCS45V8EFrgWhG7+LUrOrDcoup1OwLDREW0ye5caSlKZc546LCnz9I
         q8xw==
X-Gm-Message-State: AOJu0Yx8zYk8hoiEHOxkC/T2SXxWdwYHUUuWPxRJXV/p4fRe7cdYgDgI
        xHnymZS1Dd3ig6uglH7MLNDXKJjCpMrT5TsN35hHfgRl1sdZAR4jkw+WlA==
X-Google-Smtp-Source: AGHT+IFMbBaIbZ8vbaB75MQbqoDbu8E0C8Ec9zxuz4BxU7lU/J8XNgaVO6lCaRx+XzQQq4FCHx/7KEsGkwJtpvlsV8E=
X-Received: by 2002:ac8:5f89:0:b0:405:47aa:7ffd with SMTP id
 j9-20020ac85f89000000b0040547aa7ffdmr38495qta.19.1693004226468; Fri, 25 Aug
 2023 15:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com> <20230824041330.266337-7-irogers@google.com>
 <ZOdiX4eJHFfFbQhi@kernel.org> <428afeb4-d5ca-8115-73fc-881119a1cd51@linux.ibm.com>
 <CAP-5=fVt1vxK0CJ=aYjZzs4mushbxAx8056uxVQZUfsLAKpVoQ@mail.gmail.com>
 <4f2438fc-2360-8833-3751-fe3bc8b11afb@linux.ibm.com> <ZOkVYoN17A8wwP3k@kernel.org>
In-Reply-To: <ZOkVYoN17A8wwP3k@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 25 Aug 2023 15:56:54 -0700
Message-ID: <CAP-5=fUqLXdu2=TPSASFBbZ+B1oTFbuFra38z5YwYHWpX-V=hw@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] perf s390 s390_cpumcfdg_dump: Don't scan all PMUs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 1:56=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Aug 25, 2023 at 04:39:22PM +0200, Thomas Richter escreveu:
> > On 8/25/23 15:14, Ian Rogers wrote:
> > > On Fri, Aug 25, 2023 at 1:20=E2=80=AFAM Thomas Richter <tmricht@linux=
.ibm.com> wrote:
>
> > >> On 8/24/23 15:59, Arnaldo Carvalho de Melo wrote:
> > >>> Em Wed, Aug 23, 2023 at 09:13:18PM -0700, Ian Rogers escreveu:
> > >>>> Rather than scanning all PMUs for a counter name, scan the PMU
> > >>>> associated with the evsel of the sample. This is done to remove a
> > >>>> dependence on pmu-events.h.
>
> > >>> I'm applying this one, and CCing the S/390 developers so that they =
can
> > >>> try this and maybe provide an Acked-by/Tested-by,
>
> > >> I have downloaded this patch set of 18 patches (using b4), but they =
do not
> > >> apply on my git tree.
>
> > >> Which git branch do I have to use to test this. Thanks a lot.
>
> > > the changes are in the perf-tools-next tree:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/
>
> > Unfurtunately this patch set fails again on s390.
> > Here is the test output from the current 6.5.0rc7 kernel:
> >
> > # ./perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
> >   6: Parse event definition strings                                  :
> >   6.1: Test event parsing                                            : =
Ok
> >   6.2: Parsing of all PMU events from sysfs                          : =
Ok
> >   6.3: Parsing of given PMU events from sysfs                        : =
Ok
> >   6.4: Parsing of aliased events from sysfs                          : =
Skip (no aliases in sysfs)
> >   6.5: Parsing of aliased events                                     : =
Ok
> >   6.6: Parsing of terms (event modifiers)                            : =
Ok
> >  10: PMU events                                                      :
> >  10.1: PMU event table sanity                                        : =
Ok
> >  10.2: PMU event map aliases                                         : =
Ok
> >  10.3: Parsing of PMU event table metrics                            : =
Ok
> >  10.4: Parsing of PMU event table metrics with fake PMUs             : =
Ok
> >  10.5: Parsing of metric thresholds with fake PMUs                   : =
Ok
> >  95: perf all metricgroups test                                      : =
Ok
> >  96: perf all metrics test                                           : =
Ok
> > #
> >
> > This looks good.
>
> Reproduced:
>
> # grep -E vendor_id\|^processor -m2 /proc/cpuinfo
> vendor_id       : IBM/S390
> processor 0: version =3D 00,  identification =3D 1A33E8,  machine =3D 296=
4
> #
> # perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
>   6: Parse event definition strings                                  :
>   6.1: Test event parsing                                            : Ok
>   6.2: Parsing of all PMU events from sysfs                          : Ok
>   6.3: Parsing of given PMU events from sysfs                        : Ok
>   6.4: Parsing of aliased events from sysfs                          : Sk=
ip (no aliases in sysfs)
>   6.5: Parsing of aliased events                                     : Ok
>   6.6: Parsing of terms (event modifiers)                            : Ok
>  10: PMU events                                                      :
>  10.1: PMU event table sanity                                        : Ok
>  10.2: PMU event map aliases                                         : Ok
>  10.3: Parsing of PMU event table metrics                            : Ok
>  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
>  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
>  95: perf all metricgroups test                                      : Ok
>  96: perf all metrics test                                           : Ok
> # perf -v
> perf version 6.5.rc7.g6f0edbb833ec
> #
>
> > However when I use the check-out from perf-tools-next, I get this outpu=
t:
> > # ./perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
> >   6: Parse event definition strings                                  :
> >   6.1: Test event parsing                                            : =
Ok
> >   6.2: Parsing of all PMU events from sysfs                          : =
FAILED!
> >   6.3: Parsing of given PMU events from sysfs                        : =
Ok
> >   6.4: Parsing of aliased events from sysfs                          : =
Skip (no aliases in sysfs)
> >   6.5: Parsing of aliased events                                     : =
FAILED!
> >   6.6: Parsing of terms (event modifiers)                            : =
Ok
> >  10: PMU events                                                      :
> >  10.1: PMU event table sanity                                        : =
Ok
> >  10.2: PMU event map aliases                                         : =
FAILED!
> >  10.3: Parsing of PMU event table metrics                            : =
Ok
> >  10.4: Parsing of PMU event table metrics with fake PMUs             : =
FAILED!
> >  10.5: Parsing of metric thresholds with fake PMUs                   : =
Ok
> >  93: perf all metricgroups test                                      : =
FAILED!
> >  94: perf all metrics test                                           : =
FAILED!
> > #
> >
> > So some tests are failing again.
> >
> > I am out for the next two weeks, Sumanth Korikkar (on to list) might be=
 able to help.
> > Thanks a lot.
>
> [root@kernelqe3 linux]# git checkout perf-tools-next
> git Switched to branch 'perf-tools-next'
> Your branch is up to date with 'perf-tools-next/perf-tools-next'.
> [root@kernelqe3 linux]# git log --oneline -5
> eeb6b12992c4 (HEAD -> perf-tools-next, perf-tools-next/perf-tools-next) p=
erf jevents: Don't append Unit to desc
> f208b2c6f984 (perf-tools-next/tmp.perf-tools-next) perf scripts python ge=
cko: Launch the profiler UI on the default browser with the appropriate URL
> 43803cb16f99 perf scripts python: Add support for input args in gecko scr=
ipt
> f85d120c46e7 perf jevents: Sort strings in the big C string to reduce fau=
lts
> 8d4b6d37ea78 perf pmu: Lazily load sysfs aliases
> [root@kernelqe3 linux]# make BUILD_BPF_SKEL=3D1 -C tools/perf O=3D/tmp/bu=
ild/perf install-bin
>
> [root@kernelqe3 linux]# perf -v
> perf version 6.5.rc5.geeb6b12992c4
> [root@kernelqe3 linux]# git log --oneline -1
> eeb6b12992c4 (HEAD -> perf-tools-next, perf-tools-next/perf-tools-next) p=
erf jevents: Don't append Unit to desc
> [root@kernelqe3 linux]# perf test 6 10 'perf all metricgroups test' 'perf=
 all metrics test'
>   6: Parse event definition strings                                  :
>   6.1: Test event parsing                                            : Ok
>   6.2: Parsing of all PMU events from sysfs                          : FA=
ILED!
>   6.3: Parsing of given PMU events from sysfs                        : Ok
>   6.4: Parsing of aliased events from sysfs                          : Sk=
ip (no aliases in sysfs)
>   6.5: Parsing of aliased events                                     : FA=
ILED!
>   6.6: Parsing of terms (event modifiers)                            : Ok
>  10: PMU events                                                      :
>  10.1: PMU event table sanity                                        : Ok
>  10.2: PMU event map aliases                                         : FA=
ILED!
>  10.3: Parsing of PMU event table metrics                            : Ok
>  10.4: Parsing of PMU event table metrics with fake PMUs             : FA=
ILED!
>  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
>  93: perf all metricgroups test                                      : FA=
ILED!
>  94: perf all metrics test                                           : FA=
ILED!
> [root@kernelqe3 linux]#
>
> Bisecting the first problem:
>
>  10.2: PMU event map aliases                                         : FA=
ILED!
>
> make: Leaving directory '/root/git/linux/tools/perf'
>   6: Parse event definition strings                                  :
>   6.1: Test event parsing                                            : Ok
>   6.2: Parsing of all PMU events from sysfs                          : Ok
>   6.3: Parsing of given PMU events from sysfs                        : Ok
>   6.4: Parsing of aliased events from sysfs                          : Sk=
ip (no aliases in sysfs)
>   6.5: Parsing of aliased events                                     : Ok
>   6.6: Parsing of terms (event modifiers)                            : Ok
>  10: PMU events                                                      :
>  10.1: PMU event table sanity                                        : Ok
>  10.2: PMU event map aliases                                         : FA=
ILED!
>  10.3: Parsing of PMU event table metrics                            : Ok
>  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
>  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
>  93: perf all metricgroups test                                      : Ok
>  94: perf all metrics test                                           : Ok
> [root@kernelqe3 linux]# git bisect bad
> 2e255b4f9f41f137d9e3dc4fae3603a9c2c3dd28 is the first bad commit
> commit 2e255b4f9f41f137d9e3dc4fae3603a9c2c3dd28
> Author: Ian Rogers <irogers@google.com>
> Date:   Wed Aug 23 21:13:16 2023 -0700
>
>     perf jevents: Group events by PMU
>
>     Prior to this change a cpuid would map to a list of events where the =
PMU
>     would be encoded alongside the event information. This change breaks
>     apart each group of events so that there is a group per PMU. A new ta=
ble
>     is added with the PMU's name and the list of events, the original tab=
le
>     now holding an array of these per PMU tables.
>
>     These changes are to make it easier to get per PMU information about
>     events, rather than the current approach of scanning all events. The
>     perf binary size with BPF skeletons on x86 is reduced by about 1%. Th=
e
>     unidentified PMU is now always expanded to "cpu".
>
>     Signed-off-by: Ian Rogers <irogers@google.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Gaosheng Cui <cuigaosheng1@huawei.com>
>     Cc: Ingo Molnar <mingo@redhat.com>
>     Cc: James Clark <james.clark@arm.com>
>     Cc: Jing Zhang <renyu.zj@linux.alibaba.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: John Garry <john.g.garry@oracle.com>
>     Cc: Kajol Jain <kjain@linux.ibm.com>
>     Cc: Kan Liang <kan.liang@linux.intel.com>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Ravi Bangoria <ravi.bangoria@amd.com>
>     Cc: Rob Herring <robh@kernel.org>
>     Link: https://lore.kernel.org/r/20230824041330.266337-5-irogers@googl=
e.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
>  tools/perf/pmu-events/jevents.py | 181 +++++++++++++++++++++++++++++----=
------
>  tools/perf/tests/pmu-events.c    |  30 ++++---
>  2 files changed, 154 insertions(+), 57 deletions(-)
> [root@kernelqe3 linux]#
>

This change defaulted events without a specified PMU to being for the
PMU 'cpu', so that events in pmu-events.c were associated with a PMU
and we could find per-PMU information easily. The test events have no
PMU and so this has broken s390 where the the PMU should be "cpum_cf".
It has probably also broken x86 hybrid and arm where their default PMU
isn't cpu. I'll work on a fix, but the problem will be limited to the
test.

Thanks,
Ian
