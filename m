Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E5E79795E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjIGRL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjIGRL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:11:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE471BF3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:11:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bf3f59905so144785166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1694106621; x=1694711421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlqiYu4W6Rw8b3OUfLdEXFPD32dWiZ3Dy4bMwhxUd4E=;
        b=o4HjhMORtc8aBsHlPMwaz6KhsBWJT1KgjXbc1OjkihtPHErtLZ1/dWBlRs3uGgdTmm
         Fwo5QUYY/4twE3L/RxvO0R4wMxnNfUbvP+nyrTQOZbMPNndTOTb+zOQc6BU/3C3EaJ6d
         5YkGCPR3PPhBB9qgGAwoTwqAbKNUhtc7kdyWauZsUHQV9CPOvu/nt9GzDfOEYVQc7OWF
         hAkM13Y3DLG0WwOxdBPFRW5RUN94mQspi+SBXTQvTzp+jFb6tlLXuWgzQny+gDUiqhG5
         krx4PPaGL2ef8tmnVW89dvMHUSQbDXnfWUepEPjv+OeqW3VEbCEGXQYFzmizp3tX1cH4
         DTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694106621; x=1694711421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlqiYu4W6Rw8b3OUfLdEXFPD32dWiZ3Dy4bMwhxUd4E=;
        b=cr9nEzHtkeb9bI59qAr8qSGhDnJR/Zx+LhCm2xxScSdYU7MqmUrQarbpRiRJd9gDi0
         R9TcUtQf1q3vOYUDwlBQoB7VNpTDYouDPYlcJgmVYKI9jnV8Qnyx0gbt+vbvEHPolxMr
         ZEtTHuM1zQq9ILhpVn5fUoxkqB+yD/brisUhW81FIkoRyw0ndmcgUFfDBGNaNjXmxWQA
         jM9BfBnwjY9yGq6axw6afyRyfb71tWha7i1FoV3KVW76eMD+J9bNRbRHLzd9hEURvHOl
         8UEVtlkBZGH/PqwQItnQsnssO6yImVKIHsYOhvWUkDU2XlUDYosk9vkDDgn1PlQZBgRV
         tbWw==
X-Gm-Message-State: AOJu0YxlrziI95FCoaalQDKTHJde2/mJH1kAiM8UOmoxlmBJ/NsC5KbX
        Y0xGI7sVAoNokO21chA1TmD/aCAx9hU1+TFAeyZMVrg8G2lGnxXd5L79Ug==
X-Google-Smtp-Source: AGHT+IFZKvLvDrcUUt1AdJGgmJG9It2BwH1JwdrdkbJnayvU4ppYimD21mX/yyhLW9K0tMnO6jb+LUunyIXhKsgJQIw=
X-Received: by 2002:a05:6512:706:b0:4f8:62a6:8b2 with SMTP id
 b6-20020a056512070600b004f862a608b2mr4812176lfs.46.1694092023638; Thu, 07 Sep
 2023 06:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230907021635.1002738-1-peterlin@andestech.com> <20230907021635.1002738-3-peterlin@andestech.com>
In-Reply-To: <20230907021635.1002738-3-peterlin@andestech.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 7 Sep 2023 18:36:52 +0530
Message-ID: <CAAhSdy0iy_7-XaE0s97J8jUESUzV-4BMsxsJ8QFNDyHgtv63ZA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] irqchip/riscv-intc: Support large non-standard
 hwirq number
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, atishp@atishpatra.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, ajones@ventanamicro.com,
        heiko@sntech.de, samuel@sholland.org, geert+renesas@glider.be,
        n.shubin@yadro.com, dminus@andestech.com, ycliang@andestech.com,
        tim609@andestech.com, locus84@andestech.com, dylan@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 7, 2023 at 7:48=E2=80=AFAM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> Currently, the implementation of the RISC-V INTC driver uses the
> interrupt cause as hwirq and has a limitation of supporting a
> maximum of 64 hwirqs. However, according to the privileged spec,
> interrupt cause >=3D 16 are defined for platform use.
>
> This limitation prevents us from fully utilizing the available
> local interrupt sources. Additionally, the hwirqs used on RISC-V
> are sparse, with only interrupt numbers 1, 5 and 9 (plus Sscofpmf
> or T-Head's PMU irq) being currently used for supervisor mode.
>
> The patch switches to using irq_domain_create_tree() which
> creates the radix tree map, allowing us to handle a larger
> number of hwirqs.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
>
> ---
> There are 3 hwirqs of local interrupt source exceed 64 defined in
> AX45MP datasheet [1] Table 56: AX45MP-1C scause Value After Trap:
> - 256+16 Slave port ECC error interrupt (S-mode)
> - 256+17 Bus write transaction error interrupt (S-mode)
> - 256+18 Performance monitor overflow interrupt(S-mode)
>
> [1] http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Data=
sheet.pdf
> ---
>  drivers/irqchip/irq-riscv-intc.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index 4adeee1bc391..76e1229c45de 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -24,8 +24,8 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *r=
egs)
>  {
>         unsigned long cause =3D regs->cause & ~CAUSE_IRQ_FLAG;
>
> -       if (unlikely(cause >=3D BITS_PER_LONG))
> -               panic("unexpected interrupt cause");
> +       if (!irq_find_mapping(intc_domain, cause))
> +               panic("unexpected interrupt cause: %ld", cause);

Checking irq_find_mapping() is redundant here instead check the return
value of generic_handle_domain_irq() and print warning on error.

>
>         generic_handle_domain_irq(intc_domain, cause);
>  }
> @@ -117,8 +117,8 @@ static int __init riscv_intc_init_common(struct fwnod=
e_handle *fn)
>  {
>         int rc;
>
> -       intc_domain =3D irq_domain_create_linear(fn, BITS_PER_LONG,
> -                                              &riscv_intc_domain_ops, NU=
LL);
> +       intc_domain =3D irq_domain_create_tree(fn, &riscv_intc_domain_ops=
,
> +                                            NULL);

This is incomplete because you have additional customization on-top-of
vanilla RISC-V INTC.

I suggest to do the following:
1) Define an enum of types of INTC (such as generic, andestech, etc)
2) Define new compatible string "andestec,cpu-intc" for you custom INTC
    and pass that information to riscv_intc_init_common()
3) Extend riscv_intc_domain_map() to use custom andestech_intc_chip
    for the custom local irqs. The andestech_intc_chip will provide andes
    specific mask/unmask mechanism.

>         if (!intc_domain) {
>                 pr_err("unable to add IRQ domain\n");
>                 return -ENXIO;
> @@ -132,8 +132,6 @@ static int __init riscv_intc_init_common(struct fwnod=
e_handle *fn)
>
>         riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
>
> -       pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> -
>         return 0;
>  }
>
> --
> 2.34.1
>

Regards,
Anup
