Return-Path: <linux-kernel+bounces-78418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22C7861333
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF9A285E61
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E327F7C5;
	Fri, 23 Feb 2024 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="nKJOqbj2"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BC57F7C3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696013; cv=none; b=YsYjwpLeJRDAfFswXZEhbEixGthugZ5eibd7m4XM3Hra37w5voEc5MaNdVwGieN1RkSMVxz8x0ccstNlWhQqWhxD5+Jv8XG0STzcDhN1bZxhUZW0ws9N1PKk5ahkPWTZ7bURSnPZVPmafNBCaQWPn5FByhf6DXKdpz7hTuEY4ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696013; c=relaxed/simple;
	bh=tQ+4MkeaOdk8F1CNSLrgDH2Jr/uEmRDsHrx0aGUhjZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRaRqb/rZNGpPoJx4jinx3wkl2MeqC7D7gpYO0yxu2qG0KB3n9DMbKE2QGU0rnliUjCg7R16tb9oOngWQa08sshE5d3EbrHqpX4VPM+8ig4qeVzEsh+HpQjRXcc3ALkMVOtShqlS/D4IDDD6+9U6YqkU61fRlpVPwQTsiZO6dXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=nKJOqbj2; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708695704;
	bh=KNP5q5q/PAXpZJw1qKUd/6AeLQXLWocD1CBe+CsZZ6E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nKJOqbj29B9dT9jI4NELHB3iBzz9+6CIoo72s0+opHVCvnH/YBw5Sbm3r1MSWrfyn
	 bcX3ZT6lj6AYW/NzlowdCf/lUtr1qMcSCkpZPQtuWBTmBjjrVkFkbrUYHlsaG7b/o9
	 tdl5YZMGaXwIitF81KZyzzxpFb/7lPsMNPU7Vml0=
Received: from [IPV6:2409:8a60:2a61:ef40:a0ce:972d:4d86:c925] ([2409:8a60:2a61:ef40:a0ce:972d:4d86:c925])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id A5633ED8; Fri, 23 Feb 2024 21:41:22 +0800
X-QQ-mid: xmsmtpt1708695682t1idb5efw
Message-ID: <tencent_7C50F304C14CB2A5133317F8A13D1F544D0A@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy7004WcpIuEbJrJAv+aA6cCrPORn/FF08+ybhGNSVfdGS2UZ80axu
	 +CFqLLgOatgnkf28L5AAoEpclz7/PM0BpxTXdPpgdZyA4VSMadRPMDhVWIBOxeyCZubaDrLZ0SVm
	 z/ZV/x9BE2N4PMjMYJBMk53vQybhsyYQtARVBH1tKE45GJWGkIGL50jz5t6m8cUe3ZrFG5tBgWR3
	 ijrfPzq4v9GxyQuSNqq9CaRgZ+gG/GUyVyOu3y/3k7rnCcQR+DCSU1K2ZcVuRSvdbashZsrNX0oU
	 T6QcQowo3i7H4YWXRhPEwseURr201uhY4PtyXaKu874lYVCqz/Dnew1sw0auWblP3iuzf9irv/pl
	 PbTWt3RL5E9K2VAwgmllbcxJKvCK52dxpNQ0QNnuYZ0DZ26VmV5YQgTNLZt1nbifK1DM5Yf85gct
	 Z8NrBcxpDj9SEQGkg3n9G6Lk3V3BozxSTnukCre5T9kecqHSaFpQylIEwkW6R9ssbdaxkFIPfk1J
	 ECYUGt+CijPA3aWPVrjfaWZPkBc6HEfZUSNp0MwDiFcsHNmzgWu66OZu6DwKvO02fHhx0QsDQMFd
	 NOsYYJeyXBzN/SLfDQ+kyRSC49NisX08zE1ndHWEPHrhagPyfzbm44D8L/ePmmRbVRKmaLwvEzLa
	 P7new2CbWdaMsCNzmJRL2T5Hy+bpqWnpio+R79cZ/1JCByFbQNsqtR7g0YUuWug6bLMSBq7CmYU1
	 PYQHOyKMMvCa/2Sxp4501yCK6azrvUYZUViyZXbyzEZapmhdl6bEX3hjU6yt4HRov8p1gb12DDP/
	 MVh17ZepJytm9AFPzMYPlGwBagj6uni//G7zfZhbuUFN8TiZubxGpTzXnvpm/UosLuqwdhCXtcBS
	 tCf3ULsfSJNocoIm3hBGPfKI1hReQCwkoR4MibLg6V2Mb9cPNRzi02AaltOg5zOgux+M/JXdeWF6
	 KQWDtmQuIpOq/sCQu1HaSUhNz1iO/Qy29YA8RCf5Vqf6KZJ/hRGguj/aRRHFMn
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <8b9f4b04-a347-8af4-b74f-16a83ae3ac31@foxmail.com>
Date: Fri, 23 Feb 2024 21:41:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] get_signal: simplify/cleanup the the usage of ksig->info
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org
References: <20240223105025.GA4542@redhat.com>
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240223105025.GA4542@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/23 18:50, Oleg Nesterov wrote:
> get_signal() uses signr or ksig->info.si_signo in a chaotic way, this
> looks confusing. Change it to always use signr.
> 
> This allows us to simplify the SIGNAL_GROUP_EXIT/group_exec_task branch,
> it no longer needs to touch ksig at all.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>   kernel/signal.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index c9c57d053ce4..690982e6595e 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2727,12 +2727,15 @@ bool get_signal(struct ksignal *ksig)
>   		/* Has this task already been marked for death? */
>   		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
>   		     signal->group_exec_task) {
> -			clear_siginfo(&ksig->info);
> -			ksig->info.si_signo = signr = SIGKILL;
> +			signr = SIGKILL;
>   			sigdelset(&current->pending.signal, SIGKILL);
>   			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
> -				&sighand->action[SIGKILL - 1]);
> +					     &sighand->action[SIGKILL - 1]);
>   			recalc_sigpending();
> +			/*
> +			 * implies do_group_exit(), no need to initialize
> +			 * ksig->info
> +			 */
>   			goto fatal;

There is little question:
If the this conditions is met:
    current->flags & PF_USER_WORKER
It may execute “goto out“ instead of do_group_exit().

--
Best wishes,
Wen


>   		}
>   
> @@ -2842,7 +2845,7 @@ bool get_signal(struct ksignal *ksig)
>   				spin_lock_irq(&sighand->siglock);
>   			}
>   
> -			if (likely(do_signal_stop(ksig->info.si_signo))) {
> +			if (likely(do_signal_stop(signr))) {
>   				/* It released the siglock.  */
>   				goto relock;
>   			}
> @@ -2866,7 +2869,7 @@ bool get_signal(struct ksignal *ksig)
>   
>   		if (sig_kernel_coredump(signr)) {
>   			if (print_fatal_signals)
> -				print_fatal_signal(ksig->info.si_signo);
> +				print_fatal_signal(signr);
>   			proc_coredump_connector(current);
>   			/*
>   			 * If it was able to dump core, this kills all
> @@ -2890,7 +2893,7 @@ bool get_signal(struct ksignal *ksig)
>   		/*
>   		 * Death signals, no core dump.
>   		 */
> -		do_group_exit(ksig->info.si_signo);
> +		do_group_exit(signr);
>   		/* NOTREACHED */
>   	}
>   	spin_unlock_irq(&sighand->siglock);


