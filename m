Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A6C80D474
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344737AbjLKRuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjLKRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:50:09 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6D8C7;
        Mon, 11 Dec 2023 09:50:12 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28aabe4a728so432766a91.3;
        Mon, 11 Dec 2023 09:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317011; x=1702921811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiLi/yokcTOlHvcoLGIsa/eRQZmbR3afyB1eNuF7ev0=;
        b=cOdQKG+bEEe+J4ehE0xdFOEvupK/BKS2a+CMxVRk7t+38nTEpNFLXnFLx3T61n3lNR
         tzKwRoHUD8i4Q2Man5DN9zC4cXZSgPXqGxsu1c7Za6N2oiV5L4rnZVk8YTmou1pTHnge
         UnfY9VXAF8h9LAR+SqbpEL+Oaze27ljAKMYkYnr5jjewCmoSWI5NUvZqcEyReMYt14F2
         EcoN3WYma9uDBRpxAcP456gPyoOCMjOPY+AYnN6itPW4kKWH/WTDWnrzwtr9ksVFOhGL
         9OR19qu0eEp+nKKJOsUA8gzW+z16Sk4E6yJos54HgJ/NuSOOKUa85O4CzopWH1qZVtW7
         htAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317011; x=1702921811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiLi/yokcTOlHvcoLGIsa/eRQZmbR3afyB1eNuF7ev0=;
        b=BKAMhKgFNOW5N9vsLcGNpy0090H9mcdTUzQ57wCzAF5jE9ppm8GlwavNaGNcR3YkVe
         E96wHFqPdcuybF0dJ3Zm0wyVN6Ibbwuups+KYzXcxPqJ5lGH4DZ197z9L6L6plKLDGW2
         DVYuTP1+Chdm4Bao1iUA6nCyHxYoMW0AIRCcME6v4fzz+ntXBya9cT98VcGrDxrUNk7L
         wk0BQIBoH9C6ATn8Q7kqSCJbEEoqsvHtxOIsclOPrgkhPgZ5D0BeMlmlFq+l9QChCU2W
         7TDnTlZVAqT8ns61q9sutoZiAhDY1F0ymA2djStGuLEtTcqWAquu4kek7hS1EyGScwVS
         mopQ==
X-Gm-Message-State: AOJu0YzNp4xpxEUQxrZtzcUTprD0/iGEoDRUFgAzJmYFUoPy+sSG1Mnz
        ZqRT1OAQZWGM6lNw1qobWB3hloP0k/ryPaQNzZs=
X-Google-Smtp-Source: AGHT+IGZ09V46qQ2KO7TgfHo5RcJIBY0LdSE3C3oXZPU+qn+nf/0U8vIhPjyznuLtIRWHVoYZFhRwF70ijgGPgZ23U0=
X-Received: by 2002:a17:90a:454f:b0:286:d42d:e7e with SMTP id
 r15-20020a17090a454f00b00286d42d0e7emr2099722pjm.3.1702317011374; Mon, 11 Dec
 2023 09:50:11 -0800 (PST)
MIME-Version: 1.0
References: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
 <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com>
 <CANpmjNNvGL--j-20UxqX_WjeXGiAcjfDAQpfds+Orajz0ZeBsg@mail.gmail.com>
 <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
 <CANpmjNN7Gf_aeX+Y6g0UBL-cmTGEF9zgE7hQ1VK8F+0Yeg5Rvg@mail.gmail.com>
 <20230215143306.2d563215@rorschach.local.home> <CAMn1gO4_+-0x4ibpcASy4bLeZ+7rsmjx=0AYKGVDUApUbanSrQ@mail.gmail.com>
 <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
 <20230505095805.759153de@gandalf.local.home> <n37j6cbsogluma25crzruaiq7qcslnjeoroyybsy3vw2cokpcm@mh7r3ocp24cb>
In-Reply-To: <n37j6cbsogluma25crzruaiq7qcslnjeoroyybsy3vw2cokpcm@mh7r3ocp24cb>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 11 Dec 2023 18:50:00 +0100
Message-ID: <CA+fCnZebmy-fZdNonrgLofepTPL5hU6P8R37==sygTLBSRoa+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
To:     =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Collingbourne <pcc@google.com>,
        Marco Elver <elver@google.com>, andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 5:37=E2=80=AFPM Paul Heidekr=C3=BCger
<paul.heidekrueger@tum.de> wrote:
>
> Hi all!
>
> On 05.05.2023 09:58, Steven Rostedt wrote:
> > On Mon, 1 May 2023 15:02:37 -0700
> > Peter Collingbourne <pcc@google.com> wrote:
> >
> > > > > "ftrace" is really for just the function tracing, but CONFIG_FTRA=
CE
> > > > > really should just be for the function tracing infrastructure, an=
d
> > > > > perhaps not even include trace events :-/ But at the time it was
> > > > > created, it was for all the "tracers" (this was added before trac=
e
> > > > > events).
> > > >
> > > > It would be great to see this cleaned up. I found this aspect of ho=
w
> > > > tracing works rather confusing.
> > > >
> > > > So do you think it makes sense for the KASAN tests to "select TRACI=
NG"
> > > > for now if the code depends on the trace event infrastructure?
> > >
> > > Any thoughts? It looks like someone else got tripped up by this:
> > > https://reviews.llvm.org/D144057
> >
> > Yeah, it really does need to get cleaned up, but unfortunately it's not
> > going to be a trivial change. We need to make sure it's done in a way t=
hat
> > an old .config still keeps the same things enabled with the new config
> > settings. That takes some trickery in the dependency.
> >
> > I'll add this to my todo list, hopefully it doesn't fall into the abyss
> > portion of that list :-p
> >
> > -- Steve
>
> Just adding to Peter's concern re: CONFIG_KASAN_KUNIT_TEST's dependency o=
n
> CONFIG_TRACEPOINTS.
>
> I'm having no luck running the KASan KUnit tests on arm64 with the follow=
ing
> .kunitconfig on v6.6.0:
>
>         CONFIG_KUNIT=3Dy
>         CONFIG_KUNIT_ALL_TESTS=3Dn
>         CONFIG_DEBUG_KERNEL=3Dy
>         CONFIG_KASAN=3Dy
>         CINFIG_KASAN_GENERIC=3Dy
>         CONFIG_KASAN_KUNIT_TEST=3Dy
>
> CONFIG_TRACEPOINTS, which CONFIG_KASAN_TEST relies on since the patch thi=
s
> thread is based on, isn't defined for arm64, AFAICT.
>
> If I comment out the dependency on CONFIG_TRACEPOINTS, the tests appear t=
o run,
> but KUnit isn't picking up the KASan output.
>
> If I revert the patch, the above .kunitconfig appears to work fine on arm=
64 and
> the tests pass.
>
> The above .kunitconfig works as intended on X86, no changes necessary.
>
> Am I missing something?

Hi Paul,

I've been successfully running KASAN tests with CONFIG_TRACEPOINTS
enabled on arm64 since this patch landed.

What happens when you try running the tests with .kunitconfig? Does
CONFIG_TRACEPOINTS or CONFIG_KASAN_KUNIT_TEST get disabled during
kernel building? Or tests just don't get executed?

Thanks!
