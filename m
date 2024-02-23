Return-Path: <linux-kernel+bounces-77779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AC8860A27
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F571C2373A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3947711716;
	Fri, 23 Feb 2024 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="B9gVKpbs"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B3101C1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708665386; cv=none; b=nndQmvOPg4DHcZIzfj3ecYkR6POPjAMzG899ZonBle7euPxQ8FPtN5FXtrqJjDBfcmGcqP13KGhhMwrcnSpzuo4VQ+XQyM07WHPhK4Urb3D9RcBviJx2cZG9/P7Ym6WmmdVREhfloSArGmvYkd3aEMRbQf2pVZdRfyTtqIy1zg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708665386; c=relaxed/simple;
	bh=gw3tv+yAOIlafJurMKn/u43ulkyUfIbwlXNxWeyUU3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eg5VrhRTMIml0Asd/qKL+Fg9UvDhLdfJI2KeLVrKkGfJbTNuGjP473q0bJfCyZD8GwVpTYOozBJhkzS3vGm9tLj5LRneEve6t6VAnNF/9sv51DwyPEUH9zYjSzYv6HBi6AFq7NEJJLYPjR7cbmZrWL/c3o8aUxH0SJLulalv1AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=B9gVKpbs; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708665373;
	bh=D+C3u92ueUIQRjid0KLHpC7lAbDDf/dVb3cyKJVuMFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B9gVKpbsX7yfvWmvLk0GSl8carNiBAcOD1Y2hXND9h6OBZPP2m13fA0VbA6OaF/5i
	 ty+16NgcZRhw9pgVgjYU3ol/C12U8kf2cczSbyWkX3xAfRNaknT5hm+Sx8tqb9f7dM
	 2hIXeCwKZ4uwNM/kn5cCsz5r4xdS0q00nhqDS2VI=
Received: from [IPV6:2409:8961:2a00:95cb:ea24:ca0f:4466:39d5] ([2409:8961:2a00:95cb:ea24:ca0f:4466:39d5])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 404A1C5A; Fri, 23 Feb 2024 13:16:04 +0800
X-QQ-mid: xmsmtpt1708665364tmuscyhpl
Message-ID: <tencent_3867DFAA296AACA094C9E8F413E6493FF407@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NokieQOX+Plr80ci1V7efnOZJhtLS+2Q1ayo7Nw98QKbXlyMW+lx
	 uENoiCMkkuR45tXQ+DqgLzNpeIBo9AKsq5DWpabxNBlhDjV/xFioZwg+QXKkmjDKBS1OnhXkRO+b
	 g5G2F0rXgfO736xVbygUrwlXc5o3r3Lb1d7uGve9I3cdqcJvpueXOjkNieIl8ciFAeqRwW4mJdA1
	 CvdlbSo/cGKS+bl1kzBChVbHNo35SNT6A9dSTSvu0snJ2979cJJ411g9fP1YTb1Pual6AjgX+umc
	 mJU2lcyUOPwZYKEhADln+vznkQJeYsJmX4LDMFloQ29s6PYmGVvic8/Rk+Jm0MN9z4sKYPa5Fdk3
	 O346F2l3FpTGYkKfQcJr+hH+qV+89ICEeDKhURtB+83UyYn+ewE1Wc2f2fXbXEHOB3sEWVdCjCKq
	 mJ3PC7w+gE/Z4D/AfPrVwEbK6tn25EEQ7A4Zcd3YqVnvwUaA3D/7snB5A+Va5U1RHNulYD80RO3v
	 +/xwYzpkpkwcaLTnjPKWiIaz8dvJ6w8eaq+79b4QvLu3hE6WobBeK0l0xWqFof0Nezvhp37j7zUC
	 gzsYF0XQaM8GgS66AJo/h8n/qt8VRJTcIhs7CWgvai41O1CfR8WBOtj6qol5N/KCE2sO0eiUUdYh
	 RxXaT7ZYqdsq3SSsojqHR676KRRTv4YgRtwOdx+KAWLEpZPTpEzyejff7zxryQlGaZ0hvyQIMKaC
	 ceYEBDNeX1SZxYmmTg9FtSTfAZfdSjS3fxZL+ETq7qaxxIsqNiNbhUGJ4KbMgOkFcyeGEgC+lhj0
	 ziTEkgk2Ro5jGjSODCILvqimXmQ0KsHlrmpCJwZ+g7irrhVS0RZEKSizpVRx+aC+0GEV20s9++xu
	 /LrrTR2UTni6F9cMO/yiyKa/HsESno1mpcfIfnrqfxcKkg7pDE3jLo3s2FahZUxqHsKdQjANnhVv
	 uec+BQMYvOOMAWbngzVN66jMZ2JObQdeIFa2Ry6b3ceJ5K+Fitw7YkXVeV5WKpVgZ9Q1wU6JbbpU
	 TMEXx/TA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <b9a023e2-1814-4a5c-b56a-a46e4b6f4b38@foxmail.com>
Date: Fri, 23 Feb 2024 13:16:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] kernel/signal.c: explicitly initialize si_code and
 use ksig->info uniformly
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Mike Christie <michael.christie@oracle.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <tencent_195B55A5521705954D5EA4873327F8E53D0A@qq.com>
 <20240222190546.GA5993@redhat.com>
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240222190546.GA5993@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/23 03:05, Oleg Nesterov wrote:
> On 02/23, wenyang.linux@foxmail.com wrote:
>>
>> From: Wen Yang <wenyang.linux@foxmail.com>
>>
>> By explicitly initializing ksig->info.si_code and uniformly using ksig->info,
>> get_signal() function could be slightly optimized, as folowes:
> 
> I don't understand. Why do you think it will be optimized? in what sense?
> 
>> 	clear_siginfo(&ksig->info);
>> 	ksig->info.si_signo = signr = SIGKILL;          --> missed si_code
> 
> because we do not need to set .si_code in this case?
> 
>> 	sigdelset(&current->pending.signal, SIGKILL);
>> 	trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,  --> unnecessary SEND_SIG_NOINFO
> 
> Why do you think the usage of SEND_SIG_NOINFO is "unnecessary" or bad?
> To me this looks good.
> 

Since it is called "SEND_SIG_NOINFO", but here it is neither SEND_SIG
nor NOINFO.
It is get_signal() here, and ksig->info has also been partially
initialized before calling trace_signal_deliver(). Below "goto fatal", 
do_coredump() also use the initialized ksig->info.


>> @@ -2732,8 +2732,9 @@ bool get_signal(struct ksignal *ksig)
>>   		     signal->group_exec_task) {
>>   			clear_siginfo(&ksig->info);
>>   			ksig->info.si_signo = signr = SIGKILL;
>> +			ksig->info.si_code = SI_USER;
>>   			sigdelset(&current->pending.signal, SIGKILL);
>> -			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
>> +			trace_signal_deliver(SIGKILL, &ksig->info,
> 
> Well. to me this look like the minor but unnecessary pessimization.
> 
> AFAICS, we do not need to initialize .si_code. The usage if ksig->info
> instead of  means that TP_STORE_SIGINFO() will actually read
> the memory.
> 
> Sorry, I don't understand the point at all :/
> 
> and it seems that we can simply kill clear_siginfo(), but this is
> another story.
> 



This is not right.

ksig->info will be passed to user space through do_coredump(), and the 
clear_siginfo() cannot be killed.


bool get_signal(struct ksignal *ksig)
{
..
                 if ((signal->flags & SIGNAL_GROUP_EXIT) ||
                      signal->group_exec_task) {
                         clear_siginfo(&ksig->info);
                         ksig->info.si_signo = signr = SIGKILL;
..
                         goto fatal;
                 }

         fatal:
..
                         do_coredump(&ksig->info);
                 }



void do_coredump(const kernel_siginfo_t *siginfo)
{
..
         struct coredump_params cprm = {
                 .siginfo = siginfo,
..
         };

..
        sub_info = call_usermodehelper_setup(..., &cprm);
..
        call_usermodehelper_exec(sub_info,...);




> Oleg.
> 


