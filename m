Return-Path: <linux-kernel+bounces-22398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86B7829D28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01A0EB25DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CF24BAAE;
	Wed, 10 Jan 2024 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="TklbYuii"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB84BA9A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3608bdb484fso9992455ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1704899488; x=1705504288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7dnx0armDk/+RvWWpSg/XyhmNCzgM7h7SgaiA/YSV0=;
        b=TklbYuiioxlzjnWfAA24zNXJlHUJ8ZH1uZVbhZ696vnd2G3jJ8Ko9rhkdiyfh9xLgX
         t/jTP9OI8Q2iBqKqYFYV1Znshpcsaic/1pHXVGjj7RKbjOiRGZoKch11IulXC4GIEpk5
         5+rFCjENgBwniQJDhzFSIpRa6fHzcSNalGWibqv/H0xUxCMFJme3WZGxMg7exb3TCWvX
         wk5Fw+/Cqv5IwmHFsuUVq26CrXMUvE99iaJGPNzPD4IHYo4GzU1n9MnHUIBGSXMzm5L0
         nQW7v0rrntORL8uHR5hAF/mQ6odNs5Qh/ethdEEwtCbtHxgP6CX8uzZxE1PwvU50JFGM
         eFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704899488; x=1705504288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7dnx0armDk/+RvWWpSg/XyhmNCzgM7h7SgaiA/YSV0=;
        b=otEjEvrdntDCbQhsIUEeAk/3lBZO4pd/XOlCD9TqkCUM2bppGJg9tC81CTbG4qR6jG
         EnEgyfd3jynnIeISxZGuh+LfvScrkwCnv7E7Dx0ybfpIfmdi0rusU/ZRHYYUYe5jjWkN
         aS0j0XyhD9XKBBlJcnHg8dlnidiSJq2HILL7WufxsJitxKXl2bkK6L5Yd3TGBU+1xied
         PY50c1+hDkV77k87FDHDEMMlg7zsAqoGUAqgM1Uj/sp4grgBQmgAtvp0E81JSbjFy/GJ
         CNgYTFGAlTFDMoiw9MLPYyRCyprcC4FitALXsYnS9pKBCNDCwQlke5t4kLtQOr6nqGxO
         uSIQ==
X-Gm-Message-State: AOJu0YyU4Jt5wRRdwTXjlx+FGehQktOdRwjizsNa+LwmZ/gwZqNipfou
	jwO56fdCsC7x8vdt+5T/XZeHqWZwnPyXNBw1scUaI7A2l6kyhg==
X-Google-Smtp-Source: AGHT+IEuq58zauZkEQ1xO5LVtDSLalCCv+/Jivx2TA3XmedpEjlVHqJRGlt6ZOsWmnTKoMBajwuUrebUCLahkbpfozk=
X-Received: by 2002:a92:c56b:0:b0:360:8a0b:50dc with SMTP id
 b11-20020a92c56b000000b003608a0b50dcmr143554ilj.10.1704899488291; Wed, 10 Jan
 2024 07:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110073917.2398826-1-peterlin@andestech.com> <20240110073917.2398826-3-peterlin@andestech.com>
In-Reply-To: <20240110073917.2398826-3-peterlin@andestech.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 10 Jan 2024 20:41:16 +0530
Message-ID: <CAAhSdy1KLSFBA_vD+NX15wuiOsz5QadQWj4ZWOK11qfL1LuHqA@mail.gmail.com>
Subject: Re: [PATCH v7 02/16] irqchip/riscv-intc: Allow large non-standard
 interrupt number
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
> Currently, the implementation of the RISC-V INTC driver uses the
> interrupt cause as the hardware interrupt number, with a maximum of
> 64 interrupts. However, the platform can expand the interrupt number
> further for custom local interrupts.
>
> To fully utilize the available local interrupt sources, switch
> to using irq_domain_create_tree() that creates the radix tree
> map, add global variables (riscv_intc_nr_irqs, riscv_intc_custom_base
> and riscv_intc_custom_nr_irqs) to determine the valid range of local
> interrupt number (hwirq).
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Randolph <randolph@andestech.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
> Changes v1 -> v2:
>   - Fixed irq mapping failure checking (suggested by Cl=C3=A9ment and Anu=
p)
> Changes v2 -> v3:
>   - No change
> Changes v3 -> v4: (Suggested by Thomas [1])
>   - Use pr_warn_ratelimited instead
>   - Fix coding style and commit message
> Changes v4 -> v5: (Suggested by Thomas)
>   - Fix commit message
> Changes v5 -> v6: (Suggested by Anup [2])
>   - Add riscv_intc_* global variables for checking range in riscv_intc_do=
main_alloc()
>   - Advertise the number of interrupts allowed
> Changes v6 -> v7:
>   - No functional change
>
> [1] https://patchwork.kernel.org/project/linux-riscv/patch/20231023004100=
2663486-3-peterlin@andestech.com/#25573085
> [2] https://patchwork.kernel.org/project/linux-riscv/patch/20231213070301=
1684751-3-peterlin@andestech.com/#25636589
> ---
>  drivers/irqchip/irq-riscv-intc.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index e8d01b14ccdd..b13a16b164c9 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -19,15 +19,17 @@
>  #include <linux/smp.h>
>
>  static struct irq_domain *intc_domain;
> +static unsigned int riscv_intc_nr_irqs __ro_after_init;
> +static unsigned int riscv_intc_custom_base __ro_after_init;
> +static unsigned int riscv_intc_custom_nr_irqs __ro_after_init;
>
>  static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
>  {
>         unsigned long cause =3D regs->cause & ~CAUSE_IRQ_FLAG;
>
> -       if (unlikely(cause >=3D BITS_PER_LONG))
> -               panic("unexpected interrupt cause");
> -
> -       generic_handle_domain_irq(intc_domain, cause);
> +       if (generic_handle_domain_irq(intc_domain, cause))
> +               pr_warn_ratelimited("Failed to handle interrupt (cause: %=
ld)\n",
> +                                   cause);
>  }
>
>  /*
> @@ -93,6 +95,14 @@ static int riscv_intc_domain_alloc(struct irq_domain *=
domain,
>         if (ret)
>                 return ret;
>
> +       /*
> +        * Only allow hwirq for which we have corresponding standard or
> +        * custom interrupt enable register.
> +        */
> +       if ((riscv_intc_nr_irqs <=3D hwirq && hwirq < riscv_intc_custom_b=
ase) ||
> +           (riscv_intc_custom_base + riscv_intc_custom_nr_irqs) <=3D hwi=
rq)
> +               return -EINVAL;
> +
>         for (i =3D 0; i < nr_irqs; i++) {
>                 ret =3D riscv_intc_domain_map(domain, virq + i, hwirq + i=
);
>                 if (ret)
> @@ -117,8 +127,7 @@ static int __init riscv_intc_init_common(struct fwnod=
e_handle *fn)
>  {
>         int rc;
>
> -       intc_domain =3D irq_domain_create_linear(fn, BITS_PER_LONG,
> -                                              &riscv_intc_domain_ops, NU=
LL);
> +       intc_domain =3D irq_domain_create_tree(fn, &riscv_intc_domain_ops=
, NULL);
>         if (!intc_domain) {
>                 pr_err("unable to add IRQ domain\n");
>                 return -ENXIO;
> @@ -132,7 +141,10 @@ static int __init riscv_intc_init_common(struct fwno=
de_handle *fn)
>
>         riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
>
> -       pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> +       pr_info("%d local interrupts mapped\n", riscv_intc_nr_irqs);
> +       if (riscv_intc_custom_nr_irqs)
> +               pr_info("%d custom local interrupts mapped\n",
> +                       riscv_intc_custom_nr_irqs);
>
>         return 0;
>  }
> @@ -166,6 +178,10 @@ static int __init riscv_intc_init(struct device_node=
 *node,
>                 return 0;
>         }
>
> +       riscv_intc_nr_irqs =3D BITS_PER_LONG;
> +       riscv_intc_custom_base =3D riscv_intc_nr_irqs;
> +       riscv_intc_custom_nr_irqs =3D 0;
> +
>         return riscv_intc_init_common(of_node_to_fwnode(node));
>  }
>
> --
> 2.34.1
>

