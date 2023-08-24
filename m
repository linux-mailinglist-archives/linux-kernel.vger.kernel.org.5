Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF8278655E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbjHXCaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbjHXCaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:30:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB710E5;
        Wed, 23 Aug 2023 19:30:01 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a56401b9aso2786364b3a.1;
        Wed, 23 Aug 2023 19:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692844201; x=1693449001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJwrGCdChlY0C/dK5bpgf0LNuuHaWM9CyX2jaifdjkQ=;
        b=dIZlZFi+0C8OXo/tvDM8xN0jWqsWzIqVYXm3R6KcEWrtS8qXR4mDtn3JiEyeBzsJZy
         2ecEh13YW6Qg3CqauLIhEisbNYg1eUujo2i+9zfnrS31rQWbRRHoR/0VbZ8wuhgArTwY
         mPvBS4/Cr+098GVTFr40NkuKA1gzb47ObEJ3+fwMtqLXRIzaRMIueef7P7rAGRW1TprC
         EmtTJaVOXLRIQThnfKxIGADuA3MhJhJ43qA9ZbwCGp4JokSdXu4GNIxUU6e1RPfNhT2m
         H/YzCS+BL7aUm3Ss90dZIYSw2N9cqZcRec49MjTdKOT0E3I4LDpufByVzlM8WNE3Ir5W
         5rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692844201; x=1693449001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJwrGCdChlY0C/dK5bpgf0LNuuHaWM9CyX2jaifdjkQ=;
        b=E0NvhiiSgbgD61j/iiwj0CBzHcH3BAYKi7k4tD7gP3Sj3umpvBOnuvqJis/HshA2zZ
         LKbQzfdwPwr8J/EbvZASAKnXM9hzziJU757SghEp/au4XBSymn8ze/ntDiaXg/x12nrc
         x8M/TL0eko++TEQwE78bDCTPWGTpPEwg+HBzuhHsRDli2kBr+z/sF3ELmHZbqwXvO2N8
         3eGRuO//Lr6Mk1ZGvW1o6diyEYhopiRKRNaYvJcmOoT0XvMEMVD840KMKWT5rdTSuHku
         pQ+0VaOlIDveON7K2uY8Tzr736noRkgyY1YrkE0C282a3F38CMYnQN+EYpyQaH9HrMoZ
         nBqQ==
X-Gm-Message-State: AOJu0Yy2Z9pRHlwQZPJdfRYiPcTiSFh6oCjJYV3dS/+XXKMFANKMuKO3
        mVFyuOhy/afx8f7/e99TYonSJI9KEdKgzuykl3I=
X-Google-Smtp-Source: AGHT+IFYVKAUMDGtiJjAbfnyLW8QA5tWrGQuRRrj+4nZz4K4wjPD5UW8eP8IWQXI4wVbJxpiqG9OkvpSP927vbaK50g=
X-Received: by 2002:a05:6a00:98f:b0:68b:da4b:4620 with SMTP id
 u15-20020a056a00098f00b0068bda4b4620mr4368790pfg.31.1692844200814; Wed, 23
 Aug 2023 19:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <1683039962-15751-1-git-send-email-zhouzhouyi@gmail.com> <795ab1ed-de92-4f31-9483-b1800b597405@paulmck-laptop>
In-Reply-To: <795ab1ed-de92-4f31-9483-b1800b597405@paulmck-laptop>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 24 Aug 2023 10:29:49 +0800
Message-ID: <CAABZP2zfSmeLO=DRTKP7wPg2zFc4a2AOx31oWTK-xLubqYvS0g@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu: torture: shorten the time between
 forward-progress tests
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lance@osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 5:15=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, May 02, 2023 at 11:06:02PM +0800, zhouzhouyi@gmail.com wrote:
> > From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >
> > Currently, default time between rcu torture forward-progress tests is 6=
0HZ,
> > Under this configuration, false positive caused by __stack_chk_fail [1]=
 is
> > difficult to reproduce (needs average 5*420 seconds for SRCU-P),
> > which means one has to invoke [2] 5 times in average to make [1] appear=
.
> >
> > With time between rcu torture forward-progress tests be 1 HZ, above
> > phenomenon will be reproduced within 3 minutes, which means we can
> > reproduce [1] everytime we invoke [2].
> >
> > Although [1] is a false positive, this change will make possible future
> > true bugs easier to be discovered.
> >
> > [1] Link: https://lore.kernel.org/lkml/CAABZP2yS5=3DZUwEZQ7iHkV0wDm_HgO=
8K-TeAhyJrZhavzKDa44Q@mail.gmail.com/T/
> > [2] tools/testing/selftests/rcutorture/bin/torture.sh
> >
> > Tested in PPC VM of Opensource Lab of Oregon State Univerisity.
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>
> Please accept my apologies for being ridiculously slow to reply!
Never mind. I have made a lot of self improvement during the study of
RCU and RCU torture and your book ;-)
>
> In recent -rcu, module parameters such as this one that simply set a
> value can be overridden on the command line.  So you could get the effect
> (again, in recent kernels) in your testing by adding:
>
>         --bootargs "rcutorture.fwd_progress_holdoff=3D1"
>
> The reason that I am reluctant to accept this patch is that we sometimes
> have trouble with this forward-progress testing exhausting memory, and
> making in happen could therefore cause trouble with generic rcutorture
> testing.
Agree, false positives can disrupt our judgement in many cases.

Thanx Zhouyi
>
> Or am I missing the point of this change?
>
>                                                         Thanx, Paul
>
> > ---
> >  tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot  | 1 +
> >  tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot  | 1 +
> >  tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot | 1 +
> >  tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot  | 1 +
> >  tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot  | 1 +
> >  5 files changed, 5 insertions(+)
> >
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot=
 b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
> > index ce0694fd9b92..982582bff041 100644
> > --- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
> > @@ -1,2 +1,3 @@
> >  rcutorture.torture_type=3Dsrcu
> >  rcutorture.fwd_progress=3D3
> > +rcutorture.fwd_progress_holdoff=3D1
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot=
 b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
> > index 2db39f298d18..18f5d7361d8a 100644
> > --- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
> > @@ -1,4 +1,5 @@
> >  rcutorture.torture_type=3Dsrcud
> >  rcupdate.rcu_self_test=3D1
> >  rcutorture.fwd_progress=3D3
> > +rcutorture.fwd_progress_holdoff=3D1
> >  srcutree.big_cpu_lim=3D5
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boo=
t b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
> > index c70b5db6c2ae..b86bc7df7603 100644
> > --- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
> > @@ -1,2 +1,3 @@
> >  rcutorture.torture_type=3Dtasks-tracing
> >  rcutorture.fwd_progress=3D2
> > +rcutorture.fwd_progress_holdoff=3D1
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot=
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
> > index dd914fa8f690..933302f885df 100644
> > --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
> > @@ -1 +1,2 @@
> >  rcutorture.fwd_progress=3D2
> > +rcutorture.fwd_progress_holdoff=3D1
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot=
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot
> > index dd914fa8f690..933302f885df 100644
> > --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot
> > @@ -1 +1,2 @@
> >  rcutorture.fwd_progress=3D2
> > +rcutorture.fwd_progress_holdoff=3D1
> > --
> > 2.34.1
> >
