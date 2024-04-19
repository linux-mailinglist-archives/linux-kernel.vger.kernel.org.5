Return-Path: <linux-kernel+bounces-151129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E428AA976
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FBA1F2256D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797004EB43;
	Fri, 19 Apr 2024 07:44:44 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C474DA0D;
	Fri, 19 Apr 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512684; cv=none; b=RXgetMEnUycgV7/LXlB+4dAFD9ivWd6hn8H/n6jr4FaQzyroc7ssN6JZrlf92agp5Q8zczCUe5tCquSxCAxU6nL3xSAf7Ur0neLYARrbWd+xbeVc4BDAoySrvlh+E5V525O2Y1SymVxS4/UtYqnXtPqx07oARydm5kziuhVSOao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512684; c=relaxed/simple;
	bh=2GGt86edY2lm8kr2PVjmA1G4gvSGUPMlBXuQK8dCo7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgrmmLgDpr5d0VGmaIorW54LsensP3F64fYsoEME33kfPGBF/H0LXKA5QlZRMDI7M8ZQuiQWVxHuQb42CInLjYMYI/t+qoIYSFLJKSsRY6AQKjId1raxZ78pQMo6unVl/zwfLWJScbrLOMYyj8V7MZqqQmaxYwwM1rqV5ob4KEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61ad5f2c231so19951167b3.2;
        Fri, 19 Apr 2024 00:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713512679; x=1714117479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9aGfGVkclitK9fGaCPJLToKLvFSDmM3YASsQou3aVI=;
        b=mkQQ47yKPp1CvnDxrJHF31YvvnomRBLoH03LMc3CH2bQlGnk3Z37lcNmaj61SonHZa
         ZtZSn7TP2cBZbZb51fhqd9lZqAJdH62iG/I8wx99H++7Ky7b2QZSLgCqe8bbzocnBtxy
         WuMJdYteh2oLXO6j4IWIj1eOZJiBdAL7UmLu/kY3frTBJ/UF115aVDRBgujs3aK40P//
         X/J6q+tXopcaXzkP3b1gp7aI/IdaSqkZHmFblycQRXRv8/vLqUrfKhcsuaRVUZq1WuYQ
         YJpf5ke63ySNELFBGIhphEa1IZRFkhakVTpx2ODtvFQ4T9b4nrmzZRGdlUcUMaixc/GU
         s7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4oVkPyBA6/D6OrpJ+axOpMvVBY6GW+j2BC3hDbYJbn/TQOMhflTLtbUmPko+2u5IDv4t6dB0a01hXzj2B82ZIeLgHVWxPe86KS1bHpn/XLKMa8X6z/Rvio3miF4D13AeHfGO9I/HN88UJ13uFUPqjlq3WWBya2Ryyr8TLcoDTE1wU/EOP+lG4gTch
X-Gm-Message-State: AOJu0YxKT2sH1GB6Wck+fuBCIIPNeQxApcqwmOBgN4yX5TB0zycerup0
	FGJ4ROZeQZR8H3hNgKw9pJvPF1UvFeYXzvT+AsJzeDswd/SHfNMzJvO8OCsg
X-Google-Smtp-Source: AGHT+IHtQIQI7on1rrTyVCHfOJzKCHqK1v7A/S6siyBrX4swfn+bLUPU3t2jO3JZLezcrDjYj1qiAw==
X-Received: by 2002:a05:690c:620c:b0:618:8b98:f274 with SMTP id hl12-20020a05690c620c00b006188b98f274mr1449346ywb.45.1713512679087;
        Fri, 19 Apr 2024 00:44:39 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id l12-20020a81ad4c000000b00617be0a2bf2sm680714ywk.72.2024.04.19.00.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 00:44:38 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de47485532cso1377542276.3;
        Fri, 19 Apr 2024 00:44:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGVrHYv8K1qsV5u8NDZJamRFMRQWWAI92xHLIDwTAWIHs/k81fEh8Z0azUEPOXDTaZZAhyML1Ux+zJMKW4vLpGkw6O/ITXZ0iqSAJA31CfOSY9g7Qe1bj22KdNXLGBZxgv9d8gmvgqQ5GKzOzrR1BtYH18TbA4xWhm/O3LJfrDTfKKxGQMId5zx+KF
X-Received: by 2002:a05:6902:218d:b0:dc6:bcb3:5d8e with SMTP id
 dl13-20020a056902218d00b00dc6bcb35d8emr1436727ybb.20.1713512677738; Fri, 19
 Apr 2024 00:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240403203503.634465-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdW7kiSYm8n8CfMs9zKaN+PhVt+=16nx=ttLk6Ur_jOa-g@mail.gmail.com> <CA+V-a8t6B3pGjrciDNRzdpGQp-8cGW0JXV9k0udpku3GVA0ckA@mail.gmail.com>
In-Reply-To: <CA+V-a8t6B3pGjrciDNRzdpGQp-8cGW0JXV9k0udpku3GVA0ckA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Apr 2024 09:44:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWCHD+AuP9v2fBygDv-fJqP4RZ=Gtp3PX9b1K-GX1+XQg@mail.gmail.com>
Message-ID: <CAMuHMdWCHD+AuP9v2fBygDv-fJqP4RZ=Gtp3PX9b1K-GX1+XQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Fri, Apr 19, 2024 at 9:15=E2=80=AFAM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, Apr 18, 2024 at 4:11=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Wed, Apr 3, 2024 at 10:36=E2=80=AFPM Prabhakar <prabhakar.csengg@gma=
il.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > The IX45 block has additional mask registers (NMSK/IMSK/TMSK) as comp=
ared
> > > to the RZ/G2L (family) SoC.
> > >
> > > Introduce masking/unmasking support for IRQ and TINT interrupts in IR=
QC
> > > controller driver. Two new registers, IMSK and TMSK, are defined to
> > > handle masking on RZ/Five SoC. The implementation utilizes a new data
> > > structure, `struct rzg2l_irqc_data`, to determine mask support for a
> > > specific controller instance.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > ---
> > > v1->v2
> > > - Added IRQCHIP_MATCH() for RZ/Five
> > > - Retaining a copy of OF data in priv
> > > - Rebased the changes
> >
> > Thanks for the update!
> >
> > > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > > @@ -66,15 +68,25 @@ struct rzg2l_irqc_reg_cache {
> > >         u32     titsr[2];
> > >  };
> > >
> > > +/**
> > > + * struct rzg2l_irqc_of_data - OF data structure
> > > + * @mask_supported: Indicates if mask registers are available
> > > + */
> > > +struct rzg2l_irqc_of_data {
> > > +       bool    mask_supported;
> > > +};
> > > +
> > >  /**
> > >   * struct rzg2l_irqc_priv - IRQ controller private data structure
> > >   * @base:      Controller's base address
> > > + * @data:      OF data pointer
> > >   * @fwspec:    IRQ firmware specific data
> > >   * @lock:      Lock to serialize access to hardware registers
> > >   * @cache:     Registers cache for suspend/resume
> > >   */
> > >  static struct rzg2l_irqc_priv {
> > >         void __iomem                    *base;
> > > +       const struct rzg2l_irqc_of_data *data;
> >
> > That's not a copy, but a pointer.
> >
> Oops, should that be OK or shall I create a copy instead?

If you would use a copy, all SoC-specific rzg2l_irqc_of_data structures
could become __initconst.

However, depending on how far you want to go with the irq_chip
separation, you may no longer need this field anyway.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

