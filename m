Return-Path: <linux-kernel+bounces-52357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F36849717
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4D61F225B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D9B12E6D;
	Mon,  5 Feb 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TKmSnozs"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099812E4E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126975; cv=none; b=WZ6KlGvNNYnrsbYeZMYKyfEdupjCwBGlp4346Rs2FAKNg5q03083XxrXGF6hHnRoy90JVzMupKawuzeP+clAjVOZW926yVfStUYdFBIr0lB4lfIFQZ/NpaCh0MZQLdoEOiMquuFjDaiyO1SEIGE/5BwYowrPMP4BSUHydjRnyu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126975; c=relaxed/simple;
	bh=beA5jKCFvMxf03a7msTgO2rm/6nQdr1GBNzkVRMzdTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+SHVxbY2nX4sCDPKqJ0CVcRfcPZc9V8TKeOrV9Fx2Nb15pPH+m3esdu2A3i8u57WDLyStbK1rV1DP/qC1maWldw4Rv+21mEsfKKf0M1U8Lfi0lTH4ecsE9cmkRmOGZFBxDnDKA6EMwzm7utl8nJEAl44xe+ZInjWnhPiZsZO7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TKmSnozs; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d090c83d45so26020141fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707126972; x=1707731772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9BPe2mmfdZET5BWvxtuooX2YZGr+tHIeZQXWHS+HOE=;
        b=TKmSnozsD4pnKcYBHCXd9KjcBTnCVuxQKbtzlkKrmQPpa4SbRy+aML0tIN8Y+i9zrL
         9/bWtLLOgFGK8XtBByVsSNyXjrL0Aef6L6xI6ejD3sqeQlQ8sTq9Zhzovt2BYybxM0W4
         Fqis5rpM3Y1P67bcyHFqW5VW6ndbFrpvy8BYPYwZJYta8IWoqlnVxagsHQ9Q+hVqYh6b
         GrtYro0vYO+LbDeRtrCHoAm8fA9Dhy3qyfJGfiO0jj5x9GyuJW4fArLET0nxwfTEX1ue
         4HcLsXvYbajMWSqrnlgFIUp38Acwb0QMpNgsQ+1nPomgKkyxvbWNMRkSo27xmrWvUGmL
         zTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126972; x=1707731772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9BPe2mmfdZET5BWvxtuooX2YZGr+tHIeZQXWHS+HOE=;
        b=QMMFR161FuurSU/spY3vh0KrFZwr6nACW5m1032o4KucU3uVo/6gV1o9dagGZh+VXa
         ldk9XW0F63koqAXlYOnEMTGy1wGpnY+5T37r5qOTVqAMfZW3XJQwF+/+Z8K1IszHxQ5X
         Ocp6WxeSAd2MK8D13vm/uD2EXgZTVGgWgKehPNeWbToLir2VaaVoriIIdg8i0k513Vx/
         JGvyuM4QJLu3LUku3LxYlV15hnZ9HNptnN7uUPDJCd9Zl0BZ0/q9ERGyyhnNIMhmWRcp
         afklxCQBg54zPuoGT9mdV1MXW2dZwM7ZOTNhY7P8L2sdr0Zfw3lAAiDX2JpMU2YVuUfi
         tg8A==
X-Gm-Message-State: AOJu0YzMrqoxnntri9PUOvjLTDuzgBEm77eq+WTwgNVq3/5EUj/lSlJK
	oh140A0o5VwZNGOjZslSetxVvjuEbu7Cm55NPK6beH8/lbEbOhpXJO/bWR3vyLL2KTGIihjbMAe
	24Kf7t/I2MLsgKtcdexPAQfsM88NVWfH609OXgA==
X-Google-Smtp-Source: AGHT+IH3P5s7Frwj0p+8I7LR12TkIrs63+BQ1M+xJBNP1K9TLpzBZz8WvmvE8AYrszJxa8mic1nfZKmP3/V0QwqFSs0=
X-Received: by 2002:a05:651c:1a11:b0:2d0:abec:25b9 with SMTP id
 by17-20020a05651c1a1100b002d0abec25b9mr1411667ljb.50.1707126971479; Mon, 05
 Feb 2024 01:56:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205042955.833752-1-apatel@ventanamicro.com> <d5e21238-89f4-444e-9c35-f4a28e01052e@ghiti.fr>
In-Reply-To: <d5e21238-89f4-444e-9c35-f4a28e01052e@ghiti.fr>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 5 Feb 2024 15:25:59 +0530
Message-ID: <CAK9=C2XEmFBDB6R5f+L9++7ojhWb8rJK-e-vgFrDmsi2=DMOBw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Don't use IPIs in flush_icache_all() when
 patching text
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 11:52=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Anup,
>
> On 05/02/2024 05:29, Anup Patel wrote:
> > If some of the HARTs are parked by stop machine then IPI-based
> > flushing in flush_icache_all() will hang. This hang is observed
> > when text patching is invoked by various debug and BPF features.
> >
> > To avoid this hang, we force use of SBI-based icache flushing
> > when patching text.
> >
> > Fixes: 627922843235 ("RISC-V: Use IPIs for remote icache flush when pos=
sible")
> > Reported-by: Bjorn Topel <bjorn@kernel.org>
> > Closes: https://gist.github.com/bjoto/04a580568378f3b5483af07cd9d22501
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >   arch/riscv/include/asm/cacheflush.h | 7 ++++---
> >   arch/riscv/kernel/hibernate.c       | 2 +-
> >   arch/riscv/kernel/patch.c           | 4 ++--
> >   arch/riscv/mm/cacheflush.c          | 7 ++++---
> >   4 files changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/a=
sm/cacheflush.h
> > index a129dac4521d..561e079f34af 100644
> > --- a/arch/riscv/include/asm/cacheflush.h
> > +++ b/arch/riscv/include/asm/cacheflush.h
> > @@ -32,7 +32,8 @@ static inline void flush_dcache_page(struct page *pag=
e)
> >    * RISC-V doesn't have an instruction to flush parts of the instructi=
on cache,
> >    * so instead we just flush the whole thing.
> >    */
> > -#define flush_icache_range(start, end) flush_icache_all()
> > +#define flush_icache_range(start, end) flush_icache_all(true)
> > +#define flush_icache_patch_range(start, end) flush_icache_all(false)
> >   #define flush_icache_user_page(vma, pg, addr, len) \
> >       flush_icache_mm(vma->vm_mm, 0)
> >
> > @@ -43,12 +44,12 @@ static inline void flush_dcache_page(struct page *p=
age)
> >
> >   #ifndef CONFIG_SMP
> >
> > -#define flush_icache_all() local_flush_icache_all()
> > +#define flush_icache_all(want_ipi) local_flush_icache_all()
> >   #define flush_icache_mm(mm, local) flush_icache_all()
> >
> >   #else /* CONFIG_SMP */
> >
> > -void flush_icache_all(void);
> > +void flush_icache_all(bool want_ipi);
> >   void flush_icache_mm(struct mm_struct *mm, bool local);
> >
> >   #endif /* CONFIG_SMP */
> > diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernat=
e.c
> > index 671b686c0158..388f10e187ba 100644
> > --- a/arch/riscv/kernel/hibernate.c
> > +++ b/arch/riscv/kernel/hibernate.c
> > @@ -153,7 +153,7 @@ int swsusp_arch_suspend(void)
> >       } else {
> >               suspend_restore_csrs(hibernate_cpu_context);
> >               flush_tlb_all();
> > -             flush_icache_all();
> > +             flush_icache_all(true);
> >
> >               /*
> >                * Tell the hibernation core that we've just restored the=
 memory.
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index 37e87fdcf6a0..721e144a7847 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -182,7 +182,7 @@ int patch_text_set_nosync(void *addr, u8 c, size_t =
len)
> >       ret =3D patch_insn_set(tp, c, len);
> >
> >       if (!ret)
> > -             flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
> > +             flush_icache_patch_range((uintptr_t)tp, (uintptr_t)tp + l=
en);
> >
> >       return ret;
> >   }
> > @@ -217,7 +217,7 @@ int patch_text_nosync(void *addr, const void *insns=
, size_t len)
> >       ret =3D patch_insn_write(tp, insns, len);
> >
> >       if (!ret)
> > -             flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
> > +             flush_icache_patch_range((uintptr_t) tp, (uintptr_t) tp +=
 len);
> >
> >       return ret;
> >   }
> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > index 55a34f2020a8..03cd3d4831ef 100644
> > --- a/arch/riscv/mm/cacheflush.c
> > +++ b/arch/riscv/mm/cacheflush.c
> > @@ -17,11 +17,12 @@ static void ipi_remote_fence_i(void *info)
> >       return local_flush_icache_all();
> >   }
> >
> > -void flush_icache_all(void)
> > +void flush_icache_all(bool want_ipi)
> >   {
> >       local_flush_icache_all();
> >
> > -     if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
> > +     if (IS_ENABLED(CONFIG_RISCV_SBI) &&
> > +         (!want_ipi || !riscv_use_ipi_for_rfence()))
> >               sbi_remote_fence_i(NULL);
> >       else
> >               on_each_cpu(ipi_remote_fence_i, NULL, 1);
> > @@ -87,7 +88,7 @@ void flush_icache_pte(pte_t pte)
> >       struct folio *folio =3D page_folio(pte_page(pte));
> >
> >       if (!test_bit(PG_dcache_clean, &folio->flags)) {
> > -             flush_icache_all();
> > +             flush_icache_all(true);
> >               set_bit(PG_dcache_clean, &folio->flags);
> >       }
> >   }
>
>
> Since patch_text_cb() is run on all cpus, couldn't we completely avoid
> any remote icache flush by slightly changing patch_text_cb() instead as
> follows?

Unfortunately patch_text_cb() is not the only user of patch_text_nosync
since patch_text_nosync() and patch_text_set_nosync() are called directly
from other places as well.

We have to update all users of patch_text_nosync() and
patch_text_set_nosync() to move to local icache flushes which
is a much bigger change.

Regards,
Anup

>
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 37e87fdcf6a0..075c376ed528 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -232,8 +232,8 @@ static int patch_text_cb(void *data)
>          if (atomic_inc_return(&patch->cpu_count) =3D=3D num_online_cpus(=
)) {
>                  for (i =3D 0; ret =3D=3D 0 && i < patch->ninsns; i++) {
>                          len =3D GET_INSN_LENGTH(patch->insns[i]);
> -                       ret =3D patch_text_nosync(patch->addr + i * len,
> - &patch->insns[i], len);
> +                       ret =3D patch_insn_write((u32 *)(patch->addr + i =
*
> len),
> + &patch->insns[i], len);
>                  }
>                  atomic_inc(&patch->cpu_count);
>          } else {
> @@ -242,6 +242,8 @@ static int patch_text_cb(void *data)
>                  smp_mb();
>          }
>
> +       local_flush_icache_all();
> +
>          return ret;
>   }
>   NOKPROBE_SYMBOL(patch_text_cb);
>
>
>

