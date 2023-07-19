Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D71075A191
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGSWPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSWP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:15:29 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46E91BCF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:15:28 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40540a8a3bbso56801cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689804928; x=1690409728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI4h//jtHulH4e1vD3lH5/PhOzYIPiS3BViR1dZJxNY=;
        b=gYT68r9HXYzI4rTptv1st6gRoYl7R798bb78w4Sz8KEx9R+xqwnmO0G6+XfdMvo8/K
         BBWJh6L+/q0Tu44Lse2slk06fPHzFBYEbqQvji3TxSyATaLaYnXbWOMfzOpt/7093AUP
         xYKA8J6zHD3WSyRAaav6Vyoh/Syldv4mCakm881HD8ue2Kbe4JJaxyFP8sehJvrLI03r
         0Sfd8qEKF14E9/1NCabDI7aLY2ft3vRKJPfxrL0qz+RRZ+mL7+CeV8W5/Pf/hhh7mKJ4
         qSHZnlunfsBb4Bdi9gCtTD0sjJOdTmQTDdcC/qOaQuoE+bT9/NQcPS+ZozBeUs7VzLYY
         FYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689804928; x=1690409728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI4h//jtHulH4e1vD3lH5/PhOzYIPiS3BViR1dZJxNY=;
        b=CRRT5nx0XUWLRb2byPOaf07SZmTOKRCiLoklksVWPaTRGxF3/3lEsbrtFsXkiPUJ3Z
         FJ+Fj+aH/DGt2YOxDWjoijoTvR8qIwoI9Cp2O0Q8No7DW2UMDO155uiUy4qXo8dcQ431
         lR7OlB6ZzE1BZPq6YJnLgUjh5ltTGLWW40NdPUdnmGMMMCIw6QRpzUzbMaXOuC1zARb1
         /9QiybLKZy0UEcZ8Df+1c/8U9jcWNuyaBRMJdD41fqBbI9XOtt4yh35ptpj3DICeRIf6
         C8tpZGqOoFpDGB5FPg+nEhwd0kmf3fSmQlhp+RSXcqlq3kjLWY3bkq7gpMcJl6dl72bG
         HiNA==
X-Gm-Message-State: ABy/qLZJQHs++Yd5FlX9Po1NSFaTucCMRiJpkwHcVRkYDrDr//1fdDga
        Njz86WXoQH8rcj6UNrHAj4NDB55BvffxJ5PfvzFCYg==
X-Google-Smtp-Source: APBJJlE9o37ZaHd/XcocCfK+Zf8TveQJE0XYZg4TdckQGOg3QWt9pydQkQ5o8hgi65StLMnWGe8GuZ4vXeadT+Nfxps=
X-Received: by 2002:ac8:5755:0:b0:403:f3f5:1a8 with SMTP id
 21-20020ac85755000000b00403f3f501a8mr89408qtx.12.1689804927647; Wed, 19 Jul
 2023 15:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230719113542.2293295-1-apatel@ventanamicro.com> <20230719113542.2293295-4-apatel@ventanamicro.com>
In-Reply-To: <20230719113542.2293295-4-apatel@ventanamicro.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 19 Jul 2023 15:14:51 -0700
Message-ID: <CAGETcx9zAF2ipO0s-6-zjyvn1JWt7OUS9G=cQ6OwyOPuqh-pBA@mail.gmail.com>
Subject: Re: [PATCH v6 03/14] drivers: irqchip/riscv-intc: Mark all INTC nodes
 as initialized
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 4:36=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> The RISC-V INTC local interrupts are per-HART (or per-CPU) so
> we create INTC IRQ domain only for the INTC node belonging to
> the boot HART. This means only the boot HART INTC node will be
> marked as initialized and other INTC nodes won't be marked which
> results downstream interrupt controllers (such as IMSIC and APLIC
> direct-mode) not being probed due to missing device suppliers.
>
> To address this issue, we mark all INTC node for which we don't
> create IRQ domain as initialized.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/irqchip/irq-riscv-intc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index 65f4a2afb381..4e2704bc25fb 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -155,8 +155,16 @@ static int __init riscv_intc_init(struct device_node=
 *node,
>          * for each INTC DT node. We only need to do INTC initialization
>          * for the INTC DT node belonging to boot CPU (or boot HART).
>          */
> -       if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id())
> +       if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id()) {
> +               /*
> +                * The INTC nodes of each CPU are suppliers for downstrea=
m
> +                * interrupt controllers (such as IMSIC and APLIC direct-=
mode)
> +                * so we should mark an INTC node as initialized if we ar=
e
> +                * not creating IRQ domain for it.
> +                */

I'm a bit confused by this. If those non-boot CPUs INTC doesn't have
an IRQ domain, why are the downstream interrupt controllers listing
these non-boot CPU INTCs as an upstream interrupt controller?

This is more of a question of the existing behavior that this patch,
but this patch highlights the existing oddity.

-Saravana

> +               fwnode_dev_initialized(of_fwnode_handle(node), true);
>                 return 0;
> +       }
>
>         return riscv_intc_init_common(of_node_to_fwnode(node));
>  }
> --
> 2.34.1
>
