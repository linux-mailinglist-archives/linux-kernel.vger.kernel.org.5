Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5960F789B7D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 07:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjH0FvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 01:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjH0FvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 01:51:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A173121;
        Sat, 26 Aug 2023 22:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93DD261F06;
        Sun, 27 Aug 2023 05:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB709C433CC;
        Sun, 27 Aug 2023 05:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693115469;
        bh=C+Nf7CBzD0Q5vLjwMcpMDCumqXPtwRgFtsKEMR9LScY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UKVRPaauWeqwwN25bqPQKF4eSbqX8RbK2Yh7jZmwdlgoN+tyOekoRk1nEACVYIIG2
         1U0qTKWH+Zkfrr5US9wNKT37lDKgLBDpk9PFLb53D6URciSAeUMhicRNqKk69Lijsh
         ICyfIZQUwDy3FXGgbSI7EO41F+U+tgk9YtUZQt2Of2HfjHKe7c60Jw5vG6a7humHCs
         8WLAqZus4p7eRD+J2Yq2qi96RBiQFKnnyk4OlLZbPsQa44vHGkvmMg3faFkcJtVcSU
         QVdI6/uEekop+4Eae9AmR7kKN363ULf7jVF6EiKVcOM4PZvrr8chp/xbo1SJbXESH/
         nlLvTraBSgsLw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so3318318e87.2;
        Sat, 26 Aug 2023 22:51:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YxEOKTnaniZx4iss2sTm9qJ/leUyA0bj+ddVd10eCqQ/uEnZCNj
        h07VubzGDzdBNwQx/DSsuSGHSb+zNIct3kAB5go=
X-Google-Smtp-Source: AGHT+IHA61TPYdTr1bFR7cKpkifAmXg0s/MST49tU58axMFhVT05AZUNdxy9+5xdiFli8x7Z7z5luA1jDhMhr1/345U=
X-Received: by 2002:a05:6512:1310:b0:500:96dd:f95b with SMTP id
 x16-20020a056512131000b0050096ddf95bmr8955559lfu.59.1693115466912; Sat, 26
 Aug 2023 22:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx> <03fe7084-0509-45fa-87ee-8f8705a221a6@paulmck-laptop>
 <CAAhV-H5Z3s=2_OyA_AJ1-NqXBtNrcs-EmsqYcrjc+qXmJ=SitQ@mail.gmail.com>
 <16827b4e-9823-456d-a6be-157fbfae64c3@paulmck-laptop> <CAAhV-H7uXA=r-w1nN7sBpRTba3LjjZs+wasJfGo7VZ6D9eMBAw@mail.gmail.com>
 <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop> <CAAhV-H5BNPX8Eo3Xdy-jcYY97=xazGU+VVqoDy7qEH+VpVWFJA@mail.gmail.com>
 <24e34f50-32d2-4b67-8ec0-1034c984d035@paulmck-laptop> <CAAhV-H5pfDG_tsRDL4dUYykaQ1ZwQYRDrQccpULBM5+kF4i2fA@mail.gmail.com>
 <20230825232807.GA97898@google.com> <CAEXW_YSock304V471X_A7WrxCWtHJGx3APmSy0k7Lc0o69D9Hg@mail.gmail.com>
In-Reply-To: <CAEXW_YSock304V471X_A7WrxCWtHJGx3APmSy0k7Lc0o69D9Hg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 27 Aug 2023 13:50:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6PM_KZj4_h-SdJAaseMDK2nMqqJWL8fWHhL4vUA50bQg@mail.gmail.com>
Message-ID: <CAAhV-H6PM_KZj4_h-SdJAaseMDK2nMqqJWL8fWHhL4vUA50bQg@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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

Hi, Joel,

On Sun, Aug 27, 2023 at 11:27=E2=80=AFAM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> On Fri, Aug 25, 2023 at 7:28=E2=80=AFPM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> >
> > On Fri, Aug 25, 2023 at 07:15:44PM +0800, Huacai Chen wrote:
> > > Hi, Paul,
> > >
> > > On Fri, Aug 25, 2023 at 2:28=E2=80=AFAM Paul E. McKenney <paulmck@ker=
nel.org> wrote:
> [..]
> > > > > > > > > > > > On Thu, Aug 17, 2023 at 3:27=E2=80=AFAM Joel Fernan=
des <joel@joelfernandes.org> wrote:
> > > > > > > > > > > >> > If  do_update_jiffies_64() cannot be used in NMI=
 context,
> > > > > > > > > > > >>
> > > > > > > > > > > >> Can you not make the jiffies update conditional on=
 whether it is
> > > > > > > > > > > >> called within NMI context?
> > > > > > > > > > >
> > > > > > > > > > > Which solves what? If KGDB has a breakpoint in the ji=
ffies lock held
> > > > > > > > > > > region then you still dead lock.
> > > > > > > > > > >
> > > > > > > > > > > >> I dislike that..
> > > > > > > > > > > > Is this acceptable?
> > > > > > > > > > > >
> > > > > > > > > > > > void rcu_cpu_stall_reset(void)
> > > > > > > > > > > > {
> > > > > > > > > > > >         unsigned long delta;
> > > > > > > > > > > >
> > > > > > > > > > > >         delta =3D nsecs_to_jiffies(ktime_get_ns() -=
 ktime_get_coarse_ns());
> > > > > > > > > > > >
> > > > > > > > > > > >         WRITE_ONCE(rcu_state.jiffies_stall,
> > > > > > > > > > > >                    jiffies + delta + rcu_jiffies_ti=
ll_stall_check());
> > > > > > > > > > > > }
> > > > > > > > > > > >
> > > > > > > > > > > > This can update jiffies_stall without updating jiff=
ies (but has the
> > > > > > > > > > > > same effect).
> > > > > > > > > > >
> > > > > > > > > > > Now you traded the potential dead lock on jiffies loc=
k for a potential
> > > > > > > > > > > live lock vs. tk_core.seq. Not really an improvement,=
 right?
> > > > > > > > > > >
> > > > > > > > > > > The only way you can do the above is something like t=
he incomplete and
> > > > > > > > > > > uncompiled below. NMI safe and therefore livelock pro=
of time interfaces
> > > > > > > > > > > exist for a reason.
> > > > > > > > > >
> > > > > > > > > > Just for completeness, another approach, with its own a=
dvantages
> > > > > > > > > > and disadvantage, is to add something like ULONG_MAX/4 =
to
> > > > > > > > > > rcu_state.jiffies_stall, but also set a counter indicat=
ing that this
> > > > > > > > > > has been done.  Then RCU's force-quiescent processing c=
ould decrement
> > > > > > > > > > that counter (if non-zero) and reset rcu_state.jiffies_=
stall when it
> > > > > > > > > > does reach zero.
> > > > > > > > > >
> > > > > > > > > > Setting the counter to three should cover most cases, b=
ut "live by the
> > > > > > > > > > heuristic, die by the heuristic".  ;-)
> > > > > > > > > >
> > > > > > > > > > It would be good to have some indication when gdb exite=
d, but things
> > > > > > > > > > like the gdb "next" command can make that "interesting"=
 when applied to
> > > > > > > > > > a long-running function.
> > > > > > > > >
> > > > > > > > > The original code is adding ULONG_MAX/2, so adding ULONG_=
MAX/4 may
> > > > > > > > > make no much difference? The simplest way is adding 300*H=
Z, but Joel
> > > > > > > > > dislikes that.
> > > > > > > >
> > > > > > > > I am not seeing the ULONG_MAX/2, so could you please point =
me to that
> > > > > > > > original code?
> > > > > > >
> > > > > > > Maybe I misunderstand something, I say the original code mean=
s code
> > > > > > > before commit a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable =
GP stall
> > > > > > > detection in rcu_cpu_stall_reset()").
> > > > > >
> > > > > > Yes, my suggestion would essentially revert that patch.  It wou=
ld
> > > > > > compensate by resetting rcu_state.jiffies_stall after a few cal=
ls
> > > > > > to rcu_gp_fqs().
> > > > > >
> > > > > > Alternatively, we could simply provide a way for gdb users to m=
anually
> > > > > > disable RCU CPU stall warnings at the beginning of their debug =
sessions
> > > > > > and to manually re-enable them when they are done.
> > > > >
> > > > > This problem is not KGDB-specific (though it is firstly found in =
the
> > > > > KGDB case), so I want to fix it in the rcu code rather than in th=
e
> > > > > kgdb code.
> > > >
> > > > Sure, for example, there is also PowerPC XMON.
> > > >
> > > > But this problem also is not RCU-specific.  There are also hardlock=
ups,
> > > > softlockups, workqueue lockups, networking timeouts, and who knows =
what
> > > > all else.
> > > >
> > > > Plus, and again to Thomas's point, gdb breakpoints can happen anywh=
ere.
> > > > For example, immediately after RCU computes the RCU CPU stall time =
for
> > > > a new grace period, and right before it stores it.  The gdb callout
> > > > updates rcu_state.jiffies_stall, but that update is overwritten wit=
h a
> > > > stale value as soon as the system starts back up.
> > > >
> > > > Low probabillity, to be sure, but there are quite a few places in
> > > > the kernel right after a read from some timebase or another, and ma=
ny
> > > > (perhaps all) of these can see similar stale-time-use problems.
> > > >
> > > > The only way I know of to avoid these sorts of false positives is f=
or
> > > > the user to manually suppress all timeouts (perhaps using a kernel-=
boot
> > > > parameter for your early-boot case), do the gdb work, and then unsu=
ppress
> > > > all stalls.  Even that won't work for networking, because the other
> > > > system's clock will be running throughout.
> > > >
> > > > In other words, from what I know now, there is no perfect solution.
> > > > Therefore, there are sharp limits to the complexity of any solution=
 that
> > > > I will be willing to accept.
> > > I think the simplest solution is (I hope Joel will not angry):
> >
> > Not angry at all, just want to help. ;-). The problem is the 300*HZ sol=
ution
> > will also effect the VM workloads which also do a similar reset.  Allow=
 me few
> > days to see if I can take a shot at fixing it slightly differently. I a=
m
> > trying Paul's idea of setting jiffies at a later time. I think it is do=
able.
> > I think the advantage of doing this is it will make stall detection mor=
e
> > robust in this face of these gaps in jiffie update. And that solution d=
oes
> > not even need us to rely on ktime (and all the issues that come with th=
at).
> >
>
> I wrote a patch similar to Paul's idea and sent it out for review, the
> advantage being it purely is based on jiffies. Could you try it out
> and let me know?
If you can cc my gmail <chenhuacai@gmail.com>, that could be better.

I have read your patch, maybe the counter (nr_fqs_jiffies_stall)
should be atomic_t and we should use atomic operation to decrement its
value. Because rcu_gp_fqs() can be run concurrently, and we may miss
the (nr_fqs =3D=3D 1) condition.

Huacai
>
> thanks,
>
>  - Joel
