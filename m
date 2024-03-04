Return-Path: <linux-kernel+bounces-91384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8413871081
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C2D1C217E8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA127C0A1;
	Mon,  4 Mar 2024 22:54:14 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE47B3FA;
	Mon,  4 Mar 2024 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592854; cv=none; b=QGhBm8gDgxuM1FjcDsSjR6j6ck6Iw9d0nxPdEHTOXXm8ORiCXMBfLceAQRN9jOFBHXDUaV8GXIykOEb4IJGF3o1EQHbhMRkWcrph6p56mNDEs5ckX5Wa2fyvXM/FpY2BH+iG72MsZN4wT6wGhDTm5bxKUSwUvmcZLbyK+NZIoh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592854; c=relaxed/simple;
	bh=gO9mH5Z0JvT/SaaCXTzhnv1+STJClW88KiE2NUjLdXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4gG2/DJmBJ/W6oDBKdNutf8HSYZe8DnlDkcZTq2j3V2GTVT1jURuCfBPvGaQVDoCwJmbO0BrEs3/Z5eQ2nURsNQTczfY583sneyC6HRCVNeamtGpPv2SYyYCtigyoEBOUnHeUGAlOif17g6VSndrZ13d96UcFs6bgk+gmnjOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29a940614easo3284091a91.3;
        Mon, 04 Mar 2024 14:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592852; x=1710197652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5CES4TSoLXwloLCxuKSrwc7XyMKCyLWgf+m5vrjXfw=;
        b=teLbTeWsMExBei0+e602Hx2HK8oLducFHLGz/wEv8LIE1M2QtYpIsqZhn9FI8Qqxk4
         BB3uhC8yqRwhCJuUoTaxBlwVNzOwo1jPY0jq2jH8A7jYvtuYr6R/QvXZzfDb0xLaIoNy
         NNCF1yOyk46wl4zlYYekJ6gUiHy63jEw7s2EDWhTKpwjJwsnoVVFvZBZnCvpssSH8DLn
         nYgayWTBd+3jAuj90XrIWpzi9K05PeEIgu5JHveIMJdHvvtz/TrjLYXsy/5D1Rj/pypq
         S2sNquCWmnK4VwFCmRWmfF47/dZPJjkySg3Ro9vjPekJc5eh588OAz/vVLUqFJ4LHzUd
         IjZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTtffb4v1Lc2PT9L65lVf8/n2H2gJRLVPEtTk2nKdgfE0qUxMB3FQrxJhf+z7FTmHAZwWVX0I8cVh1oTeGFAN0h0n6IaUeOjXWB4DxgFIk7m1WSfi5iBy8ukMhfB0J088F4h3eWrXQG4Y+qRhIZw==
X-Gm-Message-State: AOJu0YxIOiCgOUg0UFU6D0jeSWyuKcJ/qaR28RJ8woZmYba5d7ylazso
	b289h7W5xmZxEiwFlBIt1ox452iUgRqu/A1jUIOnjSdVyEdWpLH5kjnSs6DKBZEvSycWkxvqhKk
	IxbyrB3uVyoLYw/01RSeKkbyAbMo=
X-Google-Smtp-Source: AGHT+IH4eheqVGCCO+jxB3lin0rOkXq5DEPtLhniSrhGJcJ7W8Z2YPWgT39tCqKLjrV0RE5VKdSrWqqSGi7ocq0y3DI=
X-Received: by 2002:a17:90a:d58a:b0:29a:2860:28b9 with SMTP id
 v10-20020a17090ad58a00b0029a286028b9mr7312356pju.48.1709592851935; Mon, 04
 Mar 2024 14:54:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228005230.287113-1-namhyung@kernel.org> <ZeXTmdhu3Y_gC9ma@x1>
 <CAM9d7chEoab71v8=th7NAWcsPPZV+oGiJPGfiCcjdS3L+u13dA@mail.gmail.com>
In-Reply-To: <CAM9d7chEoab71v8=th7NAWcsPPZV+oGiJPGfiCcjdS3L+u13dA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 4 Mar 2024 14:53:59 -0800
Message-ID: <CAM9d7cggEAm3qyaBYVhpAXbGJ8LjJjK67WPds9dAFd_F5NJbhA@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf annotate: Improve memory usage for symbol histogram
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 8:36=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Arnaldo,
>
> On Mon, Mar 4, 2024 at 5:58=E2=80=AFAM Arnaldo Carvalho de Melo <acme@ker=
nel.org> wrote:
> >
> > On Tue, Feb 27, 2024 at 04:52:26PM -0800, Namhyung Kim wrote:
> > > This is another series of memory optimization in perf annotate.
> >
> > > When perf annotate (or perf report/top with TUI) processes samples, i=
t
> > > needs to save the sample period (overhead) at instruction level.  For
> > > now, it allocates an array to do that for the whole symbol when it
> > > hits any new symbol.  This comes with a lot of waste since samples ca=
n
> > > be very few and instructions span to multiple bytes.
> >
> > > For example, when a sample hits symbol 'foo' that has size of 100 and
> > > that's the only sample falls into the symbol.  Then it needs to
> > > allocate a symbol histogram (sym_hist) and the its size would be
> >
> > >   16 (header) + 16 (sym_hist_entry) * 100 (symbol_size) =3D 1616
> >
> > > But actually it just needs 32 (header + sym_hist_entry) bytes.  Thing=
s
> > > get worse if the symbol size is bigger (and it doesn't have many
> > > samples in different places).  Also note that it needs separate
> > > histogram for each event.
> >
> > > Let's split the sym_hist_entry and have it in a hash table so that it
> > > can allocate only necessary entries.
> >
> > > No functional change intended.
> >
> > I tried this before/after this series:
> >
> >   $ time perf annotate --stdio2 -i perf.data.annotate
> >
> > For:
> >
> >   perf record -e '{cycles,instructions,cache-misses}' make -k CORESIGHT=
=3D1 O=3D/tmp/build/$(basename $PWD)/ -C tools/perf install-bin
> >
> > And found these odd cases:
> >
> >   $ diff -u before after
> >   --- before    2024-02-28 15:38:25.086062812 -0300
> >   +++ after     2024-02-29 14:12:05.606652725 -0300
> >   @@ -2450826,7 +2450826,7 @@
> >                                 =E2=86=93 je       1c62
> >                                 =E2=86=92 call     operator delete(void=
*)@plt
> >                                 { return _M_dataplus._M_p; }
> >   -                       1c62:   mov      0x13c0(%rsp),%rdi
> >   +  0.00   0.00 100.00   1c62:   mov      0x13c0(%rsp),%rdi
> >                                 if (_M_data() =3D=3D _M_local_data())
> >                                   lea      0x13d0(%rsp),%rax
> >                                   cmp      %rax,%rdi
> >   @@ -2470648,7 +2470648,7 @@
> >                                   mov      %rbx,%rdi
> >                                 =E2=86=92 call     operator delete(void=
*)@plt
> >                                 using reference =3D T &;
> >   -  0.00   0.00 100.00  11c65:   mov      0x8(%r12),%rax
> >   +                      11c65:   mov      0x8(%r12),%rax
> >                                 size_t size() const { return Size; }
> >                                   mov      0x10(%r12),%ecx
> >                                   mov      %rax,%rbp
> >   $
> >
> >
> > This is a large function:
>
> Thanks for the test!  I think it missed the cast to 64-bit somewhere.
> I'll check and send v2 soon.

Yep, the offset variable in __symbol__inc_addr_samples()
should be u64.

Thanks,
Namhyung

