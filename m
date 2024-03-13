Return-Path: <linux-kernel+bounces-101100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0968287A256
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A86B1F22B28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55F810A3B;
	Wed, 13 Mar 2024 04:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="LaXzoID2"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759C1BA3F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710304507; cv=none; b=VoceplMsxVYTXlr/TkJnhYkc7itymuRL0KLnbkCMww1vd0Q6rs1bSmwbSkQE3jk7BQay12RnjFIEEiOO1lbEEVlKCqmc1cvIx8M1gm1KM4JXanoMYjIflNjl6GPIOqThGYLD5nbahAKAlGwHDbsFs6VHaQi8I9yAHCLIC1RsS1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710304507; c=relaxed/simple;
	bh=+DL1Yw3hbujlOsf1drnPbBS2/sr3+wz7snK2f/4Qi3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdhpQuC2H/HPA3AMvwdcgoG6n2dhhC2Q99ricB2uFbKPn9V+nLSGiZp2SBB73g4ueDUvOxlvszgTnT11ay0/ZVogLtqhO77nwbFn/2MBlgs4uzJwTO3bXb2WGYwGHqup3/t5ZnkMp5U60DwRVbqvWvR/UZYfSScXu5UxuiLBdSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=LaXzoID2; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-364f791a428so29346905ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1710304504; x=1710909304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+ojfhId1+LThxcC+VoZJPeAkhUw8IvP6nZWtFu7M50=;
        b=LaXzoID2bcBTXSoufFozfU3x/6FT2myy66fUKNWwkidfPLRoiTunafqzex9whfrkwS
         ZJhP0jVCdDiFQC1d21xsvQ9EYAaCdmKGq4ZA5kyCnbNK8ho2agkwzIDy4UC64vlD4+3X
         TAKBk440L29in9aeHpfZjlIxdf/qjlrJl3/cDZYpjtv+d2X1LON/jSu+MoYf8BPLPRgd
         QWC0JW8vfAzrP5cufMfxfEFnJdFr11V2eypIwffKg3bFUWRDNzk2vsPOIEhNqk//H+QR
         HXfyusj7mOUxX2YrsrOv2dzUkv3zn9m7nVIuoQ0j3JX/pTyd4kc4+96gPm6aKcQWQOei
         BCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710304504; x=1710909304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+ojfhId1+LThxcC+VoZJPeAkhUw8IvP6nZWtFu7M50=;
        b=sBUz7Lr3HJviDQbIQDtMjHAhG4vY5E9p6FMtPGOFZJVMTlNcQrCDYnFnUsFJPP8nsm
         DJKyg8bz1ORDtuEKSpWilD4CDhYKEheKUF6uknEwoIGHVzP/n5MEhnbXaiFQZa4gKlml
         +nWh5mg94cVg6CVWBrt055YZrLW4hwjfWNViNa0/g4j41vmhG6yn9Ou6EAglICXtLJox
         MV35qloH1QFa/jYJ9cgHt1Zn602AqyUnw5P2Vj2gL3L0vzYga4Qo+UkWM3d4uRLbv2Yr
         KI4xOPoZ0PUURQraYc6ZSCRjo4J33lwxHI5KAyX2AboLPRD34BNyZw6EjeYYGWiWrskp
         eMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1cxoumnkqzadLqiZFIWBDFEJKuLYQdYaEe+SCOPezoWJnrZ1Kdt81EjrB3hkEURBtzdx5fn0JKZRIKKDJZOdDPFgajo7Kd5lShyVF
X-Gm-Message-State: AOJu0YxR5yEipCRGWMFcJ0SrpH7V6pkJY2GsrM2Xpg5wkBaVhJFczpuQ
	t4k9g+XdR/2DfIDYl2rKu/fO8nxXEME24swTxB9O4yxKMdVOFWgVtnoXdKD0XJSUchxj8V7wRSe
	/9Kq2XNUZHSnaJP05Y4+WKCyoMvCMcbtbPQD+/g==
X-Google-Smtp-Source: AGHT+IGNHY6yALXc0HHKiXAFJ/gCo5nkoSqgcYH+W8nW6RbXOtlAqWcFNeEuBtNCAB/bi676z5bhdsaNAz18dXYhQgU=
X-Received: by 2002:a05:6e02:11a9:b0:366:4ad5:a066 with SMTP id
 9-20020a056e0211a900b003664ad5a066mr7558070ilj.23.1710304504474; Tue, 12 Mar
 2024 21:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312212813.2323841-1-samuel.holland@sifive.com>
In-Reply-To: <20240312212813.2323841-1-samuel.holland@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 13 Mar 2024 10:04:52 +0530
Message-ID: <CAAhSdy1TtGEVHG1GzeJGvA8yHvFmwWqvMZPCvh0wQuGExY8rKw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/riscv-intc: Fix use of AIA IRQs 32-63 on riscv32
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Albert Ou <aou@eecs.berkeley.edu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 2:58=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> riscv_intc_custom_base is initialized to BITS_PER_LONG, so the second
> check passes even though AIA provides 64 IRQs. Adjust the condition to
> only check the custom IRQ range for IRQs outside the standard range, and
> adjust the standard range when AIA is available.
>
> Fixes: bb7921cdea12 ("irqchip/riscv-intc: Add support for RISC-V AIA")
> Fixes: e6bd9b966dc8 ("irqchip/riscv-intc: Fix low-level interrupt handler=
 setup for AIA")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

I missed adjusting riscv_intc_nr_irqs in commit e6bd9b966dc8.
Thanks for catching.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>
>  drivers/irqchip/irq-riscv-intc.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index f87aeab460eb..9e71c4428814 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -149,8 +149,9 @@ static int riscv_intc_domain_alloc(struct irq_domain =
*domain,
>          * Only allow hwirq for which we have corresponding standard or
>          * custom interrupt enable register.
>          */
> -       if ((hwirq >=3D riscv_intc_nr_irqs && hwirq < riscv_intc_custom_b=
ase) ||
> -           (hwirq >=3D riscv_intc_custom_base + riscv_intc_custom_nr_irq=
s))
> +       if (hwirq >=3D riscv_intc_nr_irqs &&
> +           (hwirq < riscv_intc_custom_base ||
> +            hwirq >=3D riscv_intc_custom_base + riscv_intc_custom_nr_irq=
s))
>                 return -EINVAL;
>
>         for (i =3D 0; i < nr_irqs; i++) {
> @@ -183,10 +184,12 @@ static int __init riscv_intc_init_common(struct fwn=
ode_handle *fn, struct irq_ch
>                 return -ENXIO;
>         }
>
> -       if (riscv_isa_extension_available(NULL, SxAIA))
> +       if (riscv_isa_extension_available(NULL, SxAIA)) {
> +               riscv_intc_nr_irqs =3D 64;
>                 rc =3D set_handle_irq(&riscv_intc_aia_irq);
> -       else
> +       } else {
>                 rc =3D set_handle_irq(&riscv_intc_irq);
> +       }
>         if (rc) {
>                 pr_err("failed to set irq handler\n");
>                 return rc;
> @@ -195,7 +198,7 @@ static int __init riscv_intc_init_common(struct fwnod=
e_handle *fn, struct irq_ch
>         riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
>
>         pr_info("%d local interrupts mapped%s\n",
> -               riscv_isa_extension_available(NULL, SxAIA) ? 64 : riscv_i=
ntc_nr_irqs,
> +               riscv_intc_nr_irqs,
>                 riscv_isa_extension_available(NULL, SxAIA) ? " using AIA"=
 : "");
>         if (riscv_intc_custom_nr_irqs)
>                 pr_info("%d custom local interrupts mapped\n", riscv_intc=
_custom_nr_irqs);
> --
> 2.43.1
>

