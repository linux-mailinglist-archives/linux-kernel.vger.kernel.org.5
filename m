Return-Path: <linux-kernel+bounces-78761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6942086187C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBB0285C84
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AEA12883A;
	Fri, 23 Feb 2024 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UMCyR1rR"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4075585921
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707284; cv=none; b=lFPP2l2KT0601Kxf+8mhmyjb3S2ElgUZBKHbxBd/TMNXt0Uu3BvAGO5X7M8Ow93Ht6b0aPZSD6zxl5Y7j+9hI5FtLHlEIfav0FBH39SCG5jAUk+4hzLWfq8MplJXJ6U6gc0eEcTFXNJ4AusV4+xGjqusqrINKEcMOptcY7DoEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707284; c=relaxed/simple;
	bh=QI7uI1KXt8yAnEEZZxwT2Di4supb6fpRFy598XS/CQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtW+U4Tbd5Stm+KNk6QZP/EesI3+Hq59ZY+Lk6kqdxKoOpe8l5mxqscmByVrbGO2BDVHidnVWxXLJY8geedsCyFN3Hm+eeAQnRpuKY6dyDT3QwNMRIbzF8KrLvQVN+m2yjMSvyRGVJ9k4CwW8GXKoRNc3M4D5Y9WekVoA3von1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=UMCyR1rR; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1708707271;
	bh=QI7uI1KXt8yAnEEZZxwT2Di4supb6fpRFy598XS/CQc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UMCyR1rRF7rrqYAMi2ZfLgAUnlrvvYGg/pnBldF3PBhjkC5Vu/mN9Xxz4qNc8k7rq
	 eB/esg9zWFHwt8qnmyeGegzYFyK4O2AwyFA9V0Y60XdL2ZsoFKdjvhzJhb7F6m53NX
	 ifDYBIBoq7+i0rUtq9QHN8kqkCMJpJf60+lpyWeBSq/TBXk9tcS6OYUDLnttJ0r+Aq
	 2DJGWK8wv5a+nTtB25wfkniqB3o5oUqVo62lT05ZzW5XB02ZADItPy/0iLtKGA0eIQ
	 dWI0Ap7vwJvhqyv/186HNyYS2npoA2PEJj83x7YMZvnIoSaEMKuIFGCDyXkAEvpwBT
	 JyPGD4H3gSXQQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4ThGMB6c12zd2Q;
	Fri, 23 Feb 2024 11:54:30 -0500 (EST)
Message-ID: <c9427e40-10b1-49eb-9baa-dde1364e8fe5@efficios.com>
Date: Fri, 23 Feb 2024 11:54:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coredump debugging: add a tracepoint to report the
 coredumping
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Oleg Nesterov <oleg@redhat.com>, wenyang.linux@foxmail.com,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 lttng-dev <lttng-dev@lists.lttng.org>,
 Karim Yaghmour <karim.yaghmour@opersys.com>,
 Matthew Khouzam <matthew.khouzam@ericsson.com>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
 <20240217104924.GB10393@redhat.com>
 <20240219112926.77ac16f8@gandalf.local.home>
 <20240219170038.GA710@redhat.com>
 <20240219122825.31579a1e@gandalf.local.home>
 <776b842b-b19f-44bf-bc34-ac756fce7466@efficios.com>
 <20240223092630.49b9d367@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240223092630.49b9d367@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-23 09:26, Steven Rostedt wrote:
> On Mon, 19 Feb 2024 13:01:16 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Between "sched_process_exit" and "sched_process_free", the task can still be
>> observed by a trace analysis looking at sched and signal events: it's a zombie at
>> that stage.
> 
> Looking at the history of this tracepoint, it was added in 2008 by commit
> 0a16b60758433 ("tracing, sched: LTTng instrumentation - scheduler").
> Hmm, LLTng? I wonder who the author was?

[ common typo: LLTng -> LTTng ;-) ]

> 
>    Author: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> 
>   :-D
> 
> Mathieu, I would say it's your call on where the tracepoint can be located.
> You added it, you own it!

Wow! that's now 16 years ago :)

I've checked with Matthew Khouzam (maintainer of Trace Compass)
which care about this tracepoint, and we have not identified any
significant impact of moving it on its model of the scheduler, other
than slightly changing its timing.

I've also checked quickly in lttng-analyses and have not found
any code that care about its specific placement.

So I would say go ahead and move it earlier in do_exit(), it's
fine by me.

If you are interested in a bit of archeology, "sched_process_free"
originated from my ltt-experimental 0.1.99.13 kernel patch against
2.6.12-rc4-mm2 back in September 2005 (that's 19 years ago). It was
a precursor to the LTTng 0.x kernel patchset.

https://lttng.org/files/ltt-experimental/patch-2.6.12-rc4-mm2-ltt-exp-0.1.99.13.gz

Index: kernel/exit.c
===================================================================
--- a/kernel/exit.c	(.../trunk/kernel/linux-2.6.12-rc4-mm2)	(revision 41)
+++ b/kernel/exit.c	(.../branches/mathieu/linux-2.6.12-rc4-mm2)	(revision 41)
@@ -4,6 +4,7 @@
   *  Copyright (C) 1991, 1992  Linus Torvalds
   */
  
+#include <linux/ltt/ltt-facility-process.h>
  #include <linux/config.h>
  #include <linux/mm.h>
  #include <linux/slab.h>
@@ -55,6 +56,7 @@ static void __unhash_process(struct task
  	}
  
  	REMOVE_LINKS(p);
+  trace_process_free(p->pid);
  }
  
  void release_task(struct task_struct * p)
@@ -832,6 +834,8 @@ fastcall NORET_TYPE void do_exit(long co
  	}
  	exit_mm(tsk);
  
+	trace_process_exit(tsk->pid);
+
  	exit_sem(tsk);
  	__exit_files(tsk);
  	__exit_fs(tsk);

This was a significant improvement over the prior LTT which only
had the equivalent of "sched_process_exit", which caused issues
with the Linux scheduler model in LTTV due to zombie processes.

Here is where it appeared in LTT back in 1999:

http://www.opersys.com/ftp/pub/LTT/TracePackage-0.9.0.tgz

patch-ltt-2.2.13-991118

diff -urN linux/kernel/exit.c linux-2.2.13/kernel/exit.c
--- linux/kernel/exit.c	Tue Oct 19 20:14:02 1999
+++ linux-2.2.13/kernel/exit.c	Sun Nov  7 23:49:17 1999
@@ -14,6 +14,8 @@
  #include <linux/acct.h>
  #endif
  
+#include <linux/trace.h>
+
  #include <asm/uaccess.h>
  #include <asm/pgtable.h>
  #include <asm/mmu_context.h>
@@ -386,6 +388,8 @@
  	del_timer(&tsk->real_timer);
  	end_bh_atomic();
  
+	TRACE_PROCESS(TRACE_EV_PROCESS_EXIT, 0, 0);
+
  	lock_kernel();
  fake_volatile:
  #ifdef CONFIG_BSD_PROCESS_ACCT

And it was moved to its current location (after exit_mm()) a bit
later (2001):

http://www.opersys.com/ftp/pub/LTT/TraceToolkit-0.9.5pre2.tgz

Patches/patch-ltt-linux-2.4.5-vanilla-010909-1.10

diff -urN linux/kernel/exit.c /ext2/home/karym/kernel/linux-2.4.5/kernel/exit.c
--- linux/kernel/exit.c	Fri May  4 17:44:06 2001
+++ /ext2/home/karym/kernel/linux-2.4.5/kernel/exit.c	Wed Jun 20 12:39:24 2001
@@ -14,6 +14,8 @@
  #include <linux/acct.h>
  #endif
  
+#include <linux/trace.h>
+
  #include <asm/uaccess.h>
  #include <asm/pgtable.h>
  #include <asm/mmu_context.h>
@@ -439,6 +441,8 @@
  #endif
  	__exit_mm(tsk);
  
+	TRACE_PROCESS(TRACE_EV_PROCESS_EXIT, 0, 0);
+
  	lock_kernel();
  	sem_exit();
  	__exit_files(tsk);

So this sched_process_exit placement was actually decided
by Karim Yaghmour back in the LTT days (2001). I don't think
he will mind us moving it around some 23 years later. ;)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


