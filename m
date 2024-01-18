Return-Path: <linux-kernel+bounces-29684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C538311AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A95A1C220A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF656104;
	Thu, 18 Jan 2024 03:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRHpNnSy"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FE08F40;
	Thu, 18 Jan 2024 03:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705547745; cv=none; b=nLjNHpegCXPXFr2UiRtHirlN93qPje+aF+qPCW9PPxEBcOW0jVjWnWLNHEq4S91o9DRxW2w7VqCzRUVp4B5I85bP7J1MZ10Np7+YZGWU9IohnC651gHqaI9rGkz8iiaGVWCrROvQ4Ol3szzcFH04LAw1NvdJC5QevOgcTvZXbQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705547745; c=relaxed/simple;
	bh=ahcR17wy58ScwIXrUFs8un/n33HPyuW4frd6NNX2NPc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=UYfLOCQdxK237xJBHJN+AdThDexWkiT6uzuaKoi23sLGem3q/EkFZiINks9mRPyxzHQKWubjQe9eO0hezrORL8pYrZz0spwfjQwdyi6HcEiDJy1QIOWSP+nP6xBNvEGzwd6Br+PouUWUfipHyqvWFOOEoJ3XxgwfrDhc/pzkmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRHpNnSy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso12860164a12.0;
        Wed, 17 Jan 2024 19:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705547742; x=1706152542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcEJsJxbIc0RAjynqcDHIyz4es0oO29gIuI17GO9R1g=;
        b=PRHpNnSykpd6UBJWF4m5Ovfjm0DeBX9am3QF/cygxUT9eoQGK0p+MIPCVg2bYRID8+
         5hJxg9MsokrobeqlPUYYUfFx+i7Ed69tKoZvYDS8FZagtCXwi+Q1hKajSHFVtEQier9w
         tUJo+4I+iioqKPdTKsbJGDESOc+ehJw7g7v4+eIL2Hy7fuk9CEPWfVFaMdZlHXKmR4Ga
         eiHBZ934CMIPlFYouCe5nYoQGlHHw1OJTSXOvyf301xQPBLAdq27erKRI56WVtWupV2u
         UePUuwO419ubvMzw+of3RtxjEa0liz9DhzBdigS7xPbSdLYPQi0eqpNRgbDCg/fC8ZCD
         pEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705547742; x=1706152542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcEJsJxbIc0RAjynqcDHIyz4es0oO29gIuI17GO9R1g=;
        b=SbSFUkRQklxfTnrs2yIhs+D6o3gewSV/P5BzNTFiNEtUxBlzGj+IjrEf127UsUMw/S
         B7N6gyj+pXifI8Na2qQjLdGM1ftr0snMdLjdYarQPicexX0dZzVYBnXaa9Oh6xKHezuh
         DwoGwgNCyJ5zklZM25wlQ/WIVyD/IUqniIovOcDb3wv6SueCtCWloSuSBiQiT8jqXBMH
         F5f7K2/n4bLkxuvrGgPfoSUuCD56BGbQWnJlUKdvcZwZ4bAl694kvu5UxIlCEMmKUUvz
         bkq2LCJiE2k0m+HlyLmy1A+uIGeHq0CCTPWO9jC8ye4h/3TO1owwfK6d+shsI1SjMkIN
         SOeA==
X-Gm-Message-State: AOJu0YzyWBfQwVlIGfVT4Rla2Uwv3d7poxRMuH1XFVyImYcXc40OlY6a
	c8+N8OGCxiBSb4D1U2fNHL004mNGlN8bpoLJlZQdRjxv15/jEZKyVoNL/IaAX266O04JCY2y2xi
	KUIHM2ABkvGDpU6ISAYtnuvfGEzE=
X-Google-Smtp-Source: AGHT+IG2KpdSARt9ngCj9PJk6H/6VhsAPH2Y6QTGCgL0gC6etSkuYrAHQ8YkaG8PI+ATXyYMa1Vr3+I3AlsDzkutXU4=
X-Received: by 2002:aa7:c345:0:b0:555:e495:3540 with SMTP id
 j5-20020aa7c345000000b00555e4953540mr154855edr.73.1705547742047; Wed, 17 Jan
 2024 19:15:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115072306.303993-1-zegao@tencent.com> <CAM9d7cgXKaKTnfx9YJae2qqv0pXtWLVQPBN=2H0WZkenBjHFnQ@mail.gmail.com>
 <CAD8CoPA6xBT9hbGZoviyyQm1bwn2Oh=v8QCMjxkMMOSN2zfC-A@mail.gmail.com>
In-Reply-To: <CAD8CoPA6xBT9hbGZoviyyQm1bwn2Oh=v8QCMjxkMMOSN2zfC-A@mail.gmail.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Thu, 18 Jan 2024 11:15:31 +0800
Message-ID: <CAD8CoPA0YgVHVW1Ya1O0-vhmpCbiw2h3i29ayzKmg4YTu-zeKQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf sched: Fix task state report
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:00=E2=80=AFAM Ze Gao <zegao2021@gmail.com> wrote=
:
>
> On Wed, Jan 17, 2024 at 9:35=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hello,
> >
> > On Sun, Jan 14, 2024 at 11:23=E2=80=AFPM Ze Gao <zegao2021@gmail.com> w=
rote:
> > >
> > > Hi,
> > >
> > > The problems of task state report in both libtraceevent
> > > and perf sched has been reported in [1]. In short, they
> > > parsed the wrong state due to relying on the outdated
> > > hardcoded state string to interpret the raw bitmask
> > > from the record, which left the messes to maintain the
> > > backward compatibilities for both tools.
> > >
> > > [1] has not managed to make itself into the kernel, the
> > > problems and the solutions are well studied though.
> > >
> > > Luckily, as suggested by Steven, perf/libtraceevent
> > > records the print format, especially the __print_flags()
> > > part of the in-kernel tracepoint sched_switch in its
> > > metadata, and we have a chance to build the state str
> > > on the fly by parsing it.
> > >
> > > Now that libtraceevent has landed this solution in [2],
> > > we now apply the same idea to perf as well.
> >
> > Thanks for your work.  But perf links libtraceevent
> > conditionally so you need to make sure if it works without
> > that too.
>
> Yes, I've tested with NO_LIBTRACEEVENT=3D1, and it turns
> out perf removes perf sched subcmd without libtraceevent,

FWIW,  commit 378ef0f5d9d7f4 ("perf build: Use libtraceevent
from the system") has proved this as well.

Regards,
        -- Ze

> which explains why the compiler does not complain no
> evsel__intval() defined when !HAVE_LIBTRACEEVENT
> given the fact so many references of evsel__intval() in
> builtin-sched.c.
> Here evsel__taskstate() uses the exact assumption as
> evsel__intval(), so I put it next to it for clarity and it works
> without a doubt.
>
> > I think all libtraceevent related stuff should be in the
> > util/trace-event.c which is included only if the library is
> > available.  Maybe util/trace-event-parse.c is a better
> > place but then you need to tweak the python-ext-sources
> > and Makefile.perf for the case it's not available.
>
> Thanks for pointing this out. I will do the hack if you insist
> on this move :D. But I think the current version is clear
> enough, otherwise we need to move all the parts guarded
> by #ifdef HAVE_LIBTRACEEVENT out for complete decoupling.
> What do you think of it?
>
> Thanks,
>         -- Ze
>
> > Thanks,
> > Namhyung
> >
> > >
> > > Regards,
> > >
> > >         -- Ze
> > >
> > > [1]: https://lore.kernel.org/lkml/20230803083352.1585-1-zegao@tencent=
com/
> > > [2]: https://lore.kernel.org/linux-trace-devel/20231224140732.7d41698=
d@rorschach.local.home/
> > >
> > > Ze Gao (4):
> > >   perf sched: Sync state char array with the kernel
> > >   perf util: Add helpers to parse task state string from libtraceeven=
t
> > >   perf util: Add evsel__taskstate() to parse the task state info inst=
ead
> > >   perf sched: Commit to evsel__taskstate() to parse task state info
> > >
> > >  tools/perf/builtin-sched.c |  57 +++------------
> > >  tools/perf/util/evsel.c    | 146 +++++++++++++++++++++++++++++++++++=
++
> > >  tools/perf/util/evsel.h    |   1 +
> > >  3 files changed, 157 insertions(+), 47 deletions(-)
> > >
> > > --
> > > 2.41.0
> > >

