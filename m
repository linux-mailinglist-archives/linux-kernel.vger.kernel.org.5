Return-Path: <linux-kernel+bounces-56969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F984D1F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142D31C20A7A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618A86147;
	Wed,  7 Feb 2024 19:04:35 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5FE85C49;
	Wed,  7 Feb 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332674; cv=none; b=vEiaIw9raCKp6MKUq5xAGWGaRYx1wsgyHPQejDRRjfZJDvgQRzAzCoQYn9iQ6h7WRn8klIPRnZXgidbtln/GF3WCbQxJpJ1JScFK1jjdeXpE1mGMb+2wriUkvVQaIQS2o0FMGa38l/PgA6MerpJr3ZrAo8O7bMT3LWT0ZJ44EzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332674; c=relaxed/simple;
	bh=eSR8JlMnD37e2fdYBa8LzrVXfMjhsrYROPi+JXssO10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZW35AGDosvNZFCRWqgCuQscBlza7Y44KwWCUoPzpqmG/2DfwopO4Naxdz9TRBAOeHgzV0O9RS8pBig4naRNBs3hqHx7LlK38oZZDxM2yHr0JZIKi3ZA3UUtroffF8iLU+wxpVy9jT8IuSFRU0jo9vzWxvgoRwo7TnEPsDD0IFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso760448a12.3;
        Wed, 07 Feb 2024 11:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707332672; x=1707937472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8perGIw/BuKpMeus4TL5BLo9dzJJHqJwC6cZICjUEZI=;
        b=aK7RsnYnSqV7O05ss6/mVNjs0PMuw9A559f4e/v5HVFBNWlQX1F2Bd8ElutVN7rdvo
         1Obfv52Bpon6m7nTCDYmaaKF0xQ5zA7kwRUam2WvNJAZJfx/RrbR8RSQ8u5gOAr2Xltu
         FRGQwpiO1MCY45ILnSPplcTYap0bo6CSIfZxyduL5gj0O+nAOLuMAXKvUmf8j06dcG66
         LCOOB/Buf7cHYIunposKsUhFiv8Oi2d+huL35TYdTVc6wwT0+0GIGwZpWZvi8YyO0ror
         pYb6dZKMlM1XO85a77+EhTbcQLtLY+Qa7DBPbYkF3W1MKjaM1MUzWVOxPFvwKmEwYDHk
         smUA==
X-Gm-Message-State: AOJu0Yyy4l5RhVZ3PxnL6pG+aLKhby1IBke9COwcQa2D+QpNCgcOtPpb
	iHS14GRmqYo29wfAOBRm/8RUXjloyp54zNQODyc7b1C8esGCwv0pDDjNpmCTdGIKpP7JhZ3cwVV
	+AFUzelkFZKPd0E+xpsKamg3idwBmY8QVvio=
X-Google-Smtp-Source: AGHT+IEpyp2fgWRzjBrnEfTzgcQMrIKsdhE4SFkaDHOeGqt1nS1ocypZ3lJnDguuDQsSqNejp3oret8dwemQT9uusiY=
X-Received: by 2002:a05:6a20:d49a:b0:19c:888b:b74e with SMTP id
 im26-20020a056a20d49a00b0019c888bb74emr7978073pzb.61.1707332671888; Wed, 07
 Feb 2024 11:04:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-5-namhyung@kernel.org>
 <CAP-5=fU=P-ib+n+OfqJAbm8gS2RY-W-KcBskoSHkC+aCmXYcXQ@mail.gmail.com>
 <CAM9d7chvEw6r8_7agxOpWxufTo+dLaNForSFFShCFGd9KDBtoA@mail.gmail.com> <CAP-5=fWx9Uub9uRgQJq_ekQScm4fJXMdr9_cr19vcckCPjPt9w@mail.gmail.com>
In-Reply-To: <CAP-5=fWx9Uub9uRgQJq_ekQScm4fJXMdr9_cr19vcckCPjPt9w@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 7 Feb 2024 11:04:21 -0800
Message-ID: <CAM9d7ciGna7tm5gxoVAQexj_to9sRSL-emmCTSkMbGZgY8mthw@mail.gmail.com>
Subject: Re: [PATCH 04/14] perf map: Add map__objdump_2rip()
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:34=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Feb 6, 2024 at 3:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > Hi Ian,
> >
> > On Fri, Feb 2, 2024 at 5:42=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > > >
> > > > Sometimes we want to convert an address in objdump output to
> > > > map-relative address to match with a sample data.  Let's add
> > > > map__objdump_2rip() for that.
> > >
> > > Hi Namhyung,
> > >
> > > I think the naming can be better here. Aren't the objdump addresses
> > > DSO relative offsets? Is the relative IP relative to the map or the
> > > DSO?
> >
> > AFAIK the objdump addresses are DSO-relative and rip is to map.
> > They are mostly the same but sometimes different due to kASLR
> > for the kernel.
>
> Perhaps we need to use names like map_rip for mapping relative and
> dso_rip to clean this up, or to add a different mapping_type to the
> enum. For non-kernel maps addresses for map are either the whole
> virtual address space (identity) or relative to a dso:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/map.h?h=3Dperf-tools-next#n115
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/map.h?h=3Dperf-tools-next#n20
> The dso addresses should work for objdump so perhaps the kernel
> addresses need map__pgoff fixing?

I'm not sure about the vDSO case.

By the way, I need to take a look if we can make this objdump-rip
thing simpler as you mentioned.  My feeling is that it can be done
but I'd like to do it in a separate work and to move this forward.

Thanks,
Namhyung

