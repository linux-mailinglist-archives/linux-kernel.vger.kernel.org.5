Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268037FF95A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbjK3S3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjK3S3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:29:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C67E10D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:29:43 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso14365e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701368982; x=1701973782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBKQZd68edVxF6ECkF2oX9KfXPiYc6EetlvZAUBR47c=;
        b=ouETubjN1Hdfwdi3lj5ciw9BryOW7yvcfzKQ8Y6c9yMy99sUrEZjdtvK4hgBXQcrHw
         QOKA/wmdEMYw8XZhz70GYM/rzYolQYCaA/htcob/jmnpV9u06qUnjK/rlDjXJalwiolJ
         UyBsk8YT8+T8NWijedkchFVYnMhjTsmaZi5AfrsNxxq71qnVGwJccjjm4xWh+/JrxXtn
         gxBp4vE83nlRW5PewqnFvmVSjDvi6STPDLTpS/2PE/+sJfusmXGrMAyyn8aJ9nq7PZ69
         B2Gcq76iRn1gs0o3w1id+LxjamdEHE19sbD8RJdXLPJSguWAMHMJLPIIG8QTp4jISYC9
         +JxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701368982; x=1701973782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBKQZd68edVxF6ECkF2oX9KfXPiYc6EetlvZAUBR47c=;
        b=w6m4eqYXjzkr5sFPnoy/tYHbIpss4u9omigWe6kVW34YZyvc4R/QNLj89QZGkvEQVu
         EbjIV5z2pyQCVw4o4S9BToMCyRB1m2zFbq+HqQIb9WM6W6l7Z9Gcn0Wu50Qi3pPltSIV
         mxBlw87ynql1XEvTToYyZFnbwaPfwnD90KHSK8lPH171TL/sFDr3V8EZbU2SSf/MPDvr
         2NXgqaYZ3+TaRFK20TWJrIK6n45y7snMA5u4BULxnRnWvamXmVtfPDhe1RbW9av8d8v1
         k/OGptFhdA2yLAr7/HxDX4mU3RR3ARf4JisRrFFT7NAq/8atK5If2XhIvOO1DCzpmP4J
         wy0g==
X-Gm-Message-State: AOJu0YyMP3CR099BvlofR7cawTf70NUns72ZAN9pfyvtQG4upKvGHNxH
        M5GQZ+uBQPoTbKhBo/hcgVaQ0Ru8YHVSj2O5VcXWnQ==
X-Google-Smtp-Source: AGHT+IGJXurzgm9WUTj0WY4QgYfh64X35gMpEmBv6sX8eZgPY8mokBM6500vWNCCFVYZsaGL0tJ3UdVaHekQSMyAvhA=
X-Received: by 2002:a05:600c:1c04:b0:40b:43f4:df9e with SMTP id
 j4-20020a05600c1c0400b0040b43f4df9emr211199wms.2.1701368981847; Thu, 30 Nov
 2023 10:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-9-irogers@google.com>
 <CAM9d7cjpYHN_Q63sW70vTCisdW=-SzjsrryUUJjgtZ3+9jdxfA@mail.gmail.com>
In-Reply-To: <CAM9d7cjpYHN_Q63sW70vTCisdW=-SzjsrryUUJjgtZ3+9jdxfA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 30 Nov 2023 10:29:30 -0800
Message-ID: <CAP-5=fXjReF38T_GKohtWd7_7fZjYVnKBj-Fwt+agi1vSWAEdQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/50] perf record: Be lazier in allocating lost
 samples buffer
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
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

On Wed, Nov 29, 2023 at 6:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Nov 27, 2023 at 2:09=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
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
> >         struct perf_session *session =3D rec->session;
> > -       struct perf_record_lost_samples *lost;
> > +       struct perf_record_lost_samples *lost =3D NULL;
> >         struct evsel *evsel;
> >
> >         /* there was an error during record__open */
> >         if (session->evlist =3D=3D NULL)
> >                 return;
> >
> > -       lost =3D zalloc(PERF_SAMPLE_MAX_SIZE);
>
> To minimize the allocation size, this can be
> sizeof(*lost) + session->machines.host.id_hdr_size
> instead of PERF_SAMPLE_MAX_SIZE.

Sounds good, should probably be a follow up. The current size is
PERF_SAMPLE_MAX_SIZE.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > -       if (lost =3D=3D NULL) {
> > -               pr_debug("Memory allocation failed\n");
> > -               return;
> > -       }
> > -
> > -       lost->header.type =3D PERF_RECORD_LOST_SAMPLES;
> > -
> >         evlist__for_each_entry(session->evlist, evsel) {
> >                 struct xyarray *xy =3D evsel->core.sample_id;
> >                 u64 lost_count;
> > @@ -1961,6 +1953,14 @@ static void record__read_lost_samples(struct rec=
ord *rec)
> >                                 }
> >
> >                                 if (count.lost) {
> > +                                       if (!lost) {
> > +                                               lost =3D zalloc(PERF_SA=
MPLE_MAX_SIZE);
> > +                                               if (!lost) {
> > +                                                       pr_debug("Memor=
y allocation failed\n");
> > +                                                       return;
> > +                                               }
> > +                                               lost->header.type =3D P=
ERF_RECORD_LOST_SAMPLES;
> > +                                       }
> >                                         __record__save_lost_samples(rec=
, evsel, lost,
> >                                                                     x, =
y, count.lost, 0);
> >                                 }
> > @@ -1968,9 +1968,18 @@ static void record__read_lost_samples(struct rec=
ord *rec)
> >                 }
> >
> >                 lost_count =3D perf_bpf_filter__lost_count(evsel);
> > -               if (lost_count)
> > +               if (lost_count) {
> > +                       if (!lost) {
> > +                               lost =3D zalloc(PERF_SAMPLE_MAX_SIZE);
> > +                               if (!lost) {
> > +                                       pr_debug("Memory allocation fai=
led\n");
> > +                                       return;
> > +                               }
> > +                               lost->header.type =3D PERF_RECORD_LOST_=
SAMPLES;
> > +                       }
> >                         __record__save_lost_samples(rec, evsel, lost, 0=
, 0, lost_count,
> >                                                     PERF_RECORD_MISC_LO=
ST_SAMPLES_BPF);
> > +               }
> >         }
> >  out:
> >         free(lost);
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >
