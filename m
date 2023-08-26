Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65390789408
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 08:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjHZG3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 02:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjHZG2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 02:28:36 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB171FC3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 23:28:32 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-407db3e9669so80261cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 23:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693031311; x=1693636111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taqpoRV8JLMPdsHv+xop7MTqrr2dW06cVtvOQz3+/2I=;
        b=oER2Sn7sBCTFBDAKZi8fD6NqfghSOKVdcpvZraQqtRnTkmJbh4sV8tqYWkkmwtw5BH
         fCBbmUje+j+Lb2EPPGceDAYcKJt1r92OcVrSaEUuUTVSPwH96KaQeYtijz56hm7RoBLm
         l5WqGLzqDH2GHbf5Li4O1/QGIam+mqwhl7N8c/vXsSens8G5766OqIzO8DxDHap4ARvn
         GHg/u9xK5gTo+U5HpeHd/5TWHKCI8LqkffvKV6lfo9gr92jb7WCS+PaZiXeFjpL7IEUG
         cZ6EK5EvfhKXfnFoMaQaW+hkQYZrdVftIsbGkhBdkxm6vzsTl18qUi12JJhVDkzhdLtY
         7dCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693031311; x=1693636111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taqpoRV8JLMPdsHv+xop7MTqrr2dW06cVtvOQz3+/2I=;
        b=Bvfr7mmmMSUwlwkLhhexggCfY7AWDvRUCLBSF213bFjDPEBRCSs4TUdpJztt+0noxb
         GY8N7ytt9eVF+7KSFY17+Ikpx3HeUJVA6eSvQx1YMtRjTk2xcPUvbkb+5hMjXjRW3jxy
         eKQSaY4sVq1uc7Ou9WREsF1S1cxeYxhsHaQks1gCn8AwMYLg6FJtYb6cAV6qtff6/YWs
         bUovoW7skawoz69nFrYeqgShkhPhj69ER0gYBv193zJsTcHaVJ+mpLV2370hyA9vjPLl
         CXfHUORwEUwHBuYJOBQeIysHspd4BUyOKCilfIpJS/XT5Pmuk/h1pxX8jk74pU7v+tgM
         fAIA==
X-Gm-Message-State: AOJu0YxypYk3NVpcpvEwCtQ2v2O9fxEw02ykBd5Bp4qD1WpRZV/1bcsM
        OpFwZZH6qhta5n+1GCvRicBV+s59yVL90gseuK3UKg==
X-Google-Smtp-Source: AGHT+IFCmz64SPqZDhPfBIwZBZCZp41/X3PZFdAPX1mr/zsjrxQf8PQRJiucXTiSiTSWkqmNMsChSrMSd3KJqdHZE+4=
X-Received: by 2002:a05:622a:34d:b0:410:385c:d1e0 with SMTP id
 r13-20020a05622a034d00b00410385cd1e0mr82153qtw.25.1693031311181; Fri, 25 Aug
 2023 23:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com> <20230824041330.266337-7-irogers@google.com>
 <ZOdiX4eJHFfFbQhi@kernel.org> <428afeb4-d5ca-8115-73fc-881119a1cd51@linux.ibm.com>
 <CAP-5=fVt1vxK0CJ=aYjZzs4mushbxAx8056uxVQZUfsLAKpVoQ@mail.gmail.com>
 <4f2438fc-2360-8833-3751-fe3bc8b11afb@linux.ibm.com> <ZOkVYoN17A8wwP3k@kernel.org>
 <CAP-5=fUqLXdu2=TPSASFBbZ+B1oTFbuFra38z5YwYHWpX-V=hw@mail.gmail.com> <ZOlXpJM/ognSPlcz@kernel.org>
In-Reply-To: <ZOlXpJM/ognSPlcz@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 25 Aug 2023 23:28:19 -0700
Message-ID: <CAP-5=fUshGTWjcVVBACGToDziK5s1kgpxpnraicwQGZAfzvabg@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 6:38=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Aug 25, 2023 at 03:56:54PM -0700, Ian Rogers escreveu:
> > On Fri, Aug 25, 2023 at 1:56=E2=80=AFPM Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:
> > > [root@kernelqe3 linux]# git bisect bad
> > > 2e255b4f9f41f137d9e3dc4fae3603a9c2c3dd28 is the first bad commit
> > > commit 2e255b4f9f41f137d9e3dc4fae3603a9c2c3dd28
> > > Author: Ian Rogers <irogers@google.com>
> > > Date:   Wed Aug 23 21:13:16 2023 -0700
> > >
> > >     perf jevents: Group events by PMU
> > >
> > >     Prior to this change a cpuid would map to a list of events where =
the PMU
> > >     would be encoded alongside the event information. This change bre=
aks
> > >     apart each group of events so that there is a group per PMU. A ne=
w table
> > >     is added with the PMU's name and the list of events, the original=
 table
> > >     now holding an array of these per PMU tables.
> > >
> > >     These changes are to make it easier to get per PMU information ab=
out
> > >     events, rather than the current approach of scanning all events. =
The
> > >     perf binary size with BPF skeletons on x86 is reduced by about 1%=
. The
> > >     unidentified PMU is now always expanded to "cpu".
> > >
> > >     Signed-off-by: Ian Rogers <irogers@google.com>
> > >     Cc: Adrian Hunter <adrian.hunter@intel.com>
> > >     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > >     Cc: Gaosheng Cui <cuigaosheng1@huawei.com>
> > >     Cc: Ingo Molnar <mingo@redhat.com>
> > >     Cc: James Clark <james.clark@arm.com>
> > >     Cc: Jing Zhang <renyu.zj@linux.alibaba.com>
> > >     Cc: Jiri Olsa <jolsa@kernel.org>
> > >     Cc: John Garry <john.g.garry@oracle.com>
> > >     Cc: Kajol Jain <kjain@linux.ibm.com>
> > >     Cc: Kan Liang <kan.liang@linux.intel.com>
> > >     Cc: Mark Rutland <mark.rutland@arm.com>
> > >     Cc: Namhyung Kim <namhyung@kernel.org>
> > >     Cc: Peter Zijlstra <peterz@infradead.org>
> > >     Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> > >     Cc: Rob Herring <robh@kernel.org>
> > >     Link: https://lore.kernel.org/r/20230824041330.266337-5-irogers@g=
oogle.com
> > >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> > >  tools/perf/pmu-events/jevents.py | 181 +++++++++++++++++++++++++++++=
----------
> > >  tools/perf/tests/pmu-events.c    |  30 ++++---
> > >  2 files changed, 154 insertions(+), 57 deletions(-)
> > > [root@kernelqe3 linux]#
> >
> > This change defaulted events without a specified PMU to being for the
> > PMU 'cpu', so that events in pmu-events.c were associated with a PMU
> > and we could find per-PMU information easily. The test events have no
> > PMU and so this has broken s390 where the the PMU should be "cpum_cf".
> > It has probably also broken x86 hybrid and arm where their default PMU
> > isn't cpu. I'll work on a fix, but the problem will be limited to the
> > test.
>
> Ok, please use tmp.perf-tools-next as the basis for your work, that is
> what I have right now.

Thanks. I repro-ed the PMU events failure on alderlake and the patch I sent=
:
https://lore.kernel.org/lkml/20230826062203.1058041-1-irogers@google.com/
addressed it. I didn't repro the sysfs issue and so it may be resolved
by this too, but it may be a different issue. There may also be more
issues specific to s390. I'm hopeful the patch fixes them but please
give it a go.

Thanks,
Ian

> - Arnaldo
