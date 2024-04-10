Return-Path: <linux-kernel+bounces-139549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990F48A043A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237AA2879D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECE53FB1C;
	Wed, 10 Apr 2024 23:50:05 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65BC132;
	Wed, 10 Apr 2024 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712793005; cv=none; b=fXnvPM58lFvrZLBdPMhZHr0aMsG9nq+bzHTTBpBpRYx6RxTq0xrLZ6VM1nabQhkRWe9jAuOtRK74H0gtrnlLmyryuRnSQrQfUJCW6193d3PQg85eD8T5oTRs4mvjPwJr6oIdrw1npu3GkLnIXR6N1DGuBlGmy/wBcEiq/zW+sxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712793005; c=relaxed/simple;
	bh=bRWJYdWzj/coHs4B1Gcd43qql80WSaQ7XRwLGU5SzGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcROfMYyPnmOKn7E5DMbyE4LpJ3rpqPJVlDiw81PtXu9HlCx9ylvSRGHh4aBj71NiN5JY3gABzcAGQOAk4sqI8GtXUFWirYH30lda6wLodGGJ8GCEtBakypIYrxCmiq+YpsSY7j/AmQIc5rKNgtRD8DDTeaS+T+yN/wDldW2wyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed01c63657so4961963b3a.2;
        Wed, 10 Apr 2024 16:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712793003; x=1713397803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53OBmNyk70ZNGHwUGm3I1IvF04+FN0hyjQYeieocvs0=;
        b=Q2E+RHvBrv7NSB/AUE7U6ZoOkr21A8oHUUzKivd63TAmBqnsPx0UOaMJc1qTkt2Ldh
         2GIipy0LhGdHcAiJ8+s9B6ndZe5NbHdyMKtxDWbuZFebgBzRX6LWMRHxT9AHCJKEbWjo
         SjaR44Cg9bgQ3IG2T7dgr7ig5Yl4e6XUVyHMtcxMEtb1tisI+HNSN4yzpqAl+W8s6aZ0
         uFaNR9DMwVXnsE6WMWbMT2apiDsSdjar00sDyLdPNBOUt7WZ2e+JZHJ9MJ51gxzWVgFz
         RW29n5MBD2AOozSFZk/WsoImAqxKIBfLPqVtXjRK9MW8WTYrUxjPvNQVAbqyjN35zjVz
         vYHg==
X-Forwarded-Encrypted: i=1; AJvYcCWbMZuY/4tGczhXx2IFJ8FsmLrJhTmzwO11Mr6lO9wyJW5xd/sBbENuq8jAyrAvo0iXESR4X2XV91iTos7Dhoa5jxLI0ay9k8HHRny/iFX3dboYxiAzIqNVGknAoLOY0wXTRQ7NX46MBi1mlB4fMw==
X-Gm-Message-State: AOJu0YzaMuvM0vQXZBt0r6UVsWrgXyr96aqhGyW7eqAfjNPR5xx2j+MG
	buue4MPWXeK0RLQuwtiO6ks2xCP/uBDNajaS3jfv0QP9FYN02Nn261xkyySgEB89CCUwxYmYw99
	9gyysdTOapagoHa5EXVPPRGKgHvREfA==
X-Google-Smtp-Source: AGHT+IEagieuV4FOtUh6ojGBJ4YHnNFTHxqo95++OdVPJ7HotoYwhw84UcATl1JYtq3Xe1xRRCMcW8YEJChFWpMuQVM=
X-Received: by 2002:a05:6a20:12c6:b0:1a9:6c78:6892 with SMTP id
 v6-20020a056a2012c600b001a96c786892mr2453707pzg.45.1712793003159; Wed, 10 Apr
 2024 16:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409235000.1893969-1-namhyung@kernel.org> <20240409235000.1893969-4-namhyung@kernel.org>
 <Zhb0raj1yW8JhuFW@x1> <Zhb-17CrgZt_PdUH@x1> <Zhb_F6hvWrjMcoM1@x1>
 <ZhcAvddbSEcMXzvH@x1> <ZhcB2Vh6lAcqPasI@x1> <ZhcCgzslBmDK4-vn@x1> <ZhcFXm9a2fzNeZwm@x1>
In-Reply-To: <ZhcFXm9a2fzNeZwm@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 10 Apr 2024 16:49:52 -0700
Message-ID: <CAM9d7cgz52wYFh16o9053OimT_Np11bfxLYGBWW9VnEqb_djsA@mail.gmail.com>
Subject: Re: [PATCH 3/6] perf annotate-data: Add hist_entry__annotate_data_tui()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 2:32=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Apr 10, 2024 at 06:20:06PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Apr 10, 2024 at 06:17:16PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Wed, Apr 10, 2024 at 06:12:32PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > On Wed, Apr 10, 2024 at 06:05:27PM -0300, Arnaldo Carvalho de Melo =
wrote:
> > > > > On Wed, Apr 10, 2024 at 06:04:26PM -0300, Arnaldo Carvalho de Mel=
o wrote:
> > > > > > On Wed, Apr 10, 2024 at 05:21:01PM -0300, Arnaldo Carvalho de M=
elo wrote:
> > > > > > > On Tue, Apr 09, 2024 at 04:49:57PM -0700, Namhyung Kim wrote:
> > > > > > > > Support data type profiling output on TUI.
> > > > > > >
> > > > > > > Added the follow to the commit log message, to make reviewing=
 easier.
> > > > > > >
> > > > > > > As followup patches I think having the DSO name together with=
 the type
> > > > > > > is important, also I think we could have a first menu with al=
l the pairs
> > > > > > > of DSO/type, sorted top down by the types with most samples, =
wdyt?
> > > > > > >
> > > > > > > Applied.
> > > > > > >
> > > > > >
> > > > > > There is something else here with the static build, checking...
> > > > >
> > > > > Probably because of:
> > > > >
> > > > > Makefile.config:810: slang not found, disables TUI support. Pleas=
e install slang-devel, libslang-dev or libslang2-dev
> > > > >
> > > > > Fixing...
> > > >
> > > > Trying with:
> > >
> > > Not really, I need to check for HAVE_DWARF_SUPPORT as well? Doing tha=
t
> >
> > Attempting with:
>
> Nope, the surgery needed is a bit bigger, as you made
> hist_entry__annotate_data_tty dependent on DWARF but calls it without
> checking HAVE_DWARF_SUPPORT from builtin-annotate.c.
>
> I put what I have in tmp.perf-tools-next, please take a look, I'll
> continue  tomorrow.

Oops, thanks a lot for fighting with this.  I think I can add a
dummy version in case it doesn't have the slang support.
I'll send v2 including all your other improvements.

Thanks,
Namhyung

