Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F217480912A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjLGTUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLGTUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:20:49 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491FC10D8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:20:55 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4b2d64a368aso619192e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 11:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701976854; x=1702581654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0eWtcC0cEcM+29fQ7DEe8bVrVzRsIkhiOsp8oEkDaY=;
        b=rvzcUIHg7wZJ+RvMeE2ejeRbC3cTv5KAPOdFW6HxPWOV7CLTrOhNeeJZukBRjD5cMC
         +wuEQhUMf4JhGwVwH5FYOJrYchfCy7Qz9CY6mpfm8cLdmNkTpQT+MB8eEDk2NKRUqWWu
         Yip8k1+XWTgSNNR76n1+suCRn7PQWK7UR32Sj0+PYSu9gKNAj7wMiGsd3RzcW79koX3J
         tj6jdZNNMCQg+e9gY66GY8Kz2ZqVT1IO42IkaF58M0ua+vclsBxNNu8EFq6lJ3bSbbfV
         gX2KqVkWWE9Ao3I1xNoh8HKce3giuEx/czRGuIPR/ZarpRrkstHpeZsjguCPCB46GVna
         BNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701976854; x=1702581654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0eWtcC0cEcM+29fQ7DEe8bVrVzRsIkhiOsp8oEkDaY=;
        b=OIxzj/MCMMcGQgVgGP52jnq4RCqwRUAki4tk3wBImdomWLfr9v0e76arGGxhzCaAia
         SVXObHoVIf94AUEQq1vCFNG5P9bYsawOD8ynXSUBFcxBqiTjtitSTv3e8hbL+7MB2bWW
         HeteOKnt+5ujyMsycv0p6/KNXvVln4lts1p8GAdVq59godp4ifwf7BBeROf39XZ3eWEw
         RDWaSH60W9K1BUQGC1gl0gpHY8JRn8I6fjQcCE40IV0Vy2AGu3JGsxVwjNjemJOli+O6
         pOmD5No2hVUCpH4kKCCXmxHTDmb0S6oAtIpacQFvxYiCxsgT7P/mr1SncyjWs4BzjWH9
         WUIg==
X-Gm-Message-State: AOJu0Yx3a4wJgH8yz8w0d2ZnHw6+LpxdJe2th399SRzzGNwARbPHcLiF
        MPm758+iw9uNNil2R6/PU/jOwxVoWS1MAv/+fkQ38Q==
X-Google-Smtp-Source: AGHT+IFu6WULcTNGRYIvZNfvwgwLiezBZ0ERdRXmVUBophvomj9TjcnmYdxmZIS2cNuz5+rjMogaW8PNinZhFrhPmv0=
X-Received: by 2002:a1f:cc81:0:b0:48d:5be:2868 with SMTP id
 c123-20020a1fcc81000000b0048d05be2868mr2990447vkg.0.1701976854172; Thu, 07
 Dec 2023 11:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20231207163458.5554-1-khuey@kylehuey.com> <20231207163458.5554-4-khuey@kylehuey.com>
 <CAEf4Bzbt1abnfj2w6Hmp2w8SqVkQiCW=SimY6ss_Jp_325QyoA@mail.gmail.com>
In-Reply-To: <CAEf4Bzbt1abnfj2w6Hmp2w8SqVkQiCW=SimY6ss_Jp_325QyoA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 7 Dec 2023 20:20:16 +0100
Message-ID: <CANpmjNOLojXk64jvwD+m19B+FsR5MuBwWKv95uakq-Dp1_AGXA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftest/bpf: Test a perf bpf program that
 suppresses side effects.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kyle Huey <me@kylehuey.com>, Kyle Huey <khuey@kylehuey.com>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
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

On Thu, 7 Dec 2023 at 20:12, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Thu, Dec 7, 2023 at 8:35=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
> >
> > The test sets a hardware breakpoint and uses a bpf program to suppress =
the
> > side effects of a perf event sample, including I/O availability signals=
,
> > SIGTRAPs, and decrementing the event counter limit, if the ip matches t=
he
> > expected value. Then the function with the breakpoint is executed multi=
ple
> > times to test that all effects behave as expected.
> >
> > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > ---
> >  .../selftests/bpf/prog_tests/perf_skip.c      | 145 ++++++++++++++++++
> >  .../selftests/bpf/progs/test_perf_skip.c      |  15 ++
> >  2 files changed, 160 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools=
/testing/selftests/bpf/prog_tests/perf_skip.c
> > new file mode 100644
> > index 000000000000..f6fa9bfd9efa
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> > @@ -0,0 +1,145 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define _GNU_SOURCE
> > +
> > +/* We need the latest siginfo from the kernel repo. */
> > +#include <asm/siginfo.h>
>
> selftests are built with UAPI headers' copies under tools/include, so
> CI did catch a real issue, I think. Try copying
> include/uapi/asm-generic/siginfo.h into
> tools/include/uapi/asm-generic/siginfo.h ?

I believe parts of this were inspired by
tools/testing/selftests/perf_events/sigtrap_threads.c - getting the
kernel headers is allowed, as long as $(KHDR_INCLUDES) is added to
CFLAGS. See tools/testing/selftests/perf_events/Makefile. Not sure
it's appropriate for this test though, if you don't want to add
KHDR_INCLUDES for everything.
