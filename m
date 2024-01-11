Return-Path: <linux-kernel+bounces-23821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9E182B23B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9E21C2338C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBC74EB5C;
	Thu, 11 Jan 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JO5QJYwA"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB24F1E6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bc09434600so2504492b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704988610; x=1705593410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XzlSQgi5aMFQ6ZZbKcTjiWRQSktCc9jeFnSRbXOKzuI=;
        b=JO5QJYwAGS+ekfRmosz2EhW4wCC5gpPSHmP3EPktykd5vfHypZI+Zv03d3d6tDUrOE
         zOxvN0YSROPpY0s0fjRny0wMko+hlQqNvrxnh299Nq7ACJrI+fKuhH3UIzIibqbEA8bR
         3Ufy7/0OnCw1NSk0naA0X9H4D6DWWCgw2yfCeDU0p0JR7LsadqBYw65KE+u2SpFYGHrj
         f8MVVOQfLozHTISwdWT5nc+bPFsGeRebPOsaT+90T1FCVvTKu/RoFQK6lK4gPRyWVSSj
         IM7RM/1pRSdEHU1IMH8SY2gWRRJCNj5Wxtey/TXNvqdJthYgo1BJHwTb68x+r1oAKkwf
         p92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704988610; x=1705593410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzlSQgi5aMFQ6ZZbKcTjiWRQSktCc9jeFnSRbXOKzuI=;
        b=gptY8eAOx5TFUVzWOcH8frj6Rf5p/CCTu0hVlKflLmVdTocXGg9N58zV0RxO7Dvj8K
         +p1ZfS0JlF8Ua/SDkzY6QEyOVpQKTk+/Bcitj+DDx2wsu2ewF/p4r7J+gWzi/yHvfvQa
         aWVW2pBVfI+igqD4uPu64MfSYPSwsUyZ8Rj0P/mFqJHiwwB9Ok8Z3MisUmqKCkt8Li72
         /N+nJKLA8UEsRzlRFj/CH4ZBX8kwGxUenOQt0ojza+Z+F9brcpu7h6dhat8hxLX2yZoW
         cg09MeXeBODvDn6/tYks3hKBfGRfQY+GfE1JWfmdIwCrihFszVP82a16EQcENz8cis/Q
         M1nw==
X-Gm-Message-State: AOJu0YyPo8/ZK5EOEIEMPLOOcxkRxSITfvbliM9AFH6NtPoIuevTmk3M
	cbQFMwzqqgmVXtHG9T7j9NBX/BdvzTCB0g==
X-Google-Smtp-Source: AGHT+IHYynUbRhLmuQVEz/Gn2c2nYnwGP0p6jJC5WKr54BT87sr0IvlKfK2tBXuiCnWCfqjPiMAcuQ==
X-Received: by 2002:a05:6808:2e9a:b0:3bd:4b9f:7f5a with SMTP id gt26-20020a0568082e9a00b003bd4b9f7f5amr6897oib.23.1704988609940;
        Thu, 11 Jan 2024 07:56:49 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id b14-20020aca220e000000b003bd4453e5d5sm204005oic.22.2024.01.11.07.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 07:56:49 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rNxQG-00326u-0o;
	Thu, 11 Jan 2024 11:56:48 -0400
Date: Thu, 11 Jan 2024 11:56:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommufd/selftest: Use right iommu_ops for mock device
Message-ID: <20240111155648.GX50608@ziepe.ca>
References: <20240111073213.180020-1-baolu.lu@linux.intel.com>
 <20240111144840.GW50608@ziepe.ca>
 <016e052e-8a99-4d60-b864-87c9859953f2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016e052e-8a99-4d60-b864-87c9859953f2@arm.com>

On Thu, Jan 11, 2024 at 03:50:51PM +0000, Robin Murphy wrote:
> On 11/01/2024 2:48 pm, Jason Gunthorpe wrote:
> > On Thu, Jan 11, 2024 at 03:32:13PM +0800, Lu Baolu wrote:
> > > In the iommu probe device path, __iommu_probe_device() gets the iommu_ops
> > > for the device from dev->iommu->fwspec if this field has been initialized
> > > before probing. Otherwise, it will lookup the global iommu device list
> > > and use the iommu_ops of the first iommu device which has no
> > > dev->iommu->fwspec. This causes the wrong iommu_ops to be used for the mock
> > > device on x86 platforms where dev->iommu->fwspec is not used.
> > > 
> > > Preallocate the fwspec for the mock device so that the right iommu ops can
> > > be used.
> > 
> > I really don't like this.
> > 
> > The lifecycle model for fwspec is already a bit confusing. Introducing
> > a new case where a driver pre-allocates the fwspec is making it worse,
> > not better.
> > 
> > eg iommu_init_device() error unwind will free this allocated fwspec
> > leaving the device broken. We don't have the concept of a fwspec that
> > is owned by the device, it is really owned by the probing code.
> 
> As I've tried to explain before, this is in fact the correct use of fwspec
> as originally designed, i.e. being set up by *bus code* before device_add()
> (remember this is not the "IOMMU driver" part of selftest.c).

I understand it was the intention, but it doesn't relaly match how the
code works today..

> Indeed for perfect symmetry the bus code would free the fwspec after the
> corresponding device_del() returns, but there's no harm in that being
> factored into iommu_release_device() since the notifier call occurs
> sufficiently late in device_del() itself as to make no practical difference.

IIRC there were issues with leaking the dev_iommu :(

> I'm working to get things back to that model (wherein the dev_iommu and
> fwspec lifecycles become trivial), just with the slight tweak that these
> days it's going to make more sense to have the initialisation factored into
> device_add() itself (via iommu_probe_device()), rather than beforehand.

I would prefer to simply remove fwspec as I've already shown patches
for. You should give some comment on them.

My main complaint is there is no full vision to remove the 'global
drivers', we will always have some drivers doing FW parsing in probe
and then this different fwspec thing on the side for other drivers.

Jason

