Return-Path: <linux-kernel+bounces-58326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C84A84E4B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857C11F27441
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D057B3DB;
	Thu,  8 Feb 2024 16:10:05 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB54F7E79A;
	Thu,  8 Feb 2024 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408604; cv=none; b=DrSu3Tj68WH/Mb3uHeg6sGLjz9CzhbojpZbXE7BuVyFovZJWpAVbP965P+G1AYTq6zDC1kDHYX9GNpeEljGvQz/p81YRgT/4DkXf+YPCCDGPQ3eBc0wf47zHDErd4FRB83q/pRwCvAlOyIH4do5cEVPUIstN/cdqXAEz/81ez7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408604; c=relaxed/simple;
	bh=S1sd8HbbpUd9FjSYOKtZgb/F3IO/C1wLRtiXfPZIx/s=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=X96Yusq6uCW4gxzaxaq/sGtcq1qvldJZ8+Xkn5uGYOqoE4oMcKcLJKKTLNgLTF7v2lpEaqtQ7JkhuvO8QD86nvISP7I6QDWn4Vk+G+rBqKUwriEI0o0eLHMfBf72jkkc3MydOflsFvKsamrx3wKja9d09pEi0x9dIpseaM6TOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:56100)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rY6Q0-003VkL-8b; Thu, 08 Feb 2024 08:34:28 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:56436 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rY6Pz-001plP-2z; Thu, 08 Feb 2024 08:34:27 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,  Andy Lutomirski
 <luto@amacapital.net>,  Tycho Andersen <tycho@tycho.pizza>,
  linux-api@vger.kernel.org,  linux-kernel@vger.kernel.org
In-Reply-To: <20240207114549.GA12697@redhat.com> (Oleg Nesterov's message of
	"Wed, 7 Feb 2024 12:45:49 +0100")
References: <20240207114549.GA12697@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 08 Feb 2024 09:33:46 -0600
Message-ID: <8734u32co5.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rY6Pz-001plP-2z;;;mid=<8734u32co5.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/ZEJ+XOenGhdjrpc2ZjArZXtizBmgdUL0=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 582 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 10 (1.6%), b_tie_ro: 8 (1.4%), parse: 0.88 (0.2%),
	 extract_message_metadata: 3.8 (0.7%), get_uri_detail_list: 2.0 (0.3%),
	 tests_pri_-2000: 3.1 (0.5%), tests_pri_-1000: 2.2 (0.4%),
	tests_pri_-950: 1.17 (0.2%), tests_pri_-900: 0.90 (0.2%),
	tests_pri_-90: 231 (39.7%), check_bayes: 229 (39.4%), b_tokenize: 9
	(1.6%), b_tok_get_all: 8 (1.4%), b_comp_prob: 2.5 (0.4%),
	b_tok_touch_all: 206 (35.4%), b_finish: 0.87 (0.1%), tests_pri_0: 313
	(53.8%), check_dkim_signature: 0.56 (0.1%), check_dkim_adsp: 2.9
	(0.5%), poll_dns_idle: 1.15 (0.2%), tests_pri_10: 1.99 (0.3%),
	tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Oleg Nesterov <oleg@redhat.com> writes:

> Turn kill_pid_info() into kill_pid_info_type(), this allows to pass any
> pid_type to group_send_sig_info(), despite its name it should work fine
> even if type = PIDTYPE_PID.
>
> Change pidfd_send_signal() to use PIDTYPE_PID or PIDTYPE_TGID depending
> on PIDFD_THREAD.
>
> While at it kill another TODO comment in pidfd_show_fdinfo(). As Christian
> expains fdinfo reports f_flags, userspace can already detect PIDFD_THREAD.
>

I have a question here.

Why is this based on group_send_sig_info instead of send_sig_info?

AKA why does this look like sys_kill instead of sys_tgkill?

In particular I am asking are the intended semantics that the signal is
sent to a single thread in a thread group and placed in the per thread
queue, or is the signal sent to the entire thread group and placed
in the thread group signal queue?

Does the type parameter handle that decision for us now?  If so
perhaps we should cleanup the helpers so that this easier to
see when reading the code.

Because honestly right now using group_send_sig_info when
the intended target of the signal is not the entire thread
group is very confusing when reading your change.

Eric

> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/fork.c   |  2 --
>  kernel/signal.c | 18 ++++++++++++------
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index cd61ca87d0e6..47b565598063 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2051,8 +2051,6 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
>  
>  	seq_put_decimal_ll(m, "Pid:\t", nr);
>  
> -	/* TODO: report PIDFD_THREAD */
> -
>  #ifdef CONFIG_PID_NS
>  	seq_put_decimal_ll(m, "\nNSpid:\t", nr);
>  	if (nr > 0) {
> diff --git a/kernel/signal.c b/kernel/signal.c
> index c3fac06937e2..e3edcd784e45 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -47,6 +47,7 @@
>  #include <linux/cgroup.h>
>  #include <linux/audit.h>
>  #include <linux/sysctl.h>
> +#include <uapi/linux/pidfd.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/signal.h>
> @@ -1478,7 +1479,8 @@ int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp)
>  	return ret;
>  }
>  
> -int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
> +static int kill_pid_info_type(int sig, struct kernel_siginfo *info,
> +				struct pid *pid, enum pid_type type)
>  {
>  	int error = -ESRCH;
>  	struct task_struct *p;
> @@ -1487,11 +1489,10 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
>  		rcu_read_lock();
>  		p = pid_task(pid, PIDTYPE_PID);
>  		if (p)
> -			error = group_send_sig_info(sig, info, p, PIDTYPE_TGID);
> +			error = group_send_sig_info(sig, info, p, type);
>  		rcu_read_unlock();
>  		if (likely(!p || error != -ESRCH))
>  			return error;
> -
>  		/*
>  		 * The task was unhashed in between, try again.  If it
>  		 * is dead, pid_task() will return NULL, if we race with
> @@ -1500,6 +1501,11 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
>  	}
>  }
>  
> +int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
> +{
> +	return kill_pid_info_type(sig, info, pid, PIDTYPE_TGID);
> +}
> +
>  static int kill_proc_info(int sig, struct kernel_siginfo *info, pid_t pid)
>  {
>  	int error;
> @@ -3890,6 +3896,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  	struct fd f;
>  	struct pid *pid;
>  	kernel_siginfo_t kinfo;
> +	enum pid_type type;
>  
>  	/* Enforce flags be set to 0 until we add an extension. */
>  	if (flags)
> @@ -3928,9 +3935,8 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  		prepare_kill_siginfo(sig, &kinfo);
>  	}
>  
> -	/* TODO: respect PIDFD_THREAD */
> -	ret = kill_pid_info(sig, &kinfo, pid);
> -
> +	type = (f.file->f_flags & PIDFD_THREAD) ? PIDTYPE_PID : PIDTYPE_TGID;
> +	ret = kill_pid_info_type(sig, &kinfo, pid, type);
>  err:
>  	fdput(f);
>  	return ret;

