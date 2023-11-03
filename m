Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88947E05BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbjKCPtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjKCPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:49:13 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2EBD42
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:49:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50931d0bb04so4511e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699026548; x=1699631348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=392tRVZxGtLzEQKNmN3YbTUmZB8ld747UCZRAgobKm8=;
        b=UZKx1CqInR3ZeR64N91T0FSZEPRZo1d1rEecXwYALVpexcC2FJwf91mbbc63ZOfcEY
         8X7OlfWW72Ux4QbdmuthKz7KYFyW/zKhWwbnOt6sZhpW7R3XoxPpE5jQuL/CYOzjLArx
         ColqZoYu3wXV1VN00nzqihQKVnVLWuy4jkSgXiRK2kSiO0do/6/OXb2PtuKPkijEnR2w
         H+d7ZTK8S2QQ8mPKIurYbjJHX2/YsasFcxl9BVuqQc4Y8ex+tARiBU1bEXsCvGW8b6jy
         +4l4yywj+D8+o8NO1qbUabZ9hXaydgqwBaSGrhQVaKsZtITueVoF2rwfwkR2Qs3NohX8
         8yUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699026548; x=1699631348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=392tRVZxGtLzEQKNmN3YbTUmZB8ld747UCZRAgobKm8=;
        b=OAX2JnP4C5saxGEIQd967z5utdejCUYDScDlZvnfXlqQahthRA3wkrB+Yp7Rnkv+9D
         FysiOxHMyTK3YrNgwp1FdMMA0LwFVvl/zIbMpg9UFITcnUq7cNtFP2zr3iiYpKQnne7n
         SGJ6lSOZIl17I380wwEjvbCPzIyV5A0IOaA38M3TjZsM/WW2cYa7SFBUVwK0yag5JjeA
         tbJ9no1tHPiUnm84SzvG+/1kmc7t2hw88A9pJth8GEc2TmvfpTC9mta64QR3mUsIICtL
         y0aX4vIg5KkRH5ounuPKbBWJAfVrGorbGVITA/OpGbFcQv90G2nUYl4HXn+ypKhzCDEK
         9EFw==
X-Gm-Message-State: AOJu0YyJq+bKqviR6kGWInTWVfeiwcu3gUUBiot4vp1iXel4boyWKVlE
        b7G+NZqiONYEpz5M5q3WQauyd73twKjrbxenaAqkog==
X-Google-Smtp-Source: AGHT+IEU9qY8K6ePCFkLTQIgMKJOq3f4OTO41CbKsFGSamfOG3t42TUBCLCjTt0zydqgegKWmoCdQvuLKRyGEhr5cCM=
X-Received: by 2002:a19:9153:0:b0:501:b029:1a47 with SMTP id
 y19-20020a199153000000b00501b0291a47mr120339lfj.1.1699026548121; Fri, 03 Nov
 2023 08:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-4-irogers@google.com>
 <ZUSwOlsOyJdDT1ls@gentoo.org>
In-Reply-To: <ZUSwOlsOyJdDT1ls@gentoo.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 3 Nov 2023 08:48:56 -0700
Message-ID: <CAP-5=fVm5rmOTvXi1LZzSEc3wHv68HszOfZmBb-RG=eUj2UVHg@mail.gmail.com>
Subject: Re: [PATCH v4 03/53] libperf: Lazily allocate mmap event copy
To:     Guilherme Amadio <amadio@gentoo.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
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

On Fri, Nov 3, 2023 at 1:33=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org>=
 wrote:
>
> Hi,
>
> On Thu, Nov 02, 2023 at 10:56:45AM -0700, Ian Rogers wrote:
> > The event copy in the mmap is used to have storage to a read
> > event. Not all users of mmaps read the events, such as perf record, so
> > switch the allocation to being on first read rather than being
> > embedded within the perf_mmap.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/include/internal/mmap.h | 2 +-
> >  tools/lib/perf/mmap.c                  | 9 +++++++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/in=
clude/internal/mmap.h
> > index 5a062af8e9d8..b11aaf5ed645 100644
> > --- a/tools/lib/perf/include/internal/mmap.h
> > +++ b/tools/lib/perf/include/internal/mmap.h
> > @@ -33,7 +33,7 @@ struct perf_mmap {
> >       bool                     overwrite;
> >       u64                      flush;
> >       libperf_unmap_cb_t       unmap_cb;
> > -     char                     event_copy[PERF_SAMPLE_MAX_SIZE] __align=
ed(8);
> > +     void                    *event_copy;
> >       struct perf_mmap        *next;
> >  };
> >
> > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > index 2184814b37dd..91ae46aac378 100644
> > --- a/tools/lib/perf/mmap.c
> > +++ b/tools/lib/perf/mmap.c
> > @@ -51,6 +51,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct per=
f_mmap_param *mp,
> >
> >  void perf_mmap__munmap(struct perf_mmap *map)
> >  {
> > +     free(map->event_copy);
> > +     map->event_copy =3D NULL;
> >       if (map && map->base !=3D NULL) {
>
> If map can be NULL as the if statement above suggests, then there is a
> potential a null pointer dereference bug here. Suggestion:
>
>     if (!map)
>         return;
>
>     free(map->event_copy);
>     map->event_copy =3D NULL;
>     if (map->base !=3D NULL) {
>
>     ...

Makes sense, will fix in v5. Waiting to get additional feedback to
avoid too much email.

Thanks,
Ian

> Cheers,
> -Guilherme
>
> >               munmap(map->base, perf_mmap__mmap_len(map));
> >               map->base =3D NULL;
> > @@ -226,6 +228,13 @@ static union perf_event *perf_mmap__read(struct pe=
rf_mmap *map,
> >                       unsigned int len =3D min(sizeof(*event), size), c=
py;
> >                       void *dst =3D map->event_copy;
> >
> > +                     if (!dst) {
> > +                             dst =3D malloc(PERF_SAMPLE_MAX_SIZE);
> > +                             if (!dst)
> > +                                     return NULL;
> > +                             map->event_copy =3D dst;
> > +                     }
> > +
> >                       do {
> >                               cpy =3D min(map->mask + 1 - (offset & map=
->mask), len);
> >                               memcpy(dst, &data[offset & map->mask], cp=
y);
> > --
> > 2.42.0.869.gea05f2083d-goog
> >
> >
