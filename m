Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DAE7FE45D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjK2X4o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 18:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2X4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:56:43 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684B110C2;
        Wed, 29 Nov 2023 15:56:49 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28613d87c4cso398494a91.3;
        Wed, 29 Nov 2023 15:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701302209; x=1701907009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyQl4Vy/rEx3cdSpEiRXOw3IV56Abu0Xky4Rbxj2uHw=;
        b=VsOMszPlF/a39vu0arMliKClNCPkj8EaEgUrDNrgdLUSemSYx1B+G+6Bva4FAiHeS+
         0kKWYqJDEfjtIGh0057No4GSYw0Ny9Mfq1K03wjPIBi8XoXbDS8Tr+5WD7M+1WzLHouw
         JIznvx41Rw5nuutQsv3i6s44ilU9Uvtf8tRstPSaDhzO17WeL/+v/tlGkIrEgd88T3q2
         4+/DFQPU0tevIEh/MXxY83/hCvGB0Lyf+7eIV1c/LlBAYzd3YZ/yRnTDHhge1Ep973Je
         LLkGCP/BgHhPe3VRiaKUz7SANKPl4NN05NmQT+g/x6BjwXYmUB7ZmBYNdQIgRoyQw/sd
         +D7w==
X-Gm-Message-State: AOJu0YyZUdm3l5ZcNZi2HxztIKv3Tpj4OyfZrl6XZ5SzdKw64l7CNRzt
        VfbQ/Yjr3Zm2xVKrrrbhsrnTxMIxPtKTcm8s9Qk=
X-Google-Smtp-Source: AGHT+IHDfzxX1rS5SziiRbb7Ev377hzw2KeazGnVixPVbRxHPgBzKCjzHnxqN2V1TD3i9FlP2mIwuiIlI5mSyuUhpa4=
X-Received: by 2002:a17:90b:2b50:b0:285:9e58:1bac with SMTP id
 rr16-20020a17090b2b5000b002859e581bacmr19346035pjb.27.1701302208691; Wed, 29
 Nov 2023 15:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20231128175441.721579-1-namhyung@kernel.org> <CAP-5=fWfKqgT60TFRALw8vTDQT7VFV+0+eo1rFSSH3eVrjzPmA@mail.gmail.com>
In-Reply-To: <CAP-5=fWfKqgT60TFRALw8vTDQT7VFV+0+eo1rFSSH3eVrjzPmA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Nov 2023 15:56:37 -0800
Message-ID: <CAM9d7chKmDETK6Ea2wyR8L21jyHWcPHbKavarnq-JmNA-AoUnQ@mail.gmail.com>
Subject: Re: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Tue, Nov 28, 2023 at 11:14 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Nov 28, 2023 at 9:54 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > It used to have annotation_options for each command separately (for
> > example, perf report, annotate, and top), but we can make it global as
> > they never used together (with different settings).  This would save
> > some memory for each symbol when annotation is enabled.
> >
> > This code is available at 'perf/annotate-option-v1' branch in
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> >
> > Thanks,
> > Namhyung
>
> Thanks for doing this and I think it is progress. I think there is a
> common problem with having things be an option rather than say part of
> session. Having a global variable seems unfortunate but I'm not sure
> if in all locations we have easy access to the session.

That's not the case when you deal with hist entry or TUI browser.
I think that's the reason we have the option in the annotation.


> The rough
> structure with annotations as I understand it is:
>
> session has machines
> a machine has dsos
> a dso has symbols
> a symbol has an annotation

That's true.  But the annotation struct is used only if
symbol__annotation_init() is called.

>
> Annotation is something of unfortunate abstraction as it covers things
> like an IPC per symbol (why hard code to just IPC?) and things like
> source files and line numbers.

Right, that's why I splitted the struct annotated_branch.

>
> A recent success story where we got rid of a configuration variable
> was by switching to lazy allocation with sorting by name for symbols
> within a dso. If we could have a lazy allocation model with
> annotations then maybe we can do away with large hammers like global
> options.

Maybe I can move the pointer to option into the annotated_source
which is allocated lazily.  But I don't think it needs to keep the option
for each symbol or annotation.  It's usually to control some display
behaviors in the disasm output globally.  So I think it's better to have
a global variable.

Thanks,
Namhyung

>
>
> > Namhyung Kim (8):
> >   perf annotate: Introduce global annotation_options
> >   perf report: Convert to the global annotation_options
> >   perf top: Convert to the global annotation_options
> >   perf annotate: Use global annotation_options
> >   perf ui/browser/annotate: Use global annotation_options
> >   perf annotate: Ensure init/exit for global options
> >   perf annotate: Remove remaining usages of local annotation options
> >   perf annotate: Get rid of local annotation options
> >
> >  tools/perf/builtin-annotate.c     |  43 +++++----
> >  tools/perf/builtin-report.c       |  37 ++++----
> >  tools/perf/builtin-top.c          |  45 +++++-----
> >  tools/perf/ui/browsers/annotate.c |  85 ++++++++----------
> >  tools/perf/ui/browsers/hists.c    |  34 +++----
> >  tools/perf/ui/browsers/hists.h    |   2 -
> >  tools/perf/util/annotate.c        | 142 +++++++++++++++---------------
> >  tools/perf/util/annotate.h        |  38 ++++----
> >  tools/perf/util/block-info.c      |   6 +-
> >  tools/perf/util/block-info.h      |   3 +-
> >  tools/perf/util/hist.h            |  25 ++----
> >  tools/perf/util/top.h             |   1 -
> >  12 files changed, 206 insertions(+), 255 deletions(-)
> >
> >
> > base-commit: 757489991f7c08603395b85037a981c31719c92c
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >
