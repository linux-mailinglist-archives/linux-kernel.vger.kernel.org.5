Return-Path: <linux-kernel+bounces-11653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E7381E96F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62C61F21171
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6EA4C80;
	Tue, 26 Dec 2023 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/mobnnk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5B23C6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703618709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iXTdOONRHny7xEnEy9yWubjQEcQu4RJR3ICJLroNr8=;
	b=D/mobnnksQabxvz4SfP92dBqeVZWdDRhCv/PBYygMmPhARlYENlOYQChewHlKP+ycOA5aL
	+nJyRnKWoRaVe5jxlpj9Zf97dvaWiRYH7XKGbMl136ScQzEiBIyAwpLhUIgwSReoPivJxh
	C+Z04IwLsz8ovoqgdbneh9o5mZOOMYs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-qF8tCRmcNxymqOUlCm-9WQ-1; Tue, 26 Dec 2023 14:25:07 -0500
X-MC-Unique: qF8tCRmcNxymqOUlCm-9WQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-427be172911so64798721cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:25:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618707; x=1704223507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iXTdOONRHny7xEnEy9yWubjQEcQu4RJR3ICJLroNr8=;
        b=KsPcXzDJBOQW0+jevylOtgN1Rw2DeGl6bHzekMKljKdPEug3fRHNBBiYWYIcdavFge
         lYHOLzjAl8cbywsY9E0eYOqmSf76Fj/2wr9a0G6jv6cZ8Er8/1JAqopC5CoP9m+mO8h3
         45nW/YzsOBcDsRotCC1hKHVTQYoRmisESuJ4Nn8PThEeKoo3hYSpHxyHUaGyss8RLxgK
         wlyRnnHC5jENID8O78SROo8UMISGzo1p7lpfWY5hFl42nTVHeJM74ROm8f/goInNABin
         gMqAjWJBudZISKKgATBLTDXX5Pafg5UMWYnxOMgovkmqvdMy0vtHAvXUPDKFH8JkbnGt
         7nLw==
X-Gm-Message-State: AOJu0YxLb6ZFFEZTstI+1mf9nSPZpKtcqYmYANfN3miiC6wTr4qhtnjp
	wwq7+01vw0D3BbT+bI4K6Hbx/BHZLtsmtuWlHVEZlISbrs5tfYYs/iMzkXgCVI1Evxcvkujoq6V
	ZKbCH2cp55PBFZIGsE2CCLjy4kIh4Yz6cbCTU6WYFund+2SGH
X-Received: by 2002:a05:622a:1015:b0:427:eae2:f02c with SMTP id d21-20020a05622a101500b00427eae2f02cmr263520qte.30.1703618706908;
        Tue, 26 Dec 2023 11:25:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnYA9PuTSPIQqJOWrMDj5PvnvtnxyVWGv1QzJxODCgLC8yTN1kgrGSrr2zGyVRhecB5rgBINIyT1bULYoxvTk=
X-Received: by 2002:a05:622a:1015:b0:427:eae2:f02c with SMTP id
 d21-20020a05622a101500b00427eae2f02cmr263487qte.30.1703618706670; Tue, 26 Dec
 2023 11:25:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222074605.452452-1-leobras@redhat.com> <20231222074605.452452-4-leobras@redhat.com>
 <CABgGipXLe7MxP076CJ=BLAaChAQug5X7qkNxxm9eEnyy92nEJQ@mail.gmail.com>
In-Reply-To: <CABgGipXLe7MxP076CJ=BLAaChAQug5X7qkNxxm9eEnyy92nEJQ@mail.gmail.com>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Tue, 26 Dec 2023 16:24:55 -0300
Message-ID: <CAJ6HWG4Pe0co91-tRpV-gKoVUJkobB=uz8J-pjTvyX=Ed49u_w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] riscv: Introduce is_compat_thread() into compat.h
To: Andy Chiu <andy.chiu@sifive.com>
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

On Sat, Dec 23, 2023 at 1:26=E2=80=AFAM Andy Chiu <andy.chiu@sifive.com> wr=
ote:
>
> On Fri, Dec 22, 2023 at 3:46=E2=80=AFPM Leonardo Bras <leobras@redhat.com=
> wrote:
> >
> > task_user_regset_view() makes use of a function very similar to
> > is_compat_task(), but pointing to a any thread.
> >
> > In arm64 asm/compat.h there is a function very similar to that:
> > is_compat_thread(struct thread_info *thread)
> >
> > Copy this function to riscv asm/compat.h and make use of it into
> > task_user_regset_view().
> >
> > Also, introduce a compile-time test for CONFIG_COMPAT and simplify the
> > function code by removing the #ifdef.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  arch/riscv/include/asm/compat.h | 8 ++++++++
> >  arch/riscv/kernel/ptrace.c      | 6 +++---
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/c=
ompat.h
> > index 91517b51b8e27..da4b28cd01a95 100644
> > --- a/arch/riscv/include/asm/compat.h
> > +++ b/arch/riscv/include/asm/compat.h
> > @@ -20,6 +20,14 @@ static inline int is_compat_task(void)
> >         return test_thread_flag(TIF_32BIT);
> >  }
> >
> > +static inline int is_compat_thread(struct thread_info *thread)
> > +{
> > +       if (!IS_ENABLED(CONFIG_COMPAT))
> > +               return 0;
> > +
> > +       return test_ti_thread_flag(thread, TIF_32BIT);
> > +}
> > +
>
> Does it make sense to use a #ifdef CONFIG_COMPAT clause to group
> is_compat_thread() and is_compat_flag()? For example,

Hello Andy,

Sure, it does make sense.

But I honestly think that using IS_ENABLED() instead of #ifdef +
multiple same-named functions works better for code reading, at least
for small functions such as these.

Does this make sense?

Thanks for reviewing!
Leo


>
> #ifdef CONFIG_COMPAT
> static inline int is_compat_thread(struct thread_info *thread)
> {
>  return test_ti_thread_flag(thread, TIF_32BIT);
> }
> static inline int is_compat_task(void)
> {
>  return is_compat_thread(current);
> }
> #else
> static inline int is_compat_thread(struct thread_info *thread) { return 0=
; }
> static inline int is_compat_task(void) { return 0; }
> #endif
>
> >  struct compat_user_regs_struct {
> >         compat_ulong_t pc;
> >         compat_ulong_t ra;
> > diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> > index 2afe460de16a6..f362832123616 100644
> > --- a/arch/riscv/kernel/ptrace.c
> > +++ b/arch/riscv/kernel/ptrace.c
> > @@ -374,14 +374,14 @@ long compat_arch_ptrace(struct task_struct *child=
, compat_long_t request,
> >
> >         return ret;
> >  }
> > +#else
> > +static const struct user_regset_view compat_riscv_user_native_view =3D=
 {};
> >  #endif /* CONFIG_COMPAT */
> >
> >  const struct user_regset_view *task_user_regset_view(struct task_struc=
t *task)
> >  {
> > -#ifdef CONFIG_COMPAT
> > -       if (test_tsk_thread_flag(task, TIF_32BIT))
> > +       if (is_compat_thread(&task->thread_info))
> >                 return &compat_riscv_user_native_view;
> >         else
> > -#endif
> >                 return &riscv_user_native_view;
> >  }
> > --
> > 2.43.0
> >
>


