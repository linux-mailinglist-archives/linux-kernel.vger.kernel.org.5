Return-Path: <linux-kernel+bounces-97378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D2E8769BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31751F250CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A82353813;
	Fri,  8 Mar 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PVh//E0x"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1FE3FBAD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918388; cv=none; b=qRf2pAxYA94BIKeniBEhfoK2TG/dRvyUIAxfo9ZQyGz3ysTa46D6LSaqhnPgAThTTiCBsr+kLS9rO0QpcwntWo0Cq7DYtoQrqF+jpesQRZ4nVwhK2gAsFrsZnT259pUE4YMg7d3Xsi8i3L4rb7PRwJeiJumRoxifaM7jkKTDqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918388; c=relaxed/simple;
	bh=JzkeDh5AwdfJCEuCQJCZYQvR6O/baYk0o5Ac9VAu/wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei/7FK6OOwfrcCvzN6ypD7B3BJZg95xKTNaDeW1u3rGgrFC3MySh9dF36e5D22WaB24bPqeochG5Y2EQZIZHyqtjmwXJvbfA1iQjbI8+kHVZV+3nCVvOVF1PKFQjTRgVriWmrywzj6By0VRyHhJ/iOHNS27o/k5ksUO/hLywbys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PVh//E0x; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a1a069bd16so576530eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 09:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709918386; x=1710523186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QyfvgQ7g3k3inQ55L9jhBCdrQml4NQHWxp+tVzvR3qY=;
        b=PVh//E0xuXkuPOSoLEsjjg07Dervkk0fc/V5iY4C1Oqa2XAe93VXbBAIu1QABHwB+V
         sWfUb96BF7dKhPfY7gmH7ojjhcO/4KztKBI7wUAG9SnnTs1cwp8RdTu5xLwlSwoJY7PI
         RdpATlC1oon6Tznniekpp4QgDpbw/FgR5htxh0Ao34cPtb5/B75HXy15dTd/mhv+g2p9
         xDqVcAaMTt3RCJhO55JbKGRafa7jETPPb6tyWp2DcjPDHkCmT+KqJbgFTE/tFYknrzxt
         QzxK6cG1ZYERqvDJdFAwPM1KdCg7AlnnzWrgj9EXOwWYMlXHNq82FcYuU6fzioLRQmC2
         Co0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709918386; x=1710523186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyfvgQ7g3k3inQ55L9jhBCdrQml4NQHWxp+tVzvR3qY=;
        b=vbChHgrqxnbbRjg8OkmYctZeuFFrxzg5FpZ1wot13D57Yb0W41Z7XNijX1UTiRB5EB
         oEC0LfuXBp88154S8QUcWzJylbrqQElnCr8XbVodHVxZK1XXXlgSrvOVgHJrZFcpIYgA
         ROA5+iox+kCDtJWsuGVWIgmvqRA/YFKps1Inwy+F+M2HDsaf1oCaTKCcgaxCY9vSGzxU
         XtGRzspV0BOncQ3O2X8boBT0Wb9jT/88j/92mm4repBMTTgKBWvGlZmKh4L8gbUJlzwt
         Dzu1dSbolR0oPiGRH7nAO+CjILtinwjbC0ldK/w60cFcP7uHQIj4efyj0Okvief90wrh
         DNjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPvkcwZKQL+gMzMdkMJcTRBrOuJrijb4Ms3XBT33bLIesIsQFP+iAwl+adVNsjTkyY3LPKaqwmoi0200d3/aQ0z+QxFjH5Hg1iQNuV
X-Gm-Message-State: AOJu0Yz92KhwsCD1WyrE87mXU2jdAJPSi+r2ZkGDvcOPOc0x1AG0aL77
	ZzsvNkWIsoIod6m/AaIjcykjsBkOwId/5PAI5VVY+FeHYdcVaRMQ5Xedd0Muxgo=
X-Google-Smtp-Source: AGHT+IHGXwED6hQvAWGBvs0kxPiSJ0tL8OBtEwFzgQm9eQ3JplhnsbF7jKSfoG/okjgvLWcpY+GZ4g==
X-Received: by 2002:a05:6820:229b:b0:5a1:c935:2eca with SMTP id ck27-20020a056820229b00b005a1c9352ecamr2575641oob.6.1709918386043;
        Fri, 08 Mar 2024 09:19:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bs18-20020a056820179200b005a12e140fa2sm490330oob.22.2024.03.08.09.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:19:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ridsm-007URd-IT;
	Fri, 08 Mar 2024 13:19:44 -0400
Date: Fri, 8 Mar 2024 13:19:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240308171944.GU9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <CABQgh9FwOVsFe3+5VG0_rDruJVW0ueHTcsnxUcVAvFqrF4Vz6Q@mail.gmail.com>
 <CABQgh9G5yFZ_p+tfvnJqOQo+Be62rMDatsEX1rhD_oTiXDaw5w@mail.gmail.com>
 <20240306160120.GN9225@ziepe.ca>
 <74d6f11a-9415-48e5-a165-7b9f5b87873d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d6f11a-9415-48e5-a165-7b9f5b87873d@linux.intel.com>

On Thu, Mar 07, 2024 at 09:54:53AM +0800, Baolu Lu wrote:
> On 2024/3/7 0:01, Jason Gunthorpe wrote:
> > On Wed, Mar 06, 2024 at 11:15:50PM +0800, Zhangfei Gao wrote:
> > > Double checked, this does not send flags, 0 is OK,
> > > Only domain_alloc_user in iommufd_hwpt_paging_alloc requires flags.
> > > 
> > > In my debug, I need this patch, otherwise NULL pointer errors happen
> > > since SVA is not set.
> > This is some driver bug, we need to get rid of these
> > iommu_dev_enable_feature() requirements.
> 
> Yes. Especially iopf should be independent of SVA.
> 
> The problem in the arm smmu v3 driver is that enabling iopf is actually
> done in the enabling SVA path, while the enabling iopf path does nothing
> except for some checks. It doesn't matter if iopf is tied with SVA, but
> when it comes to delivering iopf to user space, we need to decouple it.

Yes. Each driver is going to need to get a to a NOP for the feature
things then we can remove them.

I did half the ARM driver in my part 2, the iopf bit still needs
doing there.

Jason

