Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65DD801C2E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 11:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjLBK2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 05:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBK2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 05:28:24 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB2411C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 02:28:30 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50be10acaf9so853021e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 02:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701512909; x=1702117709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smmkaPwRBEhghfavMkRDx5+n1rkAwcjqaQHVGc9sgpo=;
        b=eGbqIZXQR7kBiGbBou8NZP8/75fy/esKY9iCjXojXATk7kExxpkvnh95z/OM/upJfP
         IuKxxGIGrM/GSYidiYOupSn++Xh6zbLMGc3BasbNAFcKTbBv2Tygm64ezind+qVmPRuT
         leN7muMlkqNH1UGnMpY76GGzAVQmHutM5lZuNI2GWiSeD21OCC7YmjzoqLqvGfbYAAdB
         oghElUyZBFjtQ4Va5dK+kTuDwix9yWRuSXMTJAQr+c2XPAR4/fCGe/YA9v0X/kW912dJ
         3WWqRzyoNZOp+3gRHDi4YBY9l2TGtfFY0DK9eDEZWvnYvhv28umvyemvSTgxPcarDaGs
         Y8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701512909; x=1702117709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smmkaPwRBEhghfavMkRDx5+n1rkAwcjqaQHVGc9sgpo=;
        b=alDEQutRfcj/36HgWdM5dt6aVe7S4fTmNZ4ai9zoGmlPm+3hXIp3qQIo3v2HV7Jg2b
         uvQ3h+DD8c70ZSyNDQ6v7vL/tmM7P6dXRuCNVAMxqOhr87MWoloUXFKVlTTc43mJdBZf
         A1t4wdgNawfkrD+wNBcEguckCgvTiqzb4iYizB9SKIg+PmFXWnOXrLvRwMKQ2fGSY9+v
         iEm1CtQ+FIcwiXnxOyMy0fqsVkFOd3ZvCt+P2AXIgiLWDMfzVAIQ8g3hRtYhnQj6BXPR
         x9s/LXXl5BzeM0oh9NY1e/WUXr5WcjSbXTYS+bojKOcwJx9ASTrrOxoQGCUDkuzRLHOA
         mwkw==
X-Gm-Message-State: AOJu0YzOnuPVHwOvJdVjOpc/u0W4XcHyC+g2cfa4rD5beAhPv+RE8rOU
        pse3HQ+7KQI+JbPeWdNNhAW+EaSDXtmObbPVlDk=
X-Google-Smtp-Source: AGHT+IGveJRT/uQ7rxWo1Fs44Iffy89IGaNm6LNweWMB5s46nXUtPCfraIP/yE/OxjxsNghyeM533/+Ln5ztlmhh+Gk=
X-Received: by 2002:a05:6512:b9e:b0:50b:ed31:72a4 with SMTP id
 b30-20020a0565120b9e00b0050bed3172a4mr204572lfv.28.1701512908112; Sat, 02 Dec
 2023 02:28:28 -0800 (PST)
MIME-Version: 1.0
References: <20231201073240.T9bFNCkU@linutronix.de> <20231201080522.GA31309@didi-ThinkCentre-M930t-N000>
 <20231201161640.Z0cJLUi3@linutronix.de>
In-Reply-To: <20231201161640.Z0cJLUi3@linutronix.de>
From:   Yuanhan Zhang <zyhtheonly@gmail.com>
Date:   Sat, 2 Dec 2023 05:28:15 -0500
Message-ID: <CAEQmJ=jbB5ag5HRMjZqjych_wj_v6wTMLQxJbnJsgwNdn37kbw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks for your kindly interpretation.

Sebastian Andrzej Siewior <bigeasy@linutronix.de> =E4=BA=8E2023=E5=B9=B412=
=E6=9C=881=E6=97=A5=E5=91=A8=E4=BA=94 11:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2023-12-01 16:05:41 [+0800], tiozhang wrote:
> > In CONFIG_PREEMPT_RT kernel, ktimers also calls __do_softirq,
> > so when accounting CPUTIME_SOFTIRQ, ktimers need to be accounted the sa=
me
> > as ksoftirqd.
>
> I still don't understand why this is a good thing and why want to align
> it with ksoftirqd and what breaks if we don't.

My motivation of doing this is to keep CPUTIME_SOFTIRQ in /proc/stat
remaining more accurate in PREEPT_RT kernel.

If we dont align, ktimers' cpu time is added to CPUTIME_SYSTEM when
CONFIG_IRQ_TIME_ACCOUNTING is enabled, make our stats less accurate..

>
> This "skip ksoftirqd for accounting" has been added in commit
>         b52bfee445d31 ("sched: Add IRQ_TIME_ACCOUNTING, finer accounting =
of irq time")
>
> At this point (v2.6.37) it had no accounting of time spent in ksoftirqd a=
s
> SOFTIRQ time. This was then fixed/ added by commit
>         414bee9ba613a ("softirqs: Account ksoftirqd time as cpustat softi=
rq")
>
> which went in v2.6.39. It started accounting it when it was noticed by
> the tick. So it is less accurate. The "benefit" seems to be that this
> accounting pops up in /proc/stat. As per-CPU or overall.
>
> I *guess* this was to align the softirqs which occur at the end of an
> interrupt with those which were outsourced to ksoftirqd because they
> took too long. This would patch the wording
>         =E2=80=A6 wanted to see more complete solution in not accounting =
irq
>         processing time to tasks at all.
>         https://lore.kernel.org/all/1284688596-6731-1-git-send-email-venk=
i@google.com/
>
> Or it tried to preserve the current status.
>
> A different account occurs for SOFTIRQs if they occur as port of
> hardirq and are maybe deferred to ksoftirqd vs a task raising softirqs
> on their own like packet over loopback.
> Don't see the benefit that but this is my interpretation based on what
> it does.
>
> This was v2.6.39. Since then we got threaded interrupts (also v2.6.39)
> or threaded-NAPI which utilise mostly the same mechanism as ksoftirqd
> but are treated differently. I don't see why ktimers should align with
> ksoftirqd and honestly and I don't understand why ksoftirqd had to be
> excluded to in the first place.

The main diff between ksoftirqd and force-threaded interrupt is that ksofti=
rq
is in SOFTIRQ_OFFSET (serving softirqs) while  force-threaded is in
SOFTIRQ_DISABLE_OFFSET (by using local_disable_bh).

CPUTIME_SOFTIRQ serves for time in SOFTIRQ_OFFSET (processing softirqs).
See
https://lore.kernel.org/all/1285619753-10892-1-git-send-email-venki@google.=
com/

So this leads to ksoftirqd is counted into CPUTIME_SOFTIRQ but irq-threads
into CPUTIME_SYSTEM.

Since ktimers is also in SOFTIRQ_OFFSET, align it with ksoftirq will
put it into CPUTIME_SOFTIRQ, making /proc/stat more accurate.

>
> Sorry, but I would need to go on than this.

Thanks for your time.

>
> > Signed-off-by: tiozhang <tiozhang@didiglobal.com>
>
> Sebastian
