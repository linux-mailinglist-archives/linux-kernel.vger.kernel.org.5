Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46B57FF988
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjK3Shx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjK3Shv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:37:51 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E28B10F2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:37:57 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso17055e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701369475; x=1701974275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXco1RY+ISh2r9hYhXm6nxpoVtv+hMYlnAajh2Nsll0=;
        b=YMjGxcKpDEbynuBh8yfWNljj3wlXZ10SXzDhUhQxRodrPPO1BI+GwD7Of7ouisLfsz
         2esZ06f/rtxqKL2+gs1LsdPtxhVKv+onTwvIi5SysNAL9nYs9YALCWZMx3sGdiiPS0Jc
         A1hPx4Qr1nkbIzQIgazRQzF23ggAT8+BNM6CxFNsEGO22ZXcaBb8nW1y1jJEqwdo0JrU
         EUmWaBX5kp2z4qSy2ooE7V3Lr7LFbOEZe/N1Vpdaq5T3mL/5fxXpqlA00yVVQelaGAVH
         ycyz1wADRHQlvrzaqh13vl8VY6SaN+nuZ+TqObZlzGk4P5YVldS+6rSfpYmmJ8XCnpAX
         MFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701369475; x=1701974275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXco1RY+ISh2r9hYhXm6nxpoVtv+hMYlnAajh2Nsll0=;
        b=Bfizt8KUpXFDIoShGx/PuliMwtHnRYdGrqIjqvzCY2znfq+vfbYI1qFOoCRlnnvhbZ
         pgcqW6e3AiKJMWGeUmrlQQorKvTianUS2X+sSBMQqakYD1xEBStO8oMtnOnD99O13ecW
         XbWRXL4NHcF3TCabaxgseTC7GA1/M6uUU0yffMUFEnajptwmE5LXwtVCiDsfFfAWgDYm
         CTKtvDm0BM5ah7T6yj/R4hL88dDB4Mg7KCPXVRchpS+LSlDCODzc+K+ckBLSFdmvGimk
         2kwVTSC4l++8sbmdsZWg/thK735vQWsiN1MVqeV4+2wkJUD9bdvpjwJJU/L8BpWPudJ8
         m0zQ==
X-Gm-Message-State: AOJu0YwWJTi/zQpxC2Z0uwdZISE1dknaIj/pvIL50P9c/XmllBFTcvX2
        tAuUQ+6OnriL6jT2gpz0/ft+nK9i14r8F0ghYG0ezw==
X-Google-Smtp-Source: AGHT+IGanbiuBztJsruAZoXU2GoCMTZMLwl7B6oJzmVXrqiHFVZTRDjzE/pUmh/xmmwmSWkZonhhRNjkQdD1ZvPhpCo=
X-Received: by 2002:a05:600c:1e15:b0:40b:3483:8488 with SMTP id
 ay21-20020a05600c1e1500b0040b34838488mr173166wmb.3.1701369475263; Thu, 30 Nov
 2023 10:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20231128175441.721579-1-namhyung@kernel.org> <CAP-5=fWfKqgT60TFRALw8vTDQT7VFV+0+eo1rFSSH3eVrjzPmA@mail.gmail.com>
 <CAM9d7chKmDETK6Ea2wyR8L21jyHWcPHbKavarnq-JmNA-AoUnQ@mail.gmail.com>
In-Reply-To: <CAM9d7chKmDETK6Ea2wyR8L21jyHWcPHbKavarnq-JmNA-AoUnQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 30 Nov 2023 10:37:43 -0800
Message-ID: <CAP-5=fUf6R=bsfg7i8atFApJBY-=zWUBMq7inFsCPZhB+w2==Q@mail.gmail.com>
Subject: Re: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Wed, Nov 29, 2023 at 3:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Tue, Nov 28, 2023 at 11:14=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Tue, Nov 28, 2023 at 9:54=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hello,
> > >
> > > It used to have annotation_options for each command separately (for
> > > example, perf report, annotate, and top), but we can make it global a=
s
> > > they never used together (with different settings).  This would save
> > > some memory for each symbol when annotation is enabled.
> > >
> > > This code is available at 'perf/annotate-option-v1' branch in
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.g=
it
> > >
> > > Thanks,
> > > Namhyung
> >
> > Thanks for doing this and I think it is progress. I think there is a
> > common problem with having things be an option rather than say part of
> > session. Having a global variable seems unfortunate but I'm not sure
> > if in all locations we have easy access to the session.
>
> That's not the case when you deal with hist entry or TUI browser.
> I think that's the reason we have the option in the annotation.
>
>
> > The rough
> > structure with annotations as I understand it is:
> >
> > session has machines
> > a machine has dsos
> > a dso has symbols
> > a symbol has an annotation
>
> That's true.  But the annotation struct is used only if
> symbol__annotation_init() is called.

Right. I find this approach likely to lead to errors, such as a symbol
created globally before symbol__annotation_init() was called breaking
the container_of assumptions.

> >
> > Annotation is something of unfortunate abstraction as it covers things
> > like an IPC per symbol (why hard code to just IPC?) and things like
> > source files and line numbers.
>
> Right, that's why I splitted the struct annotated_branch.
>
> >
> > A recent success story where we got rid of a configuration variable
> > was by switching to lazy allocation with sorting by name for symbols
> > within a dso. If we could have a lazy allocation model with
> > annotations then maybe we can do away with large hammers like global
> > options.
>
> Maybe I can move the pointer to option into the annotated_source
> which is allocated lazily.  But I don't think it needs to keep the option
> for each symbol or annotation.  It's usually to control some display
> behaviors in the disasm output globally.  So I think it's better to have
> a global variable.

Sgtm. My point wasn't to criticize, I think this is a good change, I
was just trying to imagine doing things in a way that could overall
reduce complexity

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> >
> > > Namhyung Kim (8):
> > >   perf annotate: Introduce global annotation_options
> > >   perf report: Convert to the global annotation_options
> > >   perf top: Convert to the global annotation_options
> > >   perf annotate: Use global annotation_options
> > >   perf ui/browser/annotate: Use global annotation_options
> > >   perf annotate: Ensure init/exit for global options
> > >   perf annotate: Remove remaining usages of local annotation options
> > >   perf annotate: Get rid of local annotation options
> > >
> > >  tools/perf/builtin-annotate.c     |  43 +++++----
> > >  tools/perf/builtin-report.c       |  37 ++++----
> > >  tools/perf/builtin-top.c          |  45 +++++-----
> > >  tools/perf/ui/browsers/annotate.c |  85 ++++++++----------
> > >  tools/perf/ui/browsers/hists.c    |  34 +++----
> > >  tools/perf/ui/browsers/hists.h    |   2 -
> > >  tools/perf/util/annotate.c        | 142 +++++++++++++++-------------=
--
> > >  tools/perf/util/annotate.h        |  38 ++++----
> > >  tools/perf/util/block-info.c      |   6 +-
> > >  tools/perf/util/block-info.h      |   3 +-
> > >  tools/perf/util/hist.h            |  25 ++----
> > >  tools/perf/util/top.h             |   1 -
> > >  12 files changed, 206 insertions(+), 255 deletions(-)
> > >
> > >
> > > base-commit: 757489991f7c08603395b85037a981c31719c92c
> > > --
> > > 2.43.0.rc1.413.gea7ed67945-goog
> > >
