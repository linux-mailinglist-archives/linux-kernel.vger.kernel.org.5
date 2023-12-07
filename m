Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB98808EC0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443232AbjLGRTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjLGRTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:19:38 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F7BA3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:19:44 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9efa1ab7fso13053771fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701969582; x=1702574382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFzsTwNY0X8LjrwdrZy2AmY/Xkfl1V4/oogMUAjar04=;
        b=Ywd5fwnQ+lQ2RomSew7SeP+MTXAsQWKwoLx4W94dp8lV8+0yfunWuy1bDvBPu6Fppe
         RsoZsEYYw0S1A2ki9y6y8QvLKN6tx/lE1LwycsEI7HuPNMMBhgAXWtdecMcIxMeO79T0
         w3QrkZmfKYMewbKnv5IlINGSU+GkccmyKZ+rHD20f8D0m/h3bOdWrVEA7Yaxa13H0XwN
         gkTw6fDARnCvood4YvKxOtvyXgBYJufpViD928mTwRSLBf3qpv+IknH3DX+YCfovUXUt
         gzGSOSNlP8sZMUSPsivxXBOmldx4/l1t+YONGgq/kczfaSZhbSeTUwZlIzjPrYTmKwc7
         DATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969582; x=1702574382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFzsTwNY0X8LjrwdrZy2AmY/Xkfl1V4/oogMUAjar04=;
        b=EezI1/7xdoSuS1kPi9fq18vD04a2XGp/w8f80MpCvWGLu8W/D/O2wcPEVQrlnOHtiY
         X5WhU8Ibo2UJFyb4KM9l3ELttxyHuS4MgpnvYy10WCBF4zremMPN6DjAxZjuov187gQB
         ix+Mj55OjDwraI27JxRyHUPWDuaT7Y9uL2HK4bu6LhHlNfUjghyuy2JVvFxNc1wyUwt/
         fBmtyYqQOhF+ukxeQEUY2xwgUjrXKUx04W+uAyfT+tr/KH/MQISCG18UR/MwhIVLotNd
         odTFfdt50l8b4YLBsayMEdF64UzhNQK6AgYrEKFHW0fzmcGCoRoRIPFKPo0eOX4fGTiH
         JsvA==
X-Gm-Message-State: AOJu0Yzyz57kjMut8JSrn4jXqmeD5+kiZfpYAPug4chA9m45GyoYL1h4
        TIhcBu3VrFEhUyAPxUnwtth9xtwqnqyrZkYIZ+Q=
X-Google-Smtp-Source: AGHT+IHS2gc/HZHKobnAePosSJLtKbll2DBHPoojlFVh/iT3goe+rpli+NBOsdaIliRpepU9wha5b6it5zfDbYl4BNw=
X-Received: by 2002:a2e:ba09:0:b0:2ca:2912:bd07 with SMTP id
 p9-20020a2eba09000000b002ca2912bd07mr666400lja.176.1701969581894; Thu, 07 Dec
 2023 09:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20231201073240.T9bFNCkU@linutronix.de> <20231201080522.GA31309@didi-ThinkCentre-M930t-N000>
 <20231201161640.Z0cJLUi3@linutronix.de> <CAEQmJ=jbB5ag5HRMjZqjych_wj_v6wTMLQxJbnJsgwNdn37kbw@mail.gmail.com>
 <20231205153146.OSpCIs1G@linutronix.de> <CAEQmJ=iNVUuQQrm4bJgud=e7yhgwNb4Q1-BgOQF98D7NP9r29A@mail.gmail.com>
 <20231207103536.30ae05aa@gandalf.local.home>
In-Reply-To: <20231207103536.30ae05aa@gandalf.local.home>
From:   Yuanhan Zhang <zyhtheonly@gmail.com>
Date:   Thu, 7 Dec 2023 12:19:28 -0500
Message-ID: <CAEQmJ=jceiVevd9d3i4h0BHCNc8FFONJqEaiKyN9p21rg0QdkQ@mail.gmail.com>
Subject: Re: [PATCH v3] sched/cputime: let ktimers align with ksoftirqd in
 accounting CPUTIME_SOFTIRQ
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        zyhtheonly@yeah.net, tglx@linutronix.de, mingo@redhat.com,
        Venkatesh Pallipadi <venki@google.com>, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com
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

Steven Rostedt <rostedt@goodmis.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=887=E6=
=97=A5=E5=91=A8=E5=9B=9B 10:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 7 Dec 2023 18:43:47 +0800
> Yuanhan Zhang <zyhtheonly@gmail.com> wrote:
>
> > It results in if we do not handle ksoftirqd like this, we will have a
> > bigger SYSTEM and less SOFTIRQ.
>
> And honestly that's what we want. Interrupts and softirqs that execute in
> interrupts and softirq context take away from the system. That is, if the=
y
> are not explicitly blocked (local_irq_disable/local_bh_disable) they
> interrupt the current task and take up the time of the current task. We
> need to differentiate this because this context has no "task" context to
> measure.
>
> We do not want to add ksoftirqd or threaded interrupt handlers / softirqs
> to this measurement. Sure, they are handling interrupt and softirq code,
> but they have their own context that can be measured like any other task.
>
> If we blur this with real irqs and softirqs, then we will not know what
> those real irqs and softirqs are measuring.

Yes you say clearly enough and it makes some sense to me!
So my understanding is that in PREEMPT_RT, it is better to put ksoftirqd's =
time
into SYSTEM since they are just in their "task" context.

If my understanding is right, how about we just exclude ksoftirqd
like what I do in the last email?
(something like
    else if (in_serving_softirq() &&
               (IS_ENABLED(CONFIG_PREEMPT_RT) || curr !=3D this_cpu_ksoftir=
qd()))

If this looks okay to you, I'm happy to send a new patch for this :)

>
> > So my point is if we do not align ktimers, ktimers would act like
> > **observation on *not-excluded ksoftirq patched* kernel** part in the
> > above example,
> > and this might make SOFTIRQ less than expected, /proc/stat less accurat=
e.
>
> No it does not. When a softirq kicks off it's work to a thread (ksoftirq,
> threaded softirqd, or simply a workqueue), it's no longer running in
> softirq context, and should not be measured as such.
>
> The measurement is not about how much work the softirq is doing (otherwis=
e
> we need to add workqueues started by softirqs too), it's about measuring
> the actual irq and softirq context. In PREEMPT_RT, we try to eliminate th=
at
> context as much as possible.

Thanks anyway, I think I begin to learn a bit more about PREEMPT_RT...

>
> So seeing less is a feature not a bug!
>
> -- Steve
