Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8018D791640
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352805AbjIDLaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbjIDLaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:30:12 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61751184
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 04:30:09 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-414ba610766so235811cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693827008; x=1694431808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XUCQKB6pi7IttK1owfeaOm6Ex0tigVABg1Q1Hm9uvA=;
        b=lGz6L2PbvGWyakjSPH+DEfsj9ze8bHHNBDP1BjVBJ4I7kgAfRe1t9Klh11fGQc89SV
         3dvNLEdVsFYPcBtDNzQZ1gZ1eBZYpFlXpzmz5eDbFkrvtnRJTKCqcQIAHHdmBvKVnRzI
         bQT9YQT5Pp2OHsRD+AHsQ639qgRckEEVEe2w8lfYdd6f7DDhXp5KTqm/S/zmXnvI/SFb
         K2xAX3MHRt4+xtYrOykjo8brnB4UUV9fXUiJpjFA0GLz6r3POE/taFcSsVLQupGj3wGq
         4p2Qpr7fyT7TwT4dhbK6aapyTfBWW/bYRyZKmI2KmlbJ6QJ6qt+r5LZ7VZDdmbPl+Tje
         8BfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693827008; x=1694431808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XUCQKB6pi7IttK1owfeaOm6Ex0tigVABg1Q1Hm9uvA=;
        b=RWTO2ocHAG/c2vKfUusle0FIrRegKAyCob7RDxF+jeFsoAQ8HCAFGu8/VTgiBpOH+W
         oJnClevs2kHggKJ73T39ojRyrVzOkcfluwiSw0AGk5snYcSFM7wyV0HulN4nM4nHkrkV
         W3darJ/8JQgoQZEjQrddwpWI51FtkRAUCQKn/g2ftOUoh1yJraRwgHdn9SEGhwT8uFGr
         ldVMLLYgWyHi3wnA1kxPWInuO6Qd5oIHlISEJPTNlp81uaiMrfMILftHKIzmdN8MppIs
         4eIdWD+Ktx4sM6bgIJ7qWv4NJlx8R+Rxu6dtMJ+0vqVPEiyPbxqPILqa3YeYIcqZnpya
         BgXA==
X-Gm-Message-State: AOJu0YzdCoBx/b2H7WiY/MtBLopdzhHDywthSD68TQDmTHWYCpQRINAg
        Alg8Rv4oTkKzsypuKyUkKvv0CFN2z0jMyLl2ZZVIAw==
X-Google-Smtp-Source: AGHT+IF1g9qeeFA7ZtjyeIQy1qMImu6yBb601ONsY8ITLtWyQK0e88+XdZN7JI7wIgLndeZOAnfHFzlNH5A54eez2aY=
X-Received: by 2002:ac8:5c82:0:b0:40f:dc70:fde2 with SMTP id
 r2-20020ac85c82000000b0040fdc70fde2mr375758qta.26.1693827008368; Mon, 04 Sep
 2023 04:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230830112600.4483-1-hdanton@sina.com> <f607a7d5-8075-f321-e3c0-963993433b14@I-love.SAKURA.ne.jp>
 <20230831114108.4744-1-hdanton@sina.com> <CANn89iLCCGsP7SFn9HKpvnKu96Td4KD08xf7aGtiYgZnkjaL=w@mail.gmail.com>
 <20230903005334.5356-1-hdanton@sina.com>
In-Reply-To: <20230903005334.5356-1-hdanton@sina.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 4 Sep 2023 13:29:57 +0200
Message-ID: <CANn89iJj_VR0L7g3-0=aZpKbXfVo7=BG0tsb8rhiTBc4zi_EtQ@mail.gmail.com>
Subject: Re: selftests: net: pmtu.sh: Unable to handle kernel paging request
 at virtual address
To:     Hillf Danton <hdanton@sina.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Netdev <netdev@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 3, 2023 at 5:57=E2=80=AFAM Hillf Danton <hdanton@sina.com> wrot=
e:
>
> On Thu, 31 Aug 2023 15:12:30 +0200 Eric Dumazet <edumazet@google.com>
> > On Thu, Aug 31, 2023 at 2:17=3DE2=3D80=3DAFPM Hillf Danton <hdanton@sin=
a.com>
> > > On Wed, 30 Aug 2023 21:44:57 +0900 Tetsuo Handa <penguin-kernel@I-lov=
e.SAKURA.ne.jp>
> > > >On 2023/08/30 20:26, Hillf Danton wrote:
> > > >>> <4>[  399.014716] Call trace:
> > > >>> <4>[  399.015702]  percpu_counter_add_batch+0x28/0xd0
> > > >>> <4>[  399.016399]  dst_destroy+0x44/0x1e4
> > > >>> <4>[  399.016681]  dst_destroy_rcu+0x14/0x20
> > > >>> <4>[  399.017009]  rcu_core+0x2d0/0x5e0
> > > >>> <4>[  399.017311]  rcu_core_si+0x10/0x1c
> > > >>> <4>[  399.017609]  __do_softirq+0xd4/0x23c
> > > >>> <4>[  399.017991]  ____do_softirq+0x10/0x1c
> > > >>> <4>[  399.018320]  call_on_irq_stack+0x24/0x4c
> > > >>> <4>[  399.018723]  do_softirq_own_stack+0x1c/0x28
> > > >>> <4>[  399.022639]  __irq_exit_rcu+0x6c/0xcc
> > > >>> <4>[  399.023434]  irq_exit_rcu+0x10/0x1c
> > > >>> <4>[  399.023962]  el1_interrupt+0x8c/0xc0
> > > >>> <4>[  399.024810]  el1h_64_irq_handler+0x18/0x24
> > > >>> <4>[  399.025324]  el1h_64_irq+0x64/0x68
> > > >>> <4>[  399.025612]  _raw_spin_lock_bh+0x0/0x6c
> > > >>> <4>[  399.026102]  cleanup_net+0x280/0x45c
> > > >>> <4>[  399.026403]  process_one_work+0x1d4/0x310
> > > >>> <4>[  399.027140]  worker_thread+0x248/0x470
> > > >>> <4>[  399.027621]  kthread+0xfc/0x184
> > > >>> <4>[  399.028068]  ret_from_fork+0x10/0x20
> > > >>
> > > >> static void cleanup_net(struct work_struct *work)
> > > >> {
> > > >>      ...
> > > >>
> > > >>      synchronize_rcu();
> > > >>
> > > >>      /* Run all of the network namespace exit methods */
> > > >>      list_for_each_entry_reverse(ops, &pernet_list, list)
> > > >>              ops_exit_list(ops, &net_exit_list);
> > > >>      ...
> > > >>
> > > >> Why did the RCU sync above fail to work in this report, Eric?
> > > >
> > > > Why do you assume that synchronize_rcu() failed to work?
> > >
> > > In the ipv6 pernet_operations [1] for instance, dst_entries_destroy()=
 is
> > > invoked after RCU sync to ensure that nobody is using the exiting net=
,
> > > but this report shows that protection falls apart.
> >
> > Because synchronize_rcu() is not the same than rcu_barrier()
> >
> > The dst_entries_add()/ percpu_counter_add_batch() call should not
> > happen after an rcu grace period.
>
>         cpu2                    cpu3
>         =3D=3D=3D=3D                    =3D=3D=3D=3D
>         cleanup_net()           rcu_read_lock();
>                                 it is safe to use either netns or dst
>                                 rcu_read_unlock();
>         synchronize_rcu();
>                                 unsafe to access anyone now
> >
> > Something like this (untested) patch
> >
> > diff --git a/net/core/dst.c b/net/core/dst.c
> > index 980e2fd2f013b3e50cc47ed0666ee5f24f50444b..f02fdd1da6066a4d56c2a0a=
a8038eca76d62f8bd
> > 100644
> > --- a/net/core/dst.c
> > +++ b/net/core/dst.c
> > @@ -163,8 +163,13 @@ EXPORT_SYMBOL(dst_dev_put);
> >
> >  void dst_release(struct dst_entry *dst)
> >  {
> > -       if (dst && rcuref_put(&dst->__rcuref))
> > +       if (dst && rcuref_put(&dst->__rcuref)) {
> > +               if (!(dst->flags & DST_NOCOUNT)) {
> > +                       dst->flags |=3D3D DST_NOCOUNT;
> > +                       dst_entries_add(dst->ops, -1);
>
> Could this add happen after the rcu sync above?
>

I do not think so. All dst_release() should happen before netns removal.
