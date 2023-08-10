Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B957782B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjHJVau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHJVat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:30:49 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330112712
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:30:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so20717401fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691703046; x=1692307846;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:references:cc:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXpjAWn8IHT9pnCM615W9ZDd0D3kHbzikgTR2b9M2No=;
        b=jDV+qIHOHwIWxu2mJV/NgYD1dQ4hmbVKGkBJP1u2UgBJ0SEOZ6fDMDamaFwCvqTzD0
         4BzkYD9Ea3mdpJWJaRtLQiA24Oayb8l8Ti+Q+hVIGirYjO11rhflYznDB4UIwMucWMcO
         zCsz0cn46ek9ZVC3iJ/sk4nbBo91YexOhWVHXq0X8KYV6H4yO7LrXgc2DVHRDxKtw9dS
         hre5kppnvE/BTIje+PjhClFhpY3NO5gsKA6aQgLTzGfj4ZS8e1lod//GNUbZVBLU6GFy
         M0b8Ybn8Z8TCd+JBkGy5y4vuqcx5F9Gd2zsy3tXJBKS66jHEVCyUtSDJM61PSrTkKox5
         eKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691703046; x=1692307846;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:references:cc:to:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WXpjAWn8IHT9pnCM615W9ZDd0D3kHbzikgTR2b9M2No=;
        b=bJR9ArQCDN6jz4555uENEizGq+RP284oxlKTGmg9LS7oCdJWorqGOzkAgkgM+l7p1O
         vccoDhT/MIxe4+OpUOxovTT9y08udvus6m+zpcvpELyiT8BAbRjej1QBeHjxoFfL35Oj
         HzkbVgW1vThOblFJigEkmh/5JO3pwCX4uMlS8nhrhJRyVwdh+UekVBH1jdSmR8nx9vrw
         /1vwIDdYPXtoYOqlXeV4iRrlDpHCX52nO+jDgkwkdxr8GCJBYI+FuLyrf1qX6Gj+I1/x
         TD04+L7/fs5DB0E8+dLcSlT6mV9ibLm+Plg/SfB8x4Zf/mmeOdyFmoUYu9WcFJORBgiw
         NKhg==
X-Gm-Message-State: AOJu0YzjfCVW2g6LX7QfRL47gVmueBKc/GewuMJzpSJ4q/x45reA+Cat
        ZOG0JJkDE4ZfE4go/Ag9tWY=
X-Google-Smtp-Source: AGHT+IF8K8iDpXf0ACMckCrgmw9gGZk7OyDUPz+vaHnOi65WR+Iq/cEOKPDu+u/gIvsMhR7KwSrktQ==
X-Received: by 2002:a2e:9783:0:b0:2b4:6d59:7863 with SMTP id y3-20020a2e9783000000b002b46d597863mr173350lji.25.1691703046079;
        Thu, 10 Aug 2023 14:30:46 -0700 (PDT)
Received: from ?IPV6:2001:1ae9:2f0:fa00:546f:93fc:49cd:cae3? (2001-1ae9-2f0-fa00-546f-93fc-49cd-cae3.ip6.tmcz.cz. [2001:1ae9:2f0:fa00:546f:93fc:49cd:cae3])
        by smtp.gmail.com with ESMTPSA id a17-20020a170906671100b0099bd8c1f67esm1411687ejp.109.2023.08.10.14.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 14:30:45 -0700 (PDT)
Message-ID: <336ae9be-c66c-d87f-61fe-b916e9f04ffc@gmail.com>
Date:   Thu, 10 Aug 2023 23:30:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/1] *** Fix kill(-1,s) returning 0 on 0 kills ***
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
References: <20221122161240.137570-1-pskocik@gmail.com>
 <202211220913.AF86992@keescook>
 <d2d508b7-f267-0fe6-1b56-4292c95355a7@gmail.com>
 <878rai7u0l.fsf@email.froward.int.ebiederm.org>
From:   Petr Skocik <pskocik@gmail.com>
In-Reply-To: <878rai7u0l.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        GB_FREEMAIL_DISPTO,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 18:16, Eric W. Biederman wrote:
> Petr Skocik <pskocik@gmail.com> writes:
>
>> Hi.
>>
>> Is there anything else I can do to help get this (or some other equivalent
>> change that results in kill(-1,s) returning -ESRCH when it has nothing to kill
>> (like it does on the BSDs),
>> as opposed to the current return value of 0 in that case) incorporated into
>> mainline Linux?
> I think you are talking about a rare enough case that we can safely
> change the error handling behavior  without real risk of trouble.
>
> I think there is room for cleanup here.
>
> I don't think we can change the set of processes signaled.  The linux
> man page should be updated to note that we skip sending a signal
> to ourselves in the event of -1.
>
> Reading the code the error handling logic is dubious.
>
> POSIX provides some guidance it says:
>
> If pid is -1, sig shall be sent to all processes (excluding an
> unspecified set of system processes) for which the process has
> permission to send that signal.
>
> [EINVAL]
>      The value of the sig argument is an invalid or unsupported signal number.
> [EPERM]
>      The process does not have permission to send the signal to any receiving process.
> [ESRCH]
>      No process or process group can be found corresponding to that specified by pid.
>
>>                  if (err != -EPERM)
>>                      ret = err; /*either all 0 or all -EINVAL*/
> The comment in your proposed patch is wrong:
>    -EAGAIN an be returned in the case of real time signals.
>    -ENOMEM can be returned due to linux audit.
>    -EINVAL can be returned, but arguably it should be caught
>            before we even go into the loop.
>
> Given that the comment is wrong I don't like what you have done with the
> error handling logic.  It just adds confusion.
>
> My question: What would a good and carefully implemented version
> of kill(2) return?
>
> Today for -pgrp we return 0 if any signal delivery succeeds and
> the error from the last process in the signal group otherwise.
>
> For -1 we return -EINVAL if the signal is invalid.
> For -1 we return -ESRCH only if we are the init process and
> there are no other processes in the system, aka never except
> when we are the init process in a pid namespace.
> For -1 otherwise we return the return value of the last
> process signaled.
>
> I would argue that what needs to happen for -1 is:
> - Return 0 if the signal was sent to any process successfully.
> - Return -EINVAL for invalid signals.
> - When everything errors return some error value and not 0.
>
> What error value should we return when everything errors?
> Especially what error value should we return when everything
> says -EPERM?
>
> Should we follow BSD and return ESRCH?
> Should we follow Posix and return EPERM?
> Should we follow SYSV unix?
>
> Looking at FreeBSD aka:
> https://cgit.freebsd.org/src/tree/sys/kern/kern_sig.c?id=9e283cf9a2fe2b3aa6e4a47a012fd43b4e49ebec
> kill(2) aka killpg1 only returns 0 or ESRCH when sending a signal
> to multiple processes (after passing the EINVAL) check.
>
> The man pages for AIX and Solaris suggest that -EPERM is returned when
> things don't work.
>
> So what should Linux do?
>
> Historically Linux signaling is very SysV unix with a some compatibility
> flags for BSD where it matters.  So I am not convinced that return
> ESRCH in this case is the right answer.
>
> Basing the logic off of __kill_pgrp_info I would do:
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index b5370fe5c198..369499ebb8e2 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1602,7 +1602,8 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
>   		ret = __kill_pgrp_info(sig, info,
>   				pid ? find_vpid(-pid) : task_pgrp(current));
>   	} else {
> -		int retval = 0, count = 0;
> +		bool found = false, success = false;
> +		int retval = 0;
>   		struct task_struct * p;
>   
>   		for_each_process(p) {
> @@ -1610,12 +1611,12 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
>   					!same_thread_group(p, current)) {
>   				int err = group_send_sig_info(sig, info, p,
>   							      PIDTYPE_MAX);
> -				++count;
> -				if (err != -EPERM)
> -					retval = err;
> +				found = true;
> +				success |= !err;
> +				retval = err;
>   			}
>   		}
> -		ret = count ? retval : -ESRCH;
> +		ret = success ? 0 : (found ? retval : -ESRCH);
>   	}
>   	read_unlock(&tasklist_lock);
>   
> I think that fits in better with Linux, and doesn't have any surprising
> behavior.
>
>> It would rather help some of the user software I'm developing, and the slightly
>> new semantics are IMO definitely reasonable (BSDs have them).
> Would my proposal above work for the software you are developing?
>
> The behavior your patch was implementing was:
> 	ret = success ? 0 : ((retval == -EINVAL)? -EINVAL : -ESRCH);
>
> Which gives less information.  So I am not thrilled by it.
>
> Eric
>
>
>
Thanks for the detailed analysis, Eric W. Biederman.

All my software really cares about is that I get some indication that a 
kill(-1,s) run from a non-root pid no longer had anything left to kill, 
which on Linux is currently being masked by a return value of 0 whereas 
BDSs nicely provide an ESRCH. -EPERM would work too (and would still be 
more useful to me than the current behavior), but I will still object to 
it because I'm convinced you're misreading POSIX here and ESRCH, not 
EPERM, is the error that should be returned here.

You see, while the POSIX guidance for EPERM-returns from kill

     [EPERM] The process does not have permission to send the signal to 
any receiving process.

does indeed seem to suggest that EPERM might be right here, the issue is 
that the receiving processes that returned -EPERM in the loop were 
formally NOT the receiving processes of  kill(-1,s) at all

     If pid is -1, sig shall be sent to all processes (excluding an
     unspecified set of system processes) for which the process has
     permission to send that signal.

The -EPERM-returning internal kills (group_send_sig_info), according to 
the POSIX rules for kill(-1,s), *never* should have happened. It's 
harmless that they did happen as part of the implementation, given that 
those attempts aren't externally observable anyway, but this 
implementation detail should not leak out. Since all targets that for 
kill(-1,s) internally returned -EPERM formally shouldn't have been tried 
in the first place, then if all tried processes returned -EPERM, there 
was no process to try to kill and an -ESRCH is in order. No need to 
diverge from the BSDs here.

That is why the original code had a branch to disregard internal EPERM 
returns and why this branch should be preserved in any patches so that
kill(-1,s) should continue to NEVER return -EPERM. Returning it would 
contradict the spec (kill(-1,s) kills all it has permission to kill so 
it's nonsensical for it to report that it
lacks that permission).

As I said in previous messages, especially my latest one, I don't object 
to dropping the apparent implicit assumption of the current code that 
there can be no masking of a previous
non-EPERM error by a later success, or to making it explicit with some 
assert/BUG_ON statement. Please see the code examples for both of these 
other alternatives  in my previous message.

However, any other implementation (including the one you suggested) is 
welcome and thank you very much for your analysis and willingness to 
pick this.

Best regards,
Petr Skocik

