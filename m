Return-Path: <linux-kernel+bounces-29677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5612A83119D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BC91C2157E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BE76138;
	Thu, 18 Jan 2024 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhNFy0fC"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97796103;
	Thu, 18 Jan 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705546833; cv=none; b=Ag7de8UNIcnzTGyQEVqOCt0dBF5Ij2K4cMJrv5ToOAYIobpClyNlwAYsKk40/KF2p0Byll7zSlRmof5NEPEzYPzvxZFW6HsDj/NLIk7enZZLa8F7xOI5w60nCa/F/P5fCSbTmHTrVEseN24SVBJ5xWM5rlwRZjeWlMn58CKwSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705546833; c=relaxed/simple;
	bh=LVESCuDDxMkJnbV3/rZtny3ZFnghMF4aexce89WXjvk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=um4Bzim0Z5x1l4DOQxzciXJKvBkjuc8UB6SPmroL/rVc74FQyTHkZm1xkeBhLT5TBQywzSJXQJvDZ3zwgZKWg0xl5joOQ464YvzmRmplDHs/QY8Bd/za1JpHjpduzs8jRNtgPjJR2UK/4s1J/p/DXDdVb+/+h39IHcY4SyvgzgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhNFy0fC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-559d0ef3fb5so1663565a12.3;
        Wed, 17 Jan 2024 19:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705546830; x=1706151630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3tpggAW+qay+leKpt4ji/Ug6yIjOuqm8spjS9hcUjo=;
        b=JhNFy0fCuF2AU+xJMEY/BAmf3p4JAtLudS++g5HGDGlJpti5Y0GVPRS75tn0rtgPmV
         nXNefw72nLZivPfoMWgCRdsatlxE1KZCvhB2ZVZcIaP8CRh+0VScKg9JgcGRsvbPCWIe
         T5v8896dwrI6RbuXC8nYeasBCC5upLtUzJeKSEvwdqVxNXyYu169sNM6ccoGZJ8+6jwx
         xE0g9IOFhCFwNWDqUzfYUYE4gGPfXupVWAk+mvcnFB9hObSQnJoAxw6FAjirZ8Qs7kFz
         LZwXCFgoeE+vrs2yUApDywju53kT0ZfyWLcxH33CkJx8VOpbDZj86G0fx2v5W1AgACmN
         67hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705546830; x=1706151630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3tpggAW+qay+leKpt4ji/Ug6yIjOuqm8spjS9hcUjo=;
        b=bGdMjG3yaZHsbOidRIyt7a5//WECTpqu7zw/SIv+Cz5DOP7GFUAUxhTJGolFK3YYbk
         3qhaRpCgMtL/9g6BCjP/OEB3zB82OUvbKT9766fwjD+c46R4/3NOgZYWbAwZfDbArkg8
         h0b1maVdoFLSSCTg686qdIBn9H8NjpvW5wx15hw3VXc6LLpLrfeJAwXmpEbBUwu0G53T
         oWBJ5vcl42xIkox6s8HXS6KAwU91Z20wWGUtvo5bqQgwLSYlvo/JdnIizjWqWsskqZsr
         /8bn7bKEpLDorZ8ZSGlOLQPLJn5qg17Ml8dXF/BS3Bko6Pq22OOw0qlCmbXrKsdVjg6g
         veHg==
X-Gm-Message-State: AOJu0YxOyrS7mVw58ezZMGbMjl/cInifMI4kaYttFn4VhYm3F0qfCir8
	ztkkVct/78E0vbtJUuI66LzNcxjLh3TMAVtlsuFo8+HvQzWI2lwJX9NWwK3OjJXcAH1hOuS9L3V
	yUYkySScEaI0FhCC9NC04ev4a4H0=
X-Google-Smtp-Source: AGHT+IExOIl7sYKdEL0YDe7JcH6dv+9ucSRklmKirA1QT3KhLh4HWge73XLiKxdg/3wIMESiFyrM6kJxGh56ruOH8FA=
X-Received: by 2002:aa7:c345:0:b0:555:e495:3540 with SMTP id
 j5-20020aa7c345000000b00555e4953540mr145791edr.73.1705546829818; Wed, 17 Jan
 2024 19:00:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115072306.303993-1-zegao@tencent.com> <CAM9d7cgXKaKTnfx9YJae2qqv0pXtWLVQPBN=2H0WZkenBjHFnQ@mail.gmail.com>
In-Reply-To: <CAM9d7cgXKaKTnfx9YJae2qqv0pXtWLVQPBN=2H0WZkenBjHFnQ@mail.gmail.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Thu, 18 Jan 2024 11:00:18 +0800
Message-ID: <CAD8CoPA6xBT9hbGZoviyyQm1bwn2Oh=v8QCMjxkMMOSN2zfC-A@mail.gmail.com>
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

On Wed, Jan 17, 2024 at 9:35=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Sun, Jan 14, 2024 at 11:23=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wro=
te:
> >
> > Hi,
> >
> > The problems of task state report in both libtraceevent
> > and perf sched has been reported in [1]. In short, they
> > parsed the wrong state due to relying on the outdated
> > hardcoded state string to interpret the raw bitmask
> > from the record, which left the messes to maintain the
> > backward compatibilities for both tools.
> >
> > [1] has not managed to make itself into the kernel, the
> > problems and the solutions are well studied though.
> >
> > Luckily, as suggested by Steven, perf/libtraceevent
> > records the print format, especially the __print_flags()
> > part of the in-kernel tracepoint sched_switch in its
> > metadata, and we have a chance to build the state str
> > on the fly by parsing it.
> >
> > Now that libtraceevent has landed this solution in [2],
> > we now apply the same idea to perf as well.
>
> Thanks for your work.  But perf links libtraceevent
> conditionally so you need to make sure if it works without
> that too.

Yes, I've tested with NO_LIBTRACEEVENT=3D1, and it turns
out perf removes perf sched subcmd without libtraceevent,
which explains why the compiler does not complain no
evsel__intval() defined when !HAVE_LIBTRACEEVENT
given the fact so many references of evsel__intval() in
builtin-sched.c.

Here evsel__taskstate() uses the exact assumption as
evsel__intval(), so I put it next to it for clarity and it works
without a doubt.

> I think all libtraceevent related stuff should be in the
> util/trace-event.c which is included only if the library is
> available.  Maybe util/trace-event-parse.c is a better
> place but then you need to tweak the python-ext-sources
> and Makefile.perf for the case it's not available.

Thanks for pointing this out. I will do the hack if you insist
on this move :D. But I think the current version is clear
enough, otherwise we need to move all the parts guarded
by #ifdef HAVE_LIBTRACEEVENT out for complete decoupling.
What do you think of it?

Thanks,
        -- Ze

> Thanks,
> Namhyung
>
> >
> > Regards,
> >
> >         -- Ze
> >
> > [1]: https://lore.kernel.org/lkml/20230803083352.1585-1-zegao@tencent.c=
om/
> > [2]: https://lore.kernel.org/linux-trace-devel/20231224140732.7d41698d@=
rorschach.local.home/
> >
> > Ze Gao (4):
> >   perf sched: Sync state char array with the kernel
> >   perf util: Add helpers to parse task state string from libtraceevent
> >   perf util: Add evsel__taskstate() to parse the task state info instea=
d
> >   perf sched: Commit to evsel__taskstate() to parse task state info
> >
> >  tools/perf/builtin-sched.c |  57 +++------------
> >  tools/perf/util/evsel.c    | 146 +++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/evsel.h    |   1 +
> >  3 files changed, 157 insertions(+), 47 deletions(-)
> >
> > --
> > 2.41.0
> >

