Return-Path: <linux-kernel+bounces-157758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65308B1567
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC03DB24187
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93C0157A70;
	Wed, 24 Apr 2024 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HqS+oCjy"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826A157E9E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995964; cv=none; b=cejenH9m+PWTOOux8vKU+mibYsGupXXYV0cKb/o1rD00CRO1eqO9HH2Hwd0iEbwQtCEUvCNbrzycxV2+dTcvCzIA1EWhyBy+jDp8YegMgIDAZ71x09rNkVSSefw/heWLcvWP1tZoFpoQRV8jbENYsTKqsRw97RY+2142aCbDkVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995964; c=relaxed/simple;
	bh=SdkCy1RmEMNXBIMvDN6pIRi0ZZD7QT/ylETkALKTdDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRqnJ4AnYBQIxGyhQMJ/O3Mjx1FLgpo7oOPnGWi/EfbWCBxslS7Riorz9yBJ++D1Lo0wsW1tNNpiqDjzdrgkxpwD18Hp2UK8kjL3TwZKmMyWS2iK+QYe2KJtwKGKrZZKojTEwPczcSX7x+kHiVmWIQfKCFDoVPdynRe3SC5C32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HqS+oCjy; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-60585faa69fso285490a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713995960; x=1714600760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gS/+fdiiZEZAb6nf4x6NL+H6n5ee2OMETAMQVQ4LvTs=;
        b=HqS+oCjyfEbkkeKdRFHM6W5T2Udya+KQ6H+a89EMvHUphABhnGdErVfWKbkKxcZ7Nb
         +hMF1kTecEGUXT/kcoXFZiYHHLqAmexvNsx1piT/lXwIr7sDWVvuKrog9j2VbgvIvom8
         KQpvvaAJx1uSb1pMbpyuWiRgbYVSZDsJT6P0FU/zKKXYOOUyeIwCQceyJTRZTl0Zep/r
         rkqsKU6cCc/101qjYwkq2AoUFIYd5geiGw5me34Ac90VjqlvvWB/nrOJ2IbjWJuZAHG1
         HCts8NDeTGYmwoltKuVwRZwtKlXh2g/YHjUI+yeF+1+bhpRgWVQboqzm440LPdC9daY7
         dQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713995960; x=1714600760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gS/+fdiiZEZAb6nf4x6NL+H6n5ee2OMETAMQVQ4LvTs=;
        b=fRqo2ewq2v73HPq/LvhoV4mFfiptBECfoJ1ibws6rHtlqBcO7o+Px5OoKJPswjc8XF
         1eJCodzxMGlvgWpqotd8mGLYNc+cm/U6U1HM40Dr0iz130pznoX+UfXWyGxRSEshB2SZ
         h9chhJpQlwrxbSYRnmtPwIOtUi4HXWfn6k7xsN7H+OViwsp3wd+IPGjYCCCcEzlLWhh8
         xTks0MQOIGyWU6FZ/sw5lPvlVoajx1uMYSLPf/edhdvjT9uT18zPf7owvuXTpPkAY2GQ
         cMtaE9MbkwXwNbWcDiIPNYtEMvt5V+H26y4OJXpKGmzYVoJNdWu7f6T8AgDgeDEVTtVc
         Juyg==
X-Forwarded-Encrypted: i=1; AJvYcCXuoT/kWnm/xZOiCq6yapzXMXKZBXBjx6DB0MBHmFoiqgaw3d2tvpI+o0b+Nq+spBr6dh1kl0QNPsMAvFf7Q2dgQL23rD1Wcqq3tcvt
X-Gm-Message-State: AOJu0YwTq5eOfigDnj6Qrr9x/6zjY5EAjdACGkrSEWUhptoL71FiG+L/
	VWrjw67IeV5TnmmHNjFVUV6OyUjv6uHkdFsrUCEWyVWV/oRZGlwdZiWDwVQRLmkNxEuyJ5Suk4z
	2r27oJobz9S2/pDOGQ+mOPwJjECplUIiPAykmGQ==
X-Google-Smtp-Source: AGHT+IFhjjvtl6urVgHbuvLaOpmLALCnFwP9LVrPW7ESf2h3rSIWppXXCFY7pFG7DoR45m0Ff/bRXiIWFqL/KjwEWxA=
X-Received: by 2002:a17:90b:792:b0:2a5:506f:161c with SMTP id
 l18-20020a17090b079200b002a5506f161cmr1408363pjz.4.1713995959168; Wed, 24 Apr
 2024 14:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713456597.git.tjeznach@rivosinc.com> <741996169fef074b5d9f4f218c2a98bf5dd38386.1713456598.git.tjeznach@rivosinc.com>
 <7f9a82ea-c4c8-40a5-8f26-7cb135e91c5d@arm.com>
In-Reply-To: <7f9a82ea-c4c8-40a5-8f26-7cb135e91c5d@arm.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 24 Apr 2024 14:59:08 -0700
Message-ID: <CAH2o1u6FpDWNZsQCADQQKauPYzxDE73DRHHQKw6LjNb27ePeXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] iommu/riscv: Add RISC-V IOMMU platform device driver
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 2:22=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2024-04-18 5:32 pm, Tomasz Jeznach wrote:
> > Introduce platform device driver for implementation of RISC-V IOMMU
> > architected hardware.
> >
> > Hardware interface definition located in file iommu-bits.h is based on
> > ratified RISC-V IOMMU Architecture Specification version 1.0.0.
> >
> > This patch implements platform device initialization, early check and
> > configuration of the IOMMU interfaces and enables global pass-through
> > address translation mode (iommu_mode =3D=3D BARE), without registering
> > hardware instance in the IOMMU subsystem.
> >
> > Link: https://github.com/riscv-non-isa/riscv-iommu
> > Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> > Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> > Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> > Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > ---
> >   MAINTAINERS                          |   6 +
> >   drivers/iommu/Kconfig                |   1 +
> >   drivers/iommu/Makefile               |   2 +-
> >   drivers/iommu/riscv/Kconfig          |  16 +
> >   drivers/iommu/riscv/Makefile         |   2 +
> >   drivers/iommu/riscv/iommu-bits.h     | 707 ++++++++++++++++++++++++++=
+
> >   drivers/iommu/riscv/iommu-platform.c |  94 ++++
> >   drivers/iommu/riscv/iommu.c          |  89 ++++
> >   drivers/iommu/riscv/iommu.h          |  62 +++
> >   9 files changed, 978 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/iommu/riscv/Kconfig
> >   create mode 100644 drivers/iommu/riscv/Makefile
> >   create mode 100644 drivers/iommu/riscv/iommu-bits.h
> >   create mode 100644 drivers/iommu/riscv/iommu-platform.c
> >   create mode 100644 drivers/iommu/riscv/iommu.c
> >   create mode 100644 drivers/iommu/riscv/iommu.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2657f9eae84c..051599c76585 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18972,6 +18972,12 @@ L:   iommu@lists.linux.dev
> >   L:  linux-riscv@lists.infradead.org
> >   S:  Maintained
> >   F:  Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > +F:   drivers/iommu/riscv/Kconfig
> > +F:   drivers/iommu/riscv/Makefile
> > +F:   drivers/iommu/riscv/iommu-bits.h
> > +F:   drivers/iommu/riscv/iommu-platform.c
> > +F:   drivers/iommu/riscv/iommu.c
> > +F:   drivers/iommu/riscv/iommu.h
>
> I'm pretty sure a single "F: drivers/iommu/riscv/" pattern will suffice.
>

Correct. But will required a workaround for pretty naive MAINTAINERS update
check in scripts/checkpatch.pl:3014 in next patch.

> >   RISC-V MICROCHIP FPGA SUPPORT
> >   M:  Conor Dooley <conor.dooley@microchip.com>
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 0af39bbbe3a3..ae762db0365e 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -195,6 +195,7 @@ config MSM_IOMMU
> >   source "drivers/iommu/amd/Kconfig"
> >   source "drivers/iommu/intel/Kconfig"
> >   source "drivers/iommu/iommufd/Kconfig"
> > +source "drivers/iommu/riscv/Kconfig"
> >
> >   config IRQ_REMAP
> >       bool "Support for Interrupt Remapping"
> > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > index 542760d963ec..5e5a83c6c2aa 100644
> > --- a/drivers/iommu/Makefile
> > +++ b/drivers/iommu/Makefile
> > @@ -1,5 +1,5 @@
> >   # SPDX-License-Identifier: GPL-2.0
> > -obj-y +=3D amd/ intel/ arm/ iommufd/
> > +obj-y +=3D amd/ intel/ arm/ iommufd/ riscv/
> >   obj-$(CONFIG_IOMMU_API) +=3D iommu.o
> >   obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
> >   obj-$(CONFIG_IOMMU_API) +=3D iommu-sysfs.o
> > diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> > new file mode 100644
> > index 000000000000..d02326bddb4c
> > --- /dev/null
> > +++ b/drivers/iommu/riscv/Kconfig
> > @@ -0,0 +1,16 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +# RISC-V IOMMU support
> > +
> > +config RISCV_IOMMU
> > +     def_bool y if RISCV && 64BIT && MMU
>
> Drop the dependencies here, they're already dependencies. However, also
> consider allowing users to configure this out without disabling
> IOMMU_SUPPORT entirely - I imagine other IOMMU implementations are going
> to end up paired wiothg RISC-V CPUs sooner or later. Furthermore, if
> it's a regular driver model driver, consider allowing it to build as a
> module. Not to mention that the help text below is rather pointless if
> there's no prompt offered in the first place.
>

Ack. Changed to optional builtin driver for now, also cleaned up all
module info.
I'll revisit proper module build later.

> > +     depends on RISCV && 64BIT && MMU
> > +     select DMA_OPS
>
> Drop this, you're not (and shouldn't be) architecture code implementing
> DMA ops.
>
> > +     select IOMMU_API
> > +     select IOMMU_IOVA
>
> Drop this, you're not using the IOVA library either.
>
> > +     help
> > +       Support for implementations of the RISC-V IOMMU architecture th=
at
> > +       complements the RISC-V MMU capabilities, providing similar addr=
ess
> > +       translation and protection functions for accesses from I/O devi=
ces.
> > +
> > +       Say Y here if your SoC includes an IOMMU device implementing
> > +       the RISC-V IOMMU architecture.
> > diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefil=
e
> > new file mode 100644
> > index 000000000000..e4c189de58d3
> > --- /dev/null
> > +++ b/drivers/iommu/riscv/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-platform.o
> > diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iom=
mu-bits.h
> > new file mode 100644
> > index 000000000000..ba093c29de9f
> > --- /dev/null
> > +++ b/drivers/iommu/riscv/iommu-bits.h
> > @@ -0,0 +1,707 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright =C2=A9 2022-2024 Rivos Inc.
> > + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> > + * Copyright =C2=A9 2023 RISC-V IOMMU Task Group
> > + *
> > + * RISC-V IOMMU - Register Layout and Data Structures.
> > + *
> > + * Based on the 'RISC-V IOMMU Architecture Specification', Version 1.0
> > + * Published at  https://github.com/riscv-non-isa/riscv-iommu
> > + *
> > + */
> > +
> > +#ifndef _RISCV_IOMMU_BITS_H_
> > +#define _RISCV_IOMMU_BITS_H_
> > +
> > +#include <linux/types.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +
> > +/*
> > + * Chapter 5: Memory Mapped register interface
> > + */
> > +
> > +/* Common field positions */
> > +#define RISCV_IOMMU_PPN_FIELD                GENMASK_ULL(53, 10)
> > +#define RISCV_IOMMU_QUEUE_LOGSZ_FIELD        GENMASK_ULL(4, 0)
> > +#define RISCV_IOMMU_QUEUE_INDEX_FIELD        GENMASK_ULL(31, 0)
> > +#define RISCV_IOMMU_QUEUE_ENABLE     BIT(0)
> > +#define RISCV_IOMMU_QUEUE_INTR_ENABLE        BIT(1)
> > +#define RISCV_IOMMU_QUEUE_MEM_FAULT  BIT(8)
> > +#define RISCV_IOMMU_QUEUE_OVERFLOW   BIT(9)
> > +#define RISCV_IOMMU_QUEUE_ACTIVE     BIT(16)
> > +#define RISCV_IOMMU_QUEUE_BUSY               BIT(17)
> > +
> > +#define RISCV_IOMMU_ATP_PPN_FIELD    GENMASK_ULL(43, 0)
> > +#define RISCV_IOMMU_ATP_MODE_FIELD   GENMASK_ULL(63, 60)
> > +
> > +/* 5.3 IOMMU Capabilities (64bits) */
> > +#define RISCV_IOMMU_REG_CAP          0x0000
> > +#define RISCV_IOMMU_CAP_VERSION              GENMASK_ULL(7, 0)
> > +#define RISCV_IOMMU_CAP_S_SV32               BIT_ULL(8)
> > +#define RISCV_IOMMU_CAP_S_SV39               BIT_ULL(9)
> > +#define RISCV_IOMMU_CAP_S_SV48               BIT_ULL(10)
> > +#define RISCV_IOMMU_CAP_S_SV57               BIT_ULL(11)
> > +#define RISCV_IOMMU_CAP_SVPBMT               BIT_ULL(15)
> > +#define RISCV_IOMMU_CAP_G_SV32               BIT_ULL(16)
> > +#define RISCV_IOMMU_CAP_G_SV39               BIT_ULL(17)
> > +#define RISCV_IOMMU_CAP_G_SV48               BIT_ULL(18)
> > +#define RISCV_IOMMU_CAP_G_SV57               BIT_ULL(19)
> > +#define RISCV_IOMMU_CAP_AMO_MRIF     BIT_ULL(21)
> > +#define RISCV_IOMMU_CAP_MSI_FLAT     BIT_ULL(22)
> > +#define RISCV_IOMMU_CAP_MSI_MRIF     BIT_ULL(23)
> > +#define RISCV_IOMMU_CAP_AMO_HWAD     BIT_ULL(24)
> > +#define RISCV_IOMMU_CAP_ATS          BIT_ULL(25)
> > +#define RISCV_IOMMU_CAP_T2GPA                BIT_ULL(26)
> > +#define RISCV_IOMMU_CAP_END          BIT_ULL(27)
> > +#define RISCV_IOMMU_CAP_IGS          GENMASK_ULL(29, 28)
> > +#define RISCV_IOMMU_CAP_HPM          BIT_ULL(30)
> > +#define RISCV_IOMMU_CAP_DBG          BIT_ULL(31)
> > +#define RISCV_IOMMU_CAP_PAS          GENMASK_ULL(37, 32)
> > +#define RISCV_IOMMU_CAP_PD8          BIT_ULL(38)
> > +#define RISCV_IOMMU_CAP_PD17         BIT_ULL(39)
> > +#define RISCV_IOMMU_CAP_PD20         BIT_ULL(40)
> > +
> > +#define RISCV_IOMMU_CAP_VERSION_VER_MASK     0xF0
> > +#define RISCV_IOMMU_CAP_VERSION_REV_MASK     0x0F
> > +
> > +/**
> > + * enum riscv_iommu_igs_settings - Interrupt Generation Support Settin=
gs
> > + * @RISCV_IOMMU_CAP_IGS_MSI: I/O MMU supports only MSI generation
> > + * @RISCV_IOMMU_CAP_IGS_WSI: I/O MMU supports only Wired-Signaled inte=
rrupt
> > + * @RISCV_IOMMU_CAP_IGS_BOTH: I/O MMU supports both MSI and WSI genera=
tion
> > + * @RISCV_IOMMU_CAP_IGS_RSRV: Reserved for standard use
> > + */
> > +enum riscv_iommu_igs_settings {
> > +     RISCV_IOMMU_CAP_IGS_MSI =3D 0,
> > +     RISCV_IOMMU_CAP_IGS_WSI =3D 1,
> > +     RISCV_IOMMU_CAP_IGS_BOTH =3D 2,
> > +     RISCV_IOMMU_CAP_IGS_RSRV =3D 3
> > +};
> > +
> > +/* 5.4 Features control register (32bits) */
> > +#define RISCV_IOMMU_REG_FCTL         0x0008
> > +#define RISCV_IOMMU_FCTL_BE          BIT(0)
> > +#define RISCV_IOMMU_FCTL_WSI         BIT(1)
> > +#define RISCV_IOMMU_FCTL_GXL         BIT(2)
> > +
> > +/* 5.5 Device-directory-table pointer (64bits) */
> > +#define RISCV_IOMMU_REG_DDTP         0x0010
> > +#define RISCV_IOMMU_DDTP_MODE                GENMASK_ULL(3, 0)
> > +#define RISCV_IOMMU_DDTP_BUSY                BIT_ULL(4)
> > +#define RISCV_IOMMU_DDTP_PPN         RISCV_IOMMU_PPN_FIELD
> > +
> > +/**
> > + * enum riscv_iommu_ddtp_modes - I/O MMU translation modes
> > + * @RISCV_IOMMU_DDTP_MODE_OFF: No inbound transactions allowed
> > + * @RISCV_IOMMU_DDTP_MODE_BARE: Pass-through mode
> > + * @RISCV_IOMMU_DDTP_MODE_1LVL: One-level DDT
> > + * @RISCV_IOMMU_DDTP_MODE_2LVL: Two-level DDT
> > + * @RISCV_IOMMU_DDTP_MODE_3LVL: Three-level DDT
> > + * @RISCV_IOMMU_DDTP_MODE_MAX: Max value allowed by specification
> > + */
> > +enum riscv_iommu_ddtp_modes {
> > +     RISCV_IOMMU_DDTP_MODE_OFF =3D 0,
> > +     RISCV_IOMMU_DDTP_MODE_BARE =3D 1,
> > +     RISCV_IOMMU_DDTP_MODE_1LVL =3D 2,
> > +     RISCV_IOMMU_DDTP_MODE_2LVL =3D 3,
> > +     RISCV_IOMMU_DDTP_MODE_3LVL =3D 4,
> > +     RISCV_IOMMU_DDTP_MODE_MAX =3D 4
> > +};
> > +
> > +/* 5.6 Command Queue Base (64bits) */
> > +#define RISCV_IOMMU_REG_CQB          0x0018
> > +#define RISCV_IOMMU_CQB_ENTRIES              RISCV_IOMMU_QUEUE_LOGSZ_F=
IELD
> > +#define RISCV_IOMMU_CQB_PPN          RISCV_IOMMU_PPN_FIELD
> > +
> > +/* 5.7 Command Queue head (32bits) */
> > +#define RISCV_IOMMU_REG_CQH          0x0020
> > +#define RISCV_IOMMU_CQH_INDEX                RISCV_IOMMU_QUEUE_INDEX_F=
IELD
> > +
> > +/* 5.8 Command Queue tail (32bits) */
> > +#define RISCV_IOMMU_REG_CQT          0x0024
> > +#define RISCV_IOMMU_CQT_INDEX                RISCV_IOMMU_QUEUE_INDEX_F=
IELD
> > +
> > +/* 5.9 Fault Queue Base (64bits) */
> > +#define RISCV_IOMMU_REG_FQB          0x0028
> > +#define RISCV_IOMMU_FQB_ENTRIES              RISCV_IOMMU_QUEUE_LOGSZ_F=
IELD
> > +#define RISCV_IOMMU_FQB_PPN          RISCV_IOMMU_PPN_FIELD
> > +
> > +/* 5.10 Fault Queue Head (32bits) */
> > +#define RISCV_IOMMU_REG_FQH          0x0030
> > +#define RISCV_IOMMU_FQH_INDEX                RISCV_IOMMU_QUEUE_INDEX_F=
IELD
> > +
> > +/* 5.11 Fault Queue tail (32bits) */
> > +#define RISCV_IOMMU_REG_FQT          0x0034
> > +#define RISCV_IOMMU_FQT_INDEX                RISCV_IOMMU_QUEUE_INDEX_F=
IELD
> > +
> > +/* 5.12 Page Request Queue base (64bits) */
> > +#define RISCV_IOMMU_REG_PQB          0x0038
> > +#define RISCV_IOMMU_PQB_ENTRIES              RISCV_IOMMU_QUEUE_LOGSZ_F=
IELD
> > +#define RISCV_IOMMU_PQB_PPN          RISCV_IOMMU_PPN_FIELD
> > +
> > +/* 5.13 Page Request Queue head (32bits) */
> > +#define RISCV_IOMMU_REG_PQH          0x0040
> > +#define RISCV_IOMMU_PQH_INDEX                RISCV_IOMMU_QUEUE_INDEX_F=
IELD
> > +
> > +/* 5.14 Page Request Queue tail (32bits) */
> > +#define RISCV_IOMMU_REG_PQT          0x0044
> > +#define RISCV_IOMMU_PQT_INDEX_MASK   RISCV_IOMMU_QUEUE_INDEX_FIELD
> > +
> > +/* 5.15 Command Queue CSR (32bits) */
> > +#define RISCV_IOMMU_REG_CQCSR                0x0048
> > +#define RISCV_IOMMU_CQCSR_CQEN               RISCV_IOMMU_QUEUE_ENABLE
> > +#define RISCV_IOMMU_CQCSR_CIE                RISCV_IOMMU_QUEUE_INTR_EN=
ABLE
> > +#define RISCV_IOMMU_CQCSR_CQMF               RISCV_IOMMU_QUEUE_MEM_FAU=
LT
> > +#define RISCV_IOMMU_CQCSR_CMD_TO     BIT(9)
> > +#define RISCV_IOMMU_CQCSR_CMD_ILL    BIT(10)
> > +#define RISCV_IOMMU_CQCSR_FENCE_W_IP BIT(11)
> > +#define RISCV_IOMMU_CQCSR_CQON               RISCV_IOMMU_QUEUE_ACTIVE
> > +#define RISCV_IOMMU_CQCSR_BUSY               RISCV_IOMMU_QUEUE_BUSY
> > +
> > +/* 5.16 Fault Queue CSR (32bits) */
> > +#define RISCV_IOMMU_REG_FQCSR                0x004C
> > +#define RISCV_IOMMU_FQCSR_FQEN               RISCV_IOMMU_QUEUE_ENABLE
> > +#define RISCV_IOMMU_FQCSR_FIE                RISCV_IOMMU_QUEUE_INTR_EN=
ABLE
> > +#define RISCV_IOMMU_FQCSR_FQMF               RISCV_IOMMU_QUEUE_MEM_FAU=
LT
> > +#define RISCV_IOMMU_FQCSR_FQOF               RISCV_IOMMU_QUEUE_OVERFLO=
W
> > +#define RISCV_IOMMU_FQCSR_FQON               RISCV_IOMMU_QUEUE_ACTIVE
> > +#define RISCV_IOMMU_FQCSR_BUSY               RISCV_IOMMU_QUEUE_BUSY
> > +
> > +/* 5.17 Page Request Queue CSR (32bits) */
> > +#define RISCV_IOMMU_REG_PQCSR                0x0050
> > +#define RISCV_IOMMU_PQCSR_PQEN               RISCV_IOMMU_QUEUE_ENABLE
> > +#define RISCV_IOMMU_PQCSR_PIE                RISCV_IOMMU_QUEUE_INTR_EN=
ABLE
> > +#define RISCV_IOMMU_PQCSR_PQMF               RISCV_IOMMU_QUEUE_MEM_FAU=
LT
> > +#define RISCV_IOMMU_PQCSR_PQOF               RISCV_IOMMU_QUEUE_OVERFLO=
W
> > +#define RISCV_IOMMU_PQCSR_PQON               RISCV_IOMMU_QUEUE_ACTIVE
> > +#define RISCV_IOMMU_PQCSR_BUSY               RISCV_IOMMU_QUEUE_BUSY
> > +
> > +/* 5.18 Interrupt Pending Status (32bits) */
> > +#define RISCV_IOMMU_REG_IPSR         0x0054
> > +
> > +#define RISCV_IOMMU_INTR_CQ          0
> > +#define RISCV_IOMMU_INTR_FQ          1
> > +#define RISCV_IOMMU_INTR_PM          2
> > +#define RISCV_IOMMU_INTR_PQ          3
> > +#define RISCV_IOMMU_INTR_COUNT               4
> > +
> > +#define RISCV_IOMMU_IPSR_CIP         BIT(RISCV_IOMMU_INTR_CQ)
> > +#define RISCV_IOMMU_IPSR_FIP         BIT(RISCV_IOMMU_INTR_FQ)
> > +#define RISCV_IOMMU_IPSR_PMIP                BIT(RISCV_IOMMU_INTR_PM)
> > +#define RISCV_IOMMU_IPSR_PIP         BIT(RISCV_IOMMU_INTR_PQ)
> > +
> > +/* 5.19 Performance monitoring counter overflow status (32bits) */
> > +#define RISCV_IOMMU_REG_IOCOUNTOVF   0x0058
> > +#define RISCV_IOMMU_IOCOUNTOVF_CY    BIT(0)
> > +#define RISCV_IOMMU_IOCOUNTOVF_HPM   GENMASK_ULL(31, 1)
> > +
> > +/* 5.20 Performance monitoring counter inhibits (32bits) */
> > +#define RISCV_IOMMU_REG_IOCOUNTINH   0x005C
> > +#define RISCV_IOMMU_IOCOUNTINH_CY    BIT(0)
> > +#define RISCV_IOMMU_IOCOUNTINH_HPM   GENMASK(31, 1)
> > +
> > +/* 5.21 Performance monitoring cycles counter (64bits) */
> > +#define RISCV_IOMMU_REG_IOHPMCYCLES     0x0060
> > +#define RISCV_IOMMU_IOHPMCYCLES_COUNTER      GENMASK_ULL(62, 0)
> > +#define RISCV_IOMMU_IOHPMCYCLES_OVF  BIT_ULL(63)
> > +
> > +/* 5.22 Performance monitoring event counters (31 * 64bits) */
> > +#define RISCV_IOMMU_REG_IOHPMCTR_BASE        0x0068
> > +#define RISCV_IOMMU_REG_IOHPMCTR(_n) (RISCV_IOMMU_REG_IOHPMCTR_BASE + =
((_n) * 0x8))
> > +
> > +/* 5.23 Performance monitoring event selectors (31 * 64bits) */
> > +#define RISCV_IOMMU_REG_IOHPMEVT_BASE        0x0160
> > +#define RISCV_IOMMU_REG_IOHPMEVT(_n) (RISCV_IOMMU_REG_IOHPMEVT_BASE + =
((_n) * 0x8))
> > +#define RISCV_IOMMU_IOHPMEVT_CNT     31
> > +#define RISCV_IOMMU_IOHPMEVT_EVENT_ID        GENMASK_ULL(14, 0)
> > +#define RISCV_IOMMU_IOHPMEVT_DMASK   BIT_ULL(15)
> > +#define RISCV_IOMMU_IOHPMEVT_PID_PSCID       GENMASK_ULL(35, 16)
> > +#define RISCV_IOMMU_IOHPMEVT_DID_GSCID       GENMASK_ULL(59, 36)
> > +#define RISCV_IOMMU_IOHPMEVT_PV_PSCV BIT_ULL(60)
> > +#define RISCV_IOMMU_IOHPMEVT_DV_GSCV BIT_ULL(61)
> > +#define RISCV_IOMMU_IOHPMEVT_IDT     BIT_ULL(62)
> > +#define RISCV_IOMMU_IOHPMEVT_OF              BIT_ULL(63)
> > +
> > +/**
> > + * enum riscv_iommu_hpmevent_id - Performance-monitoring event identif=
ier
> > + *
> > + * @RISCV_IOMMU_HPMEVENT_INVALID: Invalid event, do not count
> > + * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
> > + * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
> > + * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
> > + * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
> > + * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
> > + * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
> > + * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: S/VS-Stage page table walks
> > + * @RISCV_IOMMU_HPMEVENT_G_WALKS: G-Stage page table walks
> > + * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event IDs
> > + */
> > +enum riscv_iommu_hpmevent_id {
> > +     RISCV_IOMMU_HPMEVENT_INVALID    =3D 0,
> > +     RISCV_IOMMU_HPMEVENT_URQ        =3D 1,
> > +     RISCV_IOMMU_HPMEVENT_TRQ        =3D 2,
> > +     RISCV_IOMMU_HPMEVENT_ATS_RQ     =3D 3,
> > +     RISCV_IOMMU_HPMEVENT_TLB_MISS   =3D 4,
> > +     RISCV_IOMMU_HPMEVENT_DD_WALK    =3D 5,
> > +     RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
> > +     RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
> > +     RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
> > +     RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> > +};
> > +
> > +/* 5.24 Translation request IOVA (64bits) */
> > +#define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
> > +#define RISCV_IOMMU_TR_REQ_IOVA_VPN  GENMASK_ULL(63, 12)
> > +
> > +/* 5.25 Translation request control (64bits) */
> > +#define RISCV_IOMMU_REG_TR_REQ_CTL   0x0260
> > +#define RISCV_IOMMU_TR_REQ_CTL_GO_BUSY       BIT_ULL(0)
> > +#define RISCV_IOMMU_TR_REQ_CTL_PRIV  BIT_ULL(1)
> > +#define RISCV_IOMMU_TR_REQ_CTL_EXE   BIT_ULL(2)
> > +#define RISCV_IOMMU_TR_REQ_CTL_NW    BIT_ULL(3)
> > +#define RISCV_IOMMU_TR_REQ_CTL_PID   GENMASK_ULL(31, 12)
> > +#define RISCV_IOMMU_TR_REQ_CTL_PV    BIT_ULL(32)
> > +#define RISCV_IOMMU_TR_REQ_CTL_DID   GENMASK_ULL(63, 40)
> > +
> > +/* 5.26 Translation request response (64bits) */
> > +#define RISCV_IOMMU_REG_TR_RESPONSE  0x0268
> > +#define RISCV_IOMMU_TR_RESPONSE_FAULT        BIT_ULL(0)
> > +#define RISCV_IOMMU_TR_RESPONSE_PBMT GENMASK_ULL(8, 7)
> > +#define RISCV_IOMMU_TR_RESPONSE_SZ   BIT_ULL(9)
> > +#define RISCV_IOMMU_TR_RESPONSE_PPN  RISCV_IOMMU_PPN_FIELD
> > +
> > +/* 5.27 Interrupt cause to vector (64bits) */
> > +#define RISCV_IOMMU_REG_IVEC         0x02F8
> > +#define RISCV_IOMMU_IVEC_CIV         GENMASK_ULL(3, 0)
> > +#define RISCV_IOMMU_IVEC_FIV         GENMASK_ULL(7, 4)
> > +#define RISCV_IOMMU_IVEC_PMIV                GENMASK_ULL(11, 8)
> > +#define RISCV_IOMMU_IVEC_PIV         GENMASK_ULL(15, 12)
> > +
> > +/* 5.28 MSI Configuration table (32 * 64bits) */
> > +#define RISCV_IOMMU_REG_MSI_CONFIG   0x0300
> > +#define RISCV_IOMMU_REG_MSI_ADDR(_n) (RISCV_IOMMU_REG_MSI_CONFIG + ((_=
n) * 0x10))
> > +#define RISCV_IOMMU_MSI_ADDR         GENMASK_ULL(55, 2)
> > +#define RISCV_IOMMU_REG_MSI_DATA(_n) (RISCV_IOMMU_REG_MSI_CONFIG + ((_=
n) * 0x10) + 0x08)
> > +#define RISCV_IOMMU_MSI_DATA         GENMASK_ULL(31, 0)
> > +#define RISCV_IOMMU_REG_MSI_VEC_CTL(_n)      (RISCV_IOMMU_REG_MSI_CONF=
IG + ((_n) * 0x10) + 0x0C)
> > +#define RISCV_IOMMU_MSI_VEC_CTL_M    BIT_ULL(0)
> > +
> > +#define RISCV_IOMMU_REG_SIZE 0x1000
> > +
> > +/*
> > + * Chapter 2: Data structures
> > + */
> > +
> > +/*
> > + * Device Directory Table macros for non-leaf nodes
> > + */
> > +#define RISCV_IOMMU_DDTE_VALID       BIT_ULL(0)
> > +#define RISCV_IOMMU_DDTE_PPN RISCV_IOMMU_PPN_FIELD
> > +
> > +/**
> > + * struct riscv_iommu_dc - Device Context
> > + * @tc: Translation Control
> > + * @iohgatp: I/O Hypervisor guest address translation and protection
> > + *        (Second stage context)
> > + * @ta: Translation Attributes
> > + * @fsc: First stage context
> > + * @msiptp: MSI page table pointer
> > + * @msi_addr_mask: MSI address mask
> > + * @msi_addr_pattern: MSI address pattern
> > + * @_reserved: Reserved for future use, padding
> > + *
> > + * This structure is used for leaf nodes on the Device Directory Table=
,
> > + * in case RISCV_IOMMU_CAP_MSI_FLAT is not set, the bottom 4 fields ar=
e
> > + * not present and are skipped with pointer arithmetic to avoid
> > + * casting, check out riscv_iommu_get_dc().
> > + * See section 2.1 for more details
> > + */
> > +struct riscv_iommu_dc {
> > +     u64 tc;
> > +     u64 iohgatp;
> > +     u64 ta;
> > +     u64 fsc;
> > +     u64 msiptp;
> > +     u64 msi_addr_mask;
> > +     u64 msi_addr_pattern;
> > +     u64 _reserved;
> > +};
> > +
> > +/* Translation control fields */
> > +#define RISCV_IOMMU_DC_TC_V          BIT_ULL(0)
> > +#define RISCV_IOMMU_DC_TC_EN_ATS     BIT_ULL(1)
> > +#define RISCV_IOMMU_DC_TC_EN_PRI     BIT_ULL(2)
> > +#define RISCV_IOMMU_DC_TC_T2GPA              BIT_ULL(3)
> > +#define RISCV_IOMMU_DC_TC_DTF                BIT_ULL(4)
> > +#define RISCV_IOMMU_DC_TC_PDTV               BIT_ULL(5)
> > +#define RISCV_IOMMU_DC_TC_PRPR               BIT_ULL(6)
> > +#define RISCV_IOMMU_DC_TC_GADE               BIT_ULL(7)
> > +#define RISCV_IOMMU_DC_TC_SADE               BIT_ULL(8)
> > +#define RISCV_IOMMU_DC_TC_DPE                BIT_ULL(9)
> > +#define RISCV_IOMMU_DC_TC_SBE                BIT_ULL(10)
> > +#define RISCV_IOMMU_DC_TC_SXL                BIT_ULL(11)
> > +
> > +/* Second-stage (aka G-stage) context fields */
> > +#define RISCV_IOMMU_DC_IOHGATP_PPN   RISCV_IOMMU_ATP_PPN_FIELD
> > +#define RISCV_IOMMU_DC_IOHGATP_GSCID GENMASK_ULL(59, 44)
> > +#define RISCV_IOMMU_DC_IOHGATP_MODE  RISCV_IOMMU_ATP_MODE_FIELD
> > +
> > +/**
> > + * enum riscv_iommu_dc_iohgatp_modes - Guest address translation/prote=
ction modes
> > + * @RISCV_IOMMU_DC_IOHGATP_MODE_BARE: No translation/protection
> > + * @RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4: Sv32x4 (2-bit extension of Sv3=
2), when fctl.GXL =3D=3D 1
> > + * @RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4: Sv39x4 (2-bit extension of Sv3=
9), when fctl.GXL =3D=3D 0
> > + * @RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4: Sv48x4 (2-bit extension of Sv4=
8), when fctl.GXL =3D=3D 0
> > + * @RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4: Sv57x4 (2-bit extension of Sv5=
7), when fctl.GXL =3D=3D 0
> > + */
> > +enum riscv_iommu_dc_iohgatp_modes {
> > +     RISCV_IOMMU_DC_IOHGATP_MODE_BARE =3D 0,
> > +     RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4 =3D 8,
> > +     RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4 =3D 8,
> > +     RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4 =3D 9,
> > +     RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4 =3D 10
> > +};
> > +
> > +/* Translation attributes fields */
> > +#define RISCV_IOMMU_DC_TA_PSCID              GENMASK_ULL(31, 12)
> > +
> > +/* First-stage context fields */
> > +#define RISCV_IOMMU_DC_FSC_PPN               RISCV_IOMMU_ATP_PPN_FIELD
> > +#define RISCV_IOMMU_DC_FSC_MODE              RISCV_IOMMU_ATP_MODE_FIEL=
D
> > +
> > +/**
> > + * enum riscv_iommu_dc_fsc_atp_modes - First stage address translation=
/protection modes
> > + * @RISCV_IOMMU_DC_FSC_MODE_BARE: No translation/protection
> > + * @RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32: Sv32, when dc.tc.SXL =3D=3D 1
> > + * @RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39: Sv39, when dc.tc.SXL =3D=3D 0
> > + * @RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48: Sv48, when dc.tc.SXL =3D=3D 0
> > + * @RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57: Sv57, when dc.tc.SXL =3D=3D 0
> > + * @RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8: 1lvl PDT, 8bit process ids
> > + * @RISCV_IOMMU_DC_FSC_PDTP_MODE_PD17: 2lvl PDT, 17bit process ids
> > + * @RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20: 3lvl PDT, 20bit process ids
> > + *
> > + * FSC holds IOSATP when RISCV_IOMMU_DC_TC_PDTV is 0 and PDTP otherwis=
e.
> > + * IOSATP controls the first stage address translation (same as the sa=
tp register on
> > + * the RISC-V MMU), and PDTP holds the process directory table, used t=
o select a
> > + * first stage page table based on a process id (for devices that supp=
ort multiple
> > + * process ids).
> > + */
> > +enum riscv_iommu_dc_fsc_atp_modes {
> > +     RISCV_IOMMU_DC_FSC_MODE_BARE =3D 0,
> > +     RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 =3D 8,
> > +     RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 =3D 8,
> > +     RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48 =3D 9,
> > +     RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57 =3D 10,
> > +     RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8 =3D 1,
> > +     RISCV_IOMMU_DC_FSC_PDTP_MODE_PD17 =3D 2,
> > +     RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20 =3D 3
> > +};
> > +
> > +/* MSI page table pointer */
> > +#define RISCV_IOMMU_DC_MSIPTP_PPN    RISCV_IOMMU_ATP_PPN_FIELD
> > +#define RISCV_IOMMU_DC_MSIPTP_MODE   RISCV_IOMMU_ATP_MODE_FIELD
> > +#define RISCV_IOMMU_DC_MSIPTP_MODE_OFF       0
> > +#define RISCV_IOMMU_DC_MSIPTP_MODE_FLAT      1
> > +
> > +/* MSI address mask */
> > +#define RISCV_IOMMU_DC_MSI_ADDR_MASK GENMASK_ULL(51, 0)
> > +
> > +/* MSI address pattern */
> > +#define RISCV_IOMMU_DC_MSI_PATTERN   GENMASK_ULL(51, 0)
> > +
> > +/**
> > + * struct riscv_iommu_pc - Process Context
> > + * @ta: Translation Attributes
> > + * @fsc: First stage context
> > + *
> > + * This structure is used for leaf nodes on the Process Directory Tabl=
e
> > + * See section 2.3 for more details
> > + */
> > +struct riscv_iommu_pc {
> > +     u64 ta;
> > +     u64 fsc;
> > +};
> > +
> > +/* Translation attributes fields */
> > +#define RISCV_IOMMU_PC_TA_V  BIT_ULL(0)
> > +#define RISCV_IOMMU_PC_TA_ENS        BIT_ULL(1)
> > +#define RISCV_IOMMU_PC_TA_SUM        BIT_ULL(2)
> > +#define RISCV_IOMMU_PC_TA_PSCID      GENMASK_ULL(31, 12)
> > +
> > +/* First stage context fields */
> > +#define RISCV_IOMMU_PC_FSC_PPN       RISCV_IOMMU_ATP_PPN_FIELD
> > +#define RISCV_IOMMU_PC_FSC_MODE      RISCV_IOMMU_ATP_MODE_FIELD
> > +
> > +/*
> > + * Chapter 3: In-memory queue interface
> > + */
> > +
> > +/**
> > + * struct riscv_iommu_command - Generic I/O MMU command structure
> > + * @dword0: Includes the opcode and the function identifier
> > + * @dword1: Opcode specific data
> > + *
> > + * The commands are interpreted as two 64bit fields, where the first
> > + * 7bits of the first field are the opcode which also defines the
> > + * command's format, followed by a 3bit field that specifies the
> > + * function invoked by that command, and the rest is opcode-specific.
> > + * This is a generic struct which will be populated differently
> > + * according to each command. For more infos on the commands and
> > + * the command queue check section 3.1.
> > + */
> > +struct riscv_iommu_command {
> > +     u64 dword0;
> > +     u64 dword1;
> > +};
> > +
> > +/* Fields on dword0, common for all commands */
> > +#define RISCV_IOMMU_CMD_OPCODE       GENMASK_ULL(6, 0)
> > +#define      RISCV_IOMMU_CMD_FUNC    GENMASK_ULL(9, 7)
> > +
> > +/* 3.1.1 I/O MMU Page-table cache invalidation */
> > +/* Fields on dword0 */
> > +#define RISCV_IOMMU_CMD_IOTINVAL_OPCODE              1
> > +#define RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA    0
> > +#define RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA   1
> > +#define RISCV_IOMMU_CMD_IOTINVAL_AV          BIT_ULL(10)
> > +#define RISCV_IOMMU_CMD_IOTINVAL_PSCID               GENMASK_ULL(31, 1=
2)
> > +#define RISCV_IOMMU_CMD_IOTINVAL_PSCV                BIT_ULL(32)
> > +#define RISCV_IOMMU_CMD_IOTINVAL_GV          BIT_ULL(33)
> > +#define RISCV_IOMMU_CMD_IOTINVAL_GSCID               GENMASK_ULL(59, 4=
4)
> > +/* dword1[61:10] is the 4K-aligned page address */
> > +#define RISCV_IOMMU_CMD_IOTINVAL_ADDR                GENMASK_ULL(61, 1=
0)
> > +
> > +/* 3.1.2 I/O MMU Command Queue Fences */
> > +/* Fields on dword0 */
> > +#define RISCV_IOMMU_CMD_IOFENCE_OPCODE               2
> > +#define RISCV_IOMMU_CMD_IOFENCE_FUNC_C               0
> > +#define RISCV_IOMMU_CMD_IOFENCE_AV           BIT_ULL(10)
> > +#define RISCV_IOMMU_CMD_IOFENCE_WSI          BIT_ULL(11)
> > +#define RISCV_IOMMU_CMD_IOFENCE_PR           BIT_ULL(12)
> > +#define RISCV_IOMMU_CMD_IOFENCE_PW           BIT_ULL(13)
> > +#define RISCV_IOMMU_CMD_IOFENCE_DATA         GENMASK_ULL(63, 32)
> > +/* dword1 is the address, word-size aligned and shifted to the right b=
y two bits. */
> > +
> > +/* 3.1.3 I/O MMU Directory cache invalidation */
> > +/* Fields on dword0 */
> > +#define RISCV_IOMMU_CMD_IODIR_OPCODE         3
> > +#define RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT 0
> > +#define RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT 1
> > +#define RISCV_IOMMU_CMD_IODIR_PID            GENMASK_ULL(31, 12)
> > +#define RISCV_IOMMU_CMD_IODIR_DV             BIT_ULL(33)
> > +#define RISCV_IOMMU_CMD_IODIR_DID            GENMASK_ULL(63, 40)
> > +/* dword1 is reserved for standard use */
> > +
> > +/* 3.1.4 I/O MMU PCIe ATS */
> > +/* Fields on dword0 */
> > +#define RISCV_IOMMU_CMD_ATS_OPCODE           4
> > +#define RISCV_IOMMU_CMD_ATS_FUNC_INVAL               0
> > +#define RISCV_IOMMU_CMD_ATS_FUNC_PRGR                1
> > +#define RISCV_IOMMU_CMD_ATS_PID                      GENMASK_ULL(31, 1=
2)
> > +#define RISCV_IOMMU_CMD_ATS_PV                       BIT_ULL(32)
> > +#define RISCV_IOMMU_CMD_ATS_DSV                      BIT_ULL(33)
> > +#define RISCV_IOMMU_CMD_ATS_RID                      GENMASK_ULL(55, 4=
0)
> > +#define RISCV_IOMMU_CMD_ATS_DSEG             GENMASK_ULL(63, 56)
> > +/* dword1 is the ATS payload, two different payload types for INVAL an=
d PRGR */
> > +
> > +/* ATS.INVAL payload*/
> > +#define RISCV_IOMMU_CMD_ATS_INVAL_G          BIT_ULL(0)
> > +/* Bits 1 - 10 are zeroed */
> > +#define RISCV_IOMMU_CMD_ATS_INVAL_S          BIT_ULL(11)
> > +#define RISCV_IOMMU_CMD_ATS_INVAL_UADDR              GENMASK_ULL(63, 1=
2)
> > +
> > +/* ATS.PRGR payload */
> > +/* Bits 0 - 31 are zeroed */
> > +#define RISCV_IOMMU_CMD_ATS_PRGR_PRG_INDEX   GENMASK_ULL(40, 32)
> > +/* Bits 41 - 43 are zeroed */
> > +#define RISCV_IOMMU_CMD_ATS_PRGR_RESP_CODE   GENMASK_ULL(47, 44)
> > +#define RISCV_IOMMU_CMD_ATS_PRGR_DST_ID              GENMASK_ULL(63, 4=
8)
> > +
> > +/**
> > + * struct riscv_iommu_fq_record - Fault/Event Queue Record
> > + * @hdr: Header, includes fault/event cause, PID/DID, transaction type=
 etc
> > + * @_reserved: Low 32bits for custom use, high 32bits for standard use
> > + * @iotval: Transaction-type/cause specific format
> > + * @iotval2: Cause specific format
> > + *
> > + * The fault/event queue reports events and failures raised when
> > + * processing transactions. Each record is a 32byte structure where
> > + * the first dword has a fixed format for providing generic infos
> > + * regarding the fault/event, and two more dwords are there for
> > + * fault/event-specific information. For more details see section
> > + * 3.2.
> > + */
> > +struct riscv_iommu_fq_record {
> > +     u64 hdr;
> > +     u64 _reserved;
> > +     u64 iotval;
> > +     u64 iotval2;
> > +};
> > +
> > +/* Fields on header */
> > +#define RISCV_IOMMU_FQ_HDR_CAUSE     GENMASK_ULL(11, 0)
> > +#define RISCV_IOMMU_FQ_HDR_PID               GENMASK_ULL(31, 12)
> > +#define RISCV_IOMMU_FQ_HDR_PV                BIT_ULL(32)
> > +#define RISCV_IOMMU_FQ_HDR_PRIV              BIT_ULL(33)
> > +#define RISCV_IOMMU_FQ_HDR_TTYPE     GENMASK_ULL(39, 34)
> > +#define RISCV_IOMMU_FQ_HDR_DID               GENMASK_ULL(63, 40)
> > +
> > +/**
> > + * enum riscv_iommu_fq_causes - Fault/event cause values
> > + * @RISCV_IOMMU_FQ_CAUSE_INST_FAULT: Instruction access fault
> > + * @RISCV_IOMMU_FQ_CAUSE_RD_ADDR_MISALIGNED: Read address misaligned
> > + * @RISCV_IOMMU_FQ_CAUSE_RD_FAULT: Read load fault
> > + * @RISCV_IOMMU_FQ_CAUSE_WR_ADDR_MISALIGNED: Write/AMO address misalig=
ned
> > + * @RISCV_IOMMU_FQ_CAUSE_WR_FAULT: Write/AMO access fault
> > + * @RISCV_IOMMU_FQ_CAUSE_INST_FAULT_S: Instruction page fault
> > + * @RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S: Read page fault
> > + * @RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S: Write/AMO page fault
> > + * @RISCV_IOMMU_FQ_CAUSE_INST_FAULT_VS: Instruction guest page fault
> > + * @RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS: Read guest page fault
> > + * @RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS: Write/AMO guest page fault
> > + * @RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED: All inbound transactions disall=
owed
> > + * @RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT: DDT entry load access fault
> > + * @RISCV_IOMMU_FQ_CAUSE_DDT_INVALID: DDT entry invalid
> > + * @RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED: DDT entry misconfigured
> > + * @RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED: Transaction type disallowed
> > + * @RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT: MSI PTE load access fault
> > + * @RISCV_IOMMU_FQ_CAUSE_MSI_INVALID: MSI PTE invalid
> > + * @RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED: MSI PTE misconfigured
> > + * @RISCV_IOMMU_FQ_CAUSE_MRIF_FAULT: MRIF access fault
> > + * @RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT: PDT entry load access fault
> > + * @RISCV_IOMMU_FQ_CAUSE_PDT_INVALID: PDT entry invalid
> > + * @RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED: PDT entry misconfigured
> > + * @RISCV_IOMMU_FQ_CAUSE_DDT_CORRUPTED: DDT data corruption
> > + * @RISCV_IOMMU_FQ_CAUSE_PDT_CORRUPTED: PDT data corruption
> > + * @RISCV_IOMMU_FQ_CAUSE_MSI_PT_CORRUPTED: MSI page table data corrupt=
ion
> > + * @RISCV_IOMMU_FQ_CAUSE_MRIF_CORRUIPTED: MRIF data corruption
> > + * @RISCV_IOMMU_FQ_CAUSE_INTERNAL_DP_ERROR: Internal data path error
> > + * @RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT: IOMMU MSI write access fault
> > + * @RISCV_IOMMU_FQ_CAUSE_PT_CORRUPTED: First/second stage page table d=
ata corruption
> > + *
> > + * Values are on table 11 of the spec, encodings 275 - 2047 are reserv=
ed for standard
> > + * use, and 2048 - 4095 for custom use.
> > + */
> > +enum riscv_iommu_fq_causes {
> > +     RISCV_IOMMU_FQ_CAUSE_INST_FAULT =3D 1,
> > +     RISCV_IOMMU_FQ_CAUSE_RD_ADDR_MISALIGNED =3D 4,
> > +     RISCV_IOMMU_FQ_CAUSE_RD_FAULT =3D 5,
> > +     RISCV_IOMMU_FQ_CAUSE_WR_ADDR_MISALIGNED =3D 6,
> > +     RISCV_IOMMU_FQ_CAUSE_WR_FAULT =3D 7,
> > +     RISCV_IOMMU_FQ_CAUSE_INST_FAULT_S =3D 12,
> > +     RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S =3D 13,
> > +     RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S =3D 15,
> > +     RISCV_IOMMU_FQ_CAUSE_INST_FAULT_VS =3D 20,
> > +     RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS =3D 21,
> > +     RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS =3D 23,
> > +     RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED =3D 256,
> > +     RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT =3D 257,
> > +     RISCV_IOMMU_FQ_CAUSE_DDT_INVALID =3D 258,
> > +     RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED =3D 259,
> > +     RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED =3D 260,
> > +     RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT =3D 261,
> > +     RISCV_IOMMU_FQ_CAUSE_MSI_INVALID =3D 262,
> > +     RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED =3D 263,
> > +     RISCV_IOMMU_FQ_CAUSE_MRIF_FAULT =3D 264,
> > +     RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT =3D 265,
> > +     RISCV_IOMMU_FQ_CAUSE_PDT_INVALID =3D 266,
> > +     RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED =3D 267,
> > +     RISCV_IOMMU_FQ_CAUSE_DDT_CORRUPTED =3D 268,
> > +     RISCV_IOMMU_FQ_CAUSE_PDT_CORRUPTED =3D 269,
> > +     RISCV_IOMMU_FQ_CAUSE_MSI_PT_CORRUPTED =3D 270,
> > +     RISCV_IOMMU_FQ_CAUSE_MRIF_CORRUIPTED =3D 271,
> > +     RISCV_IOMMU_FQ_CAUSE_INTERNAL_DP_ERROR =3D 272,
> > +     RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT =3D 273,
> > +     RISCV_IOMMU_FQ_CAUSE_PT_CORRUPTED =3D 274
> > +};
> > +
> > +/**
> > + * enum riscv_iommu_fq_ttypes: Fault/event transaction types
> > + * @RISCV_IOMMU_FQ_TTYPE_NONE: None. Fault not caused by an inbound tr=
ansaction.
> > + * @RISCV_IOMMU_FQ_TTYPE_UADDR_INST_FETCH: Instruction fetch from untr=
anslated address
> > + * @RISCV_IOMMU_FQ_TTYPE_UADDR_RD: Read from untranslated address
> > + * @RISCV_IOMMU_FQ_TTYPE_UADDR_WR: Write/AMO to untranslated address
> > + * @RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH: Instruction fetch from tran=
slated address
> > + * @RISCV_IOMMU_FQ_TTYPE_TADDR_RD: Read from translated address
> > + * @RISCV_IOMMU_FQ_TTYPE_TADDR_WR: Write/AMO to translated address
> > + * @RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ: PCIe ATS translation request
> > + * @RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ: PCIe message request
> > + *
> > + * Values are on table 12 of the spec, type 4 and 10 - 31 are reserved=
 for standard use
> > + * and 31 - 63 for custom use.
> > + */
> > +enum riscv_iommu_fq_ttypes {
> > +     RISCV_IOMMU_FQ_TTYPE_NONE =3D 0,
> > +     RISCV_IOMMU_FQ_TTYPE_UADDR_INST_FETCH =3D 1,
> > +     RISCV_IOMMU_FQ_TTYPE_UADDR_RD =3D 2,
> > +     RISCV_IOMMU_FQ_TTYPE_UADDR_WR =3D 3,
> > +     RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH =3D 5,
> > +     RISCV_IOMMU_FQ_TTYPE_TADDR_RD =3D 6,
> > +     RISCV_IOMMU_FQ_TTYPE_TADDR_WR =3D 7,
> > +     RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ =3D 8,
> > +     RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ =3D 9,
> > +};
> > +
> > +/**
> > + * struct riscv_iommu_pq_record - PCIe Page Request record
> > + * @hdr: Header, includes PID, DID etc
> > + * @payload: Holds the page address, request group and permission bits
> > + *
> > + * For more infos on the PCIe Page Request queue see chapter 3.3.
> > + */
> > +struct riscv_iommu_pq_record {
> > +     u64 hdr;
> > +     u64 payload;
> > +};
> > +
> > +/* Header fields */
> > +#define RISCV_IOMMU_PREQ_HDR_PID     GENMASK_ULL(31, 12)
> > +#define RISCV_IOMMU_PREQ_HDR_PV              BIT_ULL(32)
> > +#define RISCV_IOMMU_PREQ_HDR_PRIV    BIT_ULL(33)
> > +#define RISCV_IOMMU_PREQ_HDR_EXEC    BIT_ULL(34)
> > +#define RISCV_IOMMU_PREQ_HDR_DID     GENMASK_ULL(63, 40)
> > +
> > +/* Payload fields */
> > +#define RISCV_IOMMU_PREQ_PAYLOAD_R   BIT_ULL(0)
> > +#define RISCV_IOMMU_PREQ_PAYLOAD_W   BIT_ULL(1)
> > +#define RISCV_IOMMU_PREQ_PAYLOAD_L   BIT_ULL(2)
> > +#define RISCV_IOMMU_PREQ_PAYLOAD_M   GENMASK_ULL(2, 0)       /* Mask o=
f RWL for convenience */
> > +#define RISCV_IOMMU_PREQ_PRG_INDEX   GENMASK_ULL(11, 3)
> > +#define RISCV_IOMMU_PREQ_UADDR               GENMASK_ULL(63, 12)
> > +
> > +/**
> > + * struct riscv_iommu_msi_pte - MSI Page Table Entry
> > + * @pte: MSI PTE
> > + * @mrif_info: Memory-resident interrupt file info
> > + *
> > + * The MSI Page Table is used for virtualizing MSIs, so that when
> > + * a device sends an MSI to a guest, the IOMMU can reroute it
> > + * by translating the MSI address, either to a guest interrupt file
> > + * or a memory resident interrupt file (MRIF). Note that this page tab=
le
> > + * is an array of MSI PTEs, not a multi-level pt, each entry
> > + * is a leaf entry. For more infos check out the AIA spec, chapter 9.5=
.
> > + *
> > + * Also in basic mode the mrif_info field is ignored by the IOMMU and =
can
> > + * be used by software, any other reserved fields on pte must be zeroe=
d-out
> > + * by software.
> > + */
> > +struct riscv_iommu_msi_pte {
> > +     u64 pte;
> > +     u64 mrif_info;
> > +};
> > +
> > +/* Fields on pte */
> > +#define RISCV_IOMMU_MSI_PTE_V                BIT_ULL(0)
> > +#define RISCV_IOMMU_MSI_PTE_M                GENMASK_ULL(2, 1)
> > +#define RISCV_IOMMU_MSI_PTE_MRIF_ADDR        GENMASK_ULL(53, 7)      /=
* When M =3D=3D 1 (MRIF mode) */
> > +#define RISCV_IOMMU_MSI_PTE_PPN              RISCV_IOMMU_PPN_FIELD   /=
* When M =3D=3D 3 (basic mode) */
> > +#define RISCV_IOMMU_MSI_PTE_C                BIT_ULL(63)
> > +
> > +/* Fields on mrif_info */
> > +#define RISCV_IOMMU_MSI_MRIF_NID     GENMASK_ULL(9, 0)
> > +#define RISCV_IOMMU_MSI_MRIF_NPPN    RISCV_IOMMU_PPN_FIELD
> > +#define RISCV_IOMMU_MSI_MRIF_NID_MSB BIT_ULL(60)
> > +
> > +#endif /* _RISCV_IOMMU_BITS_H_ */
> > diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv=
/iommu-platform.c
> > new file mode 100644
> > index 000000000000..770086ae2ab3
> > --- /dev/null
> > +++ b/drivers/iommu/riscv/iommu-platform.c
> > @@ -0,0 +1,94 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * RISC-V IOMMU as a platform device
> > + *
> > + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> > + * Copyright =C2=A9 2023-2024 Rivos Inc.
> > + *
> > + * Authors
> > + *   Nick Kossifidis <mick@ics.forth.gr>
> > + *   Tomasz Jeznach <tjeznach@rivosinc.com>
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "iommu-bits.h"
> > +#include "iommu.h"
> > +
> > +static int riscv_iommu_platform_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct riscv_iommu_device *iommu =3D NULL;
> > +     struct resource *res =3D NULL;
> > +     int vec;
> > +
> > +     iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> > +     if (!iommu)
> > +             return -ENOMEM;
> > +
> > +     iommu->dev =3D dev;
> > +     iommu->reg =3D devm_platform_get_and_ioremap_resource(pdev, 0, &r=
es);
> > +     if (IS_ERR(iommu->reg))
> > +             return dev_err_probe(dev, PTR_ERR(iommu->reg),
> > +                                  "could not map register region\n");
> > +
> > +     dev_set_drvdata(dev, iommu);
> > +
> > +     /* Check device reported capabilities / features. */
> > +     iommu->caps =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAP);
> > +     iommu->fctl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> > +
> > +     /* For now we only support WSI */
> > +     switch (FIELD_GET(RISCV_IOMMU_CAP_IGS, iommu->caps)) {
> > +     case RISCV_IOMMU_CAP_IGS_WSI:
> > +     case RISCV_IOMMU_CAP_IGS_BOTH:
> > +             break;
> > +     default:
> > +             return dev_err_probe(dev, -ENODEV,
> > +                                  "unable to use wire-signaled interru=
pts\n");
> > +     }
> > +
> > +     iommu->irqs_count =3D platform_irq_count(pdev);
> > +     if (iommu->irqs_count <=3D 0)
> > +             return dev_err_probe(dev, -ENODEV,
> > +                                  "no IRQ resources provided\n");
> > +
> > +     for (vec =3D 0; vec < iommu->irqs_count; vec++)
> > +             iommu->irqs[vec] =3D platform_get_irq(pdev, vec);
>
> And if I've specified 97 interrupts in my DT because I won't let schema
> be the boss of me?
>
> > +     /* Enable wire-signaled interrupts, fctl.WSI */
> > +     if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
> > +             iommu->fctl ^=3D RISCV_IOMMU_FCTL_WSI;
>
> Using XOR to only ever set a 0 bit to 1 seems a bit obtuse.
>
> > +             riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fc=
tl);
> > +     }
> > +
> > +     return riscv_iommu_init(iommu);
> > +};
> > +
> > +static void riscv_iommu_platform_remove(struct platform_device *pdev)
> > +{
> > +     riscv_iommu_remove(dev_get_drvdata(&pdev->dev));
> > +};
> > +
> > +static const struct of_device_id riscv_iommu_of_match[] =3D {
> > +     {.compatible =3D "riscv,iommu",},
> > +     {},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, riscv_iommu_of_match);
>
> And yet it cannot be a module?
>
> > +static struct platform_driver riscv_iommu_platform_driver =3D {
> > +     .probe =3D riscv_iommu_platform_probe,
> > +     .remove_new =3D riscv_iommu_platform_remove,
> > +     .driver =3D {
> > +             .name =3D "riscv,iommu",
> > +             .of_match_table =3D riscv_iommu_of_match,
> > +             .suppress_bind_attrs =3D true,
> > +     },
> > +};
> > +
> > +module_driver(riscv_iommu_platform_driver, platform_driver_register,
> > +           platform_driver_unregister);
>
> module_platform_driver() is a thing. Or builtin_platform_driver(), as
> things currently stand.
>
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > new file mode 100644
> > index 000000000000..af68c89200a9
> > --- /dev/null
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -0,0 +1,89 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * IOMMU API for RISC-V IOMMU implementations.
> > + *
> > + * Copyright =C2=A9 2022-2024 Rivos Inc.
> > + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> > + *
> > + * Authors
> > + *   Tomasz Jeznach <tjeznach@rivosinc.com>
> > + *   Nick Kossifidis <mick@ics.forth.gr>
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> I guess that ends up as "iommu:"? Given that that prefix already belongs
> to the core code, please pick something more specific.
>
> > +#include <linux/compiler.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/init.h>
> > +#include <linux/iommu.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +
> > +#include "iommu-bits.h"
> > +#include "iommu.h"
> > +
> > +MODULE_DESCRIPTION("Driver for RISC-V IOMMU");
> > +MODULE_AUTHOR("Tomasz Jeznach <tjeznach@rivosinc.com>");
> > +MODULE_AUTHOR("Nick Kossifidis <mick@ics.forth.gr>");
> > +MODULE_LICENSE("GPL");
> > +
> > +/* Timeouts in [us] */
> > +#define RISCV_IOMMU_DDTP_TIMEOUT     50000
> > +
> > +static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
> > +{
> > +     u64 ddtp;
> > +
> > +     /* Hardware must be configured in OFF | BARE mode at system initi=
alization. */
> > +     riscv_iommu_readq_timeout(iommu, RISCV_IOMMU_REG_DDTP,
> > +                               ddtp, !(ddtp & RISCV_IOMMU_DDTP_BUSY),
> > +                               10, RISCV_IOMMU_DDTP_TIMEOUT);
> > +     if (FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp) > RISCV_IOMMU_DDTP_MOD=
E_BARE)
> > +             return -EBUSY;
>
> It looks like RISC-V already supports kdump, so you probably want to be
> prepared to find the IOMMU with its pants down and deal with it from day
> one.
>

This is the simplest check/fail for the kexec and/or boot loaders
leaving IOMMU translations active.
I've been already looking into kexec path to quiesce all devices and
IOMMU in shutdown path.
I'm not convinced it's ready for the prime time on RISC-V, will
address this in follow up patches.

> > +
> > +     /* Configure accesses to in-memory data structures for CPU-native=
 byte order. */
> > +     if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) !=3D !!(iommu->fctl & RISCV=
_IOMMU_FCTL_BE)) {
> > +             if (!(iommu->caps & RISCV_IOMMU_CAP_END))
> > +                     return -EINVAL;
> > +             riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL,
> > +                                iommu->fctl ^ RISCV_IOMMU_FCTL_BE);
> > +             iommu->fctl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_=
FCTL);
> > +             if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) !=3D !!(iommu->fctl=
 & RISCV_IOMMU_FCTL_BE))
> > +                     return -EINVAL;
> > +     }
>
> That's fun. It could be reorganised to avoid the duplicate check, but it
> is rather majestic as-is :)
>
> > +
> > +     dma_set_mask_and_coherent(iommu->dev,
> > +                               DMA_BIT_MASK(FIELD_GET(RISCV_IOMMU_CAP_=
PAS, iommu->caps)));
>
> This isn't a check, so I would think it belongs to "_init" rather than
> "_init_check".
>
> Thanks,
> Robin.
>

ACK to all other comments.

Thanks
- Tomasz

> > +
> > +     return 0;
> > +}
> > +
> > +void riscv_iommu_remove(struct riscv_iommu_device *iommu)
> > +{
> > +     iommu_device_sysfs_remove(&iommu->iommu);
> > +}
> > +
> > +int riscv_iommu_init(struct riscv_iommu_device *iommu)
> > +{
> > +     int rc;
> > +
> > +     rc =3D riscv_iommu_init_check(iommu);
> > +     if (rc)
> > +             return dev_err_probe(iommu->dev, rc, "unexpected device s=
tate\n");
> > +     /*
> > +      * Placeholder for a complete IOMMU device initialization.
> > +      * For now, only bare minimum: enable global identity mapping mod=
e and register sysfs.
> > +      */
> > +     riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP,
> > +                        FIELD_PREP(RISCV_IOMMU_DDTP_MODE, RISCV_IOMMU_=
DDTP_MODE_BARE));
> > +
> > +     rc =3D iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-i=
ommu@%s",
> > +                                 dev_name(iommu->dev));
> > +     if (WARN(rc, "cannot register sysfs interface\n"))
> > +             goto err_sysfs;
> > +
> > +     return 0;
> > +
> > +err_sysfs:
> > +     return rc;
> > +}
> > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> > new file mode 100644
> > index 000000000000..700e33dc2446
> > --- /dev/null
> > +++ b/drivers/iommu/riscv/iommu.h
> > @@ -0,0 +1,62 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright =C2=A9 2022-2024 Rivos Inc.
> > + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> > + *
> > + * Authors
> > + *   Tomasz Jeznach <tjeznach@rivosinc.com>
> > + *   Nick Kossifidis <mick@ics.forth.gr>
> > + */
> > +
> > +#ifndef _RISCV_IOMMU_H_
> > +#define _RISCV_IOMMU_H_
> > +
> > +#include <linux/iommu.h>
> > +#include <linux/types.h>
> > +#include <linux/iopoll.h>
> > +
> > +#include "iommu-bits.h"
> > +
> > +struct riscv_iommu_device {
> > +     /* iommu core interface */
> > +     struct iommu_device iommu;
> > +
> > +     /* iommu hardware */
> > +     struct device *dev;
> > +
> > +     /* hardware control register space */
> > +     void __iomem *reg;
> > +
> > +     /* supported and enabled hardware capabilities */
> > +     u64 caps;
> > +     u32 fctl;
> > +
> > +     /* available interrupt numbers, MSI or WSI */
> > +     unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
> > +     unsigned int irqs_count;
> > +};
> > +
> > +int riscv_iommu_init(struct riscv_iommu_device *iommu);
> > +void riscv_iommu_remove(struct riscv_iommu_device *iommu);
> > +
> > +#define riscv_iommu_readl(iommu, addr) \
> > +     readl_relaxed((iommu)->reg + (addr))
> > +
> > +#define riscv_iommu_readq(iommu, addr) \
> > +     readq_relaxed((iommu)->reg + (addr))
> > +
> > +#define riscv_iommu_writel(iommu, addr, val) \
> > +     writel_relaxed((val), (iommu)->reg + (addr))
> > +
> > +#define riscv_iommu_writeq(iommu, addr, val) \
> > +     writeq_relaxed((val), (iommu)->reg + (addr))
> > +
> > +#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > +     readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, con=
d, \
> > +                        delay_us, timeout_us)
> > +
> > +#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > +     readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, con=
d, \
> > +                        delay_us, timeout_us)
> > +
> > +#endif

