Return-Path: <linux-kernel+bounces-141439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA128A1E44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23151F253EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA4F824A6;
	Thu, 11 Apr 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlHKgg+D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51C1E892;
	Thu, 11 Apr 2024 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858575; cv=none; b=X25fekGtZilgD2zflJ86HnlxRCP/QdGWa6yKPRIjskFZ7nzW7BsUEGazbmO9LaBFLl4XsATlg0OpSjACmRxuid/mEHrYyS3q/52sfn9XayIxu9aXKtL1WO4ot1cAtfBdLl8YmSjs0sKQroTi7WZVezbQmSDOiNTYW7PE9lGolLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858575; c=relaxed/simple;
	bh=Y053hDNWDdlbJKBy+lcyQdE5G+tWn3OYigsAOCjGI2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bV+/qVfCy9C7as5//Qxu8IMdO45CCX1EROCi1OIH5Vmo0DQ1giUztxYwAo8cZ4H3ILfTSI9hlYNkdE4I9DfiESpELh6VeFchuy+L5JtAx75LZgGAiCnIzfe0qHizLfCIJrYXPnd4Var+RtBUloikG+0Hv+ZSqVTFsDqI3yCOAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlHKgg+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824FEC072AA;
	Thu, 11 Apr 2024 18:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712858574;
	bh=Y053hDNWDdlbJKBy+lcyQdE5G+tWn3OYigsAOCjGI2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IlHKgg+DA76Z0el5BLc3rN5PNpOY4yjbfGZWw9CSxcLHd9Lqqr3eoHns/FznGEI9m
	 lrNBtvtjqn0DF3T6tu/loQbTxP01dY2r1Gt5ivenxQSyfpbRGsxC8dkl228WZLVNm7
	 k0DCElk+AANvACFK86ZxCCpG7c9+xYDbXw3DTQSedXRlB0L003tl+JM1mlUxppotHa
	 1FbDtGiu1/q3kzFBBXrKiXXPKXE4xIRoOnAZ3AbiImQ2kNVyCMWzmTUb9uMCgl+0/5
	 Wej3FgCChUWaVL4cD+Z2EaYO7FTR5sGrxbee1BfiA96J75oSg4PWtMXkjrAR/cihYs
	 k5keqvmfsxaZA==
Date: Thu, 11 Apr 2024 15:02:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: BISECTED: perf test -v "Test data symbol" failing on Intel
 Hybrid systems
Message-ID: <Zhgly2eQ5vk4FdEE@x1>
References: <ZhWTIuyB9p1ORbQH@x1>
 <CAP-5=fXR0HmxUBvTbPN4GPdqFftYAGsgYHm81+TgmGY7Yh4gww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXR0HmxUBvTbPN4GPdqFftYAGsgYHm81+TgmGY7Yh4gww@mail.gmail.com>

On Tue, Apr 09, 2024 at 02:28:43PM -0700, Ian Rogers wrote:
> On Tue, Apr 9, 2024 at 12:12 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > root@x1:~# grep -m1 "model name" /proc/cpuinfo
> > model name      : 13th Gen Intel(R) Core(TM) i7-1365U
> > root@x1:~# uname -a
> > Linux x1 6.7.11-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Mar 27 16:50:39 UTC 2024 x86_64 GNU/Linux
> > root@x1:~#
> >
> > Bisected down to:
> >
> > commit 5752c20f3787c9bc9ff9411a70b3d41add85518c
> > Author: Ravi Bangoria <ravi.bangoria@amd.com>
> > Date:   Thu Jun 15 10:47:00 2023 +0530
> >
> >     perf mem: Scan all PMUs instead of just core ones
> >
> >     Scanning only core PMUs is not sufficient on platforms like AMD since
> >     perf mem on AMD uses IBS OP PMU, which is independent of core PMU.
> >     Scan all PMUs instead of just core PMUs. There should be negligible
> >     performance overhead because of scanning all PMUs, so we should be okay.
> >
> >     Reviewed-by: Ian Rogers <irogers@google.com>
> >     Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> >
> > root@x1:~# perf -v ; perf test -v "Test data symbol"
> > perf version 6.4.rc3.g5752c20f3787
> > 111: Test data symbol                                                :
> > --- start ---
> > test child forked, pid 522202
> > Recording workload...
> > malloc_consolidate(): invalid chunk size
> > /home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh: line 60: 522208 Aborted                 (core dumped) perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM
> > /home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh: line 62: kill: (522208) - No such process
> > Cleaning up files...
> > test child finished with -1
> > ---- end ----
> > Test data symbol: FAILED!
> > root@x1:~# perf -v ; perf test -v "Test data symbol"
> > perf version 6.8.g63c22868714b
> > 116: Test data symbol:
> > --- start ---
> > test child forked, pid 526540
> >  954300-954339 l buf1
> > perf does have symbol 'buf1'
> > Recording workload...
> > Waiting for "perf record has started" message
> > OK
> > Cleaning up files...
> > ---- end(-1) ----
> > 116: Test data symbol                                                : FAILED!
> > root@x1:~#
> >
> > Further details:
> >
> > (gdb) run mem record --all-user sleep 1
> > Starting program: /root/bin/perf mem record --all-user sleep 1
> >
> >
> > This GDB supports auto-downloading debuginfo from the following URLs:
> >   <https://debuginfod.fedoraproject.org/>
> > Enable debuginfod for this session? (y or [n]) y
> > Debuginfod has been enabled.
> > To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
> > [Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/lib64/libthread_db.so.1".
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x0000000000611860 in perf_mem_events__record_args (rec_argv=0xea8280, argv_nr=0x7fffffffd6bc, rec_tmp=0xebbda0, tmp_nr=0x7fffffffd6c0) at util/mem-events.c:213
> > 213                                     s = perf_mem_events__name(j, pmu->name);
> > (gdb) bt
> > #0  0x0000000000611860 in perf_mem_events__record_args (rec_argv=0xea8280, argv_nr=0x7fffffffd6bc, rec_tmp=0xebbda0, tmp_nr=0x7fffffffd6c0) at util/mem-events.c:213
> > #1  0x000000000045c47f in __cmd_record (argc=2, argv=0x7fffffffe420, mem=0x7fffffffda20) at builtin-mem.c:152
> > #2  0x000000000045d69b in cmd_mem (argc=4, argv=0x7fffffffe420) at builtin-mem.c:514
> > #3  0x00000000004ffe38 in run_builtin (p=0xe08aa0 <commands+672>, argc=5, argv=0x7fffffffe420) at perf.c:323
> > #4  0x00000000005000ac in handle_internal_command (argc=5, argv=0x7fffffffe420) at perf.c:377
> > #5  0x00000000005001fb in run_argv (argcp=0x7fffffffe23c, argv=0x7fffffffe230) at perf.c:421
> > #6  0x00000000005004e8 in main (argc=5, argv=0x7fffffffe420) at perf.c:537
> > (gdb) list -5
> > file: "arch/x86/util/mem-events.c", line number: 208, symbol: "???"
> > Line number 203 out of range; arch/x86/util/mem-events.c has 93 lines.
> > (gdb)

> >
> >
> > (gdb) list -5
> > file: "arch/x86/util/mem-events.c", line number: 208, symbol: "???"
> > Line number 203 out of range; arch/x86/util/mem-events.c has 93 lines.
> > (gdb) p j
> > $1 = 0
> > (gdb) p pmu->name
> > Cannot access memory at address 0x64ffffff9c
> > (gdb)
> >
> > 183 int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
> > 184                                  char **rec_tmp, int *tmp_nr)
> > 185 {
> > 186         int i = *argv_nr, k = 0;
> > 187         struct perf_mem_event *e;
> > 188         struct perf_pmu *pmu;
> > 189         char *s;
> > 190
> > 191         for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> > 192                 e = perf_mem_events__ptr(j);
> > 193                 if (!e->record)
> > 194                         continue;
> > 195
> > 196                 if (perf_pmus__num_mem_pmus() == 1) {
> > 197                         if (!e->supported) {
> > 198                                 pr_err("failed: event '%s' not supported\n",
> > 199                                        perf_mem_events__name(j, NULL));
> > 200                                 return -1;
> > 201                         }
> > 202
> > 203                         rec_argv[i++] = "-e";
> > 204                         rec_argv[i++] = perf_mem_events__name(j, NULL);
> > 205                 } else {
> > 206                         if (!e->supported) {
> > 207                                 perf_mem_events__print_unsupport_hybrid(e, j);
> > 208                                 return -1;
> > 209                         }
> > 210
> > 211                         while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> > 212                                 rec_argv[i++] = "-e";
> > 213                                 s = perf_mem_events__name(j, pmu->name);
> > 214                                 if (s) {
> > 215                                         s = strdup(s);
> 
> This looks like something that address/memory sanitizers could help with.

I'm I forgetting something?

⬢[acme@toolbox perf-tools-next]$ rm -rf ~/libexec/perf-core/ ; make -k CORESIGHT=1 EXTRA_CFLAGS="-fsanitize=address" O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin

root@x1:~# perf test -v 116
116: Test data symbol:
--- start ---
test child forked, pid 614595
 f87540-f87579 l buf1
perf does have symbol 'buf1'
Recording workload...
Waiting for "perf record has started" message
OK
Cleaning up files...
---- end(-1) ----
116: Test data symbol                                                : FAILED!
root@x1:~# ldd ~/bin/perf | grep asan
	libasan.so.8 => /lib64/libasan.so.8 (0x00007f8eb7a00000)
root@x1:~#

