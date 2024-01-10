Return-Path: <linux-kernel+bounces-22477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E52829E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE891F22AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE2C4CB24;
	Wed, 10 Jan 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ApIamlZf"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4964BA84
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso11363a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704903091; x=1705507891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDJXHFEiJHkmo5Kt4fZcWSD9ksHrfCtUrgd+CNqE69Q=;
        b=ApIamlZfEXtITK7MA8a5y+d6MkA7DBXK7HtKGYrtrNhgj/czceyOcS4bNRuI/lzv1L
         fldGFD9sL5pibjbXr4qqRaA1EOVOROTOXklQh2oqAGKEucJypHc5UoFPno2K+fWKGD3j
         scGqUbWVggyy/PxDiV7CPWpRU/FDDhMEnzyj4ugWp9ydSTNnVwLYY4s01nbW0R9TQiOK
         fJ1ObKb2pC2weXBfChOj7nPUn3DXbZYV/7PEg2XDGi8BLpbiFRK4E4rRax8vJsgUY1CV
         P+fRMQlYtGPMgBQrEWclw9OP7qgBeR6ktNrMTx2UDlK4wE/9avCRMWDsDKUU0WGslm+N
         hC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704903091; x=1705507891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDJXHFEiJHkmo5Kt4fZcWSD9ksHrfCtUrgd+CNqE69Q=;
        b=CuVnB0aWgj6G1HVHP4J2ZzJzbcgqVZMoxjUQcqwLpfq298as4W5V/h4zJpAhCgOCUO
         AnMKsXA3GezXZtkNl/qfTjA5MK+6GCVSfm+qiG6o3duOeWugJ9Uo5moo9uZlcIDW+vRr
         DaP54GeAdX/19RvQWB4xxSfolosVFm1FURzeHiyFUPZ+PLKeubC65WiHceFqPig8z1Ea
         Skb9LAKXzPHKu1pBzRdiwIz9VujENe8tO/FiOaSEg6qVfi2TUA14qDSje8JgmW0/TzJG
         54aqSppVNR7EY5mCHgQ4+X8Nw+Zy9+49c+uNc47apAWFWDHea44g8deKztzdnLMkDbZc
         Re3Q==
X-Gm-Message-State: AOJu0Yymmpzxt/Kun9VvfchBxdxA6iOM3chB+QRp5WMpGgewHLZYD8O8
	sPIUXly9CowJMKXB2UQTjmXBQwONksZFBSnQG+AeiU7Nq28z
X-Google-Smtp-Source: AGHT+IFgin3uPDv/Ownu2lWi1XYQd92iiNIwnOVtqn/lRyeJvIpZ0IHIJdqAFpczwxFKPInMpKIC5iCK2ogtIU07qZE=
X-Received: by 2002:a50:d746:0:b0:557:3c8a:7242 with SMTP id
 i6-20020a50d746000000b005573c8a7242mr46624edj.3.1704903091100; Wed, 10 Jan
 2024 08:11:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM9d7ciuh1H2Mfx5ToYGT1fOm8E3jrQhkzg304JKDd7BhT=h5g@mail.gmail.com>
 <0354dcae23a8713f75f4fed609e0caec3c6e3cd5.1672174189.git.nabijaczleweli@nabijaczleweli.xyz>
 <ZZch2_ceYO-UI71B@kernel.org>
In-Reply-To: <ZZch2_ceYO-UI71B@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Jan 2024 08:11:19 -0800
Message-ID: <CAP-5=fUJK5FZAse3qVvAbVaNQ=qSqUsYmgxaj3eMRruv9ufEUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf tui: don't ignore job control
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	yaowenbin <yaowenbin1@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:23=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Tue, Dec 27, 2022 at 09:57:40PM +0100, Ahelenia Ziemia=C5=84ska escrev=
eu:
> > In its infinite wisdom, by default, SLang sets susp undef,
> > and this can only be un-done by calling SLtty_set_suspend_state(true).
> > After every SLang_init_tty().
> >
> > Additionally, no provisions are made for maintaining the teletype
> > attributes across suspend/continue (outside of curses emulation mode(?!=
),
> > which provides full support, naturally), so we need to save and restore
> > the flags ourselves, as well as reset the text colours when going under=
.
> > We need to also re-draw the screen, and raising SIGWINCH, shockingly,
> > Just Works.
> >
> > The correct solution would be to Not Use SLang, but as a stop-gap,
> > this makes TUI perf report usable.
>
> This was in the compost pile for a long time, but I got to it, indeed
> 'perf report' works, the refresh after returning to it, etc.
>
> 'perf top' needs some care, but we can do it later.
>
> About not using slang, perf started with newt, I moved to slang, there
> are people suggesting we move to some more modern thing, maybe
> notcurses?

Fwiw, my feeling is that doing UI stuff in C is a particular pain.
Maybe there will be a move to allow C++ in the kernel and so perf
could follow [1]. For C++ the most maintained/best text UI looks like
ftxui [2], but what I think looks best is a python library called
textual [3] that already has support for things like flamegraphs [4]
as well as having a HTML/JavaScript output/interaction option [5]. So
my feeling is that if we're rebuilding the UI we should be moving more
to python+textual than a C/C++ library that gets a fraction of the
care.

Thanks,
Ian

[1] https://www.phoronix.com/news/CPP-Linux-Kernel-2024-Discuss
[2] https://github.com/ArthurSonzogni/FTXUI
[3] https://github.com/Textualize/textual
[4] https://github.com/Textualize/textual/discussions/3390
[5] https://github.com/Textualize/textual-web

> - Arnaldo
>
> > Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.=
xyz>
> > ---
> > Yeah, somehow I didn't hit that in my tests, but it was relatively easy
> > to trigger when I tried. A full partial write retry loop is an overkill
> > here, I think, and few other places in perf actually try to resubmit
> > partial writes, so.
> >
> >  tools/perf/ui/browsers/annotate.c |  1 +
> >  tools/perf/ui/browsers/hists.c    |  2 ++
> >  tools/perf/ui/browsers/scripts.c  |  1 +
> >  tools/perf/ui/tui/setup.c         | 22 ++++++++++++++++++++++
> >  4 files changed, 26 insertions(+)
> >
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers=
/annotate.c
> > index c03fa76c02ff..6a4ffbf66c7f 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -942,6 +942,7 @@ int hist_entry__tui_annotate(struct hist_entry *he,=
 struct evsel *evsel,
> >       /* reset abort key so that it can get Ctrl-C as a key */
> >       SLang_reset_tty();
> >       SLang_init_tty(0, 0, 0);
> > +     SLtty_set_suspend_state(true);
> >
> >       return map_symbol__tui_annotate(&he->ms, evsel, hbt, opts);
> >  }
> > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hi=
sts.c
> > index b72ee6822222..2479e6d42e7c 100644
> > --- a/tools/perf/ui/browsers/hists.c
> > +++ b/tools/perf/ui/browsers/hists.c
> > @@ -3010,6 +3010,7 @@ static int evsel__hists_browse(struct evsel *evse=
l, int nr_events, const char *h
> >       /* reset abort key so that it can get Ctrl-C as a key */
> >       SLang_reset_tty();
> >       SLang_init_tty(0, 0, 0);
> > +     SLtty_set_suspend_state(true);
> >
> >       if (min_pcnt)
> >               browser->min_pcnt =3D min_pcnt;
> > @@ -3682,6 +3683,7 @@ int block_hists_tui_browse(struct block_hist *bh,=
 struct evsel *evsel,
> >       /* reset abort key so that it can get Ctrl-C as a key */
> >       SLang_reset_tty();
> >       SLang_init_tty(0, 0, 0);
> > +     SLtty_set_suspend_state(true);
> >
> >       memset(&action, 0, sizeof(action));
> >
> > diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/=
scripts.c
> > index 47d2c7a8cbe1..50d45054ed6c 100644
> > --- a/tools/perf/ui/browsers/scripts.c
> > +++ b/tools/perf/ui/browsers/scripts.c
> > @@ -166,6 +166,7 @@ void run_script(char *cmd)
> >       printf("\033[c\033[H\033[J");
> >       fflush(stdout);
> >       SLang_init_tty(0, 0, 0);
> > +     SLtty_set_suspend_state(true);
> >       SLsmg_refresh();
> >  }
> >
> > diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
> > index a3b8c397c24d..09524ba04975 100644
> > --- a/tools/perf/ui/tui/setup.c
> > +++ b/tools/perf/ui/tui/setup.c
> > @@ -2,12 +2,14 @@
> >  #include <signal.h>
> >  #include <stdbool.h>
> >  #include <stdlib.h>
> > +#include <termios.h>
> >  #include <unistd.h>
> >  #include <linux/kernel.h>
> >  #ifdef HAVE_BACKTRACE_SUPPORT
> >  #include <execinfo.h>
> >  #endif
> >
> > +#include "../../util/color.h"
> >  #include "../../util/debug.h"
> >  #include "../../perf.h"
> >  #include "../browser.h"
> > @@ -122,6 +124,23 @@ static void ui__signal(int sig)
> >       exit(0);
> >  }
> >
> > +static void ui__sigcont(int sig)
> > +{
> > +     static struct termios tty;
> > +
> > +     if (sig =3D=3D SIGTSTP) {
> > +             while (tcgetattr(SLang_TT_Read_FD, &tty) =3D=3D -1 && err=
no =3D=3D EINTR)
> > +                     ;
> > +             while (write(SLang_TT_Read_FD, PERF_COLOR_RESET, sizeof(P=
ERF_COLOR_RESET) - 1) =3D=3D -1 && errno =3D=3D EINTR)
> > +                     ;
> > +             raise(SIGSTOP);
> > +     } else {
> > +             while (tcsetattr(SLang_TT_Read_FD, TCSADRAIN, &tty) =3D=
=3D -1 && errno =3D=3D EINTR)
> > +                     ;
> > +             raise(SIGWINCH);
> > +     }
> > +}
> > +
> >  int ui__init(void)
> >  {
> >       int err;
> > @@ -136,6 +155,7 @@ int ui__init(void)
> >       err =3D SLang_init_tty(-1, 0, 0);
> >       if (err < 0)
> >               goto out;
> > +     SLtty_set_suspend_state(true);
> >
> >       err =3D SLkp_init();
> >       if (err < 0) {
> > @@ -150,6 +170,8 @@ int ui__init(void)
> >       signal(SIGINT, ui__signal);
> >       signal(SIGQUIT, ui__signal);
> >       signal(SIGTERM, ui__signal);
> > +     signal(SIGTSTP, ui__sigcont);
> > +     signal(SIGCONT, ui__sigcont);
> >
> >       perf_error__register(&perf_tui_eops);
> >
> > --
> > 2.30.2
> >
>
>
>
> --
>
> - Arnaldo
>

