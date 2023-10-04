Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB28C7B8482
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243245AbjJDQIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjJDQIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:08:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170CEC1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:08:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-565334377d0so1782332a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696435698; x=1697040498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArAGPHgh3ozAFw+P3T3leViQVG79Y2xBPqOZ8Wv+fnM=;
        b=MaOoas2kX6UbfzDSrJ8PBjIrS40cq1xzAqXlsXLz84BQhG4+AcqOripiX4CEtVJWlc
         vnAAuJN8x+/wg8i+Ex2OqprgtMB4qF28GkgV8g7UqxVSVze2SIgRD7phQsF6d48g8X/A
         +5kjekPFSiuEojHddizq8QpU9FwtL9rqywYNO3pDnEdkpdIgs6FkNhK5tv2xzTgBrZNn
         IlRZR+m2uIZGuQ2jdhmacHiD+VstQaPcfbLvKwNUyuCzQYtTRAC6rSLFA/9GGEhT0OTy
         1+oHns/ke1eml833cqTxxH1Os/tkfAzp9VsPoxB4F+861Gu6Nv7FunlkEZsIlU58E4s1
         hZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696435698; x=1697040498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArAGPHgh3ozAFw+P3T3leViQVG79Y2xBPqOZ8Wv+fnM=;
        b=Q0ovL/ygQU6LyMkCVSoVhIO25RX6Yp7IcUdOak99RrPQZYQ9pTmtikvWccBMaWAqxJ
         xykQ+7WsPhbLmYgh/tfJKkkFSHZJHl2zh1JsUUd8hTJQuUbFokBTH1pA5+UQrNIitzAE
         d+Qn4bGZwLq0/HdeTfA5izIZZOcMLNr7QkG6m2RuaP0aLzVufjEwIaSAH5/GtHDtJ73p
         NzJhiKQNhGe+wJTNxfBigSJbf/r7hJx6MkMZ60mqmh2NSSH8SSz/lqh49vjReFH3CvJo
         FUIBgW8FzjIg2TLKb193E58GNJLC4nZL4OiuUhCXM/kMq1yjSfl1PRQMaJPyk1wTz9bk
         UZwQ==
X-Gm-Message-State: AOJu0Yw7W4iJiclsxvCA9r6DPrEtXJJ5rwrezQx4NmJ4uAwzIv8i5ZtG
        e4Ccx0DXDwPzwtqEid2lvL0VjtKgl8SGQdcLZslYsw==
X-Google-Smtp-Source: AGHT+IFahlwd2MGDSD/UYYt8bxNZKia47kJFK5G12tNZu0xaYee3sS1go2QSPWZJ5H6NX/KCiQ+9Eb5A9aLjQZvveHs=
X-Received: by 2002:a17:90a:b891:b0:273:441a:dae6 with SMTP id
 o17-20020a17090ab89100b00273441adae6mr2549660pjr.19.1696435698141; Wed, 04
 Oct 2023 09:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230926102801.1591126-1-dunaev@tecon.ru> <CAK9=C2UiBNQtv0Q2yJMKqc5pMX_jam+ZmfRz3Rme0ZYuqN68HA@mail.gmail.com>
 <86il7mofmm.wl-maz@kernel.org> <CAK9=C2UUQ+ChueJVs+AnY0oCTb1zSv7qOCTijSchwxiMspX74w@mail.gmail.com>
 <86cyxuo128.wl-maz@kernel.org>
In-Reply-To: <86cyxuo128.wl-maz@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 4 Oct 2023 21:38:06 +0530
Message-ID: <CAK9=C2WcOy0_iEF7EF0LwjSRqVf2bbFaVNbxPXa=0OJtUkoVMw@mail.gmail.com>
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

On Wed, Oct 4, 2023 at 9:02=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 04 Oct 2023 15:59:33 +0100,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > On Wed, Oct 4, 2023 at 3:48=E2=80=AFPM Marc Zyngier <maz@kernel.org> wr=
ote:
> > >
> > > On Tue, 26 Sep 2023 11:36:31 +0100,
> > > Anup Patel <apatel@ventanamicro.com> wrote:
> > > >
> > > > On Tue, Sep 26, 2023 at 3:59=E2=80=AFPM Dmitry Dunaev <dunaev@tecon=
.ru> wrote:
> > > > >
> > > > > The current Linux driver irq-riscv-intc initialize IRQ domain onl=
y once,
> > > > > when init function called on primary hart. In other cases no IRQ =
domain is
> > > > > created and no operation on interrupt-controller node is performe=
d.
> > > > > This is cause of that no common Linux driver can use per-cpu inte=
rrupts
> > > > > mapped to several CPUs because fwnode of secondary cores INTC is =
not
> > > > > marked as initialized. This device is always will be marked as de=
ferred.
> > > > > For example the system with devicetree
> > > > >
> > > > >     cpu0: cpu@0 {
> > > > >         cpu0_intc: interrupt-controller {
> > > > >             interrupt-controller;
> > > > >             compatible =3D riscv,cpu-intc;
> > > > >         };
> > > > >     };
> > > > >
> > > > >     cpu1: cpu@1 {
> > > > >         cpu1_intc: interrupt-controller {
> > > > >             interrupt-controller;
> > > > >             compatible =3D riscv,cpu-intc;
> > > > >         };
> > > > >     };
> > > > >
> > > > >     buserr {
> > > > >         compatible =3D riscv,buserr;
> > > > >         interrupts-extended =3D <&cpu0_intc 16 &cpu1_intc 16>;
> > > > >     };
> > > > >
> > > > > will always report 'buserr' node as deferred without calling any
> > > > > bus probe function.
> > > > >
> > > > > This patch will mark all secondary nodes passed to irq-riscv-intc
> > > > > driver init function as initialized to be able to act as correct
> > > > > IRQ phandle node.
> > > > >
> > > > > Signed-off-by: Dmitry Dunaev <dunaev@tecon.ru>
> > > > > ---
> > > > >  drivers/irqchip/irq-riscv-intc.c | 8 ++++++--
> > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/i=
rq-riscv-intc.c
> > > > > index 4adeee1bc391..c01a4e8d4983 100644
> > > > > --- a/drivers/irqchip/irq-riscv-intc.c
> > > > > +++ b/drivers/irqchip/irq-riscv-intc.c
> > > > > @@ -155,8 +155,10 @@ static int __init riscv_intc_init(struct dev=
ice_node *node,
> > > > >          * for each INTC DT node. We only need to do INTC initial=
ization
> > > > >          * for the INTC DT node belonging to boot CPU (or boot HA=
RT).
> > > > >          */
> > > > > -       if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id()=
)
> > > > > +       if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id()=
) {
> > > > > +               fwnode_dev_initialized(of_node_to_fwnode(node), t=
rue);
> > > >
> > > > There is already a patch on LKML to address this.
> > > > https://www.spinics.net/lists/kernel/msg4929886.html
> > >
> > > If this is a fix, why is it buried in a huge series and not brought
> > > forward as an independent fix that needs to be picked early?
> >
> > Dmitry saw this issue in a totally different context which is not
> > reproducible with existing DTS files in kernel sources.
>
> I hope you're not suggesting that only the DTs that are present in the
> kernel tree are valid. Because as far as I'm concern, the DTs in the
> kernel tree are only some *examples*, and not a reference.

I am only saying why this issue was not observed before.

>
> I fully expect the vast majority of DTs to live *outside* of the
> kernel tree, provided by the firmware, and never upstreamed. Would you
> expect every PC vendor to upstream their ACPI tables?

I agree. We can't expect all vendors to submit DT to kernel sources.

>
> > This issue only manifests when some platform driver DT node
> > points to the per-HART INTC nodes. For example, RISC-V
> > irqchip device DT nodes point to per-HART INTC nodes.
>
> Is this configuration legal or not as per the DT binding? I don't see
> anything that suggests it isn't legal, and having per-CPU interrupts
> isn't exactly a new thing.

This is a perfect legal configuration in the RISC-V world. We have
similar DT binding for AIA drivers as well.

>
> > Currently, all RISC-V irqchip drivers (INTC and PLIC) are probed
> > early (not as platform drivers) so we don't see this issue with
> > existing irqchip drivers.
>
> You don't, but Dimitry does. Who wins?

I am totally fine taking PATCH3 of the Linux AIA v10 series as a
fix PATCH for 6.6-rcX. The PATCH3 is pretty self contained and
does not depend on any other PATCH of Linux AIA v10 series.

Do you want me to re-send it as an individual PATCH ?

Regards,
Anup

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
