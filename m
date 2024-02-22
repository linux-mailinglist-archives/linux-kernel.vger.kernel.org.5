Return-Path: <linux-kernel+bounces-76600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6C185F9D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4CB28847F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B3113473B;
	Thu, 22 Feb 2024 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="w7k1AQ7H"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E72B133296
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608639; cv=none; b=prMqwy8RS9uP71eZGdwMXc7qkv+wJRTmvRqAk1EQG14AIPXE0gWZZsk+G63D9JPbhc2yxnW1kVBdP2H3f1s6hZZ8iE251MV73YD83JLPVlBQq5R12iMx2lYYF8KYp6eLj+bqwAVCNfO98aH4r3mdViseLHRChQmnDT5xfBSdmcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608639; c=relaxed/simple;
	bh=is9pLe/ncZvHnudaxArpyBBcjnkjUXyeuvoguYondns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2Cf6qqNQK8UbUd3iSvnYCaH0th2HQULeyJZpGw4izo76ahLu7D38lqumRmUahzaScGS2Yt196Dgna4kF2Lir7i8PYux9UuTjOSuDTIGQ0oTnGmHmc9B7247i7LbzvIhsx5o8cUYKBDgShZq5LLPUniD5T9mac7OEOif/A2sio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=w7k1AQ7H; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-365220a2c3dso23448965ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1708608637; x=1709213437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tm6+BZx//BfcbcHBQe5tKGHx19q8gbGIF+ECXygbr2c=;
        b=w7k1AQ7HVVFqarY7SbCPeWNNBDEza5JMDigwxicBiIEqLnCbrXvPHFnXTrMjk/8O2C
         6UFzGtsE18rpDyPWQE+QrP7ahXS96yax1zRM5QirCOqFBRWszpoECWsBWrzCcjkB3fzK
         SvPq6s58Pjxj4DBdvSaLi84PVMaviCZ7nwbGvRGDOQHDpO1usOVMJPchQVWSSWP+BbbL
         hWMLX+IsDHYomvv5Gnr0j+HgjfrbGxZDhgZR7tluUoMRb1fYI91+DzzWFH/fIcdHVIZ9
         1JXyEf40+l6gDpPLIcVu8aDOGPUFGAv2tEabSu4bLLmQW3vZCQGXajbOQcsVD6fIpUnz
         DREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608637; x=1709213437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tm6+BZx//BfcbcHBQe5tKGHx19q8gbGIF+ECXygbr2c=;
        b=Tk5lPYbhMqYHU9++wkb7N03jJdXvhuTq6qGKZxmGOP0lBJg7ntOOhvVfhEb3Uj4VDA
         39vhaldS1Shj3KhzMR61P99YDdKnysQ9V/90YnoEsD3Gs6u+hOcFl2F96oM3trJpxaa1
         GrS2lFMVZ3u8KAqu6SkFI7j6if5o0frEFgtTkY2MhEhOmvyj0YM0a/DSXaRqk2o9+lzj
         CcSdzE/VvB93nSc96SVhblXqCEitbD/DX4SPgYJouDArlOKZ8NAgXSqozahXVUmU6v+c
         +tczVoJ/IX+9/QGkA+anHJN1JmA20ylkVA07RWmMo0dt0NQWswAAzgGpO1wa/Z51Wtiy
         hrVA==
X-Forwarded-Encrypted: i=1; AJvYcCU9h0lEG/ounZuQ7hRsNdm4JnufM/hsdavthtUSQRB5EKUo39sx9JSSTTHM650QaHq2FhO6c3Re5xYYTiw/NHewJfb1/sZnyS3g7BMy
X-Gm-Message-State: AOJu0YxNNjatYg0asuA3Unln4Yhi2rqhaj/CXl+wxXqkOodri7P/aWXI
	/Sy2MIu1NgAFEaIjVi/Wa/hmCXFt4en39rNmquIECecSS/M5RsKEwkIvY4EFndjZMlo4gn3Bqr3
	NCqIh22cC6KEh1NMtUw8uxfivQ68q5qgUnCNGTg==
X-Google-Smtp-Source: AGHT+IH7+5ZCczA7CU0C46qlCuTGH9ZfX4fnyGxuO1KETodyAdfp/RwxJf4awEiJMnqjcwJ7wcD82uB7iK3DMxQoA9s=
X-Received: by 2002:a05:6e02:1292:b0:363:da36:f643 with SMTP id
 y18-20020a056e02129200b00363da36f643mr18895064ilq.8.1708608637266; Thu, 22
 Feb 2024 05:30:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-14-apatel@ventanamicro.com> <87msrstzck.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87msrstzck.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 22 Feb 2024 19:00:25 +0530
Message-ID: <CAAhSdy3DtDFnZKQLXXJ2OPPSv5s8bbGvm8Mmqhg_F2rPneQ3sw@mail.gmail.com>
Subject: Re: [PATCH v14 13/18] irqchip/riscv-imsic: Add device MSI domain
 support for PCI devices
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 6:44=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> > The Linux PCI framework supports per-device MSI domains for PCI devices
> > so extend the IMSIC driver to allow PCI per-device MSI domains.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/Kconfig                    |  7 +++++
> >  drivers/irqchip/irq-riscv-imsic-platform.c | 35 ++++++++++++++++++++--
> >  2 files changed, 40 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 85f86e31c996..2fc0cb32341a 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -553,6 +553,13 @@ config RISCV_IMSIC
> >       select GENERIC_IRQ_MATRIX_ALLOCATOR
> >       select GENERIC_MSI_IRQ
> >
> > +config RISCV_IMSIC_PCI
> > +     bool
> > +     depends on RISCV_IMSIC
> > +     depends on PCI
> > +     depends on PCI_MSI
> > +     default RISCV_IMSIC
> > +
> >  config EXYNOS_IRQ_COMBINER
> >       bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
> >       depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
> > diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqch=
ip/irq-riscv-imsic-platform.c
> > index e2344fc08dca..90ddcdd0bba5 100644
> > --- a/drivers/irqchip/irq-riscv-imsic-platform.c
> > +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/irqdomain.h>
> >  #include <linux/module.h>
> >  #include <linux/msi.h>
> > +#include <linux/pci.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/smp.h>
> > @@ -208,6 +209,28 @@ static const struct irq_domain_ops imsic_base_doma=
in_ops =3D {
> >  #endif
> >  };
> >
> > +#ifdef CONFIG_RISCV_IMSIC_PCI
> > +
> > +static void imsic_pci_mask_irq(struct irq_data *d)
> > +{
> > +     pci_msi_mask_irq(d);
> > +     irq_chip_mask_parent(d);
> > +}
> > +
> > +static void imsic_pci_unmask_irq(struct irq_data *d)
> > +{
> > +     irq_chip_unmask_parent(d);
> > +     pci_msi_unmask_irq(d);
> > +}
> > +
> > +#define MATCH_PCI_MSI                BIT(DOMAIN_BUS_PCI_MSI)
> > +
> > +#else
> > +
> > +#define MATCH_PCI_MSI                0
> > +
> > +#endif
> > +
> >  static bool imsic_init_dev_msi_info(struct device *dev,
> >                                   struct irq_domain *domain,
> >                                   struct irq_domain *real_parent,
> > @@ -231,6 +254,13 @@ static bool imsic_init_dev_msi_info(struct device =
*dev,
> >
> >       /* Is the target supported? */
> >       switch (info->bus_token) {
> > +#ifdef CONFIG_RISCV_IMSIC_PCI
> > +     case DOMAIN_BUS_PCI_DEVICE_MSI:
> > +     case DOMAIN_BUS_PCI_DEVICE_MSIX:
> > +             info->chip->irq_mask =3D imsic_pci_mask_irq;
> > +             info->chip->irq_unmask =3D imsic_pci_unmask_irq;
>
> irq_set_affinity()?

It's already set by the switch-case above.

Regards,
Anup

