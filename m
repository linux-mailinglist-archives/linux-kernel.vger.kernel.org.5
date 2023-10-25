Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2BD7D6089
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjJYD2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjJYD2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:28:22 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1F898
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 20:28:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507c9305727so1038e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 20:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698204498; x=1698809298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCko5+DNPl5YusM8wx4UX9bq30OCtxNf7RBElMFnTtk=;
        b=tp7T40oX3P32yX/sFih4mfvleS95R8xZRAHgZmNzczX5OJjfMuoi/LMvnmPesHBtF+
         cISc96OazgIHlI0JwxArK3e7sySsaOCNGdhXS1jFbJct8D6pUKYCkfjeSQPSY5Xq7sJq
         nrBsW+JeLCn69GTrFf6ZzClZ+bMEiOsMG5oVfixGOl/3EofmNK+Di5cSrXg6sB8HV56m
         EjthGNUntYYLJkaCrQ1YSpUm5lE/iXfIXQIt5/18uSsn2SfNvMkX0xN9aMtGUPQo5tuQ
         UF9YezhT/c5v3PbP8nJSG6gKS2tbvA0K/2MeWi1aWPpRD0TWmh8Fd0T37GoJSXCHHyRp
         opnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698204498; x=1698809298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCko5+DNPl5YusM8wx4UX9bq30OCtxNf7RBElMFnTtk=;
        b=U1MK7IqaBdYgpqJpbnDJpvwzTM6DXoRDMD5p1spa/xIoowMWBw5mprywwwotkg3K0k
         P0LwkzcrBiNS+Y9XmVkuqCJAVtNVMkkWx7wBkWDtVdL4O3hzGDe6ttwkTySiJbpco+uU
         UtouKJzLji1qGrbLCrldw7/lYgkG6UfvBaEyzUEo/nMzA5txcGOgt21F2DEZxjBJAzEm
         jnHpIfBWJOLfeFLEf+LZFCXvM7ecKZMn0laZTYUU6tZhgF/kv4A4Kp2h/3XcWFxZQTg/
         zM67yqxNidN5UjETNAbUVe270BnOOI3x4S/QWQeLl/A2hDZB4thL2IqPvuGlEQTfk00d
         SF+A==
X-Gm-Message-State: AOJu0Ywew8kEhE94nxZtFDKHW/yMVkOy6PKqd+RzOOyP4arY+D8x1QJ9
        ZSyhrYrmtsUJN4uWeTmBjPALBIf+zeZzSTyURCEwMg==
X-Google-Smtp-Source: AGHT+IFeLTh1yjfRikYLn5I7KOGB3atpEKVmC+SBw+D4qBEkHs0UKGbkCiL0qX0EM3uoMQFwAG3J59s+zr3L50i6xPs=
X-Received: by 2002:a05:6512:3582:b0:502:932e:2e36 with SMTP id
 m2-20020a056512358200b00502932e2e36mr25055lfr.2.1698204497691; Tue, 24 Oct
 2023 20:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com> <20231024222353.3024098-14-irogers@google.com>
 <4d275fcd-a102-662f-d9f7-3acd3586acf2@huawei.com>
In-Reply-To: <4d275fcd-a102-662f-d9f7-3acd3586acf2@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 24 Oct 2023 20:28:05 -0700
Message-ID: <CAP-5=fXej_aBnvtdYJvKFMVKtmm+xXSCxOR-pNkTfr_qHmjWLA@mail.gmail.com>
Subject: Re: [PATCH v3 13/50] libperf: Lazily allocate mmap event copy
To:     Yang Jihong <yangjihong1@huawei.com>
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
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
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

On Tue, Oct 24, 2023 at 7:39=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> Hello,
>
> On 2023/10/25 6:23, Ian Rogers wrote:
> > The event copy in the mmap is used to have storage to a read
> > event. Not all users of mmaps read the events, such as perf record, so
> > switch the allocation to being on first read rather than being
> > embedded within the perf_mmap.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/lib/perf/include/internal/mmap.h | 2 +-
> >   tools/lib/perf/mmap.c                  | 9 +++++++++
> >   2 files changed, 10 insertions(+), 1 deletion(-)
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
> >   };
> >
> > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > index 2184814b37dd..91ae46aac378 100644
> > --- a/tools/lib/perf/mmap.c
> > +++ b/tools/lib/perf/mmap.c
> > @@ -51,6 +51,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct per=
f_mmap_param *mp,
> >
> >   void perf_mmap__munmap(struct perf_mmap *map)
> >   {
> > +     free(map->event_copy);
> > +     map->event_copy =3D NULL;
> >       if (map && map->base !=3D NULL) {
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
> `event` is used as the return parameter of libperf API
> perf_mmap__read_event().
> Is `zalloc` better to avoid dirty data?

We could but I'd prefer not to zero unnecessarily. We've had similar
uninitialized memory being copied to perf.data file problems such as:
http://lore.kernel.org/lkml/20210309234945.419254-1-irogers@google.com
With the sanitizers help we can avoid the problem and do less work,
which I think is best.

Thanks,
Ian

> Thanks,
> Yang
