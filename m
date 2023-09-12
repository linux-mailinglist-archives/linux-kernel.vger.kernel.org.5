Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A3379D4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbjILPbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbjILPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:31:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D5210F3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:31:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D147BC43391
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694532685;
        bh=S4zz5jP4YJxJ2vM+gOrgBKETCnLCuSrQSLBkKGxrHo0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FCUH6ryYX4GOH62XEZZkwPA6oR50f0GLhw3lVlfwybtdajW/AQ7GaVnKXGZz+oq87
         zlp10CbizsUIoggFk+O9UbZF+cVHpaEo850/yfuibZz9hoV5jnMhFoSPJos8OYbeuS
         qLaU6EeRZxV6OPcHv6czDVSQDTGOEl4w7/4Q6/bk81j13FZ17Jh7kx8zcaBGBsBuN6
         hHyjEn5gdHQga1AWIyUc9VTaK9kKmUnTi01O332M9pXbaUCmyqYsXS73x33+hdWyjB
         UdSOMSibTKgFmb2u1lNDdaCjO9Kle0JOPfDb09YXlAwVliPqIMFq0jdbaRdkXMeBxm
         zAcp5PkD0w85Q==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-501be2d45e0so9741094e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:31:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YxDNdQzB2d/MJ2A7As/QDYWFB4Ke5VVraY1mH1+3iSW12U8A2yi
        8kH082vlNzGqxRysPa0IIsB4pjGct1hXDWy9GQI=
X-Google-Smtp-Source: AGHT+IEAzbWind6QkVA4CSriWWeR9aL1Ys9MnwFlN7DNTScPGNUNHzZmpN+NdmI+ip1qnes6OS9ZFtlqdLaRsV93f0g=
X-Received: by 2002:a19:2d58:0:b0:4f8:6abe:5249 with SMTP id
 t24-20020a192d58000000b004f86abe5249mr9260322lft.3.1694532684005; Tue, 12 Sep
 2023 08:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230615121016.3731983-1-chenhuacai@loongson.cn>
 <CAAhV-H49AyrG-sH2SXLNg_cX-Wv8vS4Qno_2N4v6ccGGciv-+A@mail.gmail.com>
 <ZJ9kWqhRCWkLcYyv@bombadil.infradead.org> <CAAhV-H7qk8wSFt=ZMUSUt4cAmH+-5AsGqszXNW9w+u6Y8vDN+A@mail.gmail.com>
 <CAAhV-H7RgkZJ2hfmNmJXKqcYeE1q11V4-2Ni0j-FLJ0b5fc=Sg@mail.gmail.com>
 <CAAhV-H5pwHQTQ6wGXC2NELHmC4JM8rQUViR3RJj8hQLBygb00w@mail.gmail.com> <87cyyo9moz.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87cyyo9moz.fsf@email.froward.int.ebiederm.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 12 Sep 2023 23:31:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7D85NTS+8VP6ELiiMVrFkarhjBFbHERLbA9azaK9=XcQ@mail.gmail.com>
Message-ID: <CAAhV-H7D85NTS+8VP6ELiiMVrFkarhjBFbHERLbA9azaK9=XcQ@mail.gmail.com>
Subject: Re: [PATCH] kthread: Rename user_mode_thread() to kmuser_thread()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eric,

On Tue, Sep 12, 2023 at 9:59=E2=80=AFAM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> Huacai Chen <chenhuacai@kernel.org> writes:
>
> > Hi, all,
> >
> > Friendly ping again?
> >
> >
> > Huacai
> >
> > On Sun, Jul 23, 2023 at 10:13=E2=80=AFPM Huacai Chen <chenhuacai@kernel=
.org> wrote:
> >>
> >> Hi, Eric,
> >>
> >> On Tue, Jul 18, 2023 at 8:43=E2=80=AFPM Huacai Chen <chenhuacai@kernel=
.org> wrote:
> >> >
> >> > Hi, Luis,
> >> >
> >> > On Sat, Jul 1, 2023 at 7:25=E2=80=AFAM Luis Chamberlain <mcgrof@kern=
el.org> wrote:
> >> > >
> >> > > On Sun, Jun 25, 2023 at 04:55:33PM +0800, Huacai Chen wrote:
> >> > > > Friendly ping?
> >> > >
> >> > > You want to cc the folks who Nacked your patch. Until then, this
> >> > > probably can't go further.
> >> > Thank you very much. Eric and Andrew are already in the CC list, so
> >> > add Thomas now.
> >> >
> >> > My brain is a little old-fashioned so I insisted that "a thread
> >> > without mm_struct should be a kernel thread" in the previous patch.
> >> > Unfortunately this makes Eric and Thomas unhappy, I'm very sorry for
> >> > that.
> >> >
> >> > During the discussion of the previous patch I know I made some
> >> > mistakes about some basic concepts, but I also found the name
> >> > "user_mode_thread()" is somewhat confusing. I think rename it to
> >> > kmuser_thread() is better, because:
> >> > 1, it identify init and umh as user threads;
> >> > 2, it points out that init and umh are special user threads that run
> >> > in kernel mode before loading a user program.
> >> >
> >> > Sorry for my rudeness again.
> >> Excuse me, but could you please tell me what your opinion is. In my
> >> opinion a typical user thread is created by
> >> pthread_create()/sys_clone(), it is better to distinguish typical user
> >> threads from init and umh.
>
> If we want to emphasize that it is a kernel concept I am happy with
> renaming user_mode_thread to user_mode_task.  That is more accurate.
>
> But all threads from the kernel perspective are tasks.  Further
> all threads have times when they run code in the kernel (aka system
> calls) and times when they run code in userspace.
>
> Linux kernel tasks created with user_mode_thread() are exactly like
> other user mode tasks, and have all treated exactly the same was by the
> system as any the tasks created by pthread_create() and sys_clone().
>
> The only oddity is that there is no user mode code to execute until
> after execve is called.
>
> When running code in the kernel, user space threads never logically
> do not use the user space page tables.
>
> They are different in some significant ways from tasks created with
> kernel_thread().  Tasks created with kernel_thread do not support
> calling execve, among other things.
>
> But deeply and fundamentally I think you are trying to make a
> distinction that is not there.  All user space threads run code
> in the kernel before they run code in userspace.  Most often
> it is from the system calls fork/clone/exec.  For init and umh it
> is effectively a special dedicated system call that includes
> an execve.
>
> Let me ask what difference are you trying to high light that callers
> of user_mode_thread need to be aware of?  What problem in thinking
> do you think that the name user_mode_thread creates?  I am asking
> because I might just be missing your point.
1, My first key point is =E2=80=9Cintuition=E2=80=9D, by intuition
sys_clone()/pthread_create() creates a user thread, but init and umh
are more or less different (special user thread).
2, My second key point is "symmetry", for symmetry =E2=80=98kernel_thread=
=E2=80=99 is
a counterpart of =E2=80=98user_thread=E2=80=99, while =E2=80=98user_mode_th=
read=E2=80=99 is a
counterpart of =E2=80=98kernel_mode_thread=E2=80=99. If we keep the =E2=80=
=98kernel_thread=E2=80=99
name, then we can only rename the =E2=80=98user_mode_thread=E2=80=99. As di=
scussed
before, init and umh are user threads, but they are special user
threads run in kernel mode before kernel_execve, so I want to rename
it to =E2=80=98user_thread=E2=80=99 with a 'km' prefix, so =E2=80=98kmuser_=
thread=E2=80=99.

Huacai

>
> Eric
