Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DF67D825B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjJZMPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJZMPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:15:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25095B9;
        Thu, 26 Oct 2023 05:15:45 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c87a85332bso6860255ad.2;
        Thu, 26 Oct 2023 05:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698322544; x=1698927344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXTt+TBzmX3Sm+AergVCPro5no45uF28IOJmLAgrl2Y=;
        b=QyYyI/aq7To7Dl6mE92Oiyu21ljttE6cvzMRDChnrOgtap+F2rn75H9ICu86BV+aAr
         +dHsyYmwnoBRS+Oje6p5iOPJn19hPpFkYQBg80yIzdzuseGCt/6zC/iwWaeayxTYKat2
         O8d9PCJLhmx6t6Ty87Bj5kMJRWXzw4dz7Ltb9sPD+IvmOVr0+EbNa4O0egZvFXt2FeLS
         Pq1dgpLa2wpcTi0nMzCilvmEZRKeNGgGGDwNPwSYTqlzsyxQIcX/t/PsE2/hhj1fFyiq
         A6kAQne1OUp1eR2IG2AoCYNJklw3FK2GQ3hvm2vM/E531cQMqwrpPGk3EtPmL4RYHXHb
         tLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698322544; x=1698927344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXTt+TBzmX3Sm+AergVCPro5no45uF28IOJmLAgrl2Y=;
        b=XDvlAplOKQlFDuXgiDp5KnK+vUlBd1iLVUUarN9tUs9IUXoPQAJC7UjUulknqVi7Bn
         xc2L+Ji8kubND5x9VCl2j5azmDnF84KMPLpzEmfelHsSjJq1riBTFKCceyVtRm25LG0y
         QXXZM+vP4zCTeVpdNl72yZATblneb1jaQT48cfdkzMqZVCLr5A7HpHWAL1JAuwwWWytR
         JM3Jfx0PKb+sKBSVxtLgbwu0KCJH/F4fouetNGnCLTJp6kGc4H2wHCGuUjtgS0n6SX3m
         SxCRbbEz1ItzFiLO3XOtdDP71b16FYystsiPR7ly1DlwewTTuKlbHMGWgrIqRK1/d0q2
         7v+Q==
X-Gm-Message-State: AOJu0YwJYHDLKFWgYSEHS5A8t1+nakPfSXI4Zpk5ESU7hh+p8dDfVHkZ
        nZd2pFKPBZfl5qJAR8Yom1TlURREfLaUizHtQE4=
X-Google-Smtp-Source: AGHT+IF0d7sGTx1Y47dcctpEAb9wgAeZVvefSK5hdD1HkQl50sgfjLT0V4k8kvMvJUAlja7yWblux+TIFGMs/She1oI=
X-Received: by 2002:a17:90b:4b47:b0:27d:298e:ec4f with SMTP id
 mi7-20020a17090b4b4700b0027d298eec4fmr17343076pjb.4.1698322544571; Thu, 26
 Oct 2023 05:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231024214625.6483-1-frederic@kernel.org> <20231024214625.6483-3-frederic@kernel.org>
 <20231025084008.GD37471@noisy.programming.kicks-ass.net> <ZTjudk5mV8PVYsS-@localhost.localdomain>
In-Reply-To: <ZTjudk5mV8PVYsS-@localhost.localdomain>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Thu, 26 Oct 2023 20:15:33 +0800
Message-ID: <CALm+0cW0ZEX_G9WcJx-i3b5SCLECWfeKG+ikdXfXzNsM-XSM8w@mail.gmail.com>
Subject: Re: [PATCH 2/4] rcu/tasks: Handle new PF_IDLE semantics
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Le Wed, Oct 25, 2023 at 10:40:08AM +0200, Peter Zijlstra a =C3=A9crit :
> > On Tue, Oct 24, 2023 at 11:46:23PM +0200, Frederic Weisbecker wrote:
> >
> > > +/* Check for quiescent states since the pregp's synchronize_rcu() */
> > > +static bool rcu_tasks_is_holdout(struct task_struct *t)
> > > +{
> > > +   int cpu;
> > > +
> > > +   /* Has the task been seen voluntarily sleeping? */
> > > +   if (!READ_ONCE(t->on_rq))
> > > +           return false;
> > > +
> > > +   cpu =3D task_cpu(t);
> > > +
> > > +   /*
> > > +    * Idle tasks within the idle loop or offline CPUs are RCU-tasks
> > > +    * quiescent states. But CPU boot code performed by the idle task
> > > +    * isn't a quiescent state.
> > > +    */
> > > +   if (t =3D=3D idle_task(cpu)) {
> > > +           if (is_idle_task(t))
> > > +                   return false;
> > > +
> > > +           if (!rcu_cpu_online(cpu))
> > > +                   return false;
> > > +   }
> >
> > Hmm, why is this guarded by t =3D=3D idle_task() ?
> >
> > Notably, there is the idle-injection thing that uses FIFO tasks to run
> > 'idle', see play_idle_precise(). This will (temporarily) get PF_IDLE on
> > tasks that are not idle_task().
>
> Ah good point. So indeed the is_idle_task() test doesn't musn't be
> guarded by t =3D=3D idle_task(cpu). But rcu_cpu_online() has to, otherwis=
e
> if it's not an idle task, there is a risk that the task gets migrated out
> by the time we observe the old CPU offline.
>

If a fifo-tasks use play_idle_precise() to run idle and invoke
do_idle(), may cause
rcu-tasks to falsely report a rcu-tasks QS , when rcu_is_cpu_rrupt_from_idl=
e()
return true in rcu_sched_clock_irq(), so should we also add a check for
"current =3D=3D idle_task(task_cpu(current))" in the rcu_is_cpu_rrupt_from_=
idle() ?

Thanks
Zqiang


> Thanks.
>
> >
> > > +
> > > +   return true;
> > > +}
> > > +
> > >  /* Per-task initial processing. */
> > >  static void rcu_tasks_pertask(struct task_struct *t, struct list_hea=
d *hop)
> > >  {
> > > -   if (t !=3D current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
> > > +   if (t !=3D current && rcu_tasks_is_holdout(t)) {
> >
> >
