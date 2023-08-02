Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AD276D8DB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjHBUvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjHBUu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:50:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1680C1990
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:50:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-267ffa7e441so112692a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691009452; x=1691614252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6ziqYzLHy0RXtgC9Ak+8dJhihKSGpFQsSv2DUe8xyQ=;
        b=OsCn6qhmNqbYU+T80Pj2hZAK++4j1vGWdHTr6cqZJzKRUFaPMteZPb+z+iF7EwmUma
         DAjIqzF1h4WYuHKgW2fajUh3C6IBhs+zYw2z1c8cFt6GyKQlyLV2lOAp22nQekoAHD5b
         Ayuq7k5pnKqguQvnh8/TRxymZxySZ7al8tMa50O9dQPpwsEiFbt5a52XnOzfYNqBeEAt
         +fUcKv+nEE7+X6mROWWuJKSNusvrvJSc471AK9J63ZASJF/bEMSnJIJO5PBmL8joFZ9S
         acz/CytNnxQE4QFh7vNAvcWRZHNmzhHpN76bEUtu68quC75O9XVsZ1IgxJ0wbPCMv5Ve
         Y/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691009452; x=1691614252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6ziqYzLHy0RXtgC9Ak+8dJhihKSGpFQsSv2DUe8xyQ=;
        b=VwSNd3SVkeDoTNNB0PYAq/+y7B0QAurfkjkyXJ/GwZG4AQt5vUqw+V8ZQM3R62ZeUL
         268Y0F4/No5XniZCwBGi8rjI7/PjdZ5WBkKO1mgMk+Tqnru+5mpWpBRsTH6odGwY2HP4
         iEbmO1h6X+3jrPsuaLB+Z0ajtyy8iDu+POheHkzsyeAf+l9B1AWwoajXnxrRgyyezz6J
         INFHW/Pj+F1sn0YbkyN99+pPScDxRCA5gyO89nJHQM66HsV9x+tb20jLcCMFhWMfouG3
         CjQCtKA+oJCl1oWW+i5Qbq9EbmOVxpWfxB3J8In7s2JDDueQlWUqfQBKIEqrzC5L5m8Q
         cJQw==
X-Gm-Message-State: ABy/qLYdslTw8X6QFyMy7PxeABt7RRGkCkNopUwkqSmrf7HE5/RbJoLl
        E6qdTs7NyFNI9hvbB+22afrqHw4AGM+5zL/+R2KIyg==
X-Google-Smtp-Source: APBJJlEvLAKF3NkfXSK2LJGGO9DxK6GrLwze5+ZpfDlpBUk2k8dgowIpraxHFnGqRMo9mOOkjQnCpCLZrzEODdMsNpc=
X-Received: by 2002:a17:90b:897:b0:261:685:95b6 with SMTP id
 bj23-20020a17090b089700b00261068595b6mr16371530pjb.13.1691009452284; Wed, 02
 Aug 2023 13:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0pm+1yXuvUGudwNtvNHWV3FytH4VfCnq7_Ws=t-MZP_kQ@mail.gmail.com>
In-Reply-To: <CANXhq0pm+1yXuvUGudwNtvNHWV3FytH4VfCnq7_Ws=t-MZP_kQ@mail.gmail.com>
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
Date:   Wed, 2 Aug 2023 13:50:41 -0700
Message-ID: <CAH2o1u5P-y8UF-nCXGPs8kiKk3Y1MY8XVdDCcjp+5+zdDqxZXQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
To:     Zong Li <zong.li@sifive.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 5:58=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote:
>
> On Thu, Jul 20, 2023 at 3:34=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc=
.com> wrote:
> >
> > Enables message or wire signal interrupts for PCIe and platforms device=
s.
> >
> > Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> > Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > ---
> >  drivers/iommu/riscv/iommu-pci.c      |  72 ++++
> >  drivers/iommu/riscv/iommu-platform.c |  66 +++
> >  drivers/iommu/riscv/iommu.c          | 604 ++++++++++++++++++++++++++-
> >  drivers/iommu/riscv/iommu.h          |  28 ++
> >  4 files changed, 769 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iomm=
u-pci.c
> > index c91f963d7a29..9ea0647f7b92 100644
> > --- a/drivers/iommu/riscv/iommu-pci.c
> > +++ b/drivers/iommu/riscv/iommu-pci.c
> > @@ -34,6 +34,7 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev=
, const struct pci_device_i
> >  {
> >         struct device *dev =3D &pdev->dev;
> >         struct riscv_iommu_device *iommu;
> > +       u64 icvec;
> >         int ret;
> >
> >         ret =3D pci_enable_device_mem(pdev);
> > @@ -67,14 +68,84 @@ static int riscv_iommu_pci_probe(struct pci_dev *pd=
ev, const struct pci_device_i
> >         iommu->dev =3D dev;
> >         dev_set_drvdata(dev, iommu);
> >
> > +       /* Check device reported capabilities. */
> > +       iommu->cap =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAP);
> > +
> > +       /* The PCI driver only uses MSIs, make sure the IOMMU supports =
this */
> > +       switch (FIELD_GET(RISCV_IOMMU_CAP_IGS, iommu->cap)) {
> > +       case RISCV_IOMMU_CAP_IGS_MSI:
> > +       case RISCV_IOMMU_CAP_IGS_BOTH:
> > +               break;
> > +       default:
> > +               dev_err(dev, "unable to use message-signaled interrupts=
\n");
> > +               ret =3D -ENODEV;
> > +               goto fail;
> > +       }
> > +
> >         dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> >         pci_set_master(pdev);
> >
> > +       /* Allocate and assign IRQ vectors for the various events */
> > +       ret =3D pci_alloc_irq_vectors(pdev, 1, RISCV_IOMMU_INTR_COUNT, =
PCI_IRQ_MSIX);
> > +       if (ret < 0) {
> > +               dev_err(dev, "unable to allocate irq vectors\n");
> > +               goto fail;
> > +       }
> > +
> > +       ret =3D -ENODEV;
> > +
> > +       iommu->irq_cmdq =3D msi_get_virq(dev, RISCV_IOMMU_INTR_CQ);
> > +       if (!iommu->irq_cmdq) {
> > +               dev_warn(dev, "no MSI vector %d for the command queue\n=
",
> > +                        RISCV_IOMMU_INTR_CQ);
> > +               goto fail;
> > +       }
> > +
> > +       iommu->irq_fltq =3D msi_get_virq(dev, RISCV_IOMMU_INTR_FQ);
> > +       if (!iommu->irq_fltq) {
> > +               dev_warn(dev, "no MSI vector %d for the fault/event que=
ue\n",
> > +                        RISCV_IOMMU_INTR_FQ);
> > +               goto fail;
> > +       }
> > +
> > +       if (iommu->cap & RISCV_IOMMU_CAP_HPM) {
> > +               iommu->irq_pm =3D msi_get_virq(dev, RISCV_IOMMU_INTR_PM=
);
> > +               if (!iommu->irq_pm) {
> > +                       dev_warn(dev,
> > +                                "no MSI vector %d for performance moni=
toring\n",
> > +                                RISCV_IOMMU_INTR_PM);
> > +                       goto fail;
> > +               }
> > +       }
> > +
> > +       if (iommu->cap & RISCV_IOMMU_CAP_ATS) {
> > +               iommu->irq_priq =3D msi_get_virq(dev, RISCV_IOMMU_INTR_=
PQ);
> > +               if (!iommu->irq_priq) {
> > +                       dev_warn(dev,
> > +                                "no MSI vector %d for page-request que=
ue\n",
> > +                                RISCV_IOMMU_INTR_PQ);
> > +                       goto fail;
> > +               }
> > +       }
> > +
> > +       /* Set simple 1:1 mapping for MSI vectors */
> > +       icvec =3D FIELD_PREP(RISCV_IOMMU_IVEC_CIV, RISCV_IOMMU_INTR_CQ)=
 |
> > +           FIELD_PREP(RISCV_IOMMU_IVEC_FIV, RISCV_IOMMU_INTR_FQ);
> > +
> > +       if (iommu->cap & RISCV_IOMMU_CAP_HPM)
> > +               icvec |=3D FIELD_PREP(RISCV_IOMMU_IVEC_PMIV, RISCV_IOMM=
U_INTR_PM);
> > +
> > +       if (iommu->cap & RISCV_IOMMU_CAP_ATS)
> > +               icvec |=3D FIELD_PREP(RISCV_IOMMU_IVEC_PIV, RISCV_IOMMU=
_INTR_PQ);
> > +
> > +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IVEC, icvec);
> > +
> >         ret =3D riscv_iommu_init(iommu);
> >         if (!ret)
> >                 return ret;
> >
> >   fail:
> > +       pci_free_irq_vectors(pdev);
> >         pci_clear_master(pdev);
> >         pci_release_regions(pdev);
> >         pci_disable_device(pdev);
> > @@ -85,6 +156,7 @@ static int riscv_iommu_pci_probe(struct pci_dev *pde=
v, const struct pci_device_i
> >  static void riscv_iommu_pci_remove(struct pci_dev *pdev)
> >  {
> >         riscv_iommu_remove(dev_get_drvdata(&pdev->dev));
> > +       pci_free_irq_vectors(pdev);
> >         pci_clear_master(pdev);
> >         pci_release_regions(pdev);
> >         pci_disable_device(pdev);
> > diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv=
/iommu-platform.c
> > index e4e8ca6711e7..35935d3c7ef4 100644
> > --- a/drivers/iommu/riscv/iommu-platform.c
> > +++ b/drivers/iommu/riscv/iommu-platform.c
> > @@ -20,6 +20,8 @@ static int riscv_iommu_platform_probe(struct platform=
_device *pdev)
> >         struct device *dev =3D &pdev->dev;
> >         struct riscv_iommu_device *iommu =3D NULL;
> >         struct resource *res =3D NULL;
> > +       u32 fctl =3D 0;
> > +       int irq =3D 0;
> >         int ret =3D 0;
> >
> >         iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> > @@ -53,6 +55,70 @@ static int riscv_iommu_platform_probe(struct platfor=
m_device *pdev)
> >                 goto fail;
> >         }
> >
> > +       iommu->cap =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAP);
> > +
> > +       /* For now we only support WSIs until we have AIA support */
>
> I'm not completely understand AIA support here, because I saw the pci
> case uses the MSI, and kernel seems to have the AIA implementation.
> Could you please elaborate it?
>
> > +       ret =3D FIELD_GET(RISCV_IOMMU_CAP_IGS, iommu->cap);
> > +       if (ret =3D=3D RISCV_IOMMU_CAP_IGS_MSI) {
> > +               dev_err(dev, "IOMMU only supports MSIs\n");
> > +               goto fail;
> > +       }
> > +
> > +       /* Parse IRQ assignment */
> > +       irq =3D platform_get_irq_byname_optional(pdev, "cmdq");
> > +       if (irq > 0)
> > +               iommu->irq_cmdq =3D irq;
> > +       else {
> > +               dev_err(dev, "no IRQ provided for the command queue\n")=
;
> > +               goto fail;
> > +       }
> > +
> > +       irq =3D platform_get_irq_byname_optional(pdev, "fltq");
> > +       if (irq > 0)
> > +               iommu->irq_fltq =3D irq;
> > +       else {
> > +               dev_err(dev, "no IRQ provided for the fault/event queue=
\n");
> > +               goto fail;
> > +       }
> > +
> > +       if (iommu->cap & RISCV_IOMMU_CAP_HPM) {
> > +               irq =3D platform_get_irq_byname_optional(pdev, "pm");
> > +               if (irq > 0)
> > +                       iommu->irq_pm =3D irq;
> > +               else {
> > +                       dev_err(dev, "no IRQ provided for performance m=
onitoring\n");
> > +                       goto fail;
> > +               }
> > +       }
> > +
> > +       if (iommu->cap & RISCV_IOMMU_CAP_ATS) {
> > +               irq =3D platform_get_irq_byname_optional(pdev, "priq");
> > +               if (irq > 0)
> > +                       iommu->irq_priq =3D irq;
> > +               else {
> > +                       dev_err(dev, "no IRQ provided for the page-requ=
est queue\n");
> > +                       goto fail;
> > +               }
> > +       }
>
> Should we define the "interrupt-names" in dt-bindings?
>

Yes, this was brought up earlier wrt dt-bindings.

I'm considering removal of interrupt names from DT (and get-byname
option), as IOMMU hardware cause-to-vector remapping `icvec` should be
used to map interrupt source to actual interrupt vector. If possible
device driver should map cause to interrupt (based on number of
vectors available) or rely on ICVEC WARL properties to discover fixed
cause-to-vector mapping in the hardware.

Please let me know if this is reasonable change.

> > +
> > +       /* Make sure fctl.WSI is set */
> > +       fctl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> > +       fctl |=3D RISCV_IOMMU_FCTL_WSI;
> > +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, fctl);
> > +
> > +       /* Parse Queue lengts */
> > +       ret =3D of_property_read_u32(pdev->dev.of_node, "cmdq_len", &io=
mmu->cmdq_len);
> > +       if (!ret)
> > +               dev_info(dev, "command queue length set to %i\n", iommu=
->cmdq_len);
> > +
> > +       ret =3D of_property_read_u32(pdev->dev.of_node, "fltq_len", &io=
mmu->fltq_len);
> > +       if (!ret)
> > +               dev_info(dev, "fault/event queue length set to %i\n", i=
ommu->fltq_len);
> > +
> > +       ret =3D of_property_read_u32(pdev->dev.of_node, "priq_len", &io=
mmu->priq_len);
> > +       if (!ret)
> > +               dev_info(dev, "page request queue length set to %i\n", =
iommu->priq_len);
> > +
> >         dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> >
> >         return riscv_iommu_init(iommu);
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 31dc3c458e13..5c4cf9875302 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -45,6 +45,18 @@ static int ddt_mode =3D RISCV_IOMMU_DDTP_MODE_BARE;
> >  module_param(ddt_mode, int, 0644);
> >  MODULE_PARM_DESC(ddt_mode, "Device Directory Table mode.");
> >
> > +static int cmdq_length =3D 1024;
> > +module_param(cmdq_length, int, 0644);
> > +MODULE_PARM_DESC(cmdq_length, "Command queue length.");
> > +
> > +static int fltq_length =3D 1024;
> > +module_param(fltq_length, int, 0644);
> > +MODULE_PARM_DESC(fltq_length, "Fault queue length.");
> > +
> > +static int priq_length =3D 1024;
> > +module_param(priq_length, int, 0644);
> > +MODULE_PARM_DESC(priq_length, "Page request interface queue length.");
> > +
> >  /* IOMMU PSCID allocation namespace. */
> >  #define RISCV_IOMMU_MAX_PSCID  (1U << 20)
> >  static DEFINE_IDA(riscv_iommu_pscids);
> > @@ -65,6 +77,497 @@ static DEFINE_IDA(riscv_iommu_pscids);
> >  static const struct iommu_domain_ops riscv_iommu_domain_ops;
> >  static const struct iommu_ops riscv_iommu_ops;
> >
> > +/*
> > + * Common queue management routines
> > + */
> > +
> > +/* Note: offsets are the same for all queues */
> > +#define Q_HEAD(q) ((q)->qbr + (RISCV_IOMMU_REG_CQH - RISCV_IOMMU_REG_C=
QB))
> > +#define Q_TAIL(q) ((q)->qbr + (RISCV_IOMMU_REG_CQT - RISCV_IOMMU_REG_C=
QB))
> > +
> > +static unsigned riscv_iommu_queue_consume(struct riscv_iommu_device *i=
ommu,
> > +                                         struct riscv_iommu_queue *q, =
unsigned *ready)
> > +{
> > +       u32 tail =3D riscv_iommu_readl(iommu, Q_TAIL(q));
> > +       *ready =3D q->lui;
> > +
> > +       BUG_ON(q->cnt <=3D tail);
> > +       if (q->lui <=3D tail)
> > +               return tail - q->lui;
> > +       return q->cnt - q->lui;
> > +}
> > +
> > +static void riscv_iommu_queue_release(struct riscv_iommu_device *iommu=
,
> > +                                     struct riscv_iommu_queue *q, unsi=
gned count)
> > +{
> > +       q->lui =3D (q->lui + count) & (q->cnt - 1);
> > +       riscv_iommu_writel(iommu, Q_HEAD(q), q->lui);
> > +}
> > +
> > +static u32 riscv_iommu_queue_ctrl(struct riscv_iommu_device *iommu,
> > +                                 struct riscv_iommu_queue *q, u32 val)
> > +{
> > +       cycles_t end_cycles =3D RISCV_IOMMU_TIMEOUT + get_cycles();
> > +
> > +       riscv_iommu_writel(iommu, q->qcr, val);
> > +       do {
> > +               val =3D riscv_iommu_readl(iommu, q->qcr);
> > +               if (!(val & RISCV_IOMMU_QUEUE_BUSY))
> > +                       break;
> > +               cpu_relax();
> > +       } while (get_cycles() < end_cycles);
> > +
> > +       return val;
> > +}
> > +
> > +static void riscv_iommu_queue_free(struct riscv_iommu_device *iommu,
> > +                                  struct riscv_iommu_queue *q)
> > +{
> > +       size_t size =3D q->len * q->cnt;
> > +
> > +       riscv_iommu_queue_ctrl(iommu, q, 0);
> > +
> > +       if (q->base) {
> > +               if (q->in_iomem)
> > +                       iounmap(q->base);
> > +               else
> > +                       dmam_free_coherent(iommu->dev, size, q->base, q=
->base_dma);
> > +       }
> > +       if (q->irq)
> > +               free_irq(q->irq, q);
> > +}
> > +
> > +static irqreturn_t riscv_iommu_cmdq_irq_check(int irq, void *data);
> > +static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data);
> > +static irqreturn_t riscv_iommu_fltq_irq_check(int irq, void *data);
> > +static irqreturn_t riscv_iommu_fltq_process(int irq, void *data);
> > +static irqreturn_t riscv_iommu_priq_irq_check(int irq, void *data);
> > +static irqreturn_t riscv_iommu_priq_process(int irq, void *data);
> > +
> > +static int riscv_iommu_queue_init(struct riscv_iommu_device *iommu, in=
t queue_id)
> > +{
> > +       struct device *dev =3D iommu->dev;
> > +       struct riscv_iommu_queue *q =3D NULL;
> > +       size_t queue_size =3D 0;
> > +       irq_handler_t irq_check;
> > +       irq_handler_t irq_process;
> > +       const char *name;
> > +       int count =3D 0;
> > +       int irq =3D 0;
> > +       unsigned order =3D 0;
> > +       u64 qbr_val =3D 0;
> > +       u64 qbr_readback =3D 0;
> > +       u64 qbr_paddr =3D 0;
> > +       int ret =3D 0;
> > +
> > +       switch (queue_id) {
> > +       case RISCV_IOMMU_COMMAND_QUEUE:
> > +               q =3D &iommu->cmdq;
> > +               q->len =3D sizeof(struct riscv_iommu_command);
> > +               count =3D iommu->cmdq_len;
> > +               irq =3D iommu->irq_cmdq;
> > +               irq_check =3D riscv_iommu_cmdq_irq_check;
> > +               irq_process =3D riscv_iommu_cmdq_process;
> > +               q->qbr =3D RISCV_IOMMU_REG_CQB;
> > +               q->qcr =3D RISCV_IOMMU_REG_CQCSR;
> > +               name =3D "cmdq";
> > +               break;
> > +       case RISCV_IOMMU_FAULT_QUEUE:
> > +               q =3D &iommu->fltq;
> > +               q->len =3D sizeof(struct riscv_iommu_fq_record);
> > +               count =3D iommu->fltq_len;
> > +               irq =3D iommu->irq_fltq;
> > +               irq_check =3D riscv_iommu_fltq_irq_check;
> > +               irq_process =3D riscv_iommu_fltq_process;
> > +               q->qbr =3D RISCV_IOMMU_REG_FQB;
> > +               q->qcr =3D RISCV_IOMMU_REG_FQCSR;
> > +               name =3D "fltq";
> > +               break;
> > +       case RISCV_IOMMU_PAGE_REQUEST_QUEUE:
> > +               q =3D &iommu->priq;
> > +               q->len =3D sizeof(struct riscv_iommu_pq_record);
> > +               count =3D iommu->priq_len;
> > +               irq =3D iommu->irq_priq;
> > +               irq_check =3D riscv_iommu_priq_irq_check;
> > +               irq_process =3D riscv_iommu_priq_process;
> > +               q->qbr =3D RISCV_IOMMU_REG_PQB;
> > +               q->qcr =3D RISCV_IOMMU_REG_PQCSR;
> > +               name =3D "priq";
> > +               break;
> > +       default:
> > +               dev_err(dev, "invalid queue interrupt index in queue_in=
it!\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Polling not implemented */
> > +       if (!irq)
> > +               return -ENODEV;
> > +
> > +       /* Allocate queue in memory and set the base register */
> > +       order =3D ilog2(count);
> > +       do {
> > +               queue_size =3D q->len * (1ULL << order);
> > +               q->base =3D dmam_alloc_coherent(dev, queue_size, &q->ba=
se_dma, GFP_KERNEL);
> > +               if (q->base || queue_size < PAGE_SIZE)
> > +                       break;
> > +
> > +               order--;
> > +       } while (1);
> > +
> > +       if (!q->base) {
> > +               dev_err(dev, "failed to allocate %s queue (cnt: %u)\n",=
 name, count);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       q->cnt =3D 1ULL << order;
> > +
> > +       qbr_val =3D phys_to_ppn(q->base_dma) |
> > +           FIELD_PREP(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, order - 1);
> > +
> > +       riscv_iommu_writeq(iommu, q->qbr, qbr_val);
> > +
> > +       /*
> > +        * Queue base registers are WARL, so it's possible that whateve=
r we wrote
> > +        * there was illegal/not supported by the hw in which case we n=
eed to make
> > +        * sure we set a supported PPN and/or queue size.
> > +        */
> > +       qbr_readback =3D riscv_iommu_readq(iommu, q->qbr);
> > +       if (qbr_readback =3D=3D qbr_val)
> > +               goto irq;
> > +
> > +       dmam_free_coherent(dev, queue_size, q->base, q->base_dma);
> > +
> > +       /* Get supported queue size */
> > +       order =3D FIELD_GET(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, qbr_readback=
) + 1;
> > +       q->cnt =3D 1ULL << order;
> > +       queue_size =3D q->len * q->cnt;
> > +
> > +       /*
> > +        * In case we also failed to set PPN, it means the field is har=
dcoded and the
> > +        * queue resides in I/O memory instead, so get its physical add=
ress and
> > +        * ioremap it.
> > +        */
> > +       qbr_paddr =3D ppn_to_phys(qbr_readback);
> > +       if (qbr_paddr !=3D q->base_dma) {
> > +               dev_info(dev,
> > +                        "hardcoded ppn in %s base register, using io m=
emory for the queue\n",
> > +                        name);
> > +               dev_info(dev, "queue length for %s set to %i\n", name, =
q->cnt);
> > +               q->in_iomem =3D true;
> > +               q->base =3D ioremap(qbr_paddr, queue_size);
> > +               if (!q->base) {
> > +                       dev_err(dev, "failed to map %s queue (cnt: %u)\=
n", name, q->cnt);
> > +                       return -ENOMEM;
> > +               }
> > +               q->base_dma =3D qbr_paddr;
> > +       } else {
> > +               /*
> > +                * We only failed to set the queue size, re-try to allo=
cate memory with
> > +                * the queue size supported by the hw.
> > +                */
> > +               dev_info(dev, "hardcoded queue size in %s base register=
\n", name);
> > +               dev_info(dev, "retrying with queue length: %i\n", q->cn=
t);
> > +               q->base =3D dmam_alloc_coherent(dev, queue_size, &q->ba=
se_dma, GFP_KERNEL);
> > +               if (!q->base) {
> > +                       dev_err(dev, "failed to allocate %s queue (cnt:=
 %u)\n",
> > +                               name, q->cnt);
> > +                       return -ENOMEM;
> > +               }
> > +       }
> > +
> > +       qbr_val =3D phys_to_ppn(q->base_dma) |
> > +           FIELD_PREP(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, order - 1);
> > +       riscv_iommu_writeq(iommu, q->qbr, qbr_val);
> > +
> > +       /* Final check to make sure hw accepted our write */
> > +       qbr_readback =3D riscv_iommu_readq(iommu, q->qbr);
> > +       if (qbr_readback !=3D qbr_val) {
> > +               dev_err(dev, "failed to set base register for %s\n", na=
me);
> > +               goto fail;
> > +       }
> > +
> > + irq:
> > +       if (request_threaded_irq(irq, irq_check, irq_process, IRQF_ONES=
HOT | IRQF_SHARED,
> > +                                dev_name(dev), q)) {
> > +               dev_err(dev, "fail to request irq %d for %s\n", irq, na=
me);
> > +               goto fail;
> > +       }
> > +
> > +       q->irq =3D irq;
> > +
> > +       /* Note: All RIO_xQ_EN/IE fields are in the same offsets */
> > +       ret =3D
> > +           riscv_iommu_queue_ctrl(iommu, q,
> > +                                  RISCV_IOMMU_QUEUE_ENABLE |
> > +                                  RISCV_IOMMU_QUEUE_INTR_ENABLE);
> > +       if (ret & RISCV_IOMMU_QUEUE_BUSY) {
> > +               dev_err(dev, "%s init timeout\n", name);
> > +               ret =3D -EBUSY;
> > +               goto fail;
> > +       }
> > +
> > +       return 0;
> > +
> > + fail:
> > +       riscv_iommu_queue_free(iommu, q);
> > +       return 0;
> > +}
> > +
> > +/*
> > + * I/O MMU Command queue chapter 3.1
> > + */
> > +
> > +static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_comman=
d *cmd)
> > +{
> > +       cmd->dword0 =3D
> > +           FIELD_PREP(RISCV_IOMMU_CMD_OPCODE,
> > +                      RISCV_IOMMU_CMD_IOTINVAL_OPCODE) | FIELD_PREP(RI=
SCV_IOMMU_CMD_FUNC,
> > +                                                                    RI=
SCV_IOMMU_CMD_IOTINVAL_FUNC_VMA);
> > +       cmd->dword1 =3D 0;
> > +}
> > +
> > +static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_c=
ommand *cmd,
> > +                                                 u64 addr)
> > +{
> > +       cmd->dword0 |=3D RISCV_IOMMU_CMD_IOTINVAL_AV;
> > +       cmd->dword1 =3D addr;
> > +}
> > +
> > +static inline void riscv_iommu_cmd_inval_set_pscid(struct riscv_iommu_=
command *cmd,
> > +                                                  unsigned pscid)
> > +{
> > +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_PSCID, psc=
id) |
> > +           RISCV_IOMMU_CMD_IOTINVAL_PSCV;
> > +}
> > +
> > +static inline void riscv_iommu_cmd_inval_set_gscid(struct riscv_iommu_=
command *cmd,
> > +                                                  unsigned gscid)
> > +{
> > +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_GSCID, gsc=
id) |
> > +           RISCV_IOMMU_CMD_IOTINVAL_GV;
> > +}
> > +
> > +static inline void riscv_iommu_cmd_iofence(struct riscv_iommu_command =
*cmd)
> > +{
> > +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_=
CMD_IOFENCE_OPCODE) |
> > +           FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IOFENCE_FU=
NC_C);
> > +       cmd->dword1 =3D 0;
> > +}
> > +
> > +static inline void riscv_iommu_cmd_iofence_set_av(struct riscv_iommu_c=
ommand *cmd,
> > +                                                 u64 addr, u32 data)
> > +{
> > +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_=
CMD_IOFENCE_OPCODE) |
> > +           FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IOFENCE_FU=
NC_C) |
> > +           FIELD_PREP(RISCV_IOMMU_CMD_IOFENCE_DATA, data) | RISCV_IOMM=
U_CMD_IOFENCE_AV;
> > +       cmd->dword1 =3D (addr >> 2);
> > +}
> > +
> > +static inline void riscv_iommu_cmd_iodir_inval_ddt(struct riscv_iommu_=
command *cmd)
> > +{
> > +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_=
CMD_IODIR_OPCODE) |
> > +           FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IODIR_FUNC=
_INVAL_DDT);
> > +       cmd->dword1 =3D 0;
> > +}
> > +
> > +static inline void riscv_iommu_cmd_iodir_inval_pdt(struct riscv_iommu_=
command *cmd)
> > +{
> > +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_=
CMD_IODIR_OPCODE) |
> > +           FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IODIR_FUNC=
_INVAL_PDT);
> > +       cmd->dword1 =3D 0;
> > +}
> > +
> > +static inline void riscv_iommu_cmd_iodir_set_did(struct riscv_iommu_co=
mmand *cmd,
> > +                                                unsigned devid)
> > +{
> > +       cmd->dword0 |=3D
> > +           FIELD_PREP(RISCV_IOMMU_CMD_IODIR_DID, devid) | RISCV_IOMMU_=
CMD_IODIR_DV;
> > +}
> > +
> > +/* TODO: Convert into lock-less MPSC implementation. */
> > +static bool riscv_iommu_post_sync(struct riscv_iommu_device *iommu,
> > +                                 struct riscv_iommu_command *cmd, bool=
 sync)
> > +{
> > +       u32 head, tail, next, last;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&iommu->cq_lock, flags);
> > +       head =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_CQH) & (iommu=
->cmdq.cnt - 1);
> > +       tail =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_CQT) & (iommu=
->cmdq.cnt - 1);
> > +       last =3D iommu->cmdq.lui;
> > +       if (tail !=3D last) {
> > +               spin_unlock_irqrestore(&iommu->cq_lock, flags);
> > +               /*
> > +                * FIXME: This is a workaround for dropped MMIO writes/=
reads on QEMU platform.
> > +                *        While debugging of the problem is still ongoi=
ng, this provides
> > +                *        a simple impolementation of try-again policy.
> > +                *        Will be changed to lock-less algorithm in the=
 feature.
> > +                */
> > +               dev_dbg(iommu->dev, "IOMMU CQT: %x !=3D %x (1st)\n", la=
st, tail);
> > +               spin_lock_irqsave(&iommu->cq_lock, flags);
> > +               tail =3D
> > +                   riscv_iommu_readl(iommu, RISCV_IOMMU_REG_CQT) & (io=
mmu->cmdq.cnt - 1);
> > +               last =3D iommu->cmdq.lui;
> > +               if (tail !=3D last) {
> > +                       spin_unlock_irqrestore(&iommu->cq_lock, flags);
> > +                       dev_dbg(iommu->dev, "IOMMU CQT: %x !=3D %x (2nd=
)\n", last, tail);
> > +                       spin_lock_irqsave(&iommu->cq_lock, flags);
> > +               }
> > +       }
> > +
> > +       next =3D (last + 1) & (iommu->cmdq.cnt - 1);
> > +       if (next !=3D head) {
> > +               struct riscv_iommu_command *ptr =3D iommu->cmdq.base;
> > +               ptr[last] =3D *cmd;
> > +               wmb();
> > +               riscv_iommu_writel(iommu, RISCV_IOMMU_REG_CQT, next);
> > +               iommu->cmdq.lui =3D next;
> > +       }
> > +
> > +       spin_unlock_irqrestore(&iommu->cq_lock, flags);
> > +
> > +       if (sync && head !=3D next) {
> > +               cycles_t start_time =3D get_cycles();
> > +               while (1) {
> > +                       last =3D riscv_iommu_readl(iommu, RISCV_IOMMU_R=
EG_CQH) &
> > +                           (iommu->cmdq.cnt - 1);
> > +                       if (head < next && last >=3D next)
> > +                               break;
> > +                       if (head > next && last < head && last >=3D nex=
t)
> > +                               break;
> > +                       if (RISCV_IOMMU_TIMEOUT < (get_cycles() - start=
_time)) {
>
> This condition will be imprecise, because here is not in irq disabled
> context, it will be scheduled out or preempted. When we come back
> here, it might be over 1 second, but the IOFENCE is actually
> completed.
>

Good point. Thank.


> > +                               dev_err(iommu->dev, "IOFENCE TIMEOUT\n"=
);
> > +                               return false;
> > +                       }
> > +                       cpu_relax();
> > +               }
> > +       }
> > +
> > +       return next !=3D head;
> > +}
> > +
> > +static bool riscv_iommu_post(struct riscv_iommu_device *iommu,
> > +                            struct riscv_iommu_command *cmd)
> > +{
> > +       return riscv_iommu_post_sync(iommu, cmd, false);
> > +}
> > +
> > +static bool riscv_iommu_iofence_sync(struct riscv_iommu_device *iommu)
> > +{
> > +       struct riscv_iommu_command cmd;
> > +       riscv_iommu_cmd_iofence(&cmd);
> > +       return riscv_iommu_post_sync(iommu, &cmd, true);
> > +}
> > +
> > +/* Command queue primary interrupt handler */
> > +static irqreturn_t riscv_iommu_cmdq_irq_check(int irq, void *data)
> > +{
> > +       struct riscv_iommu_queue *q =3D (struct riscv_iommu_queue *)dat=
a;
> > +       struct riscv_iommu_device *iommu =3D
> > +           container_of(q, struct riscv_iommu_device, cmdq);
> > +       u32 ipsr =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IPSR);
> > +       if (ipsr & RISCV_IOMMU_IPSR_CIP)
> > +               return IRQ_WAKE_THREAD;
> > +       return IRQ_NONE;
> > +}
> > +
> > +/* Command queue interrupt hanlder thread function */
> > +static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
> > +{
> > +       struct riscv_iommu_queue *q =3D (struct riscv_iommu_queue *)dat=
a;
> > +       struct riscv_iommu_device *iommu;
> > +       unsigned ctrl;
> > +
> > +       iommu =3D container_of(q, struct riscv_iommu_device, cmdq);
> > +
> > +       /* Error reporting, clear error reports if any. */
> > +       ctrl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_CQCSR);
> > +       if (ctrl & (RISCV_IOMMU_CQCSR_CQMF |
> > +                   RISCV_IOMMU_CQCSR_CMD_TO | RISCV_IOMMU_CQCSR_CMD_IL=
L)) {
> > +               riscv_iommu_queue_ctrl(iommu, &iommu->cmdq, ctrl);
> > +               dev_warn_ratelimited(iommu->dev,
> > +                                    "Command queue error: fault: %d to=
ut: %d err: %d\n",
> > +                                    !!(ctrl & RISCV_IOMMU_CQCSR_CQMF),
> > +                                    !!(ctrl & RISCV_IOMMU_CQCSR_CMD_TO=
),
> > +                                    !!(ctrl & RISCV_IOMMU_CQCSR_CMD_IL=
L));
>
> We need to handle the error by either adjusting the tail to remove the
> failed command or fixing the failed command itself. Otherwise, the
> failed command will keep in the queue and IOMMU will try to execute
> it. I guess the first option might be easier to implement.
>

Correct. Thanks for pointing this out.
Error handling / recovery was not pushed in this series. There is
work-in-progress series to handle various types of failures, including
command processing errors, DDT misconfiguration, queue overflows,
device reported faults handling, etc.  I can bring some of the error
handling here, if needed. Otherwise I'd prefer to keep it as separate
series, sent out once this one is merged.

> > +       }
> > +
> > +       /* Clear fault interrupt pending. */
> > +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPS=
R_CIP);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +/*
> > + * Fault/event queue, chapter 3.2
> > + */
> > +
> > +static void riscv_iommu_fault_report(struct riscv_iommu_device *iommu,
> > +                                    struct riscv_iommu_fq_record *even=
t)
> > +{
> > +       unsigned err, devid;
> > +
> > +       err =3D FIELD_GET(RISCV_IOMMU_FQ_HDR_CAUSE, event->hdr);
> > +       devid =3D FIELD_GET(RISCV_IOMMU_FQ_HDR_DID, event->hdr);
> > +
> > +       dev_warn_ratelimited(iommu->dev,
> > +                            "Fault %d devid: %d" " iotval: %llx iotval=
2: %llx\n", err,
> > +                            devid, event->iotval, event->iotval2);
> > +}
> > +
> > +/* Fault/event queue primary interrupt handler */
> > +static irqreturn_t riscv_iommu_fltq_irq_check(int irq, void *data)
> > +{
> > +       struct riscv_iommu_queue *q =3D (struct riscv_iommu_queue *)dat=
a;
> > +       struct riscv_iommu_device *iommu =3D
> > +           container_of(q, struct riscv_iommu_device, fltq);
> > +       u32 ipsr =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IPSR);
> > +       if (ipsr & RISCV_IOMMU_IPSR_FIP)
> > +               return IRQ_WAKE_THREAD;
> > +       return IRQ_NONE;
> > +}
> > +
> > +/* Fault queue interrupt hanlder thread function */
> > +static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
> > +{
> > +       struct riscv_iommu_queue *q =3D (struct riscv_iommu_queue *)dat=
a;
> > +       struct riscv_iommu_device *iommu;
> > +       struct riscv_iommu_fq_record *events;
> > +       unsigned cnt, len, idx, ctrl;
> > +
> > +       iommu =3D container_of(q, struct riscv_iommu_device, fltq);
> > +       events =3D (struct riscv_iommu_fq_record *)q->base;
> > +
> > +       /* Error reporting, clear error reports if any. */
> > +       ctrl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FQCSR);
> > +       if (ctrl & (RISCV_IOMMU_FQCSR_FQMF | RISCV_IOMMU_FQCSR_FQOF)) {
> > +               riscv_iommu_queue_ctrl(iommu, &iommu->fltq, ctrl);
> > +               dev_warn_ratelimited(iommu->dev,
> > +                                    "Fault queue error: fault: %d full=
: %d\n",
> > +                                    !!(ctrl & RISCV_IOMMU_FQCSR_FQMF),
> > +                                    !!(ctrl & RISCV_IOMMU_FQCSR_FQOF))=
;
> > +       }
> > +
> > +       /* Clear fault interrupt pending. */
> > +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPS=
R_FIP);
> > +
> > +       /* Report fault events. */
> > +       do {
> > +               cnt =3D riscv_iommu_queue_consume(iommu, q, &idx);
> > +               if (!cnt)
> > +                       break;
> > +               for (len =3D 0; len < cnt; idx++, len++)
> > +                       riscv_iommu_fault_report(iommu, &events[idx]);
> > +               riscv_iommu_queue_release(iommu, q, cnt);
> > +       } while (1);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +/*
> > + * Page request queue, chapter 3.3
> > + */
> > +
> >  /*
> >   * Register device for IOMMU tracking.
> >   */
> > @@ -97,6 +600,54 @@ static void riscv_iommu_add_device(struct riscv_iom=
mu_device *iommu, struct devi
> >         mutex_unlock(&iommu->eps_mutex);
> >  }
> >
> > +/* Page request interface queue primary interrupt handler */
> > +static irqreturn_t riscv_iommu_priq_irq_check(int irq, void *data)
> > +{
> > +       struct riscv_iommu_queue *q =3D (struct riscv_iommu_queue *)dat=
a;
> > +       struct riscv_iommu_device *iommu =3D
> > +           container_of(q, struct riscv_iommu_device, priq);
> > +       u32 ipsr =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IPSR);
> > +       if (ipsr & RISCV_IOMMU_IPSR_PIP)
> > +               return IRQ_WAKE_THREAD;
> > +       return IRQ_NONE;
> > +}
> > +
> > +/* Page request interface queue interrupt hanlder thread function */
> > +static irqreturn_t riscv_iommu_priq_process(int irq, void *data)
> > +{
> > +       struct riscv_iommu_queue *q =3D (struct riscv_iommu_queue *)dat=
a;
> > +       struct riscv_iommu_device *iommu;
> > +       struct riscv_iommu_pq_record *requests;
> > +       unsigned cnt, idx, ctrl;
> > +
> > +       iommu =3D container_of(q, struct riscv_iommu_device, priq);
> > +       requests =3D (struct riscv_iommu_pq_record *)q->base;
> > +
> > +       /* Error reporting, clear error reports if any. */
> > +       ctrl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_PQCSR);
> > +       if (ctrl & (RISCV_IOMMU_PQCSR_PQMF | RISCV_IOMMU_PQCSR_PQOF)) {
> > +               riscv_iommu_queue_ctrl(iommu, &iommu->priq, ctrl);
> > +               dev_warn_ratelimited(iommu->dev,
> > +                                    "Page request queue error: fault: =
%d full: %d\n",
> > +                                    !!(ctrl & RISCV_IOMMU_PQCSR_PQMF),
> > +                                    !!(ctrl & RISCV_IOMMU_PQCSR_PQOF))=
;
> > +       }
> > +
> > +       /* Clear page request interrupt pending. */
> > +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPS=
R_PIP);
> > +
> > +       /* Process page requests. */
> > +       do {
> > +               cnt =3D riscv_iommu_queue_consume(iommu, q, &idx);
> > +               if (!cnt)
> > +                       break;
> > +               dev_warn(iommu->dev, "unexpected %u page requests\n", c=
nt);
> > +               riscv_iommu_queue_release(iommu, q, cnt);
> > +       } while (1);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> >  /*
> >   * Endpoint management
> >   */
> > @@ -350,7 +901,29 @@ static void riscv_iommu_flush_iotlb_range(struct i=
ommu_domain *iommu_domain,
> >                                           unsigned long *start, unsigne=
d long *end,
> >                                           size_t *pgsize)
> >  {
> > -       /* Command interface not implemented */
> > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iom=
mu_domain);
> > +       struct riscv_iommu_command cmd;
> > +       unsigned long iova;
> > +
> > +       if (domain->mode =3D=3D RISCV_IOMMU_DC_FSC_MODE_BARE)
> > +               return;
> > +
> > +       /* Domain not attached to an IOMMU! */
> > +       BUG_ON(!domain->iommu);
> > +
> > +       riscv_iommu_cmd_inval_vma(&cmd);
> > +       riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> > +
> > +       if (start && end && pgsize) {
> > +               /* Cover only the range that is needed */
> > +               for (iova =3D *start; iova <=3D *end; iova +=3D *pgsize=
) {
> > +                       riscv_iommu_cmd_inval_set_addr(&cmd, iova);
> > +                       riscv_iommu_post(domain->iommu, &cmd);
> > +               }
> > +       } else {
> > +               riscv_iommu_post(domain->iommu, &cmd);
> > +       }
> > +       riscv_iommu_iofence_sync(domain->iommu);
> >  }
> >
> >  static void riscv_iommu_flush_iotlb_all(struct iommu_domain *iommu_dom=
ain)
> > @@ -610,6 +1183,9 @@ void riscv_iommu_remove(struct riscv_iommu_device =
*iommu)
> >         iommu_device_unregister(&iommu->iommu);
> >         iommu_device_sysfs_remove(&iommu->iommu);
> >         riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> > +       riscv_iommu_queue_free(iommu, &iommu->cmdq);
> > +       riscv_iommu_queue_free(iommu, &iommu->fltq);
> > +       riscv_iommu_queue_free(iommu, &iommu->priq);
> >  }
> >
> >  int riscv_iommu_init(struct riscv_iommu_device *iommu)
> > @@ -632,6 +1208,16 @@ int riscv_iommu_init(struct riscv_iommu_device *i=
ommu)
> >         }
> >  #endif
> >
> > +       /*
> > +        * Assign queue lengths from module parameters if not already
> > +        * set on the device tree.
> > +        */
> > +       if (!iommu->cmdq_len)
> > +               iommu->cmdq_len =3D cmdq_length;
> > +       if (!iommu->fltq_len)
> > +               iommu->fltq_len =3D fltq_length;
> > +       if (!iommu->priq_len)
> > +               iommu->priq_len =3D priq_length;
> >         /* Clear any pending interrupt flag. */
> >         riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR,
> >                            RISCV_IOMMU_IPSR_CIP |
> > @@ -639,7 +1225,20 @@ int riscv_iommu_init(struct riscv_iommu_device *i=
ommu)
> >                            RISCV_IOMMU_IPSR_PMIP | RISCV_IOMMU_IPSR_PIP=
);
> >         spin_lock_init(&iommu->cq_lock);
> >         mutex_init(&iommu->eps_mutex);
> > +       ret =3D riscv_iommu_queue_init(iommu, RISCV_IOMMU_COMMAND_QUEUE=
);
> > +       if (ret)
> > +               goto fail;
> > +       ret =3D riscv_iommu_queue_init(iommu, RISCV_IOMMU_FAULT_QUEUE);
> > +       if (ret)
> > +               goto fail;
> > +       if (!(iommu->cap & RISCV_IOMMU_CAP_ATS))
> > +               goto no_ats;
> > +
> > +       ret =3D riscv_iommu_queue_init(iommu, RISCV_IOMMU_PAGE_REQUEST_=
QUEUE);
> > +       if (ret)
> > +               goto fail;
> >
> > + no_ats:
> >         ret =3D riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_BARE);
> >
> >         if (ret) {
> > @@ -663,5 +1262,8 @@ int riscv_iommu_init(struct riscv_iommu_device *io=
mmu)
> >         return 0;
> >   fail:
> >         riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> > +       riscv_iommu_queue_free(iommu, &iommu->priq);
> > +       riscv_iommu_queue_free(iommu, &iommu->fltq);
> > +       riscv_iommu_queue_free(iommu, &iommu->cmdq);
> >         return ret;
> >  }
> > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> > index 7dc9baa59a50..04148a2a8ffd 100644
> > --- a/drivers/iommu/riscv/iommu.h
> > +++ b/drivers/iommu/riscv/iommu.h
> > @@ -28,6 +28,24 @@
> >  #define IOMMU_PAGE_SIZE_1G     BIT_ULL(30)
> >  #define IOMMU_PAGE_SIZE_512G   BIT_ULL(39)
> >
> > +struct riscv_iommu_queue {
> > +       dma_addr_t base_dma;    /* ring buffer bus address */
> > +       void *base;             /* ring buffer pointer */
> > +       size_t len;             /* single item length */
> > +       u32 cnt;                /* items count */
> > +       u32 lui;                /* last used index, consumer/producer s=
hare */
> > +       unsigned qbr;           /* queue base register offset */
> > +       unsigned qcr;           /* queue control and status register of=
fset */
> > +       int irq;                /* registered interrupt number */
> > +       bool in_iomem;          /* indicates queue data are in I/O memo=
ry  */
> > +};
> > +
> > +enum riscv_queue_ids {
> > +       RISCV_IOMMU_COMMAND_QUEUE       =3D 0,
> > +       RISCV_IOMMU_FAULT_QUEUE         =3D 1,
> > +       RISCV_IOMMU_PAGE_REQUEST_QUEUE  =3D 2
> > +};
> > +
> >  struct riscv_iommu_device {
> >         struct iommu_device iommu;      /* iommu core interface */
> >         struct device *dev;             /* iommu hardware */
> > @@ -42,6 +60,11 @@ struct riscv_iommu_device {
> >         int irq_pm;
> >         int irq_priq;
> >
> > +       /* Queue lengths */
> > +       int cmdq_len;
> > +       int fltq_len;
> > +       int priq_len;
> > +
> >         /* supported and enabled hardware capabilities */
> >         u64 cap;
> >
> > @@ -53,6 +76,11 @@ struct riscv_iommu_device {
> >         unsigned ddt_mode;
> >         bool ddtp_in_iomem;
> >
> > +       /* hardware queues */
> > +       struct riscv_iommu_queue cmdq;
> > +       struct riscv_iommu_queue fltq;
> > +       struct riscv_iommu_queue priq;
> > +
> >         /* Connected end-points */
> >         struct rb_root eps;
> >         struct mutex eps_mutex;
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

best,
- Tomasz
