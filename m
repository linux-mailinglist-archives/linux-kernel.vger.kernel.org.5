Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C4477E620
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344585AbjHPQOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344537AbjHPQNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:13:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C0DC1;
        Wed, 16 Aug 2023 09:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA43A668E6;
        Wed, 16 Aug 2023 16:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D199C433CB;
        Wed, 16 Aug 2023 16:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692202424;
        bh=jQYkHke0soALnUJjyWhSomyPV+FCVP+1SeSCb3FbXOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E95UyglSfjGh70zmgdrz9PuWxugktCPAibLPoeYD7HudlBxBHUVGconbZTClPaGQT
         YiBbUSoS3HXz/UvzvZ0IQ7tU5X+8fyclyy7Jup/6xrQuP0fH9Pjil/uTumQ9YNVnrd
         Yk91C0hybar5bRetasNsCH98BehTR1DnjCvmJ8T8E2x9fxNxs5QoR8rnqknYACirL6
         /RgXbHwxzWY0IYrRnmT2+7uXvqk8/GmNY8FBp6nPNvv4b6v+ZDQdIZ/seR89h5A0C5
         R6LD2QqOhF4DgHrpeeVnMGdpEmGH7pUeSaeXbrgtWQz451pjwF9W423Ausf2cv0/Co
         1MJDM/CCRXbFQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so10852250e87.3;
        Wed, 16 Aug 2023 09:13:44 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz0TgPgYNznEtZ2snLR+AlRdmOyyFN4FQ5osE2TOwL49SNpcBl2
        zrIlT6z5GrJDmDzS1XdGYmpAXIBtRZbl215jHrU=
X-Google-Smtp-Source: AGHT+IH2dhnFu0Q1LfTXp6RIYUoemBWEdNHjsqGUy3Y72+Q1zbElBwtqAk2WUeVzE/x67wGpArXmFqVhwYrSL0evH/o=
X-Received: by 2002:ac2:58c9:0:b0:4fe:1dc8:7ec with SMTP id
 u9-20020ac258c9000000b004fe1dc807ecmr1759609lfo.37.1692202422172; Wed, 16 Aug
 2023 09:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230814020045.51950-1-chenhuacai@loongson.cn>
 <20230814020045.51950-2-chenhuacai@loongson.cn> <18b9119c-cbc8-42a1-a313-9154d73c9841@paulmck-laptop>
 <CAAhV-H7t46hD1k18-sLYQA8h=M+ROdyMnT7gRtEGoRwKKBUZUA@mail.gmail.com>
 <CALm+0cWkQ8j_jiOSOuSsR9LbKPUL5cxRrONVxeNgSM5f1nDxMQ@mail.gmail.com>
 <CAAhV-H6S3Scu-Mf7E3aaqySytY4xDgjXrWc=fXSbr4i7R+-GDA@mail.gmail.com>
 <CALm+0cUpqONZOEHbc85d-Z5cC=P5LSeOAGuCCOukpTagLxnXWw@mail.gmail.com>
 <CAAhV-H7J6Rj99M6rxoFCEKu4G6NQPX9-N0a3-2GjEwbr+tbwQw@mail.gmail.com>
 <CALm+0cVdaXn5+4veu2NDwdi7htm=KY4ca+Eh54TwnN_6Xjs8TA@mail.gmail.com>
 <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com> <D3AFC0E7-9E6C-43F2-B9F5-3AC498B14F0F@gmail.com>
In-Reply-To: <D3AFC0E7-9E6C-43F2-B9F5-3AC498B14F0F@gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 17 Aug 2023 00:13:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6XPmDFEKGwjcbv57jRwpUvZ76PcmJjxN50Dpbq+-QgKA@mail.gmail.com>
Message-ID: <CAAhV-H6XPmDFEKGwjcbv57jRwpUvZ76PcmJjxN50Dpbq+-QgKA@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     Alan Huang <mmpgouride@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alan,

On Wed, Aug 16, 2023 at 11:57=E2=80=AFPM Alan Huang <mmpgouride@gmail.com> =
wrote:
>
> >>>>>>>>>
> >>>>>>>>> Currently rcu_cpu_stall_reset() set rcu_state.jiffies_stall to =
one check
> >>>>>>>>> period later, i.e. jiffies + rcu_jiffies_till_stall_check(). Bu=
t jiffies
> >>>>>>>>> is only updated in the timer interrupt, so when kgdb_cpu_enter(=
) begins
> >>>>>>>>> to run there may already be nearly one rcu check period after j=
iffies.
> >>>>>>>>> Since all interrupts are disabled during kgdb_cpu_enter(), jiff=
ies will
> >>>>>>>>> not be updated. When kgdb_cpu_enter() returns, rcu_state.jiffie=
s_stall
> >>>>>>>>> maybe already gets timeout.
> >>>>>>>>>
> >>>>>>>>> We can set rcu_state.jiffies_stall to two rcu check periods lat=
er, e.g.
> >>>>>>>>> jiffies + (rcu_jiffies_till_stall_check() * 2) in rcu_cpu_stall=
_reset()
> >>>>>>>>> to avoid this problem. But this isn't a complete solution becau=
se kgdb
> >>>>>>>>> may take a very long time in irq disabled context.
> >>>>>>>>>
> >>>>>>>>> Instead, update jiffies at the beginning of rcu_cpu_stall_reset=
() can
> >>>>>>>>> solve all kinds of problems.
> >>>>>>>>
> >>>>>>>> Would it make sense for there to be a kgdb_cpu_exit()?  In that =
case,
> >>>>>>>> the stalls could simply be suppressed at the beginning of the de=
bug
> >>>>>>>> session and re-enabled upon exit, as is currently done for sysrq=
 output
> >>>>>>>> via rcu_sysrq_start() and rcu_sysrq_end().
> >>>>>>> Thank you for your advice, but that doesn't help. Because
> >>>>>>> rcu_sysrq_start() and rcu_sysrq_end() try to suppress the warning=
s
> >>>>>>> during sysrq, but kgdb already has no warnings during kgdb_cpu_en=
ter()
> >>>>>>> since it is executed in irq disabled context. Instead, this patch
> >>>>>>> wants to suppress the warnings *after* kgdb_cpu_enter() due to a =
very
> >>>>>>> old jiffies value.
> >>>>>>>
> >>>>>>
> >>>>>> Hello, Huacai
> >>>>>>
> >>>>>> Is it possible to set  the rcu_cpu_stall_suppress is true in
> >>>>>> dbg_touch_watchdogs()
> >>>>>> and reset the rcu_cpu_stall_suppress at the beginning and end of t=
he
> >>>>>> RCU grace period?
> >>>>> This is possible but not the best: 1, kgdb is not the only caller o=
f
> >>>>> rcu_cpu_stall_reset(); 2, it is difficult to find the "end" to rese=
t
> >>>>> rcu_cpu_stall_suppress.
> >>>>>
> >>>>
> >>>> You can replace rcu_state.jiffies_stall update by setting rcu_cpu_st=
all_suppress
> >>>> in rcu_cpu_stall_reset(),  and reset rcu_cpu_stall_suppress in rcu_g=
p_init() and
> >>>> rcu_gp_cleanup().
> >>> What's the advantage compared with updating jiffies? Updating jiffies
> >>> seems more straight forward.
> >>>
> >>
> >> In do_update_jiffies_64(), need to acquire jiffies_lock raw spinlock,
> >> like you said, kgdb is not the only caller of rcu_cpu_stall_reset(),
> >> the rcu_cpu_stall_reset() maybe invoke in NMI  (arch/x86/platform/uv/u=
v_nmi.c)
> > Reset rcu_cpu_stall_suppress in rcu_gp_init()/rcu_gp_cleanup() is
> > still not so good to me, because it does a useless operation in most
> > cases. Moreover, the rcu core is refactored again and again, something
> > may be changed in future.
> >
> > If  do_update_jiffies_64() cannot be used in NMI context, can we
>
> What about updating jiffies in dbg_touch_watchdogs or adding a wrapper wh=
ich updates
> both jiffies and jiffies_stall?
This can solve the kgdb problem, but I found that most callers of
rcu_cpu_stall_reset() are in irq disabled context so they may meet
similar problems. Modifying rcu_cpu_stall_reset() can solve all of
them.

But due to the NMI issue, from my point of view, setting jiffies_stall
to jiffies + 300*HZ is the best solution now. :)

Huacai
>
> > consider my old method [1]?
> > https://lore.kernel.org/rcu/CAAhV-H7j9Y=3DVvRLm8thLw-EX1PGqBA9YfT4G1AN7=
ucYS=3DiP+DQ@mail.gmail.com/T/#t
> >
> > Of course we should set rcu_state.jiffies_stall large enough, so we
> > can do like this:
> >
> > void rcu_cpu_stall_reset(void)
> > {
> >  WRITE_ONCE(rcu_state.jiffies_stall,
> > -   jiffies + rcu_jiffies_till_stall_check());
> > +   jiffies + 300 * HZ);
> > }
> >
> > 300s is the largest timeout value, and I think 300s is enough here in p=
ractice.
> >
> > Huacai
> >
> >>
> >> Thanks
> >> Zqiang
> >>
> >>
> >>> Huacai
> >>>
> >>>>
> >>>> Thanks
> >>>> Zqiang
> >>>>
> >>>>>
> >>>>>> or set rcupdate.rcu_cpu_stall_suppress_at_boot=3D1 in bootargs can
> >>>>>> suppress RCU stall
> >>>>>> in booting.
> >>>>> This is also possible, but it suppresses all kinds of stall warning=
s,
> >>>>> which is not what we want.
> >>>>>
> >>>>> Huacai
> >>>>>>
> >>>>>>
> >>>>>> Thanks
> >>>>>> Zqiang
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Huacai
> >>>>>>>
> >>>>>>>>
> >>>>>>>>                                                        Thanx, Pa=
ul
> >>>>>>>>
> >>>>>>>>> Cc: stable@vger.kernel.org
> >>>>>>>>> Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall =
detection in rcu_cpu_stall_reset()")
> >>>>>>>>> Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> >>>>>>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>>>>>>>> ---
> >>>>>>>>> kernel/rcu/tree_stall.h | 1 +
> >>>>>>>>> 1 file changed, 1 insertion(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> >>>>>>>>> index b10b8349bb2a..1c7b540985bf 100644
> >>>>>>>>> --- a/kernel/rcu/tree_stall.h
> >>>>>>>>> +++ b/kernel/rcu/tree_stall.h
> >>>>>>>>> @@ -153,6 +153,7 @@ static void panic_on_rcu_stall(void)
> >>>>>>>>>  */
> >>>>>>>>> void rcu_cpu_stall_reset(void)
> >>>>>>>>> {
> >>>>>>>>> +     do_update_jiffies_64(ktime_get());
> >>>>>>>>>      WRITE_ONCE(rcu_state.jiffies_stall,
> >>>>>>>>>                 jiffies + rcu_jiffies_till_stall_check());
> >>>>>>>>> }
> >>>>>>>>> --
> >>>>>>>>> 2.39.3
>
>
