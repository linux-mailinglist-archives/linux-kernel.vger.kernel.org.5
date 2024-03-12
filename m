Return-Path: <linux-kernel+bounces-100459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518928797CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081411F22365
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BA07C6EE;
	Tue, 12 Mar 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPgbUfxT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BFF7C09F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257945; cv=none; b=gfrkCIGQzmVBmJaAcdSgPmDzS4dVF/4eDCLep6AjSv1yhe5cvhbmaK7uAlH3rXiboDOabXovkGmRk6imckgU9xiw820h1BFB0Yi8Nq336ChD7zyDSYaeDQwCUYT/rYtBqDH8vujZFDwucjwePcfsNWFhMpuHxr5vX3B4FjCIySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257945; c=relaxed/simple;
	bh=XwxnpTlan0zBQfaw9W+X7oScY0H6x9GMOzWXczrEvYI=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=O/On1SGOZXBQ3u3A9SnDVqzXpTlvgqiL/Y5yejeqI4Pbn+ZY+rjD8tjOvfzCz6sYjbiSc/Fxo61HaRAPsOI77XCbvgBnb1IIcyhHjc1mkC0CSdw0rCkCmTLzp/u6LsB/WKMpfyCOp0y3EOxK+d2ww4N+6ZpjtHu95qpUNym/4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPgbUfxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8225BC433F1;
	Tue, 12 Mar 2024 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710257945;
	bh=XwxnpTlan0zBQfaw9W+X7oScY0H6x9GMOzWXczrEvYI=;
	h=Date:From:To:Cc:Subject:From;
	b=MPgbUfxTjANvUrptojgQ5B4sbePvKdE/vrcsrU9aN+1iwrhrykp0rN0U/DlhZmcbr
	 U9MBm1VYvx20av5MCRZ5ozmPAy5iZ+OU3HrV19ZREKBI9A7Cr+LOdJgTIDY+zW+Qw4
	 pJt9of91Ec706ZZTnSFl4lMIyclM1eZMiPw74eDKJtYv5BRvHjBLghbqiQEwxoe6bB
	 UHXptH/XIZqwECmgoSYKtRhy/2wcE/bEk8LFA5/kzMqleKcT3yw/bnWP+lAMXi85KL
	 7Rwf1KjJ5r/1IC/AllIcBm/t2Gs6dJc2ulYtIhe3k0YIyt48rsRyr2qhtrWbWD8nIS
	 GqTAUgpR15vmw==
Date: Wed, 13 Mar 2024 00:39:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jinghao Jia <jinghao7@illinois.edu>, Masami Hiramatsu (Google)
 <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Updates for v6.9
Message-Id: <20240313003901.de4b1b153688925ff5216c1a@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes updates for v6.9:

 - x96/kprobes: Use boolean for some function return instead of 0 and 1.
 - x86/kprobes: Prohibit probing on INT/UD. This prevents user to put kprobe on
    INTn/INT1/INT3/INTO and UD0/UD1/UD2 because these are used for a special
    purpose in the kernel.
 - x86/kprobes: Boost Grp instructions. Because a few percent of kernel
    instructions are Grp 2/3/4/5 and those are safe to be executed without
    ip register fixup, allow those to be boosted (direct execution on the
    trampoline buffer with a JMP).

 - tracing/probes: Add function argument access from return events (kretprobe
    and fprobe). This allows user to compare how a data structure field is
    changed after executing a function. With BTF, return event also accepts
    function argument access by name. This also includes below patches;
  . Fix a wrong comment (using "Kretprobe" in fprobe)
  . Cleanup a big probe argument parser function into three parts, type
     parser, post-processing function, and main parser.
  . Cleanup to set nr_args field when initializing trace_probe instead of
     counting up it while parsing.
  . Cleanup a redundant #else block from tracefs/README source code.
  . Update selftests to check entry argument access from return probes.
  . Documentation update about entry argument access from return probes.


Please pull the latest probes-v6.9 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-v6.9

Tag SHA1: 4c6745d26a2ff77a803db82beb2168f9c37b8f2b
Head SHA1: e8c32f24766a1f22da024e73d1eb8e9c822482ac


Jinghao Jia (3):
      x86/kprobes: Refactor can_{probe,boost} return type to bool
      x86/kprobes: Prohibit kprobing on INT and UD
      x86/kprobes: Boost more instructions from grp2/3/4/5

Masami Hiramatsu (Google) (7):
      tracing/fprobe-event: cleanup: Fix a wrong comment in fprobe event
      tracing/probes: Cleanup probe argument parser
      tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init
      tracing: Remove redundant #else block for BTF args from README
      tracing/probes: Support $argN in return probe (kprobe and fprobe)
      selftests/ftrace: Add test cases for entry args at function exit
      Documentation: tracing: Add entry argument access at function exit

----
 Documentation/trace/fprobetrace.rst                |  31 ++
 Documentation/trace/kprobetrace.rst                |   9 +
 arch/x86/kernel/kprobes/common.h                   |   2 +-
 arch/x86/kernel/kprobes/core.c                     |  98 +++--
 kernel/trace/trace.c                               |   5 +-
 kernel/trace/trace_eprobe.c                        |   8 +-
 kernel/trace/trace_fprobe.c                        |  59 ++-
 kernel/trace/trace_kprobe.c                        |  58 ++-
 kernel/trace/trace_probe.c                         | 417 +++++++++++++++------
 kernel/trace/trace_probe.h                         |  30 +-
 kernel/trace/trace_probe_tmpl.h                    |  10 +-
 kernel/trace/trace_uprobe.c                        |  14 +-
 .../ftrace/test.d/dynevent/fprobe_entry_arg.tc     |  18 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   4 +
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   2 +
 .../ftrace/test.d/kprobe/kretprobe_entry_arg.tc    |  18 +
 16 files changed, 584 insertions(+), 199 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_entry_arg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_entry_arg.tc


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

