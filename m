Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9508279E833
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbjIMMkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjIMMkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:40:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E6619AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:40:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF4FC433CD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694608810;
        bh=4V8qeyNYyKzAHbUxZffZtlUMKemRi78OFAMYUMKMJ04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Es4rxKw9xoWiu5Ku0pFilVXDAImSINpJibTZOdygZDvJYhrPP6aSUNnStcjHMtVGY
         BiODUMdD0BQmTEZVQVvN7SnSetss4WxX7nT60uPobHJADY0BiHv+dzDeMONmFfy6xH
         hxqZQCSAuhNydGWqEFTAGGUoUcmyl2xx6bzl8qITq5e1AhMjA/5CSQ6DFSQ6lLOkio
         97mOiHby49qXqkZfoArNWya8nibFITeb6f2wZqBr7f5LOwP4AEuUS+GUELp4ej2+Xd
         GgGPcIwPNZ/rsYUGFWk3ZwWQGrV/OrcJxzENg2YCU2VwVrme0wQA83UrNr/EVdYvix
         l66+138v5LMdA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2bfb0a2682fso20718541fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:40:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YxxsHHxayE0U4o/s57JtkVZrsRRHMb5zx3+8yX5YAbT6yzm4Xdk
        jQjjzZhPMZfqaJsu2Gechi1oXVqkvLsRdHPDJzo=
X-Google-Smtp-Source: AGHT+IEJxXX/Kw2Y5HOfmi3uSob/iMeypKr3gOgjBOZNkR7wofcsEONVEF/8uDb+llAqwIqBHL4rO3f95X+tlukee/s=
X-Received: by 2002:a2e:928a:0:b0:2b9:ecab:d924 with SMTP id
 d10-20020a2e928a000000b002b9ecabd924mr2055184ljh.18.1694608808577; Wed, 13
 Sep 2023 05:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230615121016.3731983-1-chenhuacai@loongson.cn>
 <CAAhV-H49AyrG-sH2SXLNg_cX-Wv8vS4Qno_2N4v6ccGGciv-+A@mail.gmail.com>
 <ZJ9kWqhRCWkLcYyv@bombadil.infradead.org> <CAAhV-H7qk8wSFt=ZMUSUt4cAmH+-5AsGqszXNW9w+u6Y8vDN+A@mail.gmail.com>
 <CAAhV-H7RgkZJ2hfmNmJXKqcYeE1q11V4-2Ni0j-FLJ0b5fc=Sg@mail.gmail.com>
 <CAAhV-H5pwHQTQ6wGXC2NELHmC4JM8rQUViR3RJj8hQLBygb00w@mail.gmail.com>
 <87cyyo9moz.fsf@email.froward.int.ebiederm.org> <CAAhV-H7D85NTS+8VP6ELiiMVrFkarhjBFbHERLbA9azaK9=XcQ@mail.gmail.com>
 <87a5tr1eri.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87a5tr1eri.fsf@email.froward.int.ebiederm.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 13 Sep 2023 20:39:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5dZGBP51_TZbewCgsXs8XyCQsnus9gQde1SayP=zcHUQ@mail.gmail.com>
Message-ID: <CAAhV-H5dZGBP51_TZbewCgsXs8XyCQsnus9gQde1SayP=zcHUQ@mail.gmail.com>
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

On Wed, Sep 13, 2023 at 1:30=E2=80=AFAM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> Huacai Chen <chenhuacai@kernel.org> writes:
>
> > Hi, Eric,
> >
> > On Tue, Sep 12, 2023 at 9:59=E2=80=AFAM Eric W. Biederman <ebiederm@xmi=
ssion.com> wrote:
> >>
> >> Huacai Chen <chenhuacai@kernel.org> writes:
> >>
> >> > Hi, all,
> >> >
> >> > Friendly ping again?
> >> >
> >> >
> >> > Huacai
> >> >
> >> > On Sun, Jul 23, 2023 at 10:13=E2=80=AFPM Huacai Chen <chenhuacai@ker=
nel.org> wrote:
> >> >>
> >> >> Hi, Eric,
> >> >>
> >> >> On Tue, Jul 18, 2023 at 8:43=E2=80=AFPM Huacai Chen <chenhuacai@ker=
nel.org> wrote:
> >> >> >
> >> >> > Hi, Luis,
> >> >> >
> >> >> > On Sat, Jul 1, 2023 at 7:25=E2=80=AFAM Luis Chamberlain <mcgrof@k=
ernel.org> wrote:
> >> >> > >
> >> >> > > On Sun, Jun 25, 2023 at 04:55:33PM +0800, Huacai Chen wrote:
> >> >> > > > Friendly ping?
> >> >> > >
> >> >> > > You want to cc the folks who Nacked your patch. Until then, thi=
s
> >> >> > > probably can't go further.
> >> >> > Thank you very much. Eric and Andrew are already in the CC list, =
so
> >> >> > add Thomas now.
> >> >> >
> >> >> > My brain is a little old-fashioned so I insisted that "a thread
> >> >> > without mm_struct should be a kernel thread" in the previous patc=
h.
> >> >> > Unfortunately this makes Eric and Thomas unhappy, I'm very sorry =
for
> >> >> > that.
> >> >> >
> >> >> > During the discussion of the previous patch I know I made some
> >> >> > mistakes about some basic concepts, but I also found the name
> >> >> > "user_mode_thread()" is somewhat confusing. I think rename it to
> >> >> > kmuser_thread() is better, because:
> >> >> > 1, it identify init and umh as user threads;
> >> >> > 2, it points out that init and umh are special user threads that =
run
> >> >> > in kernel mode before loading a user program.
> >> >> >
> >> >> > Sorry for my rudeness again.
> >> >> Excuse me, but could you please tell me what your opinion is. In my
> >> >> opinion a typical user thread is created by
> >> >> pthread_create()/sys_clone(), it is better to distinguish typical u=
ser
> >> >> threads from init and umh.
> >>
> >> If we want to emphasize that it is a kernel concept I am happy with
> >> renaming user_mode_thread to user_mode_task.  That is more accurate.
> >>
> >> But all threads from the kernel perspective are tasks.  Further
> >> all threads have times when they run code in the kernel (aka system
> >> calls) and times when they run code in userspace.
> >>
> >> Linux kernel tasks created with user_mode_thread() are exactly like
> >> other user mode tasks, and have all treated exactly the same was by th=
e
> >> system as any the tasks created by pthread_create() and sys_clone().
> >>
> >> The only oddity is that there is no user mode code to execute until
> >> after execve is called.
> >>
> >> When running code in the kernel, user space threads never logically
> >> do not use the user space page tables.
> >>
> >> They are different in some significant ways from tasks created with
> >> kernel_thread().  Tasks created with kernel_thread do not support
> >> calling execve, among other things.
> >>
> >> But deeply and fundamentally I think you are trying to make a
> >> distinction that is not there.  All user space threads run code
> >> in the kernel before they run code in userspace.  Most often
> >> it is from the system calls fork/clone/exec.  For init and umh it
> >> is effectively a special dedicated system call that includes
> >> an execve.
> >>
> >> Let me ask what difference are you trying to high light that callers
> >> of user_mode_thread need to be aware of?  What problem in thinking
> >> do you think that the name user_mode_thread creates?  I am asking
> >> because I might just be missing your point.
> > 1, My first key point is =E2=80=9Cintuition=E2=80=9D, by intuition
> > sys_clone()/pthread_create() creates a user thread, but init and umh
> > are more or less different (special user thread).
>
> My point is the entire point of the name is to point out your intuition
> is probably wrong in this context.
In another thread I had said that init and umh are special kernel
threads. But after your patient explanation, I admit init and umh are
user threads now. However I still don't think they are completely the
same as pthread_create()/sys_clone() so I say they are special user
threads. kernel_execve() makes init and umh user processes, but the
call to kernel_execve() is the internal logic of the created threads,
this logic has no direct relationship with 'user_mode_thread()'. And
it is also difficult for me to consider  'user_mode_thread()' as "a
special syscall", because syscall comes from userspace...

>
> > 2, My second key point is "symmetry", for symmetry =E2=80=98kernel_thre=
ad=E2=80=99 is
> > a counterpart of =E2=80=98user_thread=E2=80=99, while =E2=80=98user_mod=
e_thread=E2=80=99 is a
> > counterpart of =E2=80=98kernel_mode_thread=E2=80=99. If we keep the =E2=
=80=98kernel_thread=E2=80=99
> > name, then we can only rename the =E2=80=98user_mode_thread=E2=80=99.
>
> Frankly they could just as well be named user_mode_process,
> and user_mode_task.  All are equally accurate.
For me, 'thread' in the name has no problem. because 'task' is a
general concept, 'process' is a 'task' with independent address space,
and 'thread' is a 'task' with shared address space. I want to remove
'mode' because I like symmetry, and Andrew also thinks that 'mode' is
superfluous. Again, I admit init and umh are user threads, but they
are special so need a modifier. This modifier can be 'km' (stands for
'kernel mode') or 'kc' (stands for 'kernel created').


Huacai

>
> kernel_thread is a bit different.  Strictly speaking they are all
> processes that share the same address space.  But because they
> all share the same address space and userspace can't touch them
> thread is a perfectly adequate term.
>
> > As discussed
> > before, init and umh are user threads, but they are special user
> > threads run in kernel mode before kernel_execve, so I want to rename
> > it to =E2=80=98user_thread=E2=80=99 with a 'km' prefix, so =E2=80=98kmu=
ser_thread=E2=80=99.
>
> My deep and fundamental question to you is what technically makes umh
> and init special?
>
> What are you trying to point out to the rest of us with an improved
> name?
>
> I want to point out that people need to treat umh and init as user space
> processes, and very much not as kernel threads.  That none of the
> kernel_thread infrastructure works on them.
>
> Eric
