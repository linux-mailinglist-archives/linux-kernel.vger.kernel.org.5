Return-Path: <linux-kernel+bounces-157087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8138B0CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912951F26433
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE415ECD9;
	Wed, 24 Apr 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OFc5YRT3"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60A115E5C9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969426; cv=none; b=WgaTE8OY4prvMB+kO/11xuRx3tifoxIL+jNX1TUKhQjeexgNjGsSWfFZGSTLk/Gbs2mb0ehnZTQqEsVzxvfEdWZANgx0+Pejt7K3H9hz8dg0HCuU5C20R5EzY76jr9bvEMejnpEV14ZRS9AlT7WoCzSarZvxXAf9lokWZzKdcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969426; c=relaxed/simple;
	bh=+BYrTVqDboKGgK4KKS0DRAvfuY7c0pLEiHeUk7SiITU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dvo02HcqpGquPIDTLAxyXXew0Goag8U7cglQDUqELpG5MDIS1eLo02DEwi46IR3u88WngJkSmm9Bj1yUJ2B82bDiFL4QQXuKmZX7EGlKkVROMk49qw0P8rFTqvJUkvqGKqhHIN73BxMxv/2LFCyEvrOEyXu1F7gmYefF7t30TbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OFc5YRT3; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-22e6b61d652so2320268fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713969424; x=1714574224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T39L+QneLP5gnsdAiD9XezQQ4gD6H4BTQ8GV5y1wMWs=;
        b=OFc5YRT3tyt9cNXK2yAzRIlmxm6FdzhvhEPm4fOjfYsKYWKF+0miuMkkFiI3yfPk5s
         VN8xOXW9d/Q1yfbIKMMtDi7j9fZhn/gZ2dp+t3OJTUhnzlw+MP29lg/MTglCANHK34Hn
         3M3jj/A3Q/ojjWZuQk3e9z5VpvFnZgY+poiAzY2PXL9FoDcfijeg+WBKXYDvw2rZLsHl
         S4Vg9tieBurUNdAlwFfovZ/caO7VYx0VCbg+UjtcGhEGvlyOdNo/9GnOJCUHPaFMCRat
         Csv8bICiOdAMYCn+YHnbKw8DeSAmJCNXwCgseFYb+03gYRAScCaKv9RzAiXD+0TKq4K5
         1gyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969424; x=1714574224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T39L+QneLP5gnsdAiD9XezQQ4gD6H4BTQ8GV5y1wMWs=;
        b=EUaumis+wAX0hhTCbIlgIQgURbve57yZFAvTi0ADh//FEfq64uVxieoj86zm2/cbIX
         5vb3uwtyDIkDUp4C6sOewDOgqi8cvwSNrKPQX0s6cqSgR2uiTECrdKoEX+YCP9Ay9rke
         w98/9dpo3K47aoZmjiiTAPt13ijBnvdk6/P7GntTxiOvYvqrSeGcEHzm4jI680vC9PDi
         ATpHgeNK+z0IFqKwBZc5BQ3xrfgS48Bokg5dvgUFe3L/YzNK+8xKGZdKkQBEq/0emApR
         JRTc+tdPusn+FAf+JempICzW/Tir4QKxunkymTk8bRGRI4Brty/BQYDDzPqiUfomkRzl
         AL8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGIYpM7j5jndCWR4Xg+6qY34yeGjt5ENXzkDyX43ss7gQah6zRW8fGVQ3r4sMyHHGoXeDlFxG74wxmZBedLhC25KwHc0qgd0ULyg8s
X-Gm-Message-State: AOJu0YxUAzljIz+x1umK8Ur9CiJdmQtk63ZcGTuKr25gkskE7gmhTS3d
	Qui3PWqCwb+PdPYvT5B3m7/PnXxhsQ+tSIDJ7uh29rWdrNoy1Z/fHpzmkG+MvBl3YeIK25Thw2+
	P7aI=
X-Google-Smtp-Source: AGHT+IE1/mCX5lKDlaYeWsUxTpNAKM0lRlTcLCGZmXloq2fK5/kkJb4Y3WWADBZMtpMMR37mGoMk7w==
X-Received: by 2002:a05:6870:ef87:b0:23a:a6f:ed5a with SMTP id qr7-20020a056870ef8700b0023a0a6fed5amr2635643oab.19.1713969423775;
        Wed, 24 Apr 2024 07:37:03 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id ms26-20020a0568706b9a00b0022ea967bb9dsm2858001oab.50.2024.04.24.07.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:37:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rzdk6-008CY1-7I;
	Wed, 24 Apr 2024 11:37:02 -0300
Date: Wed, 24 Apr 2024 11:37:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	ewagner12@gmail.com, suravee.suthikulpanit@amd.com,
	vashegde@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH] iommu: Fix def_domain_type interaction with untrusted
 devices
Message-ID: <20240424143702.GH231144@ziepe.ca>
References: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>
 <20240416152943.GU223006@ziepe.ca>
 <3cf97e3c-c8d9-4282-a8ca-e4c1ea383dbd@arm.com>
 <20240424130457.GF231144@ziepe.ca>
 <77fd2bba-fc59-4997-a91a-2d9235ce5cd6@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77fd2bba-fc59-4997-a91a-2d9235ce5cd6@linux.intel.com>

On Wed, Apr 24, 2024 at 10:18:00PM +0800, Baolu Lu wrote:

> For example, the intel iommu driver allows users to opt-in graphic in
> passthrough mode, in that case def_domain_type will return
> IOMMU_DOMAIN_IDENTITY no matter the device is trusted or not.
> 
>     if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
>          return IOMMU_DOMAIN_IDENTITY;
> 
> this potentially creates same conflict as the amd driver.

These performance policy choices should be done in the core code and
they should interact correctly with other policy knobs like untrusted.

If Intel Graphics has some performance reason to prefer IDENTITY then
it should work the same no matter the IOMMU it is connected to. I
think just because the GPU is co-packaged with the IOMMU isn't a good
reason to organize the software like this.

If having a policy of a performance boost to some devices is
legitimate then I guess we'd need more levels on the command line:
 fast           all IDENTITY
 fast-secure    all DMA expect IDENTIY for special devices
 mostly-secure  all DMA but unmapping is not strict
 secure         all DMA and strict unmapping

How exactly you decide when the performance reason justfies IDENTITY,
I don't know.. Would mlx5 800G NICs that can overwhelm most IOMMUs
also go in that bucket too?

But yes, I'm quite adament that drivers should not be using
def_domain_type as some kind of performance policy thing.

Jason

