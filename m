Return-Path: <linux-kernel+bounces-31610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70678330D1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BE3284ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A1D56B8E;
	Fri, 19 Jan 2024 22:45:12 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616921E48B;
	Fri, 19 Jan 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704311; cv=none; b=X+gsItp6atSRGVmZCXvTkvVaRzmwbyr0WyGGjfqRcUSf9xT3lg96+rcLhswgNfCQgaF2j4ch4nnppKC9QTcJedo09+VVIUW10lQ6q9XzE8wks2CLBvKdvq7CO3DtdP1VtKgFHPI4kZARshtoQ0YIyxC6UUxt2X2mO3y1tXEl4L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704311; c=relaxed/simple;
	bh=B4eyS5Uxf1FzUlVXRiYuTZqQEDIUf2So9oC3bSBrZRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkenmlVzvtRR4bj3VoSLamvLZEZjkiiyq4NEsOZVnayeOu8EQKbHU8+HLjpCcymeKRcpUAfB1aT8bSbnRJ6aLFpVy5kL0X/SS3BdxpuBufkxmUP2Aje/om27X/egT/6fvwK9lTQyI3QufquCcRFp5jqsxsitXvx5X9dCHkAy0+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so896796a12.1;
        Fri, 19 Jan 2024 14:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705704309; x=1706309109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XM+S4HOr/G0VSg0eLk9ynoWhmTsjbG8S0bVdIG+8rC0=;
        b=QIuSq9vFdfV2mD0eoOBb48jFUZjGrsJ+ABReliM0KE3Ge+YV0U3gvR0oCXy7mXtQtZ
         I2F0irzSnXbYC4M21cy8nXw5JKPEYaA5/1N5QPxk1n8NOnD9eK4Ph/OLx+VmdaEdeV61
         25Oj57XkoKmKjMqPsx7aiFO4jClPKpF8XHKEUXonZLq2h4UkZUQXjUeepJoEQLboHZDa
         mjpY1zJsQtHCDhAv+UJADqBMiGeB7wTRik6bxd+wA8wRkrlGJUNmTgiO/V9JNg2G/mb7
         VeNF42iDDD9paxXaLxWTVLGfluFhV/+49xDrksYmTyvBJYoGwtPS8OLq/9q0kQ458pX3
         uScw==
X-Gm-Message-State: AOJu0YzEdpW0gjhmnJWeqQWy7G+6qkENLYtGt/ytj1nM23X6PfFQ+jXj
	3dcIeLRBvqx1Fyx8nn2fFHNz5ysGp15pYY2doFbitHmzxLbDEaRnOO2B+AHEHvuspGDP++Jesxd
	DxUTmUtVYQbEw6dL5SQ8BuW/v7P0=
X-Google-Smtp-Source: AGHT+IHq/22Q93hyFLRDaaPigiAXVI9JXzlsHz0RLpj/iYHWZR+0fHBXPcUfB9JNEY1R6p26aNRjSkb/tI03mHFSElc=
X-Received: by 2002:a05:6a21:3a47:b0:199:9acc:7d7b with SMTP id
 zu7-20020a056a213a4700b001999acc7d7bmr672996pzb.112.1705704309564; Fri, 19
 Jan 2024 14:45:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115072306.303993-1-zegao@tencent.com> <CAM9d7cgXKaKTnfx9YJae2qqv0pXtWLVQPBN=2H0WZkenBjHFnQ@mail.gmail.com>
 <CAD8CoPA6xBT9hbGZoviyyQm1bwn2Oh=v8QCMjxkMMOSN2zfC-A@mail.gmail.com>
 <CAD8CoPA0YgVHVW1Ya1O0-vhmpCbiw2h3i29ayzKmg4YTu-zeKQ@mail.gmail.com>
 <CAM9d7ciiKeVJzCjNyJp8hDsMe2ZiVyOKT3ses_SQMfdEQnWiog@mail.gmail.com> <CAD8CoPCSDcB+-qvwEZGOrdi01C3W8N3dYN3XQUQ2jrpn1mSf=Q@mail.gmail.com>
In-Reply-To: <CAD8CoPCSDcB+-qvwEZGOrdi01C3W8N3dYN3XQUQ2jrpn1mSf=Q@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 19 Jan 2024 14:44:58 -0800
Message-ID: <CAM9d7cigWxAN_nmT2rO-o7YG0hkmPNjDPeLtsn=z1YqRSjMEjA@mail.gmail.com>
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

On Thu, Jan 18, 2024 at 5:54=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wrote:
>
> On Fri, Jan 19, 2024 at 7:53=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Wed, Jan 17, 2024 at 7:15=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wr=
ote:
> > >
> > > On Thu, Jan 18, 2024 at 11:00=E2=80=AFAM Ze Gao <zegao2021@gmail.com>=
 wrote:
> > > >
> > > > On Wed, Jan 17, 2024 at 9:35=E2=80=AFAM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > On Sun, Jan 14, 2024 at 11:23=E2=80=AFPM Ze Gao <zegao2021@gmail.=
com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > The problems of task state report in both libtraceevent
> > > > > > and perf sched has been reported in [1]. In short, they
> > > > > > parsed the wrong state due to relying on the outdated
> > > > > > hardcoded state string to interpret the raw bitmask
> > > > > > from the record, which left the messes to maintain the
> > > > > > backward compatibilities for both tools.
> > > > > >
> > > > > > [1] has not managed to make itself into the kernel, the
> > > > > > problems and the solutions are well studied though.
> > > > > >
> > > > > > Luckily, as suggested by Steven, perf/libtraceevent
> > > > > > records the print format, especially the __print_flags()
> > > > > > part of the in-kernel tracepoint sched_switch in its
> > > > > > metadata, and we have a chance to build the state str
> > > > > > on the fly by parsing it.
> > > > > >
> > > > > > Now that libtraceevent has landed this solution in [2],
> > > > > > we now apply the same idea to perf as well.
> > > > >
> > > > > Thanks for your work.  But perf links libtraceevent
> > > > > conditionally so you need to make sure if it works without
> > > > > that too.
> > > >
> > > > Yes, I've tested with NO_LIBTRACEEVENT=3D1, and it turns
> > > > out perf removes perf sched subcmd without libtraceevent,
> > >
> > > FWIW,  commit 378ef0f5d9d7f4 ("perf build: Use libtraceevent
> > > from the system") has proved this as well.
> >
> > Right, but I think we can enable perf sched without libtraceevent
> > for minimal features like record only.  But that doesn't belong to
> > this change set.
> >
> > >
> > > > which explains why the compiler does not complain no
> > > > evsel__intval() defined when !HAVE_LIBTRACEEVENT
> > > > given the fact so many references of evsel__intval() in
> > > > builtin-sched.c.
> > > > Here evsel__taskstate() uses the exact assumption as
> > > > evsel__intval(), so I put it next to it for clarity and it works
> > > > without a doubt.
> > > >
> > > > > I think all libtraceevent related stuff should be in the
> > > > > util/trace-event.c which is included only if the library is
> > > > > available.  Maybe util/trace-event-parse.c is a better
> > > > > place but then you need to tweak the python-ext-sources
> > > > > and Makefile.perf for the case it's not available.
> > > >
> > > > Thanks for pointing this out. I will do the hack if you insist
> > > > on this move :D. But I think the current version is clear
> > > > enough, otherwise we need to move all the parts guarded
> > > > by #ifdef HAVE_LIBTRACEEVENT out for complete decoupling.
> > > > What do you think of it?
> >
> > Oh, I realized that all the affected codes are under the #ifdef
> > properly then maybe it's ok for now.  But I prefer moving the
> > code if you're ok.  Maybe I can accept this code as is and you
>
> Sounds great!
>
> > can work on the refactoring later.  Does that work for you?
>
> Absolutely! Will send the following refactoring patches soon. :D

Thanks, but your patches don't apply cleanly.  Could you please
rebase it onto the current perf-tools-next tree?

Thanks,
Namhyung

