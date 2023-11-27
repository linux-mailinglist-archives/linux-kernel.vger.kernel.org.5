Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF877FAD7B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjK0WdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjK0WdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:33:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4145B1BF6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:24:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso999a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123850; x=1701728650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmP8GOI7JkkxmTyMBdqzQqt4c8PGieST5QFR6LpGVHM=;
        b=ru8s6rf4SdyDiakiI3lU93uyo4VZAa/8Q9SBt6XqX8PE5M5TsuLBYV0TvlPOYI2UaE
         pFirz2fti3dHqs74fAw7fdZY3WDG5ds+qYF9+oIY7CYEOQJJ20TbplF6JgshVqYmFEpd
         Ve5UBxRGeVQqLhLLT+oa7nsRLFXRev/xYP+vQxtLYC+UO4rPIFl6ZZwK+wj86+dBE7ry
         hYuLP0gbAbPc9zA6QR1SJxskYU1ahtZH+mJtlFi/AFoixsdNCygnQjxmmTjgAsVxcTTC
         FIFkuaRFa2ApX/2ESmawViq380AeBqLsFYRNBm6QUL9DlMQbO79soEcVYQ3H6E2ph6rO
         fzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123850; x=1701728650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmP8GOI7JkkxmTyMBdqzQqt4c8PGieST5QFR6LpGVHM=;
        b=u7pBr99mQGtW/4XoCcF0xsvFnArGrPmrSOJfVarFgFYOdAFOR+gufl3E7QN33VhZQK
         A5ZQ99O0LkBfIx+qTKskatL3+WXWW00wqLw8PXk+k5s5Ex2BnykEGY5y5Cqz06Zxq++R
         7A4vE2Q8liSb3eSO07zqtgu2M1QSJyRcWS72iskZn6BzMSFOVs+7vdUAipgqVIH2fSvp
         yJB0MOYvyIqHA2z9C3ohyQZwD41kX6w9zX+De/lWdV/OOnavVUj0SMig/qRPDu/1u55J
         OKH9+XUn2RfVQjZCCooUPJAYKcgrIRN0gCJFXkqGRhDSf4QxQsGwWaLsj1zT19ZHyUzx
         9PPw==
X-Gm-Message-State: AOJu0YxjMYHMHBwGQIdcCScuSDtYUN6IttRFaZLNzhN/qYWALy4rT/uX
        knu6IeR2H5Ppc0a+mh3XngM9yLi8F3bl7lk/uFha7Q==
X-Google-Smtp-Source: AGHT+IFPGQQLLsmn5pSHaDD7xCHGkPLfyC9s84L46POWLo93bm155s8MDJGxkGQUW+f0egAGpZ7TKp/p+A+fz9+xN5k=
X-Received: by 2002:aa7:d983:0:b0:54b:8f42:e3dc with SMTP id
 u3-20020aa7d983000000b0054b8f42e3dcmr143243eds.2.1701123849509; Mon, 27 Nov
 2023 14:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-11-irogers@google.com>
 <ZWUSNLmApMByu94B@kernel.org>
In-Reply-To: <ZWUSNLmApMByu94B@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Nov 2023 14:23:57 -0800
Message-ID: <CAP-5=fVfYR2xCi=ZiT-xmcRzq2y6L6gZg8i_DWMPzhzWyeLsgQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/53] perf record: Be lazier in allocating lost
 samples buffer
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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

On Mon, Nov 27, 2023 at 2:03=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Nov 02, 2023 at 10:56:52AM -0700, Ian Rogers escreveu:
> > Wait until a lost sample occurs to allocate the lost samples buffer,
> > often the buffer isn't necessary. This saves a 64kb allocation and
> > 5.3kb of peak memory consumption.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 9b4f3805ca92..b6c8c1371b39 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1924,21 +1924,13 @@ static void __record__save_lost_samples(struct =
record *rec, struct evsel *evsel,
> >  static void record__read_lost_samples(struct record *rec)
> >  {
> >       struct perf_session *session =3D rec->session;
> > -     struct perf_record_lost_samples *lost;
> > +     struct perf_record_lost_samples *lost =3D NULL;
> >       struct evsel *evsel;
> >
> >       /* there was an error during record__open */
> >       if (session->evlist =3D=3D NULL)
> >               return;
> >
> > -     lost =3D zalloc(PERF_SAMPLE_MAX_SIZE);
> > -     if (lost =3D=3D NULL) {
> > -             pr_debug("Memory allocation failed\n");
> > -             return;
> > -     }
>
> Shouldn't we take the time here and instead improve this error message
> and then propagate the error?
>
> For instance, we may want to still get some perf.data file without these
> records but inform the user at this point how many records were lost
> (count.lost)?

Sounds like a follow-up, the messages here are just moving the
existing message and the point of the patch is to postpone/avoid a
memory allocation when possible.

Thanks,
Ian

> - Arnaldo
>
> > -
> > -     lost->header.type =3D PERF_RECORD_LOST_SAMPLES;
> > -
> >       evlist__for_each_entry(session->evlist, evsel) {
> >               struct xyarray *xy =3D evsel->core.sample_id;
> >               u64 lost_count;
> > @@ -1961,6 +1953,14 @@ static void record__read_lost_samples(struct rec=
ord *rec)
> >                               }
> >
> >                               if (count.lost) {
> > +                                     if (!lost) {
> > +                                             lost =3D zalloc(PERF_SAMP=
LE_MAX_SIZE);
> > +                                             if (!lost) {
> > +                                                     pr_debug("Memory =
allocation failed\n");
> > +                                                     return;
> > +                                             }
> > +                                             lost->header.type =3D PER=
F_RECORD_LOST_SAMPLES;
> > +                                     }
> >                                       __record__save_lost_samples(rec, =
evsel, lost,
> >                                                                   x, y,=
 count.lost, 0);
> >                               }
> > @@ -1968,9 +1968,18 @@ static void record__read_lost_samples(struct rec=
ord *rec)
> >               }
> >
> >               lost_count =3D perf_bpf_filter__lost_count(evsel);
> > -             if (lost_count)
> > +             if (lost_count) {
> > +                     if (!lost) {
> > +                             lost =3D zalloc(PERF_SAMPLE_MAX_SIZE);
> > +                             if (!lost) {
> > +                                     pr_debug("Memory allocation faile=
d\n");
> > +                                     return;
> > +                             }
> > +                             lost->header.type =3D PERF_RECORD_LOST_SA=
MPLES;
> > +                     }
> >                       __record__save_lost_samples(rec, evsel, lost, 0, =
0, lost_count,
> >                                                   PERF_RECORD_MISC_LOST=
_SAMPLES_BPF);
> > +             }
> >       }
> >  out:
> >       free(lost);
> > --
> > 2.42.0.869.gea05f2083d-goog
> >
>
> --
>
> - Arnaldo
