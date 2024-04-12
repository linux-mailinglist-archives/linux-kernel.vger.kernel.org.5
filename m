Return-Path: <linux-kernel+bounces-142938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CC58A3248
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F101C22747
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743D148840;
	Fri, 12 Apr 2024 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxVWIHeu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6988148827;
	Fri, 12 Apr 2024 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935331; cv=none; b=punu11N6u/hoq12nTm0WkvEUFIHVf3NPOIPq+uoTxbC+1tU9QxEy5GnZcWBU/Dp7K/X7Mh82X4rPIc86yW1zOdHRRCkEoNuIP/SHVV323HMrKtc16VKHSOc1wgz9JxdG8DEKXb7WSMz8Uy8JGH3uveJm4SQDoK1/xQGJ9/Hj3H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935331; c=relaxed/simple;
	bh=GWI+u4qjsUPEJ+fxWTkTzIEPGmAcqzYbivpR7z2fEe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sok5OjeJnyngF3Iq+8MjxRjPMv8SyQqtaDaLU2WpJ5+VPasMCkSwYpjkWybA+ObXPh8eIogAfxInL0AjB2AwvzJ3pTOtMNsugjTT/496CEESP2zX0FNyttO4mgNZeXTeNSMbhtOl4jAA8ghbB3vYiO21Ykj646/8UDo+/uBSjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxVWIHeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E866C2BD11;
	Fri, 12 Apr 2024 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712935331;
	bh=GWI+u4qjsUPEJ+fxWTkTzIEPGmAcqzYbivpR7z2fEe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxVWIHeuV57J9RMesi0j36PpkdWXu7fFZsXHcxtjvg6SD6LEA/6CJeFxGGSWDNbFC
	 xlFesC8XpFFDpWdfLiE8wAj3ULMWFO1fIn24Ot3T603B1raWNQGHEgRE1IlaQSDAEM
	 XxCx9nzJLTPHiHxfF/x6ibt06xvWOPATwlovkvIoFKqbUxVAcdsOwBGJFq9IsVIrr+
	 VnEmtedxD4mmSRHYFgwzikUR28XeeO1fsV+sf01HI1hw07yOPo7T28S6gmUqEDqlS8
	 uLJntrlCKSEOYAFS1oJyhmzClJqfDJdGBMAzoeGHvs9eHxVcZA+izUoFnaHODMUu8U
	 ioT9lwB3RMK8Q==
Date: Fri, 12 Apr 2024 12:22:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <ZhlRn0TUkcDaAZT5@x1>
References: <20240402094116.79751030@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402094116.79751030@canb.auug.org.au>

On Tue, Apr 02, 2024 at 09:41:16AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the perf tree, today's linux-next build (native i.e. ppc64le
> perf) failed like this:
> 
> make[3]: *** No rule to make target '/home/sfr/next/next/tools/include/uapi/linux/stat.h', needed by '/home/sfr/next/perf/libbpf/staticobjs/libbpf.o'.  Stop.

How is this built? Using O=/home/sfr/next/perf?
 
> Maybe caused by commit
> 
>   f122b3d6d179 ("perf beauty: Introduce scrape script for the 'statx' syscall 'mask' argument")
> 
> or
> 
>   a672af9139a8 ("tools headers: Remove almost unused copy of uapi/stat.h, add few conditional defines")
> 
> or a combination of them?
> 
> This is an incremental build but doing 'make -C tools/perf clean' and then
> rebuilding works, so maybe there is a dependency missing?

So I'm trying to revisit this, I did:

⬢[acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
⬢[acme@toolbox perf-tools-next]$ alias m='rm -rf ~/libexec/perf-core/ ; make -k CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin && perf test python'
⬢[acme@toolbox perf-tools-next]$ git remote update torvalds
Fetching torvalds
⬢[acme@toolbox perf-tools-next]$ m
<SNIP>
  LD      /tmp/build/perf-tools-next/perf-in.o
  CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
  LD      /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o
  LINK    /tmp/build/perf-tools-next/perf
  INSTALL binaries
  INSTALL tests
  INSTALL libperf-jvmti.so
  INSTALL libexec
  INSTALL perf-archive
  INSTALL perf-iostat
  INSTALL strace/groups
  INSTALL perl-scripts
  INSTALL python-scripts
  INSTALL dlfilters
  INSTALL perf_completion-script
  INSTALL perf-tip
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
 17: 'import perf' in python                                         : Ok
⬢[acme@toolbox perf-tools-next]$

Then left this there and merged perf-tools-next:

⬢[acme@toolbox perf-tools-next]$ git merge perf-tools-next
Auto-merging MAINTAINERS
Merge made by the 'ort' strategy.
 MAINTAINERS                                                            |    1 +
 tools/include/uapi/asm-generic/fcntl.h                                 |  221 -----------
 tools/include/uapi/linux/openat2.h                                     |   43 ---
 tools/lib/perf/cpumap.c                                                |   33 +-
 tools/lib/perf/include/perf/cpumap.h                                   |   16 +
 tools/lib/perf/libperf.map                                             |    4 +
<SNIP>
 tools/perf/util/vdso.c                                                 |   48 +--
 186 files changed, 7217 insertions(+), 3829 deletions(-)
 delete mode 100644 tools/include/uapi/asm-generic/fcntl.h
 delete mode 100644 tools/include/uapi/linux/openat2.h
 rename tools/{ => perf/trace/beauty}/arch/x86/include/asm/irq_vectors.h (100%)
 rename tools/{ => perf/trace/beauty}/arch/x86/include/uapi/asm/prctl.h (100%)
 create mode 100755 tools/perf/trace/beauty/clone.sh
 create mode 100644 tools/perf/trace/beauty/fs_at_flags.c
 create mode 100755 tools/perf/trace/beauty/fs_at_flags.sh
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/fcntl.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/fs.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/mount.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/prctl.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/sched.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/stat.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/usbdevice_fs.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/vhost.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/sound/asound.h (100%)
 create mode 100755 tools/perf/trace/beauty/statx_mask.sh
 create mode 100644 tools/perf/ui/browsers/annotate-data.c
 create mode 100644 tools/perf/util/disasm.c
 create mode 100644 tools/perf/util/disasm.h
⬢[acme@toolbox perf-tools-next]$ 

And:

⬢[acme@toolbox perf-tools-next]$ m
rm: cannot remove '/home/acme/libexec/perf-core/scripts/python/Perf-Trace-Util/lib/Perf/Trace/__pycache__/Core.cpython-312.pyc': Permission denied
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j28' parallel build
Warning: Kernel ABI header differences:
<SNIP>
Auto-detecting system features:
..                                   dwarf: [ on  ]
..                      dwarf_getlocations: [ on  ]
..                                   glibc: [ on  ]
..                                  libbfd: [ on  ]
..                          libbfd-buildid: [ on  ]
..                                  libcap: [ on  ]
..                                  libelf: [ on  ]
..                                 libnuma: [ on  ]
..                  numa_num_possible_cpus: [ on  ]
..                                 libperl: [ on  ]
..                               libpython: [ on  ]
..                               libcrypto: [ on  ]
..                               libunwind: [ on  ]
..                      libdw-dwarf-unwind: [ on  ]
..                             libcapstone: [ on  ]
..                                    zlib: [ on  ]
..                                    lzma: [ on  ]
..                               get_cpuid: [ on  ]
..                                     bpf: [ on  ]
..                                  libaio: [ on  ]
..                                 libzstd: [ on  ]

  GEN     /tmp/build/perf-tools-next/common-cmds.h
  LINK    /tmp/build/perf-tools-next/libperf-jvmti.so
  INSTALL /tmp/build/perf-tools-next/libsubcmd/include/subcmd/run-command.h
<SNIP>
INSTALL libbpf_headers
  LD      /tmp/build/perf-tools-next/libperf/libperf-in.o
  CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
  AR      /tmp/build/perf-tools-next/libperf/libperf.a
  GENSKEL /tmp/build/perf-tools-next/util/bpf_skel/augmented_raw_syscalls.skel.h
  GEN     /tmp/build/perf-tools-next/python/perf.cpython-312-x86_64-linux-gnu.so
  GEN     /tmp/build/perf-tools-next/pmu-events/pmu-events.c
  CC      /tmp/build/perf-tools-next/builtin-bench.o
  CC      /tmp/build/perf-tools-next/builtin-annotate.o
<SNIP>
  CC      /tmp/build/perf-tools-next/util/bpf-event.o
  CC      /tmp/build/perf-tools-next/util/bpf-utils.o
  CC      /tmp/build/perf-tools-next/util/pfm.o
  LD      /tmp/build/perf-tools-next/util/scripting-engines/perf-in.o
  LD      /tmp/build/perf-tools-next/util/perf-in.o
  LD      /tmp/build/perf-tools-next/perf-in.o
  CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
  LD      /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o
  LINK    /tmp/build/perf-tools-next/perf
  INSTALL binaries
  INSTALL tests
  INSTALL libperf-jvmti.so
  INSTALL libexec
  INSTALL perf-archive
  INSTALL perf-iostat
  INSTALL strace/groups
  INSTALL perl-scripts
  INSTALL python-scripts
  INSTALL dlfilters
  INSTALL perf_completion-script
  INSTALL perf-tip
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
 17: 'import perf' in python                                         : Ok
⬢[acme@toolbox perf-tools-next]$

⬢[acme@toolbox perf-tools-next]$ ls -la tools/include/uapi/linux/stat.h
ls: cannot access 'tools/include/uapi/linux/stat.h': No such file or directory
⬢[acme@toolbox perf-tools-next]$

I'm not being able to reproduce that problem, can you see where am I
doing some mistake in the above steps?

Thanks,

- Arnaldo

