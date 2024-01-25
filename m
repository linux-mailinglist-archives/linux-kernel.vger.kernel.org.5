Return-Path: <linux-kernel+bounces-39335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E18283CEE1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA1828CC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3888F13AA2E;
	Thu, 25 Jan 2024 21:49:42 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926313A25B;
	Thu, 25 Jan 2024 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219381; cv=none; b=kUxAOYrbLtkrdKogj2nunHDJIvt0559EMhMzGGtAA7NwZs0RcKrsA+rNzZGxym5jGdKc7kLx4jSnSiFLlUo1ZrYwo+Dtzve3q9qtqCTeKCMd4q8LyPH29dmim+ZEnKx0Amc3dPU5WJflpSnoIp7igFJ6x8ImslrPJKneNqqBPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219381; c=relaxed/simple;
	bh=MMjf2ofp4c0gmkfMrYD6MSVsXBOJnOQNn7LPVL+tfDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSKNwjWyOAHdk/5hEzaTy98ms8er2EGCsORtx4B9kyr+Z8R4PMTcTLCo3YturkyYWmAc+80FSAj0dL8k3l6csBnMzyO+aM7ykx/T3HCmQrGX/7gH4T5wMp6F10aN0lHV01GlgT+CFkSqIOrzHD7IMPxl+Udzjf0i3VbrYx/E2UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5c66b093b86so849178a12.0;
        Thu, 25 Jan 2024 13:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706219379; x=1706824179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cccVm7XrN1h2Yicjajyi1+QCCXmAg3SK/QJccGsNEg8=;
        b=qwo/PVxB6u32OgCV4LXizPkiyMizkdZ0HnicxNbaAIksMDI/sYAB04tbxccstbvo7J
         TCioL9lZAFaLF38ZtKNd7epI8JGZam7Dp5bdMIOaN2fTAVWrJ4aEa7eIBdqKzlmQUudM
         DY8z93/q+McTGN66lTW0NJUgd41ndBzNZQQfSxGTKgXIwdjlg65E93osrtA0+w73ncmw
         hKzASn42g3360WCtOnDDndFk8dGApoqHvQdP4omcF7323+EfbixbkKWcoV133TRugqB9
         KieW6PyRrDzuuLlkXcGQ2hf0fnjJloaJjIoynLfExmxt9HImzVXNUk/zh/hi5fhh1bC7
         rUFA==
X-Gm-Message-State: AOJu0YxOPsaH/aV7fst+ypiVkoI0FMn2PjZPQ8PC46pDO2Tb1a4IDIJS
	VlXKQYgC/KxFaspDmF6/KL+TIx1iZR84lxQTp+JdRw3CYvwDT8ID6RYfVkGotfDL7D5V0UgouLy
	awDa1Gk3sgqX+26EYgIC3wpWDQnk=
X-Google-Smtp-Source: AGHT+IEfrTcvaOnxrVtBc3PIKPHHF4RS+XoCW3aoBL7ZfTa+wCUcGJb62cdpc7kij1YakHfLXaJut2rJn6YeJI+RNS0=
X-Received: by 2002:a05:6a21:3390:b0:19c:6dc5:b29f with SMTP id
 yy16-20020a056a21339000b0019c6dc5b29fmr238566pzb.12.1706219379359; Thu, 25
 Jan 2024 13:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125055124.1579617-1-namhyung@kernel.org> <ZbJ0DyIx9bW-7HjM@kernel.org>
In-Reply-To: <ZbJ0DyIx9bW-7HjM@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 25 Jan 2024 13:49:28 -0800
Message-ID: <CAM9d7cjPZRsocHkv7rz2scvCbK8kT6VzfcACOxErxSes6nV9FA@mail.gmail.com>
Subject: Re: [PATCH RESEND] perf tools: Add -H short option for --hierarchy
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Thu, Jan 25, 2024 at 6:45=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Jan 24, 2024 at 09:51:24PM -0800, Namhyung Kim escreveu:
> > I found the hierarchy mode useful, but it's easy to make a typo when
> > using it.  Let's add a short option for that.
>
> Fair enough, but:
>
> [root@quaco ~]# perf report --hi + head -15
>  Error: Ambiguous option: hi (could be --hide-unresolved or --hierarchy)
>
>  Usage: perf report [<options>]
>
>     -U, --hide-unresolved
>                           Only display entries resolved to a symbol
>         --hierarchy       Show entries in a hierarchy
>         [root@quaco ~]# perf report --hie | head -15
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 56  of event 'cycles:P'
> # Event count (approx.): 13456952
> #
> #       Overhead  Command / Shared Object / Symbol
> # ..............  ........................................
> #
>     72.56%        swapper
>        72.56%        [kernel.kallsyms]
>           72.56%        [k] intel_idle_ibrs
>     18.53%        perf
> [root@quaco ~]#
>
> > Also update the documentation. :)
>
> Thanks, as a suggestion maybe we should have a:
>
>   $ perf config ui.hierarchy
>
> as we have:
>
> [root@quaco ~]# perf config ui.show-headers=3Dtrue
> [root@quaco ~]# perf config ui.show-headers
> ui.show-headers=3Dtrue
> [root@quaco ~]#

Yep, I'll think about the config option later.  Right now it
cannot work with children mode which can be enabled
by a config as well.

>
>
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks,
Namhyung

>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-report.txt | 29 ++++++++++++++++++++-
> >  tools/perf/Documentation/perf-top.txt    | 32 +++++++++++++++++++++++-
> >  tools/perf/builtin-report.c              |  2 +-
> >  tools/perf/builtin-top.c                 |  2 +-
> >  4 files changed, 61 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Docu=
mentation/perf-report.txt
> > index 38f59ac064f7..d8b863e01fe0 100644
> > --- a/tools/perf/Documentation/perf-report.txt
> > +++ b/tools/perf/Documentation/perf-report.txt
> > @@ -531,8 +531,35 @@ include::itrace.txt[]
> >  --raw-trace::
> >       When displaying traceevent output, do not use print fmt or plugin=
s.
> >
> > +-H::
> >  --hierarchy::
> > -     Enable hierarchical output.
> > +     Enable hierarchical output.  In the hierarchy mode, each sort key=
 groups
> > +     samples based on the criteria and then sub-divide it using the lo=
wer
> > +     level sort key.
> > +
> > +     For example:
> > +     In normal output:
> > +
> > +       perf report -s dso,sym
> > +       # Overhead  Shared Object      Symbol
> > +           50.00%  [kernel.kallsyms]  [k] kfunc1
> > +           20.00%  perf               [.] foo
> > +           15.00%  [kernel.kallsyms]  [k] kfunc2
> > +           10.00%  perf               [.] bar
> > +            5.00%  libc.so            [.] libcall
> > +
> > +     In hierarchy output:
> > +
> > +       perf report -s dso,sym --hierarchy
> > +       #   Overhead  Shared Object / Symbol
> > +           65.00%    [kernel.kallsyms]
> > +             50.00%    [k] kfunc1
> > +             15.00%    [k] kfunc2
> > +           30.00%    perf
> > +             20.00%    [.] foo
> > +             10.00%    [.] bar
> > +            5.00%    libc.so
> > +              5.00%    [.] libcall
> >
> >  --inline::
> >       If a callgraph address belongs to an inlined function, the inline=
 stack
> > diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documen=
tation/perf-top.txt
> > index 3c202ec080ba..a754875fa5bb 100644
> > --- a/tools/perf/Documentation/perf-top.txt
> > +++ b/tools/perf/Documentation/perf-top.txt
> > @@ -261,8 +261,38 @@ Default is to monitor all CPUS.
> >  --raw-trace::
> >       When displaying traceevent output, do not use print fmt or plugin=
s.
> >
> > +-H::
> >  --hierarchy::
> > -     Enable hierarchy output.
> > +     Enable hierarchical output.  In the hierarchy mode, each sort key=
 groups
> > +     samples based on the criteria and then sub-divide it using the lo=
wer
> > +     level sort key.
> > +
> > +     For example, in normal output:
> > +
> > +       perf report -s dso,sym
> > +       #
> > +       # Overhead  Shared Object      Symbol
> > +       # ........  .................  ...........
> > +           50.00%  [kernel.kallsyms]  [k] kfunc1
> > +           20.00%  perf               [.] foo
> > +           15.00%  [kernel.kallsyms]  [k] kfunc2
> > +           10.00%  perf               [.] bar
> > +            5.00%  libc.so            [.] libcall
> > +
> > +     In hierarchy output:
> > +
> > +       perf report -s dso,sym --hierarchy
> > +       #
> > +       #   Overhead  Shared Object / Symbol
> > +       # ..........  ......................
> > +           65.00%    [kernel.kallsyms]
> > +             50.00%    [k] kfunc1
> > +             15.00%    [k] kfunc2
> > +           30.00%    perf
> > +             20.00%    [.] foo
> > +             10.00%    [.] bar
> > +            5.00%    libc.so
> > +              5.00%    [.] libcall
> >
> >  --overwrite::
> >       Enable this to use just the most recent records, which helps in h=
igh core count
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index f2ed2b7e80a3..ccb91fe6b876 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -1410,7 +1410,7 @@ int cmd_report(int argc, const char **argv)
> >                   "only show processor socket that match with this filt=
er"),
> >       OPT_BOOLEAN(0, "raw-trace", &symbol_conf.raw_trace,
> >                   "Show raw trace event output (do not use print fmt or=
 plugins)"),
> > -     OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
> > +     OPT_BOOLEAN('H', "hierarchy", &symbol_conf.report_hierarchy,
> >                   "Show entries in a hierarchy"),
> >       OPT_CALLBACK_DEFAULT(0, "stdio-color", NULL, "mode",
> >                            "'always' (default), 'never' or 'auto' only =
applicable to --stdio mode",
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index baf1ab083436..03cf45088fd8 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1573,7 +1573,7 @@ int cmd_top(int argc, const char **argv)
> >                   "add last branch records to call history"),
> >       OPT_BOOLEAN(0, "raw-trace", &symbol_conf.raw_trace,
> >                   "Show raw trace event output (do not use print fmt or=
 plugins)"),
> > -     OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
> > +     OPT_BOOLEAN('H', "hierarchy", &symbol_conf.report_hierarchy,
> >                   "Show entries in a hierarchy"),
> >       OPT_BOOLEAN(0, "overwrite", &top.record_opts.overwrite,
> >                   "Use a backward ring buffer, default: no"),
> > --
> > 2.43.0.429.g432eaa2c6b-goog
> >
>
> --
>
> - Arnaldo

