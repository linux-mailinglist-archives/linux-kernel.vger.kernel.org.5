Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE0767F5D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjG2M6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjG2M6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:58:41 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FB530D4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 05:58:37 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-77a62a84855so121461939f.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 05:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690635517; x=1691240317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywtU7NmWzqoNsRCStJu7rd0SBy/o1tSie2dGlFUdpiI=;
        b=I+a0Qz9rp8S5N3BqSMk+KQPSHfyBXroeEaI9hxlrXwEj1zsMwY6QsJjWERPRsAGl7K
         8W8eZYGNYMoa9XKbA+RC1owtX93fePVCpfqOl87Tdps0VdLwxNMr44XI3dnk3r38XrsS
         Po8ua4xrJfopQHsz/JgjBZWvH1yo20ZlZy3ghBx2fRyJ+lxrDcT9dzqWL5BJSvpeXYSX
         ZoCUBbrajec48w0yt5e7eCkcw4L4aBW16mXnXcVBbOQuclimOEybfXcAFgnZlxTyoCM6
         A22DNl5oQtvVKrWza9hSTpdBWaUBW1qFFkTZLbZ686bHhHz7wy5lGYvPKp0lip2HXkzY
         OPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690635517; x=1691240317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywtU7NmWzqoNsRCStJu7rd0SBy/o1tSie2dGlFUdpiI=;
        b=bPFsEAUpIFCs7EGnQzj5P/QmAdhTM9Kh1afS74UPE9B7Gdn/fORrkCQWQ31meefskK
         6E8DgEdTCOD6Z7j2j4zB0BF+l367i/N1SdhmAt3tl96JA/5MqqduYy0YtlLRmUHKQCBN
         /WJQy67HdbpHNRFdl1k8em71ToGZnCfpLY75jgkRmtxKVXpVZaTdtV1ajQIc7F/mSwmz
         CgnWxkCAZULo05xXfT5nG1O0sGbiFooGRbRdgNW3eBcTA9GDrthq4zwkyTQjVYsuDmok
         3IL43/MDfQWlsupOBXDu/STvL0/+HQGNo/KcbL4AUC2pghx4hgc8DNhjwZ15b5qJvwbu
         27eA==
X-Gm-Message-State: ABy/qLYgX1bSWEpf3kLuth9uo/DN8ZQbrsUB54y5LR43dRx/7G+CyOQY
        O6DaXfyzaglOaYjYjRWGlpENgvpLB86E7yVDvcatrA==
X-Google-Smtp-Source: APBJJlFARoxgv8knYdIM3mE/UpTojIrXQ2oXtGyDwWrtsYfdb5f2BUoydHXmq6KTVuTaTyyzOThVRrnT1L79T1OX+Ug=
X-Received: by 2002:a5e:9810:0:b0:783:49ec:8115 with SMTP id
 s16-20020a5e9810000000b0078349ec8115mr2349087ioj.5.1690635516801; Sat, 29 Jul
 2023 05:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
In-Reply-To: <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Sat, 29 Jul 2023 20:58:25 +0800
Message-ID: <CANXhq0pm+1yXuvUGudwNtvNHWV3FytH4VfCnq7_Ws=t-MZP_kQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
To:     Tomasz Jeznach <tjeznach@rivosinc.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 3:34=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> Enables message or wire signal interrupts for PCIe and platforms devices.
>
> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/riscv/iommu-pci.c      |  72 ++++
>  drivers/iommu/riscv/iommu-platform.c |  66 +++
>  drivers/iommu/riscv/iommu.c          | 604 ++++++++++++++++++++++++++-
>  drivers/iommu/riscv/iommu.h          |  28 ++
>  4 files changed, 769 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-=
pci.c
> index c91f963d7a29..9ea0647f7b92 100644
> --- a/drivers/iommu/riscv/iommu-pci.c
> +++ b/drivers/iommu/riscv/iommu-pci.c
> @@ -34,6 +34,7 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev, =
const struct pci_device_i
>  {
>         struct device *dev =3D &pdev->dev;
>         struct riscv_iommu_device *iommu;
> +       u64 icvec;
>         int ret;
>
>         ret =3D pci_enable_device_mem(pdev);
> @@ -67,14 +68,84 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev=
, const struct pci_device_i
>         iommu->dev =3D dev;
>         dev_set_drvdata(dev, iommu);
>
> +       /* Check device reported capabilities. */
> +       iommu->cap =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAP);
> +
> +       /* The PCI driver only uses MSIs, make sure the IOMMU supports th=
is */
> +       switch (FIELD_GET(RISCV_IOMMU_CAP_IGS, iommu->cap)) {
> +       case RISCV_IOMMU_CAP_IGS_MSI:
> +       case RISCV_IOMMU_CAP_IGS_BOTH:
> +               break;
> +       default:
> +               dev_err(dev, "unable to use message-signaled interrupts\n=
");
> +               ret =3D -ENODEV;
> +               goto fail;
> +       }
> +
>         dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>         pci_set_master(pdev);
>
> +       /* Allocate and assign IRQ vectors for the various events */
> +       ret =3D pci_alloc_irq_vectors(pdev, 1, RISCV_IOMMU_INTR_COUNT, PC=
I_IRQ_MSIX);
> +       if (ret < 0) {
> +               dev_err(dev, "unable to allocate irq vectors\n");
> +               goto fail;
> +       }
> +
> +       ret =3D -ENODEV;
> +
> +       iommu->irq_cmdq =3D msi_get_virq(dev, RISCV_IOMMU_INTR_CQ);
> +       if (!iommu->irq_cmdq) {
> +               dev_warn(dev, "no MSI vector %d for the command queue\n",
> +                        RISCV_IOMMU_INTR_CQ);
> +               goto fail;
> +       }
> +
> +       iommu->irq_fltq =3D msi_get_virq(dev, RISCV_IOMMU_INTR_FQ);
> +       if (!iommu->irq_fltq) {
> +               dev_warn(dev, "no MSI vector %d for the fault/event queue=
\n",
> +                        RISCV_IOMMU_INTR_FQ);
> +               goto fail;
> +       }
> +
> +       if (iommu->cap & RISCV_IOMMU_CAP_HPM) {
> +               iommu->irq_pm =3D msi_get_virq(dev, RISCV_IOMMU_INTR_PM);
> +               if (!iommu->irq_pm) {
> +                       dev_warn(dev,
> +                                "no MSI vector %d for performance monito=
ring\n",
> +                                RISCV_IOMMU_INTR_PM);
> +                       goto fail;
> +               }
> +       }
> +
> +       if (iommu->cap & RISCV_IOMMU_CAP_ATS) {
> +               iommu->irq_priq =3D msi_get_virq(dev, RISCV_IOMMU_INTR_PQ=
);
> +               if (!iommu->irq_priq) {
> +                       dev_warn(dev,
> +                                "no MSI vector %d for page-request queue=
\n",
> +                                RISCV_IOMMU_INTR_PQ);
> +                       goto fail;
> +               }
> +       }
> +
> +       /* Set simple 1:1 mapping for MSI vectors */
> +       icvec =3D FIELD_PREP(RISCV_IOMMU_IVEC_CIV, RISCV_IOMMU_INTR_CQ) |
> +           FIELD_PREP(RISCV_IOMMU_IVEC_FIV, RISCV_IOMMU_INTR_FQ);
> +
> +       if (iommu->cap & RISCV_IOMMU_CAP_HPM)
> +               icvec |=3D FIELD_PREP(RISCV_IOMMU_IVEC_PMIV, RISCV_IOMMU_=
INTR_PM);
> +
> +       if (iommu->cap & RISCV_IOMMU_CAP_ATS)
> +               icvec |=3D FIELD_PREP(RISCV_IOMMU_IVEC_PIV, RISCV_IOMMU_I=
NTR_PQ);
> +
> +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IVEC, icvec);
> +
>         ret =3D riscv_iommu_init(iommu);
>         if (!ret)
>                 return ret;
>
>   fail:
> +       pci_free_irq_vectors(pdev);
>         pci_clear_master(pdev);
>         pci_release_regions(pdev);
>         pci_disable_device(pdev);
> @@ -85,6 +156,7 @@ static int riscv_iommu_pci_probe(struct pci_dev *pdev,=
 const struct pci_device_i
>  static void riscv_iommu_pci_remove(struct pci_dev *pdev)
>  {
>         riscv_iommu_remove(dev_get_drvdata(&pdev->dev));
> +       pci_free_irq_vectors(pdev);
>         pci_clear_master(pdev);
>         pci_release_regions(pdev);
>         pci_disable_device(pdev);
> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/i=
ommu-platform.c
> index e4e8ca6711e7..35935d3c7ef4 100644
> --- a/drivers/iommu/riscv/iommu-platform.c
> +++ b/drivers/iommu/riscv/iommu-platform.c
> @@ -20,6 +20,8 @@ static int riscv_iommu_platform_probe(struct platform_d=
evice *pdev)
>         struct device *dev =3D &pdev->dev;
>         struct riscv_iommu_device *iommu =3D NULL;
>         struct resource *res =3D NULL;
> +       u32 fctl =3D 0;
> +       int irq =3D 0;
>         int ret =3D 0;
>
>         iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> @@ -53,6 +55,70 @@ static int riscv_iommu_platform_probe(struct platform_=
device *pdev)
>                 goto fail;
>         }
>
> +       iommu->cap =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAP);
> +
> +       /* For now we only support WSIs until we have AIA support */

I'm not completely understand AIA support here, because I saw the pci
case uses the MSI, and kernel seems to have the AIA implementation.
Could you please elaborate it?

> +       ret =3D FIELD_GET(RISCV_IOMMU_CAP_IGS, iommu->cap);
> +       if (ret =3D=3D RISCV_IOMMU_CAP_IGS_MSI) {
> +               dev_err(dev, "IOMMU only supports MSIs\n");
> +               goto fail;
> +       }
> +
> +       /* Parse IRQ assignment */
> +       irq =3D platform_get_irq_byname_optional(pdev, "cmdq");
> +       if (irq > 0)
> +               iommu->irq_cmdq =3D irq;
> +       else {
> +               dev_err(dev, "no IRQ provided for the command queue\n");
> +               goto fail;
> +       }
> +
> +       irq =3D platform_get_irq_byname_optional(pdev, "fltq");
> +       if (irq > 0)
> +               iommu->irq_fltq =3D irq;
> +       else {
> +               dev_err(dev, "no IRQ provided for the fault/event queue\n=
");
> +               goto fail;
> +       }
> +
> +       if (iommu->cap & RISCV_IOMMU_CAP_HPM) {
> +               irq =3D platform_get_irq_byname_optional(pdev, "pm");
> +               if (irq > 0)
> +                       iommu->irq_pm =3D irq;
> +               else {
> +                       dev_err(dev, "no IRQ provided for performance mon=
itoring\n");
> +                       goto fail;
> +               }
> +       }
> +
> +       if (iommu->cap & RISCV_IOMMU_CAP_ATS) {
> +               irq =3D platform_get_irq_byname_optional(pdev, "priq");
> +               if (irq > 0)
> +                       iommu->irq_priq =3D irq;
> +               else {
> +                       dev_err(dev, "no IRQ provided for the page-reques=
t queue\n");
> +                       goto fail;
> +               }
> +       }

Should we define the "interrupt-names" in dt-bindings?

> +
> +       /* Make sure fctl.WSI is set */
> +       fctl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> +       fctl |=3D RISCV_IOMMU_FCTL_WSI;
> +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, fctl);
> +
> +       /* Parse Queue lengts */
> +       ret =3D of_property_read_u32(pdev->dev.of_node, "cmdq_len", &iomm=
u->cmdq_len);
> +       if (!ret)
> +               dev_info(dev, "command queue length set to %i\n", iommu->=
cmdq_len);
> +
> +       ret =3D of_property_read_u32(pdev->dev.of_node, "fltq_len", &iomm=
u->fltq_len);
> +       if (!ret)
> +               dev_info(dev, "fault/event queue length set to %i\n", iom=
mu->fltq_len);
> +
> +       ret =3D of_property_read_u32(pdev->dev.of_node, "priq_len", &iomm=
u->priq_len);
> +       if (!ret)
> +               dev_info(dev, "page request queue length set to %i\n", io=
mmu->priq_len);
> +
>         dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>
>         return riscv_iommu_init(iommu);
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 31dc3c458e13..5c4cf9875302 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -45,6 +45,18 @@ static int ddt_mode =3D RISCV_IOMMU_DDTP_MODE_BARE;
>  module_param(ddt_mode, int, 0644);
>  MODULE_PARM_DESC(ddt_mode, "Device Directory Table mode.");
>
> +static int cmdq_length =3D 1024;
> +module_param(cmdq_length, int, 0644);
> +MODULE_PARM_DESC(cmdq_length, "Command queue length.");
> +
> +static int fltq_length =3D 1024;
> +module_param(fltq_length, int, 0644);
> +MODULE_PARM_DESC(fltq_length, "Fault queue length.");
> +
> +static int priq_length =3D 1024;
> +module_param(priq_length, int, 0644);
> +MODULE_PARM_DESC(priq_length, "Page request interface queue length.");
> +
>  /* IOMMU PSCID allocation namespace. */
>  #define RISCV_IOMMU_MAX_PSCID  (1U << 20)
>  static DEFINE_IDA(riscv_iommu_pscids);
> @@ -65,6 +77,497 @@ static DEFINE_IDA(riscv_iommu_pscids);
>  static const struct iommu_domain_ops riscv_iommu_domain_ops;
>  static const struct iommu_ops riscv_iommu_ops;
>
> +/*
> + * Common queue management routines
> + */
> +
> +/* Note: offsets are the same for all queues */
> +#define Q_HEAD(q) ((q)->qbr + (RISCV_IOMMU_REG_CQH - RISCV_IOMMU_REG_CQB=
))
> +#define Q_TAIL(q) ((q)->qbr + (RISCV_IOMMU_REG_CQT - RISCV_IOMMU_REG_CQB=
))
> +
> +static unsigned riscv_iommu_queue_consume(struct riscv_iommu_device *iom=
mu,
> +                                         struct riscv_iommu_queue *q, un=
signed *ready)
> +{
> +       u32 tail =3D riscv_iommu_readl(iommu, Q_TAIL(q));
> +       *ready =3D q->lui;
> +
> +       BUG_ON(q->cnt <=3D tail);
> +       if (q->lui <=3D tail)
> +               return tail - q->lui;
> +       return q->cnt - q->lui;
> +}
> +
> +static void riscv_iommu_queue_release(struct riscv_iommu_device *iommu,
> +                                     struct riscv_iommu_queue *q, unsign=
ed count)
> +{
> +       q->lui =3D (q->lui + count) & (q->cnt - 1);
> +       riscv_iommu_writel(iommu, Q_HEAD(q), q->lui);
> +}
> +
> +static u32 riscv_iommu_queue_ctrl(struct riscv_iommu_device *iommu,
> +                                 struct riscv_iommu_queue *q, u32 val)
> +{
> +       cycles_t end_cycles =3D RISCV_IOMMU_TIMEOUT + get_cycles();
> +
> +       riscv_iommu_writel(iommu, q->qcr, val);
> +       do {
> +               val =3D riscv_iommu_readl(iommu, q->qcr);
> +               if (!(val & RISCV_IOMMU_QUEUE_BUSY))
> +                       break;
> +               cpu_relax();
> +       } while (get_cycles() < end_cycles);
> +
> +       return val;
> +}
> +
> +static void riscv_iommu_queue_free(struct riscv_iommu_device *iommu,
> +                                  struct riscv_iommu_queue *q)
> +{
> +       size_t size =3D q->len * q->cnt;
> +
> +       riscv_iommu_queue_ctrl(iommu, q, 0);
> +
> +       if (q->base) {
> +               if (q->in_iomem)
> +                       iounmap(q->base);
> +               else
> +                       dmam_free_coherent(iommu->dev, size, q->base, q->=
base_dma);
> +       }
> +       if (q->irq)
> +               free_irq(q->irq, q);
> +}
> +
> +static irqreturn_t riscv_iommu_cmdq_irq_check(int irq, void *data);
> +static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data);
> +static irqreturn_t riscv_iommu_fltq_irq_check(int irq, void *data);
> +static irqreturn_t riscv_iommu_fltq_process(int irq, void *data);
> +static irqreturn_t riscv_iommu_priq_irq_check(int irq, void *data);
> +static irqreturn_t riscv_iommu_priq_process(int irq, void *data);
> +
> +static int riscv_iommu_queue_init(struct riscv_iommu_device *iommu, int =
queue_id)
> +{
> +       struct device *dev =3D iommu->dev;
> +       struct riscv_iommu_queue *q =3D NULL;
> +       size_t queue_size =3D 0;
> +       irq_handler_t irq_check;
> +       irq_handler_t irq_process;
> +       const char *name;
> +       int count =3D 0;
> +       int irq =3D 0;
> +       unsigned order =3D 0;
> +       u64 qbr_val =3D 0;
> +       u64 qbr_readback =3D 0;
> +       u64 qbr_paddr =3D 0;
> +       int ret =3D 0;
> +
> +       switch (queue_id) {
> +       case RISCV_IOMMU_COMMAND_QUEUE:
> +               q =3D &iommu->cmdq;
> +               q->len =3D sizeof(struct riscv_iommu_command);
> +               count =3D iommu->cmdq_len;
> +               irq =3D iommu->irq_cmdq;
> +               irq_check =3D riscv_iommu_cmdq_irq_check;
> +               irq_process =3D riscv_iommu_cmdq_process;
> +               q->qbr =3D RISCV_IOMMU_REG_CQB;
> +               q->qcr =3D RISCV_IOMMU_REG_CQCSR;
> +               name =3D "cmdq";
> +               break;
> +       case RISCV_IOMMU_FAULT_QUEUE:
> +               q =3D &iommu->fltq;
> +               q->len =3D sizeof(struct riscv_iommu_fq_record);
> +               count =3D iommu->fltq_len;
> +               irq =3D iommu->irq_fltq;
> +               irq_check =3D riscv_iommu_fltq_irq_check;
> +               irq_process =3D riscv_iommu_fltq_process;
> +               q->qbr =3D RISCV_IOMMU_REG_FQB;
> +               q->qcr =3D RISCV_IOMMU_REG_FQCSR;
> +               name =3D "fltq";
> +               break;
> +       case RISCV_IOMMU_PAGE_REQUEST_QUEUE:
> +               q =3D &iommu->priq;
> +               q->len =3D sizeof(struct riscv_iommu_pq_record);
> +               count =3D iommu->priq_len;
> +               irq =3D iommu->irq_priq;
> +               irq_check =3D riscv_iommu_priq_irq_check;
> +               irq_process =3D riscv_iommu_priq_process;
> +               q->qbr =3D RISCV_IOMMU_REG_PQB;
> +               q->qcr =3D RISCV_IOMMU_REG_PQCSR;
> +               name =3D "priq";
> +               break;
> +       default:
> +               dev_err(dev, "invalid queue interrupt index in queue_init=
!\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Polling not implemented */
> +       if (!irq)
> +               return -ENODEV;
> +
> +       /* Allocate queue in memory and set the base register */
> +       order =3D ilog2(count);
> +       do {
> +               queue_size =3D q->len * (1ULL << order);
> +               q->base =3D dmam_alloc_coherent(dev, queue_size, &q->base=
_dma, GFP_KERNEL);
> +               if (q->base || queue_size < PAGE_SIZE)
> +                       break;
> +
> +               order--;
> +       } while (1);
> +
> +       if (!q->base) {
> +               dev_err(dev, "failed to allocate %s queue (cnt: %u)\n", n=
ame, count);
> +               return -ENOMEM;
> +       }
> +
> +       q->cnt =3D 1ULL << order;
> +
> +       qbr_val =3D phys_to_ppn(q->base_dma) |
> +           FIELD_PREP(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, order - 1);
> +
> +       riscv_iommu_writeq(iommu, q->qbr, qbr_val);
> +
> +       /*
> +        * Queue base registers are WARL, so it's possible that whatever =
we wrote
> +        * there was illegal/not supported by the hw in which case we nee=
d to make
> +        * sure we set a supported PPN and/or queue size.
> +        */
> +       qbr_readback =3D riscv_iommu_readq(iommu, q->qbr);
> +       if (qbr_readback =3D=3D qbr_val)
> +               goto irq;
> +
> +       dmam_free_coherent(dev, queue_size, q->base, q->base_dma);
> +
> +       /* Get supported queue size */
> +       order =3D FIELD_GET(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, qbr_readback) =
+ 1;
> +       q->cnt =3D 1ULL << order;
> +       queue_size =3D q->len * q->cnt;
> +
> +       /*
> +        * In case we also failed to set PPN, it means the field is hardc=
oded and the
> +        * queue resides in I/O memory instead, so get its physical addre=
ss and
> +        * ioremap it.
> +        */
> +       qbr_paddr =3D ppn_to_phys(qbr_readback);
> +       if (qbr_paddr !=3D q->base_dma) {
> +               dev_info(dev,
> +                        "hardcoded ppn in %s base register, using io mem=
ory for the queue\n",
> +                        name);
> +               dev_info(dev, "queue length for %s set to %i\n", name, q-=
>cnt);
> +               q->in_iomem =3D true;
> +               q->base =3D ioremap(qbr_paddr, queue_size);
> +               if (!q->base) {
> +                       dev_err(dev, "failed to map %s queue (cnt: %u)\n"=
, name, q->cnt);
> +                       return -ENOMEM;
> +               }
> +               q->base_dma =3D qbr_paddr;
> +       } else {
> +               /*
> +                * We only failed to set the queue size, re-try to alloca=
te memory with
> +                * the queue size supported by the hw.
> +                */
> +               dev_info(dev, "hardcoded queue size in %s base register\n=
", name);
> +               dev_info(dev, "retrying with queue length: %i\n", q->cnt)=
;
> +               q->base =3D dmam_alloc_coherent(dev, queue_size, &q->base=
_dma, GFP_KERNEL);
> +               if (!q->base) {
> +                       dev_err(dev, "failed to allocate %s queue (cnt: %=
u)\n",
> +                               name, q->cnt);
> +                       return -ENOMEM;
> +               }
> +       }
> +
> +       qbr_val =3D phys_to_ppn(q->base_dma) |
> +           FIELD_PREP(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, order - 1);
> +       riscv_iommu_writeq(iommu, q->qbr, qbr_val);
> +
> +       /* Final check to make sure hw accepted our write */
> +       qbr_readback =3D riscv_iommu_readq(iommu, q->qbr);
> +       if (qbr_readback !=3D qbr_val) {
> +               dev_err(dev, "failed to set base register for %s\n", name=
);
> +               goto fail;
> +       }
> +
> + irq:
> +       if (request_threaded_irq(irq, irq_check, irq_process, IRQF_ONESHO=
T | IRQF_SHARED,
> +                                dev_name(dev), q)) {
> +               dev_err(dev, "fail to request irq %d for %s\n", irq, name=
);
> +               goto fail;
> +       }
> +
> +       q->irq =3D irq;
> +
> +       /* Note: All RIO_xQ_EN/IE fields are in the same offsets */
> +       ret =3D
> +           riscv_iommu_queue_ctrl(iommu, q,
> +                                  RISCV_IOMMU_QUEUE_ENABLE |
> +                                  RISCV_IOMMU_QUEUE_INTR_ENABLE);
> +       if (ret & RISCV_IOMMU_QUEUE_BUSY) {
> +               dev_err(dev, "%s init timeout\n", name);
> +               ret =3D -EBUSY;
> +               goto fail;
> +       }
> +
> +       return 0;
> +
> + fail:
> +       riscv_iommu_queue_free(iommu, q);
> +       return 0;
> +}
> +
> +/*
> + * I/O MMU Command queue chapter 3.1
> + */
> +
> +static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command =
*cmd)
> +{
> +       cmd->dword0 =3D
> +           FIELD_PREP(RISCV_IOMMU_CMD_OPCODE,
> +                      RISCV_IOMMU_CMD_IOTINVAL_OPCODE) | FIELD_PREP(RISC=
V_IOMMU_CMD_FUNC,
> +                                                                    RISC=
V_IOMMU_CMD_IOTINVAL_FUNC_VMA);
> +       cmd->dword1 =3D 0;
> +}
> +
> +static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_com=
mand *cmd,
> +                                                 u64 addr)
> +{
> +       cmd->dword0 |=3D RISCV_IOMMU_CMD_IOTINVAL_AV;
> +       cmd->dword1 =3D addr;
> +}
> +
> +static inline void riscv_iommu_cmd_inval_set_pscid(struct riscv_iommu_co=
mmand *cmd,
> +                                                  unsigned pscid)
> +{
> +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_PSCID, pscid=
) |
> +           RISCV_IOMMU_CMD_IOTINVAL_PSCV;
> +}
> +
> +static inline void riscv_iommu_cmd_inval_set_gscid(struct riscv_iommu_co=
mmand *cmd,
> +                                                  unsigned gscid)
> +{
> +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_GSCID, gscid=
) |
> +           RISCV_IOMMU_CMD_IOTINVAL_GV;
> +}
> +
> +static inline void riscv_iommu_cmd_iofence(struct riscv_iommu_command *c=
md)
> +{
> +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CM=
D_IOFENCE_OPCODE) |
> +           FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IOFENCE_FUNC=
_C);
> +       cmd->dword1 =3D 0;
> +}
> +
> +static inline void riscv_iommu_cmd_iofence_set_av(struct riscv_iommu_com=
mand *cmd,
> +                                                 u64 addr, u32 data)
> +{
> +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CM=
D_IOFENCE_OPCODE) |
> +           FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IOFENCE_FUNC=
_C) |
> +           FIELD_PREP(RISCV_IOMMU_CMD_IOFENCE_DATA, data) | RISCV_IOMMU_=
CMD_IOFENCE_AV;
> +       cmd->dword1 =3D (addr >> 2);
> +}
> +
> +static inline void riscv_iommu_cmd_iodir_inval_ddt(struct riscv_iommu_co=
mmand *cmd)
> +{
> +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CM=
D_IODIR_OPCODE) |
> +           FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IODIR_FUNC_I=
NVAL_DDT);
> +       cmd->dword1 =3D 0;
> +}
> +
> +static inline void riscv_iommu_cmd_iodir_inval_pdt(struct riscv_iommu_co=
mmand *cmd)
> +{
> +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CM=
D_IODIR_OPCODE) |
> +           FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IODIR_FUNC_I=
NVAL_PDT);
> +       cmd->dword1 =3D 0;
> +}
> +
> +static inline void riscv_iommu_cmd_iodir_set_did(struct riscv_iommu_comm=
and *cmd,
> +                                                unsigned devid)
> +{
> +       cmd->dword0 |=3D
> +           FIELD_PREP(RISCV_IOMMU_CMD_IODIR_DID, devid) | RISCV_IOMMU_CM=
D_IODIR_DV;
> +}
> +
> +/* TODO: Convert into lock-less MPSC implementation. */
> +static bool riscv_iommu_post_sync(struct riscv_iommu_device *iommu,
> +                                 struct riscv_iommu_command *cmd, bool s=
ync)
> +{
> +       u32 head, tail, next, last;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&iommu->cq_lock, flags);
> +       head =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_CQH) & (iommu->=
cmdq.cnt - 1);
> +       tail =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_CQT) & (iommu->=
cmdq.cnt - 1);
> +       last =3D iommu->cmdq.lui;
> +       if (tail !=3D last) {
> +               spin_unlock_irqrestore(&iommu->cq_lock, flags);
> +               /*
> +                * FIXME: This is a workaround for dropped MMIO writes/re=
ads on QEMU platform.
> +                *        While debugging of the problem is still ongoing=
, this provides
> +                *        a simple impolementation of try-again policy.
> +                *        Will be changed to lock-less algorithm in the f=
eature.
> +                */
> +               dev_dbg(iommu->dev, "IOMMU CQT: %x !=3D %x (1st)\n", last=
, tail);
> +               spin_lock_irqsave(&iommu->cq_lock, flags);
> +               tail =3D
> +                   riscv_iommu_readl(iommu, RISCV_IOMMU_REG_CQT) & (iomm=
u->cmdq.cnt - 1);
> +               last =3D iommu->cmdq.lui;
> +               if (tail !=3D last) {
> +                       spin_unlock_irqrestore(&iommu->cq_lock, flags);
> +                       dev_dbg(iommu->dev, "IOMMU CQT: %x !=3D %x (2nd)\=
n", last, tail);
> +                       spin_lock_irqsave(&iommu->cq_lock, flags);
> +               }
> +       }
> +
> +       next =3D (last + 1) & (iommu->cmdq.cnt - 1);
> +       if (next !=3D head) {
> +               struct riscv_iommu_command *ptr =3D iommu->cmdq.base;
> +               ptr[last] =3D *cmd;
> +               wmb();
> +               riscv_iommu_writel(iommu, RISCV_IOMMU_REG_CQT, next);
> +               iommu->cmdq.lui =3D next;
> +       }
> +
> +       spin_unlock_irqrestore(&iommu->cq_lock, flags);
> +
> +       if (sync && head !=3D next) {
> +               cycles_t start_time =3D get_cycles();
> +               while (1) {
> +                       last =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG=
_CQH) &
> +                           (iommu->cmdq.cnt - 1);
> +                       if (head < next && last >=3D next)
> +                               break;
> +                       if (head > next && last < head && last >=3D next)
> +                               break;
> +                       if (RISCV_IOMMU_TIMEOUT < (get_cycles() - start_t=
ime)) {

This condition will be imprecise, because here is not in irq disabled
context, it will be scheduled out or preempted. When we come back
here, it might be over 1 second, but the IOFENCE is actually
completed.

> +                               dev_err(iommu->dev, "IOFENCE TIMEOUT\n");
> +                               return false;
> +                       }
> +                       cpu_relax();
> +               }
> +       }
> +
> +       return next !=3D head;
> +}
> +
> +static bool riscv_iommu_post(struct riscv_iommu_device *iommu,
> +                            struct riscv_iommu_command *cmd)
> +{
> +       return riscv_iommu_post_sync(iommu, cmd, false);
> +}
> +
> +static bool riscv_iommu_iofence_sync(struct riscv_iommu_device *iommu)
> +{
> +       struct riscv_iommu_command cmd;
> +       riscv_iommu_cmd_iofence(&cmd);
> +       return riscv_iommu_post_sync(iommu, &cmd, true);
> +}
> +
> +/* Command queue primary interrupt handler */
> +static irqreturn_t riscv_iommu_cmdq_irq_check(int irq, void *data)
> +{
> +       struct riscv_iommu_queue *q =3D (struct riscv_iommu_queue *)data;
> +       struct riscv_iommu_device *iommu =3D
> +           container_of(q, struct riscv_iommu_device, cmdq);
> +       u32 ipsr =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IPSR);
> +       if (ipsr & RISCV_IOMMU_IPSR_CIP)
> +               return IRQ_WAKE_THREAD;
> +       return IRQ_NONE;
> +}
> +
> +/* Command queue interrupt hanlder thread function */
> +static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
> +{
> +       struct riscv_iommu_queue *q =3D (struct riscv_iommu_queue *)data;
> +       struct riscv_iommu_device *iommu;
> +       unsigned ctrl;
> +
> +       iommu =3D container_of(q, struct riscv_iommu_device, cmdq);
> +
> +       /* Error reporting, clear error reports if any. */
> +       ctrl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_CQCSR);
> +       if (ctrl & (RISCV_IOMMU_CQCSR_CQMF |
> +                   RISCV_IOMMU_CQCSR_CMD_TO | RISCV_IOMMU_CQCSR_CMD_ILL)=
) {
> +               riscv_iommu_queue_ctrl(iommu, &iommu->cmdq, ctrl);
> +               dev_warn_ratelimited(iommu->dev,
> +                                    "Command queue error: fault: %d tout=
: %d err: %d\n",
> +                                    !!(ctrl & RISCV_IOMMU_CQCSR_CQMF),
> +                                    !!(ctrl & RISCV_IOMMU_CQCSR_CMD_TO),
> +                                    !!(ctrl & RISCV_IOMMU_CQCSR_CMD_ILL)=
);

We need to handle the error by either adjusting the tail to remove the
failed command or fixing the failed command itself. Otherwise, the
failed command will keep in the queue and IOMMU will try to execute
it. I guess the first option might be easier to implement.

> +       }
> +
> +       /* Clear fault interrupt pending. */
> +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_=
CIP);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/*
> + * Fault/event queue, chapter 3.2
> + */
> +
> +static void riscv_iommu_fault_report(struct riscv_iommu_device *iommu,
> +                                    struct riscv_iommu_fq_record *event)
> +{
> +       unsigned err, devid;
> +
> +       err =3D FIELD_GET(RISCV_IOMMU_FQ_HDR_CAUSE, event->hdr);
> +       devid =3D FIELD_GET(RISCV_IOMMU_FQ_HDR_DID, event->hdr);
> +
> +       dev_warn_ratelimited(iommu->dev,
> +                            "Fault %d devid: %d" " iotval: %llx iotval2:=
 %llx\n", err,
> +                            devid, event->iotval, event->iotval2);
> +}
> +
> +/* Fault/event queue primary interrupt handler */
> +static irqreturn_t riscv_iommu_fltq_irq_check(int irq, void *data)
> +{
> +       struct riscv_iommu_queue *q =3D (struct riscv_iommu_queue *)data;
> +       struct riscv_iommu_device *iommu =3D
> +           container_of(q, struct riscv_iommu_device, fltq);
> +       u32 ipsr =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IPSR);
> +       if (ipsr & RISCV_IOMMU_IPSR_FIP)
> +               return IRQ_WAKE_THREAD;
> +       return IRQ_NONE;
> +}
> +
> +/* Fault queue interrupt hanlder thread function */
> +static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
> +{
> +       struct riscv_iommu_queue *q =3D (struct riscv_iommu_queue *)data;
> +       struct riscv_iommu_device *iommu;
> +       struct riscv_iommu_fq_record *events;
> +       unsigned cnt, len, idx, ctrl;
> +
> +       iommu =3D container_of(q, struct riscv_iommu_device, fltq);
> +       events =3D (struct riscv_iommu_fq_record *)q->base;
> +
> +       /* Error reporting, clear error reports if any. */
> +       ctrl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FQCSR);
> +       if (ctrl & (RISCV_IOMMU_FQCSR_FQMF | RISCV_IOMMU_FQCSR_FQOF)) {
> +               riscv_iommu_queue_ctrl(iommu, &iommu->fltq, ctrl);
> +               dev_warn_ratelimited(iommu->dev,
> +                                    "Fault queue error: fault: %d full: =
%d\n",
> +                                    !!(ctrl & RISCV_IOMMU_FQCSR_FQMF),
> +                                    !!(ctrl & RISCV_IOMMU_FQCSR_FQOF));
> +       }
> +
> +       /* Clear fault interrupt pending. */
> +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_=
FIP);
> +
> +       /* Report fault events. */
> +       do {
> +               cnt =3D riscv_iommu_queue_consume(iommu, q, &idx);
> +               if (!cnt)
> +                       break;
> +               for (len =3D 0; len < cnt; idx++, len++)
> +                       riscv_iommu_fault_report(iommu, &events[idx]);
> +               riscv_iommu_queue_release(iommu, q, cnt);
> +       } while (1);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/*
> + * Page request queue, chapter 3.3
> + */
> +
>  /*
>   * Register device for IOMMU tracking.
>   */
> @@ -97,6 +600,54 @@ static void riscv_iommu_add_device(struct riscv_iommu=
_device *iommu, struct devi
>         mutex_unlock(&iommu->eps_mutex);
>  }
>
> +/* Page request interface queue primary interrupt handler */
> +static irqreturn_t riscv_iommu_priq_irq_check(int irq, void *data)
> +{
> +       struct riscv_iommu_queue *q =3D (struct riscv_iommu_queue *)data;
> +       struct riscv_iommu_device *iommu =3D
> +           container_of(q, struct riscv_iommu_device, priq);
> +       u32 ipsr =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IPSR);
> +       if (ipsr & RISCV_IOMMU_IPSR_PIP)
> +               return IRQ_WAKE_THREAD;
> +       return IRQ_NONE;
> +}
> +
> +/* Page request interface queue interrupt hanlder thread function */
> +static irqreturn_t riscv_iommu_priq_process(int irq, void *data)
> +{
> +       struct riscv_iommu_queue *q =3D (struct riscv_iommu_queue *)data;
> +       struct riscv_iommu_device *iommu;
> +       struct riscv_iommu_pq_record *requests;
> +       unsigned cnt, idx, ctrl;
> +
> +       iommu =3D container_of(q, struct riscv_iommu_device, priq);
> +       requests =3D (struct riscv_iommu_pq_record *)q->base;
> +
> +       /* Error reporting, clear error reports if any. */
> +       ctrl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_PQCSR);
> +       if (ctrl & (RISCV_IOMMU_PQCSR_PQMF | RISCV_IOMMU_PQCSR_PQOF)) {
> +               riscv_iommu_queue_ctrl(iommu, &iommu->priq, ctrl);
> +               dev_warn_ratelimited(iommu->dev,
> +                                    "Page request queue error: fault: %d=
 full: %d\n",
> +                                    !!(ctrl & RISCV_IOMMU_PQCSR_PQMF),
> +                                    !!(ctrl & RISCV_IOMMU_PQCSR_PQOF));
> +       }
> +
> +       /* Clear page request interrupt pending. */
> +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_=
PIP);
> +
> +       /* Process page requests. */
> +       do {
> +               cnt =3D riscv_iommu_queue_consume(iommu, q, &idx);
> +               if (!cnt)
> +                       break;
> +               dev_warn(iommu->dev, "unexpected %u page requests\n", cnt=
);
> +               riscv_iommu_queue_release(iommu, q, cnt);
> +       } while (1);
> +
> +       return IRQ_HANDLED;
> +}
> +
>  /*
>   * Endpoint management
>   */
> @@ -350,7 +901,29 @@ static void riscv_iommu_flush_iotlb_range(struct iom=
mu_domain *iommu_domain,
>                                           unsigned long *start, unsigned =
long *end,
>                                           size_t *pgsize)
>  {
> -       /* Command interface not implemented */
> +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> +       struct riscv_iommu_command cmd;
> +       unsigned long iova;
> +
> +       if (domain->mode =3D=3D RISCV_IOMMU_DC_FSC_MODE_BARE)
> +               return;
> +
> +       /* Domain not attached to an IOMMU! */
> +       BUG_ON(!domain->iommu);
> +
> +       riscv_iommu_cmd_inval_vma(&cmd);
> +       riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> +
> +       if (start && end && pgsize) {
> +               /* Cover only the range that is needed */
> +               for (iova =3D *start; iova <=3D *end; iova +=3D *pgsize) =
{
> +                       riscv_iommu_cmd_inval_set_addr(&cmd, iova);
> +                       riscv_iommu_post(domain->iommu, &cmd);
> +               }
> +       } else {
> +               riscv_iommu_post(domain->iommu, &cmd);
> +       }
> +       riscv_iommu_iofence_sync(domain->iommu);
>  }
>
>  static void riscv_iommu_flush_iotlb_all(struct iommu_domain *iommu_domai=
n)
> @@ -610,6 +1183,9 @@ void riscv_iommu_remove(struct riscv_iommu_device *i=
ommu)
>         iommu_device_unregister(&iommu->iommu);
>         iommu_device_sysfs_remove(&iommu->iommu);
>         riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> +       riscv_iommu_queue_free(iommu, &iommu->cmdq);
> +       riscv_iommu_queue_free(iommu, &iommu->fltq);
> +       riscv_iommu_queue_free(iommu, &iommu->priq);
>  }
>
>  int riscv_iommu_init(struct riscv_iommu_device *iommu)
> @@ -632,6 +1208,16 @@ int riscv_iommu_init(struct riscv_iommu_device *iom=
mu)
>         }
>  #endif
>
> +       /*
> +        * Assign queue lengths from module parameters if not already
> +        * set on the device tree.
> +        */
> +       if (!iommu->cmdq_len)
> +               iommu->cmdq_len =3D cmdq_length;
> +       if (!iommu->fltq_len)
> +               iommu->fltq_len =3D fltq_length;
> +       if (!iommu->priq_len)
> +               iommu->priq_len =3D priq_length;
>         /* Clear any pending interrupt flag. */
>         riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR,
>                            RISCV_IOMMU_IPSR_CIP |
> @@ -639,7 +1225,20 @@ int riscv_iommu_init(struct riscv_iommu_device *iom=
mu)
>                            RISCV_IOMMU_IPSR_PMIP | RISCV_IOMMU_IPSR_PIP);
>         spin_lock_init(&iommu->cq_lock);
>         mutex_init(&iommu->eps_mutex);
> +       ret =3D riscv_iommu_queue_init(iommu, RISCV_IOMMU_COMMAND_QUEUE);
> +       if (ret)
> +               goto fail;
> +       ret =3D riscv_iommu_queue_init(iommu, RISCV_IOMMU_FAULT_QUEUE);
> +       if (ret)
> +               goto fail;
> +       if (!(iommu->cap & RISCV_IOMMU_CAP_ATS))
> +               goto no_ats;
> +
> +       ret =3D riscv_iommu_queue_init(iommu, RISCV_IOMMU_PAGE_REQUEST_QU=
EUE);
> +       if (ret)
> +               goto fail;
>
> + no_ats:
>         ret =3D riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_BARE);
>
>         if (ret) {
> @@ -663,5 +1262,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iomm=
u)
>         return 0;
>   fail:
>         riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> +       riscv_iommu_queue_free(iommu, &iommu->priq);
> +       riscv_iommu_queue_free(iommu, &iommu->fltq);
> +       riscv_iommu_queue_free(iommu, &iommu->cmdq);
>         return ret;
>  }
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 7dc9baa59a50..04148a2a8ffd 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -28,6 +28,24 @@
>  #define IOMMU_PAGE_SIZE_1G     BIT_ULL(30)
>  #define IOMMU_PAGE_SIZE_512G   BIT_ULL(39)
>
> +struct riscv_iommu_queue {
> +       dma_addr_t base_dma;    /* ring buffer bus address */
> +       void *base;             /* ring buffer pointer */
> +       size_t len;             /* single item length */
> +       u32 cnt;                /* items count */
> +       u32 lui;                /* last used index, consumer/producer sha=
re */
> +       unsigned qbr;           /* queue base register offset */
> +       unsigned qcr;           /* queue control and status register offs=
et */
> +       int irq;                /* registered interrupt number */
> +       bool in_iomem;          /* indicates queue data are in I/O memory=
  */
> +};
> +
> +enum riscv_queue_ids {
> +       RISCV_IOMMU_COMMAND_QUEUE       =3D 0,
> +       RISCV_IOMMU_FAULT_QUEUE         =3D 1,
> +       RISCV_IOMMU_PAGE_REQUEST_QUEUE  =3D 2
> +};
> +
>  struct riscv_iommu_device {
>         struct iommu_device iommu;      /* iommu core interface */
>         struct device *dev;             /* iommu hardware */
> @@ -42,6 +60,11 @@ struct riscv_iommu_device {
>         int irq_pm;
>         int irq_priq;
>
> +       /* Queue lengths */
> +       int cmdq_len;
> +       int fltq_len;
> +       int priq_len;
> +
>         /* supported and enabled hardware capabilities */
>         u64 cap;
>
> @@ -53,6 +76,11 @@ struct riscv_iommu_device {
>         unsigned ddt_mode;
>         bool ddtp_in_iomem;
>
> +       /* hardware queues */
> +       struct riscv_iommu_queue cmdq;
> +       struct riscv_iommu_queue fltq;
> +       struct riscv_iommu_queue priq;
> +
>         /* Connected end-points */
>         struct rb_root eps;
>         struct mutex eps_mutex;
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
