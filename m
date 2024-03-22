Return-Path: <linux-kernel+bounces-111846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438C188719E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25A3286AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E515FB8A;
	Fri, 22 Mar 2024 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H5MovQYM"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B479604D7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127178; cv=none; b=cghUJvAXNmJD+LuQjXWbNFrMRFUXURig5FHc0t6+XA4yzF16rs5MWMKOK0aMyRMamQnTCyzEoylyKQDAc+u57FfKzIcVd8tdzot/dqzkSVAD+nwU0Z/wZrcyjUx9tC/a7evewszQ8lfFXWME1y6+B5XExwMOkLYNBJKz8Sl5Cds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127178; c=relaxed/simple;
	bh=jT967HD0NkVb4sBMYdepySf5iZRznTV4xbYQBqhu4p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5VnodEGExqfU1bASYj46V7mPtxefBGgwXknLoUiGCdHH7DC47GzH3ivjkv3Lu1108q/VTrvSpLZwhjSgZ5z8icfq08Q1pmGYQ7ZtyrV0FeTFwvQlj8j2LeTDRR41YIhYp7ljxrVJM+d2hFGW9JQUwqLQ17zmWRyz9pwO3+QKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H5MovQYM; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-789f00aba19so173948785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711127174; x=1711731974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIw9kOrgrH/Oi2+Nn2/myUDrH5PEiTKiNi9APpbGWJQ=;
        b=H5MovQYMulRQTt08//8+yKz3/26wdGnp8ybvT2INYBD1CSHdmiWOJW1eFeEOTyN3G7
         Vk7JU+wXlpFT74q+mxzNf4UDKZGMNLnBmf8B/OXz5EC7UyeYaMsiSRyy047RnYBIiRcj
         b9PUgl4VVRo3o9VJlOR1QySU3tNlwyA6lIGtpsdbSLki8LRNEr97pILWKNvn/VyyTlbw
         w0ViUZnMoS7BJ4arA/12LqINVut+D3eWcMPyV6d1/khsy2BZXZoWSb4DJggS+jMFTn1v
         W/Av1F7fO1QNI/v9iCZJ7TX6YMudPq93hGpWkVwjEiEA8eQCsRKFQWm1nUoAVGT/mH8Y
         9q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127174; x=1711731974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIw9kOrgrH/Oi2+Nn2/myUDrH5PEiTKiNi9APpbGWJQ=;
        b=AXEfi1NfvbN/A2UpNpnJwjsR7LiFXsUvaTEpEK9aVGmvUCNeLruubVI+i/1V+cnurF
         uca9S8ht+84xSJSz9bg/GEogsJkUAvkyvjNVGBir/b5/AKouaWzLO9y+bmz2yaIR0hhw
         Eow7M0QZ4SDNi8YnKjr/Ep3k+Zj+8rkeGFdyxlkEyi82xktH52slrpzvPl2pCt7c4u2G
         MfpZx3nS8CJTtKgWmhbGbNRUEkdtMusRUMiZ/ywYitF08ZGGZZITYPc0AlwEgs5/uvwL
         FQYNFmGEFJqD3soGrTza0ctAj84yy8Y3tmes6KbNdyRHQbxsJ3ZDhb6gWYoke3o2lyaj
         RxoA==
X-Forwarded-Encrypted: i=1; AJvYcCUA1m11i+8RM5nsGIQKM/EhWmfRxCOz56FK3lHiiFaFdS8M7E37hXcjG1aPelgF4O06MWHnVwRWDR2VrqHk1L5wDj9RMDjRQTu5tNpa
X-Gm-Message-State: AOJu0YxXKmzjV7ReMtN4tPnUu4VFmgmdHCMMuFXVpQ6zRHEcVZICB67D
	Cpxow6k3evJzIq/936vVTvLEQFqe2sii1dz4JAjOdzA06WNY8SOwKKMLKPVXjSc=
X-Google-Smtp-Source: AGHT+IEHFGKv/VWM3Yg4smu9N1G/2nFTpEK73dYxyEMKGfCzZHq73AEibapXcw3+Qlp7ej5p7M2doQ==
X-Received: by 2002:a05:620a:27c7:b0:789:f0ac:1b4b with SMTP id i7-20020a05620a27c700b00789f0ac1b4bmr34471qkp.58.1711127174318;
        Fri, 22 Mar 2024 10:06:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id g12-20020a37e20c000000b007882fe32acasm926378qki.3.2024.03.22.10.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:06:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rniLN-00CSJq-BV;
	Fri, 22 Mar 2024 14:06:13 -0300
Date: Fri, 22 Mar 2024 14:06:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240322170613.GI66976@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <20240308190539.GY9225@ziepe.ca>
 <7a6ac83b-3165-4abe-91be-a58f69656f8a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a6ac83b-3165-4abe-91be-a58f69656f8a@linux.intel.com>

On Fri, Mar 15, 2024 at 09:16:43AM +0800, Baolu Lu wrote:
> On 3/9/24 3:05 AM, Jason Gunthorpe wrote:
> > On Mon, Jan 22, 2024 at 03:39:00PM +0800, Lu Baolu wrote:
> > 
> > > @@ -411,6 +414,8 @@ enum iommu_hwpt_data_type {
> > >    * @__reserved: Must be 0
> > >    * @data_type: One of enum iommu_hwpt_data_type
> > >    * @data_len: Length of the type specific data
> > > + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
> > > + *            IOMMU_HWPT_FAULT_ID_VALID is set.
> > >    * @data_uptr: User pointer to the type specific data
> > >    *
> > >    * Explicitly allocate a hardware page table object. This is the same object
> > > @@ -441,6 +446,7 @@ struct iommu_hwpt_alloc {
> > >   	__u32 __reserved;
> > >   	__u32 data_type;
> > >   	__u32 data_len;
> > > +	__u32 fault_id;
> > >   	__aligned_u64 data_uptr;
> > >   };
> > 
> > ?? We can't add fault_id in the middle of the struct??
> 
> Yes. I should add the new field at the end.
> 
> By the way, with a __u32 added, this data structure is not 64-byte-
> aligned anymore. Do we need to add another unused u32 entry, or just let
> the compiler handle it?

Yes, add a reserved u32 to ensure the structs is always without
implicit padding.

> > 
> > > +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> > > +		struct iommufd_fault *fault;
> > > +
> > > +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
> > > +		if (IS_ERR(fault)) {
> > > +			rc = PTR_ERR(fault);
> > > +			goto out_hwpt;
> > > +		}
> > > +		hwpt->fault = fault;
> > > +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
> > > +		hwpt->domain->fault_data = hwpt;
> > > +		hwpt->fault_capable = true;
> > 
> > I wonder if there should be an iommu API to make a domain fault
> > capable?
> 
> The iommu core identifies a fault-capable domain by checking its
> domain->iopf_handler. Anyway, what's the difference between a fault or
> non-fault capable domain from iommu core's point of view?

From the core? Nothing. I'm just wondering from an API perspective if
we should have a little inline to indicate it.

Jason

