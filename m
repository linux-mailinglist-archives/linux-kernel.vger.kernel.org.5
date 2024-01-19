Return-Path: <linux-kernel+bounces-30697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2814083232D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927EF1F22003
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7FD1378;
	Fri, 19 Jan 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBuUmdNG"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD43ECE;
	Fri, 19 Jan 2024 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705629263; cv=none; b=Tn9b0VRX3GbG6/v2ZmAQ/vliHtGRw897CXx/VlZ9Y3mPbJtzlHpSfVpj/We8ZwGQpX0GNcz4baqTbzrcesHrO9MjIlkN3hTxnNa+MWS7R9PXj0TGlyvaHqhj8/Ns3bReIbSKJuUWjY/0tQxnp1+u31315rKDBcvQqv7Bq4y79L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705629263; c=relaxed/simple;
	bh=/K/lvSczRyq8bKp78iBHMrZfPqgHCbhVaRHOkLanmGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbX2Xv71oXXy6T9TEP9Dudq/GOpIbcI14acaifozzLK8SNPplC/4kynQsnQk4DWUY0Zm1B66D7Bc5QUwDTp8rw+4mQ8bzHKs4FrzegjWaiQdCXph8m8pRAJzGAp7zw3SdfNxckxFQHknLcaii4oZAd1GblrKwM7Lk9uDlwd1B6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBuUmdNG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5578485fc0eso216358a12.1;
        Thu, 18 Jan 2024 17:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705629260; x=1706234060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxspzzojEHKDIlBbhyo3X9dJsQNZP6Pc2Rw4ErC2p4Y=;
        b=KBuUmdNG+nSgLK+/IYmJ2tLk3yMWG8daHOP9yOh/oNehCuiaZUmNQ59uhzCGp7zsfn
         Jur0CYaax237eZqbls6qBR+wSXtHYHZdzuc0JjDEqNgnByRyPJqQrw5OfBpxnsT5qOta
         M9W9Dn+eMoTcnt/vdlTjvWHrJiEQfbKl3/Z2kixPS4Vdivo3xr/GekSwzGlnfXVNYCeN
         Abr4c8+EnFFhlz925dR4aMulFagKtbK0REW4N+DmBuV9cCMCA2NkaPnj8WjoXrhH8FT5
         OGnFu7trXrGCXrGd1vxnlvXu/DIkPfYVN2vlR3U8eZo4a+GVEGTaL9hjPF+0xJSuSDk1
         kcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705629260; x=1706234060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxspzzojEHKDIlBbhyo3X9dJsQNZP6Pc2Rw4ErC2p4Y=;
        b=PZJA8Xq+9sQfszQS4q4HRwmtiVndjlzoHB0vOEVS7w5jGZNHXKXu5KhvFEEsDNUY3I
         JjEgLX+VH5AYgoZ+irM0wak/ov5SMbS3CWx2fjY3HMn9FFJqIWJp1C+SIcY8mh11CyFP
         Ia3HGszhYZD88qlS22WVYH2kkfxEWRRMyTV3VgVTkPjrJYLr5q3EsoAAMcPxOAQB+2J+
         gG+rh4ksSHTteH3dybXIGsdR/lAArdqMaHeHfg0Z1L8VviX+cf7kRI9dX9mmQtUXRqKU
         knM/3jVJ8CWkRMYmzm8j59Dm40RxrTuumAR8S7EIkFkoSjb5l7E3mxdpPfFaT4Izouou
         jzdA==
X-Gm-Message-State: AOJu0Yx52dLMb9tC7RcMqWs2qihtYjnAzkPi+msyUT+mTxnPmEGk94Zg
	8c9pFOE8rAQiOpdVXVhwEDg/fNTir0CX9Z4CZofKrf8GrGjzkHF+5mzW8zbaRGiz0C0XeF65lRc
	7iGyvidQwOh5d0oBfdsBtv12yKYg=
X-Google-Smtp-Source: AGHT+IEqWvQFRVZrQ84fN9bZVhFCcZ1q7+4jQidbD+FIcdSFNHxdANwMBjRsTUCa3YNtivT6AwZQKmXlHRSwn0FIiQ4=
X-Received: by 2002:a05:6402:31fc:b0:559:d229:372e with SMTP id
 dy28-20020a05640231fc00b00559d229372emr1109809edb.64.1705629260031; Thu, 18
 Jan 2024 17:54:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115072306.303993-1-zegao@tencent.com> <CAM9d7cgXKaKTnfx9YJae2qqv0pXtWLVQPBN=2H0WZkenBjHFnQ@mail.gmail.com>
 <CAD8CoPA6xBT9hbGZoviyyQm1bwn2Oh=v8QCMjxkMMOSN2zfC-A@mail.gmail.com>
 <CAD8CoPA0YgVHVW1Ya1O0-vhmpCbiw2h3i29ayzKmg4YTu-zeKQ@mail.gmail.com> <CAM9d7ciiKeVJzCjNyJp8hDsMe2ZiVyOKT3ses_SQMfdEQnWiog@mail.gmail.com>
In-Reply-To: <CAM9d7ciiKeVJzCjNyJp8hDsMe2ZiVyOKT3ses_SQMfdEQnWiog@mail.gmail.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Fri, 19 Jan 2024 09:54:08 +0800
Message-ID: <CAD8CoPCSDcB+-qvwEZGOrdi01C3W8N3dYN3XQUQ2jrpn1mSf=Q@mail.gmail.com>
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

On Fri, Jan 19, 2024 at 7:53=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jan 17, 2024 at 7:15=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wrot=
e:
> >
> > On Thu, Jan 18, 2024 at 11:00=E2=80=AFAM Ze Gao <zegao2021@gmail.com> w=
rote:
> > >
> > > On Wed, Jan 17, 2024 at 9:35=E2=80=AFAM Namhyung Kim <namhyung@kernel=
org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > On Sun, Jan 14, 2024 at 11:23=E2=80=AFPM Ze Gao <zegao2021@gmail.co=
m> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > The problems of task state report in both libtraceevent
> > > > > and perf sched has been reported in [1]. In short, they
> > > > > parsed the wrong state due to relying on the outdated
> > > > > hardcoded state string to interpret the raw bitmask
> > > > > from the record, which left the messes to maintain the
> > > > > backward compatibilities for both tools.
> > > > >
> > > > > [1] has not managed to make itself into the kernel, the
> > > > > problems and the solutions are well studied though.
> > > > >
> > > > > Luckily, as suggested by Steven, perf/libtraceevent
> > > > > records the print format, especially the __print_flags()
> > > > > part of the in-kernel tracepoint sched_switch in its
> > > > > metadata, and we have a chance to build the state str
> > > > > on the fly by parsing it.
> > > > >
> > > > > Now that libtraceevent has landed this solution in [2],
> > > > > we now apply the same idea to perf as well.
> > > >
> > > > Thanks for your work.  But perf links libtraceevent
> > > > conditionally so you need to make sure if it works without
> > > > that too.
> > >
> > > Yes, I've tested with NO_LIBTRACEEVENT=3D1, and it turns
> > > out perf removes perf sched subcmd without libtraceevent,
> >
> > FWIW,  commit 378ef0f5d9d7f4 ("perf build: Use libtraceevent
> > from the system") has proved this as well.
>
> Right, but I think we can enable perf sched without libtraceevent
> for minimal features like record only.  But that doesn't belong to
> this change set.
>
> >
> > > which explains why the compiler does not complain no
> > > evsel__intval() defined when !HAVE_LIBTRACEEVENT
> > > given the fact so many references of evsel__intval() in
> > > builtin-sched.c.
> > > Here evsel__taskstate() uses the exact assumption as
> > > evsel__intval(), so I put it next to it for clarity and it works
> > > without a doubt.
> > >
> > > > I think all libtraceevent related stuff should be in the
> > > > util/trace-event.c which is included only if the library is
> > > > available.  Maybe util/trace-event-parse.c is a better
> > > > place but then you need to tweak the python-ext-sources
> > > > and Makefile.perf for the case it's not available.
> > >
> > > Thanks for pointing this out. I will do the hack if you insist
> > > on this move :D. But I think the current version is clear
> > > enough, otherwise we need to move all the parts guarded
> > > by #ifdef HAVE_LIBTRACEEVENT out for complete decoupling.
> > > What do you think of it?
>
> Oh, I realized that all the affected codes are under the #ifdef
> properly then maybe it's ok for now.  But I prefer moving the
> code if you're ok.  Maybe I can accept this code as is and you

Sounds great!

> can work on the refactoring later.  Does that work for you?

Absolutely! Will send the following refactoring patches soon. :D

Cheers,
        -- Ze

> Thanks,
> Namhyung

