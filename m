Return-Path: <linux-kernel+bounces-74276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ADF85D1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72EEE1C23B29
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0B33B79F;
	Wed, 21 Feb 2024 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mp3bG2mi"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E113B1B7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502532; cv=none; b=P+c4p3uNrnWs6BgOmMlOX3NF3RNZ3jEvMCKA2sXepj/C/9/miytNd9vBaX8rhsjjBTw258w01rNkiDejaz0FMmq78+8XPAFb2amDhRzI3Uds1ijUNRnCnngPncrmFR0i3486SXEq4Bus86NRxks7GpqNHmmrG2IzY603c7dYnNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502532; c=relaxed/simple;
	bh=lsFXu1CbLS/JAcC8IGbcv6Okc/fTRfgi94LrWHJOr/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1/VW2Uqx6P3nbadchF5Xb6RzM284C/hwtFMVY+ZOALSiXTKCAZp8Ku6dgl3kvlq5D6yKsTzxMmrMp69W9wiTO3Tl2Dwxr4Dk85NEvUIEzNO5c3dc8J+/tOGbMcszIXC1wbg6i5N7An5rF890hSrrZKelL32YmfVT7k42YbZAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mp3bG2mi; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso3948541fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708502528; x=1709107328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g1l8Q97+iETt6GAieAaoa+B3bZHXWxI3blTfH192x0c=;
        b=mp3bG2mifW4dfvUm3QzRxbA+9mpBTvOa9M0kJyJxBOJMfGkSTSYeoTH99gXqQfcmBm
         vd2OidnOK0HYxIgaJWFg+23/SxW7ZWk7RiYVMLvKSZsYo9kWxiTXMMofADG8kJG/cT1D
         j8EeSu19EoaHnFVLDmCXHfQ5MPwlb+Wpo2EoqcR72bRIoc1yYqWzg2bZHCG5IkWrlbir
         GEJOoW7SwUKU/86H7MDNHSwgcOEgYLngRfLgmyvJEbdq+zWoxnZ/w9h+QEU7TogSapbF
         glWykjQXl7EcsJyR+gv/PCcS9Js2yPxOvCe0yC/gLsuwG/Mihgy8Va+/DB23ef3oK61m
         HD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708502528; x=1709107328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1l8Q97+iETt6GAieAaoa+B3bZHXWxI3blTfH192x0c=;
        b=E0CyccMMAduHmm9ObIfYsYz4KnnU5pBqPWYdjtmvAp3VdlpG93J1SnAhhEjBQIZO2A
         KGPtrdoHvKNn32ZOwC7jMSiozsk3Is8dcngP6C+G1lPEOR+PdVWbk5fhgPvbgxqB/4ss
         O1N6xF2YctMrDyP9S4w36yyvQYoAwotIMbgtTI0xoDHY7TneCGCMCzohOTVAaLhPYsur
         JZoFKSTdrJ7kqC7iZdzRLBlEsvOLoWUJVk4yKx/QlnmGqb7fbus04A1KlgD9ULQHscNP
         dx72WZIpGMCxNyGXKd/MpyCngAfvBow+LG1piBqOp1r86un55MiExqBPZ+3mwiJ0/aQf
         +x/w==
X-Forwarded-Encrypted: i=1; AJvYcCWLC7CkEULrgVTx+UjM0uEmuznyHiCzZSpU16JIf+HXK05HnRnYGxy41zYJ6YjVOCsENj4EnLwSKEFS3fJBl3e3c1TmGpnG5MF5XicU
X-Gm-Message-State: AOJu0Yz5N+IAyYLDon1nuKU0o6bRmetalNKwcNT8aEErTbq3r4g35dR4
	YlQ1+6AztIOLYZ5v/mitZ/HldEW9StsB3kRcMsjy/VGbEtEWX8Jb26LfCfQT4h0Q2aZH715/Ewa
	H55+6jWVzGKL9jH2ecpDXyWbW+lUpi6eXPK06EA==
X-Google-Smtp-Source: AGHT+IGn25MpS1uSHBlUApi7nJCMjufiaC7n14bIWphjESDL+OD9Zf+zi9o3mg+lr2hXljeXzlGYD1BPhQCRiV5XaJo=
X-Received: by 2002:a2e:8811:0:b0:2d2:4c8c:4d05 with SMTP id
 x17-20020a2e8811000000b002d24c8c4d05mr2273169ljh.11.1708502528299; Wed, 21
 Feb 2024 00:02:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-6-tina.zhang@intel.com> <CABQgh9GWcqUeBkHQCpj5tzu6FnEgpOp3KOQ6s9c0X0KU7Ov1qw@mail.gmail.com>
 <MW5PR11MB5881C5CC15452017867B412889502@MW5PR11MB5881.namprd11.prod.outlook.com>
 <CABQgh9GxQmGU2HR73bSoZLuf4XZFhThXwUs_HJx6KwxDmXrXgg@mail.gmail.com>
 <b05958ba-0c47-45ba-8159-372779f9cc8b@linux.intel.com> <CABQgh9FFpL=mEZ-7PqRRVg1eniYV176B7USbGP5MLPvhJaGo9A@mail.gmail.com>
 <MW5PR11MB5881B3EA808820BCBCFAF72589572@MW5PR11MB5881.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB5881B3EA808820BCBCFAF72589572@MW5PR11MB5881.namprd11.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 21 Feb 2024 16:01:56 +0800
Message-ID: <CABQgh9HPhp+LKz5pPnpN1bWXoU3C38k6swqhAqJj67xGJQUmwA@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva domains
To: "Zhang, Tina" <tina.zhang@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Michael Shavit <mshavit@google.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Hao Fang <fanghao11@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 15:41, Zhang, Tina <tina.zhang@intel.com> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Sent: Wednesday, February 21, 2024 10:45 AM
> > To: Baolu Lu <baolu.lu@linux.intel.com>
> > Cc: Zhang, Tina <tina.zhang@intel.com>; iommu@lists.linux.dev; linux-
> > kernel@vger.kernel.org; David Woodhouse <dwmw2@infradead.org>; Joerg
> > Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Robin Murphy
> > <robin.murphy@arm.com>; Jason Gunthorpe <jgg@ziepe.ca>; Tian, Kevin
> > <kevin.tian@intel.com>; Nicolin Chen <nicolinc@nvidia.com>; Michael Shavit
> > <mshavit@google.com>; Vasant Hegde <vasant.hegde@amd.com>; Jason
> > Gunthorpe <jgg@nvidia.com>; Jean-Philippe Brucker <jean-
> > philippe@linaro.org>; Hao Fang <fanghao11@huawei.com>
> > Subject: Re: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva
> > domains
> >
> > On Wed, 21 Feb 2024 at 10:06, Baolu Lu <baolu.lu@linux.intel.com> wrote:
> > >
> > > On 2024/2/21 9:28, Zhangfei Gao wrote:
> > > > On Wed, 21 Feb 2024 at 07:58, Zhang, Tina<tina.zhang@intel.com>
> > wrote:
> > > >
> > > >>>>   struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> > > >>>> struct mm_struct *mm)  {
> > > >>>> +       struct iommu_mm_data *iommu_mm;
> > > >>>>          struct iommu_domain *domain;
> > > >>>>          struct iommu_sva *handle;
> > > >>>>          int ret;
> > > >>>>
> > > >>>> +       mutex_lock(&iommu_sva_lock);
> > > >>>> +
> > > >>>>          /* Allocate mm->pasid if necessary. */
> > > >>>> -       ret = iommu_sva_alloc_pasid(mm, dev);
> > > >>>> -       if (ret)
> > > >>>> -               return ERR_PTR(ret);
> > > >>>> +       iommu_mm = iommu_alloc_mm_data(mm, dev);
> > > >>>> +       if (IS_ERR(iommu_mm)) {
> > > >>>> +               ret = PTR_ERR(iommu_mm);
> > > >>>> +               goto out_unlock;
> > > >>>> +       }
> > > >>>>
> > > >>>>          handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> > > >>>> -       if (!handle)
> > > >>>> -               return ERR_PTR(-ENOMEM);
> > > >>>> -
> > > >>>> -       mutex_lock(&iommu_sva_lock);
> > > >>>> -       /* Search for an existing domain. */
> > > >>>> -       domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
> > > >>>> -                                               IOMMU_DOMAIN_SVA);
> > > >>>> -       if (IS_ERR(domain)) {
> > > >>>> -               ret = PTR_ERR(domain);
> > > >>>> +       if (!handle) {
> > > >>>> +               ret = -ENOMEM;
> > > >>>>                  goto out_unlock;
> > > >>>>          }
> > > >>>>
> > > >>>> -       if (domain) {
> > > >>>> -               domain->users++;
> > > >>>> -               goto out;
> > > >>> Our multi bind test case broke since 6.8-rc1.
> > > >>> The test case can use same domain & pasid, return different
> > > >>> handle,
> > > >>> 6.7 simply  domain->users ++ and return.
> > > >>>
> > > >>>> +       /* Search for an existing domain. */
> > > >>>> +       list_for_each_entry(domain, &mm->iommu_mm->sva_domains,
> > > >>>> + next)
> > > >>> {
> > > >>>> +               ret = iommu_attach_device_pasid(domain, dev,
> > > >>>> + iommu_mm->pasid);
> > > >>> Now iommu_attach_device_pasid return BUSY since the same pasid.
> > > >>> And then iommu_sva_bind_device attach ret=-16
> > > >> Sounds like the test case tries to bind a device to a same mm multiple
> > times without unbinding the device and the expectation is that it can always
> > return a valid handle to pass the test. Right?
> > > > Yes
> > > >
> > > > The device can bind to the same mm multi-times and return different
> > > > handle, Since the refcount, no need to unbind and bind sequently,
> > > > The unbind can happen later with the handle.
> > >
> > > Is there any real use case to bind an mm to the pasid of a device
> > > multiple times? If there are cases, is it better to handle this in the
> > > uacce driver?
> >
> > Yes, it is required for multi-thread, the device can provide multi-queue to
> > speed up.
> >
> > >
> > >  From iommu core's perspective, it doesn't make sense to attach the
> > > same domain to the same device (or pasid) multiple times.
> >
> > But is it the refcount domain->user++ used for?
> > Is there any reason not doing this.
> The domain->user is a refcount of the devices (or iommu group) attached to the domain.  IOMMU core needs to keep this refcount to ensure that a sva domain will be released when no device uses it.

I think the limitation of one user only attach one domain one time
does not make sense.
Just like one file can only be opened one time by a user, then
refcount is meanless.

Thanks
>
> Regards,
> -Tina
>
> >
> > Thanks

