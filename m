Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B317D768E98
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGaHXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjGaHWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:22:34 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736C5189
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:19:30 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-790b080f2a0so3679239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690787970; x=1691392770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5HCKgizQghhFT6UNgruN8RzDFlLCCsJgxRTM0kkuHo=;
        b=N56ECHCkbSfOZhDGlV+T01EqnLZlDfwu15hmGWt50FxcJRdncuzIU6LQMNNj6YhLnH
         gOHz9uaQA2tVlTnuzp0mkNS9J3kRVHzALxhsOrMCJ2U0qb/sWKq0VT3k167GGNLW9MPL
         2Ylt52nUWQUsyFUTEA5IQ+UGDPhkJC+/g9we7WFToJJCpi+pv+fpsPDYt7Rk6gsHX1KT
         DZ9GzX0KG12h3+MN2BG8qlJgcKWjjfcVJShpOcsgbfqwG7Y1L/sBCdOf2zMMLrzryMBc
         soc0SErpbNwb/xF1RccqN7W+Vc6xpjAtjW2P+saBpod304Qo9V3ImTK4lXNyoM/e4/sT
         +o2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787970; x=1691392770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5HCKgizQghhFT6UNgruN8RzDFlLCCsJgxRTM0kkuHo=;
        b=QOJoh6/KjiYJrgtfj30ZEgTGFc3yiaxlNUcqqqLVht8ZDdvdd128qHvv1xiK5xd9Aj
         eZdASAWSei6Y3jCxKgptWMlw6nPIun6axjyMykzVa/A1pMe8wDHysYqL7WWm5Vd6Hr2N
         mt4uYAgjVO2CJJpDaRfDi1RhjrFNoIt/W6eqKZy+WqC5xk/r+1mwshBCmYGdo9W1fXeZ
         FMPmge4DjBFvrzb4QqCRBeLkQdoM9hxCatH8CufqF7xNjnY50W3egLRWJPxCMogrCkrz
         X7gW1wD5wU1W96K0lqcYx6+kVmf0uD1DKxCpaC4BvIdjO8gEae6mAA4aVRUfl9xDn2bs
         Woqg==
X-Gm-Message-State: ABy/qLYBaluvWSTw8agEWjugPDUDboZDbE4paVpbvBYijtDWZoTqUg9Y
        KwchtaYZNDVdZB5LJUYwBLIrT0nu3ktn6T/vECTLCA==
X-Google-Smtp-Source: APBJJlHz36eN/D+sgs9SSHSNxRkJbB420vSQzDbNnunHJRr/b3BttfpC6gVEsy5DqdcMgqrzYKUJtLjRiNs6YP1loxw=
X-Received: by 2002:a05:6602:641:b0:787:129a:1e6c with SMTP id
 d1-20020a056602064100b00787129a1e6cmr5113578iox.4.1690787969731; Mon, 31 Jul
 2023 00:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <2d5242e79a98dc75cd8fa0fefdb4e3ad37a920ba.1689792825.git.tjeznach@rivosinc.com>
In-Reply-To: <2d5242e79a98dc75cd8fa0fefdb4e3ad37a920ba.1689792825.git.tjeznach@rivosinc.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 31 Jul 2023 15:19:19 +0800
Message-ID: <CANXhq0pb-4y9rOoMwqSgyf-RUQAAp5J8iOheG=Nbo71vCtns7g@mail.gmail.com>
Subject: Re: [PATCH 08/11] RISC-V: drivers/iommu/riscv: Add page table support
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
> Introduces I/O page level translation services, with 4K, 2M, 1G page
> size support and enables page level iommu_map/unmap domain interfaces.
>
> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/io-pgtable.c       |   3 +
>  drivers/iommu/riscv/Makefile     |   2 +-
>  drivers/iommu/riscv/io_pgtable.c | 266 +++++++++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu.c      |  40 +++--
>  drivers/iommu/riscv/iommu.h      |   1 +
>  include/linux/io-pgtable.h       |   2 +
>  6 files changed, 297 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/iommu/riscv/io_pgtable.c
>
> diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> index b843fcd365d2..c4807175934f 100644
> --- a/drivers/iommu/io-pgtable.c
> +++ b/drivers/iommu/io-pgtable.c
> @@ -32,6 +32,9 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] =3D {
>         [AMD_IOMMU_V1] =3D &io_pgtable_amd_iommu_v1_init_fns,
>         [AMD_IOMMU_V2] =3D &io_pgtable_amd_iommu_v2_init_fns,
>  #endif
> +#ifdef CONFIG_RISCV_IOMMU
> +       [RISCV_IOMMU] =3D &io_pgtable_riscv_init_fns,
> +#endif
>  };
>
>  struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
> diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
> index 9523eb053cfc..13af452c3052 100644
> --- a/drivers/iommu/riscv/Makefile
> +++ b/drivers/iommu/riscv/Makefile
> @@ -1 +1 @@
> -obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-pci.o iommu-platform.o iomm=
u-sysfs.o
> \ No newline at end of file
> +obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-pci.o iommu-platform.o iomm=
u-sysfs.o io_pgtable.o
> diff --git a/drivers/iommu/riscv/io_pgtable.c b/drivers/iommu/riscv/io_pg=
table.c
> new file mode 100644
> index 000000000000..b6e603e6726e
> --- /dev/null
> +++ b/drivers/iommu/riscv/io_pgtable.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright =C2=A9 2022-2023 Rivos Inc.
> + *
> + * RISC-V IOMMU page table allocator.
> + *
> + * Authors:
> + *     Tomasz Jeznach <tjeznach@rivosinc.com>
> + *     Sebastien Boeuf <seb@rivosinc.com>
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/bitops.h>
> +#include <linux/io-pgtable.h>
> +#include <linux/kernel.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/dma-mapping.h>
> +
> +#include "iommu.h"
> +
> +#define io_pgtable_to_domain(x) \
> +       container_of((x), struct riscv_iommu_domain, pgtbl)
> +
> +#define io_pgtable_ops_to_domain(x) \
> +       io_pgtable_to_domain(container_of((x), struct io_pgtable, ops))
> +
> +static inline size_t get_page_size(size_t size)
> +{
> +       if (size >=3D IOMMU_PAGE_SIZE_512G)
> +               return IOMMU_PAGE_SIZE_512G;
> +
> +       if (size >=3D IOMMU_PAGE_SIZE_1G)
> +               return IOMMU_PAGE_SIZE_1G;
> +
> +       if (size >=3D IOMMU_PAGE_SIZE_2M)
> +               return IOMMU_PAGE_SIZE_2M;
> +
> +       return IOMMU_PAGE_SIZE_4K;
> +}
> +
> +static void riscv_iommu_pt_walk_free(pmd_t * ptp, unsigned shift, bool r=
oot)
> +{
> +       pmd_t *pte, *pt_base;
> +       int i;
> +
> +       if (shift =3D=3D PAGE_SHIFT)
> +               return;
> +
> +       if (root)
> +               pt_base =3D ptp;
> +       else
> +               pt_base =3D
> +                   (pmd_t *) pfn_to_virt(__page_val_to_pfn(pmd_val(*ptp)=
));
> +
> +       /* Recursively free all sub page table pages */
> +       for (i =3D 0; i < PTRS_PER_PMD; i++) {
> +               pte =3D pt_base + i;
> +               if (pmd_present(*pte) && !pmd_leaf(*pte))
> +                       riscv_iommu_pt_walk_free(pte, shift - 9, false);
> +       }
> +
> +       /* Now free the current page table page */
> +       if (!root && pmd_present(*pt_base))
> +               free_page((unsigned long)pt_base);
> +}
> +
> +static void riscv_iommu_free_pgtable(struct io_pgtable *iop)
> +{
> +       struct riscv_iommu_domain *domain =3D io_pgtable_to_domain(iop);
> +       riscv_iommu_pt_walk_free((pmd_t *) domain->pgd_root, PGDIR_SHIFT,=
 true);
> +}
> +
> +static pte_t *riscv_iommu_pt_walk_alloc(pmd_t * ptp, unsigned long iova,
> +                                       unsigned shift, bool root,
> +                                       size_t pgsize,
> +                                       unsigned long (*pd_alloc)(gfp_t),
> +                                       gfp_t gfp)
> +{
> +       pmd_t *pte;
> +       unsigned long pfn;
> +
> +       if (root)
> +               pte =3D ptp + ((iova >> shift) & (PTRS_PER_PMD - 1));
> +       else
> +               pte =3D (pmd_t *) pfn_to_virt(__page_val_to_pfn(pmd_val(*=
ptp))) +
> +                   ((iova >> shift) & (PTRS_PER_PMD - 1));
> +
> +       if ((1ULL << shift) <=3D pgsize) {
> +               if (pmd_present(*pte) && !pmd_leaf(*pte))
> +                       riscv_iommu_pt_walk_free(pte, shift - 9, false);
> +               return (pte_t *) pte;
> +       }
> +
> +       if (pmd_none(*pte)) {
> +               pfn =3D pd_alloc ? virt_to_pfn(pd_alloc(gfp)) : 0;
> +               if (!pfn)
> +                       return NULL;
> +               set_pmd(pte, __pmd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE=
));
> +       }
> +
> +       return riscv_iommu_pt_walk_alloc(pte, iova, shift - 9, false,
> +                                        pgsize, pd_alloc, gfp);
> +}
> +
> +static pte_t *riscv_iommu_pt_walk_fetch(pmd_t * ptp,
> +                                       unsigned long iova, unsigned shif=
t,
> +                                       bool root)
> +{
> +       pmd_t *pte;
> +
> +       if (root)
> +               pte =3D ptp + ((iova >> shift) & (PTRS_PER_PMD - 1));
> +       else
> +               pte =3D (pmd_t *) pfn_to_virt(__page_val_to_pfn(pmd_val(*=
ptp))) +
> +                   ((iova >> shift) & (PTRS_PER_PMD - 1));
> +
> +       if (pmd_leaf(*pte))
> +               return (pte_t *) pte;
> +       else if (pmd_none(*pte))
> +               return NULL;
> +       else if (shift =3D=3D PAGE_SHIFT)
> +               return NULL;
> +
> +       return riscv_iommu_pt_walk_fetch(pte, iova, shift - 9, false);
> +}
> +
> +static int riscv_iommu_map_pages(struct io_pgtable_ops *ops,
> +                                unsigned long iova, phys_addr_t phys,
> +                                size_t pgsize, size_t pgcount, int prot,
> +                                gfp_t gfp, size_t *mapped)
> +{
> +       struct riscv_iommu_domain *domain =3D io_pgtable_ops_to_domain(op=
s);
> +       size_t size =3D 0;
> +       size_t page_size =3D get_page_size(pgsize);
> +       pte_t *pte;
> +       pte_t pte_val;
> +       pgprot_t pte_prot;
> +
> +       if (domain->domain.type =3D=3D IOMMU_DOMAIN_BLOCKED)
> +               return -ENODEV;
> +
> +       if (domain->domain.type =3D=3D IOMMU_DOMAIN_IDENTITY) {
> +               *mapped =3D pgsize * pgcount;
> +               return 0;
> +       }
> +
> +       pte_prot =3D (prot & IOMMU_WRITE) ?
> +           __pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_WRITE | _PAGE_DIRTY)=
 :
> +           __pgprot(_PAGE_BASE | _PAGE_READ);
> +
> +       while (pgcount--) {
> +               pte =3D
> +                   riscv_iommu_pt_walk_alloc((pmd_t *) domain->pgd_root,=
 iova,
> +                                             PGDIR_SHIFT, true, page_siz=
e,
> +                                             get_zeroed_page, gfp);
> +               if (!pte) {
> +                       *mapped =3D size;
> +                       return -ENOMEM;
> +               }
> +
> +               pte_val =3D pfn_pte(phys_to_pfn(phys), pte_prot);
> +
> +               set_pte(pte, pte_val);
> +
> +               size +=3D page_size;
> +               iova +=3D page_size;
> +               phys +=3D page_size;
> +       }
> +
> +       *mapped =3D size;
> +       return 0;
> +}
> +
> +static size_t riscv_iommu_unmap_pages(struct io_pgtable_ops *ops,
> +                                     unsigned long iova, size_t pgsize,
> +                                     size_t pgcount,
> +                                     struct iommu_iotlb_gather *gather)
> +{
> +       struct riscv_iommu_domain *domain =3D io_pgtable_ops_to_domain(op=
s);
> +       size_t size =3D 0;
> +       size_t page_size =3D get_page_size(pgsize);
> +       pte_t *pte;
> +
> +       if (domain->domain.type =3D=3D IOMMU_DOMAIN_IDENTITY)
> +               return pgsize * pgcount;
> +
> +       while (pgcount--) {
> +               pte =3D riscv_iommu_pt_walk_fetch((pmd_t *) domain->pgd_r=
oot,
> +                                               iova, PGDIR_SHIFT, true);
> +               if (!pte)
> +                       return size;
> +
> +               set_pte(pte, __pte(0));
> +
> +               iommu_iotlb_gather_add_page(&domain->domain, gather, iova=
,
> +                                           pgsize);
> +
> +               size +=3D page_size;
> +               iova +=3D page_size;
> +       }
> +
> +       return size;
> +}
> +
> +static phys_addr_t riscv_iommu_iova_to_phys(struct io_pgtable_ops *ops,
> +                                           unsigned long iova)
> +{
> +       struct riscv_iommu_domain *domain =3D io_pgtable_ops_to_domain(op=
s);
> +       pte_t *pte;
> +
> +       if (domain->domain.type =3D=3D IOMMU_DOMAIN_IDENTITY)
> +               return (phys_addr_t) iova;
> +
> +       pte =3D riscv_iommu_pt_walk_fetch((pmd_t *) domain->pgd_root,
> +                                       iova, PGDIR_SHIFT, true);
> +       if (!pte || !pte_present(*pte))
> +               return 0;
> +
> +       return (pfn_to_phys(pte_pfn(*pte)) | (iova & PAGE_MASK));

As I mentioned in last mail, it should be (iova & ~PAGE_MASK) for
getting low 12 bits.

> +}
> +
> +static void riscv_iommu_tlb_inv_all(void *cookie)
> +{
> +}
> +
> +static void riscv_iommu_tlb_inv_walk(unsigned long iova, size_t size,
> +                                    size_t granule, void *cookie)
> +{
> +}
> +

What could we do in these callbacks? Perhaps send the IOTINVAL command to I=
OMMU?

> +static void riscv_iommu_tlb_add_page(struct iommu_iotlb_gather *gather,
> +                                    unsigned long iova, size_t granule,
> +                                    void *cookie)
> +{
> +}
> +
> +static const struct iommu_flush_ops riscv_iommu_flush_ops =3D {
> +       .tlb_flush_all =3D riscv_iommu_tlb_inv_all,
> +       .tlb_flush_walk =3D riscv_iommu_tlb_inv_walk,
> +       .tlb_add_page =3D riscv_iommu_tlb_add_page,
> +};
> +
> +/* NOTE: cfg should point to riscv_iommu_domain structure member pgtbl.c=
fg */
> +static struct io_pgtable *riscv_iommu_alloc_pgtable(struct io_pgtable_cf=
g *cfg,
> +                                                   void *cookie)
> +{
> +       struct io_pgtable *iop =3D container_of(cfg, struct io_pgtable, c=
fg);
> +
> +       cfg->pgsize_bitmap =3D SZ_4K | SZ_2M | SZ_1G;
> +       cfg->ias =3D 57;          // va mode, SvXX -> ias
> +       cfg->oas =3D 57;          // pa mode, or SvXX+4 -> oas

Is it possible that use VA_BITS instead of this magic number?

> +       cfg->tlb =3D &riscv_iommu_flush_ops;
> +
> +       iop->ops.map_pages =3D riscv_iommu_map_pages;
> +       iop->ops.unmap_pages =3D riscv_iommu_unmap_pages;
> +       iop->ops.iova_to_phys =3D riscv_iommu_iova_to_phys;
> +
> +       return iop;
> +}
> +
> +struct io_pgtable_init_fns io_pgtable_riscv_init_fns =3D {
> +       .alloc =3D riscv_iommu_alloc_pgtable,
> +       .free =3D riscv_iommu_free_pgtable,
> +};
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 9ee7d2b222b5..2ef6952a2109 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -807,7 +807,7 @@ static struct iommu_device *riscv_iommu_probe_device(=
struct device *dev)
>         /* Initial DC pointer can be NULL if IOMMU is configured in OFF o=
r BARE mode */
>         ep->dc =3D riscv_iommu_get_dc(iommu, ep->devid);
>
> -       dev_info(iommu->dev, "adding device to iommu with devid %i in dom=
ain %i\n",
> +       dev_dbg(iommu->dev, "adding device to iommu with devid %i in doma=
in %i\n",
>                 ep->devid, ep->domid);
>
>         dev_iommu_priv_set(dev, ep);
> @@ -874,7 +874,10 @@ static struct iommu_domain *riscv_iommu_domain_alloc=
(unsigned type)
>  {
>         struct riscv_iommu_domain *domain;
>
> -       if (type !=3D IOMMU_DOMAIN_IDENTITY &&
> +       if (type !=3D IOMMU_DOMAIN_DMA &&
> +           type !=3D IOMMU_DOMAIN_DMA_FQ &&
> +           type !=3D IOMMU_DOMAIN_UNMANAGED &&
> +           type !=3D IOMMU_DOMAIN_IDENTITY &&
>             type !=3D IOMMU_DOMAIN_BLOCKED)
>                 return NULL;
>
> @@ -890,7 +893,7 @@ static struct iommu_domain *riscv_iommu_domain_alloc(=
unsigned type)
>         domain->pscid =3D ida_alloc_range(&riscv_iommu_pscids, 1,
>                                         RISCV_IOMMU_MAX_PSCID, GFP_KERNEL=
);
>
> -       printk("domain type %x alloc %u\n", type, domain->pscid);
> +       printk("domain alloc %u\n", domain->pscid);
>
>         return &domain->domain;
>  }
> @@ -903,6 +906,9 @@ static void riscv_iommu_domain_free(struct iommu_doma=
in *iommu_domain)
>                 pr_warn("IOMMU domain is not empty!\n");
>         }
>
> +       if (domain->pgtbl.cookie)
> +               free_io_pgtable_ops(&domain->pgtbl.ops);
> +
>         if (domain->pgd_root)
>                 free_pages((unsigned long)domain->pgd_root, 0);
>
> @@ -959,6 +965,9 @@ static int riscv_iommu_domain_finalize(struct riscv_i=
ommu_domain *domain,
>         if (!domain->pgd_root)
>                 return -ENOMEM;
>
> +       if (!alloc_io_pgtable_ops(RISCV_IOMMU, &domain->pgtbl.cfg, domain=
))
> +               return -ENOMEM;
> +
>         return 0;
>  }
>
> @@ -1006,9 +1015,8 @@ static int riscv_iommu_attach_dev(struct iommu_doma=
in *iommu_domain, struct devi
>                 return 0;
>         }
>
> -       if (!dc) {
> +       if (!dc)
>                 return -ENODEV;
> -       }
>
>         /*
>          * S-Stage translation table. G-Stage remains unmodified (BARE).
> @@ -1104,12 +1112,11 @@ static int riscv_iommu_map_pages(struct iommu_dom=
ain *iommu_domain,
>  {
>         struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
>
> -       if (domain->domain.type =3D=3D IOMMU_DOMAIN_IDENTITY) {
> -               *mapped =3D pgsize * pgcount;
> -               return 0;
> -       }
> +       if (!domain->pgtbl.ops.map_pages)
> +               return -ENODEV;
>
> -       return -ENODEV;
> +       return domain->pgtbl.ops.map_pages(&domain->pgtbl.ops, iova, phys=
,
> +                                          pgsize, pgcount, prot, gfp, ma=
pped);
>  }
>
>  static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
> @@ -1118,10 +1125,11 @@ static size_t riscv_iommu_unmap_pages(struct iomm=
u_domain *iommu_domain,
>  {
>         struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
>
> -       if (domain->domain.type =3D=3D IOMMU_DOMAIN_IDENTITY)
> -               return pgsize * pgcount;
> +       if (!domain->pgtbl.ops.unmap_pages)
> +               return 0;
>
> -       return 0;
> +       return domain->pgtbl.ops.unmap_pages(&domain->pgtbl.ops, iova, pg=
size,
> +                                            pgcount, gather);
>  }
>
>  static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_d=
omain,
> @@ -1129,10 +1137,10 @@ static phys_addr_t riscv_iommu_iova_to_phys(struc=
t iommu_domain *iommu_domain,
>  {
>         struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
>
> -       if (domain->domain.type =3D=3D IOMMU_DOMAIN_IDENTITY)
> -               return (phys_addr_t) iova;
> +       if (!domain->pgtbl.ops.iova_to_phys)
> +               return 0;
>
> -       return 0;
> +       return domain->pgtbl.ops.iova_to_phys(&domain->pgtbl.ops, iova);
>  }
>
>  /*
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 9140df71e17b..fe32a4eff14e 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -88,6 +88,7 @@ struct riscv_iommu_device {
>
>  struct riscv_iommu_domain {
>         struct iommu_domain domain;
> +       struct io_pgtable pgtbl;
>
>         struct list_head endpoints;
>         struct mutex lock;
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 1b7a44b35616..8dd9d3a28e3a 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -19,6 +19,7 @@ enum io_pgtable_fmt {
>         AMD_IOMMU_V2,
>         APPLE_DART,
>         APPLE_DART2,
> +       RISCV_IOMMU,
>         IO_PGTABLE_NUM_FMTS,
>  };
>
> @@ -258,5 +259,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_mali=
_lpae_init_fns;
>  extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
>  extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns;
>  extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;
> +extern struct io_pgtable_init_fns io_pgtable_riscv_init_fns;
>
>  #endif /* __IO_PGTABLE_H */
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
