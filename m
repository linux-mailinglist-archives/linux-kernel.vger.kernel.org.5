Return-Path: <linux-kernel+bounces-31130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1E8832979
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E466C2864BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1524F206;
	Fri, 19 Jan 2024 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+potGob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38A3C6BF;
	Fri, 19 Jan 2024 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667338; cv=none; b=jPUKraoPLNDhYRlodT4q1q9hiUgZN8ugNFMnmi6sPDHyVLc8erNSfUyWCuD4iGAbEzeqqdaMS68NYoeVbmqLCX7Z7VyefxKCbc2ZHKsCFOlOUlICLygJyBg0E2n5fVvezRt7ZIx4KnGCqXOQd8S20O2pXi7GisLD9yrx39sd6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667338; c=relaxed/simple;
	bh=JgYn9wLiSMmiNGhXSTl8fgIB2xZaj38sx2xGMu9Q5f4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ul1HdZnODI74ymTBd/2tNziSIjaWN5rfMgZWdWhkMGIa7bW9JG7L9KjwrdQKTRDRr0vOczgB/lpw+ANQe2xumxX/uoWIIq80tAcj9Cxh5xhzEdWNFUafO1APfm+82adPsX7DhGXOzWd+0SL65t8OWWkC9Az2PdsvS8Ob2p3IG7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+potGob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A892C433C7;
	Fri, 19 Jan 2024 12:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705667338;
	bh=JgYn9wLiSMmiNGhXSTl8fgIB2xZaj38sx2xGMu9Q5f4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p+potGobznUdXgGX70MhZqjxI4wwi+A+46olJGC5jCZGgsLuoJPJDr44LJeUh5cLg
	 crjE3n/9fSfRnnwE892n1ONlXESTR2SSVdybvhjk3b3fDBe3Lq7jpBR/j4GxpIGiRg
	 dd9N7IaAUusbFMfT9G3vaUJ5YQ3PNUJcJizVgO2Bm04qAsmnnbt1oo9njLKnohZTct
	 nxLzQvHloRLjbNH14qPmd4p2t1kz3Gqc2NjMkdKX8/jx/5dnp21PYYnxbxSDtqwEIx
	 cO4SgECkk1fAEEqJNHWoQ8DD4mqCvKLjRz9zg+Hlvt7e0lCqJVnIKAUM4RhcpbQl6+
	 qXwV02kGCOM2w==
Date: Fri, 19 Jan 2024 21:28:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Chen Zhongjin <chenzhongjin@huawei.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <yangjihong1@huawei.com>,
 <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
 <davem@davemloft.net>, <paulmck@kernel.org>, <mhiramat@kernel.org>,
 <akpm@linux-foundation.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
 <pmladek@suse.com>, <dianders@chromium.org>, <npiggin@gmail.com>,
 <mpe@ellerman.id.au>, <jkl820.git@gmail.com>,
 <juerg.haefliger@canonical.com>, <rick.p.edgecombe@intel.com>,
 <eric.devolder@oracle.com>, <mic@digikod.net>
Subject: Re: [PATCH v2] kprobes: Use synchronize_rcu_tasks_rude in
 kprobe_optimizer
Message-Id: <20240119212850.a46eeaec8083770c5abad81a@kernel.org>
In-Reply-To: <20240117212646.5f0ddf0c@gandalf.local.home>
References: <20240118021842.290665-1-chenzhongjin@huawei.com>
	<20240117212646.5f0ddf0c@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 21:26:46 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 18 Jan 2024 02:18:42 +0000
> Chen Zhongjin <chenzhongjin@huawei.com> wrote:
> 
> > There is a deadlock scenario in kprobe_optimizer():
> > 
> > pid A				pid B			pid C
> > kprobe_optimizer()		do_exit()		perf_kprobe_init()
> > mutex_lock(&kprobe_mutex)	exit_tasks_rcu_start()	mutex_lock(&kprobe_mutex)
> > synchronize_rcu_tasks()		zap_pid_ns_processes()	// waiting kprobe_mutex
> > // waiting tasks_rcu_exit_srcu	kernel_wait4()
> > 				// waiting pid C exit
> > 
> > To avoid this deadlock loop, use synchronize_rcu_tasks_rude() in kprobe_optimizer()
> > rather than synchronize_rcu_tasks(). synchronize_rcu_tasks_rude() can also promise
> > that all preempted tasks have scheduled, but it will not wait tasks_rcu_exit_srcu.
> > 

At first, thanks for finding this scenario! 

> 
> Did lockdep detect this? If not, we should fix that.

Can lockdep find rcu and wait4 related one?

> 
> I'm also thinking if we should find another solution, as this seems more of
> a work around than a fix.

Hmm, IIUC, we may need a synchronizer which will return -EBUSY if
someone starts waiting in exit_tasks_rcu_start(). Then optimizer 
can unlock the mutex and retry it.

Thank you,

> 
> > Fixes: a30b85df7d59 ("kprobes: Use synchronize_rcu_tasks() for optprobe with CONFIG_PREEMPT=y")
> > Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > ---
> > v1 -> v2: Add Fixes tag
> > ---
> >  arch/Kconfig     | 2 +-
> >  kernel/kprobes.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index f4b210ab0612..dc6a18854017 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -104,7 +104,7 @@ config STATIC_CALL_SELFTEST
> >  config OPTPROBES
> >  	def_bool y
> >  	depends on KPROBES && HAVE_OPTPROBES
> > -	select TASKS_RCU if PREEMPTION
> > +	select TASKS_RUDE_RCU
> 
> Is this still a bug if PREEMPTION is not enabled?
> 
> -- Steve
> 
> >  
> >  config KPROBES_ON_FTRACE
> >  	def_bool y
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index d5a0ee40bf66..09056ae50c58 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -623,7 +623,7 @@ static void kprobe_optimizer(struct work_struct *work)
> >  	 * Note that on non-preemptive kernel, this is transparently converted
> >  	 * to synchronoze_sched() to wait for all interrupts to have completed.
> >  	 */
> > -	synchronize_rcu_tasks();
> > +	synchronize_rcu_tasks_rude();
> >  
> >  	/* Step 3: Optimize kprobes after quiesence period */
> >  	do_optimize_kprobes();
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

