Return-Path: <linux-kernel+bounces-73906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ACD85CD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4090284E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EBA468F;
	Wed, 21 Feb 2024 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcN55P1L"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A5C17D5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478902; cv=none; b=IZ/EFeZyECBh8zRuqfot3DNIZKxPCZE7Pmb8v3wRgFbubyjN37zH9v0Dr0mVFTX2s7ZxHgSag+8Sfqhw764g6/3hAv1huyoVZbNrpEe4Oox+ikUDv6cIWrTsPKzhXM6dlrCe33ZApWur+ZuSTCindR5+iwMjdoFyDigPSCrbxmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478902; c=relaxed/simple;
	bh=miuWVSUfiT4bw6c4HADcYw+Oa2GyLFZkBZGaNA1iiHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cq3PYLwP0qverrstVK3QwJ9uQ4GoRY0cCEunfz6a7OXjdbWODOjIxqzbULdIXY2lTuD47LpTPzVUI1Bm6rhfMhEYI+Bv06aHjhfunFyeotynXf+3cntWMqpo/Z1t/F3fubzRg1Aq8w9K3RfFaQuhz1QCk9Dm6I87oyVHUjbWzSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tcN55P1L; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512be87a0f3so105307e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708478899; x=1709083699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nYNt1GrpQrtFfSNviDmfzHNLw/OwvxTSzUWQXin35bs=;
        b=tcN55P1LaNtXahXtvZKWe8w936K3Q5xNs5H4EYRpHAQxTwn55g0lvKgLa6C3QLX1k1
         7LflE8ytOamO5kfVyLe4P/sKAYsk5BfFUNPuVbksAE6kcXiSTTygqZTpypb3oLn3ZqGz
         8010hWfg+DSmMgj4whgfrlbsmXrjRUpK3mhaj5uqyAY0MR0dMy33eUoDsMinAJZf5C8e
         iZ90HSgM9rNlOVSjhBdqIC6Y/N5BZ8iwlLvEZc+mDDn6IvhStTROTxFwtz9SZJf4R2ps
         6RnS5uMzrlmsieuVbcOVEBTvzyS599rhcJIbYNBq1PgrNPqeiGgFvJ/l0mMjmY/9PRUY
         I3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708478899; x=1709083699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYNt1GrpQrtFfSNviDmfzHNLw/OwvxTSzUWQXin35bs=;
        b=OoJJHUR7ibkWcofKmKB7ZXEGtChZSq2j5lWAc4Jcf61fuy+D6XF8AsG6ypXWKtZRyU
         5m+VPheQSZBJf/bHYRyEeOmEdEF2QQtHH6Y2RtjS0zrBGmljBrGwPcHrDTNqinPc/u5+
         gD0EiXJ7IA/qDWj924ECC02KsXd6I6ObfDuz3ckBQ+l9IB0XrbsrKkoJuIB8RESLu80n
         9toGJNn844SEsf4ERnracl7l19WMFcJZU64HJKZXFGXIuil1I9fMn4L7XxmEccTyvqBL
         P6WHXtcPO3XnX5uK75af2rNgW5UO3S/hbKotLw4ve4K605mLFx76vfB7LA8Yv4Q28AQO
         d9KA==
X-Forwarded-Encrypted: i=1; AJvYcCXQgPEmZENIV+qWLmozpB7ykdrVaZ94VowaPtZqsUjHTQ6PbnZhFMyOAx6OFAG/clEuiX3A+iFTiEZCPXMj4hR/sjQ5tkJcH3z8UgxU
X-Gm-Message-State: AOJu0YwDfjBjLapr3srQJLJkmyTqUEifsy9zYZ3A5y9dQwr2flIhHbUs
	9BgvCGA8Nt99KHmQxbWvoTEi00XT9yWJ2k4da6MZoE3eydYDx83e0mZ6A+FPlEKLrejuy0raaGs
	NN+TMvS77FlY1Fpzp2rc9IKkMIRDR3GTwXh7JmA==
X-Google-Smtp-Source: AGHT+IG8/gJasXhBJ2zg0xGRCx11CYH9J/kNDUlx5W2Eb78PnwLX0tpjO++0WDuEDCY9bmuAJPyB5zfkGRNFRAFqE30=
X-Received: by 2002:a05:6512:3e6:b0:512:ba41:51f with SMTP id
 n6-20020a05651203e600b00512ba41051fmr3710314lfq.50.1708478899197; Tue, 20 Feb
 2024 17:28:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-6-tina.zhang@intel.com> <CABQgh9GWcqUeBkHQCpj5tzu6FnEgpOp3KOQ6s9c0X0KU7Ov1qw@mail.gmail.com>
 <MW5PR11MB5881C5CC15452017867B412889502@MW5PR11MB5881.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB5881C5CC15452017867B412889502@MW5PR11MB5881.namprd11.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 21 Feb 2024 09:28:07 +0800
Message-ID: <CABQgh9GxQmGU2HR73bSoZLuf4XZFhThXwUs_HJx6KwxDmXrXgg@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva domains
To: "Zhang, Tina" <tina.zhang@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Michael Shavit <mshavit@google.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Tina

On Wed, 21 Feb 2024 at 07:58, Zhang, Tina <tina.zhang@intel.com> wrote:

> > >  struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct
> > > mm_struct *mm)  {
> > > +       struct iommu_mm_data *iommu_mm;
> > >         struct iommu_domain *domain;
> > >         struct iommu_sva *handle;
> > >         int ret;
> > >
> > > +       mutex_lock(&iommu_sva_lock);
> > > +
> > >         /* Allocate mm->pasid if necessary. */
> > > -       ret = iommu_sva_alloc_pasid(mm, dev);
> > > -       if (ret)
> > > -               return ERR_PTR(ret);
> > > +       iommu_mm = iommu_alloc_mm_data(mm, dev);
> > > +       if (IS_ERR(iommu_mm)) {
> > > +               ret = PTR_ERR(iommu_mm);
> > > +               goto out_unlock;
> > > +       }
> > >
> > >         handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> > > -       if (!handle)
> > > -               return ERR_PTR(-ENOMEM);
> > > -
> > > -       mutex_lock(&iommu_sva_lock);
> > > -       /* Search for an existing domain. */
> > > -       domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
> > > -                                               IOMMU_DOMAIN_SVA);
> > > -       if (IS_ERR(domain)) {
> > > -               ret = PTR_ERR(domain);
> > > +       if (!handle) {
> > > +               ret = -ENOMEM;
> > >                 goto out_unlock;
> > >         }
> > >
> > > -       if (domain) {
> > > -               domain->users++;
> > > -               goto out;
> >
> > Our multi bind test case broke since 6.8-rc1.
> > The test case can use same domain & pasid, return different handle,
> > 6.7 simply  domain->users ++ and return.
> >
> > > +       /* Search for an existing domain. */
> > > +       list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next)
> > {
> > > +               ret = iommu_attach_device_pasid(domain, dev,
> > > + iommu_mm->pasid);
> >
> > Now iommu_attach_device_pasid return BUSY since the same pasid.
> > And then iommu_sva_bind_device attach ret=-16
> Sounds like the test case tries to bind a device to a same mm multiple times without unbinding the device and the expectation is that it can always return a valid handle to pass the test. Right?

Yes

The device can bind to the same mm multi-times and return different handle,
Since the refcount, no need to unbind and bind sequently,
The unbind can happen later with the handle.

Thanks

