Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E09978656A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbjHXCbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbjHXCaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:30:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE6510E5;
        Wed, 23 Aug 2023 19:30:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26d60f27491so2915836a91.1;
        Wed, 23 Aug 2023 19:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692844248; x=1693449048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXV0FqCm9bu5AEOC96cbW8cXHv67KP0cqZLLFhbEfYw=;
        b=sWKYtitE38vH0TOa0fmHdt4mqQ6u8jm50+Gp1cs47szbrU4Ap1WEVh7xhGWusOWoeC
         bsz4q5MK5t1FIfI44ZPxgYD2sKarPSR4wJnnLL5QuO5yqAWNcXq85vYN0cXDEEBASg3u
         1aY2Arl7c4m35N6ZJ5Ek2YtfijLul6QNLC8QLK5G0IYrgP4lI+11hdKDlrRqZ3FuThPp
         8O7V2gtGGc3lBZZDWHgk9KqWOoVu+1fbKIu5EQQTm8/DwzXFAr0Kvm1nXyztRt47B2Sg
         QJnim0M4eEX3aT82IOJ4Y5E40dMGM2c7tTWQhnSooycC5ohM3JDmVbjTYlaAVvw9ByQY
         QRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692844248; x=1693449048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXV0FqCm9bu5AEOC96cbW8cXHv67KP0cqZLLFhbEfYw=;
        b=AdIPJCgQqkm6PSWWWmsaxH7oJCAIeW/qRfJhj6lVKnwIgEpwYJUeSYmHdw6o5olpy0
         ukHH/EztsshgVsnlxMnjA73NSwryqzwkQ5jbK5zyDS0pRoMZNtVS1KUPLDZq3axcMVwK
         4nd3PSg7ORfoIpXb2Lr8Of398m8Sliw8uePHhVIO9sAP+GI2NelKHPktykkmYMS0rLMQ
         Gn1kq/thBEaTeF9OKaj1+SELzjkM0BnIeLJMLouuVeerElLKGsJ7KoUOma9+R+/Fq8VZ
         hfU/RGNH+xxaHk9NcvZEyh7rrENWSXhBi+j/QlU7LLapKd5IvVj9/cZwTCtGqq6q4cd6
         REEw==
X-Gm-Message-State: AOJu0YxJfoowUTeIP7qNgeDn4q9H8CZUQIkpQWbR22pJ+r+zEzsRDUx5
        pshd9ulcBUapr1NBKp1Td8I+JMSGfEBL0yUXN5zbczEK1o0=
X-Google-Smtp-Source: AGHT+IExN5gutxIbu6IZtzcE5CQMwX876Au1J1N/Tt5sXri66AS4E9vDNB1wPGyvxIREPL9GvSUhcToBOs4z3ug0jC8=
X-Received: by 2002:a17:90b:1082:b0:26d:4ab3:fe11 with SMTP id
 gj2-20020a17090b108200b0026d4ab3fe11mr10027538pjb.24.1692844248428; Wed, 23
 Aug 2023 19:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALm+0cVvHb=Fe8kseVLesjS1d=579c7Bn5hxdiqyzBp5Z7SugA@mail.gmail.com>
 <CAEXW_YScFnFG0Y1NgFS7KGS6s9CoXJ3ZQB++6udyK38mcJ=1xg@mail.gmail.com> <600e1ab4-059b-4b4e-9db2-2c56ac557d3b@paulmck-laptop>
In-Reply-To: <600e1ab4-059b-4b4e-9db2-2c56ac557d3b@paulmck-laptop>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Thu, 24 Aug 2023 10:30:37 +0800
Message-ID: <CALm+0cUrwYAQ=frj+S=N8s8Q4KYV6JWoU0+2E-NvaqEoFcMC7g@mail.gmail.com>
Subject: Re: rcutorture: Can not Disable RT throttling
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
> On Wed, Aug 23, 2023 at 09:50:37AM -0400, Joel Fernandes wrote:
> > On Tue, Aug 22, 2023 at 3:37=E2=80=AFAM Z qiang <qiang.zhang1211@gmail.=
com> wrote:
> > >
> > > When running build-in rcutorture tests in 6.5.0-rc4-rt, and found tha=
t,
> > > although the value of /proc/sys/kernel/sched_rt_runtime_us is -1,
> > >
> > > cat /sys/kernel/debug/sched/debug
> > > ....
> > > rt_rq[6]:
> > >   .rt_nr_running                 : 4
> > >   .rt_nr_migratory               : 0
> > >   .rt_throttled                  : 0
> > >   .rt_time                       : 0.000000
> > >   .rt_runtime                    : 950.000000
> > >
> > > but the rt_runtime still is 950.000000.
> > > set sysctl_sched_rt_runtime in rcu_torture_disable_rt_throttle()
> > > does not disable rt-throttling.
> >
> > I think you have hit a bug. I think the problem is
> > rcu_torture_disable_rt_throttle() modifies the sysctl knobs, but does
> > not change def_rt_bandwidth and reinitialize the rt_rq. I think we
> > need to call sched_rt_do_global() like the sysfs handler does, or
> > change the sysctl knobs to be earlier in the boot process before the
> > rt_rq are initialized.

I've thought about something like this before, call the sched_rt*() in
the sched_rt_handler(),
this requires exporting these functions.

> >
> > Or better yet (not sure if it is possible) trigger the sysctl change
> > via the sysctl layer and let it do the same logic.

This is good, but I haven't found it yet

>
> That would be difficult in built-in rcutorture testing due to the fact
> that there is not much in the way of userspace.  I suppose we could
> invoke the sysfs handler so as to mock up a userspace access, but that
> might not be the most robust approach.

Does it mean to use filp_open() to open sched_rt_runtime_us file and
write -1 through kernel_write() ?


>
> Another way is to disable preemption in the real-time kthreads.  Which
> might need careful implementation to avoid "scheduling while atomic"
> and friends.
>
>                                                         Thanx, Paul
