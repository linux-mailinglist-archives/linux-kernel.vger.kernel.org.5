Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEF3768F81
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGaIEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjGaIEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:04:05 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E798B2113
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:02:47 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77acb04309dso230535539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690790565; x=1691395365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCZirPUdtYbiMuCxmXphGmJX/Sg5hOUUOg1RDGHulbI=;
        b=SGjh/AtHr94md2aeFSV2NwDOg0oqQn/SnLDDCpkiU+G/+WrXhyeOhsf66FGuUrpqYs
         7V3JqnTUGI4Us+GaagWCJgh/GCN2kKnZ/dF9GCAGYievYQeiUtSbEGxAE2cIbk7c074o
         Dd6mH52/RWEtboQi+FZ9Fxp6tT450oKtHzGNomgcoExJYC4BfFneAv3jVkvw6ZNqr/Ty
         y4Ki3bP0cbG+IljwLYr2ygscyyKgN/DaHBC6dzBbOFd/GkNmdgo1JLS1vZ5z59XUoa9b
         +TWq7KrAye5BeHAUoEA4ALj1+uInnUN41dRuZCE2h1cd5kZC8FBVwcQ2q0UWMgnliuoZ
         MuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690790565; x=1691395365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCZirPUdtYbiMuCxmXphGmJX/Sg5hOUUOg1RDGHulbI=;
        b=eeLbyE+EOS1nDYX85wzh7E7EN2r9JeewPWViUidwg7buAB01pUwfLjZKeA2hquCWTn
         N9phZrpl9bYdbtO4xapy8zV6rID0c2zsw3k7bDMYieYjUy3FLSZPuBO+xbgsV7miZZ5h
         i1FNM5c/5I16RUiLkcHJ5Ld7ch67cDist5frhFgYSlxPh3OGBt5HbeC+rq1WdJgyZWTW
         O7aAqyVsPx9r2wRMfoFChOFA1xWp9rXP4jOsLEiwTeBlgWxwPJbbqhsyyg26hCXm7A9b
         aXGatHeZVnGb7neEhXr8YAxDM91q5t0RG9eQ2xqHfCDmz9ShmPeKId190Rs2ALxVtPG8
         vssQ==
X-Gm-Message-State: ABy/qLZUolwffbx2DNabsvcoqv4VaEXU4dniI1C/sy2LC0786LxouqvE
        yPf7xGZjyqN2tP5l/SQyxZcikpj3zy5MiAzRl0U89gUzcOwyLy4fWm0=
X-Google-Smtp-Source: APBJJlH3GU7IdkMvOpU71QMDvT5/hmd5Yp3CEFjdkjLPmxV1u8VCET+nuHN/SjOnH78U+3zpVmL7y/wwobSRmkMbN3s=
X-Received: by 2002:a5e:a90f:0:b0:790:a23b:1dfc with SMTP id
 c15-20020a5ea90f000000b00790a23b1dfcmr3153500iod.9.1690790565610; Mon, 31 Jul
 2023 01:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <660b7a8707e494a6bb2706e10569a7414c3640a7.1689792825.git.tjeznach@rivosinc.com>
In-Reply-To: <660b7a8707e494a6bb2706e10569a7414c3640a7.1689792825.git.tjeznach@rivosinc.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 31 Jul 2023 16:02:35 +0800
Message-ID: <CANXhq0oSiv7UV+nmZppA0_oZCevEEt2UsNTz6WE3gtcCpExYqw@mail.gmail.com>
Subject: Re: [PATCH 10/11] RISC-V: drivers/iommu/riscv: Add MSI identity remapping
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 3:34=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> This change provides basic identity mapping support to
> excercise MSI_FLAT hardware capability.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/riscv/iommu.c | 81 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu.h |  3 ++
>  2 files changed, 84 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 6042c35be3ca..7b3e3e135cf6 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -61,6 +61,9 @@ MODULE_PARM_DESC(priq_length, "Page request interface q=
ueue length.");
>  #define RISCV_IOMMU_MAX_PSCID  (1U << 20)
>  static DEFINE_IDA(riscv_iommu_pscids);
>
> +/* TODO: Enable MSI remapping */
> +#define RISCV_IMSIC_BASE       0x28000000

I'm not sure if it is appropriate to hard code the base address of
peripheral in source code, it might be depends on the layout of each
target.

> +
>  /* 1 second */
>  #define RISCV_IOMMU_TIMEOUT    riscv_timebase
>
> @@ -932,6 +935,72 @@ static irqreturn_t riscv_iommu_priq_process(int irq,=
 void *data)
>   * Endpoint management
>   */
>
> +static int riscv_iommu_enable_ir(struct riscv_iommu_endpoint *ep)
> +{
> +       struct riscv_iommu_device *iommu =3D ep->iommu;
> +       struct iommu_resv_region *entry;
> +       struct irq_domain *msi_domain;
> +       u64 val;
> +       int i;
> +
> +       /* Initialize MSI remapping */
> +       if (!ep->dc || !(iommu->cap & RISCV_IOMMU_CAP_MSI_FLAT))
> +               return 0;
> +
> +       ep->msi_root =3D (struct riscv_iommu_msi_pte *)get_zeroed_page(GF=
P_KERNEL);
> +       if (!ep->msi_root)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < 256; i++) {
> +               ep->msi_root[i].pte =3D RISCV_IOMMU_MSI_PTE_V |
> +                   FIELD_PREP(RISCV_IOMMU_MSI_PTE_M, 3) |
> +                   phys_to_ppn(RISCV_IMSIC_BASE + i * PAGE_SIZE);
> +       }
> +
> +       entry =3D iommu_alloc_resv_region(RISCV_IMSIC_BASE, PAGE_SIZE * 2=
56, 0,
> +                                       IOMMU_RESV_SW_MSI, GFP_KERNEL);
> +       if (entry)
> +               list_add_tail(&entry->list, &ep->regions);
> +
> +       val =3D virt_to_pfn(ep->msi_root) |
> +           FIELD_PREP(RISCV_IOMMU_DC_MSIPTP_MODE, RISCV_IOMMU_DC_MSIPTP_=
MODE_FLAT);
> +       ep->dc->msiptp =3D cpu_to_le64(val);
> +
> +       /* Single page of MSIPTP, 256 IMSIC files */
> +       ep->dc->msi_addr_mask =3D cpu_to_le64(255);
> +       ep->dc->msi_addr_pattern =3D cpu_to_le64(RISCV_IMSIC_BASE >> 12);
> +       wmb();
> +
> +       /* set msi domain for the device as isolated. hack. */
> +       msi_domain =3D dev_get_msi_domain(ep->dev);
> +       if (msi_domain) {
> +               msi_domain->flags |=3D IRQ_DOMAIN_FLAG_ISOLATED_MSI;
> +       }
> +
> +       dev_dbg(ep->dev, "RV-IR enabled\n");
> +
> +       ep->ir_enabled =3D true;
> +
> +       return 0;
> +}
> +
> +static void riscv_iommu_disable_ir(struct riscv_iommu_endpoint *ep)
> +{
> +       if (!ep->ir_enabled)
> +               return;
> +
> +       ep->dc->msi_addr_pattern =3D 0ULL;
> +       ep->dc->msi_addr_mask =3D 0ULL;
> +       ep->dc->msiptp =3D 0ULL;
> +       wmb();
> +
> +       dev_dbg(ep->dev, "RV-IR disabled\n");
> +
> +       free_pages((unsigned long)ep->msi_root, 0);
> +       ep->msi_root =3D NULL;
> +       ep->ir_enabled =3D false;
> +}
> +
>  /* Endpoint features/capabilities */
>  static void riscv_iommu_disable_ep(struct riscv_iommu_endpoint *ep)
>  {
> @@ -1226,6 +1295,7 @@ static struct iommu_device *riscv_iommu_probe_devic=
e(struct device *dev)
>
>         mutex_init(&ep->lock);
>         INIT_LIST_HEAD(&ep->domain);
> +       INIT_LIST_HEAD(&ep->regions);
>
>         if (dev_is_pci(dev)) {
>                 ep->devid =3D pci_dev_id(to_pci_dev(dev));
> @@ -1248,6 +1318,7 @@ static struct iommu_device *riscv_iommu_probe_devic=
e(struct device *dev)
>         dev_iommu_priv_set(dev, ep);
>         riscv_iommu_add_device(iommu, dev);
>         riscv_iommu_enable_ep(ep);
> +       riscv_iommu_enable_ir(ep);
>
>         return &iommu->iommu;
>  }
> @@ -1279,6 +1350,7 @@ static void riscv_iommu_release_device(struct devic=
e *dev)
>                 riscv_iommu_iodir_inv_devid(iommu, ep->devid);
>         }
>
> +       riscv_iommu_disable_ir(ep);
>         riscv_iommu_disable_ep(ep);
>
>         /* Remove endpoint from IOMMU tracking structures */
> @@ -1301,6 +1373,15 @@ static struct iommu_group *riscv_iommu_device_grou=
p(struct device *dev)
>
>  static void riscv_iommu_get_resv_regions(struct device *dev, struct list=
_head *head)
>  {
> +       struct iommu_resv_region *entry, *new_entry;
> +       struct riscv_iommu_endpoint *ep =3D dev_iommu_priv_get(dev);
> +
> +       list_for_each_entry(entry, &ep->regions, list) {
> +               new_entry =3D kmemdup(entry, sizeof(*entry), GFP_KERNEL);
> +               if (new_entry)
> +                       list_add_tail(&new_entry->list, head);
> +       }
> +
>         iommu_dma_get_resv_regions(dev, head);
>  }
>
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 83e8d00fd0f8..55418a1144fb 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -117,14 +117,17 @@ struct riscv_iommu_endpoint {
>         struct riscv_iommu_dc *dc;              /* device context pointer=
 */
>         struct riscv_iommu_pc *pc;              /* process context root, =
valid if pasid_enabled is true */
>         struct riscv_iommu_device *iommu;       /* parent iommu device */
> +       struct riscv_iommu_msi_pte *msi_root;   /* interrupt re-mapping *=
/
>
>         struct mutex lock;
>         struct list_head domain;                /* endpoint attached mana=
ged domain */
> +       struct list_head regions;               /* reserved regions, inte=
rrupt remapping window */
>
>         /* end point info bits */
>         unsigned pasid_bits;
>         unsigned pasid_feat;
>         bool pasid_enabled;
> +       bool ir_enabled;
>  };
>
>  /* Helper functions and macros */
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
