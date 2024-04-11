Return-Path: <linux-kernel+bounces-140556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DA38A1628
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B03FB29473
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71811514ED;
	Thu, 11 Apr 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M1yl0uq6"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779B145FFA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842918; cv=none; b=k5tw+CbtSihzJlz6Pna6bh++TerqtBe6yi8U9pKpnjTkDKQ0+3a6no2eWBvF5doQ6kKZkIESX6ythWyrYt/porI4LUkOCjjI+PbGLajQpEERJ16qRFL0CAR9j4JLdzghx//nPavyJcIlfhBSq8ihmv3KAMIppmYiUidVH/yviSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842918; c=relaxed/simple;
	bh=3oGpsXWmc3HGA7rtUUVqBCocMMuUmgvht732EoPs5XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpTQdExcyJtUJiWBrILNKms/sdFSbeY7dKMoOB/rCATi4UphPPeV432lp5TMhBO1q+5SukQ1UugIDNCfb+GVytQcfgP/E5pGZ6xErP5dK7edsv5+pERjfhzvKCSMJQ6n8a6y/5pMiNatTGHcSGXX6JESi5e30qhDCmmGA7skCpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M1yl0uq6; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69b514d3cf4so1697286d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712842915; x=1713447715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9v9IYMurW1GEHuOD/BlZrlZ0U0DSGWxEk7s+eTR4EGo=;
        b=M1yl0uq6xvQeiNSk/eeYGytWWdZ+UorMkIhKKM5Txo5iyPlmzqHu2QH8ai3ihIrXKk
         MXT6YTUiF6kD1GFVAN98htzhDQTrRjFUbF29EHZpajS/ItWQT+P84MkzC70GjwVX1AHU
         c9jkl87JQgajLc1nwxAIVPMb56Tw4qaVTwmoizapMTNx2nMMh6NDzmMo6j8GkB6kdD3Q
         YdKzjMQOV90NK9/udWX/f21dZhMcQBSf+RIMlMP9nGAN60fikImUj14RHIwM7SsxRDh4
         Tzn8xWrqFW6ZwL0JfFyIxmUxpAiSCONMPvOhFWTOXlJncwHETA3Jp1BVVKtpsSpWa8g3
         M4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842915; x=1713447715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v9IYMurW1GEHuOD/BlZrlZ0U0DSGWxEk7s+eTR4EGo=;
        b=bHbFsDcLuN/W866mGwre8ZDpT7ptAd595Fwju+zyAdoyM1FJOYdTBC8CorAsHe0zHZ
         i26+djhfgr6ADM/6S6/BP6JQS3SZrGnBS4vOUozRI3XabuvexE4Wm7ZwvE0N6AZSDAvG
         /8kvGtf4fRJmPc/w5/Lzacg9xAon7kP2agHPkvSrqFr3ezUh6Bo6haPVcQ4juzrWcyeG
         /lq1fLXb5kgRYfPG0j5MouPdNHi0UHKTStO6uHnTDHcoCnbgSKKjCV7sCCLqH3vP/48m
         EFSDeeuPKAko8xkGR+9tDPSDIcLK0kFVW6/vDTjJeHTFZpBJDp7DmjJyFmmUdfB5yvMQ
         gaXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFGh5Gl987uMCcvkhtOAXv++nTISX546WeYoFCxvrqfl0cWDAVgwi6wBzHQ6DCMxYsTodgDAufsGU5kyDcORmmNxPvxuR9QocP+Hjb
X-Gm-Message-State: AOJu0Yxi+yCV5ienJV1Rrs8/kxw9rjJueaG8gFBf/CavS2jskvPiiwLt
	NmOvJQwq+f0fMPJOyvy7Fp4G2qVq86JYf7WgDhzbQPQUSmLeN4PBzPBkYKQFnHw=
X-Google-Smtp-Source: AGHT+IG6lO9jxLBIJJs8K37+TPzJ2KkipZ7o4L5la7Szplwxm+9SeI0AwZXwIBZX1UouadNZz1E2sg==
X-Received: by 2002:a05:6214:5090:b0:69b:17b4:dbb with SMTP id kk16-20020a056214509000b0069b17b40dbbmr6353521qvb.13.1712842915668;
        Thu, 11 Apr 2024 06:41:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id r18-20020ad44052000000b00698e65cdfefsm944079qvp.87.2024.04.11.06.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:41:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ruugc-00AkN5-Ab;
	Thu, 11 Apr 2024 10:41:54 -0300
Date: Thu, 11 Apr 2024 10:41:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Eric Badger <ebadger@purestorage.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iommu: Add static iommu_ops->release_domain
Message-ID: <20240411134154.GK223006@ziepe.ca>
References: <20240305013305.204605-1-baolu.lu@linux.intel.com>
 <20240305013305.204605-2-baolu.lu@linux.intel.com>
 <20240410152606.GF223006@ziepe.ca>
 <0dda6ce6-1b82-4168-93b7-a0e847ce9b08@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dda6ce6-1b82-4168-93b7-a0e847ce9b08@arm.com>

On Wed, Apr 10, 2024 at 05:37:06PM +0100, Robin Murphy wrote:
> > We should probably be sensitive to the
> > dev->iommu->require_direct flag - generally drivers should prefer the
> > blocked for the release domain, but in case the FW ias asking for
> > require_direct we need to switch to identity.
> 
> At this point do we even need release_domain?

Ultimately ideally not, but I feel better going through the exercise
driver-by-driver before we just make the core code do it
automatically. Maybe I'm being overly pessimistic about the drivers..

Have all the drivers setting identity/blocked domain set release
domain before we switch to this unconditional method.

Anyhow, I just noticed it went into -rc1 already, so may as well keep
going.

> static void iommu_set_release_domain(struct device *dev)
> {
> 	const struct iommu_ops *ops = dev_iommu_ops(dev);
> 	struct iommu_domain *rd;
> 
> 	/*
> 	 * Static domains are expected not to track any device state,
> 	 * and thus be tolerant of devices disappearing once "attached"
> 	 */
> 	if (ops->blocked_domain && !(dev->iommu->require_direct ||
> other_arch_or_platform_reason))
> 		rd = ops->blocked_domain;
> 	else if (ops->identity_domain)
> 		rd = ops->identity_domain;
> 	else /* Hope release_device does the right thing! */
> 		return;
> 
> 	if (!dev->iommu->attach_deferred && rd != dev->iommu_group->domain)
> 		__iommu_attach_device(rd, dev);
> }

Yeah, this is a good end goal.

Jason

