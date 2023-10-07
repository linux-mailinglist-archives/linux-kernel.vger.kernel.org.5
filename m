Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087AC7BC6C4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343827AbjJGKZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343783AbjJGKZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:25:06 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6731193;
        Sat,  7 Oct 2023 03:25:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2773523b2b6so1941109a91.2;
        Sat, 07 Oct 2023 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696674305; x=1697279105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZrX+dTB7po/SFyO4VmNLR/v/7IkFcGD0fZTbD+Yg6I=;
        b=OJ+njM1dFP/ZorHh3Mzlf1jEIX7P22pEq03dvKLj4x49vtNGekE3ofD1rEKqU1h3RW
         uDBFNlxFpExXuS2oyFRBk1uIYffgWhwqbLiXDEndLc+9zQoXVuYyvuMyWaPCTFCACLXR
         ptzCbMcMSj+sHn1MwtQ5JaqzUOAePcMbMS7Ik1uCmuX3vFaVGew0lm6huhO/yGxcA5V0
         aUqHG8PvAnokT+vZJ77ghVwRtXvDOHnAqTeTPVCR0JmQNQC4B8ucMtvf3wiqyc/UnAGE
         Z+2f5eQU1uAs+KRhAmNeK0ODJUT7IIanHZiIW5agHmXoLsbFTh55x8TpfmCVczQj5SjN
         d6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696674305; x=1697279105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZrX+dTB7po/SFyO4VmNLR/v/7IkFcGD0fZTbD+Yg6I=;
        b=i4OPgoJcsMIfVRy2hXLoWj3ZGkfAQHXiEPDYkSiXKwa9IJHGdeqYkYbr+Cow7uEvDH
         H4g5lS3jKKecYs3fZEQFlXoxNrrhp48aM6G+6lkdssOY31VmXthkIx0ywDqwMbizEvH+
         ObaFenQYIhKlQnMdnQfl1ZiHpyIqm4ZwiiUm+mcfbHZ2TVrIF3+hYJ6VL9mqmCo3kus5
         e/YLd1cMfkRSgA21StTZI/TDppsOJgEshPs6XomDy2aawTQIvhM27tdSZJeU76cTctWl
         sXSal7ugkK1u2fkUhx8DkHX6ypQOHlVB5ibpQ9NgB0DufPPaFAqXqgw1C08L2m8+eFBi
         s16Q==
X-Gm-Message-State: AOJu0Yxb1MerWLWkiPeBgLo6w3lKgsdYpEUeeMxJhoMtB1oQL0CEAzGi
        8UHlczRqyPsOktHguYKXckg1zrOfTSw9J3fcf8w=
X-Google-Smtp-Source: AGHT+IH1hI2l1/yITSbqW+RpK+Q5smunjEoi5mtQynU7RHJOiuJFSjsMQw+MtS83LJdNGcUzRnip+GzO4SWEs+0lwFg=
X-Received: by 2002:a17:90a:fe17:b0:277:cdc:29cf with SMTP id
 ck23-20020a17090afe1700b002770cdc29cfmr9865372pjb.46.1696674304734; Sat, 07
 Oct 2023 03:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231003232903.7109-1-frederic@kernel.org> <f214737a-6856-455f-ac86-9f7ec605b902@paulmck-laptop>
 <ZR0vjdp+BNiFm46+@lothringen>
In-Reply-To: <ZR0vjdp+BNiFm46+@lothringen>
From:   zhuangel570 <zhuangel570@gmail.com>
Date:   Sat, 7 Oct 2023 18:24:53 +0800
Message-ID: <CANZk6aQG4Lqyk8JkT_my3dwub4jGpn31wYRoCwW4oSH1x=sJ1A@mail.gmail.com>
Subject: Re: [PATCH 0/5] srcu fixes
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 5:25=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> On Tue, Oct 03, 2023 at 05:35:31PM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 04, 2023 at 01:28:58AM +0200, Frederic Weisbecker wrote:
> > > Hi,
> > >
> > > This contains a fix for "SRCU: kworker hung in synchronize_srcu":
> > >
> > >     http://lore.kernel.org/CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=
=3DxXMB401g@mail.gmail.com
> > >
> > > And a few cleanups.
> > >
> > > Passed 50 hours of SRCU-P and SRCU-N.
> > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks=
.git
> > >     srcu/fixes
> > >
> > > HEAD: 7ea5adc5673b42ef06e811dca75e43d558cc87e0
> > >
> > > Thanks,
> > >     Frederic
> >
> > Very good, and a big "Thank You!!!" to all of you!
> >
> > I queued this series for testing purposes, and have started a bunch of
> > SRCU-P and SRCU-N tests on one set of systems, and a single SRCU-P and
> > SRCU-N on another system, but with both scenarios resized to 40 CPU eac=
h.
> >
> > While that is in flight, a few questions:
> >
> > o     Please check the Co-developed-by rules.  Last I knew, it was
> >       necessary to have a Signed-off-by after each Co-developed-by.
>
> Indeed! I'll try to collect the three of them within a few days. If some
> are missing, I'll put a Reported-by instead.
>
> >
> > o     Is it possible to get a Tested-by from the original reporter?
> >       Or is this not reproducible?
>
> It seems that the issue would trigger rarely. But I hope we can get one.

There is currently no way to reproduce this problem in our environment.
The problem has appeared on 2 machines, and each time it occurred, the
test had been running for more than a month.

BTW, I will run tests with these patches in our environment.

>
> >
> > o     Is it possible to convince rcutorture to find this sort of
> >       bug?  Seems like it should be, but easy to say...
>
> So at least the part where advance/accelerate fail is observed from time
> to time. But then we must meet two more rare events:
>
> 1) The CPU failing to ACC/ADV must also fail to start the grace period be=
cause
>   another CPU was faster.
>
> 2) The callbacks invocation must not run until that grace period has ende=
d (even
>   though we had a previous one completed with callbacks ready).
>
>   Or it can run after all but at least the acceleration part of it has to
>   happen after the end of the new grace period.
>
> Perhaps all these conditions can me met more often if we overcommit the n=
umber
> of vCPU. For example run 10 SRCU-P instances within 3 real CPUs. This cou=
ld
> introduce random breaks within the torture writers...
>
> Just an idea...
>
> >
> > o     Frederic, would you like to include this in your upcoming
> >       pull request?  Or does it need more time?
>
> At least the first patch yes. It should be easily backported and
> it should be enough to solve the race. I'll just wait a bit to collect
> more tags.
>
> Thanks!
>
> >
> >                                               Thanx, Paul
> >
> > > ---
> > >
> > > Frederic Weisbecker (5):
> > >       srcu: Fix callbacks acceleration mishandling
> > >       srcu: Only accelerate on enqueue time
> > >       srcu: Remove superfluous callbacks advancing from srcu_start_gp=
()
> > >       srcu: No need to advance/accelerate if no callback enqueued
> > >       srcu: Explain why callbacks invocations can't run concurrently
> > >
> > >
> > >  kernel/rcu/srcutree.c | 55 ++++++++++++++++++++++++++++++++++++-----=
----------
> > >  1 file changed, 39 insertions(+), 16 deletions(-)
