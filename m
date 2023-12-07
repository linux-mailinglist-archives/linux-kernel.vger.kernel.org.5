Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51189808641
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjLGKn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjLGKnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:43:55 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0987D4B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:44:01 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9ef682264so6621871fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 02:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701945840; x=1702550640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NToopFfj3zJgp0Zs6TGFfeur5itmedxFuewhh83+XaA=;
        b=cHseBrKyHWtsgHFbnd8jl2ADj6YWgkxDa1C9mOpxt0lwRklhgKvXHPYDsI2lmsqVGL
         145IRedIqcU9Md6TkBF/zTINfUZI5CyXDAtYDMs1Fnqyru9+dtU+SBKyMU7BNGykB+Mc
         4u0FGCeWnjcDCNVCkJxrBB7s4/iAyqYb29JK5qXDtDzR3WsjTXpas8x0pxHdor1C2gRB
         NSlGMmUG4hSNvq+BasUZTQvJnJ8owT9sUb0/gX+LZmL75lzDt5f2Mv3zF0K0bDyXIsIC
         nFQaHiQdmnHH0N+TnVr67jYxnjgTh53PR0HmHjJcgOQS6p5EovpOB0bR2FyxLY4EiqzD
         t67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701945840; x=1702550640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NToopFfj3zJgp0Zs6TGFfeur5itmedxFuewhh83+XaA=;
        b=ollSrJ0iKJrlBHpvIqpaBaiztM+zDm3jyWubRFKxL5HizlEMh99RR6eteSkdLzmGJZ
         d8wVFpGAy9ctTul+n/kY6dtF+niOyUUAT7oW4hNYTVPDmFX7Q3nA2DrlWsKFRGtJk7CW
         SFDN36y/vaWPC66xkchto/Q0Y1TslxfM1Oqnu4j6b6uYaIebdRU8Twr+w90w3Ko4PN1r
         fgvW4h+7ciEOWyv6KfY3w1tfeJ80ztxDN1kFeZyxKDhjGn+QH0nfKIC2EPnNJexfTKto
         htieJ1QeH6Hxh9dU7Va3ZFU7OXKHFCKibmRu+r9g3etY9DZcgPWsxLbPsDJz1VAR9lRD
         eNjA==
X-Gm-Message-State: AOJu0YybYNqni+VO0Gj3XI3qm3V5XUi+gqIoqRq2Tqvts41s4f7Lkae6
        I9CBZnSZxj6apWrlLF4odsNYcJgd4eg1NoNi22M=
X-Google-Smtp-Source: AGHT+IFOursrMakG0h33TA/au96GPlTKC8SCDKw7n8sKSWlQtR1gXHGn4l78NnD66D0rxhVhmU7bQzf/TsTHjmAABOA=
X-Received: by 2002:a2e:870a:0:b0:2c9:ffe6:5bbb with SMTP id
 m10-20020a2e870a000000b002c9ffe65bbbmr1423695lji.13.1701945839124; Thu, 07
 Dec 2023 02:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20231201073240.T9bFNCkU@linutronix.de> <20231201080522.GA31309@didi-ThinkCentre-M930t-N000>
 <20231201161640.Z0cJLUi3@linutronix.de> <CAEQmJ=jbB5ag5HRMjZqjych_wj_v6wTMLQxJbnJsgwNdn37kbw@mail.gmail.com>
 <20231205153146.OSpCIs1G@linutronix.de>
In-Reply-To: <20231205153146.OSpCIs1G@linutronix.de>
From:   Yuanhan Zhang <zyhtheonly@gmail.com>
Date:   Thu, 7 Dec 2023 18:43:47 +0800
Message-ID: <CAEQmJ=iNVUuQQrm4bJgud=e7yhgwNb4Q1-BgOQF98D7NP9r29A@mail.gmail.com>
Subject: Re: [PATCH v3] sched/cputime: let ktimers align with ksoftirqd in
 accounting CPUTIME_SOFTIRQ
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     zyhtheonly@yeah.net, tglx@linutronix.de, rostedt@goodmis.org,
        mingo@redhat.com, Venkatesh Pallipadi <venki@google.com>,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sebastian Andrzej Siewior <bigeasy@linutronix.de> =E4=BA=8E2023=E5=B9=B412=
=E6=9C=885=E6=97=A5=E5=91=A8=E4=BA=8C 23:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2023-12-02 05:28:15 [-0500], Yuanhan Zhang wrote:
> > Hi,
> Hi,
>
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> =E4=BA=8E2023=E5=B9=
=B412=E6=9C=881=E6=97=A5=E5=91=A8=E4=BA=94 11:16=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On 2023-12-01 16:05:41 [+0800], tiozhang wrote:
> > > > In CONFIG_PREEMPT_RT kernel, ktimers also calls __do_softirq,
> > > > so when accounting CPUTIME_SOFTIRQ, ktimers need to be accounted th=
e same
> > > > as ksoftirqd.
> > >
> > > I still don't understand why this is a good thing and why want to ali=
gn
> > > it with ksoftirqd and what breaks if we don't.
> >
> > My motivation of doing this is to keep CPUTIME_SOFTIRQ in /proc/stat
> > remaining more accurate in PREEPT_RT kernel.
> >
> > If we dont align, ktimers' cpu time is added to CPUTIME_SYSTEM when
> > CONFIG_IRQ_TIME_ACCOUNTING is enabled, make our stats less accurate..
>
> So it is only SYSTEM? There is no additional SOFTIRQ that is used?

Yes, there is some SOFTIRQ, but less than expected.
Here is my little test to explain this, in a reverse way:

I patch my kernel with ksoftirqd not-excluded, like this:

/**/
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 0796f938c4f0..6de9eccd094b 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c

@@ -67,7 +67,7 @@ void irqtime_account_irq(struct task_struct *curr)
         */
        if (hardirq_count())
                irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
-       else if (in_serving_softirq() && curr !=3D this_cpu_ksoftirqd())
+       else if (in_serving_softirq())
                irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
 }
 EXPORT_SYMBOL_GPL(irqtime_account_irq);

@@ -371,14 +371,7 @@ static void irqtime_account_process_tick(struct
task_struct *p, int user_tick,

        cputime -=3D other;

-       if (this_cpu_ksoftirqd() =3D=3D p) {
-               /*
-                * ksoftirqd time do not get accounted in cpu_softirq_time.
-                * So, we have to handle it separately here.
-                * Also, p->stime needs to be updated for ksoftirqd.
-                */
-               account_system_index_time(p, cputime, CPUTIME_SOFTIRQ);
-       } else if (user_tick) {
+       if (user_tick) {
                account_user_time(p, cputime);
        } else if (p =3D=3D rq->idle) {
                account_idle_time(cputime);
/**/

Then I do the following test between patched and unpatched kernels on
the same machine:
1. set loopback rps&xps on cpu0
2. test it with iperf like: `iperf -c 127.0.0.1 -P 1 -t 999 -i 1`, making s=
ome
softirqs happening on [ksoftirqd/0].
3. observe delta per second on /proc/stat

observation on *not-excluded ksoftirq patched* kernel:
------------------------------------------------------------------------
// SOFTIRQ stats
root@ubuntu-1804-live-x86-tiozhang:~#
while true;do sleep 1;curr=3D`cat /proc/stat | grep cpu0 | awk '{print
$8}'`;echo $((curr-last));last=3D$curr;done
...
13
14
13
13
13
13
14
13
13
13
...
// SYSTEM stats
root@ubuntu-1804-live-x86-tiozhang:~#
while true;do sleep 1;curr=3D`cat /proc/stat | grep cpu0 | awk '{print
$4}'`;echo $((curr-last));last=3D$curr;done
...
75
78
76
79
77
77
78
76
76
77
78
77
...

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

observation on *normal* kernel:
------------------------------------------------------------------------
// SOFTIRQ stats
root@ubuntu-1804-live-x86-tiozhang-2:~#
while true;do sleep 1;curr=3D`cat /proc/stat | grep cpu0 | awk '{print
$8}'`;echo $((curr-last));last=3D$curr;done
...
18
20
22
17
23
18
18
20
17
20
18
18
22
18
22
...
// SYSTEM stats
root@ubuntu-1804-live-x86-tiozhang-2:~#
while true;do sleep 1;curr=3D`cat /proc/stat | grep cpu0 | awk '{print
$4}'`;echo $((curr-last));last=3D$curr;done
...
72
74
73
74
72
69
74
76
73
73
74
73
72
73
73
...

It results in if we do not handle ksoftirqd like this, we will have a
bigger SYSTEM and less SOFTIRQ.
So my point is if we do not align ktimers, ktimers would act like
**observation on *not-excluded ksoftirq patched* kernel** part in the
above example,
and this might make SOFTIRQ less than expected, /proc/stat less accurate.

>
> > The main diff between ksoftirqd and force-threaded interrupt is that ks=
oftirq
> > is in SOFTIRQ_OFFSET (serving softirqs) while  force-threaded is in
> > SOFTIRQ_DISABLE_OFFSET (by using local_disable_bh).
>
> This depends. If you look at a network driver, SOFTIRQ_DISABLE_OFFSET is
> used during the driver routine doing almost only schedule a softirq.
> Then the main part happens during SOFTIRQ_OFFSET where the driver pulls
> the packets and passes them to the network stack.
>
> > CPUTIME_SOFTIRQ serves for time in SOFTIRQ_OFFSET (processing softirqs)=
.
> > See
> > https://lore.kernel.org/all/1285619753-10892-1-git-send-email-venki@goo=
gle.com/
>
> Let me look at this later=E2=80=A6
>
> > So this leads to ksoftirqd is counted into CPUTIME_SOFTIRQ but irq-thre=
ads
> > into CPUTIME_SYSTEM.
> >
> > Since ktimers is also in SOFTIRQ_OFFSET, align it with ksoftirq will
> > put it into CPUTIME_SOFTIRQ, making /proc/stat more accurate.
>
> But this only works if it is observed during the TICK interrupt, right?

This may take a long time to read, thanks again for your time and patience.

>
> Sebastian
