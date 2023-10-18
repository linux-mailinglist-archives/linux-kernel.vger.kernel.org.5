Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6043B7CDB60
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjJRMPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjJRMPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:15:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DAF98
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:15:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso11882478a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631300; x=1698236100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlmUOMPIHXCoA1mbbwcwugrmWOtlaocEiaphBwyu/sU=;
        b=Jb1bmiTySefYgjyJybzoZPzTFMI+nOgWLruOyuOQKcilMaJpbB6Vwa6tTNyiN8PT13
         huhFy9JMkJNzgRB+uN9aAk6c+GabE2aKRn55VDPIzXmGxANr8nPLwaM9yYnX+RgiWvXT
         OYgpsYRnERtagi4FriIIkaLvd8B8vSkczYjtuQqmcmX3KYyyxxgbSrGwAW7MwR3aVOrc
         AsP2d1XDAuC1tDKVLl33XZyy8QJwAxUwV5tWER6jvyBhLgSJrd+tUidBo1GigagIrhIC
         XpKiKei0RLEr5zM+3Zc+ddXhgwVm5QSKOq4WyOeUjkNa+MWytvzNSAHNHOsCsF162OfY
         jy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631300; x=1698236100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlmUOMPIHXCoA1mbbwcwugrmWOtlaocEiaphBwyu/sU=;
        b=tLEZKVMwZIYhqHtTsKfRQ8FwMdYj0G4wRfBHQhEZl2aKRntg6jTQKZtrTAveScJmgl
         Pi9GEMzTRmXlm8FFrOg13rP/KLnxOC3CIwU0d9IVoqaEVASw4HvZgflXMoPjPd/5YiNl
         wzFYdSJrK09aShIafyVaQOIF8BUqxJIF4vuaQgNTOGEFNQZWpWIvF8WffryMeBcW117s
         e4RCxA93iQmPf3AP68OFZkKvyx8kLVUW1cxBM2g+PQUnDkGvOANgm0E+QY67S8VBuG6A
         CEUVoqhcc/vTYw3vTs91bK6j8opDICWw7b/5aVolxedLjV+uRSIa5+MQmmTBYtJCIRTj
         EtwQ==
X-Gm-Message-State: AOJu0YypRwvSv1Rr3+XxkIbWjL73VT2scPSiQsxSAFwg8ReQV8XHwRIq
        j8n5Z8vJOrQ6/U7rZKhg/e77Bn/mUrHr9y06EUg=
X-Google-Smtp-Source: AGHT+IHglPtl0Z58QsZGIkpJeJo79G/F2ZYQ/4YV7AbtqCk3DDYTIyoGPxGLoQs+euqWgyKqR/akabh+1HE00qs3E48=
X-Received: by 2002:a50:d709:0:b0:53e:1825:be92 with SMTP id
 t9-20020a50d709000000b0053e1825be92mr3567800edi.31.1697631299479; Wed, 18 Oct
 2023 05:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com> <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com> <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
 <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
 <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com> <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com>
In-Reply-To: <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Oct 2023 14:14:47 +0200
Message-ID: <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Nadav Amit <namit@vmware.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Wed, Oct 18, 2023 at 12:54=E2=80=AFPM Nadav Amit <namit@vmware.com> wrot=
e:
>
>
>
> > On Oct 18, 2023, at 12:04 PM, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Solved.
> >
> > All that is needed is to patch cpu_init() from
> > arch/x86/kernel/cpu/common.c with:
> >
> > --cut here--
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.=
c
> > index b14fc8c1c953..61b6fcdf6937 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -2228,7 +2232,7 @@ void cpu_init_exception_handling(void)
> > */
> > void cpu_init(void)
> > {
> > -       struct task_struct *cur =3D current;
> > +       struct task_struct *cur =3D this_cpu_read_stable(pcpu_hot.curre=
nt_task);
> >       int cpu =3D raw_smp_processor_id();
>
> Thanks for solving that, and sorry that I missed it.
>
> The reason I didn=E2=80=99t encounter it before is that in my original pa=
tch I created
> a new compilation unit which only defined the alias.
>
> Since there might be additional problems (any =E2=80=9Ccurrent=E2=80=9D u=
se in common.c is
> dangerous, even in included files), I think that while there may be addit=
ional
> solutions, defining the alias in a separate compilation unit - as I did b=
efore -
> is the safest.

What happens here can be illustrated with the following testcase:

--cut here--
int init_mm;

struct task_struct
{
  int *active_mm;
};

struct task_struct init_task;

struct pcpu_hot
{
  struct task_struct *current_task;
};

struct pcpu_hot pcpu_hot =3D { .current_task =3D &init_task };

extern const struct pcpu_hot __seg_gs const_pcpu_hot
__attribute__((alias("pcpu_hot")));

void foo (void)
{
  struct task_struct *cur =3D const_pcpu_hot.current_task;

  cur->active_mm =3D &init_mm;
}
--cut here--

gcc -O2 -S:

foo:
       movq    $init_mm, init_task(%rip)
       ret

Here, gcc optimizes the access to generic address space, which is
allowed to, since *we set the alias to pcpu_hot*, which is in the
generic address space. The compiler doesn't care that we actually
want:

foo:
       movq    %gs:const_pcpu_hot(%rip), %rax
       movq    $init_mm, (%rax)

So yes, to prevent the optimization, we have to hide the alias in another T=
U.

BTW: Clang creates:

foo:
       movq    %gs:pcpu_hot(%rip), %rax
       movq    $init_mm, (%rax)
       retq

It is a bit more conservative and retains the address space of the
aliasing symbol.

Looks like another case of underspecified functionality where both
compilers differ. Luckily, both DTRT when aliases are hidden in
another TU.

Uros.
