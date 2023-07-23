Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17DF75DF83
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 02:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjGWAkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 20:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGWAj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 20:39:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F52D199D;
        Sat, 22 Jul 2023 17:39:58 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b89cfb4571so25146505ad.3;
        Sat, 22 Jul 2023 17:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690072797; x=1690677597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JUqzz2luCw+ctpy0rc5BCEXDL94cbKYesxevVtZQqs=;
        b=fxUYcMX+v8PpLhfXVkYSRxl2sdLCXCWYO0gVFSV5LRbi4vAUDuS5aP7c9cAHQ6Olus
         RWHTmw6LISRfoS4Bfb0GCCh1CUTOkaIWY+KqDp9kowenAlDgJ6U8oqNya4md5lAyeJ0x
         WrmkFNBsBPQxJDiER/EZtcUGJlLP87yKwGZ2p+6xAtDzPTavApX6V51EyR67d3sIjIc3
         2ZGmG0y9mPuPXqG5IfwBPfdrKdLnrzb/KP51D9YEpj8sgrIa1brwl562ZBQfiNubsDTK
         2fkc+rKNsoVb3COFvZrtcCwcu9tZToY3liR1HxkuM+edmMV5zALUF2E2p+9UZb1M4dNq
         cfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690072797; x=1690677597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JUqzz2luCw+ctpy0rc5BCEXDL94cbKYesxevVtZQqs=;
        b=G6TmmCQLEl/ALbFIIz/X493CtxrPP9V5nC+ic6Up79Jmkbwg/LwPaY1ZoSWnhlVQuc
         BynLC3Go7adFcs2jiT+AFJQxvjl3GlVsg950g6yY86K4Z06/azib79a1aKWXzzpTFUQU
         1BbuVtsJy33qnwNcVFI0nuOzkm4ZbHuf4sjtxC6Zd6bWMqySoQ5edNDrfkXxWpR2jMUL
         2F+AW4EuA/xDQYSWgCzbvMUYWhr9BaATQ0R2q5Ixe+hDRjuTUtNI2ffFXA41AYl9spuk
         wQoqZmnihwT+CFh9VzRlOxm1MPvFx9mzV8xNnfrwKxHe/Gce7VcTrdt/mM6p4FGMMOAs
         HrSg==
X-Gm-Message-State: ABy/qLYOGoZCJ+dsMEbqdzyqP6oWInZlVn6qGBH0kukt+iGf1q9CtU+D
        pPZ8LrenJr995y8skYGM12/7w1i3DmsuxSSCK0w=
X-Google-Smtp-Source: APBJJlFSRrU345/sVvT9X7n1pCDwsFxZZN35xvavkVYufN1Lg+6pTggjJioPVsbnfwTIg/+nzVOTRa17svDXykjkCdY=
X-Received: by 2002:a17:903:442:b0:1b8:1bac:3782 with SMTP id
 iw2-20020a170903044200b001b81bac3782mr5918228plb.6.1690072797413; Sat, 22 Jul
 2023 17:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <2023071940-suspect-ominous-4a6a@gregkh> <20230720132714.GA3726096@google.com>
 <CAABZP2xrLRTVM6te22RFTYCpFB6CnyZ1ASjq=vsGuhpnRfU-OA@mail.gmail.com>
 <CAABZP2xwBczWqpPv09JWT+GrJ5oKjeBO7VV1O23yCX7AsbxGBw@mail.gmail.com> <20230723002658.GB284241@google.com>
In-Reply-To: <20230723002658.GB284241@google.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sun, 23 Jul 2023 08:39:46 +0800
Message-ID: <CAABZP2wSvJpvbp6ze0OihO7Tqdx2Vu2FQbsAXAiJTv+PDrJpwg@mail.gmail.com>
Subject: Re: [BUG] Re: Linux 6.4.4
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 8:27=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Sat, Jul 22, 2023 at 09:00:16AM +0800, Zhouyi Zhou wrote:
> > On Fri, Jul 21, 2023 at 9:51=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.c=
om> wrote:
> > >
> > > On Thu, Jul 20, 2023 at 9:31=E2=80=AFPM Joel Fernandes <joel@joelfern=
andes.org> wrote:
> > > >
> > > > On Wed, Jul 19, 2023 at 05:06:39PM +0200, Greg Kroah-Hartman wrote:
> > > > > I'm announcing the release of the 6.4.4 kernel.
> > > > >
> > > > > All users of the 6.4 kernel series must upgrade.
> > > > >
> > > > > The updated 6.4.y git tree can be found at:
> > > > >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable.git linux-6.4.y
> > > > > and can be browsed at the normal kernel.org git web browser:
> > > > >       https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-s=
table.git;a=3Dsummary
> > > >
> > > > I have been consistently hitting the following splat with rcutortur=
e's TREE03
> > > > test on 6.4.4. This happened with 6.4.4-rc3 as well.
> > > Hi, I am also interested in this topic , I am going to test 6.4.4 on =
my laptop
> > I rcu tortured 6.4.4 on my Intel(R) Core(TM) i7-11800H laptop for 2
> > rounds each of which lasting 7 hours.
> > all of them report:
> > Summary: Successes: 55 Failures: 0.
>
> Thanks for checking. One thing about my environment is it is nested
> virtualized. So rcutorture is actually running inside a second-level of
> virtualization which probably adds a lot of timing related uncertainty to=
 my
> testing (which could be a good thing :P).
Thank Joel for your great guidance, now I learned a advanced way to
torture the RCU.
I will try to establish such an environment.

thanks,
  - Zhouyi
>
> thanks,
>
>  - Joel
>
>
> >
> > Thanks, Zhouyi
> > >
> > > Thanks, Zhouyi
> > > >
> > > > Happens at:
> > > >                 WARN_ON_ONCE(n_rcu_torture_boost_failure); // boost=
 failed (TIMER_SOFTIRQ RT prio?)
> > > >
> > > > So likely RCU boosting is failing:
> > > >
> > > > The full TREE03 splat:
> > > > [   54.243588] ------------[ cut here ]------------
> > > > [   54.244547] rcu-torture: rcu_torture_boost started
> > > > [   54.247643] WARNING: CPU: 12 PID: 166 at kernel/rcu/rcutorture.c=
:2227 rcu_torture_stats_print+0x5b2/0x620
> > > > [   54.273082] Modules linked in:
> > > > [   54.278336] CPU: 12 PID: 166 Comm: rcu_torture_sta Not tainted 6=
.4.4-g62813c2d2a36 #1
> > > > [   54.288540] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > > [   54.300499] RIP: 0010:rcu_torture_stats_print+0x5b2/0x620
> > > > [   54.307525] Code: 00 00 48 8b 05 3f 6c 46 02 e9 4a fe ff ff 0f 0=
b e9 02 fd ff ff 0f 0b e9 09 fd ff ff 0f 0b e9 10 fd ff ff 0f 0b e9 17 fd f=
f ff <0f> 0b e9 1e fd ff ff 0f 0b e9 21 fd ff ff e8 0b 54 ff ff 84 c0 0f
> > > > [   54.331276] RSP: 0000:ffff9fef805efe08 EFLAGS: 00010202
> > > > [   54.338374] RAX: 0000000000000000 RBX: ffff9fef805efe88 RCX: 000=
00000ffffdfff
> > > > [   54.347738] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000=
0000000000001
> > > > [   54.358923] RBP: ffff9fef805efe30 R08: 00000000ffffdfff R09: 000=
00000ffffdfff
> > > > [   54.368209] R10: ffffffff94e59280 R11: ffffffff94e59280 R12: 000=
0000000000001
> > > > [   54.377367] R13: 0000000000000000 R14: 00000000000002fc R15: fff=
fffff93514000
> > > > [   54.386739] FS:  0000000000000000(0000) GS:ffff9c901f500000(0000=
) knlGS:0000000000000000
> > > > [   54.397130] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [   54.404585] CR2: 0000000000000000 CR3: 000000000308e000 CR4: 000=
00000000006e0
> > > > [   54.413884] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
> > > > [   54.423118] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
> > > > [   54.432192] Call Trace:
> > > > [   54.435634]  <TASK>
> > > > [   54.438512]  ? rcu_torture_stats_print+0x5b2/0x620
> > > > [   54.444904]  ? __warn+0x7c/0x130
> > > > [   54.449221]  ? rcu_torture_stats_print+0x5b2/0x620
> > > > [   54.455737]  ? report_bug+0x171/0x1a0
> > > > [   54.460935]  ? handle_bug+0x3c/0x70
> > > > [   54.465874]  ? exc_invalid_op+0x17/0x70
> > > > [   54.471336]  ? asm_exc_invalid_op+0x1a/0x20
> > > > [   54.477092]  ? __pfx_rcu_torture_stats+0x10/0x10
> > > > [   54.483472]  ? rcu_torture_stats_print+0x5b2/0x620
> > > > [   54.490029]  ? rcu_torture_stats_print+0x28a/0x620
> > > > [   54.496565]  ? finish_task_switch.isra.0+0x7e/0x240
> > > > [   54.503261]  rcu_torture_stats+0x25/0x70
> > > > [   54.508686]  kthread+0xe3/0x110
> > > > [   54.513141]  ? __pfx_kthread+0x10/0x10
> > > > [   54.518330]  ret_from_fork+0x2c/0x50
> > > > [   54.523356]  </TASK>
> > > > [   54.526500] ---[ end trace 0000000000000000 ]---
> > > >
> > > > Also other issues in 6.4.4, I am seeing RCU failures with TREE07 ab=
out 40
> > > > minutes into the test. This warning indicates that an rcu_torture o=
bject from
> > > > the rcu_torture pool is still allocated which is an indiciation tha=
t RCU is
> > > > not working.
> > > >
> > > > [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
> > > >
> > > > However, if we are to believe the '9', it appears the object did ma=
de it
> > > > quite some till the end of the pipe array but not until the free po=
ol.
> > > >
> > > > The full TREE07 splat:
> > > > [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
> > > > [ 2169.489413] WARNING: CPU: 4 PID: 130 at kernel/rcu/rcutorture.c:=
1584 rcu_torture_writer+0x7f2/0xd80
> > > > [ 2169.504064] Modules linked in:
> > > > [ 2169.508957] CPU: 4 PID: 130 Comm: rcu_torture_wri Not tainted 6.=
4.4-g62813c2d2a36 #2
> > > > [ 2169.521735] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > > [ 2169.540908] RIP: 0010:rcu_torture_writer+0x7f2/0xd80
> > > > [ 2169.548542] Code: 15 8b 62 45 02 49 8d 45 e8 48 39 c2 74 bf e8 8=
5 03 08 00 41 8b 55 f8 48 c7 c6 d0 f7 e0 9d 48 c7 c7 d7 7b 28 9e e8 ce 29 f=
7 ff <0f> 0b 8b 05 9a 48 45 02 85 c0 75 97 89 d8 87 05 8e 48 45 02 85 c0
> > > > [ 2169.578445] RSP: 0000:ffffa645804cfe20 EFLAGS: 00010282
> > > > [ 2169.586793] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000=
00000ffffdfff
> > > > [ 2169.598069] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000=
0000000009ffb
> > > > [ 2169.609359] RBP: ffffa645804cff10 R08: 00000000ffffdfff R09: 000=
00000ffffdfff
> > > > [ 2169.620717] R10: ffffffff9e659220 R11: ffffffff9e659220 R12: 000=
0000000000017
> > > > [ 2169.631918] R13: ffffffff9f166b60 R14: 0000000000000000 R15: 000=
0000000000001
> > > > [ 2169.643365] FS:  0000000000000000(0000) GS:ffff8b3a5f300000(0000=
) knlGS:0000000000000000
> > > > [ 2169.655249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [ 2169.663207] CR2: 0000000000000000 CR3: 000000001562e000 CR4: 000=
00000000006e0
> > > > [ 2169.672806] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
> > > > [ 2169.682194] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
> > > > [ 2169.693530] Call Trace:
> > > > [ 2169.698054]  <TASK>
> > > > [ 2169.701786]  ? rcu_torture_writer+0x7f2/0xd80
> > > > [ 2169.708853]  ? __warn+0x7c/0x120
> > > > [ 2169.714088]  ? rcu_torture_writer+0x7f2/0xd80
> > > > [ 2169.721066]  ? report_bug+0x15d/0x180
> > > > [ 2169.726125]  ? handle_bug+0x3c/0x70
> > > > [ 2169.730948]  ? exc_invalid_op+0x17/0x70
> > > > [ 2169.736238]  ? asm_exc_invalid_op+0x1a/0x20
> > > > [ 2169.742047]  ? rcu_torture_writer+0x7f2/0xd80
> > > > [ 2169.747907]  ? __pfx_rcu_torture_writer+0x10/0x10
> > > > [ 2169.754175]  kthread+0xcb/0xf0
> > > > [ 2169.758407]  ? __pfx_kthread+0x10/0x10
> > > > [ 2169.763501]  ret_from_fork+0x2c/0x50
> > > > [ 2169.768420]  </TASK>
> > > > [ 2169.771445] ---[ end trace 0000000000000000 ]---
> > > > [ 2169.777698] Dumping ftrace buffer:
> > > > [ 2169.782470]    (ftrace buffer empty)
> > > > [ 2169.787241] ------------[ cut here ]------------
> > > >
> > > >
> > > > I will continue to monitor and debug these but since I recently re-=
started
> > > > testing stable (my infra was down for a long time), I don't have an=
y
> > > > reference for when these started happening.
> > > >
> > > > thanks,
> > > >
> > > >  - Joel
> > > >
