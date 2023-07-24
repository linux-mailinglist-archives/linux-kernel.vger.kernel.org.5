Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF046760242
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjGXW1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGXW1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:27:34 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB47E1BC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 15:27:32 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-765942d497fso443295185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 15:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690237652; x=1690842452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmJ4UktUm3I4b08JNBNEtnNvEux0EbK78Q8s0QO58jU=;
        b=bAlfJaNfqM49DHJaN+ilEqFTHpxcdiCzxldvdmGyGQ+FFGn/x35Zu1BNa4jmcuLxDT
         BR70Ybc3Z/fKvEpaE1Ye7VhUHxiKi3dnxOjQwJTQbCaa3kH30o9vdfPAbA+M+9ds2V/G
         nnsr2d9Ac7WKln1WWgRVY+6XtwRjMsLm/JLGvLhuv8AHcKn09MKt6VTRaXRAk8s/CheO
         E8HtPR0m/QUmtYfDuqmvA7hlufvZ4UdddVZ+PrFXhBbE6YIOBVdEAM5NtTipCR9zR/3p
         jXlEzyh2l/nTYnkjmwYKzo6nfpyRts33gJcxIWU9/oHB7FBOEh7Qi+BISa1s35GuwIKe
         Yi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690237652; x=1690842452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmJ4UktUm3I4b08JNBNEtnNvEux0EbK78Q8s0QO58jU=;
        b=LFwfvRGOd4qI1O84UZvwuXVS5kvOw+x4S+Bo4qrrn4UfgcgNjDoDBO9f0y94K6JQk+
         jhA8FsCOsHqyCpWKz59WbGPeURHolEiAtdu2bcXwe+vmqbBeCupNSN0GNjwvH44/7B5I
         /i84f+vQAKS5WfxKerXVnvj78GEljRLgKVYnHxCIv2oYGe8j7Q+lfvX7NuTsQlXTpcUn
         KWMhLLS+s2uWKxctoq1wZH78S3TUcJCieagwnZQtHwsQuQz7SQtxTevAoaXSQwJBJoiK
         ojqhQ8xWz+hifHoax2ThNmB/frBg2+54TQ1nPBaKOzUZXO6uTGUGA40SjCsPDWEulMYu
         zU3g==
X-Gm-Message-State: ABy/qLZMdtlASRoSXLrgwBMb2MgbWKttBlZAdZA55Ug6LbHMLPasAvz/
        FZa0lcl4aNDsmxme8odaiJJrcZYHYRPv8+qE1VLuUA==
X-Google-Smtp-Source: APBJJlECrVm2GuN7mTC2Dq191dLy/wkFF1S9HS78iZkZQBh7hVibPxOOINn7nGfNmqIm7MRcqzKxAsAUVxtL4ns4Ly8=
X-Received: by 2002:a05:620a:2493:b0:766:27c2:cec8 with SMTP id
 i19-20020a05620a249300b0076627c2cec8mr1375203qkn.16.1690237651874; Mon, 24
 Jul 2023 15:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com> <CAKwvOd=12eSPyc5ZRgm8NPMJYjj13QOxcnHtv_Y7Ws-zffyUrA@mail.gmail.com>
 <CAP-5=fVh5atUjf4sLBYi4CwxYdWJfub_0anXKTdVuJrZkC4-tQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVh5atUjf4sLBYi4CwxYdWJfub_0anXKTdVuJrZkC4-tQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jul 2023 15:27:20 -0700
Message-ID: <CAKwvOd=eZ+m4hJ23S=v-BW0BxuWk=YCW=xRLcD00iTKWBiHjVQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Perf tool LTO support
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev, maskray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 2:48=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Jul 24, 2023 at 2:15=E2=80=AFPM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, Jul 24, 2023 at 1:12=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Add a build flag, LTO=3D1, so that perf is built with the -flto
> > > flag. Address some build errors this configuration throws up.
> >
> > Hi Ian,
> > Thanks for the performance numbers. Any sense of what the build time
> > numbers might look like for building perf with LTO?
> >
> > Does `-flto=3Dthin` in clang's case make a meaningful difference of
> > `-flto`? I'd recommend that over "full LTO" `-flto` when the
> > performance difference of the result isn't too meaningful.  ThinLTO
> > should be faster to build, but I don't know that I've ever built perf,
> > so IDK what to expect.
>
> Hi Nick,
>
> I'm not sure how much the perf build will benefit from LTO to say
> whether thin is good enough or not. Things like "perf record" are
> designed to spend the majority of their time blocking on a poll system
> call. We have benchmarks at least :-)
>
> I grabbed some clang build times in an unscientific way on my loaded lapt=
op:
>
> no LTO
> real    0m48.846s
> user    3m11.452s
> sys     0m29.598s
>
> -flto=3Dthin
> real    0m55.910s
> user    4m2.342s
> sys     0m30.120s
>
> real    0m50.330s
> user    3m36.986s
> sys     0m28.519s
>
> -flto
> real    1m12.002s
> user    3m27.676s
> sys     0m30.305s
>
> real    1m5.187s
> user    3m19.348s
> sys     0m29.031s
>
> So perhaps thin LTO increases total build time by 10%, whilst full LTO
> increases it by 50%.
>
> Gathering some clang performance numbers:
>
> no LTO
> $ perf bench internals synthesize
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>  Average synthesis took: 178.694 usec (+- 0.171 usec)
>  Average num. events: 52.000 (+- 0.000)
>  Average time per event 3.436 usec
>  Average data synthesis took: 194.545 usec (+- 0.088 usec)
>  Average num. events: 277.000 (+- 0.000)
>  Average time per event 0.702 usec
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>  Average synthesis took: 175.381 usec (+- 0.105 usec)
>  Average num. events: 52.000 (+- 0.000)
>  Average time per event 3.373 usec
>  Average data synthesis took: 188.980 usec (+- 0.071 usec)
>  Average num. events: 278.000 (+- 0.000)
>  Average time per event 0.680 usec
>
> -flto=3Dthin
> $ perf bench internals synthesize
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>  Average synthesis took: 183.122 usec (+- 0.082 usec)
>  Average num. events: 52.000 (+- 0.000)
>  Average time per event 3.522 usec
>  Average data synthesis took: 196.468 usec (+- 0.102 usec)
>  Average num. events: 277.000 (+- 0.000)
>  Average time per event 0.709 usec
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>  Average synthesis took: 177.684 usec (+- 0.094 usec)
>  Average num. events: 52.000 (+- 0.000)
>  Average time per event 3.417 usec
>  Average data synthesis took: 190.079 usec (+- 0.077 usec)
>  Average num. events: 275.000 (+- 0.000)
>  Average time per event 0.691 usec
>
> -flto
> $ perf bench internals synthesize
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>  Average synthesis took: 112.599 usec (+- 0.040 usec)
>  Average num. events: 52.000 (+- 0.000)
>  Average time per event 2.165 usec
>  Average data synthesis took: 119.012 usec (+- 0.070 usec)
>  Average num. events: 278.000 (+- 0.000)
>  Average time per event 0.428 usec
> # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>  Average synthesis took: 107.606 usec (+- 0.147 usec)
>  Average num. events: 52.000 (+- 0.000)
>  Average time per event 2.069 usec
>  Average data synthesis took: 114.633 usec (+- 0.159 usec)
>  Average num. events: 279.000 (+- 0.000)
>  Average time per event 0.411 usec
>
> The performance win from thin LTO doesn't look to be there. Full LTO
> appears to be reducing event synthesis time down to 60% of what it
> was. The clang numbers are looking better than the GCC ones. I think
> from this it makes sense to use -flto.

Without any context, I'm not really sure what numbers are good vs. bad
("is larger better?").  More so I was curious if thinLTO perhaps got
most of the win without significant performance regressions. If not,
oh well, and if the slower full LTO has numbers that make sense to
other reviewers, well then *Chuck Norris thumbs up*.  Thanks for the
stats.

>
> Thanks,
> Ian
>
> > --
> > Thanks,
> > ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
