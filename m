Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13FF809862
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444192AbjLHBIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHBIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:08:51 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706001709
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:08:49 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54dca2a3f16so2456494a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 17:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701997728; x=1702602528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VamHLYhm2WN9bmNhjuvgJGDIjabCdh/6ajHFYfLgx48=;
        b=ejYjWszroPKefIQq2C/zoAAx6MRQ2r9FgeGnRe4IW20UY3wad7kf2YyUJgYMSvG6ep
         UAqCPY+xzvI5W8w1+TCZ1Cnt4lXP7kDh5sZtX/kR8Mg7f1EfrlSzDlr9pcAilMum1edu
         biwqYAxa8aWZQPbu09pEgpJ2MKc9m44ev24ld04BFx/G7/oXfdc3+3J5YtiVeMTLJPjb
         DmtO9v1uXM7cZThTsgQoWxmbPICfMIrt8IK3AYpLXk9eu3tb3NbtmN2MqKiBBQU+RDhf
         B9DUeBrDIPPj/sMNwHdbOM3Be2WqL16BvgqOnVA2s2rLfF1Os8HgiFKC+HJWnhK2+pTw
         VVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701997728; x=1702602528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VamHLYhm2WN9bmNhjuvgJGDIjabCdh/6ajHFYfLgx48=;
        b=nlyJy1UOTIlJv9fNwkSQaNyuL1IssQkizXijrrY8w7PGgHnvd+nMAx8LRa9ACaKAtG
         vBpAy/Xzq4UVm0PaKaOGo6lJZQLBkSyLiK5cBVXkn6AXzbh5+IN5doP7byrSRl5tLlYY
         EE180kNtkAbm+A62xcCfavQ1TZ+VNoG3YJ8A7yYZJNjJ1EwNb6lBcJGGyQc9P/hdWRuz
         9Fwiz9LE1gNJrEYOMDUn141Q3zZtRMK7oTzdWZ9s6tWJ3/hf6ISQeIiLU1VrJhrqiGyb
         cO9GDegumLhsPy6SM5Nyhgni6qRWp4vfEeN+WK4yddV2PRXjD05oPnAJMhFgzr9uCBzi
         Qe0g==
X-Gm-Message-State: AOJu0YwxZmV8JDM+iHODxnGT/1tF24GZ+XETaZiiWPZDD/gK3aFnOFWd
        ry+UOPv0YVItqXNBKbRCLcRcQiIbd906gqD9BFmxlA==
X-Google-Smtp-Source: AGHT+IFKUFLgG+i0vqmy2QpCsmJ0GjKYQVijPT5fXBQGzBPdhFPbsiYoNVD7utCVpONzjpvzfQo5fozF4NZ/wqCYbqQ=
X-Received: by 2002:a17:906:1c1:b0:9a9:f0e6:904e with SMTP id
 1-20020a17090601c100b009a9f0e6904emr90727ejj.16.1701997727789; Thu, 07 Dec
 2023 17:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20231207163458.5554-1-khuey@kylehuey.com> <20231207163458.5554-4-khuey@kylehuey.com>
 <CAEf4Bzbt1abnfj2w6Hmp2w8SqVkQiCW=SimY6ss_Jp_325QyoA@mail.gmail.com>
 <CANpmjNOLojXk64jvwD+m19B+FsR5MuBwWKv95uakq-Dp1_AGXA@mail.gmail.com> <CAP045AoeVP=n5K+0jt2ddBspif7kx4hzOdBM86CuxNGRCgx4VA@mail.gmail.com>
In-Reply-To: <CAP045AoeVP=n5K+0jt2ddBspif7kx4hzOdBM86CuxNGRCgx4VA@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Thu, 7 Dec 2023 17:08:35 -0800
Message-ID: <CAP045ArdMgodyOTs_m6-99FxrqUJzRjDth8epkaa69YQtNeSMw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftest/bpf: Test a perf bpf program that
 suppresses side effects.
To:     Marco Elver <elver@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 2:56=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
>
> On Thu, Dec 7, 2023 at 11:20=E2=80=AFAM Marco Elver <elver@google.com> wr=
ote:
> >
> > On Thu, 7 Dec 2023 at 20:12, Andrii Nakryiko <andrii.nakryiko@gmail.com=
> wrote:
> > >
> > > On Thu, Dec 7, 2023 at 8:35=E2=80=AFAM Kyle Huey <me@kylehuey.com> wr=
ote:
> > > >
> > > > The test sets a hardware breakpoint and uses a bpf program to suppr=
ess the
> > > > side effects of a perf event sample, including I/O availability sig=
nals,
> > > > SIGTRAPs, and decrementing the event counter limit, if the ip match=
es the
> > > > expected value. Then the function with the breakpoint is executed m=
ultiple
> > > > times to test that all effects behave as expected.
> > > >
> > > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > > > ---
> > > >  .../selftests/bpf/prog_tests/perf_skip.c      | 145 ++++++++++++++=
++++
> > > >  .../selftests/bpf/progs/test_perf_skip.c      |  15 ++
> > > >  2 files changed, 160 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_ski=
p.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_ski=
p.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/t=
ools/testing/selftests/bpf/prog_tests/perf_skip.c
> > > > new file mode 100644
> > > > index 000000000000..f6fa9bfd9efa
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> > > > @@ -0,0 +1,145 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +#define _GNU_SOURCE
> > > > +
> > > > +/* We need the latest siginfo from the kernel repo. */
> > > > +#include <asm/siginfo.h>
> > >
> > > selftests are built with UAPI headers' copies under tools/include, so
> > > CI did catch a real issue, I think. Try copying
> > > include/uapi/asm-generic/siginfo.h into
> > > tools/include/uapi/asm-generic/siginfo.h ?
> >
> > I believe parts of this were inspired by
> > tools/testing/selftests/perf_events/sigtrap_threads.c - getting the
> > kernel headers is allowed, as long as $(KHDR_INCLUDES) is added to
> > CFLAGS. See tools/testing/selftests/perf_events/Makefile. Not sure
> > it's appropriate for this test though, if you don't want to add
> > KHDR_INCLUDES for everything.
>
> Yes, that's right. Namhyung's commit message for 91c97b36bd69 leads me
> to believe that I should copy siginfo.h over into tools/include and
> fix the perf_events self tests too.
>
> - Kyle

That doesn't really help (though perhaps it should be done anyway so
the selftests aren't reaching into include/) because the glibc headers
still redefine a ton of stuff in asm-generic/siginfo.h.

- Kyle
