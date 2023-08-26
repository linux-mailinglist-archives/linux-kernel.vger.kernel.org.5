Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A227789400
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 08:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjHZGOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 02:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjHZGNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 02:13:53 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4C42682;
        Fri, 25 Aug 2023 23:13:51 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a7d4030621so1013592b6e.3;
        Fri, 25 Aug 2023 23:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693030430; x=1693635230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sgU8Ln5Lgx/RyqorzJt1zp0SL+mSfYjwzgmS5gdi1bI=;
        b=VJ/IhqnxcNSiLJr3e+7lBNC9NPpr8c0TSDH3lo/IBe9gFpwnzNXUnHZi1pbgLlK3vx
         M9x6L7YjK0D1rfF+DHhl8YNETJ4p9WLByCR0amXTAX2ONhPPDpJc+t6Axw1wcvS+2Ea1
         0bVKtjwmL5E4WRZIJxu8vBlJu5TB2Xz+KZGOtf/JuL8gAERxdj8/x2vZUu+0UuZPy3O8
         r7x6PzR9etlZyEl2l5xZGxT/x6EI6LKQPfTsLIyZWxAuXVpxTs+rDYSoVpNF6WjSrNJa
         tvKLhLeY3cJHic86KYz6xX3GEg+715nBQluBP6kYZb9u8bpm9k8xHwcZlt6Hlnvz9ugv
         UpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693030430; x=1693635230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgU8Ln5Lgx/RyqorzJt1zp0SL+mSfYjwzgmS5gdi1bI=;
        b=iOu02tom1Zv5WppsBrRIKzteYPgSrIddoZF8oP1t8D/L6CappacMcsBDT4exiICU/d
         5un1xNuf5mfqvsT0GtimKG8TVHGa7veQE0eLRbwPhHK3Ym2+vsN5SQIhfFWpYH2p2Fe8
         3myhetLnghTKPVDL4hmY9/1DFM4GFLXYPmgwIi+N5KXjLBcNSYs+wInvUxQD5ymleSb4
         s2AHfEnEgobWJLAgiPj9ElVU43v383hXSNBWtsPomzvXkdTLy53KWyN965l1RCrjJo+T
         okFhgOdniTUDG5g3B5a+2bA45fkDbZ3JE1g/6L/IL37mnlhXeOIVJwbZSqWfmXDTI93I
         3nvQ==
X-Gm-Message-State: AOJu0Yzev71EgCh1xPyPnTo+DOQtqm+o7XIJYN1D1cB6JGieA+MvoW/q
        vgjG0K+uw6dvcQu1p7heKcPaUN4hO/IOxipdndk=
X-Google-Smtp-Source: AGHT+IGnBRlCy/GHk0hYXyJ3W+bjgnmngqX6N4H7rzMmNwfLoYz7Zw5qoS9HgRRNXRSSlRw+/0U4uy2u46DpP9m1DaE=
X-Received: by 2002:a05:6808:2d7:b0:3a8:6c27:c1f6 with SMTP id
 a23-20020a05680802d700b003a86c27c1f6mr4884677oid.19.1693030430437; Fri, 25
 Aug 2023 23:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230824084206.22844-1-qiang.zhang1211@gmail.com>
 <162989fe-5ed8-4d1f-8c99-144e2de532f5@paulmck-laptop> <CALm+0cVgg9u1-E+XrnbEyD75a_H3ifN9oB9j6xx0=cm8kuXE-Q@mail.gmail.com>
 <20e7f112-ff70-4ba7-b39f-a0fea499d8d7@paulmck-laptop>
In-Reply-To: <20e7f112-ff70-4ba7-b39f-a0fea499d8d7@paulmck-laptop>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Sat, 26 Aug 2023 14:13:39 +0800
Message-ID: <CALm+0cV8GP_gbbiCwmKyMxE=Qm1pLVWXWkmHUjdaDS8L0hZgFw@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in rcu_nocb_toggle()
To:     paulmck@kernel.org
Cc:     joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
> On Fri, Aug 25, 2023 at 10:28:37AM +0800, Z qiang wrote:
> > >
> > > On Thu, Aug 24, 2023 at 04:42:06PM +0800, Zqiang wrote:
> > > > Currently, the maxcpu is set by traversing online CPUs, however, if
> > > > the rcutorture.onoff_holdoff is set zero and onoff_interval is set
> > > > non-zero, and the some CPUs with larger cpuid has been offline before
> > > > setting maxcpu, for these CPUs, even if they are online again, also
> > > > cannot be offload or deoffload.
> > > >
> > > > This commit therefore use for_each_possible_cpu() instead of
> > > > for_each_online_cpu() in rcu_nocb_toggle().
> > > >
> > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > ---
> > > >  kernel/rcu/rcutorture.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > > index a58372bdf0c1..b75d0fe558ce 100644
> > > > --- a/kernel/rcu/rcutorture.c
> > > > +++ b/kernel/rcu/rcutorture.c
> > > > @@ -2131,7 +2131,7 @@ static int rcu_nocb_toggle(void *arg)
> > > >       VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
> > > >       while (!rcu_inkernel_boot_has_ended())
> > > >               schedule_timeout_interruptible(HZ / 10);
> > > > -     for_each_online_cpu(cpu)
> > > > +     for_each_possible_cpu(cpu)
> > >
> > > Last I checked, bad things could happen if the code attempted to
> > > nocb_toggle a CPU that had not yet come online.  Has that changed?
> >
> > For example, there are 8 online CPUs in the system, before we traversing online
> > CPUs and set maxcpu,  CPU7 has been offline, this causes us to miss nocb_toggle
> > for CPU7(maxcpu=6)
> >
> > Even though we still use for_each_online_cpu(), the things described
> > above also happen.  before we toggle the CPU, this CPU has been offline.
>
> Suppose we have a system whose possible CPUs are 0, 1, 2, and 3.  However,
> only 0 and 1 are present in this system, and until some manual action is
> taken, only 0 and 1 will ever be online.  (Yes, this really can happen!)
> In that state, won't toggling CPU 2 and 3 result in failures?
>

Agree.
As long as we enabled rcutorture.onoff_interval,  regardless of whether we use
online CPUs or possible CPUs to set maxcpu,  It is all possible to
toggling the CPUs failure
and print "NOCB: Cannot CB-offload offline CPU" log. but the failures
due to CPU offline are acceptable.

but at least the toggling operation on CPU7 will not be missed. when
CPU7 comes online again.

Would it be better to use for_each_present_cpu() ?

Thanks
Zqiang

>
>                                                         Thanx, Paul
>
> > Thanks
> > Zqiang
> >
> >
> > >
> > >                                                         Thanx, Paul
> > >
> > > >               maxcpu = cpu;
> > > >       WARN_ON(maxcpu < 0);
> > > >       if (toggle_interval > ULONG_MAX)
> > > > --
> > > > 2.17.1
> > > >
