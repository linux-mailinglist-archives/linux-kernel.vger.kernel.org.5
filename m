Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE80F7929C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352756AbjIEQ2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353476AbjIEGUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:20:55 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72CA191
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 23:20:51 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4909915fc30so1835988e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 23:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693894851; x=1694499651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dTsyYa/QdP6Tl24EGEqM/W7pZY67ehglq6B9Jrf8D4=;
        b=bC4GRH43n/O6uqB8W905e4Bd1DGmh/k6yWROpWKQzmFCIh77pymX6l3JptVtyeR01x
         aF2TqVvIsZznvbcbZoJLzUzgt27LvwUUgDhLJ2iannuQuEGaTuwAjHWd0eP2hM2PvfOR
         A+oK7DwiZrjJltU76XLF83FAm+0oO/B/MDlJXiy26xk3UOkA8DczOXqEesojvGuYaiwx
         egegil2eUXik/x6pd4BsNmmcOvcDnPOBlbFhQEjr+xH1ZCwvFoHBkbd7s0IIqPY4EkXi
         f+W6NcwYu6puBBCmcTjR3bWiQQRzZgSaE7YCzHpCVhtGhWdv9sdHbRBVEOEDJgzSs1aw
         /fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693894851; x=1694499651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dTsyYa/QdP6Tl24EGEqM/W7pZY67ehglq6B9Jrf8D4=;
        b=DysbFH+G0ezPR/OJnSyQL1qWduH93bhFQGUAp/2oQSmbtn9KhHB3IJxVzMSGXnTuVG
         fq33HHQ7cM7prLUvcWxLfsMbj/MzyBPFx1A4bgK8XIFu04zksXgprQNUNp6kfZ4x+3e6
         dr09g1k8cHVVCFAoGskRbBztxmrDW3j+vWtqUyjyHDlnJZJ9BrOCdgls4gwyE0xURQw5
         90t/DN+Qk1nadB+ZWKI7JGaBT+VCdekutgQoRGQvGAV06pj4qU0J0UjtNQD0KefWASiA
         UQNfg+Spwi+8Ee1HZHh6WGEQC+a3k7HqATI61B+XF/y4uM8mB49EcpPX4oCn2c/gGNlQ
         Kfkw==
X-Gm-Message-State: AOJu0Yw6IncXisjuoHMYOV+biNyqJk4JbPUlk6GM5vLWxJjjGSw3vsoV
        ktx4xuYt6kNpa+Hco8Dl09Rjyq59pKv9y2vB6vd73g==
X-Google-Smtp-Source: AGHT+IH/hc6gN1xTLSGGfJPyXJHHQub6ol1hzXoe2NEM2Na7aG7mU0a3/C+JV7UXynN3hn4iOEeQUeqbH8Ay4Soc5Ho=
X-Received: by 2002:a1f:c703:0:b0:48d:348:4e0b with SMTP id
 x3-20020a1fc703000000b0048d03484e0bmr6786184vkf.4.1693894850958; Mon, 04 Sep
 2023 23:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230830112600.4483-1-hdanton@sina.com> <f607a7d5-8075-f321-e3c0-963993433b14@I-love.SAKURA.ne.jp>
 <20230831114108.4744-1-hdanton@sina.com> <CANn89iLCCGsP7SFn9HKpvnKu96Td4KD08xf7aGtiYgZnkjaL=w@mail.gmail.com>
In-Reply-To: <CANn89iLCCGsP7SFn9HKpvnKu96Td4KD08xf7aGtiYgZnkjaL=w@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Sep 2023 11:50:39 +0530
Message-ID: <CA+G9fYs26E2vVGKdyMMpjSTkdFXitgRnw+puSc7XSDXpY1sivQ@mail.gmail.com>
Subject: Re: selftests: net: pmtu.sh: Unable to handle kernel paging request
 at virtual address
To:     Eric Dumazet <edumazet@google.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Netdev <netdev@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 18:42, Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Aug 31, 2023 at 2:17=E2=80=AFPM Hillf Danton <hdanton@sina.com> w=
rote:
> >
> > On Wed, 30 Aug 2023 21:44:57 +0900 Tetsuo Handa <penguin-kernel@I-love.=
SAKURA.ne.jp>
> > >On 2023/08/30 20:26, Hillf Danton wrote:
> > >>> <4>[  399.014716] Call trace:
> > >>> <4>[  399.015702]  percpu_counter_add_batch+0x28/0xd0
> > >>> <4>[  399.016399]  dst_destroy+0x44/0x1e4
> > >>> <4>[  399.016681]  dst_destroy_rcu+0x14/0x20
> > >>> <4>[  399.017009]  rcu_core+0x2d0/0x5e0
> > >>> <4>[  399.017311]  rcu_core_si+0x10/0x1c
> > >>> <4>[  399.017609]  __do_softirq+0xd4/0x23c
> > >>> <4>[  399.017991]  ____do_softirq+0x10/0x1c
> > >>> <4>[  399.018320]  call_on_irq_stack+0x24/0x4c
> > >>> <4>[  399.018723]  do_softirq_own_stack+0x1c/0x28
> > >>> <4>[  399.022639]  __irq_exit_rcu+0x6c/0xcc
> > >>> <4>[  399.023434]  irq_exit_rcu+0x10/0x1c
> > >>> <4>[  399.023962]  el1_interrupt+0x8c/0xc0
> > >>> <4>[  399.024810]  el1h_64_irq_handler+0x18/0x24
> > >>> <4>[  399.025324]  el1h_64_irq+0x64/0x68
> > >>> <4>[  399.025612]  _raw_spin_lock_bh+0x0/0x6c
> > >>> <4>[  399.026102]  cleanup_net+0x280/0x45c
> > >>> <4>[  399.026403]  process_one_work+0x1d4/0x310
> > >>> <4>[  399.027140]  worker_thread+0x248/0x470
> > >>> <4>[  399.027621]  kthread+0xfc/0x184
> > >>> <4>[  399.028068]  ret_from_fork+0x10/0x20
> > >>
> > >> static void cleanup_net(struct work_struct *work)
> > >> {
> > >>      ...
> > >>
> > >>      synchronize_rcu();
> > >>
> > >>      /* Run all of the network namespace exit methods */
> > >>      list_for_each_entry_reverse(ops, &pernet_list, list)
> > >>              ops_exit_list(ops, &net_exit_list);
> > >>      ...
> > >>
> > >> Why did the RCU sync above fail to work in this report, Eric?
> > >
> > > Why do you assume that synchronize_rcu() failed to work?
> >
> > In the ipv6 pernet_operations [1] for instance, dst_entries_destroy() i=
s
> > invoked after RCU sync to ensure that nobody is using the exiting net,
> > but this report shows that protection falls apart.
>
> Because synchronize_rcu() is not the same than rcu_barrier()
>
> The dst_entries_add()/ percpu_counter_add_batch() call should not
> happen after an rcu grace period.
>
> Something like this (untested) patch
>
> diff --git a/net/core/dst.c b/net/core/dst.c
> index 980e2fd2f013b3e50cc47ed0666ee5f24f50444b..f02fdd1da6066a4d56c2a0aa8=
038eca76d62f8bd
> 100644
> --- a/net/core/dst.c
> +++ b/net/core/dst.c
> @@ -163,8 +163,13 @@ EXPORT_SYMBOL(dst_dev_put);
>
>  void dst_release(struct dst_entry *dst)
>  {
> -       if (dst && rcuref_put(&dst->__rcuref))
> +       if (dst && rcuref_put(&dst->__rcuref)) {
> +               if (!(dst->flags & DST_NOCOUNT)) {
> +                       dst->flags |=3D DST_NOCOUNT;
> +                       dst_entries_add(dst->ops, -1);
> +               }
>                 call_rcu_hurry(&dst->rcu_head, dst_destroy_rcu);
> +       }
>  }
>  EXPORT_SYMBOL(dst_release);
>

The above patch applied on top of Linux next and tested
selftests : net: pmtu.sh and test did not crash.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

> It is not even clear why we are still counting dst these days.
> We removed the ipv4 route cache a long time ago, and ipv6 got a
> similar treatment.

Links,
https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/naresh/tests/2Uw58x3x=
JIqqpYDZspTytGe3L1V
https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/naresh/tests/2Uw58x3x=
JIqqpYDZspTytGe3L1V/logs?format=3Dhtml


--
Linaro LKFT
https://lkft.linaro.org
