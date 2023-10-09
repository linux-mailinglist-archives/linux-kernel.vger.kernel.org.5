Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3328F7BE60C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377151AbjJIQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377100AbjJIQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:13:24 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF6BBA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:13:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5068b69f4aeso8041e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696867999; x=1697472799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0jKnvS+p6tLusyf0KR6YxKQNRwudB/CjvpEJfWJaDA=;
        b=pbxm7K99vjQnmloMqRtmCZxbCBwwnBu8t0PN38YqT5RK4gnb2/HIfcL7SebCTKJA5m
         Xlz0kasxBJKKxtp8ko/mH4+S0zmSoaVgjGHMAIETL+fIUMNXGs0LwlNOOMe0fpSQUiMD
         1iiPrJxckZFiE0TEC0jVxfLodDnLU7HyJ0QQQYu9pJ3oBc2ypYQ81tKeWgm0E9oo9o/f
         c5tmGKoGIYWkjlzROnlSD4U7e+J4p2BQnFIL8aLHu8Uc40m/7KI8UxSA8XD3wSDua8hT
         gNfAHLUec0IXfYxK0MAEea5iyLsvk76mo3wAc+GJEEaf4qh/FTupUDcVQP7jB0UdF7GB
         P3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867999; x=1697472799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0jKnvS+p6tLusyf0KR6YxKQNRwudB/CjvpEJfWJaDA=;
        b=K6IAn0OtIzUxTN01p9eY9SrcvXxcrP8rb/1sI+488+IapcHDAEy3+32DBjLcMuxxyk
         juWhyrJ7NoSmnUZq6iaVu8UIQO25ymWj4IHK6ahwXudphfhwezMcra12TJkNlq10dmLQ
         mXjI+0ubW0f1L6NYb0dbZPwpf9W64qdQKIMxEm0osGrNEFWyHD5o7jMy6+hj9pDNz7So
         9OTiNVfbdjHbKXYcaAuhTZi8YCFKpM2kjJpeB9tybO7a4or6Ae57CGyrcEFcXEGz3Qhi
         66D1P0JKfQdyiNb+3QcsQ1Kq8PGf5s9prMEYR8pOeGUUpsGy6/qSpDkwJr0g9U0iH7aC
         5eTg==
X-Gm-Message-State: AOJu0YxSehWbrXQ6VHRmjc6J4wRojmjceYtQD5XPIiWYGPUlEfSN+Pv3
        lKD79N7gVcSFLUerADyGlysikbch28OhC2gcN29xHw==
X-Google-Smtp-Source: AGHT+IF1HdpHvO8s/EVxVQ0me6ekTtk7UbIlgadFNqVNz5wYB+4oNqfX/opeS9wuIKe7sPJkg7G/ilLuNk6Uh/uD+jE=
X-Received: by 2002:a19:7006:0:b0:502:dc15:7fb with SMTP id
 h6-20020a197006000000b00502dc1507fbmr284723lfc.5.1696867999100; Mon, 09 Oct
 2023 09:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-6-irogers@google.com>
 <CAM9d7chmVRrFgEZMYk3EWG+1wjXqLC3suu-xrX64hmfBSAFi0A@mail.gmail.com>
In-Reply-To: <CAM9d7chmVRrFgEZMYk3EWG+1wjXqLC3suu-xrX64hmfBSAFi0A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 Oct 2023 09:13:05 -0700
Message-ID: <CAP-5=fXbU_hckJp=evE5ja7BA4sS30E6hHryXXAEvwXs=1qkBA@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] perf bench uprobe: Fix potential use of memory
 after free
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 10:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 5, 2023 at 4:09=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Found by clang-tidy:
> > ```
> > bench/uprobe.c:98:3: warning: Use of memory after it is freed [clang-an=
alyzer-unix.Malloc]
> >                 bench_uprobe_bpf__destroy(skel);
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> I'm ok with the change but I think it won't call
> bench_uprobe__teardown_bpf_skel() if the setup function
> returns a negative value.  Maybe we also need to set the
> err in the default case of `switch (bench)` statement.

Yes, the analysis (I'll put it below) assumes that the err can be
positive yielding destroy being called twice, the second creating a
use-after-free. I think it is worth cleaning the code up and making
the analyzer's job easier.

Thanks,
Ian

```
bench/uprobe.c:98:3: warning: Use of memory after it is freed
[clang-analyzer-unix.Malloc]
               bench_uprobe_bpf__destroy(skel);
               ^
tools/perf/bench/uprobe.c:197:9: note: Calling 'bench_uprobe'
       return bench_uprobe(argc, argv, BENCH_UPROBE__TRACE_PRINTK);
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/bench/uprobe.c:150:6: note: 'bench' is not equal to
BENCH_UPROBE__BASELINE
       if (bench !=3D BENCH_UPROBE__BASELINE &&
bench_uprobe__setup_bpf_skel(bench) < 0)
           ^~~~~
tools/perf/bench/uprobe.c:150:6: note: Left side of '&&' is true
tools/perf/bench/uprobe.c:150:41: note: Calling 'bench_uprobe__setup_bpf_sk=
el'
       if (bench !=3D BENCH_UPROBE__BASELINE &&
bench_uprobe__setup_bpf_skel(bench) < 0)

^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/bench/uprobe.c:68:7: note: 'skel' is non-null
       if (!skel) {
            ^~~~
tools/perf/bench/uprobe.c:68:2: note: Taking false branch
       if (!skel) {
       ^
tools/perf/bench/uprobe.c:74:6: note: Assuming 'err' is not equal to 0
       if (err) {
           ^~~
tools/perf/bench/uprobe.c:74:2: note: Taking true branch
       if (err) {
       ^
tools/perf/bench/uprobe.c:76:3: note: Control jumps to line 91
               goto cleanup;
               ^
tools/perf/bench/uprobe.c:91:2: note: Calling 'bench_uprobe_bpf__destroy'
       bench_uprobe_bpf__destroy(skel);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/util/bpf_skel/bench_uprobe.skel.h:44:6: note: Assuming
'obj' is non-null
       if (!obj)
           ^~~~
tools/perf/util/bpf_skel/bench_uprobe.skel.h:44:2: note: Taking false branc=
h
       if (!obj)
       ^
tools/perf/util/bpf_skel/bench_uprobe.skel.h:46:6: note: Assuming
field 'skeleton' is null
       if (obj->skeleton)
           ^~~~~~~~~~~~~
tools/perf/util/bpf_skel/bench_uprobe.skel.h:46:2: note: Taking false branc=
h
       if (obj->skeleton)
       ^
tools/perf/util/bpf_skel/bench_uprobe.skel.h:48:2: note: Memory is released
       free(obj);
       ^~~~~~~~~
tools/perf/bench/uprobe.c:91:2: note: Returning; memory was released
via 1st parameter
       bench_uprobe_bpf__destroy(skel);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/bench/uprobe.c:150:41: note: Returning; memory was released
       if (bench !=3D BENCH_UPROBE__BASELINE &&
bench_uprobe__setup_bpf_skel(bench) < 0)

^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/bench/uprobe.c:150:41: note: Assuming the condition is false
       if (bench !=3D BENCH_UPROBE__BASELINE &&
bench_uprobe__setup_bpf_skel(bench) < 0)

^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/bench/uprobe.c:150:2: note: Taking false branch
       if (bench !=3D BENCH_UPROBE__BASELINE &&
bench_uprobe__setup_bpf_skel(bench) < 0)
       ^
tools/perf/bench/uprobe.c:155:14: note: Assuming 'i' is >=3D 'loops'
       for (i =3D 0; i < loops; i++) {
                   ^~~~~~~~~
tools/perf/bench/uprobe.c:155:2: note: Loop condition is false.
Execution continues on line 159
       for (i =3D 0; i < loops; i++) {
       ^
tools/perf/bench/uprobe.c:164:2: note: Control jumps to 'case 1:'  at line =
169
       switch (bench_format) {
       ^
tools/perf/bench/uprobe.c:171:3: note:  Execution continues on line 179
               break;
               ^
tools/perf/bench/uprobe.c:179:6: note: 'bench' is not equal to
BENCH_UPROBE__BASELINE
       if (bench !=3D BENCH_UPROBE__BASELINE)
           ^~~~~
tools/perf/bench/uprobe.c:179:2: note: Taking true branch
       if (bench !=3D BENCH_UPROBE__BASELINE)
       ^
tools/perf/bench/uprobe.c:180:3: note: Calling 'bench_uprobe__teardown_bpf_=
skel'
               bench_uprobe__teardown_bpf_skel();
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/bench/uprobe.c:97:6: note: 'skel' is non-null
       if (skel) {
           ^~~~
tools/perf/bench/uprobe.c:97:2: note: Taking true branch
       if (skel) {
       ^
tools/perf/bench/uprobe.c:98:3: note: Use of memory after it is freed
               bench_uprobe_bpf__destroy(skel);
               ^                         ~~~~
1 warning generated.
```

> Thanks,
> Namhyung
>
>
> > ---
> >  tools/perf/bench/uprobe.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
> > index 914c0817fe8a..5c71fdc419dd 100644
> > --- a/tools/perf/bench/uprobe.c
> > +++ b/tools/perf/bench/uprobe.c
> > @@ -89,6 +89,7 @@ static int bench_uprobe__setup_bpf_skel(enum bench_up=
robe bench)
> >         return err;
> >  cleanup:
> >         bench_uprobe_bpf__destroy(skel);
> > +       skel =3D NULL;
> >         return err;
> >  }
> >
> > --
> > 2.42.0.609.gbb76f46606-goog
> >
