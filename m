Return-Path: <linux-kernel+bounces-7732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2C981AC5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27962878C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1459B185D;
	Thu, 21 Dec 2023 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L+cBbBvy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B6315AE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 01:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1fab887fab8so194552fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 17:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703123501; x=1703728301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAWSfxg1miex9VPUVo9Ilnw4CJ41/kT47/lxOaa6acg=;
        b=L+cBbBvywJugQiUmbh8/I7h9oPeWCP2bcMsUfZC43646uita9Pzli9My9x5EyBRdXH
         xHWkqMgbv3x4QHrZ2d7pNq1Op+woJDWTd17vmj3kDaM/m8um7jDoH2DYqoMxxDMynGm9
         1AdQu7XoHiErFao9LGMYdkAug+L6Rf0m0dw7T0Dsv3KWOqv3dUQ/N7RhgbwVSyspLcmu
         aCrLWHWfXHLDXNEDQVqOrcyazyVu3hiVmkMVGCYYMrl94OORHloKvUix6F2Xr2VPKmR7
         CLXFgO2BYGzmN+y2m29wwakATlE5AcITIK0mCbXC1qOEj5IxOdogVVTsZAd6IhCWggXI
         7oGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703123501; x=1703728301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAWSfxg1miex9VPUVo9Ilnw4CJ41/kT47/lxOaa6acg=;
        b=FL+FA0Hd843mz3ZScb6g0JCme3OZfbI0JoIyUR3iZN8Op82tUwcu7feEw0X38FpnYc
         RVwftbrSEDT6ob8Hwb9zjguruMY0zl8TZ/QZwVnia32ZW5faD6Atld/kr3TOR1J7Nd88
         CMm1y63crpLE8/rA50u6X5czDom+pwqt4klGgf0mBMh1mh/bJs5VbzJdW82tI1mzjrdr
         5YG11VHbKKf9KigWONJyKQ6HwWOxoKehNXy4CGFP6IIIVqEfGMZcdY3wCwLbj+5v0yow
         fB4s0fZUd5KYQo4zuSxT87VWrI5lgzPkcWfvddabN6lUSrRDqW4yu/QSS2iEa1m26Sjj
         qehQ==
X-Gm-Message-State: AOJu0YyipK+CoMajWkuCGRDHW7s1bkzEpj6YLAjSMxE75o+zWjTkJqQb
	l077+jlB+boPQ+ZtYRRZrn2ZjR7QC0BB/AZJ+UAAWA==
X-Google-Smtp-Source: AGHT+IGN8PP7Ek6OmvKkh+7+/vTCnhK7cnIN5E/W9H5dAyu3VY2JS7fSNFsVpuoOstd0OaOISNlEDGsV6vgYcUy4Mus=
X-Received: by 2002:a05:6871:4d4:b0:203:4038:dfd5 with SMTP id
 n20-20020a05687104d400b002034038dfd5mr782420oai.94.1703123500988; Wed, 20 Dec
 2023 17:51:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220103428.61758-1-cuiyunhui@bytedance.com>
 <594df6bc-0207-46f6-aa81-dcf1f3665917@ghiti.fr> <20231220-bash-booting-2dc46e8c41f7@spud>
In-Reply-To: <20231220-bash-booting-2dc46e8c41f7@spud>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 21 Dec 2023 09:51:29 +0800
Message-ID: <CAEEQ3w=_i6cDkt-j+xDZ1oanbScA9o8NpV-KU0s4-w=ZJ1U6cA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: put va_kernel_xip_pa_offset into CONFIG_XIP_KERNEL
To: Conor Dooley <conor@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, ajones@ventanamicro.com, alexghiti@rivosinc.com, 
	anup@brainfault.org, samitolvanen@google.com, rppt@kernel.org, 
	panqinglin2020@iscas.ac.cn, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor=EF=BC=8CAlex

On Thu, Dec 21, 2023 at 6:35=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Dec 20, 2023 at 10:14:59PM +0100, Alexandre Ghiti wrote:
> > Hi Yunhui,
> >
> > On 20/12/2023 11:34, Yunhui Cui wrote:
> > > opitmize the kernel_mapping_pa_to_va() and kernel_mapping_va_to_pa().
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >   arch/riscv/include/asm/page.h | 33 ++++++++++++++++++++------------=
-
> > >   1 file changed, 20 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/p=
age.h
> > > index 5488ecc337b6..0d2b479d02cd 100644
> > > --- a/arch/riscv/include/asm/page.h
> > > +++ b/arch/riscv/include/asm/page.h
> > > @@ -113,8 +113,8 @@ struct kernel_mapping {
> > >     unsigned long va_pa_offset;
> > >     /* Offset between kernel mapping virtual address and kernel load =
address */
> > >     unsigned long va_kernel_pa_offset;
> > > -   unsigned long va_kernel_xip_pa_offset;
> > >   #ifdef CONFIG_XIP_KERNEL
> > > +   unsigned long va_kernel_xip_pa_offset;
> > >     uintptr_t xiprom;
> > >     uintptr_t xiprom_sz;
> > >   #endif
> > > @@ -134,12 +134,25 @@ extern phys_addr_t phys_ram_base;
> > >   #else
> > >   void *linear_mapping_pa_to_va(unsigned long x);
> > >   #endif
> > > -#define kernel_mapping_pa_to_va(y) ({                               =
       \
> > > -   unsigned long _y =3D (unsigned long)(y);                         =
         \
> > > -   (IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?          =
       \
> > > -           (void *)(_y + kernel_map.va_kernel_xip_pa_offset) :      =
       \
> > > -           (void *)(_y + kernel_map.va_kernel_pa_offset + XIP_OFFSET=
);     \
> > > -   })
> > > +
> > > +#ifdef CONFIG_XIP_KERNEL
> > > +#define kernel_mapping_pa_to_va(y)                                  =
               \
> > > +   (((unsigned long)(y) < phys_ram_base) ?                          =
               \
> > > +           (void *)((unsigned long)(y) + kernel_map.va_kernel_xip_pa=
_offset) :     \
> > > +           (void *)((unsigned long)(y) + kernel_map.va_kernel_pa_off=
set + XIP_OFFSET))
> > > +
> > > +#define kernel_mapping_va_to_pa(y)                                  =
       \
> > > +   (((unsigned long)(y) < kernel_map.virt_addr + XIP_OFFSET) ?      =
       \
> > > +           ((unsigned long)(y) - kernel_map.va_kernel_xip_pa_offset)=
 :     \
> > > +           ((unsigned long)(y) - kernel_map.va_kernel_pa_offset - XI=
P_OFFSET))
> > > +#else
> > > +#define kernel_mapping_pa_to_va(y)                                  =
       \
> > > +   ((void *)((unsigned long)(y) + kernel_map.va_kernel_pa_offset + X=
IP_OFFSET))
> > > +
> > > +#define kernel_mapping_va_to_pa(y)                                  =
       \
> > > +   ((unsigned long)(y) - kernel_map.va_kernel_pa_offset - XIP_OFFSET=
)
> > > +#endif
> > > +
> > >   #define __pa_to_va_nodebug(x)             linear_mapping_pa_to_va(x=
)
> > >   #ifndef CONFIG_DEBUG_VIRTUAL
> > > @@ -147,12 +160,6 @@ void *linear_mapping_pa_to_va(unsigned long x);
> > >   #else
> > >   phys_addr_t linear_mapping_va_to_pa(unsigned long x);
> > >   #endif
> > > -#define kernel_mapping_va_to_pa(y) ({                               =
               \
> > > -   unsigned long _y =3D (unsigned long)(y);                         =
         \
> > > -   (IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP=
_OFFSET) ? \
> > > -           (_y - kernel_map.va_kernel_xip_pa_offset) :              =
       \
> > > -           (_y - kernel_map.va_kernel_pa_offset - XIP_OFFSET);      =
       \
> > > -   })
> > >   #define __va_to_pa_nodebug(x)     ({                               =
               \
> > >     unsigned long _x =3D x;                                          =
         \
> >
> >
> > Not sure using #ifdef optimizes anything since the compiler should do t=
he
> > same with the IS_ENABLED(CONFIG_XIP_KERNEL) and it does not really impr=
ove
> > the readability of this file which is already overloaded with #ifdef, s=
o I
> > don't think this change is needed.
>
> I would say that we explicitly do not want to move things that are
> guarded by IS_ENABLED() to ifdeffery. In fact, we should move things in
> the other direction if possible, especially for stuff like XIP_KERNEL
> that nobody ever build tests.

The point of this patch is that logically, like xiprom and xiprom_sz,
stuct kernel_mapping.va_kernel_xip_pa_offset should be included in
CONFIG_XIP_KERNEL.

I believe we can agree on this, right?

Thanks,
Yunhui

