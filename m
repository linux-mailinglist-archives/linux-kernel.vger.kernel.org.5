Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CE475EAD0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjGXF2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGXF2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:28:50 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E259E46;
        Sun, 23 Jul 2023 22:28:48 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3ff24a193dbso28876141cf.3;
        Sun, 23 Jul 2023 22:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690176527; x=1690781327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIVichlo2tjhXjSPPSS2sZB3SIismoqhgH3V/jU2V8g=;
        b=qtr6NmlZ4epRdBNhQSZGVZCfMQKUL85ZWxtrF+im/ZQSAYchlLenAKUGRQ8JMhYXea
         R5rimxpdlNqU/RfLX54uaa41Qj6GzGY0dvhhIJHDuLvjYq4wrXYjQK1frzbK7QOpI59+
         DIMQZdQFck/9iKfSO/PVbiStlVVhn4HSZ0rLtECtKn63mQrggSOzb+n7Y8Gv/F68tEZd
         GiXLzaVJxsOBcqQnSSFCA2zGamjcrqLhCWgYVBRDs3XxEgQ2jTMZQf+g+ERO+LQGJhdg
         dtMDsGsiP+5hDemOyfpZyi9QsJJQzd0N38OphCmFDpwAPq9WpHeK15ZLdsEzsnPhnObo
         tsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690176527; x=1690781327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIVichlo2tjhXjSPPSS2sZB3SIismoqhgH3V/jU2V8g=;
        b=f2g2X9cbgkmTQhACS7eXduQjsLH+bSUk76TQm/PWu2+9Kl/djG3B5KL7Gav6T/t4a6
         9tElRQwPf3oHsFek/KBJ1NncrVX6L9nA/fh1CenEcsbqT06xDCsNgIkzXSPj2c+Eg95Q
         3B34g7jkYEXE5mO9PTHvUesOiqLp2Iq6onRU+rgQ69woD3OY6W8hTYTZ5FY/tLQTVPMU
         sAS5GVNnOAr8BmedGsc+OLkeiVoKq08yGhEioJ7l0mLnr3prcrFUg5C2va9/XlTuGdhs
         gqg7BRhgtlmjlDekuiB2Crm87nfqE74dDfhGnm2FlQa6B0XUNV9oRA5g9kec0e2nij8c
         8uPQ==
X-Gm-Message-State: ABy/qLa6kgqbe2qWGcyTL8vp1oSGeK85eOgvSLCl54LrO0lhKUSu6rSB
        Z/lO4Saum4thn8bmCQLL1CQqDGFglodS2f57f3o=
X-Google-Smtp-Source: APBJJlGg4frVLm2pAtiWixV84NFS4IGavAz0GyJntVi0mc+Mnia1ZaEaITgLkH97wCtY+vMlcw7Pe6PnMvsLJtaary8=
X-Received: by 2002:ac8:5c83:0:b0:403:a262:7751 with SMTP id
 r3-20020ac85c83000000b00403a2627751mr9598232qta.12.1690176527050; Sun, 23 Jul
 2023 22:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230721121534.44328-1-ppbuk5246@gmail.com> <05e98227-77f4-4918-8f8e-2170a158e350@paulmck-laptop>
 <CAM7-yPRc4Z0siaiWf+fK2GEfjPMq5UaY13F4o19rU6NNUS5fNg@mail.gmail.com>
 <faf07eef-0a51-49f3-be48-0433952171ad@paulmck-laptop> <CAM7-yPTrHN1xPXWjSUrJeTEOuy78DpmL8ytUY+a4ZOekiAbnZg@mail.gmail.com>
 <31070aab-8665-44c4-8950-0631a777ef44@paulmck-laptop> <CAM7-yPSn8ietAJ8NKb0-VHDQhkHs73u--KFmO3rpTPUvcFuMvA@mail.gmail.com>
 <CALm+0cWeZnMUk8Lj_nF3Htd14czGcT_Yt71nVwJdGhTECQOAWg@mail.gmail.com>
In-Reply-To: <CALm+0cWeZnMUk8Lj_nF3Htd14czGcT_Yt71nVwJdGhTECQOAWg@mail.gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Mon, 24 Jul 2023 06:28:35 +0100
Message-ID: <CAM7-yPR2jG=4MkBF1+=f8KUNqmSopq3yTTfWN6YvLcmJjpq8Hw@mail.gmail.com>
Subject: Re: [PATCH] rcu: remove unnecessary check cpu_no_qs.norm on rcu_report_qs_rdp
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, osh@joshtriplett.org, boqun.feng@gmail.com,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Z qiang!

Thanks for replying. But I'm pinned on something wrong..!

> For built with CONFIG_RCU_STRICT_GRACE_PERIOD=3Dy and CONFIG_PREEMPT=3Dn =
kernels
> Consider the following scenario:
>
> __rcu_read_unlock()
>    -> rcu_read_unlock_strict()
>         ->rdp =3D this_cpu_ptr(&rcu_data);
>         ->rdp->cpu_no_qs.b.norm =3D false;
>
>                  by interrupt and return invoke rcu_core():
>                  ->rcu_check_quiescent_state()
>                       ->rdp =3D raw_cpu_ptr(&rcu_data);
>                       -> rcu_check_quiescent_state(rdp);
>                             ->note_gp_changes(rdp);
>                                 -> __note_gp_changes(rnp, rdp)
>                                 start new gp
>                                 ->rdp->cpu_no_qs.b.norm =3D true;
>
>         ->rcu_report_qs_rdp(rdp);
>            ->if (rdp->cpu_no_qs.b.norm || ...)

I've already seen this scenario, But I think something is missing in my vie=
w.
What I couldn't catch is

                  ->rcu_check_quiescent_state()
                       ->rdp =3D raw_cpu_ptr(&rcu_data);
                       -> rcu_check_quiescent_state(rdp);
                             ->note_gp_changes(rdp);
                                 -> __note_gp_changes(rnp, rdp)
                                 start new gp

the new gp is started.

to set cpu_no_qs.b.norm as true, below condition should be true

1201 >---if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
  1202 >---    unlikely(READ_ONCE(rdp->gpwrap))) {

Here,
How rcu_seq_new_gp could return true and new gp already started via
rcu_gp_kthread.
IIUC, because rcu_gp_fqs_loop couldn't see the root rnp->qsmask is
zero, it couldn't call rcu_gp_init.

Sorry to make noise, but would you correct me what I'm thinking wrong?

Many thanks..!

-----------
Sincerely,
Levi.

On Mon, Jul 24, 2023 at 4:21=E2=80=AFAM Z qiang <qiang.zhang1211@gmail.com>=
 wrote:
>
> >
> > Thanks for replying to reply Paul :)
> >
> > > And try testing with CONFIG_RCU_STRICT_GRACE_PERIOD=3Dy and CONFIG_PR=
EEMPT=3Dn.
> > > Though there might be better Kconfig options to use.  Those two come
> > > immediately to mind.
> >
> > I've tested with this option via rcu torture.
> > and it doesn't report any problems.
> > and after commit 6d60ea03ac2d3 ("rcu: Report QS for outermost
> > PREEMPT=3Dn rcu_read_unlock() for strict GPs")
> > it always makes cpu_no_qs.b.norm false whenever it calls
> > rcu_report_qs_rdp in rcu_read_unlock.
> >
> > > But one critical piece is that softirq handlers, including the RCU_SO=
FTIRQ
> > > handler rcu_core_si(), can be invoked upon return from interrupts.
> >
> > I think in that case, no problem because if it reports qs already,
> > rcu_check_quiescent_state wouldn't call rcu_report_qs_rdp again.
> > And if RCU_SOFTIRQ is called as soon as RCU interrupt is finished,
> > it seems the fastest one to notify qs to related tree.
> >
> > > Another critical piece is that if a CPU is idle during any part of a
> > > grace period, the grace-period kthread can report a quiescent state o=
n
> > > its behalf.
> >
> > I think
> >     1) If timer interrupt is still programed,
> >           - when rcu_sched_clock_irq first reports qs, no problem
> >           - If qs is reported via grace period thread first,
> > note_gp_chagned in rcu interrupt
> >             will recognize this situation by setting core_needs_qs as f=
alse,
> >             it doesn't call rcu_report_qs_rdp thou cpu_no_qs.b.norm is =
true.
> >
> >      2) If the timer interrupt isn't programmed,
> >           - rcu_gp_kthreaad reports its qs, no problem.
> >
> > So, I think there's no problem removing
> >       "rdp->cpu_no_qs.b.norm" check in rcu_report_qs_rdp.
> > or wrap this condition check as WARN_ON_ONCE.
> >
> > > Does that help?
> > Many thanks always :)
> >
>
>
> Hi Levi
>
> For built with CONFIG_RCU_STRICT_GRACE_PERIOD=3Dy and CONFIG_PREEMPT=3Dn =
kernels
> Consider the following scenario:
>
> __rcu_read_unlock()
>    -> rcu_read_unlock_strict()
>         ->rdp =3D this_cpu_ptr(&rcu_data);
>         ->rdp->cpu_no_qs.b.norm =3D false;
>
>                  by interrupt and return invoke rcu_core():
>                  ->rcu_check_quiescent_state()
>                       ->rdp =3D raw_cpu_ptr(&rcu_data);
>                       -> rcu_check_quiescent_state(rdp);
>                             ->note_gp_changes(rdp);
>                                 -> __note_gp_changes(rnp, rdp)
>                                 start new gp
>                                 ->rdp->cpu_no_qs.b.norm =3D true;
>
>         ->rcu_report_qs_rdp(rdp);
>            ->if (rdp->cpu_no_qs.b.norm || ...)
>
>
> Thanks
> Zqiang
>
>
> >
> > --------
> > SIncerely,
> > Levi.
