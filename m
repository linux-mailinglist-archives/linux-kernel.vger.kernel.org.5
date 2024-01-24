Return-Path: <linux-kernel+bounces-37333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C871083AE77
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99552B2736C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9E97CF32;
	Wed, 24 Jan 2024 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oKZfGFug"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BABD7CF1A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113692; cv=none; b=Jxz0f5U6debC7lr1/i/j2+jYqDhzl0fhXxAwZI/XIpxDFnkZ3NKnJp7GdKOpu9FjxlRkErVLfSh9m6rp59oQLTvZv8FkYd+7L7bobyLFmaSHKj+UseBFmBmUbCbY7dXgLCpBzCwRm4THqoIIRhvvF7mH+k0+IAcMxgp2w8ZZEMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113692; c=relaxed/simple;
	bh=gLHkSQWpkbD1hmnLgTICPpcir4dWz8DwxnNhev1K+hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9ozQJYyYi+neaoLbd+9NM8Ez99miL/Yaf20kfv50gOcUlmlRjYe6HG/3lxShjnzAAzTvbInW/CeOeIQ3lXlAcRtGteY6TTtxr81AvDSHa1C/g9h6ngn9wKkLHqg64HXiussgFKCcb7jJ5fjiIE1WmzmnvvCzefihRh/XvEpSx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oKZfGFug; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bbc649c275so2173260b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706113690; x=1706718490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KB2zplKZXZmwEaf35sIS9GHJDUJDfzr6dvv7piAnaEg=;
        b=oKZfGFugwaLHtks6wFDArVuMagDO7BsB6mw4TnYUeoOTRSHRlAwEsy0/aTuD54ERfU
         DLtQ6rSbmkzj4T1VUMudKZYhPlf/v0L/9KXKpIwGLjaRMlJ8MVypgea3p6TKR8jd4/nA
         3P+Y05tK/zGbozeej/j2TJJG1Y80w9Fuv+lDvccymWb1jtkJOaEtlE+a2jGjLNYFa6DC
         T2OzpEaRhhZzk8s9tF5VcmHZe6ITQh9a9qnyldu9YAnlldtMA5OzMfvpF8E2DhjW19CU
         o7sS9PC+4sGdYDEkv4eoHWhGeyboPvnD3TehwY0/Uv4Jf7WymA7mC1le97wfXDzs01eq
         i1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706113690; x=1706718490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KB2zplKZXZmwEaf35sIS9GHJDUJDfzr6dvv7piAnaEg=;
        b=owZk+7UqON8377Hh6uFUDLvMj/HhrCTVDTY7Lk/PcB/2poXiT/DPrBkGSB8mhCOGUL
         Lvk/e2v92g9xKy2NFBehXymXqEzadh2oQQnTgjKLc+uUfgClbOxZUE+bEsqJobtQ6FTD
         rQigRrIAr9s0kMs6Nk5Fdv3/NMqbE6Bg0SYErfvc7iAxck5wlWyrmhZypi8QV3cRqNZA
         NeF8fAZSY1DbydG1rs3r/rBf/hjj9JPTCluMwzQTB/ZbB2m8kwmdwtVJYl/gT3JA1//s
         34kJyP9i9DwD/FJ710FTc6WMnH2Os7A87dTKbYPcrUgdmHFe+t9+7IkRIl+5ltiFXJTN
         j4MA==
X-Gm-Message-State: AOJu0Yyo3dnHDsFgZQ+MkPsbcMuwKpL7yZDAj6DMqQfUv+b/sBO6PZk+
	r4wo3HsIPifyxE26gU18UZOzHhF2Y5ZGRgFfMXqfT2NeVfjHPLtYqTYkM2ixZoM=
X-Google-Smtp-Source: AGHT+IEi7HTUXH3vmWl30/1TUyQz5MURf/7khn5w6ICtjrdySxkJ4o7FVdQYk67VDlULKCkNAAcMjg==
X-Received: by 2002:a05:6808:3c85:b0:3bd:36fc:1c1e with SMTP id gs5-20020a0568083c8500b003bd36fc1c1emr2302861oib.44.1706113690073;
        Wed, 24 Jan 2024 08:28:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id g50-20020a0568080df200b003bdb4a17d4bsm1614959oic.16.2024.01.24.08.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:28:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rSg6i-008pwi-AR;
	Wed, 24 Jan 2024 12:28:08 -0400
Date: Wed, 24 Jan 2024 12:28:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: "zhangzekun (A)" <zhangzekun11@huawei.com>, will@kernel.org,
	joro@8bytes.org, nicolinc@nvidia.com, mshavit@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add a threshold to avoid potential
 soft lockup
Message-ID: <20240124162808.GT50608@ziepe.ca>
References: <20240115114040.6279-1-zhangzekun11@huawei.com>
 <20240115153152.GA50608@ziepe.ca>
 <e74ea905-d107-4202-97ca-c2c509e7aa1e@huawei.com>
 <20240118142243.GI50608@ziepe.ca>
 <10c1980a-df07-4f69-93e5-c1c50b106a13@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10c1980a-df07-4f69-93e5-c1c50b106a13@arm.com>

On Wed, Jan 24, 2024 at 12:17:43PM +0000, Robin Murphy wrote:

> I don't think the story here has changed from when I first remember this
> being discussed probably 7 or 8 years ago - what VFIO has always really
> wanted for this situation is to know when it's doing a complete teardown and
> just detach and free the domain, then unpin the pages afterwards, without
> wasting any time at all on frivolous unmapping. 

What VFIO/iommufd really wants is a fast way to to read back and unmap
the PFNs from the domain. Today it has to call iommu_iova_to_phys()
and then unmap which ends up walking the radix many times.

Ideally we'd batch read and unmap in a single call with a single radix
walk.

This is because the domain is used to store the 'struct page *' which
is needed to unpin the memory.

Combined with the no-attachments optimization I described it could be
pretty close to optimal.

Jason

