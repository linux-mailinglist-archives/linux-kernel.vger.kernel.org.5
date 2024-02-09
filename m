Return-Path: <linux-kernel+bounces-59689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 956A784FA73
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248891F2434E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03CA80BF7;
	Fri,  9 Feb 2024 17:00:02 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A081E486;
	Fri,  9 Feb 2024 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498002; cv=none; b=kgAZ3ddtTo7sDepk8twSWyPK+mswb99tW4a64SxXMzd18Xm4PSVB7u6/wCbwtbh0vf13JfBC/mAgVvtl4Q6Lbap6sN+1ubKkJd1SBrVqzaXTIDRGO2PzcApMlsnlqNgBWCNkCiALlG1565vTXzPPU02qpO4/Up3KJv7dlffrQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498002; c=relaxed/simple;
	bh=4TJPfYzFEccNa7N8cEXWG2mJo2lv8XbuNRQ6Vf/x234=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=iwofnef2h5UyvJV88587HiyOk6lO7iXa0Xv9EVjKPT6Qe6ajivmMt6I1b32tjKBTYQaHHIeBAKYbIgyFBZQ/iJ0u3AH7dttFpGOQApx7Ag9QpAPYVU14ZbtxOff+9Ol5hj43OPpblg97IxS4/Z91S3UsYvXb8UetbEvPj7InlDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:49702)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rYTfF-00Dlh8-Hx; Fri, 09 Feb 2024 09:23:45 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54500 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rYTfE-00FRwV-G9; Fri, 09 Feb 2024 09:23:45 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,  Andy Lutomirski
 <luto@amacapital.net>,  Tycho Andersen <tycho@tycho.pizza>,
  linux-api@vger.kernel.org,  linux-kernel@vger.kernel.org
References: <20240209130620.GA8039@redhat.com>
Date: Fri, 09 Feb 2024 10:22:23 -0600
In-Reply-To: <20240209130620.GA8039@redhat.com> (Oleg Nesterov's message of
	"Fri, 9 Feb 2024 14:06:20 +0100")
Message-ID: <87sf21zjy8.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rYTfE-00FRwV-G9;;;mid=<87sf21zjy8.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19qPeXB4WCLv5Q6VcPpQcx938PWGTS/HWw=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4952]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 453 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (2.4%), b_tie_ro: 10 (2.1%), parse: 0.90
	(0.2%), extract_message_metadata: 3.8 (0.8%), get_uri_detail_list:
	1.86 (0.4%), tests_pri_-2000: 3.2 (0.7%), tests_pri_-1000: 2.3 (0.5%),
	tests_pri_-950: 1.19 (0.3%), tests_pri_-900: 0.97 (0.2%),
	tests_pri_-90: 113 (24.9%), check_bayes: 111 (24.6%), b_tokenize: 8
	(1.8%), b_tok_get_all: 9 (1.9%), b_comp_prob: 2.4 (0.5%),
	b_tok_touch_all: 89 (19.6%), b_finish: 0.86 (0.2%), tests_pri_0: 299
	(66.0%), check_dkim_signature: 0.52 (0.1%), check_dkim_adsp: 2.5
	(0.5%), poll_dns_idle: 0.67 (0.1%), tests_pri_10: 2.1 (0.5%),
	tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/2] signal: add the "int si_code" arg to
 prepare_kill_siginfo()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Oleg Nesterov <oleg@redhat.com> writes:

> So that do_tkill() can use this helper too. This also simplifies
> the next patch.
>
> TODO: perhaps we can kill prepare_kill_siginfo() and change the
> callers to use SEND_SIG_NOINFO,  but this needs some changes in
> __send_signal_locked() and TP_STORE_SIGINFO().

Could you can pass in the destination type instead of the si_code?
Something like I have shown below?

That allows the knowledge of the siginfo details to be isolated to
prepare_kill_siginfo, making it easy to verify that a the union members
match the union decode for the signal/si_code combination?

It is all too easy to fill in siginfo improperly.

Looking at siginfo_layout() SI_USER paired with any signal results in
SIL_KILL whereas SI_TKILL paired with any signal results in SIL_RT.  A
superset of the fields of SIL_KILL.

We use clear_siginfo() so si_sigval is set to 0 for SI_TKILL which seems
correct.  But we do allow userspace if it specifies SI_TKILL to provide
si_sigval.  So the current do_tkill code is very close to being wrong.

Likewise you are filling in the details to match what the existing
code is doing, so you are fine.  Still it is a loaded footgun
to allow passing in an arbitrary si_code.

Eric

> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/signal.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index c3fac06937e2..a8199fda0d61 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3793,12 +3793,12 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait_time32, compat_sigset_t __user *, uthese,
>  #endif
>  #endif
>  
> -static inline void prepare_kill_siginfo(int sig, struct kernel_siginfo *info)
> +static void prepare_kill_siginfo(int sig, struct kernel_siginfo *info, int si_code)
>  {
>  	clear_siginfo(info);
>  	info->si_signo = sig;
>  	info->si_errno = 0;
> -	info->si_code = SI_USER;
> +	info->si_code = si_code;
	info->si_code = (type == PIDTYPE_PID) ? SI_TKILL : SI_USER;
>  	info->si_pid = task_tgid_vnr(current);
>  	info->si_uid = from_kuid_munged(current_user_ns(), current_uid());
>  }
> @@ -3812,7 +3812,7 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
>  {
>  	struct kernel_siginfo info;
>  
> -	prepare_kill_siginfo(sig, &info);
> +	prepare_kill_siginfo(sig, &info, SI_USER);
>  
>  	return kill_something_info(sig, &info, pid);
>  }
> @@ -3925,7 +3925,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
>  			goto err;
>  	} else {
> -		prepare_kill_siginfo(sig, &kinfo);
> +		prepare_kill_siginfo(sig, &kinfo, SI_USER);
>  	}
>  
>  	/* TODO: respect PIDFD_THREAD */
> @@ -3970,12 +3970,7 @@ static int do_tkill(pid_t tgid, pid_t pid, int sig)
>  {
>  	struct kernel_siginfo info;
>  
> -	clear_siginfo(&info);
> -	info.si_signo = sig;
> -	info.si_errno = 0;
> -	info.si_code = SI_TKILL;
> -	info.si_pid = task_tgid_vnr(current);
> -	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
> +	prepare_kill_siginfo(sig, &info, SI_TKILL);
>  
>  	return do_send_specific(tgid, pid, sig, &info);
>  }

