Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20D575B43C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGTQbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGTQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:31:29 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E089BE75
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:31:26 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b962535808so14937361fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689870685; x=1690475485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQLbcSCN+2YyuVHPRVItbT+Q+tqkJu9oKiuCw5Oe340=;
        b=MlJxPF5ThvM0GyLpEb9PGaxLrJf7fXVC+WnbtZr5eIXul2XCeW7Czs8Shjd4EL1Qmg
         Fa79yliMRnoR3stB5j3fv29PS4l4v7xzcWa7Bs0NBNCzBhez6n+m4Wq0f+KuIuKtd4ql
         poBR5MBm4ef83jDnkiauHf/yC+aRz01odih5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689870685; x=1690475485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQLbcSCN+2YyuVHPRVItbT+Q+tqkJu9oKiuCw5Oe340=;
        b=Ody7/Bh2+OTpQFvHNDqNapRKLYaSrmWfyNpIzoxIBm1P6LXoKeXNCvq3buVzkTKxc+
         a4BiaEAX6PrQRs8tbBdVF4oRBWGyuN+BytB2syb9bttZICW6QgakniQVRVsmNfh5N9f9
         S914ysBVsUqZW/WLyp5sJk5qkPbyLtU6BO8/BRlHH0JejFUsuqUiqrx9qih9PHAHFx1E
         GhRhMQUvgldv3IsY9+KgpIRUyYftjvZdP7CuR+Gi0I25nB3yAw8bjoJTFZZCVch1wvrB
         JdNh+Cy4ewjVo7G8XrjbdOhPOAestMHrgeV2I87n4cz+xZ00Xn8bzZK0KDIQsHaao19w
         7jfA==
X-Gm-Message-State: ABy/qLZwKLt/sCJMq2D4lgG02UNhq8jJAsYMPK75O0ExmBMn1OQ5b+MW
        pciyLDAhgX7JqEQN1TllLq1Hxwilma7QGuG9+tK3hw==
X-Google-Smtp-Source: APBJJlHw0HhTHSnqucY0VLNy7nbD/ychKrMggduRYAFvn4K5TowI89/A/c9j6ExMpmWj0mMEKmIYV9Wk1aMk90nWBe4=
X-Received: by 2002:a2e:b60e:0:b0:2b6:a6e7:5afa with SMTP id
 r14-20020a2eb60e000000b002b6a6e75afamr2313197ljn.12.1689870684741; Thu, 20
 Jul 2023 09:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <2023071940-suspect-ominous-4a6a@gregkh> <20230720132714.GA3726096@google.com>
 <2b8fc10b-785e-48b9-9a38-5c1af81f9578@paulmck-laptop>
In-Reply-To: <2b8fc10b-785e-48b9-9a38-5c1af81f9578@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 20 Jul 2023 12:31:13 -0400
Message-ID: <CAEXW_YQO7OCdkXm_SBcPhAm8V8vMaF_5DQq7PbG9PZb7RFgA_g@mail.gmail.com>
Subject: Re: [BUG] Re: Linux 6.4.4
To:     paulmck@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Jul 20, 2023 at 11:55=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Thu, Jul 20, 2023 at 01:27:14PM +0000, Joel Fernandes wrote:
> > On Wed, Jul 19, 2023 at 05:06:39PM +0200, Greg Kroah-Hartman wrote:
> > > I'm announcing the release of the 6.4.4 kernel.
> > >
> > > All users of the 6.4 kernel series must upgrade.
> > >
> > > The updated 6.4.y git tree can be found at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
.git linux-6.4.y
> > > and can be browsed at the normal kernel.org git web browser:
> > >     https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.=
git;a=3Dsummary
> >
> > I have been consistently hitting the following splat with rcutorture's =
TREE03
> > test on 6.4.4. This happened with 6.4.4-rc3 as well.
> >
> > Happens at:
> >               WARN_ON_ONCE(n_rcu_torture_boost_failure); // boost faile=
d (TIMER_SOFTIRQ RT prio?)
> >
> > So likely RCU boosting is failing:
> >
> > The full TREE03 splat:
> > [   54.243588] ------------[ cut here ]------------
> > [   54.244547] rcu-torture: rcu_torture_boost started
> > [   54.247643] WARNING: CPU: 12 PID: 166 at kernel/rcu/rcutorture.c:222=
7 rcu_torture_stats_print+0x5b2/0x620
> > [   54.273082] Modules linked in:
> > [   54.278336] CPU: 12 PID: 166 Comm: rcu_torture_sta Not tainted 6.4.4=
-g62813c2d2a36 #1
> > [   54.288540] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.16.2-debian-1.16.2-1 04/01/2014
> > [   54.300499] RIP: 0010:rcu_torture_stats_print+0x5b2/0x620
> > [   54.307525] Code: 00 00 48 8b 05 3f 6c 46 02 e9 4a fe ff ff 0f 0b e9=
 02 fd ff ff 0f 0b e9 09 fd ff ff 0f 0b e9 10 fd ff ff 0f 0b e9 17 fd ff ff=
 <0f> 0b e9 1e fd ff ff 0f 0b e9 21 fd ff ff e8 0b 54 ff ff 84 c0 0f
> > [   54.331276] RSP: 0000:ffff9fef805efe08 EFLAGS: 00010202
> > [   54.338374] RAX: 0000000000000000 RBX: ffff9fef805efe88 RCX: 0000000=
0ffffdfff
> > [   54.347738] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000=
000000001
> > [   54.358923] RBP: ffff9fef805efe30 R08: 00000000ffffdfff R09: 0000000=
0ffffdfff
> > [   54.368209] R10: ffffffff94e59280 R11: ffffffff94e59280 R12: 0000000=
000000001
> > [   54.377367] R13: 0000000000000000 R14: 00000000000002fc R15: fffffff=
f93514000
> > [   54.386739] FS:  0000000000000000(0000) GS:ffff9c901f500000(0000) kn=
lGS:0000000000000000
> > [   54.397130] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   54.404585] CR2: 0000000000000000 CR3: 000000000308e000 CR4: 0000000=
0000006e0
> > [   54.413884] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [   54.423118] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [   54.432192] Call Trace:
> > [   54.435634]  <TASK>
> > [   54.438512]  ? rcu_torture_stats_print+0x5b2/0x620
> > [   54.444904]  ? __warn+0x7c/0x130
> > [   54.449221]  ? rcu_torture_stats_print+0x5b2/0x620
> > [   54.455737]  ? report_bug+0x171/0x1a0
> > [   54.460935]  ? handle_bug+0x3c/0x70
> > [   54.465874]  ? exc_invalid_op+0x17/0x70
> > [   54.471336]  ? asm_exc_invalid_op+0x1a/0x20
> > [   54.477092]  ? __pfx_rcu_torture_stats+0x10/0x10
> > [   54.483472]  ? rcu_torture_stats_print+0x5b2/0x620
> > [   54.490029]  ? rcu_torture_stats_print+0x28a/0x620
> > [   54.496565]  ? finish_task_switch.isra.0+0x7e/0x240
> > [   54.503261]  rcu_torture_stats+0x25/0x70
> > [   54.508686]  kthread+0xe3/0x110
> > [   54.513141]  ? __pfx_kthread+0x10/0x10
> > [   54.518330]  ret_from_fork+0x2c/0x50
> > [   54.523356]  </TASK>
> > [   54.526500] ---[ end trace 0000000000000000 ]---
>
> Agreed, this indicates that RCU priority boosting isn't getting its
> job done.  Does this consistently fail about a minute into the run,
> or is it less deterministic than that?

It is not consistently a minute in, on another run it happened in an hour:
[ 3611.018653] WARNING: CPU: 10 PID: 168 at
kernel/rcu/rcutorture.c:2227 rcu_torture_stats_print+0x5b2/0x620

> > Also other issues in 6.4.4, I am seeing RCU failures with TREE07 about =
40
> > minutes into the test. This warning indicates that an rcu_torture objec=
t from
> > the rcu_torture pool is still allocated which is an indiciation that RC=
U is
> > not working.
> >
> > [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
> >
> > However, if we are to believe the '9', it appears the object did made i=
t
> > quite some till the end of the pipe array but not until the free pool.
>
> This is from this if/for statement, correct?
>
>                 stutter_waited =3D stutter_wait("rcu_torture_writer");
>                 if (stutter_waited &&
>                     !atomic_read(&rcu_fwd_cb_nodelay) &&
>                     !cur_ops->slow_gps &&
>                     !torture_must_stop() &&
>                     boot_ended)
>                         for (i =3D 0; i < ARRAY_SIZE(rcu_tortures); i++)
>                                 if (list_empty(&rcu_tortures[i].rtort_fre=
e) &&
>                                     rcu_access_pointer(rcu_torture_curren=
t) !=3D
>                                     &rcu_tortures[i]) {
>                                         tracing_off();
>                                         show_rcu_gp_kthreads();
>                                         WARN(1, "%s: rtort_pipe_count: %d=
\n", __func__, rcu_tortures[i].rtort_pipe_count);
>                                         rcu_ftrace_dump(DUMP_ALL);
>                                 }

Yes, that's right.

>
> If so, this happens when there was a stutter wait, but RCU grace
> periods failed to clear out the backlog during the several seconds that
> rcutorture was forced idle.  This might be related to the RCU priority
> boosting failure, in which a preempted reader persisted across the
> stutter interval.

When RCU is operating normally, shouldn't the check
"(list_empty(&rcu_tortures[i].rtort_free)" not run until the preempted
reader unblocks and exits its RCU read-side critical section?

One thing that confuses me, in the case of
"cur_ops->deferred_free(old_rp);" , the earlier do-while loop may exit
before the async callbacks can finish. So what prevents the
"(list_empty(&rcu_tortures[i].rtort_free)" check from happening before
grace periods happen? Thanks for any clarification.

>
> > The full TREE07 splat:
> > [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
> > [ 2169.489413] WARNING: CPU: 4 PID: 130 at kernel/rcu/rcutorture.c:1584=
 rcu_torture_writer+0x7f2/0xd80
> > [ 2169.504064] Modules linked in:
> > [ 2169.508957] CPU: 4 PID: 130 Comm: rcu_torture_wri Not tainted 6.4.4-=
g62813c2d2a36 #2
> > [ 2169.521735] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.16.2-debian-1.16.2-1 04/01/2014
> > [ 2169.540908] RIP: 0010:rcu_torture_writer+0x7f2/0xd80
> > [ 2169.548542] Code: 15 8b 62 45 02 49 8d 45 e8 48 39 c2 74 bf e8 85 03=
 08 00 41 8b 55 f8 48 c7 c6 d0 f7 e0 9d 48 c7 c7 d7 7b 28 9e e8 ce 29 f7 ff=
 <0f> 0b 8b 05 9a 48 45 02 85 c0 75 97 89 d8 87 05 8e 48 45 02 85 c0
> > [ 2169.578445] RSP: 0000:ffffa645804cfe20 EFLAGS: 00010282
> > [ 2169.586793] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000=
0ffffdfff
> > [ 2169.598069] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000=
000009ffb
> > [ 2169.609359] RBP: ffffa645804cff10 R08: 00000000ffffdfff R09: 0000000=
0ffffdfff
> > [ 2169.620717] R10: ffffffff9e659220 R11: ffffffff9e659220 R12: 0000000=
000000017
> > [ 2169.631918] R13: ffffffff9f166b60 R14: 0000000000000000 R15: 0000000=
000000001
> > [ 2169.643365] FS:  0000000000000000(0000) GS:ffff8b3a5f300000(0000) kn=
lGS:0000000000000000
> > [ 2169.655249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 2169.663207] CR2: 0000000000000000 CR3: 000000001562e000 CR4: 0000000=
0000006e0
> > [ 2169.672806] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [ 2169.682194] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [ 2169.693530] Call Trace:
> > [ 2169.698054]  <TASK>
> > [ 2169.701786]  ? rcu_torture_writer+0x7f2/0xd80
> > [ 2169.708853]  ? __warn+0x7c/0x120
> > [ 2169.714088]  ? rcu_torture_writer+0x7f2/0xd80
> > [ 2169.721066]  ? report_bug+0x15d/0x180
> > [ 2169.726125]  ? handle_bug+0x3c/0x70
> > [ 2169.730948]  ? exc_invalid_op+0x17/0x70
> > [ 2169.736238]  ? asm_exc_invalid_op+0x1a/0x20
> > [ 2169.742047]  ? rcu_torture_writer+0x7f2/0xd80
> > [ 2169.747907]  ? __pfx_rcu_torture_writer+0x10/0x10
> > [ 2169.754175]  kthread+0xcb/0xf0
> > [ 2169.758407]  ? __pfx_kthread+0x10/0x10
> > [ 2169.763501]  ret_from_fork+0x2c/0x50
> > [ 2169.768420]  </TASK>
> > [ 2169.771445] ---[ end trace 0000000000000000 ]---
> > [ 2169.777698] Dumping ftrace buffer:
> > [ 2169.782470]    (ftrace buffer empty)
> > [ 2169.787241] ------------[ cut here ]------------
> >
> >
> > I will continue to monitor and debug these but since I recently re-star=
ted
> > testing stable (my infra was down for a long time), I don't have any
> > reference for when these started happening.
>
> I haven't been seeing this in v6.4, though there is always the possibilit=
y
> that your hardware setup has timing differences from mine, so maybe my
> testing simply isn't seeing this.
>
> And thank you very much for testing this!!!

Sure, my pleasure, thanks!

 - Joel
