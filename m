Return-Path: <linux-kernel+bounces-12401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E5381F449
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF2C1C216FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2CB136F;
	Thu, 28 Dec 2023 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jHDaDhd0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E3410E5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e81761e43so2277746e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 19:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703733070; x=1704337870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tojWnjZoOPArkc/1ypwctKQDulVjKNakYJmlzZOcB4=;
        b=jHDaDhd0BO4rf2yQXT8g07bMIxpfwvF0DJbfu+/Oafz3odBqKd5LdhZgXzdXyIBch5
         o8K/PGJysWVttf0cz/kcRdh0EQBvrdI8rxUSrw8FRLfkN2FETZqrxgjSNNjtaQkodlKE
         DIqaq5kZmW8ulCAHgnOlh/eLVRgYDHc9FQgCOmcE6IR/AeujxE8M+QGL9AJBrE5yWi+s
         RBcQKNk6QUSRCsWze7Y1svVIF4rZNgiT0KGreHtd686o+9PGubC21n03zvecT7De68Q8
         g30j5oOyzG87MP79+Z/2HElOGoOHHt4QmxTohX46XPdkCMHiIPYXlE6JiUSuvmTyjqsz
         IxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703733070; x=1704337870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tojWnjZoOPArkc/1ypwctKQDulVjKNakYJmlzZOcB4=;
        b=EH4P9bON8SY9JyU00ShYvjy7C+i9jbwiGyRh1A/8uZy2h87eeLER2d34Z/yIKm8TIq
         a2c2VIGQcPHyn2B2wWd+6dYvtzT8uZv9sRJDgVtNZr+kCKULPGnc2Ixu+aZgF8f7TZxY
         cfimVGXN8LGdRc7CwR6sNv1w1EFJ2BFP8qhrRWgBuiOpVX1rYP6gDiSS07hxrZ2zSwVK
         FD7XoiHau9LAm3k2TRgwo4owv6Pktnf6z0V3yrMfHLFhuPC+vRBe8ktAMgw2V7Va4YXl
         lHP8yV0GO/vYhluNa5UITdQICrFdTlDNI+RxXhDCPiIzE0hV55h+BPk80Tv18hzxLrtK
         jzgw==
X-Gm-Message-State: AOJu0YzCeDnX+b/bfLD4Me1QJ+V1LZboTc2js6SuC3P3L/itb/yWOVmL
	pT6dENt2aeGNX9jWQOlk5EOlQqU2tG8TpxDyMjZqlZLnjoMyIQ==
X-Google-Smtp-Source: AGHT+IG9tZ2wg3iQJxAba0ROVCc95Rf84jfl7lOU9lpNNGSZonGS7SyM+Cc8rxSMb7fcGUKgiCL1TrxxQvgJyBtlTKA=
X-Received: by 2002:ac2:5504:0:b0:50e:6a21:f9b2 with SMTP id
 j4-20020ac25504000000b0050e6a21f9b2mr3399360lfk.55.1703733069697; Wed, 27 Dec
 2023 19:11:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222074605.452452-1-leobras@redhat.com> <20231222074605.452452-4-leobras@redhat.com>
 <CABgGipXLe7MxP076CJ=BLAaChAQug5X7qkNxxm9eEnyy92nEJQ@mail.gmail.com> <CAJ6HWG4Pe0co91-tRpV-gKoVUJkobB=uz8J-pjTvyX=Ed49u_w@mail.gmail.com>
In-Reply-To: <CAJ6HWG4Pe0co91-tRpV-gKoVUJkobB=uz8J-pjTvyX=Ed49u_w@mail.gmail.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 28 Dec 2023 11:10:58 +0800
Message-ID: <CABgGipU_xLWMFy-fwRqVRAC4_s=PH9cXq9-CGNHgQhOGOB+rdQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] riscv: Introduce is_compat_thread() into compat.h
To: Leonardo Bras Soares Passos <leobras@redhat.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Greg Ungerer <gerg@kernel.org>, 
	Vincent Chen <vincent.chen@sifive.com>, Xiao Wang <xiao.w.wang@intel.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	David Hildenbrand <david@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Qinglin Pan <panqinglin2020@iscas.ac.cn>, Greentime Hu <greentime.hu@sifive.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 3:25=E2=80=AFAM Leonardo Bras Soares Passos
<leobras@redhat.com> wrote:
>
> On Sat, Dec 23, 2023 at 1:26=E2=80=AFAM Andy Chiu <andy.chiu@sifive.com> =
wrote:
> >
> > On Fri, Dec 22, 2023 at 3:46=E2=80=AFPM Leonardo Bras <leobras@redhat.c=
om> wrote:
> > >
> > > task_user_regset_view() makes use of a function very similar to
> > > is_compat_task(), but pointing to a any thread.
> > >
> > > In arm64 asm/compat.h there is a function very similar to that:
> > > is_compat_thread(struct thread_info *thread)
> > >
> > > Copy this function to riscv asm/compat.h and make use of it into
> > > task_user_regset_view().
> > >
> > > Also, introduce a compile-time test for CONFIG_COMPAT and simplify th=
e
> > > function code by removing the #ifdef.
> > >
> > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > ---
> > >  arch/riscv/include/asm/compat.h | 8 ++++++++
> > >  arch/riscv/kernel/ptrace.c      | 6 +++---
> > >  2 files changed, 11 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm=
/compat.h
> > > index 91517b51b8e27..da4b28cd01a95 100644
> > > --- a/arch/riscv/include/asm/compat.h
> > > +++ b/arch/riscv/include/asm/compat.h
> > > @@ -20,6 +20,14 @@ static inline int is_compat_task(void)
> > >         return test_thread_flag(TIF_32BIT);
> > >  }
> > >
> > > +static inline int is_compat_thread(struct thread_info *thread)
> > > +{
> > > +       if (!IS_ENABLED(CONFIG_COMPAT))
> > > +               return 0;
> > > +
> > > +       return test_ti_thread_flag(thread, TIF_32BIT);
> > > +}
> > > +
> >
> > Does it make sense to use a #ifdef CONFIG_COMPAT clause to group
> > is_compat_thread() and is_compat_flag()? For example,
>
> Hello Andy,
>
> Sure, it does make sense.
>
> But I honestly think that using IS_ENABLED() instead of #ifdef +
> multiple same-named functions works better for code reading, at least
> for small functions such as these.
>
> Does this make sense?
>
> Thanks for reviewing!
> Leo

Hi, yes!

It makes sense to me.

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>

Thanks,
Andy

>
>
> >
> > #ifdef CONFIG_COMPAT
> > static inline int is_compat_thread(struct thread_info *thread)
> > {
> >  return test_ti_thread_flag(thread, TIF_32BIT);
> > }
> > static inline int is_compat_task(void)
> > {
> >  return is_compat_thread(current);
> > }
> > #else
> > static inline int is_compat_thread(struct thread_info *thread) { return=
 0; }
> > static inline int is_compat_task(void) { return 0; }
> > #endif
> >
> > >  struct compat_user_regs_struct {
> > >         compat_ulong_t pc;
> > >         compat_ulong_t ra;
> > > diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> > > index 2afe460de16a6..f362832123616 100644
> > > --- a/arch/riscv/kernel/ptrace.c
> > > +++ b/arch/riscv/kernel/ptrace.c
> > > @@ -374,14 +374,14 @@ long compat_arch_ptrace(struct task_struct *chi=
ld, compat_long_t request,
> > >
> > >         return ret;
> > >  }
> > > +#else
> > > +static const struct user_regset_view compat_riscv_user_native_view =
=3D {};
> > >  #endif /* CONFIG_COMPAT */
> > >
> > >  const struct user_regset_view *task_user_regset_view(struct task_str=
uct *task)
> > >  {
> > > -#ifdef CONFIG_COMPAT
> > > -       if (test_tsk_thread_flag(task, TIF_32BIT))
> > > +       if (is_compat_thread(&task->thread_info))
> > >                 return &compat_riscv_user_native_view;
> > >         else
> > > -#endif
> > >                 return &riscv_user_native_view;
> > >  }
> > > --
> > > 2.43.0
> > >
> >
>

