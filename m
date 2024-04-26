Return-Path: <linux-kernel+bounces-159432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE44F8B2E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CBD1C2230A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276B41879;
	Fri, 26 Apr 2024 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLSLEG++"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222EC1849
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714097393; cv=none; b=k13Fm5DcJ9pyy0UzEg9sjBeTODku26QILYJmGGfJ3fzshf6J9s921rjU262XO9MIVDW2c1qMe1XI2giZlGEvc61lRZeu2cK3CiUicixH4rSzReJ6bXrFuE0lKW/ksYMpfSL+6IVNRCfXeUx+dIhKScFZotG9VCleIaESFMb9v0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714097393; c=relaxed/simple;
	bh=CJQPDJjLXFcAcTD6jR0pZXL7qJ7UBG26LY2nhUlRLz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6LO0yFznV3WMpDSLJyc9Wud9F6zwTSIV7vRA4poak2Q89/o3IZgfbQTuRBlOCkeMwJcUcpYds0dESjZ5IrQFO0bWPdlWAiKC+yhDUCbqXm6sL15unQjY4dxDMv08kcXvnevAnt3oEVFGrx9ZDPvgv54mikauiIUDxTlINeyMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLSLEG++; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso1389442a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714097391; x=1714702191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CMCsFUqUgYms1WmtM5Vc8C2+q3f5Kprb1BLjL9ZLzIY=;
        b=YLSLEG++Xzi4AhcACEWm646LSWbaJmq0uZaUHwwUc5A2Mlqo5Kjqmv91kfHpyacZ9V
         tAZ201vJXESMkg7g0IrXEfL2HybOjngmhrmqCLAgC8ycVZCU2DV3Iir/RNNwE5h5C2fN
         3FiP1SAlqatULSGe6T+wuKl40tDXKaeHyGW7PUSdc2q5wo9khYz17FCdQgHunaFXXKHE
         S9r/0nFV2U9/MJauasc/mMrQrQIEGqQpYXIYvga+HT+divm9kvaxNHC1z1QXwui3pQNQ
         mo+R3/Xko8cky1YHgyM8OJVFrtoHU2Qf47Lmrl8izgN0X73b7VemXzln/nj6uc3yq9/2
         X6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714097391; x=1714702191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMCsFUqUgYms1WmtM5Vc8C2+q3f5Kprb1BLjL9ZLzIY=;
        b=uxvEH05zJEME/CfGYZJ0rjG3R+bwJj1QtSv7ETAxW1Ib/gMxfHuVGAIwaxYksYwVrw
         stjABoeIDqPCz84d7+MrDTabA7y/BxLNR8EcHOqAOn4ZnQqtghg9ApRgVEcp5/vZH67k
         fo2+geuyGuloKD/JGnMxnMAur7Ax6uM3gaaobaEktoUZmk4cKtTCWtt4hNhbGm/2QRlB
         AUu4BEvmbDPqzLmkuKBB2OdGzhd8P9zfePNSpd0br7Xt9nJHhNw69J7a3Yt6rPKvvhde
         Mo2wZFq4DRcOLTBqJ6zE1nd4sLxVDOzdrXSKFHw0l7AI41robBA5vF9xwI4HHZHr+y15
         KicA==
X-Forwarded-Encrypted: i=1; AJvYcCW+TYaEcSuHTH6LUgjrMi7VeO4DnUm2nWQY3KDWnllsQp5SYDbOs42y5Crq8FsSofA4m/MODkcXuuQbC1oA2UBQWtzHq6K6pjhC+K6u
X-Gm-Message-State: AOJu0YztVq1Wrih8cqcnIBKPQf0LPwsVi/4d7ZSyP3Dow+vzzhit3qFu
	Cxn8jbM+OwzpINmUIhrhqgsic+yQQW22n5pQlgCxtKdXQSUWIaVdlAaGEAstSg/lAHxB+ZsVVrv
	cjy81rBUdTX+nemtqsCWCIwMjpDQ=
X-Google-Smtp-Source: AGHT+IEiS03GHrczLzjNXejqvyErK4iNBbnGfzDmHQ0aiHrroIIWF8n7qFwjYK5rD+WY3wuF+MN8R2Uj3zddoJMIr5k=
X-Received: by 2002:a05:6a21:3d94:b0:1a7:5fbf:3774 with SMTP id
 bj20-20020a056a213d9400b001a75fbf3774mr1928166pzc.55.1714097391310; Thu, 25
 Apr 2024 19:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALm+0cWx1kYtftE4nj7Jjgx2_bmNmSrBAgd36ksSvxJtNVhxHg@mail.gmail.com>
 <CALm+0cWRC1kqLJvmEqda4O97PZ-n0R0UQ35=fi6oA3rLsPoUSQ@mail.gmail.com>
 <8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop> <CALm+0cWN0+cCsYddBUefya3aUw9c9Xn89GVV=Ys1_UPjS19WrQ@mail.gmail.com>
 <4c09abb6-4f6e-42d7-9944-c5da995649cb@paulmck-laptop> <CALm+0cVaLfE2ieK9aqh9yHkPDyO7zWbMe9K6WjTUgm4t9SnSFQ@mail.gmail.com>
 <ac7bf2c3-c752-46db-a5c8-0c55a1af8561@paulmck-laptop> <CALm+0cXGBPWxiNOkAoQG4hdnKCeVVR-APbfBPk9OGeU2RW+bKA@mail.gmail.com>
 <87o7a1umj3.ffs@tglx> <CALm+0cUesD9KaWyfsRUyGdErbrU11sAfRgRR=Qjyz7Boq9Vt=g@mail.gmail.com>
 <b735d174-8ad9-4ace-86ee-75dc09852537@paulmck-laptop>
In-Reply-To: <b735d174-8ad9-4ace-86ee-75dc09852537@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Fri, 26 Apr 2024 10:09:39 +0800
Message-ID: <CALm+0cVvM56xse8ejf7+Wro+XBkFwY-MO1jyhWcVU8BWaZ2qjg@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] WARNING: suspicious RCU usage in __do_softirq
To: paulmck@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	syzbot <syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Apr 23, 2024 at 10:20:49AM +0800, Z qiang wrote:
> > >
> > > On Fri, Apr 19 2024 at 13:50, Z qiang wrote:
> > > >> On Thu, Apr 18, 2024 at 05:49:38PM +0800, Z qiang wrote:
> > > >  static __init int spawn_ksoftirqd(void)
> > > >  {
> > > > +       int cpu;
> > > > +
> > > > +       for_each_possible_cpu(cpu)
> > > > +               per_cpu(ksoftirqd_work, cpu) = false;
> > >
> > > First of all that initialization is pointless, but why making all of
> > > this complex as hell?
> > >
> > > Thanks,
> > >
> > >         tglx
> > > ---
> > > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > > index b315b21fb28c..e991d735be0d 100644
> > > --- a/kernel/softirq.c
> > > +++ b/kernel/softirq.c
> > > @@ -508,7 +508,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
> > >  static inline void lockdep_softirq_end(bool in_hardirq) { }
> > >  #endif
> > >
> > > -asmlinkage __visible void __softirq_entry __do_softirq(void)
> > > +static void handle_softirqs(bool kirqd)
> > >  {
> > >         unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
> > >         unsigned long old_flags = current->flags;
> > > @@ -563,8 +563,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
> > >                 pending >>= softirq_bit;
> > >         }
> > >
> > > -       if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > > -           __this_cpu_read(ksoftirqd) == current)
> > > +       if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kirqd)
> > >                 rcu_softirq_qs();
> > >
> > >         local_irq_disable();
> > > @@ -584,6 +583,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
> > >         current_restore_flags(old_flags, PF_MEMALLOC);
> > >  }
> > >
> > > +asmlinkage __visible void __softirq_entry __do_softirq(void)
> > > +{
> > > +       handle_softirqs(false);
> > > +}
> > > +
> > >  /**
> > >   * irq_enter_rcu - Enter an interrupt context with RCU watching
> > >   */
> > > @@ -921,7 +925,7 @@ static void run_ksoftirqd(unsigned int cpu)
> > >                  * We can safely run softirq on inline stack, as we are not deep
> > >                  * in the task stack here.
> > >                  */
> > > -               __do_softirq();
> > > +               handle_softirqs(true);
> >
> > Thanks, this is good for me :),
> > Paul, what do you think?
>
> This looks quite nice to me, especially given that it avoids changing
> all the other calls to __do_softirq().  Some architectures might want
> to directly call handle_softirqs(), but if so, they can send the patches.


Hello, Thomas
Can you send an official patch? or I will send and add you to
Co-developed-by tags.

Thanks
Zqiang


>
>                                                         Thanx, Paul
>
> > Thanks
> > Zqiang
> >
> > >                 ksoftirqd_run_end();
> > >                 cond_resched();
> > >                 return;

