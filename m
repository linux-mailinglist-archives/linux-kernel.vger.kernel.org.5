Return-Path: <linux-kernel+bounces-108522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C7A880BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54001F23956
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD551EB23;
	Wed, 20 Mar 2024 07:05:37 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96475A40
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918337; cv=none; b=hRb3kxQ4/2sFk3E6SoS7NdZ+R4rZiNN6K68lkxRVaLRtQeDIee9wwf4Bl6O8tlOxJ8AlvqKHvpxNqOSqt+BHVmNrwjwH+DlBnGIlSk/lts77989pUARNfk85cEzmyZDDBQm6EoKn7nkD4JynxeLgtPjPlOMG9HKTbCThn6HDW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918337; c=relaxed/simple;
	bh=D40fDv1ukzQQBwwTxmoTvTU/H5ZTXMg5Io2Qu+SEf38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avGbiLiqlePucxMYBtzeW6sh5bRZoAzJ4EeiBKKJfioJ0uyuMLV2ShRKc8eLJcTBcDjNJushgNwIK2RQvIjRQR/tkUXJpe7sFT4IHFkAPWgbqtCVQ1tKY+OgzUMt6AnscALqdgOXLGDLBuLnSaVLndW8UTgoaa4/oFUOIOlZo1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42K74thc000289;
	Wed, 20 Mar 2024 16:04:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Wed, 20 Mar 2024 16:04:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42K74tO8000285
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 20 Mar 2024 16:04:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <596aad11-ee69-4ef1-b945-7b67a9fb22d7@I-love.SAKURA.ne.jp>
Date: Wed, 20 Mar 2024 16:04:54 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] possible deadlock in console_flush_all (2)
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness
 <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <000000000000e40a2906072e9567@google.com>
 <ab273ae2-80ec-45da-910a-e74298c71d50@I-love.SAKURA.ne.jp>
 <CAADnVQLmLMt2bF9aAB26dtBCvy2oUFt+AAKDRgTTrc7Xk_zxJQ@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAADnVQLmLMt2bF9aAB26dtBCvy2oUFt+AAKDRgTTrc7Xk_zxJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/20 15:56, Alexei Starovoitov wrote:
> This has nothing to do with bpf.
> bpf never calls printk().

Please see the Sample crash report in the dashboard.
bpf program is hitting printk() via report_bug().

-> #0 (console_owner){....}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       console_lock_spinning_enable kernel/printk/printk.c:1873 [inline]
       console_emit_next_record kernel/printk/printk.c:2901 [inline]
       console_flush_all+0x810/0xfd0 kernel/printk/printk.c:2973
       console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3042
       vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2342
       _printk+0xd5/0x120 kernel/printk/printk.c:2367
       __report_bug lib/bug.c:195 [inline]
       report_bug+0x346/0x500 lib/bug.c:219
       handle_bug+0x3e/0x70 arch/x86/kernel/traps.c:239
       exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:260
       asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
       __local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
       spin_unlock_bh include/linux/spinlock.h:396 [inline]
       __sock_map_delete net/core/sock_map.c:424 [inline]
       sock_map_delete_elem+0xca/0x140 net/core/sock_map.c:446
       bpf_prog_2c29ac5cdc6b1842+0x42/0x46
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run4+0x25a/0x490 kernel/trace/bpf_trace.c:2422
       trace_sched_switch include/trace/events/sched.h:222 [inline]
       __schedule+0x250b/0x49d0 kernel/sched/core.c:6733
       __schedule_loop kernel/sched/core.c:6813 [inline]
       schedule+0x14b/0x320 kernel/sched/core.c:6828
       ptrace_stop+0x5b4/0x940 kernel/signal.c:2358
       ptrace_do_notify kernel/signal.c:2395 [inline]
       ptrace_notify+0x255/0x380 kernel/signal.c:2407
       ptrace_report_syscall include/linux/ptrace.h:415 [inline]
       ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
       syscall_exit_work+0xbd/0x170 kernel/entry/common.c:167
       syscall_exit_to_user_mode_prepare kernel/entry/common.c:194 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:199 [inline]
       syscall_exit_to_user_mode+0x273/0x360 kernel/entry/common.c:212
       do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x6d/0x75


