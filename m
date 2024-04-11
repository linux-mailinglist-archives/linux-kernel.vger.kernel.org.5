Return-Path: <linux-kernel+bounces-140557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D65918A1629
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9038F282944
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E413152178;
	Thu, 11 Apr 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OmeO4EjG"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A214D6F5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842944; cv=none; b=rM/ZGAQQqeidqDvlDIAhRgQggA//7MVJtsEjlPzn4/F9G8DvSXnfdaJ9e18cTdKfPuZj7+Vv9qWob7+3+21j2T4V0ycETt1QgYWylzY2wZ8o2CDiKpVKY5u2435EMP8BoYZPUB0wV/dC1aQcmfqxZ5SvqXJHkl0rrwX5XTkbugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842944; c=relaxed/simple;
	bh=zgR0cR6ogn8YFChqfla+EM8IAhBegygR7tw+SMxmgNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFAQcZM6McWrRQQQzxM6UGbSy85HGDqOzPWHv7U1SGKWgaFI4EiqxR72hnGX3Pb2EjtfPyMwUoKKUeSC19atw+iKFdc0Ymy7zYVEfWIas3w0y0BeFHoq6FCI9Lxdz2SVJTbnlhUkn36jWFS8bVwQCLbTsz/7mEDJB3bQ9pvXNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OmeO4EjG; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4346e50ef62so7447711cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712842942; x=1713447742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFCmlim2ishqWRIA11SEYbkXYRYiuK5KGvMdScupqjg=;
        b=OmeO4EjG8jV775DPfKRthOQm27ZCAFOXCAUAe1kqYHnfhks7GWdHdXa8jcdDOKRfHd
         zgcJ6LSvoxvMryZv/8oGHi0giZO3sP8CY+meb4l/YAS3e1PTiTE3RzEjMHBqEhAyB7x4
         ykqHFEJ6ZVFwSRflHIOihDLda+dFB7NrM+EQfBjFe5rFs1nfAnozfftQD359kQkohayb
         NG6M7Sq9Rp0RlIeoNE3PdWq6zt5ypKF9htQeqHupdcuLRsen87dd3tHg8cr2nKfuBeRw
         5sb1setZvi+i4Ep/C4u4Xc1Wl4Ojd9R+HXWzA7o3iwWksvwM4hlWNBB2QLelnft7Y/Rl
         rgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842942; x=1713447742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFCmlim2ishqWRIA11SEYbkXYRYiuK5KGvMdScupqjg=;
        b=T3T5PilgqzAEaDJ8XnOvc6RzGQL9DehUqR2pNsyHWi1kyryVR5sw63IX1q5ccbq0Za
         cglcc8QSFy0A0Q4yAyAQoHftFUgRxqr/dSLVK6PIj2XzpJDiVC8ABVnoHCWajmG1JGvH
         Rcx6qiY1V2wc1eQqgPBfwsGPhlirFKBJtFlnQeLrMKQzqJGn9VE0QzUwRqZ98ggbjdra
         zZh6swIx3aTp/4u16nRdbxVnP66d0OmntrG2bAbPVONO4fuw3Bv+zMSGFwyc9DA8hFkI
         l9WSNfkIMjtGV13qFu9Z/4Ek6NVBiFtPIlSgSYRkQobDQhQvKNzTHvwroy+jCjZ5xD7s
         A4+g==
X-Forwarded-Encrypted: i=1; AJvYcCUMtrIVOAmRkdtm3vbjGD57RnQBW9a9t07ecL8p3qIaGQXvbAOzDLHp+Q2QAZlCyTgIj3nBAM4iVVqFhqNmUwGFbM1toYWExOFflkrM
X-Gm-Message-State: AOJu0Yw/SbDG9GA1an3vw2VmLwgytbPmkRWcjMyOIJWPg6CS4n0ln/Q4
	tw88jRJ4b0p9RLO3G6VOsixo5PCB6s3CcEHNxSEkfFnTtZfznRy6jj7VJ9tnIFw=
X-Google-Smtp-Source: AGHT+IGL2cbOKCZcGzgMbJlL2z68v+tK6zD101PWXggW/pcyy1RmCVHxVJqaYVopM1k3wQoJqHy5qA==
X-Received: by 2002:a05:622a:138e:b0:435:fff2:2d57 with SMTP id o14-20020a05622a138e00b00435fff22d57mr4397147qtk.22.1712842942315;
        Thu, 11 Apr 2024 06:42:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id jr13-20020a05622a800d00b00434c25cb61bsm912364qtb.73.2024.04.11.06.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:42:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ruuh3-00AkQa-C8;
	Thu, 11 Apr 2024 10:42:21 -0300
Date: Thu, 11 Apr 2024 10:42:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Zhang, Tina" <tina.zhang@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
Message-ID: <20240411134221.GL223006@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-2-baolu.lu@linux.intel.com>
 <20240410154134.GG223006@ziepe.ca>
 <BN9PR11MB5276B57D6E72870C9B1798838C062@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4e47aff7-aa65-4c60-a5dc-b7e0f2737a3e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e47aff7-aa65-4c60-a5dc-b7e0f2737a3e@linux.intel.com>

On Thu, Apr 11, 2024 at 09:17:41PM +0800, Baolu Lu wrote:
> On 2024/4/11 7:14, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Wednesday, April 10, 2024 11:42 PM
> > > 
> > > On Mon, Mar 25, 2024 at 10:16:54AM +0800, Lu Baolu wrote:
> > > > +static int __cache_tag_assign_parent_domain(struct dmar_domain
> > > *domain, u16 did,
> > > > +					    struct device *dev, ioasid_t pasid)
> > > > +{
> > > > +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> > > > +	int ret;
> > > > +
> > > > +	ret = cache_tag_assign(domain, did, dev, pasid,
> > > CACHE_TAG_TYPE_PARENT_IOTLB);
> > > > +	if (ret || !info->ats_enabled)
> > > > +		return ret;
> > > 
> > > I'm not sure I understood the point of PARENT_IOTLB? I didn't see any
> > > different implementation?
> > > 
> > > Isn't this backwards though? Each domain should have a list of things
> > > to invalidate if the domain itself changes.
> > > 
> > > So the nesting parent should have a list of CHILD_DEVTLB's that need
> > > cleaning. That list is changed when the nesting domains are attached
> > > to something.
> > > 
> > 
> > probably just a naming confusion. it's called PARENT_IOTLB from the
> > angle that this domain is used as a parent domain but actually it
> > tracks the child tags in nested attach.
> 
> Is NESTING_IOTLB more readable?

Yes

Jason

