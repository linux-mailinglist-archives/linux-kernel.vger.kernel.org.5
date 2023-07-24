Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D976B75EA8E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 06:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGXEhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 00:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGXEhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 00:37:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444B8122
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 21:37:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3172144c084so3483384f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 21:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690173461; x=1690778261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZHcL0SOTF6CbMrr4QYrXlvClPug/NnsMz11+ZmmbM8=;
        b=pRVTF3y5289BhDzNt9u0jcEPcvWzv2e5agYEpVHKjp4efAMhzU2Y1KWeEc3iBjmOTB
         GHjpZBZhk6E+dmCxwx5g252rJDoX5bH2xPwGCGFS11GdMrooViXyS5uRpb4jo661utty
         1surwvYC2qjVcs5TwnuA6hd93zdqMCMXqtK37FNTaqgHWJ9NX/3xDpuhY408BuW+7kqc
         aVd+JVpI5W0BiOM9JXLS3gy2VrrTYGh43+jdXnuiQ0u/TDQLofcY8AZhHXGU4H43jrFf
         wmqC2ja0a5h9ydRc+3C5S4TJjCuzopW8WRU98k/D896e7bHN5kG9TDdsl/JcE4DdDkUC
         8M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690173461; x=1690778261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZHcL0SOTF6CbMrr4QYrXlvClPug/NnsMz11+ZmmbM8=;
        b=fYq/KVO3brLOl433JDJGeOz2CvETka7carnw8XJ8HtsufhBUnVTpiJtx56VcijRSXs
         cJPTkEG5rISCqdix2W3dJOqVrp8IUv2EqZjnx1KBHbLVGnT2PMCqNH8jWhPschnfVedh
         3igyO9w/sP8ar22Vitsl7FWzGOHJoPNTnv3I+bzEA6pLYsIgGJwwnDiFzdmesVbSHD/Q
         oh8ub4tN0zuMwI2OqMK0RiTIUsyE9FadbFkaOl6kOW6nS5tWzq0jxn7ibsI5BFr609UY
         SUCncddB/OpgWXSsu5JVPhkGrexG2dD/jrHPrOWFQOzXGVwjJDnLYZ+HE5wadOho+1pJ
         mzwA==
X-Gm-Message-State: ABy/qLav4javuPtxMtnnnhoGLpiIbNZyjROo4gYQM+O75xy6DaXoWuF3
        +yHl3o3G9vW88vqtNVBi4c+opIXFKkfWn2kTZY4=
X-Google-Smtp-Source: APBJJlGHPpCnwMtrNElXUBUj21Qff5jmiBqj+wqa8ukljjni3UpLKAZtNKnTPej6J40hrX4O+CJ19fB1vaMTvf9LoH4=
X-Received: by 2002:adf:ea0f:0:b0:313:f957:bf29 with SMTP id
 q15-20020adfea0f000000b00313f957bf29mr8589889wrm.65.1690173460414; Sun, 23
 Jul 2023 21:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAKZGPAOYPp3ANWfBWxcsT3TJdPt8jH-f2ZJzpin=UZ=-b_-QFg@mail.gmail.com>
 <CAKZGPAOY9uxvSTuta+4a41=GGqTxus8YDcv54T7iAL9P-fj_+w@mail.gmail.com> <20230720103746.GC3569127@hirez.programming.kicks-ass.net>
In-Reply-To: <20230720103746.GC3569127@hirez.programming.kicks-ass.net>
Sender: getarunks@gmail.com
X-Google-Sender-Delegation: getarunks@gmail.com
From:   Arun KS <arunks.linux@gmail.com>
Date:   Mon, 24 Jul 2023 10:07:28 +0530
X-Google-Sender-Auth: ah61y3xgMv4f2_-0Sl_0CKUkub8
Message-ID: <CAKZGPAPuPQkpaZr4kMEg56VXAV+Ug7auxB2brb1=sbzdRz72rw@mail.gmail.com>
Subject: Re: Question on sched_clock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arun KS <getarunks@gmail.com>, pmladek@suse.com,
        tglx@linutronix.de
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

On Thu, Jul 20, 2023 at 4:07=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Jul 20, 2023 at 03:54:56PM +0530, Arun KS wrote:
> > CCing maintainers
> >
> > On Wed, Jul 19, 2023 at 10:36=E2=80=AFAM Arun KS <arunks.linux@gmail.co=
m> wrote:
> > >
> > > Hi,
> > >
> > > Kernel=E2=80=99s printk uses local_clock() for timestamps and it is m=
apped to
> > > sched_clock(). Two problems/requirements I see,
> > >
> > > One, Kernel=E2=80=99s printk timestamps start from 0, I want to chang=
e this to
> > > match with actual time since boot.
>
> You can fundamentally only consistently tell time since the clock gets
> initialized. Starting at 0 is what you get.
>
> > > Two, sched_clock() doesn=E2=80=99t account for time spend in low powe=
r
> > > state(suspend to ram)
>
> Why would we do that? The next person will complain that they don't want
> this. Then another person complains they also want time spend in
> suspend-to-disk, and another person wants a pony.

Thanks Peter, Got your point. I was trying to understand if there are
any other side effects of doing this downstream.

>
> > >
> > > Could workout patches to modify these behaviours and found working in
> > > my system. But need to hear expert opinion on why this is not done in
> > > the upstream.
> > >
> > > diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> > > index 68d6c1190ac7..b63b2ded5727 100644
> > > --- a/kernel/time/sched_clock.c
> > > +++ b/kernel/time/sched_clock.c
>
> This is only one of many sched_clock implementations...
>
> > > @@ -190,7 +190,10 @@ sched_clock_register(u64 (*read)(void), int bits=
,
> > > unsigned long rate)
> > >         /* Update epoch for new counter and update 'epoch_ns' from ol=
d counter*/
> > >         new_epoch =3D read();
> > >         cyc =3D cd.actual_read_sched_clock();
> > > -       ns =3D rd.epoch_ns + cyc_to_ns((cyc - rd.epoch_cyc) &
> > > rd.sched_clock_mask, rd.mult, rd.shift);
> > > +       if (!cyc)
> > > +               ns =3D cyc_to_ns(new_epoch, new_mult, new_shift)
> > > +       else
> > > +               ns =3D rd.epoch_ns + cyc_to_ns((cyc - rd.epoch_cyc) &
> > > rd.sched_clock_mask, rd.mult, rd.shift);
> > >         cd.actual_read_sched_clock =3D read;
> > >
> > >         rd.read_sched_clock     =3D read;
> > >
> > > @@ -287,7 +290,6 @@ void sched_clock_resume(void)
> > >  {
> > >         struct clock_read_data *rd =3D &cd.read_data[0];
> > >
> > > -       rd->epoch_cyc =3D cd.actual_read_sched_clock();
>
> And what if you've been suspended long enough to wrap the clock ?!?
Fair point. Will take a note.

>
> > >         hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_RE=
L_HARD);
> > >         rd->read_sched_clock =3D cd.actual_read_sched_clock;
> > >  }
> > >
> > > Regards,
> > > Arun
