Return-Path: <linux-kernel+bounces-75088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0B485E2E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEFD1C24022
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125CA8174E;
	Wed, 21 Feb 2024 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GTINw7Om"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271C7FBC4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532246; cv=none; b=uiMgPDkJKpfukfPaPUKHpzqjwSmInhM64Mq8mzDoaRF2PtXfGIxmuGOzQ42JLkBT/ystXTLyoyQdrVFWQUUf/0lSeSyvnkTvf2+hrkf1VoXrQ2TSz0IYNKUORX9QZ7Kph4dykb9MKFGS+nkiRfpQKUETRzNTa8oyZCT9IAqkWLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532246; c=relaxed/simple;
	bh=I1meVWt4Ajaq/+XCxI26UXI001r+bq752Odfv/pfMpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FiA1phUndXJzX/fYGoBKhd07wDLJcp58GE9ZN2GKdbQYOjlqCTSdUb3UpRjLX916dAkYP1G4rPnaUylHcWCFjqriIE3cINGTu2EKCPqvrY1a/fS1ve/Nsfs1XeAS4SKADG8gVlBYZB4b6IHEJWnKshK22oCfe0oj8WPGJS6CiRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GTINw7Om; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d208d0b282so90920131fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708532242; x=1709137042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QSRdTUORIP3JPrt7kN1tEQGw0K12XfL4OvvkueI/BL4=;
        b=GTINw7OmqIGsB35R7I/sOJ2od4Fz2fBVIFwBK7Cryxnb3Vif5kGf1ZK8L9mxplc/9z
         deMCXeTGc13f8V12vPE9gSSlTz/Z2o2wnNLAmJ+IRL7UNbj2QLN0h2J6Z66UIdNRhYPY
         Ib2Kr7aksnif6NH2yr5LLw1Rqr39pQBxbac35+1pVzHKrOYVlRddanWcDABCz4Qw1hNg
         LTs9Crg3GNUrf8647/1ioplMyyPNDkxYcHT7xuk0WmDxAN5IXcKD7SeBhvywOEN0lkfz
         E9Q2wKYhgGdXz6+fcboe2AlLCHhNRXHTqicua+bFANYo9E7gSsDLIIfZggStoirfnL0C
         6DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708532242; x=1709137042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSRdTUORIP3JPrt7kN1tEQGw0K12XfL4OvvkueI/BL4=;
        b=uUV+6wm8+sjVPtX280GwXJtDuhjL+5Bqmb1pMG7o60uYeXwiA2KlDvIkI34qJRn2x5
         2euG7x8mUM4vtfNFX2i7a0lebmokVYlYuyYDEgXO4TTbltdJGmEJ2bYouqRmU+YriMcX
         n6Wqb7j/IU58Srzf79gdNaqN39rhH8D9B10OuFvIwGsan7YrVzv66JDL9vXUaOZsG7Xt
         z6MUxitESy3dciNG0Q8CETLBcCuCxhfdUeYX/G7839Ojvc/i9sE+GBeg5JkgFQ1ajGSy
         e6LLYpcH8hBhX2hR6TXPj5/wFlddiztwaE90ANmO3y00Juffm0Atnp39sbVCT5+dIvPA
         WBYg==
X-Forwarded-Encrypted: i=1; AJvYcCU9xF6Dp8eg/eeA/FoIpJRgfn03qw9U6Wrn303ggaBc/1j+gn9Ul81+wcOUO0tjjNl++bijET2M1yBeq+7KnZEjwvkAXZrpEi53ibsi
X-Gm-Message-State: AOJu0Yxn4n3lfTboZlr7U4ngr+1CAd9EcWF4woZeNSlzfh58O0GD4ejO
	HVmUMuRHy49OclYf0/XBKzhWobEbX6KqAcYFi2sjbychNr55P7IHPAMeru+sMDlAFSKK7Y0Tzeh
	bwz4VGMbgPltT6sVVkIIHlTH7CAlN1NUTYbnonztekyS4y7NbN+bwvjmZO2E=
X-Google-Smtp-Source: AGHT+IEAPcKs9cACBOi8r1qIxX65sNThq1I+8at14ElsSzJt2HeQxDAK+upl9KCdTVvkGPrjF+VdX67GjanquSArscg=
X-Received: by 2002:a2e:9f44:0:b0:2d2:2e1d:651b with SMTP id
 v4-20020a2e9f44000000b002d22e1d651bmr7799978ljk.29.1708532242159; Wed, 21 Feb
 2024 08:17:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221110658.529-1-zhangfei.gao@linaro.org> <20240221131725.GR13330@nvidia.com>
In-Reply-To: <20240221131725.GR13330@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 22 Feb 2024 00:17:10 +0800
Message-ID: <CABQgh9Ha6C=Ej7Z2Md3v5Q6iXPKHsz+yQ2G_-oOaotVuVi8Hmg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: Fix iommu_sva_bind_device to the same domain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	jean-philippe <jean-philippe@linaro.org>, baolu.lu@linux.intel.com, 
	"Zhang, Tina" <tina.zhang@intel.com>, kevin.tian@intel.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 21:17, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Feb 21, 2024 at 11:06:58AM +0000, Zhangfei Gao wrote:
> > The accelerator device can provide multi-queue and bind to
> > the same domain in multi-thread for better performance,
> > and domain refcount takes care of it.
> >
> > 'commit 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> > removes the possibility, so fix it
> >
> > Fixs: '092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > ---
> > v2: Instead of checking ret == -EBUSY,
> >     change iommu_attach_device_pasid return value from -EBUSY to 0
> >     when pasid entry is found, and refcount++ when return
> >
> >  drivers/iommu/iommu-sva.c | 2 +-
> >  drivers/iommu/iommu.c     | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index c3fc9201d0be..20b232c7675d 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -141,8 +141,8 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
> >       struct device *dev = handle->dev;
> >
> >       mutex_lock(&iommu_sva_lock);
> > -     iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
> >       if (--domain->users == 0) {
> > +             iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
> >               list_del(&domain->next);
> >               iommu_domain_free(domain);
> >       }
>
> The users refcount is not to provide for sharing of the same PASID it
> is to provide for sharing the domain across devices. This change would
> break that because we loose the 'dev' that needs to be detached in a
> multi-device case if we don't immediately call detach_device_pasid
> here.
>
> You'd need to build something much more complicated here to allow
> PASID sharing.
>
> I wonder if this case is common enough to warrant the core code to get
> involved. I suppose maybe, does idxd have the same problem? It can
> only open it's cdev once because of this - that doesn't seem like what
> the code intends for a non-wq_dedicated?
>
> More like this:

Hi, Jason

Only added two lines change, and tested ok.
The different with before is same handle is returned, and the handle
itself has refcount.
While before different handle is returned,
Not think about any issue now, I think it is OK.

Could you send the patch, will add tested-by then.

>
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index c3fc9201d0be97..aec11e5cde6b0e 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -41,6 +41,7 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
>         }
>         iommu_mm->pasid = pasid;
>         INIT_LIST_HEAD(&iommu_mm->sva_domains);
> +       INIT_LIST_HEAD(&iommu_mm->sva_handles);
>         /*
>          * Make sure the write to mm->iommu_mm is not reordered in front of
>          * initialization to iommu_mm fields. If it does, readers may see a
> @@ -82,6 +83,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>                 goto out_unlock;
>         }
>
> +       list_for_each_entry(handle, &mm->iommu_mm->sva_handles, handle_item) {
> +               if (handle->dev == dev && handle->domain->mm == mm) {
> +                       refcount_inc(&handle->users);

mutex_unlock(&iommu_sva_lock);


> +                       return handle;
> +               }
> +       }
> +
>         handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>         if (!handle) {
>                 ret = -ENOMEM;
> @@ -109,6 +117,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>                 goto out_free_domain;
>         domain->users = 1;

 refcount_set(&handle->users, 1);


>         list_add(&domain->next, &mm->iommu_mm->sva_domains);
> +       list_add(&handle->handle_item, &mm->iommu_mm->sva_handles);
>
>  out:
>         mutex_unlock(&iommu_sva_lock);
> @@ -141,6 +150,12 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>         struct device *dev = handle->dev;
>
>         mutex_lock(&iommu_sva_lock);
> +       if (!refcount_dec_and_test(&handle->users)) {
> +               mutex_unlock(&iommu_sva_lock);
> +               return;
> +       }
> +       list_del(&handle->handle_item);
> +
>         iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>         if (--domain->users == 0) {
>                 list_del(&domain->next);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 1ea2a820e1eb03..5e27cb3a3be99b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -892,11 +892,14 @@ struct iommu_fwspec {
>  struct iommu_sva {
>         struct device                   *dev;
>         struct iommu_domain             *domain;
> +       struct list_head                handle_item;
> +       refcount_t                      users;
>  };
>
>  struct iommu_mm_data {
>         u32                     pasid;
>         struct list_head        sva_domains;
> +       struct list_head        sva_handles;
>  };
>
>  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,

Thanks

