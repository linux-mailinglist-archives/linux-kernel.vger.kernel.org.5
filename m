Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBFE7BE540
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377005AbjJIPpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376901AbjJIPpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:45:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E15C5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:45:38 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5068b69f4aeso7673e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696866337; x=1697471137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfVtaRDig7D+Ty8+FieODZ141554VQ+ssPrPXjaViV4=;
        b=1T9y0OuY4Di/oPxX0WRkVnisYCrqkSCYzZQq9xCp9RXvy8nqDtVzKAulHk6kp6Gy4L
         jYG3SH1aWScJg70xupLLk15aUiHX2iyKQk6I0qIR0kqlbPHRVaaLdEiVYd2gpXxd39MH
         UZ1cVpStnD8B78VPKr+IxYOgHbEJtdGm3EoJa81rt7wAcdtsmwypTl3iwKmHkmOWFJc5
         CEc8eDEt00CKygbmJ/fx0qLgo0v48EquWrGZ+OuM0TTLLjMzAk+CkXpkNidUIteeTSR+
         /R8OKSWgPvo5NPagTC10rzoMaYImlJb4ccp+cxKpinSBIZaj9jy0nRQFov2hG6hueQMF
         2JSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696866337; x=1697471137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfVtaRDig7D+Ty8+FieODZ141554VQ+ssPrPXjaViV4=;
        b=J3AGl7cvwmwqv2MKMfLkTljAmwA6QD9Olh1IqEDY9XfOwvgIfLGmdYtXYV8it4oZgV
         0jOCD7n0SiB95X3lii7nDsP6usRNW/SwbultYPD1OLfNKlkWS0fCM/xstaK5H7j5dcWn
         HS0tkxepOVEOpf0hoDEezMUMIN3gQdDgyomVW7/K+SNykNCXFZ0pVZVX+Vo2gz/HAp7d
         aceIf0DniX86L064e/s1qQeYhdK+P5vuujuVUx+mPTXpMfCzZpQwr/zt7DUzFPRr/m54
         oRhhQbAJbDKO1dnaDg4Y4mYgzsSvZX/12P3P3vyhHE4CMwr5AnMDdstvGfuJHs40edMY
         CavQ==
X-Gm-Message-State: AOJu0YwO/3E6ktCVjXTM+piYCO834Rnzpiyj2ebeIELpVVc3t2KqBRdz
        RwtiaWW3ZB50qwfLIHvKH2Ih877W2LdD0jQD0c81MQ==
X-Google-Smtp-Source: AGHT+IHyqimkAN/ZGin5q4+q2QxBs1Lei/HTv3/YCpCfU6KTN/Jvvy/WxyiYZnOsxUwM84s6ifYLH255oUoVtofxu+M=
X-Received: by 2002:ac2:51a5:0:b0:501:a2b9:6046 with SMTP id
 f5-20020ac251a5000000b00501a2b96046mr220584lfk.7.1696866336692; Mon, 09 Oct
 2023 08:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-5-irogers@google.com>
 <CAM9d7ch4SLLbORdhkanCoPQZX=f-p-HxsYX2YWYbtLR4beD4wg@mail.gmail.com>
In-Reply-To: <CAM9d7ch4SLLbORdhkanCoPQZX=f-p-HxsYX2YWYbtLR4beD4wg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 Oct 2023 08:45:25 -0700
Message-ID: <CAP-5=fXtx20VWAVpxAB-HHONx-8MUQKyFm9iSf7ohNBhoESoYg@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] perf hisi-ptt: Fix potential memory leak
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Yuan Can <yuancan@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 10:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 5, 2023 at 4:09=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Fix clang-tidy found potential memory leak and unread value:
> > ```
> > tools/perf/util/hisi-ptt.c:108:3: warning: Value stored to 'data_offset=
' is never read [clang-analyzer-deadcode.DeadStores]
> >                 data_offset =3D 0;
> >                 ^             ~
> > tools/perf/util/hisi-ptt.c:108:3: note: Value stored to 'data_offset' i=
s never read
> >                 data_offset =3D 0;
> >                 ^             ~
> > tools/perf/util/hisi-ptt.c:112:12: warning: Potential leak of memory po=
inted to by 'data' [clang-analyzer-unix.Malloc]
> >                         return -errno;
> >                                 ^
> > /usr/include/errno.h:38:18: note: expanded from macro 'errno'
> >                  ^
> > tools/perf/util/hisi-ptt.c:100:15: note: Memory is allocated
> >         void *data =3D malloc(size);
> >                      ^~~~~~~~~~~~
> > tools/perf/util/hisi-ptt.c:104:6: note: Assuming 'data' is non-null
> >         if (!data)
> >             ^~~~~
> > tools/perf/util/hisi-ptt.c:104:2: note: Taking false branch
> >         if (!data)
> >         ^
> > tools/perf/util/hisi-ptt.c:107:6: note: Assuming the condition is false
> >         if (perf_data__is_pipe(session->data)) {
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > tools/perf/util/hisi-ptt.c:107:2: note: Taking false branch
> >         if (perf_data__is_pipe(session->data)) {
> >         ^
> > tools/perf/util/hisi-ptt.c:111:7: note: Assuming the condition is true
> >                 if (data_offset =3D=3D -1)
> >                     ^~~~~~~~~~~~~~~~~
> > tools/perf/util/hisi-ptt.c:111:3: note: Taking true branch
> >                 if (data_offset =3D=3D -1)
> >                 ^
> > tools/perf/util/hisi-ptt.c:112:12: note: Potential leak of memory point=
ed to by 'data'
> >                         return -errno;
> >                                 ^
> > /usr/include/errno.h:38:18: note: expanded from macro 'errno'
> > ```
>
> We already have
>
>   https://lore.kernel.org/r/20230930072719.1267784-1-visitorckw@gmail.com

Agreed. There is a written to but not read addressed in this one, but
I think that is okay to clean up later and to drop this patch.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/hisi-ptt.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
> > index 45b614bb73bf..ea297329c526 100644
> > --- a/tools/perf/util/hisi-ptt.c
> > +++ b/tools/perf/util/hisi-ptt.c
> > @@ -98,18 +98,18 @@ static int hisi_ptt_process_auxtrace_event(struct p=
erf_session *session,
> >         int fd =3D perf_data__fd(session->data);
> >         int size =3D event->auxtrace.size;
> >         void *data =3D malloc(size);
> > -       off_t data_offset;
> >         int err;
> >
> >         if (!data)
> >                 return -errno;
> >
> > -       if (perf_data__is_pipe(session->data)) {
> > -               data_offset =3D 0;
> > -       } else {
> > -               data_offset =3D lseek(fd, 0, SEEK_CUR);
> > -               if (data_offset =3D=3D -1)
> > +       if (!perf_data__is_pipe(session->data)) {
> > +               off_t data_offset =3D lseek(fd, 0, SEEK_CUR);
> > +
> > +               if (data_offset =3D=3D -1) {
> > +                       free(data);
> >                         return -errno;
> > +               }
> >         }
> >
> >         err =3D readn(fd, data, size);
> > --
> > 2.42.0.609.gbb76f46606-goog
> >
