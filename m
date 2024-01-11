Return-Path: <linux-kernel+bounces-23729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F4782B0EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C620628707F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C66495CA;
	Thu, 11 Jan 2024 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YYseTwxg"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC853C097
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59883168a83so1148649eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704984523; x=1705589323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TrN/u7xLL+bkBWkVdwAioWUw4hwqypb2+jiPonctpyM=;
        b=YYseTwxgqc6bXJMJGvT0ddJIuuPEHmBkiq4DUdhFwuYIfekiw03+4WVJ9SBGOemv7s
         VvDcrGySAqccqIut/8MdBXh3u2+2p01L531adrnPagAQm34L3LShAPMbEtw24wMVzVbA
         DVrmhn0GXxhfRf+JPnny+JnW3jEQRJaDaHP6Fhe7mk9zJtZtmnpTFT7r3GVrE+eEIWOv
         glolBVZ7fOBLj1fsJSnkxNp3TI6jOf7QrZ1aqWbHTkDMuhars6NUpJu52XGgdhnXNG1J
         x54TKBl+Y+Ln/yUS82hdR7dPnA5jqePQql8XW17weM7jD29YV+vRZH7nZ71sw5NDAHIN
         pZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704984523; x=1705589323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrN/u7xLL+bkBWkVdwAioWUw4hwqypb2+jiPonctpyM=;
        b=oeLo+Gdrik7p4JzMcqTTa2jbEF2hJ2J5ZlicJMznTTNxP/V352cNXqedigmY+cqRxU
         KWmTatywZCPaQS8hnPnIykBB8eRcuEEgJRqI7h9xqGbDrAWzZZw1H4YCUalzX8X9Ryuk
         2EMWAEoUbXybXotdfbO8wQ7flh2k4NWcU3xS1uG5p4J1dl8SXCsLTZSGZRoaBkILG3Da
         s1btK1NEmiX6kCflAl2/dd3NZsDaxH8PmuH1EJ1ODlssQQZ4T5PdbzHqTlw6g1VNAz+Z
         kGlFcE6e26orckvoD2rhEnaOD0iXR8Iu8Eu6qRsGyyCShbWVaxvOEicon5Ah10GWZwuQ
         Sj+g==
X-Gm-Message-State: AOJu0YzXqW6Ot4RcX2Uzq+9n4Fae23+ntpuZo570kKG01coaBiMhFSHc
	bdlxvK5TJI20/+L5rzgNBtHc+L3yS15n8Q==
X-Google-Smtp-Source: AGHT+IFmdXOrokCK1WP95oOIGerHyQd/Znbs6+ctkcHiNb9val6YVB+UCc/1G2ZDKwu7lECzZ2wSEQ==
X-Received: by 2002:a05:6820:238e:b0:595:5276:5b1 with SMTP id co14-20020a056820238e00b00595527605b1mr1190596oob.19.1704984522914;
        Thu, 11 Jan 2024 06:48:42 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id w1-20020a4ae081000000b00594c1fa39efsm215624oos.14.2024.01.11.06.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 06:48:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rNwMK-0031Wz-UK;
	Thu, 11 Jan 2024 10:48:40 -0400
Date: Thu, 11 Jan 2024 10:48:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommufd/selftest: Use right iommu_ops for mock device
Message-ID: <20240111144840.GW50608@ziepe.ca>
References: <20240111073213.180020-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111073213.180020-1-baolu.lu@linux.intel.com>

On Thu, Jan 11, 2024 at 03:32:13PM +0800, Lu Baolu wrote:
> In the iommu probe device path, __iommu_probe_device() gets the iommu_ops
> for the device from dev->iommu->fwspec if this field has been initialized
> before probing. Otherwise, it will lookup the global iommu device list
> and use the iommu_ops of the first iommu device which has no
> dev->iommu->fwspec. This causes the wrong iommu_ops to be used for the mock
> device on x86 platforms where dev->iommu->fwspec is not used.
> 
> Preallocate the fwspec for the mock device so that the right iommu ops can
> be used.

I really don't like this.

The lifecycle model for fwspec is already a bit confusing. Introducing
a new case where a driver pre-allocates the fwspec is making it worse,
not better.

eg iommu_init_device() error unwind will free this allocated fwspec
leaving the device broken. We don't have the concept of a fwspec that
is owned by the device, it is really owned by the probing code.

The fundamental issue is we now have a special kind of driver:

	fwspec = dev_iommu_fwspec_get(dev);
	if (fwspec && fwspec->ops)
		ops = fwspec->ops;
	else
		ops = iommu_ops_from_fwnode(NULL);
                                           ^^^^^^^^

Which represents a "global" non-fwspec using driver that will only
bind to devices that didn't parse into a fwspec.

The code above supports only one of these drivers at time, but allows
more than one to be registered - it is inconsistent.

I think the right/easy answer is to iterate over all the "global"
drivers and call their probe instead of just the first one.

Especially since my approach over here migrates the whole thing to work
by iterating:

https://lore.kernel.org/all/0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com/

And this patch:

https://lore.kernel.org/all/28-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com/

Is how I made the iterating logic, it could be pulled out and tidied a
bit.

Jason

