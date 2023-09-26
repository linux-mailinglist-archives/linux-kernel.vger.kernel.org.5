Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ECE7AECC4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjIZM1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjIZM1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:27:51 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4104FB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:27:44 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3ae5e56e3a5so77011b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695731264; x=1696336064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecd6aTwmPojDhhjXTS5Sm+x1aifN6HhuUDSTeCWBUOE=;
        b=IekbgQ0FEDgHGh1AdBJRYBf9tbPtYunmm8reEBdivwhHZ1PW5N8hWVEYQjD5WDjWCs
         v0Uh+IWEfe/HQVz2yu7A48lTjf7RtwOz5bY0HKIqfb7bd8yJ3tyU/8SVrv3sVLcQeUTE
         9Vs79RIfWWtqE7FS5L6As4+OSVVsuJoYOHMzeI/6nkzsDxmnrJXkTYcdqLI0KGSgusxa
         WGtxxddaxhpELd1p3SOBtxt728aKe4G5C7fDkstbgPLcIgMsyZdOCZVUQOorgaPuy7ex
         Mp15eyKDeV3IVkt0oUCEHvMvitSp061LeHCS37PgBHY2SDv/0r52peUDrPtyU7pAl7/b
         gQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695731264; x=1696336064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecd6aTwmPojDhhjXTS5Sm+x1aifN6HhuUDSTeCWBUOE=;
        b=jcZmPEmnRWMcynxucEzuRgqjX3NQKHps5O2VaH3fLu7VRtURHp9dPEiMfPS4gwF7+Z
         UhIPa/+EyGN0igeCAMYKAs+uiCmtKmk51H4CPDgIMpq8yUkbZ8KEhYnksSzbKWwBmH3n
         8ccdnlF3nlgv5Ae7NjmLjcqBKsF1qqKzMwVx4Lpe+99gvoQLED1e9ldK3F2f5vOUnk07
         xa+niI5lZQREq1YmGfrT4/x+VUamQbJH/WG2m8rEQHJ7/kuljOgfvXXjnu1ycKq1BRIG
         xd4WaWaZriwkxA2S+foiJhJguvORDOxrXOeWe8Knv2yIDTeaFD/rFXdBBN9Z8aI4qJB8
         NHdg==
X-Gm-Message-State: AOJu0Ywk2ItCy3KzjyuvEXd8QchJ4q9ed2n+udwJwaieQTpxRRObHmna
        D+o1rfLjMteHbVY1fk3+Y7HnG4mCHv7neAWtsO9OXg==
X-Google-Smtp-Source: AGHT+IFcDYRKHI3MnCK+bdOiQSNRW9LfrPqOMjaeUxaMn6JJWkAZ5/iGEXuoRrOGmpuhKaQj689lWd1pSPIwfBK8lyo=
X-Received: by 2002:a05:6808:14cf:b0:3ae:1446:d48b with SMTP id
 f15-20020a05680814cf00b003ae1446d48bmr14011249oiw.3.1695731264006; Tue, 26
 Sep 2023 05:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230912174928.528414-1-apatel@ventanamicro.com>
 <20230912174928.528414-3-apatel@ventanamicro.com> <ZRE5A5GxF7wU68vt@sunil-laptop>
In-Reply-To: <ZRE5A5GxF7wU68vt@sunil-laptop>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 26 Sep 2023 17:57:31 +0530
Message-ID: <CAK9=C2X=KbvCjR2pQCVnqt3kgNtRH9-0S4JtXf+qci--fAuY8Q@mail.gmail.com>
Subject: Re: [PATCH v8 02/16] RISC-V: Add riscv_get_intc_hartid() function
To:     Sunil V L <sunilvl@ventanamicro.com>
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
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 1:08=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Hi Anup,
>
> On Tue, Sep 12, 2023 at 11:19:14PM +0530, Anup Patel wrote:
> > We add a common riscv_get_intc_hartid() which help device drivers to
> > get hartid of the HART associated with a INTC (i.e. local interrupt
> > controller) fwnode. This new function is more generic compared to
> > the existing riscv_of_parent_hartid() function hence we also replace
> > use of riscv_of_parent_hartid() with riscv_get_intc_hartid().
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/processor.h |  4 +++-
> >  arch/riscv/kernel/cpu.c            | 13 ++++++++++++-
> >  drivers/irqchip/irq-riscv-intc.c   |  2 +-
> >  drivers/irqchip/irq-sifive-plic.c  |  3 ++-
> >  4 files changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/as=
m/processor.h
> > index 3e23e1786d05..3ce64b3bea4e 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -119,7 +119,9 @@ static inline void wait_for_interrupt(void)
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
> >
> >  extern void riscv_fill_hwcap(void);
> >  extern int arch_dup_task_struct(struct task_struct *dst, struct task_s=
truct *src);
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index 157ace8b262c..ee583eac3c5b 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -123,7 +123,8 @@ int __init riscv_early_of_processor_hartid(struct d=
evice_node *node, unsigned lo
> >   * To achieve this, we walk up the DT tree until we find an active
> >   * RISC-V core (HART) node and extract the cpuid from it.
> >   */
> > -int riscv_of_parent_hartid(struct device_node *node, unsigned long *ha=
rtid)
> > +static int riscv_of_parent_hartid(struct device_node *node,
> > +                               unsigned long *hartid)
> >  {
> >       for (; node; node =3D node->parent) {
> >               if (of_device_is_compatible(node, "riscv")) {
> > @@ -139,6 +140,16 @@ int riscv_of_parent_hartid(struct device_node *nod=
e, unsigned long *hartid)
> >       return -1;
> >  }
> >
> > +/* Find hart ID of the INTC fwnode. */
> > +int riscv_get_intc_hartid(struct fwnode_handle *node, unsigned long *h=
artid)
> > +{
> > +     /* Extend this function ACPI in the future. */
>
> As per Marc's feedback, we can't use swnode for ACPI irchips. So, there
> is no need to create this wrapper function and this patch can be
> dropped.

Okay, I will drop this patch.

Regards,
Anup

>
> Thanks,
> Sunil
>
> > +     if (!is_of_node(node))
> > +             return -ENODEV;
> > +
> > +     return riscv_of_parent_hartid(to_of_node(node), hartid);
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
