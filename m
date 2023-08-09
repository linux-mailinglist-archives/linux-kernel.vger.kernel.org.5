Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B272B77699A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjHIUOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjHIUOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:14:17 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0095310D4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:14:14 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3498795048aso841925ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691612054; x=1692216854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=guZ5vpqqJqA9daPfYYnKXLU14D1mpOwdXtcKs7C1O6E=;
        b=teRQ96U/IkC6y31VwU1NjtwjZdh80fpd032mGixaFIjCCO+6DahLSaWhjFgwyX+D0s
         7xRN+Sng3LnCEh0nCfXyr3x+CDQfV8BGwj/0ILM/ErxHnOnPzHOafQSHWHEo2t26Z43A
         vLYFxhySi1w09JWBgEBF0tV1pLt8s+pU8wCZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691612054; x=1692216854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guZ5vpqqJqA9daPfYYnKXLU14D1mpOwdXtcKs7C1O6E=;
        b=PHXJKroXRtyRxVMtEBAz7K0O2sEJBoOzpjpXgmz/wLRMiPvJyGdIHDq+A0tsVPJzzW
         D4JXwdgMIPj1gh6krP2UZ26j3L+ae48QuQ7ekOSkZWZ+zlI+rTE3te/vDK4joT9x0io4
         8kTg038cJl2jXm+J2zIHn6xPX29B1aeNe6nv3q9oedME/lau3+WwQYhVaZRXkPxGmSic
         iPyHABvPiKWmArTg1bEqZUIwiuxWZJ7C+1Lce3WcgKznvEekKQu3CiqXOH4ja+0f3vvQ
         xDq8LLqiuKXRGr+uDUIxpC2gB+bT0dAy6qWiYaZkOfXFl86zVQiEFPcEnW5d43v4BSZr
         k6ig==
X-Gm-Message-State: AOJu0Yx7iwKLEdsFi99e4H5BfaqcqMovjncwSTDSlFONXXwL89RGLxwq
        9mO2yfnhW3WvDcEWOQaBa5oAIg==
X-Google-Smtp-Source: AGHT+IHFssVCaalC7OaCchaWhg7XXfx3K1aZGh4DfLLnCZfW44BE6qugHkyqKK6ivgJmigJ1V78RCA==
X-Received: by 2002:a05:6e02:20c8:b0:347:693a:a52b with SMTP id 8-20020a056e0220c800b00347693aa52bmr199791ilq.6.1691612054245;
        Wed, 09 Aug 2023 13:14:14 -0700 (PDT)
Received: from localhost (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id j10-20020a02cb0a000000b0042b8566a982sm4189018jap.41.2023.08.09.13.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:14:13 -0700 (PDT)
Date:   Wed, 9 Aug 2023 20:14:13 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
Message-ID: <20230809201413.GA3374446@google.com>
References: <20230809103633.485906560@linuxfoundation.org>
 <20230809135326.GE3031656@google.com>
 <f47340c6-3c41-1f91-d0f9-fe0b59a23aac@roeck-us.net>
 <CAEXW_YQ4GqPwvUF8=8CWmdj=cD56v_eEVK-EirsObQXyBDFVpg@mail.gmail.com>
 <35e4b770-2ead-4a19-ad01-fa75996adef4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35e4b770-2ead-4a19-ad01-fa75996adef4@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 12:25:48PM -0700, Guenter Roeck wrote:
> On Wed, Aug 09, 2023 at 02:35:59PM -0400, Joel Fernandes wrote:
> > On Wed, Aug 9, 2023 at 12:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On 8/9/23 06:53, Joel Fernandes wrote:
> > > > On Wed, Aug 09, 2023 at 12:40:36PM +0200, Greg Kroah-Hartman wrote:
> > > >> This is the start of the stable review cycle for the 5.15.126 release.
> > > >> There are 92 patches in this series, all will be posted as a response
> > > >> to this one.  If anyone has any issues with these being applied, please
> > > >> let me know.
> > > >>
> > > >> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> > > >> Anything received after that time might be too late.
> > > >>
> > > >> The whole patch series can be found in one patch at:
> > > >>      https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.126-rc1.gz
> > > >> or in the git tree and branch at:
> > > >>      git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > >> and the diffstat can be found below.
> > > >
> > > > Not necesscarily new with 5.15 stable but 3 of the 19 rcutorture scenarios
> > > > hang with this -rc: TREE04, TREE07, TASKS03.
> > > >
> > > > 5.15 has a known stop machine issue where it hangs after 1.5 hours with cpu
> > > > hotplug rcutorture testing. Me and tglx are continuing to debug this. The
> > > > issue does not show up on anything but 5.15 stable kernels and neither on
> > > > mainline.
> > > >
> > >
> > > Do you by any have a crash pattern that we could possibly use to find the crash
> > > in ChromeOS crash logs ? No idea if that would help, but it could provide some
> > > additional data points.
> > 
> > The pattern shows as a hard hang, the system is unresponsive and all CPUs
> > are stuck in stop_machine. Sometimes it recovers on its own from the
> > hang and then RCU immediately gives stall warnings. It takes 1.5 hour
> > to reproduce and sometimes never happens for several hours.
> > 
> > It appears related to CPU hotplug since gdb showed me most of the CPUs
> > are spinning in multi_cpu_stop() / stop machine after the hang.
> > 
> 
> Hmm, we do see lots of soft lockups with multi_cpu_stop() in the backtrace,
> but not with v5.15.y but with v5.4.y. The actual hang is in stop_machine_yield().

Interesting. It looks similar as far as the stack dump in gdb goes, here are
the stacks I dumped with the hang I referred to:
https://paste.debian.net/1288308/

But in dmesg, it prints nothing for about 20-30 mins before recovering, then
I get RCU stalls. It looks like this:

[  682.721962] kvm-clock: cpu 7, msr 199981c1, secondary cpu clock
[  682.736830] kvm-guest: stealtime: cpu 7, msr 1f5db140
[  684.445875] smpboot: Booting Node 0 Processor 5 APIC 0x5
[  684.467831] kvm-clock: cpu 5, msr 19998141, secondary cpu clock
[  684.555766] kvm-guest: stealtime: cpu 5, msr 1f55b140
[  687.356637] smpboot: Booting Node 0 Processor 4 APIC 0x4
[  687.377214] kvm-clock: cpu 4, msr 19998101, secondary cpu clock
[ 2885.473742] kvm-guest: stealtime: cpu 4, msr 1f51b140
[ 2886.456408] rcu: INFO: rcu_sched self-detected stall on CPU
[ 2886.457590] rcu_torture_fwd_prog_nr: Duration 15423 cver 170 gps 337
[ 2886.464934] rcu: 0-...!: (2 ticks this GP) idle=7eb/0/0x1 softirq=118271/118271 fqs=0 last_accelerate: e3cd/71c0 dyntick_enabled: 1
[ 2886.490837] (t=2199034 jiffies g=185489 q=4)
[ 2886.497297] rcu: rcu_sched kthread timer wakeup didn't happen for 2199031 jiffies! g185489 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[ 2886.514201] rcu: Possible timer handling issue on cpu=0 timer-softirq=441616
[ 2886.524593] rcu: rcu_sched kthread starved for 2199034 jiffies! g185489 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
[ 2886.540067] rcu: Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
[ 2886.551967] rcu: RCU grace-period kthread stack dump:
[ 2886.558644] task:rcu_sched       state:I stack:14896 pid:   15 ppid:     2 flags:0x00004000
[ 2886.569640] Call Trace:
[ 2886.572940]  <TASK>
[ 2886.575902]  __schedule+0x284/0x6e0
[ 2886.580969]  schedule+0x53/0xa0
[ 2886.585231]  schedule_timeout+0x8f/0x130

In that huge gap, I connect gdb and dumped those stacks in above link.

On 5.15 stable you could repro it in about an hour and a half most of the time by running something like:
tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 48 --duration 60 --configs TREE04

Let me know if you saw anything like this. I am currently trying to panic the
kernel when the hang happens so I can get better traces.

thanks,

 - Joel

