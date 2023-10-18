Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002D57CE5E4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjJRSIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJRSIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:08:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4F8B8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:08:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so12069075a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697652513; x=1698257313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMlAH6aGo5Pg/afWqCBzzwAyO5+Bhz51dc20z6ZimfQ=;
        b=nIrsB2izxcIZIwzrssM5o8wlhhFZVKARvua1fR6flKAdkelc32j95c6RBi2FEerapf
         xL8dAjnOgDhFcAi0Jl0XeMzZc6sYEWkAw4lgFR3ejIy+AmmoF/0//1OVm7a+2VJBEBAW
         +qXghmKTTw27j37sL0IDWhlk7BMtb8daSGNXHovB79WeBY//9rMiTcd1VD4A+2aGzx3u
         RXS+/XlVj4qdJWS0wkjWiCQu7eoW4Gjy67p55bcBERCgTKzbzFQuAqeV+mOIxo38dNeg
         epiBtslpypj07OpNYoIGyOia8i/Yc9ZSYKbhLM/DuZXrmsGbj1fufwbd5LFl/oOo7Q5i
         IoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652513; x=1698257313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMlAH6aGo5Pg/afWqCBzzwAyO5+Bhz51dc20z6ZimfQ=;
        b=xUUTh1kVk7xcLzh3TtU7kv/4m2aCznnRBefvGHFBSI9V0G9AAUFbs9IwyYZrAX5XvU
         K2+LvZ61Tt0JsuV3mBif7UnQ9OfkGbfonccX370HlKaMuzIbuqKg9pFHcmw0sUCmJcnw
         docbgRtXLSl2B0wgdi3YS+QKz3TsV/WsrrvJrntmzXJ8a9mNBScgB5gyD7FEZlXJCXYi
         H98fDBL8ZyWnS9zeX2LvGTR07H26Q65EERRKP1ehPhY4zYd6NRw0x1QlWGH9h8D+3EES
         KRG4Kj546neGt0jS0AG+2QfIKtm3ZNUq2asK1VIBeElwZgB/bKi6GQxDv1FzF4KHFTbg
         MddQ==
X-Gm-Message-State: AOJu0Yx4V7tb60F2Z7Ei9VdDAtkmwH6JS54P90N+1hLNOFVsJon0zHIc
        D/FtBRUNX6T7OGdwO211a7vbt6ccM3Y3nlnmhP0=
X-Google-Smtp-Source: AGHT+IF3cRkIwh4BxhQVKuVra4hDlZVYphL1nXFW83x5EKZpr8CDkZdsxSWecqEfmSfjMwQ061Yhw/H0atac8AD1A3Y=
X-Received: by 2002:a05:6402:510d:b0:53d:e8a7:57a6 with SMTP id
 m13-20020a056402510d00b0053de8a757a6mr5185458edd.34.1697652512998; Wed, 18
 Oct 2023 11:08:32 -0700 (PDT)
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
 <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
 <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com> <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
 <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com> <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
 <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com> <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
In-Reply-To: <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Oct 2023 20:08:21 +0200
Message-ID: <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <namit@vmware.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 6:26=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 18 Oct 2023 at 09:03, Nadav Amit <namit@vmware.com> wrote:
> >
> > Having said that, I am not sure what other usages you have in mind.
> > =E2=80=9Ccurrent=E2=80=9D is a pretty obvious straight forward case wit=
h considerable
> > impact on code generation. There may be additional variables, but it is
> > likely that there would be more functions/TU in which they would not be
> > constant and would require more refined techniques to avoid mistakes
> > such as the use of stale cached values.
>
> Yeah, I don't think there really are other cases.
>
> We do have things that could be considered stable (like
> "smp_processor_id()" which is stable as long as preemption or
> migration is disabled (or it's in an irq-off section).
>
> And it might be lovely to optimize those too, *BUT* that would require
> that there be a barrier against that optimization that works.

But loads from non-const memory work like the above.

Please consider:

--cut here--
extern __seg_gs int m;

int foo (void)
{
  int r;

  r =3D m;
  r +=3D m;
  asm volatile ("" ::: "memory");
  r +=3D m;

  return r;
}

int bar (void)
{
  int r;

  r =3D m;
  r +=3D m;
  r +=3D m;

  return r;
}
--cut here--

gcc -O2:

foo:
       movl    %gs:m(%rip), %eax
       addl    %eax, %eax
       addl    %gs:m(%rip), %eax
       ret

bar:
       movl    %gs:m(%rip), %eax
       leal    (%rax,%rax,2), %eax
       ret

Please note the __barrier(), implemented with asm volatile.

> And if there is anything that this thread has made clear, it's that
> the whole 'load from a constant section' doesn't seem to have any sane
> barriers.
>
> So while the CSE for inline asm statements is a bit too weak with that
> whole "only CSE within a basic block" thing, the CSE of "load a
> constant value from memory" is too *strong*, in that we don't seem to
> have _any_ sane way to say "now you need to reload".

We can use alias to __seg_gs non-const memory, so the value can be
accessed without asm. __barrier() will then force reload. Please note
that any memory clobber, hidden inside asm will also force reload.

> The traditional way we've done that is with our "barrier()" macro,
> which does the whole inline asm with a memory clobber, but even that
> doesn't act as a barrier for gcc optimizing the constant load.
>
> Which means that while we'd probably love for the compiere to optimize
> smp_processor_id() a bit more, we can't use the 'stable memory
> location' trick for it.

We should get rid of asm statements, and as shown above, __barrier()
will do the trick.

> Because I can't think of anything but 'current' that would be _that_
> stable as far as C code is concerned.

Uros.
