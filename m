Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D1178AEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjH1Lbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjH1LbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:31:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4EBE7;
        Mon, 28 Aug 2023 04:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34C79644F5;
        Mon, 28 Aug 2023 11:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0ABC433C7;
        Mon, 28 Aug 2023 11:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693222268;
        bh=Nhion05gVnDK6S9dWuQYwIm+H21e1aZtGHRfwWW5B4Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rfJF0avrAMX2oDW30SSR0xJi79YnoYmOJKbFFWoPuTJ4RNDjNDEMnOU0QopXJlhhZ
         hge8x62/bDP8pH+UCXpS18/szaR4jQoygldyjVOILGS2qLl/CaIKNl/i1a2lNS9Ba2
         bHrRp6TrtM1hrb8anUwKb6kWbDHe1WWlhM3hoa/m89tcxpaOQQ87hnJ3odpN2YYILK
         4Ra4umyL7N7cmEgKOQyaWFjGa1/X3XkWDkotAYvvqws+gBsFTuwBthWZWrlq/HW/H9
         pGk39C25XAOIuNLogb6p4Ovhmhw0gLOUMLKjURwGph9QASHtzG+OS9ZgnzSDz02qLR
         cBlqKxcVRyWlw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-99c1d03e124so405894766b.2;
        Mon, 28 Aug 2023 04:31:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YwwbJNXBSWFs7/vERTrX2z5O1NJiDvoDDI8Dsl2BV9nQFj2PX1c
        3+SOYjENUDjIxnyekun6tZ0uiCyYEnwY94iIqyk=
X-Google-Smtp-Source: AGHT+IGLeODxbIyTL5Ow53F35GSsVkvyB/kUjH1zd48Qn339Qibc5wi6a1Bv79ZKnXlQIzXYbich/pPwHHY6t1DW78Q=
X-Received: by 2002:a17:906:5198:b0:9a1:b967:aca8 with SMTP id
 y24-20020a170906519800b009a1b967aca8mr12841234ejk.4.1693222266793; Mon, 28
 Aug 2023 04:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <16827b4e-9823-456d-a6be-157fbfae64c3@paulmck-laptop>
 <CAAhV-H7uXA=r-w1nN7sBpRTba3LjjZs+wasJfGo7VZ6D9eMBAw@mail.gmail.com>
 <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop> <CAAhV-H5BNPX8Eo3Xdy-jcYY97=xazGU+VVqoDy7qEH+VpVWFJA@mail.gmail.com>
 <24e34f50-32d2-4b67-8ec0-1034c984d035@paulmck-laptop> <CAAhV-H5pfDG_tsRDL4dUYykaQ1ZwQYRDrQccpULBM5+kF4i2fA@mail.gmail.com>
 <20230825232807.GA97898@google.com> <CAEXW_YSock304V471X_A7WrxCWtHJGx3APmSy0k7Lc0o69D9Hg@mail.gmail.com>
 <CAAhV-H6PM_KZj4_h-SdJAaseMDK2nMqqJWL8fWHhL4vUA50bQg@mail.gmail.com>
 <CAEXW_YS5dVVOQvO6tWwF7mrgtHiYgVKP_TAipzBNiaFqWDzdeQ@mail.gmail.com> <2681134d-cc88-49a0-a1bc-4ec0816288f6@paulmck-laptop>
In-Reply-To: <2681134d-cc88-49a0-a1bc-4ec0816288f6@paulmck-laptop>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 28 Aug 2023 19:30:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6hkyAe616BuuE2H2TqNYFXqyHpJVc_Zn4307JszuVKYQ@mail.gmail.com>
Message-ID: <CAAhV-H6hkyAe616BuuE2H2TqNYFXqyHpJVc_Zn4307JszuVKYQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Z qiang <qiang.zhang1211@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul and Joel,

On Mon, Aug 28, 2023 at 6:47=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Sun, Aug 27, 2023 at 06:11:40PM -0400, Joel Fernandes wrote:
> > On Sun, Aug 27, 2023 at 1:51=E2=80=AFAM Huacai Chen <chenhuacai@kernel.=
org> wrote:
> > [..]
> > > > > > > The only way I know of to avoid these sorts of false positive=
s is for
> > > > > > > the user to manually suppress all timeouts (perhaps using a k=
ernel-boot
> > > > > > > parameter for your early-boot case), do the gdb work, and the=
n unsuppress
> > > > > > > all stalls.  Even that won't work for networking, because the=
 other
> > > > > > > system's clock will be running throughout.
> > > > > > >
> > > > > > > In other words, from what I know now, there is no perfect sol=
ution.
> > > > > > > Therefore, there are sharp limits to the complexity of any so=
lution that
> > > > > > > I will be willing to accept.
> > > > > > I think the simplest solution is (I hope Joel will not angry):
> > > > >
> > > > > Not angry at all, just want to help. ;-). The problem is the 300*=
HZ solution
> > > > > will also effect the VM workloads which also do a similar reset. =
 Allow me few
> > > > > days to see if I can take a shot at fixing it slightly differentl=
y. I am
> > > > > trying Paul's idea of setting jiffies at a later time. I think it=
 is doable.
> > > > > I think the advantage of doing this is it will make stall detecti=
on more
> > > > > robust in this face of these gaps in jiffie update. And that solu=
tion does
> > > > > not even need us to rely on ktime (and all the issues that come w=
ith that).
> > > > >
> > > >
> > > > I wrote a patch similar to Paul's idea and sent it out for review, =
the
> > > > advantage being it purely is based on jiffies. Could you try it out
> > > > and let me know?
> > > If you can cc my gmail <chenhuacai@gmail.com>, that could be better.
> >
> > Sure, will do.
> >
> > > I have read your patch, maybe the counter (nr_fqs_jiffies_stall)
> > > should be atomic_t and we should use atomic operation to decrement it=
s
> > > value. Because rcu_gp_fqs() can be run concurrently, and we may miss
> > > the (nr_fqs =3D=3D 1) condition.
> >
> > I don't think so. There is only 1 place where RMW operation happens
> > and rcu_gp_fqs() is called only from the GP kthread. So a concurrent
> > RMW (and hence a lost update) is not possible.
>
> Huacai, is your concern that the gdb user might have created a script
> (for example, printing a variable or two, then automatically continuing),
> so that breakpoints could happen in quick successsion, such that the
> second breakpoint might run concurrently with rcu_gp_fqs()?
>
> If this can really happen, the point that Joel makes is a good one, namel=
y
> that rcu_gp_fqs() is single-threaded and (absent rcutorture) runs only
> once every few jiffies.  And gdb breakpoints, even with scripting, should
> also be rather rare.  So if this is an issue, a global lock should do the
> trick, perhaps even one of the existing locks in the rcu_state structure.
> The result should then be just as performant/scalable and a lot simpler
> than use of atomics.
Sorry, I made a mistake. Yes, there is no concurrent issue, and this
approach probably works. But I have another problem: how to ensure
that there is a jiffies update in three calls to rcu_gp_fqs()? Or in
other word, is three also a magic number here?

And I rechecked the commit message of a80be428fbc1f1f3bc9e ("rcu: Do
not disable GP stall detection in rcu_cpu_stall_reset()"). I don't
know why Sergey said that the original code disables stall-detection
forever, in fact it only disables the detection in the current GP.

Huacai

>
> > Could you test the patch for the issue you are seeing and provide your
> > Tested-by tag? Thanks,
>
> Either way, testing would of course be very good!  ;-)
>
>                                                         Thanx, Paul
