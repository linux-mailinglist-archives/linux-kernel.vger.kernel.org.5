Return-Path: <linux-kernel+bounces-79802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5350A8626F5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79E91F21C1B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A204C600;
	Sat, 24 Feb 2024 19:19:13 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCB94879B;
	Sat, 24 Feb 2024 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708802352; cv=none; b=a5tBvTuW9zQr3wk4MHoobovW/9K185PnslQA6Xlf1Af0jpwXWKZ8U02JmJ/cBH4aImerUHKv+EGVejdG4wfTiUCwkpI5xC/RrCtlST51wI2ra7K/TLmcasSM1Ayccr8U87jnGNgVLbHJ50E/FC8n4d/Ch6aKk5ncunMBsTR/zSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708802352; c=relaxed/simple;
	bh=EIBC3ik/1IgUIYuIzkjpB25tXBwPX2pnTpaTkdtCpig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOmLIwgz9P+W1CUieD8WmAkk5ZbOgmt/aFBjZ9HU5++ScYp2R1zXTON+MiEPAerjrxWkcjzfZj1BNSwJuY3yr0DpesgzSV0OFleFNXHsEA1I5cor4mn8v78dGq6ZQ1s8J0YaqTntIRv8LWp7Yz7OmnAR9jPzd2X79PXygo/uzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29aa77e86b2so178949a91.0;
        Sat, 24 Feb 2024 11:19:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708802350; x=1709407150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qR6Uf/hJ5IVuBEGWnR8Fp0SCf+fS67gdVlvmoGdV0Io=;
        b=P/rGLcq9GBPyuYJGFRYlxp9dCLUGl8P6xfvG2etlZpPyIZrxPWN64hm4sFwh10c8Jk
         KA9vX4IPDWawA9lEU5Z/GNskvA7ClGaa5O4qBmCq464m+6sC5eYf8z8A4miD4ZGsMb0I
         Z8FAMLiNoOdmuGTddnhy/M6r1ypHUHxhLMpph4S/1v+03zfZVoPDcS70ADkwEvdTQpax
         /HvNmn5Ktl9q+jXV2r7mgCrwAUZabZGMvqjQsqQ9Ov+oYsa/lZvN+L1ho/74N5JQKO99
         W2HSNBBRwfm/3CdgIYfTtsjV03gQRBAmAu0DbI1FwHLBPDqgWPAikPx9ElR+iftX1l1y
         L25A==
X-Forwarded-Encrypted: i=1; AJvYcCUETSyDTToRnzzkvQ0/Osqn7/Dn/YffaKojPlcacXEqWGPZoAuMbpJ66QO7faYtHcCSfHNZrgwdimctogLzOTNcxAB8yQKLxBBxqmWtdR4gCZgctskE1DJUKgfxNTI/qGq1gUcf4pzOdW5OVGLa5Q==
X-Gm-Message-State: AOJu0YxzTGeXppjfAQLuGHHSFuhYR1r5J4MjYnI4dcqGEfUhqx+m6Wkf
	2OzhcdSv0CA7Mp9hweYdEk7TTlEgS0IYvMJoZDwWGQto9it1aSyqWyPfUIHAo7o8KJuSs2PegqI
	Vg3gq2pGWpcSSnxi2ByQDNIg/44R8e/0x
X-Google-Smtp-Source: AGHT+IHRwNME7UDzdtOZh8uhim3VicNZdVOq4acklVIhqN414Zrxcd6TE1HeIkuojoco6AKAERyT3NcvLuTpivozbXs=
X-Received: by 2002:a17:90b:3017:b0:299:7c4f:c8ee with SMTP id
 hg23-20020a17090b301700b002997c4fc8eemr1967496pjb.19.1708802350152; Sat, 24
 Feb 2024 11:19:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZdoPrWg-qYFpBJbz@x1> <CAP-5=fVhQLSXb7GSn3H=CLCq+n7hr2FXgQLrOyJZAeBOJUOveA@mail.gmail.com>
In-Reply-To: <CAP-5=fVhQLSXb7GSn3H=CLCq+n7hr2FXgQLrOyJZAeBOJUOveA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sat, 24 Feb 2024 11:18:58 -0800
Message-ID: <CAM9d7ch3iaVDAFsVmmrF_BHCEcT=sEUUKx7TjJ8bOY7+zspuTA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf bpf: Check that the minimal vmlinux.h installed
 is the latest one
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 7:57=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sat, Feb 24, 2024 at 7:48=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > When building BPF skels perf will, by default, install a minimalistic
> > vmlinux.h file with the types needed by the BPF skels in
> > tools/perf/util/bpf_skel/ in its build directory.
> >
> > When 29d16de26df17e94 ("perf augmented_raw_syscalls.bpf: Move 'struct
> > timespec64' to vmlinux.h") was added, a type used in the augmented_raw_=
syscalls
> > BPF skel, 'struct timespec64' was not found when building from a pre-ex=
isting
> > build directory, because the vmlinux.h there didn't contain that type,
> > ending up with this error, spotted in linux-next:
> >
> >     CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw=
_syscalls.bpf.o
> >   util/bpf_skel/augmented_raw_syscalls.bpf.c:329:15: error: invalid app=
lication of 'sizeof' to an incomplete type 'struct timespec64'
> >     329 |         __u32 size =3D sizeof(struct timespec64);
> >         |                      ^     ~~~~~~~~~~~~~~~~~~~
> >   util/bpf_skel/augmented_raw_syscalls.bpf.c:329:29: note: forward decl=
aration of 'struct timespec64'
> >     329 |         __u32 size =3D sizeof(struct timespec64);
> >         |                                    ^
> >   util/bpf_skel/augmented_raw_syscalls.bpf.c:350:15: error: invalid app=
lication of 'sizeof' to an incomplete type 'struct timespec64'
> >     350 |         __u32 size =3D sizeof(struct timespec64);
> >         |                      ^     ~~~~~~~~~~~~~~~~~~~
> >   util/bpf_skel/augmented_raw_syscalls.bpf.c:350:29: note: forward decl=
aration of 'struct timespec64'
> >     350 |         __u32 size =3D sizeof(struct timespec64);
> >         |                                    ^
> >   2 errors generated.
> >   make[2]: *** [Makefile.perf:1158: /tmp/build/perf-tools-next/util/bpf=
_skel/.tmp/augmented_raw_syscalls.bpf.o] Error 1
> >   make[2]: *** Waiting for unfinished jobs....
> >   make[1]: *** [Makefile.perf:261: sub-make] Error 2
> >   make: *** [Makefile:113: install-bin] Error 2
> >   make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> >
> > So add a Makefile dependency (Namhyung's suggestion) to make sure that
> > the new tools/perf/util/bpf_skel/vmlinux/vmlinux.h minimal vmlinux is
> > updated in the build directory, providing the moved 'struct timespec64'
> > type.
> >
> > Fixes: 29d16de26df17e94 ("perf augmented_raw_syscalls.bpf: Move 'struct=
 timespec64' to vmlinux.h")
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Link: https://lore.kernel.org/lkml/CAM9d7ciaj80QZL0AS_T2HNBdMOyS-j1wBHQ=
SYs=3DU3kHQimY1mQ@mail.gmail.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Suggested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

