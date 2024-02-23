Return-Path: <linux-kernel+bounces-79056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969EB861CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC07B242BF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA3214532F;
	Fri, 23 Feb 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAMMDQNm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9D84FA7;
	Fri, 23 Feb 2024 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717853; cv=none; b=astOzaHFAcPG+88Hdvyy7O9qTskIxsRardaaKb8DOCmaAR0Y6zGz3Zw1lz7XFR9bmohrL/329So4Ivbv+/vmfhnJmzAy4ECrrA5oOBdtfkvwi7l3brasw+rkI+iV1UBsn4qi+caE9H4rS1tetjf5BYTC3fIxQAOt+8VpIqj7meU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717853; c=relaxed/simple;
	bh=wvrr275yjInTJZFP8axO/9lFGI3KozPNDA0b9rOo4f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5Iiy/LZqXA6lrcfUnnJ4rshV0bIlZ/qoVsZcnEFWE1MGUzuKtsHg+JroxuUq9M+LK4+oDBNqErsqImDs/0ycotaaKvNazOmm+HtyCL5QhBEajuBwcTock/71dMv+/0JHsrAUMdAZuQIpgyqY6kHcVAcDSju+GVV98GE9IBMrBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAMMDQNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDA1C433C7;
	Fri, 23 Feb 2024 19:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708717852;
	bh=wvrr275yjInTJZFP8axO/9lFGI3KozPNDA0b9rOo4f8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAMMDQNmkOkJRIhitP/6yGmWd3uETTrSECCMXXn8CwIwvOCcqi025rn08V1nsCh2b
	 WJlMGv4E6OqP1HtjMVX+YV6F3DZ4tsOWkkRDjEt+FypqVnjEJ1i5stAEQUE6rewQde
	 c0TnloP7N+h/aiMRo0UdmXjkEnn35vKwbb1tG/f+ljtroiRXZfq2d/FyEZcRgCKhQu
	 5wi2hoGO/MAo7vTtg0RPQQxQqYgqIzEEhyMt4hgbOWFTNJU/N78qu5pGUl7PNJveOT
	 qKp73VbmcrZ4lGiVl271hzZ0pXHtK9fRK0CtyOR+a5RIDTAN2e07Za+eA70fbLWPwz
	 ah0+tUzRkbYkw==
Date: Fri, 23 Feb 2024 16:50:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <Zdj3FyPjE5ezyfsM@x1>
References: <20240222100656.0a644254@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222100656.0a644254@canb.auug.org.au>

On Thu, Feb 22, 2024 at 10:06:56AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the perf tree, today's linux-next build (native perf)
> failed like this:
> 
> util/bpf_skel/augmented_raw_syscalls.bpf.c:329:15: error: invalid application of 'sizeof' to an incomplete type 'struct timespec64'
>         __u32 size = sizeof(struct timespec64);
>                      ^     ~~~~~~~~~~~~~~~~~~~
> util/bpf_skel/augmented_raw_syscalls.bpf.c:329:29: note: forward declaration of 'struct timespec64'
>         __u32 size = sizeof(struct timespec64);
>                                    ^
> 
> Caused by commit
> 
>   29d16de26df1 ("perf augmented_raw_syscalls.bpf: Move 'struct timespec64' to vmlinux.h")
> 
> This is a ppc64 le build.
> 
> I have used the perf tree from next-20240221 for today.

Ok, finally I managed to secure a ppc64 machine to test this and
sometimes I reproduce just like you reported, but sometimes I can't do
it, didn't manage to isolate what is that makes it fail sometimes, make
-C tools/perf clean, nuking the O= target directory, etc, when I
reproduce it:

  GENSKEL /tmp/build/perf-tools-next/util/bpf_skel/lock_contention.skel.h
util/bpf_skel/augmented_raw_syscalls.bpf.c:329:15: error: invalid application of 'sizeof' to an incomplete type 'struct timespec64'
  329 |         __u32 size = sizeof(struct timespec64);
      |                      ^     ~~~~~~~~~~~~~~~~~~~
util/bpf_skel/augmented_raw_syscalls.bpf.c:329:29: note: forward declaration of 'struct timespec64'
  329 |         __u32 size = sizeof(struct timespec64);
      |                                    ^
1 error generated.
make[2]: *** [Makefile.perf:1161: /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:264: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'

$ cat /etc/redhat-release 
Red Hat Enterprise Linux release 9.5 Beta (Plow)
$
Linux host 5.14.0-425.el9.ppc64le #1 SMP Wed Feb 21 15:29:04 EST 2024 ppc64le ppc64le ppc64le GNU/Linux

$ clang -v
clang version 17.0.6 (Red Hat, Inc. 17.0.6-5.el9)
Target: ppc64le-redhat-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Found candidate GCC installation: /opt/rh/gcc-toolset-13/root/usr/lib/gcc/ppc64le-redhat-linux/13
Selected GCC installation: /opt/rh/gcc-toolset-13/root/usr/lib/gcc/ppc64le-redhat-linux/13
Candidate multilib: .;@m64
Selected multilib: .;@m64


But this is an elusive bug, its not always that it fails :-\

$ git log --oneline -1
659663f0bccc (HEAD -> perf-tools-next, perf-tools-next/perf-tools-next) perf: script: prefer capstone to XED
$ file /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o 
/tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), with debug_info, not stripped
$ 

That "incomplete" type is defined in:

$ grep timespec64 -B10 -A3 tools/perf/util/bpf_skel/vmlinux/vmlinux.h 

typedef __u8 u8;
typedef __u32 u32;
typedef __u64 u64;
typedef __s64 s64;

typedef int pid_t;

typedef __s64 time64_t;

struct timespec64 {
        time64_t        tv_sec;
        long int        tv_nsec;
};
$

But it is used only on this sizeof expression, that is used only by
clang and for the BPF target...

$ grep timespec64 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
	__u32 size = sizeof(struct timespec64);
$

Stephen, can you try to reproduce this again? And if it fails, try
reproducing that 'sizeof(struct timespec64)' with 16, which is, in
ppc64:

$ uname -m
ppc64le
$ pahole timespec64
struct timespec64 {
	time64_t                   tv_sec;               /*     0     8 */
	long int                   tv_nsec;              /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* last cacheline: 16 bytes */
};

$ 

And on x86_64:

acme@x1:~$ uname -m
x86_64
acme@x1:~$ pahole timespec64
struct timespec64 {
	time64_t                   tv_sec;               /*     0     8 */
	long int                   tv_nsec;              /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* last cacheline: 16 bytes */
};

acme@x1:~$

- Arnaldo

