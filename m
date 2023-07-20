Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0436375A568
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjGTFV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGTFV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:21:27 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D529F110
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:21:25 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76714caf466so44824385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689830485; x=1690435285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wbrMMQ8KV+niCaXh6uJjaEC3/Z2Le24zOgdMFKpH7A=;
        b=E/Zr9Jc6xEoShH0RQk2rvrcWAkbs2qJx8iGl9hbMHK7GaotEkfJngBuGG9PbGp8wVl
         wxoOpW7hEK/Uqmvksp1lfkKE6jtuimBAy9kR4ZHGFnhdoiM5QQIV6xIM6zB0uZ6A7Lr3
         /kljX445kk9wmORbSRIkspJM2rskoX8+4nF8q+xNmo3dsDPuIDvAjwsFKphO4I61OWpu
         CsF0hFAK2KiX9pWO+ZVlaPeEWYAuZZXG95Fb7mxBqnbAnisVFCRiWr9CWV7EGYYFvi9u
         tIkfz5kwp+4BU5MuqY2Z8YpqxuBhAjXPRhRzb02vogAW0IW/cwIUKT2YEXRRvjq16EE+
         sEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689830485; x=1690435285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wbrMMQ8KV+niCaXh6uJjaEC3/Z2Le24zOgdMFKpH7A=;
        b=ROTf4GeRLL3sZ4bu4ZuZH8qXK2VOdmZ2ZGMpNFaOsqxe+OrbFjK4VUzObcYnk+8ORt
         HFTIyJy1T0M8wN36CXLk9kIy0DzQa/wmNvh7xdqmn/zUBODgJHTxqaM/JdiGzpTsgBM+
         CtWBAmkYVFIhZMeEYawoJL9ys3MJWSC5mhhf2WRuXeBSFsuynwuVq2YG21V18CHtaMKa
         7u50IadC+xUK/KYLU2Put+Ogis520JmHgDW3XbD2Ffddjntkt4AlpBxYWIP1nk94otW3
         sPFNgKAAZP8bj6QK2n7yU4aFCM9aW0VVftQWtfA9EvYHL7bcrJx1aNNCbzAt5uTBb/Rx
         l4XA==
X-Gm-Message-State: ABy/qLYGapdbtXA68q8j9dshp/uJlMuTFTwBPGKOTC/FQ4BIq8EMyOnD
        IbJVohcfcA2YNiVT5F4WMd1fcduXarnoEdmX3wQCfFUhy9tJYlt2
X-Google-Smtp-Source: APBJJlHEOy19qtlkcGaHDIuc9mnNrYFhv8bdTodnJgm6v5jJ1iiM+01UseayFLO3E6jvX5MG6G8Qjpj5SRf478QYNEM=
X-Received: by 2002:a05:620a:6407:b0:760:69ca:7a1a with SMTP id
 pz7-20020a05620a640700b0076069ca7a1amr20891834qkn.1.1689830484880; Wed, 19
 Jul 2023 22:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230719113542.2293295-1-apatel@ventanamicro.com>
 <20230719113542.2293295-4-apatel@ventanamicro.com> <CAGETcx9zAF2ipO0s-6-zjyvn1JWt7OUS9G=cQ6OwyOPuqh-pBA@mail.gmail.com>
In-Reply-To: <CAGETcx9zAF2ipO0s-6-zjyvn1JWt7OUS9G=cQ6OwyOPuqh-pBA@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 20 Jul 2023 10:51:13 +0530
Message-ID: <CAK9=C2WZYn_TFZVY2a-DMaGzTesHUotDA2YJCjM6dYmcyyZ1og@mail.gmail.com>
Subject: Re: [PATCH v6 03/14] drivers: irqchip/riscv-intc: Mark all INTC nodes
 as initialized
To:     Saravana Kannan <saravanak@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 3:45=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Wed, Jul 19, 2023 at 4:36=E2=80=AFAM Anup Patel <apatel@ventanamicro.c=
om> wrote:
> >
> > The RISC-V INTC local interrupts are per-HART (or per-CPU) so
> > we create INTC IRQ domain only for the INTC node belonging to
> > the boot HART. This means only the boot HART INTC node will be
> > marked as initialized and other INTC nodes won't be marked which
> > results downstream interrupt controllers (such as IMSIC and APLIC
> > direct-mode) not being probed due to missing device suppliers.
> >
> > To address this issue, we mark all INTC node for which we don't
> > create IRQ domain as initialized.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/irq-riscv-intc.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-ris=
cv-intc.c
> > index 65f4a2afb381..4e2704bc25fb 100644
> > --- a/drivers/irqchip/irq-riscv-intc.c
> > +++ b/drivers/irqchip/irq-riscv-intc.c
> > @@ -155,8 +155,16 @@ static int __init riscv_intc_init(struct device_no=
de *node,
> >          * for each INTC DT node. We only need to do INTC initializatio=
n
> >          * for the INTC DT node belonging to boot CPU (or boot HART).
> >          */
> > -       if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id())
> > +       if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id()) {
> > +               /*
> > +                * The INTC nodes of each CPU are suppliers for downstr=
eam
> > +                * interrupt controllers (such as IMSIC and APLIC direc=
t-mode)
> > +                * so we should mark an INTC node as initialized if we =
are
> > +                * not creating IRQ domain for it.
> > +                */
>
> I'm a bit confused by this. If those non-boot CPUs INTC doesn't have
> an IRQ domain, why are the downstream interrupt controllers listing
> these non-boot CPU INTCs as an upstream interrupt controller?

Downstream interrupt controllers (such as PLIC, APLIC direct-mode,
or IMSIC) use "interrupts-extended" DT property to associate their
MMIO resources with target CPU.

For example: If we have 4 CPUs then PLIC will typically have 2 PLIC
MMIO contexts for each CPU where one context is for M-mode and
another context is for S-mode. In this case, there are total 8 PLIC
MMIO contexts and the arrangement of these MMIO resources is
platform specific so "interrupts-extended" DT property is used by
PLIC driver to discover the arrangement of PLIC MMIO contexts
and their mapping to target CPU.

Similar to the above example, the APLIC direct-mode has per-CPU
IDC MMIO registers and "interrupts-extended" DT property is used
to discover arrangement of these IDC MMIO registers and their
mapping to the target CPU.

>
> This is more of a question of the existing behavior that this patch,
> but this patch highlights the existing oddity.
>
> -Saravana
>
> > +               fwnode_dev_initialized(of_fwnode_handle(node), true);
> >                 return 0;
> > +       }
> >
> >         return riscv_intc_init_common(of_node_to_fwnode(node));
> >  }
> > --
> > 2.34.1
> >

Regards,
Anup
