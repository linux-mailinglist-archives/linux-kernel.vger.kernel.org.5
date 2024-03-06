Return-Path: <linux-kernel+bounces-94142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14404873A7E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3749F1C20FC6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C457134CEF;
	Wed,  6 Mar 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIVDD9i0"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BEE134CE3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738166; cv=none; b=rzBtgSzH5JEDmKvM5IMh2ggtqnsejlxhBLuL0yo0XPCrC6nrJm3MG7wkKifc2sa+7ijFyfULTcFiHbbFHHYOHNib36R3M6438aFWzLnovNJ6lJeuVAsBcf0Pb6P2TnGTSHL/HQximPYxayQ815pn+Q5Uia9ArAChPoa9KlF3ww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738166; c=relaxed/simple;
	bh=kZ8mXvtpel/ZYEPSkuZBEYdU1hA22wv0YjD3idEA/+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQl+pPzUKdi4LzV22W1ZZTAAdo0fLJ8bbtsL69iA5TGn8ONJn4zw0Xt8Y/QPI21zrwxxU8eFe3doqArvCLn0b2BKDdtuyLMUF5giFK4cFBNHrpleBqnTH+uOHRYKsL4rzdRQEDTTU9qKn5une20f+N1AaSHo0XTLHhdWDuGOcb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LIVDD9i0; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d3f962a9dfso19272051fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709738162; x=1710342962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1tzJ9zCUXkaV13wzjAuc8h9G1xtp7/nN8arE8U8gfY8=;
        b=LIVDD9i0BTYdyriqzV840QIbaaOnhv0UNw14domnB1x48TxdGvd5PzT8Xvw1eteeOH
         Bj0SRaPtZp4n/T1Zq+q8+57D91fBduVTZfmsSs8pNNrVOTMDeoLQsY/8H4Yqm2Yvoi6j
         IktO69wU/gR1effTTjQ/0DyVVGascjOU0vObpLNxplPEQUVeNWL+KjMZDKcWI1iUfAye
         /7V3TCMAsq46dy4WkFiRUduXp9S8rHWKrEKrvGX76ru7POZlAbWEgEFFzXuJ8UgO1orn
         xyc9O9cdbpHzXI/BckGiBG58/Jtkh4vviA0iher12T7J/JDgY/oPNmUeQXjGE3llUitV
         V8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709738162; x=1710342962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tzJ9zCUXkaV13wzjAuc8h9G1xtp7/nN8arE8U8gfY8=;
        b=MhxUSxdN5d4ME3KbQRNrXszQZ08jl/h7fx583V3Ch3J2qW7siESS2AvtabZKIBYKaH
         y9jqms00BHI4McfoH4D2KVSdBARlkYSxx+cJxwq8VQmxZzSftzU06nFz/4/uW9j3pfdX
         QsyosCXt9ojKnQVrZI/Qb45CSl47tzNUZIxyclLeUkVPIuBH12jGzDTXbELYAKlff2e7
         jh+W+9PC0U81F9Tz8DDIkF1RsC+S1qGIJhxLMQo24fnhQ1IeDmxGoHdyygT4CGtCU8iZ
         xq+BYZ38lBvtJUndcxWuPTFbVjXQxObaFI4shfPhA4p8RPWvjiYrTK6cx3uVPk8YoXPF
         vGqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0fH94kJRhPKNPpIlb4eLaWrts2GTUpwbcmvAPP01AKajXd23sCOdhiLIRFjLYjifnIO48AIjdu/PyiRJA/+KNq+wiO9dk3V0y7jVF
X-Gm-Message-State: AOJu0YxWVhuNv0bKU3LfMDquvuhd5Q2niOFRmMBTPYwCo7sjjTtV0n8s
	xM3+EwqdFPWFUJ1j2SmgcqTZXNeWDXFp+H8hbjh852jMpcDUiaMN/Q8zjyQWiADa/UBf1mkQtEP
	gnsRl0jWP/zU+Po4cEmX4+YZS7nqVOlIRf4OV0g==
X-Google-Smtp-Source: AGHT+IHmRpEcbVPzqLhnsNtyibyzMhmgr/03XxNzNXgO7mCxUIf62cD2x5AhOtv+FfAHACFNwN5t6nlDOMlQ2JOOkcE=
X-Received: by 2002:a2e:9796:0:b0:2d2:2b2e:1680 with SMTP id
 y22-20020a2e9796000000b002d22b2e1680mr3445457lji.35.1709738162161; Wed, 06
 Mar 2024 07:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com> <CABQgh9FwOVsFe3+5VG0_rDruJVW0ueHTcsnxUcVAvFqrF4Vz6Q@mail.gmail.com>
In-Reply-To: <CABQgh9FwOVsFe3+5VG0_rDruJVW0ueHTcsnxUcVAvFqrF4Vz6Q@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 6 Mar 2024 23:15:50 +0800
Message-ID: <CABQgh9G5yFZ_p+tfvnJqOQo+Be62rMDatsEX1rhD_oTiXDaw5w@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with iommufd_hw_pgtable
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Baolu

On Sat, 2 Mar 2024 at 10:36, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> On Mon, 22 Jan 2024 at 15:46, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >
> > When allocating a user iommufd_hw_pagetable, the user space is allowed to
> > associate a fault object with the hw_pagetable by specifying the fault
> > object ID in the page table allocation data and setting the
> > IOMMU_HWPT_FAULT_ID_VALID flag bit.
> >
> > On a successful return of hwpt allocation, the user can retrieve and
> > respond to page faults by reading and writing the file interface of the
> > fault object.
> >
> > Once a fault object has been associated with a hwpt, the hwpt is
> > iopf-capable, indicated by fault_capable set to true. Attaching,
> > detaching, or replacing an iopf-capable hwpt to an RID or PASID will
> > differ from those that are not iopf-capable. The implementation of these
> > will be introduced in the next patch.
> >
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  drivers/iommu/iommufd/iommufd_private.h | 11 ++++++++
> >  include/uapi/linux/iommufd.h            |  6 +++++
> >  drivers/iommu/iommufd/fault.c           | 14 ++++++++++
> >  drivers/iommu/iommufd/hw_pagetable.c    | 36 +++++++++++++++++++------
> >  4 files changed, 59 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> > index 52d83e888bd0..2780bed0c6b1 100644
> > --- a/drivers/iommu/iommufd/iommufd_private.h
> > +++ b/drivers/iommu/iommufd/iommufd_private.h
> > @@ -293,6 +293,8 @@ int iommufd_check_iova_range(struct io_pagetable *iopt,
> >  struct iommufd_hw_pagetable {
> >         struct iommufd_object obj;
> >         struct iommu_domain *domain;
> > +       struct iommufd_fault *fault;
> > +       bool fault_capable : 1;
> >  };
> >
> >  struct iommufd_hwpt_paging {
> > @@ -446,8 +448,17 @@ struct iommufd_fault {
> >         struct wait_queue_head wait_queue;
> >  };
> >
> > +static inline struct iommufd_fault *
> > +iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
> > +{
> > +       return container_of(iommufd_get_object(ucmd->ictx, id,
> > +                                              IOMMUFD_OBJ_FAULT),
> > +                           struct iommufd_fault, obj);
> > +}
> > +
> >  int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
> >  void iommufd_fault_destroy(struct iommufd_object *obj);
> > +int iommufd_fault_iopf_handler(struct iopf_group *group);
> >
> >  #ifdef CONFIG_IOMMUFD_TEST
> >  int iommufd_test(struct iommufd_ucmd *ucmd);
> > diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> > index c32d62b02306..7481cdd57027 100644
> > --- a/include/uapi/linux/iommufd.h
> > +++ b/include/uapi/linux/iommufd.h
> > @@ -357,10 +357,13 @@ struct iommu_vfio_ioas {
> >   *                                the parent HWPT in a nesting configuration.
> >   * @IOMMU_HWPT_ALLOC_DIRTY_TRACKING: Dirty tracking support for device IOMMU is
> >   *                                   enforced on device attachment
> > + * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
> > + *                             valid.
> >   */
> >  enum iommufd_hwpt_alloc_flags {
> >         IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
> >         IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
> > +       IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
> >  };
> >
> >  /**
> > @@ -411,6 +414,8 @@ enum iommu_hwpt_data_type {
> >   * @__reserved: Must be 0
> >   * @data_type: One of enum iommu_hwpt_data_type
> >   * @data_len: Length of the type specific data
> > + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
> > + *            IOMMU_HWPT_FAULT_ID_VALID is set.
> >   * @data_uptr: User pointer to the type specific data
> >   *
> >   * Explicitly allocate a hardware page table object. This is the same object
> > @@ -441,6 +446,7 @@ struct iommu_hwpt_alloc {
> >         __u32 __reserved;
> >         __u32 data_type;
> >         __u32 data_len;
> > +       __u32 fault_id;
> >         __aligned_u64 data_uptr;
> >  };
> >  #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
> > diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> > index 9844a85feeb2..e752d1c49dde 100644
> > --- a/drivers/iommu/iommufd/fault.c
> > +++ b/drivers/iommu/iommufd/fault.c
> > @@ -253,3 +253,17 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
> >
> >         return rc;
> >  }
> > +
> > +int iommufd_fault_iopf_handler(struct iopf_group *group)
> > +{
> > +       struct iommufd_hw_pagetable *hwpt = group->cookie->domain->fault_data;
> > +       struct iommufd_fault *fault = hwpt->fault;
> > +
> > +       mutex_lock(&fault->mutex);
> > +       list_add_tail(&group->node, &fault->deliver);
> > +       mutex_unlock(&fault->mutex);
> > +
> > +       wake_up_interruptible(&fault->wait_queue);
> > +
> > +       return 0;
> > +}
> > diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> > index 3f3f1fa1a0a9..2703d5aea4f5 100644
> > --- a/drivers/iommu/iommufd/hw_pagetable.c
> > +++ b/drivers/iommu/iommufd/hw_pagetable.c
> > @@ -8,6 +8,15 @@
> >  #include "../iommu-priv.h"
> >  #include "iommufd_private.h"
> >
> > +static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
> > +{
> > +       if (hwpt->domain)
> > +               iommu_domain_free(hwpt->domain);
> > +
> > +       if (hwpt->fault)
> > +               iommufd_put_object(hwpt->fault->ictx, &hwpt->fault->obj);
> > +}
> > +
> >  void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
> >  {
> >         struct iommufd_hwpt_paging *hwpt_paging =
> > @@ -22,9 +31,7 @@ void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
> >                                          hwpt_paging->common.domain);
> >         }
> >
> > -       if (hwpt_paging->common.domain)
> > -               iommu_domain_free(hwpt_paging->common.domain);
> > -
> > +       __iommufd_hwpt_destroy(&hwpt_paging->common);
> >         refcount_dec(&hwpt_paging->ioas->obj.users);
> >  }
> >
> > @@ -49,9 +56,7 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
> >         struct iommufd_hwpt_nested *hwpt_nested =
> >                 container_of(obj, struct iommufd_hwpt_nested, common.obj);
> >
> > -       if (hwpt_nested->common.domain)
> > -               iommu_domain_free(hwpt_nested->common.domain);
> > -
> > +       __iommufd_hwpt_destroy(&hwpt_nested->common);
> >         refcount_dec(&hwpt_nested->parent->common.obj.users);
> >  }
> >
> > @@ -213,7 +218,8 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
> >         struct iommufd_hw_pagetable *hwpt;
> >         int rc;
> >
> > -       if (flags || !user_data->len || !ops->domain_alloc_user)
> > +       if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
> > +           !user_data->len || !ops->domain_alloc_user)
> >                 return ERR_PTR(-EOPNOTSUPP);
> >         if (parent->auto_domain || !parent->nest_parent)
> >                 return ERR_PTR(-EINVAL);
> > @@ -227,7 +233,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
> >         refcount_inc(&parent->common.obj.users);
> >         hwpt_nested->parent = parent;
> >
> > -       hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
> > +       hwpt->domain = ops->domain_alloc_user(idev->dev, 0,
> >                                               parent->common.domain, user_data);
>
> Why remove flags? typo or any reason?
> arm_smmu_domain_alloc_user  can not get flags from the user app.
> User should set IOMMU_HWPT_FAULT_ID_VALID, right?
>

Double checked, this does not send flags, 0 is OK,
Only domain_alloc_user in iommufd_hwpt_paging_alloc requires flags.

In my debug, I need this patch, otherwise NULL pointer errors happen
since SVA is not set.

Subject: [PATCH] iommufd: enable/disable IOMMU_DEV_FEAT_SVA when
 iopf_enable/disable

When iopf_enable, IOMMU_DEV_FEAT_SVA has to be enabled as well,
which will call iopf_queue_add_device(master->smmu->evtq.iopf, dev).
Otherwise NULL pointer will happen since fault_param is NULL.

And disable IOMMU_DEV_FEAT_SVA in iopf_disable accordingly.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/iommufd/fault.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index a4a49f3cd4c2..89837d83e757 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -289,6 +289,12 @@ static int iommufd_fault_iopf_enable(struct
iommufd_device *idev)
        if (ret)
                return ret;

+       ret = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_SVA);
+       if (ret) {
+               iommu_dev_disable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
+               return ret;
+       }
+
        idev->iopf_enabled = true;

        return 0;
@@ -299,6 +305,7 @@ static void iommufd_fault_iopf_disable(struct
iommufd_device *idev)
        if (!idev->iopf_enabled)
                return;

+       iommu_dev_disable_feature(idev->dev, IOMMU_DEV_FEAT_SVA);
        iommu_dev_disable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
        idev->iopf_enabled = false;
 }


And iommufd_fault_domain_replace_dev
        if (iopf_enabled_originally && !hwpt->fault_capable)
                iommufd_fault_iopf_disable(idev);
will cause iopf enable/ disable / enable, is this required, a bit confused.

Thanks

