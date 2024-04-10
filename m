Return-Path: <linux-kernel+bounces-139330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97EA8A017C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182FF28C908
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADF3181D10;
	Wed, 10 Apr 2024 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqVJLC0i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C36181CFA;
	Wed, 10 Apr 2024 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782248; cv=none; b=kFvl7q+s4c4l/MsGizeBPmjj0TANFQufgVnkOmApTAcJTmTJUBwMoPOViZMc/2YOTpwoqiegTnjQSY2oI3OqJrPe2GesQ+Wjf9vvyvgdRjchf43EGOFu91d4BkhJBQdK/jCYR0epgKshcS7we2+Z7OKa9hM2Nn4ff+95quJLuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782248; c=relaxed/simple;
	bh=rT0vmbF75kIM7dloTAwjPwfWBKwi587xTzBOd8ulHKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZSU5CRN/fpbsaKw+6dDHclGLsuof6TWIPcHe8q9PwkSLsrxlSuQj4e3SYmzlzIlba9EfqGVtuR3lwI69Q0ph7Xzl7QgUWpdxFIb1H5rRk4YRHwFQaR6jzexLMMEQwh+VHvBIZXHcoVIiV9+rONs6gpCCzGybUOCeEJ39zcgAC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqVJLC0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108A3C43390;
	Wed, 10 Apr 2024 20:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712782247;
	bh=rT0vmbF75kIM7dloTAwjPwfWBKwi587xTzBOd8ulHKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqVJLC0ikJ99L/HyISlWtap838nsv/qJ6vFcQ7/l6bPbGwlsK07AmFwjbiDoeP+M/
	 zFVmvdJFftBbsh30AQFq1mZy/x2Q59mGLHI+hoojnmTXRrFltO6MyYimWFHgv/7203
	 pf7xkXMZnnFBvnMvgrol/P8wKAfk1+eqQjUL8hreUGM/x/U7dfIUrb3rg7uAUW5P8A
	 h1BdWbSxLuVXZ/TCtjKd0ZDObOYNuD6QdWlp55V3UdhJQiVjTn/eHp5MgjMBzl7ZDA
	 tuY0VGJKJdq+YOi4SZWUQ+rCffaLL5YT3eJ4Uc8jYnxsjohb+PnwvsFDKijrTL59GQ
	 1fofX0qDCVWtg==
Date: Wed, 10 Apr 2024 17:50:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/6] perf report: Add a menu item to annotate data type
 in TUI
Message-ID: <Zhb7pPySSGnIU3bO@x1>
References: <20240409235000.1893969-1-namhyung@kernel.org>
 <20240409235000.1893969-6-namhyung@kernel.org>
 <Zhb6jJneP36Z-or0@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zhb6jJneP36Z-or0@x1>

On Wed, Apr 10, 2024 at 05:46:04PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 09, 2024 at 04:49:59PM -0700, Namhyung Kim wrote:
> > When the hist entry has the type info, it should be able to display the
> > annotation browser for the type like in `perf annotate --data-type`.
> 
> Trying to test this with:
> 
> root@number:~# perf report --header-only |& grep "perf record"
> # cmdline : /home/acme/bin/perf record -a -e {cpu_core/mem-loads,ldlat=30/P,cpu_core/mem-stores/P} 
> root@number:~# perf evlist -v
> cpu_core/mem-loads,ldlat=30/P: type: 4 (cpu_core), size: 136, config: 0x1cd (mem-loads), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, precise_ip: 2, sample_id_all: 1, { bp_addr, config1 }: 0x1f
> cpu_core/mem-stores/P: type: 4 (cpu_core), size: 136, config: 0x2cd (mem-stores), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, inherit: 1, freq: 1, precise_ip: 3, sample_id_all: 1
> dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
> root@number:~# perf report -s type
> 
> And when I press ESC to exit:
> 
> root@number:~# perf report -s type
> perf: Segmentation fault
> -------- backtrace --------
> perf[0x61326b]
> /lib64/libc.so.6(+0x3e9a0)[0x7f7173a5c9a0]
> /lib64/libc.so.6(free+0x25)[0x7f7173abd385]
> perf[0x5d5002]
> perf[0x4fd007]
> perf[0x523ce0]
> perf[0x525ad4]
> perf[0x503f43]
> perf[0x557ad4]
> perf[0x557eeb]
> perf[0x4e5355]
> perf[0x4dea42]
> perf[0x528aad]
> perf[0x42b559]
> perf[0x4c39e9]
> perf[0x4c3cf9]
> perf[0x410e47]
> /lib64/libc.so.6(+0x2814a)[0x7f7173a4614a]
> /lib64/libc.so.6(__libc_start_main+0x8b)[0x7f7173a4620b]
> perf[0x4113e5]
> root@number:~#
> 
> Trying to build with debug info...

Removing the O= dir and then trying with:

⬢[acme@toolbox perf-tools-next]$ alias m
alias m='rm -rf ~/libexec/perf-core/ ; make -k DEBUG=1 CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin && perf test python'
⬢[acme@toolbox perf-tools-next]$

I don't get a backtrace :-\ Ooops, sometimes I get it, but again without
resolving symbols:

root@number:~# perf report -s type
perf: Segmentation fault
-------- backtrace --------
perf[0x6b1087]
/lib64/libc.so.6(+0x3e9a0)[0x7fc15fa5c9a0]
/lib64/libc.so.6(free+0x25)[0x7fc15fabd385]
perf[0x66c2c0]
perf[0x66c363]
perf[0x553bc5]
perf[0x553d63]
perf[0x57ed76]
perf[0x58027e]
perf[0x5802bc]
perf[0x580325]
perf[0x5818aa]
perf[0x582241]
perf[0x58233c]
perf[0x5823fd]
perf[0x55c4ca]
perf[0x55c55f]
perf[0x5c36bf]
perf[0x5c1049]
perf[0x5c1197]
perf[0x5c7a4d]
perf[0x5c7ac7]
perf[0x531928]
perf[0x53196d]
perf[0x526a70]
perf[0x526b7d]
perf[0x585fd8]
perf[0x434503]
perf[0x5062c3]
perf[0x506532]
perf[0x506681]
perf[0x506978]
root@number:~#

Will try with gdb:

Lots of forks:

┌Merging related events...────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                 [  [                     from child process 2278982]                                                                                                        │
[Detaching after fork from child process 2278983]─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
[Detaching after fork from child process 2278984]
[Detaching after fork from child process 2278985]
[Detaching after fork from child process 2278986]
[Detaching after fork from child process 2278987]
[Detaching after fork from child process 2278988]
[Detaching after fork from child process 2278989]



                                                                                 ┌───────────────────────────┐                                                                                ▒
                                                                                 │Do you really want to exit?│                                                                                ▒
                                                                                 │                           │                                                                                ▒
                                                                                 │Enter: Yes, ESC: No        │                                                                                ▒
                                                                                 └───────────────────────────Program received signal SIGSEGV, Segmentation fault.                             ▒
                                                                                                                                                                 0x00007ffff6ebd385 in __GI___libc_free (mem=0x69647225202c3866) at malloc.c:3368                                                                                                                                            ▒
Downloading source file /usr/src/debug/glibc-2.38-17.fc39.x86_64/malloc/malloc.c                                                                                                              ▒
3368      if (chunk_is_mmapped (p))                       /* release mmapped memory. */                                                                                                        
(gdb) 

and:

(gdb) bt
#0  0x00007ffff6ebd385 in __GI___libc_free (mem=0x69647225202c3866) at malloc.c:3368                                                                                                          ▒
#1  0x000000000066c2c0 in delete_data_type_histograms (adt=0x8dedf0c0) at util/annotate-data.c:1655                                                                                           ▒
#2  0x000000000066c363 in annotated_data_type__tree_delete (root=0xe6bc68) at util/annotate-data.c:1669                                                                                       ▒
#3  0x0000000000553bc5 in dso__delete (dso=0xe6bbd0) at util/dso.c:1376                                                                                                                       ▒
#4  0x0000000000553d63 in dso__put (dso=0xe6bbd0) at util/dso.c:1409                                                                                                                          ▒
#5  0x000000000057ed76 in __dso__zput (dso=0xf5b540) at util/dso.h:262                                                                                                                        ▒
#6  0x000000000058027e in map__exit (map=0xf5b520) at util/map.c:300                                                                                                                          ▒
#7  0x00000000005802bc in map__delete (map=0xf5b520) at util/map.c:305cord -b ... ; perf report --total-cycles                                                                                ▒
#8  0x0000000000580325 in map__put (map=0xf5b520) at util/map.c:312
#9  0x00000000005818aa in __map__zput (map=0xf3e300) at util/map.h:196
#10 0x0000000000582241 in maps__exit (maps=0xf5aee0) at util/maps.c:246
#11 0x000000000058233c in maps__delete (maps=0xf5aee0) at util/maps.c:268
#12 0x00000000005823fd in maps__put (maps=0xf5aee0) at util/maps.c:285
#13 0x000000000055c4ca in __maps__zput (map=0x47856d8) at util/maps.h:32
#14 0x000000000055c55f in map_symbol__exit (ms=0x47856d8) at util/map_symbol.c:8
#15 0x00000000005c36bf in hist_entry__delete (he=0x4785660) at util/hist.c:1319
#16 0x00000000005c1049 in hists__delete_entry (hists=0xe68fe0, he=0x4785660) at util/hist.c:382
#17 0x00000000005c1197 in hists__delete_entries (hists=0xe68fe0) at util/hist.c:410
#18 0x00000000005c7a4d in hists__delete_all_entries (hists=0xe68fe0) at util/hist.c:2872
#19 0x00000000005c7ac7 in hists_evsel__exit (evsel=0xe68d70) at util/hist.c:2884
#20 0x0000000000531928 in evsel__exit (evsel=0xe68d70) at util/evsel.c:1489
#21 0x000000000053196d in evsel__delete (evsel=0xe68d70) at util/evsel.c:1497
#22 0x0000000000526a70 in evlist__purge (evlist=0xe67a00) at util/evlist.c:163
#23 0x0000000000526b7d in evlist__delete (evlist=0xe67a00) at util/evlist.c:185
#24 0x0000000000585fd8 in perf_session__delete (session=0xe670a0) at util/session.c:313
#25 0x0000000000434503 in cmd_report (argc=0, argv=0x7fffffffe430) at builtin-report.c:1828
#26 0x00000000005062c3 in run_builtin (p=0xe3f160 <commands+288>, argc=3, argv=0x7fffffffe430) at perf.c:350
#27 0x0000000000506532 in handle_internal_command (argc=3, argv=0x7fffffffe430) at perf.c:403
#28 0x0000000000506681 in run_argv (argcp=0x7fffffffe21c, argv=0x7fffffffe210) at perf.c:447
#29 0x0000000000506978 in main (argc=3, argv=0x7fffffffe430) at perf.c:561
(gdb) 

Continuing...

