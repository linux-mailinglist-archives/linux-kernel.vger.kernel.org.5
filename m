Return-Path: <linux-kernel+bounces-17374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49913824C65
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4545284466
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0305C1C10;
	Fri,  5 Jan 2024 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBF7yRuw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557F41845
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 01:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99EDC43391
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 01:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704417213;
	bh=JNDfPZexh2mpstDALLBYw8BPHCxQYcpNV+7M+PjH5wA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iBF7yRuwNQlaWgY0RPrRcLoXwCYqLPNLRnaPLFjATzNyFdsRJuxL04JOKKIukaDa9
	 oXUtKnOe/tfocGxTkcdOalugdg0fsAW4ZfFSVDX3qBnfejnF2WYZmOiIAvNKVGZD0W
	 tPrJW5hrxPWd3mYfJmjsRJuAl+DtwmzpyibPvrnHuIamcmsJfLXRCKb2n9WUAxPet0
	 x1yH6AuPK9hdABqasrNRYOnt5vRNQAvXv9uQJTA6DGjfV2/jw/zqSArv8nswbkgxna
	 rMrKQgyfgcxdJOue/pIXQWqbYIoYAkMJa+T75dn9NQqmlb5xihUxeSNv+Hc0DGGNXX
	 JqO2pVPjB0tpg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso1248837e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 17:13:33 -0800 (PST)
X-Gm-Message-State: AOJu0YzkqUG2DHiJuSPUb+U23+Iw8bO3o30lXChxe5NBcGqsmomZ/HJr
	oPPD6g6Mmj+OAWGs7pDRT25U9fohy8AB/JBkaF8=
X-Google-Smtp-Source: AGHT+IE/jrxQGmIeh5KaMHFfKue85vrbOJV69Mtu9Xvnf4OESV+eW+oa9dW8+AUzAk6imsCthCE4gAtXrS7j2v6+njI=
X-Received: by 2002:ac2:46f8:0:b0:50e:8e76:1323 with SMTP id
 q24-20020ac246f8000000b0050e8e761323mr615716lfo.121.1704417211777; Thu, 04
 Jan 2024 17:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-4-guoren@kernel.org>
 <20240102-81391283df04c430d76c0eb0@orel> <CAJF2gTQ7Oo8UKdPRs0GAAUsh9mDCgGucS8g8kuPzByaWVOtigw@mail.gmail.com>
 <ZZW5Y85OdibCu58h@LeoBras> <CAJF2gTTpi5A+9KP5EyH9qhD_fwuZrWpx6zdCJyG+iv0Ez5q-gw@mail.gmail.com>
 <ZZYsdyKx8kmoDBGB@LeoBras> <CAJF2gTTT8QBEKtKOpriF=c8Y3g5MmM23MZxN7JCa65MbKeKNOQ@mail.gmail.com>
 <ZZa96DEQhYnnGi51@LeoBras>
In-Reply-To: <ZZa96DEQhYnnGi51@LeoBras>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 5 Jan 2024 09:13:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSw6YebWt09W3xsux+rNLeefCwYYhQ5F5jJCWcxRWtK_Q@mail.gmail.com>
Message-ID: <CAJF2gTSw6YebWt09W3xsux+rNLeefCwYYhQ5F5jJCWcxRWtK_Q@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] riscv: xchg: Prefetch the destination word for sc.w
To: Leonardo Bras <leobras@redhat.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	peterz@infradead.org, keescook@chromium.org, wuwei2016@iscas.ac.cn, 
	xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, unicorn_wang@outlook.com, 
	uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, atishp@atishpatra.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 10:17=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Thu, Jan 04, 2024 at 04:14:27PM +0800, Guo Ren wrote:
> > On Thu, Jan 4, 2024 at 11:56=E2=80=AFAM Leonardo Bras <leobras@redhat.c=
om> wrote:
> > >
> > > On Thu, Jan 04, 2024 at 09:24:40AM +0800, Guo Ren wrote:
> > > > On Thu, Jan 4, 2024 at 3:45=E2=80=AFAM Leonardo Bras <leobras@redha=
t.com> wrote:
> > > > >
> > > > > On Wed, Jan 03, 2024 at 02:15:45PM +0800, Guo Ren wrote:
> > > > > > On Tue, Jan 2, 2024 at 7:19=E2=80=AFPM Andrew Jones <ajones@ven=
tanamicro.com> wrote:
> > > > > > >
> > > > > > > On Sun, Dec 31, 2023 at 03:29:53AM -0500, guoren@kernel.org w=
rote:
> > > > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > > > >
> > > > > > > > The cost of changing a cacheline from shared to exclusive s=
tate can be
> > > > > > > > significant, especially when this is triggered by an exclus=
ive store,
> > > > > > > > since it may result in having to retry the transaction.
> > > > > > > >
> > > > > > > > This patch makes use of prefetch.w to prefetch cachelines f=
or write
> > > > > > > > prior to lr/sc loops when using the xchg_small atomic routi=
ne.
> > > > > > > >
> > > > > > > > This patch is inspired by commit: 0ea366f5e1b6 ("arm64: ato=
mics:
> > > > > > > > prefetch the destination word for write prior to stxr").
> > > > > > > >
> > > > > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > > > ---
> > > > > > > >  arch/riscv/include/asm/cmpxchg.h | 4 +++-
> > > > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/=
include/asm/cmpxchg.h
> > > > > > > > index 26cea2395aae..d7b9d7951f08 100644
> > > > > > > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > > > > > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > > > > > > @@ -10,6 +10,7 @@
> > > > > > > >
> > > > > > > >  #include <asm/barrier.h>
> > > > > > > >  #include <asm/fence.h>
> > > > > > > > +#include <asm/processor.h>
> > > > > > > >
> > > > > > > >  #define __arch_xchg_masked(prepend, append, r, p, n)      =
           \
> > > > > > >
> > > > > > > Are you sure this is based on v6.7-rc7? Because I don't see t=
his macro.
> > > > > > Oh, it is based on Leobras' patches. I would remove it in the n=
ext of version.
> > > > >
> > > > > I would say this next :)
> > > > Thx for the grammar correction.
> > >
> > > Oh, I was not intending to correct grammar.
> > > I just meant the next thing I would mention is that it was based on t=
op of
> > > my patchset instead of v6.7-rc7:
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >  ({                                                        =
           \
> > > > > > > > @@ -23,6 +24,7 @@
> > > > > > > >                                                            =
           \
> > > > > > > >       __asm__ __volatile__ (                               =
           \
> > > > > > > >              prepend                                       =
           \
> > > > > > > > +            PREFETCHW_ASM(%5)                             =
           \
> > > > > > > >              "0:      lr.w %0, %2\n"                       =
           \
> > > > > > > >              "        and  %1, %0, %z4\n"                  =
           \
> > > > > > > >              "        or   %1, %1, %z3\n"                  =
           \
> > > > > > > > @@ -30,7 +32,7 @@
> > > > > > > >              "        bnez %1, 0b\n"                       =
           \
> > > > > > > >              append                                        =
           \
> > > > > > > >              : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(__=
ptr32b))       \
> > > > > > > > -            : "rJ" (__newx), "rJ" (~__mask)               =
           \
> > > > > > > > +            : "rJ" (__newx), "rJ" (~__mask), "rJ" (__ptr32=
b)         \
> > > > > > >
> > > > > > > I'm pretty sure we don't want to allow the J constraint for _=
_ptr32b.
> > > > > > >
> > > > > > > >              : "memory");                                  =
           \
> > > > > > > >                                                            =
           \
> > > > > > > >       r =3D (__typeof__(*(p)))((__retx & __mask) >> __s);  =
             \
> > > > > > > > --
> > > > > > > > 2.40.1
> > > > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > > drew
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Best Regards
> > > > > >  Guo Ren
> > > > > >
> > > > >
> > > > > Nice patch :)
> > > > > Any reason it's not needed in __arch_cmpxchg_masked(), and __arch=
_cmpxchg() ?
> > > > CAS is a conditional AMO, unlike xchg (Stand AMO). Arm64 is wrong, =
or
> > > > they have a problem with the hardware.
> > >
> > > Sorry, I was unable to fully understand the reason here.
> > >
> > > You suggest that the PREFETCH.W was inserted on xchg_masked because i=
t will
> > > always switch the variable (no compare, blind CAS), but not on cmpxch=
g.
> > >
> > > Is this because cmpxchg will depend on a compare, and thus it does no=
t
> > > garantee a write? so it would be unwise to always prefetch cacheline
> > Yes, it has a comparison, so a store may not exist there.
> >
> > > exclusiveness for this cpu, where shared state would be enough.
> > > Is that correct?
> > Yes, exclusiveness would invalidate other harts' cache lines.
>
> I see.
>
> I recall a previous discussion on computer arch which stated that any LR
> would require to get a cacheline in exclusive state for lr/sc to work, bu=
t
> I went through the RISC-V lr/sc documentation and could not find any info
> about its cacheline behavior.

No, lr couldn't get a cacheline in exclusive, that would break the ISA desi=
gn.
Think about "lr + wfe" pair.

>
> If this stands correct, the PREFETCH.W could be useful before every lr,
> right?
> (maybe that's the case for arm64 that you mentioned before)
The arm64 "lr + sc" cmpxchg version is not good, don't follow that.
They are moving to the LSE's cas instruction.


>
> Thanks!
> Leo
>
> >
> > >
> > > Thanks!
> > > Leo
> > >
> > >
> > > >
> > > > >
> > > > > Thanks!
> > > > > Leo
> > > > >
> > > >
> > > >
> > > > --
> > > > Best Regards
> > > >  Guo Ren
> > > >
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
>


--=20
Best Regards
 Guo Ren

