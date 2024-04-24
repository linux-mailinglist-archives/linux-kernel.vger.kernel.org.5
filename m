Return-Path: <linux-kernel+bounces-157842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1B18B1714
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D262821CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1924616F293;
	Wed, 24 Apr 2024 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZMYIGmZR"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37116F273
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001459; cv=none; b=MYXa017DJLA6N4bNof3pdALXl1N2WicSqzX7EBzo7upU+ttGBcVwCm7V9DIhEWanHO6cio/TTUm0e3YkSKR0iyguaAqEwQlQstdns3wnbbSjXGabVUS6Kut6U1RsWox3e5MDX3q6B+HVWHeWL7MN37qEOABWwoyqPeSWVfSPy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001459; c=relaxed/simple;
	bh=8tX0hIqEDwtvdHuLOQHmw3t48nptNzqhFmHzM8Lw3Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hh1JVCFeTpyjQ7kUIe+MTpwq4k1ULw1RdLwR42u++Cukncjf5HoVXwytBDZutX4WAiaYzetC4r2LcWx+uCQ1+FXf/su6GHDcETFjiwkRt4B0nMezxtWAyXnzYOq+1Fyr3ZmHc0sSaIAqwPQ9nJMImYwmvJ7RNwvkmKItdLkdG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZMYIGmZR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a6fa7773d3so388011a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714001456; x=1714606256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMATVbNc+KeJ4YoonusKbhJs7fn4XepeFw1NaKuOxdo=;
        b=ZMYIGmZRJAU07POXs4CL/Pba7aT+4jLdNoUWVb8OWip6DAElqdKnIYaZXnD1AAPRq/
         Jtqdy9UL2X+8ROLet9D6i2izTD2p5aKDW4NH8/eLN7wTGd20QjZGSSJbiubQONB05m4c
         RW613TQz6wR0eFyyM+NGvBoCrq+mjDp5WR3tU9HrRvheqAUHWyN8dnar1bN06NH4HTDX
         LVgjUSmqdUQ8dcvZHheINHNCyPxb2F0KIpispL7y0xUuiDtHMmqe2sb565wTJU7bCPZS
         iXEcTwyGbMQtpOTtFe12yA5gYRcdWRlnARXvT21SCjq/IRMgDXMdhD4DDVV6YUEM9n0Y
         IK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714001456; x=1714606256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMATVbNc+KeJ4YoonusKbhJs7fn4XepeFw1NaKuOxdo=;
        b=mfhAL8qunDQz9LTLCgyubTT48LpUOU06WogHxqwfyebmlwVHA7Drzq7F/WLIACqLyN
         St0vFSineIzAI7h6+8JGl52Rp5ysJnGKYA2vUnPvvtvxEf6rBf7MfwBQAriH0WIQHoD6
         gLpFRnj+lKIxTtinYAtPs2QlZWLS4LFaH1jxgC7+bVvI/ep6Mj+dEdkBE/CRg0AG+5sA
         I9SuNrVa9YU3BLj3//hAAOrXJIDgrqezLMTIwP0zGe15zHfCNGoA47QYY/PQwSA7v6Ja
         hRf+Rs7S/tWr3Wv8+0L5NK7W1CGFUe148OZfLKEsrysg0vtpapilAeVAz+9WcLx9qYi/
         N+yw==
X-Forwarded-Encrypted: i=1; AJvYcCVE9eqtWq05IkXmHylp+RhqGTem0re/UJW1SmnDaM8mVNT7PvmI4s/5wmVlrT8hyrNsxug/ARYryCAZy9UQrYyvUt3V54O60WtGlKUg
X-Gm-Message-State: AOJu0YzwHHOuzDuQDps1hlTo6wUYj3/bPaGua7U2waDKhy3cVLlFWSd+
	fRdzam+IpKKu+SRMi1+DNRBuymEnzKQvkjXXkttXsSbLGhEvh8h3zNmmg7ezltL227iyHlkY1m2
	Gxam79xeF8n6v10usQENUgK/tTv7IBRqgScNn+A==
X-Google-Smtp-Source: AGHT+IHDriSlySRYAYqL2sP2QSsED+lIW5yVPA8GnLPlrwvTr2mGvTrOQx5/GwZwnS4XHBtP69e+E7BWAjK1DtYW0H4=
X-Received: by 2002:a17:90b:1103:b0:2a3:be59:e969 with SMTP id
 gi3-20020a17090b110300b002a3be59e969mr3617650pjb.47.1714001456387; Wed, 24
 Apr 2024 16:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713456597.git.tjeznach@rivosinc.com> <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>
 <20240419125627.GD223006@ziepe.ca>
In-Reply-To: <20240419125627.GD223006@ziepe.ca>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 24 Apr 2024 16:30:45 -0700
Message-ID: <CAH2o1u5+XD9YN=gdMVtfkyhKoKha0UpwKgOVbCAwOQa+saPfRw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] iommu/riscv: Paging domain support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 5:56=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Apr 18, 2024 at 09:32:25AM -0700, Tomasz Jeznach wrote:
>
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index a4f74588cdc2..32ddc372432d 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -46,6 +46,10 @@ MODULE_LICENSE("GPL");
> >  #define dev_to_iommu(dev) \
> >       container_of((dev)->iommu->iommu_dev, struct riscv_iommu_device, =
iommu)
> >
> > +/* IOMMU PSCID allocation namespace. */
> > +static DEFINE_IDA(riscv_iommu_pscids);
> > +#define RISCV_IOMMU_MAX_PSCID                BIT(20)
> > +
>
> You may consider putting this IDA in the riscv_iommu_device() and move
> the pscid from the domain to the bond?
>

I've been considering containing IDA inside riscv_iommu_device at some
point,  but it made PCSID management more complicated.  In the follow
up patches it is desired for PSCID to be unique across all IOMMUs in
the system (within guest's GSCID), as the protection domains might
(and will) be shared between more than single IOMMU device.

> >  /* Device resource-managed allocations */
> >  struct riscv_iommu_devres {
> >       unsigned long addr;
> > @@ -752,12 +756,77 @@ static int riscv_iommu_ddt_alloc(struct riscv_iom=
mu_device *iommu)
> >       return 0;
> >  }
> >
> > +struct riscv_iommu_bond {
> > +     struct list_head list;
> > +     struct rcu_head rcu;
> > +     struct device *dev;
> > +};
> > +
> > +/* This struct contains protection domain specific IOMMU driver data. =
*/
> > +struct riscv_iommu_domain {
> > +     struct iommu_domain domain;
> > +     struct list_head bonds;
> > +     int pscid;
> > +     int numa_node;
> > +     int amo_enabled:1;
> > +     unsigned int pgd_mode;
> > +     /* paging domain */
> > +     unsigned long pgd_root;
> > +};
>
> Glad to see there is no riscv_iommu_device pointer in the domain!
>
> > +static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
> > +                                 unsigned long start, unsigned long en=
d)
> > +{
> > +     struct riscv_iommu_bond *bond;
> > +     struct riscv_iommu_device *iommu;
> > +     struct riscv_iommu_command cmd;
> > +     unsigned long len =3D end - start + 1;
> > +     unsigned long iova;
> > +
> > +     rcu_read_lock();
> > +     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > +             iommu =3D dev_to_iommu(bond->dev);
>
> Pedantically this locking isn't locked right, there is technically
> nothing that prevents bond->dev and the iommu instance struct from
> being freed here. eg iommufd can hit races here if userspace can hot
> unplug devices.
>
> I suggest storing the iommu pointer itself in the bond instead of the
> device then add a synchronize_rcu() to the iommu unregister path.
>

Very good point. Thanks for pointing this out.
Reworked to add locking around list modifications (and do not
incorrectly rely on iommu group mutex locks).

> > +             riscv_iommu_cmd_inval_vma(&cmd);
> > +             riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> > +             if (len > 0 && len < RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> > +                     for (iova =3D start; iova < end; iova +=3D PAGE_S=
IZE) {
> > +                             riscv_iommu_cmd_inval_set_addr(&cmd, iova=
);
> > +                             riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +                     }
> > +             } else {
> > +                     riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +             }
> > +     }
>
> This seems suboptimal, you probably want to copy the new design that
> Intel is doing where you allocate "bonds" that are already
> de-duplicated. Ie if I have 10 devices on the same iommu sharing the
> domain the above will invalidate the PSCID 10 times. It should only be
> done once.
>
> ie add a "bond" for the (iommu,pscid) and refcount that based on how
> many devices are used. Then another "bond" for the ATS stuff eventually.
>

Agree, not perfect to send duplicate invalidations.
This should improve with follow up patchsets introducing of SVA
(reusing the same, extended bond structure) and update to send IOTLB
range invalidations.

For this change I've decided to go with as simple as possible
implementation and over-invalidate for domains with multiple devices
attached. Hope this makes sense.

> > +
> > +     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > +             iommu =3D dev_to_iommu(bond->dev);
> > +
> > +             riscv_iommu_cmd_iofence(&cmd);
> > +             riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEO=
UT);
> > +     }
> > +     rcu_read_unlock();
> > +}
> > +
>
> > @@ -787,12 +870,390 @@ static int riscv_iommu_attach_domain(struct risc=
v_iommu_device *iommu,
> >               xchg64(&dc->ta, ta);
> >               xchg64(&dc->tc, tc);
> >
> > -             /* Device context invalidation will be required. Ignoring=
 for now. */
> > +             if (!(tc & RISCV_IOMMU_DC_TC_V))
> > +                     continue;
>
> No negative caching in HW?
>
No. Disallowed by the spec.

> > +             /* Invalidate device context cache */
> > +             riscv_iommu_cmd_iodir_inval_ddt(&cmd);
> > +             riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
> > +             riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +
> > +             if (FIELD_GET(RISCV_IOMMU_PC_FSC_MODE, fsc) =3D=3D RISCV_=
IOMMU_DC_FSC_MODE_BARE)
> > +                     continue;
> > +
> > +             /* Invalidate last valid PSCID */
> > +             riscv_iommu_cmd_inval_vma(&cmd);
> > +             riscv_iommu_cmd_inval_set_pscid(&cmd, FIELD_GET(RISCV_IOM=
MU_DC_TA_PSCID, ta));
> > +             riscv_iommu_cmd_send(iommu, &cmd, 0);
> > +     }
> > +
> > +     /* Synchronize directory update */
> > +     riscv_iommu_cmd_iofence(&cmd);
> > +     riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_IOTINVAL_TIMEOUT);
> > +
> > +     /* Track domain to devices mapping. */
> > +     if (bond)
> > +             list_add_rcu(&bond->list, &domain->bonds);
>
> This is in the wrong order, the invalidation on the pscid needs to
> start before the pscid is loaded into HW in the first place otherwise
> concurrent invalidations may miss HW updates.
>
> > +
> > +     /* Remove tracking from previous domain, if needed. */
> > +     iommu_domain =3D iommu_get_domain_for_dev(dev);
> > +     if (iommu_domain && !!(iommu_domain->type & __IOMMU_DOMAIN_PAGING=
)) {
>
> No need for !!, && is already booleanizing
>
> > +             domain =3D iommu_domain_to_riscv(iommu_domain);
> > +             bond =3D NULL;
> > +             rcu_read_lock();
> > +             list_for_each_entry_rcu(b, &domain->bonds, list) {
> > +                     if (b->dev =3D=3D dev) {
> > +                             bond =3D b;
> > +                             break;
> > +                     }
> > +             }
> > +             rcu_read_unlock();
> > +
> > +             if (bond) {
> > +                     list_del_rcu(&bond->list);
> > +                     kfree_rcu(bond, rcu);
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
>
> > +static inline size_t get_page_size(size_t size)
> > +{
> > +     if (size >=3D IOMMU_PAGE_SIZE_512G)
> > +             return IOMMU_PAGE_SIZE_512G;
> > +     if (size >=3D IOMMU_PAGE_SIZE_1G)
> > +             return IOMMU_PAGE_SIZE_1G;
> > +     if (size >=3D IOMMU_PAGE_SIZE_2M)
> > +             return IOMMU_PAGE_SIZE_2M;
> > +     return IOMMU_PAGE_SIZE_4K;
> > +}
> > +
> > +#define _io_pte_present(pte) ((pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE=
))
> > +#define _io_pte_leaf(pte)    ((pte) & _PAGE_LEAF)
> > +#define _io_pte_none(pte)    ((pte) =3D=3D 0)
> > +#define _io_pte_entry(pn, prot)      ((_PAGE_PFN_MASK & ((pn) << _PAGE=
_PFN_SHIFT)) | (prot))
> > +
> > +static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
> > +                              unsigned long pte, struct list_head *fre=
elist)
> > +{
> > +     unsigned long *ptr;
> > +     int i;
> > +
> > +     if (!_io_pte_present(pte) || _io_pte_leaf(pte))
> > +             return;
> > +
> > +     ptr =3D (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
> > +
> > +     /* Recursively free all sub page table pages */
> > +     for (i =3D 0; i < PTRS_PER_PTE; i++) {
> > +             pte =3D READ_ONCE(ptr[i]);
> > +             if (!_io_pte_none(pte) && cmpxchg_relaxed(ptr + i, pte, 0=
) =3D=3D pte)
> > +                     riscv_iommu_pte_free(domain, pte, freelist);
> > +     }
> > +
> > +     if (freelist)
> > +             list_add_tail(&virt_to_page(ptr)->lru, freelist);
> > +     else
> > +             free_page((unsigned long)ptr);
> > +}
>
> Consider putting the page table handling in its own file?
>

It was in separate file at some point, but merged to iommu.c, as its
simple enough with ~300 lines only. Probably not worth separating this
out.

> > +static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu=
_domain,
> > +                                         struct device *dev)
> > +{
> > +     struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > +     struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(iommu=
_domain);
> > +     struct page *page;
> > +
> > +     if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
> > +             return -ENODEV;
> > +
> > +     domain->numa_node =3D dev_to_node(iommu->dev);
> > +     domain->amo_enabled =3D !!(iommu->caps & RISCV_IOMMU_CAP_AMO_HWAD=
);
> > +
> > +     if (!domain->pgd_root) {
> > +             page =3D alloc_pages_node(domain->numa_node,
> > +                                     GFP_KERNEL_ACCOUNT | __GFP_ZERO, =
0);
> > +             if (!page)
> > +                     return -ENOMEM;
> > +             domain->pgd_root =3D (unsigned long)page_to_virt(page);
>
> The pgd_root should be allocated by the alloc_paging function, not
> during attach. There is no locking here that will protect against
> concurrent attach and also map before attach should work.
>
> You can pick up the numa affinity from the alloc paging dev pointer
> (note it may be null still in some cases)
>

Good point. Thanks. Will send update shortly with v3.

> Jason

Ack to all other comments, thank you!
Best,
- Tomasz

