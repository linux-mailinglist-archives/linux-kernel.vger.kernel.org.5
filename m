Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801F27EFB5F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbjKQW15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjKQW14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:27:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A7CD51
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700260071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AiZjKSvYvhsu7/NaT39ijvKLN1v9uLeQ5qahPEsXOuA=;
        b=ZnCQf9k4zl/e/3iE77Lbp7oWlxMuRaBMNi8/RIPyEwGmgFOWuj1Fe/MPG4TZSU4HcOejbo
        7mrDNKzfNcMC+rBEfuMOBuZLcLMZTnVmNXnGrl7bVOpXMpG0/F092h5YMECmPbyGXKuu6j
        2yZMA/rjcSibka8Z7WQttknMot6Q9wo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-k8iAqpTYMmSsT0zeP3U6Ig-1; Fri, 17 Nov 2023 17:27:50 -0500
X-MC-Unique: k8iAqpTYMmSsT0zeP3U6Ig-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41cb577d45aso26401221cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700260069; x=1700864869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiZjKSvYvhsu7/NaT39ijvKLN1v9uLeQ5qahPEsXOuA=;
        b=FtUzXyymH61KodPLZ++K7Wn/YDou7TLBEoaq7nZ0sze+s6FkFYwbv7u4c2bbfshkzA
         F1O1OK1DUSZ4RnnX+LIOZEkWZKV+k9pj9Ntl8K4c4Izmo1AVoknc2iS+O9VSdCnKbDvz
         ByowG9hGblAmWKMhovdbWaZkT6jbcJ4/+iHpkA1G7I90DDbgGajsMMhv/Oq+T5vTTo0u
         dvYY8wXgZ0vM0ezyZJJyga7e2p6kbFTjlU2TGObhxPk4W5w0yKCS2i0spDzc6lnnehIX
         HURUyF4m3JgHrmBmRfF/qo9dftmT24AnTEO6cjOviVznfToF0TOIosPCrBvV2G89jyIJ
         VYkA==
X-Gm-Message-State: AOJu0YxoOMGL/LVKddQBxV0bsd/TGh+HdBpxu1KTAU3jCDdWMnQReW4o
        jtAZ//w8fE5J0Un3nYZegEFY38OXWUfyacpikAL6w08UKBiBWIEl+V/2PDXk+D6i2ojL4D36jRw
        tQgGub5+BCofwKFqrDvMXzTaO
X-Received: by 2002:a05:622a:489:b0:418:134f:17f4 with SMTP id p9-20020a05622a048900b00418134f17f4mr1220627qtx.22.1700260069483;
        Fri, 17 Nov 2023 14:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3FkLYOtTnQ+GMh7ZthjKHMc/IDRfHJKSpZF/RA1Mg2kREUnam2d8pU1JSK/6NXHglK6YeCg==
X-Received: by 2002:a05:622a:489:b0:418:134f:17f4 with SMTP id p9-20020a05622a048900b00418134f17f4mr1220612qtx.22.1700260069175;
        Fri, 17 Nov 2023 14:27:49 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id i2-20020ac84882000000b004166905aa2asm881752qtq.28.2023.11.17.14.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 14:27:48 -0800 (PST)
Date:   Fri, 17 Nov 2023 15:27:46 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     yaozhenguo <yaozhenguo1@gmail.com>
Cc:     yaozhenguo@jd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Wenchao Yao <yaowenchao@jd.com>,
        ZiHan Zhou <zhouzihan30@jd.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V1] vfio: add attach_group_by_node to control behavior
 of attaching group to domain
Message-ID: <20231117152746.3aa55d68.alex.williamson@redhat.com>
In-Reply-To: <20231115020209.4665-1-yaozhenguo@jd.com>
References: <20231115020209.4665-1-yaozhenguo@jd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 10:02:09 +0800
yaozhenguo <yaozhenguo1@gmail.com> wrote:

> From: Zhenguo Yao <yaozhenguo1@gmail.com>
>=20
> Groups will attach to one iommu_domain if ops and enforce_cache_coherency
> are equal. And all the iommu hardware share one pagetable by default.
> There are performance issue in some scenarios. For example:
> Host hardware topopy:
>=20
> node0 + PCIe RP0 ---+ GPU A100
>       |         |---+ GPU A100
>       |	        |---+ NIC Mellanox CX6
>       |	        |---+ NIC Mellanox CX6
>       + PCIe RP1 ---+ GPU A100
>                 |---+ GPU A100
>       	        |---+ NIC Mellanox CX6
>                 |---+ NIC Mellanox CX6
> node1 + PCIe RP0 ---+ GPU A100
>       |         |---+ GPU A100
>       |	        |---+ NIC Mellanox CX6
>       |	        |---+ NIC Mellanox CX6
>       + PCIe RP1 ---+ GPU A100
>                 |---+ GPU A100
>       	        |---+ NIC Mellanox CX6
>                 |---+ NIC Mellanox CX6
>=20
> We passthrough all NICs and GPU to VM, and emulate host hardware topopy.
> Mellanox CX6 ATS feature is enabled, GPU direct RDMA enabled.
> We test NCCL allreduce in VM at different cases.
>=20
> Case1: allreduce test use 4nic and 4GPU in numa0.
> Case2=EF=BC=9Aallreduce test use 4nic and 4GPU in numa1.
> case3: allreduce test use 8nic and 8GPU.
>=20
> the result are below:
>=20
> |        | algbw (GB/S) |
> | ------ | -------------|
> | case1  | 24           |
> | case2  | 32           |
> | case3  | 45           |
>=20
> We checked that IOMMU pagetable is allocated in numa1 when VM boot up.
> So, if IOTLB miss happan, IOMMU hardware in numa0 will access remote
> pagetable in numa1. This will drop performance. After apply this patch and
> attach_group_by_node is 1. Group in same node will attach to one domain.
> IOMMU will access there local pagetable. Performance is improved:
>=20
> |        | algbw (GB/S) |
> | ------ | -------------|
> | case1  | 32           |
> | case2  | 32           |
> | case3  | 63           |
>=20
> Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>
> Co-developed-by: Wenchao Yao <yaowenchao@jd.com>
> Signed-off-by: Wenchao Yao <yaowenchao@jd.com>
> Co-developed-by: ZiHan Zhou <zhouzihan30@jd.com>
> Signed-off-by: ZiHan Zhou <zhouzihan30@jd.com>
> ---
>  drivers/iommu/intel/iommu.c     |  8 +++++++-
>  drivers/vfio/vfio_iommu_type1.c | 33 +++++++++++++++++++++------------
>  include/linux/iommu.h           |  1 +
>  3 files changed, 29 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 3531b95..2c6d8f0 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -569,8 +569,10 @@ void domain_update_iommu_cap(struct dmar_domain *dom=
ain)
>  	 * If RHSA is missing, we should default to the device numa domain
>  	 * as fall back.
>  	 */
> -	if (domain->nid =3D=3D NUMA_NO_NODE)
> +	if (domain->nid =3D=3D NUMA_NO_NODE) {
>  		domain->nid =3D domain_update_device_node(domain);
> +		domain->domain.nid =3D domain->nid;
> +	}
> =20
>  	/*
>  	 * First-level translation restricts the input-address to a
> @@ -1767,6 +1769,7 @@ static struct dmar_domain *alloc_domain(unsigned in=
t type)
>  		return NULL;
> =20
>  	domain->nid =3D NUMA_NO_NODE;
> +	domain->domain.nid =3D NUMA_NO_NODE;
>  	if (first_level_by_default(type))
>  		domain->use_first_level =3D true;
>  	domain->has_iotlb_device =3D false;
> @@ -1808,6 +1811,8 @@ int domain_attach_iommu(struct dmar_domain *domain,=
 struct intel_iommu *iommu)
>  	info->refcnt	=3D 1;
>  	info->did	=3D num;
>  	info->iommu	=3D iommu;
> +	domain->nid     =3D iommu->node;
> +	domain->domain.nid     =3D iommu->node;
>  	curr =3D xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
>  			  NULL, info, GFP_ATOMIC);
>  	if (curr) {
> @@ -1837,6 +1842,7 @@ void domain_detach_iommu(struct dmar_domain *domain=
, struct intel_iommu *iommu)
>  		clear_bit(info->did, iommu->domain_ids);
>  		xa_erase(&domain->iommu_array, iommu->seq_id);
>  		domain->nid =3D NUMA_NO_NODE;
> +		domain->domain.nid =3D NUMA_NO_NODE;
>  		domain_update_iommu_cap(domain);
>  		kfree(info);
>  	}
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_ty=
pe1.c
> index eacd6ec..6a5641e 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -59,6 +59,11 @@
>  module_param_named(dma_entry_limit, dma_entry_limit, uint, 0644);
>  MODULE_PARM_DESC(dma_entry_limit,
>  		 "Maximum number of user DMA mappings per container (65535).");
> +static uint attach_group_by_node;
> +module_param_named(attach_group_by_node,
> +		attach_group_by_node, uint, 0644);
> +MODULE_PARM_DESC(attach_group_by_node,
> +		 "Attach group to domain when it's in same node");
> =20
>  struct vfio_iommu {
>  	struct list_head	domain_list;
> @@ -2287,19 +2292,23 @@ static int vfio_iommu_type1_attach_group(void *io=
mmu_data,
>  		if (d->domain->ops =3D=3D domain->domain->ops &&
>  		    d->enforce_cache_coherency =3D=3D
>  			    domain->enforce_cache_coherency) {
> -			iommu_detach_group(domain->domain, group->iommu_group);
> -			if (!iommu_attach_group(d->domain,
> -						group->iommu_group)) {
> -				list_add(&group->next, &d->group_list);
> -				iommu_domain_free(domain->domain);
> -				kfree(domain);
> -				goto done;
> -			}
> +			if ((attach_group_by_node =3D=3D 1 &&
> +				d->domain->nid =3D=3D domain->domain->nid) ||
> +				attach_group_by_node =3D=3D 0) {
> +				iommu_detach_group(domain->domain, group->iommu_group);
> +				if (!iommu_attach_group(d->domain,
> +							group->iommu_group)) {
> +					list_add(&group->next, &d->group_list);
> +					iommu_domain_free(domain->domain);
> +					kfree(domain);
> +					goto done;
> +				}
> =20
> -			ret =3D iommu_attach_group(domain->domain,
> -						 group->iommu_group);
> -			if (ret)
> -				goto out_domain;
> +				ret =3D iommu_attach_group(domain->domain,
> +						group->iommu_group);
> +				if (ret)
> +					goto out_domain;
> +			}
>  		}
>  	}
> =20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ec289c1..c1330ed 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -123,6 +123,7 @@ struct iommu_domain {
>  			int users;
>  		};
>  	};
> +	int nid;
>  };
> =20
>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)

As I understand what's being done here, we're duplicating
dmar_domain.nid to iommu_domain.nid, then when enabled by this new
module option, we'll use this node id as part of the match to determine
whether to create a new domain within the same container context or
re-use an existing domain, which may have non-favorably locality.

If we're going to implement a node id on the iommu_domain, it should
replace the existing use of node id in the device specific structure
and not simply duplicate it.  This should also account for non-VT-d use
cases as well, for example AMD IOMMU also has a nid field on their
protection_domain structure.  Alternatively this might be implemented
through iommu_domain_ops so we could query the node association for a
domain.

I question whether we need this solution at all though.  AIUI the
initial domain is allocated in proximity to the initial group.  The
problem comes when the user asks to add an additional group into the
same container.  Another valid solution would be that the user
recognizes that these groups are not within the same locality and
creates a separate container for this group.  In fact, if we're using
QEMU here and created a q35 VM with vIOMMU, each device would have a
separate address space and therefore a separate container and we'd
already avoid the issue this patch tries to solve.

Separate containers per QEMU AddressSpace are a requirement, but QEMU
might also implement a policy to not re-use vfio containers between
virtual nodes such that if each locality were mapped to separate PXBs
with unique proximities, then simply reflecting the physical locality
into the VM would be sufficient to avoid this non-optimal domain
allocation placement.

In any case, the type1 vfio IOMMU backend is in the early stages of
deprecation, so any choices we make here would also need to be reflected
in IOMMUFD, both in the compatibility and native interfaces.  Thanks,

Alex

