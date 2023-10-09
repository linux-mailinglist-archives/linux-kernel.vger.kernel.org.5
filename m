Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0427BE672
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377211AbjJIQdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376996AbjJIQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:33:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F9599
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:33:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50348c54439so7214e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696869224; x=1697474024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgAUhHJmbAWVKMj/qj7uBpSpsL5yIQNcIBFI1M3KUrE=;
        b=UYHqckFZjMRtNKJc9ZHT+a9mD9KooKG2TR+i3KjqXu6ent+qp2MQFs2toi5zQigWMz
         z+ENkt0r0w4pbxkUyZdzSR09ESntGcyYuM1y1aoI3rg0nZgQO0MWX8mHPMp3yuhzPIUX
         tzGxXgP4cXYLgiq2H1unVbupMm84Ih3cLBKjo7tvKyVZ+2xyj1SyIe+cFgHQ6i7/x6jK
         zsT+cXdifKsTAS3hssZJ6YWzjdGaZKx2vAfeTsMJPWWquWOiWMVK1OpI+iSf971SZz6d
         G3+JiH0YTxmmCWfwZbPosjpia6PeOgry6R6PkqYKn74KXKm4fw5siJGdpwPpRDaIwqgW
         gEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869224; x=1697474024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgAUhHJmbAWVKMj/qj7uBpSpsL5yIQNcIBFI1M3KUrE=;
        b=gbFsZQxxESFePVufOLTsL9RGJTrZYUmW5oqIDAKc2HMmduMYVpv/ZKA96YwEHbMtaw
         DdiptYD57SMwiMKzsPY1cpXDRoXALSvVPXqvahlwnzonbD/BTQFCsSrYJolLwRgc0Q0S
         +ImdXotRh4xsQ0BPcVtHt8AxGL8XZIOR5xXJPXgV7Xx+kjN6PkaOGxX3zY+f+JTFBa1X
         Y12xd7/kLIYoLOLKCixEO/MlulpU7KeLFIU5FWJd2vvOJMTrekNz+dE4uO7yWOWVATs8
         Jon5vv34ZWAM03JNpbJOJMidw7DdV20/2M/DxI27seOUXbFIpYv7Bh0ko5VJ5qY9KRk4
         XbrA==
X-Gm-Message-State: AOJu0YzVCBnK2S1ihXTuIMak5H7Z2oXFiKlywSqMNgUeZ3inQfwTrw0W
        j4qHtXLdyrXoyoatBvTen7Lf+j3vJr7NDG2o7IlzGQ==
X-Google-Smtp-Source: AGHT+IGXiscr4EwxJpJQCI+XewTXiBNpPjwzDfqPDNFwxJs+1vHuH0y0A/ysZtYnjJFzd+aiIxPaVy3GoJQMOtBy2aw=
X-Received: by 2002:ac2:44db:0:b0:505:7c88:9e45 with SMTP id
 d27-20020ac244db000000b005057c889e45mr230791lfm.0.1696869223703; Mon, 09 Oct
 2023 09:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-8-irogers@google.com>
 <CAM9d7cjcJKjUnpYEjGap=d1fuukpsDyWCOk2_UKrepXmagceZA@mail.gmail.com>
In-Reply-To: <CAM9d7cjcJKjUnpYEjGap=d1fuukpsDyWCOk2_UKrepXmagceZA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 Oct 2023 09:33:32 -0700
Message-ID: <CAP-5=fX1f022Z052mOxgJODg_jOPCqHScjZam2_3YwUXqriO4A@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] perf env: Remove unnecessary NULL tests
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 11:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 5, 2023 at 4:09=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > clang-tidy was warning:
> > ```
> > util/env.c:334:23: warning: Access to field 'nr_pmu_mappings' results i=
n a dereference of a null pointer (loaded from variable 'env') [clang-analy=
zer-core.NullDereference]
> >         env->nr_pmu_mappings =3D pmu_num;
> > ```
> >
> > As functions are called potentially when !env was true. This condition
> > could never be true as it would produce a segv, so remove the
> > unnecessary NULL tests and silence clang-tidy.
>
> IIRC !env was to handle live sessions like perf top
> or when it doesn't have a perf data file.  Anyway,
> it doesn't seem to work anymore.

I trust the analyzer here and it would be better to crash earlier,
from env being NULL, than in a particular conditional branch. Like
you, I wasn't able to find a failure from removing the checks.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/env.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index a164164001fb..44140b7f596a 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -457,7 +457,7 @@ const char *perf_env__cpuid(struct perf_env *env)
> >  {
> >         int status;
> >
> > -       if (!env || !env->cpuid) { /* Assume local operation */
> > +       if (!env->cpuid) { /* Assume local operation */
> >                 status =3D perf_env__read_cpuid(env);
> >                 if (status)
> >                         return NULL;
> > @@ -470,7 +470,7 @@ int perf_env__nr_pmu_mappings(struct perf_env *env)
> >  {
> >         int status;
> >
> > -       if (!env || !env->nr_pmu_mappings) { /* Assume local operation =
*/
> > +       if (!env->nr_pmu_mappings) { /* Assume local operation */
> >                 status =3D perf_env__read_pmu_mappings(env);
> >                 if (status)
> >                         return 0;
> > @@ -483,7 +483,7 @@ const char *perf_env__pmu_mappings(struct perf_env =
*env)
> >  {
> >         int status;
> >
> > -       if (!env || !env->pmu_mappings) { /* Assume local operation */
> > +       if (!env->pmu_mappings) { /* Assume local operation */
> >                 status =3D perf_env__read_pmu_mappings(env);
> >                 if (status)
> >                         return NULL;
> > --
> > 2.42.0.609.gbb76f46606-goog
> >
