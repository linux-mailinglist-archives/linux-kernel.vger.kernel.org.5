Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DD176DF4C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 06:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjHCEMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 00:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjHCEMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 00:12:20 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF4B2D70
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 21:12:18 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1bb954414e8so369725fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 21:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691035937; x=1691640737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd30A/fggcN39gGQkepwL8jeQAs7m97eSs1H31wFckk=;
        b=gchTmtHHTNGBMK+YVbrxUYjTe+nIANMrji0XlGoUMCaDfcmXNO9MzbzoN1UGAh4hEb
         B87W6Hi/mm1pyIPeos9QZaD3XBOdr/x16eFJzPVf+O9FgJ0YlsnfS4gAO8lT2xQBLygo
         JYQz+BqXau3MFZ8CvpgRtcbwoMZYyU/6eukLLowhWgzNU/lZ0j8b3iCGIX+C6BbKsysL
         9QFSgb5420atLu4wrLOWSR+KA/fDTwRRsoKOq9wTy6/qYW1T+zA38YL3D1casMQYLsrD
         vZNMZri6t3ZuOKW/wGXIh4sLR5oJERW692l88QcM9vgFpIUhUKYZeuFJjpfrvcFqLHBa
         jpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691035937; x=1691640737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd30A/fggcN39gGQkepwL8jeQAs7m97eSs1H31wFckk=;
        b=Mo3s0nVLQTfEOfVYMf6e/H+CSuuBZ+wsEjkFICqDQEgHS/5GCqkT2N45IslxnnKw+p
         nwFb8zAXF5flPuAeQraHG/xcDQYMCBC6cwjpmqlVTOau2dJ5BK7jmRWR5yvgtsDeZMe0
         jQSZ9g3eiXpqBSKmKDSTFKe6evGITT+7+gfVaH824C1arBYL3EPVgXUPvsswD+800uNu
         4fueDcctfT5y1z61MvkqdwDx6nRTFqWgewN2BfV3MjdP3WL9neDrWZnb/36TLCdwvHvK
         k/x5mCqlqj/pnxnMr2NZT0nU8GQK7pCvm8OICfCLoOe6vOz4U4OIbp4jRqREEGWBI8Od
         Orog==
X-Gm-Message-State: ABy/qLagGnyO4Uw3FFpErUZrpFObPzTbrUjeVFGOJym9n6DzMR2nQ2TC
        GH5oqZEO8Yhrnr9KMhESAZMrRJp3UwevyC317Mgakez/xjXpOw/enPoNdA==
X-Google-Smtp-Source: APBJJlGF8FGby+LnkJV4mKB0xGQp5jLExxKgE/f1UFtD3irgOue0rnzA//Q2O+jmw2s1SFCZprxjH4kY4EgyZTm4H/w=
X-Received: by 2002:a05:6870:ac0d:b0:1b0:2f63:4ff6 with SMTP id
 kw13-20020a056870ac0d00b001b02f634ff6mr22643857oab.1.1691035937115; Wed, 02
 Aug 2023 21:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230802150018.327079-1-apatel@ventanamicro.com>
 <20230802150018.327079-2-apatel@ventanamicro.com> <20230802-b0c478839e55890385d98f31@orel>
In-Reply-To: <20230802-b0c478839e55890385d98f31@orel>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 3 Aug 2023 09:42:04 +0530
Message-ID: <CAK9=C2V+RYFLiZTx5ygNrzrTyrrfrEnwqy90en0T+4zyHNAuYg@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] RISC-V: Add riscv_get_intc_hartid() function
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
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

On Wed, Aug 2, 2023 at 10:41=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Aug 02, 2023 at 08:30:04PM +0530, Anup Patel wrote:
> > We add a common riscv_get_intc_hartid() which help device drivers to
> > get hartid of the HART associated with a INTC (i.e. local interrupt
> > controller) fwnode. This new function is more generic compared to
> > the existing riscv_of_parent_hartid() function hence we also replace
> > use of riscv_of_parent_hartid() with riscv_get_intc_hartid().
> >
> > Also, while we are here let us update riscv_of_parent_hartid() to
> > always return the hartid irrespective whether the CPU/HART DT node
> > is disabled or not.
>
> This change should probably be a separate patch with its own
> justification in its commit message.

Okay, I will move this into a separate patch in the next revision.

>
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/processor.h |  4 +++-
> >  arch/riscv/kernel/cpu.c            | 26 ++++++++++++++++++++------
> >  drivers/irqchip/irq-riscv-intc.c   |  2 +-
> >  drivers/irqchip/irq-sifive-plic.c  |  3 ++-
> >  4 files changed, 26 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/as=
m/processor.h
> > index c950a8d9edef..662da1e112dd 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -79,7 +79,9 @@ static inline void wait_for_interrupt(void)
> >  struct device_node;
> >  int riscv_of_processor_hartid(struct device_node *node, unsigned long =
*hartid);
> >  int riscv_early_of_processor_hartid(struct device_node *node, unsigned=
 long *hartid);
> > -int riscv_of_parent_hartid(struct device_node *node, unsigned long *ha=
rtid);
> > +
> > +struct fwnode_handle;
> > +int riscv_get_intc_hartid(struct fwnode_handle *node, unsigned long *h=
artid);
>
> Do we want a function that is named in a way that appears to be
> intc-specific in processor.h?

Yes, this is intended to be only for intc because only intc fwnode can have
"hartid" property.

>
> >
> >  extern void riscv_fill_hwcap(void);
> >  extern int arch_dup_task_struct(struct task_struct *dst, struct task_s=
truct *src);
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index a2fc952318e9..c3eaa8a55bbe 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -81,21 +81,35 @@ int riscv_early_of_processor_hartid(struct device_n=
ode *node, unsigned long *har
> >   * To achieve this, we walk up the DT tree until we find an active
> >   * RISC-V core (HART) node and extract the cpuid from it.
> >   */
> > -int riscv_of_parent_hartid(struct device_node *node, unsigned long *ha=
rtid)
> > +static int riscv_of_parent_hartid(struct device_node *node,
> > +                               unsigned long *hartid)
> >  {
> > -     int rc;
> > -
> >       for (; node; node =3D node->parent) {
> >               if (of_device_is_compatible(node, "riscv")) {
> > -                     rc =3D riscv_of_processor_hartid(node, hartid);
> > -                     if (!rc)
> > -                             return 0;
> > +                     *hartid =3D (unsigned long)of_get_cpu_hwid(node, =
0);
>
> Shouldn't we still do something like
>
>    if (*hartid =3D=3D ~0UL) {
>        pr_warn_once("Found CPU without hart ID\n");
>        return -ENODEV;
>    }

Sure, I will add it in the next revision.

>
> > +                     return 0;
> >               }
> >       }
> >
> >       return -1;
> >  }
> >
> > +/* Find hart ID of the INTC fwnode. */
> > +int riscv_get_intc_hartid(struct fwnode_handle *node, unsigned long *h=
artid)
> > +{
> > +     int rc;
> > +     u64 temp;
> > +
> > +     if (!is_of_node(node)) {
> > +             rc =3D fwnode_property_read_u64_array(node, "hartid", &te=
mp, 1);
>
> This fwnode property read call seems premature, since we don't have any
> way to know that "hartid" will be a property of the intc since it's not a
> property documented in the DT binding. (I know Sunil has a series in
> progress which will introduce "hartid" for ACPI, but, even then, it seems
> like we need some documentation to point at that says '"hartid" is the
> name to use'.

Sure, I will return a failure if it is not an OF node and Sunil can include
a patch to extend this function for ACPI.

The idea here is that we create SW fwnodes for static ACPI tables and
the irqchip driver only uses fwnode APIs as an abstraction over DT and
ACPI. This way irqchip drivers work for both DT and ACPI with minimal
modifications.

Almost all properties of SW fwnodes are exactly same as defined by
the DT bindings except two synthetic properties:
1) "hartid" in INTC fwnode created only for ACPI
2) "gsi-base" in the APLIC fwnode created only for ACPI.

I suggest we should document both of these synthetic fwnode properties
in Documentation/riscv/acpi.rst since these are only for ACPI.

>
> > +             if (!rc)
> > +                     *hartid =3D temp;
> > +     } else
> > +             rc =3D riscv_of_parent_hartid(to_of_node(node), hartid);
> > +
> > +     return rc;
> > +}
> > +
> >  DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
> >
> >  unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
> > diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-ris=
cv-intc.c
> > index 4adeee1bc391..65f4a2afb381 100644
> > --- a/drivers/irqchip/irq-riscv-intc.c
> > +++ b/drivers/irqchip/irq-riscv-intc.c
> > @@ -143,7 +143,7 @@ static int __init riscv_intc_init(struct device_nod=
e *node,
> >       int rc;
> >       unsigned long hartid;
> >
> > -     rc =3D riscv_of_parent_hartid(node, &hartid);
> > +     rc =3D riscv_get_intc_hartid(of_fwnode_handle(node), &hartid);
> >       if (rc < 0) {
> >               pr_warn("unable to find hart id for %pOF\n", node);
> >               return 0;
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-si=
five-plic.c
> > index e1484905b7bd..56b0544b1f27 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -477,7 +477,8 @@ static int __init __plic_init(struct device_node *n=
ode,
> >                       continue;
> >               }
> >
> > -             error =3D riscv_of_parent_hartid(parent.np, &hartid);
> > +             error =3D riscv_get_intc_hartid(of_fwnode_handle(parent.n=
p),
> > +                                           &hartid);
> >               if (error < 0) {
> >                       pr_warn("failed to parse hart ID for context %d.\=
n", i);
> >                       continue;
> > --
> > 2.34.1
> >
>
> Thanks,
> drew

Regards,
Anup
