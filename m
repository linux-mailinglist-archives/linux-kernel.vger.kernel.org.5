Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78867FAA4C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjK0T2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjK0T2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:28:32 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DB1D5A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:28:38 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50babb66dedso5367e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701113316; x=1701718116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emsUw2/bJXpid3wTNhP0ePyetslR3hOrktzFF6VS7Tk=;
        b=t9mKuVfRYSi11h4hMOeCOUqEwtrsSrLieu0r+Iw880q0KBobBe8KEzYRcTBKlf9RI3
         DekwH/ccmNl/UqUaBmFXIEsd01cbAsm75bNqGV5SmQbZgMvOr2RwQ6sGCbPwoUjZYha2
         VTQSfnqFw9gXGcUUS9iGQLNbksr+BEap9jBmNZaF5aA2xdgRp3/7QHmSgQC3EQ9owuz7
         DPHqWSrZ7aJ/1PgU+AQWfkPDhzRecUROp6gPJOLk9XrvdkdAo6HJ8kzS6juYs1Gwdpc2
         Lm4/P0WQHB0j+WNPYyEoq2Dzrxzahr1gpaldntzzmuMcWVP4pWg9Z7wHtvU4XMekpR7x
         9pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701113316; x=1701718116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emsUw2/bJXpid3wTNhP0ePyetslR3hOrktzFF6VS7Tk=;
        b=Mycl7WmlFwlM60El9HfzG4BVyf9YKFP66V4hB9V5Ti0NmkzhRbR1qQwW4evTyhYyqI
         1UR7bCxKz1ZlbYFvZ/cV4/V4bPccndJGgzLHR4fvRwV8xrBGzL4mWM9I5+sS+8O2uw1P
         LVVOKTdNVY3dcAmBK+ceZJDKWHBtxthEZUvVf2IPZ9isQGf4q9IID1RVuhHjyxBY43eY
         DgWzWHr2HxLf24G3HOFNTVlBoBJORYUYdEs25TkB6ZVo8NLnj8EOc8ESsI+AcbbipJFE
         83e3GixMtmFxMVeekcfJrBA5e8zrpuPDwNmZEbinbRwTjfeHewxQOipZmj5M15TvZdaf
         oQiA==
X-Gm-Message-State: AOJu0Yw4Jntu0YV5IJDCWdrrIwd35eiSmqq2lQtufmf6VrHHEBfYXN/I
        myPBPMxU6NxuokUIK61GmcnRtQwW+ohx3RuU91PbAg==
X-Google-Smtp-Source: AGHT+IGqz5YV8saJWdO+etbO+UPSAP/D4OHFvMdJV3aIAzcmDHsaTLH1laau0c92fGE4K+1K5IgG18qww6GSfojHddI=
X-Received: by 2002:ac2:4c8e:0:b0:50a:a790:30b9 with SMTP id
 d14-20020ac24c8e000000b0050aa79030b9mr324468lfl.0.1701113315882; Mon, 27 Nov
 2023 11:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-4-irogers@google.com>
 <ZUSwOlsOyJdDT1ls@gentoo.org> <CAP-5=fVm5rmOTvXi1LZzSEc3wHv68HszOfZmBb-RG=eUj2UVHg@mail.gmail.com>
 <CAM9d7ciqPsR1DNnngZApwkyNd+6AQPtqxBvy=m_jsMnchHvr9w@mail.gmail.com>
In-Reply-To: <CAM9d7ciqPsR1DNnngZApwkyNd+6AQPtqxBvy=m_jsMnchHvr9w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Nov 2023 11:28:24 -0800
Message-ID: <CAP-5=fXFPnpOvYJeKTeDGDjDw4FD1KS22U+D0Aeffx3qaNW7MQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/53] libperf: Lazily allocate mmap event copy
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Guilherme Amadio <amadio@gentoo.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 5, 2023 at 10:12=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Nov 3, 2023 at 8:49=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Fri, Nov 3, 2023 at 1:33=E2=80=AFAM Guilherme Amadio <amadio@gentoo.=
org> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Nov 02, 2023 at 10:56:45AM -0700, Ian Rogers wrote:
> > > > The event copy in the mmap is used to have storage to a read
> > > > event. Not all users of mmaps read the events, such as perf record,=
 so
> > > > switch the allocation to being on first read rather than being
> > > > embedded within the perf_mmap.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/lib/perf/include/internal/mmap.h | 2 +-
> > > >  tools/lib/perf/mmap.c                  | 9 +++++++++
> > > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/per=
f/include/internal/mmap.h
> > > > index 5a062af8e9d8..b11aaf5ed645 100644
> > > > --- a/tools/lib/perf/include/internal/mmap.h
> > > > +++ b/tools/lib/perf/include/internal/mmap.h
> > > > @@ -33,7 +33,7 @@ struct perf_mmap {
> > > >       bool                     overwrite;
> > > >       u64                      flush;
> > > >       libperf_unmap_cb_t       unmap_cb;
> > > > -     char                     event_copy[PERF_SAMPLE_MAX_SIZE] __a=
ligned(8);
> > > > +     void                    *event_copy;
> > > >       struct perf_mmap        *next;
> > > >  };
> > > >
> > > > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > > > index 2184814b37dd..91ae46aac378 100644
> > > > --- a/tools/lib/perf/mmap.c
> > > > +++ b/tools/lib/perf/mmap.c
> > > > @@ -51,6 +51,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct=
 perf_mmap_param *mp,
> > > >
> > > >  void perf_mmap__munmap(struct perf_mmap *map)
> > > >  {
> > > > +     free(map->event_copy);
> > > > +     map->event_copy =3D NULL;
> > > >       if (map && map->base !=3D NULL) {
> > >
> > > If map can be NULL as the if statement above suggests, then there is =
a
> > > potential a null pointer dereference bug here. Suggestion:
> > >
> > >     if (!map)
> > >         return;
> > >
> > >     free(map->event_copy);
> > >     map->event_copy =3D NULL;
> > >     if (map->base !=3D NULL) {
> > >
> > >     ...
> >
> > Makes sense, will fix in v5. Waiting to get additional feedback to
> > avoid too much email.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
>
> But I have another concern (not related to this change).
>
> > >
> > > >               munmap(map->base, perf_mmap__mmap_len(map));
> > > >               map->base =3D NULL;
> > > > @@ -226,6 +228,13 @@ static union perf_event *perf_mmap__read(struc=
t perf_mmap *map,
> > > >                       unsigned int len =3D min(sizeof(*event), size=
), cpy;
>
> I'm not sure if it's ok to read less than the actual size, IOW
> it seems to assume 'size' is smaller than sizeof(*event).
> I guess it's true for most cases as union perf_event has
> perf_record_mmap2 (among others) which contains a
> filename array of size PATH_MAX.
>
> But the SAMPLE record can be larger than that when it has
> PERF_SAMPLE_AUX IIRC.  It'd happen only if it crossed the mmap
> boundary and I'm afraid it'd corrupt the data.

Thanks, I was thinking this would just be a drop in change but I think
given this feedback it would be better to switch from allocating once
a PERF_SAMPLE_MAX_SIZE buffer to allocating or reallocating one based
on size. This potentially saves memory when size is less than
PERF_SAMPLE_MAX_SIZE and by removing the min calculation for the
amount copied (len) we can potentially exceed it and fix a potential
bug. I'll add this in v5.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > > >                       void *dst =3D map->event_copy;
> > > >
> > > > +                     if (!dst) {
> > > > +                             dst =3D malloc(PERF_SAMPLE_MAX_SIZE);
> > > > +                             if (!dst)
> > > > +                                     return NULL;
> > > > +                             map->event_copy =3D dst;
> > > > +                     }
> > > > +
> > > >                       do {
> > > >                               cpy =3D min(map->mask + 1 - (offset &=
 map->mask), len);
> > > >                               memcpy(dst, &data[offset & map->mask]=
, cpy);
> > > > --
> > > > 2.42.0.869.gea05f2083d-goog
> > > >
> > > >
