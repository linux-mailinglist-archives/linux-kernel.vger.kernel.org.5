Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CCA7D6101
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjJYFIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 01:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJYFId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:08:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB03E5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 22:08:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27d425a2dd0so4589706a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 22:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698210511; x=1698815311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFvh81m/EkJYzWlFXi+WuBbUWclMpLB5KNSNRJow4Gk=;
        b=aHpIMNAOAlB2/YqNG5UTqHmTouDdjZ6KZxQ2Gmp2DLy+T55QIw1Qafmq37UkmmeNJY
         ik8ercMqf3UGkb3sybVxvkFRlTdCshoHlb2h2uQ2W9UvQIpDKfseXQEMy0rmCG0sowqE
         JvqZ41cZ/pSo0ebQPPPrd6ueWNVvnTJX0RAd0k94p07VX0UuAevvvK+zwTfqYUdAjffv
         ms/673vVXUmt0s6PxY+tSdnon5wCfnGZw46mYAXXFpdlKWtzmyfS2SW7homhYVb0Xsh0
         210a0ZMP/W0QAPocwTUBs9+Q/HEgXXJK9MABcaENF59V/0TUbJUZ1Vkqi7Mxnq4eJU8s
         GFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698210511; x=1698815311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFvh81m/EkJYzWlFXi+WuBbUWclMpLB5KNSNRJow4Gk=;
        b=rqFfn6SzIuwQSjDE7MlWlJJv538cpm+MVGLSurIO02KsP3x2bS3xRlCh2g3l98N+g2
         tCB4TbkCbOFP7073OG24sV2/6VwFMuQ9o2O+zMO4d1596H4SUvXVFKyc24X8dF0Ibtvj
         KpITySxqnC4sPLQRppbcg5uYiBnd/2aT70qLjDPtLlXg+rfyK1CTIyrQju37tnAcWI0k
         7wJWu/6o84QbLvUVDNichGMf+i62hl18zXO2R/HwftkP3tpo9KldPmXO5aQ4rOQ1p452
         sNhwwNlUVjhbqgExpyex0BDK1dPsNhBTeKtYMWXuy8yMBN7NEFjCeIjofkLELhurwcYH
         KTmw==
X-Gm-Message-State: AOJu0Ywnqc9eKY+484Y5bc4iLUvGpwQUZdpukgnWnxXHkC8EcQ7oDu7o
        vqvQsinLVFKgVPPquKHlmqGD0FJmoYxKtTMcb3vwCg==
X-Google-Smtp-Source: AGHT+IHcaVxUx65KUpdn3fS8Uk95UJXFTtrVhI8I3RT798xBXThkTN9cWmveeVlGayof6ryYYLraHDlLGhg4cwxsmyg=
X-Received: by 2002:a17:90b:4d12:b0:279:2dac:80b3 with SMTP id
 mw18-20020a17090b4d1200b002792dac80b3mr13071676pjb.44.1698210510922; Tue, 24
 Oct 2023 22:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-10-apatel@ventanamicro.com> <8734y0rwtw.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <8734y0rwtw.fsf@all.your.base.are.belong.to.us>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 25 Oct 2023 10:38:20 +0530
Message-ID: <CAK9=C2UVgTd-a0671Lab_ZeOPWP3=wHY+pydKHqaR-Yg65YhrA@mail.gmail.com>
Subject: Re: [PATCH v11 09/14] irqchip/riscv-imsic: Add support for PCI MSI irqdomain
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 6:39=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> > The Linux PCI framework requires it's own dedicated MSI irqdomain so
> > let us create PCI MSI irqdomain as child of the IMSIC base irqdomain.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/Kconfig                    |  7 +++
> >  drivers/irqchip/irq-riscv-imsic-platform.c | 51 ++++++++++++++++++++++
> >  drivers/irqchip/irq-riscv-imsic-state.h    |  1 +
> >  3 files changed, 59 insertions(+)
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index bdd80716114d..c1d69b418dfb 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -552,6 +552,13 @@ config RISCV_IMSIC
> >       select IRQ_DOMAIN_HIERARCHY
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
> > index 23d286cb017e..cdb659401199 100644
> > --- a/drivers/irqchip/irq-riscv-imsic-platform.c
> > +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/irqdomain.h>
> >  #include <linux/module.h>
> >  #include <linux/msi.h>
> > +#include <linux/pci.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/smp.h>
> > @@ -215,6 +216,42 @@ static const struct irq_domain_ops imsic_base_doma=
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
>
> I've asked this before, but I still don't get why you need to propagate
> to the parent? Why isn't masking on PCI enough?
>

We are using hierarchical IRQ domains where IMSIC-BASE is
the root domain whereas IMSIC-PLAT domain (MSI irq domain
for platform devices) and IMSIC-PCI domain (MSI irq domain
for PCI devices). For hierarchical IRQ domains, if irq domain X
does not implement irq_mask/unmask then the parent irq
domain irq_mask/unmask is called with parent irq descriptor.

Now for IMSIC-PCI domain, the PCI framework expects the
pci_msi_mask/unmask_irq() functions to be called but if
we directly point pci_msi_mask/unmask_irq() in the IMSIC-PCI
irqchip then IMSIC-BASE (parent domain) irq_mask/umask
won't be called hence the IRQ won't be masked/unmask.
Due to this, we call both pci_msi_mask/unmask_irq() and
irq_chip_mask/unmask_parent() for IMSIC-PCI domain.

The ARM GIC driver also uses hierarchical IRQ domains
even there same thing is done.
(Refer, first 30 lines of drivers/irqchip/irq-gic-v3-its-pci-msi.c)

Regards,
Anup
