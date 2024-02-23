Return-Path: <linux-kernel+bounces-79078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B034B861D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB73282711
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1238B146E6B;
	Fri, 23 Feb 2024 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4Dzo/hR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130F14532B;
	Fri, 23 Feb 2024 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719077; cv=none; b=HKufukxxwMYFvABCYuAnIG6PnKAP4/SQsjVQnQj80vQjOnXicK5HYQsQj8CLSVE4jO+5RFc0x8FgvyoDckZWUmdZkfMeZddLNAbAtG+66/OueJhMivvnh+f3Y0n2/H+hkp6fJ3MtDvqqk9XsDB/z1CtF15RMwfqldb0kjsnNFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719077; c=relaxed/simple;
	bh=8xW8KxDODeymUb/1hXcdxwew9busA4V8Q9f//wMlheM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk28qlQOaJnQrcenqrxg7XxmIdcQ9wqViCvj9Kkit+EKZAkj28ESa/oMxw0PpiRO8YVU98Ud4AiMgFCi3SL7f4dNEI38Mm7g2CaFU6d3RNQgq/5k02ZwPmPXCQces676yc5mPFFmAzqCm5LhC/diku0JSgQf+jPW3e/wnzgvk1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4Dzo/hR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B516C433F1;
	Fri, 23 Feb 2024 20:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708719076;
	bh=8xW8KxDODeymUb/1hXcdxwew9busA4V8Q9f//wMlheM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4Dzo/hR20xvmO1jr//XhxqGK+erueAvuoFuJSeFYPgharDdWH+fn1b98im3Ih947
	 WQCSHZvzOjGy+RO1SuZ0JGRgIvoWiTkYfRBUgPkx34e/EHfVUX68vsfw3iwyMnWaHT
	 ZUf88//1z8rxOInhdHTGVf3E/rZwsulCKNfmHdktkxydNE0H8nLemZSanWN/pB9o3y
	 oL5haI2bgF6C5ImYaWESo3f6Cp94gfjgVF78vNlpC7kQ8gUWIZpJV449M3zOyvsjWG
	 6wWD7aw5YSgK7ZsZve6n6TPM+xy7zgCdgU0BGjpbse14cFtdJdrh6jJ9ftzoXWdR/c
	 thKsoeztjbWoA==
Date: Fri, 23 Feb 2024 17:11:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [solved] Re: linux-next: build failure after merge of the perf tree
Message-ID: <Zdj74Zo10vYTZNMl@x1>
References: <20240222100656.0a644254@canb.auug.org.au>
 <Zdj3FyPjE5ezyfsM@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdj3FyPjE5ezyfsM@x1>

On Fri, Feb 23, 2024 at 04:50:47PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Feb 22, 2024 at 10:06:56AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the perf tree, today's linux-next build (native perf)
> > failed like this:
> > 
> > util/bpf_skel/augmented_raw_syscalls.bpf.c:329:15: error: invalid application of 'sizeof' to an incomplete type 'struct timespec64'
> >         __u32 size = sizeof(struct timespec64);
> >                      ^     ~~~~~~~~~~~~~~~~~~~
> > util/bpf_skel/augmented_raw_syscalls.bpf.c:329:29: note: forward declaration of 'struct timespec64'
> >         __u32 size = sizeof(struct timespec64);
> >                                    ^
> > 
> > Caused by commit
> > 
> >   29d16de26df1 ("perf augmented_raw_syscalls.bpf: Move 'struct timespec64' to vmlinux.h")
> > 
> > This is a ppc64 le build.
> > 
> > I have used the perf tree from next-20240221 for today.
> 
> Ok, finally I managed to secure a ppc64 machine to test this and
> sometimes I reproduce just like you reported, but sometimes I can't do
> it, didn't manage to isolate what is that makes it fail sometimes, make
> -C tools/perf clean, nuking the O= target directory, etc, when I
> reproduce it:

So I think I see the problem, I now left the build directory with a
previous build from torvalds/master, then switched to the
perf-tools-branch and tried to build from there, without first removing
the old build, it fails:

  CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
util/bpf_skel/augmented_raw_syscalls.bpf.c:329:15: error: invalid application of 'sizeof' to an incomplete type 'struct timespec64'
  329 |         __u32 size = sizeof(struct timespec64);
      |                      ^     ~~~~~~~~~~~~~~~~~~~
util/bpf_skel/augmented_raw_syscalls.bpf.c:329:29: note: forward declaration of 'struct timespec64'
  329 |         __u32 size = sizeof(struct timespec64);
      |                                    ^
1 error generated.
make[2]: *** [Makefile.perf:1161: /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o] Error 1
make[1]: *** [Makefile.perf:264: sub-make] Error 2


Because it will use what was installed before in the build dir:

[acme@ibm-p9z-16-lp5 perf-tools-next]$ ls -la /tmp/build/perf-tools-next/util/bpf_skel/vmlinux.h 
-rw-r--r--. 1 acme acme 4319 Feb 23 14:59 /tmp/build/perf-tools-next/util/bpf_skel/vmlinux.h
[acme@ibm-p9z-16-lp5 perf-tools-next]$

And that one doesn't have 'struct timespec64':

[acme@ibm-p9z-16-lp5 perf-tools-next]$ grep timespec64 /tmp/build/perf-tools-next/util/bpf_skel/vmlinux.h 
[acme@ibm-p9z-16-lp5 perf-tools-next]$

If I remove that directory contents:

[acme@ibm-p9z-16-lp5 perf-tools-next]$ rm -rf /tmp/build/perf-tools-next/
[acme@ibm-p9z-16-lp5 perf-tools-next]$ mkdir /tmp/build/perf-tools-next/
[acme@ibm-p9z-16-lp5 perf-tools-next]$

And then try to build again:

make -k O=/tmp/build/perf-tools-next/ -C tools/perf install-bin

It works.

I reproduced the problem on x86_64, so, on this transition period, the
problem happens, probably we need to robustify the installation of
tools/perf/util/bpf_skel/vmlinux/vmlinux.h in the O= target directory,
but if you just make sure the build directory is clean before trying to
build it, this time, it should work, wdyt?

Ian, ideas?

- Arnaldo

