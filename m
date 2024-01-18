Return-Path: <linux-kernel+bounces-30643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86EF832269
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98457286580
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9793C1EB53;
	Thu, 18 Jan 2024 23:53:47 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEA51E526;
	Thu, 18 Jan 2024 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705622027; cv=none; b=rJIDKUjPPvFutK79ZFPA5hzg8DaouUZYgbsHZFsVZwJqTF5isw3fvfJQIYaXVSpvrYR1DwUDrEeZjKRsFbm9PxTK4uzp02iah40zq2QRSSfpJTCaJFoUtGYjdQ02BgYRAXfdgqnC1ye/hUlA70q6amwW+Nq3Cs888jhaoQ+8xos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705622027; c=relaxed/simple;
	bh=dH+2l6OwauixQhf/uwUFeKx76qVVyik+j5oHs1cwawU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jc8QTd9CGSBcI+6IybCjHqOUwNqfo9FbGAMbuI5y1rV0VCaDW0ZdHAiG1uvtMe9+HDBN6oQ+RtFKky/+0dRrOpIpyUYjzUTUFUdZoKQ6U99hQpmj/rScnFOmQB6nFERtQxBaG96ZfM2og5Z8VRfoGOWayIACtHx8+0KU5ePu5z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso191795a12.1;
        Thu, 18 Jan 2024 15:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705622025; x=1706226825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TigLBHq4V1Dou2wp+gkiDBZsxhJ6NyZ5H+xB6Pl9Xk=;
        b=WavdqrMHWZ/yBXBZ/r7uiDm/hhSmUscPIB8tcjwXQLPuE7AVi9mn+vjFCkBWmSVvV2
         4i6NcFG2IBG9qz9nyBMj6BICZGLHDObUsXy1kBk+au1hkJ5+RpIny/3+mxZdDXOqQjwV
         Pb0G7x7FF+l9btU1KLCL/KCj4GfeBVtunArSPy7sYeHCwSgpucvz6DllaRX1zdiKwgUB
         JT50Q/nWEcnIGwyXe7/KwNjRPWe8REyayK7+V/bGj0rElbeyK/bXflE/XEi9qc6reEH9
         +ZNPnf/XvFJwwp82+9CoN+ZihLrPzGSijoXafcrFQiwX5fYoenWBX3I4RCqphF2T1P45
         jVQw==
X-Gm-Message-State: AOJu0YxYocYxRdv/krEUdo6UvR0KYnesYagtOelCoEiN/iSSyS5GVoZQ
	vvkXW4IKyWkWDy9vS04JawBY6q9Mq0mIAn9O4DKHanIHJ5QsiIbKrrEoRNm4ODwCPoZY0J0kVGq
	+1w9XwTIu/8ooqm3QANrQ7t55A5c=
X-Google-Smtp-Source: AGHT+IEL+9LZ8TYQE2d3v5cAzTvGVvCEUo32mobRsUQu5IHKOWvBtVLegf9dRboJuB5njgo9OW+H+CfgMIXdnTtOd28=
X-Received: by 2002:a17:90a:16d0:b0:28c:bb53:aa83 with SMTP id
 y16-20020a17090a16d000b0028cbb53aa83mr1485461pje.15.1705622025092; Thu, 18
 Jan 2024 15:53:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115072306.303993-1-zegao@tencent.com> <CAM9d7cgXKaKTnfx9YJae2qqv0pXtWLVQPBN=2H0WZkenBjHFnQ@mail.gmail.com>
 <CAD8CoPA6xBT9hbGZoviyyQm1bwn2Oh=v8QCMjxkMMOSN2zfC-A@mail.gmail.com> <CAD8CoPA0YgVHVW1Ya1O0-vhmpCbiw2h3i29ayzKmg4YTu-zeKQ@mail.gmail.com>
In-Reply-To: <CAD8CoPA0YgVHVW1Ya1O0-vhmpCbiw2h3i29ayzKmg4YTu-zeKQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 18 Jan 2024 15:53:34 -0800
Message-ID: <CAM9d7ciiKeVJzCjNyJp8hDsMe2ZiVyOKT3ses_SQMfdEQnWiog@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf sched: Fix task state report
To: Ze Gao <zegao2021@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 7:15=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wrote:
>
> On Thu, Jan 18, 2024 at 11:00=E2=80=AFAM Ze Gao <zegao2021@gmail.com> wro=
te:
> >
> > On Wed, Jan 17, 2024 at 9:35=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hello,
> > >
> > > On Sun, Jan 14, 2024 at 11:23=E2=80=AFPM Ze Gao <zegao2021@gmail.com>=
 wrote:
> > > >
> > > > Hi,
> > > >
> > > > The problems of task state report in both libtraceevent
> > > > and perf sched has been reported in [1]. In short, they
> > > > parsed the wrong state due to relying on the outdated
> > > > hardcoded state string to interpret the raw bitmask
> > > > from the record, which left the messes to maintain the
> > > > backward compatibilities for both tools.
> > > >
> > > > [1] has not managed to make itself into the kernel, the
> > > > problems and the solutions are well studied though.
> > > >
> > > > Luckily, as suggested by Steven, perf/libtraceevent
> > > > records the print format, especially the __print_flags()
> > > > part of the in-kernel tracepoint sched_switch in its
> > > > metadata, and we have a chance to build the state str
> > > > on the fly by parsing it.
> > > >
> > > > Now that libtraceevent has landed this solution in [2],
> > > > we now apply the same idea to perf as well.
> > >
> > > Thanks for your work.  But perf links libtraceevent
> > > conditionally so you need to make sure if it works without
> > > that too.
> >
> > Yes, I've tested with NO_LIBTRACEEVENT=3D1, and it turns
> > out perf removes perf sched subcmd without libtraceevent,
>
> FWIW,  commit 378ef0f5d9d7f4 ("perf build: Use libtraceevent
> from the system") has proved this as well.

Right, but I think we can enable perf sched without libtraceevent
for minimal features like record only.  But that doesn't belong to
this change set.

>
> > which explains why the compiler does not complain no
> > evsel__intval() defined when !HAVE_LIBTRACEEVENT
> > given the fact so many references of evsel__intval() in
> > builtin-sched.c.
> > Here evsel__taskstate() uses the exact assumption as
> > evsel__intval(), so I put it next to it for clarity and it works
> > without a doubt.
> >
> > > I think all libtraceevent related stuff should be in the
> > > util/trace-event.c which is included only if the library is
> > > available.  Maybe util/trace-event-parse.c is a better
> > > place but then you need to tweak the python-ext-sources
> > > and Makefile.perf for the case it's not available.
> >
> > Thanks for pointing this out. I will do the hack if you insist
> > on this move :D. But I think the current version is clear
> > enough, otherwise we need to move all the parts guarded
> > by #ifdef HAVE_LIBTRACEEVENT out for complete decoupling.
> > What do you think of it?

Oh, I realized that all the affected codes are under the #ifdef
properly then maybe it's ok for now.  But I prefer moving the
code if you're ok.  Maybe I can accept this code as is and you
can work on the refactoring later.  Does that work for you?

Thanks,
Namhyung

