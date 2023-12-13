Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D4681152A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441824AbjLMOqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbjLMOqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:46:14 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0954B10E2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:45:42 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9f72176cfso87954271fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702478740; x=1703083540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmqPFkPuxnmZl6SJeiaZQfpiU27tLb3tsOrQMJyrLD4=;
        b=Agj/ICxbfAA8gikFbPx/aYaV00RAZ2/uHfd3qjMezPv/8CVFLw+cbJYimZ1O40ohsP
         rZ9Gj2UzkHdWDgDoiZmUYI2KIilTYFiGctNS2YoiiOHrvuP3Xwoo6wQqGAXks/muW/6V
         PKFviEYgBqizGlGgqLql0LXEdRga5Lqg0bDm1yeb07Tl2A5gUG3VxmRR2/Vz5UXtwDLk
         kodHD46XLQNxHgeg16tlIEcwlPZmepIzRl+6msJymXWeCitozjzVSUt//nHBv8wYJ1Pd
         kyVuEflKcYQUz/w3GqZIuIDliqfRCRwaWrInB6Etxtpo1nVks9FdOsRYZaNke7Kxb/oE
         FU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478740; x=1703083540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmqPFkPuxnmZl6SJeiaZQfpiU27tLb3tsOrQMJyrLD4=;
        b=WRRMDqxA+bwYS7nwOrqWtTBU5TnzyoWHENQo4MyDNel/3Du/FqkxvSW/LqScm0oxGo
         E0ybasJd407Me3HNleAmwZbfhjUn6ait1s+mkt0Kyi+j7wo6KxVRgEICo1hGAbuKrfVe
         nl0P0pxUy7Vq1YtUJQibfqsuMV884nxpIQe+6dhvmK297U51CpdcePPklooJvqFxQ+Zn
         Je1i9znjxVHghP+nnelAsbmQtciCXWz5nbA5YDbCOMRuuVQnbfr4GYYkoa5nZ328CuMy
         nFwhWsk4yeTNKrhuLJriMFU6HcGW5kELv0zHdVzjOy1AZoyx8yHLk27qsNprc8yavhPr
         FFSA==
X-Gm-Message-State: AOJu0YxN3qA6fU+HXYxUnxcCXEyKoXHUQNePBwH15d3NVMtY8baSx2OK
        nxV2l/Pf9wvdyrUumP2rcPv4dcwm+8Bk5/2hQ75IUA==
X-Google-Smtp-Source: AGHT+IG6FMOgiaHfoGJ4CXnfRM137eDjGlMeCoh6XEgb1O0XWDa1v6SeRcYd9d9XNsMFoYiywjezVdEKzupnFGgO6Xc=
X-Received: by 2002:a2e:9f51:0:b0:2c9:fece:5be6 with SMTP id
 v17-20020a2e9f51000000b002c9fece5be6mr1427130ljk.54.1702478740068; Wed, 13
 Dec 2023 06:45:40 -0800 (PST)
MIME-Version: 1.0
References: <20231213070301.1684751-1-peterlin@andestech.com> <20231213070301.1684751-4-peterlin@andestech.com>
In-Reply-To: <20231213070301.1684751-4-peterlin@andestech.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 13 Dec 2023 20:15:28 +0530
Message-ID: <CAK9=C2WC2i7XkjDgbjccVn03BYfnE_YS4YiA6ZWMj6GDyTjJKA@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] irqchip/riscv-intc: Introduce Andes hart-level
 interrupt controller
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, guoren@kernel.org,
        heiko@sntech.de, irogers@google.com, jernej.skrabec@gmail.com,
        jolsa@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, locus84@andestech.com,
        magnus.damm@gmail.com, mark.rutland@arm.com, mingo@redhat.com,
        n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
        tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
        wens@csie.org, will@kernel.org, ycliang@andestech.com,
        inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 12:35=E2=80=AFPM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> Add support for the Andes hart-level interrupt controller. This
> controller provides interrupt mask/unmask functions to access the
> custom register (SLIE) where the non-standard S-mode local interrupt
> enable bits are located.
>
> To share the riscv_intc_domain_map() with the generic RISC-V INTC and
> ACPI, add a chip parameter to riscv_intc_init_common(), so it can be
> passed to the irq_domain_set_info() as private data.
>
> Andes hart-level interrupt controller requires the "andestech,cpu-intc"
> compatible string to be present in interrupt-controller of cpu node.
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
> Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
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
>
> [1] https://patchwork.kernel.org/project/linux-riscv/patch/20231019135723=
.3657156-1-peterlin@andestech.com/
> ---
>  drivers/irqchip/irq-riscv-intc.c | 53 ++++++++++++++++++++++++++++----
>  include/linux/soc/andes/irq.h    | 17 ++++++++++
>  2 files changed, 64 insertions(+), 6 deletions(-)
>  create mode 100644 include/linux/soc/andes/irq.h
>
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index 2fdd40f2a791..0b6bf3fb1dba 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/smp.h>
> +#include <linux/soc/andes/irq.h>
>
>  static struct irq_domain *intc_domain;
>
> @@ -46,6 +47,31 @@ static void riscv_intc_irq_unmask(struct irq_data *d)
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
> +       unsigned int mask =3D BIT(d->hwirq - ANDES_SLI_CAUSE_BASE);
> +
> +       if (d->hwirq < ANDES_SLI_CAUSE_BASE)
> +               csr_clear(CSR_IE, mask);
> +       else
> +               csr_clear(ANDES_CSR_SLIE, mask);
> +}
> +
> +static void andes_intc_irq_unmask(struct irq_data *d)
> +{
> +       unsigned int mask =3D BIT(d->hwirq - ANDES_SLI_CAUSE_BASE);
> +
> +       if (d->hwirq < ANDES_SLI_CAUSE_BASE)
> +               csr_set(CSR_IE, mask);
> +       else
> +               csr_set(ANDES_CSR_SLIE, mask);

Clearly, Andes does not have any CSR for:
XLEN <=3D local interrupt <ANDES_SLI_CAUSE_BASE
and
ANDES_SLI_CAUSE_BASE + XLEN <=3D local interrupt

Regards,
Anup

> +}
> +
>  static void riscv_intc_irq_eoi(struct irq_data *d)
>  {
>         /*
> @@ -69,11 +95,20 @@ static struct irq_chip riscv_intc_chip =3D {
>         .irq_eoi =3D riscv_intc_irq_eoi,
>  };
>
> +static struct irq_chip andes_intc_chip =3D {
> +       .name       =3D "RISC-V INTC",
> +       .irq_mask   =3D andes_intc_irq_mask,
> +       .irq_unmask =3D andes_intc_irq_unmask,
> +       .irq_eoi    =3D riscv_intc_irq_eoi,
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
> +       irq_domain_set_info(d, irq, hwirq, chip, NULL,
>                             handle_percpu_devid_irq, NULL, NULL);
>
>         return 0;
> @@ -112,11 +147,12 @@ static struct fwnode_handle *riscv_intc_hwnode(void=
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
> @@ -136,8 +172,9 @@ static int __init riscv_intc_init_common(struct fwnod=
e_handle *fn)
>  static int __init riscv_intc_init(struct device_node *node,
>                                   struct device_node *parent)
>  {
> -       int rc;
> +       struct irq_chip *chip =3D &riscv_intc_chip;
>         unsigned long hartid;
> +       int rc;
>
>         rc =3D riscv_of_parent_hartid(node, &hartid);
>         if (rc < 0) {
> @@ -162,10 +199,14 @@ static int __init riscv_intc_init(struct device_nod=
e *node,
>                 return 0;
>         }
>
> -       return riscv_intc_init_common(of_node_to_fwnode(node));
> +       if (of_device_is_compatible(node, "andestech,cpu-intc"))
> +               chip =3D &andes_intc_chip;
> +
> +       return riscv_intc_init_common(of_node_to_fwnode(node), chip);
>  }
>
>  IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
> +IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_intc_init);
>
>  #ifdef CONFIG_ACPI
>
> @@ -192,7 +233,7 @@ static int __init riscv_intc_acpi_init(union acpi_sub=
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
> index 000000000000..f03e68fea261
> --- /dev/null
> +++ b/include/linux/soc/andes/irq.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 Andes Technology Corporation
> + */
> +#ifndef __ANDES_IRQ_H
> +#define __ANDES_IRQ_H
> +
> +/* Andes PMU irq number */
> +#define ANDES_RV_IRQ_PMU               18
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
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
