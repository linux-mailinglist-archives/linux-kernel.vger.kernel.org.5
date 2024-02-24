Return-Path: <linux-kernel+bounces-79711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8419F8625B1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E761C20C16
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA8E45C08;
	Sat, 24 Feb 2024 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJXs5p2l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596BE24B54;
	Sat, 24 Feb 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708787128; cv=none; b=bCcOB+Y3mB7qSwAxeDDMhvaFTHxveXPye6I8tkpbt/ihGX91W594ijitTcuJ6aif0bz9qILEzFVpHDP+6bpy33gqlFGuo/soa0asoo+WgBMmDlaFkEc3gDKJeKdOLd1Lfwnz6jXsWLYmOvvQ6Ec7hUfVEEfC0ijHVZC5YqG/FQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708787128; c=relaxed/simple;
	bh=oC+819alsBsCF37dz60vdeaMt67VeJuCkAD2RtMidss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsXs3UyARUx625UQkJPgcIZkla32mzgbckZjmi8qN/To/UF8haKWmXTn7zo+UKKVIRi8I5yIHL7bFJ7R4qLIbtOT8MfiRaEHScQBxhvlGf9Nuse1xcYsRapG2HBBMe7lEqzCNPYWQcX15HcAMzIk5ZaQr6Lihmty8NrqyppIAKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJXs5p2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC64BC433F1;
	Sat, 24 Feb 2024 15:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708787128;
	bh=oC+819alsBsCF37dz60vdeaMt67VeJuCkAD2RtMidss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJXs5p2lPsA++XKQWmL0YkfkWSlzoIOywXQchJiIrYKG90l0zDG4Mwr2IoHpKkXs/
	 gfV2+PBDH6R/g4nceJSBYotXoOW/Cxa+PGM0zL5lc1o1qJ71X7c7jL8Jnef7Pw9+8d
	 vi6jhwHaPPkwFfNWWrQxcsEirCdKv3Qt6q+l7w9dP5pVTLv6WL+AnXQ6LfRrjN/7z9
	 T9L66jdVhMbPvUjN1/4ePXzCYrkeUvZc6lczj7S1i6Bd/rSQ/StNajCaDFgZrwa0L7
	 5uguXiiQMtbNbFFHnGyQhTHGwiyp4di8ozhvDxVoZzjJG7BT5mkSGZsFH4RFtNY5mx
	 ESNnSJoxNjv0g==
Date: Sat, 24 Feb 2024 12:05:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [solved] Re: linux-next: build failure after merge of the perf
 tree
Message-ID: <ZdoFtNnivIONTNtg@x1>
References: <20240222100656.0a644254@canb.auug.org.au>
 <Zdj3FyPjE5ezyfsM@x1>
 <Zdj74Zo10vYTZNMl@x1>
 <CAM9d7ciaj80QZL0AS_T2HNBdMOyS-j1wBHQSYs=U3kHQimY1mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciaj80QZL0AS_T2HNBdMOyS-j1wBHQSYs=U3kHQimY1mQ@mail.gmail.com>

On Fri, Feb 23, 2024 at 12:34:40PM -0800, Namhyung Kim wrote:
> Hi Arnaldo,
> 
> On Fri, Feb 23, 2024 at 12:11 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Fri, Feb 23, 2024 at 04:50:47PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Thu, Feb 22, 2024 at 10:06:56AM +1100, Stephen Rothwell wrote:
> > > > Hi all,
> > > >
> > > > After merging the perf tree, today's linux-next build (native perf)
> > > > failed like this:
> > > >
> > > > util/bpf_skel/augmented_raw_syscalls.bpf.c:329:15: error: invalid application of 'sizeof' to an incomplete type 'struct timespec64'
> > > >         __u32 size = sizeof(struct timespec64);
> > > >                      ^     ~~~~~~~~~~~~~~~~~~~
> > > > util/bpf_skel/augmented_raw_syscalls.bpf.c:329:29: note: forward declaration of 'struct timespec64'
> > > >         __u32 size = sizeof(struct timespec64);
> > > >                                    ^
> > > >
> > > > Caused by commit
> > > >
> > > >   29d16de26df1 ("perf augmented_raw_syscalls.bpf: Move 'struct timespec64' to vmlinux.h")
> > > >
> > > > This is a ppc64 le build.
> > > >
> > > > I have used the perf tree from next-20240221 for today.
> > >
> > > Ok, finally I managed to secure a ppc64 machine to test this and
> > > sometimes I reproduce just like you reported, but sometimes I can't do
> > > it, didn't manage to isolate what is that makes it fail sometimes, make
> > > -C tools/perf clean, nuking the O= target directory, etc, when I
> > > reproduce it:
> >
> > So I think I see the problem, I now left the build directory with a
> > previous build from torvalds/master, then switched to the
> > perf-tools-branch and tried to build from there, without first removing
> > the old build, it fails:
> >
> >   CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
> > util/bpf_skel/augmented_raw_syscalls.bpf.c:329:15: error: invalid application of 'sizeof' to an incomplete type 'struct timespec64'
> >   329 |         __u32 size = sizeof(struct timespec64);
> >       |                      ^     ~~~~~~~~~~~~~~~~~~~
> > util/bpf_skel/augmented_raw_syscalls.bpf.c:329:29: note: forward declaration of 'struct timespec64'
> >   329 |         __u32 size = sizeof(struct timespec64);
> >       |                                    ^
> > 1 error generated.
> > make[2]: *** [Makefile.perf:1161: /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o] Error 1
> > make[1]: *** [Makefile.perf:264: sub-make] Error 2
> >
> >
> > Because it will use what was installed before in the build dir:
> >
> > [acme@ibm-p9z-16-lp5 perf-tools-next]$ ls -la /tmp/build/perf-tools-next/util/bpf_skel/vmlinux.h
> > -rw-r--r--. 1 acme acme 4319 Feb 23 14:59 /tmp/build/perf-tools-next/util/bpf_skel/vmlinux.h
> > [acme@ibm-p9z-16-lp5 perf-tools-next]$
> >
> > And that one doesn't have 'struct timespec64':
> >
> > [acme@ibm-p9z-16-lp5 perf-tools-next]$ grep timespec64 /tmp/build/perf-tools-next/util/bpf_skel/vmlinux.h
> > [acme@ibm-p9z-16-lp5 perf-tools-next]$
> >
> > If I remove that directory contents:
> >
> > [acme@ibm-p9z-16-lp5 perf-tools-next]$ rm -rf /tmp/build/perf-tools-next/
> > [acme@ibm-p9z-16-lp5 perf-tools-next]$ mkdir /tmp/build/perf-tools-next/
> > [acme@ibm-p9z-16-lp5 perf-tools-next]$
> >
> > And then try to build again:
> >
> > make -k O=/tmp/build/perf-tools-next/ -C tools/perf install-bin
> >
> > It works.
> >
> > I reproduced the problem on x86_64, so, on this transition period, the
> > problem happens, probably we need to robustify the installation of
> > tools/perf/util/bpf_skel/vmlinux/vmlinux.h in the O= target directory,
> > but if you just make sure the build directory is clean before trying to
> > build it, this time, it should work, wdyt?
> 
> Can we add a dependency to the minimal vmlinux.h?

That fixes it, I'll submit a formal patch

- Arnaldo
 
> Thanks,
> Namhyung
> 
> ---8<---
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 3cecd51b2397..33621114135e 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1147,7 +1147,7 @@ ifeq ($(VMLINUX_H),)
>    endif
>  endif
> 
> -$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> +$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) $(VMLINUX_H)
>  ifeq ($(VMLINUX_H),)
>         $(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
>  else

