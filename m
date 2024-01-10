Return-Path: <linux-kernel+bounces-22402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 154F2829D33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF5E1C21DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9704BAB6;
	Wed, 10 Jan 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Gj383Vmc"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59CA4BAB5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bef44df5c6so23646439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1704899582; x=1705504382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLmfrw2jsSN60tMCB/PEONVy5KPpeeDlWefaJWRpQVA=;
        b=Gj383VmcW2gMF508XBtyA8e1ddp26AVQqZrh3fAxNXvNivJODnS62dLuBoT+qSSRzK
         CuU5rtk8FPUEzSXLcjic2MsVJVqBO/1Relt7HeByWgXI+kHYAWxQIOT3msNWF5BsXh72
         AZrsY4GAiKayhgQVyPtWm5TPYK/R+TPzR8wiJTdT1O3+Pe5L/V0Z9tXtYbqGMffEjKuS
         B28/D95PYlgkKf/KH3TYXW8yaaLQkDGYWHXDSCmtxan4sDsTrlRKDfOQmDfRUWCoFtte
         XjQ/QPTBL2E7fWKTLd0DUIMzEO1c1RWB8DZoRvzYZpMlcKKFBume1vo2qiui7wVmqh0V
         dIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704899582; x=1705504382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLmfrw2jsSN60tMCB/PEONVy5KPpeeDlWefaJWRpQVA=;
        b=HZ8vl75hEpppTcPldaZNnBZbzTqF0CV0aKf4X37nTNM4CX/uO7qHA2aYDgkrHzSCBl
         nztPptyBFODkI9BMbB4vMWssNXhEldnUb6lJsTkDPe6icCECsIbRThs8coZc4+zQilUT
         sIlPoFuTbIcfaoy5GLFcJFlhq6U5bTW+3Jgk01hDd76ytN4UM8NECXKvCM9pJtxhO1j0
         J6961/Ae2djuzT36gcIcLjmykoRM+po+SO+Nr5PV2f/2ZuTN6aEjKi1zUPn+GY+Gl24J
         oQPbi1+fiqqdXxDyl09biFnkFZyoLbVtPaqvmpZiKngaNS/bZ/FLpiJguGICSIjpofqe
         +SLw==
X-Gm-Message-State: AOJu0YxMg1PoPfu38zglE3gBt+qXzMMgH9QxQNYs1Uvf7VygOsYJH9vQ
	drrXVbJwf+AWV0bvLSLUSKspE2+ihGyvKJ/Fz98UkArHW4qAKA==
X-Google-Smtp-Source: AGHT+IFw/X6CIWamQROjC4ZRQCvZflW+gMP7cNCJOi9mY8EYrqD9A+TpR1UT0WY6zElbjQktNj/ob+qZDfTjcmm69QA=
X-Received: by 2002:a05:6e02:16c6:b0:35f:b61f:a8a0 with SMTP id
 6-20020a056e0216c600b0035fb61fa8a0mr178722ilx.13.1704899581750; Wed, 10 Jan
 2024 07:13:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110073917.2398826-1-peterlin@andestech.com> <20240110073917.2398826-4-peterlin@andestech.com>
In-Reply-To: <20240110073917.2398826-4-peterlin@andestech.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 10 Jan 2024 20:42:50 +0530
Message-ID: <CAAhSdy1vsngrYj2tjUJqxepLEcz1zOFfYHvAvL4kqX4p62gnGA@mail.gmail.com>
Subject: Re: [PATCH v7 03/16] irqchip/riscv-intc: Introduce Andes hart-level
 interrupt controller
To: Yu Chien Peter Lin <peterlin@andestech.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	alexander.shishkin@linux.intel.com, andre.przywara@arm.com, 
	aou@eecs.berkeley.edu, atishp@atishpatra.org, conor+dt@kernel.org, 
	conor.dooley@microchip.com, conor@kernel.org, devicetree@vger.kernel.org, 
	dminus@andestech.com, evan@rivosinc.com, geert+renesas@glider.be, 
	guoren@kernel.org, heiko@sntech.de, irogers@google.com, 
	jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, locus84@andestech.com, magnus.damm@gmail.com, 
	mark.rutland@arm.com, mingo@redhat.com, n.shubin@yadro.com, 
	namhyung@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	peterz@infradead.org, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org, 
	sunilvl@ventanamicro.com, tglx@linutronix.de, tim609@andestech.com, 
	uwu@icenowy.me, wens@csie.org, will@kernel.org, ycliang@andestech.com, 
	inochiama@outlook.com, chao.wei@sophgo.com, unicorn_wang@outlook.com, 
	wefu@redhat.com, Randolph <randolph@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:10=E2=80=AFPM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> Add support for the Andes hart-level interrupt controller. This
> controller provides interrupt mask/unmask functions to access the
> custom register (SLIE) where the non-standard S-mode local interrupt
> enable bits are located. The base of custom interrupt number is set
> to 256.
>
> To share the riscv_intc_domain_map() with the generic RISC-V INTC and
> ACPI, add a chip parameter to riscv_intc_init_common(), so it can be
> passed to the irq_domain_set_info() as a private data.
>
> Andes hart-level interrupt controller requires the "andestech,cpu-intc"
> compatible string to be present in interrupt-controller of cpu node to
> enable the use of custom local interrupt source.
> e.g.,
>
>   cpu0: cpu@0 {
>       compatible =3D "andestech,ax45mp", "riscv";
>       ...
>       cpu0-intc: interrupt-controller {
>           #interrupt-cells =3D <0x01>;
>           compatible =3D "andestech,cpu-intc", "riscv,cpu-intc";
>           interrupt-controller;
>       };
>   };
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Randolph <randolph@andestech.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
> Changes v1 -> v2:
>   - New patch
> Changes v2 -> v3:
>   - Return -ENXIO if no valid compatible INTC found
>   - Allow falling back to generic RISC-V INTC
> Changes v3 -> v4: (Suggested by Thomas [1])
>   - Add comment to andes irq chip function
>   - Refine code flow to share with generic RISC-V INTC and ACPI
>   - Move Andes specific definitions to include/linux/soc/andes/irq.h
> Changes v4 -> v5: (Suggested by Thomas)
>   - Fix commit message
>   - Subtract ANDES_SLI_CAUSE_BASE from d->hwirq to calculate the value of=
 mask
>   - Do not set chip_data to the chip itself with irq_domain_set_info()
>   - Follow reverse fir tree order variable declarations
> Changes v5 -> v6:
>   - To follow the naming on datasheet, rename ANDES_RV_IRQ_PMU to ANDES_R=
V_IRQ_PMOVI
>   - Initialize the riscv_intc_* global variables for Andes INTC (Suggeste=
d by Anup)
>   - Use BITS_PER_LONG to compute the bit mask of SIE/SLIE as they are 64-=
bit registers (32-bit for RV32)
> Changes v6 -> v7:
>   - No change
>
> [1] https://patchwork.kernel.org/project/linux-riscv/patch/20231019135723=
3657156-1-peterlin@andestech.com/
> ---
>  drivers/irqchip/irq-riscv-intc.c | 66 +++++++++++++++++++++++++++-----
>  include/linux/soc/andes/irq.h    | 18 +++++++++
>  2 files changed, 74 insertions(+), 10 deletions(-)
>  create mode 100644 include/linux/soc/andes/irq.h
>
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index b13a16b164c9..7064857f1f1d 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/smp.h>
> +#include <linux/soc/andes/irq.h>
>
>  static struct irq_domain *intc_domain;
>  static unsigned int riscv_intc_nr_irqs __ro_after_init;
> @@ -49,6 +50,31 @@ static void riscv_intc_irq_unmask(struct irq_data *d)
>         csr_set(CSR_IE, BIT(d->hwirq));
>  }
>
> +static void andes_intc_irq_mask(struct irq_data *d)
> +{
> +       /*
> +        * Andes specific S-mode local interrupt causes (hwirq)
> +        * are defined as (256 + n) and controlled by n-th bit
> +        * of SLIE.
> +        */
> +       unsigned int mask =3D BIT(d->hwirq % BITS_PER_LONG);
> +
> +       if (d->hwirq < ANDES_SLI_CAUSE_BASE)
> +               csr_clear(CSR_IE, mask);
> +       else
> +               csr_clear(ANDES_CSR_SLIE, mask);
> +}
> +
> +static void andes_intc_irq_unmask(struct irq_data *d)
> +{
> +       unsigned int mask =3D BIT(d->hwirq % BITS_PER_LONG);
> +
> +       if (d->hwirq < ANDES_SLI_CAUSE_BASE)
> +               csr_set(CSR_IE, mask);
> +       else
> +               csr_set(ANDES_CSR_SLIE, mask);
> +}
> +
>  static void riscv_intc_irq_eoi(struct irq_data *d)
>  {
>         /*
> @@ -72,12 +98,21 @@ static struct irq_chip riscv_intc_chip =3D {
>         .irq_eoi =3D riscv_intc_irq_eoi,
>  };
>
> +static struct irq_chip andes_intc_chip =3D {
> +       .name           =3D "RISC-V INTC",
> +       .irq_mask       =3D andes_intc_irq_mask,
> +       .irq_unmask     =3D andes_intc_irq_unmask,
> +       .irq_eoi        =3D riscv_intc_irq_eoi,
> +};
> +
>  static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
>                                  irq_hw_number_t hwirq)
>  {
> +       struct irq_chip *chip =3D d->host_data;
> +
>         irq_set_percpu_devid(irq);
> -       irq_domain_set_info(d, irq, hwirq, &riscv_intc_chip, d->host_data=
,
> -                           handle_percpu_devid_irq, NULL, NULL);
> +       irq_domain_set_info(d, irq, hwirq, chip, NULL, handle_percpu_devi=
d_irq,
> +                           NULL, NULL);
>
>         return 0;
>  }
> @@ -123,11 +158,12 @@ static struct fwnode_handle *riscv_intc_hwnode(void=
)
>         return intc_domain->fwnode;
>  }
>
> -static int __init riscv_intc_init_common(struct fwnode_handle *fn)
> +static int __init riscv_intc_init_common(struct fwnode_handle *fn,
> +                                        struct irq_chip *chip)
>  {
>         int rc;
>
> -       intc_domain =3D irq_domain_create_tree(fn, &riscv_intc_domain_ops=
, NULL);
> +       intc_domain =3D irq_domain_create_tree(fn, &riscv_intc_domain_ops=
, chip);
>         if (!intc_domain) {
>                 pr_err("unable to add IRQ domain\n");
>                 return -ENXIO;
> @@ -152,8 +188,9 @@ static int __init riscv_intc_init_common(struct fwnod=
e_handle *fn)
>  static int __init riscv_intc_init(struct device_node *node,
>                                   struct device_node *parent)
>  {
> -       int rc;
> +       struct irq_chip *chip;
>         unsigned long hartid;
> +       int rc;
>
>         rc =3D riscv_of_parent_hartid(node, &hartid);
>         if (rc < 0) {
> @@ -178,14 +215,23 @@ static int __init riscv_intc_init(struct device_nod=
e *node,
>                 return 0;
>         }
>
> -       riscv_intc_nr_irqs =3D BITS_PER_LONG;
> -       riscv_intc_custom_base =3D riscv_intc_nr_irqs;
> -       riscv_intc_custom_nr_irqs =3D 0;
> +       if (of_device_is_compatible(node, "andestech,cpu-intc")) {
> +               riscv_intc_nr_irqs =3D BITS_PER_LONG;
> +               riscv_intc_custom_base =3D ANDES_SLI_CAUSE_BASE;
> +               riscv_intc_custom_nr_irqs =3D ANDES_RV_IRQ_LAST;
> +               chip =3D &andes_intc_chip;
> +       } else {
> +               riscv_intc_nr_irqs =3D BITS_PER_LONG;
> +               riscv_intc_custom_base =3D riscv_intc_nr_irqs;
> +               riscv_intc_custom_nr_irqs =3D 0;
> +               chip =3D &riscv_intc_chip;
> +       }
>
> -       return riscv_intc_init_common(of_node_to_fwnode(node));
> +       return riscv_intc_init_common(of_node_to_fwnode(node), chip);
>  }
>
>  IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
> +IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_intc_init);
>
>  #ifdef CONFIG_ACPI
>
> @@ -212,7 +258,7 @@ static int __init riscv_intc_acpi_init(union acpi_sub=
table_headers *header,
>                 return -ENOMEM;
>         }
>
> -       return riscv_intc_init_common(fn);
> +       return riscv_intc_init_common(fn, &riscv_intc_chip);
>  }
>
>  IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC, NULL,
> diff --git a/include/linux/soc/andes/irq.h b/include/linux/soc/andes/irq.=
h
> new file mode 100644
> index 000000000000..edc3182d6e66
> --- /dev/null
> +++ b/include/linux/soc/andes/irq.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 Andes Technology Corporation
> + */
> +#ifndef __ANDES_IRQ_H
> +#define __ANDES_IRQ_H
> +
> +/* Andes PMU irq number */
> +#define ANDES_RV_IRQ_PMOVI             18
> +#define ANDES_RV_IRQ_LAST              ANDES_RV_IRQ_PMOVI
> +#define ANDES_SLI_CAUSE_BASE           256
> +
> +/* Andes PMU related registers */
> +#define ANDES_CSR_SLIE                 0x9c4
> +#define ANDES_CSR_SLIP                 0x9c5
> +#define ANDES_CSR_SCOUNTEROF           0x9d4
> +
> +#endif /* __ANDES_IRQ_H */
> --
> 2.34.1
>

