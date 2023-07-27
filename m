Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A26076435F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 03:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjG0BWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 21:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjG0BWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:22:02 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D539C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 18:21:59 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-56c4c4e822eso77171eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 18:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690420919; x=1691025719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGQku+vNde65N4HYDOaGInWh0D/YJzm9XbuNXSooZ/s=;
        b=R2nt10LK7J1qOEO7oVIy96CP262oG7oUIhbQweLlb//g9fWic2glJvc0i8KKnZd0WM
         OO0OKGBftLQ4H6hRRkX2t1cg+bdJFcEm62MrPKWI2JkvFRow/gsqWHyA7r/KhxxMm10s
         xj0vAMvxR4JQsQ2EBX6slyUSQ2yTR0vgqynCtlEy4BBRXI8eMIRocU/GIjDth0ZoFqqB
         ZF2bzJ5/0L1aS9u5FSUFWzhAEweMpV5DJoZmXu2pOBlZ2rgiDwtaAcYfgGaYiL0fBECI
         4UeW9YZrqYmUxAnn/ap04ksmH03un93u/b1pwFC93yBvDLdWYyK00OmpafGzGMcznmWH
         EZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690420919; x=1691025719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGQku+vNde65N4HYDOaGInWh0D/YJzm9XbuNXSooZ/s=;
        b=OcIYQaG4WKYj5PJ0Sz55Bx9wOaPxKnqv4mKcozR1URkYWGpZsUG86hxyQyMMXq9lTH
         j6zpQOZNPRD9iex+9ukdhNhBH9kENls5XQ2dFgoLkJlPPJkAaylFxo1cQ8qpy00VRRRv
         KQeOUg7KMW17Ei7a6KgAqJCYFm4Pkt2qg227eTm1zzR5hF1Wja/f+i5rIZkqJHVNRraY
         H8DiY/mJZE/1QkEr2tdn3hNzIlbkxO8mZQEaD8+D6FF9E9oEk+OB+wZyb/9zJDeEWZEG
         HnZD8LPClsEHL7TkYmx1yi+mgeE4WfHbp6STxu95zd0dhqOdgZXWOgDzO1lO+/WxREKX
         HE+A==
X-Gm-Message-State: ABy/qLagVteJU6YShjQOx7/Ct4W5riHfRxRYyCWRPhmCqD7sBD+QLnwc
        eSuPip0ei+vnL19sco55jhAnlEYSdOoedptQ8Vc=
X-Google-Smtp-Source: APBJJlHeYqw4B6s1mIAgvPdZsLtFNoXzVUwxcGaPW3llHa/YUb3boGTRXngakwSZ4YhKeQ3g5Q6yGeYUp3Z3zdjyB4Q=
X-Received: by 2002:a4a:2444:0:b0:566:f1f6:9de7 with SMTP id
 v4-20020a4a2444000000b00566f1f69de7mr2010826oov.9.1690420919005; Wed, 26 Jul
 2023 18:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230713071713.5762-1-xuewen.yan@unisoc.com> <20230725-hemmschwelle-braten-481527898001@brauner>
 <CAB8ipk9CXWmUg13gEHDECXf3DDUvbYyA0y2yFXUuGsAjMSXv8w@mail.gmail.com>
 <20230725-gespeichert-auffuhr-00ed9e57ec7f@brauner> <CAB8ipk_AhvZxoa410F8s=SfLsqCNp+rRi6YgFzdLO7wh+N4KMA@mail.gmail.com>
 <20230726-tierisch-soweit-7bcefe6957dc@brauner>
In-Reply-To: <20230726-tierisch-soweit-7bcefe6957dc@brauner>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Thu, 27 Jul 2023 09:21:48 +0800
Message-ID: <CAB8ipk93n-0x7bs4nrQUrsswt81f4e6dHAFpEchc4G3mPKQSjQ@mail.gmail.com>
Subject: Re: [PATCH] pid: Add the judgment of whether ns is NULL in the find_pid_ns
To:     Christian Brauner <brauner@kernel.org>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, jack@suse.cz,
        keescook@chromium.org, peterz@infradead.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 5:25=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Jul 26, 2023 at 09:23:13AM +0800, Xuewen Yan wrote:
> > On Tue, Jul 25, 2023 at 8:47=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Tue, Jul 25, 2023 at 08:24:18PM +0800, Xuewen Yan wrote:
> > > > On Tue, Jul 25, 2023 at 4:49=E2=80=AFPM Christian Brauner <brauner@=
kernel.org> wrote:
> > > > >
> > > > > On Thu, Jul 13, 2023 at 03:17:13PM +0800, Xuewen Yan wrote:
> > > > > > There is no the judgment of whether namspace is NULL in find_pi=
d_ns.
> > > > > > But there is a corner case when ns is null, for example: if use=
r
> > > > > > call find_get_pid when current is in exiting, the following sta=
ck would
> > > > > > set thread_id be null:
> > > > > > release_task
> > > > > >     __exit_signal(p);
> > > > > >         __unhash_process(tsk, group_dead);
> > > > > >               detach_pid(p, PIDTYPE_PID);
> > > > > >                   __change_pid(task, type, NULL);
> > > > > >
> > > > > > If user call find_get_pid at now, in find_vpid function, the
> > > > >
> > > > > I fail to see how this can happen. The code you're referencing is=
 in
> > > > > release_task(). If current has gone through that then current obv=
iously
> > > > > can't call find_vpid() on itself anymore or anything else for tha=
t
> > > > > matter.
> > > >
> > > > This happened when user calls  find_vpid() in irq.
> > > >
> > > > [72117.635162] Call trace:
> > > > [72117.635595]  idr_find+0xc/0x24
> > > > [72117.636103]  find_get_pid+0x40/0x68
> > > > [72117.636812]  send_event+0x88/0x180 [demux]
> > > > [72117.637593]  vbvop_copy_data+0x150/0x344 [demux]
> > > > [72117.638434]  dmisr_video_parsing_mpeg12+0x29c/0x42c [demux]
> > > > [72117.639393]  dmisr_video_parsing_switch+0x68/0xec [demux]
> > > > [72117.640332]  dmisr_handle_video_pes+0x10c/0x26c [demux]
> > > > [72117.641108]  tasklet_action_common+0x130/0x224
> > > > [72117.641784]  tasklet_action+0x28/0x34
> > > > [72117.642366]  __do_softirq+0x128/0x4dc
> > > > [72117.642944]  irq_exit+0xf8/0xfc
> > > > [72117.643459]  __handle_domain_irq+0xb0/0x108
> > > > [72117.644102]  gic_handle_irq+0x6c/0x124
> > > > [72117.644691]  el1_irq+0x108/0x200
> > > > [72117.645217]  _raw_write_unlock_irq+0x2c/0x5c
> > > > [72117.645870]  release_task+0x144/0x1ac   <<<<<<
> > > > [72117.646447]  do_exit+0x524/0x94c
> > > > [72117.646970]  __do_sys_exit_group+0x0/0x14
> > > > [72117.647591]  do_group_exit+0x0/0xa0
> > > > [72117.648146]  __se_sys_exit+0x0/0x20
> > > > [72117.648704]  el0_svc_common+0xcc/0x1bc
> > > > [72117.649292]  el0_svc_handler+0x2c/0x3c
> > > > [72117.649881]  el0_svc+0x8/0xc
> > > >
> > > > In release_task, write_unlock_irq(&tasklist_lock) will open irq, at
> > > > this time, if user calls find_get_pid() in irq, because
> > > > current->thread_id is NULL,
> > > > it will handle the NULL pointer.
> > >
> > > Uhm, where is that code from? This doesn't seem to be upstream.
> >
> > It's from our own platform, we found someone called  find_get_pid() in
> > the module, and caused the crash.
>
> So this is a bug report for an out of tree driver which I'm sure you're
> aware we consider mostly irrelevant unless this is an upstream issue.
>
> Please work around or better fix this in your out of tree driver or
> please show a reproducer how this can happen on upstream kernels.
>
> Otherwise I don't see why we'd care.

Okay, Thanks a lot!

BR
