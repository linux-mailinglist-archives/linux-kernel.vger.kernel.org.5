Return-Path: <linux-kernel+bounces-109052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD948813FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9CF1F24262
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2624C629;
	Wed, 20 Mar 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGjULKox"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17164AEC3;
	Wed, 20 Mar 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946819; cv=none; b=BjxA447RypsxG8hhPxQ1MFnMY/ugxoIhSwLq7VezNMbwCPD0MYA7sLkxxJ3zHS7u0xwzTbjOE8i1/WcwQLgqpvXgmLp10YsjBlWpchYwbp+eW2xHCBqSmEmRtBooila4bIFED4eVt6z/tDxH+ajXESFqEwGC/4ZZOdhTNP51mCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946819; c=relaxed/simple;
	bh=7naKemsKKoX1Qcb7rvXqIykV5KktCI6MWuU+9KcgL8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuQvvTpZNkRUIQtLr2vHNPTnGItzukKe5Bop+DzAyUpFEXKKo+lwfsJnQVKaO0EjAhODvirGbAnFSYHUPx+Ib05OXvh40jV6X0TpR9aRXDFF40jtiNzUI4Amlx08RYp2uLpplsPl6yUZ5YpEczqjU58bn9F+MnvTzIilB+nkYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGjULKox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F91C433F1;
	Wed, 20 Mar 2024 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710946819;
	bh=7naKemsKKoX1Qcb7rvXqIykV5KktCI6MWuU+9KcgL8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGjULKox9mIbDG/r7G7C+ik9Y9Lc+MXiLEScDXIRBrjZP4a9Qhj1kQHbT/82ZUq4l
	 mw0Fdouqg5Vpm3JV5bjGhCY/QdGNOXB+HVKVDYGc0Y8gJQ222tj5zIzeuExkouCpv9
	 qsBN9NjEYXha73Z5LBUXQs7EaPhi0DqkZxQRfeALxPW1o0RmKqQ3eDmp1UyBtgQMC6
	 HioAaSuXupnbRUxck1vhoZ6sD4fkP4gLtgubQX2iyGKlelB1IfmK3SDLU3AfPBKI2r
	 Y2LItBhI9v/NL05n1AtAlZl2uDPuitFYQrPaB6HOS0x5XhX4709C29u3g1ssE9PeH2
	 COX6rJE9P9ZgQ==
Date: Wed, 20 Mar 2024 12:00:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: Suggest inbuilt commands for unknown command
Message-ID: <Zfr5__Ej3-0C8sJj@x1>
References: <20240301201306.2680986-1-irogers@google.com>
 <Zfr4jX_b8FCOG_x_@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zfr4jX_b8FCOG_x_@x1>

On Wed, Mar 20, 2024 at 11:54:09AM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 01, 2024 at 12:13:05PM -0800, Ian Rogers wrote:
> > The existing unknown command code looks for perf scripts like
> > perf-archive.sh and perf-iostat.sh, however, inbuilt commands aren't
> > suggested. Add the inbuilt commands so they may be suggested too.
> > 
> > Before:
> > ```
> > $ perf reccord
> > perf: 'reccord' is not a perf-command. See 'perf --help'.
> > ```
> > 
> > After:
> > ```
> > $ perf reccord
> > perf: 'reccord' is not a perf-command. See 'perf --help'.
> > 
> > Did you mean this?
> >         record
> > ```
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > v2. Drops a merged patch and rebases. No functional change. Arnaldo
> >     reported the patch not working for him, but I've not found a
> 
> Not working:
> 
> root@number:~# perf reccord
> Failed to run command 'reccord': No such file or directory
> root@number:~# 
> 
> ⬢[acme@toolbox perf-tools-next]$ git log --oneline -1
> a65ef8052854ba75 (HEAD) perf: Suggest inbuilt commands for unknown command
> ⬢[acme@toolbox perf-tools-next]$
> 
> I use O= with install-bin, trying:
> 
> ⬢[acme@toolbox perf-tools-next]$ make -C  tools/perf install-bin
> ⬢[acme@toolbox perf-tools-next]$ perf raccord
> Failed to run command 'raccord': No such file or directory
> ⬢[acme@toolbox perf-tools-next]$
> 
> Also didn't work
> 
> Trying to figure this out...

It somehow gets done_help set to 32767, and this will not run help_unknown_cmd(), continuing after a conf call...

(gdb) p *argv
$7 = 0x7fffffffe4c5 "raccord"
(gdb) s
run_argv (argcp=0x7fffffffdfbc, argv=0x7fffffffdfb0) at perf.c:445
445	{
(gdb) n
447		handle_internal_command(*argcp, *argv);
(gdb) n
450		execv_dashed_external(*argv);
(gdb) p *argv
$8 = (const char **) 0x7fffffffe1d0
(gdb) p **argv
$9 = 0x7fffffffe4c5 "raccord"
(gdb) n
[Detaching after fork from child process 3245070]
451		return 0;
(gdb) n
452	}
(gdb) n
main (argc=1, argv=0x7fffffffe1d0) at perf.c:565
565			if (errno != ENOENT)
(gdb) p; errno
Invalid character ';' in expression.
(gdb) p errno
$10 = 2
(gdb) n
568			if (!done_help) {
(gdb) p done_help
$11 = 32767
(gdb) list
563			run_argv(&argc, &argv);
564	
565			if (errno != ENOENT)
566				break;
567	
568			if (!done_help) {
569				struct cmdnames main_cmds;
570	
571				for (unsigned int i = 0; i < ARRAY_SIZE(commands); i++) {
572					add_cmdname(&main_cmds,
(gdb) 
573						    commands[i].cmd,
574						    strlen(commands[i].cmd));
575				}
576				cmd = argv[0] = help_unknown_cmd(cmd, &main_cmds);
577				clean_cmdnames(&main_cmds);
578				done_help = 1;
579				if (!cmd)
580					break;
581			} else
582				break;
(gdb)

