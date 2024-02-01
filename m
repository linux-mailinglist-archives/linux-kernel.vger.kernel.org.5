Return-Path: <linux-kernel+bounces-48587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D8C845E78
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C3D1F278A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBDC6308D;
	Thu,  1 Feb 2024 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9YFSYwk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50363070
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808316; cv=none; b=pFZDoWxlGwgFWggyBc1aEae+39v04Hfwefiib2+/iNi5Xt/5oyrjp1SDt0M5R8+xkQcr4TnF4n1sgIAJ7m4gzmOWGc8+g3iepcAQWdlmpKXofHOqD2a6he918uQB9ediwd8jSP/poQqN/m9/bW1lD195obh70bHIda0v6gZ0D78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808316; c=relaxed/simple;
	bh=tBYk8YykMIVRr0v+B9NPNqXN+hKhdmu2UDa/5IsXif4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQMn1C5IA3t/sHXgxTtUtOyzsLD7dQqJ4Kq1gLkZ/naKkdhGTQPg3B5g4lM7sY78otTtXufbRAyU65I3jsgnn8DG9vlZc0BqVjPKYSa4hTk6goBQPwLNIT69qkFDsjz/q2KAhb6nfPTcNbnNt9M5uCSLP/dJufSEUgvnhYXuJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9YFSYwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB186C43390;
	Thu,  1 Feb 2024 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706808316;
	bh=tBYk8YykMIVRr0v+B9NPNqXN+hKhdmu2UDa/5IsXif4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9YFSYwkgW019Zluy29Rk4B3/9gTuq98RqDTpxJc1HTY+UVyJ4ieKq8oMZBy4utBP
	 VmiFfxEjMQnSQwq9NhJNK1HKTBuKtdhMejJqYnlgSezsPHYzO7Asb09N2v+fRnvP4q
	 EzO7p9tffzg1td+0X/7R6DRZgR1An+EfK1N7lFKHuSEE75vl9edkeYe0sL8j0LgHLp
	 Nnd8vJsG5OF+HQuo1ruzVXpVhKfpWRkZYywFBtSxIYzW6+oVGmy+MrEn091iBvqnBG
	 zEyGX4RQl2b74VLu1nXcYYNnAt5nVCqFI/5IurK1sk1CmmLgZm1MXG0fN0WpBivndE
	 M0Y1z1m5wK5sA==
Date: Thu, 1 Feb 2024 18:25:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240201-dokumentieren-holen-bc44288345b5@brauner>
References: <20240131132541.GA23632@redhat.com>
 <20240131132602.GA23641@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240131132602.GA23641@redhat.com>

On Wed, Jan 31, 2024 at 02:26:02PM +0100, Oleg Nesterov wrote:
> With this flag:
> 
> 	- pidfd_open() doesn't require that the target task must be
> 	  a thread-group leader
> 
> 	- pidfd_poll() succeeds when the task exits and becomes a
> 	  zombie (iow, passes exit_notify()), even if it is a leader
> 	  and thread-group is not empty.
> 
> 	  This means that the behaviour of pidfd_poll(PIDFD_THREAD,
> 	  pid-of-group-leader) is not well defined if it races with
> 	  exec() from its sub-thread; pidfd_poll() can succeed or not
> 	  depending on whether pidfd_task_exited() is called before
> 	  or after exchange_tids().
> 
> 	  Perhaps we can improve this behaviour later, pidfd_poll()
> 	  can probably take sig->group_exec_task into account. But
> 	  this doesn't really differ from the case when the leader
> 	  exits before other threads (so pidfd_poll() succeeds) and
> 	  then another thread execs and pidfd_poll() will block again.
> 
> thread_group_exited() is no longer used, perhaps it can die.
> 
> Co-developed-by: Tycho Andersen <tycho@tycho.pizza>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  fs/exec.c                  |  6 +++++-
>  include/linux/pid.h        |  3 ++-
>  include/uapi/linux/pidfd.h |  3 ++-
>  kernel/exit.c              |  7 +++++++
>  kernel/fork.c              | 38 +++++++++++++++++++++++++++++++-------
>  kernel/pid.c               | 14 +++-----------
>  kernel/signal.c            |  6 ++++--
>  7 files changed, 54 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 73e4045df271..0fd7e668c477 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1143,7 +1143,11 @@ static int de_thread(struct task_struct *tsk)
>  
>  		BUG_ON(leader->exit_state != EXIT_ZOMBIE);
>  		leader->exit_state = EXIT_DEAD;
> -
> +		/*
> +		 * leader and tsk exhanged their pids, the old pid dies,
> +		 * wake up the PIDFD_THREAD waiters.
> +		 */
> +		do_notify_pidfd(leader);
>  		/*
>  		 * We are going to release_task()->ptrace_unlink() silently,
>  		 * the tracer can sleep in do_wait(). EXIT_DEAD guarantees
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index e6a041cb8bac..8124d57752b9 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -70,10 +70,11 @@ extern const struct file_operations pidfd_fops;
>  
>  struct file;
>  
> -extern struct pid *pidfd_pid(const struct file *file);
> +struct pid *pidfd_pid(const struct file *file);
>  struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
>  struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
>  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
> +void do_notify_pidfd(struct task_struct *task);
>  
>  static inline struct pid *get_pid(struct pid *pid)
>  {
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index 5406fbc13074..2e6461459877 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -7,6 +7,7 @@
>  #include <linux/fcntl.h>
>  
>  /* Flags for pidfd_open().  */
> -#define PIDFD_NONBLOCK O_NONBLOCK
> +#define PIDFD_NONBLOCK	O_NONBLOCK
> +#define PIDFD_THREAD	O_EXCL
>  
>  #endif /* _UAPI_LINUX_PIDFD_H */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index dfb963d2f862..493647fd7c07 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -739,6 +739,13 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>  		kill_orphaned_pgrp(tsk->group_leader, NULL);
>  
>  	tsk->exit_state = EXIT_ZOMBIE;
> +	/*
> +	 * sub-thread or delay_group_leader(), wake up the
> +	 * PIDFD_THREAD waiters.
> +	 */
> +	if (!thread_group_empty(tsk))
> +		do_notify_pidfd(tsk);
> +
>  	if (unlikely(tsk->ptrace)) {
>  		int sig = thread_group_leader(tsk) &&
>  				thread_group_empty(tsk) &&
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 347641398f9d..bea32071fff2 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -101,6 +101,7 @@
>  #include <linux/user_events.h>
>  #include <linux/iommu.h>
>  #include <linux/rseq.h>
> +#include <uapi/linux/pidfd.h>
>  
>  #include <asm/pgalloc.h>
>  #include <linux/uaccess.h>
> @@ -2050,6 +2051,8 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
>  
>  	seq_put_decimal_ll(m, "Pid:\t", nr);
>  
> +	/* TODO: report PIDFD_THREAD */

One more thing that came to my mind. We also support waitid(P_PIDFD,
pidfd). And I just looked through the code and I think it does the right
thing when we pass it a PIDFD_THREAD pidfd because wait_consider_task()
rejects task->exit_signal != SIGCHLD in eligible_child() and
CLONE_THREAD implies task->exit_signal == -1.

