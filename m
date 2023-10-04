Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889797B8312
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbjJDO7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjJDO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:59:48 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F15C4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:59:45 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57b67c84999so1390250eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696431584; x=1697036384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEXQevqSveCTnz5Ht5KZikoHbpn3n64PdUPId3xt3YE=;
        b=Z+X5JBeA5N37UP19y0cbR/+Yd72STs+2Qbkzw6IskVOqEwn6007/KY80QfvP0lL4bz
         V+0tJhfYGKU6FWSkwur4DEyKzI7Bell3UoUPUSZCWL3/fEAa5PTqGna8+bmp69Yfyvrl
         0GFSYYJ6ClJUB5a9Y+BWVaryO3uO37HKNWdQrWSXhArjIDKyePo5wuRiHZxHxmZjXbGf
         A1T+/SyqGWjfNbUIyKChCsXRnSgf00to/EDMB7zydJH6FA6EhcKouA1k37fm5BO5hGL1
         kPLInqPOGlPdbyemlwweSo/70s7vt4y++VmZ9IFCJgj5SPrY5BVfzW63pU6m75evat4T
         qQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696431584; x=1697036384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEXQevqSveCTnz5Ht5KZikoHbpn3n64PdUPId3xt3YE=;
        b=hTyyuDtC+JYYgBWSJlVVHwkNIH9/6+BbF7DglBIwhMEa080WRi2pgCz9x8vJZuSqOO
         XJ3/ElrwUWfR3BBEo1qsu2hoI/uHZGPQI10gv5cyeccm5NU1/bT2Hp3dpD6Z0ihjeEm6
         DIGWr1bwxtLoVoYhxXlPp5oibhBVCuCBX7UCm/VMlB1M1FJfAh3srG6XSpu4xi4n3S+f
         S40o0pB6jymI1aSRIUG96xjeyTlvMP8rRaHyD8GW7rspJVlplWCPBmsnOBu1lIHm1w/8
         Jz1f5SFb9SeaevedeaXKqofMU70Aqtb7Cpt3dNRPQPKdhaeTsMXECE+swd/vUSB2v8yK
         A34A==
X-Gm-Message-State: AOJu0Yxr9Q0u7pK+qRcLVh+0cnDCbY8FnzNAZfbziYHR/t5JFRnma1j3
        7lUVeFDF4ve+DQeDKuXxwHogqOzmaWKxA7geuxvt7PgP9KrN5wz7kIA=
X-Google-Smtp-Source: AGHT+IFU7hW/Kn3xhnt1RQxTnCHcZyF4PyxNb82RfQJ7+yx9mDLdmtP9so8jDV+twSh1CFHLLdLH12ppJ6Wj39xJrXw=
X-Received: by 2002:a05:6358:718b:b0:142:d678:f708 with SMTP id
 t11-20020a056358718b00b00142d678f708mr3006382rwt.19.1696431584156; Wed, 04
 Oct 2023 07:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230926102801.1591126-1-dunaev@tecon.ru> <CAK9=C2UiBNQtv0Q2yJMKqc5pMX_jam+ZmfRz3Rme0ZYuqN68HA@mail.gmail.com>
 <86il7mofmm.wl-maz@kernel.org>
In-Reply-To: <86il7mofmm.wl-maz@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 4 Oct 2023 20:29:33 +0530
Message-ID: <CAK9=C2UUQ+ChueJVs+AnY0oCTb1zSv7qOCTijSchwxiMspX74w@mail.gmail.com>
Subject: Re: [PATCH] irqchip/riscv-intc: Mark INTC nodes for secondary CPUs as initialized.
To:     Marc Zyngier <maz@kernel.org>
Cc:     Dmitry Dunaev <dunaev@tecon.ru>, dunaich@mail.ru,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 3:48=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 26 Sep 2023 11:36:31 +0100,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > On Tue, Sep 26, 2023 at 3:59=E2=80=AFPM Dmitry Dunaev <dunaev@tecon.ru>=
 wrote:
> > >
> > > The current Linux driver irq-riscv-intc initialize IRQ domain only on=
ce,
> > > when init function called on primary hart. In other cases no IRQ doma=
in is
> > > created and no operation on interrupt-controller node is performed.
> > > This is cause of that no common Linux driver can use per-cpu interrup=
ts
> > > mapped to several CPUs because fwnode of secondary cores INTC is not
> > > marked as initialized. This device is always will be marked as deferr=
ed.
> > > For example the system with devicetree
> > >
> > >     cpu0: cpu@0 {
> > >         cpu0_intc: interrupt-controller {
> > >             interrupt-controller;
> > >             compatible =3D riscv,cpu-intc;
> > >         };
> > >     };
> > >
> > >     cpu1: cpu@1 {
> > >         cpu1_intc: interrupt-controller {
> > >             interrupt-controller;
> > >             compatible =3D riscv,cpu-intc;
> > >         };
> > >     };
> > >
> > >     buserr {
> > >         compatible =3D riscv,buserr;
> > >         interrupts-extended =3D <&cpu0_intc 16 &cpu1_intc 16>;
> > >     };
> > >
> > > will always report 'buserr' node as deferred without calling any
> > > bus probe function.
> > >
> > > This patch will mark all secondary nodes passed to irq-riscv-intc
> > > driver init function as initialized to be able to act as correct
> > > IRQ phandle node.
> > >
> > > Signed-off-by: Dmitry Dunaev <dunaev@tecon.ru>
> > > ---
> > >  drivers/irqchip/irq-riscv-intc.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-r=
iscv-intc.c
> > > index 4adeee1bc391..c01a4e8d4983 100644
> > > --- a/drivers/irqchip/irq-riscv-intc.c
> > > +++ b/drivers/irqchip/irq-riscv-intc.c
> > > @@ -155,8 +155,10 @@ static int __init riscv_intc_init(struct device_=
node *node,
> > >          * for each INTC DT node. We only need to do INTC initializat=
ion
> > >          * for the INTC DT node belonging to boot CPU (or boot HART).
> > >          */
> > > -       if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id())
> > > +       if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id()) {
> > > +               fwnode_dev_initialized(of_node_to_fwnode(node), true)=
;
> >
> > There is already a patch on LKML to address this.
> > https://www.spinics.net/lists/kernel/msg4929886.html
>
> If this is a fix, why is it buried in a huge series and not brought
> forward as an independent fix that needs to be picked early?

Dmitry saw this issue in a totally different context which is not
reproducible with existing DTS files in kernel sources.

This issue only manifests when some platform driver DT node
points to the per-HART INTC nodes. For example, RISC-V
irqchip device DT nodes point to per-HART INTC nodes.

Currently, all RISC-V irqchip drivers (INTC and PLIC) are probed
early (not as platform drivers) so we don't see this issue with
existing irqchip drivers.

The Linux AIA series implements RISC-V irqchip drivers (PLIC,
APLIC, and IMSIC) as regular platform drivers (like you suggested)
so this issue is easily seen with Linux AIA series hence the
corresponding fix is part of the Linux AIA series.
(https://www.spinics.net/lists/devicetree/msg638068.html)


Regards,
Anup



>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
