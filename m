Return-Path: <linux-kernel+bounces-137282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF2989DFE2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466B428A982
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE8D13D614;
	Tue,  9 Apr 2024 15:59:10 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2F913D53B;
	Tue,  9 Apr 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678349; cv=none; b=o3UT8vLVOouUmQXkkjR1c+wak48tm3Cl0QKbVsrk9SoVO0oVqUUTA3siKGFFu7fci3vokvro64KYR5ahzyFaASczCQomLQxkIwBcdzzdNCQoML5u8Bmrl81eECdNLCTr2bMa77kU4fu5aYUleyKdPSTpuA7Si0buUqzs1hJ5eUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678349; c=relaxed/simple;
	bh=m8H9joEIptmRTW9J5ds/aLheZ/X7urtgRu5eARksGZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVnemh3v2Px3x9uP46HIMzHgbT21fmC+qkGCi+mv1zrwCiXxf1RgLyAkWKpktwkC5PjMUUhcnqzngVF1UhnTZ6lHFOfJx7y8J0y5BWnthoO0n1QQ8ERHxIGCms7XkbgOkW07p4pwPUvtfCu2vpUYRRUx0zLBQAFZh4V1mOXNz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e3f17c6491so22828855ad.2;
        Tue, 09 Apr 2024 08:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712678348; x=1713283148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaAFxDesLCp1J9HNjP5kNxfAXTppheD2uL+QLjtaWsY=;
        b=Vlwu+pv5A3ENGHYaWMiRlP/IwJrgrh14zeZvX9PkejTWEJMHS2xEcx1zcwbDqOxT1K
         lGNSqYah+VKlq3oxzhQGZYIbHlrm6TwQcmd7I5HbpR4UgXTZZebKcTc5puAorIv/5Qu2
         WC2YPPq/7qUdG9Kly9jhBhMnnp1QHgSPf0p7qCsZXmO1dR7BKkqKGPmflFhsqUaGB4Ka
         yyA+XuhXSpuMBPEg1cTOPPiNC/QP/YqsoNANShgK1el0TcKb5jLW3mfTvYpN3SZLjf3U
         aYZlJuyC9Gq1WbnmXYcipp1I0kDCOj6lx8XWEIQ2T4P5484eo5HeNDyHodAjKPV+T9u/
         ISIg==
X-Forwarded-Encrypted: i=1; AJvYcCWlu6lGmt97G8HCX4Q7ziULPLzt2JwjGIJ1IAfNE3TKNaae6pvdvI94tQqta/OG3DClA69aIXTqubremuo4Z2XgsCxy8o6dUcmDnR0FxgFqaXd2v7vwicDlJ9qgu30foynS3KdLc9Z9g2vdVRU+oQ==
X-Gm-Message-State: AOJu0Yzy7GcCn0utrObmCDPccomn/EiQO96awCgaw7eTkE7SIYzng43S
	ydVdY7Nwj8pysPJbxxXbwnDaHvpEWEzBF48z2s6wUcd5pQaTXjDJH4cMPiHcIjHGpf6eJm5b8FM
	ze20aXvu3rr5xkfTUFg6EVy/aGPo=
X-Google-Smtp-Source: AGHT+IEoB3gl4csO3v2Yp3hXSGaET+RnrA2EP5yYdzwofOI00wbretEX9XVxg9tqhSnaCcQ3YUvMKRHsLVEF+2Slp70=
X-Received: by 2002:a17:903:240b:b0:1e3:e257:2c8d with SMTP id
 e11-20020a170903240b00b001e3e2572c8dmr182741plo.11.1712678347692; Tue, 09 Apr
 2024 08:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408185520.1550865-1-namhyung@kernel.org> <20240408185520.1550865-2-namhyung@kernel.org>
 <874jcb9etk.fsf@intel.com> <ZhTwPLliHXKPAJUQ@gmail.com> <87pluy972m.fsf@intel.com>
In-Reply-To: <87pluy972m.fsf@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 9 Apr 2024 08:58:55 -0700
Message-ID: <CAM9d7cizO8j3tLjxiVKh4qw3dOzqKmUKZg8BZwaCF=ChmbX81A@mail.gmail.com>
Subject: Re: [PATCH 1/9] tools/include: Sync uapi/drm/i915_drm.h with the
 kernel sources
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 9, 2024 at 3:14=E2=80=AFAM Jani Nikula <jani.nikula@linux.intel=
com> wrote:
>
> On Tue, 09 Apr 2024, Ingo Molnar <mingo@kernel.org> wrote:
> > * Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >
> >> On Mon, 08 Apr 2024, Namhyung Kim <namhyung@kernel.org> wrote:
> >> > To pick up changes from:
> >> >
> >> >    b112364867499 ("drm/i915: Add GuC submission interface version qu=
ery")
> >> >    5cf0fbf763741 ("drm/i915: Add some boring kerneldoc")
> >> >
> >> > This should be used to beautify DRM syscall arguments and it address=
es
> >> > these tools/perf build warnings:
> >> >
> >> >   Warning: Kernel ABI header differences:
> >> >     diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_=
drm.h
> >>
> >> All these years and I never realized there are header copies
> >> there. But... why copies?
> >
> > It's better than all the alternatives we tried so far:
> >
> >  - Symbolic links and direct #includes: this was the original approach =
but
> >    was pushed back on from the kernel side, when tooling modified the
> >    headers and broke them accidentally for kernel builds.
> >
> >  - Duplicate self-defined ABI headers like glibc: double the maintenanc=
e
> >    burden, double the chance for mistakes, plus there's no tech-driven
> >    notification mechanism to look at new kernel side changes.
> >
> > What we are doing now is a third option:
> >
> >  - A software-enforced copy-on-write mechanism of kernel headers to
> >    tooling, driven by non-fatal warnings on the tooling side build when
> >    kernel headers get modified:
> >
> >     Warning: Kernel ABI header differences:
> >       diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_d=
rm.h
> >       diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h
> >       diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
> >       ...
> >
> >    The tooling policy is to always pick up the kernel side headers as-i=
s,
> >    and integate them into the tooling build. The warnings above serve a=
s a
> >    notification to tooling maintainers that there's changes on the kern=
el
> >    side.
> >
> > We've been using this for many years now, and it might seem hacky, but
> > works surprisingly well.
> >
> > Does this make sense to you?
>
> Yes, although there are probably pieces of the puzzle I'm missing.
> Thanks for the explanation! (That might work almost as-is copied to
> tools/include/uapi/README. ;)
>
> It's also kind of funny to find this kind of back alleys of the kernel
> repo I've never wandered to before.

I have some explanation in the cover letter of the series but I forgot
to mention that in each commit message.  Probably I can update the
explanation with Ingo's reply.

Thanks,
Namhyung

