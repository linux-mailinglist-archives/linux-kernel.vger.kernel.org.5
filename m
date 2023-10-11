Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABD57C4BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345042AbjJKH1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344888AbjJKH1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:27:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69638AC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:27:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-534659061afso10724744a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697009256; x=1697614056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQq/ChY71TVgF5NA2DHBJ9cqMTnGx9eF+5R9iQkkS5E=;
        b=TOIuiTAABMMIT1DI1tDpk2PPC3aeESIFE2/zN9OLEEaI4ZXNnEIYOrwhNsHr7YYtrn
         1dNJf+UryTOKM1Kyg784yV9fvzEXDiXT6qYYU75UxNr+rPQqeoq85HwUU1QdCNqHoYqm
         kg4BZX8Ez5BUVEdWSjv1sSibDX5x4QiXukCZ3tMoE6OQPewykalf2JuE6Gpad55c+Yf1
         nAbHDSLhC99JvvMUw4BJ0A5+diXC1OOq7v3LLV40/gmi9RwGZ7N639HlfdCraSgCPYnt
         LRICBH6cJEMVSjr6eVlSWMeaRMATq0jtwiyTKvVuDwVYHZ52TJSOlSZtunlaLv5tuCxk
         OmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697009256; x=1697614056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQq/ChY71TVgF5NA2DHBJ9cqMTnGx9eF+5R9iQkkS5E=;
        b=P5FAgkFVmDxvARlAPr7RCN6Xh1oC0ZgvMxgvioUEF8tV7PXemf/PaijXXJr2ZGiyOS
         l4IVJ1jMAaNkqtuppCVpmF3xo/xalkr5vF0aIttHZ5IDfAqpRIBXAzVqqJqq8bDFW6yy
         liVtmznQB4h6/FhChx9CvHDZXHVy0q5f1sg1+YjeiQxiW6FSUBHkhHU77IMY1ecDqGII
         lZHJIOEWaQ287brMoh+N6QIJ1nX2hpgQtjv38AmYSmPHj7iiSjeBeLoUMUk3A69G3XQA
         +EJwnwQGuKOlUIlSkdI7JfOGdzLAnVIx0p/xZQuMKSoUkVD/5HxYSa+eFZ2Fb9BYTtI4
         9IOw==
X-Gm-Message-State: AOJu0YzfbzxIG8vLl1IxkjUSNZPNWCtP8CKUlEnOG8K5VlQim1YvPQ6i
        pvPtEmQw2J6k2w3A0wC+2U9mvev14Ef+I5Cdlvs=
X-Google-Smtp-Source: AGHT+IGNhDiWmyc2Eol6dI8Jhb+U2kNHV4g/ty6jsgqThW2c93ZNFsQPjf/c3OTJjSztOw/6E331fCl1ZzlLHiR9aDw=
X-Received: by 2002:a50:ee8b:0:b0:530:e180:ab9a with SMTP id
 f11-20020a50ee8b000000b00530e180ab9amr18062798edr.3.1697009255571; Wed, 11
 Oct 2023 00:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com> <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
In-Reply-To: <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 11 Oct 2023 09:27:24 +0200
Message-ID: <CAFULd4Z-F0mFov5zhLya=OfPnQx=oOHkyLqs_UVTbQaWjk7AMA@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Tue, Oct 10, 2023 at 8:52=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 10 Oct 2023 at 11:41, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Yes, but does it CSE the load from multiple addresses?
>
> Yes, it should do that just right, because the *asm* itself is
> identical, just the offsets (that gcc then adds separately) would be
> different.

Indeed. To illustrate the question with an example, foo() and bar()
should compile to the same assembly, and there should be only one read
form m resp. n:

--cut here--
__seg_gs int m;

int foo (void)
{
  return m + m;
}

int n;

static inline int get (int *m)
{
  int res;

  asm ("mov %%gs:%1, %0" : "=3Dr"(res) : "m"(*m));
  return res;
}

int bar (void)
{
  return get (&n) + get (&n);
}
--cut here--

And they do:

0000000000000000 <foo>:
  0:   65 8b 05 00 00 00 00    mov    %gs:0x0(%rip),%eax        # 7 <foo+0x=
7>
  7:   01 c0                   add    %eax,%eax
  9:   c3                      retq

0000000000000010 <bar>:
 10:   65 8b 05 00 00 00 00    mov    %gs:0x0(%rip),%eax        # 17 <bar+0=
x7>
 17:   01 c0                   add    %eax,%eax
 19:   c3                      retq

>
> This is not unlike how we depend on gcc CSE'ing the "current" part
> when doing multiple accesses of different members off that:
>
>     static __always_inline struct task_struct *get_current(void)
>     {
>         return this_cpu_read_stable(pcpu_hot.current_task);
>     }
>
> with this_cpu_read_stable() being an inline asm that lacks the memory
> component (the same way the fallback hides it by just using
> "%%gs:this_cpu_off" directly inside the asm, instead of exposing it as
> a memory access to gcc).
>
> Of course, I think that with the "__seg_gs" patches, we *could* expose
> the "%%gs:this_cpu_off" part to gcc, since gcc hopefully then can do
> the alias analysis on that side and see that it can CSE the thing
> anyway.
>
> That might be a better choice than __FORCE_ORDER, in fact.
>
> IOW, something like
>
>     static __always_inline unsigned long new_cpu_offset(void)
>     {
>         unsigned long res;
>         asm(ALTERNATIVE(
>                         "movq " __percpu_arg(1) ",%0",
>                         "rdgsbase %0",
>                         X86_FEATURE_FSGSBASE)
>                 : "=3Dr" (res)
>                 : "m" (this_cpu_off));
>         return res;
>     }
>
> would presumably work together with your __seg_gs stuff.

I have zero experience with rdgsbase insn, but the above is not
dependent on __seg_gs, so (the movq part at least) would also work in
the current mainline. To work together with __seg_gs stuff,
this_cpu_offset should be enclosed in __my_cpu_var. Also, if rdgsbase
is substituted with rdfsbase, it will also work for 32-bit targets.

Uros.

> UNTESTED!!
>
>             Linus
