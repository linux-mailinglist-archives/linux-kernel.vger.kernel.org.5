Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE787BAFA5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjJFAgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjJFAgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:36:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB33D8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:36:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b28dee4de8so58534466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696552598; x=1697157398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFgmfWnki8h/R7++p9q6A3/cLBb3+aKhbDTv7byzrlY=;
        b=dFFZ1/YSxXyzgxxyjqkginlxOYt/SbTUW44x0Q0vFAIiHYKflRwH0CPoxFp12jD5Za
         PgU9E33neuNM/A81kU5KqIS4sW0shKIvu/LWEMwaHDAfueUCfqKLviwwIOY96OkdiUqz
         bTnxW+0Yh5shn+2beKXQa+Fv3LQU8AhcYqEKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696552598; x=1697157398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFgmfWnki8h/R7++p9q6A3/cLBb3+aKhbDTv7byzrlY=;
        b=l0plHvIuQGFcrmlqLRxvBBaXxJkE4nQfIPiC49P9DgxSxPqXqaIknZ2lxahmR3D3p2
         g+qeX/EZfu5y+9iScJ3I6b3iHxMenNj6rpRqJY9QPWvOxij0Op+x075W67yQlYtk9kMN
         HxH4BTf7ppS9eboJvv+wARGOUktkm99SoZOUKsuvpZde8sfqZvyx+HETRSm/i8/rztwS
         BRFbZa1xxC5fssoBfbzOA+1s9/W0VjPTfhPG4n4lxsddUe1YymlSCvxEVt1k/ja5hSA9
         OLRPwzNpBNy68Zy4AFxy7IlVFEdK+4ff7sVkFZ+0JafenCmG6ho+UGiARxGdM14Kxarg
         M2fQ==
X-Gm-Message-State: AOJu0YzQ952VA3lG2dBAFmRZHeYRD0aW50Bkc1TdArHg3aNdHXXxHjSN
        kw+61mmlKAjBHt2sFUo5rdooTf+wvPG4H3LD/YoR8g==
X-Google-Smtp-Source: AGHT+IGuPRZ181qonvgAkt1WxGqramIbgveDQXMFl2wA5Gw5sFbksbRvLIduDYoU6aVcnOe8W4NAOK17zdYkwUBRYm8=
X-Received: by 2002:a17:906:10dd:b0:9a2:1e03:1570 with SMTP id
 v29-20020a17090610dd00b009a21e031570mr5391001ejv.0.1696552597840; Thu, 05 Oct
 2023 17:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230531115839.089944915@infradead.org> <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
 <20230906131356.GG38741@noisy.programming.kicks-ass.net> <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
 <20231002184136.GA1539@noisy.programming.kicks-ass.net> <20231005120557.GA743@noisy.programming.kicks-ass.net>
 <CA+q576MLvCwH2YQFx3V2tf3f4n6JUze7jkpqqTx97UPsOHewhg@mail.gmail.com>
In-Reply-To: <CA+q576MLvCwH2YQFx3V2tf3f4n6JUze7jkpqqTx97UPsOHewhg@mail.gmail.com>
From:   Youssef Esmat <youssefesmat@chromium.org>
Date:   Thu, 5 Oct 2023 19:36:26 -0500
Message-ID: <CA+q576OonOQrDnXtu3VR2Fm9vBomWNovh0A0XnGo5HnSc2S8MQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] sched: EEVDF and latency-nice and/or slice-attr
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 1:23=E2=80=AFPM Youssef Esmat <youssefesmat@chromium=
.org> wrote:
>
> On Thu, Oct 5, 2023 at 7:06=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> >
> > On Mon, Oct 02, 2023 at 08:41:36PM +0200, Peter Zijlstra wrote:
> >
> > > When mixing request sizes things become a little more interesting.
> > >
> > > Let me ponder this a little bit more.
> >
> > Using the attached program (I got *REALLY* fed up trying to draw these
> > diagrams by hand), let us illustrate the difference between Earliest
> > *Eligible* Virtual Deadline First and the one with the Eligible test
> > taken out: EVDF.
> >
> > Specifically, the program was used with the following argument for
> > EEVDF:
> >
> >   ./eevdf -e "0,1024,6" -e "1,1024,2" -e "2,1024,18" -v 19
> >
> > and with an additional '-n' for the EVDF column.
> >

<snip diagrams>

> >
> >
> > As I wrote before; EVDF has worse lag bounds, but this is not
> > insurmountable. The biggest problem that I can see is that of wakeup
> > preemption. Currently we allow to preempt when 'current' has reached V
> > (RUN_TO_PARITY in pick_eevdf()).
> >
> > With these rules, when EEVDF schedules C (our large slice task) at t=3D=
10
> > above, it is only a little behind C and can be reaily preempted after
> > about 2 time units.
> >
> > However, EVDF will delay scheduling C until much later, see how A and B
> > walk far ahead of V until t=3D36. Only when will we pick C. But this me=
ans
> > that we're firmly stuck with C for at least 11 time units. A newly
> > placed task will be around V and will have no chance to preempt.
> >
>
> Thank you for the detailed analysis! I am still in the process of
> digesting everything.
> I do have a quick question, this will only be the case if we adjust
> C's runtime without adjusting nice value, correct? So it does not
> currently apply to the submitted code where the only way to change the
> deadline is to also change the nice value and thus how fast/slow
> vruntime accumulates. In other words without the sched_runtime
> patch[1] we should not run into this scenario, correct?
>
> [1] https://lore.kernel.org/lkml/20230915124354.416936110@noisy.programmi=
ng.kicks-ass.net/

Sorry, to clarify, by "this" I meant "that we're firmly stuck with C
for at least 11 time units".

>
> > That said, I do have me a patch to cure some of that:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/comm=
it/?h=3Dsched/eevdf&id=3Dd7edbe431f31762e516f2730196f41322edcc621
> >
> > That would allow a task with a shorter request time to preempt in spite
> > of RUN_TO_PARITY.
> >
> > However, in this example V is only 2/3 of the way to C's deadline, but
> > it we were to have many more tasks, you'll see V gets closer and closer
> > to C's deadline and it will become harder and harder to place such that
> > preemption becomes viable.
> >
> > Adding 4 more tasks:
> >
> >   ./eevdf -e "0,1024,6" -e "1,1024,2" -e "2,1024,18" -v 19 -n -e "3,102=
4,2" -e "4,1024,2" -e "5,1024,2" -e "6,1024,2"
> >
> > t=3D92 V=3D16
> >  A                   |----<
> >  B                    |<
> > >C   |----------------<
> >  D                    |<
> >  E                   |<
> >  F                    |<
> >  G                   |<
> >    |---------|-----*---|---------|---------|----
> >
> >
> > And I worry this will create very real latency spikes.
> >
> > That said; I do see not having the eligibility check can help. So I'm
> > not opposed to having a sched_feat for this, but I would not want to
> > default to EVDF.
