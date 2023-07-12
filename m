Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD0D751005
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjGLRws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjGLRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:52:44 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987C81FDE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:52:43 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-403b622101bso24471cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689184363; x=1691776363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM9bdOrQaPaBEpJgo9Tqz6y2K8+tG7zdCt8BktRJpJo=;
        b=hVhHcKmDYYcq31tgzpNRob1VHBPNpT1S6Ss6aaAdNzk12rMfcRRvMj/BCUIH4cKEfR
         utRpq9C8WQ5N6mnRRkTlefEEaahp7ZTQbVN9XnCwBtw38qxJTuRLNgipu4ebiANTwC5b
         0ICzVyS/naI0l5gpgwEbAbS8m3YFlaAtTiH6znnFWQZOKEWvBVfpEOgLUfuA45YPqzq5
         YkRtKz+ND6g0vjvW0ImkjQJTXH//5/EsrGq2ySvI49kJM4uqHK0hU43x0qRLX8Wxv83s
         M0B9Ks7jAbMgV3HI6voGQjZwBioDmtToB44QbRW8DVOkV7IrbvGyja3ianMJd6MApBxN
         ml+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689184363; x=1691776363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jM9bdOrQaPaBEpJgo9Tqz6y2K8+tG7zdCt8BktRJpJo=;
        b=DXHMuzh3LCet9CFEKqmNbi5OWoI1OdggYv42vgrZHhli8i4BL1M93rTj1G9Mi/TARh
         PwjaXGtZz+UG+hOd67Hxa+mznfWD0SCOVNm7tlY5dqfbJyNRM98Ac99Hv8QE78kaWRVq
         TzwJv2lOrTFauq8uEpL9ahbb1M3mWarJDGeHDmQ5VLTSqiYj85Y8Pw+UK14EfzuZ8Cnl
         DRsnh9Dn7ljhZ4qB+Vq6gVWdC0LvQrzWopg7Psz9gci5spYX+RfOUpRR8PzNDTF3OCtU
         bzwXa/FdEtyWnVlmhTR0klc9QfQnoslHLh8cgkARbz2xLhJvw6Bz7tXzoygOoKtRezAw
         DfGA==
X-Gm-Message-State: ABy/qLZBDFhPzncrjXsbfZ1DwWssEOTIKo7AmxHSftxoQ1Rv89b337yw
        zR3vAVQoa8GBUBE+g4fpvNZUaxx9vaep6oryNNKQlw==
X-Google-Smtp-Source: APBJJlHaYXEfRmzu+bv8B6OWFOU1nFEd32JbQY9BYrwEvxiAqRK40ckZP5eOSp3wk6r3t+v7uLcBs+vuiLRlcg0Akbg=
X-Received: by 2002:ac8:5981:0:b0:403:aa88:cf7e with SMTP id
 e1-20020ac85981000000b00403aa88cf7emr260453qte.29.1689184362598; Wed, 12 Jul
 2023 10:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-5-john.g.garry@oracle.com> <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
 <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com>
 <d59b6e7c-cead-24d4-a9cb-6552b3154d84@oracle.com> <CAP-5=fUu6xgVDQT4tq=vmRLDMe3ddMLywP11uOLvKSu8Lc6BjQ@mail.gmail.com>
 <897dcf1d-6a04-33d3-9c4f-ea9d1706cdad@oracle.com>
In-Reply-To: <897dcf1d-6a04-33d3-9c4f-ea9d1706cdad@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 10:52:31 -0700
Message-ID: <CAP-5=fX+rz928LtFs2MWYUH=6Mcvz0XQcLRkO-n9BnVnX4RYWw@mail.gmail.com>
Subject: Re: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 3:55=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
>
> >>>> MetricExpr: "cpu_core@instructions@ / cpu_core@cycles@",
> >> I did not know that it was possible to state that an event is for a
> >> specific PMU type in this fashion - is this feature new? Does it work
> >> only for known terms, like cycles and instructions?
> > It has been in metrics a long time (I didn't choose that @ was the /
> > replacement =F0=9F=98=84 ). It should work for all events.
> >
>
> Good to know.
>
> >>>> The @ is used to avoid parsing confusion with / meaning divide. The
> >>>> PMUs for the events are explicitly listed here. We could say the PMU
> >>>> is implied but then it gets complex for uncore events, for metrics
> >>>> that mix core and uncore events.
> >> So this works ok for IPC and CPU PMUs as we want the same event for ma=
ny
> >> PMU types and naturally it would have the same name.
> >>
> >> I am still not sure that sys event metrics need to specify a PMU.
> > There was a similar thought for hybrid metrics. The PMU could be
> > implied from the PMU of the metric. I think there can be confusion
> > from an implied PMU, for example the cycles event without a PMU will
> > open two events on a hybrid CPU. If we imply the PMU then it can mean
> > just 1 PMU, but if the PMU doesn't have the event presumably it means
> > the multiple PMU behavior.
> >
> > In parse-events there is existing logic to wildcard events but to
> > ignore those that don't match a given PMU. This is used to support the
> > --cputype option in builtin-stat.c, there is a similar option for
> > builtin-list.c. We can use this so that events in a metric only match
> > the PMU of the metric. Currently there are core metrics but whose
> > events are all uncore like:
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel=
/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/x86/alderlake=
/adl-metrics.json?h=3Dperf-tools-next*n1802__;Iw!!ACWV5N9M2RV99hQ!MjhanGd4A=
VsAl6d8weFktNHgeOptrgeBDyooXlpeW-J1TQ0e2BwzvqO4BTFEjs_gRzuWTPfnhW_jLx1pIJc$
> >
> > So we'd need to move these metrics to be on the appropriate uncore
> > PMU. Supporting >1 PMU
>
> To be crystal clear, when you say ">1 PMU", do you mean ">1 PMU instance
> of the same type" or ">1 PMU type"?

So I'm meaning that if you have a MetricExpr where the events are from
>1 PMU, for example memory bandwidth coming from uncore PMUs and then
instructions from a core PMU, and you do something like a ratio
between these two.

>   in a metric wouldn't work though as it would
> > appear the event was missing. Having the metric specify the PMU avoids
> > these problems, but is verbose.
>
> The message I'm getting - correct me if I am wrong - is that you would
> still prefer the PMU specified per event in metric expr, right? We don't
> do that exactly for sys PMU metrics today - we specify "Unit" instead, li=
ke:
>
> MetricExpr: "sys_pmu_bar_event_foo1 + sys_pmu_bar_event_foo2"
> Compat: "baz"
> Unit:"sys_pmu_bar"
>
> And so you prefer something like the following, right?
> MetricExpr: "sys_pmu_foo@bar1@ + sys_pmu_foo@bar2@"
>
> If so, I think that is ok - I just want to get rid of Unit and Compat.

I think we're agreeing :-) I think Unit may be useful, say on Intel
hybrid I want the tma_fround_bound metric on just cpu_atom. Currently
the use of Unit is messy for metrics, ie uncore metrics are associated
with core PMUs, and what to do with a MetricExpr with >1 PMU. I think
we're learning from trying. I'm just hoping the migration to a sysfs
style layout will still be possible, as I can see lots of upside in
terms of testing, 1 approach, etc.

Thanks,
Ian

> Thanks,
> John
