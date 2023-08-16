Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88A077E6F7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344942AbjHPQxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344940AbjHPQwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:52:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDDBE4C;
        Wed, 16 Aug 2023 09:52:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-26928c430b2so3785320a91.0;
        Wed, 16 Aug 2023 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692204748; x=1692809548;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLVO5zOgzVmgvf0ogMhir1oYpbJwVnFoCZ42ZkSZiP8=;
        b=WcZFbELKcFjg8/tY+QzULT4pNSnYqeGvvbkNYpNvtbj0tRot5wzwgv1ENiBX7or1wR
         6V4o64MDQEIEklP/2VPKQzTrXNk4BnU2rusuKA5WGtou16hcPe5Bc51r0mpYkoLTYzxH
         4wCJ+XAm8RWSlfAljHlkxvI24JxfOLYrxkJvCvD76nO/Ssv73EY/3SOOOgN+MEYUczNs
         4M9cKkQVpcWX4+zkct9eKr+/5f/i0hw0hQ1JYTKBBd/GN6BSOihX8Zqk3oym6eNxRKE7
         WCodZK97+ADal9eFottizUiCvmHBemZiMGFdomR8o8sY6NgRO9XXtXQfpAJ3NK0DS4/V
         kcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692204748; x=1692809548;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLVO5zOgzVmgvf0ogMhir1oYpbJwVnFoCZ42ZkSZiP8=;
        b=Q8321PKfrXBXt7JX5j6rQGIrP1SSQ+FGmF0QgDKI5LVcq9+dTrdRVpoWm9w9AqfT2I
         YoLAav2CjaVrvywBAq8oEAL88uWOC0CCSNmEYRMn3/WMT0CyRHW0tNQrWz3uNJiVjRL6
         gyDcSZbYw/mugO/BEhDxtwF6Y7cngz70aB0hX76bZhi48I97iCZlyegd3uXY370GvGXj
         sus3rJGbmDBUeSeaQFUsqTYhgBWc/Zc8p8L+Fw7/Zk4K2xzwIUGMq6JLps0XDB/Zhie9
         86h9BHOVLUJ1o86WNv8G8K+Ppyf4IpMRQsseBnNJ5CcekrudQe57Qha3xDf9M8ZWY+OA
         iOIA==
X-Gm-Message-State: AOJu0YxrokeX1nwQ2QH8eIH9oGlqEYkUyjUpIA/YUwKoHolbgbSZalwD
        0goPRD70pp+AQCL/XdbwyMc=
X-Google-Smtp-Source: AGHT+IEv8tPCvCY3Ju+0BzwyavB5gFNaZocbqlnN96ACHmbYvOEJhsn8AFVps7WFYC8/zUvdZc+Acw==
X-Received: by 2002:a17:90b:4c4f:b0:261:688:fd91 with SMTP id np15-20020a17090b4c4f00b002610688fd91mr1938943pjb.8.1692204748109;
        Wed, 16 Aug 2023 09:52:28 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090adc0500b0026b420ae167sm7237609pjv.17.2023.08.16.09.52.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Aug 2023 09:52:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <CAAhV-H6XPmDFEKGwjcbv57jRwpUvZ76PcmJjxN50Dpbq+-QgKA@mail.gmail.com>
Date:   Thu, 17 Aug 2023 00:52:05 +0800
Cc:     Z qiang <qiang.zhang1211@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2EB2D2A7-7C69-4E75-BF62-92309121B0A5@gmail.com>
References: <20230814020045.51950-1-chenhuacai@loongson.cn>
 <20230814020045.51950-2-chenhuacai@loongson.cn>
 <18b9119c-cbc8-42a1-a313-9154d73c9841@paulmck-laptop>
 <CAAhV-H7t46hD1k18-sLYQA8h=M+ROdyMnT7gRtEGoRwKKBUZUA@mail.gmail.com>
 <CALm+0cWkQ8j_jiOSOuSsR9LbKPUL5cxRrONVxeNgSM5f1nDxMQ@mail.gmail.com>
 <CAAhV-H6S3Scu-Mf7E3aaqySytY4xDgjXrWc=fXSbr4i7R+-GDA@mail.gmail.com>
 <CALm+0cUpqONZOEHbc85d-Z5cC=P5LSeOAGuCCOukpTagLxnXWw@mail.gmail.com>
 <CAAhV-H7J6Rj99M6rxoFCEKu4G6NQPX9-N0a3-2GjEwbr+tbwQw@mail.gmail.com>
 <CALm+0cVdaXn5+4veu2NDwdi7htm=KY4ca+Eh54TwnN_6Xjs8TA@mail.gmail.com>
 <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <D3AFC0E7-9E6C-43F2-B9F5-3AC498B14F0F@gmail.com>
 <CAAhV-H6XPmDFEKGwjcbv57jRwpUvZ76PcmJjxN50Dpbq+-QgKA@mail.gmail.com>
To:     Huacai Chen <chenhuacai@kernel.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> Currently rcu_cpu_stall_reset() set rcu_state.jiffies_stall =
to one check
>>>>>>>>>>> period later, i.e. jiffies + rcu_jiffies_till_stall_check(). =
But jiffies
>>>>>>>>>>> is only updated in the timer interrupt, so when =
kgdb_cpu_enter() begins
>>>>>>>>>>> to run there may already be nearly one rcu check period =
after jiffies.
>>>>>>>>>>> Since all interrupts are disabled during kgdb_cpu_enter(), =
jiffies will
>>>>>>>>>>> not be updated. When kgdb_cpu_enter() returns, =
rcu_state.jiffies_stall
>>>>>>>>>>> maybe already gets timeout.
>>>>>>>>>>>=20
>>>>>>>>>>> We can set rcu_state.jiffies_stall to two rcu check periods =
later, e.g.
>>>>>>>>>>> jiffies + (rcu_jiffies_till_stall_check() * 2) in =
rcu_cpu_stall_reset()
>>>>>>>>>>> to avoid this problem. But this isn't a complete solution =
because kgdb
>>>>>>>>>>> may take a very long time in irq disabled context.
>>>>>>>>>>>=20
>>>>>>>>>>> Instead, update jiffies at the beginning of =
rcu_cpu_stall_reset() can
>>>>>>>>>>> solve all kinds of problems.
>>>>>>>>>>=20
>>>>>>>>>> Would it make sense for there to be a kgdb_cpu_exit()?  In =
that case,
>>>>>>>>>> the stalls could simply be suppressed at the beginning of the =
debug
>>>>>>>>>> session and re-enabled upon exit, as is currently done for =
sysrq output
>>>>>>>>>> via rcu_sysrq_start() and rcu_sysrq_end().
>>>>>>>>> Thank you for your advice, but that doesn't help. Because
>>>>>>>>> rcu_sysrq_start() and rcu_sysrq_end() try to suppress the =
warnings
>>>>>>>>> during sysrq, but kgdb already has no warnings during =
kgdb_cpu_enter()
>>>>>>>>> since it is executed in irq disabled context. Instead, this =
patch
>>>>>>>>> wants to suppress the warnings *after* kgdb_cpu_enter() due to =
a very
>>>>>>>>> old jiffies value.
>>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Hello, Huacai
>>>>>>>>=20
>>>>>>>> Is it possible to set  the rcu_cpu_stall_suppress is true in
>>>>>>>> dbg_touch_watchdogs()
>>>>>>>> and reset the rcu_cpu_stall_suppress at the beginning and end =
of the
>>>>>>>> RCU grace period?
>>>>>>> This is possible but not the best: 1, kgdb is not the only =
caller of
>>>>>>> rcu_cpu_stall_reset(); 2, it is difficult to find the "end" to =
reset
>>>>>>> rcu_cpu_stall_suppress.
>>>>>>>=20
>>>>>>=20
>>>>>> You can replace rcu_state.jiffies_stall update by setting =
rcu_cpu_stall_suppress
>>>>>> in rcu_cpu_stall_reset(),  and reset rcu_cpu_stall_suppress in =
rcu_gp_init() and
>>>>>> rcu_gp_cleanup().
>>>>> What's the advantage compared with updating jiffies? Updating =
jiffies
>>>>> seems more straight forward.
>>>>>=20
>>>>=20
>>>> In do_update_jiffies_64(), need to acquire jiffies_lock raw =
spinlock,
>>>> like you said, kgdb is not the only caller of =
rcu_cpu_stall_reset(),
>>>> the rcu_cpu_stall_reset() maybe invoke in NMI  =
(arch/x86/platform/uv/uv_nmi.c)
>>> Reset rcu_cpu_stall_suppress in rcu_gp_init()/rcu_gp_cleanup() is
>>> still not so good to me, because it does a useless operation in most
>>> cases. Moreover, the rcu core is refactored again and again, =
something
>>> may be changed in future.
>>>=20
>>> If  do_update_jiffies_64() cannot be used in NMI context, can we
>>=20
>> What about updating jiffies in dbg_touch_watchdogs or adding a =
wrapper which updates
>> both jiffies and jiffies_stall?
> This can solve the kgdb problem, but I found that most callers of
> rcu_cpu_stall_reset() are in irq disabled context so they may meet

The duration of other contexts where interrupts are disabled may not be =
as long as in the case of kgdb=EF=BC=9F

> similar problems. Modifying rcu_cpu_stall_reset() can solve all of
> them.
>=20
> But due to the NMI issue, from my point of view, setting jiffies_stall
> to jiffies + 300*HZ is the best solution now. :)

If I understand correctly, the NMI issue is the deadlock issue? If so, =
plus the short duration of other irq disabled=20
contexts, it=E2=80=99s ok just update jiffies in dbg_touch_watchdogs.

Please correct me if anything wrong. :)

>=20
> Huacai
>>=20
>>> consider my old method [1]?
>>> =
https://lore.kernel.org/rcu/CAAhV-H7j9Y=3DVvRLm8thLw-EX1PGqBA9YfT4G1AN7ucY=
S=3DiP+DQ@mail.gmail.com/T/#t
>>>=20
>>> Of course we should set rcu_state.jiffies_stall large enough, so we
>>> can do like this:
>>>=20
>>> void rcu_cpu_stall_reset(void)
>>> {
>>> WRITE_ONCE(rcu_state.jiffies_stall,
>>> -   jiffies + rcu_jiffies_till_stall_check());
>>> +   jiffies + 300 * HZ);
>>> }
>>>=20
>>> 300s is the largest timeout value, and I think 300s is enough here =
in practice.
>>>=20
>>> Huacai
>>>=20
>>>>=20
>>>> Thanks
>>>> Zqiang
>>>>=20
>>>>=20
>>>>> Huacai
>>>>>=20
>>>>>>=20
>>>>>> Thanks
>>>>>> Zqiang
>>>>>>=20
>>>>>>>=20
>>>>>>>> or set rcupdate.rcu_cpu_stall_suppress_at_boot=3D1 in bootargs =
can
>>>>>>>> suppress RCU stall
>>>>>>>> in booting.
>>>>>>> This is also possible, but it suppresses all kinds of stall =
warnings,
>>>>>>> which is not what we want.
>>>>>>>=20
>>>>>>> Huacai
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Thanks
>>>>>>>> Zqiang
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> Huacai
>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>                                                       Thanx, =
Paul
>>>>>>>>>>=20
>>>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>>>> Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP =
stall detection in rcu_cpu_stall_reset()")
>>>>>>>>>>> Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
>>>>>>>>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>>>>>>>>>> ---
>>>>>>>>>>> kernel/rcu/tree_stall.h | 1 +
>>>>>>>>>>> 1 file changed, 1 insertion(+)
>>>>>>>>>>>=20
>>>>>>>>>>> diff --git a/kernel/rcu/tree_stall.h =
b/kernel/rcu/tree_stall.h
>>>>>>>>>>> index b10b8349bb2a..1c7b540985bf 100644
>>>>>>>>>>> --- a/kernel/rcu/tree_stall.h
>>>>>>>>>>> +++ b/kernel/rcu/tree_stall.h
>>>>>>>>>>> @@ -153,6 +153,7 @@ static void panic_on_rcu_stall(void)
>>>>>>>>>>> */
>>>>>>>>>>> void rcu_cpu_stall_reset(void)
>>>>>>>>>>> {
>>>>>>>>>>> +     do_update_jiffies_64(ktime_get());
>>>>>>>>>>>     WRITE_ONCE(rcu_state.jiffies_stall,
>>>>>>>>>>>                jiffies + rcu_jiffies_till_stall_check());
>>>>>>>>>>> }
>>>>>>>>>>> --
>>>>>>>>>>> 2.39.3


