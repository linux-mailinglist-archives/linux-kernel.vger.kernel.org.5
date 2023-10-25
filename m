Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B9A7D71F6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjJYRBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjJYRBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:01:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8658D132
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:01:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso19e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698253263; x=1698858063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CErK5br5TeZeV3yT6FzK4rCa2/wdScC7HtXwgBBWNM=;
        b=C8pRHVV7PGXgLbb7kecm58lrGzc2eZzwU4trhydekIrotjWlqhhxhJ9yfUXbduZPpL
         QOsKWUfpIIFWBtX9ZJQKvEyB4Eyhm3ICD3fJwnZIx2lPhuML5yMXT8OxOF1TlLy5hyLc
         DudxdWvkQ2Ef8MHLdC6BMWubiDwuaOkTZhFtYs6vYfQFuueJ6JsFqKDltiJjpDIT/5Py
         4oaWgr202I53viyE5nLQgsFRxsdszothuSzyR3lGmH8+FMCG4AQMTTDUlymgneStLRKo
         EmkHWmFeeM7rcoR2fJwwGaVzc+pVedsTa1QZfRxghI757DcpfN7B2VnKlcE5tjJY8glO
         kFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698253263; x=1698858063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CErK5br5TeZeV3yT6FzK4rCa2/wdScC7HtXwgBBWNM=;
        b=PhGTf5SLjFjPjN8bsRimr9GkBLnr0OX2M9GmkBLtXZ/pvVlV5ykTFdKZsegnroRSc7
         hkDVcjhpahrhiS9udpcWZ9dh3FgL0ibDqah8vLvS4EJImg5ovK21P0V8rPE2qH/2mHFP
         iF0+HJY9tPNmChrVc45tb611OH2nThW0Bkr++G8+s14xvYg/wX91npV3iQGmx4abjrmN
         v9RPLVhhLtxB887mv0nx7CFzU+b70qaOILbbiVVcX4LtjQvPpoyWKRIqNFk2Kk72ZgbQ
         KfNTB6qJrZR2GrokBZlshCqPeT0VC23DaoGEeTjar/GqmQUt4eFzsJa257+p3+ia5Er2
         gHhA==
X-Gm-Message-State: AOJu0YwgAoJYIY56hCeGMI4Z1omM2gx3A5A766WyRSfS3d2Y6PJGR4oh
        /GJ4gYNuayeA4kVlEPpl//UaD6TVZcGe7hRNN+HREQ==
X-Google-Smtp-Source: AGHT+IGe+Z5mxuVh5PNb8OXDmKV7m5nxvS6TySaRCJoW9fAIMA5Cv+Vg2c6I/ppQyoQ2RBZz4+bbaZsCPgXbmZlEV58=
X-Received: by 2002:a05:6512:202a:b0:507:968f:a6e7 with SMTP id
 s10-20020a056512202a00b00507968fa6e7mr73984lfs.5.1698253262469; Wed, 25 Oct
 2023 10:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com> <20231024222353.3024098-21-irogers@google.com>
 <7516348d-fe6d-9768-049e-328cfcda89ee@huawei.com>
In-Reply-To: <7516348d-fe6d-9768-049e-328cfcda89ee@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 Oct 2023 10:00:50 -0700
Message-ID: <CAP-5=fX2Mk9uUfbnF75B=2xFjGy3HWtjPaM-B0-_KWaHjBW0qQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/50] perf record: Be lazier in allocating lost
 samples buffer
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

On Tue, Oct 24, 2023 at 8:44=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> Hello,
>
> On 2023/10/25 6:23, Ian Rogers wrote:
> > Wait until a lost sample occurs to allocate the lost samples buffer,
> > often the buffer isn't necessary. This saves a 64kb allocation and
> > 5.3kb of peak memory consumption.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/builtin-record.c | 29 +++++++++++++++++++----------
> >   1 file changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 9b4f3805ca92..b6c8c1371b39 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1924,21 +1924,13 @@ static void __record__save_lost_samples(struct =
record *rec, struct evsel *evsel,
> >   static void record__read_lost_samples(struct record *rec)
> >   {
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
>
> Can zalloc for `lost` be moved to __record__save_lost_samples?
> This simplifies the code.

Hmm.. seems marginal. This change makes the code not return in
record__read_lost_samples when the memory allocation fails, so I'm
50/50 on it.

Thanks,
Ian

>
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index dcf288a4fb9a..8d2eb746031a 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1888,14 +1888,25 @@ record__switch_output(struct record *rec, bool
> at_exit)
>   }
>
>   static void __record__save_lost_samples(struct record *rec, struct
> evsel *evsel,
> -                                       struct perf_record_lost_samples
> *lost,
> +                                       struct perf_record_lost_samples
> **plost,
>                                          int cpu_idx, int thread_idx,
> u64 lost_count,
>                                          u16 misc_flag)
>   {
>          struct perf_sample_id *sid;
>          struct perf_sample sample =3D {};
> +       struct perf_record_lost_samples *lost =3D *plost;
>          int id_hdr_size;
>
> +       if (!lost) {
> +               lost =3D zalloc(PERF_SAMPLE_MAX_SIZE);
> +               if (!lost) {
> +                       pr_debug("Memory allocation failed\n");
> +                       return;
> +               }
> +               lost->header.type =3D PERF_RECORD_LOST_SAMPLES;
> +               *plost =3D lost;
> +       }
> +
>          lost->lost =3D lost_count;
>          if (evsel->core.ids) {
>                  sid =3D xyarray__entry(evsel->core.sample_id, cpu_idx,
> thread_idx);
> @@ -1912,21 +1923,13 @@ static void __record__save_lost_samples(struct
> record *rec, struct evsel *evsel,
>   static void record__read_lost_samples(struct record *rec)
>   {
>          struct perf_session *session =3D rec->session;
> -       struct perf_record_lost_samples *lost;
> +       struct perf_record_lost_samples *lost =3D NULL;
>          struct evsel *evsel;
>
>          /* there was an error during record__open */
>          if (session->evlist =3D=3D NULL)
>                  return;
>
> -       lost =3D zalloc(PERF_SAMPLE_MAX_SIZE);
> -       if (lost =3D=3D NULL) {
> -               pr_debug("Memory allocation failed\n");
> -               return;
> -       }
> -
> -       lost->header.type =3D PERF_RECORD_LOST_SAMPLES;
> -
>          evlist__for_each_entry(session->evlist, evsel) {
>                  struct xyarray *xy =3D evsel->core.sample_id;
>                  u64 lost_count;
> @@ -1949,7 +1952,7 @@ static void record__read_lost_samples(struct
> record *rec)
>                                  }
>
>                                  if (count.lost) {
> -                                       __record__save_lost_samples(rec,
> evsel, lost,
> +                                       __record__save_lost_samples(rec,
> evsel, &lost,
>                                                                      x,
> y, count.lost, 0);
>                                  }
>                          }
> @@ -1957,11 +1960,12 @@ static void record__read_lost_samples(struct
> record *rec)
>
>                  lost_count =3D perf_bpf_filter__lost_count(evsel);
>                  if (lost_count)
> -                       __record__save_lost_samples(rec, evsel, lost, 0,
> 0, lost_count,
> +                       __record__save_lost_samples(rec, evsel, &lost,
> 0, 0, lost_count,
>
> PERF_RECORD_MISC_LOST_SAMPLES_BPF);
>          }
>   out:
> -       free(lost);
> +       if (lost)
> +               free(lost);
>   }
>
>   static volatile sig_atomic_t workload_exec_errno;
>
>
> Thanks,
> Yang
>
