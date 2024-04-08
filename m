Return-Path: <linux-kernel+bounces-135509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0489C6E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8978E1F240F7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD8B12AAEA;
	Mon,  8 Apr 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KDvfgvJg"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CAA128362
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585991; cv=none; b=fPA7M2j4W3BUeXyUM3C8b4FazunwsYzEz7w+RPYwvskhwd3WDxoHvAOoBMa7WFwWetKZ2tMPL4xdof1pp0D4iAARb7msGuo2VHIkCQgPHRx4XHtoGox3c/+lpXL3o+uCkIV4cuerW4quipzT7GRKUVFlLa2w2xajDw6UPrGa91o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585991; c=relaxed/simple;
	bh=aOckf8npwbeO73onf1zvZsoS3mECBJj89vWb1uXTPPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAhbfpZbRydtW8xTJVYgo1Zf7kawuoeUyYo5CP4FDv4nJU5saqvl3PiUNinWvYKfGVesyvRq4FmOFor6+CLphXl+J8cXbxHkZyvjpn/D7ADcthyXfj+L8afM3lQbyWXFYN/UruE7GtJWFadBy2o5YS8jo73v+g/Pq10slBG2vog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KDvfgvJg; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78d61a716ddso106752985a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712585988; x=1713190788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8/gkgj06mHoGEBTKOjzdrcRyFw1djs3fy2Wv1GZpCOs=;
        b=KDvfgvJgbaWHfY6VdI2+wyGvavxHUwKKqWqBD7LI/zGz8p9WFRT2qox7zkAai3lQa1
         8ZdV8Pf2w+15UFNFtmCGGaDNPBaSAJwdLTHYejIvpvcCNca5XUvVr/ojb2QnueM8PTTv
         RAVejASnjWtl7eI30QLdTtbKdMwwkB+pV6tWjRo2FE3yco1XtAp5sov8Jg2gW2TemHXi
         1jrYcn0XTXnAjwAZI+1+zuq3jdlsi7lUcusTb7lzqGlA0KfeiT/mq1mqHf4ygx1ZCQPb
         9P+5FVcdJrMrw/hfZN7wPmoXimJ8iYyREFa4FqJwXaKH4VkveWI8EeeO/vlgqqC2O7EP
         l36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585988; x=1713190788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/gkgj06mHoGEBTKOjzdrcRyFw1djs3fy2Wv1GZpCOs=;
        b=N573U5lUWfCkmZWOsgJfvtmvOogtV23tYCzfdCanlwak08rpi+NZfWd19/l0uVrD//
         /lyjgOWT0oH85GhCa67asr3A+jsBfDN9PUbW0vy+CSZIw450mJ7fUxmwb5anqxLeHRhR
         dYZtzfOhwAzDNB8h1D7RJYzyzSlqUAgMriO3J9VP7RLYKEgF5scnO4j33bnnQZntGCyp
         rC/7oYE2wbCF8YJAE4DPSY6m0cZXGJvSoOaHp948GDc2KfrhEJtP8wBFa3urjT/WsT4q
         bqpqSVLjPGXFVX/xo7I10y+fNjR5rUPPXgkUkkO3xfbCBPfPcZ8HEsxhjfMcjo3QmIhe
         pBJA==
X-Forwarded-Encrypted: i=1; AJvYcCVu1cXvZKVD60qA0Xf20M1s+3RztyBeo6CsagjXRqktrbuRkckF5YWKeEhhUXiB5QXtBLXn9bq1doppH3tlTXaK7r9XAcbpqrFZdkZ4
X-Gm-Message-State: AOJu0YxY2RrmVD5lPjlZ/NtZPI4nF9S+ZOastmLLtbZJ36yme1o99vpj
	QKUulgAdWnAerLxe9FOWQCiuJP23iZuor9hkO86Y0GPGkh1nbInJy08lsZeeeCc=
X-Google-Smtp-Source: AGHT+IE8Gxhq268X4xisT4dmVwJbupLs0jwAwPMQeWGGRMXB87HiENKFwyhJYlQDe1J23nu23fbpaw==
X-Received: by 2002:ad4:5763:0:b0:696:9df4:58e5 with SMTP id r3-20020ad45763000000b006969df458e5mr10787694qvx.1.1712585988440;
        Mon, 08 Apr 2024 07:19:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id p4-20020a0cf684000000b0069b215adb5csm410376qvn.25.2024.04.08.07.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:19:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rtpqc-005GwN-7j;
	Mon, 08 Apr 2024 11:19:46 -0300
Date: Mon, 8 Apr 2024 11:19:46 -0300
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
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Message-ID: <20240408141946.GB223006@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>

On Sat, Apr 06, 2024 at 02:09:34PM +0800, Baolu Lu wrote:
> On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
> > On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
> > > +	/* A bond already exists, just take a reference`. */
> > > +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
> > > +	if (handle) {
> > > +		mutex_unlock(&iommu_sva_lock);
> > > +		return handle;
> > >   	}
> > At least in this context this is not enough we need to ensure that the
> > domain on the PASID is actually an SVA domain and it was installed by
> > this mechanism, not an iommufd domain for instance.
> > 
> > ie you probably need a type field in the iommu_attach_handle to tell
> > what the priv is.
> > 
> > Otherwise this seems like a great idea!
> 
> Yes, you are right. For the SVA case, I will add the following changes.
> The IOMMUFD path will also need such enhancement. I will update it in
> the next version.

The only use for this is the PRI callbacks right? Maybe instead of
adding a handle type let's just check domain->iopf_handler  ?

Ie SVA will pass &ommu_sva_iopf_handler as its "type"

Jason

